<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<meta charset="UTF-8">
<title>Badminton shoes - Yonex</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/banner.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/athletes.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/spotlight.css">
</head>
<body>
    <div class="breadcrumb-container">
        <div class="breadcrumb-content">
            <a href="${pageContext.request.contextPath}/home.htm">Trang chủ</a>
<span class="breadcrumb-separator">></span>

<c:choose>
    <c:when test="${not empty param.brand}">
        <a href="${pageContext.request.contextPath}/products/index.htm?id=${param.id}">
            ${category.categoryName}
        </a>
        <span class="breadcrumb-separator">></span>
        <a href="#" class="active">${category.categoryName} ${param.brand}</a>
    </c:when>

    <c:otherwise>
        <a href="#" class="active">${category.categoryName}</a>
    </c:otherwise>
</c:choose>
        </div>
    </div>

    <div class="category-header-container">
        <div class="category-header-left">
            <h2 class="category-title">${category.categoryName}</h2>
            <p class="category-description">${category.description}</p>
        </div>

        <%-- NÚT FILTERS VÀ SORT nằm bên phải --%>
        <div class="category-header-right">
            <button class="filter-btn" onclick="toggleFilterDrawer()">
                <span>Filters</span>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M19.25 9.537H6.895M2.534 9.537H0.75M2.534 9.537C2.534 8.95883 2.76368 8.40434 3.17251 7.99551C3.58134 7.58668 4.13583 7.357 4.714 7.357C5.29217 7.357 5.84666 7.58668 6.25549 7.99551C6.66432 8.40434 6.894 8.95883 6.894 9.537C6.894 10.1152 6.66432 10.6697 6.25549 11.0785C5.84666 11.4873 5.29217 11.717 4.714 11.717C4.13583 11.717 3.58134 11.4873 3.17251 11.0785C2.76368 10.6697 2.534 10.1152 2.534 9.537ZM19.25 16.144H13.502M13.502 16.144C13.502 16.7223 13.2718 17.2774 12.8628 17.6863C12.4539 18.0953 11.8993 18.325 11.321 18.325C10.7428 18.325 10.1883 18.0943 9.77951 17.6855C9.37068 17.2767 9.141 16.7222 9.141 16.144M13.502 16.144C13.502 15.5657 13.2718 15.0116 12.8628 14.6027C12.4539 14.1937 11.8993 13.964 11.321 13.964C10.7428 13.964 10.1883 14.1937 9.77951 14.6025C9.37068 15.0113 9.141 15.5658 9.141 16.144M9.141 16.144H0.75M19.25 2.93H16.145M11.784 2.93H0.75M11.784 2.93C11.784 2.35183 12.0137 1.79734 12.4225 1.38851C12.8313 0.979678 13.3858 0.75 13.964 0.75C14.2503 0.75 14.5338 0.806387 14.7983 0.915943C15.0627 1.0255 15.3031 1.18608 15.5055 1.38851C15.7079 1.59094 15.8685 1.83126 15.9781 2.09575C16.0876 2.36024 16.144 2.64372 16.144 2.93C16.144 3.21628 16.0876 3.49976 15.9781 3.76425C15.8685 4.02874 15.7079 4.26906 15.5055 4.47149C15.3031 4.67392 15.0627 4.8345 14.7983 4.94406C14.5338 5.05361 14.2503 5.11 13.964 5.11C13.3858 5.11 12.8313 4.88032 12.4225 4.47149C12.0137 4.06266 11.784 3.50817 11.784 2.93Z" stroke="black" stroke-width="1.5" stroke-miterlimit="10" stroke-linecap="round"/>
</svg>

            </button>

            <div class="sort-dropdown-wrapper">
    <button class="sort-btn" onclick="toggleSortMenu()">
        <span id="sortLabel">
            <c:choose>
                <c:when test="${selectedSortBy == 'priceAsc'}">Giá: Thấp đến Cao</c:when>
                <c:when test="${selectedSortBy == 'priceDesc'}">Giá: Cao đến Thấp</c:when>
                <c:when test="${selectedSortBy == 'oldest'}">Cũ nhất</c:when>
                <c:otherwise>Sort by most relevant</c:otherwise>
            </c:choose>
        </span>
        <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M0.160156 5.37891C0.160156 5.21094 0.226563 5.03905 0.355469 4.91014C0.613281 4.65233 1.03516 4.65233 1.29297 4.91014L10.1172 13.7344L18.8125 5.03905C19.0703 4.78123 19.4922 4.78123 19.75 5.03905C20.0078 5.29686 20.0078 5.71873 19.75 5.97655L10.5859 15.1445C10.3281 15.4023 9.90625 15.4023 9.64844 15.1445L0.355469 5.85155C0.222656 5.71873 0.160156 5.55077 0.160156 5.37891Z" fill="black"/>
        </svg>
    </button>

    <div class="sort-menu" id="sortMenu">
        <a href="?id=${category.id}&brand=${selectedBrandName}&minPrice=${minPrice}&maxPrice=${maxPrice}&footType=${selectedFootType}&inStock=${inStockOnly}&sortBy=newest">
            Sort by most relevant
        </a>
        <a href="?id=${category.id}&brand=${selectedBrandName}&minPrice=${minPrice}&maxPrice=${maxPrice}&footType=${selectedFootType}&inStock=${inStockOnly}&sortBy=priceAsc">
            Giá: Thấp đến Cao
        </a>
        <a href="?id=${category.id}&brand=${selectedBrandName}&minPrice=${minPrice}&maxPrice=${maxPrice}&footType=${selectedFootType}&inStock=${inStockOnly}&sortBy=priceDesc">
            Giá: Cao đến Thấp
        </a>
        <a href="?id=${category.id}&brand=${selectedBrandName}&minPrice=${minPrice}&maxPrice=${maxPrice}&footType=${selectedFootType}&inStock=${inStockOnly}&sortBy=oldest">
            Cũ nhất
        </a>
    </div>
