package com.sport.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.HashSet;
import java.util.Set;

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

	@RequestMapping("/add.htm")
	public String showAddForm() {
		return "admin/add_product";
	}

	@RequestMapping(value = "/save.htm", method = RequestMethod.POST)
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
			@RequestParam("stockQuantities") Integer[] stockQuantities) {

		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			ProductsEntity product = new ProductsEntity();
			product.setProductName(productName);
			product.setPrice(price);
			product.setDescription(description);

			CategoriesEntity cate = (CategoriesEntity) session.get(CategoriesEntity.class, categoryId);
			BrandsEntity brand = (BrandsEntity) session.get(BrandsEntity.class, brandId);
			product.setBrand_id(brand);
			product.setCategory_id(cate);

			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			product.setCreateAt(formatter.format(new java.util.Date()));

			session.save(product);

			String productSlug = product.covertedToSlug(productName);
			String uploadFolder = context.getRealPath("/images/products");

			File directory = new File(uploadFolder);
			if (!directory.exists()) {
				directory.mkdirs();
			}

			MultipartFile[] files = {fileMain, fileRight, fileTop, fileBottom};
			String[] suffixes = {"main", "right", "top", "bottom"};

			for (int i = 0; i < files.length; i++) {
			    MultipartFile file = files[i];
			    String suffix = suffixes[i];

			    if (file == null || file.isEmpty()) {
			        if ("main".equals(suffix)) {
			            throw new IllegalArgumentException("Ảnh đại diện (Main side) là bắt buộc!");
			        }
			        continue;
			    }

			    String finalFileName = productSlug + "-" + suffix + ".png";
			    String fullPathToSave = uploadFolder + File.separator + finalFileName;

			    File tempFile = File.createTempFile("upload_", file.getOriginalFilename());
			    file.transferTo(tempFile);

			    try {
			        boolean isRemoved = BackgroundRemoverService.removeBackground(tempFile, fullPathToSave);
			        if (!isRemoved) {
			            Files.copy(tempFile.toPath(), new File(fullPathToSave).toPath(), StandardCopyOption.REPLACE_EXISTING);
			        }
			    } catch (Exception e) {
			        Files.copy(tempFile.toPath(), new File(fullPathToSave).toPath(), StandardCopyOption.REPLACE_EXISTING);
			    } finally {
			        if (tempFile.exists()) {
			            tempFile.delete();
			        }
			    }

			    ProductImagesEntity imgEntity = new ProductImagesEntity();
			    imgEntity.setProduct(product);
			    imgEntity.setImageUrl(finalFileName);
			    imgEntity.setIsMain("main".equals(suffix));
			    session.save(imgEntity);
			}

			if (variantNames != null && stockQuantities != null) {
				for (int j = 0; j < variantNames.length; j++) {
					if (variantNames[j] == null || variantNames[j].trim().isEmpty()) continue;
					if (stockQuantities[j] == null) continue;

					ProductVariantsEntity variant = new ProductVariantsEntity();
					variant.setProduct(product);
					variant.setVariant_name(variantNames[j].trim());
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
			            "INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, :key, :val)")
			        .setParameter("pid", product.getId())
			        .setParameter("key", key.trim())
			        .setParameter("val", value.trim())
			        .executeUpdate();
			    }
			}

			String brandNameFilter = "";
			if (brandId == 1) brandNameFilter = "Yonex";
			else if (brandId == 2) brandNameFilter = "Victor";
			else if (brandId == 3) brandNameFilter = "Lining";

			if (!brandNameFilter.isEmpty()) {
				session.createSQLQuery(
					"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'brand_filter', :val)")
				.setParameter("pid", product.getId())
				.setParameter("val", brandNameFilter)
				.executeUpdate();
			}

			if (variantNames != null) {
				Set<String> addedFilters = new HashSet<>();

				for (String vName : variantNames) {
					if (vName == null || vName.trim().isEmpty()) continue;

					String trimmedName = vName.trim();
					String upperName = trimmedName.toUpperCase();

					if (categoryId == 3 && (upperName.equals("S") || upperName.equals("M") || upperName.equals("L")
							|| upperName.equals("XL") || upperName.equals("XXL") || upperName.contains("SIZE"))) {
						String sizeValue = trimmedName.replaceAll("(?i)Size\\s*", "").toUpperCase().trim();
						if (!sizeValue.isEmpty() && addedFilters.add("cloth_size_" + sizeValue)) {
							session.createSQLQuery(
								"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'cloth_size', :val)")
							.setParameter("pid", product.getId())
							.setParameter("val", sizeValue)
							.executeUpdate();
						}
					} else if (categoryId == 2 && (trimmedName.toLowerCase().contains("size") || trimmedName.matches("\\d+"))) {
						String sizeValue = trimmedName.replaceAll("(?i)Size\\s*", "").trim();
						if (!sizeValue.isEmpty() && addedFilters.add("size_filter_" + sizeValue)) {
							session.createSQLQuery(
								"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'size_filter', :val)")
							.setParameter("pid", product.getId())
							.setParameter("val", sizeValue)
							.executeUpdate();
						}
					} else if (upperName.contains("U")) {
						String weightValue = "";
						if (upperName.contains("2U")) weightValue = "2U";
						else if (upperName.contains("3U")) weightValue = "3U";
						else if (upperName.contains("4U")) weightValue = "4U";
						else if (upperName.contains("5U")) weightValue = "5U";

						if (!weightValue.isEmpty() && addedFilters.add("weight_" + weightValue)) {
							session.createSQLQuery(
								"INSERT INTO ProductAttributes (product_id, attr_key, attr_value) VALUES (:pid, 'weight', :val)")
							.setParameter("pid", product.getId())
							.setParameter("val", weightValue)
							.executeUpdate();
						}
					}
				}
			}

			t.commit();

		} catch (Exception e) {
			if (t != null) t.rollback();
			e.printStackTrace();
			return "admin/add_product";
		} finally {
			if (session != null) session.close();
		}

		return "redirect:/products/index.htm?id=" + categoryId;
	}
}
