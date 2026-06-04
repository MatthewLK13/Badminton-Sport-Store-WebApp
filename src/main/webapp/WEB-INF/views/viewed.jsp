<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm đã xem - Yonex</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .page-title {
            font-size: 28px; font-weight: 700; margin-bottom: 30px;
            color: #333;
        }
        .products-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
        }
        .product-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: #f0f0f0;
        }
        .product-info { padding: 15px; }
        .product-name {
            font-size: 14px; font-weight: 600; color: #333;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .product-price {
            font-size: 16px; font-weight: 700; color: #000;
        }
        .view-link {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 16px;
            background: #333;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
        }
        .view-link:hover { background: #000; }
        .empty-message {
            text-align: center;
            padding: 60px 20px;
            color: #888;
        }
        .empty-message i { font-size: 48px; margin-bottom: 15px; }
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
            color: #333;
            text-decoration: none;
            font-weight: 500;
        }
        .back-link:hover { color: #000; }
    </style>
</head>
<body>

    <div class="container">
        <a href="${pageContext.request.contextPath}/home.htm" class="back-link">
            <i class="fa-solid fa-arrow-left"></i> Quay lại trang chủ
        </a>

        <h1 class="page-title">Sản phẩm đã xem</h1>

        <c:choose>
            <c:when test="${not empty viewedProducts}">
                <div class="products-grid">
                    <c:forEach var="product" items="${viewedProducts}">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}/images/products/${product.avatarName}"
                                 alt="${product.productName}"
                                 class="product-image"
                                 onerror="this.src='${pageContext.request.contextPath}/images/products/placeholder.jpg'">
                            <div class="product-info">
                                <h3 class="product-name">${product.productName}</h3>
                                <p class="product-price">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </p>
                                <a href="${pageContext.request.contextPath}/products/details.htm?id=${product.id}" class="view-link">
                                    Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <i class="fa-regular fa-eye-slash"></i>
                    <p>Bạn chưa xem sản phẩm nào.</p>
                    <p style="margin-top: 10px;">
                        <a href="${pageContext.request.contextPath}/home.htm" style="color: #007aff;">Khám phá sản phẩm</a>
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>
