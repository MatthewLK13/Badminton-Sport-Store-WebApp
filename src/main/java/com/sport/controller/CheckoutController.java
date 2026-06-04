package com.sport.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.sport.dao.OrderDAO;
import com.sport.dao.CartDao;
import com.sport.dao.ProductDao;
import com.sport.model.CheckoutDTO;
import com.sport.model.CartItemDTO;
import com.sport.entity.Order;
import com.sport.entity.OrderItemEntity;
import com.sport.entity.User;
import com.sport.entity.CartEntity;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.ProductsEntity;

@Controller
@RequestMapping("/checkout.htm")
public class CheckoutController {

	@Autowired
	private OrderDAO orderDAO;

	@Autowired
	private CartDao cartDao;

	@Autowired
	private ProductDao productDao;

	@RequestMapping(method = RequestMethod.GET)
	public String showCheckoutPage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login.htm";
		}

		// Add empty checkoutDTO for form binding
		model.addAttribute("checkoutDTO", new CheckoutDTO());

		// Get cart items with product details
		List<CartEntity> cartEntities = cartDao.getByUserId(user.getId());
		List<CartItemDTO> cartItems = new ArrayList<>();
		double cartTotal = 0;

		for (CartEntity item : cartEntities) {
			ProductVariantsEntity variant = productDao.getVariantById(item.getProductVariantId());
			if (variant != null && variant.getProduct() != null) {
				ProductsEntity product = variant.getProduct();
				CartItemDTO dto = new CartItemDTO(
					item.getId(),
					item.getProductVariantId(),
					product.getProductName(),
					variant.getVariant_name(),
					product.getPrice(),
					product.getAvatarName(),
					item.getQuantity()
				);
				cartItems.add(dto);
				cartTotal += product.getPrice() * item.getQuantity();
			}
		}

		model.addAttribute("cartItems", cartItems);
		model.addAttribute("cartTotal", String.format("%.2f", cartTotal));
		return "checkout";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String processCheckout(@Valid @ModelAttribute CheckoutDTO checkoutData, BindingResult bindingResult,
			HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login.htm";
		}

		// Return with validation errors
		if (bindingResult.hasErrors()) {
			// Re-populate cart items for the form
			List<CartEntity> cartEntities = cartDao.getByUserId(user.getId());
			List<CartItemDTO> cartItems = new ArrayList<>();
			double cartTotal = 0;
			for (CartEntity item : cartEntities) {
				ProductVariantsEntity variant = productDao.getVariantById(item.getProductVariantId());
				if (variant != null && variant.getProduct() != null) {
					ProductsEntity product = variant.getProduct();
					CartItemDTO dto = new CartItemDTO(
						item.getId(),
						item.getProductVariantId(),
						product.getProductName(),
						variant.getVariant_name(),
						product.getPrice(),
						product.getAvatarName(),
						item.getQuantity()
					);
					cartItems.add(dto);
					cartTotal += product.getPrice() * item.getQuantity();
				}
			}
			model.addAttribute("cartItems", cartItems);
			model.addAttribute("cartTotal", String.format("%.2f", cartTotal));
			model.addAttribute("error", "Vui lòng kiểm tra lại thông tin!");
			return "checkout";
		}

		// Get cart items
		List<CartEntity> cartItems = cartDao.getByUserId(user.getId());
		if (cartItems == null || cartItems.isEmpty()) {
			model.addAttribute("error", "Giỏ hàng trống!");
			return "checkout";
		}

		// Check stock for all items first
		for (CartEntity item : cartItems) {
			int available = productDao.getAvailableStock(item.getProductVariantId());
			if (available < item.getQuantity()) {
				model.addAttribute("error", "Sản phẩm không đủ số lượng trong kho!");
				return "checkout";
			}
		}

		// Decrement stock for each item
		for (CartEntity item : cartItems) {
			productDao.decrementStock(item.getProductVariantId(), item.getQuantity());
		}

		// Create order first
		Order order = new Order();
		order.setUser(user);
		order.setEmail(checkoutData.getEmail());
		order.setFirstName(checkoutData.getFirstName());
		order.setLastName(checkoutData.getLastName());
		order.setAddress(checkoutData.getAddress());
		order.setPhone(checkoutData.getPhone());
		order.setCardNumber(checkoutData.getCardNumber());
		order.setOrderDate(new Date());
		order.setStatus(0);

		// Calculate total amount and create order items
		Double totalAmount = 0.0;
		List<OrderItemEntity> orderItems = new ArrayList<>();

		for (CartEntity item : cartItems) {
			// Fetch variant to get product details
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

		// Clear cart after successful checkout
		cartDao.clearCart(user.getId());

		System.out.println("LƯU ĐƠN HÀNG THÀNH CÔNG VỚI USER_ID: " + user.getId());
		return "redirect:/home.htm";
	}
}
