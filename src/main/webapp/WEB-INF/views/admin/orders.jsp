<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng - Yonex Admin</title>
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
            background-color: #b8c9c3; /* Màu xanh xám nhẹ chuẩn Figma */
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
            box-shadow: 0 4px 10px rgba(0,0,0,0.03);
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.02);
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

        /* Dashboard Title & Stats Cards */
        .page-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 25px;
        }
        .stats-container {
            display: flex;
            gap: 25px;
            margin-bottom: 40px;
        }
        .card {
            background: #fff;
            padding: 25px;
            border-radius: 16px;
            width: 220px;
            display: flex;
            flex-direction: column;
            gap: 15px;
            position: relative;
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
        }
        .card-icon {
            width: 40px; height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .card-icon.red { background: #ffebeb; color: #e74c3c; }
        .card-icon.green { background: #e8f8f0; color: #2ecc71; }
        .card-title { font-size: 12px; color: #8e8e8e; font-weight: 500; }
        .card-value { font-size: 24px; font-weight: 700; }
        
        /* Table section */
        .orders-list-box {
            background: #fff;
            padding: 30px;
            border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }
        .filter-row {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        .filter-group label {
            font-size: 12px; font-weight: 600; color: #4a4a4a;
        }
        .filter-input {
            padding: 8px 16px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            font-size: 13px;
            outline: none;
            min-width: 220px;
        }

        .orders-list-title {
            font-size: 16px; font-weight: 700; margin-bottom: 20px;
        }

        /* Table CSS */
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }
        th {
            font-size: 12px; font-weight: 600; color: #8e8e8e;
            padding: 15px 10px;
            border-bottom: 2px solid #f4f6f8;
        }
        td {
            padding: 18px 10px;
            border-bottom: 1px solid #f4f6f8;
            font-size: 14px;
            font-weight: 500;
        }
        
        /* Badges */
        .badge {
            padding: 6px 14px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
            display: inline-block;
        }
        .badge.admin { background: #ffe8cc; color: #e36009; }
        .badge.user { background: #e7f1ff; color: #007aff; }
        .badge.vip { background: #fdf6cc; color: #ccac00; }
        .badge.done { background: #dff0d8; color: #3c763d; }
        .badge.pending { background: #fcf8e3; color: #8a6d3b; }

        .btn-view-detail {
            color: #000;
            background: none; border: none;
            cursor: pointer; font-size: 16px;
            transition: transform 0.2s;
        }
        .btn-view-detail:hover {
            transform: scale(1.2);
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
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/dashboard.htm"><i class="fa-solid fa-chart-simple"></i> Dashboard</a></li>
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

        <h2 class="page-title">Orders Management</h2>

        <div class="stats-container">
            <div class="card">
                <div class="card-icon red"><i class="fa-solid fa-bag-shopping"></i></div>
                <span class="card-title">Total Order</span>
                <span class="card-value"><fmt:formatNumber value="${totalOrders}" pattern="#,###"/></span>
            </div>
            <div class="card">
                <div class="card-icon green"><i class="fa-solid fa-truck-fast"></i></div>
                <span class="card-title">New Order (this month)</span>
                <span class="card-value">${newOrders}</span>
            </div>
        </div>

        <div class="orders-list-box">
            <!-- Filter panel -->
            <form action="${pageContext.request.contextPath}/admin/orders.htm" method="GET">
            <div class="filter-row">
                <div class="filter-group">
                    <label>Search</label>
                    <input type="text" name="keyword" class="filter-input" placeholder="Search by name/email/ID" value="${param.keyword}">
                </div>
                <div class="filter-group">
                    <label>Order date</label>
                    <input type="date" name="orderDate" class="filter-input" value="${param.orderDate}">
                </div>
                <div class="filter-group" style="justify-content: flex-end;">
                    <button type="submit" class="btn btn-outline-secondary" style="height: 36px; padding: 0 20px; border-radius: 10px; cursor: pointer; border: 1px solid #ccc;">Filter</button>
                </div>
            </div>
            </form>

            <h3 class="orders-list-title">Orders list</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User's name</th>
                        <th>Order code</th>
                        <th>Role</th>
                        <th>Order date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="ordersTableBody">
                    <c:forEach var="item" items="${orders}">
                        <tr class="order-row" data-date="<fmt:formatDate value="${item.orderDate}" pattern="yyyy-MM-dd"/>">
                            <td>${item.id}</td>
                            <td class="user-name-col">${item.firstName} ${item.lastName}</td>
                            <td>O-0${item.id}</td>
                            <td>
                                <!-- Giả lập Role cho phù hợp Figma -->
                                <c:choose>
                                    <c:when test="${item.id % 3 == 0}">
                                        <span class="badge admin">Admin</span>
                                    </c:when>
                                    <c:when test="${item.id % 3 == 1}">
                                        <span class="badge user">User</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge vip">Vip</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${item.orderDate}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 0}"><span class="badge pending">Chờ xác nhận</span></c:when>
                                    <c:when test="${item.status == 1}"><span class="badge" style="background: #dbeafe; color: #1d4ed8;">Đã xác nhận</span></c:when>
                                    <c:when test="${item.status == 2}"><span class="badge" style="background: #fef3c7; color: #d97706;">Đang giao</span></c:when>
                                    <c:when test="${item.status == 3}"><span class="badge done">Đã giao</span></c:when>
                                    <c:when test="${item.status == 4}"><span class="badge" style="background: #fee2e2; color: #dc2626;">Đã hủy</span></c:when>
                                    <c:otherwise><span class="badge pending">Unknown</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/order-detail.htm?id=${item.id}" class="btn-view-detail">
                                    <i class="fa-regular fa-file-lines"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: #8e8e8e;">Chưa có đơn hàng nào trong hệ thống!</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>