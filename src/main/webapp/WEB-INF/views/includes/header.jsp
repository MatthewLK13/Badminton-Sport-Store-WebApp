<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Top Black Bar -->
<div class="black-bar"></div>

<!-- Main Header -->
<header>
    <div class="top-links">
        <a href="#">Tìm cửa hàng</a>
        <a href="#">Trợ giúp</a>
        <a href="#">Theo dõi đơn hàng</a>
        <a href="${pageContext.request.contextPath}/login.htm">Đăng nhập</a>
        <a href="#">VI</a>
    </div>

    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/yonex-logo.png" alt="Yonex Logo">
            <span class="logo-text">YONEX</span>
        </div>
        
        <ul class="nav-center">
            <li><a href="#">TRANG CHỦ</a></li>
            <li><a href="#">SẢN PHẨM</a></li>
            <li><a href="#">ATHLETE INSPIRED</a></li>
            <li class="gray"><a href="#">CÁC THƯƠNG HIỆU</a></li>
            <li class="gray"><a href="#">SALES</a></li>
        </ul>

        <div class="nav-right">
            <div class="search-box">
                <input type="text" placeholder="Tìm kiếm">
                <i class="fa-solid fa-magnifying-glass" style="font-size: 10px;"></i>
            </div>
            <div class="icons">
                <i class="fa-regular fa-user"></i>
                <i class="fa-solid fa-heart"></i>
                <i class="fa-solid fa-bag-shopping"></i>
            </div>
        </div>
    </div>
</header>