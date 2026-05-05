<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form action="${pageContext.request.contextPath}/login.htm" method="post" style="text-align: left;">
    
    <input type="text" name="username" class="input-field" placeholder="Email/Số điện thoại" required>
    
    <input type="password" name="password" class="input-field" placeholder="Mật khẩu" required>

    <!-- Khối chứa link Quên mật khẩu đã được quản lý bằng CSS -->
    <div class="forgot-pass-container">
        <a href="${pageContext.request.contextPath}/forgot.htm" class="forgot-pass">
           Quên mật khẩu
        </a>
    </div>
    
    <!-- Nút đăng nhập -->
    <div style="width: 100%;">
        <button type="submit" class="btn-login">Đăng nhập</button>
    </div>
    
</form>