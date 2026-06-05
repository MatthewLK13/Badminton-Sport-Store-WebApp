<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- Cột tóm tắt đơn hàng bên phải -->
<div class="checkout-summary-section">
    <c:choose>
        <c:when test="${empty cartItems}">
            <p style="text-align: center; color: #666;"><spring:message code="cart.empty" text="Your cart is empty" /></p>
        </c:when>
        <c:otherwise>
            <c:forEach var="item" items="${cartItems}">
                <div class="summary-item">
                    <div class="item-details">
                        <div class="item-img">
                            <img src="${pageContext.request.contextPath}/images/products/${item.avatarName}"
                                 alt="${item.productName}">
                        </div>
                        <div class="item-info">
                            <div class="item-name">${item.productName}</div>
                            <div class="item-variant">${item.variantName}</div>
                            <div class="item-qty">x${item.quantity}</div>
                        </div>
                    </div>
                    <div class="item-price">
                        <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="$" maxFractionDigits="2"/>
                    </div>
                </div>
            </c:forEach>

            <div class="summary-totals">
                <div class="summary-row">
                    <span>Subtotal · ${cartItems.size()} items</span>
                    <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="$" maxFractionDigits="2"/></span>
                </div>
                <div class="summary-row">
                    <span>Shipping</span>
                    <span style="font-size:12px; color:#666;"><spring:message code="checkout.shipping.free" text="Free" /></span>
                </div>
                <div class="summary-row total">
                    <span>Total</span>
                    <span><span style="font-size:11px; color:#777; font-weight:normal; margin-right:8px;">USD</span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="$" maxFractionDigits="2"/></span>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
