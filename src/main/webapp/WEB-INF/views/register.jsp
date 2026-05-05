<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yonex Register</title>
    <!-- Font & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <h1>Đăng ký</h1>
        <p class="sub-text">Đã có tài khoản, đăng nhập <a href="${pageContext.request.contextPath}/login.htm">tại đây</a></p>

        <!-- 3. NHÚNG FORM ĐĂNG KÝ -->
        <jsp:include page="components/register-form.jsp" />
    </div>

</body>
</html>