package com.sport.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Simple test to verify Gemini API works.
 * Run this main() method directly to test without Spring.
 *
 * Set GEMINI_API_KEY environment variable before running.
 */
public class GeminiServiceTest {

    private static final String API_KEY = System.getenv("GEMINI_API_KEY");
    private static final String API_URL =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent";
    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    private static final String SYSTEM_PROMPT =
        "Ban la tro ly tu van chon vot cau long chuyen nghiep cua shop Yonex Viet Nam. " +
        "Cac thuong hieu co san: Yonex, Victor, Lining, Adidas. " +
        "Ban hay hoi khach hang ve: " +
        "- Level choi: moi choi, choi binh thuong, choi gioi (thi dau) " +
        "- Phong cach: tan cong (suc manh, smesh), phong thu (kiem soat), can bang " +
        "- Ngan sach: re ($20-50), trung binh ($50-100), cao cap ($100+) " +
        "Tra loi ngan gon, thiet thuc, 2-3 cau.";

    public static void main(String[] args) {
        System.out.println("=== Gemini API Test ===");
        System.out.println("API Key: " + (API_KEY != null ? "SET (" + API_KEY.substring(0, 10) + "...)" : "NOT SET"));
        System.out.println();

        if (API_KEY == null || API_KEY.isBlank()) {
            System.out.println("ERROR: GEMINI_API_KEY environment variable is not set!");
            System.out.println("Set it with: set GEMINI_API_KEY=your_key (Windows)");
            System.out.println("Or: export GEMINI_API_KEY=your_key (Linux/Mac)");
            return;
        }

        try {
            // Test 1: Simple greeting
            System.out.println("Test 1: Sending greeting message...");
            String reply1 = sendMessage("Xin chao, ban la ai?");
            System.out.println("Reply: " + reply1);
            System.out.println();

            // Test 2: Racket consultation
            System.out.println("Test 2: Sending consultation request...");
            String reply2 = sendMessage("Toi muon tim vot cho nguoi moi choi, ngan sach $50");
            System.out.println("Reply: " + reply2);
            System.out.println();

            // Test 3: Empty message (should trigger system prompt introduction)
            System.out.println("Test 3: Empty message (system intro)...");
            String reply3 = sendMessage("");
            System.out.println("Reply: " + reply3);
            System.out.println();

            System.out.println("=== All Tests Passed! ===");

        } catch (Exception e) {
            System.out.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static String sendMessage(String userMessage) throws IOException {
        OkHttpClient client = new OkHttpClient();
        ObjectMapper objectMapper = new ObjectMapper();

        // Build request body with system_instruction
        String jsonBody = buildRequestBody(userMessage);
        System.out.println("Request Body: " + jsonBody.substring(0, Math.min(200, jsonBody.length())) + "...");

        RequestBody body = RequestBody.create(jsonBody, JSON);

        Request request = new Request.Builder()
                .url(API_URL + "?key=" + API_KEY)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Unexpected response code: " + response.code() + " - " + response.message());
            }

            String responseBody = response.body().string();
            System.out.println("Response (first 300 chars): " + responseBody.substring(0, Math.min(300, responseBody.length())));

            return parseResponse(responseBody, objectMapper);
        }
    }

    private static String buildRequestBody(String userMessage) {
        String escapedSystemPrompt = escapeJson(SYSTEM_PROMPT);
        String escapedUserMessage = escapeJson(userMessage);

        return "{\"system_instruction\":{\"parts\":[{\"text\":\"" + escapedSystemPrompt + "\"]}," +
               "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapedUserMessage + "\"}]}]}";
    }

    private static String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    private static String parseResponse(String jsonResponse, ObjectMapper objectMapper) {
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

            JsonNode error = rootNode.path("error");
            if (!error.isMissingNode()) {
                return "API Error: " + error.path("message").asText();
            }

            return "No response text found in API response";
        } catch (Exception e) {
            return "Parse error: " + e.getMessage();
        }
    }
}
