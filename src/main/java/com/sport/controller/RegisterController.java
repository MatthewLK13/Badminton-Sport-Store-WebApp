package com.sport.controller;

import com.sport.dao.UserDAO;
import com.sport.entity.Role;
import com.sport.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegisterController {

    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/register.htm", method = RequestMethod.GET)
    public String showRegister() {
        return "register";
    }

    @RequestMapping(value = "/register.htm", method = RequestMethod.POST)
    public String register(
            @RequestParam("fullname") String fullname,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("password") String pass,
            @RequestParam("confirmPassword") String repass,
            Model model) {

        // Trim dữ liệu đầu vào
        fullname = fullname.trim();
        email    = email.trim();
        phone    = phone.trim();
        pass     = pass.trim();
        repass   = repass.trim();

        // --- Validate ---
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        String phoneRegex = "^[0-9]{10}$";
        String passRegex  = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$";

        if (fullname.isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập họ và tên!");
            return "register";
        }

        if (!email.matches(emailRegex)) {
            model.addAttribute("error", "Email không hợp lệ!");
            return "register";
        }

        if (!phone.matches(phoneRegex)) {
            model.addAttribute("error", "Số điện thoại phải gồm đúng 10 chữ số!");
            return "register";
        }

        if (!pass.matches(passRegex)) {
            model.addAttribute("error", "Mật khẩu phải >= 6 ký tự, gồm cả chữ và số!");
            return "register";
        }

        if (!pass.equals(repass)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "register";
        }

        // --- Kiểm tra trùng lặp trong Database ---
        if (userDAO.existsByEmail(email)) {
            model.addAttribute("error", "Email này đã được đăng ký!");
            return "register";
        }

        if (userDAO.existsByPhone(phone)) {
            model.addAttribute("error", "Số điện thoại này đã được đăng ký!");
            return "register";
        }

        // --- Lưu user mới vào Database ---
        User newUser = new User();
        newUser.setFullName(fullname);
        newUser.setEmail(email);
        newUser.setPhone(phone);
        newUser.setPasswordHash(pass); // TODO: hash password nếu cần bảo mật cao hơn

        // Gán role mặc định là User (role_id = 2)
        Role role = new Role();
        role.setId(2);
        newUser.setRole(role);

        userDAO.saveUser(newUser);

        model.addAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
        return "login";
    }
}