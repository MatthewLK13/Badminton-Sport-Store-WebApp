package com.sport.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.sport.dao.ViewedProductDao;
import com.sport.dao.ProductDao;
import com.sport.entity.User;
import com.sport.entity.ProductsEntity;
import com.sport.entity.ViewedProductEntity;

@Controller
public class ViewedProductController {

    @Autowired
    private ViewedProductDao viewedProductDao;

    @Autowired
    private ProductDao productDao;

    @RequestMapping(value = "/viewed.htm", method = RequestMethod.GET)
    public String showViewedProducts(ModelMap model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        List<ViewedProductEntity> viewedEntities = viewedProductDao.getViewedProductsByUserId(user.getId());
        List<ProductsEntity> viewedProducts = new ArrayList<>();

        for (ViewedProductEntity entity : viewedEntities) {
            ProductsEntity product = productDao.getProductById(entity.getProductId());
            if (product != null) {
                viewedProducts.add(product);
            }
        }

        model.addAttribute("viewedProducts", viewedProducts);
        return "viewed";
    }
}
