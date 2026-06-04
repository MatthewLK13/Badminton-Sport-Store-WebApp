package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Locale;

@Controller
public class LocaleController {

    @RequestMapping(value = "/changeLocale.htm", method = RequestMethod.GET)
    public String changeLocale(@RequestParam("lang") String lang,
                               HttpServletRequest request,
                               @RequestParam(value = "redirect", required = false) String redirect) {
        Locale locale;

        if ("vi".equalsIgnoreCase(lang)) {
            locale = new Locale("vi");
        } else {
            locale = new Locale("en");
        }

        HttpSession session = request.getSession();
        session.setAttribute("locale", locale);

        if (redirect != null && !redirect.isEmpty()) {
            return "redirect:" + redirect;
        }

        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }

        return "redirect:/home.htm";
    }
}
