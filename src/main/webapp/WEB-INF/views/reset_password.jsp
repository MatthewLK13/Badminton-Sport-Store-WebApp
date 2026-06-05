<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yonex Reset Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 400px;
            margin: 80px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .title-reset {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
        }
        .sub-text {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }
        .input-field {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .btn-reset {
            width: 100%;
            padding: 12px;
            background: #e36009;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
        }
        .btn-reset:hover {
            background: #c45508;
        }
        .alert {
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .alert.error {
            background: #fee;
            border: 1px solid #f00;
            color: #c00;
        }
        .alert.success {
            background: #efe;
            border: 1px solid #0a0;
            color: #060;
        }
    </style>
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">

    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <h1 class="title-reset">Đặt lại mật khẩu</h1>
        <p class="sub-text">Nhập mật khẩu mới cho tài khoản của bạn</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/reset-password.htm" method="post">
            <input type="hidden" name="token" value="${token}">

            <input type="password" name="password" class="input-field"
                   placeholder="Mật khẩu mới" required>

            <input type="password" name="confirmPassword" class="input-field"
                   placeholder="Xác nhận mật khẩu mới" required>

            <button type="submit" class="btn-reset">Đặt lại mật khẩu</button>
        </form>
    </div>

</body>
</html>
