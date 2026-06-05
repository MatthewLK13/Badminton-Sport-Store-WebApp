package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
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
import com.sport.util.LocaleUtils;

@Controller
@RequestMapping("/checkout.htm")
public class CheckoutController {

	@Autowired
	private OrderDAO orderDAO;

	@Autowired
	private CartDao cartDao;

	@Autowired
	private ProductDao productDao;

	@Autowired
	private com.sport.service.CheckoutService checkoutService;

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
	public String processCheckout(@Valid @ModelAttribute("checkoutDTO") CheckoutDTO checkoutData, BindingResult bindingResult,
			HttpServletRequest request, HttpSession session, Model model) {
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
			model.addAttribute("error", LocaleUtils.msg(request, "checkout.error.review"));
			return "checkout";
		}

		// Get cart items
		List<CartEntity> cartItems = cartDao.getByUserId(user.getId());
		if (cartItems == null || cartItems.isEmpty()) {
			model.addAttribute("error", LocaleUtils.msg(request, "cart.empty"));
			return "checkout";
		}

		// Check stock and process order within a single transaction
		try {
			checkoutService.processOrder(user, checkoutData, cartItems);
		} catch (RuntimeException e) {
			model.addAttribute("error", e.getMessage());
			return "checkout";
		}

		session.setAttribute("cartCount", 0);
		session.setAttribute("checkoutSuccess", LocaleUtils.msg(request, "checkout.success.thankyou"));

		System.out.println("LƯU ĐƠN HÀNG THÀNH CÔNG VỚI USER_ID: " + user.getId());
		return "redirect:/home.htm";
	}
}
