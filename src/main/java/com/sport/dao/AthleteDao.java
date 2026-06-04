package com.sport.dao;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sport.entity.AthleteEntity;

@Repository
@Transactional
public class AthleteDao {
	@Autowired
	private SessionFactory factory;
	
	public List<AthleteEntity> getAll() {
        Session session = factory.getCurrentSession();
        return session.createQuery("FROM AthleteEntity").list();
    }
	
	public AthleteEntity getById(int id) {
		Session session = factory.getCurrentSession();
		return (AthleteEntity) session.get(AthleteEntity.class, id);
	}
}
