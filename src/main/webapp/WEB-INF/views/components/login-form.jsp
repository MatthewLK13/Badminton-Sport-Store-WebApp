<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form action="${pageContext.request.contextPath}/login.htm" method="post" style="text-align: left;">
    
    <input type="text" name="username" class="input-field" placeholder="Email/Số điện thoại" required>
    
    <input type="password" name="password" class="input-field" placeholder="Mật khẩu" required>

    <div class="auth-actions">
        <button type="submit" class="btn-login">Đăng nhập</button>
        <a href="${pageContext.request.contextPath}/forgot.htm" class="forgot-pass">
           Quên mật khẩu
        </a>
    </div>
    
</form>