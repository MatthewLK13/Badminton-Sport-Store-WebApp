package com.sport.dao;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.sport.entity.WishlistEntity;

@Repository
@Transactional
public class WishlistDao {
	@Autowired
	private SessionFactory factory;
	
	public List<WishlistEntity> getByUserId(int userId){
		Session session = factory.getCurrentSession();
		Query query = session.createQuery(
				 "FROM WishlistEntity WHERE userId = :uid"
				);
		query.setParameter("uid", userId);
		return query.list();
	}
	
	public long countByUserId(int userId) {
		Session session = factory.getCurrentSession();
		Query query = session.createQuery(
				 "SELECT COUNT(w) FROM WishlistEntity w WHERE w.userId = :uid"
				);
		query.setParameter("uid", userId);
		return (Long) query.uniqueResult();
	}
	
	public boolean exists(int userId, int productId) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "SELECT COUNT(w) FROM WishlistEntity w WHERE w.userId = :uid AND w.productId = :pid");
        query.setParameter("uid", userId);
        query.setParameter("pid", productId);
        return ((Long) query.uniqueResult()) > 0;
    }

    public void add(int userId, int productId) {
        Session session = factory.getCurrentSession();
        WishlistEntity w = new WishlistEntity();
        w.setUserId(userId);
        w.setProductId(productId);
        session.save(w);
    }

    public void remove(int userId, int productId) {
        Session session = factory.getCurrentSession();
        session.createQuery(
            "DELETE FROM WishlistEntity WHERE userId = :uid AND productId = :pid")
            .setParameter("uid", userId)
            .setParameter("pid", productId)
            .executeUpdate();
    }
}
