package com.sport.controller;

import com.sport.dao.UserDAO;
import com.sport.entity.Role;
import com.sport.util.PasswordUtil;
import com.sport.util.LocaleUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.sport.model.User;

@Controller
public class RegisterController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private JavaMailSender mailSender;

    @RequestMapping(value = "/register.htm", method = RequestMethod.GET)
    public String showRegister(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @RequestMapping(value = "/register.htm", method = RequestMethod.POST)
    public String register(
            @ModelAttribute("user") @Valid User user,
            @RequestParam("confirmPassword") String repass,
            BindingResult result,
            HttpServletRequest request,
            Model model) {

        if (result.hasErrors()) {
            model.addAttribute("user", user);
            return "register";
        }

        if (!repass.equals(user.getPassword())) {
            model.addAttribute("error", LocaleUtils.msg(request, "validation.password.mismatch"));
            return "register";
        }

        String email = user.getEmail().trim();
        String phone = user.getPhone().trim();

        if (userDAO.existsByEmail(email)) {
            model.addAttribute("error", LocaleUtils.msg(request, "auth.register.exists"));
            return "register";
        }

        if (userDAO.existsByPhone(phone)) {
            model.addAttribute("error", LocaleUtils.msg(request, "auth.register.phone.exists"));
            return "register";
        }

        com.sport.entity.User newUserEntity = new com.sport.entity.User();
        newUserEntity.setFullName(user.getName().trim());
        newUserEntity.setEmail(email);
        newUserEntity.setPhone(phone);
        String hashedPassword = PasswordUtil.hashPassword(user.getPassword(), email);
        newUserEntity.setPasswordHash(hashedPassword);

        Role role = new Role();
        role.setId(2);
        newUserEntity.setRole(role);

        userDAO.saveUser(newUserEntity);

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("lmkhoidev@gmail.com", "Yonex Sport");
            helper.setTo(email);
            helper.setSubject("Đăng ký tài khoản thành công - Yonex Sport");
            helper.setText("Chào " + user.getName() + ",<br><br>"
                    + "Chúc mừng bạn đã đăng ký tài khoản thành công tại Yonex Sport!<br>"
                    + "Email đăng nhập: " + email + "<br><br>"
                    + "Cảm ơn bạn đã đồng hành cùng chúng tôi.", true);

            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("success", LocaleUtils.msg(request, "auth.register.success"));
        return "redirect:/login.htm";
    }
}