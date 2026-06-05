<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #eef2f3; display: flex; min-height: 100vh; }
        
        /* SIDEBAR */
        .sidebar {
            width: 240px; background-color: #b8c9c3; padding: 30px 20px;
            display: flex; flex-direction: column; border-right: 1px solid rgba(0,0,0,0.05);
            position: fixed; height: 100vh;
        }
        .logo-area { text-align: center; margin-bottom: 50px; }
        .logo-area svg { width: 60px; height: auto; fill: #000; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a {
            display: flex; align-items: center; gap: 15px; text-decoration: none;
            color: #4a4a4a; font-size: 14px; font-weight: 600; padding: 12px 15px;
            border-radius: 20px; transition: all 0.3s;
        }
        .menu-item a:hover, .menu-item.active a {
            background-color: #ffffffc9; color: #000; box-shadow: 0 4px 10px rgba(0,0,0,0.03);
        }

        /* MAIN CONTENT */
        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; }
        
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .btn-back {
            text-decoration: none; color: #000; font-weight: 600; font-size: 14px;
            display: flex; align-items: center; gap: 8px;
        }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }
        
        .page-title { font-size: 24px; font-weight: 700; margin-bottom: 25px; }

        .form-container {
            background: #fff; padding: 40px; border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }

        .section-title { font-size: 14px; font-weight: 700; color: #8e8e8e; text-transform: uppercase; margin-bottom: 15px; margin-top: 30px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .section-title:first-child { margin-top: 0; }

        .form-group { margin-bottom: 20px; display: flex; flex-direction: column; gap: 8px; }
        .form-row { display: flex; gap: 20px; }
        .form-row .form-group { flex: 1; }
        
        label { font-size: 13px; font-weight: 600; color: #333; }
        .form-control, .form-select {
            padding: 12px 16px; border: 1px solid #e0e0e0; border-radius: 12px;
            font-size: 14px; outline: none; background: #fafafa; transition: 0.3s;
        }
        .form-control:focus, .form-select:focus { border-color: #000; background: #fff; }
        .form-control[readonly] { background: #eee; cursor: not-allowed; }

        .images-grid { display: flex; gap: 15px; margin-bottom: 20px; }
        .image-upload-card {
            border: 1px dashed #cbd5e1; padding: 15px; border-radius: 12px;
            background: #f8fafc; text-align: center; flex: 1; display: flex; flex-direction: column; gap: 10px;
        }
        .image-preview {
            width: 100%; height: 120px; object-fit: cover;
            border-radius: 8px; border: 1px solid #e0e0e0;
            margin-bottom: 8px;
        }
        .image-upload-card label { font-size: 13px; color: #475569; }
        .image-upload-card label.main-img { color: #e74c3c; font-weight: 700; }
        .image-upload-card input[type="file"] { font-size: 12px; }

        .attr-section { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 16px; padding: 25px; margin-top: 20px; }
        
        .variant-row { background: #fff; border: 1px solid #e0e0e0; border-radius: 12px; padding: 15px; margin-bottom: 10px; display: flex; gap: 15px; align-items: center; }
        .variant-row .badge { padding: 6px 12px; border-radius: 8px; font-size: 12px; font-weight: 600; }
        .badge.bg-success { background: #e8f8f0; color: #2ecc71; }
        .badge.bg-danger { background: #ffebeb; color: #e74c3c; }
        .badge.bg-secondary { background: #f0f0f0; color: #666; }

        .btn-add-variant { background: none; border: 1px dashed #000; padding: 8px 15px; border-radius: 8px; font-size: 13px; font-weight: 600; cursor: pointer; display: inline-block; margin-top: 10px; text-decoration: none; color: #000; }
        .btn-add-variant:hover { background: #000; color: #fff; }

        .btn-save {
            background: #000; color: #fff; border-radius: 12px; padding: 15px 30px;
            font-weight: 600; font-size: 15px; border: none; cursor: pointer; margin-top: 30px; transition: 0.3s;
        }
        .btn-save:hover { background: #333; }
    </style>
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">

    <!-- SIDEBAR -->
    <div class="sidebar">
                <div class="logo-area">
            <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" style="width: 60px; height: auto; fill: #000;">
                <path d="M20 70 L35 25 L50 25 L35 70 Z" />
                <path d="M50 70 L65 25 L80 25 L65 70 Z" />
            </svg>
        </div>
        <ul class="menu-list">
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/dashboard.htm"><i class="fa-solid fa-chart-simple"></i> Dashboard</a></li>
            <li class="menu-item active"><a href="${pageContext.request.contextPath}/admin/product/management.htm"><i class="fa-solid fa-box"></i> Products</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/users.htm"><i class="fa-solid fa-users"></i> Users</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/orders.htm"><i class="fa-solid fa-truck"></i> Orders</a></li>
        </ul>
        <div class="logout-container" style="margin-top: auto; padding-top: 20px;">
            <a href="${pageContext.request.contextPath}/logout.htm" style="display: flex; align-items: center; justify-content: center; gap: 10px; text-decoration: none; color: #e74c3c; font-weight: 600; padding: 12px; border-radius: 15px; background: #ffebeb; transition: all 0.3s; width: 100%;">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="topbar">
            <a href="${pageContext.request.contextPath}/admin/product/management.htm" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back to Products</a>
            <div class="admin-profile">
                <span>${sessionScope.user.fullName}</span>
                <i class="fa-solid fa-circle-user" style="font-size: 20px;"></i>
            </div>
        </div>

        <h2 class="page-title">Edit Product #${product.id}</h2>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/product/update.htm" method="POST" enctype="multipart/form-data">
                
                <input type="hidden" name="productId" value="${product.id}">

                <h3 class="section-title">Product Images</h3>
                <div class="images-grid">
                    <c:forEach var="img" items="${product.productImages}">
                        <div class="image-upload-card">
                            <label class="${img.isMain ? 'main-img' : ''}">
                                ${img.isMain ? '★ Main side' : 'Side image'}
                            </label>
                            <img src="${pageContext.request.contextPath}/images/products/${img.imageUrl}" class="image-preview" alt="image">
                            <input type="file" name="${img.isMain ? 'fileMain' : img.imageUrl.contains('right') ? 'fileRight' : img.imageUrl.contains('top') ? 'fileTop' : 'fileBottom'}" class="form-control" accept="image/*">
                            <small style="font-size:11px; color:#999;">Để trống nếu không đổi ảnh</small>
                        </div>
                    </c:forEach>
                    <c:if test="${product.productImages.size() < 2}">
                        <div class="image-upload-card">
                            <label>Right side</label>
                            <div class="image-preview" style="display:flex;align-items:center;justify-content:center;background:#eee;color:#999;font-size:12px;">No image</div>
                            <input type="file" name="fileRight" class="form-control" accept="image/*">
                        </div>
                    </c:if>
                </div>

                <h3 class="section-title">Basic Information</h3>
                <div class="form-group">
                    <label>Tên sản phẩm</label>
                    <input type="text" name="productName" class="form-control" value="${product.productName}" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Danh mục</label>
                        <select name="categoryId" class="form-select" required>
                            <option value="1" ${product.category_id.id == 1 ? 'selected' : ''}>Vợt cầu lông</option>
                            <option value="2" ${product.category_id.id == 2 ? 'selected' : ''}>Giày cầu lông</option>
                            <option value="3" ${product.category_id.id == 3 ? 'selected' : ''}>Quần áo cầu lông</option>
                            <option value="4" ${product.category_id.id == 4 ? 'selected' : ''}>Túi vợt cầu lông</option>
                            <option value="5" ${product.category_id.id == 5 ? 'selected' : ''}>Phụ kiện cầu lông</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Thương hiệu</label>
                        <select name="brandId" class="form-select" required>
                            <option value="1" ${product.brand_id.id == 1 ? 'selected' : ''}>Yonex</option>
                            <option value="2" ${product.brand_id.id == 2 ? 'selected' : ''}>Victor</option>
                            <option value="3" ${product.brand_id.id == 3 ? 'selected' : ''}>Lining</option>
                            <option value="4" ${product.brand_id.id == 4 ? 'selected' : ''}>Mizuno</option>
                            <option value="5" ${product.brand_id.id == 5 ? 'selected' : ''}>Kawasaki</option>
                            <option value="6" ${product.brand_id.id == 6 ? 'selected' : ''}>Venson</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Giá (USD)</label>
                        <input type="number" step="0.01" name="price" class="form-control" value="${product.price}" required>
                    </div>
                    <div class="form-group">
                        <label>Mô tả ngắn</label>
                        <input type="text" name="description" class="form-control" value="${product.description}">
                    </div>
                </div>

                <div class="attr-section">
                    <h3 class="section-title" style="margin-top: 0; border: none; color: #333;"><i class="fa-solid fa-layer-group"></i> KÍCH CỠ & TỒN KHO</h3>
                    
                    <c:forEach var="v" items="${variants}">
                        <div class="variant-row">
                            <input type="hidden" name="variantIds" value="${v.id}">
                            <div class="form-group" style="flex:2; margin-bottom:0;">
                                <label>Tên size/khối lượng</label>
                                <input type="text" name="variantNames" class="form-control" value="${v.variant_name}" required>
                            </div>
                            <div class="form-group" style="flex:1; margin-bottom:0;">
                                <label>Số lượng tồn kho</label>
                                <input type="number" name="stockQuantities" class="form-control" value="${v.stock_quantity}" required>
                            </div>
                            <div style="flex:1; text-align:right; margin-top:20px;">
                                <span class="badge ${v.stock_quantity > 0 ? 'bg-success' : 'bg-danger'}">
                                    ${v.stock_quantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                                </span>
                            </div>
                        </div>
                    </c:forEach>

                    <a href="?id=${product.id}&extraRows=${extraRows + 1}" class="btn-add-variant"><i class="fa-solid fa-plus"></i> Thêm size mới</a>

                    <c:forEach begin="1" end="${extraRows}" var="i">
                        <div class="variant-row" style="border: 1px dashed #2ecc71; margin-top: 15px;">
                            <input type="hidden" name="variantIds" value="">
                            <div class="form-group" style="flex:2; margin-bottom:0;">
                                <label>Tên size mới #${i}</label>
                                <input type="text" name="variantNames" class="form-control" placeholder="Ví dụ: Size 43, 4U G5...">
                            </div>
                            <div class="form-group" style="flex:1; margin-bottom:0;">
                                <label>Số lượng</label>
                                <input type="number" name="stockQuantities" class="form-control" placeholder="0" min="0">
                            </div>
                            <div style="flex:1; text-align:right; margin-top:20px;">
                                <span class="badge bg-secondary">Mới</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${not empty attrs}">
                    <div class="attr-section">
                        <h3 class="section-title" style="margin-top: 0; border: none; color: #333;"><i class="fa-solid fa-tags"></i> THÔNG TIN CHI TIẾT (ATTRIBUTES)</h3>
                        <c:forEach var="attr" items="${attrs}">
                            <c:if test="${attr.attrKey != 'brand_filter' and attr.attrKey != 'weight' and attr.attrKey != 'size_filter' and attr.attrKey != 'cloth_size'}">
                                <div class="form-row mb-3">
                                    <div class="form-group" style="flex:1;">
                                        <label>Thuộc tính</label>
                                        <input type="text" name="attrKeys" class="form-control" value="${attr.attrKey}" readonly>
                                    </div>
                                    <div class="form-group" style="flex:2;">
                                        <label>Giá trị</label>
                                        <input type="text" name="attrValues" class="form-control" value="${attr.attrValue}">
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:if>

                <div style="text-align: right;">
                    <button type="submit" class="btn-save"><i class="fa-solid fa-floppy-disk"></i> LƯU THAY ĐỔI</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>