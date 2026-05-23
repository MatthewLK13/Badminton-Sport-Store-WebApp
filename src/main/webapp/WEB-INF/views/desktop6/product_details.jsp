<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.productName}</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product_details.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%-- BREADCRUMB --%>
<div class="breadcrumb-container">
    <div class="breadcrumb-content">
        <a href="${pageContext.request.contextPath}/home.htm">Trang chủ</a>
        <span class="breadcrumb-separator">></span>
        <a href="${pageContext.request.contextPath}/products/index.htm?id=${product.category_id.id}">
            Cầu lông
        </a>
        <span class="breadcrumb-separator">></span>
        <span class="active">Giày cầu lông Yonex</span>
    </div>
</div>

<%-- MAIN DETAIL LAYOUT --%>
<div class="detail-container">

    <%-- CỘT TRÁI: KHU VỰC HIỂN THỊ ẢNH --%>
    <div class="detail-images">
        <%-- Ảnh chính phía trên --%>
        <div class="main-image-wrapper">
            <img id="mainImage" 
                 src="${pageContext.request.contextPath}/images/products/${product.avatarName}" 
                 alt="Product Image" class="main-image">
        </div>

        <%-- Danh sách ảnh nhỏ nằm ngang phía dưới --%>
        <div class="thumb-list">
            <c:forEach var="img" items="${product.productImages}">
                <div class="thumb-wrapper ${img.isMain ? 'active' : ''}" 
                     onclick="changeImage('${pageContext.request.contextPath}/images/products/${img.imageUrl}', this)">
                    <img src="${pageContext.request.contextPath}/images/products/${img.imageUrl}" alt="thumb" class="thumb-img">
                </div>
            </c:forEach>
            
            <%-- Ảnh giả lập để test hiển thị nếu dữ liệu database chưa có --%>
            <div class="thumb-wrapper active" onclick="changeImage('https://via.placeholder.com/500x500/F5F5F5/000000?text=Giay+1', this)">
                <img src="https://via.placeholder.com/75x75/F5F5F5/000000?text=Giay+1" class="thumb-img">
            </div>
            <div class="thumb-wrapper" onclick="changeImage('https://via.placeholder.com/500x500/EAEAEA/000000?text=Giay+2', this)">
                <img src="https://via.placeholder.com/75x75/EAEAEA/000000?text=Giay+2" class="thumb-img">
            </div>
            <div class="thumb-wrapper" onclick="changeImage('https://via.placeholder.com/500x500/DDDDDD/000000?text=Giay+3', this)">
                <img src="https://via.placeholder.com/75x75/DDDDDD/000000?text=Giay+3" class="thumb-img">
            </div>
        </div>
    </div>

    <%-- CỘT PHẢI: KHU VỰC THÔNG TIN SẢN PHẨM --%>
    <div class="detail-info">
        <div class="info-top-meta">
            <span class="product-category">Giày / Nữ / Cầu lông</span>
            <span class="badge-new">Mới</span>
        </div>

        <h1 class="detail-name">ECLIPSION 5 WOMEN</h1>
        <p class="detail-price">$180.00</p>

        <div class="option-section">
            <span class="option-label">Màu sắc</span>
            <div class="color-picker-list">
                <div class="color-box active" style="background-color: #FF6B35;" title="Cam"></div>
                <div class="color-box" style="background-color: #111111;" title="Đen"></div>
                <div class="color-box" style="background-color: #FFFFFF; border: 1px solid #ccc;" title="Trắng"></div>
            </div>
        </div>

        <div class="option-section">
            <span class="option-label">Kích cỡ</span>
            <div class="size-picker-grid">
                <c:forEach var="variant" items="${product.productVariants}">
                    <div class="size-box ${variant.stock_quantity == 0 ? 'disabled' : ''}" 
                         onclick="selectSize(this, ${variant.id})">
                        ${variant.variant_name}
                    </div>
                </c:forEach>
                
                <%-- Kích cỡ giả lập để test khung lưới chuẩn figma --%>
                <div class="size-box" onclick="selectSize(this)">37</div>
                <div class="size-box" onclick="selectSize(this)">38</div>
                <div class="size-box active" onclick="selectSize(this)">39</div>
                <div class="size-box" onclick="selectSize(this)">40</div>
                <div class="size-box" onclick="selectSize(this)">41</div>
                <div class="size-box disabled">42</div>
                <div class="size-box" onclick="selectSize(this)">43</div>
            </div>
        </div>

        <div class="size-note-box">
            <span class="note-title">Chú ý khi chọn kích cỡ</span>
            <p class="note-desc">Đúng kích cỡ. Chúng tôi khuyên bạn nên đặt theo kích cỡ thông thường.</p>
        </div>

        <div class="actions-wrapper">
            <button class="btn-add-to-cart" onclick="addToCart()">
                Thêm vào giỏ hàng
            </button>
            <button class="btn-wishlist" title="Yêu thích">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                </svg>
            </button>
        </div>
        
        <input type="hidden" id="selectedVariantId" name="variantId" value="">
    </div>
</div>

<script type="text/javascript">
function changeImage(src, el) {
    document.getElementById('mainImage').src = src;
    document.querySelectorAll('.thumb-wrapper').forEach(t => t.classList.remove('active'));
    el.classList.add('active');
}

function selectSize(element, variantId) {
    document.querySelectorAll('.size-box').forEach(box => box.classList.remove('active'));
    element.classList.add('active');
    if(variantId) {
        document.getElementById('selectedVariantId').value = variantId;
    }
}

function addToCart() {
    alert('Đã nhấn nút Thêm vào giỏ hàng thành công!');
}
</script>

</body>
</html>