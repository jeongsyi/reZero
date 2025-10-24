package com.sch.rezero.config;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class S3Service {

  private final S3Client s3Client;

  @Value("${aws.s3.bucket}")
  private String bucket;

  public String uploadFile(MultipartFile file) throws IOException {
    String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();

    PutObjectRequest putObjectRequest = PutObjectRequest.builder()
        .bucket(bucket)
        .key(fileName)
        .contentType(file.getContentType())
        .build();

    s3Client.putObject(
        putObjectRequest,
        RequestBody.fromInputStream(file.getInputStream(), file.getSize())
    );

    // ✅ 리턴 URL 명시적으로 생성
    String fileUrl = String.format(
        "https://%s.s3.%s.amazonaws.com/%s",
        bucket, "ap-northeast-2", fileName
    );

    System.out.println("✅ Uploaded file URL: " + fileUrl); // 디버그용

    return fileUrl; // ⚠️ 반드시 이걸 리턴해야 함
  }
}
