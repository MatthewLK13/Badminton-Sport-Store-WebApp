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
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {

        int pageSize = 20;
        model.addAttribute("query", query);

        List<ProductsEntity> results = productDao.searchProducts(query, page, pageSize);
        long totalProducts = productDao.countSearchProducts(query);

        model.addAttribute("searchResults", results);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", (int) Math.ceil((double) totalProducts / pageSize));

        return "search";
    }
}
