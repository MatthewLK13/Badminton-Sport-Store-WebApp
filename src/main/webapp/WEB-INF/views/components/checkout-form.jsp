<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- Form nhập liệu -->
<div class="checkout-form-section">
    <!-- Error message display -->
    <c:if test="${not empty error}">
        <div style="background: #fee2e2; border: 1px solid #ef4444; color: #dc2626; padding: 12px; border-radius: 4px; margin-bottom: 20px;">
            <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
    </c:if>

    <!-- Form này sẽ submit về đường dẫn /checkout.htm bằng phương thức POST -->
    <form:form action="${pageContext.request.contextPath}/checkout.htm" method="POST" modelAttribute="checkoutDTO">

        <h2 class="section-title"><spring:message code="checkout.section.contact" text="Contact" /></h2>
        <div class="form-group">
            <form:input type="email" path="email" placeholder="Email" />
            <form:errors path="email" cssClass="field-error" />
        </div>

        <h2 class="section-title"><spring:message code="checkout.section.delivery" text="Delivery" /></h2>
        <div class="form-group">
            <form:select path="region">
                <form:option value="Hồ Chí Minh">Hồ Chí Minh</form:option>
                <form:option value="Hà Nội">Hà Nội</form:option>
                <form:option value="Đà Nẵng">Đà Nẵng</form:option>
            </form:select>
            <form:errors path="region" cssClass="field-error" />
        </div>

        <div class="form-row">
            <div class="form-col">
                <form:input type="text" path="firstName" placeholder="First name" />
                <form:errors path="firstName" cssClass="field-error" />
            </div>
            <div class="form-col">
                <form:input type="text" path="lastName" placeholder="Last name" />
                <form:errors path="lastName" cssClass="field-error" />
            </div>
        </div>

        <div class="form-group">
            <form:input type="text" path="address" placeholder="Address" />
            <form:errors path="address" cssClass="field-error" />
        </div>

        <div class="form-row">
            <div class="form-col">
                <form:input type="text" path="city" placeholder="City" />
                <form:errors path="city" cssClass="field-error" />
            </div>
            <div class="form-col">
                <form:input type="text" path="state" placeholder="State" />
                <form:errors path="state" cssClass="field-error" />
            </div>
            <div class="form-col">
                <form:input type="text" path="zipCode" placeholder="Zip code" />
                <form:errors path="zipCode" cssClass="field-error" />
            </div>
        </div>

        <div class="form-group">
            <form:input type="text" path="phone" placeholder="Phone: +84" />
            <form:errors path="phone" cssClass="field-error" />
        </div>

        <h2 class="section-title">Payment</h2>
        <p class="secure-text">All transactions are secure and encrypted.</p>

        <div class="payment-box">
            <div class="payment-header">
                <span>Credit card</span>
                <div class="card-icons">
                    <img src="${pageContext.request.contextPath}/images/visa.png" alt="Visa">
                    <img src="${pageContext.request.contextPath}/images/mastercard.png" alt="Mastercard">
                    <img src="${pageContext.request.contextPath}/images/amex.png" alt="Amex">
                </div>
            </div>
            <div class="payment-body">
                <form:input type="text" path="cardNumber" placeholder="Card number" />
                <form:errors path="cardNumber" cssClass="field-error" />
                <div class="form-row" style="margin-bottom:0;">
                    <div class="form-col">
                        <form:input type="text" path="expDate" placeholder="Expiration date (MM/YY)" />
                        <form:errors path="expDate" cssClass="field-error" />
                    </div>
                    <div class="form-col">
                        <form:input type="text" path="cvv" placeholder="Security code" />
                        <form:errors path="cvv" cssClass="field-error" />
                    </div>
                </div>
                <form:input type="text" path="nameOnCard" placeholder="Name on card" />
                <form:errors path="nameOnCard" cssClass="field-error" />
            </div>
        </div>

        <button type="submit" class="btn-pay">PAY NOW</button>
    </form:form>
</div>

<style>
.field-error {
    color: #dc2626;
    font-size: 12px;
    margin-top: 4px;
    display: block;
}
</style>
