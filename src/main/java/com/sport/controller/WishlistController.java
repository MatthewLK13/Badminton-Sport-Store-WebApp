package com.sport.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.CartDao;
import com.sport.dao.ProductDao;
import com.sport.dao.WishlistDao;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.ProductsEntity;
import com.sport.entity.User;
import com.sport.entity.WishlistEntity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {

    @Autowired
    private WishlistDao wishlistDao;

    @Autowired
    private ProductDao productDao;

    @Autowired
    private CartDao cartDao;

    @RequestMapping(value = "/toggle", method = RequestMethod.POST)
    public String toggle(
            @RequestParam("productId") int productId,
            HttpSession session,
            javax.servlet.http.HttpServletRequest request) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        int userId = user.getId();
        boolean exists = wishlistDao.exists(userId, productId);

        if (exists) {
            wishlistDao.remove(userId, productId);
        } else {
            wishlistDao.add(userId, productId);
        }

        session.setAttribute("wishlistCount", wishlistDao.countByUserId(userId));

        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/home.htm");
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> count(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            result.put("count", 0);
        } else {
            result.put("count", wishlistDao.countByUserId(user.getId()));
        }
        return result;
    }

    @RequestMapping(value = "/items", method = RequestMethod.GET)
    @ResponseBody
    public List<Map<String, Object>> getItems(HttpSession session) {
        List<Map<String, Object>> result = new ArrayList<>();
        User user = (User) session.getAttribute("user");
        if (user == null) return result;

        List<WishlistEntity> wishlist = wishlistDao.getByUserId(user.getId());
        for (WishlistEntity w : wishlist) {
            ProductsEntity product = productDao.getProductById(w.getProductId());
            if (product != null) {
                ProductVariantsEntity variant = productDao.getDefaultVariantByProductId(product.getId());
                Map<String, Object> item = new HashMap<>();
                item.put("id", product.getId());
                item.put("variantId", variant != null ? variant.getId() : null);
                item.put("variantName", variant != null ? variant.getVariant_name() : "");
                item.put("productName", product.getProductName());
                item.put("price", product.getPrice());
                item.put("avatarName", product.getAvatarName());
                result.add(item);
            }
        }
        return result;
    }

    @RequestMapping(value = "/addToCart", method = RequestMethod.POST)
    public String addToCart(
            @RequestParam("variantId") int variantId,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user != null) {
            cartDao.add(user.getId(), variantId, quantity);
        }
        return "redirect:/wishlist.htm";
    }
}