</div>
        </div>
    </div><%-- Đóng category-header-container --%>

    <%-- Đặt NGOÀI category-header, fixed vào cạnh phải màn hình --%>
    <div id="filterDrawer" class="filter-drawer">
        <div class="drawer-header">
            <h3>FILTERS</h3>
            <button class="btn-close-drawer" onclick="toggleFilterDrawer()">&times;</button>
        </div>

        <form action="${pageContext.request.contextPath}/products/index.htm" method="GET" class="drawer-body">
            <input type="hidden" name="id" value="${category.id}">

         
            <c:forEach var="filter" items="${dynamicFilters}">
                <div class="filter-section">
                    <%-- Vẽ tiêu đề: Ví dụ "ĐỘ CỨNG ĐŨA", "KIỂU BÀN CHÂN" --%>
                    <h4 class="section-title" style="text-transform: uppercase;">${filter.key}</h4>
                    
                    <%-- Vòng lặp vẽ các giá trị con bên trong bộ lọc đó --%>
                    <c:forEach var="value" items="${filter.value}">
                        <label class="custom-checkbox">
                            <%-- Gửi mảng tham số tên là 'attrs' lên Controller xử lý --%>
                            <input type="checkbox" name="attrs" value="${value}"
                                   ${paramValues.attrs != null && fn:contains(paramValues.attrs, value) ? 'checked' : ''}>
                            <span class="checkmark"></span> ${value}
                        </label>
                    </c:forEach>
                </div>
            </c:forEach>
            
            <div class="filter-section">
                <h4 class="section-title">GIÁ (USD)</h4>
                <div class="price-range">
                    <input type="number" name="minPrice" value="${minPrice}"
                           placeholder="Từ" min="0" class="price-input">
                    <span>—</span>
                    <input type="number" name="maxPrice" value="${maxPrice}"
                           placeholder="Đến" min="0" class="price-input">
                </div>
            </div>
			
        
            <div class="filter-section">
                <h4 class="section-title">TÌNH TRẠNG KHO</h4>
                <label class="custom-checkbox">
                    <input type="checkbox" name="inStock" value="true"
                           ${inStockOnly == true ? 'checked' : ''}>
                    <span class="checkmark"></span> Chỉ hiện sản phẩm còn hàng
                </label>
            </div>

            <div class="drawer-footer">
                <a href="${pageContext.request.contextPath}/products/index.htm?id=${category.id}"
                   class="btn-clear-all">CLEAR ALL</a>
                <button type="submit" class="btn-apply-results">KẾT QUẢ</button>
            </div>
        </form>
    </div>

    <%-- Overlay tối phía sau drawer --%>
    <div id="drawerOverlay" class="drawer-overlay" onclick="toggleFilterDrawer()"></div>

    <div class="products-grid-container">
    <c:forEach items="${products}" var="p">
        
        <%-- Bọc cả card trong div, không dùng <a> bọc toàn bộ --%>
        <div class="product-card-wrapper" style="position: relative;">
            
            <%-- Nút wishlist đặt NGOÀI thẻ <a>, dùng position absolute --%>
            <button class="wishlist-btn"
        data-product-id="${p.id}"
        onclick="toggleWishlist(${p.id}, this)"
        style="position:absolute; top:16px; right:16px; z-index:10; background:transparent; border:none; cursor:pointer;">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path class="heart-path" fill-rule="evenodd" clip-rule="evenodd"
                          d="M19.6431 7.05858C19.6103 4.79858 18.3289 2.57286 16.3617 1.65572C15.3044 1.16162 14.0982 1.09057 12.9903 1.45715C11.9831 1.77715 10.9731 2.43286 10.0003 3.46429C9.02742 2.43286 8.01742 1.77858 7.01028 1.45715C5.90232 1.09057 4.69612 1.16162 3.63885 1.65572C1.67171 2.57286 0.390279 4.79858 0.357422 7.05858V7.07001C0.357422 10.3657 2.31742 13.2857 4.39456 15.3357C5.33754 16.2725 6.38375 17.0992 7.51314 17.8C7.99599 18.0943 8.45171 18.33 8.85599 18.4957C9.24171 18.6529 9.64599 18.7729 10.0003 18.7729C10.3546 18.7729 10.7574 18.6529 11.1431 18.4957C11.5489 18.3314 12.0046 18.0957 12.486 17.8014C13.6159 17.1002 14.6626 16.273 15.606 15.3357C17.6831 13.2857 19.6431 10.3657 19.6431 7.07144V7.05858Z"
                          fill="rgba(0,0,0,0.1)" stroke="black" stroke-width="1.2"/>
                </svg>
            </button>

            <%-- Thẻ <a> chỉ bọc phần nội dung card --%>
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
                        <span class="product-color-title">Màu sắc</span>
                        <div class="product-colors-dots">
                            <span class="color-dot" style="background-color: #D1D1D1;"></span>
                        </div>
                    </div>
                </div>
            </a>

        </div>
    </c:forEach>

    <c:if test="${empty products}">
        <p style="padding: 20px;">Không tìm thấy sản phẩm nào.</p>
    </c:if>
