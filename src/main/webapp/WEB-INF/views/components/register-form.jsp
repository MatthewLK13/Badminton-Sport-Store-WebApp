<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form action="${pageContext.request.contextPath}/register.htm" method="post" style="text-align: left;">
    
    <!-- Các trường thông tin (bạn có thể thêm bớt tùy theo Database/Model User thực tế) -->
    <input type="text" name="fullname" class="input-field" placeholder="Họ và tên" required>
    
    <input type="email" name="email" class="input-field" placeholder="Email" required>
    
    <input type="text" name="phone" class="input-field" placeholder="Số điện thoại" required>
    
    <input type="password" name="password" class="input-field" placeholder="Mật khẩu" required>
    
    <input type="password" name="confirmPassword" class="input-field" placeholder="Nhập lại mật khẩu" required>

    <div style="width: 100%; display: flex; justify-content: flex-start; margin-top: 10px;">
        <!-- Nút đăng ký mình cho full chiều rộng (width: 100%) để form nhìn cân đối -->
        <button type="submit" class="btn-login" style="width: 100%;">Đăng ký tài khoản</button>
    </div>
</form>