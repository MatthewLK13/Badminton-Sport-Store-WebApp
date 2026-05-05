<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form action="${pageContext.request.contextPath}/forgot.htm" method="post" style="text-align: left;">
    
    <input type="text" name="identifier" class="input-field" placeholder="Email/Số điện thoại" required>
    
    <div style="width: 100%; display: flex; justify-content: flex-start;">
        <button type="submit" class="btn-login" style="width: 100%;">Tìm mật khẩu</button>
    </div>
    
</form>