<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id} - Yonex</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .breadcrumb {
            padding: 12px 40px;
            font-size: 13px;
            color: #999;
            border-bottom: 1px solid #f0f0f0;
        }
        .breadcrumb a { text-decoration: none; color: #999; }
        .breadcrumb a:hover { color: #e36009; }
        .breadcrumb span { color: #e36009; font-weight: 600; }
        .breadcrumb i { font-size: 10px; margin: 0 6px; }

        .page-title {
            padding: 24px 40px 16px;
            font-size: 24px;
            font-weight: 700;
            color: #222;
        }

        .order-container {
            padding: 0 40px 60px;
        }

        .order-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .order-header {
            background: #f8f8f8;
            padding: 20px 24px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .order-info {
            display: flex;
            gap: 40px;
        }
        .order-info-item {
            font-size: 13px;
        }
        .order-info-label {
            color: #888;
            margin-bottom: 4px;
        }
        .order-info-value {
            font-weight: 600;
            color: #333;
        }

        .badge {
            display: inline-block;
            padding: 6px 16px;
            font-size: 13px;
            font-weight: 600;
            border-radius: 4px;
        }
        .badge-done    { background: #e8f8ef; color: #27ae60; }
        .badge-pending { background: #fff4e5; color: #e36009; }
        .badge-shipping { background: #e8f0ff; color: #2980b9; }
        .badge-cancel  { background: #fdecea; color: #e74c3c; }

        .order-body {
            padding: 24px;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }
        .items-table th {
            text-align: left;
            padding: 12px 0;
            border-bottom: 2px solid #eee;
            font-size: 12px;
            font-weight: 700;
            color: #888;
            letter-spacing: 0.05em;
        }
        .items-table td {
            padding: 16px 0;
            border-bottom: 1px solid #f5f5f5;
            font-size: 14px;
        }
        .items-table tr:last-child td { border-bottom: none; }

        .item-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            background: #f5f5f5;
        }

        .item-name {
            font-weight: 600;
            color: #333;
        }
        .item-variant {
            font-size: 12px;
            color: #888;
            margin-top: 4px;
        }

        .item-price {
            font-weight: 600;
            color: #333;
        }

        .order-summary {
            margin-top: 24px;
            padding-top: 24px;
            border-top: 2px solid #eee;
            display: flex;
            justify-content: flex-end;
        }

        .summary-box {
            width: 280px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            font-size: 14px;
        }
        .summary-row.total {
            font-size: 18px;
            font-weight: 700;
            border-top: 2px solid #333;
            padding-top: 12px;
            margin-top: 8px;
        }

        .btn-back {
            display: inline-block;
            padding: 12px 24px;
            background: #333;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
            margin-top: 24px;
            transition: background 0.2s;
        }
        .btn-back:hover { background: #e36009; }
    </style>
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">

    <jsp:include page="includes/header.jsp" />

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home.htm">Trang chủ</a>
        <i class="fa-solid fa-chevron-right"></i>
        <a href="${pageContext.request.contextPath}/order/history.htm">Lịch sử đơn hàng</a>
        <i class="fa-solid fa-chevron-right"></i>
        <span>Chi tiết đơn hàng #${order.id}</span>
    </div>

    <h1 class="page-title">Đơn hàng #${order.id}</h1>

    <div class="order-container">
        <div class="order-card">
            <div class="order-header">
                <div class="order-info">
                    <div class="order-info-item">
                        <div class="order-info-label">Ngày đặt</div>
                        <div class="order-info-value">
                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </div>
                    </div>
                    <div class="order-info-item">
                        <div class="order-info-label">Người nhận</div>
                        <div class="order-info-value">${order.firstName} ${order.lastName}</div>
                    </div>
                    <div class="order-info-item">
                        <div class="order-info-label">Điện thoại</div>
                        <div class="order-info-value">${order.phone}</div>
                    </div>
                    <div class="order-info-item">
                        <div class="order-info-label">Địa chỉ giao hàng</div>
                        <div class="order-info-value">${order.address}, ${order.city}</div>
                    </div>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${order.status == 0}">
                            <span class="badge badge-pending">Chờ xác nhận</span>
                        </c:when>
                        <c:when test="${order.status == 1}">
                            <span class="badge badge-pending">Đã xác nhận</span>
                        </c:when>
                        <c:when test="${order.status == 2}">
                            <span class="badge badge-shipping">Đang giao hàng</span>
                        </c:when>
                        <c:when test="${order.status == 3}">
                            <span class="badge badge-done">Đã giao hàng</span>
                        </c:when>
                        <c:when test="${order.status == 4}">
                            <span class="badge badge-cancel">Đã hủy</span>
                        </c:when>
                        <c:when test="${order.status == -1}">
                            <span class="badge badge-cancel">Đã hủy</span>
                        </c:when>
                    </c:choose>
                </div>
            </div>

            <div class="order-body">
                <table class="items-table">
                    <thead>
                        <tr>
                            <th style="width: 80px;">Hình ảnh</th>
                            <th>Sản phẩm</th>
                            <th style="width: 100px;">Đơn giá</th>
                            <th style="width: 80px;">Số lượng</th>
                            <th style="width: 120px;">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.orderItems}">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/images/products/${item.imageUrl}"
                                         alt="${item.productName}"
                                         class="item-image">
                                </td>
                                <td>
                                    <div class="item-name">${item.productName}</div>
                                    <div class="item-variant">${item.variantName}</div>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </td>
                                <td>${item.quantity}</td>
                                <td>
                                    <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="order-summary">
                    <div class="summary-box">
                        <div class="summary-row total">
                            <span>Tổng thanh toán</span>
                            <span>
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </span>
                        </div>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/order/history.htm" class="btn-back">
                    <i class="fa-solid fa-arrow-left"></i> Quay lại lịch sử đơn hàng
                </a>
            </div>
        </div>
    </div>

</body>
</html>
