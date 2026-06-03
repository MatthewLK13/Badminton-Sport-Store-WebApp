package com.sport.entity;

import javax.persistence.*;
import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "Products")
public class ProductsEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "price")
    private Double price;

    @Column(name = "description")
    private String description;

    @Column(name = "created_at")
    private String createAt;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private CategoriesEntity category_id;

    @ManyToOne
    @JoinColumn(name = "brand_id")
    private BrandsEntity brand_id;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private Collection<ProductImagesEntity> productImages;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<ProductVariantsEntity> productVariants;

    public ProductsEntity() {}

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCreateAt() { return createAt; }
    public void setCreateAt(String createAt) { this.createAt = createAt; }

    public CategoriesEntity getCategory_id() { return category_id; }
    public void setCategory_id(CategoriesEntity category_id) { this.category_id = category_id; }

    public BrandsEntity getBrand_id() { return brand_id; }
    public void setBrand_id(BrandsEntity brand_id) { this.brand_id = brand_id; }

    public Collection<ProductImagesEntity> getProductImages() { return productImages; }
    public void setProductImages(Collection<ProductImagesEntity> productImages) { this.productImages = productImages; }

    public List<ProductVariantsEntity> getProductVariants() { return productVariants; }
    public void setProductVariants(List<ProductVariantsEntity> productVariants) { this.productVariants = productVariants; }

    // Lấy tên ảnh đại diện
    public String getAvatarName() {
        if (this.productImages != null && !this.productImages.isEmpty()) {
            for (ProductImagesEntity img : this.productImages) {
                if (img.getIsMain() != null && img.getIsMain()) {
                    return img.getImageUrl();
                }
            }
            return this.productImages.iterator().next().getImageUrl();
        }
        return "placeholder.jpg";
    }

    // Chuyển tên sản phẩm thành slug
    public String covertedToSlug(String input) {
        if (input == null) return "";
        String str = input.toLowerCase().trim();
        str = str.replaceAll("[àáạảãâầấậẩẫăằắặẳẵ]", "a");
        str = str.replaceAll("[èéẹẻẽêềếệểễ]", "e");
        str = str.replaceAll("[ìíịỉĩ]", "i");
        str = str.replaceAll("[òóọỏõôồốộổỗơờớợởỡ]", "o");
        str = str.replaceAll("[ùúụủũưừứựửữ]", "u");
        str = str.replaceAll("[ỳýỵỷỹ]", "y");
        str = str.replaceAll("[đ]", "d");
        str = str.replaceAll("[^a-z0-9\\s-]", "");
        str = str.replaceAll("\\s+", "-");
        str = str.replaceAll("-+", "-");
        return str;
    }
}