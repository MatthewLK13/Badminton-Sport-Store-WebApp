<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yonex - Trang chủ</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background: #fff; padding-top: 30px; }
        .black-bar { width: 100%; height: 30px; background: #000; position: fixed; top: 0; z-index: 1000; }
        header { width: 100%; padding: 10px 40px; border-bottom: 1px solid #eee; }
        .top-links { display: flex; justify-content: flex-end; gap: 20px; font-size: 11px; margin-bottom: 8px; }
        .top-links a { text-decoration: none; color: #000; }
        .navbar { display: flex; align-items: center; justify-content: space-between; }
        .logo-container { display: flex; flex-direction: column; align-items: center; transform: translateY(-8px); }
        .logo-container img { height: 25px; width: auto; }
        .logo-text { font-size: 12px; font-weight: 900; margin-top: 2px; }
        .nav-center { display: flex; gap: 20px; list-style: none; }
        .nav-center a { text-decoration: none; color: #000; font-weight: 800; font-size: 11px; }

       
        .container { width: 100%; max-width: 800px; margin: 100px auto; text-align: center; }
        h2 { font-family: 'Impact', sans-serif; color: #e36009; font-size: 45px; margin-bottom: 20px; }
        .welcome-box { background: #f9f9f9; padding: 40px; border-radius: 8px; border: 1px solid #eee; }
        .user-name { font-size: 24px; font-weight: 700; color: #333; margin: 10px 0; }
        .btn-logout { background: #000; color: #fff; padding: 12px 30px; border: none; font-weight: 600; cursor: pointer; margin-top: 20px; }

        
        #toast { position: fixed; top: 50px; right: 20px; z-index: 2000; }
        .toast { padding: 15px 25px; border-radius: 4px; color: #fff; margin-bottom: 10px; opacity: 0; transition: 0.4s; }
        .toast.success { background: #2ecc71; }
        .toast.error { background: #e74c3c; }
        .toast.show { opacity: 1; transform: translateY(10px); }
    </style>
</head>
<body>

<div class="black-bar"></div>

<header>
    <div class="top-links">
        <a href="#">Trợ giúp</a>
        <a href="#">Theo dõi đơn hàng</a>
        <a href="${pageContext.request.contextPath}/logout.htm">Đăng xuất</a>
        <a href="#">VI</a>
    </div>
    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/yonex-logo.png" alt="Yonex Logo">
            <span class="logo-text">YONEX</span>
        </div>
        <ul class="nav-center">
            <li><a href="#">TRANG CHỦ</a></li>
            <li><a href="#">SẢN PHẨM</a></li>
            <li><a href="#">SALES</a></li>
        </ul>
    </div>
</header>

<div class="container">
   
<div class="welcome-box">
    <h2>Hệ thống Yonex</h2>
    <% 
        
        com.sport.entity.User userObj = (com.sport.entity.User) session.getAttribute("user");
        if(userObj != null){ 
    %>
        <p>Xin chào mừng trở lại,</p>
        <p class="user-name"><%= userObj.getFullName() %></p>
        <p style="font-size: 12px; color: #666;"><%= userObj.getEmail() %></p>
    <% } else { %>
        <p>Vui lòng <a href="${pageContext.request.contextPath}/login.htm">đăng nhập</a>.</p>
    <% } %>
</div>
</div>

<div id="toast"></div>

<script>
function showToast(message, type = "success") {
    const toastContainer = document.getElementById("toast");
    const toast = document.createElement("div");
    toast.className = `toast ${type}`;
    toast.innerText = message;
    toastContainer.appendChild(toast);
    setTimeout(() => toast.classList.add("show"), 100);
    setTimeout(() => {
        toast.classList.remove("show");
        setTimeout(() => toast.remove(), 400);
    }, 3000);
}

<% if(request.getAttribute("success") != null){ %>
    showToast("<%=request.getAttribute("success")%>", "success");
<% } %>
<% if(request.getAttribute("error") != null){ %>
    showToast("<%=request.getAttribute("error")%>", "error");
<% } %>
</script>

</body>
</html>