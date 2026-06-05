package com.sport.controller;

import java.util.List;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.dao.AdminProductDao;
import com.sport.dao.OrderDAO;
import com.sport.dao.ProductDao;
import com.sport.dao.UserDAO;
import com.sport.entity.Order;
import com.sport.entity.User;
import com.sport.service.OrderService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private OrderDAO orderDAO;

	@Autowired
	private OrderService orderService;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private AdminProductDao adminProductDao;

	@RequestMapping(value ="/dashboard.htm", method = RequestMethod.GET)
	public String showDashboard(Model model, HttpSession session) {
		
		List<Order> orders = orderDAO.getAllOrders();
		double totalSales = 0;
		for (Order o : orders) {
			if (o.getTotalAmount() != null && o.getStatus() != 4) { // Ignore cancelled orders (status 4)
				totalSales += o.getTotalAmount();
			}
		}
		
		long totalProducts = adminProductDao.countAllProducts(null, null, null, null);
		int totalUsers = userDAO.getAllUsers().size();
		
		model.addAttribute("totalSales", totalSales);
		model.addAttribute("totalUsers", totalUsers);
		model.addAttribute("totalProducts", totalProducts);
		model.addAttribute("totalOrders", orders.size());
		
		return "admin/dashboard";
	}

	@RequestMapping(value ="/orders.htm", method = RequestMethod.GET)
	public String listOrders(
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "orderDate", required = false) String orderDate,
			Model model, HttpSession session) {
		List<Order> allOrders = orderDAO.getAllOrders();

		int totalOrders = allOrders.size();
		int newOrdersThisMonth = 0;

		Calendar cal = Calendar.getInstance();
		int currentMonth = cal.get(Calendar.MONTH);
		int currentYear = cal.get(Calendar.YEAR);

		for (Order order : allOrders) {
			if (order.getOrderDate() != null) {
				cal.setTime(order.getOrderDate());
				if(cal.get(Calendar.MONTH) == currentMonth && cal.get(Calendar.YEAR) == currentYear) {
					newOrdersThisMonth++;
				}
			}
		}

		// Filter orders
		List<Order> filteredOrders = new java.util.ArrayList<>();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		
		for (Order o : allOrders) {
			boolean matchKeyword = true;
			if (keyword != null && !keyword.trim().isEmpty()) {
				String kw = keyword.trim().toLowerCase();
				String fullName = ((o.getFirstName() != null ? o.getFirstName() : "") + " " + (o.getLastName() != null ? o.getLastName() : "")).toLowerCase();
				String email = (o.getEmail() != null ? o.getEmail() : "").toLowerCase();
				String idStr = o.getId() != null ? o.getId().toString() : "";
				String orderCodeStr = o.getId() != null ? "o-" + String.format("%02d", o.getId()) : "";
				matchKeyword = fullName.contains(kw) || email.contains(kw) || idStr.equals(kw) || orderCodeStr.equals(kw);
			}

			boolean matchDate = true;
			if (orderDate != null && !orderDate.trim().isEmpty()) {
				if (o.getOrderDate() != null) {
					String dStr = sdf.format(o.getOrderDate());
					matchDate = dStr.equals(orderDate.trim());
				} else {
					matchDate = false;
				}
			}

			if (matchKeyword && matchDate) {
				filteredOrders.add(o);
			}
		}

		model.addAttribute("orders", filteredOrders);
		model.addAttribute("totalOrders", totalOrders);
		model.addAttribute("newOrders", newOrdersThisMonth);
		return "admin/orders";
	}

	@RequestMapping(value = "/order-detail.htm", method = RequestMethod.GET)
	public String orderDetail(@RequestParam("id") Integer id, Model model, HttpSession session) {
		Order order = orderDAO.getOrderByIdWithItems(id);
		if (order == null) {
			return "redirect:/admin/orders.htm";
		}

		model.addAttribute("order", order);

		return "admin/order-detail";
	}

	@RequestMapping(value = "/order-status.htm", method = RequestMethod.POST)
	public String updateOrderStatus(@RequestParam("orderId") Integer orderId,
								   @RequestParam("status") Integer status, HttpSession session) {
		// Validate status phải nằm trong range 0-4
		if (status == null || status < 0 || status > 4) {
			return "redirect:/admin/orders.htm";
		}
		
		// Dùng OrderService để vừa cập nhật trạng thái vừa phục hồi tồn kho (nếu hủy đơn)
		orderService.updateOrderStatusByAdmin(orderId, status);
		
		return "redirect:/admin/order-detail.htm?id=" + orderId;
	}
}
