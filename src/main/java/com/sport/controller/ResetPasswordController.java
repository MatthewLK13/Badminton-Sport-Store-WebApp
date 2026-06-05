package com.sport.controller;

import com.sport.dao.UserDAO;
import com.sport.entity.User;
import com.sport.service.PasswordResetTokenService;
import com.sport.util.PasswordUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

import com.sport.util.LocaleUtils;

@Controller
public class ResetPasswordController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private PasswordResetTokenService tokenService;

    @RequestMapping(value = "/reset-password.htm", method = RequestMethod.GET)
    public String showResetForm(@RequestParam("token") String token, HttpServletRequest request, Model model) {
        Integer userId = tokenService.validateToken(token);

        if (userId == null) {
            model.addAttribute("error", LocaleUtils.msg(request, "auth.reset.error"));
            return "reset_password"; // Will show error page
        }

        model.addAttribute("token", token);
        return "reset_password";
    }

    @RequestMapping(value = "/reset-password.htm", method = RequestMethod.POST)
    public String processReset(
            @RequestParam("token") String token,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpServletRequest request,
            Model model) {

        Integer userId = tokenService.validateToken(token);

        if (userId == null) {
            model.addAttribute("error", LocaleUtils.msg(request, "auth.reset.error"));
            return "reset_password";
        }

        // Validate passwords
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("error", LocaleUtils.msg(request, "auth.reset.password.required"));
            model.addAttribute("token", token);
            return "reset_password";
        }

        String passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$";
        if (!password.matches(passRegex)) {
            model.addAttribute("error", LocaleUtils.msg(request, "auth.reset.password.pattern"));
            model.addAttribute("token", token);
            return "reset_password";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", LocaleUtils.msg(request, "validation.password.mismatch"));
            model.addAttribute("token", token);
            return "reset_password";
        }

        // Get user and update password
        User user = userDAO.getUserById(userId);
        if (user == null) {
            model.addAttribute("error", LocaleUtils.msg(request, "auth.reset.account.notfound"));
            return "reset_password";
        }

        // Hash new password and save
        String hashedPassword = PasswordUtil.hashPassword(password, user.getEmail());
        user.setPasswordHash(hashedPassword);
        userDAO.updateUser(user);

        // Remove used token
        tokenService.removeToken(token);

        model.addAttribute("success", LocaleUtils.msg(request, "auth.reset.success"));
        return "login";
    }
}
