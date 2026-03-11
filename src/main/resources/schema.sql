DROP TABLE IF EXISTS group_members CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS `groups` CASCADE;
DROP TABLE IF EXISTS complaints CASCADE;
DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS scraps CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS recycling_posts CASCADE;
DROP TABLE IF EXISTS popular_posts CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
DROP TABLE IF EXISTS recycling_images CASCADE;
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS interests CASCADE;

CREATE TABLE users
(
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    login_id        VARCHAR(50)  NOT NULL UNIQUE,
    password        VARCHAR(50)  NOT NULL,
    name            VARCHAR(100) NOT NULL,
    role            VARCHAR(20)  NOT NULL DEFAULT 'user',
    profile_url     VARCHAR(255),
    complaint_count INT          NOT NULL DEFAULT 0,
    locked_at       TIMESTAMP,
    locked          BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at      TIMESTAMP,
    created_at      TIMESTAMP    NOT NULL,
    updated_at      TIMESTAMP
);

CREATE TABLE `groups`
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT,
    leader_id   BIGINT      NOT NULL,
    name        VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    created_at  TIMESTAMP   NOT NULL,
    deleted_at  TIMESTAMP,
    CONSTRAINT FK_users_groups FOREIGN KEY (leader_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE group_members
(
    id        BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id   BIGINT    NOT NULL,
    group_id  BIGINT    NOT NULL,
    approved  BOOLEAN   NOT NULL DEFAULT FALSE,
    joined_at TIMESTAMP NOT NULL,
    CONSTRAINT UQ_user_group UNIQUE (user_id, group_id),
    CONSTRAINT FK_users_group_members FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_groups_group_members FOREIGN KEY (group_id) REFERENCES `groups` (id) ON DELETE CASCADE
);

CREATE TABLE categories
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    category   VARCHAR(20) NOT NULL,
    created_at TIMESTAMP   NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP
);

CREATE TABLE stores
(
    id              BIGINT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(255)   NOT NULL,
    address         VARCHAR(500)   NOT NULL,
    lat             DECIMAL(10, 7) NOT NULL,
    lng             DECIMAL(10, 7) NOT NULL,
    source_store_id VARCHAR(100)   NOT NULL UNIQUE
);

CREATE TABLE reviews
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id    BIGINT    NOT NULL,
    store_id   BIGINT    NOT NULL,
    content    TEXT      NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    CONSTRAINT FK_users_reviews FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_stores_reviews FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE
);

CREATE TABLE complaints
(
    id          BIGINT PRIMARY KEY AUTO_INCREMENT,
    reporter_id BIGINT      NOT NULL,
    reported_id BIGINT      NOT NULL,
    reason      TEXT        NOT NULL,
    status      VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'resolved', 'rejected')),
    created_at  TIMESTAMP   NOT NULL,
    updated_at  TIMESTAMP,
    deleted_at  TIMESTAMP,
    CONSTRAINT FK_users_complaints_reporter FOREIGN KEY (reporter_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_users_complaints_reported FOREIGN KEY (reported_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE notifications
(
    notification_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id         BIGINT       NOT NULL,
    title           VARCHAR(100) NOT NULL,
    content         VARCHAR(500) NOT NULL,
    is_read         BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at      TIMESTAMP    NOT NULL,
    target_type     VARCHAR(100) NOT NULL,
    target_id       BIGINT       NOT NULL,
    CONSTRAINT FK_users_notifications FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE recycling_posts
(
    id               BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id          BIGINT       NOT NULL,
    category_id      BIGINT       NOT NULL,
    title            VARCHAR(255) NOT NULL,
    description      TEXT         NOT NULL,
    created_at       TIMESTAMP    NOT NULL,
    updated_at       TIMESTAMP,
    thumb_nail_image VARCHAR(255) NOT NULL,
    deleted_at       TIMESTAMP,
    CONSTRAINT FK_users_recycling_posts FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_category_recycling_posts FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);

CREATE TABLE scraps
(
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,
    post_id    BIGINT    NOT NULL,
    user_id    BIGINT    NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT UQ_user_scrap UNIQUE (user_id, post_id),
    CONSTRAINT FK_recycling_posts_scraps FOREIGN KEY (post_id) REFERENCES recycling_posts (id) ON DELETE CASCADE,
    CONSTRAINT FK_users_scraps FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE popular_posts
(
    id       BIGINT PRIMARY KEY AUTO_INCREMENT,
    post_id  BIGINT      NOT NULL,
    `period` VARCHAR(20) NOT NULL,
    `rank`   BIGINT      NOT NULL,
    score    INT         NOT NULL,
    CONSTRAINT FK_recycling_posts_popular_posts FOREIGN KEY (post_id) REFERENCES recycling_posts (id) ON DELETE CASCADE
);

CREATE TABLE recycling_images
(
    id           BIGINT PRIMARY KEY AUTO_INCREMENT,
    recycling_id BIGINT       NOT NULL,
    image_url    VARCHAR(255) NOT NULL,
    created_at   TIMESTAMP    NOT NULL,
    updated_at   TIMESTAMP,
    CONSTRAINT FK_recycling_posts_recycling_images FOREIGN KEY (recycling_id) REFERENCES recycling_posts (id) ON DELETE CASCADE
);

CREATE TABLE comments
(
    id           BIGINT PRIMARY KEY AUTO_INCREMENT,
    recycling_id BIGINT    NOT NULL,
    user_id      BIGINT    NOT NULL,
    parent_id    BIGINT,
    content      TEXT      NOT NULL,
    created_at   TIMESTAMP NOT NULL,
    updated_at   TIMESTAMP,
    CONSTRAINT FK_recycling_posts_comments FOREIGN KEY (recycling_id) REFERENCES recycling_posts (id) ON DELETE CASCADE,
    CONSTRAINT FK_users_comments FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_comments_comments FOREIGN KEY (parent_id) REFERENCES comments (id) ON DELETE CASCADE
);

CREATE TABLE interests
(
    user_id     BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, category_id),
    CONSTRAINT FK_users_interests FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_category_interests FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);