package com.sport.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.sport.entity.ViewedProductEntity;
import com.sport.entity.ProductsEntity;
import java.util.List;

@Repository
@Transactional
public class ViewedProductDao {

    @Autowired
    private SessionFactory sessionFactory;

    public void addViewedProduct(Integer userId, Integer productId) {
        Session session = sessionFactory.getCurrentSession();

        // Kiem tra product ton tai truoc khi luu
        ProductsEntity product = (ProductsEntity) session.get(ProductsEntity.class, productId);
        if (product == null) {
            return; // Khong luu neu product khong ton tai
        }

        // Kiem tra xem da co record chua
        String hql = "FROM ViewedProductEntity WHERE userId = :uid AND productId = :pid";
        Query query = session.createQuery(hql);
        query.setParameter("uid", userId);
        query.setParameter("pid", productId);
        List list = query.list();

        if (!list.isEmpty()) {
            // Da co -> cap nhat thoi gian
            ViewedProductEntity existing = (ViewedProductEntity) list.get(0);
            existing.setViewedAt(new java.util.Date());
            session.update(existing);
        } else {
            // Chua co -> them moi
            ViewedProductEntity viewed = new ViewedProductEntity(userId, productId);
            session.save(viewed);
        }
    }

    @SuppressWarnings("unchecked")
    public List<ViewedProductEntity> getViewedProductsByUserId(Integer userId) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "FROM ViewedProductEntity WHERE userId = :uid ORDER BY viewedAt DESC";
        Query query = session.createQuery(hql);
        query.setParameter("uid", userId);
        query.setMaxResults(10); // Gioi han 10 san pham gan nhat
        return query.list();
    }

    public void clearViewedProducts(Integer userId) {
        Session session = sessionFactory.getCurrentSession();
        session.createQuery("DELETE FROM ViewedProductEntity WHERE userId = :uid")
               .setParameter("uid", userId)
               .executeUpdate();
    }
}
