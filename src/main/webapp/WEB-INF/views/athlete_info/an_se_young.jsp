<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Athlete Profile - An Se Young</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background-color: #ffffff; color: #000; }

        .hero-section {
            position: relative;
            width: 100%;
            height: 500px;
            background: url('${pageContext.request.contextPath}/images/image10.png') no-repeat center center;
            background-size: cover;
            display: flex;
            align-items: center;
            padding: 0 80px;
            color: #fff;
        }

        .hero-section::before {
            content: ''; position: absolute; top: 0; left: 0; width: 60%; height: 100%;
            background: linear-gradient(to right, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0) 100%);
        }

        .hero-content { position: relative; z-index: 1; }
        .hero-content h1 { font-size: 56px; font-weight: 800; text-transform: uppercase; margin-bottom: 10px; display: flex; align-items: center; }
        .hero-content .flag { margin-right: 15px; }
        .hero-content p { font-size: 20px; margin-top: 5px; opacity: 0.9; }

        .bio-section { max-width: 800px; margin: 50px auto; padding: 20px; text-align: center; line-height: 1.8; }
        .bio-section h3 { margin: 30px 0 15px 0; font-size: 24px; color: #333; }
    </style>
</head>
<body>
    <%@include file="/WEB-INF/views/includes/header.jsp" %>

    <section class="hero-section">
        <div class="hero-content">
          
  <h1>
    <img src="https://upload.wikimedia.org/wikipedia/commons/0/09/Flag_of_South_Korea.svg" 
         alt="South Korea Flag" 
         style="width: 50px; vertical-align: middle; margin-right: 15px; border-radius: 4px;">
    AN SE YOUNG
</h1>
            <p>Quốc tịch: HÀN QUỐC</p>
            <p>Bộ môn: CẦU LÔNG</p>
        </div>
    </section>

    <section class="bio-section">
        <p>An Se-young là một trong những tay vợt đơn nữ xuất sắc nhất thế giới hiện nay. Với lối chơi bền bỉ, kỹ thuật phòng thủ phản công đỉnh cao và tinh thần thi đấu kiên cường, cô đã vươn lên trở thành biểu tượng mới của cầu lông Hàn Quốc và thế giới.</p>
        
        <h3>Thành tích nổi bật:</h3>
        <p>Huy chương vàng Đơn nữ - Thế vận hội Olympic Paris 2024</p>
        <p>Vô địch Giải Cầu lông Thế giới năm 2023</p>
        <p>Liên tục đứng đầu bảng xếp hạng BWF Thế giới</p>
        
    </section>
    
</body>
</html>