<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<form action="${pageContext.request.contextPath}/login.htm" method="post" style="text-align: left;">
    
    <input type="text" name="username" class="input-field" placeholder="<spring:message code='auth.login.placeholder.account' text='Email/Phone' />" required>
    
    <input type="password" name="password" class="input-field" placeholder="<spring:message code='auth.login.password' text='Password' />" required>

    <div class="auth-actions">
        <button type="submit" class="btn-login"><spring:message code="auth.login.submit" text="Login" /></button>
        <a href="${pageContext.request.contextPath}/forgot.htm" class="forgot-pass">
           <spring:message code="auth.login.forgot" text="Forgot password?" />
        </a>
    </div>
    
</form>
