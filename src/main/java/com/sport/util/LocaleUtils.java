package com.sport.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

@Component
public class LocaleUtils implements ApplicationContextAware {

    private static ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext context) {
        applicationContext = context;
    }

    public static void setMessageSource(MessageSource ms) {
        // Deprecated - now uses ApplicationContext
    }

    public static MessageSource getMessageSourceStatic() {
        return resolveMessageSource(null);
    }

    public static String getMessage(HttpServletRequest request, String code) {
        return getMessage(request, code, (String) null);
    }

    public static String getMessage(HttpServletRequest request, String code, String defaultMsg) {
        MessageSource ms = resolveMessageSource(request);
        if (ms == null) {
            return defaultMsg != null ? defaultMsg : code;
        }

        Locale locale = getCurrentLocale(request);
        try {
            return ms.getMessage(code, null, defaultMsg, locale);
        } catch (Exception e) {
            return defaultMsg != null ? defaultMsg : code;
        }
    }

    public static String getMessage(HttpServletRequest request, String code, Object[] args) {
        return getMessage(request, code, args, code);
    }

    public static String getMessage(HttpServletRequest request, String code, Object[] args, String defaultMsg) {
        MessageSource ms = resolveMessageSource(request);
        if (ms == null) {
            return defaultMsg;
        }

        Locale locale = getCurrentLocale(request);
        try {
            return ms.getMessage(code, args, defaultMsg, locale);
        } catch (Exception e) {
            return defaultMsg;
        }
    }

    private static MessageSource resolveMessageSource(HttpServletRequest request) {
        // 1. Try ApplicationContext (best approach - always available after init)
        if (applicationContext != null) {
            try {
                MessageSource ms = applicationContext.getBean(MessageSource.class);
                if (ms != null) {
                    return ms;
                }
            } catch (Exception e) {
                // Bean not found
            }
        }

        // 2. Use static messageSource if set manually
        // (kept for backward compatibility)

        // 3. Try request attribute set by DispatcherServlet (Spring 4.x compatible)
        if (request != null) {
            MessageSource ms = (MessageSource) request.getAttribute("org.springframework.web.servlet.DispatcherServlet.MESSAGE_SOURCE");
            if (ms != null) {
                return ms;
            }
        }

        // 4. Fallback: try RequestContextHolder request attributes
        try {
            ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpServletRequest req = attrs.getRequest();
            MessageSource ms = (MessageSource) req.getAttribute("org.springframework.web.servlet.DispatcherServlet.MESSAGE_SOURCE");
            if (ms != null) {
                return ms;
            }
        } catch (Exception e) {
            // Ignore
        }

        return null;
    }

    public static Locale getCurrentLocale(HttpServletRequest request) {
        if (request != null) {
            Locale resolved = RequestContextUtils.getLocale(request);
            if (resolved != null) {
                return resolved;
            }
            if (request.getSession(false) != null) {
                Locale sessionLocale = (Locale) request.getSession(false).getAttribute("locale");
                if (sessionLocale != null) {
                    return sessionLocale;
                }
            }
        }
        return new Locale("vi");
    }

    public static String getCurrentLanguage(HttpServletRequest request) {
        Locale locale = getCurrentLocale(request);
        return locale.getLanguage();
    }

    public static boolean isVietnamese(HttpServletRequest request) {
        return "vi".equals(getCurrentLanguage(request));
    }

    public static String msg(HttpServletRequest request, String code) {
        return getMessage(request, code, code);
    }

    public static String msg(HttpServletRequest request, String code, Object[] args) {
        return getMessage(request, code, args, code);
    }
}
