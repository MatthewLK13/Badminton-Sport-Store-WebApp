<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yonex Việt Nam</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/banner.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/athletes.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/spotlight.css">

    <style>
        .top-banner {
            background-color: #f3f3f3;
            color: #000;
            text-align: left; 
            padding: 10px 0 10px 23%; 
            font-size: 12px;
            font-weight: 700;
            width: 100%;
            border-bottom: 1px solid #e5e5e5;
            letter-spacing: 0.5px;
        }
        
        
        .lang-list {
            display: none !important; 
            position: absolute;
            top: 100%;
            right: 0;
            background-color: #ffffff;
            min-width: 120px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.15);
            list-style: none;
            padding: 6px 0;
            margin: 4px 0 0 0;
            border: 1px solid #eee;
            z-index: 10010;
        }

       
        .lang-list.show {
            display: block !important;
        }
        
       
        .trigger-lang {
            cursor: pointer !important;
            user-select: none;
        }

       
        .goog-te-banner-frame, .goog-te-balloon-frame, .goog-te-banner { display: none !important; }
        body { top: 0px !important; }
    </style>
</head>
<body>
    <div class="black-top-bar"></div>

   <%@include file="/WEB-INF/views/includes/header.jsp" %>	

    <div class="top-banner">
        Đơn hàng có thể giao chậm trong các dịp lễ Tết. Mong quý khách thông cảm. Hân hạnh được phục vụ quý khách
    </div>

    <section class="hero-section">
        <div class="hero-content">
            <h2>PLACE FOR ALL MEMBERS</h2>
           <div class="figma-banner-buttons">
        <a href="${pageContext.request.contextPath}/products.htm" class="figma-btn btn-explore">
            KHÁM PHÁ NGAY &nbsp;→
        </a>
        
        <a href="${pageContext.request.contextPath}/khuyen-mai.htm" class="figma-btn btn-buy">
            MUA NGAY &nbsp;→
        </a>
    </div>
        </div>
    </section>

    <div class="banner-footer">
        <h2 class="banner-title">ASTROX 99 PRO GEN 3 - AVAILABLE NOW</h2>
        <p class="banner-subtitle">Smooth swings, full freedom, pure badminton joy.</p>
        <div class="banner-btn-container">
           <a href="${pageContext.request.contextPath}/astrox-99.htm" class="btn-learn-more">
        LEARN MORE
    </a>
        </div>
    </div>
    
   <section class="spotlight-section">
    <h2 class="spotlight-header">SPOTLIGHT CATEGORIES</h2>
    <div class="spotlight-grid">
        
        <div class="spotlight-card">
            <img src="${pageContext.request.contextPath}/images/homepage/image2.png" alt="Isometric">
            <div class="card-content">
                <h3>ISOMETRIC - BIGGER SWEET SPOT</h3>
                <a href="${pageContext.request.contextPath}/category/isometric.htm" class="explore-link">Explore now</a>
            </div>
            <span class="card-sparkle"></span>
        </div>

        <div class="spotlight-card">
            <img src="${pageContext.request.contextPath}/images/homepage/image3.png" alt="From Miles to Match">
            <div class="card-content">
                <h3>FROM MILES TO MATCH - POINT</h3>
                <a href="${pageContext.request.contextPath}/category/shoes-point.htm" class="explore-link">Explore now</a>
            </div>
            <span class="card-sparkle"></span>
        </div>

        <div class="spotlight-card">
            <img src="${pageContext.request.contextPath}/images/homepage/image4.png" alt="Performance Apparel">
            <div class="card-content">
                <h3>PERFORMANCE APPAREL</h3>
                <a href="${pageContext.request.contextPath}/category/apparel-dryknit.htm" class="explore-link">Explore now</a>
            </div>
            <span class="card-sparkle">✦</span>
        </div>
    </div>

    <div class="spotlight-large-banner">
        <img src="${pageContext.request.contextPath}/images/homepage/image5.png" alt="Gear up and go">
        <div class="large-banner-content">
            <h2>GEAR UP AND GO</h2>
            <p>Badminton bags designed to fit all your gear, wherever the game takes you.</p>
            <a href="${pageContext.request.contextPath}/category/bags.htm" class="btn-shop-now">SHOP NOW</a>
        </div>
        <span class="large-banner-sparkle">✦</span>
    </div>
