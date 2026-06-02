<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<header>
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
    <li><a href="${pageContext.request.contextPath}/home.htm">TRANG CHỦ</a></li>
    
    <li class="dropdown-mega">
        <a href="javascript:void(0)">SẢN PHẨM</a>
        
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
                        <li><a href="#">Ván trượt tuyết</a></li>
                        <li><a href="#">Phụ kiện</a></li>
                    </ul>
                </div>
			<div class="mega-column">
                    <h3><a href="${pageContext.request.contextPath}/products/index.htm?id=5">CÁC PHỤ KIỆN CẦU LÔNG</a></h3>
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
                        <a href="#">Xem hồ sơ</a>
                    </div>
                </div>

                <div class="athlete-item">
                    <div class="athlete-img-wrapper">
                        <img src="${pageContext.request.contextPath}/images/homepage/image12.png" alt="Seo Seung-jae">
                    </div>
                    <div class="athlete-info">
                        <h3>SEO SEUNG-JAE</h3>
                        <a href="#">Xem hồ sơ</a>
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
                <a href="javascript:void(0)" id="wishlist-btn" style="position:relative;">
    <i class="fa-solid fa-heart"></i>
    <span id="wishlistBadge" style="display:none; position:absolute; top:-8px; right:-8px; 
        background:#e36009; color:#fff; border-radius:50%; width:18px; height:18px; 
        font-size:11px; align-items:center; justify-content:center;">0</span>
</a>
<a href="javascript:void(0)" id="cart-btn" style="position:relative;">
    <i class="fa-solid fa-bag-shopping"></i>
    <span id="cartBadge" style="display:none; position:absolute; top:-8px; right:-8px; 
        background:#e36009; color:#fff; border-radius:50%; width:18px; height:18px; 
        font-size:11px; align-items:center; justify-content:center;">0</span>
