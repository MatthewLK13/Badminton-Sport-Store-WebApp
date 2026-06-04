package com.sport.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sport.entity.User;
import com.sport.dao.CartDao;
import com.sport.entity.CartEntity;

import java.util.List;

public class CartInterceptor extends HandlerInterceptorAdapter {

    private CartDao cartDao;

    public CartInterceptor() {
    }

    public CartInterceptor(CartDao cartDao) {
        this.cartDao = cartDao;
    }

    public void setCartDao(CartDao cartDao) {
        this.cartDao = cartDao;
    }

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        if (session == null || cartDao == null) {
            return true;
        }

        User user = (User) session.getAttribute("user");
        if (user != null) {
            List<CartEntity> cartItems = cartDao.getCartByUserId(user.getId());
            int cartCount = cartItems != null ? cartItems.size() : 0;
            session.setAttribute("cartCount", cartCount);
        }

        return true;
    }
}
