package com.sport.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "ViewedProducts")
public class ViewedProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "viewed_at")
    private Date viewedAt;

    // Constructors
    public ViewedProductEntity() {}

    public ViewedProductEntity(Integer userId, Integer productId) {
        this.userId = userId;
        this.productId = productId;
        this.viewedAt = new Date();
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public Date getViewedAt() { return viewedAt; }
    public void setViewedAt(Date viewedAt) { this.viewedAt = viewedAt; }
}
