package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.hibernate.Query;

import com.sport.entity.Order;
import com.sport.entity.OrderItemEntity;

@Repository
public class OrderDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	public void saveOrder(Order order) {
		Session session = sessionFactory.getCurrentSession();
		session.save(order);
		// Cascade will save order items automatically due to FetchType.LAZY + CascadeType.ALL
	}

	@Transactional
	public void saveOrderItem(OrderItemEntity item) {
		Session session = sessionFactory.getCurrentSession();
		session.save(item);
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

	@Transactional
	public Order getOrderByIdWithItems(Integer id) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT o FROM Order o LEFT JOIN FETCH o.orderItems LEFT JOIN FETCH o.user WHERE o.id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (Order) query.uniqueResult();
	}

	@Transactional
	public void updateOrderStatus(Integer orderId, Integer status) {
		Session session = sessionFactory.getCurrentSession();
		Order order = (Order) session.get(Order.class, orderId);
		if (order != null) {
			order.setStatus(status);
			session.update(order);
		}
	}

	@Transactional
	@SuppressWarnings("unchecked")
	public List<Order> findByUserId(Integer userId) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.orderItems WHERE o.user.id = :uid ORDER BY o.orderDate DESC";
		Query query = session.createQuery(hql);
		query.setParameter("uid", userId);
		return query.list();
	}

	@Transactional
	public boolean cancelOrder(Integer orderId, Integer userId) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "UPDATE Order SET status = -1 WHERE id = :oid AND user.id = :uid AND status = 0";
		int updated = session.createQuery(hql)
				.setParameter("oid", orderId)
				.setParameter("uid", userId)
				.executeUpdate();
		return updated > 0;
	}
}
