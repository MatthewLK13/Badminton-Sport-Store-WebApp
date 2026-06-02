package com.sport.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

    
    @RequestMapping(value = "/home.htm", method = RequestMethod.GET)
    public String home(HttpSession session) {

        if (session.getAttribute("user") == null) {
            return "redirect:/login.htm";
        }

        return "home";
    }
    @RequestMapping(value = "/athlete/an-se-young.htm", method = RequestMethod.GET)
    public String showAnSeYoungProfile(ModelMap model) {
        model.addAttribute("athleteName", "AN SE YOUNG");
        return "athlete_info/an_se_young"; // Sẽ mở file /WEB-INF/views/athlete_an_se_young.jsp
    }

    // Đường dẫn cho Kento Momota
    @RequestMapping(value = "/athlete/kento-momota.htm", method = RequestMethod.GET)
    public String showKentoMomotaProfile(ModelMap model) {
        model.addAttribute("athleteName", "KENTO MOMOTA");
        return "athlete_kento_momota"; // Sẽ mở file /WEB-INF/views/athlete_kento_momota.jsp
    }

    // Đường dẫn cho cặp đôi Seo Seung-jae / Kim Won Ho
    @RequestMapping(value = "/athlete/seo-chae.htm", method = RequestMethod.GET)
    public String showSeoChaeProfile(ModelMap model) {
        model.addAttribute("athleteName", "SEO SEUNG JAE & KIM WON HO");
        return "athlete_seo_kim"; // Sẽ mở file /WEB-INF/views/athlete_seo_kim.jsp
    }
    
    @RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
    public String logout(HttpSession session) {

        if (session != null) {
            session.invalidate(); // xóa session
        }

        return "redirect:/login.htm";
    }
}