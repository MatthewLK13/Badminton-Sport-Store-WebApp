<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #eef2f3; display: flex; min-height: 100vh; }

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
        .logo-area { text-align: center; margin-bottom: 50px; }
        .logo-area svg { width: 60px; height: auto; fill: #000; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a {
            display: flex; align-items: center; gap: 15px;
            text-decoration: none; color: #4a4a4a;
            font-size: 14px; font-weight: 600;
            padding: 12px 15px; border-radius: 20px; transition: all 0.3s;
        }
        .menu-item a:hover, .menu-item.active a {
            background-color: #ffffffc9; color: #000;
        }

        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; }
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .search-top {
            background: #fff; padding: 8px 16px; border-radius: 20px;
            display: flex; align-items: center; width: 250px;
        }
        .search-top input { border: none; outline: none; font-size: 13px; width: 100%; margin-left: 10px; }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }

        .page-title { font-size: 28px; font-weight: 700; margin-bottom: 25px; }
        .stats-container { display: flex; gap: 25px; margin-bottom: 40px; }
        .card {
            background: #fff; padding: 25px; border-radius: 16px;
            width: 220px; display: flex; flex-direction: column; gap: 15px;
            position: relative; box-shadow: 0 4px 15px rgba(0,0,0,0.02);
        }
        .card-icon { width: 40px; height: 40px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 20px; }
        .card-icon.blue { background: #e7f1ff; color: #007aff; }
        .card-icon.green { background: #e8f8f0; color: #2ecc71; }
        .card-icon.red { background: #ffebeb; color: #e74c3c; }
        .card-title { font-size: 12px; color: #8e8e8e; font-weight: 500; }
        .card-value { font-size: 24px; font-weight: 700; }

        .users-list-box { background: #fff; padding: 30px; border-radius: 24px; box-shadow: 0 4px 20px rgba(0,0,0,0.02); }
        .users-list-title { font-size: 16px; font-weight: 700; margin-bottom: 20px; }

        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { font-size: 12px; font-weight: 600; color: #8e8e8e; padding: 15px 10px; border-bottom: 2px solid #f4f6f8; }
        td { padding: 18px 10px; border-bottom: 1px solid #f4f6f8; font-size: 14px; font-weight: 500; }

        .badge { padding: 6px 14px; border-radius: 12px; font-size: 11px; font-weight: 700; display: inline-block; }
        .badge.active { background: #dff0d8; color: #3c763d; }
        .badge.locked { background: #fee2e2; color: #dc2626; }
        .badge.admin { background: #ffe8cc; color: #e36009; }

        .btn-action {
            padding: 6px 12px; border: none; border-radius: 8px; font-size: 12px; cursor: pointer; margin-right: 5px;
        }
        .btn-lock { background: #fee2e2; color: #dc2626; }
        .btn-unlock { background: #dff0d8; color: #3c763d; }
        .btn-delete { background: #ffebeb; color: #e74c3c; }
        .btn-view { background: #e7f1ff; color: #007aff; }

        .btn-prev {
            display: flex; align-items: center; gap: 8px;
            background: #dcdcdc; border: none; padding: 8px 20px;
            border-radius: 20px; font-weight: 600; font-size: 13px;
            color: #333; cursor: pointer; text-decoration: none; transition: background 0.3s;
        }
        .btn-prev:hover { background: #c8c8c8; }
        .title-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
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
            <li class="menu-item active"><a href="${pageContext.request.contextPath}/admin/users.htm"><i class="fa-solid fa-users"></i> Users</a></li>
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
            
            <div class="admin-profile">
                <span>${sessionScope.user.fullName}</span>
                <i class="fa-solid fa-circle-user"></i>
            </div>
        </div>

        <div class="title-row">
            <div class="header-container" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <h2 class="page-title" style="margin-bottom: 0;">Users Management</h2>
            <a href="${pageContext.request.contextPath}/admin/user/add.htm" class="btn-add-user" style="background-color: #000; color: #fff; padding: 12px 25px; border-radius: 20px; text-decoration: none; font-weight: 600; font-size: 14px; transition: 0.3s; margin-left: 20px;">+ Add new user</a>
        </div>
            <a href="${pageContext.request.contextPath}/home.htm" class="btn-prev">
                <i class="fa-solid fa-arrow-rotate-left"></i> Back to Shop
            </a>
        </div>

        <div class="stats-container">
            <div class="card">
                <div class="card-icon blue"><i class="fa-solid fa-users"></i></div>
                <span class="card-title">Total Users</span>
                <span class="card-value">${users.size()}</span>
            </div>
            <div class="card">
                <div class="card-icon green"><i class="fa-solid fa-user-check"></i></div>
                <span class="card-title">Active Users</span>
                <span class="card-value">
                    <c:set var="activeCount" value="0"/>
                    <c:forEach var="u" items="${users}"><c:if test="${u.isActive == true}"><c:set var="activeCount" value="${activeCount + 1}"/></c:if></c:forEach>
                    ${activeCount}
                </span>
            </div>
            <div class="card">
                <div class="card-icon red"><i class="fa-solid fa-user-lock"></i></div>
                <span class="card-title">Locked Users</span>
                <span class="card-value">
                    <c:set var="lockedCount" value="0"/>
                    <c:forEach var="u" items="${users}"><c:if test="${u.isActive == false}"><c:set var="lockedCount" value="${lockedCount + 1}"/></c:if></c:forEach>
                    ${lockedCount}
                </span>
            </div>
        </div>

        <div class="users-list-box">
            <!-- Filter panel -->
            <form action="${pageContext.request.contextPath}/admin/users.htm" method="GET">
            <div class="filter-row" style="display: flex; gap: 20px; margin-bottom: 30px;">
                <div class="filter-group" style="display: flex; flex-direction: column; gap: 6px;">
                    <label style="font-size: 12px; font-weight: 600; color: #4a4a4a;">Search</label>
                    <input type="text" name="keyword" style="padding: 8px 16px; border: 1px solid #e0e0e0; border-radius: 10px; font-size: 13px; outline: none; min-width: 220px;" placeholder="Search by name/email/phone/ID" value="${param.keyword}">
                </div>
                <div class="filter-group" style="display: flex; flex-direction: column; justify-content: flex-end;">
                    <label>&nbsp;</label>
                    <button type="submit" class="btn btn-outline-secondary" style="height: 36px; padding: 0 20px; border-radius: 10px; cursor: pointer; border: 1px solid #ccc; background: white;">Filter</button>
                </div>
            </div>
            </form>

            <h3 class="users-list-title">Users list</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.role.roleName == 'ADMIN'}">
                                        <span class="badge admin">Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge" style="background: #e7f1ff; color: #007aff;">User</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.isActive == true}">
                                        <span class="badge active">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge locked">Locked</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${user.isActive == true}">
                                    <form action="${pageContext.request.contextPath}/admin/user/lock.htm" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.id}"/>
                                        <button type="submit" class="btn-action btn-lock" title="Khóa">
                                            <i class="fa-solid fa-lock"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${user.isActive == false}">
                                    <form action="${pageContext.request.contextPath}/admin/user/unlock.htm" method="post" style="display:inline;">
                                        <input type="hidden" name="userId" value="${user.id}"/>
                                        <button type="submit" class="btn-action btn-unlock" title="Mở khóa">
                                            <i class="fa-solid fa-unlock"></i>
                                        </button>
                                    </form>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/admin/user/delete.htm" method="post" style="display:inline;">
                                    <input type="hidden" name="userId" value="${user.id}"/>
                                    <button type="submit" class="btn-action btn-delete" title="Xóa">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: #8e8e8e;">Chưa có người dùng nào!</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>

