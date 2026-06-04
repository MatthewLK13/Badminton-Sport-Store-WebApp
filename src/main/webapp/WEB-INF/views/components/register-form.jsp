<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<form:form action="${pageContext.request.contextPath}/register.htm" method="post" modelAttribute="user" style="text-align: left;">

    <div class="form-group">
        <form:input type="text" path="name" class="input-field" placeholder="Họ và tên" />
        <form:errors path="name" cssClass="field-error" />
    </div>

    <div class="form-group">
        <form:input type="email" path="email" class="input-field" placeholder="Email" />
        <form:errors path="email" cssClass="field-error" />
    </div>

    <div class="form-group">
        <form:input type="text" path="phone" class="input-field" placeholder="Số điện thoại" />
        <form:errors path="phone" cssClass="field-error" />
    </div>

    <div class="form-group">
        <form:password type="password" path="password" class="input-field" placeholder="Mật khẩu" />
        <form:errors path="password" cssClass="field-error" />
    </div>

    <div class="form-group">
        <input type="password" name="confirmPassword" class="input-field" placeholder="Nhập lại mật khẩu" required>
    </div>

    <div style="width: 100%; display: flex; justify-content: flex-start; margin-top: 10px;">
        <button type="submit" class="btn-login" style="width: 100%;">Đăng ký tài khoản</button>
    </div>
</form:form>

<style>
.field-error {
    color: #dc2626;
    font-size: 12px;
    margin-top: 4px;
    display: block;
}
.form-group {
    margin-bottom: 15px;
}
</style>