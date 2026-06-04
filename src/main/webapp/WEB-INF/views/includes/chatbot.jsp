<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Chatbot Widget -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/chatbot.css">

<div class="chatbot-container">
    <button class="chatbot-float-btn" onclick="toggleChatbot()">
        <svg viewBox="0 0 24 24">
            <path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 14H5.17L4 17.17V4h16v12z"/>
        </svg>
    </button>

    <div class="chatbot-box" id="chatbotBox">
        <div class="chatbot-header">
            <h4>Tư vấn vợt cầu lông</h4>
            <div class="chatbot-header-actions">
                <button class="chatbot-reset" onclick="resetChat()" title="Reset cuộc trò chuyện">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="white">
                        <path d="M12 5V1L7 6l5 5V7c3.31 0 6 2.69 6 6s-2.69 6-6 6-6-2.69-6-6H4c0 4.42 3.58 8 8 8s8-3.58 8-8-3.58-8-8-8z"/>
                    </svg>
                </button>
                <button class="chatbot-close" onclick="toggleChatbot()">&times;</button>
            </div>
        </div>

        <div class="chatbot-messages" id="chatbotMessages">
            <!-- Messages will be added here -->
        </div>

        <div class="chatbot-input-area">
            <input type="text" class="chatbot-input" id="chatbotInput"
                   placeholder="Nhập tin nhắn..."
                   onkeypress="if(event.key==='Enter')sendMessage()">
            <button class="chatbot-send" onclick="sendMessage()">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="white">
                    <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z"/>
                </svg>
            </button>
        </div>
    </div>
</div>

<script>
let chatbotOpen = false;

function toggleChatbot() {
    chatbotOpen = !chatbotOpen;
    const box = document.getElementById('chatbotBox');
    box.classList.toggle('active', chatbotOpen);

    if (chatbotOpen && document.getElementById('chatbotMessages').children.length === 0) {
        // First open - show initial message
        fetchChatbotResponse('');
    }
}

function addMessage(text, isBot, products) {
    const container = document.getElementById('chatbotMessages');

    const msgDiv = document.createElement('div');
    msgDiv.className = 'message ' + (isBot ? 'bot' : 'user');
    msgDiv.textContent = text;
    container.appendChild(msgDiv);

    // Add products if provided
    if (products && products.length > 0) {
        const productsDiv = document.createElement('div');
        productsDiv.className = 'chatbot-products';

        products.forEach(function(p) {
            const link = document.createElement('a');
            link.href = '${pageContext.request.contextPath}/products/details.htm?id=' + p.id;
            link.className = 'chatbot-product';
            link.target = '_blank';
            link.innerHTML = '<img src="${pageContext.request.contextPath}/images/products/' + p.image + '">' +
                           '<div class="chatbot-product-info">' +
                           '<div class="chatbot-product-name">' + p.name + '</div>' +
                           '<div class="chatbot-product-price">$' + p.price + '</div></div>';
            productsDiv.appendChild(link);
        });

        container.appendChild(productsDiv);
    }

    container.scrollTop = container.scrollHeight;
}

function sendMessage() {
    const input = document.getElementById('chatbotInput');
    const message = input.value.trim();

    if (!message) return;

    addMessage(message, false, null);
    input.value = '';

    fetchChatbotResponse(message);
}

function fetchChatbotResponse(message) {
    const contextPath = '${pageContext.request.contextPath}';
    const url = contextPath + '/api/chatbot.htm';

    const formData = new URLSearchParams();
    formData.append('message', message);

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        addMessage(data.reply, true, data.products);
    })
    .catch(error => {
        console.error('Chatbot error:', error);
        addMessage('Xin lỗi, đã có lỗi xảy ra. Vui lòng thử lại.', true, null);
    });
}

function resetChat() {
    const contextPath = '${pageContext.request.contextPath}';
    const url = contextPath + '/api/chatbot/reset.htm';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        }
    })
    .then(response => response.json())
    .then(data => {
        // Clear messages
        document.getElementById('chatbotMessages').innerHTML = '';
        // Show reset confirmation
        addMessage(data.reply, true, null);
    })
    .catch(error => {
        console.error('Reset error:', error);
    });
}
</script>
