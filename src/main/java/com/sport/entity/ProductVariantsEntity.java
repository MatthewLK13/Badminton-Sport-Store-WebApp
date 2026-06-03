package com.sport.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ProductVariants") // Khớp chính xác với tên bảng trong SQL Server của bạn
public class ProductVariantsEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	// Mối quan hệ Nhiều biến thể thuộc về Một sản phẩm chính (Many-to-One)
	@ManyToOne
	@JoinColumn(name = "product_id") // Khớp với tên cột khóa ngoại dưới DB của bạn
	private ProductsEntity product;

	@Column(name = "variant_name", length = 255)
	private String variant_name;



	@Column(name = "stock_quantity")
	private Integer stock_quantity;

	// --- Hàm khởi tạo (Constructors) ---
	public ProductVariantsEntity() {
	}

	// --- Các hàm Getter và Setter giúp Controller đóng/mở gói dữ liệu ---
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ProductsEntity getProduct() {
		return product;
	}

	public void setProduct(ProductsEntity product) {
		this.product = product;
	}

	public String getVariant_name() {
		return variant_name;
	}

	public void setVariant_name(String variant_name) {
		this.variant_name = variant_name;
	}


	public Integer getStock_quantity() {
		return stock_quantity;
	}

	public void setStock_quantity(Integer stock_quantity) {
		this.stock_quantity = stock_quantity;
	}


}