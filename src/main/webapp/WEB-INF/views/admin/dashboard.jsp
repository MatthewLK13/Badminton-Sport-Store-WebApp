<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Overview - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #eef2f3; display: flex; min-height: 100vh; }
        
        /* SIDEBAR */
        .sidebar {
            width: 240px; background-color: #b8c9c3; padding: 30px 20px;
            display: flex; flex-direction: column; border-right: 1px solid rgba(0,0,0,0.05);
            position: fixed; height: 100vh;
        }
        .logo-area { text-align: left; margin-bottom: 50px; padding-left: 15px; }
        .logo-area h3 { color: #888; font-weight: 600; font-size: 16px; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a {
            display: flex; align-items: center; gap: 15px; text-decoration: none;
            color: #111; font-size: 14px; font-weight: 600; padding: 12px 15px;
            border-radius: 20px; transition: all 0.3s;
        }
        .menu-item a:hover, .menu-item.active a {
            background-color: #ffffffc9; color: #000; box-shadow: 0 4px 10px rgba(0,0,0,0.03);
        }

        /* MAIN CONTENT */
        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; }
        
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .search-top {
            background: #fff; padding: 10px 16px; border-radius: 8px;
            display: flex; align-items: center; width: 350px; border: 1px solid #e0e0e0;
        }
        .search-top input { border: none; outline: none; font-size: 13px; width: 100%; margin-left: 10px; }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }
        
        .page-title { font-size: 28px; font-weight: 700; margin-bottom: 30px; }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .dash-card {
            background: #fff; padding: 25px; border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
            display: flex; flex-direction: column; position: relative;
        }
        
        .dash-icon {
            width: 35px; height: 35px; border-radius: 8px;
            display: flex; align-items: center; justify-content: center; font-size: 18px;
            margin-bottom: 25px;
        }
        .icon-sales { background: #2ecc71; color: #fff; }
        .icon-users { background: #f39c12; color: #fff; }
        .icon-products { background: #e74c3c; color: #fff; }
        .icon-orders { background: #95a5a6; color: #fff; }
        
        .card-more { position: absolute; top: 25px; right: 20px; color: #ccc; cursor: pointer; }
        
        .dash-desc { font-size: 12px; color: #a0a0a0; font-weight: 500; text-transform: lowercase; margin-bottom: 5px; }
        .dash-title { font-size: 24px; font-weight: 700; color: #111; }
        
        .chart-container {
            background: #fff; padding: 30px; border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }
        .chart-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .chart-title { font-size: 16px; font-weight: 700; }
        .chart-filter { padding: 6px 12px; border-radius: 20px; border: 1px solid #ddd; outline: none; font-size: 13px; }
    </style>
</head>
<body class="${sessionScope.theme == 'dark' ? 'dark-mode' : ''}">

    <!-- SIDEBAR -->
    <div class="sidebar">
                <div class="logo-area">
            <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" style="width: 60px; height: auto; fill: #000;">
                <path d="M20 70 L35 25 L50 25 L35 70 Z" />
                <path d="M50 70 L65 25 L80 25 L65 70 Z" />
            </svg>
        </div>
        <ul class="menu-list">
            <li class="menu-item active"><a href="${pageContext.request.contextPath}/admin/dashboard.htm"><i class="fa-solid fa-border-all"></i> Dashboard</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/product/management.htm"><i class="fa-solid fa-bag-shopping"></i> Products</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/users.htm"><i class="fa-solid fa-person"></i> Users</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/orders.htm"><i class="fa-solid fa-truck"></i> Orders</a></li>
            
        </ul>
        <div class="logout-container" style="margin-top: auto; padding-top: 20px;">
            <a href="${pageContext.request.contextPath}/logout.htm" style="display: flex; align-items: center; justify-content: center; gap: 10px; text-decoration: none; color: #e74c3c; font-weight: 600; padding: 12px; border-radius: 15px; background: #ffebeb; transition: all 0.3s; width: 100%;">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="topbar">
            <div class="search-top">
                <i class="fa-solid fa-magnifying-glass" style="color:#aaa;"></i>
                <input type="text" placeholder="Tìm kiếm">
            </div>
            <div class="admin-profile">
                <span>${sessionScope.user.fullName}</span>
                <i class="fa-regular fa-circle-user" style="font-size: 24px;"></i>
            </div>
        </div>

        <h2 class="page-title">Overview</h2>

        <div class="dashboard-grid">
            <div class="dash-card">
                <div class="dash-icon icon-sales"><i class="fa-solid fa-chart-simple"></i></div>
                <i class="fa-solid fa-ellipsis card-more"></i>
                <div class="dash-desc">total sales</div>
                <div class="dash-title">$<fmt:formatNumber value="${totalSales}" pattern="#,##0.00"/></div>
            </div>
            
            <div class="dash-card">
                <div class="dash-icon icon-users"><i class="fa-solid fa-address-card"></i></div>
                <i class="fa-solid fa-ellipsis card-more"></i>
                <div class="dash-desc">total users</div>
                <div class="dash-title"><fmt:formatNumber value="${totalUsers}" pattern="#,##0"/></div>
            </div>
            
            <div class="dash-card">
                <div class="dash-icon icon-products"><i class="fa-solid fa-cube"></i></div>
                <i class="fa-solid fa-ellipsis card-more"></i>
                <div class="dash-desc">total products</div>
                <div class="dash-title"><fmt:formatNumber value="${totalProducts}" pattern="#,##0"/></div>
            </div>

            <div class="dash-card">
                <div class="dash-icon icon-orders"><i class="fa-solid fa-file-lines"></i></div>
                <i class="fa-solid fa-ellipsis card-more"></i>
                <div class="dash-desc">total orders</div>
                <div class="dash-title"><fmt:formatNumber value="${totalOrders}" pattern="#,##0"/></div>
            </div>
        </div>

        <div class="chart-container">
            <div class="chart-header">
                <div class="chart-title">User & Sell</div>
                <select class="chart-filter">
                    <option>Monthly</option>
                    <option>Yearly</option>
                </select>
            </div>
            <canvas id="userSellChart" height="100"></canvas>
        </div>
    </div>

    <script>
        const ctx = document.getElementById('userSellChart').getContext('2d');
        const userSellChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Sales (USD)',
                    data: [12000, 19000, 3000, 5000, 20000, 30000, 45000, 50000, 25000, 60000, 75000, 80000],
                    borderColor: '#2ecc71',
                    backgroundColor: 'rgba(46, 204, 113, 0.1)',
                    borderWidth: 2,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { color: '#a0a0a0' },
                        grid: { color: '#f0f0f0', drawBorder: false }
                    },
                    x: {
                        ticks: { color: '#a0a0a0' },
                        grid: { display: false, drawBorder: false }
                    }
                }
            }
        });
    </script>
</body>
</html>
