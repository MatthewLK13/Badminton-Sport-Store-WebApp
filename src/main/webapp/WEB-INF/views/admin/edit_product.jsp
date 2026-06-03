<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product - ${product.productName}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
* { box-sizing: border-box; }
body { background: #f5f5f5; font-family: 'Segoe UI', sans-serif; margin: 0; }

.sidebar {
    width: 220px; min-height: 100vh;
    background: #fff; border-right: 1px solid #e0e0e0;
    position: fixed; top: 0; left: 0;
    display: flex; flex-direction: column; padding: 20px 0;
}
.sidebar .logo { padding: 0 20px 20px; font-weight: 700; font-size: 18px; }
.sidebar a {
    display: flex; align-items: center; gap: 10px;
    padding: 12px 20px; color: #555; text-decoration: none; font-size: 14px;
}
.sidebar a:hover, .sidebar a.active {
    background: #f0f4f0; color: #2e7d32; font-weight: 600;
    border-left: 3px solid #2e7d32;
}

.main-content { margin-left: 220px; padding: 24px; }

.topbar {
    background: #fff; padding: 14px 24px;
    border-radius: 10px; margin-bottom: 24px;
    display: flex; justify-content: space-between; align-items: center;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

.form-card {
    background: #fff; border-radius: 10px;
    padding: 28px; box-shadow: 0 1px 4px rgba(0,0,0,0.06);
    margin-bottom: 20px;
}
.form-card h6 {
    font-weight: 700; color: #334155;
    margin-bottom: 20px; padding-bottom: 10px;
    border-bottom: 1px solid #f0f0f0;
    text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px;
}

.image-preview {
    width: 100%; height: 120px; object-fit: cover;
    border-radius: 8px; border: 1px solid #e0e0e0;
    margin-bottom: 8px;
}
.image-upload-card {
    border: 1px dashed #cbd5e1; padding: 12px;
    border-radius: 10px; background: #f8fafc; text-align: center;
}
.image-upload-card label {
    font-size: 13px; font-weight: 600; color: #475569;
    display: block; margin-bottom: 6px;
}

.variant-row { background: #f8fafc; border-radius: 8px; padding: 12px; margin-bottom: 8px; }
.attr-row { background: #f8fafc; border-radius: 8px; padding: 12px; margin-bottom: 8px; }

.btn-save { background: #000; color: #fff; border-radius: 10px; padding: 12px 32px; font-weight: 600; border: none; }
.btn-save:hover { background: #1e293b; color: #fff; }
</style>
</head>
<body>

<%-- SIDEBAR --%>
<div class="sidebar">
    <div class="logo">🏸 Sport Admin</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard.htm">📊 Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/product/management.htm" class="active">📦 Products</a>
    <a href="${pageContext.request.contextPath}/admin/user/management.htm">👤 Users</a>
    <a href="${pageContext.request.contextPath}/admin/order/management.htm">🚚 Orders</a>
</div>

<div class="main-content">

    <%-- TOPBAR --%>
    <div class="topbar">
        <div class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/admin/product/management.htm"
               class="btn btn-outline-secondary btn-sm">← Back</a>
            <h5 class="mb-0 fw-bold">Edit Product #${product.id}</h5>
        </div>
        <div class="d-flex align-items-center gap-2">
            <span class="text-muted" style="font-size:14px;">Admin</span>
            <div style="width:36px;height:36px;border-radius:50%;background:#2e7d32;
                        color:#fff;display:flex;align-items:center;justify-content:center;
                        font-weight:700;">A</div>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/admin/product/update.htm"
          method="POST" enctype="multipart/form-data">

        <input type="hidden" name="productId" value="${product.id}">

        <%-- ẢNH --%>
        <div class="form-card">
            <h6>📷 Product Images</h6>
            <div class="row g-3">
                <c:forEach var="img" items="${product.productImages}">
                    <div class="col-md-3">
                        <div class="image-upload-card">
                            <label class="${img.isMain ? 'text-danger' : ''}">
                                ${img.isMain ? '★ Main side' : 'Side image'}
                            </label>
                            <img src="${pageContext.request.contextPath}/images/products/${img.imageUrl}"
                                 class="image-preview" alt="${img.imageUrl}">
                            <input type="file"
                                   name="${img.isMain ? 'fileMain' : img.imageUrl.contains('right') ? 'fileRight' : img.imageUrl.contains('top') ? 'fileTop' : 'fileBottom'}"
                                   class="form-control form-control-sm" accept="image/*">
                            <small class="text-muted d-block mt-1">Để trống nếu không đổi ảnh</small>
                        </div>
                    </div>
                </c:forEach>

                <%-- Nếu chưa đủ 4 ảnh thì hiện placeholder --%>
                <c:if test="${product.productImages.size() < 2}">
                    <div class="col-md-3">
                        <div class="image-upload-card">
                            <label>Right side</label>
                            <div class="image-preview d-flex align-items-center justify-content-center bg-light text-muted">No image</div>
                            <input type="file" name="fileRight" class="form-control form-control-sm" accept="image/*">
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <%-- THÔNG TIN CƠ BẢN --%>
        <div class="form-card">
            <h6>📝 Basic Information</h6>
            <div class="row g-3">
                <div class="col-md-12">
                    <label class="form-label fw-semibold">Tên sản phẩm</label>
                    <input type="text" name="productName" class="form-control"
                           value="${product.productName}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Danh mục</label>
                    <select name="categoryId" class="form-select" required>
                        <option value="1" ${product.category_id.id == 1 ? 'selected' : ''}>Vợt cầu lông</option>
                        <option value="2" ${product.category_id.id == 2 ? 'selected' : ''}>Giày cầu lông</option>
                        <option value="3" ${product.category_id.id == 3 ? 'selected' : ''}>Quần áo cầu lông</option>
                        <option value="4" ${product.category_id.id == 4 ? 'selected' : ''}>Túi vợt cầu lông</option>
                        <option value="5" ${product.category_id.id == 5 ? 'selected' : ''}>Phụ kiện cầu lông</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Thương hiệu</label>
                    <select name="brandId" class="form-select" required>
                        <option value="1" ${product.brand_id.id == 1 ? 'selected' : ''}>Yonex</option>
                        <option value="2" ${product.brand_id.id == 2 ? 'selected' : ''}>Victor</option>
                        <option value="3" ${product.brand_id.id == 3 ? 'selected' : ''}>Lining</option>
                        <option value="4" ${product.brand_id.id == 4 ? 'selected' : ''}>Mizuno</option>
                        <option value="5" ${product.brand_id.id == 5 ? 'selected' : ''}>Kawasaki</option>
                        <option value="6" ${product.brand_id.id == 6 ? 'selected' : ''}>Venson</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Giá (USD)</label>
                    <input type="number" step="0.01" name="price" class="form-control"
                           value="${product.price}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Mô tả ngắn</label>
                    <input type="text" name="description" class="form-control"
                           value="${product.description}">
                </div>
            </div>
        </div>

        <%-- VARIANTS --%>
        
<div class="form-card">
    <h6>📦 Kích cỡ & Số lượng tồn kho</h6>
    
    <%-- Variants hiện có --%>
    <c:forEach var="v" items="${variants}">
        <div class="variant-row">
            <div class="row g-2 align-items-center">
                <input type="hidden" name="variantIds" value="${v.id}">
                <div class="col-md-5">
                    <label class="form-label fw-semibold mb-1" style="font-size:12px;">Tên size/khối lượng</label>
                    <input type="text" name="variantNames" class="form-control"
                           value="${v.variant_name}" required>
                </div>
                <div class="col-md-5">
                    <label class="form-label fw-semibold mb-1" style="font-size:12px;">Số lượng tồn kho</label>
                    <input type="number" name="stockQuantities" class="form-control"
                           value="${v.stock_quantity}" required>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <span class="badge ${v.stock_quantity > 0 ? 'bg-success' : 'bg-danger'} w-100 py-2">
                        ${v.stock_quantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                    </span>
                </div>
            </div>
        </div>
    </c:forEach>

    <%-- Divider --%>
    <hr class="my-3">
    <p class="text-muted mb-2" style="font-size:13px;">➕ Thêm size mới (để trống nếu không thêm)</p>

    <%-- New variant rows - để trống id nghĩa là INSERT mới --%>
    <%-- Nút + Thêm size --%>
<a href="?id=${product.id}&extraRows=${extraRows + 1}"
   class="btn btn-outline-primary btn-sm mt-2">+ Thêm size</a>

<%-- Render số ô trống theo extraRows --%>
<c:forEach begin="1" end="${extraRows}" var="i">
    <div class="variant-row border border-dashed border-success mt-2">
        <div class="row g-2 align-items-center">
            <input type="hidden" name="variantIds" value="">
            <div class="col-md-5">
                <label class="form-label fw-semibold mb-1" style="font-size:12px;">
                    Tên size mới #${i}
                </label>
                <input type="text" name="variantNames" class="form-control"
                       placeholder="Ví dụ: Size 43, 4U G5...">
            </div>
            <div class="col-md-5">
                <label class="form-label fw-semibold mb-1" style="font-size:12px;">Số lượng</label>
                <input type="number" name="stockQuantities" class="form-control"
                       placeholder="0" min="0">
            </div>
            <div class="col-md-2 d-flex align-items-end">
                <span class="badge bg-secondary w-100 py-2">Mới</span>
            </div>
        </div>
    </div>
</c:forEach>

</div>

        <%-- ATTRIBUTES --%>
        <c:if test="${not empty attrs}">
            <div class="form-card">
                <h6>🏷 Thông tin chi tiết</h6>
                <c:forEach var="attr" items="${attrs}">
                    <c:if test="${attr.attrKey != 'brand_filter' and attr.attrKey != 'weight'
                                  and attr.attrKey != 'size_filter' and attr.attrKey != 'cloth_size'}">
                        <div class="attr-row">
                            <div class="row g-2 align-items-center">
                                <div class="col-md-4">
                                    <label class="form-label fw-semibold mb-1" style="font-size:12px;">Thuộc tính</label>
                                    <input type="text" name="attrKeys" class="form-control form-control-sm"
                                           value="${attr.attrKey}" readonly>
                                </div>
                                <div class="col-md-8">
                                    <label class="form-label fw-semibold mb-1" style="font-size:12px;">Giá trị</label>
                                    <input type="text" name="attrValues" class="form-control form-control-sm"
                                           value="${attr.attrValue}">
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>

        <%-- SUBMIT --%>
        <div class="d-flex gap-3 justify-content-end">
            <a href="${pageContext.request.contextPath}/admin/product/management.htm"
               class="btn btn-outline-secondary px-4">Hủy</a>
            <button type="submit" class="btn btn-save">💾 Lưu thay đổi</button>
        </div>

    </form>
</div>
</body>
</html>