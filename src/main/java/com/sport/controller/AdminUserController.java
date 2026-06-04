package com.sport.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.dao.UserDAO;
import com.sport.entity.User;

@Controller
@RequestMapping("/admin")
public class AdminUserController {

    @Autowired
    private UserDAO userDAO;

    private static final int ADMIN_ROLE_ID = 1;

    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && user.getRole() != null && user.getRole().getId() == ADMIN_ROLE_ID;
    }

    @RequestMapping(value = "/users.htm", method = RequestMethod.GET)
    public String listUsers(Model model, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/home.htm?error=access_denied";
        }
        List<User> users = userDAO.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user_management";
    }

    @RequestMapping(value = "/user/delete.htm", method = RequestMethod.POST)
    public String deleteUser(HttpSession session, @RequestParam("userId") Integer userId) {
        if (!isAdmin(session)) {
            return "redirect:/home.htm?error=access_denied";
        }
        userDAO.deleteUser(userId);
        return "redirect:/admin/users.htm";
    }

    @RequestMapping(value = "/user/lock.htm", method = RequestMethod.POST)
    public String lockUser(HttpSession session, @RequestParam("userId") Integer userId) {
        if (!isAdmin(session)) {
            return "redirect:/home.htm?error=access_denied";
        }
        userDAO.lockUser(userId);
        return "redirect:/admin/users.htm";
    }

    @RequestMapping(value = "/user/unlock.htm", method = RequestMethod.POST)
    public String unlockUser(HttpSession session, @RequestParam("userId") Integer userId) {
        if (!isAdmin(session)) {
            return "redirect:/home.htm?error=access_denied";
        }
        userDAO.unlockUser(userId);
        return "redirect:/admin/users.htm";
    }
}
