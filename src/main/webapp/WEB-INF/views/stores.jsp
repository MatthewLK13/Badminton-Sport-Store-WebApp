<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hệ thống cửa hàng - Yonex Việt Nam</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { margin: 0; padding: 0; font-family: 'Inter', sans-serif; background: #fafafa; color: #333; }
        
        /* Navbar độc lập cho trang Stores */
        .custom-nav { display: flex; justify-content: space-between; align-items: center; padding: 15px 40px; background: #ffffff; border-bottom: 2px solid #0066cc; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .nav-brand { font-weight: 900; font-size: 18px; letter-spacing: 1px; color: #000; text-decoration: none; display: flex; align-items: center; gap: 10px; }
        .nav-brand span { font-size: 11px; background: #0066cc; color: #fff; padding: 2px 6px; font-weight: 600; letter-spacing: 0; }
        .back-home { text-decoration: none; color: #666; font-size: 13px; font-weight: 500; transition: color 0.2s; }
        .back-home:hover { color: #0066cc; }

        /* Bố cục nội dung */
        .main-content { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        .page-header-box { border-left: 4px solid #0066cc; padding-left: 15px; margin-bottom: 30px; }
        .page-title { font-weight: 300; font-size: 26px; letter-spacing: 1px; text-transform: uppercase; margin: 0; color: #111; }
        
        .store-layout { display: flex; gap: 30px; margin-top: 20px; }
        .store-list { flex: 4; display: flex; flex-direction: column; gap: 15px; }
        .store-item { background: #fff; padding: 20px; border: 1px solid #e5e5e5; border-radius: 4px; }
        .store-name { font-weight: 700; font-size: 15px; color: #0066cc; margin-bottom: 10px; letter-spacing: 0.5px; }
        .store-info { font-size: 13px; color: #555; margin-bottom: 6px; display: flex; align-items: center; gap: 10px; }
        .store-info i { color: #0066cc; width: 14px; }
        
        .map-wrapper { flex: 6; background: #fff; border: 1px solid #e5e5e5; border-radius: 4px; padding: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.02); }
    </style>
</head>
<body>

    <nav class="custom-nav">
        <a href="${pageContext.request.contextPath}/" class="nav-brand">YONEX <span>STORES</span></a>
        <a href="${pageContext.request.contextPath}/" class="back-home"><i class="fa-solid fa-arrow-left"></i> Quay về trang chủ</a>
    </nav>

    <div class="main-content">
        <div class="page-header-box">
            <h1 class="page-title">Hệ thống cửa hàng ủy quyền</h1>
        </div>
        
        <div class="store-layout">
            <div class="store-list">
                <div class="store-item">
                    <div class="store-name">CHUYÊN DỤNG YONEX - QUẬN 9</div>
                    <div class="store-info"><i class="fa-solid fa-location-dot"></i> 97 Man Thiện, Phường Hiệp Phú, Quận 9, TP. HCM</div>
                    <div class="store-info"><i class="fa-solid fa-phone"></i> Hotline: 028.3730.5555</div>
                    <div class="store-info"><i class="fa-solid fa-clock"></i> Giờ mở cửa: 08:00 - 22:00</div>
                </div>
                
                <div class="store-item">
                    <div class="store-name">YONEX PREMIUM - BÌNH THẠNH</div>
                    <div class="store-info"><i class="fa-solid fa-location-dot"></i> 120 Điện Biên Phủ, Phường 25, Quận Bình Thạnh, TP. HCM</div>
                    <div class="store-info"><i class="fa-solid fa-phone"></i> Hotline: 028.3840.1234</div>
                    <div class="store-info"><i class="fa-solid fa-clock"></i> Giờ mở cửa: 08:00 - 21:30</div>
                </div>
            </div>
            
           <div class="map-wrapper">
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.479599557458!2d106.772594675906!3d10.851082957813206!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752763f915433d%3A0x6b8eb6a7cbdf5650!2zSOG7jWMgdmnhu4duIEPDtG5nIG5naOG7hyBCxrB1IGNow61uaCBWaeG7hW4gdGjDtG5nIChDbyBz4bufIDIp!5e0!3m2!2svi!2s!4v1716000000000!5m2!2svi!2s" 
            width="100%" 
            height="400" 
            style="border:0;">
    </iframe>
</div>
            </div>
        </div>
    

</body>
</html>