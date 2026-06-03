package com.sport.entity;

import javax.persistence.*;

@Entity
@Table(name = "FilterAttributes")
public class FilterAttributeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "category_id")
    private Integer categoryId;

    @Column(name = "attr_key", length = 100)
    private String attrKey;

    @Column(name = "attr_label", length = 100)
    private String attrLabel;

    @Column(name = "attr_type", length = 20)
    private String attrType;

    @Column(name = "display_order")
    private Integer displayOrder;

    public FilterAttributeEntity() {}

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getCategoryId() { return categoryId; }
    public void setCategoryId(Integer categoryId) { this.categoryId = categoryId; }

    public String getAttrKey() { return attrKey; }
    public void setAttrKey(String attrKey) { this.attrKey = attrKey; }

    public String getAttrLabel() { return attrLabel; }
    public void setAttrLabel(String attrLabel) { this.attrLabel = attrLabel; }

    public String getAttrType() { return attrType; }
    public void setAttrType(String attrType) { this.attrType = attrType; }

    public Integer getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(Integer displayOrder) { this.displayOrder = displayOrder; }
}