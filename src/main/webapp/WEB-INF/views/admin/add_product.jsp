<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Add New Product</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
body { background-color: #f3f5f4; padding: 40px 0; font-family: 'Segoe UI', sans-serif; }
.form-container { background: #fff; padding: 40px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
.image-upload-card { border: 1px dashed #cbd5e1; padding: 15px; border-radius: 10px; background: #f8fafc; text-align: center; }
.image-upload-card label { font-size: 14px; font-weight: 600; color: #475569; display: block; margin-bottom: 8px; }
.btn-save { background: #000; color: #fff; border-radius: 12px; padding: 12px; font-weight: 600; font-size: 18px; border: none; }
.btn-save:hover { background: #1e293b; color: #fff; }
.attr-section { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px; margin-top: 16px; }
.attr-section h6 { font-weight: 700; color: #334155; margin-bottom: 14px; letter-spacing: 0.5px; }
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

        <%-- THUỘC TÍNH CỤ THỂ CHO VỢT CẦU LÔNG --%>
        <div class="attr-section">
            <h6><i class="fa-solid fa-table-cells"></i> THÔNG SỐ VỢT CẦU LÔNG</h6>
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Trọng lượng (U)</label>
                    <select name="attrValues" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option value="2U (90-94g)">2U (90-94g)</option>
                        <option value="3U (85-89g)">3U (85-89g)</option>
                        <option value="4U (80-84g)">4U (80-84g)</option>
                        <option value="5U (75-79g)">5U (75-79g)</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Mức căng tối đa</label>
                    <select name="attrKeys" class="form-select">
                        <option value="">-- Chọn --</option>
                        <option value="15-16kg">15-16kg</option>
                        <option value="17-18kg">17-18kg</option>
                        <option value="19-20kg">19-20kg</option>
                        <option value="21-22kg">21-22kg</option>
                        <option value="23-24kg">23-24kg</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Độ cứng</label>
                    <select class="form-select">
                        <option value="">-- Chọn --</option>
                        <option value="Cứng">Cứng</option>
                        <option value="Trung bình">Trung bình</option>
                        <option value="Mềm">Mềm</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Điểm cân bằng</label>
                    <select class="form-select">
                        <option value="">-- Chọn --</option>
                        <option value="Ngọt (Head Heavy)">Ngọt (Head Heavy)</option>
                        <option value="Cân bằng">Cân bằng (Even)</option>
                        <option value="Đầu nhẹ (Head Light)">Đầu nhẹ (Head Light)</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Màu sắc</label>
                    <input type="text" name="attrValues" class="form-control" placeholder="VD: Xanh dương">
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Chất liệu</label>
                    <input type="text" class="form-control" placeholder="VD: Carbon">
                </div>
            </div>
        </div>

        <%-- KÍCH CỠ GIÀY (NẾU LÀ GIÀY) --%>
        <div class="attr-section mt-3">
            <h6><i class="fa-solid fa-shoe-prints"></i> KÍCH CỠ GIÀY CẦU LÔNG</h6>
            <div class="row g-2">
                <c:forEach begin="0" end="7" var="i">
                    <div class="col-md-3">
                        <div class="input-group input-group-sm mb-2">
                            <span class="input-group-text">Size ${38 + i}</span>
                            <input type="number" name="shoeQuantity" class="form-control" placeholder="SL" min="0">
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%-- KÍCH CỠ VỢT (BIẾN THỂ) --%>
        <div class="attr-section mt-3">
            <h6><i class="fa-solid fa-layer-group"></i> KÍCH CỠ / PHÂN LOẠI BIẾN THỂ</h6>
            <div class="row g-2 mb-2">
                <div class="col-md-6">
                    <input type="text" name="variantNames" class="form-control" placeholder="Tên biến thể (VD: Yonex Astrox 88D Pro)">
                </div>
                <div class="col-md-6">
                    <input type="number" name="variantStocks" class="form-control" placeholder="Số lượng tồn kho" min="0">
                </div>
            </div>
            <div class="row g-2 mb-2">
                <div class="col-md-6">
                    <input type="text" name="variantNames" class="form-control" placeholder="Tên biến thể (VD: Yonex Astrox 88D)">
                </div>
                <div class="col-md-6">
                    <input type="number" name="variantStocks" class="form-control" placeholder="Số lượng tồn kho" min="0">
                </div>
            </div>
            <div class="row g-2">
                <div class="col-md-6">
                    <input type="text" name="variantNames" class="form-control" placeholder="Tên biến thể (VD: Yonex Astrox 88S)">
                </div>
                <div class="col-md-6">
                    <input type="number" name="variantStocks" class="form-control" placeholder="Số lượng tồn kho" min="0">
                </div>
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