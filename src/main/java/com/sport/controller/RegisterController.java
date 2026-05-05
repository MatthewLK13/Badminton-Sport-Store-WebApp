package com.sport.controller;

import com.sport.model.User;
import java.util.*;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegisterController {

    @Autowired
    ServletContext context;

    
    @RequestMapping(value = "/register.htm", method = RequestMethod.GET)
    public String showRegister() {
        return "register";
    }

    
    @RequestMapping(value = "/register.htm", method = RequestMethod.POST)
    public String register(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("password") String pass,
            @RequestParam("repassword") String repass,
            Model model) {

        
        name = name.trim();
        email = email.trim();
        phone = phone.trim();
        pass = pass.trim();
        repass = repass.trim();

        
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        String phoneRegex = "^[0-9]{10}$";
        String passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$";

       
        if (!email.matches(emailRegex)) {
            model.addAttribute("error", "Email không hợp lệ!");
            return "register";
        }

        
        if (!phone.matches(phoneRegex)) {
            model.addAttribute("error", "SĐT phải gồm đúng 10 số!");
            return "register";
        }

        
        if (!pass.matches(passRegex)) {
            model.addAttribute("error", "Mật khẩu >=6 ký tự, gồm chữ và số!");
            return "register";
        }

        
        if (!pass.equals(repass)) {
            model.addAttribute("error", "Mật khẩu không khớp!");
            return "register";
        }

        @SuppressWarnings("unchecked")
        List<User> users = (List<User>) context.getAttribute("users");

        if (users == null) {
            users = new ArrayList<>();
            context.setAttribute("users", users);
        }

        
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(email)) {
                model.addAttribute("error", "Email đã tồn tại!");
                return "register";
            }
            if (u.getPhone().equals(phone)) {
                model.addAttribute("error", "SĐT đã tồn tại!");
                return "register";
            }
        }

        
        users.add(new User(name, email, phone, pass));

        model.addAttribute("success", "Đăng ký thành công!");
        return "login";
    }
}