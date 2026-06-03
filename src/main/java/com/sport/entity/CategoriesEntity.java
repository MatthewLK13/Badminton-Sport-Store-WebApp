package com.sport.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="Categories")
public class CategoriesEntity {
	@Id
	@GeneratedValue
	private int id;
	@Column(name ="category_name")
	private String categoryName;
	@Column(name="description")
	private String description;
	@Column(name = "long_title")
	private String longTitle;
	@Column(name = "long_description")
	private String longDescription;

	public String getLongDescription() { return longDescription; }
	public void setLongDescription(String longDescription) { this.longDescription = longDescription; }
	@Column(name = "long_content")
	private String longContent;

	public String getLongTitle() { return longTitle; }
	public void setLongTitle(String longTitle) { this.longTitle = longTitle; }

	public String getLongContent() { return longContent; }
	public void setLongContent(String longContent) { this.longContent = longContent; }
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
