DROP TABLE IF EXISTS users CASCADE;

DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS recycling_posts CASCADE;
DROP TABLE IF EXISTS recycling_images CASCADE;
DROP TABLE IF EXISTS qna_comments CASCADE;
DROP TABLE IF EXISTS scraps CASCADE;

DROP TABLE IF EXISTS follows CASCADE;
DROP TABLE IF EXISTS community_posts CASCADE;
DROP TABLE IF EXISTS community_images CASCADE;
DROP TABLE IF EXISTS community_comments CASCADE;
DROP TABLE IF EXISTS community_likes CASCADE;

CREATE TABLE IF NOT EXISTS users
(
    id          BIGSERIAL PRIMARY KEY,
    login_id    VARCHAR(50)  NOT NULL UNIQUE,
    password    VARCHAR      NOT NULL,
    name        VARCHAR(100) NOT NULL,
    role        VARCHAR(20)  NOT NULL CHECK (role in ('ADMIN', 'USER')) DEFAULT 'USER',
    birth       DATE,
    region      VARCHAR(100),
    profile_url VARCHAR
);

CREATE TABLE IF NOT EXISTS category
(
    id       BIGSERIAL PRIMARY KEY,
    category VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS recycling_posts
(
    id               BIGSERIAL PRIMARY KEY,
    user_id          BIGINT      NOT NULL,
    title            VARCHAR     NOT NULL,
    description      TEXT        NOT NULL,
    created_at       timestamptz NOT NULL DEFAULT NOW(),
    updated_at       timestamptz,
    thumb_nail_image VARCHAR     NOT NULL,
    category         VARCHAR(20) NOT NULL,

    CONSTRAINT FK_users_TO_recycling_posts FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS recycling_images
(
    id           BIGSERIAL PRIMARY KEY,
    recycling_id BIGINT      NOT NULL,
    image_url    VARCHAR     NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),
    updated_at   timestamptz,

    CONSTRAINT FK_recycling_posts_TO_recycling_images FOREIGN KEY (recycling_id)
        REFERENCES recycling_posts (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS qna_comments
(
    id           BIGSERIAL PRIMARY KEY,
    recycling_id BIGINT      NOT NULL,
    user_id      BIGINT      NOT NULL,
    parent_id    BIGINT,
    content      TEXT        NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),
    updated_at   timestamptz,

    CONSTRAINT FK_recycling_posts_TO_qna_comments FOREIGN KEY (recycling_id)
        REFERENCES recycling_posts (id) ON DELETE CASCADE,
    CONSTRAINT FK_users_TO_qna_comments FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_qna_comments_TO_qna_comments FOREIGN KEY (parent_id)
        REFERENCES qna_comments (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS scraps
(
    id           BIGSERIAL PRIMARY KEY,
    recycling_id BIGINT      NOT NULL,
    user_id      BIGINT      NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),

    CONSTRAINT FK_recycling_posts_TO_scraps FOREIGN KEY (recycling_id)
        REFERENCES recycling_posts (id) ON DELETE CASCADE,
    CONSTRAINT FK_users_TO_scraps FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS follows
(
    id           BIGSERIAL PRIMARY KEY,
    following_id BIGINT      NOT NULL,
    follower_id  BIGINT      NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),

    CONSTRAINT FK_users_TO_follows_1 FOREIGN KEY (following_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_users_TO_follows_2 FOREIGN KEY (follower_id)
        REFERENCES users (id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS community_posts
(
    id               BIGSERIAL PRIMARY KEY,
    user_id          BIGINT      NOT NULL,
    title            VARCHAR     NOT NULL,
    description      TEXT        NOT NULL,
    created_at       timestamptz NOT NULL DEFAULT NOW(),
    updated_at       timestamptz,
    thumb_nail_image VARCHAR     NOT NULL,

    CONSTRAINT FK_users_TO_community_posts FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS community_images
(
    id           BIGSERIAL PRIMARY KEY,
    community_id BIGINT      NOT NULL,
    image_url    VARCHAR     NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),
    updated_at   timestamptz,

    CONSTRAINT FK_community_posts_TO_community_images FOREIGN KEY (community_id)
        REFERENCES community_posts (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS community_comments
(
    id           BIGSERIAL PRIMARY KEY,
    community_id BIGINT      NOT NULL,
    user_id      BIGINT      NOT NULL,
    parent_id    BIGINT,
    content      TEXT        NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),
    updated_at   timestamptz,

    CONSTRAINT FK_community_posts_TO_community_comments FOREIGN KEY (community_id)
        REFERENCES community_posts (id) ON DELETE CASCADE,
    CONSTRAINT FK_users_TO_community_comments FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT FK_community_comments_TO_community_comments FOREIGN KEY (parent_id)
        REFERENCES community_comments (id) ON DELETE CASCADE
);