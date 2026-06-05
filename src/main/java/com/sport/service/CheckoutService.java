package com.sport.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sport.dao.CartDao;
import com.sport.dao.OrderDAO;
import com.sport.dao.ProductDao;
import com.sport.entity.CartEntity;
import com.sport.entity.Order;
import com.sport.entity.OrderItemEntity;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.User;
import com.sport.model.CheckoutDTO;

@Service
@Transactional
public class CheckoutService {

	@Autowired
	private OrderDAO orderDAO;

	@Autowired
	private CartDao cartDao;

	@Autowired
	private ProductDao productDao;

	public void processOrder(User user, CheckoutDTO checkoutData, List<CartEntity> cartItems) {
		for (CartEntity item : cartItems) {
			if (item.getProductVariantId() == null) continue;
			Integer available = productDao.getAvailableStock(item.getProductVariantId());
			if (available == null || available < item.getQuantity()) {
				throw new RuntimeException("Sản phẩm không đủ số lượng trong kho!");
			}
		}

		Order order = new Order();
		order.setUser(user);
		order.setEmail(checkoutData.getEmail());
		order.setFirstName(checkoutData.getFirstName());
		order.setLastName(checkoutData.getLastName());
		order.setAddress(checkoutData.getAddress());
		order.setCity(checkoutData.getCity());
		order.setState(checkoutData.getState());
		order.setPhone(checkoutData.getPhone());
		order.setCardNumber(checkoutData.getCardNumber());
		order.setOrderDate(new Date());
		order.setStatus(0);

		Double totalAmount = 0.0;
		List<OrderItemEntity> orderItems = new ArrayList<>();

		for (CartEntity item : cartItems) {
			ProductVariantsEntity variant = productDao.getVariantById(item.getProductVariantId());
			if (variant == null) continue;

			String productName = variant.getProduct() != null ? variant.getProduct().getProductName() : "";
			String variantName = variant.getVariant_name();
			Double price = variant.getProduct() != null ? variant.getProduct().getPrice() : 0.0;
			String imageUrl = variant.getProduct() != null ? variant.getProduct().getAvatarName() : "";

			Double subtotal = price * item.getQuantity();
			totalAmount += subtotal;

			OrderItemEntity orderItem = new OrderItemEntity();
			orderItem.setOrder(order);
			orderItem.setVariantId(item.getProductVariantId());
			if (variant.getProduct() != null) {
			    orderItem.setProductId(variant.getProduct().getId());
			}
			orderItem.setProductName(productName);
			orderItem.setVariantName(variantName);
			orderItem.setPrice(price);
			orderItem.setQuantity(item.getQuantity());
			orderItem.setImageUrl(imageUrl);
			orderItems.add(orderItem);
		}

		order.setTotalAmount(totalAmount);
		order.setOrderItems(orderItems);
		
		orderDAO.saveOrder(order);

		for (CartEntity item : cartItems) {
			productDao.decrementStock(item.getProductVariantId(), item.getQuantity());
		}
		cartDao.clearCart(user.getId());
	}
}
