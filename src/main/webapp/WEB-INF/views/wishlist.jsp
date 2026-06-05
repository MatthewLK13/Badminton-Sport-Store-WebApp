<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><spring:message code="wishlist.title" text="My Wishlist" /> - Yonex</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="breadcrumb-container">
    <div class="breadcrumb-content">
        <a href="${pageContext.request.contextPath}/home.htm"><spring:message code="nav.home" text="Home" /></a>
        <span class="breadcrumb-separator">></span>
        <span class="active"><spring:message code="breadcrumb.wishlist" text="Wishlist" /></span>
    </div>
</div>

<div class="wishlist-page-container" style="max-width: 1200px; margin: 40px auto; padding: 0 20px;">
    <h1 style="margin-bottom: 30px;"><spring:message code="wishlist.page.title" text="MY WISHLIST" /></h1>

    <c:choose>
        <c:when test="${empty wishlistItems}">
            <div style="text-align: center; padding: 60px 20px;">
                <p style="font-size: 18px; color: #666;"><spring:message code="wishlist.empty" text="Your wishlist is empty" /></p>
                <a href="${pageContext.request.contextPath}/home.htm" style="display: inline-block; margin-top: 20px; padding: 12px 30px; background: #000; color: #fff; text-decoration: none;"><spring:message code="wishlist.explore" text="Explore products" /></a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="wishlist-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px;">
                <c:forEach var="item" items="${wishlistItems}">
                    <div class="wishlist-item" style="border: 1px solid #eee; padding: 15px; position: relative;">
                        <%-- Remove from wishlist --%>
                        <form action="${pageContext.request.contextPath}/wishlist/toggle.htm" method="post" style="position: absolute; top: 10px; right: 10px;">
                            <input type="hidden" name="productId" value="${item.id}">
                            <button type="submit" style="background: none; border: none; cursor: pointer; font-size: 20px; color: #888;">&times;</button>
                        </form>

                        <a href="${pageContext.request.contextPath}/products/details.htm?id=${item.id}" style="text-decoration: none; color: inherit;">
                            <img src="${pageContext.request.contextPath}/images/products/${item.avatarName}"
                                 alt="${item.productName}"
                                 style="width: 100%; height: 200px; object-fit: contain; background: #f5f5f5;">
                            <h3 style="margin: 15px 0 10px; font-size: 14px; color: #333;">${item.productName}</h3>
                            <p style="margin: 0 0 10px; font-weight: 700; font-size: 18px;">$${item.price}</p>
                        </a>

                        <%-- Add to cart --%>
                        <c:choose>
                            <c:when test="${item.variantId != null}">
                                <form action="${pageContext.request.contextPath}/wishlist/addToCart.htm" method="post">
                                    <input type="hidden" name="variantId" value="${item.variantId}">
                                    <input type="hidden" name="quantity" value="1">
                                    <button type="submit" style="width: 100%; padding: 10px; background: #0077c8; color: #fff; border: none; cursor: pointer; font-weight: 600;">THÊM VÀO GIỎ</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/products/details.htm?id=${item.id}" style="display: block; text-align: center; padding: 10px; background: #0077c8; color: #fff; text-decoration: none; font-weight: 600;">CHỌN BIẾN THỂ</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
