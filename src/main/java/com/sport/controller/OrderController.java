package com.sport.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.sport.dao.OrderDAO;
import com.sport.dao.ProductDao;
import com.sport.entity.Order;
import com.sport.entity.OrderItemEntity;
import com.sport.entity.User;
import java.util.List;

import com.sport.util.LocaleUtils;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private com.sport.service.OrderService orderService;

    @RequestMapping("/history.htm")
    public String orderHistory(HttpSession session, org.springframework.ui.Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        List<Order> orders = orderDAO.findByUserId(user.getId());
        model.addAttribute("orders", orders);
        return "order-history";
    }

    @RequestMapping(value = "/detail.htm", method = RequestMethod.GET)
    public String orderDetail(@RequestParam("id") Integer orderId, HttpSession session, org.springframework.ui.Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        Order order = orderDAO.getOrderByIdWithItems(orderId);
        if (order == null || order.getUser() == null || !order.getUser().getId().equals(user.getId())) {
            return "redirect:/order/history.htm";
        }

        model.addAttribute("order", order);
        return "order-detail-customer";
    }

    @RequestMapping(value = "/cancel.htm", method = RequestMethod.POST)
    public String cancelOrder(@RequestParam("orderId") Integer orderId, HttpServletRequest request, HttpSession session, org.springframework.ui.Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login.htm";
        }

        // Get order and verify ownership
        Order order = orderDAO.getOrderByIdWithItems(orderId);
        if (order == null || order.getUser() == null || !order.getUser().getId().equals(user.getId())) {
            return "redirect:/order/history.htm";
        }

        // Only pending orders (status=0) can be cancelled
        if (order.getStatus() != 0) {
            model.addAttribute("error", LocaleUtils.msg(request, "order.cancel.warning"));
            model.addAttribute("orders", orderDAO.findByUserId(user.getId()));
            return "order-history";
        }

        // Cancel order via Transactional Service
        boolean success = orderService.cancelOrderByUser(orderId, user.getId());
        if (!success) {
            model.addAttribute("error", LocaleUtils.msg(request, "order.cancel.error"));
            model.addAttribute("orders", orderDAO.findByUserId(user.getId()));
            return "order-history";
        }

        model.addAttribute("success", LocaleUtils.msg(request, "order.cancel.success"));
        model.addAttribute("orders", orderDAO.findByUserId(user.getId()));
        return "order-history";
    }
}
