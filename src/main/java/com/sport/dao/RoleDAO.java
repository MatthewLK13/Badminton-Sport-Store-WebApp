package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sport.entity.Role;
import java.util.List;

@Repository
@Transactional
public class RoleDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<Role> getAllRoles() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Role ORDER BY id ASC").list();
    }
    
    public Role getRoleById(Integer id) {
        Session session = sessionFactory.getCurrentSession();
        return (Role) session.get(Role.class, id);
    }
}
