<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <select name="categoryId" class="form-select" onchange="loadAttributes(this.value)" required>
                    <option value="">-- Chọn danh mục --</option>
                    <option value="1">Vợt cầu lông</option>
                    <option value="2">Giày cầu lông</option>
                    <option value="3">Quần áo cầu lông</option>
                </select>
            </div>
            <div class="col-md-6">
                <label class="form-label fw-semibold">Thương hiệu (Brand ID)</label>
                <input type="number" name="brandId" class="form-control" placeholder="Ví dụ: 1" required>
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

        <%-- TIÊU CHÍ ĐỘNG THEO CATEGORY --%>
        <div id="attr-container"></div>

        <%-- VARIANTS --%>
        <div class="mb-4 mt-4">
            <label class="form-label fw-bold">Kích cỡ & Số lượng tồn kho</label>
            <div id="variant-container">
                <div class="row g-2 mb-2 variant-row">
                    <div class="col-md-6">
                        <input type="text" name="variantNames" class="form-control" placeholder="Ví dụ: Size 40" required>
                    </div>
                    <div class="col-md-4">
                        <input type="number" name="stockQuantities" class="form-control" placeholder="Số lượng" required>
                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-outline-danger w-100" onclick="removeVariant(this)">✕</button>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-outline-primary btn-sm mt-2" onclick="addVariant()">+ Thêm size</button>
        </div>

        <div class="d-grid mt-4">
            <button type="submit" class="btn btn-save">⬇ Save</button>
        </div>
    </form>
</div>
</div>
</div>
</div>

<script>
// Cấu hình tiêu chí theo từng category - khớp với FilterAttributes trong DB
const categoryAttributes = {
    "1": [ // Vợt cầu lông
        { key: "flexibility", label: "Độ cứng đũa", options: ["Cứng", "Trung bình", "Mềm"] },
        { key: "weight",      label: "Trọng lượng (U)", options: ["2U", "3U", "4U", "5U"] },
        { key: "swingweight", label: "Swingweight", options: ["Nặng đầu", "Cân bằng", "Nhẹ đầu"] },
        { key: "balance_point",label: "Điểm cân bằng", options: ["Head Heavy", "Even Balance", "Head Light"] },
        { key: "play_style",  label: "Phong cách chơi", options: ["Tấn công", "Phòng thủ", "Toàn diện"] },
        { key: "play_level",  label: "Trình độ chơi", options: ["Người mới", "Trung cấp", "Chuyên nghiệp"] },
        { key: "brand_filter",label: "Thương hiệu", options: ["Yonex", "Victor", "Lining"] }
    ],
    "2": [ // Giày cầu lông
        { key: "foot_type",   label: "Kiểu bàn chân", options: ["Slim", "Wide", "Normal"] },
        { key: "brand_filter",label: "Thương hiệu", options: ["Yonex", "Victor", "Lining"] },
        { key: "size_filter", label: "Size giày", options: ["39", "40", "41", "42", "43", "44"] },
        { key: "segment_filter", label: "Phân khúc", options: ["Cao cấp", "Trung cấp", "Phổ thông"] }
    ],
    "3": [ // Quần áo
        { key: "brand_filter",label: "Thương hiệu", options: ["Yonex", "Victor", "Lining"] },
        { key: "size_filter", label: "Size quần áo", options: ["S", "M", "L", "XL", "XXL"] }
    ]
};

function loadAttributes(categoryId) {
    const container = document.getElementById('attr-container');
    container.innerHTML = '';

    if (!categoryId || !categoryAttributes[categoryId]) return;

    const attrs = categoryAttributes[categoryId];
    let html = '<div class="attr-section"><h6>THÔNG TIN CHI TIẾT SẢN PHẨM</h6><div class="row g-3">';

    for (let i = 0; i < attrs.length; i++) {
        const attr = attrs[i];

        let optionsHtml = '<option value="">-- Chọn ' + attr.label + ' --</option>';
        for (let j = 0; j < attr.options.length; j++) {
            optionsHtml += '<option value="' + attr.options[j] + '">' + attr.options[j] + '</option>';
        }

        html += '<div class="col-md-6">';
        html += '<label class="form-label fw-semibold">' + attr.label + '</label>';
        html += '<input type="hidden" name="attrKeys" value="' + attr.key + '">';
        html += '<select name="attrValues" class="form-select">' + optionsHtml + '</select>';
        html += '</div>';
    }

    html += '</div></div>';
    container.innerHTML = html;
}

function addVariant() {
    const container = document.getElementById('variant-container');
    const newRow = document.createElement('div');
    newRow.className = 'row g-2 mb-2 variant-row';
    newRow.innerHTML = `
        <div class="col-md-6">
            <input type="text" name="variantNames" class="form-control" placeholder="Ví dụ: Size 41" required>
        </div>
        <div class="col-md-4">
            <input type="number" name="stockQuantities" class="form-control" placeholder="Số lượng" required>
        </div>
        <div class="col-md-2">
            <button type="button" class="btn btn-outline-danger w-100" onclick="removeVariant(this)">✕</button>
        </div>`;
    container.appendChild(newRow);
}

function removeVariant(btn) {
    const rows = document.querySelectorAll('.variant-row');
    if (rows.length > 1) {
        btn.closest('.variant-row').remove();
    } else {
        alert("Phải có ít nhất một biến thể!");
    }
}
</script>
</body>
</html>