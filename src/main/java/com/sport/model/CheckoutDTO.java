package com.sport.model;

import org.hibernate.validator.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class CheckoutDTO {

    @NotBlank(message = "Email không được để trống")
    @Pattern(regexp = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$", message = "Email không hợp lệ")
    private String email;

    @NotBlank(message = "Vui lòng chọn khu vực")
    private String region;

    @NotBlank(message = "Họ không được để trống")
    @Size(max = 50, message = "Họ tối đa 50 ký tự")
    private String firstName;

    @NotBlank(message = "Tên không được để trống")
    @Size(max = 50, message = "Tên tối đa 50 ký tự")
    private String lastName;

    @NotBlank(message = "Địa chỉ không được để trống")
    @Size(max = 200, message = "Địa chỉ tối đa 200 ký tự")
    private String address;

    @NotBlank(message = "Thành phố không được để trống")
    private String city;

    @NotBlank(message = "Tỉnh/Thành không được để trống")
    private String state;

    @NotBlank(message = "Mã bưu điện không được để trống")
    @Pattern(regexp = "^[0-9]{5,6}$", message = "Mã bưu điện phải là 5-6 chữ số")
    private String zipCode;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^[0-9]{10,11}$", message = "Số điện thoại phải 10-11 chữ số")
    private String phone;

    @NotBlank(message = "Số thẻ không được để trống")
    @Pattern(regexp = "^[0-9]{13,19}$", message = "Số thẻ không hợp lệ")
    private String cardNumber;

    @NotBlank(message = "Ngày hết hạn không được để trống")
    @Pattern(regexp = "^(0[1-9]|1[0-2])/([0-9]{2})$", message = "Định dạng phải là MM/YY")
    private String expDate;

    @NotBlank(message = "CVV không được để trống")
    @Pattern(regexp = "^[0-9]{3,4}$", message = "CVV phải 3-4 chữ số")
    private String cvv;

    @NotBlank(message = "Tên trên thẻ không được để trống")
    @Size(max = 100, message = "Tên trên thẻ tối đa 100 ký tự")
    private String nameOnCard;

    public CheckoutDTO() {
        super();
    }

    public CheckoutDTO(String email, String region, String firstName, String lastName, String address, String city,
            String state, String zipCode, String phone, String cardNumber, String expDate, String cvv,
            String nameOnCard) {
        super();
        this.email = email;
        this.region = region;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.phone = phone;
        this.cardNumber = cardNumber;
        this.expDate = expDate;
        this.cvv = cvv;
        this.nameOnCard = nameOnCard;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getExpDate() {
        return expDate;
    }

    public void setExpDate(String expDate) {
        this.expDate = expDate;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public String getNameOnCard() {
        return nameOnCard;
    }

    public void setNameOnCard(String nameOnCard) {
        this.nameOnCard = nameOnCard;
    }
}
