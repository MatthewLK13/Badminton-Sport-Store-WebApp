<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trung tâm trợ giúp - Yonex Việt Nam</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { margin: 0; padding: 0; font-family: 'Inter', sans-serif; background: #ffffff; color: #333; }
        
        /* Navbar độc lập cho trang Help */
        .help-nav { display: flex; justify-content: space-between; align-items: center; padding: 15px 40px; background: #111111; color: #fff; }
        .help-nav .brand { font-weight: 900; font-size: 18px; letter-spacing: 1px; color: #fff; text-decoration: none; }
        .help-nav .brand span { color: #0066cc; }
        .help-nav .link-close { color: #ccc; text-decoration: none; font-size: 13px; }
        .help-nav .link-close:hover { color: #fff; }

        .help-hero { background: #f8f9fa; padding: 40px 20px; text-align: center; border-bottom: 1px solid #eee; }
        .help-hero h1 { font-weight: 300; font-size: 28px; margin: 0 0 10px 0; letter-spacing: 1px; }
        
        .help-container { max-width: 800px; margin: 40px auto; padding: 0 20px; }
        .faq-card { background: #fdfdfd; border: 1px solid #e5e5e5; border-radius: 6px; margin-bottom: 15px; padding: 20px; transition: all 0.2s; }
        .faq-card:hover { border-color: #0066cc; background: #fff; }
        .faq-q { font-weight: 700; font-size: 15px; color: #000; margin-bottom: 8px; display: flex; align-items: center; gap: 10px; }
        .faq-q i { color: #0066cc; }
        .faq-a { font-size: 13px; color: #666; line-height: 1.6; padding-left: 24px; }
        
        .footer-contact { text-align: center; margin-top: 5px; padding: 30px; background: #f9f9f9; border-radius: 6px; }
        .footer-contact h3 { margin: 0 0 8px 0; font-size: 15px; }
        .footer-contact p { font-size: 13px; color: #666; margin: 0; }
    </style>
</head>
<body>

    <nav class="help-nav">
        <a href="${pageContext.request.contextPath}/" class="brand">YONEX <span>SUPPORT</span></a>
        <a href="${pageContext.request.contextPath}/" class="link-close">Thoát trợ giúp &times;</a>
    </nav>

    <div class="help-hero">
        <h1>Chúng tôi có thể giúp gì cho bạn?</h1>
    </div>

    <div class="help-container">
        <div class="faq-card">
            <div class="faq-q"><i class="fa-solid fa-circle-question"></i> Làm thế nào để chọn đúng size giày?</div>
            <div class="faq-a">Bạn nên đo chiều dài bàn chân và đối chiếu với bảng size quy đổi. Khuyên dùng tăng thêm 0.5 size so với thông thường để tạo sự thoải mái tối đa khi thực hiện các bước di chuyển nhảy đập cầu.</div>
        </div>

        <div class="faq-card">
            <div class="faq-q"><i class="fa-solid fa-circle-question"></i> Thời gian xử lý đơn hàng và vận chuyển?</div>
            <div class="faq-a">Đơn hàng của bạn sẽ được đóng gói trong vòng 24 giờ kể từ khi đặt. Giao hàng nội thành dự kiến mất 1-2 ngày, các tỉnh thành khác từ 3-5 ngày.</div>
        </div>
        
        <div class="footer-contact">
            <h3>Cần trợ giúp trực tiếp?</h3>
            <p>Tổng đài CSKH miễn phí toàn quốc: <strong>1900 6789</strong> (8:00 - 18:00)</p>
        </div>
    </div>

</body>
</html>