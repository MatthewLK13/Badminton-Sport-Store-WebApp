<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
header {
    width: 100%;
    padding: 0;
    border-bottom: 1px solid #eee;
    position: relative;
}

.black-top-bar {
    height: 30px;
    background: #000;
    width: 100%;
}

.top-announcement {
    background: #f3f3f3;
    font-size: 11px;
    text-align: center;
    padding: 8px 0;
    border-bottom: 1px solid #e5e5e5;
}

.top-links {
    display: flex;
    justify-content: flex-end;
    gap: 15px;
    font-size: 10px;
    padding: 8px 40px 0 40px;
    color: #666;
}

.top-links a {
    text-decoration: none;
    color: #333;
    font-weight: 500;
}

.navbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 40px 20px 40px;
    position: relative;
}

.logo-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 2px;
}

.logo-container img {
    height: 40px;
}

.logo-text {
    font-weight: 900;
    font-size: 14px;
    letter-spacing: 1px;
}

.nav-center {
    display: flex;
    align-items: center;
    gap: 25px;
    list-style: none;
}

.nav-center a {
    text-decoration: none;
    color: #000;
    font-weight: 700;
    font-size: 12px;
    display: inline-block;
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94), color 0.25s ease;
    will-change: transform;
}

.nav-center a.nav-gray {
    color: #999 !important;
}

.nav-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

@media (max-width: 1024px) {
    .nav-center { display: none; }
}

.search-container {
    display: flex;
    align-items: center;
    background-color: #f1f1f1;
    border: 1px solid transparent;
    border-radius: 4px;
    padding: 6px 12px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.02);
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94), 
                box-shadow 0.3s ease, 
                border-color 0.25s ease, 
                background-color 0.25s ease;
    will-change: transform;
}

.search-container:hover,
.search-container:focus-within {
    background-color: #eaeaea;   
    border-color: #E60012;
    transform: translateY(-3px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
}

.search-container input,
.search-input {
    border: none;
    background: transparent;
    outline: none;
    font-size: 12px;
    width: 150px;
    color: #000000;
}

.search-container i {
    font-size: 12px;
    color: #666;
    cursor: pointer;
}

.action-icons {
    display: flex;
    align-items: center;
    gap: 20px;
}

.action-icons a, 
.cart-icon {
    position: relative;
    font-size: 18px;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    color: #000000 !important;
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94), color 0.25s ease-in-out;
    will-change: transform;
}

.action-icons .fa-bag-shopping {
    font-size: 18px;
    color: #ffffff !important;
    background: none !important;
    -webkit-text-stroke: 1.5px #000000;
    transition: -webkit-text-stroke 0.25s ease-in-out;
}

.action-icons a:hover,
.cart-icon:hover {
    color: #E60012 !important;
    transform: translateY(-4px);
}

.action-icons a:hover .fa-bag-shopping,
.cart-icon:hover .fa-bag-shopping {
    -webkit-text-stroke: 1.5px #E60012;
    color: #ffffff !important;
}

.cart-count {
    position: absolute;
    top: -8px;
    right: -10px;
    width: 18px;
    height: 18px;
    background: red;
    color: white;
    border-radius: 50%;
    font-size: 11px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.cart-sidebar {
    position: fixed;
    top: 0;
    right: -420px;
    width: 400px;
    max-width: 100%;
    height: 100%;
    background: #ffffff;
    z-index: 10000;
    transition: right 0.3s ease-in-out;
    box-shadow: -5px 0 25px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    font-family: 'Inter', sans-serif;
}

.cart-sidebar.active {
    right: 0;
}

.cart-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    opacity: 0;
    visibility: hidden;
    transition: opacity 0.3s, visibility 0.3s;
    z-index: 9999;
}

.cart-overlay.active {
    opacity: 1;
    visibility: visible;
}

.cart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 25px 20px;
    border-bottom: 1px solid #e5e5e5;
}

.cart-header h2 {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    font-size: 20px;
    font-weight: 900;
    letter-spacing: 1px;
    margin: 0;
    color: #000;
}

.close-cart {
    cursor: pointer;
    font-size: 24px;
    color: #666;
    background: none;
    border: none;
}

.cart-body {
    flex: 1;
    overflow-y: auto;
    padding: 0 20px;
}

