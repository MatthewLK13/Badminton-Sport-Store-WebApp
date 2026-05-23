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
			    
			    // TỰ ĐỘNG LẤY ĐƯỜNG DẪN THẬT ngoài Desktop dựa vào Server ảo (Lùi 4 cấp thư mục để về src gốc)
			 // XÓA TOÀN BỘ đoạn tính workspaceDir cũ, thay bằng dòng này:
			    String desktopPathToSave = "C:\\Users\\Administrator\\Documents\\LTW\\Badminton-Sport-Store-WebApp\\src\\main\\webapp\\images\\products\\" + finalFileName;

			    // Tạo sẵn file tạm để nhận dữ liệu upload
			    java.io.File tempFile = java.io.File.createTempFile("upload_", file.getOriginalFilename());
			    file.transferTo(tempFile);
			    
			    try {
			        // Đảm bảo thư mục Desktop thật sự tồn tại trước khi ghi file
			        java.io.File desktopFolder = new java.io.File(desktopPathToSave).getParentFile();
			        if (!desktopFolder.exists()) {
			            desktopFolder.mkdirs();
			        }

			        // Tiến hành gọi AI xử lý xóa nền và lưu thẳng vào Desktop
			        boolean isRemoved = BackgroundRemoverService.removeBackground(tempFile, desktopPathToSave);
			        
			        if (isRemoved) {
			            // Nếu AI thành công, copy bản tách nền từ Desktop sang Server tạm của Tomcat để web hiển thị ngay
			            java.nio.file.Files.copy(
			                new java.io.File(desktopPathToSave).toPath(), 
			                new java.io.File(fullPathToSave).toPath(), 
			                java.nio.file.StandardCopyOption.REPLACE_EXISTING
			            );
			            System.out.println("Đã xóa nền và đồng bộ ảnh thành công!");
			        } else {
			            // Nếu AI thất bại (hết lượt), tự động copy ảnh gốc của khách vào cả 2 nơi để cứu vãn
			            java.nio.file.Files.copy(tempFile.toPath(), new java.io.File(desktopPathToSave).toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
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
			//  Lưu ProductAttributes
			if (attrKeys != null && attrValues != null) {
			    for (int k = 0; k < attrKeys.length; k++) {
			        if (attrValues[k] != null && !attrValues[k].isEmpty()) {
			            // Dùng SQL native để insert
			            session.createSQLQuery(
			                "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, :key, :val)"
			            )
			            .setParameter("pid", product.getId())
			            .setParameter("key", attrKeys[k])
			            .setParameter("val", attrValues[k])
			            .executeUpdate();
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
		
		// Thành công: Điều hướng ra trang danh sách sản phẩm
		return "desktop5/product_list"; 
	}
}