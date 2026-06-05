package com.sport.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sport.dao.OrderDAO;
import com.sport.dao.ProductDao;
import com.sport.entity.Order;
import com.sport.entity.OrderItemEntity;

@Service
@Transactional
public class OrderService {

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private ProductDao productDao;

    // Cho User: Hủy đơn hàng (Status = -1) và phục hồi tồn kho
    public boolean cancelOrderByUser(Integer orderId, Integer userId) {
        Order order = orderDAO.getOrderByIdWithItems(orderId);
        if (order == null || order.getUser() == null || !order.getUser().getId().equals(userId)) {
            return false;
        }

        // Chỉ có thể hủy khi đang chờ xác nhận (status = 0)
        if (order.getStatus() != 0) {
            return false;
        }

        // 1. Cập nhật trạng thái sang -1
        boolean success = orderDAO.cancelOrder(orderId, userId);
        if (!success) {
            return false;
        }

        // 2. Phục hồi tồn kho
        List<OrderItemEntity> orderItems = order.getOrderItems();
        if (orderItems != null && !orderItems.isEmpty()) {
            for (OrderItemEntity item : orderItems) {
                productDao.incrementStock(item.getVariantId(), item.getQuantity());
            }
        }
        return true;
    }

    // Cho Admin: Cập nhật trạng thái đơn hàng (0-4)
    public void updateOrderStatusByAdmin(Integer orderId, Integer newStatus) {
        Order order = orderDAO.getOrderByIdWithItems(orderId);
        if (order == null) return;

        Integer oldStatus = order.getStatus();

        // 1. Cập nhật trạng thái
        orderDAO.updateOrderStatus(orderId, newStatus);

        // 2. Phục hồi tồn kho nếu Admin hủy đơn (chuyển trạng thái sang 4)
        // Chỉ phục hồi nếu đơn trước đó chưa bị hủy (tránh cộng nhầm 2 lần)
        if (oldStatus != 4 && oldStatus != -1 && newStatus == 4) {
            List<OrderItemEntity> orderItems = order.getOrderItems();
            if (orderItems != null && !orderItems.isEmpty()) {
                for (OrderItemEntity item : orderItems) {
                    productDao.incrementStock(item.getVariantId(), item.getQuantity());
                }
            }
        }
    }
}
