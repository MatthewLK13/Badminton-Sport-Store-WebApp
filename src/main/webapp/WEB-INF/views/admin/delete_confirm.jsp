<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xác nhận xóa sản phẩm</title>
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
.confirm-card {
    background: #fff; border-radius: 12px;
    padding: 40px; box-shadow: 0 1px 4px rgba(0,0,0,0.06);
    max-width: 600px; margin: 60px auto; text-align: center;
}
.product-img {
    width: 120px; height: 120px; object-fit: cover;
    border-radius: 12px; border: 1px solid #e0e0e0;
    margin-bottom: 20px;
}
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
    <div class="confirm-card">

        <%-- Icon cảnh báo --%>
        <div style="width:64px;height:64px;border-radius:50%;background:#fce4e4;
                    display:flex;align-items:center;justify-content:center;
                    margin:0 auto 20px;font-size:28px;">
            
        </div>

        <h4 class="fw-bold mb-2">Xác nhận xóa sản phẩm</h4>
        <p class="text-muted mb-4">
            Hành động này không thể hoàn tác. Toàn bộ dữ liệu của sản phẩm
            bao gồm ảnh, variants và attributes sẽ bị xóa vĩnh viễn.
        </p>

        <%-- Thông tin sản phẩm --%>
        <div style="background:#f8fafc;border-radius:10px;padding:20px;margin-bottom:28px;">
            <c:forEach var="img" items="${product.productImages}">
                <c:if test="${img.isMain}">
                    <img src="${pageContext.request.contextPath}/images/products/${img.imageUrl}"
                         class="product-img" alt="${product.productName}">
                </c:if>
            </c:forEach>
            <h5 class="fw-bold mb-1">${product.productName}</h5>
            <p class="text-muted mb-1" style="font-size:14px;">
                #${product.id} · ${product.category_id.categoryName} · ${product.brand_id.brandName}
            </p>
            <p class="fw-bold text-danger mb-0">
                $<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
            </p>
        </div>

        <%-- Form xác nhận xóa --%>
        <form action="${pageContext.request.contextPath}/admin/product/delete.htm"
              method="POST">
            <input type="hidden" name="productId" value="${product.id}">
            <div class="d-flex gap-3 justify-content-center">
                <a href="${pageContext.request.contextPath}/admin/product/management.htm"
                   class="btn btn-outline-secondary px-5 py-2">
                    Hủy
                </a>
                <button type="submit"
                        class="btn btn-danger px-5 py-2 fw-semibold">
                     Xóa vĩnh viễn
                </button>
            </div>
        </form>

    </div>
</div>
</body>
</html>