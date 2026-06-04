package com.sport.controller;

import java.util.List;
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

    @RequestMapping(value = "/users.htm", method = RequestMethod.GET)
    public String listUsers(Model model) {
        List<User> users = userDAO.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user_management";
    }

    @RequestMapping(value = "/user/delete.htm", method = RequestMethod.POST)
    public String deleteUser(@RequestParam("userId") Integer userId) {
        userDAO.deleteUser(userId);
        return "redirect:/admin/users.htm";
    }

    @RequestMapping(value = "/user/lock.htm", method = RequestMethod.POST)
    public String lockUser(@RequestParam("userId") Integer userId) {
        userDAO.lockUser(userId);
        return "redirect:/admin/users.htm";
    }

    @RequestMapping(value = "/user/unlock.htm", method = RequestMethod.POST)
    public String unlockUser(@RequestParam("userId") Integer userId) {
        userDAO.unlockUser(userId);
        return "redirect:/admin/users.htm";
    }
}
