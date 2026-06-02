package com.sport.controller;

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
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartDao cartDao;

    @Autowired
    private ProductDao productDao;

    // Thêm vào giỏ
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public String add(
            @RequestParam("variantId") int variantId,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "{\"status\":\"login_required\",\"count\":0}";

        cartDao.add(user.getId(), variantId, quantity);
        long count = cartDao.countByUserId(user.getId());
        return "{\"status\":\"added\",\"count\":" + count + "}";
    }

    // Đếm số lượng
    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ResponseBody
    public String count(HttpSession session) {
        User user = (User) session.getAttribute("user");
        long count = (user != null) ? cartDao.countByUserId(user.getId()) : 0;
        return "{\"count\":" + count + "}";
    }

    // Lấy danh sách items
    @RequestMapping(value = "/items", method = RequestMethod.GET)
    @ResponseBody
    public String getItems(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "[]";

        List<CartEntity> cartItems = cartDao.getByUserId(user.getId());
        StringBuilder sb = new StringBuilder("[");
        boolean first = true;

        for (CartEntity item : cartItems) {
            // Lấy thông tin variant và product
            ProductVariantsEntity variant = productDao.getVariantById(item.getProductVariantId());
            if (variant == null) continue;

            ProductsEntity product = variant.getProduct();
            if (product == null) continue;

            if (!first) sb.append(",");
            first = false;

            sb.append("{");
            sb.append("\"cartId\":").append(item.getId()).append(",");
            sb.append("\"variantId\":").append(item.getProductVariantId()).append(",");
            sb.append("\"variantName\":\"").append(variant.getVariant_name().replace("\"","\\\"")).append("\",");
            sb.append("\"productName\":\"").append(product.getProductName().replace("\"","\\\"")).append("\",");
            sb.append("\"price\":").append(product.getPrice()).append(",");
            sb.append("\"quantity\":").append(item.getQuantity()).append(",");
            sb.append("\"avatarName\":\"").append(product.getAvatarName()).append("\"");
            sb.append("}");
        }
        sb.append("]");
        return sb.toString();
    }

    // Cập nhật số lượng
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(
            @RequestParam("cartId") int cartId,
            @RequestParam("quantity") int quantity,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "{\"status\":\"error\"}";

        if (quantity <= 0) {
            cartDao.remove(cartId);
        } else {
            cartDao.updateQuantity(cartId, quantity);
        }
        long count = cartDao.countByUserId(user.getId());
        return "{\"status\":\"updated\",\"count\":" + count + "}";
    }

    // Xóa item
    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public String remove(
            @RequestParam("cartId") int cartId,
            HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "{\"status\":\"error\",\"count\":0}";

        cartDao.remove(cartId);
        long count = cartDao.countByUserId(user.getId());
        return "{\"status\":\"removed\",\"count\":" + count + "}";
    }
}