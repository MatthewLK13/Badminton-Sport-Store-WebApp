<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #f6f6f6; display: flex; min-height: 100vh; }
        
        /* --- SIDEBAR --- */
        .sidebar {
            width: 240px; background-color: #b8c9c3; padding: 30px 20px;
            display: flex; flex-direction: column; position: fixed; height: 100vh;
        }
        .logo-area { text-align: center; margin-bottom: 50px; }
        .logo-area svg { width: 60px; height: auto; fill: #000; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a {
            display: flex; align-items: center; gap: 15px; text-decoration: none; color: #4a4a4a;
            font-size: 14px; font-weight: 600; padding: 12px 15px; border-radius: 20px; transition: all 0.3s;
        }
        .menu-item a:hover, .menu-item.active a { background-color: #ffffff; color: #000; box-shadow: 0 4px 10px rgba(0,0,0,0.03); }

        /* --- MAIN CONTENT --- */
        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; }

        /* Top Bar */
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .search-top {
            background: #fff; padding: 8px 16px; border-radius: 20px;
            display: flex; align-items: center; width: 250px; box-shadow: 0 2px 5px rgba(0,0,0,0.02);
        }
        .search-top input { border: none; outline: none; font-size: 13px; width: 100%; margin-left: 10px; }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }
        .admin-profile i { font-size: 20px; }

        /* Overview Section */
        .page-title { font-size: 24px; font-weight: 700; margin-bottom: 25px; }
        .stats-container { display: flex; gap: 20px; margin-bottom: 40px; justify-content: space-between; }
        .card {
            background: #fff; padding: 25px 20px; border-radius: 16px; flex: 1;
            display: flex; flex-direction: column; gap: 12px; position: relative;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
        }
        .card-header { display: flex; justify-content: space-between; align-items: center; }
        .card-icon {
            width: 35px; height: 35px; border-radius: 8px; display: flex;
            align-items: center; justify-content: center; font-size: 18px;
        }
        /* Card specific colors matching Figma */
        .icon-sales { background: #e8f8f0; color: #2ecc71; }
        .icon-users { background: #fff5e6; color: #f39c12; }
        .icon-products { background: #ffebeb; color: #e74c3c; }
        .icon-orders { background: #f0f2f5; color: #7f8c8d; }
        
        .card-dots { color: #ccc; cursor: pointer; font-size: 14px; }
        .card-title { font-size: 12px; color: #a0a0a0; font-weight: 500; text-transform: lowercase; }
        .card-value { font-size: 22px; font-weight: 700; color: #000; }

        /* Chart Section */
        .chart-box {
            background: #fff; padding: 30px; border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }
        .chart-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .chart-title { font-size: 16px; font-weight: 700; }
        .chart-filter select {
            padding: 6px 12px; border: 1px solid #e0e0e0; border-radius: 20px;
            font-size: 12px; font-weight: 500; outline: none; background: #fff; cursor: pointer;
        }
        .chart-container { position: relative; height: 350px; width: 100%; }
    </style>
</head>
<body>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="logo-area">
            <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <path d="M20 70 L35 25 L50 25 L35 70 Z" />
                <path d="M50 70 L65 25 L80 25 L65 70 Z" />
            </svg>
        </div>
        <ul class="menu-list">
            <li class="menu-item active"><a href="#"><i class="fa-solid fa-border-all"></i> Dashboard</a></li>
            <li class="menu-item"><a href="#"><i class="fa-solid fa-box"></i> Products</a></li>
            <li class="menu-item"><a href="#"><i class="fa-solid fa-users"></i> Users</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/orders.htm"><i class="fa-solid fa-truck"></i> Orders</a></li>
            <li class="menu-item"><a href="#"><i class="fa-regular fa-comment"></i> Announcement</a></li>
        </ul>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="topbar">
            <div class="search-top">
                <i class="fa-solid fa-magnifying-glass" style="color: #ccc;"></i>
                <input type="text" placeholder="Tìm kiếm">
            </div>
            <div class="admin-profile">
                <span>VinhNguyen</span>
                <i class="fa-regular fa-circle-user"></i>
            </div>
        </div>

        <h2 class="page-title">Overview</h2>

        <div class="stats-container">
            <!-- Card 1: Total Sales -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon icon-sales"><i class="fa-solid fa-chart-simple"></i></div>
                    <i class="fa-solid fa-ellipsis card-dots"></i>
                </div>
                <div class="card-title">total sales</div>
                <div class="card-value">$${totalSales}</div>
            </div>
            <!-- Card 2: Total Users -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon icon-users"><i class="fa-solid fa-id-badge"></i></div>
                    <i class="fa-solid fa-ellipsis card-dots"></i>
                </div>
                <div class="card-title">total users</div>
                <div class="card-value">${totalUsers}</div>
            </div>
            <!-- Card 3: Total Products -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon icon-products"><i class="fa-solid fa-box-open"></i></div>
                    <i class="fa-solid fa-ellipsis card-dots"></i>
                </div>
                <div class="card-title">total products</div>
                <div class="card-value">${totalProducts}</div>
            </div>
            <!-- Card 4: Total Orders -->
            <div class="card">
                <div class="card-header">
                    <div class="card-icon icon-orders"><i class="fa-solid fa-receipt"></i></div>
                    <i class="fa-solid fa-ellipsis card-dots"></i>
                </div>
                <div class="card-title">total orders</div>
                <div class="card-value">${totalOrders}</div>
            </div>
        </div>

        <!-- Chart -->
        <div class="chart-box">
            <div class="chart-header">
                <h3 class="chart-title">User & Sell</h3>
                <div class="chart-filter">
                    <select>
                        <option>Monthly</option>
                        <option>Weekly</option>
                        <option>Yearly</option>
                    </select>
                </div>
            </div>
            <div class="chart-container">
                <canvas id="userSellChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Chart.js Setup -->
    <script>
        const ctx = document.getElementById('userSellChart').getContext('2d');
        
        // Dữ liệu mô phỏng theo Figma (Dạng lượn sóng)
        const labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        
        const chart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Sell',
                        data: [2000, 3000, 2500, 4500, 4000, 6000, 5500, 7500, 6000, 8000, 7000, 8500],
                        borderColor: '#2ecc71', // Màu xanh
                        backgroundColor: 'rgba(46, 204, 113, 0.1)',
                        borderWidth: 2,
                        tension: 0.4, // Tạo độ cong mềm mại
                        fill: true
                    },
                    {
                        label: 'User',
                        data: [1500, 2000, 1800, 3000, 2500, 4000, 3500, 5000, 4500, 6000, 5000, 6500],
                        borderColor: '#f1c40f', // Màu vàng/cam
                        backgroundColor: 'transparent',
                        borderWidth: 2,
                        borderDash: [5, 5], // Nét đứt (tùy chọn để phân biệt)
                        tension: 0.4,
                        fill: false
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false // Ẩn legend đi cho giống Figma
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: '#ccc',
                            font: { size: 10 }
                        },
                        grid: {
                            color: '#f0f0f0',
                            drawBorder: false
                        }
                    },
                    x: {
                        ticks: {
                            color: '#ccc',
                            font: { size: 10 }
                        },
                        grid: {
                            display: false,
                            drawBorder: false
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
