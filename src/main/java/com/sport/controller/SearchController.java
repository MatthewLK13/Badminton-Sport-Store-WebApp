package com.sport.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.ProductDao;
import com.sport.entity.ProductsEntity;

import java.util.List;

@Controller
public class SearchController {

    @Autowired
    private ProductDao productDao;

    @RequestMapping(value = "/search.htm", method = RequestMethod.GET)
    public String search(
            @RequestParam("q") String query,
            ModelMap model) {

        model.addAttribute("query", query);

        List<ProductsEntity> results = productDao.searchProducts(query);
        model.addAttribute("searchResults", results);

        return "search";
    }
}
