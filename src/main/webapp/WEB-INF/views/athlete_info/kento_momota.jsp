<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Athlete Profile - Kento Momota</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background-color: #ffffff; color: #000; }

        .hero-section {
            position: relative;
            width: 100%;
            height: 500px;
            /* Đổi đường dẫn ảnh nền thành ảnh của Kento Momota */
            background: url('${pageContext.request.contextPath}/images/image11.png') no-repeat center center;
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
                <img src="https://upload.wikimedia.org/wikipedia/commons/9/9e/Flag_of_Japan.svg" 
                     alt="Japan Flag" 
                     style="width: 50px; vertical-align: middle; margin-right: 15px; border-radius: 4px;">
                KENTO MOMOTA
            </h1>
            <p>Quốc tịch: NHẬT BẢN</p>
            <p>Bộ môn: CẦU LÔNG</p>
        </div>
    </section>

    <section class="bio-section">
        <p>Kento Momota được mệnh danh là "thiên tài" của cầu lông Nhật Bản. Với khả năng kiểm soát cầu tinh tế, tư duy chiến thuật nhạy bén và lối chơi đầy cảm hứng, anh từng thống trị bảng xếp hạng thế giới và giành được nhiều danh hiệu cao quý trong sự nghiệp.</p>
        
        <h3>Thành tích nổi bật:</h3>
        <p>2 lần Vô địch Thế giới (2018, 2019)</p>
        <p>Huy chương vàng Giải vô địch Châu Á (2018, 2019)</p>
        <p>Kỷ lục 11 danh hiệu trong một mùa giải (2019)</p>
    </section>
    
</body>
</html>