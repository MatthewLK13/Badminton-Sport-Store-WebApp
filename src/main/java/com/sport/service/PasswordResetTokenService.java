package com.sport.service;

import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class PasswordResetTokenService {

    private static final long TOKEN_EXPIRY_MS = 24 * 60 * 60 * 1000; // 24 hours

    // In-memory token storage: token -> {userId, createdAt, expiresAt}
    private static final Map<String, TokenData> tokenStore = new ConcurrentHashMap<>();

    public String generateToken(Integer userId) {
        String token = UUID.randomUUID().toString();
        long now = System.currentTimeMillis();
        long expiresAt = now + TOKEN_EXPIRY_MS;

        tokenStore.put(token, new TokenData(userId, now, expiresAt));

        return token;
    }

    public Integer validateToken(String token) {
        if (token == null || token.isEmpty()) {
            return null;
        }

        TokenData data = tokenStore.get(token);
        if (data == null) {
            return null;
        }

        if (System.currentTimeMillis() > data.expiresAt) {
            tokenStore.remove(token);
            return null;
        }

        return data.userId;
    }

    public void removeToken(String token) {
        tokenStore.remove(token);
    }

    private static class TokenData {
        final Integer userId;
        final long createdAt;
        final long expiresAt;

        TokenData(Integer userId, long createdAt, long expiresAt) {
            this.userId = userId;
            this.createdAt = createdAt;
            this.expiresAt = expiresAt;
        }
    }
}
