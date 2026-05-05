package com.sport.controller;

import com.sport.model.User;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ForgotController {

    @Autowired
    ServletContext context;

    
    @RequestMapping(value = "/forgot.htm", method = RequestMethod.GET)
    public String showForm() {
        return "forgot";
    }

    
    @SuppressWarnings("unchecked")
	@RequestMapping(value = "/forgot.htm", method = RequestMethod.POST)
    public String forgot(@RequestParam("identifier") String identifier, Model model) {

        if (identifier == null || identifier.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập Email hoặc SĐT!");
            return "forgot";
        }

        identifier = identifier.trim();

        List<User> users = (List<User>) context.getAttribute("users");

        if (users != null) {
            for (User u : users) {
                if (identifier.equalsIgnoreCase(u.getEmail()) 
                    || identifier.equals(u.getPhone())) {

                    model.addAttribute("password", u.getPassword()); // demo
                    model.addAttribute("success", "Tìm thấy tài khoản!");
                    return "forgot";
                }
            }
        }

        model.addAttribute("error", "Không tìm thấy tài khoản!");
        return "forgot";
    }
    }
