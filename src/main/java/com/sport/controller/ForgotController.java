package com.sport.controller;

import com.sport.dao.UserDAO;
import com.sport.entity.User;
import com.sport.service.PasswordResetTokenService;
import com.sport.util.PasswordUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

@Controller
public class ForgotController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private PasswordResetTokenService tokenService;

    @RequestMapping(value = "/forgot.htm", method = RequestMethod.GET)
    public String showForm() {
        return "forgot";
    }

    @RequestMapping(value = "/forgot.htm", method = RequestMethod.POST)
    public String forgot(@RequestParam("identifier") String identifier,
                        @RequestParam(value = "baseUrl", required = false) String baseUrl,
                        Model model,
                        HttpServletRequest request) {

        if (identifier == null || identifier.trim().isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập Email hoặc Số điện thoại!");
            return "forgot";
        }

        identifier = identifier.trim();
        User user = userDAO.findByEmailOrPhone(identifier);

        if (user != null) {
            String token = tokenService.generateToken(user.getId());

            String serverName = request.getServerName();
            int serverPort = request.getServerPort();
            String protocol = request.getScheme();

            String resetLink;
            if (baseUrl != null && !baseUrl.isEmpty()) {
                resetLink = baseUrl + "/reset-password.htm?token=" + token;
            } else {
                String portPart = (serverPort == 80 || serverPort == 443) ? "" : ":" + serverPort;
                resetLink = protocol + "://" + serverName + portPart + request.getContextPath() + "/reset-password.htm?token=" + token;
            }

            // Send email with reset link
            try {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

                helper.setFrom("lmkhoidev@gmail.com", "Yonex Sport");
                helper.setTo(user.getEmail());
                helper.setSubject("Yonex Sport - Reset Password");
                helper.setText(
                    "Chào " + user.getFullName() + ",<br><br>" +
                    "Chúng tôi đã nhận được yêu cầu reset password cho tài khoản của bạn.<br><br>" +
                    "Click vào link bên dưới để reset password:<br>" +
                    "<a href='" + resetLink + "'>" + resetLink + "</a><br><br>" +
                    "Link này sẽ hết hạn sau 24 giờ.<br><br>" +
                    "Nếu bạn không yêu cầu reset password, vui lòng bỏ qua email này.",
                    true
                );

                mailSender.send(message);
                model.addAttribute("success",
                    "Đã gửi link reset password về email: " + user.getEmail());
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("error", "Không thể gửi email. Vui lòng thử lại sau.");
                return "forgot";
            }
            return "forgot";
        }

        model.addAttribute("error", "Không tìm thấy tài khoản với thông tin này!");
        return "forgot";
    }
}
