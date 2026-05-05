package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.sport.entity.User;

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

    public void saveUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.save(user);
    }
}