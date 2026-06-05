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

import com.sport.dao.OrderDAO;
import com.sport.dao.UserDAO;
import com.sport.dao.AdminProductDao;
import com.sport.entity.Order;
import com.sport.entity.User;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private OrderDAO orderDAO;

	@Autowired
	private com.sport.service.OrderService orderService;

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
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="orderDate", required=false) String orderDateStr,
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

		List<Order> filteredOrders = new java.util.ArrayList<Order>();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		
		for (Order order : allOrders) {
			boolean matchKeyword = true;
			boolean matchDate = true;

			if (keyword != null && !keyword.trim().isEmpty()) {
				String kw = keyword.trim().toLowerCase();
				String fullName = (order.getFirstName() + " " + order.getLastName()).toLowerCase();
				String email = order.getEmail() != null ? order.getEmail().toLowerCase() : "";
				String idStr = String.valueOf(order.getId());
				
				// Search matches ID, or name, or email
				if (!idStr.equals(kw) && !fullName.contains(kw) && !email.contains(kw)) {
					matchKeyword = false;
				}
			}

			if (orderDateStr != null && !orderDateStr.trim().isEmpty()) {
				if (order.getOrderDate() != null) {
					String orderDateFormatted = sdf.format(order.getOrderDate());
					if (!orderDateFormatted.equals(orderDateStr.trim())) {
						matchDate = false;
					}
				} else {
					matchDate = false;
				}
			}

			if (matchKeyword && matchDate) {
				filteredOrders.add(order);
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
		// Validate status pháº£i náº±m trong range 0-4
		if (status == null || status < 0 || status > 4) {
			return "redirect:/admin/orders.htm";
		}
		
		// DÃ¹ng OrderService Ä‘á»ƒ vá»«a cáº­p nháº­t tráº¡ng thÃ¡i vá»«a phá»¥c há»“i tá»“n kho (náº¿u há»§y Ä‘Æ¡n)
		orderService.updateOrderStatusByAdmin(orderId, status);
		
		return "redirect:/admin/order-detail.htm?id=" + orderId;
	}
}

