package com.sport.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.service.GeminiService;

@Controller
public class ChatbotPageController {

    @Autowired
    private GeminiService geminiService;

    @RequestMapping(value = "/chatbot.htm", method = RequestMethod.GET)
    public String showChatbot(HttpSession session, Model model) {
        model.addAttribute("chatHistory", session.getAttribute("chatHistory"));
        return "chatbot";
    }

    @RequestMapping(value = "/chatbot.htm", method = RequestMethod.POST)
    public String sendMessage(
            @RequestParam("message") String message,
            HttpSession session,
            Model model) {

        // Get chat history from session
        java.util.List<java.util.Map<String, String>> chatHistory =
            (java.util.List<java.util.Map<String, String>>) session.getAttribute("chatHistory");

        if (chatHistory == null) {
            chatHistory = new java.util.ArrayList<>();
        }

        // Add user message
        java.util.Map<String, String> userMsg = new java.util.HashMap<>();
        userMsg.put("role", "user");
        userMsg.put("content", message);
        chatHistory.add(userMsg);

        // Get bot response
        String botReply = geminiService.getChatbotResponse(message, chatHistory);

        // Add bot message
        java.util.Map<String, String> botMsg = new java.util.HashMap<>();
        botMsg.put("role", "bot");
        botMsg.put("content", botReply);
        chatHistory.add(botMsg);

        // Keep only last 10 messages
        if (chatHistory.size() > 10) {
            chatHistory = chatHistory.subList(chatHistory.size() - 10, chatHistory.size());
        }

        session.setAttribute("chatHistory", chatHistory);
        model.addAttribute("chatHistory", chatHistory);
        model.addAttribute("reply", botReply);

        return "chatbot";
    }

    @RequestMapping(value = "/chatbot/reset.htm", method = RequestMethod.GET)
    public String resetChat(HttpSession session) {
        session.removeAttribute("chatHistory");
        return "redirect:/chatbot.htm";
    }
}
