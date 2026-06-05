<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Athlete Profile - Seo Seung-jae và Kim Won-ho</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background-color: #ffffff; color: #000; }

        .hero-section {
            position: relative;
            width: 100%;
            height: 500px;
            background: url('${pageContext.request.contextPath}/images/image16.png') no-repeat center center;
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
        .hero-content h1 { font-size: 50px; font-weight: 800; text-transform: uppercase; margin-bottom: 10px; display: flex; align-items: center; }
        .hero-content p { font-size: 20px; margin-top: 5px; opacity: 0.9; }

        .bio-section { max-width: 800px; margin: 50px auto; padding: 20px; text-align: center; line-height: 1.8; }
        .bio-section h3 { margin: 30px 0 15px 0; font-size: 24px; color: #333; }
    </style>
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">
    <%@include file="/WEB-INF/views/includes/header.jsp" %>

    <section class="hero-section">
        <div class="hero-content">
            <h1>
                <img src="https://upload.wikimedia.org/wikipedia/commons/0/09/Flag_of_South_Korea.svg" 
                     alt="South Korea Flag" 
                     style="width: 50px; vertical-align: middle; margin-right: 15px; border-radius: 4px;">
                SEO SEUNG-JAE và KIM WON-HO
            </h1>
            <p>Quốc tịch: HÀN QUỐC</p>
            <p>Bộ môn: ĐÔI NAM (BADMINTON MEN'S DOUBLES)</p>
        </div>
    </section>

    <section class="bio-section">
        <p>Seo Seung-jae và Kim Won-ho là một trong những cặp đôi nam chủ lực của cầu lông Hàn Quốc. Với sự phối hợp ăn ý giữa sức mạnh tấn công của Seo Seung-jae và sự bao quát sân, điều cầu thông minh của Kim Won-ho, cặp đôi này luôn là đối thủ khó chịu đối với mọi tay vợt hàng đầu thế giới.</p>
        
        <h3>Thành tích nổi bật:</h3>
        <p>Thứ hạng cao trên bảng xếp hạng BWF Men's Doubles</p>
        <p>Giành nhiều huy chương tại các giải đấu thuộc hệ thống BWF World Tour</p>
        <p>Đóng góp quan trọng vào thành công của đội tuyển cầu lông Hàn Quốc tại các giải đấu đồng đội quốc tế</p>
    </section>
    
</body>
</html>