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

DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS answers CASCADE;
DROP TABLE IF EXISTS user_answers CASCADE;
DROP TABLE iF EXISTS levels CASCADE;

CREATE TABLE IF NOT EXISTS users
(
    id          BIGSERIAL PRIMARY KEY,
    login_id    VARCHAR(50)  NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    name        VARCHAR(100) NOT NULL,
    role        VARCHAR(20)  NOT NULL CHECK (role IN ('ADMIN', 'USER')) DEFAULT 'USER',
    birth       DATE,
    region      VARCHAR(100),
    profile_url VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS categories
(
    id       BIGSERIAL PRIMARY KEY,
    category VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS recycling_posts
(
    id               BIGSERIAL PRIMARY KEY,
    user_id          BIGINT       NOT NULL,
    title            VARCHAR(255) NOT NULL,
    description      TEXT         NOT NULL,
    created_at       timestamptz  NOT NULL DEFAULT NOW(),
    updated_at       timestamptz,
    thumb_nail_image VARCHAR(255) NOT NULL,
    category_id      BIGINT       NOT NULL,

    CONSTRAINT fk_users_to_recycling_posts FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_categories_to_recycling_posts FOREIGN KEY (category_id)
        REFERENCES categories (id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS recycling_images
(
    id           BIGSERIAL PRIMARY KEY,
    recycling_id BIGINT       NOT NULL,
    image_url    VARCHAR(255) NOT NULL,
    created_at   timestamptz  NOT NULL DEFAULT NOW(),
    updated_at   timestamptz,

    CONSTRAINT fk_recycling_posts_to_recycling_images FOREIGN KEY (recycling_id)
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

    CONSTRAINT fk_recycling_posts_to_qna_comments FOREIGN KEY (recycling_id)
        REFERENCES recycling_posts (id) ON DELETE CASCADE,
    CONSTRAINT fk_users_to_qna_comments FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_qna_comments_to_qna_comments FOREIGN KEY (parent_id)
        REFERENCES qna_comments (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS scraps
(
    id           BIGSERIAL PRIMARY KEY,
    recycling_id BIGINT      NOT NULL,
    user_id      BIGINT      NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_recycling_posts_to_scraps FOREIGN KEY (recycling_id)
        REFERENCES recycling_posts (id) ON DELETE CASCADE,
    CONSTRAINT fk_users_to_scraps FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS follows
(
    id           BIGSERIAL PRIMARY KEY,
    following_id BIGINT      NOT NULL,
    follower_id  BIGINT      NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_users_to_follows_1 FOREIGN KEY (following_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_users_to_follows_2 FOREIGN KEY (follower_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT uq_follows UNIQUE (following_id, follower_id)
);


CREATE TABLE IF NOT EXISTS community_posts
(
    id               BIGSERIAL PRIMARY KEY,
    user_id          BIGINT       NOT NULL,
    title            VARCHAR(255) NOT NULL,
    description      TEXT         NOT NULL,
    created_at       timestamptz  NOT NULL DEFAULT NOW(),
    updated_at       timestamptz,

    CONSTRAINT fk_users_to_community_posts FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS community_images
(
    id           BIGSERIAL PRIMARY KEY,
    community_id BIGINT       NOT NULL,
    image_url    VARCHAR(255) NOT NULL,
    created_at   timestamptz  NOT NULL DEFAULT NOW(),
    updated_at   timestamptz,

    CONSTRAINT fk_community_posts_to_community_images FOREIGN KEY (community_id)
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

    CONSTRAINT fk_community_posts_to_community_comments FOREIGN KEY (community_id)
        REFERENCES community_posts (id) ON DELETE CASCADE,
    CONSTRAINT fk_users_to_community_comments FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_community_comments_to_community_comments FOREIGN KEY (parent_id)
        REFERENCES community_comments (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS community_likes
(
    id           BIGSERIAL PRIMARY KEY,
    community_id BIGINT      NOT NULL,
    user_id      BIGINT      NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_community_posts_to_community_likes FOREIGN KEY (community_id)
        REFERENCES community_posts (id) ON DELETE CASCADE,
    CONSTRAINT fk_users_to_community_likes FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,

    CONSTRAINT uq_community_likes UNIQUE (community_id, user_id)
);

CREATE TABLE IF NOT EXISTS questions
(
    id       BIGSERIAL PRIMARY KEY NOT NULL,
    question VARCHAR(255)          NOT NULL
);

CREATE TABLE IF NOT EXISTS answers
(
    id          BIGSERIAL PRIMARY KEY NOT NULL,
    question_id BIGINT                NOT NULL,
    answer      VARCHAR(255)          NOT NULL,
    score       INT                   NOT NULL,

    CONSTRAINT fk_questions_to_answers FOREIGN KEY (question_id)
        REFERENCES questions (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_answers
(
    id        BIGSERIAL PRIMARY KEY NOT NULL,
    user_id   BIGINT                NOT NULL,
    answer_id BIGINT                NOT NULL,

    CONSTRAINT fk_users_to_user_answers FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_answers_to_user_answers FOREIGN KEY (answer_id)
        REFERENCES answers (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS levels
(
    id        BIGSERIAL PRIMARY KEY NOT NULL,
    name      VARCHAR(50)           NOT NULL,
    min_score INT,
    max_score INT
);