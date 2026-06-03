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
                        RequestBody.create(MediaType.parse("image/*"), sourceFile)) // Đã đảo MediaType lên trước sourceFile
                .addFormDataPart("size", "auto")
                .build();
        // Thiết lập cấu trúc Request gửi đi kèm mã bảo mật API Key ở Header
        Request request = new Request.Builder()
                .url(API_URL)
                .addHeader("X-Api-Key", API_KEY)
                .post(requestBody)
                .build();

        // Bắt đầu thực thi gửi và nhận phản hồi
        try (Response response = client.newCall(request).execute()) {
            if (response.isSuccessful() && response.body() != null) {
                // Đọc toàn bộ luồng byte của bức ảnh trong suốt trả về từ AI
                byte[] imageBytes = response.body().bytes();
                
                // Ghi dữ liệu byte này thành một file ảnh vật lý thật trên ổ đĩa
                try (FileOutputStream fos = new FileOutputStream(targetPath)) {
                    fos.write(imageBytes);
                }
                System.out.println(" Đã xóa nền thành công! Ảnh lưu tại: " + targetPath);
                return true;
            } else {
                System.err.println(" Lỗi xử lý từ Remove.bg: " + response.code() + " - " + response.message());
                if (response.body() != null) {
                    System.err.println("Chi tiết nguyên nhân: " + response.body().string());
                }
            }
        } catch (IOException e) {
            System.err.println(" Lỗi mạng, không thể kết nối tới máy chủ API: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}