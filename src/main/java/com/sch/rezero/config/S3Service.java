package com.sch.rezero.config;

import java.net.URI;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.IOException;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class S3Service {

  private final S3Client s3Client;

  @Value("${aws.s3.bucket}")
  private String bucket;

  public String uploadFile(MultipartFile file, String folderName) throws IOException {
    String fileName = folderName + "/" + UUID.randomUUID() + "_" + file.getOriginalFilename();

    PutObjectRequest putObjectRequest = PutObjectRequest.builder()
        .bucket(bucket)
        .key(fileName)
        .contentType(file.getContentType())
        .build();

    s3Client.putObject(
        putObjectRequest,
        RequestBody.fromInputStream(file.getInputStream(), file.getSize())
    );

    String fileUrl = String.format(
        "https://%s.s3.%s.amazonaws.com/%s",
        bucket, "ap-northeast-2", fileName
    );

    return fileUrl;
  }

  public void deleteFile(String fileUrl) {
    if (fileUrl == null || fileUrl.isEmpty()) return;

    try {

      URI uri = new URI(fileUrl);
      String key = uri.getPath().substring(1);

      System.out.println("getHost: " + uri.getHost());
      System.out.println("getPath: " + uri.getPath());
      System.out.println("key: " + uri.getPath().substring(1));

      DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
          .bucket(bucket)
          .key(key)
          .build();

      s3Client.deleteObject(deleteObjectRequest);

    } catch (Exception e) {
      return;
    }
  }
}
