package com.sport.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.UserDAO;
import com.sport.entity.User;

@Controller
public class LoginController {

    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/login.htm", method = RequestMethod.GET)
    public String showLogin() {
        return "login";
    }

    @RequestMapping(value = "/login.htm", method = RequestMethod.POST)
    public String login(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        username = username.trim();
        password = password.trim();

        User user = userDAO.findByEmailOrPhone(username);

        if (user != null) {
            if (user.getPasswordHash().equals(password)) {
                session.setAttribute("user", user);
                return "redirect:/home.htm"; 
            }
        }

        model.addAttribute("error", "Sai tài khoản hoặc mật khẩu!");
        return "login";
    }
}