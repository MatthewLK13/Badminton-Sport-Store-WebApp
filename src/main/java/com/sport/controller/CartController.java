package com.sport.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.CartDao;
import com.sport.dao.ProductDao;
import com.sport.entity.CartEntity;
import com.sport.entity.ProductsEntity;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.User;
import com.sport.model.CartItemDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.*;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartDao cartDao;

    @Autowired
    private ProductDao productDao;

    @Autowired
    private ObjectMapper objectMapper;

    // Thêm vào giỏ
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(
            @RequestParam("variantId") int variantId,
            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
            HttpSession session,
            javax.servlet.http.HttpServletRequest request) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login.htm";

        // Kiem tra stock
        Integer availableStock = productDao.getAvailableStock(variantId);
        if (availableStock == null || availableStock < quantity) {
            session.setAttribute("cartError", "Sản phẩm không đủ số lượng! Chỉ còn " + availableStock + " sản phẩm.");
            String referer = request.getHeader("Referer");
            return "redirect:" + (referer != null ? referer : "/cart/index.htm");
        }

        cartDao.add(user.getId(), variantId, quantity);
        long count = cartDao.countByUserId(user.getId());
        session.setAttribute("cartCount", count);
        session.removeAttribute("cartError");
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/cart/index.htm");
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
        List<Map<String, Object>> result = new ArrayList<>();

        for (CartEntity item : cartItems) {
            ProductVariantsEntity variant = productDao.getVariantById(item.getProductVariantId());
            if (variant == null) continue;

            ProductsEntity product = variant.getProduct();
            if (product == null) continue;

            Map<String, Object> itemMap = new LinkedHashMap<>();
            itemMap.put("cartId", item.getId());
            itemMap.put("variantId", item.getProductVariantId());
            itemMap.put("variantName", variant.getVariant_name());
            itemMap.put("productName", product.getProductName());
            itemMap.put("price", product.getPrice());
            itemMap.put("quantity", item.getQuantity());
            itemMap.put("avatarName", product.getAvatarName());
            result.add(itemMap);
        }

        try {
            return objectMapper.writeValueAsString(result);
        } catch (Exception e) {
            return "[]";
        }
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

        // Lay cart item de kiem tra variant
        CartEntity cartItem = cartDao.getCartById(cartId);
        if (cartItem == null) {
            return "{\"status\":\"error\",\"message\":\"Item not found\"}";
        }

        // Kiem tra stock khi cap nhat
        if (quantity > 0) {
            Integer availableStock = productDao.getAvailableStock(cartItem.getProductVariantId());
            if (availableStock == null || availableStock < quantity) {
                return "{\"status\":\"insufficient_stock\",\"available\":" + availableStock + "}";
            }
        }

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

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String viewCart(HttpSession session, ModelMap model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login.htm";

        List<CartEntity> cartEntities = cartDao.getByUserId(user.getId());
        List<CartItemDTO> cartItems = new ArrayList<>();
        double cartTotal = 0;

        for (CartEntity item : cartEntities) {
            ProductVariantsEntity variant = productDao.getVariantById(item.getProductVariantId());
            if (variant != null && variant.getProduct() != null) {
                ProductsEntity product = variant.getProduct();
                CartItemDTO dto = new CartItemDTO(
                    item.getId(),
                    item.getProductVariantId(),
                    product.getProductName(),
                    variant.getVariant_name(),
                    product.getPrice(),
                    product.getAvatarName(),
                    item.getQuantity()
                );
                cartItems.add(dto);
                cartTotal += product.getPrice() * item.getQuantity();
            }
        }

        model.addAttribute("cartTotal", String.format("%.2f", cartTotal));
        model.addAttribute("cartItems", cartItems);
        return "cart";
    }
}