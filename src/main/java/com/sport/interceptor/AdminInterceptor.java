package com.sport.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sport.entity.User;

public class AdminInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        if (user == null || user.getRole() == null) {
            response.sendRedirect(request.getContextPath() + "/login.htm");
            return false;
        }

        String roleName = user.getRole().getRoleName();
        if (!"ADMIN".equalsIgnoreCase(roleName)) {
            if (isAjaxRequest(request)) {
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                response.getWriter().write("{\"error\": \"Không có quyền truy cập\"}");
                return false;
            }
            response.sendRedirect(request.getContextPath() + "/home.htm");
            return false;
        }

        return true;
    }

    private boolean isAjaxRequest(HttpServletRequest request) {
        String ajaxHeader = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equals(ajaxHeader);
    }
}
