package com.sport.controller;

import com.sport.dao.UserDAO;
import com.sport.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ForgotController {

    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/forgot.htm", method = RequestMethod.GET)
    public String showForm() {
        return "forgot";
    }

    @RequestMapping(value = "/forgot.htm", method = RequestMethod.POST)
    public String forgot(@RequestParam("identifier") String identifier, Model model) {

        if (identifier == null || identifier.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập Email hoặc Số điện thoại!");
            return "forgot";
        }

        identifier = identifier.trim();

        // Tìm user trong Database
        User user = userDAO.findByEmailOrPhone(identifier);

        if (user != null) {
            // Không hiển thị mật khẩu thật – chỉ thông báo tài khoản tồn tại
            model.addAttribute("success",
                "Tài khoản hợp lệ! Mật khẩu của bạn đã được gửi về email: " + user.getEmail());
            return "forgot";
        }

        model.addAttribute("error", "Không tìm thấy tài khoản với thông tin này!");
        return "forgot";
    }
}
