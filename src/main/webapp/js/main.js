document.addEventListener("DOMContentLoaded", function() {
    const cartBtn = document.getElementById("cart-btn");
    const cartDrawer = document.getElementById("cart-drawer");
    const closeCartBtn = document.getElementById("close-cart-btn");
    const cartOverlay = document.getElementById("cart-overlay");

    if (cartBtn) {
        cartBtn.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation(); // Ngăn sự kiện nổi bọt gây lỗi
            
            console.log("-> Đã click thành công nút giỏ hàng!");
            
            if (cartDrawer) {
                cartDrawer.classList.add("open");
            } else {
                console.error("Lỗi: Không tìm thấy thẻ có id='cart-drawer' trong file JSP!");
            }
        });
    } else {
        console.error("Lỗi: Không tìm thấy nút id='cart-btn' trong file JSP!");
    }

    if (closeCartBtn) {
        closeCartBtn.addEventListener("click", function() {
            cartDrawer.classList.remove("open");
        });
    }

    if (cartOverlay) {
        cartOverlay.addEventListener("click", function() {
            cartDrawer.classList.remove("open");
        });
    }
});