.cart-item {
    display: flex;
    gap: 15px;
    padding: 20px 0;
    border-bottom: 1px solid #f5f5f5;
}

.cart-item img {
    width: 85px;
    height: 85px;
    object-fit: contain;
    background: #fdfdfd;
    border: 1px solid #f0f0f0;
}

.item-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.item-title-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
}

.item-info h4 {
    font-size: 13px;
    font-weight: 700;
    margin: 0;
    color: #000;
    font-family: 'Inter', sans-serif;
}

.item-price {
    font-size: 13px;
    font-weight: 700;
    color: #000;
}

.item-price-sub {
    font-size: 12px;
    color: #333;
    font-weight: 500;
    margin-top: 2px;
}

.item-meta {
    font-size: 11px;
    color: #767676; 
    font-weight: 400;
    line-height: 1.4;
    margin: 1px 0;
}

.item-controls-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: 10px; 
}

.quantity-selector {
    display: flex;
    align-items: center;
    border: 1px solid #dcdcdc;
    border-radius: 2px;
}

.quantity-selector button {
    background: none;
    border: none;
    width: 28px;
    height: 28px;
    cursor: pointer;
    font-size: 14px;
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
}

.quantity-selector input {
    width: 32px;
    height: 28px;
    text-align: center;
    border: none;
    border-left: 1px solid #dcdcdc;
    border-right: 1px solid #dcdcdc;
    font-size: 12px;
    font-weight: 600;
    color: #000;
    outline: none;
}

.delete-item-btn {
    background: none;
    border: none;
    color: #0066cc;
    cursor: pointer;
    font-size: 14px;
    padding: 5px;
}

.delete-item-btn:hover {
    color: #ff3b30;
}

.cart-footer {
    margin-top: auto;
    padding: 20px;
    border-top: 1px solid #e5e5e5;
    background: #ffffff;
}

.subtotal-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 6px;
}

.subtotal-label {
    font-size: 13px;
    color: #333;
    font-weight: 500;
}

.subtotal-price {
    font-size: 14px;
    font-weight: 700;
    color: #000;
}

.tax-notice {
    font-size: 11px;
    color: #767676;
    margin: 0 0 16px 0;
    text-align: left;
    line-height: 1.4;
}

.checkout-btn {
    width: 100%;
    padding: 15px 0;
    background: #0066cc; 
    color: #ffffff;
    border: none;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
    cursor: pointer;
    display: inline-block;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94), box-shadow 0.3s ease, background 0.2s ease;
    will-change: transform;
}

.checkout-btn:hover {
    background: #0052a3;
    transform: translateY(-4px);
    box-shadow: 0 8px 16px rgba(0, 102, 204, 0.25);
}

.lang-dropdown {
    position: relative;
    display: inline-block;
}

.lang-current {
    cursor: pointer;
    text-decoration: none;
    color: #000;
    font-weight: 700;
    display: inline-flex;
    align-items: center;
    user-select: none;
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
    z-index: 10000;
}

.lang-list.show {
    display: block !important;
}

.lang-list li a {
    color: #333 !important;
    padding: 8px 14px;
    text-decoration: none;
    display: block;
    font-size: 11px;
    text-align: left;
    font-weight: normal;
}

.lang-list li a:hover {
    background-color: #ededed;
    color: #e36009 !important;
}

.goog-te-banner-frame, .goog-te-balloon-frame, .goog-te-banner { display: none !important; }
body { top: 0px !important; }

.wishlist-sidebar {
    position: fixed;
    top: 0;
    right: -420px;
    width: 400px;
    height: 100%;
    background-color: #ffffff;
    box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
    z-index: 10005;
    display: flex;
    flex-direction: column;
    transition: right 0.3s ease-in-out;
}

.wishlist-sidebar.active {
    right: 0;
}

.wishlist-header {
    padding: 20px;
    border-bottom: 1px solid #e5e5e5;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.wishlist-header h2 {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    font-size: 18px;
    font-weight: 800;
    letter-spacing: 1px;
    margin: 0;
    color: #000;
}

.close-wishlist {
    background: none;
    border: none;
    font-size: 28px;
    cursor: pointer;
    color: #000;
}

.wishlist-body {
    flex: 1;
    padding: 20px;
    overflow-y: auto;
}

