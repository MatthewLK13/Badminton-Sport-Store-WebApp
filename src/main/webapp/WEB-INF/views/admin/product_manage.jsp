<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
* { box-sizing: border-box; }
body { background: #f5f5f5; font-family: 'Segoe UI', sans-serif; margin: 0; }

/* SIDEBAR */
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

/* MAIN */
.main-content { margin-left: 220px; padding: 24px; }

/* TOPBAR */
.topbar {
    background: #fff; padding: 14px 24px;
    border-radius: 10px; margin-bottom: 24px;
    display: flex; justify-content: space-between; align-items: center;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}

/* STATS */
.stat-card {
    background: #fff; border-radius: 10px;
    padding: 16px 20px; box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}
.stat-card .label { font-size: 12px; color: #888; margin-bottom: 4px; }
.stat-card .value { font-size: 24px; font-weight: 700; }

/* FILTER BAR */
.filter-bar {
    background: #fff; border-radius: 10px;
    padding: 16px 20px; margin-bottom: 20px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
    display: flex; gap: 12px; align-items: center; flex-wrap: wrap;
}

/* TABLE */
.table-card {
    background: #fff; border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06); overflow: hidden;
}
.table thead th {
    background: #f8f9fa; font-size: 13px;
    color: #666; font-weight: 600; border: none; padding: 12px 16px;
}
.table tbody td { padding: 12px 16px; vertical-align: middle; border-color: #f0f0f0; }
.table tbody tr:hover { background: #fafafa; }

.product-img {
    width: 48px; height: 48px; object-fit: cover;
    border-radius: 8px; border: 1px solid #e0e0e0;
}
.badge-cat {
    background: #e8f5e9; color: #2e7d32;
    padding: 3px 10px; border-radius: 20px; font-size: 12px;
}
.btn-action { width: 32px; height: 32px; padding: 0; border-radius: 6px; }

/* PAGINATION */
.pagination .page-link { border-radius: 6px !important; margin: 0 2px; color: #333; }
.pagination .page-item.active .page-link { background: #2e7d32; border-color: #2e7d32; }
</style>
</head>
<body>

<%-- SIDEBAR --%>
<div class="sidebar">
    <div class="logo">🏸 Sport Admin</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard.htm">
        📊 Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/product/management.htm" class="active">
        📦 Products
    </a>
    <a href="${pageContext.request.contextPath}/admin/user/management.htm">
        👤 Users
    </a>
    <a href="${pageContext.request.contextPath}/admin/order/management.htm">
        🚚 Orders
    </a>
</div>

<%-- MAIN CONTENT --%>
<div class="main-content">

    <%-- TOPBAR --%>
    <div class="topbar">
        <h5 class="mb-0 fw-bold">Products Management</h5>
        <div class="d-flex align-items-center gap-2">
            <span class="text-muted" style="font-size:14px;">Admin</span>
            <div style="width:36px;height:36px;border-radius:50%;background:#2e7d32;
                        color:#fff;display:flex;align-items:center;justify-content:center;
                        font-weight:700;">A</div>
        </div>
    </div>

    <%-- STATS --%>
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <div class="label">Total Products</div>
                <div class="value">${totalProducts}</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="label">Current Page</div>
                <div class="value">${currentPage} / ${totalPages}</div>
            </div>
        </div>
        <div class="col-md-6 d-flex align-items-center justify-content-end">
            <a href="${pageContext.request.contextPath}/admin/product/add.htm"
               class="btn btn-success px-4">
                + Add New Product
            </a>
        </div>
    </div>

    <%-- FILTER BAR --%>
    <form method="GET" 
          action="${pageContext.request.contextPath}/admin/product/management.htm"
          class="filter-bar">

        <input type="text" name="keyword" value="${keyword}"
               class="form-control" style="max-width:220px;"
               placeholder="🔍 Search by name...">

        <select name="categoryId" class="form-select" style="max-width:160px;">
            <option value="">All Categories</option>
            <option value="1" ${selectedCategoryId == 1 ? 'selected' : ''}>Vợt cầu lông</option>
            <option value="2" ${selectedCategoryId == 2 ? 'selected' : ''}>Giày cầu lông</option>
            <option value="3" ${selectedCategoryId == 3 ? 'selected' : ''}>Quần áo</option>
            <option value="4" ${selectedCategoryId == 4 ? 'selected' : ''}>Túi vợt</option>
            <option value="5" ${selectedCategoryId == 5 ? 'selected' : ''}>Phụ kiện</option>
        </select>

        <select name="brandId" class="form-select" style="max-width:140px;">
            <option value="">All Brands</option>
            <option value="1" ${selectedBrandId == 1 ? 'selected' : ''}>Yonex</option>
            <option value="2" ${selectedBrandId == 2 ? 'selected' : ''}>Victor</option>
            <option value="3" ${selectedBrandId == 3 ? 'selected' : ''}>Lining</option>
            <option value="4" ${selectedBrandId == 4 ? 'selected' : ''}>Mizuno</option>
            <option value="5" ${selectedBrandId == 5 ? 'selected' : ''}>Kawasaki</option>
            <option value="6" ${selectedBrandId == 6 ? 'selected' : ''}>Venson</option>
        </select>

        <input type="date" name="fromDate" value="${fromDate}"
               class="form-control" style="max-width:160px;">

        <button type="submit" class="btn btn-dark px-4">Search</button>

        <a href="${pageContext.request.contextPath}/admin/product/management.htm"
           class="btn btn-outline-secondary">Reset</a>
    </form>

    <%-- TABLE --%>
    <div class="table-card">
        <table class="table mb-0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Brand</th>
                    <th>Price</th>
                    <th>Stock</th> 
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td style="color:#888;font-size:13px;">#${p.id}</td>
                        <td>
                            <c:set var="mainImg" value=""/>
                            <c:forEach var="img" items="${p.productImages}">
                                <c:if test="${img.isMain && mainImg == ''}">
                                    <c:set var="mainImg" value="${img.imageUrl}"/>
                                </c:if>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${mainImg != ''}">
                                    <img src="${pageContext.request.contextPath}/images/products/${mainImg}"
                                         class="product-img" alt="${p.productName}">
                                </c:when>
                                <c:otherwise>
                                    <div class="product-img d-flex align-items-center 
                                                justify-content-center bg-light text-muted"
                                         style="font-size:10px;">No img</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><strong style="font-size:14px;">${p.productName}</strong></td>
                        <td><span class="badge-cat">${p.category_id.categoryName}</span></td>
                        <td style="font-size:14px;">${p.brand_id.brandName}</td>
                        <td style="font-weight:600;">
                            $<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/>
                        </td>
                        
                        <%-- Xóa <th>Stock</th> trong tbody đi --%>
<%-- Sửa lại cột Stock trong tbody thành: --%>


<%-- Trong tbody --%>
<td>
    <c:set var="pid" value="${p.id}"/>
    <c:choose>
        <c:when test="${not empty variantsMap[pid]}">
            <select class="form-select form-select-sm" style="min-width:140px;">
                <c:forEach var="v" items="${variantsMap[pid]}">
                    <option>
                        ${v.name} — SL: ${v.stock}
                    </option>
                </c:forEach>
            </select>
        </c:when>
        <c:otherwise>
            <span class="badge bg-secondary">--</span>
        </c:otherwise>
    </c:choose>
</td>
                        
                        <td style="font-size:13px;color:#888;">${p.createAt}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/product/edit.htm?id=${p.id}"
                               class="btn btn-outline-primary btn-action me-1" title="Edit">✏</a>
                            <form action="${pageContext.request.contextPath}/admin/product/delete.htm" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" class="btn btn-outline-danger btn-action" title="Delete">🗑</button>
                            </form>
                        </td>
                    </tr>
                    
                </c:forEach>

                <c:if test="${empty products}">
                    <tr>
                        <td colspan="9" class="text-center text-muted py-5"> <%-- Tăng colspan từ 8 lên 9 vì đã thêm 1 cột --%>
                            Không tìm thấy sản phẩm nào.
                        </td>
                    </tr>
                </c:if>
                
            </tbody>
        </table>

        <%-- PAGINATION --%>
        <c:if test="${totalPages > 1}">
            <div class="d-flex justify-content-center py-3">
                <ul class="pagination mb-0">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" 
                               href="?page=${currentPage-1}&keyword=${keyword}&categoryId=${selectedCategoryId}&brandId=${selectedBrandId}&fromDate=${fromDate}">
                                &laquo;
                            </a>
                        </li>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link"
                               href="?page=${i}&keyword=${keyword}&categoryId=${selectedCategoryId}&brandId=${selectedBrandId}&fromDate=${fromDate}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link"
                               href="?page=${currentPage+1}&keyword=${keyword}&categoryId=${selectedCategoryId}&brandId=${selectedBrandId}&fromDate=${fromDate}">
                                &raquo;
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </c:if>
    </div>

</div>
</body>
</html>