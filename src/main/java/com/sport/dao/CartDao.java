package com.sport.dao;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sport.entity.CartEntity;

@Repository
@Transactional
public class CartDao {
	@Autowired
	private SessionFactory factory;

	public List<CartEntity> getByUserId(int userId){
		Session session = factory.getCurrentSession();
		Query query = session.createQuery(
				"FROM CartEntity WHERE userId = :uid ORDER BY id DESC"
				);
		query.setParameter("uid", userId);
		return query.list();
	}

	public List<CartEntity> getCartByUserId(int userId) {
		return getByUserId(userId);
	}

	public Long countByUserId(int userId) {
		Session session = factory.getCurrentSession();
		Query query = session.createQuery(
				"SELECT COUNT(c) FROM CartEntity c WHERE c.userId = :uid"
				);
		query.setParameter("uid", userId);
		return (Long) query.uniqueResult();
	}

	// Kiem tra variant da co trong gio chua
    public CartEntity findByUserAndVariant(int userId, int variantId) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "FROM CartEntity WHERE userId = :uid AND productVariantId = :vid");
        query.setParameter("uid", userId);
        query.setParameter("vid", variantId);
        query.setMaxResults(1);
        List<CartEntity> list = query.list();
        return list.isEmpty() ? null : list.get(0);
    }

    // Them vao gio
    public void add(int userId, int variantId, int quantity) {
        Session session = factory.getCurrentSession();
        CartEntity existing = findByUserAndVariant(userId, variantId);
        if (existing != null) {
            // Da co -> cong them so luong
            existing.setQuantity(existing.getQuantity() + quantity);
            session.update(existing);
        } else {
            // Chua co -> them moi
            CartEntity cart = new CartEntity();
            cart.setUserId(userId);
            cart.setProductVariantId(variantId);
            cart.setQuantity(quantity);
            cart.setAddedAt(new java.util.Date());
            session.save(cart);
        }
    }

    // Cap nhat so luong
    public void updateQuantity(int cartId, int quantity) {
        Session session = factory.getCurrentSession();
        CartEntity cart = (CartEntity) session.get(CartEntity.class, cartId);
        if (cart != null) {
            cart.setQuantity(quantity);
            session.update(cart);
        }
    }

    // Xoa item khoi gio
    public void remove(int cartId) {
        Session session = factory.getCurrentSession();
        session.createQuery("DELETE FROM CartEntity WHERE id = :id")
            .setParameter("id", cartId)
            .executeUpdate();
    }

    // Xoa toan bo gio cua user
    public void clearCart(int userId) {
        Session session = factory.getCurrentSession();
        session.createQuery("DELETE FROM CartEntity WHERE userId = :uid")
            .setParameter("uid", userId)
            .executeUpdate();
    }

    public CartEntity getCartById(int cartId) {
        Session session = factory.getCurrentSession();
        return (CartEntity) session.get(CartEntity.class, cartId);
    }
}
