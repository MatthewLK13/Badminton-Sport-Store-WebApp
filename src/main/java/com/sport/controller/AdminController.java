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

import org.springframework.util.DigestUtils;

import com.sport.dao.OrderDAO;
import com.sport.dao.RoleDAO;
import com.sport.dao.UserDAO;
import com.sport.entity.Order;
import com.sport.entity.Role;
import com.sport.entity.User;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private OrderDAO orderDAO;

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private RoleDAO roleDAO;

	@RequestMapping(value ="/dashboard.htm", method = RequestMethod.GET)
	public String showDashboard(Model model) {
		Long totalUsers = userDAO.countTotalUsers();
		int totalOrders = orderDAO.getAllOrders().size();
		
		// Mock data for sales and products since we don't have these tables/columns yet
		model.addAttribute("totalSales", "120,000.00");
		model.addAttribute("totalUsers", totalUsers != null ? totalUsers : 0);
		model.addAttribute("totalProducts", "5,112");
		model.addAttribute("totalOrders", totalOrders);
		
		return "admin/dashboard";
	}

	@RequestMapping(value ="/users.htm", method = RequestMethod.GET)
	public String listUsers(Model model) {
		List<User> users = userDAO.getAllUsers();
		Long totalUsers = userDAO.countTotalUsers();
		
		model.addAttribute("users", users);
		model.addAttribute("totalUsers", totalUsers != null ? totalUsers : 0);
		model.addAttribute("newUsers", 100); // Mock data as per Figma design
		
		return "admin/users";
	}

	@RequestMapping(value = "/add-user.htm", method = RequestMethod.GET)
	public String showAddUserForm(Model model) {
		List<Role> roles = roleDAO.getAllRoles();
		model.addAttribute("roles", roles);
		return "admin/user-form";
	}

	@RequestMapping(value = "/save-user.htm", method = RequestMethod.POST)
	public String saveUser(
			@RequestParam("fullName") String fullName,
			@RequestParam("email") String email,
			@RequestParam("password") String password,
			@RequestParam("roleId") Integer roleId,
			@RequestParam("isActive") Boolean isActive) {
		
		User newUser = new User();
		newUser.setFullName(fullName);
		newUser.setEmail(email);
		
		// Encrypt password using MD5
		String encryptedPassword = DigestUtils.md5DigestAsHex(password.getBytes());
		newUser.setPasswordHash(encryptedPassword);
		
		Role role = roleDAO.getRoleById(roleId);
		newUser.setRole(role);
		newUser.setIsActive(isActive);
		
		userDAO.saveUser(newUser);
		
		return "redirect:/admin/users.htm";
	}

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
		Order order = orderDAO.getOrderById(id);
		if (order == null) {
			return "redirect:/admin/orders.htm";
		}
		
		model.addAttribute("order", order);
		
		return "admin/order-detail";
	}
}
