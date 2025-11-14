-- 🔹 질문 10개
INSERT INTO questions (question, order_index) VALUES
                                                  ('텀블러를 얼마나 자주 사용하시나요?', 1),
                                                  ('분리수거를 얼마나 철저히 하시나요?', 2),
                                                  ('음식물 쓰레기를 어떻게 처리하시나요?', 3),
                                                  ('장볼 때 비닐봉투 대신 장바구니를 사용하시나요?', 4),
                                                  ('중고거래(리셀, 나눔 등)를 얼마나 활용하시나요?', 5),
                                                  ('전등이나 전자기기를 사용하지 않을 때 꺼두시나요?', 6),
                                                  ('패션 아이템을 구매할 때 환경 영향을 고려하시나요?', 7),
                                                  ('대중교통, 자전거, 도보 이용 빈도는 어떤가요?', 8),
                                                  ('친환경 브랜드/제품을 구매한 경험이 있나요?', 9),
                                                  ('지속 가능한 생활을 위해 실천하는 행동이 있나요?', 10);

-- 🔹 선택지 (각 질문당 3개씩)
INSERT INTO answers (question_id, answer, score, order_index) VALUES
-- Q1
(1, '항상 사용한다', 3, 1),
(1, '가끔 사용한다', 2, 2),
(1, '거의 사용하지 않는다', 1, 3),

-- Q2
(2, '항상 분리수거를 철저히 한다', 3, 1),
(2, '가끔 헷갈릴 때가 있다', 2, 2),
(2, '거의 안 한다', 1, 3),

-- Q3
(3, '음식물 쓰레기를 잘 분리해서 버린다', 3, 1),
(3, '대부분 일반 쓰레기로 버린다', 2, 2),
(3, '전혀 신경 쓰지 않는다', 1, 3),

-- Q4
(4, '항상 장바구니를 사용한다', 3, 1),
(4, '가끔 사용한다', 2, 2),
(4, '비닐봉투를 주로 사용한다', 1, 3),

-- Q5
(5, '중고거래/나눔을 자주 한다', 3, 1),
(5, '가끔 한다', 2, 2),
(5, '새 제품만 산다', 1, 3),

-- Q6
(6, '사용하지 않을 때 항상 끈다', 3, 1),
(6, '가끔 깜빡한다', 2, 2),
(6, '거의 안 끈다', 1, 3),

-- Q7
(7, '항상 고려한다', 3, 1),
(7, '가끔 고려한다', 2, 2),
(7, '전혀 고려하지 않는다', 1, 3),

-- Q8
(8, '대중교통이나 도보를 주로 이용한다', 3, 1),
(8, '가끔 이용한다', 2, 2),
(8, '자동차를 주로 이용한다', 1, 3),

-- Q9
(9, '친환경 제품을 자주 구매한다', 3, 1),
(9, '가끔 구매한다', 2, 2),
(9, '관심이 없다', 1, 3),

-- Q10
(10, '꾸준히 실천 중이다', 3, 1),
(10, '가끔 실천한다', 2, 2),
(10, '아직 실천하지 않는다', 1, 3);

INSERT INTO levels (name, min_score, max_score, description) VALUES
                                                                 ('🌱 Beginner', 0, 14, '아직 환경 실천이 낯설지만, 작은 습관부터 시작해보세요!'),
                                                                 ('🌿 Intermediate', 15, 23, '꽤 친환경적인 생활을 하고 계시네요! 꾸준히 이어가봐요.'),
                                                                 ('🌳 Expert', 24, 30, '환경 보호를 몸소 실천하는 리더십을 보여주고 계십니다!');




INSERT INTO categories (id, category)
VALUES
    (1, '종이'),
    (2, '플라스틱'),
    (3, '비닐'),
    (4, '금속'),
    (5, '유리'),
    (6, '음식'),
    (7, '천'),
    (8, '기타');



