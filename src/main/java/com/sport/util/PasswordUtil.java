package com.sport.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    private static final String MD5_PREFIX = "MD5:";
    private static final int MD5_LENGTH = 32;
    private static final int SHA256_LENGTH = 64;

    public static String hashPassword(String password, String salt) {
        if (password == null || salt == null) {
            throw new IllegalArgumentException("Password and salt cannot be null");
        }
        return sha256(password + salt);
    }

    public static String hashPassword(String password) {
        if (password == null) {
            throw new IllegalArgumentException("Password cannot be null");
        }
        return sha256(password);
    }

    public static boolean verifyPassword(String rawPassword, String storedHash) {
        if (storedHash == null || storedHash.isEmpty()) {
            return false;
        }

        // Legacy MD5 password (32 hex chars, no prefix)
        if (storedHash.length() == MD5_LENGTH && !storedHash.contains(":")) {
            String md5Hash = md5(rawPassword);
            return md5Hash.equals(storedHash);
        }

        // SHA256 password
        if (storedHash.length() == SHA256_LENGTH) {
            String inputHash = sha256(rawPassword);
            return inputHash.equals(storedHash);
        }

        return false;
    }

    public static boolean verifyPassword(String rawPassword, String storedHash, String salt) {
        if (storedHash == null || storedHash.isEmpty()) {
            return false;
        }

        // Legacy MD5 password
        if (storedHash.length() == MD5_LENGTH && !storedHash.contains(":")) {
            String md5Hash = md5(rawPassword);
            return md5Hash.equals(storedHash);
        }

        // SHA256 with salt
        if (storedHash.length() == SHA256_LENGTH) {
            String inputHash = sha256(rawPassword + salt);
            return inputHash.equals(storedHash);
        }

        return false;
    }

    public static boolean isLegacyMd5Hash(String hash) {
        return hash != null && hash.length() == MD5_LENGTH && !hash.contains(":");
    }

    public static boolean isSha256Hash(String hash) {
        return hash != null && hash.length() == SHA256_LENGTH;
    }

    private static String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(input.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hashBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 algorithm not available", e);
        }
    }

    private static String sha256(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(input.getBytes(StandardCharsets.UTF_8));
            return bytesToHex(hashBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : bytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
}
