1 khi bấm thêm vào giỏ hàng từ trang chi tiết sản phẩm thì lỗi 400 - FIXED (nested form in product_details.jsp)
2 chức năng đánh giá sản phẩm khi đánh giá và chọn số sao xong bấm vào gửi đánh giá thì lỗi 500 - FIXED (lazy loading in ReviewDao)
3 chức năng wishlist bấm vào trái tim ở sản phẩm hay trên thanh header đều lỗi - FIXED (nested form)
4 chức năng tìm kiếm lỗi 500 - FIXED (SearchController passing wrong params to productDao.searchProducts)
5 truy cập vào trang chủ bị lỗi k có file index2 - KHONG TIM THAY reference den index2 trong code (HomeController dung /home.htm)
6 chức năng theo dõi đơn hàng lỗi - needs investigation

khi bấm thêm sản phẩm product bị báo lỗi org.hibernate.TransactionException: nested transactions not supported - FIXED (removed redundant @Transactional from ProductDao methods)