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
        body { background-color: #f1f3f2; display: flex; min-height: 100vh; }
        
        /* --- SIDEBAR --- */
        .sidebar { width: 240px; background-color: #b8c9c3; padding: 30px 20px; display: flex; flex-direction: column; position: fixed; height: 100vh; }
        .logo-area { text-align: center; margin-bottom: 50px; }
        .logo-area svg { width: 60px; height: auto; fill: #000; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a { display: flex; align-items: center; gap: 15px; text-decoration: none; color: #4a4a4a; font-size: 14px; font-weight: 600; padding: 12px 15px; border-radius: 20px; transition: all 0.3s; }
        .menu-item a:hover, .menu-item.active a { background-color: #ffffff; color: #000; box-shadow: 0 4px 10px rgba(0,0,0,0.03); }

        /* --- MAIN CONTENT --- */
        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; display: flex; flex-direction: column;}

        /* Top Bar */
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .search-top { background: #fff; padding: 8px 16px; border-radius: 20px; display: flex; align-items: center; width: 250px; box-shadow: 0 2px 5px rgba(0,0,0,0.02); }
        .search-top input { border: none; outline: none; font-size: 13px; width: 100%; margin-left: 10px; }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }
        .admin-profile i { font-size: 20px; }

        /* Header Area */
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .page-title { font-size: 22px; font-weight: 700; color: #000; }
        .btn-previous { 
            background-color: #e2e8e6; color: #000; text-decoration: none;
            padding: 10px 20px; border-radius: 25px; font-size: 14px; font-weight: 600;
            display: flex; align-items: center; gap: 8px; transition: background 0.3s;
        }
        .btn-previous:hover { background-color: #d1dbd8; }

        /* Form Area */
        .form-container { display: flex; flex-direction: column; gap: 25px; max-width: 600px; }
        .form-group { display: flex; flex-direction: column; gap: 10px; }
        .form-group label { font-size: 14px; font-weight: 700; color: #000; }
        
        .form-control {
            width: 100%; padding: 15px 20px; border: 1px solid #ccc;
            border-radius: 20px; font-size: 14px; outline: none;
            background-color: #fff; color: #333; transition: border-color 0.3s;
        }
        .form-control:focus { border-color: #000; }
        select.form-control { appearance: none; cursor: pointer; }
        
        .select-wrapper { position: relative; }
        .select-wrapper i { position: absolute; right: 20px; top: 50%; transform: translateY(-50%); pointer-events: none; color: #555;}

        /* Save Button Container */
        .action-container { margin-top: 20px; display: flex; justify-content: flex-end; max-width: 600px; }
        .btn-save {
            background-color: #050a04; color: #fff; border: none; cursor: pointer;
            padding: 15px 40px; border-radius: 40px; font-size: 20px; font-weight: 700;
            display: flex; align-items: center; gap: 12px; transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }
        .btn-save i { background: #fff; color: #000; padding: 5px; border-radius: 4px; font-size: 14px; }
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
            <li class="menu-item active"><a href="${pageContext.request.contextPath}/admin/users.htm"><i class="fa-solid fa-users"></i> Users</a></li>
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

        <div class="page-header">
            <h2 class="page-title">Add new User</h2>
            <a href="${pageContext.request.contextPath}/admin/users.htm" class="btn-previous">
                <i class="fa-solid fa-arrow-turn-up" style="transform: rotate(-90deg);"></i> Previous
            </a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/save-user.htm" method="POST" class="form-container">
            
            <div class="form-group">
                <label>User's name</label>
                <input type="text" name="fullName" class="form-control" placeholder="Giới hạn 40 ký tự" maxlength="40" required>
            </div>

            <div class="form-group">
                <label>Email</label>
                <!-- Đã sửa lỗi logic: Đổi từ select sang input type email -->
                <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
            </div>
            
            <div class="form-group">
                <label>Password</label>
                <!-- Bổ sung trường mật khẩu theo yêu cầu -->
                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu an toàn..." required>
            </div>

            <div class="form-group">
                <label>Role</label>
                <div class="select-wrapper">
                    <select name="roleId" class="form-control" required>
                        <option value="" disabled selected>Choose role</option>
                        <c:forEach var="r" items="${roles}">
                            <option value="${r.id}">${r.roleName}</option>
                        </c:forEach>
                    </select>
                    <i class="fa-solid fa-chevron-down"></i>
                </div>
            </div>

            <div class="form-group" style="width: 50%;">
                <label>Status</label>
                <div class="select-wrapper">
                    <select name="isActive" class="form-control">
                        <option value="true">Active</option>
                        <option value="false">Banned</option>
                    </select>
                    <i class="fa-solid fa-chevron-down"></i>
                </div>
            </div>

            <div class="action-container">
                <button type="submit" class="btn-save">
                    <i class="fa-solid fa-arrow-down"></i> Save
                </button>
            </div>
        </form>

    </div>
</body>
</html>
