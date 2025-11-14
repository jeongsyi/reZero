DROP TABLE IF EXISTS users CASCADE;

DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS recycling_posts CASCADE;
DROP TABLE IF EXISTS recycling_images CASCADE;
DROP TABLE IF EXISTS qna_comments CASCADE;
DROP TABLE IF EXISTS scraps CASCADE;

DROP TABLE IF EXISTS follows CASCADE;
DROP TABLE IF EXISTS missions CASCADE;
DROP TABLE IF EXISTS mission_posts CASCADE;
DROP TABLE IF EXISTS mission_post_images CASCADE;
DROP TABLE IF EXISTS mission_post_comments CASCADE;
DROP TABLE IF EXISTS mission_post_likes CASCADE;
DROP TABLE IF EXISTS mission_stamps CASCADE;

DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS answers CASCADE;
DROP TABLE IF EXISTS user_answers CASCADE;
DROP TABLE iF EXISTS levels CASCADE;
DROP TABLE iF EXISTS user_levels CASCADE;

CREATE TABLE IF NOT EXISTS users
(
    id              BIGSERIAL PRIMARY KEY,
    login_id        VARCHAR(50)  NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL,
    name            VARCHAR(100) NOT NULL,
    role            VARCHAR(20)  NOT NULL CHECK (role IN ('ADMIN', 'USER')) DEFAULT 'USER',
    birth           DATE,
    region          VARCHAR(100),
    profile_url     VARCHAR(255),
    follower_count  BIGINT       NOT NULL                                   DEFAULT 0,
    following_count BIGINT       NOT NULL                                   DEFAULT 0
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

CREATE TABLE missions
(
    id          BIGSERIAL PRIMARY KEY,
    title       VARCHAR(255) NOT NULL,
    description TEXT         NOT NULL,
    start_date  TIMESTAMPTZ  NOT NULL,
    end_date    TIMESTAMPTZ  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ
);


CREATE TABLE IF NOT EXISTS mission_posts
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT       NOT NULL,
    mission_id  BIGINT       NOT NULL,
    title       VARCHAR(255) NOT NULL,
    description TEXT,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ,
    status      VARCHAR(20)  NOT NULL CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),

    CONSTRAINT fk_mission_posts_user
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_mission_posts_mission
        FOREIGN KEY (mission_id) REFERENCES missions (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mission_post_images
(
    id         BIGSERIAL PRIMARY KEY,
    post_id    BIGINT       NOT NULL,
    image_url  VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,

    CONSTRAINT fk_post_images_post
        FOREIGN KEY (post_id) REFERENCES mission_posts (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mission_post_comments
(
    id         BIGSERIAL PRIMARY KEY,
    post_id    BIGINT       NOT NULL,
    user_id    BIGINT       NOT NULL,
    parent_id  BIGINT       NULL,
    content    VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,

    CONSTRAINT fk_post_comments_post
        FOREIGN KEY (post_id) REFERENCES mission_posts (id) ON DELETE CASCADE,
    CONSTRAINT fk_post_comments_user
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_post_comments_parent
        FOREIGN KEY (parent_id) REFERENCES mission_post_comments (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mission_post_likes
(
    id         BIGSERIAL PRIMARY KEY,
    post_id    BIGINT      NOT NULL,
    user_id    BIGINT      NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_post_likes_post
        FOREIGN KEY (post_id) REFERENCES mission_posts (id) ON DELETE CASCADE,
    CONSTRAINT fk_post_likes_user
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT uq_post_like UNIQUE (post_id, user_id)
);

CREATE TABLE mission_stamps
(
    id         BIGSERIAL PRIMARY KEY,
    mission_id BIGINT  NOT NULL,
    user_id    BIGINT  NOT NULL,
    stamp_date DATE    NOT NULL,
    stamped    BOOLEAN NOT NULL DEFAULT FALSE,
    stamped_at TIMESTAMPTZ,

    CONSTRAINT fk_mission_stamps_mission
        FOREIGN KEY (mission_id) REFERENCES missions (id) ON DELETE CASCADE,
    CONSTRAINT fk_mission_stamps_user
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT uq_mission_stamp UNIQUE (mission_id, user_id, stamp_date)
);

CREATE TABLE IF NOT EXISTS questions
(
    id          BIGSERIAL PRIMARY KEY NOT NULL,
    question    VARCHAR(255)          NOT NULL,
    order_index INT                   NOT NULL,
    created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS answers
(
    id          BIGSERIAL PRIMARY KEY NOT NULL,
    question_id BIGINT                NOT NULL,
    answer      VARCHAR(255)          NOT NULL,
    score       INT                   NOT NULL,
    order_index INT                   NOT NULL,

    CONSTRAINT fk_questions_to_answers FOREIGN KEY (question_id)
        REFERENCES questions (id) ON DELETE CASCADE,
    CONSTRAINT uq_question_answer UNIQUE (question_id, answer)
);

CREATE TABLE IF NOT EXISTS user_answers
(
    id        BIGSERIAL PRIMARY KEY NOT NULL,
    user_id   BIGINT                NOT NULL,
    answer_id BIGINT                NOT NULL,

    CONSTRAINT fk_users_to_user_answers FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_answers_to_user_answers FOREIGN KEY (answer_id)
        REFERENCES answers (id) ON DELETE CASCADE,
    CONSTRAINT uq_user_answer UNIQUE (user_id, answer_id)
);

CREATE TABLE IF NOT EXISTS levels
(
    id          BIGSERIAL PRIMARY KEY NOT NULL,
    name        VARCHAR(50)           NOT NULL,
    min_score   INT,
    max_score   INT,
    description TEXT
);

CREATE TABLE IF NOT EXISTS user_levels
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT NOT NULL,
    level_id    BIGINT NOT NULL,
    total_score INT    NOT NULL,

    CONSTRAINT fk_user_levels_user FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,

    CONSTRAINT fk_user_levels_level FOREIGN KEY (level_id)
        REFERENCES levels (id) ON DELETE CASCADE
);

CREATE TABLE notifications
(
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT      NOT NULL,      -- 알림 받는 사람
    sender_id  BIGINT,                    -- 알림 보낸 사람
    post_id    BIGINT,                    -- 관련 게시글
    type       VARCHAR(20) NOT NULL,      -- LIKE, COMMENT, APPROVED, REJECTED
    message    TEXT        NOT NULL,      -- 알림 내용
    is_read    BOOLEAN     DEFAULT FALSE, -- 읽음 여부
    created_at TIMESTAMPTZ DEFAULT now(),

    CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

