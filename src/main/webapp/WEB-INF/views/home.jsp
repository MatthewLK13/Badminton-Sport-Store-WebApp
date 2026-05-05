<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Yonex</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .dashboard {
            background: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        h1 {
            color: #2ecc71; /* Màu xanh lá báo hiệu thành công */
            margin-bottom: 10px;
        }
        .user-name {
            font-size: 20px;
            font-weight: bold;
            color: #e36009; /* Màu cam Yonex */
            margin-bottom: 30px;
        }
        .btn-logout {
            display: inline-block;
            padding: 12px 24px;
            background-color: #000;
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            border-radius: 4px;
            transition: 0.2s;
        }
        .btn-logout:hover {
            background-color: #e36009;
        }
    </style>
</head>
<body>

    <div class="dashboard">
        <h1>Đăng nhập thành công! 🎉</h1>
        <p>Chào mừng bạn quay trở lại,</p>
        
        <!-- Hiển thị tên người dùng lấy từ Session -->
        <div class="user-name">${user.fullName}</div>
        
        <!-- Nút gọi về hàm /logout.htm trong LoginController -->
        <a href="${pageContext.request.contextPath}/logout.htm" class="btn-logout">Đăng xuất</a>
    </div>

</body>
</html>