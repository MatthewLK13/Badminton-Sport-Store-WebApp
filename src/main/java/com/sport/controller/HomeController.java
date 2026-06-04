package com.sport.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sport.dao.ProductDao;
import com.sport.entity.ProductsEntity;
import com.sport.entity.User;

@Controller
public class HomeController {

    @Autowired
    private ProductDao productDao;

    @RequestMapping(value = "/home.htm", method = RequestMethod.GET)
    public String home(ModelMap model, HttpSession session) {
        List<ProductsEntity> products = productDao.getNewArrivals(6);
        model.addAttribute("products", products);

        // Add personalized recommendations if user is logged in
        User user = (User) session.getAttribute("user");
        if (user != null) {
            List<ProductsEntity> recommended = productDao.getRecommendedProducts(user.getId(), 8);
            model.addAttribute("recommendedProducts", recommended);
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
        return "athlete_info/kento_momota";
    }

    // Đường dẫn cho cặp đôi Seo Seung-jae / Kim Won Ho
    @RequestMapping(value = "/athlete/seo-chae.htm", method = RequestMethod.GET)
    public String showSeoChaeProfile(ModelMap model) {
        model.addAttribute("athleteName", "SEO SEUNG JAE & KIM WON HO");
        return "athlete_info/kim_seo";
    }

    @RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login.htm";
    }
}
