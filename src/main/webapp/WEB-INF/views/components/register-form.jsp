<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message code="auth.register.placeholder.name" var="phName"/>
<spring:message code="auth.register.placeholder.email" var="phEmail"/>
<spring:message code="auth.register.phone" var="phPhone"/>
<spring:message code="auth.register.password" var="phPassword"/>
<spring:message code="auth.register.placeholder.confirm" var="phConfirm"/>

<form:form action="${pageContext.request.contextPath}/register.htm" method="post" modelAttribute="user" style="text-align: left;">

    <div class="form-group">
        <form:input path="name" class="input-field" placeholder="${phName}" />
        <form:errors path="name" cssClass="field-error" />
    </div>

    <div class="form-group">
        <form:input path="email" class="input-field" placeholder="${phEmail}" />
        <form:errors path="email" cssClass="field-error" />
    </div>

    <div class="form-group">
        <form:input path="phone" class="input-field" placeholder="${phPhone}" />
        <form:errors path="phone" cssClass="field-error" />
    </div>

    <div class="form-group">
        <form:password path="password" class="input-field" placeholder="${phPassword}" />
        <form:errors path="password" cssClass="field-error" />
    </div>

    <div class="form-group">
        <input type="password" name="confirmPassword" class="input-field" placeholder="${phConfirm}" required>
    </div>

    <div style="width: 100%; text-align: center; margin-top: 10px;">
        <button type="submit" class="btn-login" style="width: 100%;"><spring:message code="auth.register.submit" text="Register" /></button>
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
    margin-bottom: 0px;
}
</style>