</a>
            </div>
            
            <div id="wishlist-sidebar" class="wishlist-sidebar">
    <div class="wishlist-header">
        <h2 id="wishlistTitle">SẢN PHẨM YÊU THÍCH (0)</h2>
        <button id="close-wishlist-btn" class="close-wishlist">&times;</button>
    </div>
    <div class="wishlist-body">
        <div id="wishlistItems">
            <%-- Nội dung sẽ được load động bằng JS --%>
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
    <%-- Nội dung load động bằng JS --%>
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
                loadCartItems();
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
                loadWishlistItems();
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
    function openWishlistDrawer() {
        loadWishlistItems();
        document.getElementById('wishlist-sidebar').classList.add('active'); // dùng đúng id
        document.getElementById('wishlist-overlay').classList.add('active');
    }

    function closeWishlistDrawer() {
        document.getElementById('wishlistDrawer').style.right = '-420px';
        document.getElementById('wishlistOverlay').style.display = 'none';
        document.body.style.overflow = '';
    }

    function loadWishlistItems() {
    	fetch('${pageContext.request.contextPath}/api/wishlist/items')
            .then(r => r.json())
            .then(data => {
                var container = document.getElementById('wishlistItems');
                var title = document.getElementById('wishlistTitle');
                title.textContent = 'SẢN PHẨM YÊU THÍCH (' + data.length + ')';
                if (data.length === 0) {
                    container.innerHTML = '<p style="color:#999; text-align:center; margin-top:40px;">Chưa có sản phẩm yêu thích</p>';
                    return;
                }
                var html = '';
                data.forEach(function(item) {
                    html += '<div style="display:flex; gap:16px; padding:16px 0; border-bottom:1px solid #eee; align-items:center;">';
                    html += '<img src="${pageContext.request.contextPath}/images/products/' + item.avatarName + '" style="width:80px; height:80px; object-fit:contain; background:#f5f5f5; border-radius:4px; padding:8px;">';
                    html += '<div style="flex:1;">';
                    html += '<p style="margin:0 0 4px; font-size:13px; font-weight:600;">' + item.productName + '</p>';
                    html += '<p style="margin:0 0 10px; font-size:14px; font-weight:700;">$' + item.price + '</p>';
                    html += '<div style="display:flex; align-items:center; gap:8px;">';
                    html += '<button onclick="addWishlistItemToCart(' + item.variantId + ')" style="display:inline-flex; align-items:center; gap:6px; background:#0077c8; color:#fff; border:none; padding:6px 12px; font-size:12px; font-weight:700; cursor:pointer; border-radius:2px;">';
                    html += '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">';
                    html += '<path d="M19 7H16V6C16 4.93913 15.5786 3.92172 14.8284 3.17157C14.0783 2.42143 13.0609 2 12 2C10.9391 2 9.92172 2.42143 9.17157 3.17157C8.42143 3.92172 8 4.93913 8 6V7H5C4.73478 7 4.48043 7.10536 4.29289 7.29289C4.10536 7.48043 4 7.73478 4 8V19C4 19.7956 4.31607 20.5587 4.87868 21.1213C5.44129 21.6839 6.20435 22 7 22H17C17.7956 22 18.5587 21.6839 19.1213 21.1213C19.6839 20.5587 20 19.7956 20 19V8C20 7.73478 19.8946 7.48043 19.7071 7.29289C19.5196 7.10536 19.2652 7 19 7ZM10 6C10 5.46957 10.2107 4.96086 10.5858 4.58579C10.9609 4.21071 11.4696 4 12 4C12.5304 4 13.0391 4.21071 13.4142 4.58579C13.7893 4.96086 14 5.46957 14 6V7H10V6ZM18 19C18 19.2652 17.8946 19.5196 17.7071 19.7071C17.5196 19.8946 17.2652 20 17 20H7C6.73478 20 6.48043 19.8946 6.29289 19.7071C6.10536 19.5196 6 19.2652 6 19V9H8V10C8 10.2652 8.10536 10.5196 8.29289 10.7071C8.48043 10.8946 8.73478 11 9 11C9.26522 11 9.51957 10.8946 9.70711 10.7071C9.89464 10.5196 10 10.2652 10 10V9H14V10C14 10.2652 14.1054 10.5196 14.2929 10.7071C14.4804 10.8946 14.7348 11 15 11C15.2652 11 15.5196 10.8946 15.7071 10.7071C15.8946 10.5196 16 10.2652 16 10V9H18V19Z" fill="currentColor"/>';
                    html += '</svg>';
                    html += 'THÊM VÀO GIỎ</button>';
                    html += '<button onclick="removeFromWishlist(' + item.id + ')" title="Xóa" style="display:inline-flex; align-items:center; justify-content:center; background:none; border:1px solid #ddd; padding:5px; width:28px; height:28px; cursor:pointer; border-radius:4px; color:#0077c8;">';
                    html += '<svg width="14" height="14" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">';
                    html += '<path d="M3.125 1.25C2.79348 1.25 2.47554 1.3817 2.24112 1.61612C2.0067 1.85054 1.875 2.16848 1.875 2.5V3.75C1.875 4.08152 2.0067 4.39946 2.24112 4.63388C2.47554 4.8683 2.79348 5 3.125 5H3.75V16.25C3.75 16.913 4.01339 17.5489 4.48223 18.0178C4.95107 18.4866 5.58696 18.75 6.25 18.75H13.75C14.413 18.75 15.0489 18.4866 15.5178 18.0178C15.9866 17.5489 16.25 16.913 16.25 16.25V5H16.875C17.2065 5 17.5245 4.8683 17.7589 4.63388C17.9933 4.39946 18.125 4.08152 18.125 3.75V2.5C18.125 2.16848 17.9933 1.85054 17.7589 1.61612C17.5245 1.3817 17.2065 1.25 16.875 1.25H12.5C12.5 0.918479 12.3683 0.600537 12.1339 0.366117C11.8995 0.131696 11.5815 0 11.25 0L8.75 0C8.41848 0 8.10054 0.131696 7.86612 0.366117C7.6317 0.600537 7.5 0.918479 7.5 1.25H3.125Z" fill="currentColor"/>';
                    html += '</svg>';
                    html += '</button>';
                    html += '</div>';
                    html += '</div></div>';
                });
                container.innerHTML = html;
            }).catch(() => {});
    }
    function updateWishlistButtonState(productId, isAdded) {
        var buttons = document.querySelectorAll('.wishlist-btn[data-product-id="' + productId + '"]');

        buttons.forEach(function(btn) {
            var path = btn.querySelector('path');
            if (!path) return;

            if (isAdded) {
                path.setAttribute('fill', '#e36009');
                path.setAttribute('stroke', '#e36009');
            } else {
                path.setAttribute('fill', 'transparent');
                path.setAttribute('stroke', 'black');
            }
        });
    }

    function addWishlistItemToCart(variantId) {
        if (!variantId) {
            alert('Sản phẩm này chưa có biến thể còn hàng để thêm vào giỏ.');
            return;
        }
        addToCart(variantId, 1);
    }

    function removeFromWishlist(productId) {
        fetch('${pageContext.request.contextPath}/api/wishlist/toggle', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'productId=' + productId
        })
        .then(r => r.json())
        .then(data => {
            updateWishlistBadge(data.count);
            updateWishlistButtonState(productId, data.status === 'added');
            loadWishlistItems();
        })
        .catch(() => {});
    }

    function loadWishlistCount() {
    	fetch('${pageContext.request.contextPath}/api/wishlist/count')
            .then(r => r.json())
            .then(data => updateWishlistBadge(data.count))
            .catch(() => {});
    }

    function updateWishlistBadge(count) {
        var badge = document.getElementById('wishlistBadge');
        if (!badge) return;
        if (count > 0) {
            badge.textContent = count;
            badge.style.display = 'flex';
        } else {
            badge.style.display = 'none';
        }
    }

    function toggleWishlist(productId, btn) {
    	fetch('${pageContext.request.contextPath}/api/wishlist/toggle', {
    	    method: 'POST',
    	    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    	    body: 'productId=' + productId
    	})
        .then(r => r.json())
        .then(data => {
            if (data.status === 'login_required') {
                alert('Vui lòng đăng nhập!');
                return;
            }
            updateWishlistButtonState(productId, data.status === 'added');
            updateWishlistBadge(data.count);
        }).catch(() => {});
    }
    function openCartDrawer() {
        loadCartItems();
        document.getElementById('cart-sidebar').classList.add('active'); 
        document.getElementById('cart-overlay').classList.add('active'); 
    }

    function closeCartDrawer() {
        document.getElementById('cartDrawer').style.right = '-480px';
        document.getElementById('cartOverlay').style.display = 'none';
        document.body.style.overflow = '';
    }

    function loadCartItems() {
    	fetch('${pageContext.request.contextPath}/api/cart/items')
            .then(r => r.json())
            .then(data => {
            	var container = document.getElementById('cart-items-list');
            	var footer = document.querySelector('.cart-footer');


                if (data.length === 0) {
                    container.innerHTML = '<p style="color:#999; text-align:center; margin-top:40px;">Giỏ hàng trống</p>';
                    footer.style.display = 'none';
                    return;
                }

                var html = '';
                var total = 0;
                data.forEach(function(item) {
                    total += item.price * item.quantity;
                    html += '<div style="display:flex; gap:16px; padding:16px 0; border-bottom:1px solid #eee; align-items:flex-start;">';
                    html += '<img src="${pageContext.request.contextPath}/images/products/' + item.avatarName + '" style="width:90px; height:90px; object-fit:contain; background:#f5f5f5; border-radius:4px; padding:8px; flex-shrink:0;">';
                    html += '<div style="flex:1;">';
                    html += '<p style="margin:0 0 4px; font-size:14px; font-weight:600; line-height:1.4;">' + item.productName + '</p>';
                    html += '<p style="margin:0 0 8px; font-size:12px; color:#888;">Size: ' + item.variantName + '</p>';
                    html += '<p style="margin:0 0 12px; font-size:15px; font-weight:700;">$' + item.price.toFixed(2) + '</p>';
                    html += '<div style="display:flex; align-items:center; gap:8px;">';
                    html += '<button onclick="updateCart(' + item.cartId + ', ' + (item.quantity - 1) + ')" style="width:28px; height:28px; border:1px solid #ddd; background:#fff; cursor:pointer; font-size:16px; display:flex; align-items:center; justify-content:center;">−</button>';
                    html += '<span style="font-size:14px; font-weight:600; min-width:20px; text-align:center;">' + item.quantity + '</span>';
                    html += '<button onclick="updateCart(' + item.cartId + ', ' + (item.quantity + 1) + ')" style="width:28px; height:28px; border:1px solid #ddd; background:#fff; cursor:pointer; font-size:16px; display:flex; align-items:center; justify-content:center;">+</button>';
                    html += '<button onclick="removeFromCart(' + item.cartId + ')" style="margin-left:auto; background:none; border:none; cursor:pointer; padding:4px; display:flex; align-items:center; justify-content:center;">';
                    html += '<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">';
                    html += '<path d="M3.125 1.25C2.79348 1.25 2.47554 1.3817 2.24112 1.61612C2.0067 1.85054 1.875 2.16848 1.875 2.5V3.75C1.875 4.08152 2.0067 4.39946 2.24112 4.63388C2.47554 4.8683 2.79348 5 3.125 5H3.75V16.25C3.75 16.913 4.01339 17.5489 4.48223 18.0178C4.95107 18.4866 5.58696 18.75 6.25 18.75H13.75C14.413 18.75 15.0489 18.4866 15.5178 18.0178C15.9866 17.5489 16.25 16.913 16.25 16.25V5H16.875C17.2065 5 17.5245 4.8683 17.7589 4.63388C17.9933 4.39946 18.125 4.08152 18.125 3.75V2.5C18.125 2.16848 17.9933 1.85054 17.7589 1.61612C17.5245 1.3817 17.2065 1.25 16.875 1.25H12.5C12.5 0.918479 12.3683 0.600537 12.1339 0.366117C11.8995 0.131696 11.5815 0 11.25 0L8.75 0C8.41848 0 8.10054 0.131696 7.86612 0.366117C7.6317 0.600537 7.5 0.918479 7.5 1.25H3.125ZM6.875 6.25C7.04076 6.25 7.19973 6.31585 7.31694 6.43306C7.43415 6.55027 7.5 6.70924 7.5 6.875V15.625C7.5 15.7908 7.43415 15.9497 7.31694 16.0669C7.19973 16.1842 7.04076 16.25 6.875 16.25C6.70924 16.25 6.55027 16.1842 6.43306 16.0669C6.31585 15.9497 6.25 15.7908 6.25 15.625V6.875C6.25 6.70924 6.31585 6.55027 6.43306 6.43306C6.55027 6.31585 6.70924 6.25 6.875 6.25ZM10 6.25C10.1658 6.25 10.3247 6.31585 10.4419 6.43306C10.5592 6.55027 10.625 6.70924 10.625 6.875V15.625C10.625 15.7908 10.5592 15.9497 10.4419 16.0669C10.3247 16.1842 10.1658 16.25 10 16.25C9.83424 16.25 9.67527 16.1842 9.55806 16.0669C9.44085 15.9497 9.375 15.7908 9.375 15.625V6.875C9.375 6.70924 9.44085 6.55027 9.55806 6.43306C9.67527 6.31585 9.83424 6.25 10 6.25ZM13.75 6.875V15.625C13.75 15.7908 13.6842 15.9497 13.5669 16.0669C13.4497 16.1842 13.2908 16.25 13.125 16.25C12.9592 16.25 12.8003 16.1842 12.6831 16.0669C12.5658 15.9497 12.5 15.7908 12.5 15.625V6.875C12.5 6.70924 12.5658 6.55027 12.6831 6.43306C12.8003 6.31585 12.9592 6.25 13.125 6.25C13.2908 6.25 13.4497 6.31585 13.5669 6.43306C13.6842 6.55027 13.75 6.70924 13.75 6.875Z" fill="black"/>';
                    html += '</svg>';
                    html += '</button>';
                    html += '</div></div></div>';
                });

                container.innerHTML = html;
                document.getElementById('cart-subtotal').textContent = '$' + total.toFixed(2) + ' USD';
                footer.style.display = 'block';
            }).catch(err => console.error('Load cart items error:', err));
    }

    function updateCart(cartId, quantity) {
    	fetch('${pageContext.request.contextPath}/api/cart/update', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'cartId=' + cartId + '&quantity=' + quantity
        })
        .then(r => r.json())
        .then(data => {
            updateCartBadge(data.count);
            loadCartItems();
        }).catch(() => {});
    }

    function removeFromCart(cartId) {
    	fetch('${pageContext.request.contextPath}/api/cart/remove', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'cartId=' + cartId
        })
        .then(r => r.json())
        .then(data => {
            updateCartBadge(data.count);
            loadCartItems();
        }).catch(() => {});
    }

    function loadCartCount() {
    	fetch('${pageContext.request.contextPath}/api/cart/count')
            .then(r => r.json())
            .then(data => updateCartBadge(data.count))
            .catch(() => {});
    }

    function updateCartBadge(count) {
        var badge = document.getElementById('cartBadge');
        if (!badge) return;
        if (count > 0) {
            badge.textContent = count;
            badge.style.display = 'flex';
        } else {
            badge.style.display = 'none';
        }
    }

    function addToCart(variantId, quantity) {
    	fetch('${pageContext.request.contextPath}/api/cart/add', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'variantId=' + variantId + '&quantity=' + (quantity || 1)
        })
        .then(r => r.json())
        .then(data => {
            if (data.status === 'login_required') {
                alert('Vui lòng đăng nhập!');
                return;
            }
            updateCartBadge(data.count);
            openCartDrawer();
        }).catch(() => {});
    }

    document.addEventListener('DOMContentLoaded', function() {
        loadWishlistCount();
        loadCartCount();
    });

    document.addEventListener('DOMContentLoaded', loadWishlistCount);
    
</script>
</header> 