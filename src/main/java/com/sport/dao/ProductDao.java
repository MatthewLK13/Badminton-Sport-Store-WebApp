package com.sport.dao;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.LinkedHashMap;

import com.sport.entity.BrandsEntity;
import com.sport.entity.CategoriesEntity;
import com.sport.entity.ProductAttributeEntity;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.ProductsEntity;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class ProductDao {

    @Autowired
    private SessionFactory factory;
    
    public BrandsEntity getBrandByName(String brandName) {
        Session session = factory.getCurrentSession();
        String hql = "FROM BrandsEntity b WHERE b.brandName = :brandName";
        Query query = session.createQuery(hql);
        query.setParameter("brandName", brandName);
        return (BrandsEntity) query.uniqueResult();
    }

    public CategoriesEntity getCategoryById(Integer categoryId) {
        Session session = factory.getCurrentSession();
        String hql = "FROM CategoriesEntity c WHERE c.id = :categoryId";
        Query query = session.createQuery(hql);
        query.setParameter("categoryId", categoryId);
        return (CategoriesEntity) query.uniqueResult();
    }
    
    public List<ProductsEntity> getProductsByCategoryAndBrand(
            Integer categoryId, Integer brandId,
            Double minPrice, Double maxPrice,
            String footType, Boolean inStockOnly,
            String sortBy,
            int page, int pageSize) {

        Session session = factory.getCurrentSession();
        StringBuilder hql = new StringBuilder("FROM ProductsEntity p WHERE 1=1");

        if (categoryId != null) hql.append(" AND p.category_id.id = :categoryId");
        if (brandId != null)    hql.append(" AND p.brand_id.id = :brandId");
        if (minPrice != null)   hql.append(" AND p.price >= :minPrice");
        if (maxPrice != null)   hql.append(" AND p.price <= :maxPrice");

        if (footType != null && !footType.isEmpty()) {
            if (footType.equals("normal")) {
                hql.append(" AND LOWER(p.productName) NOT LIKE '%slim%' AND LOWER(p.productName) NOT LIKE '%wide%'");
            } else {
                hql.append(" AND LOWER(p.productName) LIKE :footType");
            }
        }

        if (Boolean.TRUE.equals(inStockOnly)) {
            hql.append(" AND EXISTS (SELECT v FROM ProductVariantsEntity v WHERE v.product = p AND v.stock_quantity > 0)");
        }

        if ("priceAsc".equals(sortBy)) {
            hql.append(" ORDER BY p.price ASC");
        } else if ("priceDesc".equals(sortBy)) {
            hql.append(" ORDER BY p.price DESC");
        } else if ("oldest".equals(sortBy)) {
            hql.append(" ORDER BY p.id ASC");
        } else {
            hql.append(" ORDER BY p.id DESC");
        }

        Query query = session.createQuery(hql.toString());
        if (categoryId != null) query.setParameter("categoryId", categoryId);
        if (brandId != null)    query.setParameter("brandId", brandId);
        if (minPrice != null)   query.setParameter("minPrice", minPrice);
        if (maxPrice != null)   query.setParameter("maxPrice", maxPrice);
        if (footType != null && !footType.isEmpty() && !footType.equals("normal"))
            query.setParameter("footType", "%" + footType.toLowerCase() + "%");

        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.list();
    }

    public long countProductsByCategoryAndBrand(
            Integer categoryId, Integer brandId,
            Double minPrice, Double maxPrice,
            String footType, Boolean inStockOnly) {

        Session session = factory.getCurrentSession();
        StringBuilder hql = new StringBuilder("SELECT COUNT(p.id) FROM ProductsEntity p WHERE 1=1");

        if (categoryId != null) hql.append(" AND p.category_id.id = :categoryId");
        if (brandId != null)    hql.append(" AND p.brand_id.id = :brandId");
        if (minPrice != null)   hql.append(" AND p.price >= :minPrice");
        if (maxPrice != null)   hql.append(" AND p.price <= :maxPrice");

        if (footType != null && !footType.isEmpty()) {
            if (footType.equals("normal")) {
                hql.append(" AND LOWER(p.productName) NOT LIKE '%slim%' AND LOWER(p.productName) NOT LIKE '%wide%'");
            } else {
                hql.append(" AND LOWER(p.productName) LIKE :footType");
            }
        }

        if (Boolean.TRUE.equals(inStockOnly)) {
            hql.append(" AND EXISTS (SELECT v FROM ProductVariantsEntity v WHERE v.product = p AND v.stock_quantity > 0)");
        }

        Query query = session.createQuery(hql.toString());
        if (categoryId != null) query.setParameter("categoryId", categoryId);
        if (brandId != null)    query.setParameter("brandId", brandId);
        if (minPrice != null)   query.setParameter("minPrice", minPrice);
        if (maxPrice != null)   query.setParameter("maxPrice", maxPrice);
        if (footType != null && !footType.isEmpty() && !footType.equals("normal"))
            query.setParameter("footType", "%" + footType.toLowerCase() + "%");

        return (Long) query.uniqueResult();
    }
    
    public List<BrandsEntity> getAllBrands() {
        Session session = factory.getCurrentSession();
        return session.createQuery("FROM BrandsEntity ORDER BY brandName").list();
    }
    
    public ProductsEntity getProductById(int productId) {
        Session session = factory.getCurrentSession();
        
        String hql1 = "SELECT DISTINCT p FROM ProductsEntity p " +
                      "LEFT JOIN FETCH p.productVariants " +
                      "WHERE p.id = :productId";
        Query query1 = session.createQuery(hql1);
        query1.setParameter("productId", productId);
        ProductsEntity product = (ProductsEntity) query1.uniqueResult();
        
        String hql2 = "SELECT DISTINCT p FROM ProductsEntity p " +
                      "LEFT JOIN FETCH p.productImages " +
                      "WHERE p.id = :productId";
        Query query2 = session.createQuery(hql2);
        query2.setParameter("productId", productId);
        return (ProductsEntity) query2.uniqueResult();
    }
    
    public List<Object[]> getFilterOptionsByCategoryId(Integer categoryId) {
        String sql = "SELECT fa.attr_key, fa.attr_label, pa.attr_value " +
                     "FROM FilterAttributes fa " +
                     "JOIN ProductAttributes pa ON fa.attr_key = pa.attr_key " +
                     "JOIN Products p ON pa.product_id = p.id " +
                     "WHERE fa.category_id = :catId " +
                     "GROUP BY fa.attr_key, fa.attr_label, pa.attr_value " +
                     "ORDER BY fa.display_order ASC";
                     
        Query query = factory.getCurrentSession().createSQLQuery(sql);
        query.setParameter("catId", categoryId);
        return query.list();
    }



    /**
     * Lấy các nhóm tiêu chí và giá trị tương ứng của danh mục để hiển thị Checkbox lên JSP.
     */
    public Map<String, List<String>> getGroupedFiltersByCategoryId(Integer categoryId) {
        Map<String, List<String>> groupedFilters = new LinkedHashMap<>();
        if (categoryId == null) return groupedFilters;

        try {
            String sql = "SELECT fa.attr_label, pa.attr_value " +
                         "FROM FilterAttributes fa " +
                         "LEFT JOIN ProductAttributes pa ON fa.attr_key = pa.attr_key " +
                         "LEFT JOIN Products p ON pa.product_id = p.id AND p.category_id = :catId " +
                         "WHERE fa.category_id = :catId " +
                         "GROUP BY fa.attr_label, pa.attr_value, fa.display_order " +
                         "ORDER BY fa.display_order ASC, pa.attr_value ASC";

            // THÊM addScalar để ép kiểu NVARCHAR → String
            Query query = factory.getCurrentSession().createSQLQuery(sql)
                    .addScalar("attr_label", org.hibernate.type.StandardBasicTypes.STRING)
                    .addScalar("attr_value", org.hibernate.type.StandardBasicTypes.STRING);
                    
            query.setParameter("catId", categoryId);
            List<Object[]> rows = query.list();

            for (Object[] row : rows) {
                if (row[0] == null) continue;
                String label = row[0].toString().trim();
                String value = (row[1] != null) ? row[1].toString().trim() : "";

                if (!groupedFilters.containsKey(label)) {
                    groupedFilters.put(label, new ArrayList<String>());
                }
                if (!value.isEmpty() && !groupedFilters.get(label).contains(value)) {
                    groupedFilters.get(label).add(value);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return groupedFilters;
    }

    /**
     * Hàm truy vấn lọc danh sách sản phẩm theo nhiều tiêu chí động 
     */
    public List<ProductsEntity> getProductsByDynamicFilters(
            Integer categoryId, List<String> attrs, Double minPrice, Double maxPrice,
            Boolean inStockOnly, String sortBy, Integer page, int pageSize) {

        try {
            Session session = factory.getCurrentSession();
            
            // Bước 1: Lấy danh sách ID sản phẩm trước
            StringBuilder hqlIds = new StringBuilder(
                "SELECT p.id FROM ProductsEntity p WHERE p.category_id.id = :catId");

            if (minPrice != null) hqlIds.append(" AND p.price >= :minPrice");
            if (maxPrice != null) hqlIds.append(" AND p.price <= :maxPrice");
            if (Boolean.TRUE.equals(inStockOnly)) {
                hqlIds.append(" AND EXISTS (SELECT v FROM ProductVariantsEntity v WHERE v.product = p AND v.stock_quantity > 0)");
            }
            if (attrs != null && !attrs.isEmpty()) {
                for (int i = 0; i < attrs.size(); i++) {
                    hqlIds.append(" AND EXISTS (SELECT 1 FROM ProductAttributeEntity WHERE productId = p.id AND attrValue = :attr" + i + ")");
                }
            }
            if ("priceAsc".equals(sortBy))       hqlIds.append(" ORDER BY p.price ASC");
            else if ("priceDesc".equals(sortBy)) hqlIds.append(" ORDER BY p.price DESC");
            else if ("oldest".equals(sortBy))    hqlIds.append(" ORDER BY p.id ASC");
            else                                 hqlIds.append(" ORDER BY p.id DESC");

            Query queryIds = session.createQuery(hqlIds.toString());
            queryIds.setParameter("catId", categoryId);
            if (minPrice != null) queryIds.setParameter("minPrice", minPrice);
            if (maxPrice != null) queryIds.setParameter("maxPrice", maxPrice);
            if (attrs != null) {
                for (int i = 0; i < attrs.size(); i++) {
                    queryIds.setParameter("attr" + i, attrs.get(i));
                }
            }
            queryIds.setFirstResult((page - 1) * pageSize);
            queryIds.setMaxResults(pageSize);
            List<Integer> ids = queryIds.list();

            if (ids == null || ids.isEmpty()) return new ArrayList<>();

            // Bước 2: Fetch đầy đủ với ảnh theo ID
            Query queryFull = session.createQuery(
                "SELECT DISTINCT p FROM ProductsEntity p " +
                "LEFT JOIN FETCH p.productImages " +
                "WHERE p.id IN (:ids)");
            queryFull.setParameterList("ids", ids);
            return queryFull.list();

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Hàm đếm tổng số lượng sản phẩm sau khi lọc động để phục vụ phân trang.
     */
    public long countProductsByDynamicFilters(
            Integer categoryId, List<String> attrs, Double minPrice, Double maxPrice, Boolean inStockOnly) {

        try {
            Session session = factory.getCurrentSession();
            StringBuilder hql = new StringBuilder("SELECT COUNT(p.id) FROM ProductsEntity p WHERE p.category_id.id = :catId");

            if (minPrice != null) hql.append(" AND p.price >= :minPrice");
            if (maxPrice != null) hql.append(" AND p.price <= :maxPrice");

            if (Boolean.TRUE.equals(inStockOnly)) {
                hql.append(" AND EXISTS (SELECT v FROM ProductVariantsEntity v WHERE v.product = p AND v.stock_quantity > 0)");
            }

            if (attrs != null && !attrs.isEmpty()) {
                for (int i = 0; i < attrs.size(); i++) {
                    hql.append(" AND EXISTS (SELECT 1 FROM ProductAttributeEntity WHERE productId = p.id AND attrValue = :attr" + i + ")");
                }
            }

            Query query = session.createQuery(hql.toString());
            query.setParameter("catId", categoryId);
            if (minPrice != null) query.setParameter("minPrice", minPrice);
            if (maxPrice != null) query.setParameter("maxPrice", maxPrice);
            if (attrs != null) {
                for (int i = 0; i < attrs.size(); i++) {
                    query.setParameter("attr" + i, attrs.get(i));
                }
            }

            return (Long) query.uniqueResult();

        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    public List<ProductAttributeEntity> getAttributesByProductId(int productId) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "FROM ProductAttributeEntity WHERE productId = :pid");
        query.setParameter("pid", productId);
        return query.list();
    }
    
    public List<ProductsEntity> getRelatedProducts(int categoryId,int excludeProductId){
    	Session session = factory.getCurrentSession();
    	Query query = session.createQuery(
    			"SELECT DISTINCT p FROM ProductsEntity p " +
    			        "LEFT JOIN FETCH p.productImages " +
    			        "WHERE p.category_id.id = :catId AND p.id != :excludeId " +
    			        "ORDER BY p.id DESC"
    			);
    	query.setParameter("catId", categoryId);
    	query.setParameter("excludeId", excludeProductId);
    	query.setMaxResults(8);
    	return query.list();
    }
    public List<ProductsEntity> getComplementaryProducts(int categoryId) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "SELECT DISTINCT p FROM ProductsEntity p " +
            "LEFT JOIN FETCH p.productImages " +
            "WHERE p.category_id.id != :catId " +
            "ORDER BY p.id DESC");
        query.setParameter("catId", categoryId);
        query.setMaxResults(4);
        return query.list();
    }
    public ProductVariantsEntity getVariantById(int variantId) {
        Session session = factory.getCurrentSession();

        Query query = session.createQuery(
            "SELECT DISTINCT v FROM ProductVariantsEntity v " +
            "JOIN FETCH v.product p " +
            "LEFT JOIN FETCH p.productImages " +
            "WHERE v.id = :id"
        );

        query.setParameter("id", variantId);

        List<ProductVariantsEntity> list = query.list();
        return list.isEmpty() ? null : list.get(0);
    }

    public ProductVariantsEntity getDefaultVariantByProductId(int productId) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "FROM ProductVariantsEntity v " +
            "WHERE v.product.id = :productId AND v.stock_quantity > 0 " +
            "ORDER BY v.id ASC"
        );
        query.setParameter("productId", productId);
        query.setMaxResults(1);

        List<ProductVariantsEntity> list = query.list();
        return list.isEmpty() ? null : list.get(0);
    }

    public List<ProductsEntity> getNewArrivals(int limit) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "FROM ProductsEntity p ORDER BY p.id DESC"
        );
        query.setMaxResults(limit);
        return query.list();
    }

    public List<ProductsEntity> searchProducts(String keyword, int page, int pageSize) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "FROM ProductsEntity p WHERE p.productName LIKE :keyword OR p.description LIKE :keyword ORDER BY p.id DESC"
        );
        query.setParameter("keyword", "%" + keyword + "%");
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.list();
    }

    public long countSearchProducts(String keyword) {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery(
            "SELECT COUNT(p.id) FROM ProductsEntity p WHERE p.productName LIKE :keyword OR p.description LIKE :keyword"
        );
        query.setParameter("keyword", "%" + keyword + "%");
        return (Long) query.uniqueResult();
    }

    public long countAllProducts() {
        Session session = factory.getCurrentSession();
        Query query = session.createQuery("SELECT COUNT(p.id) FROM ProductsEntity p");
        return (Long) query.uniqueResult();
    }
}
