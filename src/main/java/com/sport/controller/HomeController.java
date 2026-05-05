package com.sport.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

    
    @RequestMapping(value = "/home.htm", method = RequestMethod.GET)
    public String home(HttpSession session) {

        if (session.getAttribute("user") == null) {
            return "redirect:/login.htm";
        }

        return "index";
    }

    
    @RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
    public String logout(HttpSession session) {

        if (session != null) {
            session.invalidate(); // xóa session
        }

        return "redirect:/login.htm";
    }
}