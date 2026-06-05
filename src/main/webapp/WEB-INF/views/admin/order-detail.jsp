<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết hóa đơn - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        body {
            background-color: #eef2f3;
            display: flex;
            min-height: 100vh;
        }
        /* --- SIDEBAR --- */
        .sidebar {
            width: 240px;
            background-color: #b8c9c3;
            padding: 30px 20px;
            display: flex;
            flex-direction: column;
            border-right: 1px solid rgba(0,0,0,0.05);
            position: fixed;
            height: 100vh;
        }
        .logo-area {
            text-align: center;
            margin-bottom: 50px;
        }
        .logo-area svg {
            width: 60px; height: auto;
            fill: #000;
        }
        .menu-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .menu-item a {
            display: flex;
            align-items: center;
            gap: 15px;
            text-decoration: none;
            color: #4a4a4a;
            font-size: 14px;
            font-weight: 600;
            padding: 12px 15px;
            border-radius: 20px;
            transition: all 0.3s;
        }
        .menu-item a:hover, .menu-item.active a {
            background-color: #ffffffc9;
            color: #000;
        }

        /* --- MAIN CONTENT --- */
        .main-content {
            margin-left: 240px;
            flex: 1;
            padding: 30px 40px;
        }

        /* Top Bar */
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        .search-top {
            background: #fff;
            padding: 8px 16px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            width: 250px;
        }
        .search-top input {
            border: none; outline: none; font-size: 13px; width: 100%; margin-left: 10px;
        }
        .admin-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            font-size: 14px;
        }
        .admin-profile i { font-size: 20px; }

        /* Dashboard Title */
        .title-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .page-title {
            font-size: 28px;
            font-weight: 700;
        }
        
        .btn-prev {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #dcdcdc;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 13px;
            color: #333;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }
        .btn-prev:hover { background: #c8c8c8; }

        /* Receipt Invoice container (Giống thiết kế Figma chuẩn) */
        .invoice-card {
            background: #fff;
            max-width: 650px;
            margin: 0 auto 30px auto;
            padding: 40px 50px;
            box-shadow: 0 4px 30px rgba(0,0,0,0.05);
            border: 1px solid #e8e8e8;
            border-radius: 4px;
        }
        .invoice-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .invoice-header svg {
            width: 50px; height: auto; fill: #000; margin-bottom: 5px;
        }
        .brand-name {
            font-size: 18px; font-weight: 900; letter-spacing: 0.1em; margin-bottom: 15px;
        }
        .invoice-title {
            font-size: 16px; font-weight: 700; margin-bottom: 20px; text-transform: uppercase;
        }
        .invoice-meta {
            display: flex;
            justify-content: space-between;
            font-size: 11px;
            color: #555;
            margin-bottom: 30px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }

        /* Invoice Table */
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        .invoice-table th {
            font-size: 11px; font-weight: 700; color: #000;
            border-bottom: 2px solid #000;
            padding: 10px 5px;
        }
        .invoice-table td {
            font-size: 12px; color: #333;
            padding: 15px 5px;
            border-bottom: 1px solid #eee;
        }
        .text-right { text-align: right; }
        .text-center { text-align: center; }

        /* Summary section */
        .invoice-summary {
            display: flex;
            flex-direction: column;
            gap: 15px;
            padding-top: 15px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            font-weight: 900;
            border-top: 1px solid #000;
            border-bottom: 1px solid #000;
            padding: 15px 0;
            margin: 10px 0;
        }
        .payment-method {
            font-size: 12px;
            color: #555;
            margin-top: 15px;
        }

        /* Print Area Action */
        .action-row {
            max-width: 650px;
            margin: 0 auto;
            text-align: right;
        }
        .btn-print {
            background: #dcdcdc;
            color: #000;
            border: none;
            padding: 12px 30px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }
        .btn-print:hover {
            background: #c8c8c8;
        }

        /* Cấu hình in ấn bằng CSS Media Queries */
        @media print {
            body { background: #fff; }
            .sidebar, .topbar, .title-row, .action-row {
                display: none !important;
            }
            .main-content {
                margin-left: 0 !important;
                padding: 0 !important;
            }
            .invoice-card {
                box-shadow: none !important;
                border: none !important;
                padding: 0 !important;
                max-width: 100% !important;
            }
        }
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
            <li class="menu-item"><a href="#"><i class="fa-solid fa-chart-simple"></i> Dashboard</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/product/management.htm"><i class="fa-solid fa-box"></i> Products</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/users.htm"><i class="fa-solid fa-users"></i> Users</a></li>
            <li class="menu-item active"><a href="${pageContext.request.contextPath}/admin/orders.htm"><i class="fa-solid fa-truck"></i> Orders</a></li>
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
            <div class="search-top">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Tìm kiếm...">
            </div>
            <div class="admin-profile">
                <span>${sessionScope.user.fullName}</span>
                <i class="fa-solid fa-circle-user"></i>
            </div>
        </div>

        <div class="title-row">
            <h2 class="page-title">Orders Detail</h2>
            <a href="${pageContext.request.contextPath}/admin/orders.htm" class="btn-prev">
                <i class="fa-solid fa-arrow-rotate-left"></i> Previous
            </a>
        </div>

        <!-- HÓA ĐƠN CHI TIẾT -->
        <div class="invoice-card">
            <div class="invoice-header">
                <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <path d="M20 70 L35 25 L50 25 L35 70 Z" />
                    <path d="M50 70 L65 25 L80 25 L65 70 Z" />
                </svg>
                <div class="brand-name">YONEX</div>
                <div class="invoice-title">Hóa đơn bán lẻ</div>
            </div>

            <div class="invoice-meta">
                <div>Số HĐ: O-0${order.id}</div>
                <div>Ngày: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></div>
                <div>Giờ: <fmt:formatDate value="${order.orderDate}" pattern="HH:mm:ss"/></div>
            </div>

            <!-- Khách hàng -->
            <div style="font-size: 12px; margin-bottom: 20px;">
                <p style="margin-bottom: 6px;"><strong>Khách hàng:</strong> ${order.firstName} ${order.lastName}</p>
                <p style="margin-bottom: 6px;"><strong>Điện thoại:</strong> ${order.phone}</p>
                <p><strong>Địa chỉ:</strong> ${order.address}, ${order.city}</p>
            </div>

            <!-- Order Status Update -->
            <div style="font-size: 12px; margin-bottom: 20px; padding: 15px; background: #f5f5f5; border-radius: 8px;">
                <form action="${pageContext.request.contextPath}/admin/order-status.htm" method="post" style="display: flex; align-items: center; gap: 10px;">
                    <input type="hidden" name="orderId" value="${order.id}"/>
                    <strong>Trạng thái:</strong>
                    <select name="status" style="padding: 6px 12px; border-radius: 6px; border: 1px solid #ddd; font-size: 12px;">
                        <option value="0" ${order.status == 0 ? 'selected' : ''}>Chờ xác nhận</option>
                        <option value="1" ${order.status == 1 ? 'selected' : ''}>Đã xác nhận</option>
                        <option value="2" ${order.status == 2 ? 'selected' : ''}>Đang giao hàng</option>
                        <option value="3" ${order.status == 3 ? 'selected' : ''}>Đã giao hàng</option>
                        <option value="4" ${order.status == 4 ? 'selected' : ''}>Đã hủy</option>
                    </select>
                    <button type="submit" style="padding: 6px 16px; background: #4a4a4a; color: #fff; border: none; border-radius: 6px; font-size: 12px; cursor: pointer;">Cập nhật</button>
                </form>
            </div>

            <!-- Bảng sản phẩm -->
            <table class="invoice-table">
                <thead>
                    <tr>
                        <th class="text-center" style="width: 10%;">STT</th>
                        <th style="width: 50%;">Tên hàng hóa</th>
                        <th class="text-center" style="width: 10%;">SL</th>
                        <th class="text-right" style="width: 15%;">Đơn giá</th>
                        <th class="text-right" style="width: 15%;">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                    <tr>
                        <td class="text-center">${status.index + 1}</td>
                        <td>${item.productName} - ${item.variantName}</td>
                        <td class="text-center">${item.quantity}</td>
                        <td class="text-right"><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                        <td class="text-right"><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="invoice-summary">
                <c:set var="totalAmount" value="0"/>
                <c:forEach var="item" items="${order.orderItems}">
                    <c:set var="totalAmount" value="${totalAmount + (item.price * item.quantity)}"/>
                </c:forEach>
                <div class="summary-row">
                    <span>Tổng cộng:</span>
                    <span><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
                </div>
                <div class="summary-total">
                    <span>Tổng thanh toán</span>
                    <span><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
                </div>
                <div class="payment-method">
                    <span>Phương thức thanh toán:</span>
                    <span style="float: right; font-weight: 600;">
                        <!-- Đọc thẻ tín dụng nếu có lưu -->
                        <c:choose>
                            <c:when test="${not empty order.cardNumber}">
                                Visa (**** <c:out value="${order.cardNumber.substring(Math.max(0, order.cardNumber.length() - 4))}"/>)
                            </c:when>
                            <c:otherwise>
                                Thẻ visa
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>

        <!-- NÚT IN HÓA ĐƠN -->
        <div class="action-row">
            <button class="btn-print" title="In hóa đơn" onclick="window.print()">
                <i class="fa-solid fa-print"></i> Print
            </button>
        </div>
    </div>

</body>
</html>