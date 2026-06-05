package com.sport.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import com.sport.dao.ProductDao;
import com.sport.entity.ProductsEntity;

@Service
public class GeminiService {

    /** Env override; otherwise default key from project config. */
    private static final String API_KEY = resolveApiKey();
    private static final String MODEL = "gemini-flash-latest";
    private static final String API_URL =
        "https://generativelanguage.googleapis.com/v1beta/models/" + MODEL + ":generateContent";

    private static String resolveApiKey() {
        String fromEnv = System.getenv("GEMINI_API_KEY");
        if (fromEnv != null && !fromEnv.isBlank()) {
            return fromEnv.trim();
        }
        return "YOUR_API_KEY_HERE";
    }

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    private final OkHttpClient client = new OkHttpClient.Builder()
        .connectTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
        .readTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
        .writeTimeout(30, java.util.concurrent.TimeUnit.SECONDS)
        .build();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private ProductDao productDao;

    // System prompt for badminton racket consultation
    private static final String SYSTEM_PROMPT =
        "Ban la tro ly tu Tu van chon vot cau long chuyen nghiep cua shop Yonex Viet Nam. " +
        "Cac thuong hieu co san: Yonex, Victor, Lining, Adidas. " +
        "Ban hay hoi khach hang ve: " +
        "- Level choi: moi choi, choi binh thuong, choi gioi (thi dau) " +
        "- Phong cach: tan cong (suc manh, smesh), phong thu (kiem soat), can bang " +
        "- Ngan sach: re ($20-50), trung binh ($50-100), cao cap ($100+) " +
        "- Trong luong vot: nhe (4U-5U) cho nguoi moi, trung binh (3U-4U) cho nguoi quen, nang (2U-3U) cho nguoi gioi " +
        "Sau khi hoi, goi y 1-3 san pham phu hop va giai thich tai sao. " +
        "Neu khong co thong tin ve ngan sach, hay hoi truoc. " +
        "Tra loi ngan gon, thiet thuc, 2-3 cau.";

    public static class ChatMessage {
        private final String role;
        private final String text;

        public ChatMessage(String role, String text) {
            this.role = role;
            this.text = text;
        }

        public String getRole() { return role; }
        public String getText() { return text; }
    }

    public static class GeminiResponse {
        private final String reply;
        private final List<ProductsEntity> products;
        private final boolean shouldRecommendProducts;

        public GeminiResponse(String reply, List<ProductsEntity> products, boolean shouldRecommendProducts) {
            this.reply = reply;
            this.products = products;
            this.shouldRecommendProducts = shouldRecommendProducts;
        }

        public String getReply() { return reply; }
        public List<ProductsEntity> getProducts() { return products; }
        public boolean shouldRecommendProducts() { return shouldRecommendProducts; }
    }

    public String getChatbotResponse(String userMessage, List<java.util.Map<String, String>> chatHistory) {
        List<ChatMessage> history = new ArrayList<>();
        if (chatHistory != null) {
            for (java.util.Map<String, String> msg : chatHistory) {
                String role = normalizeRole(msg.get("role"));
                String text = msg.get("content");
                if (role == null || text == null || text.isBlank()) {
                    continue;
                }
                history.add(new ChatMessage(role, text));
            }
        }
        GeminiResponse response = generateResponse(userMessage, history);
        return response.getReply();
    }

