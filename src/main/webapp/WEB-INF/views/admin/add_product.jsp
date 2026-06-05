<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ThÃªm sáº£n pháº©m má»›i - Yonex Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', sans-serif; }
        body { background-color: #eef2f3; display: flex; min-height: 100vh; }
        
        /* SIDEBAR */
        .sidebar {
            width: 240px; background-color: #b8c9c3; padding: 30px 20px;
            display: flex; flex-direction: column; border-right: 1px solid rgba(0,0,0,0.05);
            position: fixed; height: 100vh;
        }
        .logo-area { text-align: center; margin-bottom: 50px; }
        .logo-area svg { width: 60px; height: auto; fill: #000; }
        .menu-list { list-style: none; display: flex; flex-direction: column; gap: 15px; }
        .menu-item a {
            display: flex; align-items: center; gap: 15px; text-decoration: none;
            color: #4a4a4a; font-size: 14px; font-weight: 600; padding: 12px 15px;
            border-radius: 20px; transition: all 0.3s;
        }
        .menu-item a:hover, .menu-item.active a {
            background-color: #ffffffc9; color: #000; box-shadow: 0 4px 10px rgba(0,0,0,0.03);
        }

        /* MAIN CONTENT */
        .main-content { margin-left: 240px; flex: 1; padding: 30px 40px; }
        
        .topbar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .btn-back {
            text-decoration: none; color: #000; font-weight: 600; font-size: 14px;
            display: flex; align-items: center; gap: 8px;
        }
        .admin-profile { display: flex; align-items: center; gap: 10px; font-weight: 600; font-size: 14px; }
        
        .page-title { font-size: 24px; font-weight: 700; margin-bottom: 25px; }

        .form-container {
            background: #fff; padding: 40px; border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
        }

        .section-title { font-size: 14px; font-weight: 700; color: #8e8e8e; text-transform: uppercase; margin-bottom: 15px; margin-top: 30px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .section-title:first-child { margin-top: 0; }

        .form-group { margin-bottom: 20px; display: flex; flex-direction: column; gap: 8px; }
        .form-row { display: flex; gap: 20px; }
        .form-row .form-group { flex: 1; }
        
        label { font-size: 13px; font-weight: 600; color: #333; }
        .form-control, .form-select {
            padding: 12px 16px; border: 1px solid #e0e0e0; border-radius: 12px;
            font-size: 14px; outline: none; background: #fafafa; transition: 0.3s;
        }
        .form-control:focus, .form-select:focus { border-color: #000; background: #fff; }

        .images-grid { display: flex; gap: 15px; margin-bottom: 20px; }
        .image-upload-card {
            border: 1px dashed #cbd5e1; padding: 15px; border-radius: 12px;
            background: #f8fafc; text-align: center; flex: 1; display: flex; flex-direction: column; gap: 10px;
        }
        .image-upload-card label { font-size: 13px; color: #475569; }
        .image-upload-card label.main-img { color: #e74c3c; font-weight: 700; }
        .image-upload-card input[type="file"] { font-size: 12px; }

        .attr-section { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 16px; padding: 25px; margin-top: 20px; }
        
        .btn-save {
            background: #000; color: #fff; border-radius: 12px; padding: 15px 30px;
            font-weight: 600; font-size: 15px; border: none; cursor: pointer; width: 100%; margin-top: 30px; transition: 0.3s;
        }
        .btn-save:hover { background: #333; }
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
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/dashboard.htm"><i class="fa-solid fa-chart-simple"></i> Dashboard</a></li>
            <li class="menu-item active"><a href="${pageContext.request.contextPath}/admin/product/management.htm"><i class="fa-solid fa-box"></i> Products</a></li>
            <li class="menu-item"><a href="${pageContext.request.contextPath}/admin/users.htm"><i class="fa-solid fa-users"></i> Users</a></li>
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
            <a href="${pageContext.request.contextPath}/admin/product/management.htm" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back to Products</a>
            <div class="admin-profile">
                <span>Admin</span>
                <i class="fa-solid fa-circle-user" style="font-size: 20px;"></i>
            </div>
        </div>

        <h2 class="page-title">Add New Product</h2>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/product/save.htm" method="POST" enctype="multipart/form-data">

                <h3 class="section-title">Product Images</h3>
                <div class="images-grid">
                    <div class="image-upload-card">
                        <label class="main-img">â˜… Main side</label>
                        <input type="file" name="fileMain" class="form-control" accept="image/*" required>
                    </div>
                    <div class="image-upload-card">
                        <label>Right side</label>
                        <input type="file" name="fileRight" class="form-control" accept="image/*">
                    </div>
                    <div class="image-upload-card">
                        <label>Top side</label>
                        <input type="file" name="fileTop" class="form-control" accept="image/*">
                    </div>
                    <div class="image-upload-card">
                        <label>Bottom side</label>
                        <input type="file" name="fileBottom" class="form-control" accept="image/*">
                    </div>
                </div>

                <h3 class="section-title">Basic Information</h3>
                <div class="form-group">
                    <label>TÃªn sáº£n pháº©m</label>
                    <input type="text" name="productName" class="form-control" placeholder="GÃµ tÃªn sáº£n pháº©m..." required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Danh má»¥c</label>
                        <select name="categoryId" class="form-select" required>
                            <option value="">-- Chá»n danh má»¥c --</option>
                            <option value="1">Vá»£t cáº§u lÃ´ng</option>
                            <option value="2">GiÃ y cáº§u lÃ´ng</option>
                            <option value="3">Quáº§n Ã¡o cáº§u lÃ´ng</option>
                            <option value="4">TÃºi vá»£t cáº§u lÃ´ng</option>
                            <option value="5">Phá»¥ kiá»‡n cáº§u lÃ´ng</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>ThÆ°Æ¡ng hiá»‡u</label>
                        <select name="brandId" class="form-select" required>
                            <option value="">-- Chá»n thÆ°Æ¡ng hiá»‡u --</option>
                            <option value="1">Yonex</option>
                            <option value="2">Victor</option>
                            <option value="3">Lining</option>
                            <option value="4">Mizuno</option>
                            <option value="5">Kawasaki</option>
                            <option value="6">Venson</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>GiÃ¡ (USD)</label>
                        <input type="number" step="0.01" name="price" class="form-control" placeholder="VÃ­ dá»¥: 122.0" required>
                    </div>
                    <div class="form-group">
                        <label>MÃ´ táº£ ngáº¯n</label>
                        <input type="text" name="description" class="form-control" placeholder="MÃ´ táº£..." required>
                    </div>
                </div>

                <div class="attr-section">
                    <h3 class="section-title" style="margin-top: 0; border: none; color: #333;"><i class="fa-solid fa-layer-group"></i> KÃCH Cá»  / PHÃ‚N LOáº I BIáº¾N THá»‚</h3>
                    <p style="font-size: 13px; color: #666; margin-bottom: 15px;">ThÃªm cÃ¡c biáº¿n thá»ƒ vá» kÃ­ch cá»¡ (VD: Size giÃ y 40, Vá»£t 4U G5) vÃ  sá»‘ lÆ°á»£ng tÆ°Æ¡ng á»©ng.</p>
                    
                    
                    <!-- Nhanh Size giay -->
                    <div style="background: #eef2f3; padding: 15px; border-radius: 12px; margin-bottom: 20px; border: 1px dashed #cbd5e1;">
                        <label style="display: block; margin-bottom: 10px; color: #3b82f6; font-weight: 700;"><i class="fa-solid fa-shoe-prints"></i> NHẬP NHANH SIZE GIÀY (Bỏ qua nếu không bán giày):</label>
                        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                            <c:forEach var="size" begin="38" end="45">
                                <div style="flex: 1; min-width: 60px;">
                                    <small style="display:block; text-align:center; font-weight:600; margin-bottom:4px; color: #475569;">Size ${size}</small>
                                    <input type="number" name="shoeQuantity" class="form-control" style="padding: 8px; text-align: center; border-radius: 8px;" min="0" placeholder="-">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
<div class="form-row mb-3">
                        <div class="form-group">
                            <input type="text" name="variantNames" class="form-control" placeholder="TÃªn biáº¿n thá»ƒ (VD: 4U G5)">
                        </div>
                        <div class="form-group">
                            <input type="number" name="variantStocks" class="form-control" placeholder="Sá»‘ lÆ°á»£ng tá»“n kho" min="0">
                        </div>
                    </div>
                    <div class="form-row mb-3">
                        <div class="form-group">
                            <input type="text" name="variantNames" class="form-control" placeholder="TÃªn biáº¿n thá»ƒ (VD: 3U G5)">
                        </div>
                        <div class="form-group">
                            <input type="number" name="variantStocks" class="form-control" placeholder="Sá»‘ lÆ°á»£ng tá»“n kho" min="0">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <input type="text" name="variantNames" class="form-control" placeholder="TÃªn biáº¿n thá»ƒ khÃ¡c...">
                        </div>
                        <div class="form-group">
                            <input type="number" name="variantStocks" class="form-control" placeholder="Sá»‘ lÆ°á»£ng tá»“n kho" min="0">
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-save"><i class="fa-solid fa-check"></i> LÆ¯U Sáº¢N PHáº¨M</button>
            </form>
        </div>
    </div>
</body>
</html>
