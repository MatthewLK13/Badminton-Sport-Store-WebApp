package com.sport.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.sport.entity.*;
import com.sport.dao.ProductDao;

@Controller
@RequestMapping("products")
public class ProductController {
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String listProducts(
	        @RequestParam("id") Integer categoryId,
	        @RequestParam(value = "attrs", required = false) List<String> attrs,
	        @RequestParam(value = "brand", required = false) String brandName,
	        @RequestParam(value = "minPrice", required = false) Double minPrice,
	        @RequestParam(value = "maxPrice", required = false) Double maxPrice,
	        @RequestParam(value = "inStock", required = false) Boolean inStock,
	        @RequestParam(value = "sortBy", required = false) String sortBy,
	        @RequestParam(value = "page", defaultValue = "1") Integer page,
	        ModelMap model) {

	    model.addAttribute("category", productDao.getCategoryById(categoryId));
	    
	    Map<String, List<String>> dynamicFilters = productDao.getGroupedFiltersByCategoryId(categoryId);
	    model.addAttribute("dynamicFilters", dynamicFilters);

	   
	    if (brandName != null && !brandName.isEmpty()) {
	        if (attrs == null) attrs = new ArrayList<>();
	        attrs.add(brandName);
	    }

	    int pageSize = 20;
	    List<ProductsEntity> products = productDao.getProductsByDynamicFilters(
	            categoryId, attrs, minPrice, maxPrice, inStock, sortBy, page, pageSize);
	    long totalProducts = productDao.countProductsByDynamicFilters(
	            categoryId, attrs, minPrice, maxPrice, inStock);

	    model.addAttribute("products", products);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", (int) Math.ceil((double) totalProducts / pageSize));
	    model.addAttribute("minPrice", minPrice);
	    model.addAttribute("maxPrice", maxPrice);
	    model.addAttribute("inStockOnly", inStock);
	    model.addAttribute("selectedSortBy", sortBy);
	    model.addAttribute("selectedBrand", brandName);

	    return "desktop5/product_list";
	}
	
	@RequestMapping(value ="details" , method = RequestMethod.GET)
	public String showProductDetails(
	        @RequestParam("id") int productId,
	        ModelMap model) {

	    ProductsEntity product = productDao.getProductById(productId);
	    model.addAttribute("product", product);

	    List<ProductAttributeEntity> attrs = productDao.getAttributesByProductId(productId);
	    model.addAttribute("productAttrs", attrs);

	    // Sản phẩm liên quan cùng category
	    List<ProductsEntity> related = productDao.getRelatedProducts(
	        product.getCategory_id().getId(), productId);
	    model.addAttribute("relatedProducts", related);

	    // Sản phẩm hoàn thiện phong cách (category khác)
	    List<ProductsEntity> complementary = productDao.getComplementaryProducts(
	        product.getCategory_id().getId());
	    model.addAttribute("complementaryProducts", complementary);

	    return "desktop6/product_details";
	}
}