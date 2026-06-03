package com.sport.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.sport.entity.*;
import com.sport.service.BackgroundRemoverService;

@Repository
@Transactional
public class AdminProductDao {

    @Autowired
    private SessionFactory factory;

    public void saveFullProduct(
            String productName, int categoryId, int brandId,
            Double price, String description,
            MultipartFile fileMain, MultipartFile fileRight,
            MultipartFile fileTop, MultipartFile fileBottom,
            String[] variantNames, Integer[] stockQuantities,
            String[] attrKeys, String[] attrValues,
            String uploadFolder, String sourceFolder) throws Exception {

        Session session = factory.getCurrentSession();
        Transaction t = session.beginTransaction();

        try {
            // ==========================================
            // 1. LƯU SẢN PHẨM CHÍNH
            // ==========================================
            ProductsEntity product = new ProductsEntity();
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);

            CategoriesEntity cate = (CategoriesEntity) session.get(CategoriesEntity.class, categoryId);
            BrandsEntity brand = (BrandsEntity) session.get(BrandsEntity.class, brandId);
            product.setCategory_id(cate);
            product.setBrand_id(brand);

            String currentDateTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(new java.util.Date());
            product.setCreateAt(currentDateTime);

            session.save(product);
            System.out.println("✔ Lưu sản phẩm thành công! ID = " + product.getId());

        
            // 2. LƯU ẢNH + XÓA NỀN AI
   
            saveImages(session, product, productName,
                    fileMain, fileRight, fileTop, fileBottom,
                    uploadFolder, sourceFolder);

  
            // 3. LƯU BIẾN THỂ (SIZE & SỐ LƯỢNG)

            saveVariants(session, product, variantNames, stockQuantities);

    
            // 4. LƯU ATTRIBUTES TỪ FORM ĐỘNG
       
            saveFormAttributes(session, product, attrKeys, attrValues);

            
            // 5. LƯU ATTRIBUTES TỰ ĐỘNG (BRAND, SIZE, WEIGHT)
            
            saveAutoAttributes(session, product, brandId, categoryId, variantNames);

            t.commit();
            System.out.println("✔ Commit toàn bộ dữ liệu thành công!");

        } catch (Exception e) {
            if (t != null) t.rollback();
            System.err.println("✘ Lỗi, đã rollback: " + e.getMessage());
            throw e;
        } finally {
            if (session != null) session.close();
        }
    }


    // PRIVATE: Lưu ảnh

    private void saveImages(Session session, ProductsEntity product,
            String productName,
            MultipartFile fileMain, MultipartFile fileRight,
            MultipartFile fileTop, MultipartFile fileBottom,
            String uploadFolder, String sourceFolder) throws Exception {

        File directory = new File(uploadFolder);
        if (!directory.exists()) directory.mkdirs();

        String productSlug = product.covertedToSlug(productName);
        MultipartFile[] files = {fileMain, fileRight, fileTop, fileBottom};
        String[] suffixes = {"main", "right", "top", "bottom"};

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            String suffix = suffixes[i];

            if (file == null || file.isEmpty()) {
                if ("main".equals(suffix)) {
                    throw new IllegalArgumentException("Ảnh main là bắt buộc!");
                }
                continue;
            }

            String finalFileName = productSlug + "-" + suffix + ".png";
            String serverPath = uploadFolder + File.separator + finalFileName;
            String sourcePath = sourceFolder + finalFileName;

            // Tạo file tạm
            File tempFile = File.createTempFile("upload_", file.getOriginalFilename());
            file.transferTo(tempFile);

            try {
                // Đảm bảo thư mục source tồn tại
                new File(sourcePath).getParentFile().mkdirs();

                // Gọi AI xóa nền
                boolean isRemoved = BackgroundRemoverService.removeBackground(tempFile, sourcePath);

                if (isRemoved) {
                    // AI thành công: copy ảnh đã xóa nền sang server Tomcat
                    java.nio.file.Files.copy(
                        new File(sourcePath).toPath(),
                        new File(serverPath).toPath(),
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING
                    );
                    System.out.println(" Xóa nền thành công: " + finalFileName);
                } else {
                    // AI thất bại: lưu ảnh gốc vào cả 2 nơi
                    java.nio.file.Files.copy(tempFile.toPath(),
                        new File(sourcePath).toPath(),
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    java.nio.file.Files.copy(tempFile.toPath(),
                        new File(serverPath).toPath(),
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    System.out.println(" AI thất bại, lưu ảnh gốc: " + finalFileName);
                }
            } catch (Exception e) {
                // Fallback: lưu ảnh gốc vào server để tránh sập
                try {
                    java.nio.file.Files.copy(tempFile.toPath(),
                        new File(serverPath).toPath(),
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                } catch (Exception ex) { ex.printStackTrace(); }
                System.err.println(" Lỗi AI: " + e.getMessage() + " → lưu ảnh gốc dự phòng.");
            } finally {
                if (tempFile.exists()) tempFile.delete();
            }

            // Lưu vào bảng ProductImages
            ProductImagesEntity img = new ProductImagesEntity();
            img.setProduct(product);
            img.setImageUrl(finalFileName);
            img.setIsMain("main".equals(suffix));
            session.save(img);
            System.out.println(" Lưu ảnh DB: " + finalFileName);
        }
    }

    // ==========================================
    // PRIVATE: Lưu biến thể
    // ==========================================
    private void saveVariants(Session session, ProductsEntity product,
            String[] variantNames, Integer[] stockQuantities) {

        if (variantNames == null || stockQuantities == null) return;

        for (int i = 0; i < variantNames.length; i++) {
            if (variantNames[i] == null || variantNames[i].trim().isEmpty()) continue;

            ProductVariantsEntity variant = new ProductVariantsEntity();
            variant.setProduct(product);
            variant.setVariant_name(variantNames[i].trim());
            variant.setStock_quantity(stockQuantities[i]);
            session.save(variant);
        }
        System.out.println(" Lưu " + variantNames.length + " biến thể thành công!");
    }

    // ==========================================
    // PRIVATE: Lưu attributes từ form động
    // ==========================================
    private void saveFormAttributes(Session session, ProductsEntity product,
            String[] attrKeys, String[] attrValues) {

        if (attrKeys == null || attrValues == null) return;

        for (int i = 0; i < attrKeys.length; i++) {
            String key = attrKeys[i];
            String value = (i < attrValues.length) ? attrValues[i] : "";

            if (key == null || key.trim().isEmpty()) continue;
            if (value == null || value.trim().isEmpty()) continue;

            session.createSQLQuery(
                "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, :key, :val)"
            )
            .setParameter("pid", product.getId())
            .setParameter("key", key.trim())
            .setParameter("val", value.trim())
            .executeUpdate();
        }
        System.out.println(" Lưu form attributes thành công!");
    }

    // ==========================================
    // PRIVATE: Lưu attributes tự động
    // ==========================================
    private void saveAutoAttributes(Session session, ProductsEntity product,
            int brandId, int categoryId, String[] variantNames) {

        // Brand filter
        String brandName = "";
        if (brandId == 1) brandName = "Yonex";
        else if (brandId == 2) brandName = "Victor";
        else if (brandId == 3) brandName = "Lining";
        else if (brandId == 4) brandName = "Mizuno";
        else if (brandId == 5) brandName = "Kawasaki";
        else if (brandId == 6) brandName = "Venson";

        if (!brandName.isEmpty()) {
            session.createSQLQuery(
                "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'brand_filter', :val)"
            )
            .setParameter("pid", product.getId())
            .setParameter("val", brandName)
            .executeUpdate();
        }

        // Size / Weight filter từ variant names
        if (variantNames == null) return;

        java.util.Set<String> added = new java.util.HashSet<>();

        for (String vName : variantNames) {
            if (vName == null || vName.trim().isEmpty()) continue;

            String trimmed = vName.trim();
            String upper = trimmed.toUpperCase();

            // Quần áo (S, M, L, XL, XXL)
            if (categoryId == 3 && (upper.equals("S") || upper.equals("M") || upper.equals("L")
                    || upper.equals("XL") || upper.equals("XXL") || upper.contains("SIZE"))) {

                String sizeVal = trimmed.replaceAll("(?i)Size\\s*", "").toUpperCase().trim();
                if (!sizeVal.isEmpty() && added.add("cloth_size_" + sizeVal)) {
                    session.createSQLQuery(
                        "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'cloth_size', :val)"
                    )
                    .setParameter("pid", product.getId())
                    .setParameter("val", sizeVal)
                    .executeUpdate();
                }

            // Giày (số hoặc chứa "size")
            } else if (categoryId == 2 && (trimmed.toLowerCase().contains("size") || trimmed.matches("\\d+"))) {

                String sizeVal = trimmed.replaceAll("(?i)Size\\s*", "").trim();
                if (!sizeVal.isEmpty() && added.add("size_filter_" + sizeVal)) {
                    session.createSQLQuery(
                        "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'size_filter', :val)"
                    )
                    .setParameter("pid", product.getId())
                    .setParameter("val", sizeVal)
                    .executeUpdate();
                }

            // Vợt (chứa U: 2U, 3U, 4U, 5U)
            } else if (upper.contains("U")) {
                String weightVal = "";
                if (upper.contains("2U")) weightVal = "2U";
                else if (upper.contains("3U")) weightVal = "3U";
                else if (upper.contains("4U")) weightVal = "4U";
                else if (upper.contains("5U")) weightVal = "5U";

                if (!weightVal.isEmpty() && added.add("weight_" + weightVal)) {
                    session.createSQLQuery(
                        "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'weight', :val)"
                    )
                    .setParameter("pid", product.getId())
                    .setParameter("val", weightVal)
                    .executeUpdate();
                }
            }
        }
        System.out.println(" Lưu auto attributes thành công!");
    }
    
    public List<ProductsEntity> getAllProducts(String keyword, Integer categoryId, 
            Integer brandId, String fromDate, int page, int pageSize) {
        
        Session session = factory.getCurrentSession();
        
        StringBuilder hql = new StringBuilder(
            "SELECT DISTINCT p FROM ProductsEntity p " +
            "LEFT JOIN FETCH p.productImages " +
            	
            "WHERE 1=1");
        
        if (keyword != null && !keyword.trim().isEmpty())
            hql.append(" AND LOWER(p.productName) LIKE :keyword");
        if (categoryId != null && categoryId > 0)
            hql.append(" AND p.category_id.id = :categoryId");
        if (brandId != null && brandId > 0)
            hql.append(" AND p.brand_id.id = :brandId");
        if (fromDate != null && !fromDate.trim().isEmpty())
            hql.append(" AND p.createAt >= :fromDate");

        hql.append(" ORDER BY p.id DESC");

        Query query = session.createQuery(hql.toString());

        if (keyword != null && !keyword.trim().isEmpty())
            query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
        if (categoryId != null && categoryId > 0)
            query.setParameter("categoryId", categoryId);
        if (brandId != null && brandId > 0)
            query.setParameter("brandId", brandId);
        if (fromDate != null && !fromDate.trim().isEmpty())
            query.setParameter("fromDate", fromDate);

        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);

        return query.list(); // ← không cần try/finally, không close session
    }
    public long countAllProducts(String keyword, Integer categoryId, 
            Integer brandId, String fromDate) {
        
        Session session = factory.getCurrentSession();
        
        StringBuilder hql = new StringBuilder(
            "SELECT COUNT(p.id) FROM ProductsEntity p WHERE 1=1"
        );

        if (keyword != null && !keyword.trim().isEmpty())
            hql.append(" AND LOWER(p.productName) LIKE :keyword");
        if (categoryId != null && categoryId > 0)
            hql.append(" AND p.category_id.id = :categoryId");
        if (brandId != null && brandId > 0)
            hql.append(" AND p.brand_id.id = :brandId");
        if (fromDate != null && !fromDate.trim().isEmpty())
            hql.append(" AND p.createAt >= :fromDate");

        Query query = session.createQuery(hql.toString());

        if (keyword != null && !keyword.trim().isEmpty())
            query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
        if (categoryId != null && categoryId > 0)
            query.setParameter("categoryId", categoryId);
        if (brandId != null && brandId > 0)
            query.setParameter("brandId", brandId);
        if (fromDate != null && !fromDate.trim().isEmpty())
            query.setParameter("fromDate", fromDate);

        return (Long) query.uniqueResult(); // ← không cần try/finally, không close session
    }
    public int getTotalStockByProductId(int productId) {
        Session session = factory.getCurrentSession();
        Long total = (Long) session.createQuery(
            "SELECT SUM(v.stock_quantity) FROM ProductVariantsEntity v WHERE v.product.id = :pid")
            .setParameter("pid", productId)
            .uniqueResult();
        return total != null ? total.intValue() : 0;
    }
    public Map<Integer, List<Map<String, Object>>> getVariantsByProductIds(List<Integer> productIds) {
        Session session = factory.getCurrentSession();
        Map<Integer, List<Map<String, Object>>> result = new java.util.LinkedHashMap<>();
        
        if (productIds == null || productIds.isEmpty()) return result;
        
        List<Object[]> rows = session.createQuery(
            "SELECT v.product.id, v.variant_name, v.stock_quantity " +
            "FROM ProductVariantsEntity v " +
            "WHERE v.product.id IN (:ids) " +
            "ORDER BY v.product.id, v.id")
            .setParameterList("ids", productIds)
            .list();
        
        for (Object[] row : rows) {
            int productId = (Integer) row[0];
            String variantName = (String) row[1];
            int stock = (Integer) row[2];
            
            if (!result.containsKey(productId)) {
                result.put(productId, new java.util.ArrayList<>());
            }
            Map<String, Object> v = new HashMap<>();
            v.put("name", variantName);
            v.put("stock", stock);
            result.get(productId).add(v);
        }
        return result;
    }
    public ProductsEntity getProductByIdForEdit(int productId) {
        Session session = factory.getCurrentSession();
        
        // Fetch basic info + images
        ProductsEntity product = (ProductsEntity) session.createQuery(
            "SELECT DISTINCT p FROM ProductsEntity p " +
            "LEFT JOIN FETCH p.productImages " +
            "WHERE p.id = :id")
            .setParameter("id", productId)
            .uniqueResult();
        
        return product;
    }

    public List<ProductVariantsEntity> getVariantsByProductId(int productId) {
        Session session = factory.getCurrentSession();
        return session.createQuery(
            "FROM ProductVariantsEntity v WHERE v.product.id = :pid ORDER BY v.id")
            .setParameter("pid", productId)
            .list();
    }

    public List<ProductAttributeEntity> getAttrsByProductId(int productId) {
        Session session = factory.getCurrentSession();
        return session.createQuery(
            "FROM ProductAttributeEntity WHERE productId = :pid")
            .setParameter("pid", productId)
            .list();
    }

    public void updateProduct(int productId, String productName, int categoryId,
            int brandId, Double price, String description,
            String[] variantIds, String[] variantNames, Integer[] stockQuantities,
            String[] attrKeys, String[] attrValues,
            MultipartFile fileMain, MultipartFile fileRight,
            MultipartFile fileTop, MultipartFile fileBottom,
            String uploadFolder, String sourceFolder) throws Exception {

        Session session = factory.getCurrentSession();

        // 1. Update thông tin cơ bản
        ProductsEntity product = (ProductsEntity) session.get(ProductsEntity.class, productId);
        product.setProductName(productName);
        product.setPrice(price);
        product.setDescription(description);

        CategoriesEntity cate = (CategoriesEntity) session.get(CategoriesEntity.class, categoryId);
        BrandsEntity brand = (BrandsEntity) session.get(BrandsEntity.class, brandId);
        product.setCategory_id(cate);
        product.setBrand_id(brand);
        session.update(product);

        // 2. Update variants
        if (variantIds != null && variantNames != null && stockQuantities != null) {
            for (int i = 0; i < variantIds.length; i++) {
                String vid = variantIds[i];
                String vName = (i < variantNames.length) ? variantNames[i] : "";
                Integer vStock = (i < stockQuantities.length) ? stockQuantities[i] : 0;

                if (vName == null || vName.trim().isEmpty()) continue; // bỏ qua nếu tên trống

                if (vid == null || vid.trim().isEmpty()) {
                    // ← INSERT variant mới
                    ProductVariantsEntity newV = new ProductVariantsEntity();
                    newV.setProduct(product);
                    newV.setVariant_name(vName.trim());
                    newV.setStock_quantity(vStock != null ? vStock : 0);
                    session.save(newV);
                    System.out.println("✔ Thêm variant mới: " + vName);
                } else {
                    // ← UPDATE variant cũ
                    int variantId = Integer.parseInt(vid);
                    ProductVariantsEntity v = (ProductVariantsEntity) session.get(ProductVariantsEntity.class, variantId);
                    if (v != null) {
                        v.setVariant_name(vName.trim());
                        v.setStock_quantity(vStock != null ? vStock : 0);
                        session.update(v);
                    }
                }
            }
        }

        
        session.createSQLQuery(
            "DELETE FROM ProductAttributes WHERE product_id = :pid " +
            "AND attr_key NOT IN ('brand_filter','weight','size_filter','cloth_size')")
            .setParameter("pid", productId)
            .executeUpdate();

        if (attrKeys != null && attrValues != null) {
            for (int i = 0; i < attrKeys.length; i++) {
                String key = attrKeys[i];
                String value = (i < attrValues.length) ? attrValues[i] : "";
                if (key == null || key.trim().isEmpty()) continue;
                if (value == null || value.trim().isEmpty()) continue;
                session.createSQLQuery(
                    "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, :key, :val)")
                    .setParameter("pid", productId)
                    .setParameter("key", key.trim())
                    .setParameter("val", value.trim())
                    .executeUpdate();
            }
        }

        // 4. Update ảnh nếu có upload mới
        String productSlug = product.covertedToSlug(productName);
        MultipartFile[] files = {fileMain, fileRight, fileTop, fileBottom};
        String[] suffixes = {"main", "right", "top", "bottom"};

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            String suffix = suffixes[i];
            if (file == null || file.isEmpty()) continue;

            String finalFileName = productSlug + "-" + suffix + ".png";
            String serverPath = uploadFolder + File.separator + finalFileName;
            String sourcePath = sourceFolder + finalFileName;

            File tempFile = File.createTempFile("upload_", file.getOriginalFilename());
            file.transferTo(tempFile);

            try {
                new File(sourcePath).getParentFile().mkdirs();
                boolean isRemoved = BackgroundRemoverService.removeBackground(tempFile, sourcePath);
                if (isRemoved) {
                    java.nio.file.Files.copy(new File(sourcePath).toPath(),
                        new File(serverPath).toPath(),
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                } else {
                    java.nio.file.Files.copy(tempFile.toPath(),
                        new File(sourcePath).toPath(),
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    java.nio.file.Files.copy(tempFile.toPath(),
                        new File(serverPath).toPath(),
                        java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                }
            } finally {
                if (tempFile.exists()) tempFile.delete();
            }

            // Update tên ảnh trong DB
            session.createSQLQuery(
                "UPDATE ProductImages SET image_url = :url " +
                "WHERE product_id = :pid AND is_main = :isMain")
                .setParameter("url", finalFileName)
                .setParameter("pid", productId)
                .setParameter("isMain", "main".equals(suffix))
                .executeUpdate();
        }

        System.out.println(" Update sản phẩm " + productId + " thành công!");
    }
    public void deleteProduct(int productId) {
        Session session = factory.getCurrentSession();
        
        // 1. Xóa ProductAttributes
        session.createSQLQuery(
            "DELETE FROM ProductAttributes WHERE product_id = :pid")
            .setParameter("pid", productId)
            .executeUpdate();
        
        // 2. Xóa ProductImages
        session.createSQLQuery(
            "DELETE FROM ProductImages WHERE product_id = :pid")
            .setParameter("pid", productId)
            .executeUpdate();
        
        // 3. Xóa ProductVariants
        session.createSQLQuery(
            "DELETE FROM ProductVariants WHERE product_id = :pid")
            .setParameter("pid", productId)
            .executeUpdate();
        
        // 4. Xóa Product chính
        session.createSQLQuery(
            "DELETE FROM Products WHERE id = :pid")
            .setParameter("pid", productId)
            .executeUpdate();
        
        System.out.println(" Xóa sản phẩm " + productId + " thành công!");
    }
}