.wishlist-item {
    display: flex;
    gap: 15px;
    padding-bottom: 20px;
    margin-bottom: 20px;
    border-bottom: 1px solid #f0f0f0;
}

.wishlist-item img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    background-color: #f7f7f7;
}

.w-item-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.w-item-title-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 10px;
}

.w-item-title-row h4 {
    font-size: 13px;
    font-weight: 700;
    color: #000;
    line-height: 1.4;
}

.w-item-price {
    color: #000000;
    font-size: 13px;
    font-weight: 700;
}

.w-item-meta {
    font-size: 11px;
    color: #777;
    margin-top: 4px;
}

.w-item-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}

.btn-add-to-cart-from-w {
    background-color: #0066cc;
    color: #ffffff;
    border: none;
    padding: 6px 12px;
    font-size: 11px;
    font-weight: 700;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94), box-shadow 0.3s ease, background-color 0.2s;
    will-change: transform;
}

.btn-add-to-cart-from-w:hover {
    background-color: #004085;
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.delete-wishlist-item-btn {
    background: none;
    border: none;
    color: #0066cc;
    cursor: pointer;
    font-size: 14px;
    transition: color 0.2s;
}

.delete-wishlist-item-btn:hover {
    color: #e74c3c;
}

.wishlist-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    z-index: 10002;
    display: none;
}

.wishlist-overlay.active {
    display: block;
}

.dropdown-mega {
    position: static;
}

.mega-menu {
    position: absolute;
    top: 100%;
    left: 0;
    width: 100vw;
    background-color: #111111;
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
    z-index: 9999;
    border-top: 1px solid #222;
    opacity: 0;
    visibility: hidden;
    transform: translateY(12px);
    transition: opacity 0.25s ease-in-out, visibility 0.25s ease-in-out, transform 0.25s ease-in-out;
}

.dropdown-mega:hover .mega-menu {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.mega-menu-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 50px;
}

.mega-column h3 {
    font-family: 'Impact', 'Arial Black', sans-serif;
    font-size: 14px;
    letter-spacing: 1.5px;
    color: #ffffff;
    margin-bottom: 20px;
    border-bottom: 1px solid #2c2c2c;
    padding-bottom: 8px;
    font-weight: normal;
}

.mega-column ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.mega-column ul li {
    margin-bottom: 12px;
}

.mega-column ul li a {
    color: #b0b0b0;
    text-decoration: none;
    font-size: 13px;
    font-weight: 300;
    font-family: 'Inter', 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
    display: block;
    transition: color 0.2s ease, transform 0.2s ease;
}

.mega-column ul li a:hover {
    color: #ffffff;
    font-weight: 400;
    transform: translateX(3px);
}

.mega-full-width-top {
    width: 100%;
    border-bottom: 1px solid #222;
    padding-bottom: 20px;
    margin-bottom: 35px;
    text-align: center;
}

.view-all-link {
    color: #888;
    text-decoration: none;
    font-size: 11px;
    font-weight: 400;
    letter-spacing: 2px;
    text-transform: uppercase;
    transition: color 0.2s ease;
}

.view-all-link:hover {
    color: #ffffff;
}

.athlete-grid-menu {
    display: flex;
    justify-content: center;
    gap: 40px;
    width: 100%;
    margin: 0 auto;
}

.athlete-item {
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 220px;
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    will-change: transform;
}

.athlete-img-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    overflow: hidden;
    border-radius: 12px;
    background-color: #1a1a1a;
    margin-bottom: 18px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
    transition: box-shadow 0.3s ease;
}

.athlete-img-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease-in-out;
}

.athlete-item:hover {
    transform: translateY(-8px);
}

.athlete-item:hover .athlete-img-wrapper {
    box-shadow: 0 16px 32px rgba(0, 0, 0, 0.4);
}

.athlete-item:hover .athlete-img-wrapper img {
    transform: scale(1.04);
}

.athlete-info h3 {
    color: #ffffff;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    font-size: 13px;
    font-weight: 600;
    letter-spacing: 1px;
    text-transform: uppercase;
    margin: 0 0 6px 0;
}

.athlete-info a {
    color: #888;
    text-decoration: none;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    font-size: 11px;
    font-weight: 300;
    transition: color 0.2s ease;
    display: inline-block;
}