INSERT INTO users (login_id, password, name, role, birth, region, profile_url, follower_count, following_count)
VALUES
    ('user01', 'Admin@123!', '관리자', 'ADMIN', '1990-03-15', '서울', NULL, 0, 0),
    ('user02', 'User@1234', '김서연', 'USER', '1994-06-22', '경기', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/fb06f111-9c8d-464a-8e2e-e8a32772da6c_IMG_9175.PNG', 0, 0),
    ('user03', 'User@1234', '이도현', 'USER', '1998-01-10', '부산', NULL, 0, 0),
    ('user04', 'User@1234', '박지민', 'USER', '1992-07-05', '대전', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/ee2a30ca-e3bd-4fe6-8b69-6a5e940e96bf_IMG_7892.JPG', 0, 0),
    ('user05', 'User@1234', '최윤아', 'USER', '1989-09-12', '광주', NULL, 0, 0),
    ('user06', 'User@1234', '정우성', 'USER', '1995-12-30', '강원', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/db55dc12-87ef-4529-9ef9-a0cd41ab7f18_E7D47238-BCD3-4589-85FB-A0BC21DB3611.JPG', 0, 0),
    ('user07', 'User@1234', '김다은', 'USER', '2000-08-19', '제주', NULL, 0, 0),
    ('user08', 'User@1234', '이승현', 'USER', '1997-03-08', '인천', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/d8950c41-e5eb-4581-b521-df549eab88ae_IMG_7416.JPG', 0, 0),
    ('user09', 'User@1234', '박지후', 'USER', '1991-11-01', '충남', NULL, 0, 0),
    ('user10', 'User@1234', '조민서', 'USER', '1999-02-14', '충북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/d0862f6c-6997-40c2-b3d8-a11e40f83195_IMG_8064.JPG', 0, 0),
    ('user11', 'User@1234', '한유진', 'USER', '1988-10-25', '전남', NULL, 0, 0),
    ('user12', 'User@1234', '서지훈', 'USER', '1996-04-30', '전북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/cffac4a4-c9c4-4a8a-8729-6fe0d4f36366_IMG_429347877D82-1.jpeg', 0, 0),
    ('user13', 'User@1234', '오하늘', 'USER', '1993-07-09', '경남', NULL, 0, 0),
    ('user14', 'User@1234', '장민재', 'USER', '1987-12-22', '경북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/aca9fe59-8043-40dc-8cf8-e1741af572f7_IMG_6911.jpg', 0, 0),
    ('user15', 'User@1234', '김예진', 'USER', '1995-01-11', '서울', NULL, 0, 0),
    ('user16', 'User@1234', '이현우', 'USER', '1999-09-04', '경기', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/8a5fdc00-ca34-4c95-9e03-c611950f7def_IMG_7827.JPG', 0, 0),
    ('user17', 'User@1234', '박지아', 'USER', '1986-06-27', '부산', NULL, 0, 0),
    ('user18', 'User@1234', '최민석', 'USER', '1992-05-14', '대전', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/8a155bd4-4533-40e6-965e-7c08e7c0f88f_IMG_9030.JPG', 0, 0),
    ('user19', 'User@1234', '정윤호', 'USER', '2003-10-08', '광주', NULL, 0, 0),
    ('user20', 'User@1234', '조수빈', 'USER', '1990-12-05', '강원', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/83a9e609-2b81-4293-b74b-634796da3470_IMG_7588.HEIC', 0, 0),
    ('user21', 'User@1234', '김도윤', 'USER', '1997-03-29', '제주', NULL, 0, 0),
    ('user22', 'User@1234', '이아린', 'USER', '1989-09-17', '인천', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/7225c720-bb9e-41af-9b2a-68cf8a064b81_IMG_8336.PNG', 0, 0),
    ('user23', 'User@1234', '박건우', 'USER', '1996-02-08', '충남', NULL, 0, 0),
    ('user24', 'User@1234', '한지민', 'USER', '2001-07-03', '충북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/63da38d4-3b6a-46e5-b96a-d23a662ea343_IMG_7439.JPG', 0, 0),
    ('user25', 'User@1234', '서준혁', 'USER', '1993-05-18', '전남', NULL, 0, 0),
    ('user26', 'User@1234', '오유나', 'USER', '1987-08-21', '전북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/5f25152e-05e3-41f4-96f4-2ba19a0f045b_fa76c545cfb94dc4b0c91ed0974506f5.jpg', 0, 0),
    ('user27', 'User@1234', '장하린', 'USER', '2000-11-27', '경남', NULL, 0, 0),
    ('user28', 'User@1234', '김태현', 'USER', '1995-09-06', '경북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/5e9aa39e-9cf9-4339-b48d-72357fef0186_IMG_7689.HEIC', 0, 0),
    ('user29', 'User@1234', '이서준', 'USER', '1991-02-19', '서울', NULL, 0, 0),
    ('user30', 'User@1234', '박채원', 'USER', '1988-03-13', '경기', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/574c184e-9ff1-4cd3-869b-d95601547358_IMG_8196.JPG', 0, 0),
    ('user31', 'User@1234', '정은우', 'USER', '1999-07-30', '부산', NULL, 0, 0),
    ('user32', 'User@1234', '최하윤', 'USER', '2004-01-15', '대전', NULL, 0, 0),
    ('user33', 'User@1234', '조민준', 'USER', '1992-04-24', '광주', NULL, 0, 0),
    ('user34', 'User@1234', '한서아', 'USER', '1998-06-10', '강원', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/3496b50c-615f-411f-b8f0-accc69b71d2d_IMG_7508.JPG', 0, 0),
    ('user35', 'User@1234', '서도현', 'USER', '1994-09-28', '제주', NULL, 0, 0),
    ('user36', 'User@1234', '오예린', 'USER', '1989-11-06', '인천', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/335b2845-4213-4417-bd34-ad54588a4cb5_IMG_7936.JPG', 0, 0),
    ('user37', 'User@1234', '김하율', 'USER', '1997-01-12', '충남', NULL, 0, 0),
    ('user38', 'User@1234', '이민재', 'USER', '2002-02-17', '충북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/3323d0bb-00ae-4baa-91ec-e789c63259cc_IMG_7006.HEIC', 0, 0),
    ('user39', 'User@1234', '박도하', 'USER', '1995-10-05', '전남', NULL, 0, 0),
    ('user40', 'User@1234', '정다인', 'USER', '1986-12-21', '전북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/2270686d-8815-47d4-901a-b53c7a99c691_IMG_7108.JPG', 0, 0),
    ('user41', 'User@1234', '최유진', 'USER', '1993-08-14', '경남', NULL, 0, 0),
    ('user42', 'User@1234', '조하은', 'USER', '1990-05-09', '경북', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/1fb013ee-cc84-42bb-86b5-036e12cfad76_102FB16A-C596-4F09-A537-4F39ED930016.JPG', 0, 0),
    ('user43', 'User@1234', '한시우', 'USER', '1998-09-30', '서울', NULL, 0, 0),
    ('user44', 'User@1234', '서준호', 'USER', '1987-07-04', '경기', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/1fb013ee-cc84-42bb-86b5-036e12cfad76_102FB16A-C596-4F09-A537-4F39ED930016.JPG', 0, 0),
    ('user45', 'User@1234', '오하린', 'USER', '2001-01-23', '부산', NULL, 0, 0),
    ('user46', 'User@1234', '김지안', 'USER', '1996-10-18', '대전', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/profile/10136c39-63aa-4df9-b0c5-e04b85a580ad_IMG_7348.JPG', 0, 0),
    ('user47', 'User@1234', '이윤호', 'USER', '1992-06-27', '광주', NULL, 0, 0),
    ('user48', 'User@1234', '박수현', 'USER', '1988-02-15', '강원', NULL, 0, 0),
    ('user49', 'User@1234', '정하늘', 'USER', '2000-03-11', '제주', NULL, 0, 0),
    ('user50', 'User@1234', '최다온', 'USER', '1991-08-09', '인천', NULL, 0, 0);


INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (19, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (39, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 2, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 3, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 4, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 5, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 6, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 7, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 8, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 9, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 10, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 11, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (19, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 12, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 13, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (39, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 14, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 15, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 16, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (19, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 17, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 18, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 19, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 20, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 21, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (19, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 22, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (32, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 23, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 24, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (39, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 25, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 26, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 27, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (32, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 28, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 29, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 30, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (32, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 31, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 32, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 33, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 34, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (39, 35, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (32, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (7, 36, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 37, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (39, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 38, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (32, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 39, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (38, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 40, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (46, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 41, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (1, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (39, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 42, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (19, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (28, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 43, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (43, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (32, 44, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (32, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (50, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (25, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (14, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (40, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (48, 45, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 46, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (6, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (18, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (36, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (39, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (26, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 47, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (49, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (42, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (3, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (9, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (27, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (17, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (11, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (8, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (45, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (20, 48, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (24, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (33, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (16, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (23, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (13, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (35, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (29, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (10, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (21, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (22, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (30, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (37, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (4, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (47, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 49, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (12, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (5, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (2, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (15, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (44, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (31, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (34, 50, '2025-11-03 16:41:30');
INSERT INTO follows (following_id, follower_id, created_at) VALUES (41, 50, '2025-11-03 16:41:30');

UPDATE users u
SET follower_count = (
    SELECT COUNT(*)
    FROM follows f
    WHERE f.following_id = u.id
);

UPDATE users u
SET following_count = (
    SELECT COUNT(*)
    FROM follows f
    WHERE f.follower_id = u.id
);

CREATE TABLE notifications (
                               id BIGSERIAL PRIMARY KEY,
                               user_id BIGINT NOT NULL,          -- 알림 받는 사람
                               sender_id BIGINT,                 -- 알림 보낸 사람
                               post_id BIGINT,                   -- 관련 게시글
                               type VARCHAR(20) NOT NULL,        -- LIKE, COMMENT, APPROVED, REJECTED
                               message TEXT NOT NULL,            -- 알림 내용
                               is_read BOOLEAN DEFAULT FALSE,    -- 읽음 여부
                               created_at TIMESTAMPTZ DEFAULT now(),

                               CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
