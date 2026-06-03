<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Theo dõi đơn hàng - Yonex Việt Nam</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { margin: 0; padding: 0; font-family: 'Inter', sans-serif; background: #f3f4f6; color: #333; display: flex; flex-direction: column; min-height: 100vh; }
        
        /* Navbar độc lập cho trang Tracking */
        .track-nav { display: flex; justify-content: space-between; align-items: center; padding: 15px 40px; background: #ffffff; border-bottom: 1px solid #e5e7eb; }
        .track-nav .brand { font-weight: 900; font-size: 18px; letter-spacing: 1px; color: #000; text-decoration: none; }
        .track-nav .link-back { color: #4b5563; text-decoration: none; font-size: 13px; }

        .track-container { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px 20px; }
        .track-card { background: #ffffff; padding: 40px; width: 100%; max-width: 480px; border-radius: 8px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        .track-header { text-align: center; margin-bottom: 30px; }
        .track-header i { font-size: 40px; color: #0066cc; margin-bottom: 15px; }
        .track-header h1 { font-size: 22px; font-weight: 700; margin: 0 0 8px 0; color: #111; }
        .track-header p { font-size: 13px; color: #6b7280; margin: 0; line-height: 1.5; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 11px; font-weight: 700; text-transform: uppercase; color: #374151; margin-bottom: 6px; letter-spacing: 0.5px; }
        .form-group input { width: 100%; padding: 12px; border: 1px solid #d1d5db; border-radius: 4px; font-size: 14px; box-sizing: border-box; outline: none; }
        .form-group input:focus { border-color: #0066cc; box-shadow: 0 0 0 3px rgba(0,102,204,0.1); }
        
        .btn-submit { width: 100%; padding: 14px; background: #0066cc; color: #ffffff; border: none; font-size: 13px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; border-radius: 4px; cursor: pointer; transition: background 0.2s; }
        .btn-submit:hover { background: #0052a3; }
    </style>
</head>
<body>

    <nav class="track-nav">
        <a href="${pageContext.request.contextPath}/" class="brand">YONEX TRACKING</a>
        <a href="${pageContext.request.contextPath}/" class="link-back"><i class="fa-solid fa-house"></i> Về trang chủ</a>
    </nav>

    <div class="track-container">
        <div class="track-card">
            <div class="track-header">
                <i class="fa-solid fa-truck-ramp-box"></i>
                <h1>Theo dõi đơn hàng</h1>
                <p>Nhập các thông tin dưới đây để kiểm tra hành trình vận chuyển kiện hàng của bạn.</p>
            </div>
            
            <form action="${pageContext.request.contextPath}/order-tracking.htm" method="POST">
                <div class="form-group">
                    <label for="orderId">Mã đơn hàng *</label>
                    <input type="text" id="orderId" name="orderId" placeholder="Ví dụ: YNX987654" required>
                </div>
                
                <div class="form-group">
                    <label for="billingEmail">Email đăng ký mua hàng *</label>
                    <input type="email" id="billingEmail" name="billingEmail" placeholder="name@example.com" required>
                </div>
                
                <button type="submit" class="btn-submit">Tra cứu ngay</button>
            </form>
        </div>
    </div>

</body>
</html>