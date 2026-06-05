package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.UserDAO;
import com.sport.dao.OrderDAO;
import com.sport.entity.User;
import com.sport.util.LocaleUtils;

@Controller
public class ProfileController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private OrderDAO orderDAO;

    // GET /profile.htm – Hiển thị trang cá nhân
    @RequestMapping(value = "/profile.htm", method = RequestMethod.GET)
    public String showProfile(HttpSession session, Model model) {

        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        model.addAttribute("user", user);
        model.addAttribute("orders", orderDAO.findByUserId(user.getId()));
        return "profile";
    }

    // POST /profile.htm – Cập nhật thông tin cá nhân
    @RequestMapping(value = "/profile.htm", method = RequestMethod.POST)
    public String updateProfile(
            @RequestParam("fullname") String fullname,
            @RequestParam("phone") String phone,
            @RequestParam(value = "address", required = false) String address,
            HttpServletRequest request,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        // Validate
        fullname = fullname.trim();
        phone    = phone.trim();

        String phoneRegex = "^[0-9]{10}$";

        if (fullname.isEmpty()) {
            model.addAttribute("error", LocaleUtils.msg(request, "validation.name.required"));
            model.addAttribute("user", user);
            return "profile";
        }

        if (!phone.matches(phoneRegex)) {
            model.addAttribute("error", LocaleUtils.msg(request, "validation.phone.invalid"));
            model.addAttribute("user", user);
            return "profile";
        }

        // Cập nhật thông tin
        user.setFullName(fullname);
        user.setPhone(phone);
        if (address != null) {
            user.setAddress(address.trim());
        }

        // Lưu vào Database
        userDAO.updateUser(user);

        // Cập nhật lại session
        session.setAttribute("user", user);

        model.addAttribute("user", user);
        model.addAttribute("success", LocaleUtils.msg(request, "profile.update.success"));
        return "profile";
    }
}
