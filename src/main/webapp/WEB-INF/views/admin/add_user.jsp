<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New User - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #eef2f3; display: flex; min-height: 100vh; }
        
        /* SIDEBAR */
        .sidebar {
            width: 240px; background-color: #b8c9c3; padding: 30px 20px;
            display: flex; flex-direction: column; border-right: 1px solid rgba(0,0,0,0.05);
            position: fixed; height: 100vh;
        }
        .logo-area { text-align: left; margin-bottom: 50px; padding-left: 15px; }
        .logo-area h3 { color: #888; font-weight: 600; font-size: 16px; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a {
            display: flex; align-items: center; gap: 15px; text-decoration: none;
            color: #111; font-size: 14px; font-weight: 600; padding: 12px 15px;
            border-radius: 20px; transition: all 0.3s;
        }
        .menu-item a:hover, .menu-item.active a {
            background-color: #ffffffc9; color: #000; box-shadow: 0 4px 10px rgba(0,0,0,0.03);
        }

        /* MAIN CONTENT */
        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; }
        
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .search-top {
            background: #fff; padding: 10px 16px; border-radius: 8px;
            display: flex; align-items: center; width: 350px; border: 1px solid #e0e0e0;
        }
        .search-top input { border: none; outline: none; font-size: 13px; width: 100%; margin-left: 10px; }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }
        
        /* FORM CONTAINER */
        .header-container { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .page-title { font-size: 24px; font-weight: 700; color: #111; }
        .btn-prev {
            background-color: #e2e2e2; color: #111; padding: 10px 20px; border-radius: 20px;
            text-decoration: none; font-weight: 600; font-size: 14px; display: flex; align-items: center; gap: 8px;
        }

        .form-container { width: 600px; }
        
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; font-size: 14px; font-weight: 700; color: #111; margin-bottom: 10px; }
        
        .form-control {
            width: 100%; padding: 15px 20px; border: 1px solid #ccc; border-radius: 20px;
            font-size: 14px; color: #333; background: #fff; outline: none;
        }
        .form-control::placeholder { color: #aaa; }
        
        select.form-control {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%23333" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 15px center;
        }

        .btn-save-container { margin-top: 40px; text-align: right; width: 600px; }
        .btn-save {
            background-color: #000; color: #fff; border: none; padding: 15px 40px;
            border-radius: 30px; font-size: 18px; font-weight: 700; cursor: pointer;
            display: inline-flex; align-items: center; gap: 10px; transition: 0.3s;
        }
        .btn-save:hover { background-color: #333; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        
        .error-msg { color: #e74c3c; font-size: 14px; font-weight: 500; margin-bottom: 20px; }
    </style>
</head>
<body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="logo-area">
            <h3>Desktop - 5</h3>
        </div>
        <ul class="menu-list">
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/dashboard.htm"><i class="fa-solid fa-border-all"></i> Dashboard</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/product/management.htm"><i class="fa-solid fa-bag-shopping"></i> Products</a></li>
            <li class="menu-item active"><a href="${pageContext.request.contextPath}/admin/users.htm"><i class="fa-solid fa-person"></i> Users</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/orders.htm"><i class="fa-solid fa-truck"></i> Orders</a></li>
        </ul>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="topbar">
            <div class="search-top">
                <i class="fa-solid fa-magnifying-glass" style="color:#aaa;"></i>
                <input type="text" placeholder="Tìm kiếm">
            </div>
            <div class="admin-profile">
                <span>VinhNguyen</span>
                <i class="fa-regular fa-circle-user" style="font-size: 24px;"></i>
            </div>
        </div>

        <div class="header-container">
            <h2 class="page-title">Add new user</h2>
            <a href="${pageContext.request.contextPath}/admin/users.htm" class="btn-prev">
                <i class="fa-solid fa-arrow-rotate-left"></i> Previous
            </a>
        </div>

        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/user/save.htm" method="POST" class="form-container">
            <div class="form-group">
                <label>User's name</label>
                <input type="text" name="fullName" class="form-control" placeholder="Giới hạn 40 ký tự" maxlength="40" required>
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
            </div>

            <div class="form-group">
                <label>Password (Mật khẩu khởi tạo)</label>
                <input type="password" name="password" class="form-control" placeholder="Tối thiểu 6 ký tự" minlength="6" required>
            </div>
            
            <div class="form-group">
                <label>Role</label>
                <select name="roleId" class="form-control" required>
                    <option value="" disabled selected>Choose or add new role</option>
                    <option value="1">Admin</option>
                    <option value="2">User</option>
                </select>
            </div>
            
            <div class="form-group" style="width: 250px;">
                <label>Status</label>
                <select name="status" class="form-control" required>
                    <option value="1">Active</option>
                    <option value="0">Banned/Locked</option>
                </select>
            </div>

            <div class="btn-save-container">
                <button type="submit" class="btn-save">
                    <i class="fa-solid fa-download"></i> Save
                </button>
            </div>
        </form>

    </div>

</body>
</html>
