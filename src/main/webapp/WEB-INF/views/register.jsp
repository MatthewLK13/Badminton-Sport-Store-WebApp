<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="auth.register.title" text="Register" /></title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">
    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <h1><spring:message code="auth.register.title" text="Register" /></h1>
        <p class="sub-text"><spring:message code="auth.register.subtitle" text="Already have an account? Login" />
            <a href="${pageContext.request.contextPath}/login.htm"><spring:message code="auth.register.link.here" text="here" /></a></p>

        <jsp:include page="components/register-form.jsp" />
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="alert error" style="color:red; text-align:center; padding: 10px; margin-top: 15px; border: 1px solid red; border-radius: 5px;"><%= request.getAttribute("error") %></div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
        <div class="alert success" style="color:green; text-align:center; padding: 10px; margin-top: 15px; border: 1px solid green; border-radius: 5px;"><%= request.getAttribute("success") %></div>
    <% } %>

</body>
</html>
