<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Form nhập liệu -->
<div class="checkout-form-section">
    <!-- Form này sẽ submit về đường dẫn /checkout.htm bằng phương thức POST -->
    <form action="${pageContext.request.contextPath}/checkout.htm" method="POST">
        
        <h2 class="section-title">Contact</h2>
        <div class="form-group">
            <input type="email" name="email" placeholder="Email" required>
        </div>
        
        <h2 class="section-title">Delivery</h2>
        <div class="form-group">
            <select name="region">
                <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                <option value="Hà Nội">Hà Nội</option>
                <option value="Đà Nẵng">Đà Nẵng</option>
            </select>
        </div>
        
        <div class="form-row">
            <div class="form-col"><input type="text" name="firstName" placeholder="First name" required></div>
            <div class="form-col"><input type="text" name="lastName" placeholder="Last name" required></div>
        </div>
        
        <div class="form-group">
            <input type="text" name="address" placeholder="Address" required>
        </div>
        
        <div class="form-row">
            <div class="form-col"><input type="text" name="city" placeholder="City" required></div>
            <div class="form-col"><input type="text" name="state" placeholder="State" required></div>
            <div class="form-col"><input type="text" name="zipCode" placeholder="Zip code" required></div>
        </div>
        
        <div class="form-group">
            <input type="text" name="phone" placeholder="Phone: +84" required>
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
                <input type="text" name="cardNumber" placeholder="Card number" required>
                <div class="form-row" style="margin-bottom:0;">
                    <div class="form-col"><input type="text" name="expDate" placeholder="Expiration date" required></div>
                    <div class="form-col"><input type="text" name="cvv" placeholder="Security code" required></div>
                </div>
                <input type="text" name="nameOnCard" placeholder="Name on card" required>
            </div>
        </div>
        
        <button type="submit" class="btn-pay">PAY NOW</button>
    </form>
</div>
