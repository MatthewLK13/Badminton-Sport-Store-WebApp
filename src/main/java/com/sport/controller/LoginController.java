package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.CartDao;
import com.sport.dao.UserDAO;
import com.sport.dao.WishlistDao;
import com.sport.entity.User;
import com.sport.util.PasswordUtil;
import com.sport.util.LocaleUtils;

@Controller
public class LoginController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private CartDao cartDao;

    @Autowired
    private WishlistDao wishlistDao;

    @RequestMapping(value = "/login.htm", method = RequestMethod.GET)
    public String showLogin() {
        return "login";
    }

    @RequestMapping(value = "/login.htm", method = RequestMethod.POST)
    public String login(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            HttpServletRequest request,
            HttpSession session,
            Model model) {

        username = username.trim();
        password = password.trim();

        User user = userDAO.findByEmailOrPhone(username);

        if (user != null) {
            String storedHash = user.getPasswordHash();

            // Legacy MD5 password (32 hex chars)
            if (PasswordUtil.isLegacyMd5Hash(storedHash)) {
                if (PasswordUtil.verifyPassword(password, storedHash)) {
                    // Upgrade to SHA256
                    String newHash = PasswordUtil.hashPassword(password);
                    user.setPasswordHash(newHash);
                    userDAO.updateUser(user);

                    session.setAttribute("user", user);
                    session.setAttribute("cartCount", cartDao.countByUserId(user.getId()));
                    session.setAttribute("wishlistCount", wishlistDao.countByUserId(user.getId()));
                    if (user.getRole() != null && user.getRole().getId() == 1) {
                        return "redirect:/admin/dashboard.htm";
                    }
                    return "redirect:/home.htm";
                }
            } else {
                // SHA256 password (registered with email as salt)
                if (PasswordUtil.verifyPassword(password, storedHash, user.getEmail())) {
                    session.setAttribute("user", user);
                    session.setAttribute("cartCount", cartDao.countByUserId(user.getId()));
                    session.setAttribute("wishlistCount", wishlistDao.countByUserId(user.getId()));
                    if (user.getRole() != null && user.getRole().getId() == 1) {
                        return "redirect:/admin/dashboard.htm";
                    }
                    return "redirect:/home.htm";
                }
            }
        }

        model.addAttribute("error", LocaleUtils.msg(request, "auth.login.error"));
        return "login";
    }
}
