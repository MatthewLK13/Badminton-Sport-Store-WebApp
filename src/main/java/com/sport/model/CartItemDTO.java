package com.sport.model;

public class CartItemDTO {
    private Integer cartId;
    private Integer variantId;
    private String productName;
    private String variantName;
    private Double price;
    private String avatarName;
    private Integer quantity;

    public CartItemDTO() {}

    public CartItemDTO(Integer cartId, Integer variantId, String productName,
                       String variantName, Double price, String avatarName, Integer quantity) {
        this.cartId = cartId;
        this.variantId = variantId;
        this.productName = productName;
        this.variantName = variantName;
        this.price = price;
        this.avatarName = avatarName;
        this.quantity = quantity;
    }

    public Integer getCartId() { return cartId; }
    public void setCartId(Integer cartId) { this.cartId = cartId; }

    public Integer getVariantId() { return variantId; }
    public void setVariantId(Integer variantId) { this.variantId = variantId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getVariantName() { return variantName; }
    public void setVariantName(String variantName) { this.variantName = variantName; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getAvatarName() { return avatarName; }
    public void setAvatarName(String avatarName) { this.avatarName = avatarName; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
}
