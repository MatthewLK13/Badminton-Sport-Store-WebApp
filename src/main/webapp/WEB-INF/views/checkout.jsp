<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Yonex Sport</title>
    
    <!-- Nhúng các file CSS dùng chung của dự án cho Header -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        
        /* Main Layout */
        .checkout-container { display: flex; max-width: 1100px; margin: 0 auto; min-height: 100vh; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif !important; }
        .checkout-container input, .checkout-container select, .checkout-container button { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif !important; }
        
        /* Left Column (Form) */
        .checkout-form-section { flex: 1.2; padding: 40px 40px 40px 0; }
        .section-title { font-size: 14px; font-weight: 500; text-transform: uppercase; margin-bottom: 15px; margin-top: 30px; letter-spacing: 0.5px; color: #333; }
        .section-title:first-child { margin-top: 0; }
        
        .form-group { margin-bottom: 15px; }
        .form-row { display: flex; gap: 15px; margin-bottom: 15px; }
        .form-col { flex: 1; }
        
        .checkout-container input[type="text"], .checkout-container input[type="email"], .checkout-container select {
            width: 100%; padding: 14px; border: 1px solid #ccc; border-radius: 2px; font-size: 14px; outline: none; transition: border-color 0.2s; color: #333; font-weight: 400;
        }
        .checkout-container input::placeholder { color: #888; font-weight: 300; }
        .checkout-container input:focus, .checkout-container select:focus { border-color: #000; }
        
        /* Payment Section */
        .payment-box { border: 1px solid #ccc; border-radius: 2px; overflow: hidden; margin-bottom: 20px; }
        .payment-header { display: flex; justify-content: space-between; align-items: center; padding: 14px 16px; background: #d2d0f5; border-bottom: 1px solid #ccc; }
        .payment-header span { font-weight: 500; font-size: 14px; color: #111;}
        .card-icons { display: flex; gap: 8px; }
        .card-icons img { width: 55px; height: 35px; object-fit: contain; background: #fff; padding: 4px; border-radius: 2px; border: 1px solid #ddd; }
        .payment-body { padding: 15px; background: #d9d9d9; display: flex; flex-direction: column; gap: 15px; }
        
        .btn-pay { width: 100%; background: #556ee6; color: #fff; border: none; padding: 14px; font-size: 15px; font-weight: 600; border-radius: 2px; cursor: pointer; transition: background 0.2s; letter-spacing: 0.5px; }
        .btn-pay:hover { background: #4557b5; }
        .secure-text { font-size: 12px; color: #666; margin-bottom: 15px; }
        
        /* Right Column (Summary) */
        .checkout-summary-section { flex: 1; background-color: #d2dbd3; padding: 40px; border-left: 1px solid #ccc; }
        
        .summary-item { display: flex; justify-content: space-between; margin-bottom: 25px; align-items: flex-start; }
        .item-details { display: flex; align-items: center; gap: 15px; }
        .item-img { width: 65px; height: 80px; background: #fff; border: 1px solid #ccc; display: flex; justify-content: center; align-items: center; padding: 5px; }
        .item-img img { max-width: 100%; max-height: 100%; opacity: 0.5; }
        .item-info { font-size: 14px; }
        .item-name { font-weight: 500; color: #333; margin-bottom: 5px; }
        .item-variant { color: #777; font-size: 12px; text-transform: uppercase; }
        .item-price { font-weight: 500; font-size: 13px; }
        
        .summary-totals { padding-top: 20px; margin-top: 30px; font-size: 13px; color: #333; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; }
        .summary-row.total { font-size: 16px; font-weight: 500; margin-top: 20px; border-top: 1px solid rgba(0,0,0,0.1); padding-top: 20px; }
        
        @media (max-width: 768px) {
            .checkout-container { flex-direction: column; }
            .checkout-form-section { padding: 20px; }
            .checkout-summary-section { padding: 20px; border-left: none; border-top: 1px solid #ccc; }
            .form-row { flex-direction: column; gap: 0; }
        }
    </style>
</head>
<body>

    <!-- Dùng Header dùng chung (Component) -->
    <jsp:include page="includes/header.jsp" />

    <div class="checkout-container">
        <!-- Form nhập liệu (Cột trái) -->
        <jsp:include page="components/checkout-form.jsp" />
        
        <!-- Tóm tắt đơn hàng (Cột phải) -->
        <jsp:include page="components/checkout-summary.jsp" />
    </div>

</body>
</html>
