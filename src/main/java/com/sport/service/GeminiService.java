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

    private static final String SYSTEM_PROMPT_VI =
        "Ban la tro ly tu van chon vot cau long chuyen nghiep cua shop Yonex Viet Nam. " +
        "Cac thuong hieu co san: Yonex, Victor, Lining, Adidas. " +
        "Ban hay hoi khach hang ve: " +
        "- Level choi: moi choi, choi binh thuong, choi gioi (thi dau) " +
        "- Phong cach: tan cong (suc manh, smesh), phong thu (kiem soat), can bang " +
        "- Ngan sach: re ($20-50), trung binh ($50-100), cao cap ($100+) " +
        "- Trong luong vot: nhe (4U-5U) cho nguoi moi, trung binh (3U-4U) cho nguoi quen, nang (2U-3U) cho nguoi gioi " +
        "Sau khi hoi, goi y 1-3 san pham phu hop va giai thich tai sao. " +
        "Neu khong co thong tin ve ngan sach, hay hoi truoc. " +
        "Tra loi ngan gon, thiet thuc, 2-3 cau. " +
        "QUAN TRONG: Chi tra loi bang tieng Viet.";

    private static final String SYSTEM_PROMPT_EN =
        "You are a professional badminton racket advisor for Yonex Vietnam shop. " +
        "Available brands: Yonex, Victor, Lining, Adidas. " +
        "Ask the customer about: " +
        "- Skill level: beginner, intermediate, advanced (competitive) " +
        "- Playing style: offensive (power, smash), defensive (control), balanced " +
        "- Budget: low ($20-50), mid ($50-100), premium ($100+) " +
        "- Racket weight: light (4U-5U) for beginners, medium (3U-4U) for regular players, heavy (2U-3U) for advanced " +
        "After asking, suggest 1-3 suitable products and explain why. " +
        "If budget is unknown, ask first. " +
        "Keep answers short and practical, 2-3 sentences. " +
        "IMPORTANT: Reply in English only.";

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
        return getChatbotResponse(userMessage, chatHistory, "vi");
    }

    public String getChatbotResponse(String userMessage, List<java.util.Map<String, String>> chatHistory, String language) {
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
        GeminiResponse response = generateResponse(userMessage, history, language);
        return response.getReply();
    }

    public GeminiResponse generateResponse(String userMessage, List<ChatMessage> history) {
        return generateResponse(userMessage, history, "vi");
    }

    public GeminiResponse generateResponse(String userMessage, List<ChatMessage> history, String language) {
        String lang = normalizeLanguage(language);

        if (API_KEY == null || API_KEY.isBlank()) {
            return new GeminiResponse(
                isEnglish(lang)
                    ? "Sorry, AI service is not configured. Please contact the shop for support."
                    : "Xin loi, dich vu AI chua duoc cau hinh. Vui long lien he shop de duoc ho tro.",
                null, false);
        }

        if (userMessage == null) {
            userMessage = "";
        }

        try {
            String jsonBody = buildRequestBody(userMessage, history, lang);
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
                        mapApiErrorToUserMessage(response.code(), responseBody, lang),
                        null, false);
                }

                String reply = parseResponse(responseBody, lang);

                // Check if we should recommend products
                boolean shouldRecommend = shouldRecommendProducts(reply, lang);
                List<ProductsEntity> products = null;

                if (shouldRecommend) {
                    products = getProductRecommendations(userMessage);
                }

                return new GeminiResponse(reply, products, shouldRecommend);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new GeminiResponse(
                isEnglish(lang)
                    ? "Sorry, an error occurred: " + e.getMessage()
                    : "Xin loi, da co loi xay ra: " + e.getMessage(),
                null, false);
        }
    }

    private static String normalizeLanguage(String language) {
        if (language != null && language.toLowerCase().startsWith("en")) {
            return "en";
        }
        return "vi";
    }

    private static boolean isEnglish(String lang) {
        return "en".equals(lang);
    }

    private static String buildSystemPrompt(String lang) {
        return isEnglish(lang) ? SYSTEM_PROMPT_EN : SYSTEM_PROMPT_VI;
    }

    private String buildRequestBody(String userMessage, List<ChatMessage> history, String lang) throws Exception {
        com.fasterxml.jackson.databind.node.ObjectNode root = objectMapper.createObjectNode();

        com.fasterxml.jackson.databind.node.ObjectNode sysInstruct = root.putObject("system_instruction");
        sysInstruct.putArray("parts").addObject().put("text", buildSystemPrompt(lang));

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

    private String mapApiErrorToUserMessage(int httpCode, String errorBody, String lang) {
        try {
            JsonNode error = objectMapper.readTree(errorBody).path("error");
            String apiMessage = error.path("message").asText("");
            if (httpCode == 429 || apiMessage.toLowerCase().contains("quota")) {
                return isEnglish(lang)
                    ? "Sorry, the AI service is busy. Please try again in a few minutes."
                    : "Xin loi, he thong AI dang qua tai. Vui long thu lai sau vai phut.";
            }
            if (!apiMessage.isBlank()) {
                return isEnglish(lang)
                    ? "Sorry, API error: " + apiMessage
                    : "Xin loi, da co loi tu API: " + apiMessage;
            }
        } catch (Exception ignored) {
            // fall through
        }
        return isEnglish(lang)
            ? "Sorry, something went wrong. Please try again later."
            : "Xin loi, da co loi xay ra. Vui long thu lai sau.";
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    private String parseResponse(String jsonResponse, String lang) {
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
                return isEnglish(lang)
                    ? "Sorry, API error: " + error.path("message").asText()
                    : "Xin loi, da co loi tu API: " + error.path("message").asText();
            }

            return isEnglish(lang)
                ? "Sorry, no response received from AI."
                : "Xin loi, khong nhan duoc phan hoi tu AI.";
        } catch (Exception e) {
            e.printStackTrace();
            return isEnglish(lang)
                ? "Sorry, failed to process the AI response."
                : "Xin loi, loi khi xu ly phan hoi tu AI.";
        }
    }

    private boolean shouldRecommendProducts(String reply, String lang) {
        String lowerReply = reply.toLowerCase();
        if (isEnglish(lang)) {
            return lowerReply.contains("recommend") ||
                   lowerReply.contains("suggest") ||
                   lowerReply.contains("product") ||
                   lowerReply.contains("racket") ||
                   lowerReply.contains("suitable") ||
                   lowerReply.contains("buy");
        }
        return lowerReply.contains("goi y") ||
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