.athlete-item:hover .athlete-info a {
    color: #ffffff;
    text-decoration: underline;
}

.sales-highlight {
    color: #e74c3c !important;
    font-weight: 700 !important;
    display: inline-block;
}

.sale-menu-layout {
    display: flex !important;
    justify-content: space-between;
    align-items: flex-start;
    gap: 60px;
}

.sale-links-grid {
    flex: 3;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 40px;
}

.sale-banner-card {
    flex: 2;
    background: #1a1a1a;
    border: 1px solid #282828;
    display: flex;
    padding: 15px;
    gap: 20px;
    align-items: center;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94), box-shadow 0.3s ease;
    will-change: transform;
}

.sale-banner-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 24px rgba(0,0,0,0.35);
}

.sale-img-box {
    width: 20px;
    height: 20px;
    background: #252525;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 6px;
    overflow: hidden;
}

.sale-img-box img {
    width: 10%;
    height: 10%;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.sale-banner-card:hover .sale-img-box img {
    transform: scale(1.1) rotate(4deg);
}

.sale-banner-info {
    flex: 1;
}

.sale-banner-info h4 {
    font-family: 'Impact', sans-serif;
    color: #e74c3c;
    font-size: 16px;
    letter-spacing: 1px;
    margin-bottom: 6px;
}

.sale-banner-info p {
    color: #aaa;
    font-size: 12px;
    font-weight: 300;
    line-height: 1.5;
    margin-bottom: 12px;
}

.sale-banner-info a {
    color: #ffffff;
    text-decoration: none;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 1px;
    border-bottom: 1px solid #e74c3c;
    padding-bottom: 2px;
    transition: color 0.2s;
}

.sale-banner-info a:hover {
    color: #e74c3c;
}

.nav-center a:hover {
    transform: translateY(-4px) !important;
    color: #E60012 !important;
    text-shadow: 0 4px 8px rgba(230, 0, 18, 0.15);
}

.nav-center a.sales-highlight:hover {
    color: #e74c3c !important;
    transform: translateY(-4px) !important;
}

.btn-shop-now,
.btn-learn-more,
.product-card,
.spotlight-card,
.explore-now-btn {
    display: inline-block;
    box-shadow: 0 2px 5px rgba(0,0,0,0.06);
    transition: transform 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94),
                box-shadow 0.3s ease,
                background-color 0.2s ease;
    will-change: transform;
}

.btn-shop-now:hover,
.btn-learn-more:hover,
.product-card:hover,
.spotlight-card:hover,
.explore-now-btn:hover {
    transform: translateY(-6px) !important;
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.12) !important;
}
.top-bar-black {
    width: 100%;
    height: 25px; /* Độ cao thanh đen Yonex thường khá mảnh */
    background-color: #000000;
    position: relative;
    top: 0;
    left: 0;
}
</style>
<header>
<div class="top-bar-black"></div>
    <div class="top-links">
        <a href="${pageContext.request.contextPath}/stores.htm">Tìm cửa hàng</a>
        <a href="${pageContext.request.contextPath}/help.htm">Trợ giúp</a>
        <a href="${pageContext.request.contextPath}/order-tracking.htm">Theo dõi đơn hàng</a>
        
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/logout.htm">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.htm">Đăng nhập</a>
            </c:otherwise>
        </c:choose>
        
        <div class="lang-dropdown" style="position: relative; display: inline-block;">
            <a href="javascript:void(0)" class="lang-current trigger-lang" id="lang-trigger-btn">
                <span id="current-lang-text">VI</span>
                <i class="fa-solid fa-chevron-down" style="font-size: 8px; margin-left: 3px;"></i>
            </a>
            
            
            <ul class="lang-list" id="langList">
    <li>
        <a href="javascript:void(0)" class="lang-option" data-lang="VI">Tiếng Việt (VI)</a>
    </li>
    <li>
        <a href="javascript:void(0)" class="lang-option" data-lang="EN">English (EN)</a>
    </li>
