package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.CartDao;
import com.sport.dao.ProductDao;
import com.sport.entity.CartEntity;
import com.sport.entity.ProductsEntity;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.User;

import java.util.*;

@Controller
@RequestMapping("/cart.htm")
public class CartController {

    @Autowired
    private CartDao cartDao;

    @Autowired
    private ProductDao productDao;

    @RequestMapping(value = "/add.htm", method = RequestMethod.POST)
    public String add(
            @RequestParam("variantId") int variantId,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            HttpSession session,
            HttpServletRequest request) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        cartDao.add(user.getId(), variantId, quantity);
        session.setAttribute("cartCount", cartDao.countByUserId(user.getId()));

        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/home.htm");
    }

    @RequestMapping(method = RequestMethod.GET)
    public String viewCart(HttpSession session, org.springframework.ui.ModelMap model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        List<CartEntity> cartItems = cartDao.getByUserId(user.getId());
        List<Map<String, Object>> itemsWithDetails = new ArrayList<>();
        double total = 0;

        for (CartEntity item : cartItems) {
            ProductVariantsEntity variant = productDao.getVariantById(item.getProductVariantId());
            if (variant == null) continue;
            ProductsEntity product = variant.getProduct();
            if (product == null) continue;

            Map<String, Object> itemMap = new HashMap<>();
            itemMap.put("cartId", item.getId());
            itemMap.put("variantId", item.getProductVariantId());
            itemMap.put("variantName", variant.getVariant_name());
            itemMap.put("productName", product.getProductName());
            itemMap.put("price", product.getPrice());
            itemMap.put("quantity", item.getQuantity());
            itemMap.put("avatarName", product.getAvatarName());
            itemsWithDetails.add(itemMap);

            total += product.getPrice() * item.getQuantity();
        }

        model.addAttribute("cartItems", itemsWithDetails);
        model.addAttribute("cartTotal", total);
        return "cart";
    }

    @RequestMapping(value = "/update.htm", method = RequestMethod.POST)
    public String update(
            @RequestParam("cartId") int cartId,
            @RequestParam("quantity") int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        if (quantity <= 0) {
            cartDao.remove(cartId);
        } else {
            cartDao.updateQuantity(cartId, quantity);
        }
        session.setAttribute("cartCount", cartDao.countByUserId(user.getId()));

        return "redirect:/cart.htm";
    }

    @RequestMapping(value = "/remove.htm", method = RequestMethod.POST)
    public String remove(
            @RequestParam("cartId") int cartId,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        cartDao.remove(cartId);
        session.setAttribute("cartCount", cartDao.countByUserId(user.getId()));

        return "redirect:/cart.htm";
    }
}
