package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.ModelMap;

import com.sport.dao.CartDao;
import com.sport.dao.ProductDao;
import com.sport.dao.WishlistDao;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.ProductsEntity;
import com.sport.entity.User;
import com.sport.entity.WishlistEntity;

import java.util.*;

@Controller
@RequestMapping("/wishlist.htm")
public class WishlistController {

    @Autowired
    private WishlistDao wishlistDao;

    @Autowired
    private ProductDao productDao;

    @Autowired
    private CartDao cartDao;

    @RequestMapping(value = "/toggle.htm", method = RequestMethod.POST)
    public String toggle(
            @RequestParam("productId") int productId,
            HttpSession session,
            HttpServletRequest request) {

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

    @RequestMapping(method = RequestMethod.GET)
    public String viewWishlist(HttpSession session, ModelMap model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        List<Map<String, Object>> items = new ArrayList<>();
        List<WishlistEntity> wishlist = wishlistDao.getByUserId(user.getId());

        for (WishlistEntity w : wishlist) {
            ProductsEntity product = productDao.getProductById(w.getProductId());
            if (product != null) {
                ProductVariantsEntity variant = productDao.getDefaultVariantByProductId(product.getId());
                Map<String, Object> itemMap = new HashMap<>();
                itemMap.put("id", product.getId());
                itemMap.put("variantId", variant != null ? variant.getId() : null);
                itemMap.put("variantName", variant != null ? variant.getVariant_name() : "");
                itemMap.put("productName", product.getProductName());
                itemMap.put("price", product.getPrice());
                itemMap.put("avatarName", product.getAvatarName());
                items.add(itemMap);
            }
        }

        model.addAttribute("wishlistItems", items);
        return "wishlist";
    }

    @RequestMapping(value = "/addToCart.htm", method = RequestMethod.POST)
    public String addToCart(
            @RequestParam("variantId") int variantId,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        cartDao.add(user.getId(), variantId, quantity);
        session.setAttribute("cartCount", cartDao.countByUserId(user.getId()));

        return "redirect:/cart.htm";
    }
}
