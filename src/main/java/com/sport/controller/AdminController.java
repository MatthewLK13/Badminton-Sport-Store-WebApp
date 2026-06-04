package com.sport.controller;

import java.util.List;
import java.util.Calendar;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sport.dao.OrderDAO;
import com.sport.entity.Order;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private OrderDAO orderDAO;

	@RequestMapping(value ="/orders.htm", method = RequestMethod.GET)
	public String listOrders(Model model) {
		List<Order> orders = orderDAO.getAllOrders();
		
		int totalOrders = orders.size();
		int newOrdersThisMonth = 0;
		
		Calendar cal = Calendar.getInstance();
		int currentMonth = cal.get(Calendar.MONTH);
		int currentYear = cal.get(Calendar.YEAR);
		
		for (Order order : orders) {
			if (order.getOrderDate() != null) {
				cal.setTime(order.getOrderDate());
				if(cal.get(Calendar.MONTH) == currentMonth && cal.get(Calendar.YEAR) == currentYear) {
					newOrdersThisMonth++;
				}
			}
		}
		
		model.addAttribute("orders", orders);
		model.addAttribute("totalOrders", totalOrders);
		model.addAttribute("newOrders", newOrdersThisMonth);
		return "admin/orders";
	}
	
	@RequestMapping(value = "/order-detail.htm", method = RequestMethod.GET)
	public String orderDetail(@RequestParam("id") Integer id, Model model) {
		Order order = orderDAO.getOrderByIdWithItems(id);
		if (order == null) {
			return "redirect:/admin/orders.htm";
		}

		model.addAttribute("order", order);

		return "admin/order-detail";
	}

	@RequestMapping(value = "/order-status.htm", method = RequestMethod.POST)
	public String updateOrderStatus(@RequestParam("orderId") Integer orderId,
								   @RequestParam("status") Integer status) {
		// Validate status phải nằm trong range 0-4
		if (status == null || status < 0 || status > 4) {
			return "redirect:/admin/orders.htm";
		}
		orderDAO.updateOrderStatus(orderId, status);
		return "redirect:/admin/order-detail.htm?id=" + orderId;
	}
}
