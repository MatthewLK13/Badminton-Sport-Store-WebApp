<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<form action="${pageContext.request.contextPath}/forgot.htm" method="post" style="text-align: left;">
    
    <input type="text" name="identifier" class="input-field" placeholder="<spring:message code='auth.forgot.placeholder' text='Email/Phone' />" required>
    
    <div style="width: 100%; display: flex; justify-content: flex-start;">
        <button type="submit" class="btn-login" style="width: 100%;"><spring:message code="auth.forgot.submit" text="Send reset link" /></button>
    </div>
    
</form>