</ul>
        </div>

        <div id="google_translate_element" style="display:none !important;"></div>
    </div>

    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/yonex-logo.png" alt="Yonex Logo">
            <span class="logo-text">YONEX</span>
        </div>

        <ul class="nav-center">
    <li><a href="${pageContext.request.contextPath}/">TRANG CHỦ</a></li>
    
    <li class="dropdown-mega">
        <a href="javascript:void(0)">SẢN PHẨM</a>
        
        <div class="mega-menu">
            <div class="mega-menu-container">
                
                <div class="mega-column">
                    <h3>TENNIS</h3>
                    <ul>
                        <li><a href="#">Tất cả Tennis</a></li>
                        <li><a href="#">Vợt Tennis</a></li>
                        <li><a href="#">Dây cước</a></li>
                        <li><a href="#">Bóng tennis</a></li>
                        <li><a href="#">Quần áo</a></li>
                        <li><a href="#">Giày Tennis</a></li>
                        <li><a href="#">Phụ kiện</a></li>
                    </ul>
                </div>

                <div class="mega-column">
                    <h3>BADMINTON</h3>
                    <ul>
                        <li><a href="#">Tất cả Badminton</a></li>
                        <li><a href="#">Vợt Cầu Lông</a></li>
                        <li><a href="#">Dây cước</a></li>
                        <li><a href="#">Quả cầu lông</a></li>
                        <li><a href="#">Quần áo</a></li>
                        <li><a href="#">Giày Cầu Lông</a></li>
                        <li><a href="#">Phụ kiện</a></li>
                    </ul>
                </div>

                <div class="mega-column">
                    <h3>PICKLEBALL</h3>
                    <ul>
                        <li><a href="#">Vợt Pickleball</a></li>
                        <li><a href="#">Quần áo</a></li>
                        <li><a href="#">Giày</a></li>
                    </ul>
                </div>

                <div class="mega-column">
                    <h3>SNOWBOARDING</h3>
                    <ul>
                        <li><a href="#">Ván trượt tuyết</a></li>
                        <li><a href="#">Phụ kiện</a></li>
                    </ul>
                </div>

            </div>
        </div>
    </li>
    <li class="dropdown-mega">
    <a href="javascript:void(0)">ATHLETE INSPIRED</a>
    
    <div class="mega-menu">
        <div class="mega-menu-container">
            <div class="mega-full-width-top">
                <a href="#" class="view-all-link">TẤT CẢ VẬN ĐỘNG VIÊN <i class="fa-solid fa-chevron-right" style="font-size: 9px; margin-left: 5px;"></i></a>
            </div>

            <div class="athlete-grid-menu">
    <div class="athlete-item">
        <div class="athlete-img-wrapper">
            <img src="${pageContext.request.contextPath}/images/image10.png" alt="An Se-young">
        </div>
        <div class="athlete-info">
            <h3>AN SE-YOUNG</h3>
            <a href="${pageContext.request.contextPath}/athlete/an-se-young.htm" class="view-profile-btn">Xem hồ sơ</a>
        </div>
    </div>

    <div class="athlete-item">
        <div class="athlete-img-wrapper">
            <img src="${pageContext.request.contextPath}/images/image11.png" alt="Kento Momota">
        </div>
        <div class="athlete-info">
            <h3>KENTO MOMOTA</h3>
            <a href="${pageContext.request.contextPath}/athlete/kento-momota.htm" class="view-profile-btn">Xem hồ sơ</a>
        </div>
    </div>

    <div class="athlete-item">
        <div class="athlete-img-wrapper">
            <img src="${pageContext.request.contextPath}/images/image12.png" alt="Seo Seung-jae">
        </div>
        <div class="athlete-info">
            <h3>SEO SEUNG-JAE</h3>
            <a href="${pageContext.request.contextPath}/athlete/seo-chae.htm" class="view-profile-btn">Xem hồ sơ</a>
        </div>
    </div>

    <div class="athlete-item">
        <div class="athlete-img-wrapper">
            <img src="${pageContext.request.contextPath}/images/image17.png" alt="Kim Won Ho">
        </div>
        <div class="athlete-info">
            <h3>KIM WON HO</h3>
            <a href="${pageContext.request.contextPath}/athlete/seo-chae.htm" class="view-profile-btn">Xem hồ sơ</a>
        </div>
    </div>
