package com.sport.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class BackgroundRemoverService {

    private static final String API_KEY = System.getenv("REMOVE_BG_API_KEY");
    private static final String API_URL = "https://api.remove.bg/v1.0/removebg";

    public static boolean removeBackground(File sourceFile, String targetPath) {
        if (API_KEY == null || API_KEY.isBlank()) {
            System.err.println("REMOVE_BG_API_KEY environment variable is not set. Skipping background removal.");
            return false;
        }

        OkHttpClient client = new OkHttpClient();

        RequestBody requestBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("image_file", sourceFile.getName(),
                        RequestBody.create(MediaType.parse("image/*"), sourceFile))
                .addFormDataPart("size", "auto")
                .build();

        Request request = new Request.Builder()
                .url(API_URL)
                .addHeader("X-Api-Key", API_KEY)
                .post(requestBody)
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful() && response.body() != null) {
                byte[] imageBytes = response.body().bytes();

                try (FileOutputStream fos = new FileOutputStream(targetPath)) {
                    fos.write(imageBytes);
                }
                System.out.println("Da xoa nen thanh cong! Anh luu tai: " + targetPath);
                return true;
            } else {
                System.err.println("Loi xu ly tu Remove.bg: " + response.code() + " - " + response.message());
                if (response.body() != null) {
                    System.err.println("Chi tiet nguyen nhan: " + response.body().string());
                }
            }
        } catch (IOException e) {
            System.err.println("Loi mang, khong the ket noi toi may chu API: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}
