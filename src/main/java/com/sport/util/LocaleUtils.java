package com.sport.util;

import org.springframework.context.MessageSource;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

public class LocaleUtils {

    public static String getMessage(HttpServletRequest request, String code) {
        return getMessage(request, code, null);
    }

    public static String getMessage(HttpServletRequest request, String code, String defaultMsg) {
        MessageSource messageSource = getMessageSource(request);
        if (messageSource == null) {
            return defaultMsg != null ? defaultMsg : code;
        }

        Locale locale = getCurrentLocale(request);
        try {
            return messageSource.getMessage(code, null, defaultMsg, locale);
        } catch (Exception e) {
            return defaultMsg != null ? defaultMsg : code;
        }
    }

    public static String getMessage(HttpServletRequest request, String code, Object[] args) {
        MessageSource messageSource = getMessageSource(request);
        if (messageSource == null) {
            return code;
        }

        Locale locale = getCurrentLocale(request);
        try {
            return messageSource.getMessage(code, args, locale);
        } catch (Exception e) {
            return code;
        }
    }

    private static MessageSource getMessageSource(HttpServletRequest request) {
        // Try to get from request attribute first (set by DispatcherServlet)
        MessageSource messageSource = (MessageSource) request.getAttribute(DispatcherServlet.MESSAGE_SOURCE);
        if (messageSource != null) {
            return messageSource;
        }
        // Fallback: try RequestContextHolder
        try {
            ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            return attrs.getMessageSource();
        } catch (Exception e) {
            return null;
        }
    }

    public static Locale getCurrentLocale(HttpServletRequest request) {
        Locale sessionLocale = (Locale) request.getSession(false).getAttribute("locale");
        if (sessionLocale != null) {
            return sessionLocale;
        }
        return request.getLocale();
    }

    public static String getCurrentLanguage(HttpServletRequest request) {
        Locale locale = getCurrentLocale(request);
        return locale.getLanguage();
    }

    public static boolean isVietnamese(HttpServletRequest request) {
        return "vi".equals(getCurrentLanguage(request));
    }
}
