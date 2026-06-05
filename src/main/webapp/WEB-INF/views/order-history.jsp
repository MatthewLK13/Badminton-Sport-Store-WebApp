<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="order.history.page" text="Order History" /> - Yonex</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .breadcrumb {
            padding: 12px 40px;
            font-size: 13px;
            color: #999;
            border-bottom: 1px solid #f0f0f0;
        }
        .breadcrumb a { text-decoration: none; color: #999; }
        .breadcrumb a:hover { color: #e36009; }
        .breadcrumb span { color: #e36009; font-weight: 600; }
        .breadcrumb i { font-size: 10px; margin: 0 6px; }

        .page-title {
            padding: 24px 40px 16px;
            font-size: 24px;
            font-weight: 700;
            color: #222;
        }

        .orders-container {
            padding: 0 40px 60px;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            border-radius: 8px;
            overflow: hidden;
        }
        .orders-table thead tr {
            background: #e36009;
            color: #fff;
        }
        .orders-table th {
            padding: 14px 16px;
            font-weight: 700;
            letter-spacing: 0.03em;
            text-align: left;
        }
        .orders-table td {
            padding: 14px 16px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
            vertical-align: middle;
        }
        .orders-table tbody tr:hover { background: #fafafa; }
        .orders-table tbody tr:last-child td { border-bottom: none; }

        .order-id {
            font-weight: 700;
            color: #e36009;
        }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 4px;
        }
        .badge-done    { background: #e8f8ef; color: #27ae60; }
        .badge-pending { background: #fff4e5; color: #e36009; }
        .badge-shipping { background: #e8f0ff; color: #2980b9; }
        .badge-cancel  { background: #fdecea; color: #e74c3c; }

        .btn-view {
            padding: 6px 14px;
            background: #333;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background 0.2s;
        }
        .btn-view:hover { background: #e36009; }

        .btn-cancel {
            padding: 6px 14px;
            background: #fff;
            color: #e74c3c;
            border: 1px solid #e74c3c;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            margin-left: 8px;
        }
        .btn-cancel:hover {
            background: #e74c3c;
            color: #fff;
        }

        .empty-orders {
            text-align: center;
            padding: 80px 20px;
            color: #aaa;
            font-size: 16px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .empty-orders i { font-size: 48px; display: block; margin-bottom: 16px; color: #ddd; }
        .empty-orders p { margin-bottom: 20px; }
        .empty-orders a {
            display: inline-block;
            padding: 12px 24px;
            background: #e36009;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
        }
        .empty-orders a:hover { background: #c75408; }

        .order-items-summary {
            font-size: 12px;
            color: #888;
            margin-top: 4px;
        }
    </style>
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">

    <jsp:include page="includes/header.jsp" />

    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home.htm"><spring:message code="nav.home" text="Home" /></a>
        <i class="fa-solid fa-chevron-right"></i>
        <span><spring:message code="breadcrumb.orders" text="Order History" /></span>
    </div>

    <h1 class="page-title"><spring:message code="order.history.page" text="Order History" /></h1>

    <div class="orders-container">
        <c:choose>
            <c:when test="${not empty orders}">
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th><spring:message code="order.col.id" text="Order ID" /></th>
                            <th><spring:message code="order.col.date" text="Date" /></th>
                            <th><spring:message code="order.col.address" text="Shipping address" /></th>
                            <th><spring:message code="order.col.total" text="Total" /></th>
                            <th><spring:message code="order.col.status.detail" text="Status" /></th>
                            <th><spring:message code="order.col.action" text="Action" /></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td><span class="order-id">#${order.id}</span></td>
                                <td>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    <div class="order-items-summary">
                                        <spring:message code="order.items.count" arguments="${order.orderItems.size}" text="${order.orderItems.size} items" />
                                    </div>
                                </td>
                                <td>${order.address}, ${order.city}</td>
                                <td>
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 0}">
                                            <span class="badge badge-pending"><spring:message code="order.pending" text="Pending" /></span>
                                        </c:when>
                                        <c:when test="${order.status == 1}">
                                            <span class="badge badge-pending"><spring:message code="order.confirmed" text="Confirmed" /></span>
                                        </c:when>
                                        <c:when test="${order.status == 2}">
                                            <span class="badge badge-shipping"><spring:message code="order.shipping" text="Shipping" /></span>
                                        </c:when>
                                        <c:when test="${order.status == 3}">
                                            <span class="badge badge-done"><spring:message code="order.delivered" text="Delivered" /></span>
                                        </c:when>
                                        <c:when test="${order.status == 4}">
                                            <span class="badge badge-cancel"><spring:message code="order.cancelled" text="Cancelled" /></span>
                                        </c:when>
                                        <c:when test="${order.status == -1}">
                                            <span class="badge badge-cancel"><spring:message code="order.cancelled" text="Cancelled" /></span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order/detail.htm?id=${order.id}" class="btn-view">
                                        <i class="fa-solid fa-eye"></i> <spring:message code="order.view" text="View" />
                                    </a>
                                    <c:if test="${order.status == 0}">
                                        <form action="${pageContext.request.contextPath}/order/cancel.htm" method="post" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <button type="submit" class="btn-cancel">
                                                <i class="fa-solid fa-times"></i> <spring:message code="order.cancel.btn" text="Cancel" />
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-orders">
                    <i class="fa-regular fa-folder-open"></i>
                    <p><spring:message code="order.empty" text="You have no orders yet" /></p>
                    <a href="${pageContext.request.contextPath}/home.htm"><spring:message code="order.empty.shop" text="Start shopping" /></a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>
