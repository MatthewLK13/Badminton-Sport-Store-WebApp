package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.sport.entity.User;
import java.util.List;

@Repository
@Transactional
public class UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    public User findByEmailOrPhone(String identifier) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM User u WHERE u.email = :id OR u.phone = :id";
        Query query = session.createQuery(hql);
        query.setParameter("id", identifier);
        return (User) query.uniqueResult();
    }

    @SuppressWarnings("unchecked")
    public List<User> getAllUsers() {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM User u ORDER BY u.id ASC";
        Query query = session.createQuery(hql);
        return query.list();
    }

    public boolean existsByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
        Query query = session.createQuery(hql);
        query.setParameter("email", email);
        Long count = (Long) query.uniqueResult();
        return count != null && count > 0;
    }

    public boolean existsByPhone(String phone) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(u) FROM User u WHERE u.phone = :phone";
        Query query = session.createQuery(hql);
        query.setParameter("phone", phone);
        Long count = (Long) query.uniqueResult();
        return count != null && count > 0;
    }

    public Long countTotalUsers() {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT COUNT(u) FROM User u";
        Query query = session.createQuery(hql);
        return (Long) query.uniqueResult();
    }

    public void saveUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.save(user);
    }

    public void updateUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.update(user);
    }
}