package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.hibernate.Query;

import com.sport.entity.Order;

@Repository
public class OrderDAO {
	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	public void saveOrder(Order order) {
		Session session = sessionFactory.getCurrentSession();
		session.save(order);
	}
	
	@Transactional
	@SuppressWarnings("unchecked")
	public List<Order> getAllOrders() {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM Order ORDER BY orderDate DESC";
		Query query = session.createQuery(hql);
		return query.list();
	}
	
	@Transactional
	public Order getOrderById(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		return (Order) session.get(Order.class, id);
	}
}