    public GeminiResponse generateResponse(String userMessage, List<ChatMessage> history) {
        if (API_KEY == null || API_KEY.isBlank()) {
            return new GeminiResponse(
                "Xin loi, dich vu AI chua duoc cau hinh. Vui long lien he shop de duoc ho tro.",
                null, false);
        }

        if (userMessage == null) {
            userMessage = "";
        }

        try {
            String jsonBody = buildRequestBody(userMessage, history);
            RequestBody body = RequestBody.create(jsonBody, JSON);

            Request request = new Request.Builder()
                    .url(API_URL)
                    .post(body)
                    .addHeader("Content-Type", "application/json")
                    .addHeader("x-goog-api-key", API_KEY)
                    .build();

            try (Response response = client.newCall(request).execute()) {
                String responseBody = response.body() != null ? response.body().string() : "";

                if (!response.isSuccessful()) {
                    System.out.println("GEMINI API ERROR: " + response.code() + " - " + responseBody);
                    return new GeminiResponse(
                        mapApiErrorToUserMessage(response.code(), responseBody),
                        null, false);
                }

                String reply = parseResponse(responseBody);

                // Check if we should recommend products
                boolean shouldRecommend = shouldRecommendProducts(reply);
                List<ProductsEntity> products = null;

                if (shouldRecommend) {
                    products = getProductRecommendations(userMessage);
                }

                return new GeminiResponse(reply, products, shouldRecommend);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new GeminiResponse(
                "Xin loi, da co loi xay ra: " + e.getMessage(),
                null, false);
        }
    }

    private String buildRequestBody(String userMessage, List<ChatMessage> history) throws Exception {
        com.fasterxml.jackson.databind.node.ObjectNode root = objectMapper.createObjectNode();

        com.fasterxml.jackson.databind.node.ObjectNode sysInstruct = root.putObject("system_instruction");
        sysInstruct.putArray("parts").addObject().put("text", SYSTEM_PROMPT);

        com.fasterxml.jackson.databind.node.ArrayNode contents = root.putArray("contents");

        if (history != null) {
            for (ChatMessage msg : history) {
                String role = normalizeRole(msg.getRole());
                String text = msg.getText();
                if (role == null || text == null || text.isBlank()) {
                    continue;
                }
                com.fasterxml.jackson.databind.node.ObjectNode content = contents.addObject();
                content.put("role", role);
                content.putArray("parts").addObject().put("text", text);
            }
        }

        com.fasterxml.jackson.databind.node.ObjectNode userContent = contents.addObject();
        userContent.put("role", "user");
        userContent.putArray("parts").addObject().put("text", userMessage);

        return objectMapper.writeValueAsString(root);
    }

    private static String normalizeRole(String role) {
        if (role == null || role.isBlank()) {
            return null;
        }
        switch (role.trim().toLowerCase()) {
            case "user":
                return "user";
            case "model":
            case "bot":
            case "assistant":
                return "model";
            default:
                return null;
        }
    }

    private String mapApiErrorToUserMessage(int httpCode, String errorBody) {
        try {
            JsonNode error = objectMapper.readTree(errorBody).path("error");
            String apiMessage = error.path("message").asText("");
            if (httpCode == 429 || apiMessage.toLowerCase().contains("quota")) {
                return "Xin loi, he thong AI dang qua tai. Vui long thu lai sau vai phut.";
            }
            if (!apiMessage.isBlank()) {
                return "Xin loi, da co loi tu API: " + apiMessage;
            }
        } catch (Exception ignored) {
            // fall through
        }
        return "Xin loi, da co loi xay ra. Vui long thu lai sau.";
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    private String parseResponse(String jsonResponse) {
        try {
            JsonNode rootNode = objectMapper.readTree(jsonResponse);
            JsonNode candidates = rootNode.path("candidates");

            if (candidates.isArray() && candidates.size() > 0) {
                JsonNode content = candidates.get(0).path("content");
                JsonNode parts = content.path("parts");

                if (parts.isArray() && parts.size() > 0) {
                    return parts.get(0).path("text").asText();
                }
            }

            // Check for error
            JsonNode error = rootNode.path("error");
            if (!error.isMissingNode()) {
                return "Xin loi, da co loi tu API: " + error.path("message").asText();
            }

            return "Xin loi, khong nhan duoc phan hoi tu AI.";
        } catch (Exception e) {
            e.printStackTrace();
            return "Xin loi, loi khi xu ly phan hoi tu AI.";
        }
    }

    private boolean shouldRecommendProducts(String reply) {
        String lowerReply = reply.toLowerCase();
        return lowerReply.contains("goi y") ||
               lowerReply.contains("recommend") ||
               lowerReply.contains("san pham") ||
               lowerReply.contains("vot") ||
               lowerReply.contains("phu hop") ||
               lowerReply.contains("mua");
    }

    private List<ProductsEntity> getProductRecommendations(String userMessage) {
        try {
            // Get newest products as fallback recommendations
            return productDao.getNewArrivals(4);
        } catch (Exception e) {
            return null;
        }
    }
}
