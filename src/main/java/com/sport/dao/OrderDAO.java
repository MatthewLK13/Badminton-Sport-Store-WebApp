package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
}
