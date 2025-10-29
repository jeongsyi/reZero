package com.sch.rezero;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ReZeroApplication {

  public static void main(String[] args) {
    System.setProperty("aws.region", "ap-northeast-2");

    SpringApplication.run(ReZeroApplication.class, args);
    System.out.println("http://localhost:8080");
  }

}
