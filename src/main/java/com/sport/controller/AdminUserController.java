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
import com.sport.entity.Role;
import com.sport.util.PasswordUtil;

@Controller
@RequestMapping("/admin")
public class AdminUserController {

    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/users.htm", method = RequestMethod.GET)
    public String listUsers(Model model, HttpSession session) {
        List<User> users = userDAO.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user_management";
    }

    @RequestMapping(value = "/user/delete.htm", method = RequestMethod.POST)
    public String deleteUser(HttpSession session, @RequestParam("userId") Integer userId) {
        userDAO.deleteUser(userId);
        return "redirect:/admin/users.htm";
    }

    @RequestMapping(value = "/user/lock.htm", method = RequestMethod.POST)
    public String lockUser(HttpSession session, @RequestParam("userId") Integer userId) {
        userDAO.lockUser(userId);
        return "redirect:/admin/users.htm";
    }

    @RequestMapping(value = "/user/unlock.htm", method = RequestMethod.POST)
    public String unlockUser(HttpSession session, @RequestParam("userId") Integer userId) {
        userDAO.unlockUser(userId);
        return "redirect:/admin/users.htm";
    }

    @RequestMapping(value = "/user/add.htm", method = RequestMethod.GET)
    public String showAddUser(HttpSession session) {
        return "admin/add_user";
    }

    @RequestMapping(value = "/user/save.htm", method = RequestMethod.POST)
    public String saveUser(HttpSession session,
                           @RequestParam("fullName") String fullName,
                           @RequestParam("email") String email,
                           @RequestParam("password") String password,
                           @RequestParam("roleId") Integer roleId,
                           @RequestParam("status") Integer status,
                           Model model) {

        if (userDAO.existsByEmail(email.trim())) {
            model.addAttribute("error", "Email đã tồn tại!");
            return "admin/add_user";
        }

        User newUserEntity = new User();
        newUserEntity.setFullName(fullName.trim());
        newUserEntity.setEmail(email.trim());
        String hashedPassword = PasswordUtil.hashPassword(password, email.trim());
        newUserEntity.setPasswordHash(hashedPassword);

        Role role = new Role();
        role.setId(roleId);
        newUserEntity.setRole(role);
        newUserEntity.setIsActive(status == 1); // 1 is active, 0 is locked

        userDAO.saveUser(newUserEntity);

        return "redirect:/admin/users.htm";
    }
}
