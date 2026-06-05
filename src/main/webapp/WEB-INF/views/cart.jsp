<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><spring:message code="cart.title" text="Shopping Cart" /> - Yonex</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="breadcrumb-container">
    <div class="breadcrumb-content">
        <a href="${pageContext.request.contextPath}/home.htm"><spring:message code="nav.home" text="Home" /></a>
        <span class="breadcrumb-separator">></span>
        <span class="active"><spring:message code="breadcrumb.cart" text="Shopping Cart" /></span>
    </div>
</div>

<div class="cart-page-container" style="max-width: 1200px; margin: 40px auto; padding: 0 20px;">
    <h1 style="margin-bottom: 30px;"><spring:message code="cart.page.title" text="YOUR SHOPPING CART" /></h1>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div style="text-align: center; padding: 60px 20px;">
                <p style="font-size: 18px; color: #666;"><spring:message code="cart.empty" text="Your cart is empty" /></p>
                <a href="${pageContext.request.contextPath}/home.htm" style="display: inline-block; margin-top: 20px; padding: 12px 30px; background: #000; color: #fff; text-decoration: none;"><spring:message code="cart.continue" text="Continue Shopping" /></a>
            </div>
        </c:when>
        <c:otherwise>
            <div style="display: grid; grid-template-columns: 1fr 350px; gap: 40px;">
                <%-- Danh sách items --%>
                <div class="cart-items">
                    <c:forEach var="item" items="${cartItems}">
                        <div style="display: flex; gap: 20px; padding: 20px 0; border-bottom: 1px solid #eee; align-items: center;">
                            <img src="${pageContext.request.contextPath}/images/products/${item.avatarName}"
                                 alt="${item.productName}"
                                 style="width: 100px; height: 100px; object-fit: contain; background: #f5f5f5; padding: 10px;">

                            <div style="flex: 1;">
                                <h3 style="margin: 0 0 5px; font-size: 16px;">${item.productName}</h3>
                                <p style="margin: 0 0 10px; color: #888; font-size: 14px;">${item.variantName}</p>
                                <p style="margin: 0; font-weight: 700; font-size: 18px;">$${item.price}</p>
                            </div>

                            <div style="display: flex; align-items: center; gap: 10px;">
                                <%-- Update quantity form --%>
                                <form action="${pageContext.request.contextPath}/cart/update.htm" method="post" style="display: flex; align-items: center; gap: 8px;">
                                    <input type="hidden" name="cartId" value="${item.cartId}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="99"
                                           style="width: 60px; padding: 8px; border: 1px solid #ddd; text-align: center;">
                                    <button type="submit" style="padding: 8px 16px; background: #333; color: #fff; border: none; cursor: pointer;"><spring:message code="cart.update" text="Update" /></button>
                                </form>

                                <%-- Remove form --%>
                                <form action="${pageContext.request.contextPath}/cart/remove.htm" method="post">
                                    <input type="hidden" name="cartId" value="${item.cartId}">
                                    <button type="submit" style="padding: 8px 16px; background: #fff; color: #e74c3c; border: 1px solid #e74c3c; cursor: pointer;"><spring:message code="cart.remove" text="Remove" /></button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <%-- Order summary --%>
                <div class="cart-summary" style="background: #f9f9f9; padding: 30px; height: fit-content;">
                    <h2 style="margin-top: 0;"><spring:message code="cart.summary.title" text="ORDER SUMMARY" /></h2>
                    <div style="display: flex; justify-content: space-between; margin: 20px 0;">
                        <span><spring:message code="cart.subtotal.label" text="Subtotal" /></span>
                        <span style="font-weight: 700;">$${cartTotal}</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin: 20px 0; padding-top: 20px; border-top: 1px solid #ddd;">
                        <span style="font-size: 18px; font-weight: 700;"><spring:message code="cart.total" text="Total" /></span>
                        <span style="font-size: 18px; font-weight: 700;">$${cartTotal}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout.htm" class="checkout-btn" style="display: block; width: 100%; padding: 15px; background: #000; color: #fff; text-decoration: none; font-size: 16px; text-align: center; margin-top: 20px;"><spring:message code="cart.checkout" text="Checkout" /></a>
                    <a href="${pageContext.request.contextPath}/home.htm" style="display: block; text-align: center; margin-top: 15px; color: #0077c8; text-decoration: none;"><spring:message code="cart.continue" text="Continue Shopping" /></a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
