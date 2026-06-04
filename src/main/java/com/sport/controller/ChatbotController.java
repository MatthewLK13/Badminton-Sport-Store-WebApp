package com.sport.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.sport.service.GeminiService;
import com.sport.entity.ProductsEntity;

import java.util.*;

@Controller
@RequestMapping("/api")
public class ChatbotController {

    public static final String CHAT_HISTORY = "chatbot_history";
    public static final int MAX_HISTORY = 10; // Keep last 10 messages for context

    @Autowired
    private GeminiService geminiService;

    @RequestMapping(value = "/chatbot.htm", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> chat(@RequestParam("message") String message,
                                   HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        // Get conversation history from session
        @SuppressWarnings("unchecked")
        List<GeminiService.ChatMessage> history =
            (List<GeminiService.ChatMessage>) session.getAttribute(CHAT_HISTORY);

        if (history == null) {
            history = new ArrayList<>();
        }

        // Call Gemini API
        GeminiService.GeminiResponse geminiResponse = geminiService.generateResponse(message, history);

        String reply = geminiResponse.getReply();

        // Add user and model message to history
        history.add(new GeminiService.ChatMessage("user", message));
        history.add(new GeminiService.ChatMessage("model", reply));

        // Trim history if too long
        while (history.size() > MAX_HISTORY) {
            history.remove(0);
        }

        // Save updated history
        session.setAttribute(CHAT_HISTORY, history);

        // Build response
        response.put("reply", reply);

        // Include products if recommendations were made
        List<ProductsEntity> products = geminiResponse.getProducts();
        if (products != null && !products.isEmpty()) {
            List<Map<String, Object>> productList = new ArrayList<>();
            for (ProductsEntity p : products) {
                Map<String, Object> pmap = new HashMap<>();
                pmap.put("id", p.getId());
                pmap.put("name", p.getProductName());
                pmap.put("price", p.getPrice());
                pmap.put("image", p.getAvatarName());
                productList.add(pmap);
            }
            response.put("products", productList);
        }

        return response;
    }

    // Endpoint to reset conversation
    @RequestMapping(value = "/chatbot/reset.htm", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> resetChat(HttpSession session) {
        session.removeAttribute(CHAT_HISTORY);

        Map<String, Object> response = new HashMap<>();
        response.put("reply", "Da reset cuoc tro chuyen. Ban co the bat dau lai!");
        return response;
    }
}
