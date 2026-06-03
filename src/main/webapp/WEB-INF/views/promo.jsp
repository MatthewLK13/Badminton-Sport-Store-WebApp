<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chương Trình Ưu Đãi - YONEX</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .promo-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
        }
        .promo-breadcrumbs {
            font-size: 11px;
            color: #888;
            margin-bottom: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .promo-breadcrumbs a {
            color: #888;
            text-decoration: none;
        }
        .promo-breadcrumbs a:hover {
            color: #000;
        }
        
        /* Banner Khuyến Mãi */
        .promo-hero-banner {
            background: linear-gradient(135deg, #111 0%, #002b5c 100%);
            color: #fff;
            padding: 60px 40px;
            text-align: center;
            border-radius: 8px;
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .promo-hero-banner::before {
            content: '';
            position: absolute;
            top: 0; right: 0; bottom: 0; left: 0;
            background: url('https://www.transparenttextures.com/patterns/cubes.png');
            opacity: 0.1;
        }
        .promo-tag {
            background-color: #e74c3c;
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            padding: 5px 15px;
            border-radius: 20px;
            text-transform: uppercase;
            display: inline-block;
            margin-bottom: 15px;
            letter-spacing: 1px;
        }
        .promo-hero-banner h1 {
            font-family: 'Impact', 'Arial Black', sans-serif;
            font-size: 42px;
            letter-spacing: 2px;
            margin: 0 0 15px 0;
            text-transform: uppercase;
        }
        .promo-hero-banner p {
            font-size: 16px;
            font-weight: 300;
            max-width: 600px;
            margin: 0 auto 25px auto;
            color: #ddd;
            line-height: 1.6;
        }
        
        /* Khung chứa các mã giảm giá (Voucher) */
        .voucher-section-title {
            font-family: 'Impact', 'Arial Black', sans-serif;
            font-size: 22px;
            letter-spacing: 1px;
            border-bottom: 2px solid #111;
            padding-bottom: 10px;
            margin-bottom: 25px;
            text-transform: uppercase;
        }
        .vouchers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 25px;
            margin-bottom: 50px;
        }
        .voucher-card {
            display: flex;
            background: #fff;
            border: 1px dashed #0056b3;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            transition: transform 0.3s;
        }
        .voucher-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.05);
        }
        .voucher-left {
            background: #0056b3;
            color: #fff;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 120px;
            flex-shrink: 0;
            text-align: center;
            border-right: 1px dashed #fff;
            position: relative;
        }
        /* Tạo hiệu ứng răng cưa vé */
        .voucher-left::after {
            content: '';
            position: absolute;
            right: -5px; top: 0; bottom: 0;
            width: 10px;
            background-image: radial-gradient(circle, #fff 3px, transparent 3px);
            background-size: 10px 10px;
        }
        .voucher-value {
            font-size: 24px;
            font-weight: 800;
        }
        .voucher-type {
            font-size: 11px;
            text-transform: uppercase;
            margin-top: 4px;
            opacity: 0.8;
        }
        .voucher-right {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .voucher-title {
            font-size: 15px;
            font-weight: 700;
            margin: 0 0 5px 0;
            color: #111;
        }
        .voucher-desc {
            font-size: 12px;
            color: #666;
            margin: 0 0 15px 0;
            font-weight: 300;
        }
        .voucher-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .voucher-code {
            font-family: 'Courier New', Courier, monospace;
            font-size: 14px;
            font-weight: 700;
            background: #f1f1f1;
            padding: 4px 8px;
            border: 1px solid #ddd;
            color: #333;
        }
        .btn-copy-code {
            background: #111;
            color: #fff;
            border: none;
            padding: 6px 12px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 4px;
            text-transform: uppercase;
            transition: background 0.2s;
        }
        .btn-copy-code:hover {
            background: #0056b3;
        }

        /* Nút quay lại mua sắm */
        .promo-action-box {
            text-align: center;
            margin-top: 20px;
        }
        .btn-back-to-shop {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background-color: #0056b3;
            color: #fff;
            text-decoration: none;
            padding: 12px 30px;
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            border-radius: 4px;
            transition: background 0.2s;
        }
        .btn-back-to-shop:hover {
            background-color: #004085;
        }
    </style>
</head>
<body>

    <div class="promo-container">
        
        <div class="promo-breadcrumbs">
            <a href="${pageContext.request.contextPath}/">Trang chủ</a> / <span>Chương trình ưu đãi</span>
        </div>
        
        <div class="promo-hero-banner">
            <span class="promo-tag">Khuyến mãi giới hạn</span>
            <h1>YONEX SUPER SALE</h1>
            
            <p>
               <c:if test="${not empty message}">
    <c:out value="${message}" />
</c:if>
<c:if test="${empty message}">
    Nâng tầm phong độ với những trang bị thi đấu đỉnh cao. Áp dụng mã giảm giá ngay hôm nay để nhận ưu đãi lên đến 30% cho toàn bộ phối màu mới!
</c:if>
            </p>
        </div>

        <h2 class="voucher-section-title">MÃ GIẢM GIÁ ĐANG DIỄN RA</h2>
        
        <div class="vouchers-grid">
            
            <div class="voucher-card">
                <div class="voucher-left">
                    <span class="voucher-value">10%</span>
                    <span class="voucher-type">GIẢM THẲNG</span>
                </div>
                <div class="voucher-right">
                    <div>
                        <h4 class="voucher-title">Ưu đãi bộ môn Cầu Lông</h4>
                        <p class="voucher-desc">Giảm ngay 10% cho các dòng vợt ASTROX thế hệ mới và giày bám sân.</p>
                    </div>
                    <div class="voucher-footer">
                        <span class="voucher-code">YONEXBAD10</span>
                        <button type="button" class="btn-copy-code" onclick="copyVoucher('YONEXBAD10', this)">SAO CHÉP</button>
                    </div>
                </div>
            </div>

            <div class="voucher-card">
                <div class="voucher-left" style="background-color: #e74c3c; border-color: #e74c3c;">
                    <span class="voucher-value">$20</span>
                    <span class="voucher-type">VOUCHER</span>
                </div>
                <div class="voucher-right">
                    <div>
                        <h4 class="voucher-title">Chào mừng thành viên mới</h4>
                        <p class="voucher-desc">Áp dụng cho đơn hàng quần áo thể thao (Apparel) từ $100 trở lên.</p>
                    </div>
                    <div class="voucher-footer">
                        <span class="voucher-code">YONEXNEW20</span>
                        <button type="button" class="btn-copy-code" onclick="copyVoucher('YONEXNEW20', this)" style="background-color: #111;">SAO CHÉP</button>
                    </div>
                </div>
            </div>

        </div> <div class="promo-action-box">
            <a href="${pageContext.request.contextPath}/products.htm" class="btn-back-to-shop">
                <i class="fa-solid fa-bag-shopping"></i> QUAY LẠI MUA SẮM NGAY
            </a>
        </div>

    </div> <script type="text/javascript">
        function copyVoucher(code, button) {
            navigator.clipboard.writeText(code).then(() => {
                const originalText = button.innerText;
                button.innerText = "ĐÃ LƯU!";
                button.style.backgroundColor = "#2ecc71";
                
                setTimeout(() => {
                    button.innerText = originalText;
                    button.style.backgroundColor = "";
                }, 2000);
            }).catch(err => {
                alert("Không thể sao chép mã, bạn hãy copy tay nhé: " + code);
            });
        }
    </script>
</body>
</html>