</div>

    <c:if test="${totalPages > 1}">
        <div class="pagination-container" style="display: flex; justify-content: center; align-items: center; margin: 40px 0; gap: 8px;">
            
            <c:if test="${currentPage > 1}">
                <a href="?id=${category.id}&brand=${selectedBrandName}&page=${currentPage - 1}" 
                   style="padding: 8px 16px; border: 1px solid #ddd; color: #000; text-decoration: none; border-radius: 4px;">&laquo; Trước</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${currentPage == i}">
                        <span style="padding: 8px 16px; border: 1px solid #000; background-color: #000; color: #fff; font-weight: bold; border-radius: 4px;">${i}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?id=${category.id}&brand=${selectedBrandName}&page=${i}" 
                           style="padding: 8px 16px; border: 1px solid #ddd; color: #000; text-decoration: none; border-radius: 4px;">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="?id=${category.id}&brand=${selectedBrandName}&page=${currentPage + 1}" 
                   style="padding: 8px 16px; border: 1px solid #ddd; color: #000; text-decoration: none; border-radius: 4px;">Sau &raquo;</a>
            </c:if>
            
        </div>
    </c:if>


    <div class="category-description-section" style="max-width: 1600px; margin: 50px auto; padding: 0 20px; font-family: 'Inter', sans-serif; color: #333; line-height: 1.8;">
        
        <c:if test="${not empty category.longDescription}">
            <p class="description-lead" style="font-size: 16px; font-weight: 500; margin-bottom: 25px; color: #555;">
                ${category.longDescription}
            </p>
        </c:if>
        
        <c:if test="${not empty category.longTitle}">
            <h3 style="font-size: 22px; font-weight: 700; margin-top: 30px; margin-bottom: 15px; color: #000;">
                ${category.longTitle}
            </h3>
        </c:if>

        <c:if test="${not empty category.longContent}">
            <p style="font-size: 15px; text-align: justify; margin-bottom: 15px;">
                ${category.longContent}
            </p>
        </c:if>
        
    </div> 
    
    <script>
    function toggleWishlist(productId, btn) {
        console.log('Clicking wishlist for product:', productId);
        
        fetch('${pageContext.request.contextPath}/api/wishlist/toggle', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'productId=' + productId
        })
        .then(r => {
            console.log('Response status:', r.status);
            return r.json();
        })
        .then(data => {
            console.log('Response data:', data);
            if (data.status === 'login_required') {
                alert('Vui lòng đăng nhập!');
                return;
            }
            // Đổi màu trái tim
            updateWishlistButtonState(productId, data.status === 'added');
            updateWishlistBadge(data.count);
        })
        .catch(err => console.error('Error:', err));
    }
function toggleFilterDrawer() {
    document.getElementById('filterDrawer').classList.toggle('open');
    document.getElementById('drawerOverlay').classList.toggle('open');
    document.body.style.overflow = 
        document.getElementById('filterDrawer').classList.contains('open') 
        ? 'hidden' : '';
}
</script>
<script>
function toggleSortMenu() {
    document.getElementById('sortMenu').classList.toggle('open');
}

// Click ra ngoài thì đóng menu
document.addEventListener('click', function(e) {
    const wrapper = document.querySelector('.sort-dropdown-wrapper');
    if (wrapper && !wrapper.contains(e.target)) {
        document.getElementById('sortMenu').classList.remove('open');
    }
});
</script>
</body>
</html>