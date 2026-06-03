<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yonex Forgot Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;600;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <h1 class="title-forgot">Quên mật khẩu</h1>
        <p class="sub-text">Quay lại trang <a href="${pageContext.request.contextPath}/login.htm">đăng nhập</a></p>

        <jsp:include page="components/forgot-form.jsp" />
    </div>

    <!-- Toast notification -->
    <div id="toast"></div>
    <script>
        function showToast(message, type) {
            const container = document.getElementById("toast");
            const toast = document.createElement("div");
            toast.className = "toast " + type;
            toast.innerText = message;
            container.appendChild(toast);
            setTimeout(() => toast.classList.add("show"), 100);
            setTimeout(() => {
                toast.classList.remove("show");
                setTimeout(() => toast.remove(), 400);
            }, 4000);
        }
        <% if (request.getAttribute("error") != null) { %>
            showToast("<%= request.getAttribute("error") %>", "error");
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            showToast("<%= request.getAttribute("success") %>", "success");
        <% } %>
    </script>

</body>
</html>