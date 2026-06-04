package com.sport.controller;

import com.sport.dao.UserDAO;
import com.sport.entity.User;
import com.sport.service.PasswordResetTokenService;
import com.sport.util.PasswordUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ResetPasswordController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private PasswordResetTokenService tokenService;

    @RequestMapping(value = "/reset-password.htm", method = RequestMethod.GET)
    public String showResetForm(@RequestParam("token") String token, Model model) {
        Integer userId = tokenService.validateToken(token);

        if (userId == null) {
            model.addAttribute("error", "Link reset password không hợp lệ hoặc đã hết hạn!");
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
            Model model) {

        Integer userId = tokenService.validateToken(token);

        if (userId == null) {
            model.addAttribute("error", "Link reset password không hợp lệ hoặc đã hết hạn!");
            return "reset_password";
        }

        // Validate passwords
        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập mật khẩu mới!");
            model.addAttribute("token", token);
            return "reset_password";
        }

        String passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$";
        if (!password.matches(passRegex)) {
            model.addAttribute("error", "Mật khẩu phải >= 6 ký tự, gồm cả chữ và số!");
            model.addAttribute("token", token);
            return "reset_password";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            model.addAttribute("token", token);
            return "reset_password";
        }

        // Get user and update password
        User user = userDAO.getUserById(userId);
        if (user == null) {
            model.addAttribute("error", "Tài khoản không tồn tại!");
            return "reset_password";
        }

        // Hash new password and save
        String hashedPassword = PasswordUtil.hashPassword(password, user.getEmail());
        user.setPasswordHash(hashedPassword);
        userDAO.updateUser(user);

        // Remove used token
        tokenService.removeToken(token);

        model.addAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
        return "login";
    }
}
