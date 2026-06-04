<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tư vấn vợt cầu lông - Yonex Sport</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot-page.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
    <div class="chatbot-page">
        <header class="chatbot-page-header">
            <h1>Tư vấn vợt cầu lông</h1>
            <a href="${pageContext.request.contextPath}/home.htm" class="btn-back">
                <i class="fa-solid fa-arrow-left"></i> Quay lại
            </a>
        </header>

        <div class="chatbot-messages">
            <c:if test="${empty chatHistory}">
                <div class="message bot">
                    Xin chào! Tôi có thể giúp bạn tìm vợt cầu lông phù hợp.
                    Hãy cho tôi biết trình độ chơi, phong cách chơi và ngân sách của bạn nhé!
                </div>
            </c:if>

            <c:forEach var="msg" items="${chatHistory}">
                <div class="message ${msg.role}">
                    ${fn:escapeXml(msg.content)}
                </div>
            </c:forEach>

            <c:if test="${not empty reply}">
                <div class="message bot">
                    ${fn:escapeXml(reply)}
                </div>
            </c:if>
        </div>

        <form action="${pageContext.request.contextPath}/chatbot.htm" method="post" class="chatbot-input-area">
            <input type="text" name="message" placeholder="Nhập tin nhắn..." required>
            <button type="submit">Gửi</button>
        </form>

        <div class="chatbot-actions">
            <a href="${pageContext.request.contextPath}/chatbot/reset.htm" class="btn-reset">
                <i class="fa-solid fa-redo"></i> Reset cuộc trò chuyện
            </a>
        </div>
    </div>
</body>
</html>
