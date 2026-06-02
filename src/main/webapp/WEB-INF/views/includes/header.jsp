<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Lấy user từ session để kiểm tra đăng nhập
    com.sport.entity.User sessionUser = (com.sport.entity.User) session.getAttribute("user");
    boolean isLoggedIn = (sessionUser != null);
%>

<!-- Top Black Bar -->
<div class="black-bar"></div>

<!-- Main Header -->
<header>
    <div class="top-links">
        <a href="#">Tìm cửa hàng</a>
        <a href="#">Trợ giúp</a>
        <a href="#">Theo dõi đơn hàng</a>

        <% if (isLoggedIn) { %>
            <%-- Đã đăng nhập: hiển thị tên + Đăng xuất --%>
            <a href="${pageContext.request.contextPath}/profile.htm">
                <%= sessionUser.getFullName() %>
            </a>
            <a href="${pageContext.request.contextPath}/logout.htm">Đăng xuất</a>
        <% } else { %>
            <%-- Chưa đăng nhập: hiển thị Đăng nhập --%>
            <a href="${pageContext.request.contextPath}/login.htm">Đăng nhập</a>
        <% } %>

        <a href="#">VI</a>
    </div>

    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/yonex-logo.png" alt="Yonex Logo">
            <span class="logo-text">YONEX</span>
        </div>

        <ul class="nav-center">
            <li><a href="${pageContext.request.contextPath}/home.htm">TRANG CHỦ</a></li>
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
                <%-- Icon user: nếu đã login → vào profile, chưa login → vào login --%>
                <% if (isLoggedIn) { %>
                    <a href="${pageContext.request.contextPath}/profile.htm" style="color: inherit; text-decoration: none;">
                        <i class="fa-solid fa-user" style="color: #e36009;"></i>
                    </a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/login.htm" style="color: inherit; text-decoration: none;">
                        <i class="fa-regular fa-user"></i>
                    </a>
                <% } %>
                <i class="fa-solid fa-heart"></i>
                <i class="fa-solid fa-bag-shopping"></i>
            </div>
        </div>
    </div>
</header>