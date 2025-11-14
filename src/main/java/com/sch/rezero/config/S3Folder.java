package com.sch.rezero.config;

public enum S3Folder {
  COMMUNITY("community"),
  RECYCLING("recycling"),
  PROFILE("profile"),
  MISSION("mission"),
  COMMUNITY_THUMBNAIL("communityThumbnail"),
  RECYCLING_THUMBNAIL("recyclingThumbnail");

  private final String name;

  S3Folder(String name) {
    this.name = name;
  }
  public String getName() {
    return name;
  }
}
