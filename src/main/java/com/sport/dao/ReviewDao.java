package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sport.entity.ReviewEntity;

import java.util.List;

@Repository
public class ReviewDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public void save(ReviewEntity review) {
        Session session = sessionFactory.getCurrentSession();
        session.save(review);
    }

    @Transactional
    @SuppressWarnings("unchecked")
    public List<ReviewEntity> getByProductId(int productId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM ReviewEntity WHERE product.id = :pid ORDER BY createdAt DESC";
        Query query = session.createQuery(hql);
        query.setParameter("pid", productId);
        return query.list();
    }

    @Transactional
    @SuppressWarnings("unchecked")
    public List<ReviewEntity> getByUserId(int userId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM ReviewEntity WHERE user.id = :uid ORDER BY createdAt DESC";
        Query query = session.createQuery(hql);
        query.setParameter("uid", userId);
        return query.list();
    }

    @Transactional
    public Double getAverageRating(int productId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT AVG(r.rating) FROM ReviewEntity r WHERE r.product.id = :pid";
        Query query = session.createQuery(hql);
        query.setParameter("pid", productId);
        Object result = query.uniqueResult();
        return result != null ? (Double) result : 0.0;
    }

    @Transactional
    public int countByProductId(int productId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(*) FROM ReviewEntity WHERE product.id = :pid";
        Query query = session.createQuery(hql);
        query.setParameter("pid", productId);
        Object result = query.uniqueResult();
        return result != null ? ((Number) result).intValue() : 0;
    }

    @Transactional
    public boolean hasUserReviewed(int userId, int productId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(*) FROM ReviewEntity WHERE user.id = :uid AND product.id = :pid";
        Query query = session.createQuery(hql);
        query.setParameter("uid", userId);
        query.setParameter("pid", productId);
        Object result = query.uniqueResult();
        int count = result != null ? ((Number) result).intValue() : 0;
        return count > 0;
    }
}