</div>
</div>
</div>
</li>
   <li class="dropdown-mega">
    <a href="javascript:void(0)" class="nav-gray">CÁC THƯƠNG HIỆU</a>
    <div class="mega-menu">
        <div class="mega-menu-container">
            <div class="mega-column">
                <h3>TENNIS SERIES</h3>
                <ul>
                    <li><a href="#">EZONE (Sức mạnh kiểm soát)</a></li>
                    <li><a href="#">VCORE (Xoáy tối đa)</a></li>
                    <li><a href="#">PERCEPT (Kiểm soát chính xác)</a></li>
                    <li><a href="#">ASTREL (Thoải mái và Trợ lực)</a></li>
                </ul>
            </div>
            <div class="mega-column">
                <h3>BADMINTON SERIES</h3>
                <ul>
                    <li><a href="#">ASTROX (Tấn công uy lực)</a></li>
                    <li><a href="#">NANOFLARE (Tốc độ phản tạt)</a></li>
                    <li><a href="#">ARCSABER (Điều cầu bền bỉ)</a></li>
                    <li><a href="#">DUORA (Tối ưu hai mặt vợt)</a></li>
                </ul>
            </div>
            <div class="mega-column">
                <h3>FOOTWEAR TECH</h3>
                <ul>
                    <li><a href="#">POWER CUSHION +</a></li>
                    <li><a href="#">AERUS Z (Siêu nhẹ)</a></li>
                    <li><a href="#">ECLIPSION (Ổn định tối đa)</a></li>
                    <li><a href="#">SONICAGE (Tốc độ linh hoạt)</a></li>
                </ul>
            </div>
            <div class="mega-column">
                <h3>LIMITED COLLECTIONS</h3>
                <ul>
                    <li><a href="#">YONEX x Peter Gade</a></li>
                    <li><a href="#">Lin Dan Exclusive Edition</a></li>
                    <li><a href="#">Lee Chong Wei L.E. Pack</a></li>
                </ul>
            </div>
        </div>
    </div>
</li>

<li class="dropdown-mega">
    <a href="javascript:void(0)" class="nav-gray sales-highlight">SALES</a>
    <div class="mega-menu">
        <div class="mega-menu-container sale-menu-layout">
            <div class="sale-links-grid">
                <div class="mega-column">
                    <h3>HOT DEALS</h3>
                    <ul>
                        <li><a href="#" style="color: #e74c3c; font-weight: 600;">Xả Kho Giảm Đến 50%</a></li>
                        <li><a href="#">Sản phẩm Bán Chạy Ưu Đãi</a></li>
                        <li><a href="#">Combo Vợt Và Phụ Kiện</a></li>
                        <li><a href="#">Quần Áo Đồng Giá $19.00</a></li>
                    </ul>
                </div>
                <div class="mega-column">
                    <h3>SHOP BY DISCOUNT</h3>
                    <ul>
                        <li><a href="#">Giảm giá từ 30% trở lên</a></li>
                        <li><a href="#">Giảm giá từ 20% trở lên</a></li>
                        <li><a href="#">Hàng Outlet lẻ size</a></li>
                        <li><a href="#">Mã Coupon tuần này</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="sale-banner-card">
                <div class="sale-img-box">
                    <img src="${pageContext.request.contextPath}/images/image6.png" alt="Yonex Sale Banner">
                </div>
                <div class="sale-banner-info">
                    <h4>END OF SEASON SALE</h4>
                    <p>Cơ hội sở hữu siêu phẩm Astrox và Ezone với mức giá tốt nhất trong năm.</p>
                    <a href="#">MUA NGAY <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </div>
</li>
</ul>

        <div class="nav-right">
            <div class="search-container">
    <input type="text" id="search-input" placeholder="Tìm kiếm" onkeypress="handleSearchKeyPress(event)">
    <i class="fa-solid fa-magnifying-glass" id="search-submit-btn" onclick="executeSearch()"></i>
