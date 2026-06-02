package com.sport.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Date;
import com.sport.dao.OrderDAO;
import com.sport.model.CheckoutDTO;
import com.sport.entity.Order;

@Controller
@RequestMapping("/checkout.htm")
public class CheckoutController {
	
	@Autowired
	private OrderDAO orderDAO;
	
	@RequestMapping(method = RequestMethod.GET)
	public String showCheckoutPage() {
		return "checkout";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String processCheckout(@ModelAttribute CheckoutDTO checkoutData) {
		Order order = new Order();
		
		order.setEmail(checkoutData.getEmail());
		order.setFirstName(checkoutData.getFirstName());
		order.setLastName(checkoutData.getLastName());
		order.setAddress(checkoutData.getAddress());
		order.setPhone(checkoutData.getPhone());
        order.setCardNumber(checkoutData.getCardNumber());
        order.setOrderDate(new Date()); 
        order.setStatus(0);
        orderDAO.saveOrder(order);
        System.out.println("LƯU ĐƠN HÀNG THÀNH CÔNG VÀO DATABASE!");
        return "redirect:/home.htm";
	}
}
