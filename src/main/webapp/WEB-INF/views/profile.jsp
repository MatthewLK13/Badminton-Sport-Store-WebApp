<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang cá nhân - Yonex</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* ---- BREADCRUMB ---- */
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

        /* ---- GREETING ---- */
        .greeting {
            padding: 24px 40px 16px;
            font-size: 20px;
            font-weight: 400;
            color: #222;
        }
        .greeting strong { font-weight: 800; }

        /* ---- LAYOUT 2 CỘT ---- */
        .profile-layout {
            display: flex;
            gap: 30px;
            padding: 0 40px 60px;
            align-items: flex-start;
        }

        /* ---- PANEL TRÁI: THÔNG TIN TÀI KHOẢN ---- */
        .profile-card {
            background: #f2f2f2;
            padding: 28px 28px 32px;
            min-width: 260px;
            width: 280px;
            flex-shrink: 0;
        }
        .profile-card-title {
            font-size: 13px;
            font-weight: 800;
            letter-spacing: 0.05em;
            margin-bottom: 6px;
            color: #111;
        }
        .dots {
            display: flex;
            gap: 4px;
            margin-bottom: 20px;
        }
        .dot {
            width: 28px;
            height: 2px;
            background: #e36009;
            border-radius: 2px;
        }
        .dot.gray { background: #ccc; width: 10px; }

        .info-row {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 18px;
            font-size: 14px;
            color: #333;
        }
        .info-row i {
            font-size: 16px;
            color: #555;
            margin-top: 2px;
            width: 18px;
            text-align: center;
            flex-shrink: 0;
        }
        .info-label { font-size: 11px; color: #999; margin-bottom: 1px; }
        .info-value { font-weight: 600; color: #111; font-size: 14px; }

        .divider-dots {
            display: flex;
            gap: 4px;
            margin: 16px 0;
        }
        .divider-dot {
            width: 4px; height: 4px;
            background: #bbb;
            border-radius: 50%;
        }

        .btn-edit {
            display: block;
            width: 100%;
            padding: 14px 0;
            background: #e36009;
            color: #fff;
            border: none;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 24px;
            transition: background 0.2s;
            text-align: center;
        }
        .btn-edit:hover { background: #c75408; }

        /* ---- FORM SỬA (ẩn mặc định) ---- */
        .edit-form {
            display: none;
            margin-top: 20px;
        }
        .edit-form.active { display: block; }
        .edit-form input {
            width: 100%;
            padding: 10px 14px;
            font-size: 14px;
            border: 1px solid #ddd;
            margin-bottom: 12px;
            background: #fff;
            outline: none;
            transition: border-color 0.2s;
        }
        .edit-form input:focus { border-color: #e36009; }
        .btn-save {
            width: 100%;
            padding: 12px 0;
            background: #111;
            color: #fff;
            border: none;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-save:hover { background: #e36009; }
        .btn-cancel {
            width: 100%;
            padding: 10px 0;
            background: transparent;
            color: #888;
            border: 1px solid #ccc;
            font-size: 13px;
            cursor: pointer;
            margin-top: 8px;
            transition: all 0.2s;
        }
        .btn-cancel:hover { border-color: #e36009; color: #e36009; }

        /* ---- PANEL PHẢI: ĐƠN HÀNG ---- */
        .orders-panel { flex: 1; }
        .orders-title {
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 0.05em;
            color: #111;
            margin-bottom: 14px;
        }
        .orders-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }
        .orders-table thead tr {
            background: #e36009;
            color: #fff;
        }
        .orders-table th {
            padding: 10px 14px;
            font-weight: 700;
            letter-spacing: 0.03em;
            text-align: left;
        }
        .orders-table td {
            padding: 10px 14px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
            vertical-align: middle;
        }
        .orders-table tbody tr:hover { background: #fafafa; }
        .order-time { font-size: 11px; color: #888; margin-top: 2px; }
        .badge {
            display: inline-block;
            padding: 3px 10px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 2px;
        }
        .badge-done    { background: #e8f8ef; color: #27ae60; }
        .badge-pending { background: #fff4e5; color: #e36009; }
        .badge-cancel  { background: #fdecea; color: #e74c3c; }

        .empty-orders {
            text-align: center;
            padding: 40px 0;
            color: #aaa;
            font-size: 14px;
        }
        .empty-orders i { font-size: 32px; display: block; margin-bottom: 10px; }
    </style>
</head>
<body>

    <jsp:include page="includes/header.jsp" />

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home.htm">Trang chủ</a>
        <i class="fa-solid fa-chevron-right"></i>
        <span>Trang cá nhân</span>
    </div>

    <!-- Lời chào -->
    <div class="greeting">
        Xin chào, <strong>${user.fullName}</strong>
    </div>

    <!-- Layout 2 cột -->
    <div class="profile-layout">

        <!-- PANEL TRÁI: Thông tin tài khoản -->
        <div class="profile-card">
            <div class="profile-card-title">THÔNG TIN TÀI KHOẢN</div>
            <div class="dots">
                <div class="dot"></div>
                <div class="dot gray"></div>
                <div class="dot gray"></div>
            </div>

            <!-- Họ tên -->
            <div class="info-row">
                <i class="fa-regular fa-user"></i>
                <div>
                    <div class="info-label">Họ, tên</div>
                    <div class="info-value">${user.fullName}</div>
                </div>
            </div>

            <!-- Số điện thoại -->
            <div class="info-row">
                <i class="fa-solid fa-phone"></i>
                <div>
                    <div class="info-label">Điện thoại</div>
                    <div class="info-value">${user.phone}</div>
                </div>
            </div>

            <!-- Địa chỉ -->
            <div class="info-row">
                <i class="fa-solid fa-location-dot"></i>
                <div>
                    <div class="info-label">Địa chỉ</div>
                    <div class="info-value">
                        ${not empty user.address ? user.address : 'Chưa cập nhật'}
                    </div>
                </div>
            </div>

            <!-- Divider dots -->
            <div class="divider-dots">
                <div class="divider-dot"></div>
                <div class="divider-dot"></div>
                <div class="divider-dot"></div>
            </div>

            <!-- Email -->
            <div class="info-row">
                <i class="fa-regular fa-envelope"></i>
                <div>
                    <div class="info-label">Email</div>
                    <div class="info-value">${user.email}</div>
                </div>
            </div>

            <!-- Nút mở form sửa -->
            <button class="btn-edit" onclick="toggleEditForm()">Sửa thông tin cá nhân</button>

            <!-- Form sửa (ẩn mặc định) -->
            <div class="edit-form" id="editForm">
                <form action="${pageContext.request.contextPath}/profile.htm" method="post">
                    <input type="text" name="fullname" value="${user.fullName}" placeholder="Họ và tên" required>
                    <input type="text" name="phone" value="${user.phone}" placeholder="Số điện thoại" required>
                    <input type="text" name="address" value="${user.address}" placeholder="Địa chỉ">
                    <button type="submit" class="btn-save">Lưu thay đổi</button>
                    <button type="button" class="btn-cancel" onclick="toggleEditForm()">Hủy</button>
                </form>
            </div>
        </div>

        <!-- PANEL PHẢI: Đơn hàng -->
        <div class="orders-panel">
            <div class="orders-title">ĐƠN HÀNG CỦA BẠN</div>
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Đơn hàng</th>
                        <th>Thời gian</th>
                        <th>Địa chỉ</th>
                        <th>Tình trạng</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Placeholder: Khi có module Orders sẽ dùng JSTL forEach --%>
                    <tr>
                        <td colspan="4">
                            <div class="empty-orders">
                                <i class="fa-regular fa-folder-open"></i>
                                Chưa có đơn hàng nào
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Toast notification -->
    <div id="toast"></div>
    <script>
        function showToast(message, type) {
            const container = document.getElementById("toast");
            const toast = document.createElement("div");
            toast.className = "toast " + type;
            toast.innerText = message;
            container.appendChild(toast);
            setTimeout(() => toast.classList.add("show"), 100);
            setTimeout(() => {
                toast.classList.remove("show");
                setTimeout(() => toast.remove(), 400);
            }, 3500);
        }

        function toggleEditForm() {
            const form = document.getElementById("editForm");
            form.classList.toggle("active");
        }

        <% if (request.getAttribute("error") != null) { %>
            showToast("<%= request.getAttribute("error") %>", "error");
            document.getElementById("editForm").classList.add("active");
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            showToast("<%= request.getAttribute("success") %>", "success");
        <% } %>
    </script>

</body>
</html>
