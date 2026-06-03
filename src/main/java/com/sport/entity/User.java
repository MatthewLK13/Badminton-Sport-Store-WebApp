package com.sport.entity;

import javax.persistence.*;

@Entity
@Table(name = "Users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(unique = true)
    private String email;

    @Column(unique = true)
    private String phone;

    // SỬA TẠI ĐÂY: Tên cột dưới database của bạn là "password" chứ không phải "password_hash"
    @Column(name = "password", nullable = false)
    private String passwordHash;

    // ĐÃ CHUẨN: Tên cột dưới database trùng khớp là "fullname"
    @Column(name = "fullname", nullable = false)
    private String fullName;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "role_id")
    private Role role;

    // SỬA TẠI ĐÂY: Tên cột dưới database của bạn là "is_active" (viết thường có gạch dưới)
    @Column(name = "is_active", insertable = false)
    private Boolean isActive;

    @Column(name = "address")
    private String address;

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}