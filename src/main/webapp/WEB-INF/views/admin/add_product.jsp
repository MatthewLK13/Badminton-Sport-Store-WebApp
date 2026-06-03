<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Add New Product</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background-color: #f3f5f4; padding: 40px 0; font-family: 'Segoe UI', sans-serif; }
.form-container { background: #fff; padding: 40px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
.image-upload-card { border: 1px dashed #cbd5e1; padding: 15px; border-radius: 10px; background: #f8fafc; text-align: center; }
.image-upload-card label { font-size: 14px; font-weight: 600; color: #475569; display: block; margin-bottom: 8px; }
.btn-save { background: #000; color: #fff; border-radius: 12px; padding: 12px; font-weight: 600; font-size: 18px; border: none; }
.btn-save:hover { background: #1e293b; color: #fff; }
.attr-section { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px; margin-top: 16px; }
.attr-section h6 { font-weight: 700; color: #334155; margin-bottom: 14px; letter-spacing: 0.5px; }
.variant-remove-btn { visibility: hidden; }
.variant-row:first-child .variant-remove-btn { }
.variant-row:last-child .variant-remove-btn { visibility: visible; }
</style>
</head>
<body>
<div class="container">
<div class="row justify-content-center">
<div class="col-md-9">
<div class="form-container">
    <h2 class="fw-bold mb-4">Add new products</h2>

    <form action="${pageContext.request.contextPath}/admin/product/save.htm"
          method="POST" enctype="multipart/form-data">

        <%-- ẢNH --%>
        <p class="text-secondary mb-3">Upload images of this product</p>
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="image-upload-card">
                    <label class="text-danger">★ Main side</label>
                    <input type="file" name="fileMain" class="form-control form-control-sm" accept="image/*" required>
                </div>
            </div>
            <div class="col-md-3">
                <div class="image-upload-card">
                    <label>Right side</label>
                    <input type="file" name="fileRight" class="form-control form-control-sm" accept="image/*">
                </div>
            </div>
            <div class="col-md-3">
                <div class="image-upload-card">
                    <label>Top side</label>
                    <input type="file" name="fileTop" class="form-control form-control-sm" accept="image/*">
                </div>
            </div>
            <div class="col-md-3">
                <div class="image-upload-card">
                    <label>Bottom side</label>
                    <input type="file" name="fileBottom" class="form-control form-control-sm" accept="image/*">
                </div>
            </div>
        </div>

        <%-- THÔNG TIN CƠ BẢN --%>
        <div class="mb-3">
            <label class="form-label fw-semibold">Tên sản phẩm</label>
            <input type="text" name="productName" class="form-control" placeholder="Gõ tên sản phẩm..." required>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label fw-semibold">Danh mục</label>
                <select name="categoryId" class="form-select" required>
                    <option value="">-- Chọn danh mục --</option>
                    <option value="1">Vợt cầu lông</option>
                    <option value="2">Giày cầu lông</option>
                    <option value="3">Quần áo cầu lông</option>
                    <option value="4">Túi vợt cầu lông</option>
                    <option value="5">Phụ kiện cầu lông</option>
                </select>
            </div>
            <div class="col-md-6">
    <label class="form-label fw-semibold">Thương hiệu</label>
    <select name="brandId" class="form-select" required>
        <option value="">-- Chọn thương hiệu --</option>
        <option value="1">Yonex</option>
        <option value="2">Victor</option>
        <option value="3">Lining</option>
        <option value="4">Mizuno</option>
        <option value="5">Kawasaki</option>
        <option value="6">Venson</option>
    </select>
</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label class="form-label fw-semibold">Giá (USD)</label>
                <input type="number" step="0.01" name="price" class="form-control" placeholder="Ví dụ: 122.0" required>
            </div>
            <div class="col-md-6">
                <label class="form-label fw-semibold">Mô tả ngắn</label>
                <input type="text" name="description" class="form-control" placeholder="Mô tả..." required>
            </div>
        </div>

        <%-- TIÊU CHÍ ĐỘNG THEO CATEGORY - hiển thị tất cả, server-side sẽ xử lý --%>
        <div class="attr-section">
            <h6>THÔNG TIN CHI TIẾT SẢN PHẨM</h6>
            <div class="row g-3">
                <%-- Vợt cầu lông --%>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Độ cứng đũa</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Cứng</option>
                        <option>Trung bình</option>
                        <option>Mềm</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Swingweight</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Nặng đầu</option>
                        <option>Cân bằng</option>
                        <option>Nhẹ đầu</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Điểm cân bằng</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Head Heavy</option>
                        <option>Even Balance</option>
                        <option>Head Light</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Phong cách chơi</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Tấn công</option>
                        <option>Phòng thủ</option>
                        <option>Toàn diện</option>
                    </select>
                </div>
                <%-- Giày cầu lông --%>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Kiểu bàn chân</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Slim</option>
                        <option>Wide</option>
                        <option>Normal</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Phân khúc</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Cao cấp</option>
                        <option>Trung cấp</option>
                        <option>Phổ thông</option>
                    </select>
                </div>
                <%-- Quần áo --%>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Loại trang phục</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Quần</option>
                        <option>Áo</option>
                    </select>
                </div>
                <%-- Túi --%>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Phù hợp cho</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Nam</option>
                        <option>Nữ</option>
                        <option>Tất cả</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Thể loại túi</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>Đeo ngang vai</option>
                        <option>Đeo trên lưng</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Số ngăn lớn</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option>1 ngăn</option>
                        <option>2 ngăn</option>
                        <option>3 ngăn</option>
                    </select>
                </div>
                <%-- Phụ kiện --%>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Loại phụ kiện</label>
                    <input type="text" name="attrValues" list="accessoryList" class="form-control" placeholder="Chọn hoặc nhập mới...">
                    <datalist id="accessoryList">
                        <option value="Quấn cán">
                        <option value="Quả cầu lông">
                        <option value="Cước căng vợt">
                        <option value="Lót giày">
                        <option value="Băng chặn mồ hôi">
                    </datalist>
                </div>
            </div>
        </div>

        <%-- VARIANTS - Fixed 5 rows, submit all --%>
        <div class="mb-4 mt-4">
            <label class="form-label fw-bold">Kích cỡ & Số lượng tồn kho (để trống dòng không cần thiết)</label>
            <div id="variant-container">
                <c:forEach begin="1" end="5" varStatus="vs">
                <div class="row g-2 mb-2 variant-row">
                    <div class="col-md-6">
                        <input type="text" name="variantNames" class="form-control" placeholder="Ví dụ: Size ${vs.index}">
                    </div>
                    <div class="col-md-4">
                        <input type="number" name="stockQuantities" class="form-control" placeholder="Số lượng">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" name="removeVariant" value="${vs.index}" class="btn btn-outline-danger w-100 variant-remove-btn">✕</button>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>

        <div class="d-grid mt-4">
            <button type="submit" class="btn btn-save">⬇ Save</button>
        </div>
    </form>
</div>
</div>
</div>
</div>
</body>
</html>