<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Users Management - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #f6f6f6; display: flex; min-height: 100vh; }
        
        /* --- SIDEBAR --- */
        .sidebar { width: 240px; background-color: #b8c9c3; padding: 30px 20px; display: flex; flex-direction: column; position: fixed; height: 100vh; }
        .logo-area { text-align: center; margin-bottom: 50px; }
        .logo-area svg { width: 60px; height: auto; fill: #000; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a { display: flex; align-items: center; gap: 15px; text-decoration: none; color: #4a4a4a; font-size: 14px; font-weight: 600; padding: 12px 15px; border-radius: 20px; transition: all 0.3s; }
        .menu-item a:hover, .menu-item.active a { background-color: #ffffff; color: #000; box-shadow: 0 4px 10px rgba(0,0,0,0.03); }

        /* --- MAIN CONTENT --- */
        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; }

        /* Top Bar */
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .search-top { background: #fff; padding: 8px 16px; border-radius: 20px; display: flex; align-items: center; width: 250px; box-shadow: 0 2px 5px rgba(0,0,0,0.02); }
        .search-top input { border: none; outline: none; font-size: 13px; width: 100%; margin-left: 10px; }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }
        .admin-profile i { font-size: 20px; }

        .page-title { font-size: 24px; font-weight: 700; margin-bottom: 25px; }

        /* Overview Cards */
        .stats-container { display: flex; gap: 20px; margin-bottom: 30px; }
        .card { background: #fff; padding: 25px 20px; border-radius: 16px; width: 260px; display: flex; flex-direction: column; gap: 12px; position: relative; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .card-header { display: flex; justify-content: space-between; align-items: center; }
        .card-icon { width: 35px; height: 35px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
        .icon-orange { background: #ffe8cc; color: #e36009; }
        .icon-green { background: #e8f8f0; color: #2ecc71; }
        .card-dots { color: #ccc; cursor: pointer; font-size: 14px; }
        .card-title { font-size: 12px; color: #a0a0a0; font-weight: 500; }
        .card-value { font-size: 22px; font-weight: 700; color: #000; }

        /* Main Box (Filters + Table) */
        .content-box { background: #fff; border-radius: 20px; box-shadow: 0 4px 20px rgba(0,0,0,0.02); padding-bottom: 20px;}
        
        /* Filters */
        .filter-row { display: flex; gap: 20px; padding: 25px 30px; border-bottom: 1px solid #f4f6f8; flex-wrap: wrap;}
        .filter-group { display: flex; flex-direction: column; gap: 8px; }
        .filter-group label { font-size: 13px; font-weight: 600; color: #000; }
        .filter-input-wrap { position: relative; display: flex; align-items: center; }
        .filter-input-wrap i { position: absolute; left: 12px; color: #a0a0a0; font-size: 12px; }
        .filter-input { padding: 8px 12px 8px 32px; border: 1px solid #ccc; border-radius: 20px; font-size: 13px; outline: none; min-width: 260px; color: #555;}
        
        .table-title { font-size: 16px; font-weight: 700; padding: 25px 30px 15px 30px; }

        /* Table */
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { font-size: 13px; font-weight: 700; color: #000; padding: 15px 30px; background: #e2e8e6; border-bottom: 2px solid #ccc;}
        td { padding: 18px 30px; border-bottom: 1px solid #f4f6f8; font-size: 14px; font-weight: 600; color: #333;}
        
        /* Badges */
        .badge { padding: 6px 16px; border-radius: 20px; font-size: 12px; font-weight: 700; display: inline-block; text-align: center; min-width: 80px;}
        .badge.admin { background: #fdbb2d; color: #000; }
        .badge.user { background: #6da4f7; color: #000; }
        .badge.vip { background: #fdf6cc; color: #000; }
        
        .status-badge { padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; display: inline-flex; align-items: center; gap: 6px;}
        .status-badge .dot { width: 8px; height: 8px; border-radius: 50%; }
        .status-badge.active { background: #dff0d8; color: #000; }
        .status-badge.active .dot { background: #2ecc71; }
        .status-badge.banned { background: #f2dede; color: #000; }
        .status-badge.banned .dot { background: #e74c3c; }

        /* Actions */
        .actions-col { display: flex; gap: 15px; align-items: center; }
        .action-btn { color: #555; background: none; border: none; cursor: pointer; font-size: 15px; transition: color 0.2s; text-decoration: none;}
        .action-btn:hover { color: #000; }
    </style>
</head>
<body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="logo-area">
            <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <path d="M20 70 L35 25 L50 25 L35 70 Z" />
                <path d="M50 70 L65 25 L80 25 L65 70 Z" />
            </svg>
        </div>
        <ul class="menu-list">
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/dashboard.htm"><i class="fa-solid fa-border-all"></i> Dashboard</a></li>
            <li class="menu-item"><a href="#"><i class="fa-solid fa-box"></i> Products</a></li>
            <li class="menu-item active"><a href="#"><i class="fa-solid fa-users"></i> Users</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/orders.htm"><i class="fa-solid fa-truck"></i> Orders</a></li>
        </ul>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="topbar">
            <div class="search-top">
                <i class="fa-solid fa-magnifying-glass" style="color: #ccc;"></i>
                <input type="text" placeholder="Tìm kiếm">
            </div>
            <div class="admin-profile">
                <span>VinhNguyen</span>
                <i class="fa-regular fa-circle-user"></i>
            </div>
        </div>

        <h2 class="page-title">Users Management</h2>

        <div class="stats-container">
            <div class="card">
                <div class="card-header">
                    <div class="card-icon icon-orange"><i class="fa-solid fa-box-open"></i></div>
                    <i class="fa-solid fa-ellipsis card-dots"></i>
                </div>
                <!-- Corrected text based on user preference -->
                <div class="card-title">Total Users</div>
                <div class="card-value"><fmt:formatNumber value="${totalUsers}" pattern="#,###"/></div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <div class="card-icon icon-green"><i class="fa-solid fa-box"></i></div>
                    <i class="fa-solid fa-ellipsis card-dots"></i>
                </div>
                <div class="card-title">New Users (this month)</div>
                <div class="card-value">${newUsers}</div>
            </div>
        </div>

        <div class="content-box">
            <!-- Filter Section -->
            <div class="filter-row">
                <div class="filter-group">
                    <label>Search</label>
                    <div class="filter-input-wrap">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" id="searchInput" class="filter-input" placeholder="Search by name/ email/ ID">
                    </div>
                </div>
                <div class="filter-group">
                    <label>Role</label>
                    <div class="filter-input-wrap">
                        <select id="roleFilter" class="filter-input" style="padding-left: 15px;">
                            <option value="">All Roles</option>
                            <option value="Admin">Admin</option>
                            <option value="User">User</option>
                            <option value="Vip">Vip</option>
                        </select>
                    </div>
                </div>
                <div class="filter-group">
                    <label>Register date</label>
                    <div class="filter-input-wrap">
                        <i class="fa-regular fa-calendar"></i>
                        <input type="text" class="filter-input" placeholder="date(dd/mm/yyyy)">
                    </div>
                </div>
            </div>

            <h3 class="table-title">Users list</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="userTableBody">
                    <c:forEach var="item" items="${users}">
                        <tr class="user-row">
                            <td class="id-col">${item.id}</td>
                            <td class="name-col">${item.fullName}</td>
                            <td class="email-col">${item.email}</td>
                            <td class="role-col">
                                <c:choose>
                                    <c:when test="${item.role.roleName == 'Admin' || item.role.roleName == 'ADMIN'}">
                                        <span class="badge admin">Admin</span>
                                    </c:when>
                                    <c:when test="${item.role.roleName == 'User' || item.role.roleName == 'USER'}">
                                        <span class="badge user">User</span>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Default or VIP -->
                                        <span class="badge vip">${not empty item.role.roleName ? item.role.roleName : 'Vip'}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.isActive == null || item.isActive == true}">
                                        <span class="status-badge active"><span class="dot"></span> Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge banned"><span class="dot"></span> Banned</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="actions-col">
                                    <button class="action-btn" title="Edit"><i class="fa-solid fa-pen-clip"></i></button>
                                    <button class="action-btn" title="Delete"><i class="fa-regular fa-trash-can"></i></button>
                                    <button class="action-btn" title="Lock"><i class="fa-solid fa-lock"></i></button>
                                    <button class="action-btn" title="View"><i class="fa-solid fa-cube"></i></button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: #8e8e8e; padding: 30px;">Không có người dùng nào trong hệ thống!</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Frontend Filtering Logic -->
    <script>
        const searchInput = document.getElementById('searchInput');
        const roleFilter = document.getElementById('roleFilter');
        const rows = document.querySelectorAll('.user-row');

        function filterUsers() {
            const searchValue = searchInput.value.toLowerCase().trim();
            const roleValue = roleFilter.value.toLowerCase();

            rows.forEach(row => {
                const idText = row.querySelector('.id-col').textContent.toLowerCase();
                const nameText = row.querySelector('.name-col').textContent.toLowerCase();
                const emailText = row.querySelector('.email-col').textContent.toLowerCase();
                const roleBadge = row.querySelector('.role-col .badge');
                const roleText = roleBadge ? roleBadge.textContent.toLowerCase() : '';

                const matchesSearch = idText.includes(searchValue) || nameText.includes(searchValue) || emailText.includes(searchValue);
                const matchesRole = !roleValue || roleText.includes(roleValue);

                if (matchesSearch && matchesRole) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        searchInput.addEventListener('input', filterUsers);
        roleFilter.addEventListener('change', filterUsers);
    </script>
</body>
</html>
