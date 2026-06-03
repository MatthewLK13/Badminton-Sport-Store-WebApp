package com.sport.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sport.dao.AdminProductDao;
import com.sport.entity.ProductAttributeEntity;
import com.sport.entity.ProductVariantsEntity;
import com.sport.entity.ProductsEntity;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {

    @Autowired
    private AdminProductDao adminProductDao;

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
            @RequestParam("stockQuantities") Integer[] stockQuantities) {

        try {
            String uploadFolder = context.getRealPath("/images/products");
            String sourceFolder = "C:\\Users\\Administrator\\Documents\\LTW\\Badminton-Sport-Store-WebApp\\src\\main\\webapp\\images\\products\\";

            adminProductDao.saveFullProduct(
                productName, categoryId, brandId, price, description,
                fileMain, fileRight, fileTop, fileBottom,
                variantNames, stockQuantities,
                attrKeys, attrValues,
                uploadFolder, sourceFolder
            );

            return "redirect:/products/index.htm?id=" + categoryId;

        } catch (Exception e) {
            e.printStackTrace();
            return "admin/add_product";
        }
    }

    @RequestMapping(value = "/management", method = RequestMethod.GET)
    public String showManagement(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "categoryId", required = false) Integer categoryId,
            @RequestParam(value = "brandId", required = false) Integer brandId,
            @RequestParam(value = "fromDate", required = false) String fromDate,
            @RequestParam(value = "page", defaultValue = "1") int page,
            ModelMap model) {

        int pageSize = 10;

        List<ProductsEntity> products = adminProductDao.getAllProducts(
            keyword, categoryId, brandId, fromDate, page, pageSize);
        long total = adminProductDao.countAllProducts(
            keyword, categoryId, brandId, fromDate);
  
        Map<Integer, Integer> stockMap = new HashMap<>();
        for (ProductsEntity p : products) {
            int stock = adminProductDao.getTotalStockByProductId(p.getId());
            stockMap.put(p.getId(), stock);
        }
     // Lấy danh sách product ID
        List<Integer> productIds = new java.util.ArrayList<>();
        for (ProductsEntity p : products) {
            productIds.add(p.getId());
        }

        // Lấy variants theo từng product
        Map<Integer, List<Map<String, Object>>> variantsMap = 
            productIds.isEmpty() ? new HashMap<>() : 
            adminProductDao.getVariantsByProductIds(productIds);

        model.addAttribute("variantsMap", variantsMap);
        model.addAttribute("stockMap", stockMap);
        model.addAttribute("products", products);
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategoryId", categoryId);
        model.addAttribute("selectedBrandId", brandId);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", (int) Math.ceil((double) total / pageSize));
        model.addAttribute("totalProducts", total);

        return "admin/product_manage";
    }
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String showEditForm(
            @RequestParam("id") int productId,
            @RequestParam(value = "extraRows", defaultValue = "0") int extraRows,
            ModelMap model) {

        ProductsEntity product = adminProductDao.getProductByIdForEdit(productId);
        List<ProductVariantsEntity> variants = adminProductDao.getVariantsByProductId(productId);
        List<ProductAttributeEntity> attrs = adminProductDao.getAttrsByProductId(productId);

        model.addAttribute("product", product);
        model.addAttribute("variants", variants);
        model.addAttribute("attrs", attrs);
        model.addAttribute("extraRows", extraRows);
        return "admin/edit_product";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateProduct(
            @RequestParam("productId") int productId,
            @RequestParam("productName") String productName,
            @RequestParam("categoryId") int categoryId,
            @RequestParam("brandId") int brandId,
            @RequestParam("price") Double price,
            @RequestParam("description") String description,
            @RequestParam(value = "variantIds", required = false) String[] variantIds,
            @RequestParam(value = "variantNames", required = false) String[] variantNames,
            @RequestParam(value = "stockQuantities", required = false) Integer[] stockQuantities,
            @RequestParam(value = "attrKeys", required = false) String[] attrKeys,
            @RequestParam(value = "attrValues", required = false) String[] attrValues,
            @RequestParam(value = "fileMain", required = false) MultipartFile fileMain,
            @RequestParam(value = "fileRight", required = false) MultipartFile fileRight,
            @RequestParam(value = "fileTop", required = false) MultipartFile fileTop,
            @RequestParam(value = "fileBottom", required = false) MultipartFile fileBottom) {

        try {
            String uploadFolder = context.getRealPath("/images/products");
            String sourceFolder = "C:\\Users\\Administrator\\Documents\\LTW\\Badminton-Sport-Store-WebApp\\src\\main\\webapp\\images\\products\\";

            adminProductDao.updateProduct(
                productId, productName, categoryId, brandId, price, description,
                variantIds, variantNames, stockQuantities,
                attrKeys, attrValues,
                fileMain, fileRight, fileTop, fileBottom,
                uploadFolder, sourceFolder
            );

            return "redirect:/admin/product/management.htm";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/product/edit.htm?id=" + productId;
        }
    }
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String showDeleteConfirm(
            @RequestParam("id") int productId,
            ModelMap model) {
        ProductsEntity product = adminProductDao.getProductByIdForEdit(productId);
        model.addAttribute("product", product);
        return "admin/delete_confirm";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String deleteProduct(@RequestParam("productId") int productId) {
        try {
            adminProductDao.deleteProduct(productId);
            return "redirect:/admin/product/management.htm";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/product/management.htm";
        }
    }
}