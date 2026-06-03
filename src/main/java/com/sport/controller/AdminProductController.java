package com.sport.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sport.entity.BrandsEntity;
import com.sport.entity.CategoriesEntity;
import com.sport.entity.ProductImagesEntity;
import com.sport.entity.ProductsEntity;
import com.sport.entity.ProductVariantsEntity; 
import com.sport.service.BackgroundRemoverService;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {
	
	@Autowired
	private SessionFactory factory;
	
	@Autowired
	private ServletContext context;
	
	@RequestMapping("/add")
	public String showAddForm() {
		return "admin/add_product";
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String saveProduct(
			@RequestParam("productName") String productName,
			@RequestParam("categoryId") int categoryId,
			@RequestParam("brandId") int brandId,
			@RequestParam("price") Double price,
			@RequestParam("description") String description,
			@RequestParam("fileMain") MultipartFile fileMain,
			@RequestParam("fileRight") MultipartFile fileRight,
			@RequestParam("fileTop") MultipartFile fileTop,
			@RequestParam("fileBottom") MultipartFile fileBottom,
			@RequestParam("variantNames") String[] variantNames,
			@RequestParam(value = "attrKeys", required = false) String[] attrKeys,
			@RequestParam(value = "attrValues", required = false) String[] attrValues,
			@RequestParam("stockQuantities") Integer[] stockQuantities 
			) {
		System.out.println("=== REAL PATH: " + context.getRealPath("/"));
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		
		try {
			//  Lưu thông tin sản phẩm chính ---
			ProductsEntity product = new ProductsEntity();
			product.setProductName(productName);
			product.setPrice(price);
			product.setDescription(description);
			
			CategoriesEntity cate = (CategoriesEntity) session.get(CategoriesEntity.class, categoryId);
			BrandsEntity brand = (BrandsEntity) session.get(BrandsEntity.class, brandId);
			product.setBrand_id(brand);
			product.setCategory_id(cate);
			
			// Gán ngày giờ hiện tại cho sản phẩm mới tạo
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentDateTimeString = formatter.format(new java.util.Date());
			product.setCreateAt(currentDateTimeString);

			// Lưu sản phẩm chính xuống trước để tự động sinh ra Product ID (Khóa chính)
			session.save(product);
			
			// Cấu hình thư mục và chuẩn bị ảnh ---
			String productSlug = product.covertedToSlug(productName);
			String uploadFolder = context.getRealPath("/images/products");
			
			File directory = new File(uploadFolder);
			if (!directory.exists()) {
				directory.mkdirs();
			}
			
			// Vòng lặp xử lý ảnh và gọi AI xóa nền ---
			MultipartFile[] files = {fileMain, fileRight, fileTop, fileBottom};
			String[] suffixes = {"main", "right", "top", "bottom"};
			
			for (int i = 0; i < files.length; i++) {
			    MultipartFile file = files[i];
			    String suffix = suffixes[i];
			    
			    // Kiểm tra trống ảnh
			    if (file == null || file.isEmpty()) {
			        if ("main".equals(suffix)) {
			            System.err.println(" Lỗi Back-end: Admin không upload ảnh Main bắt buộc!");
			            throw new IllegalArgumentException("Ảnh đại diện (Main side) là bắt buộc, không được để trống!");
			        }
			        continue; 
			    }
			    
			    String finalFileName = productSlug + "-" + suffix + ".png";
			    
			    //  Đường dẫn ảo trong thư mục build của Server Tomcat
			    String fullPathToSave = uploadFolder + java.io.File.separator + finalFileName;

			    // Tạo sẵn file tạm để nhận dữ liệu upload
			    java.io.File tempFile = java.io.File.createTempFile("upload_", file.getOriginalFilename());
			    file.transferTo(tempFile);

			    try {
			        // Gọi AI xử lý xóa nền và lưu vào thư mục Server Tomcat
			        boolean isRemoved = BackgroundRemoverService.removeBackground(tempFile, fullPathToSave);
			        if (!isRemoved) {
			            // Nếu AI thất bại (hết lượt), tự động copy ảnh gốc vào thư mục
			            java.nio.file.Files.copy(tempFile.toPath(), new java.io.File(fullPathToSave).toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
			            System.out.println(" [AI Thất Bại] Hệ thống tự động chuyển hướng lưu giữ lại ảnh gốc!");
			        }
			    } catch (Exception e) {
			        // Phòng hờ lỗi hệ thống, ép buộc lưu ảnh gốc để tránh sập luồng của DB
			        try {
			            java.nio.file.Files.copy(tempFile.toPath(), new java.io.File(fullPathToSave).toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
			        } catch (Exception ex) { ex.printStackTrace(); }
			        System.err.println(" Lỗi ngoại lệ tại luồng AI: " + e.getMessage() + " -> Đã lưu ảnh gốc dự phòng.");
			    }

			    // ĐƯA RA NGOÀI ĐIỀU KIỆN IF AI: Đảm bảo bảng ProductImages LUÔN LUÔN ĐƯỢC LƯU
			    ProductImagesEntity imgEntity = new ProductImagesEntity();
			    imgEntity.setProduct(product);
			    imgEntity.setImageUrl(finalFileName);
			    imgEntity.setIsMain("main".equals(suffix)); 
			    
			    session.save(imgEntity);
			    System.out.println("Đã ghi nhận thông tin ảnh vào bảng ProductImages thành công!");
			    
			    
			    if (tempFile.exists()) {
			        tempFile.delete();
			    }
			}
			
			//  Lưu danh sách Biến thể (Size & Số lượng tồn kho) ---
			if (variantNames != null && stockQuantities != null) {
				for (int j = 0; j < variantNames.length; j++) {
					ProductVariantsEntity variant = new ProductVariantsEntity();
					variant.setProduct(product);                  
					variant.setVariant_name(variantNames[j]);     
					variant.setStock_quantity(stockQuantities[j]); 
					
					session.save(variant); 
				}
			}
			if (attrKeys != null && attrValues != null) {
			    for (int k = 0; k < attrKeys.length; k++) {
			        String key = attrKeys[k];
			        String value = (k < attrValues.length) ? attrValues[k] : "";
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
			}
			//  Lưu ProductAttributes
			// ============================================================
						// XỬ LÝ TỰ ĐỘNG BÓC TÁCH BỘ LỌC (BRAND, SIZE, WEIGHT) CHO DB
						// ============================================================
						
						// 1. Tự động lưu bộ lọc Thương hiệu (brand_filter) dựa trên brandId (Áp dụng cho TẤT CẢ danh mục)
						String brandNameFilter = "";
						if (brandId == 1) brandNameFilter = "Yonex";
						else if (brandId == 2) brandNameFilter = "Victor";
						else if (brandId == 3) brandNameFilter = "Lining";

						if (!brandNameFilter.isEmpty()) {
							session.createSQLQuery(
								"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'brand_filter', :val)"
							)
							.setParameter("pid", product.getId())
							.setParameter("val", brandNameFilter)
							.executeUpdate();
						}

						// 2. Tự động duyệt qua tồn kho để lưu bộ lọc Kích cỡ hoặc Trọng lượng
						if (variantNames != null) {
							java.util.Set<String> addedFilters = new java.util.HashSet<>();
							
							for (String vName : variantNames) {
								if (vName == null || vName.trim().isEmpty()) continue;
								
								String trimmedName = vName.trim();
								String upperName = trimmedName.toUpperCase();
								
								// THƯỜNG HỢP 1: NẾU LÀ SẢN PHẨM QUẦN ÁO (Biến thể nhập dạng chữ: S, M, L, XL, XXL)
								if (categoryId == 3 && (upperName.equals("S") || upperName.equals("M") || upperName.equals("L") 
										|| upperName.equals("XL") || upperName.equals("XXL") || upperName.contains("SIZE"))) {
									
									String sizeValue = trimmedName.replaceAll("(?i)Size\\s*", "").toUpperCase().trim();
									if (!sizeValue.isEmpty() && addedFilters.add("cloth_size_" + sizeValue)) {
										session.createSQLQuery(
			                                // Đổi từ 'size_filter' thành 'cloth_size' ở đây
											"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'cloth_size', :val)"
										)
										.setParameter("pid", product.getId())
										.setParameter("val", sizeValue)
										.executeUpdate();
									}
								}
								
								// TRƯỜNG HỢP 2: NẾU LÀ GIÀY CẦU LÔNG (Chuỗi chứa chữ "Size" hoặc chỉ chứa số, ví dụ "40", "41")
								else if (categoryId == 2 && (trimmedName.toLowerCase().contains("size") || trimmedName.matches("\\d+"))) {
									String sizeValue = trimmedName.replaceAll("(?i)Size\\s*", "").trim();
									if (!sizeValue.isEmpty() && addedFilters.add("size_filter_" + sizeValue)) {
										session.createSQLQuery(
											"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'size_filter', :val)"
										)
										.setParameter("pid", product.getId())
										.setParameter("val", sizeValue)
										.executeUpdate();
									}
								}
								
								// TRƯỜNG HỢP 3: NẾU LÀ VỢT CẦU LÔNG (Chuỗi chứa chữ "U", ví dụ "4U G5" -> bóc lấy "4U")
								else if (upperName.contains("U")) {
									String weightValue = "";
									if (upperName.contains("2U")) weightValue = "2U";
									else if (upperName.contains("3U")) weightValue = "3U";
									else if (upperName.contains("4U")) weightValue = "4U";
									else if (upperName.contains("5U")) weightValue = "5U";
									
									if (!weightValue.isEmpty() && addedFilters.add("weight_" + weightValue)) {
										session.createSQLQuery(
											"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'weight', :val)"
										)
										.setParameter("pid", product.getId())
										.setParameter("val", weightValue)
										.executeUpdate();
									}
								}
							}
						}
					
			
			t.commit();
			System.out.println("Hoàn tất! Toàn bộ dữ liệu đã được commit thành công xuống Database.");
			
		} catch (Exception e) {
			if (t != null) {
				t.rollback();
			}
			e.printStackTrace();
			return "admin/add_product"; 
		} finally {
			if (session != null) {
				session.close();
			}
		}
		
		
		return "desktop5/product_list"; 
	}
}