</div>
            <div class="action-icons">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/profile.htm" title="Trang cá nhân">
                            <i class="fa-regular fa-user" style="color: #e36009;"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.htm" title="Đăng nhập">
                            <i class="fa-regular fa-user"></i>
                        </a>
                    </c:otherwise>
                </c:choose>

                <%-- Wishlist link --%>
                <a href="${pageContext.request.contextPath}/wishlist.htm" title="Yêu thích" style="position:relative;">
                    <i class="fa-solid fa-heart"></i>
                    <c:if test="${sessionScope.wishlistCount != null && sessionScope.wishlistCount > 0}">
                        <span style="position:absolute; top:-8px; right:-8px;
                            background:#e36009; color:#fff; border-radius:50%; width:18px; height:18px;
                            font-size:11px; display:flex; align-items:center; justify-content:center;">
                            ${sessionScope.wishlistCount}
                        </span>
                    </c:if>
                </a>

                <%-- Cart link --%>
                <a href="${pageContext.request.contextPath}/cart.htm" title="Giỏ hàng" style="position:relative;">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <c:if test="${sessionScope.cartCount != null && sessionScope.cartCount > 0}">
                        <span style="position:absolute; top:-8px; right:-8px;
                            background:#e36009; color:#fff; border-radius:50%; width:18px; height:18px;
                            font-size:11px; display:flex; align-items:center; justify-content:center;">
                            ${sessionScope.cartCount}
                        </span>
                    </c:if>
                </a>
            </div>
            
            <div id="wishlist-sidebar" class="wishlist-sidebar">
                <div class="wishlist-header">
                    <h2>SẢN PHẨM YÊU THÍCH (<span id="wishlist-count">2</span>)</h2>
                    <button id="close-wishlist-btn" class="close-wishlist">&times;</button>
                </div>
                <div class="wishlist-body">
                    <div id="wishlist-items-list">
                        <div class="wishlist-item">
                            <img src="${pageContext.request.contextPath}/images/image6.png" alt="Astrox 99 Pro">
                            <div class="w-item-info">
                                <div class="w-item-title-row">
                                    <h4>ASTROX 99 PRO GEN 3</h4>
                                    <span class="w-item-price">$305.00</span>
                                </div>
                                <div class="w-item-meta">Màu: CHERRY SUNBURST</div>
                                <div class="w-item-controls">
                                    <button type="button" class="btn-add-to-cart-from-w">
                                        <i class="fa-solid fa-bag-shopping"></i> THÊM VÀO GIỎ
                                    </button>
                                    <button type="button" class="delete-wishlist-item-btn" title="Xóa khỏi danh sách">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="wishlist-item">
                            <img src="${pageContext.request.contextPath}/images/image7.png" alt="Tournament Shirt">
                            <div class="w-item-info">
                                <div class="w-item-title-row">
                                    <h4>BREAKPOINT TOURNAMENT SHIRT</h4>
                                    <span class="w-item-price">$111.00</span>
                                </div>
                                <div class="w-item-meta">Màu: NAVY BLUE</div>
                                <div class="w-item-controls">
                                    <button type="button" class="btn-add-to-cart-from-w">
                                        <i class="fa-solid fa-bag-shopping"></i> THÊM VÀO GIỎ
                                    </button>
                                    <button type="button" class="delete-wishlist-item-btn" title="Xóa khỏi danh sách">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="wishlist-overlay" class="wishlist-overlay"></div>

            <div id="cart-sidebar" class="cart-sidebar">
                <div class="cart-header">
                    <h2>YOUR CART</h2>
                    <button id="close-cart-btn" class="close-cart">&times;</button>
                </div>
                <div class="cart-body">
                    <div id="cart-items-list">
                        <div class="cart-item">
                            <img src="${pageContext.request.contextPath}/images/image6.png" alt="SUBAXIA GT (MENS)">
                            <div class="item-info">
                                <div class="item-title-row">
                                    <h4>MUSE 100</h4>
                                    <span class="item-price">$305.00</span>
                                </div>
                                <div class="item-price-sub">$305.00</div>
                                <div class="item-meta">Color: PEARL SILVER</div>
                                <div class="item-meta">Size: G1</div>
                                <div class="item-controls-row">
                                    <div class="quantity-selector">
                                        <button type="button" class="minus-btn">-</button>
                                        <input type="text" value="1" readonly>
                                        <button type="button" class="plus-btn">+</button>
                                    </div>
                                    <button type="button" class="delete-item-btn">
                                        <i class="fa-regular fa-trash-can"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="cart-footer">
                    <div class="subtotal-row">
                        <span class="subtotal-label">Subtotal</span>
                        <span id="cart-subtotal" class="subtotal-price">$305.00 USD</span>
                    </div>
                    <p class="tax-notice">Taxes, discounts and shipping calculated at checkout.</p>
                    <button type="button" class="checkout-btn">CHECKOUT</button>
                </div>
            </div>
            <div id="cart-overlay" class="cart-overlay"></div>
        </div>
    </div>
      
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
   
    <script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
    
    const currentLangText = document.getElementById("current-lang-text");
    const savedLang = localStorage.getItem('selected_lang');
    
   
    if (currentLangText) {
        currentLangText.innerText = savedLang || "VI";
    }

    
    const langOptions = document.querySelectorAll('.lang-option');
    langOptions.forEach(option => {
        option.addEventListener('click', function(e) {
            e.preventDefault();
            const lang = this.getAttribute('data-lang');
            localStorage.setItem('selected_lang', lang);
            location.reload(); 
        });
    });

   
    const langTrigger = document.getElementById("lang-trigger-btn");
    const langList = document.getElementById("langList");
    if (langTrigger && langList) {
        langTrigger.addEventListener("click", function(e) {
            e.stopPropagation();
            langList.classList.toggle("show");
        });
    }

    document.addEventListener("click", function(e) {
        if (langList && langList.classList.contains("show")) {
            langList.classList.remove("show");
        }
    });
        
        const cartBtn = document.getElementById("cart-btn");
        const cartSidebar = document.getElementById("cart-sidebar"); 
        const closeCartBtn = document.getElementById("close-cart-btn");
        const cartOverlay = document.getElementById("cart-overlay");

        const wishlistBtn = document.getElementById("wishlist-btn");
        const wishlistSidebar = document.getElementById("wishlist-sidebar");
        const closeWishlistBtn = document.getElementById("close-wishlist-btn");
        const wishlistOverlay = document.getElementById("wishlist-overlay");

        
        if (cartBtn && cartSidebar) {
            cartBtn.addEventListener("click", function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                if(wishlistSidebar) wishlistSidebar.classList.remove("active");
                if(wishlistOverlay) wishlistOverlay.classList.remove("active");

                cartSidebar.classList.add("active");
                if(cartOverlay) cartOverlay.classList.add("active");
            });
        }

        if (closeCartBtn) {
            closeCartBtn.addEventListener("click", function(e) {
                e.stopPropagation();
                if(cartSidebar) cartSidebar.classList.remove("active");
                if(cartOverlay) cartOverlay.classList.remove("active");
            });
        }

        if (cartOverlay) {
            cartOverlay.addEventListener("click", function() {
                if(cartSidebar) cartSidebar.classList.remove("active");
                if(cartOverlay) cartOverlay.classList.remove("active");
            });
        }

       
        if (wishlistBtn && wishlistSidebar) {
            wishlistBtn.addEventListener("click", function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                if(cartSidebar) cartSidebar.classList.remove("active");
                if(cartOverlay) cartOverlay.classList.remove("active");

                wishlistSidebar.classList.add("active");
                if (wishlistOverlay) wishlistOverlay.classList.add("active");
            });
        }

        if (closeWishlistBtn) {
            closeWishlistBtn.addEventListener("click", function(e) {
                e.stopPropagation();
                if (wishlistSidebar) wishlistSidebar.classList.remove("active");
                if (wishlistOverlay) wishlistOverlay.classList.remove("active");
            });
        }

        if (wishlistOverlay) {
            wishlistOverlay.addEventListener("click", function() {
                if (wishlistSidebar) wishlistSidebar.classList.remove("active");
                if (wishlistOverlay) wishlistOverlay.classList.remove("active");
            });
        }
    }, 0); 

    </script>
   <script type="text/javascript">
    function executeSearch() {
        var searchInput = document.getElementById("search-input");
        
        if (searchInput) {
            var keyword = searchInput.value.trim();
            
            if (keyword !== "") {
                
                var encodedKeyword = encodeURIComponent(keyword);
                
                
                var contextPath = "${pageContext.request.contextPath}";
                
                
                window.location.href = contextPath + "/products.htm?search=" + encodedKeyword;
            } else {
                
                searchInput.focus();
            }
        }
    }

    
    function handleSearchKeyPress(event) {
        if (event.key === "Enter" || event.keyCode === 13) {
            event.preventDefault(); 
            executeSearch();       
        }
    }
</script>
</header> 