</section>
    
<section class="products-section">
    <h2 class="products-header">NEW ARRIVALS</h2>
    <div class="products-container">
        <div class="products-grid">
            <%-- Vòng lặp lấy danh sách 6 sản phẩm động từ Database --%>
            <c:forEach var="product" items="${products}" varStatus="status">
                <div class="product-card ${status.first ? 'active' : ''}">
                    
                    <%-- SỬA TẠI ĐÂY: Thẻ <div> bọc ngoài, thẻ <a> nằm trong để ôm lấy <img> chuẩn HTML --%>
                    <div class="image-wrapper">
                        <span class="tag-new">NEW</span>
                        <a href="${pageContext.request.contextPath}/products/details.htm?id=${product.id}" style="display: block;">
                            <img src="${pageContext.request.contextPath}/images/products/${product.avatarName}" alt="${product.productName}">
                        </a>
                    </div>

                    <div class="product-info">
                        <%-- Tiêu đề tên sản phẩm chứa link chi tiết --%>
                        <h3 class="product-name">
                            <a href="${pageContext.request.contextPath}/products/details.htm?id=${product.id}">
                                ${product.productName}
                            </a>
                        </h3>

                        <p class="product-cate">
                            <c:choose>
                                <c:when test="${product.category_id.id == 1}">Badminton Racket</c:when>
                                <c:when test="${product.category_id.id == 2}">Badminton Footwear</c:when>
                                <c:otherwise>Badminton Equipment</c:otherwise>
                            </c:choose>
                        </p>
                        
                        <p class="product-price">
                            <c:choose>
                                <c:when test="${product.price > 10000}">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="đ" maxFractionDigits="0" />
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$" maxFractionDigits="2" />
                                </c:otherwise>
                            </c:choose>
                        </p>
                        
                        <div class="color-options">
                            <span class="color-box" style="background-color: #888888;"></span>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <%-- Hiển thị thông báo nếu không tìm thấy sản phẩm nào --%>
            <c:if test="${empty products}">
                <div style="grid-column: span 4; text-align: center; color: #888; padding: 40px; font-style: italic;">
                    Hiện tại chưa có sản phẩm mới nào được cập nhật.
                </div>
            </c:if>
        </div> <%-- Kết thúc thẻ .products-grid --%>
        
    </div> <%-- Kết thúc thẻ .products-container --%>
</section> <%-- Kết thúc thẻ .products-section --%>


<section class="athletes-section">
    <h2 class="athletes-header">FEATURED ATHLETES</h2>
    <div class="athletes-container">
        <div class="athletes-top-row">
            
            <div class="athlete-card">
                <div class="athlete-img-wrapper">
                    <a href="${pageContext.request.contextPath}/athlete/an-se-young.htm" style="display: block;">
                        <img src="${pageContext.request.contextPath}/images/homepage/image10.png" alt="An Se-young" class="img-base">
                        <img src="${pageContext.request.contextPath}/images/homepage/image14.png" alt="An Se-young Hover" class="img-hover">
                    </a>
                </div>
            </div>

            <div class="athlete-card">
                <div class="athlete-img-wrapper">
                    <a href="${pageContext.request.contextPath}/athlete/kento-momota.htm" style="display: block;">
                        <img src="${pageContext.request.contextPath}/images/homepage/image11.png" alt="Kento Momota" class="img-base">
                        <img src="${pageContext.request.contextPath}/images/homepage/image15.png" alt="Kento Momota Hover" class="img-hover">
                    </a>
                </div>
            </div>
            
        </div>

        <div class="athletes-bottom-row">
            <div class="athlete-card large-single">
                <div class="athlete-img-wrapper">
                    <a href="${pageContext.request.contextPath}/athlete/seo-chae.htm" style="display: block;">
                        <img src="${pageContext.request.contextPath}/images/homepage/image12.png" alt="Seo/Chae" class="img-base">
                        <img src="${pageContext.request.contextPath}/images/homepage/image16.png" alt="Seo/Chae Hover" class="img-hover">
                    </a>
                </div>
                <div class="brand-footer">
                    <img src="${pageContext.request.contextPath}/images/homepage/image13.png" alt="Yonex Logo" class="footer-logo">
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>