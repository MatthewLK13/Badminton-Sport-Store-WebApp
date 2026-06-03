<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yonex - Trang chủ</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { width: 100%; max-width: 800px; margin: 100px auto; text-align: center; }
        h2 { font-family: 'Impact', sans-serif; color: #e36009; font-size: 45px; margin-bottom: 20px; }
        .welcome-box { background: #f9f9f9; padding: 40px; border-radius: 8px; border: 1px solid #eee; }
        .user-name { font-size: 24px; font-weight: 700; color: #333; margin: 10px 0; }
    </style>
</head>
<body>

    <%-- Dùng header chung --%>
    <jsp:include page="includes/header.jsp" />

    <div class="container">
        <div class="welcome-box">
            <h2>Hệ thống Yonex</h2>
            <%
                com.sport.entity.User userObj = (com.sport.entity.User) session.getAttribute("user");
                if (userObj != null) {
            %>
                <p>Xin chào mừng trở lại,</p>
                <p class="user-name"><%= userObj.getFullName() %></p>
                <p style="font-size: 12px; color: #666;"><%= userObj.getEmail() %></p>
            <% } else { %>
                <p>Vui lòng <a href="${pageContext.request.contextPath}/login.htm">đăng nhập</a>.</p>
            <% } %>
        </div>
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
            }, 3000);
        }
        <% if (request.getAttribute("success") != null) { %>
            showToast("<%= request.getAttribute("success") %>", "success");
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            showToast("<%= request.getAttribute("error") %>", "error");
        <% } %>
    </script>

</body>
</html>