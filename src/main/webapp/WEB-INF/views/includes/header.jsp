<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<header>
    <div class="top-links">
        <a href="${pageContext.request.contextPath}/home.htm">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/order/history.htm">Theo dõi đơn hàng</a>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/logout.htm">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.htm">Đăng nhập</a>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/yonex-logo.png" alt="Yonex Logo">
            <span class="logo-text">YONEX</span>
        </div>

        <ul class="nav-center">
            <li><a href="${pageContext.request.contextPath}/home.htm">TRANG CHỦ</a></li>

            <li class="dropdown-mega">
                <a href="#">SẢN PHẨM</a>

                <div class="mega-menu">
                    <div class="mega-menu-container">

                        <div class="mega-column">
                            <h3><a href="${pageContext.request.contextPath}/products/index.htm?id=1">VỢT CẦU LÔNG</a></h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=2&brand=Yonex">Giày cầu lông Yonex</a></li>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=2&brand=Victor">Giày cầu lông Victor</a></li>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=2&brand=Lining">Giày cầu lông Lining</a></li>
                            </ul>
                        </div>

                        <div class="mega-column">
                            <h3><a href="${pageContext.request.contextPath}/products/index.htm?id=2">GIÀY CẦU LÔNG</a></h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=2&brand=Yonex">Giày cầu lông Yonex</a></li>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=2&brand=Victor">Giày cầu lông Victor</a></li>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=2&brand=Lining">Giày cầu lông Lining</a></li>
                            </ul>
                        </div>

                        <div class="mega-column">
                            <h3><a href="${pageContext.request.contextPath}/products/index.htm?id=3">QUẦN ÁO CẦU LÔNG</a></h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=3&brand=Yonex">Áo cầu lông Yonex</a></li>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=3&brand=Victor">Áo cầu lông Victor</a></li>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=3&brand=Lining">Áo cầu lông Lining</a></li>
                            </ul>
                        </div>

                        <div class="mega-column">
                            <h3><a href="${pageContext.request.contextPath}/products/index.htm?id=4">TÚI VỢT CẦU LÔNG</a></h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=4">Túi vợt</a></li>
                                <li><a href="${pageContext.request.contextPath}/products/index.htm?id=5">Phụ kiện</a></li>
                            </ul>
                        </div>

                        <div class="mega-column">
                            <h3><a href="${pageContext.request.contextPath}/products/index.htm?id=5">CÁC PHỤ KIỆN CẦU LÔNG</a></h3>
                            <ul>
                                <li><a href="#">Phụ kiện cầu lông</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </li>

            <li class="dropdown-mega">
                <a href="#">ATHLETE INSPIRED</a>

                <div class="mega-menu">
                    <div class="mega-menu-container">
                        <div class="mega-full-width-top">
                            <a href="#" class="view-all-link">TẤT CẢ VẬN ĐỘNG VIÊN <i class="fa-solid fa-chevron-right" style="font-size: 9px; margin-left: 5px;"></i></a>
                        </div>

                        <div class="athlete-grid-menu">
                            <div class="athlete-item">
                                <div class="athlete-img-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/homepage/image10.png" alt="An Se-young">
                                </div>
                                <div class="athlete-info">
                                    <h3>AN SE-YOUNG</h3>
                                    <a href="${pageContext.request.contextPath}/athlete/an-se-young.htm" class="view-profile-btn">Xem hồ sơ</a>
                                </div>
                            </div>

                            <div class="athlete-item">
                                <div class="athlete-img-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/homepage/image11.png" alt="Kento Momota">
                                </div>
                                <div class="athlete-info">
                                    <h3>KENTO MOMOTA</h3>
                                    <a href="${pageContext.request.contextPath}/athlete/kento-momota.htm">Xem hồ sơ</a>
                                </div>
                            </div>

                            <div class="athlete-item">
                                <div class="athlete-img-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/homepage/image12.png" alt="Seo Seung-jae">
                                </div>
                                <div class="athlete-info">
                                    <h3>SEO SEUNG-JAE</h3>
                                    <a href="${pageContext.request.contextPath}/athlete/seo-chae.htm">Xem hồ sơ</a>
                                </div>
                            </div>

                            <div class="athlete-item">
                                <div class="athlete-img-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/homepage/image17.png" alt="Kim Won Ho">
                                </div>
                                <div class="athlete-info">
                                    <h3>KIM WON HO</h3>
                                    <a href="#">Xem hồ sơ</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>

            <li class="dropdown-mega">
                <a href="#" class="nav-gray">CÁC THƯƠNG HIỆU</a>
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
                <a href="#" class="nav-gray sales-highlight">SALES</a>
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
                                <img src="${pageContext.request.contextPath}/images/homepage/image6.png" alt="Yonex Sale Banner">
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
                <form action="${pageContext.request.contextPath}/search.htm" method="get">
                    <input type="text" name="q" placeholder="Tìm kiếm" required>
                    <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>
            </div>

            <div class="action-icons">
                <%-- Dark mode toggle --%>
                <button class="dark-mode-toggle" onclick="toggleDarkMode()" title="Chế độ tối" aria-label="Toggle dark mode">
                    <i class="fa-solid fa-moon" id="darkModeIcon"></i>
                </button>

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
                <a href="${pageContext.request.contextPath}/wishlist/index.htm" title="Yêu thích" style="position:relative;">
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
                <a href="${pageContext.request.contextPath}/cart/index.htm" title="Giỏ hàng" style="position:relative;">
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
        </div>
    </div>

    <script>
    // Dark mode toggle
    function toggleDarkMode() {
        document.body.classList.toggle('dark-mode');
        const isDark = document.body.classList.contains('dark-mode');
        localStorage.setItem('darkMode', isDark ? 'true' : 'false');
        updateDarkModeIcon();
    }

    function updateDarkModeIcon() {
        const icon = document.getElementById('darkModeIcon');
        const isDark = document.body.classList.contains('dark-mode');
        if (isDark) {
            icon.className = 'fa-solid fa-sun';
        } else {
            icon.className = 'fa-solid fa-moon';
        }
    }

    // Apply saved dark mode preference on page load
    (function() {
        const savedDarkMode = localStorage.getItem('darkMode');
        if (savedDarkMode === 'true') {
            document.body.classList.add('dark-mode');
        }
        updateDarkModeIcon();
    })();
    </script>
</header>

<%@include file="/WEB-INF/views/includes/chatbot.jsp" %>
