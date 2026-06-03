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

@Controller
public class HomeController {

    @Autowired
    private ProductDao productDao;

    @RequestMapping(value = "/home.htm", method = RequestMethod.GET)
    public String home(ModelMap model) {
        List<ProductsEntity> products = productDao.getNewArrivals(6);
        model.addAttribute("products", products);
        return "home";
    }

    @RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login.htm";
    }
}