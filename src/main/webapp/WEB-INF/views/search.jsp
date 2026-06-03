<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kết quả tìm kiếm: ${query} - Yonex</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="breadcrumb-container">
    <div class="breadcrumb-content">
        <a href="${pageContext.request.contextPath}/home.htm">Trang chủ</a>
        <span class="breadcrumb-separator">></span>
        <span class="active">Tìm kiếm: ${query}</span>
    </div>
</div>

<div class="search-results-container" style="max-width: 1200px; margin: 40px auto; padding: 0 20px;">
    <h1 style="margin-bottom: 30px;">KẾT QUẢ TÌM KIẾM: "${query}"</h1>

    <c:choose>
        <c:when test="${empty searchResults}">
            <div style="text-align: center; padding: 60px 20px;">
                <p style="font-size: 18px; color: #666;">Không tìm thấy sản phẩm nào phù hợp với "${query}"</p>
                <a href="${pageContext.request.contextPath}/home.htm" style="display: inline-block; margin-top: 20px; padding: 12px 30px; background: #000; color: #fff; text-decoration: none;">Tiếp tục mua sắm</a>
            </div>
        </c:when>
        <c:otherwise>
            <p style="margin-bottom: 20px;">Tìm thấy ${searchResults.size()} sản phẩm</p>

            <div class="products-grid-container">
                <c:forEach var="p" items="${searchResults}">
                    <div class="product-card-wrapper" style="position: relative;">
                        <a href="${pageContext.request.contextPath}/products/details.htm?id=${p.id}"
                           style="text-decoration: none; color: inherit; display:block;">
                            <div class="product-card">
                                <div class="product-image-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/products/${p.avatarName}"
                                         alt="${p.productName}" class="product-img">
                                </div>
                                <div class="product-info">
                                    <span class="product-price">$ ${p.price}</span>
                                    <h3 class="product-name">${p.productName}</h3>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
