package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ThemeController {

    @RequestMapping(value = "/theme.htm", method = RequestMethod.GET)
    public String toggleTheme(HttpSession session, HttpServletRequest request) {
        String current = (String) session.getAttribute("theme");
        session.setAttribute("theme", "dark".equals(current) ? "light" : "dark");
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/home.htm");
    }
}
