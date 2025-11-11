DROP TABLE IF EXISTS recycling_posts CASCADE;
DROP TABLE IF EXISTS recycling_images CASCADE;

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

INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '종이 쇼핑백으로 정리함 만들기', e'1. 네모 반듯하고 깊이감 있는 종이백을 준비해요.
- 선반에 들어갈 수 있는 사이즈의 종이백을 골라주세요!

2. 손잡이를 잘라내고 윗부분을 접어 정리함처럼 형태를 잡아줘요.

3. 물품을 넣어 정리하면 깨긋하게 정리 끝~', '2025-10-04 13:37:22.927323 +00:00', '2025-11-03 13:37:22.927323 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/fc3757b6-55f2-4c3c-9c6e-322bdab69f82_화면 캡처 2025-11-02 192027.png', 1);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '종이가방 꽃다발 만들기', e'[준비물]
종이 가방, 스트로폼, 조화, 가위 송곳

[방법]
1. 스트로폼을 종이가방에 맞춰서 잘라주세요.

2. 종이 가방 윗부분을 접고 모양을 내요.

3. 스트로폼을 가방에 넣고 구멍을 내요.

4. 조화 꽃꽂이를 하고 꽃다발을 완성해요.', '2025-10-27 13:40:46.843000 +00:00', '2025-11-03 13:40:46.843518 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/400971ab-6f35-43ad-892a-9e85f4260e09_001.png', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '종이백 활용하여 티슈케이스 만들기', e'1. 사각 티슈보다 조금 더 큰 종이백을 준비해주세요.
너무 크면 각잡기도 힘들고 안이쁘니 작지만 않으면 되어요.

2. 손잡이 끈을 풀어줍니다.

3. 종이백 밑면 심도 뜯어내주세요.

4. 로고 위치가 티슈 중간에 오게끔 맞춰 잘라줍니다.
자르고 안접어주면 바닥면이 깔끔하지 않아요.

5. 자르고나면 자른면이 깔끔하지 않을텐데 5mm정도 접어 넣어주면 깔끔해집니다.

6. 윗면도 티슈 선에 맞게 잘라줄거에요.

7. 아까 뜯은 심지 이용해서 위치 잡으면 편해요.

8. 잘린 경계에 맞게 접어 준 후 끈있었던 쪽, 안쪽에 들어있는 심지를 빼주세요.
그리고 다 한번씩 접어주세요

9. 그다음 손잡이 구멍이 있는 면만 손잡이 구멍이 안보일 만큼만 바깥쪽으로 접어주세요.

10. 마지막으로 손잡이 끈으로 묶고 정리해주면 끝!', '2025-10-23 13:44:13.881828 +00:00', '2025-11-03 13:44:13.881828 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/4a83978a-3fe4-4602-870d-400347f7949e_SE-d7833e2f-5f75-4236-aae2-531b6e058dbc.jpg', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '정리 바구니 만들기', e'1. 원하는 격자 두께의 2배 폭으로 종이백을 길게 잘라 두 겹으로 접어요. (안쪽 면이 보이도록 접기)

2. 스트립을 가로·세로로 격자 모양으로 엮고, 양옆은 글루건이나 풀로 고정해 흔들림을 막아요.

3. 바닥을 접어 올리고 스트립을 하나씩 끼워 격자로 쌓아 원하는 높이까지 단을 올려요.

4. 끝단을 접어 붙이고 클립으로 고정해 마르도록 두면 완성!', '2025-10-05 13:44:57.863000 +00:00', '2025-11-03 13:44:57.864419 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/01aefcc1-6a82-4ff3-bbfd-10c264fedecf_SE-6d1e6f52-5c1a-4cb1-86e7-7ec7638cb1e5.jpg', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '북커버 만들기', e'1. 종이백 밑면을 잘라내고 옆면을 펼쳐서 한 장의 넓은 종이로 만듭니다.

2. 펼친 종이 위에 책을 올리고, 위 아래 여유분을 남겨 접어 책 높이에 맞게 접습니다.

3. 책 앞표지와 뒷표지를 넣을 ‘주머니’ 형태가 되도록 좌우 부분을 접어 만듭니다.

4. 종이 안쪽으로 앞표지와 뒷표지를 각각 넣고, 책을 닫아 커버가 단단히 고정되도록 합니다.

5. 필요하면 꾸미기 재료(스티커, 마스킹테이프, 색연필 등)로 원하는 디자인을 추가해 완성합니다.', '2025-11-01 13:45:34.508906 +00:00', '2025-11-03 13:45:34.508906 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/fff65f54-2dbe-4a67-8780-bebf0148facf_쇼핑백06.jpg', 1);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '종이죽 화분 만들기', e'1. 버려지는 종이를 모아 찢거나 잘라 물에 담근 후 펄프 상태로 만듭니다.


2. 물기를 충분히 제거한 뒤, 천연 접착제(예: 삭힌풀)와 섞어 **종이죽(걸쭉한 배합물)**을 만듭니다.

3. 화분이 될 틀이나 컵 등을 준비하고, 그 안에 종이죽을 넣어 모양을 잡아 성형합니다.

4. 성형 후 그늘에서 자연 건조시켜 단단하게 굳히고, 표면을 매끄럽게 정돈합니다.

5. 원하는 색채나 문양으로 채색하거나 꾸민 뒤, 필요 시 방수 코팅제를 발라 수분에 강하게 처리합니다.

6. 화분 속을 편백나무 조각이나 모래자갈로 채우고, 이오난사처럼 관리가 쉬운 식물을 심어 완성합니다.', '2025-09-10 13:46:07.842000 +00:00', '2025-11-03 13:46:07.842217 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/de03b23c-5028-4c48-8935-6e238c23fa90_제목을-입력해주세요_-002_(64).png', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '종이컵을 재활용해 생활 바구니 만들기', e'1. 종이컵을 13등분으로 나누어 자른다.

2. 종이컵 밑부분에 양면테이프를 붙이고 털실을 붙여 한 바퀴 감는다.

3. 잘라둔 컵의 홈마다 털실을 한 칸씩 엇갈려 감는다. 털실을 감지 않은 상단 부분은 잘라낸다
.
4.남은 털실로 세 줄을 땋아 끈을 만들고, 종이컵 상단 테두리에 붙인다.

5.와이어에 털실을 감은 뒤 컵 양쪽에 붙여 손잡이를 만든다.

6.종이컵이 아기자기한 소품 바구니로 완성되어 인테리어나 수납용으로 활용할 수 있다.', '2025-11-01 13:47:42.619262 +00:00', '2025-11-03 13:47:42.619262 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/5660fbaa-be46-4b4d-900d-aa1207b039c7_화면 캡처 2025-11-02 200638.png', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '폐지 재활용 종이 만들기', e'1. 폐지를 잘게 찢어 물에 하루 정도 불린다.

2. 믹서기로 곱게 갈아 펄프 상태로 만든다.

3. 체나 망에 고루 펴서 물기를 빼고, 수건이나 신문지 위에 올려 말린다.

4. 완전히 건조되면 새 종이처럼 사용 가능.', '2025-10-03 13:51:00.829000 +00:00', '2025-11-03 14:00:03.430701 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/7143dc12-1370-4591-92b3-be7d8df0a458_42.png', 1);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '종이 접시 모빌', e'1. 종이 접시를 여러 개 준비해 원하는 모양으로 자른다.

2. 색연필, 물감, 스티커 등으로 꾸민다.

3. 각 접시에 구멍을 뚫고 실이나 끈으로 연결한다.

4. 위쪽에 막대나 나뭇가지를 달아 천장에 걸면 완성.', '2025-11-03 13:51:25.928389 +00:00', '2025-11-03 13:51:25.928389 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/bf57322d-21af-44ed-b44e-126b31a9d59d_화면 캡처 2025-11-03 184604.png', 1);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '비닐 재활용 코바늘 티매트 만들기', e'[준비물]
비닐봉지 몇 장, 가위, 6~8호 코바늘

[방법]
1. 비닐 실(plarn) 만들기
비닐을 2~3cm 폭으로 잘라 고리처럼 연결해 실처럼 이어줌

2. 1단 – 원형 만들기
매직링 또는 사슬 4~5코로 원형 만들고 짧은뜨기 12~14코 넣기

3. 2단 – 늘리기
각 코마다 2코씩 떠서 원형 넓히기

4. 3단 – 간격 조절하며 증가 (2코 뜨기 → 1코 뜨기) 반복
더 크게 만들 땐 간격을 점점 늘리기

5. 마무리
원하는 크기 되면 빼뜨기로 정리하고 실 끝 정리', '2025-11-03 13:54:04.004346 +00:00', '2025-11-11 08:22:59.558670 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/f01429bb-eeab-4fc8-b766-602f07be89cd_SE-b44a710b-1805-4400-b371-2f59338370e5.png', 3);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '비닐 재활용 원단 만드는 방법', e'[준비물]
비닐봉지 여러 장, 가위, 다리미, 베이킹페이퍼(또는 종이포일), 평평한 다리미판

[방법]
1. 비닐봉지를 깨끗이 씻고 말린 뒤, 인쇄 부분은 가능하면 제거
구겨진 부분은 펴서 겹치기 좋게 정리

2. 비닐을 4~8겹 정도 겹쳐서 원하는 두께로 쌓기
색깔이 다른 비닐을 섞으면 패턴 효과도 남

3. 비닐 위아래에 베이킹페이퍼(또는 종이포일)를 덮고 다리미를 중온으로 예열
천천히 눌러가며 다림질 -> 비닐이 서로 녹아 붙게 함

4. 다림질 후 잠시 식히면 한 장의 단단한 비닐 원단이 완성됨

[활용]
완성된 원단은 가방, 파우치, 카드 지갑, 코스터 등 소품 제작에 사용 가능', '2025-10-08 13:54:27.252000 +00:00', '2025-11-11 08:22:37.044036 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/7263aed9-7b22-4f50-9564-343abc24ad82_KakaoTalk_20250802_170836280_05.jpg', 3);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '제기 만들기', e'1. 비닐봉지의 손잡이와 밑부분을 잘라내고 반으로 접은 뒤, 막힌 양옆을 잘라 편다.

2. 다시 반으로 접어 가운데 선을 기준으로 위아래 1~2cm는 남기고 1cm 간격으로 잘라 숱처럼 만든다.

3. 가운데에 와셔를 올리고 고무줄로 꽉 묶은 뒤, 반대쪽 끝은 테이프로 뭉쳐준다.

4. 작은 페트뚜껑 중앙에 구멍을 뚫고, 비닐과 와셔 묶음을 안쪽에 넣는다.

5. 큰 페트뚜껑에 글루건을 바르고 작은 뚜껑을 덮어 붙인 뒤 말린다.

6. 비닐 끝의 테이프를 제거하고 잘린 비닐 숱을 펼쳐 손으로 정리한다.

7. 덜 잘린 부분은 가위로 다듬으면 완성된다.', '2025-10-30 13:55:55.249000 +00:00', '2025-11-11 08:22:47.723481 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/d8936afe-4920-43ab-af5c-48d9f0b5d45d_다운로드.jpg', 3);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '나만의 다이어리 커버 만들기', e'[준비물]
재활용 비닐, 가위, 칼, 다리미, 도안 종이, 풀

[방법]
1. 베이스가 될 비닐을 도안 위에 올리고 원하는 모양의 다른 비닐 조각을 잘라 배치한다.

2. 풀로 고정한 뒤 베이킹페이퍼를 덮고 다리미로 열을 가해 녹여 붙인다.

3.완전히 식으면 도안 모양대로 칼로 자르고, 모서리를 다듬는다.

4.구멍을 뚫어 키링이나 끈을 달 수 있고, 스티커 등으로 꾸며 다이어리 커버를 완성한다.', '2025-10-07 13:56:33.142000 +00:00', '2025-11-11 08:22:28.690801 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/018cd1fa-ac50-46ce-b8e9-717fc737894b_ajtnlfnavpdlvjdkd.png', 3);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '에코백 만들기', e'1. 비닐봉지를 깨끗이 씻고 말린 뒤, 2~3cm 폭으로 가로로 잘라 고리 모양으로 만든다.

2. 고리들을 서로 연결해 긴 실처럼 이어주면 비닐실(플란, plarn)이 된다.

3. 6~8호 코바늘을 준비해 바닥부터 원형 또는 직사각형 모양으로 짧은뜨기 시작.

4. 원하는 폭까지 바닥을 만든 뒤, 양옆으로 코를 올리며 몸통 부분을 뜬다.

5. 손잡이는 사슬뜨기로 원하는 길이만큼 만들고 양쪽에 연결한다.

6.마무리로 끝실을 정리하면 비닐 재활용 에코백 완성.', '2025-11-03 13:57:14.815968 +00:00', '2025-11-11 08:23:14.051548 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/5f006c6b-a167-4414-a5e7-45332c096a96_에코백005.jpg', 3);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '책갈비 만들기', e'1. 색 있는 비닐을 3~4겹 겹쳐 베이킹페이퍼를 덮는다.

2. 다리미를 중간 온도로 눌러 비닐을 단단하게 붙인다.

3. 식으면 길쭉한 모양으로 잘라 책갈피 형태를 만든다.

4. 윗부분에 구멍을 뚫어 끈이나 리본을 달면 완성.', '2025-11-03 13:57:36.439671 +00:00', '2025-11-11 08:23:32.006324 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/2a31467e-c506-4f74-a45f-b23b4971b622_화면 캡처 2025-11-03 141737.png', 3);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '플라스틱 키링', e'1. 플라스틱 병뚜껑을 깨끗이 씻고 말린 뒤 원하는 색 조합으로 고른다.

2. 고른 병뚜껑을 잘게 잘라 틀 안에 색을 섞어 담는다.

3.뜨겁게 달궈진 기계(또는 오븐)에 넣어 병뚜껑이 녹아 하나로 합쳐지게 한다.

4. 녹은 플라스틱이 식으면 꺼내서 틀 모양대로 눌러 찍는다.

5.굳은 뒤 칼이나 가위로 가장자리를 다듬는다.

6. 구멍을 뚫고 고리를 끼워 체인을 달면 업사이클링 키링 완성.', '2025-10-05 13:58:08.347000 +00:00', '2025-11-03 13:58:08.347870 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/90dadfd1-e743-4ff5-a882-9f3947b68d36_SE-ac446c78-a682-11f0-b9d2-51ef51804879.jpg', 2);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '플라스틱 병뚜껑 티코스터', e'1. 플라스틱 병뚜껑을 깨끗이 씻고 말린 뒤 여러 색으로 잘게 자른다.

2. 실리콘 틀을 준비하고 밑바닥에 잘린 병뚜껑 조각, 압화, 바다유리 등을 원하는 모양으로 올린다.

3. 투명 레진을 부어 조각들이 잠기도록 채운다.

4. 버블이 생기면 이쑤시개나 열풍기로 제거하고 평평하게 정리한다.

5. 자외선 램프나 햇빛 아래에서 완전히 경화시킨다.

6. 굳은 뒤 틀에서 빼내어 가장자리를 다듬으면 플라스틱 업사이클링 티코스터 완성.', '2025-10-14 13:58:41.337000 +00:00', '2025-11-03 13:58:41.337730 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/cf70a961-fac8-4af3-9c84-825f089d8b39_화면 캡처 2025-11-03 143057.png', 2);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '책갈피 만들기', e'1. 플라스틱 병뚜껑을 깨끗이 씻고 말린 뒤, 색 있는 조각이나 글리터를 준비한다.

2. 병뚜껑 안쪽에 스티커나 색소를 넣어 원하는 디자인으로 꾸민다.

3. 투명 레진을 병뚜껑 안에 천천히 부어 채운다.

4. 기포가 생기면 이쑤시개로 제거하고 평평하게 만든다.

5. 자외선 램프나 햇빛 아래에서 굳혀 완전히 경화시킨다.

6. 굳은 뒤 구멍을 뚫어 끈이나 체인을 달면 업사이클링 책갈피 완성.', '2025-10-20 13:59:07.067000 +00:00', '2025-11-03 13:59:07.067266 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/f762c5b4-b31e-46a0-901c-0c9193b00472_블로그첫화면_(40).jpg', 2);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '플라스틱 구슬 만들기', e'1. 페트병 뚜껑을 모아 깨끗이 씻고 충분히 말린다.

2. 색깔별로 분류한 뒤, 분쇄기로 잘게 부숴 작은 조각으로 만든다.

3. 부순 조각을 금속이나 실리콘 틀에 넣고 열을 가해 녹인다.

4. 조각들이 녹아 서로 붙으면 원하는 모양(구슬, 원형 등)으로 성형한다.

5. 완전히 식힌 뒤 틀에서 꺼내면 알록달록한 플라스틱 구슬 완성.

이 구슬은 팔찌, 목걸이, 키링 등 다양한 업사이클링 제품으로 활용할 수 있다.', '2025-10-28 13:59:39.065000 +00:00', '2025-11-03 13:59:39.065934 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/80872896-7da7-43dd-ba38-e523203987fe_1756276947522.jpg', 2);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '종이비즈 액세서리', e'1. 잡지나 색종이를 세로로 잘라 긴 삼각형 모양으로 만든다.

2. 얇은 막대에 돌돌 말고 끝부분을 풀로 붙인다.

3. 마른 후 투명 매니큐어나 바니시를 칠해 코팅한다.

4. 실이나 끈에 꿰어 팔찌나 목걸이로 완성.', '2025-11-03 14:16:12.283081 +00:00', '2025-11-03 14:16:12.283081 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/0c6667ff-f7c2-4cb2-83fd-fdd60adf3932_화면 캡처 2025-11-03 231541.png', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '화분 커버 만들기', e'[준비물]
계란 판 묶는 비닐끈 (4판 정도), 코바늘, 가위

[방법]
1. 비닐끈을 깨끗이 모아 반으로 갈라 얇게 만든다.

2. 코바늘로 원형 바닥부터 짧은뜨기로 화분 크기에 맞게 뜬다.

3. 끈이 짧으면 이어서 매듭을 안쪽으로 넣는다.

4.윗부분에 사슬뜨기로 손잡이 끈을 만들어 연결한다.', '2025-11-03 14:45:46.774872 +00:00', '2025-11-11 08:21:47.082967 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/52b36a7e-c3c3-4cdf-89da-2d2b1d4fc6d3_SE-2950c44c-b5eb-4c62-b428-d1d429ef6e14.jpg', 3);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '비닐봉지 팔찌 만들기', e'[준비물]
비닐봉지, 가위, 고무줄(또는 철사), 테이프

[방법]
1. 비닐봉지를 깨끗이 씻어 말린 뒤 길게 잘라 끈처럼 만든다.

2. 두세 가닥을 꼬거나 땋아서 원하는 두께로 만든다.

3. 손목 둘레에 맞춰 고무줄이나 테이프로 끝을 고정한다.
- 여러 색을 섞으면 더 예쁘다. -', '2025-11-03 14:46:07.917339 +00:00', '2025-11-11 08:21:29.027120 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/2623ac48-07a3-4136-9f86-97ea7aabd896_IMG＿20230607＿132125＿981.jpg', 3);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '쿠션 벽거울 만들기', e'1. 비닐백을 깨끗이 닦고 택이나 스티커를 제거한다.

2. 거울보다 조금 작은 원을 중앙에 그리고 가위로 오린다.

3. 비닐 안쪽에 솜을 넣어 쿠션처럼 만든다.

4. 실과 바늘로 원형 테두리를 따라 꿰매며 고정한다.

5. 오려둔 부분 안쪽으로 거울을 넣고 단단히 고정한다.

6.윗부분에 실을 달아 벽에 걸 수 있도록 마무리한다.', '2025-10-07 14:46:35.798000 +00:00', '2025-11-11 08:20:54.044540 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/76278266-ea6f-4990-b147-455fd09f2018_SE-700da10c-b4ec-4762-bd9c-236b52d709c2.jpg', 3);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '비누 트레이 만들기', e'1. 플라스틱 용기를 깨끗이 씻고 물기를 말린다.

2. 비누 크기에 맞게 원하는 모양(사각형, 타원형 등)으로 자른다.

3. 송곳이나 펀치를 이용해 바닥에 물 빠짐 구멍을 여러 개 뚫는다.

4. 모서리가 날카로우면 가위 끝으로 다듬거나 테이프로 감싼다.

5. 욕실이나 세면대 위에 올려 사용한다.', '2025-11-03 14:46:56.873975 +00:00', '2025-11-03 14:46:56.873975 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/1141dc0f-adcb-49cb-a6bb-c48be191662d_화면 캡처 2025-11-03 233737.png', 2);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '플라스틱 숟가락 조명', e'1. 플라스틱 숟가락 손잡이 부분을 잘라 내어 숟가락 머리만 분리한다.

2. 컵이나 병을 뒤집어서 조명 갓 형태로 틀을 만든다.

3. 글루건으로 컵(또는 병) 윗부분 가장자리부터 숟가락 머리를 붙인다.

4. 첫 층을 붙인 뒤, 그 사이에 다시 숟가락을 붙여 겹겹이 쌓는다.

5. 전체가 꽃잎 모양처럼 되도록 층을 올려간다.

6. 숟가락 붙이기를 완료하면, 중앙에 전구 소켓을 설치하고 전구를 넣는다.

7.감성 조명 또는 무드등으로 벽에 걸거나 탁상용으로 사용한다.', '2025-11-03 14:47:22.850726 +00:00', '2025-11-03 14:47:22.850726 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/c49983b6-5a4d-456c-97ef-9d9701ad7188_jeogtm64trnhanmk8kn2.webp', 2);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '플라스틱 병 화분', e'1. 플라스틱 병을 깨끗이 씻고 라벨을 제거한다.

2. 병 윗부분을 잘라 화분 모양으로 만든다.

3. 바닥에 송곳으로 구멍을 몇 개 뚫어 배수가 잘되게 한다.

4. 자갈을 조금 넣고 흙을 채운 뒤 식물을 심는다.

5. 물감이나 테이프로 꾸며 완성한다.', '2025-10-14 14:47:54.951000 +00:00', '2025-11-03 14:47:54.951681 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/80aa854e-dbf8-45fa-b381-2a58a8199da7_IMG_8071.jpg', 2);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '신문지로 쓰레기 봉투 만들기', e'1. 신문지를 펼쳐놓고 열려있는 두 변(양쪽 긴 변)을 접어줍니다.

2. 한쪽 긴 변을 접은 뒤 풀이나 테이프로 고정합니다.

3. 다른 쪽 긴 변도 동일하게 접고 고정해서 봉투 형태로 만듭니다.

4. 하단이 열린 상태라면 아래쪽을 접어 봉투 바닥을 만들어줍니다. (두 번 접거나 바닥 안쪽으로 넣도록 접으면 단단해져요)

5. 완성된 봉투를 쓰레기통 안에 넣거나, 그 자체로 쓰레기 봉투처럼 사용합니다.
라이프스타일 슈퍼앱, 오늘의집', '2025-11-03 14:48:28.958308 +00:00', '2025-11-03 14:48:28.958308 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/dc9f6714-334f-4c58-91fd-0a554a7c065d_166910423546779530.png', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '메모 보드 캘린더', e'1. 달력의 종이를 떼고 뒷판만 남긴다.

2. 뒷판에 색종이나 포장지를 붙여 배경을 만든다.

3. 작은 상자나 접은 종이로 주머니를 만들어 붙인다.

4. 달력 페이지나 인쇄한 달력을 붙인다.

5. 사진이나 스티커로 꾸며 완성한다.', '2025-11-03 14:58:42.353033 +00:00', '2025-11-03 14:58:42.353033 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/5f4ad2c5-d4f7-4e7d-bc73-154284b600dc_SE-60c8d0ec-0618-4a20-9478-00425d241377 (1).jpg', 1);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '석고방향제 만들기', e'1. 석고 가루와 물을 약 2:1 비율로 종이컵에 넣고 나무 젓가락으로 빠르게 섞는다.
너무 오래 저으면 굳기 시작하므로 1분 이내로 섞는 것이 좋다.

2. 완성된 석고 반죽을 실리콘 몰드에 천천히 붓는다.
공기 방울이 생기면 가볍게 탁탁 쳐서 기포를 제거한다.

3. 상온에서 약 30분~1시간 정도 두어 완전히 굳힌다.
완전히 단단해지면 몰드에서 조심히 분리한다.

4. 아크릴 물감으로 석고 표면을 채색한다.
바다나 하늘을 떠올리며 파란색, 흰색, 초록색 계열을 자연스럽게 섞어 표현하면 좋다.

5. 채색이 마른 후, 글루건이나 접착제를 이용해 바다유리와 조개껍데기를 붙인다.
파도 위에 떠 있는 느낌을 내도록 위치를 자유롭게 구성한다.


6. 완성된 방향제 표면에 좋아하는 향 오일을 2~3방울 떨어뜨린다.
오일이 스며들며 은은한 향이 퍼진다.

7. 구멍이 있는 몰드라면 리본이나 끈을 달아 걸 수 있도록 마무리한다.', '2025-11-03 17:47:00.885641 +00:00', '2025-11-11 08:58:37.136217 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/82d997f2-51e8-45f2-9bc2-a9f4fa7cc7b5_SE-fddf0770-5499-4b5b-8979-b6b948b743c3.jpg', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '바다유리 도어벨 만들기', e'1. 원형판 앞면의 보호 비닐을 제거한다.

2. 펜으로 원하는 글귀나 그림을 그린다. 젤리펜이나 아크릴펜이 잘 어울린다.

3. 바다유리를 붙일 위치를 정하고, 목공풀을 이용해 부착한다.

4. 목공풀이 완전히 마를 때까지 충분히 건조시킨다.

5. 뒷면의 보호 비닐을 제거해 투명하게 완성한다.

6. 오링을 이용해 도어벨과 군번줄을 연결한다.

7. 줄 길이를 조절한 뒤 남은 부분은 자르고, 묶은 끝이 풀리지 않도록 목공풀을 살짝 바른다.

8. 완성된 도어벨을 문손잡이나 벽걸이에 걸어 딸랑딸랑 소리를 확인한다.', '2025-11-03 17:47:22.119365 +00:00', '2025-11-11 08:58:47.062912 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/e0532a47-7d46-4367-94c9-36264144d833_SE-72aa1308-afe7-48d8-9548-4eb46ee9dc22.jpg', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '캔들 홀더', e'1. 빈 깡통을 깨끗이 씻고 말린다.

2. A4용지를 바닥에 놓고 캔을 굴려 둘레 길이를 표시한 뒤, 높이까지 맞춰 잘라 캔 외형의 가이드 종이를 만든다.

3. 지점토를 밀대로 0.5cm 두께 정도로 평평하게 밀어준다.

4. 종이를 지점토 위에 올리고, 그 모양대로 아트나이프로 잘라낸다.

5. 자른 지점토를 캔 둘레에 감싸 붙이고, 겹치는 부분은 물을 살짝 묻혀 손가락으로 문질러 자연스럽게 잇는다.

6. 하루 정도 충분히 건조시켜 단단하게 굳힌다.

7. 마른 점토 표면에 마스킹테이프를 붙이고, 원하는 색으로 아크릴 물감을 칠한다. 스트라이프나 패턴을 넣어도 좋다.

8. 완전히 마르면 테이프를 제거하고 마감한다.

9.캔 안에 모래를 담고 초를 꽂아 캔들홀더로 완성한다.', '2025-11-03 17:47:47.397754 +00:00', '2025-11-11 08:43:03.237129 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/9c33a550-d6e8-4856-951c-f0bf369fe81a_1.jpg', 4);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '캔뚜껑으로 옷걸이 정리', e'- 캔뚜껑 구멍 2개를 활용해서 위에는 기존 옷걸이, 아래에는 다른 옷걸이를 걸면 여러 옷을 한 세트로 보관할 수 있음.
- 코디해둔 옷을 한 번에 걸어두면 아침 준비 시간이 단축됨.
- 코트·원피스처럼 긴 옷은 하단을 아래 옷걸이에 접어 걸면 바닥에 끌리지 않음.
- 좁은 옷장 공간을 효율적으로 확장할 수 있음.', '2025-11-03 17:48:05.956842 +00:00', '2025-11-11 08:42:05.108512 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/89e74a3f-58f7-4115-9990-bb61ab25301c_900＿20241118＿125423.jpg', 4);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '케이블·선 정리용', e'1. 캔뚜껑 한쪽 구멍에 고무줄을 묶어서 고정.

2. 케이블선을 감고 고무줄로 고정한 뒤, 다시 캔뚜껑 구멍에 넣으면 깔끔하게 정리됨.

- 여러 선이 섞이지 않고 종류별로 구분 가능.
- 캔뚜껑에 네임펜으로 용도(충전기, 노트북, 블루투스 등)를 써두면 구분이 쉬움.', '2025-11-03 17:48:24.486047 +00:00', '2025-11-11 08:41:43.321507 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/4a9d42c9-94f9-41be-a181-c9740386ef26_900＿베이지색_미니멀리스트_육아_카드뉴스_썸네일_인스타그램_포스.png', 4);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '에코백 만들기', e'1. 어깨·목 부분 자를 선 표시

2. 표시선 따라 잘라 민소매 형태 만들기

3. 티셔츠를 뒤집기

4. 밑단을 실로 두 줄 바느질해 튼튼하게 막기

5. 다시 뒤집으면 완성', '2025-11-04 02:16:05.909115 +00:00', '2025-11-11 08:56:39.554919 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/21ffa3e2-8ce7-4f2f-b2d3-3cf8528e0f9b_1.홍보서포터즈틀.jpg', 7);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '파우치 만들기', e'1. 원하는 파우치 크기의 3배 정도로 천을 자르기

2. 천을 안감이 위로 오게 펼치고, 끈이 들어갈 윗부분을 구멍 나게 접기

3. 그 접은 부분을 박음질

4. 천을 다시 안감이 바깥쪽으로 나오게 접기

5. 양쪽을 따라 박음질→ 꼼꼼히 꿰매야 튼튼

6. 윗부분 구멍에 끈을 통과시키기 (옷핀을 끈 끝에 달면 편리)

7. 양쪽 끈을 다 통과시켜 매듭짓기', '2025-11-04 02:16:30.576245 +00:00', '2025-11-11 08:56:31.096701 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/ff611472-459a-492c-a8b7-f175133ab16e_8월_5.png', 7);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '화병으로 꽃병 만들기', e'1. 잘 쓰지 않는 유리 화병과 식물, 자갈을 준비해주세요.
- 유리의 크기는 상관없습니다!

2. 물구멍이 없는 대신 굵은 자갈을 사용해 물이 머물 공간을 만들어요.

3. 흙을 조금 넣고 식물을 담은 후 다시 흙을 채워요.', '2025-11-04 02:25:33.913158 +00:00', '2025-11-11 08:57:25.162131 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/34f2818a-0684-4e7a-a229-a8c59aace8f4_KakaoTalk_20251104_112333077.png', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '노프레임거울로 구멍화병 만들기', e'1. 거울을 뒤집어 준비한 락카스프레이로 색 작업을 합니다.
- 시트지를 붙여도 괜찮습니다

2. 반대쪽 거울도 유리벙에 붙여 리폼을 합니다.

3. 완성된 구멍 화병에 물을 담고 꽃을 꽂아줍니다.', '2025-11-04 02:26:55.214607 +00:00', '2025-11-11 08:58:17.806983 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/dc86df6b-7f88-46ff-a86a-41ebf5b2fdb2_KakaoTalk_20251104_112333077_06.png', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '잼병으로 꽃병 만들기', e'1. 잼병과 페인트 마카펜을 준비합니다.
- 마카펜은 2~3가지 컬러 정도면 됩니다

2. 생각해 둔 디자인이 있다면 유리병에 미리 위치를 체크합니다.

3. 캘리그라피로 그림을 그립니다.

4. 바나시로 전체를 칠해줍니다.

5. 끈을 이용해 펜던트 유리병에 달아줍니다.', '2025-11-04 02:27:42.644495 +00:00', '2025-11-11 08:57:48.773912 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/7cda2113-9531-4ab1-97b5-7293eb53f2f2_KakaoTalk_20251104_112333077_07.png', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '유리로 캔들 홀더 만들기', e'1. 빈 유리병과 락카페이트, 스티커를 준비합니다.

2. 군데군데 스티커를 병에 붙이고 난 후 스프레이 페인트를 뿌려줍니다.
- 상자 안에 병을 넣고 30cm 정도 거리를 두고 가볍게 뿌려줍니다.

3. 한 시간 정도 말리고 핀셋으로 스티커를 떼어주면 완성입니다.', '2025-11-04 02:28:33.317866 +00:00', '2025-11-11 08:58:25.155804 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/38be6e98-9f90-4c0f-b452-69d71eab1755_KakaoTalk_20251104_112333077_11.png', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '유리타일로 냄비 받침대 만들기', e'1. 원목판의 거칠거칠한 부분을 사포로 문질러 부드럽게 만듭니다.

2. 목공용 풀을 바닥면에 넉넉하게 발라줍니다

3. 유리 타일 조각을 바닥면 위에 붙입니다.

4. 퍼티에 물을 섞어 유리와 유리 공간에 발라줍니다.

5. 30~40분 말려주면 완성입니다.', '2025-11-04 02:29:13.537611 +00:00', '2025-11-11 08:57:34.676470 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/b68ab199-2c1c-4d5d-86e3-d5a93c07a64c_KakaoTalk_20251104_112333077_14.png', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, 'EM 거름 만들기', e'1. 새 흙과 채소류 위주의 음식물 쓰레기를 준비합니다.

2. 플라스틱 통에 흙을 일정 두께로 깔아줍니다.

3. 그 위에 음식물 쓰레기를 넣습니다.

4. EM 바료액을 뿌리면 거름이 만들어집니다.', '2025-11-04 02:29:57.052726 +00:00', '2025-11-11 08:56:17.674370 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/17778759-6590-418e-9f47-766998bcaa54_KakaoTalk_20251104_112333077_19.png', 6);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '커피찌꺼기로 천연탈취제 만들기', e'1. 커피찌꺼기를 다시백이나 종이백에 넣어줍니다.
- 쓰고 남은 드립 필터지도 가능합니다!

2. 마스킹 테이프로 입구를 막아줍니다.
- 고무줄로 묶어서 고정해도 좋습니다.', '2025-11-04 02:31:07.639128 +00:00', '2025-11-11 08:55:57.688818 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/370cfa60-f10a-4271-9b33-b619f66ba505_KakaoTalk_20251104_112333077_23.png', 6);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '계란 껍질로 텀블러 세척하기', e'1. 계란 껍질과 세제, 세척할 텀블러를 준비합니다.

2. 텀플러 안에 계란 껍질과 세제를 넣고 흔들어줍니다.
- 껍질이 연마제 역할을 하여 구석구석 깨끗하게 세척할 수 있습니다.', '2025-11-04 02:31:55.999360 +00:00', '2025-11-11 08:55:45.025482 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/44a3e55b-e1fa-4621-b6fe-5a55dd3b1d1b_KakaoTalk_20251104_112333077_16.png', 6);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '페인트마카로 유리병 리폼하기', e'1. 유리병과 페인트마카를 준비합니다.
- 페인트마카 사용 전 충분히 흔들어서 사용하세요!
- 방수 소재를 사용하면 세척해도 마카가 지워지지 않아요!

2. 깨끗하게 씻은 유리병에 원하는 컬러와 패턴을 그립니다.', '2025-11-04 02:35:57.656804 +00:00', '2025-11-11 08:58:06.082687 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/3188c471-7abf-404d-9252-6f4e7c1fb5a8_KakaoTalk_20251104_113325912_04.png', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '나만의 유리컵 만들기', e'1. 그림을 직접 그려서 디자인한 뒤 자릅니다.
- 다양한 일러스트 및 이니셜도 가능합니다.

2. 자른 후에 유리 표면에 붙여 꾸며줍니다.

3. 붙인 뒤 물기를 꼼꼼하게 닦아줍니다.', '2025-11-04 02:36:28.454985 +00:00', '2025-11-11 08:57:58.338665 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/894bbd73-ac68-41d7-9b69-eb6bab801699_KakaoTalk_20251104_113325912_07.png', 5);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '바다유리로 목걸이 만들기', e'1. 바다에서 재취한 폐유리 준비합니다.

2. 바다유리에 철망을 감싸줍니다.

3. 줄을 연결해주면 목걸이가 완성됩니다.', '2025-11-04 02:36:53.977460 +00:00', '2025-11-11 08:59:01.423585 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/84213cfa-eccf-407a-b2fb-377d3a8b7f2d_KakaoTalk_20251104_113325912_02.png', 5);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '바나나껍질 활용하기', e'1. 바나나 껍질을 준비합니다.

2. 껍질 안쪽 부분을 가죽 제품에 문질러주면 클리너 역할을 합니다.
- 가죽을 부드럽고 광택나게 해줍니다!', '2025-11-04 02:37:28.586955 +00:00', '2025-11-11 08:55:37.340898 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/069e7f88-87e7-4589-8702-da3806f12682_KakaoTalk_20251104_112333077_18.png', 6);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '천연 화분 비료 만들기', e'1. 흙과 커피 찌꺼기를 준비합니다.

2. 커피찌꺼기와 흙을 1:2 비율로 섞습니다.

3. 화분의 가장자리부터 조금씩 넣어줍니다.', '2025-11-04 02:37:51.709205 +00:00', '2025-11-11 08:55:26.626131 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/f6d95c14-0b23-4b59-920f-a256d15e6554_KakaoTalk_20251104_113325912_12.png', 6);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '수박 껍질 활용하기', e'1. 수박 껍질을 준비합니다.

2. 껍질의 안쪽을 사용해 조리대나 싱크대에 문질러줍니다.

3. 마른 수건으로 닦아내면 은은한 광택과 함께 정리된 모습을 볼 수 있습니다.', '2025-11-04 02:41:50.522657 +00:00', '2025-11-11 08:55:18.118628 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/7b1d2849-cc7a-4d11-aa7d-5acafd823b4b_KakaoTalk_20251104_113325912_10.png', 6);
INSERT INTO public.recycling_posts (user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '계란 껍질로 청소하기', e'1. 계란 껍질을 깨서 물에 뿌립니다.

2. 스펀지나 스크러버를 사용하여 욕조, 세면대, 바닥 등 묻은 부분을 닦아줍니다.
- 계란껍질은 마모성이 있어 어려운 얼룩을 제거하는 데 도움이 됩니다.', '2025-11-04 02:42:35.560325 +00:00', '2025-11-11 08:55:00.470636 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/dd113b84-c1b1-467c-9dcb-cc41a69d1dba_KakaoTalk_20251104_113325912_11.png', 6);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '과일껍질로 반찬통 냄새 제거하기', e'1. 사과 껍질이나 귤껍질을 준비합니다.
- 과일 껍질에는 미세한 구멍이 많고 과일 자체의 향긋한 성분이 들어있습니다.

2. 반찬통을 씻어 잔여물을 제거하고 물기를 말려줍니다.

3. 과일 껍질을 반찬통에 넣고 하루 이틀정도 보관합니다.', '2025-11-04 02:43:21.428447 +00:00', '2025-11-11 08:54:52.023895 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/7b1a7709-0f0e-402a-a098-6bac268bfee6_KakaoTalk_20251104_113325912_01.png', 6);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '하트 볼펜 만들기', e'1. 자투리 천을 반으로 접고 하트 모양 도안을 그린 뒤 가위로 두 장을 오린다.

2.  두 장의 천을 글루건으로 가장자리를 붙이되 윗부분은 솜을 넣을 공간을 남긴다.

3. 남겨둔 틈으로 솜을 채워 볼록한 하트 모양을 만든다.

4. 볼펜 윗부분을 하트 속에 넣고 글루건으로 고정한다.

5. 남은 틈을 본드로 막고 리본이나 단추, 펠트 등으로 꾸민다.', '2025-11-04 02:45:31.136181 +00:00', '2025-11-11 08:56:58.493466 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/05ec658c-9066-4674-8145-cf1d3e2cdb0f_KakaoTalk_20251104_114145300.jpg', 7);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES (1, '한복 천을 활용한 댕기 키링 만들기', e'1. 사용할 한복 천을 고른다. 자투리천의 크기와 상태를 확인한다.

2. 키링 크기에 맞춰 천에 도안을 그리고 열펜으로 표시한 후 재단가위로 자른다.

3. 사장님이 재봉틀로 일부를 박은 천을 받아 시침질로 고정한다.

4. 표시한 선을 따라 박음질을 한다. 바느질 경험이 없어도 자세히 안내받으며 가능하다.

5. 끝부분은 뒤집을 수 있도록 숨구멍을 남겨둔다.

6. 뒤집은 후 다리미로 눌러 모양을 잡는다.

7. 천을 원하는 길이로 접어 제비부리댕기 형태로 만든다.

8. 키링 고리를 끼우고, 전통 국화매듭을 묶어 장식한다.

9. 길이를 조정하고 매듭으로 마무리한다.', '2025-11-04 02:46:18.408684 +00:00', '2025-11-11 08:57:07.538042 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/8de54a40-65d7-4ed5-b236-00c31bf0f0a1_KakaoTalk_20251104_114145300_04.jpg', 7);
INSERT INTO public.recycling_posts ( user_id, title, description, created_at, updated_at, thumb_nail_image, category_id) VALUES ( 1, '패브리캔디', e'1. 자투리 천을 수거하고 천연섬유(면, 린넨 등) 위주로 선별한다.

2. 효소를 사용해 섬유의 셀룰로오스를 포도당으로 분해한다.

3. 분해된 용액에서 포도당을 추출하고 불순물을 제거한다.

4. 정제된 포도당 용액을 가열해 점도가 생길 때까지 농축한다.

5. 천연 색소와 향료를 넣어 맛과 향, 색을 입힌다.

6. 뜨거운 혼합물을 사탕 몰드나 손으로 굴려 모양을 만든다.

7. 식혀서 굳히면 자투리 천에서 얻은 업사이클링 사탕이 완성된다.', '2025-11-04 02:46:49.235103 +00:00', '2025-11-11 08:56:50.788109 +00:00', 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recyclingThumbnail/0c754bdd-3fa7-4d53-b23d-76344668fdda_KakaoTalk_20251104_114145300_06.jpg', 7);

INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 1, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/478ed27a-8a07-41db-8e2d-ed2bc81c0085_3.png', '2025-11-03 13:37:23.224600 +00:00', '2025-11-03 13:37:23.224600 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 1, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/667428d1-0b73-4de0-b17b-5049d36dd189_화면 캡처 2025-11-02 192651.png', '2025-11-03 13:37:23.496651 +00:00', '2025-11-03 13:37:23.496651 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 1, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/ef2516f5-ceb6-478a-87a4-92ed400a9e6f_화면 캡처 2025-11-02 192128.png', '2025-11-03 13:37:23.372286 +00:00', '2025-11-03 13:37:23.372286 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 2, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/820a40d4-78e0-448c-a580-113f667ee722_SE-e4761fbd-14e8-11f0-9e55-196430243a31.jpg', '2025-11-03 13:40:47.788837 +00:00', '2025-11-03 13:40:47.788837 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 2, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/378fe4a1-85ee-417b-9922-bf989912b7a9_900＿2025－04－09－11－14－28－875.jpg', '2025-11-03 13:40:47.052596 +00:00', '2025-11-03 13:40:47.052596 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 2, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/75ff4e51-a018-42dd-b443-7a0639f34d20_900＿2025－04－09－11－14－30－042.jpg', '2025-11-03 13:40:47.283464 +00:00', '2025-11-03 13:40:47.283464 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 2, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/561c502e-249b-4054-a8d7-42976f4952cc_900＿2025－04－09－11－15－14－069.jpg', '2025-11-03 13:40:47.521257 +00:00', '2025-11-03 13:40:47.521257 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 2, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/84f52503-aac9-4840-9918-67c897ec2c43_SE-dcf0214d-5e1b-4aa1-9e1f-29c624b8afb3.jpg', '2025-11-03 13:40:47.653035 +00:00', '2025-11-03 13:40:47.653035 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 3, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/598fe412-12c1-4441-81ac-08dc64780e14_KakaoTalk_20240427_011302981_21.jpg', '2025-11-03 13:44:14.177862 +00:00', '2025-11-03 13:44:14.177862 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 3, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/b5efa21b-b7e8-4615-b1ca-e60ff2e06cb6_KakaoTalk_20240427_011302981_01.jpg', '2025-11-03 13:44:14.110000 +00:00', '2025-11-03 13:44:14.110000 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 3, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/91ceba18-ca5c-4165-9c2c-38cd9b76938b_KakaoTalk_20240427_011302981_12.jpg', '2025-11-03 13:44:14.031937 +00:00', '2025-11-03 13:44:14.031937 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 3, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/5d224781-6110-4b57-ab60-325e779eef1b_KakaoTalk_20240427_011302981_26.jpg', '2025-11-03 13:44:13.956730 +00:00', '2025-11-03 13:44:13.956730 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 3, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/2c7e1fda-6849-4336-9986-b8b29ff507e9_KakaoTalk_20240429_171531230.jpg', '2025-11-03 13:44:14.244765 +00:00', '2025-11-03 13:44:14.244765 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 4, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/6995dfbc-3fbb-4b77-b007-45034c0a82c7_바구니1 (1).jpg', '2025-11-03 13:44:58.010658 +00:00', '2025-11-03 13:44:58.010658 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 4, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/d936250c-70c0-4f13-b5f4-1b5edc01272f_바구2.jpg', '2025-11-03 13:44:57.928203 +00:00', '2025-11-03 13:44:57.928203 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 6, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/bf323376-8253-482e-9fb2-52bd4f79300d_IMG＿8808.jpg', '2025-11-03 13:46:07.918303 +00:00', '2025-11-03 13:46:07.918303 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 7, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/d4bbac32-3bc2-4301-8cdb-afab3524be24_SE-1ea385ab-426b-4ba8-b03c-cc7df5f09a41.png', '2025-11-03 13:47:42.875021 +00:00', '2025-11-03 13:47:42.875021 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 7, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/61e989ab-d488-4023-8639-87dc05447229_SE-d1232290-58dd-449b-b6ca-f8984c72a76f.png', '2025-11-03 13:47:43.660100 +00:00', '2025-11-03 13:47:43.660100 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 7, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/283f00d5-49ee-47dd-8420-a705e20bb95c_SE-220cbd73-e5fe-41a4-b101-214645427d83.png', '2025-11-03 13:47:43.523874 +00:00', '2025-11-03 13:47:43.523874 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 7, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/932acf3d-b9b9-4118-9954-dae5e10a3628_SE-64c9b32b-e149-49fa-845b-92f983fb000e.png', '2025-11-03 13:47:43.310203 +00:00', '2025-11-03 13:47:43.310203 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 7, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/a8ab6beb-da51-41a9-8808-e958e163ebe8_SE-5bf449fa-138d-41db-b61c-59959f808442.png', '2025-11-03 13:47:43.114618 +00:00', '2025-11-03 13:47:43.114618 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 8, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/09cdfe04-34d1-45ea-b0c6-4ea998afcc0a_화면 캡처 2025-11-03 184213.png', '2025-11-03 13:51:01.367538 +00:00', '2025-11-03 13:51:01.367538 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 8, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/01e89c37-ebaf-4564-87fa-3d681b02afe5_화면 캡처 2025-11-03 184121.png', '2025-11-03 13:51:01.123485 +00:00', '2025-11-03 13:51:01.123485 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 10, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/ecae8a3b-7b12-4eb3-a2f1-f681495bc212_004.jpg', '2025-11-03 13:54:04.088287 +00:00', '2025-11-03 13:54:04.088287 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 10, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/e7ea151c-74d1-482b-8f65-6265f0c0bf92_005 (1).jpg', '2025-11-03 13:54:04.222846 +00:00', '2025-11-03 13:54:04.222846 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 10, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/a32800d6-5381-46a4-8124-cc8f3840b84a_006.jpg', '2025-11-03 13:54:04.299051 +00:00', '2025-11-03 13:54:04.299051 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 12, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/a4f6009c-79f5-4088-afe5-9ced6bd03d38_크기변환138.jpg', '2025-11-03 13:55:55.729677 +00:00', '2025-11-03 13:55:55.729677 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 12, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/fb499874-8177-4ec0-be57-2c5617e47fee_크기변환18.jpg', '2025-11-03 13:55:55.444932 +00:00', '2025-11-03 13:55:55.444932 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 12, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/a20b55c3-a4cc-4810-bdbc-5a8cdb873713_크기변환116.jpg', '2025-11-03 13:55:55.517433 +00:00', '2025-11-03 13:55:55.517433 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 12, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/9c156ab0-8e25-4de8-ba9c-bb389fcab5d5_크기변환118.jpg', '2025-11-03 13:55:55.585420 +00:00', '2025-11-03 13:55:55.585420 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 12, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/0eef5f16-4e38-47ce-8c93-7b3168750729_크기변환121.jpg', '2025-11-03 13:55:55.655002 +00:00', '2025-11-03 13:55:55.655002 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 13, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/3092d5c8-ad42-40e8-a92e-0a3b80125420_IMG_2115.jpg', '2025-11-03 13:56:33.196861 +00:00', '2025-11-03 13:56:33.196861 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 13, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/2b95aa69-5892-4250-87dd-60be316d216f_IMG_2146.jpg', '2025-11-03 13:56:33.261679 +00:00', '2025-11-03 13:56:33.261679 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 14, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/d0f16569-e5ab-4884-9d08-29fd6fec6ba8_에코백010.jpg', '2025-11-03 13:57:15.062189 +00:00', '2025-11-03 13:57:15.062189 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 14, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/ed4c52c6-7cb0-4439-965a-7900a95e1679_에코백004.jpg', '2025-11-03 13:57:14.900284 +00:00', '2025-11-03 13:57:14.900284 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 14, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/71900261-bb5b-4bb6-837f-74332ec0d31b_에코백006.jpg', '2025-11-03 13:57:14.977593 +00:00', '2025-11-03 13:57:14.977593 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 14, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/42d0f23b-098b-40cb-b8cd-0e793444728a_에코백013.jpg', '2025-11-03 13:57:15.132895 +00:00', '2025-11-03 13:57:15.132895 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 16, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/b6be1f02-1f5e-4deb-a1da-c32830e46fc7_화면 캡처 2025-11-03 142858.png', '2025-11-03 13:58:08.938679 +00:00', '2025-11-03 13:58:08.938679 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 16, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/ee487bb6-a8b8-486f-baca-99c7f9731466_SE-ac570a2e-a682-11f0-b9d2-47b71022c18d.jpg', '2025-11-03 13:58:08.775717 +00:00', '2025-11-03 13:58:08.775717 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 16, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/80ce2c86-847c-4364-9164-e6ed583a2b8a_SE-ac5b4ff4-a682-11f0-b9d2-0b1c2fd1684d.jpg', '2025-11-03 13:58:08.584121 +00:00', '2025-11-03 13:58:08.584121 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 17, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/d4809fd7-eba3-4dd6-b4b8-ada1556595b4_화면 캡처 2025-11-03 143240.png', '2025-11-03 13:58:41.576074 +00:00', '2025-11-03 13:58:41.576074 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 18, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/6422bb0a-be28-4fa7-ae4e-5c7513e07b92_20250927_145422.jpg', '2025-11-03 13:59:07.182577 +00:00', '2025-11-03 13:59:07.182577 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 19, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/ee9db76b-3279-45bb-a9ce-829df0208018_crushed-bottle-cap.jpg', '2025-11-03 13:59:39.374255 +00:00', '2025-11-03 13:59:39.374255 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 19, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/6e97d951-e356-4784-8191-c465f2f5d4cf_1756277240654.jpg', '2025-11-03 13:59:39.278242 +00:00', '2025-11-03 13:59:39.278242 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 20, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/d7790629-598c-4b43-8957-02ee85ac8f5c_SE-278d5187-8f2d-439c-9d18-d3bbde41898d.jpg', '2025-11-03 14:16:12.753745 +00:00', '2025-11-03 14:16:12.753745 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 20, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/c0e6f50b-3fd3-4b1f-a891-6525b8aaf1b4_KakaoTalk_20190325_164643080_12.jpg', '2025-11-03 14:16:12.589392 +00:00', '2025-11-03 14:16:12.589392 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 20, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/2604b71c-a60d-4d1e-9ab5-b76db07eeacc_KakaoTalk_20190325_164643080_11.jpg', '2025-11-03 14:16:12.452684 +00:00', '2025-11-03 14:16:12.453683 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 21, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/9c3345c2-3189-4726-94aa-5413fe4e8c1c_SE-e6ff8e76-4ad0-4c08-9609-885189f4006f.jpg', '2025-11-03 14:45:46.996577 +00:00', '2025-11-03 14:45:46.996577 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 21, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/dc0451e8-73ff-4263-b8ed-a430f0fa3ef8_20250522_163733.jpg', '2025-11-03 14:45:46.933665 +00:00', '2025-11-03 14:45:46.933665 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 21, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/00f9c00f-a8c2-45bb-9b93-dfabd7f81445_20250520_161712.jpg', '2025-11-03 14:45:46.865870 +00:00', '2025-11-03 14:45:46.865870 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 22, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/a6a3dfe8-3874-46a0-b0eb-ccc34459952e_20230607＿093456.jpg', '2025-11-03 14:46:07.995723 +00:00', '2025-11-03 14:46:07.995723 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 23, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/1955bd19-9613-405c-ac43-490e8341d360_SE-13a6a823-1134-485a-a722-4adeb3cdd2f6.jpg', '2025-11-03 14:46:35.874989 +00:00', '2025-11-03 14:46:35.874989 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 23, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/cb8674ef-e555-4bc4-b46d-f61bd1b87a81_SE-d37c2ecd-4970-44bf-b958-bd5328dab2ce.jpg', '2025-11-03 14:46:36.001494 +00:00', '2025-11-03 14:46:36.001494 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 23, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/6fb6930d-8906-4a05-b177-eb614112069f_SE-7220b735-1e5f-4c99-b102-3327a27af16a.jpg', '2025-11-03 14:46:35.940795 +00:00', '2025-11-03 14:46:35.940795 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 25, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/33792a37-3281-41af-9b08-4e28ee58fbcf_rb892hcq2thvmz5kete0.webp', '2025-11-03 14:47:22.911752 +00:00', '2025-11-03 14:47:22.911752 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 25, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/0c4c52f4-2606-4c4e-a2ca-c983c3858568_sgofptb7to3k5hruxhgy.webp', '2025-11-03 14:47:22.977346 +00:00', '2025-11-03 14:47:22.977346 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 26, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/841daf29-9602-423e-ad46-4e5b7c92c8b8_image_4317692001495673099694.jpg', '2025-11-03 14:47:55.109750 +00:00', '2025-11-03 14:47:55.109750 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 26, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/0d5c60c3-2b3f-4dd7-ac0a-12b6d2453b16_image_5032755931495673099689.jpg', '2025-11-03 14:47:55.258809 +00:00', '2025-11-03 14:47:55.258809 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 26, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/9e4390d6-be3f-4343-91b2-99168ba6694a_image_8452400841495673099680.jpg', '2025-11-03 14:47:55.409439 +00:00', '2025-11-03 14:47:55.409439 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 27, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/daf112c7-6067-4663-a18a-0cad16e3985b_화면 캡처 2025-11-03 231341.png', '2025-11-03 14:48:29.145936 +00:00', '2025-11-03 14:48:29.145936 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 28, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/0c033298-461b-4ca9-9827-bc00e80c9404_SE-e2d6cf1c-3d2b-4eb0-b5fa-a57c4f5904e9.jpg', '2025-11-03 14:58:42.459723 +00:00', '2025-11-03 14:58:42.459723 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (29, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/4480942b-f6f0-43cb-9ca9-378173e6a56c_SE-b0f76807-4e21-4b56-89a9-36388f306977.jpg', '2025-11-03 17:47:01.187093 +00:00', '2025-11-03 17:47:01.187093 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (29, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/f681f264-7872-4336-bf7d-2f3dc22b523d_SE-6836f8df-2eb1-4709-9471-e533c9b90d93.jpg', '2025-11-03 17:47:01.100508 +00:00', '2025-11-03 17:47:01.100508 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (30, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/a2079c8e-7f1a-46d1-97b5-09294639b7dd_SE-69cac9f2-2700-40bf-a221-e007c5512232.jpg', '2025-11-03 17:47:22.193013 +00:00', '2025-11-03 17:47:22.193013 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (30, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/9d022cd7-7793-420e-a147-6af031c01c70_SE-39501e28-210c-488e-8941-7b83c876299e.jpg', '2025-11-03 17:47:22.243780 +00:00', '2025-11-03 17:47:22.243780 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (31, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/0ee9ec50-cb9b-470a-8b66-31bf12ac9c29_7.jpg', '2025-11-03 17:47:47.463903 +00:00', '2025-11-03 17:47:47.463903 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (31, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/4d8b2a6b-7e72-412e-bffa-d4775339ff55_9.jpg', '2025-11-03 17:47:47.535845 +00:00', '2025-11-03 17:47:47.535845 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (31, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/980db76e-6c5c-412d-9c2d-7903fa13940f_10.jpg', '2025-11-03 17:47:47.602428 +00:00', '2025-11-03 17:47:47.602428 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (32, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/ecbfa435-3d91-4032-8de8-60d3f3f0f1ee_900＿20241118＿125018.jpg', '2025-11-03 17:48:06.096858 +00:00', '2025-11-03 17:48:06.096858 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (33, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/ebf6fcaf-d982-4b33-b32b-8e2ecbcc6e0f_900＿20241118＿131311.jpg', '2025-11-03 17:48:24.647006 +00:00', '2025-11-03 17:48:24.647006 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (34, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/177619b6-e679-4b37-8b88-9fe8b1024b90_005.jpg', '2025-11-04 02:16:06.376349 +00:00', '2025-11-04 02:16:06.376349 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (34, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/71933ff8-337e-49dd-93b6-8725fa6c196e_011.jpg', '2025-11-04 02:16:06.801581 +00:00', '2025-11-04 02:16:06.801581 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (35, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/859673a7-56d6-4e81-aab7-7929884ab9f0_8월_1.png', '2025-11-04 02:16:30.738164 +00:00', '2025-11-04 02:16:30.738164 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (35, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/cec96e0b-4622-4da3-b66c-127134a60ef7_8월_2.png', '2025-11-04 02:16:30.930790 +00:00', '2025-11-04 02:16:30.930790 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (35, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/afefdce6-8c21-46c0-98f7-90db0285e1c5_8월_3.png', '2025-11-04 02:16:31.120238 +00:00', '2025-11-04 02:16:31.120238 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (35, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/377a528e-dccf-450a-ac16-88fcc62994ad_8월_4.png', '2025-11-04 02:16:31.298150 +00:00', '2025-11-04 02:16:31.298150 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (42, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/839b20ba-59a5-4e36-b592-411401915194_KakaoTalk_20251104_112333077_03.png', '2025-11-04 02:25:44.933354 +00:00', '2025-11-04 02:25:44.933354 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (42, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/d148e902-eb7e-4a9f-af73-34fedb742ee7_KakaoTalk_20251104_112333077_01.png', '2025-11-04 02:25:36.436473 +00:00', '2025-11-04 02:25:36.436473 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES (42, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/699d31eb-80a0-49e1-a470-6c636aa488ad_KakaoTalk_20251104_112333077_02.png', '2025-11-04 02:25:40.859732 +00:00', '2025-11-04 02:25:40.859732 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 42, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/64bad570-2619-48e2-b0f5-37c475028054_KakaoTalk_20251104_112333077_04.png', '2025-11-04 02:25:49.135875 +00:00', '2025-11-04 02:25:49.135875 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 43, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/d7c85c03-01ce-450a-810b-16bcdc17b481_KakaoTalk_20251104_112333077_05.png', '2025-11-04 02:26:55.757792 +00:00', '2025-11-04 02:26:55.757792 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 44, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/8ced2a90-1a18-41eb-86e0-c6c1e24e5315_KakaoTalk_20251104_112333077_10.png', '2025-11-04 02:27:46.602003 +00:00', '2025-11-04 02:27:46.602003 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 44, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/698c66e3-867c-4972-9770-64d738af2771_KakaoTalk_20251104_112333077_08.png', '2025-11-04 02:27:44.341645 +00:00', '2025-11-04 02:27:44.341645 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 44, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/f5b9dc43-25d4-4ac0-97ea-7c0ae8b5f2ac_KakaoTalk_20251104_112333077_09.png', '2025-11-04 02:27:45.080387 +00:00', '2025-11-04 02:27:45.080387 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 45, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/68102fda-7a50-4d7f-aa82-66e45a837088_KakaoTalk_20251104_112333077_13.png', '2025-11-04 02:28:36.465239 +00:00', '2025-11-04 02:28:36.465239 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 45, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/717c7144-2a4d-4d0e-a2ce-cb0e8269e77d_KakaoTalk_20251104_112333077_12.png', '2025-11-04 02:28:34.638355 +00:00', '2025-11-04 02:28:34.638355 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 46, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/7043b346-9b70-46d6-a82c-34fbf9c6ea31_KakaoTalk_20251104_112333077_15.png', '2025-11-04 02:29:15.358886 +00:00', '2025-11-04 02:29:15.358886 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 47, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/267e7398-9cef-483f-a887-bb563c95585c_KakaoTalk_20251104_112333077_21.png', '2025-11-04 02:29:59.207748 +00:00', '2025-11-04 02:29:59.207748 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 47, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/b9ca119a-9333-4ca7-aa59-d666f1f62458_KakaoTalk_20251104_112333077_20.png', '2025-11-04 02:29:58.235982 +00:00', '2025-11-04 02:29:58.235982 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 49, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/0e1c9f68-dda2-4ea5-9a7d-af5b0438a93a_KakaoTalk_20251104_112333077_22.png', '2025-11-04 02:31:08.289590 +00:00', '2025-11-04 02:31:08.289590 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 51, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/192fdef7-099f-4b8d-a2c3-79c2a3c98346_KakaoTalk_20251104_112333077_17.png', '2025-11-04 02:31:57.079376 +00:00', '2025-11-04 02:31:57.079376 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 52, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/1ca11658-9425-4f14-85bb-2fb556416e05_KakaoTalk_20251104_113325912_05.png', '2025-11-04 02:35:59.392617 +00:00', '2025-11-04 02:35:59.392617 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 53, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/409a9198-595b-4dde-a8d7-960c31079f31_KakaoTalk_20251104_113325912_06.png', '2025-11-04 02:36:30.628121 +00:00', '2025-11-04 02:36:30.628121 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 60, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/df31cbc2-fcdf-44d8-95a6-f172f73638fd_KakaoTalk_20251104_113325912.png', '2025-11-04 02:43:31.320010 +00:00', '2025-11-04 02:43:31.320010 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 63, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/47c95b96-269a-40ac-812c-8b05fd270398_KakaoTalk_20251104_114145300_02.jpg', '2025-11-04 02:46:23.411060 +00:00', '2025-11-04 02:46:23.411060 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 63, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/2a10dcdb-b414-42a1-a6bb-b1e942de341d_KakaoTalk_20251104_114145300_01.jpg', '2025-11-04 02:46:19.391420 +00:00', '2025-11-04 02:46:19.391420 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 63, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/15dda437-5678-4d9e-a6ed-160e6ab7b531_KakaoTalk_20251104_114145300_03.jpg', '2025-11-04 02:46:21.401800 +00:00', '2025-11-04 02:46:21.401800 +00:00');
INSERT INTO public.recycling_images ( recycling_id, image_url, created_at, updated_at) VALUES ( 64, 'https://rezero-bucket.s3.ap-northeast-2.amazonaws.com/recycling/25b6f6b9-f425-4b82-9d0e-9491f842cd5e_KakaoTalk_20251104_114145300_05.jpg', '2025-11-04 02:46:49.447652 +00:00', '2025-11-04 02:46:49.447652 +00:00');

-- 게시글 1번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (1, 22, '2025-10-30 15:55:00'),
                                                                  (1, 37, '2025-11-01 09:40:00'),
                                                                  (1, 39, '2025-10-16 15:15:00'),
                                                                  (1, 49, '2025-10-17 06:35:00'),
                                                                  (1, 24, '2025-10-18 10:56:00'),
                                                                  (1, 46, '2025-11-03 11:58:00'),
                                                                  (1, 44, '2025-10-14 16:32:00'),
                                                                  (1, 14, '2025-10-17 03:05:00'),
                                                                  (1, 2, '2025-10-23 13:15:00'),
                                                                  (1, 34, '2025-10-11 19:39:00'),
                                                                  (1, 42, '2025-10-10 07:06:00'),
                                                                  (1, 33, '2025-10-13 08:47:00'),
                                                                  (1, 47, '2025-10-23 00:01:00'),
                                                                  (1, 1, '2025-10-15 00:27:00'),
                                                                  (1, 6, '2025-10-19 14:47:00'),
                                                                  (1, 38, '2025-10-23 14:54:00'),
                                                                  (1, 11, '2025-10-21 08:27:00'),
                                                                  (1, 20, '2025-11-01 17:57:00'),
                                                                  (1, 17, '2025-10-23 22:33:00'),
                                                                  (1, 19, '2025-10-15 07:05:00'),
                                                                  (1, 15, '2025-10-26 12:15:00'),
                                                                  (1, 30, '2025-10-23 02:44:00'),
                                                                  (1, 28, '2025-10-19 23:03:00'),
                                                                  (1, 36, '2025-10-09 17:04:00'),
                                                                  (1, 27, '2025-11-03 23:06:00'),
                                                                  (1, 10, '2025-11-01 17:22:00'),
                                                                  (1, 5, '2025-10-05 22:43:00'),
                                                                  (1, 7, '2025-10-29 02:48:00'),
                                                                  (1, 8, '2025-10-06 14:11:00'),
                                                                  (1, 3, '2025-10-17 15:11:00'),
                                                                  (1, 16, '2025-10-18 03:47:00'),
                                                                  (1, 26, '2025-10-30 00:20:00'),
                                                                  (1, 40, '2025-10-25 14:57:00'),
                                                                  (1, 32, '2025-10-26 12:32:00'),
                                                                  (1, 31, '2025-10-19 02:14:00'),
                                                                  (1, 9, '2025-10-16 06:09:00'),
                                                                  (1, 21, '2025-10-30 10:44:00'),
                                                                  (1, 35, '2025-10-11 09:02:00'),
                                                                  (1, 43, '2025-10-08 16:07:00'),
                                                                  (1, 23, '2025-10-22 07:05:00'),
                                                                  (1, 25, '2025-10-27 19:39:00');

-- 게시글 2번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (2, 34, '2025-10-23 14:59:00'),
                                                                  (2, 43, '2025-10-29 18:48:00'),
                                                                  (2, 15, '2025-10-20 15:49:00'),
                                                                  (2, 3, '2025-10-16 08:17:00'),
                                                                  (2, 23, '2025-10-19 06:26:00'),
                                                                  (2, 16, '2025-10-19 23:57:00'),
                                                                  (2, 19, '2025-10-28 16:56:00'),
                                                                  (2, 49, '2025-10-07 00:09:00'),
                                                                  (2, 1, '2025-10-30 12:29:00'),
                                                                  (2, 8, '2025-10-12 14:44:00'),
                                                                  (2, 18, '2025-10-05 01:28:00');

-- 게시글 3번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (3, 30, '2025-11-03 17:39:00'),
                                                                  (3, 27, '2025-10-09 15:22:00'),
                                                                  (3, 13, '2025-10-22 20:33:00'),
                                                                  (3, 12, '2025-10-05 09:05:00'),
                                                                  (3, 5, '2025-10-08 21:25:00'),
                                                                  (3, 17, '2025-10-11 19:23:00'),
                                                                  (3, 16, '2025-10-23 05:17:00'),
                                                                  (3, 9, '2025-11-03 08:22:00'),
                                                                  (3, 14, '2025-11-03 21:13:00'),
                                                                  (3, 43, '2025-10-10 11:40:00'),
                                                                  (3, 49, '2025-10-14 08:03:00'),
                                                                  (3, 7, '2025-10-18 13:16:00'),
                                                                  (3, 2, '2025-10-22 09:17:00'),
                                                                  (3, 26, '2025-10-08 01:42:00'),
                                                                  (3, 1, '2025-10-26 10:10:00'),
                                                                  (3, 31, '2025-10-12 12:54:00'),
                                                                  (3, 40, '2025-10-30 20:27:00'),
                                                                  (3, 3, '2025-10-05 16:34:00'),
                                                                  (3, 50, '2025-10-13 19:57:00'),
                                                                  (3, 15, '2025-10-05 20:57:00'),
                                                                  (3, 48, '2025-10-30 04:14:00'),
                                                                  (3, 46, '2025-11-01 01:17:00'),
                                                                  (3, 28, '2025-10-08 01:00:00'),
                                                                  (3, 11, '2025-10-29 09:44:00'),
                                                                  (3, 25, '2025-10-26 13:59:00'),
                                                                  (3, 42, '2025-10-21 09:48:00'),
                                                                  (3, 47, '2025-10-30 12:16:00'),
                                                                  (3, 44, '2025-10-20 06:13:00'),
                                                                  (3, 20, '2025-10-15 17:37:00'),
                                                                  (3, 10, '2025-10-23 13:14:00'),
                                                                  (3, 33, '2025-10-15 06:12:00'),
                                                                  (3, 34, '2025-10-24 13:04:00'),
                                                                  (3, 8, '2025-10-12 23:04:00'),
                                                                  (3, 29, '2025-10-22 04:27:00'),
                                                                  (3, 6, '2025-10-10 11:32:00');

-- 게시글 4번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (4, 12, '2025-10-13 15:41:00'),
                                                                  (4, 30, '2025-10-13 17:35:00'),
                                                                  (4, 27, '2025-10-15 03:26:00'),
                                                                  (4, 36, '2025-10-09 01:50:00'),
                                                                  (4, 10, '2025-10-14 23:08:00'),
                                                                  (4, 24, '2025-11-03 19:27:00'),
                                                                  (4, 49, '2025-10-20 15:35:00'),
                                                                  (4, 34, '2025-10-09 19:12:00'),
                                                                  (4, 37, '2025-10-06 10:45:00'),
                                                                  (4, 6, '2025-10-27 15:11:00'),
                                                                  (4, 43, '2025-10-21 21:16:00'),
                                                                  (4, 4, '2025-10-15 01:13:00'),
                                                                  (4, 8, '2025-10-31 02:41:00'),
                                                                  (4, 44, '2025-10-19 10:53:00'),
                                                                  (4, 13, '2025-10-19 22:11:00'),
                                                                  (4, 48, '2025-10-15 02:10:00'),
                                                                  (4, 2, '2025-10-19 04:59:00'),
                                                                  (4, 40, '2025-10-25 09:15:00'),
                                                                  (4, 33, '2025-11-03 15:41:00'),
                                                                  (4, 32, '2025-10-06 04:25:00'),
                                                                  (4, 28, '2025-10-10 17:59:00'),
                                                                  (4, 9, '2025-10-05 05:12:00'),
                                                                  (4, 3, '2025-11-01 17:28:00'),
                                                                  (4, 14, '2025-10-09 13:32:00');

-- 게시글 5번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (5, 5, '2025-10-20 19:28:00'),
                                                                  (5, 42, '2025-10-15 22:09:00'),
                                                                  (5, 15, '2025-11-01 16:59:00'),
                                                                  (5, 41, '2025-10-09 08:22:00'),
                                                                  (5, 10, '2025-10-10 12:06:00'),
                                                                  (5, 14, '2025-10-30 05:04:00');

-- 게시글 6번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (6, 30, '2025-10-24 12:53:00'),
                                                                  (6, 22, '2025-11-03 13:19:00'),
                                                                  (6, 34, '2025-10-13 10:58:00'),
                                                                  (6, 2, '2025-10-09 08:46:00'),
                                                                  (6, 41, '2025-10-05 20:01:00'),
                                                                  (6, 37, '2025-10-15 09:15:00'),
                                                                  (6, 32, '2025-11-01 10:49:00'),
                                                                  (6, 13, '2025-11-02 11:05:00'),
                                                                  (6, 15, '2025-10-19 20:53:00'),
                                                                  (6, 47, '2025-10-17 05:37:00'),
                                                                  (6, 19, '2025-10-11 07:03:00'),
                                                                  (6, 23, '2025-10-06 01:29:00'),
                                                                  (6, 29, '2025-10-20 14:34:00'),
                                                                  (6, 28, '2025-10-25 16:34:00'),
                                                                  (6, 49, '2025-10-10 20:05:00'),
                                                                  (6, 17, '2025-10-26 01:57:00'),
                                                                  (6, 38, '2025-10-29 17:46:00'),
                                                                  (6, 36, '2025-10-18 09:04:00'),
                                                                  (6, 40, '2025-10-11 14:43:00'),
                                                                  (6, 6, '2025-10-16 23:02:00'),
                                                                  (6, 43, '2025-11-03 13:27:00'),
                                                                  (6, 18, '2025-10-13 19:53:00'),
                                                                  (6, 26, '2025-10-22 18:38:00'),
                                                                  (6, 25, '2025-10-10 10:03:00'),
                                                                  (6, 20, '2025-11-02 21:58:00'),
                                                                  (6, 31, '2025-10-19 08:35:00'),
                                                                  (6, 7, '2025-10-13 22:55:00'),
                                                                  (6, 24, '2025-10-22 09:39:00'),
                                                                  (6, 45, '2025-10-21 02:09:00'),
                                                                  (6, 33, '2025-10-31 05:03:00'),
                                                                  (6, 8, '2025-10-14 08:02:00'),
                                                                  (6, 39, '2025-10-10 23:26:00'),
                                                                  (6, 5, '2025-10-24 16:58:00'),
                                                                  (6, 11, '2025-10-12 19:42:00'),
                                                                  (6, 42, '2025-10-24 12:33:00'),
                                                                  (6, 27, '2025-10-27 23:03:00'),
                                                                  (6, 44, '2025-10-08 14:59:00');

-- 게시글 7번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (7, 45, '2025-10-06 09:47:00'),
                                                                  (7, 15, '2025-10-17 18:46:00'),
                                                                  (7, 9, '2025-10-06 15:40:00'),
                                                                  (7, 38, '2025-10-05 11:42:00'),
                                                                  (7, 1, '2025-10-21 16:16:00'),
                                                                  (7, 25, '2025-10-26 16:41:00'),
                                                                  (7, 5, '2025-10-09 14:49:00');

-- 게시글 8번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (8, 10, '2025-10-04 07:24:00'),
                                                                  (8, 41, '2025-10-23 08:16:00'),
                                                                  (8, 33, '2025-10-25 17:06:00'),
                                                                  (8, 43, '2025-11-03 17:43:00'),
                                                                  (8, 20, '2025-10-12 10:34:00'),
                                                                  (8, 4, '2025-10-18 22:24:00'),
                                                                  (8, 46, '2025-10-22 09:33:00'),
                                                                  (8, 19, '2025-10-06 16:15:00'),
                                                                  (8, 50, '2025-11-02 20:12:00'),
                                                                  (8, 29, '2025-10-07 18:46:00'),
                                                                  (8, 38, '2025-10-30 23:54:00'),
                                                                  (8, 22, '2025-10-13 07:59:00'),
                                                                  (8, 12, '2025-10-22 07:07:00'),
                                                                  (8, 24, '2025-10-21 20:12:00'),
                                                                  (8, 40, '2025-10-08 19:22:00'),
                                                                  (8, 39, '2025-10-22 00:53:00'),
                                                                  (8, 23, '2025-10-29 19:26:00'),
                                                                  (8, 18, '2025-11-01 21:24:00'),
                                                                  (8, 9, '2025-10-30 01:06:00'),
                                                                  (8, 14, '2025-10-25 00:58:00'),
                                                                  (8, 28, '2025-10-28 13:52:00'),
                                                                  (8, 35, '2025-11-02 00:43:00');

-- 게시글 9번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (9, 41, '2025-11-03 01:33:00'),
                                                                  (9, 37, '2025-10-29 17:51:00'),
                                                                  (9, 36, '2025-10-09 09:59:00'),
                                                                  (9, 11, '2025-10-22 16:29:00'),
                                                                  (9, 6, '2025-10-20 19:18:00'),
                                                                  (9, 31, '2025-10-27 03:49:00'),
                                                                  (9, 49, '2025-10-10 11:44:00'),
                                                                  (9, 3, '2025-10-15 19:56:00'),
                                                                  (9, 38, '2025-10-21 09:17:00'),
                                                                  (9, 2, '2025-10-14 18:23:00'),
                                                                  (9, 18, '2025-10-14 23:29:00'),
                                                                  (9, 26, '2025-10-19 04:50:00'),
                                                                  (9, 12, '2025-10-26 23:54:00'),
                                                                  (9, 13, '2025-10-23 16:43:00'),
                                                                  (9, 48, '2025-10-22 13:36:00'),
                                                                  (9, 8, '2025-10-25 03:13:00'),
                                                                  (9, 1, '2025-10-24 13:45:00'),
                                                                  (9, 15, '2025-11-02 16:44:00'),
                                                                  (9, 19, '2025-10-15 13:20:00'),
                                                                  (9, 30, '2025-10-24 10:34:00'),
                                                                  (9, 34, '2025-10-28 23:29:00'),
                                                                  (9, 33, '2025-11-03 07:38:00'),
                                                                  (9, 44, '2025-11-02 05:00:00'),
                                                                  (9, 14, '2025-10-23 02:20:00'),
                                                                  (9, 25, '2025-10-13 03:48:00'),
                                                                  (9, 29, '2025-10-09 18:17:00'),
                                                                  (9, 40, '2025-10-10 21:52:00'),
                                                                  (9, 45, '2025-11-02 14:19:00'),
                                                                  (9, 16, '2025-10-31 04:24:00'),
                                                                  (9, 20, '2025-10-10 14:06:00'),
                                                                  (9, 42, '2025-10-08 00:00:00'),
                                                                  (9, 43, '2025-10-20 03:25:00'),
                                                                  (9, 35, '2025-10-06 09:40:00'),
                                                                  (9, 10, '2025-10-26 00:19:00'),
                                                                  (9, 21, '2025-10-18 20:58:00'),
                                                                  (9, 9, '2025-10-23 14:34:00'),
                                                                  (9, 32, '2025-10-18 10:11:00'),
                                                                  (9, 17, '2025-11-02 17:14:00'),
                                                                  (9, 23, '2025-10-04 06:29:00'),
                                                                  (9, 50, '2025-10-18 15:43:00'),
                                                                  (9, 4, '2025-10-22 02:22:00'),
                                                                  (9, 22, '2025-10-07 03:07:00'),
                                                                  (9, 28, '2025-10-26 04:04:00'),
                                                                  (9, 7, '2025-10-23 18:58:00'),
                                                                  (9, 5, '2025-10-06 01:04:00'),
                                                                  (9, 24, '2025-11-01 21:59:00');

-- 게시글 10번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (10, 39, '2025-10-12 15:25:00'),
                                                                  (10, 3, '2025-10-11 13:11:00'),
                                                                  (10, 7, '2025-10-25 23:35:00'),
                                                                  (10, 18, '2025-10-21 02:29:00'),
                                                                  (10, 23, '2025-10-04 11:00:00'),
                                                                  (10, 42, '2025-10-28 13:56:00'),
                                                                  (10, 32, '2025-10-16 00:32:00'),
                                                                  (10, 46, '2025-10-21 05:06:00'),
                                                                  (10, 6, '2025-10-22 04:24:00'),
                                                                  (10, 30, '2025-10-15 09:27:00'),
                                                                  (10, 25, '2025-10-28 12:27:00'),
                                                                  (10, 31, '2025-10-11 02:55:00'),
                                                                  (10, 13, '2025-10-07 23:32:00'),
                                                                  (10, 4, '2025-10-25 05:34:00'),
                                                                  (10, 49, '2025-10-26 09:48:00'),
                                                                  (10, 11, '2025-11-02 13:51:00'),
                                                                  (10, 34, '2025-10-06 00:07:00'),
                                                                  (10, 26, '2025-10-08 19:38:00'),
                                                                  (10, 9, '2025-11-03 02:52:00'),
                                                                  (10, 43, '2025-10-19 04:06:00'),
                                                                  (10, 8, '2025-10-23 05:46:00'),
                                                                  (10, 2, '2025-10-23 12:26:00'),
                                                                  (10, 36, '2025-10-22 12:48:00'),
                                                                  (10, 35, '2025-10-21 14:49:00'),
                                                                  (10, 12, '2025-10-11 06:05:00'),
                                                                  (10, 41, '2025-10-28 12:31:00'),
                                                                  (10, 38, '2025-10-25 14:39:00'),
                                                                  (10, 24, '2025-10-06 13:52:00'),
                                                                  (10, 45, '2025-10-25 16:29:00'),
                                                                  (10, 5, '2025-10-15 11:36:00'),
                                                                  (10, 22, '2025-10-18 22:50:00'),
                                                                  (10, 21, '2025-10-30 03:48:00'),
                                                                  (10, 17, '2025-10-10 22:19:00'),
                                                                  (10, 27, '2025-11-03 14:25:00'),
                                                                  (10, 15, '2025-10-22 10:57:00'),
                                                                  (10, 37, '2025-10-26 03:18:00'),
                                                                  (10, 1, '2025-10-16 23:16:00'),
                                                                  (10, 10, '2025-10-26 10:57:00');

-- 게시글 11번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (11, 3, '2025-10-15 11:51:00'),
                                                                  (11, 25, '2025-10-19 18:57:00'),
                                                                  (11, 35, '2025-11-01 11:40:00'),
                                                                  (11, 36, '2025-10-13 13:39:00'),
                                                                  (11, 28, '2025-10-13 18:23:00'),
                                                                  (11, 13, '2025-10-25 00:58:00'),
                                                                  (11, 30, '2025-10-15 10:29:00'),
                                                                  (11, 26, '2025-10-08 13:16:00'),
                                                                  (11, 49, '2025-10-08 04:55:00'),
                                                                  (11, 38, '2025-10-07 18:35:00'),
                                                                  (11, 16, '2025-10-16 06:04:00'),
                                                                  (11, 34, '2025-10-15 10:14:00'),
                                                                  (11, 20, '2025-10-21 03:22:00'),
                                                                  (11, 9, '2025-10-20 04:47:00'),
                                                                  (11, 15, '2025-10-18 18:15:00'),
                                                                  (11, 40, '2025-10-08 10:53:00'),
                                                                  (11, 27, '2025-11-01 07:29:00'),
                                                                  (11, 45, '2025-10-29 17:05:00'),
                                                                  (11, 24, '2025-10-24 01:23:00'),
                                                                  (11, 14, '2025-10-19 07:38:00'),
                                                                  (11, 33, '2025-10-11 00:56:00'),
                                                                  (11, 37, '2025-10-19 01:48:00'),
                                                                  (11, 44, '2025-10-04 10:44:00'),
                                                                  (11, 1, '2025-10-24 08:28:00'),
                                                                  (11, 10, '2025-10-07 05:33:00'),
                                                                  (11, 31, '2025-10-24 06:17:00'),
                                                                  (11, 48, '2025-10-28 03:52:00'),
                                                                  (11, 2, '2025-10-18 16:43:00'),
                                                                  (11, 41, '2025-10-16 18:54:00'),
                                                                  (11, 50, '2025-10-10 23:19:00'),
                                                                  (11, 29, '2025-10-29 09:22:00'),
                                                                  (11, 5, '2025-10-17 04:22:00'),
                                                                  (11, 6, '2025-10-23 09:07:00'),
                                                                  (11, 18, '2025-10-05 04:08:00'),
                                                                  (11, 22, '2025-10-27 15:06:00'),
                                                                  (11, 4, '2025-10-15 20:27:00'),
                                                                  (11, 8, '2025-10-26 10:28:00'),
                                                                  (11, 39, '2025-10-21 19:20:00'),
                                                                  (11, 21, '2025-10-12 17:31:00'),
                                                                  (11, 47, '2025-10-22 16:33:00'),
                                                                  (11, 7, '2025-10-29 20:39:00'),
                                                                  (11, 12, '2025-10-05 22:08:00'),
                                                                  (11, 43, '2025-10-29 16:30:00');

-- 게시글 12번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (12, 2, '2025-10-28 07:25:00'),
                                                                  (12, 12, '2025-10-10 09:41:00'),
                                                                  (12, 30, '2025-10-24 18:35:00'),
                                                                  (12, 41, '2025-10-07 01:49:00'),
                                                                  (12, 23, '2025-10-17 05:01:00'),
                                                                  (12, 44, '2025-10-05 04:10:00'),
                                                                  (12, 39, '2025-10-26 10:51:00'),
                                                                  (12, 42, '2025-10-11 03:02:00'),
                                                                  (12, 34, '2025-10-15 23:40:00'),
                                                                  (12, 6, '2025-10-10 01:05:00'),
                                                                  (12, 27, '2025-11-03 14:48:00'),
                                                                  (12, 20, '2025-10-08 07:53:00'),
                                                                  (12, 35, '2025-10-19 14:43:00'),
                                                                  (12, 37, '2025-10-06 20:14:00'),
                                                                  (12, 49, '2025-10-09 16:29:00'),
                                                                  (12, 18, '2025-10-07 02:04:00'),
                                                                  (12, 26, '2025-10-25 23:33:00'),
                                                                  (12, 22, '2025-10-10 10:17:00'),
                                                                  (12, 24, '2025-10-23 03:01:00'),
                                                                  (12, 1, '2025-10-21 01:19:00'),
                                                                  (12, 40, '2025-10-16 03:39:00'),
                                                                  (12, 5, '2025-11-02 19:08:00'),
                                                                  (12, 16, '2025-11-02 06:25:00'),
                                                                  (12, 4, '2025-10-28 01:12:00'),
                                                                  (12, 36, '2025-10-27 08:39:00'),
                                                                  (12, 43, '2025-10-18 21:18:00'),
                                                                  (12, 50, '2025-10-17 09:39:00'),
                                                                  (12, 11, '2025-10-10 01:11:00'),
                                                                  (12, 28, '2025-10-04 15:57:00'),
                                                                  (12, 17, '2025-10-04 04:53:00'),
                                                                  (12, 48, '2025-10-15 06:10:00'),
                                                                  (12, 33, '2025-10-15 20:40:00'),
                                                                  (12, 19, '2025-10-30 23:45:00'),
                                                                  (12, 29, '2025-10-09 15:33:00'),
                                                                  (12, 7, '2025-10-16 22:21:00'),
                                                                  (12, 38, '2025-10-07 09:58:00'),
                                                                  (12, 14, '2025-10-26 06:59:00');

-- 게시글 13번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (13, 37, '2025-11-02 01:31:00'),
                                                                  (13, 13, '2025-10-16 11:22:00'),
                                                                  (13, 38, '2025-10-30 11:55:00'),
                                                                  (13, 47, '2025-10-17 23:33:00'),
                                                                  (13, 42, '2025-10-16 09:47:00'),
                                                                  (13, 30, '2025-10-26 20:21:00'),
                                                                  (13, 7, '2025-10-30 02:03:00'),
                                                                  (13, 29, '2025-10-25 06:07:00'),
                                                                  (13, 39, '2025-10-18 11:17:00'),
                                                                  (13, 20, '2025-11-01 17:37:00'),
                                                                  (13, 25, '2025-10-11 08:47:00'),
                                                                  (13, 46, '2025-10-08 03:39:00'),
                                                                  (13, 19, '2025-10-31 20:49:00'),
                                                                  (13, 40, '2025-10-28 19:41:00'),
                                                                  (13, 33, '2025-10-21 18:31:00'),
                                                                  (13, 50, '2025-10-14 08:06:00'),
                                                                  (13, 14, '2025-10-15 19:24:00'),
                                                                  (13, 1, '2025-10-16 23:17:00'),
                                                                  (13, 2, '2025-10-05 09:14:00'),
                                                                  (13, 41, '2025-10-20 04:10:00'),
                                                                  (13, 17, '2025-10-19 08:25:00'),
                                                                  (13, 8, '2025-10-12 02:27:00');

-- 게시글 14번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (14, 5, '2025-11-03 03:07:00'),
                                                                  (14, 29, '2025-10-28 04:52:00'),
                                                                  (14, 27, '2025-10-07 22:47:00'),
                                                                  (14, 13, '2025-10-05 01:41:00'),
                                                                  (14, 38, '2025-10-05 21:17:00'),
                                                                  (14, 24, '2025-10-20 00:14:00'),
                                                                  (14, 47, '2025-10-18 06:59:00'),
                                                                  (14, 42, '2025-10-26 04:24:00'),
                                                                  (14, 31, '2025-10-28 14:56:00'),
                                                                  (14, 40, '2025-11-03 22:36:00'),
                                                                  (14, 21, '2025-11-01 06:27:00'),
                                                                  (14, 50, '2025-10-13 04:13:00'),
                                                                  (14, 8, '2025-10-20 19:56:00'),
                                                                  (14, 6, '2025-10-04 15:11:00'),
                                                                  (14, 44, '2025-10-08 12:18:00'),
                                                                  (14, 1, '2025-10-20 12:28:00'),
                                                                  (14, 32, '2025-11-03 09:25:00'),
                                                                  (14, 7, '2025-10-26 16:42:00'),
                                                                  (14, 17, '2025-10-27 20:50:00'),
                                                                  (14, 3, '2025-11-03 09:24:00'),
                                                                  (14, 34, '2025-10-28 14:46:00'),
                                                                  (14, 36, '2025-10-10 15:15:00'),
                                                                  (14, 2, '2025-11-01 02:35:00'),
                                                                  (14, 30, '2025-10-08 16:54:00'),
                                                                  (14, 23, '2025-10-07 10:08:00'),
                                                                  (14, 49, '2025-11-01 11:24:00'),
                                                                  (14, 22, '2025-10-09 00:57:00'),
                                                                  (14, 33, '2025-10-28 21:53:00'),
                                                                  (14, 37, '2025-10-27 16:21:00'),
                                                                  (14, 15, '2025-10-26 02:28:00'),
                                                                  (14, 11, '2025-10-20 23:57:00'),
                                                                  (14, 12, '2025-10-06 18:53:00'),
                                                                  (14, 28, '2025-10-19 05:59:00'),
                                                                  (14, 43, '2025-10-12 16:37:00'),
                                                                  (14, 26, '2025-10-12 07:37:00'),
                                                                  (14, 25, '2025-10-17 15:35:00'),
                                                                  (14, 16, '2025-10-06 06:50:00'),
                                                                  (14, 45, '2025-10-20 09:07:00'),
                                                                  (14, 20, '2025-10-23 19:41:00'),
                                                                  (14, 48, '2025-10-10 21:37:00'),
                                                                  (14, 39, '2025-10-15 05:35:00'),
                                                                  (14, 14, '2025-10-12 13:04:00'),
                                                                  (14, 4, '2025-10-06 06:42:00'),
                                                                  (14, 41, '2025-10-11 19:37:00'),
                                                                  (14, 9, '2025-10-16 23:49:00'),
                                                                  (14, 35, '2025-11-01 18:13:00'),
                                                                  (14, 19, '2025-10-19 04:46:00');

-- 게시글 15번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (15, 23, '2025-10-14 16:30:00'),
                                                                  (15, 4, '2025-10-05 20:13:00'),
                                                                  (15, 29, '2025-10-05 15:46:00'),
                                                                  (15, 19, '2025-10-09 11:21:00'),
                                                                  (15, 32, '2025-10-17 18:52:00'),
                                                                  (15, 26, '2025-10-24 14:14:00'),
                                                                  (15, 18, '2025-10-18 03:59:00'),
                                                                  (15, 34, '2025-10-18 09:01:00');

-- 게시글 16번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (16, 41, '2025-10-09 14:44:00'),
                                                                  (16, 50, '2025-10-09 01:45:00'),
                                                                  (16, 34, '2025-10-24 03:44:00'),
                                                                  (16, 2, '2025-10-14 13:47:00'),
                                                                  (16, 4, '2025-11-03 01:49:00'),
                                                                  (16, 10, '2025-10-11 16:19:00'),
                                                                  (16, 31, '2025-10-21 16:52:00'),
                                                                  (16, 47, '2025-10-08 18:14:00'),
                                                                  (16, 15, '2025-10-15 03:58:00'),
                                                                  (16, 24, '2025-10-12 22:06:00'),
                                                                  (16, 27, '2025-10-28 06:48:00'),
                                                                  (16, 21, '2025-10-15 01:23:00'),
                                                                  (16, 9, '2025-10-15 08:34:00'),
                                                                  (16, 49, '2025-11-01 20:34:00'),
                                                                  (16, 37, '2025-11-02 18:50:00'),
                                                                  (16, 6, '2025-10-22 11:31:00'),
                                                                  (16, 18, '2025-10-06 08:28:00'),
                                                                  (16, 44, '2025-11-03 08:27:00'),
                                                                  (16, 48, '2025-10-19 05:26:00'),
                                                                  (16, 28, '2025-10-11 16:59:00'),
                                                                  (16, 26, '2025-10-07 14:45:00'),
                                                                  (16, 35, '2025-10-11 11:13:00'),
                                                                  (16, 19, '2025-11-03 10:44:00'),
                                                                  (16, 39, '2025-10-11 02:47:00');

-- 게시글 17번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (17, 34, '2025-10-13 10:27:00'),
                                                                  (17, 43, '2025-11-02 10:11:00'),
                                                                  (17, 18, '2025-10-12 10:45:00'),
                                                                  (17, 21, '2025-10-18 09:46:00'),
                                                                  (17, 13, '2025-10-20 01:06:00'),
                                                                  (17, 16, '2025-10-20 11:26:00'),
                                                                  (17, 32, '2025-10-05 22:00:00');

-- 게시글 18번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (18, 32, '2025-10-20 08:21:00'),
                                                                  (18, 1, '2025-11-02 11:43:00'),
                                                                  (18, 37, '2025-11-03 20:12:00'),
                                                                  (18, 26, '2025-10-11 04:21:00'),
                                                                  (18, 41, '2025-10-15 21:52:00'),
                                                                  (18, 12, '2025-10-10 15:16:00'),
                                                                  (18, 45, '2025-10-23 16:13:00'),
                                                                  (18, 43, '2025-10-29 12:59:00'),
                                                                  (18, 18, '2025-10-11 15:46:00'),
                                                                  (18, 2, '2025-10-30 11:49:00'),
                                                                  (18, 34, '2025-10-23 09:53:00'),
                                                                  (18, 6, '2025-10-10 03:38:00'),
                                                                  (18, 5, '2025-10-24 20:26:00'),
                                                                  (18, 42, '2025-10-31 21:15:00'),
                                                                  (18, 35, '2025-10-31 05:19:00'),
                                                                  (18, 25, '2025-10-27 21:55:00'),
                                                                  (18, 19, '2025-10-20 18:24:00'),
                                                                  (18, 14, '2025-10-17 12:34:00'),
                                                                  (18, 46, '2025-10-22 03:33:00'),
                                                                  (18, 40, '2025-10-19 02:48:00'),
                                                                  (18, 3, '2025-10-07 17:11:00'),
                                                                  (18, 7, '2025-10-17 11:16:00'),
                                                                  (18, 21, '2025-10-08 00:00:00'),
                                                                  (18, 13, '2025-10-23 16:20:00'),
                                                                  (18, 17, '2025-10-09 19:47:00'),
                                                                  (18, 38, '2025-10-15 15:19:00'),
                                                                  (18, 20, '2025-10-22 20:01:00'),
                                                                  (18, 4, '2025-10-30 16:29:00'),
                                                                  (18, 31, '2025-10-06 10:24:00'),
                                                                  (18, 33, '2025-10-11 01:40:00'),
                                                                  (18, 27, '2025-10-26 12:43:00'),
                                                                  (18, 16, '2025-10-08 12:42:00'),
                                                                  (18, 36, '2025-10-24 09:47:00'),
                                                                  (18, 29, '2025-10-11 05:05:00'),
                                                                  (18, 50, '2025-10-26 17:40:00'),
                                                                  (18, 44, '2025-10-11 12:30:00'),
                                                                  (18, 8, '2025-10-06 03:49:00'),
                                                                  (18, 22, '2025-10-07 05:25:00'),
                                                                  (18, 10, '2025-11-02 17:22:00'),
                                                                  (18, 39, '2025-10-21 10:56:00'),
                                                                  (18, 23, '2025-10-22 22:31:00'),
                                                                  (18, 24, '2025-10-28 21:17:00');

-- 게시글 19번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (19, 25, '2025-10-18 09:29:00'),
                                                                  (19, 10, '2025-10-08 01:33:00'),
                                                                  (19, 3, '2025-10-07 12:44:00'),
                                                                  (19, 36, '2025-10-21 08:48:00'),
                                                                  (19, 1, '2025-10-28 15:39:00'),
                                                                  (19, 14, '2025-10-05 20:13:00'),
                                                                  (19, 38, '2025-10-20 01:16:00'),
                                                                  (19, 9, '2025-10-07 12:41:00'),
                                                                  (19, 6, '2025-10-06 14:02:00'),
                                                                  (19, 20, '2025-10-06 22:44:00'),
                                                                  (19, 41, '2025-10-08 15:41:00'),
                                                                  (19, 40, '2025-10-29 16:09:00'),
                                                                  (19, 33, '2025-10-22 08:27:00'),
                                                                  (19, 8, '2025-10-26 04:05:00'),
                                                                  (19, 27, '2025-10-17 10:23:00'),
                                                                  (19, 15, '2025-10-04 20:02:00'),
                                                                  (19, 47, '2025-10-21 15:46:00'),
                                                                  (19, 44, '2025-11-01 16:14:00'),
                                                                  (19, 43, '2025-10-21 18:58:00'),
                                                                  (19, 11, '2025-11-03 12:27:00'),
                                                                  (19, 46, '2025-10-30 11:13:00'),
                                                                  (19, 30, '2025-10-05 10:41:00'),
                                                                  (19, 37, '2025-10-13 15:16:00'),
                                                                  (19, 34, '2025-10-21 08:11:00'),
                                                                  (19, 22, '2025-10-24 09:47:00'),
                                                                  (19, 31, '2025-10-27 04:45:00'),
                                                                  (19, 42, '2025-10-28 14:53:00'),
                                                                  (19, 29, '2025-10-13 00:23:00'),
                                                                  (19, 32, '2025-10-08 00:08:00'),
                                                                  (19, 12, '2025-10-13 05:23:00'),
                                                                  (19, 2, '2025-10-27 21:39:00');

-- 게시글 20번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (20, 9, '2025-10-25 14:04:00'),
                                                                  (20, 43, '2025-10-13 07:39:00'),
                                                                  (20, 46, '2025-10-04 09:27:00'),
                                                                  (20, 49, '2025-10-15 14:37:00'),
                                                                  (20, 7, '2025-10-15 05:56:00'),
                                                                  (20, 35, '2025-10-05 20:26:00'),
                                                                  (20, 2, '2025-10-23 11:14:00'),
                                                                  (20, 17, '2025-11-01 22:48:00'),
                                                                  (20, 30, '2025-10-26 17:12:00'),
                                                                  (20, 16, '2025-10-11 07:09:00'),
                                                                  (20, 47, '2025-10-10 02:50:00'),
                                                                  (20, 14, '2025-11-02 04:02:00'),
                                                                  (20, 10, '2025-10-09 05:58:00'),
                                                                  (20, 1, '2025-10-26 04:50:00'),
                                                                  (20, 25, '2025-10-31 11:56:00'),
                                                                  (20, 50, '2025-10-05 05:09:00'),
                                                                  (20, 39, '2025-10-19 20:43:00'),
                                                                  (20, 45, '2025-10-22 09:44:00'),
                                                                  (20, 26, '2025-10-30 08:34:00'),
                                                                  (20, 36, '2025-10-10 06:15:00'),
                                                                  (20, 41, '2025-10-08 05:53:00'),
                                                                  (20, 18, '2025-10-05 20:09:00'),
                                                                  (20, 33, '2025-10-13 06:08:00'),
                                                                  (20, 23, '2025-10-15 04:08:00'),
                                                                  (20, 13, '2025-10-30 16:53:00'),
                                                                  (20, 44, '2025-10-12 22:49:00'),
                                                                  (20, 21, '2025-10-07 12:58:00'),
                                                                  (20, 19, '2025-10-16 21:36:00'),
                                                                  (20, 15, '2025-10-13 23:12:00'),
                                                                  (20, 22, '2025-10-04 11:30:00'),
                                                                  (20, 37, '2025-10-28 10:51:00'),
                                                                  (20, 34, '2025-11-03 13:18:00');

-- 게시글 21번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (21, 22, '2025-10-08 19:24:00'),
                                                                  (21, 9, '2025-10-24 04:57:00'),
                                                                  (21, 47, '2025-10-14 03:00:00'),
                                                                  (21, 21, '2025-10-13 05:50:00'),
                                                                  (21, 34, '2025-10-18 01:12:00'),
                                                                  (21, 28, '2025-10-25 15:30:00'),
                                                                  (21, 42, '2025-10-26 23:50:00'),
                                                                  (21, 17, '2025-10-21 18:09:00'),
                                                                  (21, 40, '2025-10-27 19:48:00'),
                                                                  (21, 30, '2025-10-08 04:46:00'),
                                                                  (21, 7, '2025-10-25 14:50:00'),
                                                                  (21, 15, '2025-10-25 18:12:00'),
                                                                  (21, 46, '2025-10-16 02:55:00'),
                                                                  (21, 14, '2025-10-24 14:06:00'),
                                                                  (21, 3, '2025-10-10 18:01:00'),
                                                                  (21, 32, '2025-10-22 02:00:00'),
                                                                  (21, 4, '2025-10-16 21:45:00'),
                                                                  (21, 39, '2025-10-24 15:20:00'),
                                                                  (21, 6, '2025-10-26 11:54:00'),
                                                                  (21, 20, '2025-10-20 10:13:00'),
                                                                  (21, 10, '2025-10-17 00:31:00'),
                                                                  (21, 44, '2025-11-03 00:57:00'),
                                                                  (21, 16, '2025-11-01 06:27:00'),
                                                                  (21, 29, '2025-11-03 11:23:00'),
                                                                  (21, 33, '2025-10-22 03:44:00'),
                                                                  (21, 12, '2025-10-27 17:10:00'),
                                                                  (21, 36, '2025-10-16 09:56:00'),
                                                                  (21, 18, '2025-10-29 09:10:00'),
                                                                  (21, 31, '2025-10-06 19:43:00'),
                                                                  (21, 23, '2025-11-03 21:26:00'),
                                                                  (21, 50, '2025-10-13 08:31:00'),
                                                                  (21, 2, '2025-10-08 01:21:00'),
                                                                  (21, 24, '2025-10-10 13:40:00'),
                                                                  (21, 37, '2025-10-04 08:34:00'),
                                                                  (21, 8, '2025-10-07 21:12:00'),
                                                                  (21, 48, '2025-10-13 15:03:00'),
                                                                  (21, 26, '2025-10-12 12:34:00'),
                                                                  (21, 27, '2025-10-23 09:12:00');

-- 게시글 22번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (22, 14, '2025-10-06 18:54:00'),
                                                                  (22, 20, '2025-10-27 07:37:00'),
                                                                  (22, 22, '2025-10-28 04:44:00'),
                                                                  (22, 46, '2025-10-04 05:36:00'),
                                                                  (22, 3, '2025-11-03 18:58:00'),
                                                                  (22, 7, '2025-10-08 17:34:00'),
                                                                  (22, 25, '2025-10-23 08:15:00'),
                                                                  (22, 6, '2025-10-14 08:28:00'),
                                                                  (22, 19, '2025-10-07 15:24:00'),
                                                                  (22, 49, '2025-10-30 03:51:00');

-- 게시글 23번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (23, 8, '2025-10-09 00:37:00'),
                                                                  (23, 27, '2025-10-10 19:16:00'),
                                                                  (23, 15, '2025-10-06 13:12:00'),
                                                                  (23, 45, '2025-10-12 06:51:00'),
                                                                  (23, 22, '2025-11-02 03:54:00'),
                                                                  (23, 13, '2025-10-12 03:28:00'),
                                                                  (23, 18, '2025-10-15 10:51:00'),
                                                                  (23, 3, '2025-10-26 00:58:00'),
                                                                  (23, 44, '2025-11-01 06:45:00'),
                                                                  (23, 20, '2025-11-01 02:50:00'),
                                                                  (23, 36, '2025-10-05 23:50:00'),
                                                                  (23, 30, '2025-10-29 15:42:00'),
                                                                  (23, 46, '2025-10-09 22:27:00'),
                                                                  (23, 24, '2025-10-23 09:14:00'),
                                                                  (23, 29, '2025-10-20 11:44:00'),
                                                                  (23, 41, '2025-10-10 02:30:00'),
                                                                  (23, 1, '2025-10-23 15:03:00');

-- 게시글 24번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (24, 40, '2025-10-23 09:26:00'),
                                                                  (24, 38, '2025-10-12 05:23:00'),
                                                                  (24, 13, '2025-10-20 22:31:00'),
                                                                  (24, 31, '2025-10-09 07:22:00'),
                                                                  (24, 9, '2025-10-30 23:40:00'),
                                                                  (24, 39, '2025-10-19 19:27:00'),
                                                                  (24, 8, '2025-10-06 01:26:00'),
                                                                  (24, 30, '2025-10-10 11:12:00'),
                                                                  (24, 17, '2025-10-30 01:37:00'),
                                                                  (24, 23, '2025-10-19 03:35:00'),
                                                                  (24, 28, '2025-10-24 17:23:00'),
                                                                  (24, 10, '2025-10-22 08:27:00'),
                                                                  (24, 37, '2025-10-10 03:04:00'),
                                                                  (24, 7, '2025-10-08 22:49:00'),
                                                                  (24, 6, '2025-10-26 05:31:00'),
                                                                  (24, 18, '2025-10-08 00:03:00'),
                                                                  (24, 3, '2025-11-02 02:39:00'),
                                                                  (24, 34, '2025-10-11 15:58:00'),
                                                                  (24, 49, '2025-10-06 09:21:00'),
                                                                  (24, 14, '2025-10-09 07:02:00'),
                                                                  (24, 50, '2025-10-11 15:06:00'),
                                                                  (24, 41, '2025-10-30 18:50:00');

-- 게시글 25번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (25, 9, '2025-10-11 06:55:00'),
                                                                  (25, 47, '2025-10-28 19:41:00'),
                                                                  (25, 26, '2025-10-20 18:31:00'),
                                                                  (25, 16, '2025-10-09 01:31:00'),
                                                                  (25, 19, '2025-10-18 19:09:00'),
                                                                  (25, 24, '2025-10-13 10:09:00'),
                                                                  (25, 3, '2025-10-12 21:00:00'),
                                                                  (25, 29, '2025-10-22 13:39:00'),
                                                                  (25, 23, '2025-10-25 22:48:00'),
                                                                  (25, 41, '2025-10-11 01:33:00'),
                                                                  (25, 50, '2025-10-24 03:40:00'),
                                                                  (25, 48, '2025-10-17 13:40:00'),
                                                                  (25, 44, '2025-10-07 01:45:00'),
                                                                  (25, 4, '2025-10-26 21:35:00'),
                                                                  (25, 18, '2025-10-18 09:59:00'),
                                                                  (25, 43, '2025-11-03 20:39:00'),
                                                                  (25, 38, '2025-10-12 11:22:00'),
                                                                  (25, 14, '2025-10-12 18:33:00'),
                                                                  (25, 21, '2025-10-18 07:33:00'),
                                                                  (25, 1, '2025-10-12 22:03:00'),
                                                                  (25, 15, '2025-10-29 07:07:00'),
                                                                  (25, 35, '2025-10-09 21:51:00'),
                                                                  (25, 22, '2025-10-05 14:08:00'),
                                                                  (25, 31, '2025-10-07 18:19:00'),
                                                                  (25, 45, '2025-10-04 11:44:00'),
                                                                  (25, 10, '2025-10-11 16:22:00'),
                                                                  (25, 2, '2025-10-26 19:48:00'),
                                                                  (25, 49, '2025-10-15 03:19:00'),
                                                                  (25, 12, '2025-10-07 02:43:00'),
                                                                  (25, 33, '2025-10-25 16:12:00'),
                                                                  (25, 28, '2025-10-10 12:47:00'),
                                                                  (25, 8, '2025-10-09 21:51:00'),
                                                                  (25, 32, '2025-11-02 04:47:00'),
                                                                  (25, 11, '2025-11-01 02:29:00'),
                                                                  (25, 6, '2025-10-14 07:22:00'),
                                                                  (25, 30, '2025-10-15 12:10:00');

-- 게시글 26번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (26, 45, '2025-10-05 02:26:00'),
                                                                  (26, 6, '2025-10-29 12:01:00'),
                                                                  (26, 8, '2025-10-09 06:32:00'),
                                                                  (26, 48, '2025-10-20 06:16:00'),
                                                                  (26, 32, '2025-10-10 23:21:00'),
                                                                  (26, 40, '2025-10-12 22:17:00'),
                                                                  (26, 15, '2025-10-07 18:01:00'),
                                                                  (26, 1, '2025-10-17 02:30:00'),
                                                                  (26, 38, '2025-10-14 17:22:00'),
                                                                  (26, 17, '2025-11-03 04:11:00'),
                                                                  (26, 20, '2025-10-28 16:37:00'),
                                                                  (26, 43, '2025-10-28 14:01:00'),
                                                                  (26, 19, '2025-10-30 01:48:00'),
                                                                  (26, 42, '2025-10-29 17:17:00'),
                                                                  (26, 29, '2025-10-06 13:02:00'),
                                                                  (26, 33, '2025-10-05 15:44:00'),
                                                                  (26, 37, '2025-10-22 03:20:00'),
                                                                  (26, 28, '2025-10-23 18:58:00'),
                                                                  (26, 13, '2025-10-31 02:40:00'),
                                                                  (26, 2, '2025-10-24 20:17:00'),
                                                                  (26, 7, '2025-10-30 22:32:00'),
                                                                  (26, 47, '2025-10-15 01:33:00'),
                                                                  (26, 34, '2025-10-09 17:11:00'),
                                                                  (26, 12, '2025-10-10 13:52:00'),
                                                                  (26, 10, '2025-10-10 08:18:00'),
                                                                  (26, 3, '2025-10-06 18:06:00'),
                                                                  (26, 16, '2025-10-07 06:33:00'),
                                                                  (26, 4, '2025-10-30 13:50:00'),
                                                                  (26, 36, '2025-10-22 00:12:00'),
                                                                  (26, 26, '2025-10-29 05:10:00'),
                                                                  (26, 44, '2025-10-27 01:45:00'),
                                                                  (26, 14, '2025-11-03 12:22:00'),
                                                                  (26, 49, '2025-10-25 14:01:00'),
                                                                  (26, 31, '2025-10-26 13:10:00'),
                                                                  (26, 11, '2025-10-23 00:14:00'),
                                                                  (26, 50, '2025-10-25 14:56:00'),
                                                                  (26, 24, '2025-10-10 20:47:00'),
                                                                  (26, 27, '2025-10-20 04:57:00');

-- 게시글 27번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (27, 11, '2025-10-09 22:30:00'),
                                                                  (27, 7, '2025-10-29 17:47:00'),
                                                                  (27, 24, '2025-10-05 07:33:00'),
                                                                  (27, 45, '2025-10-22 12:48:00'),
                                                                  (27, 32, '2025-10-22 07:07:00'),
                                                                  (27, 44, '2025-10-30 11:01:00'),
                                                                  (27, 15, '2025-10-11 08:58:00'),
                                                                  (27, 23, '2025-10-26 06:26:00'),
                                                                  (27, 4, '2025-10-27 15:24:00'),
                                                                  (27, 46, '2025-10-10 11:44:00'),
                                                                  (27, 20, '2025-10-05 10:38:00'),
                                                                  (27, 6, '2025-10-06 04:23:00'),
                                                                  (27, 34, '2025-10-27 16:34:00'),
                                                                  (27, 30, '2025-10-22 23:50:00'),
                                                                  (27, 9, '2025-10-05 11:49:00'),
                                                                  (27, 50, '2025-10-26 18:29:00'),
                                                                  (27, 43, '2025-10-12 16:11:00'),
                                                                  (27, 17, '2025-10-15 07:25:00'),
                                                                  (27, 3, '2025-10-18 08:03:00'),
                                                                  (27, 49, '2025-10-15 16:37:00'),
                                                                  (27, 33, '2025-10-26 13:55:00'),
                                                                  (27, 38, '2025-10-09 07:59:00'),
                                                                  (27, 22, '2025-11-03 09:29:00'),
                                                                  (27, 8, '2025-10-31 00:25:00'),
                                                                  (27, 28, '2025-10-18 11:50:00'),
                                                                  (27, 16, '2025-10-23 05:09:00'),
                                                                  (27, 36, '2025-10-04 13:31:00');

-- 게시글 28번
INSERT INTO public.scraps (recycling_id, user_id, created_at) VALUES
                                                                  (28, 40, '2025-10-20 19:10:00'),
                                                                  (28, 19, '2025-10-17 16:01:00'),
                                                                  (28, 25, '2025-10-25 19:46:00'),
                                                                  (28, 18, '2025-10-15 00:42:00'),
                                                                  (28, 21, '2025-10-17 04:35:00'),
                                                                  (28, 33, '2025-10-28 15:28:00'),
                                                                  (28, 13, '2025-10-22 03:06:00'),
                                                                  (28, 47, '2025-10-12 04:37:00'),
                                                                  (28, 42, '2025-10-29 20:02:00'),
                                                                  (28, 24, '2025-10-31 02:32:00'),
                                                                  (28, 27, '2025-11-03 00:54:00'),
                                                                  (28, 32, '2025-10-19 15:18:00'),
                                                                  (28, 15, '2025-10-10 06:56:00'),
                                                                  (28, 30, '2025-10-22 14:26:00'),
                                                                  (28, 8, '2025-10-08 20:29:00'),
                                                                  (28, 12, '2025-10-11 01:07:00'),
                                                                  (28, 34, '2025-10-24 10:02:00'),
                                                                  (28, 39, '2025-10-21 05:56:00'),
                                                                  (28, 11, '2025-10-06 08:36:00'),
                                                                  (28, 48, '2025-10-08 02:58:00'),
                                                                  (28, 28, '2025-10-14 10:46:00'),
                                                                  (28, 49, '2025-10-24 12:40:00');


INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 37, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 31, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 13, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 42, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 48, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 17, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 16, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 46, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 43, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 45, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 5, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 32, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 29, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 11, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 7, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 25, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 34, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 2, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 49, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 29, 47, '2025-11-04 03:12:38.373812 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 11, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 24, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 6, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 46, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 16, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 3, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 20, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 39, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 40, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 29, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 9, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 1, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 36, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 14, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 41, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 15, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 8, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 30, 4, '2025-11-04 03:12:38.454753 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 31, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 18, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 9, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 29, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 33, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 19, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 20, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 26, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 25, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 31, 7, '2025-11-04 03:12:38.502601 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 11, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 41, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 33, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 27, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 26, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 17, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 48, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 16, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 28, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 32, 31, '2025-11-04 03:12:38.535960 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 28, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 5, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 14, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 31, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 44, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 4, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 10, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 18, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 40, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 50, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 43, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 3, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 37, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 39, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 47, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 49, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 33, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 42, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 8, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 25, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 1, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 41, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 16, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 24, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 12, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 34, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 48, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 32, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 33, 46, '2025-11-04 03:12:38.571049 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 43, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 38, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 48, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 41, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 3, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 37, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 42, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 18, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 13, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 45, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 15, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 25, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 8, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 20, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 40, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 39, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 11, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 34, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 1, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 23, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 4, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 12, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 24, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 34, 33, '2025-11-04 03:12:38.603315 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 21, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 12, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 17, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 3, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 50, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 40, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 7, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 48, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 22, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 8, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 43, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 39, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 44, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 31, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 47, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 10, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 11, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 45, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 35, 25, '2025-11-04 03:12:38.626405 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 36, 32, '2025-11-04 03:12:38.644596 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 36, 20, '2025-11-04 03:12:38.644596 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 36, 16, '2025-11-04 03:12:38.644596 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 36, 15, '2025-11-04 03:12:38.644596 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 37, 7, '2025-11-04 03:12:38.663239 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 37, 47, '2025-11-04 03:12:38.663239 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 49, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 31, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 38, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 36, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 21, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 12, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 43, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 10, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 41, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 42, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 32, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 11, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 13, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 14, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 34, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 48, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 17, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 40, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 38, 2, '2025-11-04 03:12:38.688415 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 39, 10, '2025-11-04 03:12:38.709097 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 39, 2, '2025-11-04 03:12:38.709097 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 39, 11, '2025-11-04 03:12:38.709097 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 39, 47, '2025-11-04 03:12:38.709097 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 39, 20, '2025-11-04 03:12:38.709097 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 39, 33, '2025-11-04 03:12:38.709097 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 39, 36, '2025-11-04 03:12:38.709097 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 21, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 43, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 7, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 28, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 34, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 5, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 18, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 14, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 45, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 49, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 16, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 23, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 6, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 12, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 47, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 15, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 46, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 35, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 38, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 26, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 13, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 25, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 19, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 40, 1, '2025-11-04 03:12:39.002273 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 43, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 11, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 27, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 28, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 2, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 9, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 10, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 20, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 22, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 45, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 15, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 48, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 25, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 1, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 39, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 31, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 37, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 21, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 26, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 46, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 14, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 33, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 50, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 41, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 12, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 18, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 6, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 32, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 41, 23, '2025-11-04 03:12:39.030063 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 42, 3, '2025-11-04 03:12:39.063335 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 42, 11, '2025-11-04 03:12:39.063335 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 42, 17, '2025-11-04 03:12:39.063335 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 42, 28, '2025-11-04 03:12:39.063335 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 42, 1, '2025-11-04 03:12:39.063335 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 42, 27, '2025-11-04 03:12:39.063335 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 39, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 37, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 16, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 30, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 15, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 14, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 5, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 26, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 10, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 19, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 6, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 2, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 50, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 12, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 46, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 8, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 41, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 20, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 28, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 25, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 1, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 18, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 17, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 43, 38, '2025-11-04 03:12:39.114274 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 16, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 19, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 8, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 46, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 10, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 1, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 34, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 7, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 11, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 31, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 12, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 35, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 20, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 30, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 44, 39, '2025-11-04 03:12:39.156655 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 29, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 44, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 25, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 13, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 31, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 9, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 34, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 45, 2, '2025-11-04 03:12:39.179016 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 22, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 41, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 5, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 45, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 25, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 7, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 35, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 6, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 13, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 30, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 15, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 36, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 28, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 46, 43, '2025-11-04 03:12:39.204031 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 45, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 29, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 1, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 49, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 20, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 39, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 44, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 14, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 31, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 17, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 24, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 33, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 28, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 6, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 3, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 46, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 18, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 8, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 37, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 35, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 50, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 12, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 38, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 47, 11, '2025-11-04 03:12:39.237040 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 48, 35, '2025-11-04 03:12:39.259562 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 48, 24, '2025-11-04 03:12:39.259562 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 48, 40, '2025-11-04 03:12:39.259562 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 48, 22, '2025-11-04 03:12:39.259562 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 48, 21, '2025-11-04 03:12:39.259562 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 26, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 46, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 49, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 3, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 32, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 23, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 1, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 21, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 12, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 8, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 35, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 36, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 42, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 9, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 7, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 38, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 10, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 45, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 29, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 49, 44, '2025-11-04 03:12:39.285287 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 35, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 3, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 32, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 45, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 49, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 38, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 34, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 15, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 12, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 44, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 8, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 17, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 30, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 50, 48, '2025-11-04 03:12:39.308964 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 48, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 35, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 31, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 21, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 12, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 17, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 24, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 14, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 4, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 19, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 15, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 10, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 45, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 37, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 11, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 18, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 9, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 29, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 25, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 50, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 7, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 40, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 28, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 26, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 30, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 44, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 51, 1, '2025-11-04 03:12:39.335761 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 22, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 3, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 29, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 39, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 18, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 43, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 32, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 13, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 45, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 42, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 12, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 5, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 17, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 24, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 27, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 20, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 14, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 40, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 49, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 52, 48, '2025-11-04 03:12:39.361916 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 6, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 31, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 50, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 21, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 43, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 17, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 46, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 33, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 42, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 16, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 27, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 3, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 28, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 4, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 40, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 53, 20, '2025-11-04 03:12:39.387717 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 5, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 9, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 31, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 4, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 18, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 1, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 17, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 47, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 12, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 22, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 23, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 30, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 50, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 45, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 13, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 34, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 3, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 41, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 19, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 26, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 14, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 49, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 6, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 24, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 54, 39, '2025-11-04 03:12:39.409843 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 55, 49, '2025-11-04 03:12:39.427686 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 55, 18, '2025-11-04 03:12:39.427686 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 55, 24, '2025-11-04 03:12:39.427686 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 55, 29, '2025-11-04 03:12:39.427686 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 55, 17, '2025-11-04 03:12:39.427686 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 55, 41, '2025-11-04 03:12:39.427686 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 48, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 36, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 41, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 24, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 25, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 10, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 26, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 34, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 13, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 42, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 6, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 2, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 38, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 23, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 40, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 30, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 29, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 27, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 44, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 4, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 32, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 19, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 56, 33, '2025-11-04 03:12:39.458888 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 40, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 13, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 19, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 37, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 36, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 39, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 24, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 20, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 18, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 38, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 16, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 23, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 8, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 26, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 2, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 46, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 1, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 10, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 11, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 6, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 14, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 31, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 44, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 48, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 57, 45, '2025-11-04 03:12:39.496161 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 58, 28, '2025-11-04 03:12:39.525713 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 58, 11, '2025-11-04 03:12:39.525713 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 58, 43, '2025-11-04 03:12:39.525713 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 16, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 7, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 46, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 18, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 15, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 29, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 2, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 39, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 17, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 38, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 21, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 50, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 42, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 10, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 48, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 45, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 36, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 41, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 31, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 27, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 30, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 59, 24, '2025-11-04 03:12:39.555132 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 37, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 1, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 4, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 44, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 48, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 3, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 6, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 40, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 10, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 42, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 7, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 14, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 9, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 41, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 15, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 46, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 18, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 13, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 24, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 49, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 33, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 29, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 27, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 12, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 45, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 31, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 17, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 60, 50, '2025-11-04 03:12:39.583403 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 11, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 38, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 34, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 4, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 1, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 31, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 42, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 6, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 39, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 48, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 41, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 23, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 28, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 17, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 25, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 14, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 13, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 7, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 46, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 10, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 22, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 35, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 2, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 24, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 61, 32, '2025-11-04 03:12:39.612319 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 19, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 15, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 38, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 2, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 9, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 8, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 14, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 4, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 28, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 29, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 25, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 48, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 22, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 43, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 1, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 10, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 42, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 27, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 7, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 13, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 6, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 23, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 47, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 46, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 62, 11, '2025-11-04 03:12:39.645775 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 63, 7, '2025-11-04 03:12:39.671940 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 63, 9, '2025-11-04 03:12:39.671940 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 63, 5, '2025-11-04 03:12:39.671940 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 63, 36, '2025-11-04 03:12:39.671940 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 10, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 4, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 33, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 43, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 41, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 15, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 31, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 18, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 46, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 8, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 50, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 5, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 42, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 14, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 35, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 12, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 17, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 19, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 38, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 37, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 24, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 48, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 21, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 27, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 23, '2025-11-04 03:12:39.699193 +00:00');
INSERT INTO public.scraps ( recycling_id, user_id, created_at) VALUES ( 64, 16, '2025-11-04 03:12:39.699193 +00:00');


INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (1, 8, null, '종이백이 얇아서 찢어질까봐 걱정돼요. 강화할 방법이 있을까요?', '2025-11-03 16:05:52.340014 +00:00', '2025-11-03 16:05:52.340014 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (1, 1, 1, '밑부분과 옆면을 두 겹으로 접거나 테이프로 보강하면 훨씬 튼튼해집니다.', '2025-11-03 16:05:52.340014 +00:00', '2025-11-03 16:05:52.340014 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (1, 22, null, '손잡이 부분을 남기면 더 편하지 않을까요?', '2025-11-03 16:05:52.340014 +00:00', '2025-11-03 16:05:52.340014 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (1, 1, 3, '가능하지만 모양이 조금 덜 정리돼 보일 수 있어요. 깔끔한 박스형을 원하면 자르는 걸 추천합니다.', '2025-11-03 16:05:52.340014 +00:00', '2025-11-03 16:05:52.340014 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (1, 15, null, '색종이로 꾸며도 예쁠까요?', '2025-11-03 16:05:52.340014 +00:00', '2025-11-03 16:05:52.340014 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (1, 1, 5, '네! 색종이나 마스킹테이프, 스티커로 포인트를 주면 훨씬 예뻐요.', '2025-11-03 16:05:52.340014 +00:00', '2025-11-03 16:05:52.340014 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (2, 10, null, '생화도 가능할까요? 무게가 좀 있어서 걱정돼요.', '2025-11-03 16:05:52.410749 +00:00', '2025-11-03 16:05:52.410749 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (2, 1, 7, '생화는 물기 때문에 무게가 실리니 조화나 드라이플라워를 추천드립니다.', '2025-11-03 16:05:52.410749 +00:00', '2025-11-03 16:05:52.410749 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES (2, 33, null, '스트로폼 대신 신문지로 대체해도 될까요?', '2025-11-03 16:05:52.410749 +00:00', '2025-11-03 16:05:52.410749 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 2, 1, 9, '네, 신문지를 돌돌 말아 꽉 채워도 비슷하게 고정됩니다.', '2025-11-03 16:05:52.410749 +00:00', '2025-11-03 16:05:52.410749 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 2, 21, null, '리본으로 묶으면 더 예쁠까요?', '2025-11-03 16:05:52.410749 +00:00', '2025-11-03 16:05:52.410749 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 2, 1, 11, '리본으로 손잡이 부분을 감싸주면 훨씬 완성도가 높아집니다.', '2025-11-03 16:05:52.410749 +00:00', '2025-11-03 16:05:52.410749 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 3, 9, null, '티슈 크기랑 종이백 크기 맞추는 게 어렵네요. 팁 있나요?', '2025-11-03 16:05:52.459844 +00:00', '2025-11-03 16:05:52.459844 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 3, 1, 13, '티슈를 종이백 안에 넣고 자른 뒤, 1cm 여유 두고 접으면 깔끔하게 맞아요.', '2025-11-03 16:05:52.459844 +00:00', '2025-11-03 16:05:52.459844 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 3, 27, null, '로고가 정중앙에 오게 하려면 어떻게 해야 하나요?', '2025-11-03 16:05:52.459844 +00:00', '2025-11-03 16:05:52.459844 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 3, 1, 15, '자르기 전에 위치를 연필로 표시해두면 맞추기 쉬워요.', '2025-11-03 16:05:52.459844 +00:00', '2025-11-03 16:05:52.459844 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 3, 35, null, '테이프로 마감해도 되나요?', '2025-11-03 16:05:52.459844 +00:00', '2025-11-03 16:05:52.459844 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 3, 1, 17, '가능합니다. 다만 글루건을 사용하면 더 튼튼하게 고정돼요.', '2025-11-03 16:05:52.459844 +00:00', '2025-11-03 16:05:52.459844 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 4, 11, null, '풀 대신 스테이플러로 고정해도 되나요?', '2025-11-03 16:05:52.476977 +00:00', '2025-11-03 16:05:52.476977 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 4, 1, 19, '가능하지만 스테이플러는 구부러지기 쉬워서 풀이나 글루건이 더 안전합니다.', '2025-11-03 16:05:52.476977 +00:00', '2025-11-03 16:05:52.476977 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 4, 23, null, '색종이 대신 신문지 써도 괜찮을까요?', '2025-11-03 16:05:52.476977 +00:00', '2025-11-03 16:05:52.476977 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 4, 1, 21, '신문지도 괜찮아요. 다만 컬러감이 약하니 포인트 색을 함께 쓰면 예뻐요.', '2025-11-03 16:05:52.476977 +00:00', '2025-11-03 16:05:52.476977 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 4, 16, null, '손잡이 달아도 될까요?', '2025-11-03 16:05:52.476977 +00:00', '2025-11-03 16:05:52.476977 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 4, 1, 23, '위쪽 모서리에 구멍을 내고 끈을 달면 간단하게 손잡이도 가능합니다.', '2025-11-03 16:05:52.476977 +00:00', '2025-11-03 16:05:52.476977 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 5, 14, null, '종이가 너무 두꺼워서 접히질 않아요. 어떤 종이가 좋을까요?', '2025-11-03 16:05:52.499081 +00:00', '2025-11-03 16:05:52.499081 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 5, 1, 25, '쇼핑백 중에서도 얇고 코팅 없는 종이가 접기에 좋아요.', '2025-11-03 16:05:52.499081 +00:00', '2025-11-03 16:05:52.499081 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 5, 29, null, '표지 모서리가 자꾸 뜨는데 방법 있나요?', '2025-11-03 16:05:52.499081 +00:00', '2025-11-03 16:05:52.499081 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 5, 1, 27, '끝부분을 테이프로 안쪽에 살짝 붙이면 깔끔하게 눌려요.', '2025-11-03 16:05:52.499081 +00:00', '2025-11-03 16:05:52.499081 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 5, 42, null, '커버 꾸밀 때 어떤 재료가 좋아요?', '2025-11-03 16:05:52.499081 +00:00', '2025-11-03 16:05:52.499081 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 5, 1, 29, '마스킹테이프나 스티커, 도일리 페이퍼 같은 얇은 소재가 좋아요.', '2025-11-03 16:05:52.499081 +00:00', '2025-11-03 16:05:52.499081 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 6, 30, null, '건조할 때 햇빛에 바로 두면 괜찮나요?', '2025-11-03 16:05:52.521043 +00:00', '2025-11-03 16:05:52.521043 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 6, 1, 31, '햇빛보다는 그늘에서 천천히 말리는 게 갈라짐이 적어요.', '2025-11-03 16:05:52.521043 +00:00', '2025-11-03 16:05:52.521043 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 6, 26, null, '색칠은 어떤 물감으로 해도 되나요?', '2025-11-03 16:05:52.521043 +00:00', '2025-11-03 16:05:52.521043 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 6, 1, 33, '아크릴 물감이 가장 잘 붙습니다. 수채화는 번질 수 있어요.', '2025-11-03 16:05:52.521043 +00:00', '2025-11-03 16:05:52.521043 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 6, 43, null, '방수 코팅은 꼭 해야 하나요?', '2025-11-03 16:05:52.521043 +00:00', '2025-11-03 16:05:52.521043 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 6, 1, 35, '습한 곳에서 쓸 거라면 코팅제를 한 번 바르는 게 좋아요.', '2025-11-03 16:05:52.521043 +00:00', '2025-11-03 16:05:52.521043 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 7, 11, null, '털실 대신 다른 재료로 감아도 되나요?', '2025-11-03 16:05:52.537556 +00:00', '2025-11-03 16:05:52.537556 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 7, 1, 37, '네, 끈이나 리본도 좋아요. 다만 너무 두꺼운 재료는 감기 어렵습니다.', '2025-11-03 16:05:52.537556 +00:00', '2025-11-03 16:05:52.537556 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 7, 25, null, '손잡이 없이 써도 괜찮을까요?', '2025-11-03 16:05:52.537556 +00:00', '2025-11-03 16:05:52.537556 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 7, 1, 39, '네, 손잡이 없이도 소품 수납용으로 충분히 예뻐요.', '2025-11-03 16:05:52.537556 +00:00', '2025-11-03 16:05:52.537556 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 7, 37, null, '컵 크기는 어느 정도가 좋을까요?', '2025-11-03 16:05:52.537556 +00:00', '2025-11-03 16:05:52.537556 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 7, 1, 41, '보통 250ml 종이컵 정도가 적당해요.', '2025-11-03 16:05:52.537556 +00:00', '2025-11-03 16:05:52.537556 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 8, 10, null, '체가 없으면 어떻게 물기를 빼야 할까요?', '2025-11-03 16:11:15.153780 +00:00', '2025-11-03 16:11:15.153780 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 8, 1, 43, '수건이나 신문지 위에 넓게 펴고 손으로 꾹꾹 눌러도 좋아요.', '2025-11-03 16:11:15.153780 +00:00', '2025-11-03 16:11:15.153780 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 8, 28, null, '색종이 섞으면 색종이색이 그대로 남을까요?', '2025-11-03 16:11:15.153780 +00:00', '2025-11-03 16:11:15.153780 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 8, 1, 45, '네, 그대로 비치기 때문에 색감 있는 재생종이로 만들어집니다.', '2025-11-03 16:11:15.153780 +00:00', '2025-11-03 16:11:15.153780 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 8, 45, null, '드라이기로 말려도 되나요?', '2025-11-03 16:11:15.153780 +00:00', '2025-11-03 16:11:15.153780 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 8, 1, 47, '가능하지만 열이 너무 강하면 종이가 말릴 수 있어요. 약풍으로 해주세요.', '2025-11-03 16:11:15.153780 +00:00', '2025-11-03 16:11:15.153780 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 9, 16, null, '종이접시 대신 두꺼운 종이를 써도 되나요?', '2025-11-03 16:11:15.178986 +00:00', '2025-11-03 16:11:15.178986 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 9, 1, 49, '네, 단단한 종이를 사용하면 오래 걸 수 있습니다.', '2025-11-03 16:11:15.178986 +00:00', '2025-11-03 16:11:15.178986 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 9, 33, null, '아이랑 같이 만들기 괜찮을까요?', '2025-11-03 16:11:15.178986 +00:00', '2025-11-03 16:11:15.178986 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 9, 1, 51, '아주 좋아요! 색칠하기나 스티커 붙이기 활동으로 적합합니다.', '2025-11-03 16:11:15.178986 +00:00', '2025-11-03 16:11:15.178986 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 9, 44, null, '끈은 어떤 걸로 연결하는 게 좋을까요?', '2025-11-03 16:11:15.178986 +00:00', '2025-11-03 16:11:15.178986 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 9, 1, 53, '실, 낚시줄, 끈 모두 좋아요. 투명줄 쓰면 더 깔끔해요.', '2025-11-03 16:11:15.178986 +00:00', '2025-11-03 16:11:15.178986 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 10, 21, null, '비닐 대신 다른 소재 써도 돼요?', '2025-11-03 16:11:15.197845 +00:00', '2025-11-03 16:11:15.197845 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 10, 1, 55, '네, 얇은 천조각이나 헌 티셔츠 조각도 가능합니다.', '2025-11-03 16:11:15.197845 +00:00', '2025-11-03 16:11:15.197845 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 10, 38, null, '코바늘 없으면 손으로 할 수 있나요?', '2025-11-03 16:11:15.197845 +00:00', '2025-11-03 16:11:15.197845 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 10, 1, 57, '가능하지만 일정한 간격 맞추기가 어려워요. 초보라면 코바늘 추천드려요.', '2025-11-03 16:11:15.197845 +00:00', '2025-11-03 16:11:15.197845 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 10, 7, null, '뜨개 초보도 만들 수 있나요?', '2025-11-03 16:11:15.197845 +00:00', '2025-11-03 16:11:15.197845 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 10, 1, 59, '네, 짧은뜨기만 알면 쉽게 가능합니다.', '2025-11-03 16:11:15.197845 +00:00', '2025-11-03 16:11:15.197845 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 11, 18, null, '다리미 온도는 어느 정도가 좋아요?', '2025-11-03 16:11:15.216125 +00:00', '2025-11-03 16:11:15.216125 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 11, 1, 61, '중온(약 120~140도)으로 천천히 눌러주세요.', '2025-11-03 16:11:15.216125 +00:00', '2025-11-03 16:11:15.216125 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 11, 26, null, '비닐이 녹아서 다리미에 붙어요 ㅠ', '2025-11-03 16:11:15.216125 +00:00', '2025-11-03 16:11:15.216125 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 11, 1, 63, '베이킹페이퍼를 꼭 위아래로 덮으면 안 붙습니다.', '2025-11-03 16:11:15.216125 +00:00', '2025-11-03 16:11:15.216125 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 11, 31, null, '색 조합 추천해주세요!', '2025-11-03 16:11:15.216125 +00:00', '2025-11-03 16:11:15.216125 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 11, 1, 65, '투명+하늘색+흰색 조합이 깔끔하고 잘 어울려요.', '2025-11-03 16:11:15.216125 +00:00', '2025-11-03 16:11:15.216125 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 12, 19, null, '비닐 대신 신문지 써도 될까요?', '2025-11-03 16:11:15.232490 +00:00', '2025-11-03 16:11:15.232490 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 12, 1, 67, '신문지는 무게감이 안 나와요. 비닐이 더 좋아요.', '2025-11-03 16:11:15.232490 +00:00', '2025-11-03 16:11:15.232490 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 12, 39, null, '아이들과 만들 때 주의할 점 있을까요?', '2025-11-03 16:11:15.232490 +00:00', '2025-11-03 16:11:15.232490 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 12, 1, 69, '와셔나 페트뚜껑 부분은 어른이 함께 조립해주세요.', '2025-11-03 16:11:15.232490 +00:00', '2025-11-03 16:11:15.232490 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 12, 46, null, '잘 튀게 만드는 팁 있나요?', '2025-11-03 16:11:15.232490 +00:00', '2025-11-03 16:11:15.232490 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 12, 1, 71, '와셔를 두 개 겹치면 무게감이 생겨 잘 튑니다.', '2025-11-03 16:11:15.232490 +00:00', '2025-11-03 16:11:15.232490 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 13, 20, null, '비닐 말고 포장지로도 가능할까요?', '2025-11-03 16:11:15.255736 +00:00', '2025-11-03 16:11:15.255736 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 13, 1, 73, '가능해요! 다만 포장지는 약해서 다리미 온도를 낮추세요.', '2025-11-03 16:11:15.255736 +00:00', '2025-11-03 16:11:15.255736 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 13, 30, null, '스티커 붙여도 녹지 않나요?', '2025-11-03 16:11:15.255736 +00:00', '2025-11-03 16:11:15.255736 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 13, 1, 75, '다리미 전 작업 후에 붙이면 문제 없습니다.', '2025-11-03 16:11:15.255736 +00:00', '2025-11-03 16:11:15.255736 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 13, 41, null, '다이어리 크기에 맞게 재단 팁 있을까요?', '2025-11-03 16:11:15.255736 +00:00', '2025-11-03 16:11:15.255736 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 13, 1, 77, '도안을 실제 크기보다 0.5cm 여유 있게 자르면 깔끔해요.', '2025-11-03 16:11:15.255736 +00:00', '2025-11-03 16:11:15.255736 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 14, 27, null, '비닐실 만드는 게 제일 어렵네요ㅠㅠ 팁 있나요?', '2025-11-03 16:11:15.281697 +00:00', '2025-11-03 16:11:15.281697 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 14, 1, 79, '비닐을 잘게 자른 뒤 고리끼리 연결해 천천히 늘리면 잘 됩니다.', '2025-11-03 16:11:15.281697 +00:00', '2025-11-03 16:11:15.281697 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 14, 9, null, '코바늘 번호는 꼭 8호여야 하나요?', '2025-11-03 16:11:15.281697 +00:00', '2025-11-03 16:11:15.281697 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 14, 1, 81, '6~8호면 충분해요. 실 두께에 맞게 조절하세요.', '2025-11-03 16:11:15.281697 +00:00', '2025-11-03 16:11:15.281697 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 14, 42, null, '손잡이 늘어짐 방지 방법 있나요?', '2025-11-03 16:11:15.281697 +00:00', '2025-11-03 16:11:15.281697 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 14, 1, 83, '손잡이 안쪽에 천 조각을 덧대면 훨씬 단단해집니다.', '2025-11-03 16:11:15.281697 +00:00', '2025-11-03 16:11:15.281697 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 15, 22, null, '다리미 말고 헤어 고데기로 해도 될까요?', '2025-11-03 16:11:15.309386 +00:00', '2025-11-03 16:11:15.309386 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 15, 1, 85, '네 가능합니다! 다만 너무 오래 누르지 마세요.', '2025-11-03 16:11:15.309386 +00:00', '2025-11-03 16:11:15.309386 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 15, 8, null, '비닐 색 조합 추천 좀요.', '2025-11-03 16:11:15.309386 +00:00', '2025-11-03 16:11:15.309386 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 15, 1, 87, '반투명+노랑, 투명+하늘색 조합이 예뻐요.', '2025-11-03 16:11:15.309386 +00:00', '2025-11-03 16:11:15.309386 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 15, 32, null, '리본 대신 다른 거 달아도 돼요?', '2025-11-03 16:11:15.309386 +00:00', '2025-11-03 16:11:15.309386 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 15, 1, 89, '실이나 끈, 체인도 모두 잘 어울립니다.', '2025-11-03 16:11:15.309386 +00:00', '2025-11-03 16:11:15.309386 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 16, 12, null, '병뚜껑 색을 섞으면 이상하지 않을까요?', '2025-11-03 16:11:15.351225 +00:00', '2025-11-03 16:11:15.351225 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 16, 1, 91, '섞어도 괜찮아요! 다양한 색이 오히려 포인트가 됩니다.', '2025-11-03 16:11:15.351225 +00:00', '2025-11-03 16:11:15.351225 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 16, 34, null, '오븐 대신 프라이팬에도 가능할까요?', '2025-11-03 16:11:15.351225 +00:00', '2025-11-03 16:11:15.351225 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 16, 1, 93, '프라이팬은 열 조절이 어려워요. 오븐이나 히팅건을 추천드려요.', '2025-11-03 16:11:15.351225 +00:00', '2025-11-03 16:11:15.351225 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 16, 47, null, '구멍은 어떻게 뚫어야 하나요?', '2025-11-03 16:11:15.351225 +00:00', '2025-11-03 16:11:15.351225 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 16, 1, 95, '송곳을 살짝 달궈서 구멍을 내면 깨끗하게 뚫립니다.', '2025-11-03 16:11:15.351225 +00:00', '2025-11-03 16:11:15.351225 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 17, 13, null, '레진 말고 다른 재료로도 가능할까요?', '2025-11-03 16:11:15.373696 +00:00', '2025-11-03 16:11:15.373696 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 17, 1, 97, '글루건으로 고정해도 되지만, 투명도는 레진이 제일 좋아요.', '2025-11-03 16:11:15.373696 +00:00', '2025-11-03 16:11:15.373696 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 17, 48, null, '햇빛으로 굳힐 때 얼마나 걸리나요?', '2025-11-03 16:11:15.373696 +00:00', '2025-11-03 16:11:15.373696 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 17, 1, 99, '여름엔 2~3시간, 겨울엔 4시간 정도면 충분히 굳습니다.', '2025-11-03 16:11:15.373696 +00:00', '2025-11-03 16:11:15.373696 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 17, 24, null, '틀은 어디서 구하나요?', '2025-11-03 16:11:15.373696 +00:00', '2025-11-03 16:11:15.373696 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 17, 1, 101, '문구점이나 다이소에서 실리콘 몰드 구입 가능해요.', '2025-11-03 16:11:15.373696 +00:00', '2025-11-03 16:11:15.373696 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 18, 29, null, '레진이 없을 때 대체할 수 있을까요?', '2025-11-03 16:11:15.392251 +00:00', '2025-11-03 16:11:15.392251 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 18, 1, 103, '투명 본드로 굳히는 것도 가능해요. 다만 두께감은 줄어듭니다.', '2025-11-03 16:11:15.392251 +00:00', '2025-11-03 16:11:15.392251 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 18, 41, null, '반짝이 말고 넣을만한 게 있을까요?', '2025-11-03 16:11:15.392251 +00:00', '2025-11-03 16:11:15.392251 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 18, 1, 105, '압화, 조개조각, 색지 조각도 예뻐요.', '2025-11-03 16:11:15.392251 +00:00', '2025-11-03 16:11:15.392251 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 18, 8, null, '굳힌 후 끈은 언제 달아야 하나요?', '2025-11-03 16:11:15.392251 +00:00', '2025-11-03 16:11:15.392251 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 18, 1, 107, '완전히 굳은 다음 송곳으로 구멍 내고 달면 됩니다.', '2025-11-03 16:11:15.392251 +00:00', '2025-11-03 16:11:15.392251 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 19, 23, null, '열은 어느 정도로 가해야 하나요?', '2025-11-03 16:11:15.421427 +00:00', '2025-11-03 16:11:15.421427 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 19, 1, 109, '120도~140도 정도가 적당해요. 너무 높으면 녹아내립니다.', '2025-11-03 16:11:15.421427 +00:00', '2025-11-03 16:11:15.421427 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 19, 35, null, '색을 섞으면 탁해지나요?', '2025-11-03 16:11:15.421427 +00:00', '2025-11-03 16:11:15.421427 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 19, 1, 111, '색이 너무 많으면 탁해질 수 있어요. 2~3색 정도가 예쁩니다.', '2025-11-03 16:11:15.421427 +00:00', '2025-11-03 16:11:15.421427 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 19, 17, null, '작은 오븐에서도 되나요?', '2025-11-03 16:11:15.421427 +00:00', '2025-11-03 16:11:15.421427 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 19, 1, 113, '네, 소형 오븐으로 충분히 가능합니다.', '2025-11-03 16:11:15.421427 +00:00', '2025-11-03 16:11:15.421427 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 20, 33, null, '풀 대신 글루건 써도 되나요?', '2025-11-03 16:11:15.441202 +00:00', '2025-11-03 16:11:15.441202 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 20, 1, 115, '가능하지만 글루건은 금방 굳으니 빠르게 붙여주세요.', '2025-11-03 16:11:15.441202 +00:00', '2025-11-03 16:11:15.441202 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 20, 50, null, '매니큐어 말고 다른 코팅제 있나요?', '2025-11-03 16:11:15.441202 +00:00', '2025-11-03 16:11:15.441202 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 20, 1, 117, '바니시나 투명 래커도 잘 어울립니다.', '2025-11-03 16:11:15.441202 +00:00', '2025-11-03 16:11:15.441202 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 20, 14, null, '잡지 말고 포장지도 되나요?', '2025-11-03 16:11:15.441202 +00:00', '2025-11-03 16:11:15.441202 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 20, 1, 119, '네, 얇은 포장지도 가능합니다. 다만 너무 얇으면 찢어질 수 있어요.', '2025-11-03 16:11:15.441202 +00:00', '2025-11-03 16:11:15.441202 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 21, 30, null, '비닐끈은 일반 비닐봉지로 만들어도 되나요?', '2025-11-03 16:11:15.463937 +00:00', '2025-11-03 16:11:15.463937 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 21, 1, 121, '네, 잘라서 꼬면 충분히 사용할 수 있어요.', '2025-11-03 16:11:15.463937 +00:00', '2025-11-03 16:11:15.463937 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 21, 36, null, '뜨개 초보도 가능한가요?', '2025-11-03 16:11:15.463937 +00:00', '2025-11-03 16:11:15.463937 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 21, 1, 123, '짧은뜨기만 할 줄 알면 만들 수 있습니다.', '2025-11-03 16:11:15.463937 +00:00', '2025-11-03 16:11:15.463937 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 21, 6, null, '끈 이어붙일 때 풀로 해도 되나요?', '2025-11-03 16:11:15.463937 +00:00', '2025-11-03 16:11:15.463937 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 21, 1, 125, '가능하지만 코바늘로 매듭 지으면 더 깔끔해요.', '2025-11-03 16:11:15.463937 +00:00', '2025-11-03 16:11:15.463937 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 22, 4, null, '고무줄 대신 철사 써도 되나요?', '2025-11-03 16:11:15.481814 +00:00', '2025-11-03 16:11:15.481814 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 22, 1, 127, '네, 가능해요. 다만 끝부분이 날카롭지 않게 감싸주세요.', '2025-11-03 16:11:15.481814 +00:00', '2025-11-03 16:11:15.481814 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 22, 46, null, '색 조합 팁 있나요?', '2025-11-03 16:11:15.481814 +00:00', '2025-11-03 16:11:15.481814 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 22, 1, 129, '흰색+파랑, 초록+노랑 조합이 산뜻합니다.', '2025-11-03 16:11:15.481814 +00:00', '2025-11-03 16:11:15.481814 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 22, 15, null, '비닐 대신 리본 써도 예쁠까요?', '2025-11-03 16:11:15.481814 +00:00', '2025-11-03 16:11:15.481814 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 22, 1, 131, '리본으로 하면 훨씬 부드럽고 예쁜 느낌이에요.', '2025-11-03 16:11:15.481814 +00:00', '2025-11-03 16:11:15.481814 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 23, 9, null, '솜 대신 휴지 넣어도 되나요?', '2025-11-03 16:11:15.505678 +00:00', '2025-11-03 16:11:15.505678 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 23, 1, 133, '가능하지만 쉽게 눌릴 수 있습니다. 솜이나 헌 옷 조각이 좋아요.', '2025-11-03 16:11:15.505678 +00:00', '2025-11-03 16:11:15.505678 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 23, 20, null, '거울은 어떤 걸 써야 하나요?', '2025-11-03 16:11:15.505678 +00:00', '2025-11-03 16:11:15.505678 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 23, 1, 135, '가벼운 플라스틱 거울을 추천드려요.', '2025-11-03 16:11:15.505678 +00:00', '2025-11-03 16:11:15.505678 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 23, 28, null, '벽에 거는 끈은 어떻게 달아요?', '2025-11-03 16:11:15.505678 +00:00', '2025-11-03 16:11:15.505678 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 23, 1, 137, '실이나 리본으로 원형 가장자리에 꿰매서 연결하세요.', '2025-11-03 16:11:15.505678 +00:00', '2025-11-03 16:11:15.505678 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 24, 18, null, '플라스틱 말고 종이로 해도 되나요?', '2025-11-03 16:11:15.523870 +00:00', '2025-11-03 16:11:15.523870 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 24, 1, 139, '종이는 물에 약해서 금방 망가집니다. 플라스틱이 좋아요.', '2025-11-03 16:11:15.523870 +00:00', '2025-11-03 16:11:15.523870 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 24, 40, null, '뚫는 구멍은 몇 개가 좋아요?', '2025-11-03 16:11:15.523870 +00:00', '2025-11-03 16:11:15.523870 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 24, 1, 141, '5~6개 정도면 물 빠짐이 잘 됩니다.', '2025-11-03 16:11:15.523870 +00:00', '2025-11-03 16:11:15.523870 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 24, 22, null, '색칠해도 괜찮나요?', '2025-11-03 16:11:15.523870 +00:00', '2025-11-03 16:11:15.523870 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 24, 1, 143, '가능해요! 아크릴 물감으로 칠하면 잘 안 벗겨져요.', '2025-11-03 16:11:15.523870 +00:00', '2025-11-03 16:11:15.523870 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 25, 44, null, '숟가락 대신 포크 써도 돼요?', '2025-11-03 16:11:15.544557 +00:00', '2025-11-03 16:11:15.544557 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 25, 1, 145, '가능하지만 포크는 모양이 날카로워 조심하세요.', '2025-11-03 16:11:15.544557 +00:00', '2025-11-03 16:11:15.544557 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 25, 27, null, '전구는 어떤 종류 써야 하나요?', '2025-11-03 16:11:15.544557 +00:00', '2025-11-03 16:11:15.544557 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 25, 1, 147, 'LED 전구를 써야 열에 안전합니다.', '2025-11-03 16:11:15.544557 +00:00', '2025-11-03 16:11:15.544557 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 25, 13, null, '몇 개 정도 붙여야 하나요?', '2025-11-03 16:11:15.544557 +00:00', '2025-11-03 16:11:15.544557 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 25, 1, 149, '보통 40~50개 정도면 충분한 크기입니다.', '2025-11-03 16:11:15.544557 +00:00', '2025-11-03 16:11:15.544557 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 26, 33, null, '병 모양은 아무거나 괜찮나요?', '2025-11-03 16:11:15.567470 +00:00', '2025-11-03 16:11:15.567470 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 26, 1, 151, '둥근 형태가 식물 심기엔 가장 좋아요.', '2025-11-03 16:11:15.567470 +00:00', '2025-11-03 16:11:15.567470 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 26, 42, null, '칼 대신 가위로 잘라도 되나요?', '2025-11-03 16:11:15.567470 +00:00', '2025-11-03 16:11:15.567470 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 26, 1, 153, '네, 가위로도 가능합니다. 단, 모서리 주의하세요.', '2025-11-03 16:11:15.567470 +00:00', '2025-11-03 16:11:15.567470 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 26, 7, null, '꾸밀 때 추천 재료 있나요?', '2025-11-03 16:11:15.567470 +00:00', '2025-11-03 16:11:15.567470 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 26, 1, 155, '마스킹테이프나 아크릴 물감이 잘 어울립니다.', '2025-11-03 16:11:15.567470 +00:00', '2025-11-03 16:11:15.567470 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 27, 25, null, '테이프 없이 고정할 수 있나요?', '2025-11-03 16:11:15.589432 +00:00', '2025-11-03 16:11:15.589432 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 27, 1, 157, '신문지를 겹겹이 접으면 테이프 없어도 잘 고정돼요.', '2025-11-03 16:11:15.589432 +00:00', '2025-11-03 16:11:15.589432 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 27, 14, null, '젖은 쓰레기도 넣을 수 있나요?', '2025-11-03 16:11:15.589432 +00:00', '2025-11-03 16:11:15.589432 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 27, 1, 159, '젖은 쓰레기는 비닐 덧대서 사용하는 게 좋아요.', '2025-11-03 16:11:15.589432 +00:00', '2025-11-03 16:11:15.589432 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 27, 31, null, 'A4용지로도 가능할까요?', '2025-11-03 16:11:15.589432 +00:00', '2025-11-03 16:11:15.589432 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 27, 1, 161, '크기가 작지만, 소형 쓰레기통엔 가능합니다.', '2025-11-03 16:11:15.589432 +00:00', '2025-11-03 16:11:15.589432 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 28, 38, null, '포켓은 꼭 만들어야 하나요?', '2025-11-03 16:11:15.653817 +00:00', '2025-11-03 16:11:15.653817 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 28, 1, 163, '선택사항이에요! 메모나 스티커 넣을 용도로 유용합니다.', '2025-11-03 16:11:15.653817 +00:00', '2025-11-03 16:11:15.653817 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 28, 45, null, '달력 대신 사진 붙여도 될까요?', '2025-11-03 16:11:15.653817 +00:00', '2025-11-03 16:11:15.653817 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 28, 1, 165, '물론이에요. 사진 캘린더로도 충분히 예뻐요.', '2025-11-03 16:11:15.653817 +00:00', '2025-11-03 16:11:15.653817 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 28, 10, null, '벽에 붙일 때 뭐가 좋아요?', '2025-11-03 16:11:15.653817 +00:00', '2025-11-03 16:11:15.653817 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 28, 1, 167, '양면테이프나 블루택을 쓰면 흔적이 남지 않아요.', '2025-11-03 16:11:15.653817 +00:00', '2025-11-03 16:11:15.653817 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 5, null, '몰드 말고 일회용 컵 써도 괜찮을까요?', '2025-11-04 02:52:18.044173 +00:00', '2025-11-04 02:52:18.044173 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 8, null, '색 조합 너무 예뻐요! 인테리어에도 잘 어울릴 듯해요 💙', '2025-11-04 02:52:18.044173 +00:00', '2025-11-04 02:52:18.044173 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 14, null, '향 오일은 아무거나 써도 되나요?', '2025-11-04 02:52:18.044173 +00:00', '2025-11-04 02:52:18.044173 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 1, 169, '일회용 컵도 사용 가능하지만, 실리콘 몰드가 재사용되어 더 친환경적이에요 😊', '2025-11-04 02:52:18.069757 +00:00', '2025-11-04 02:52:18.069757 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 6, null, '군번줄 대신 끈으로 연결해도 될까요?', '2025-11-04 02:52:18.089480 +00:00', '2025-11-04 02:52:18.089480 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 10, null, '아이랑 같이 만들어봤는데 너무 귀여워요 💚', '2025-11-04 02:52:18.089480 +00:00', '2025-11-04 02:52:18.089480 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 17, null, '바다유리는 어디서 구할 수 있나요?', '2025-11-04 02:52:18.089480 +00:00', '2025-11-04 02:52:18.089480 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 1, 173, '끈도 괜찮아요! 단, 무게를 잘 지탱할 수 있는 재질이면 더 좋아요 🌿', '2025-11-04 02:52:18.106477 +00:00', '2025-11-04 02:52:18.106477 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 11, null, '지점토 대신 일반 점토 써도 되나요?', '2025-11-04 02:52:18.127140 +00:00', '2025-11-04 02:52:18.127140 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 13, null, '색감 너무 예뻐요. 인테리어 포인트로 딱이에요!', '2025-11-04 02:52:18.127140 +00:00', '2025-11-04 02:52:18.127140 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 19, null, '초 대신 LED 캔들 써도 괜찮겠죠?', '2025-11-04 02:52:18.127140 +00:00', '2025-11-04 02:52:18.127140 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 1, 179, '네, LED 캔들도 안전하고 좋아요! 어린이 작업용으로 추천드려요 🕯', '2025-11-04 02:52:18.143764 +00:00', '2025-11-04 02:52:18.143764 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 5, null, '몰드 대신 종이컵 써도 괜찮을까요?', '2025-11-04 02:55:26.228124 +00:00', '2025-11-04 02:55:26.228124 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 8, null, '향 너무 좋아 보여요! 인테리어에도 잘 어울릴 듯해요 💐', '2025-11-04 02:55:26.228124 +00:00', '2025-11-04 02:55:26.228124 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 14, null, '굳히는 시간 짧게 줄이는 방법 있을까요?', '2025-11-04 02:55:26.228124 +00:00', '2025-11-04 02:55:26.228124 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 29, 1, 181, '종이컵도 가능하지만 실리콘 몰드가 재사용되어 더 친환경적이에요 😊', '2025-11-04 02:55:26.252093 +00:00', '2025-11-04 02:55:26.252093 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 7, null, '바다유리는 직접 주워야 하나요?', '2025-11-04 02:55:26.299886 +00:00', '2025-11-04 02:55:26.299886 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 11, null, '아이랑 같이 만들기 너무 좋아요 🐚', '2025-11-04 02:55:26.299886 +00:00', '2025-11-04 02:55:26.299886 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 18, null, '군번줄 대신 실로 연결해도 될까요?', '2025-11-04 02:55:26.299886 +00:00', '2025-11-04 02:55:26.299886 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 30, 1, 187, '실도 괜찮아요! 단, 튼튼한 재질이면 좋습니다 💪', '2025-11-04 02:55:26.314361 +00:00', '2025-11-04 02:55:26.314361 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 9, null, '지점토 말고 일반 점토 써도 되나요?', '2025-11-04 02:55:26.333318 +00:00', '2025-11-04 02:55:26.333318 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 15, null, '색감 너무 예쁘네요. 인테리어용으로 완벽해요 ✨', '2025-11-04 02:55:26.333318 +00:00', '2025-11-04 02:55:26.333318 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 21, null, '초 대신 LED 캔들 써도 괜찮겠죠?', '2025-11-04 02:55:26.333318 +00:00', '2025-11-04 02:55:26.333318 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 31, 1, 191, '네, LED 캔들도 안전해서 추천드립니다 🕯', '2025-11-04 02:55:26.347293 +00:00', '2025-11-04 02:55:26.347293 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 32, 10, null, '이거 공간 절약 진짜 되네요!', '2025-11-04 02:55:26.366269 +00:00', '2025-11-04 02:55:26.366269 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 32, 16, null, '뚜껑 대신 고리형 클립 써도 될까요?', '2025-11-04 02:55:26.366269 +00:00', '2025-11-04 02:55:26.366269 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 32, 19, null, '옷걸이 무게 버틸까요?', '2025-11-04 02:55:26.366269 +00:00', '2025-11-04 02:55:26.366269 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 32, 1, 194, '고리형 클립도 가능하지만 뚜껑이 훨씬 튼튼합니다 👕', '2025-11-04 02:55:26.381160 +00:00', '2025-11-04 02:55:26.381160 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 33, 12, null, '캔뚜껑으로 정리라니 아이디어 굿이에요!', '2025-11-04 02:55:26.393275 +00:00', '2025-11-04 02:55:26.393275 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 33, 18, null, '고무줄 없으면 테이프로 고정해도 될까요?', '2025-11-04 02:55:26.393275 +00:00', '2025-11-04 02:55:26.393275 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 33, 23, null, '선 여러 개 한 번에 묶을 때도 괜찮을까요?', '2025-11-04 02:55:26.393275 +00:00', '2025-11-04 02:55:26.393275 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 33, 1, 198, '테이프보다 고무줄이 더 오래갑니다 ⚡', '2025-11-04 02:55:26.407264 +00:00', '2025-11-04 02:55:26.407264 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 34, 6, null, '천 재질은 아무거나 괜찮나요?', '2025-11-04 02:55:26.429189 +00:00', '2025-11-04 02:55:26.429189 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 34, 17, null, '아이랑 같이 해봤는데 너무 귀여워요 👕', '2025-11-04 02:55:26.429189 +00:00', '2025-11-04 02:55:26.429189 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 34, 25, null, '손바느질로도 가능할까요?', '2025-11-04 02:55:26.429189 +00:00', '2025-11-04 02:55:26.429189 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 34, 1, 203, '네! 손바느질도 가능합니다. 꼼꼼히 하면 충분히 튼튼해요 🪡', '2025-11-04 02:55:26.447072 +00:00', '2025-11-04 02:55:26.447072 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 35, 8, null, '끈 대신 지퍼 달아도 될까요?', '2025-11-04 02:55:26.461682 +00:00', '2025-11-04 02:55:26.461682 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 35, 13, null, '이거 재활용 천으로 하면 좋겠네요 ♻️', '2025-11-04 02:55:26.461682 +00:00', '2025-11-04 02:55:26.461682 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 35, 20, null, '세탁 가능하죠?', '2025-11-04 02:55:26.461682 +00:00', '2025-11-04 02:55:26.461682 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 35, 1, 205, '지퍼형으로 바꾸면 더 실용적이에요 😊', '2025-11-04 02:55:26.479385 +00:00', '2025-11-04 02:55:26.479385 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 42, 22, null, '자갈 없으면 대신 뭐 써요?', '2025-11-04 02:55:26.498931 +00:00', '2025-11-04 02:55:26.498931 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 42, 26, null, '식물 대신 조화도 가능하겠죠?', '2025-11-04 02:55:26.498931 +00:00', '2025-11-04 02:55:26.498931 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 42, 30, null, '물이 오래가나요?', '2025-11-04 02:55:26.498931 +00:00', '2025-11-04 02:55:26.498931 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 42, 1, 209, '굵은 모래나 자갈 대체도 가능합니다 🌿', '2025-11-04 02:55:26.512324 +00:00', '2025-11-04 02:55:26.512324 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 43, 24, null, '거울 붙이는 접착제 추천 있을까요?', '2025-11-04 02:55:26.542633 +00:00', '2025-11-04 02:55:26.542633 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 43, 29, null, '시트지 색감 조합 너무 예뻐요 💫', '2025-11-04 02:55:26.542633 +00:00', '2025-11-04 02:55:26.542633 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 43, 35, null, '물 새지 않게 하려면 어떻게 해야 하나요?', '2025-11-04 02:55:26.542633 +00:00', '2025-11-04 02:55:26.542633 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 43, 1, 215, '실리콘 접착제를 사용하면 물이 새지 않습니다 🪞', '2025-11-04 02:55:26.554099 +00:00', '2025-11-04 02:55:26.554099 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 44, 33, null, '잼병 페인트 칠할 때 냄새 심한가요?', '2025-11-04 02:55:26.568525 +00:00', '2025-11-04 02:55:26.568525 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 44, 36, null, '유리병 말고 플라스틱병도 되나요?', '2025-11-04 02:55:26.568525 +00:00', '2025-11-04 02:55:26.568525 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 44, 40, null, '리본 장식 추가해도 예쁘겠어요 🎀', '2025-11-04 02:55:26.568525 +00:00', '2025-11-04 02:55:26.568525 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 44, 1, 218, '플라스틱은 페인트가 잘 안 붙으니 유리가 좋아요 👍', '2025-11-04 02:55:26.640863 +00:00', '2025-11-04 02:55:26.640863 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 45, 31, null, '스티커는 어떤 종류 써야 하나요?', '2025-11-04 02:55:26.655512 +00:00', '2025-11-04 02:55:26.655512 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 45, 37, null, '페인트가 잘 안 마르는데 팁 있을까요?', '2025-11-04 02:55:26.655512 +00:00', '2025-11-04 02:55:26.655512 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 45, 41, null, '이거 선물용으로도 예쁘네요 🕯', '2025-11-04 02:55:26.655512 +00:00', '2025-11-04 02:55:26.655512 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 45, 1, 221, '비닐 스티커나 데코용 마스킹테이프가 좋습니다 💡', '2025-11-04 02:55:26.669644 +00:00', '2025-11-04 02:55:26.669644 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 46, 28, null, '퍼티는 어디서 구매하나요?', '2025-11-04 02:55:26.683275 +00:00', '2025-11-04 02:55:26.683275 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 46, 32, null, '이거 초보자도 가능할까요?', '2025-11-04 02:55:26.683275 +00:00', '2025-11-04 02:55:26.683275 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 46, 39, null, '타일 대신 돌 조각도 괜찮나요?', '2025-11-04 02:55:26.683275 +00:00', '2025-11-04 02:55:26.683275 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 46, 1, 227, '돌 조각도 괜찮아요! 단, 두께만 일정하면 됩니다 🪵', '2025-11-04 02:55:26.700678 +00:00', '2025-11-04 02:55:26.700678 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 47, 34, null, '냄새 심하지 않나요?', '2025-11-04 02:55:26.715227 +00:00', '2025-11-04 02:55:26.715227 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 47, 38, null, 'EM 발효액은 직접 만들어야 하나요?', '2025-11-04 02:55:26.715227 +00:00', '2025-11-04 02:55:26.715227 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 47, 42, null, '효과가 바로 보이나요?', '2025-11-04 02:55:26.715227 +00:00', '2025-11-04 02:55:26.715227 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 47, 1, 229, '처음엔 약간 냄새가 나지만 금방 줄어듭니다 🌱', '2025-11-04 02:55:26.730572 +00:00', '2025-11-04 02:55:26.730572 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 49, 29, null, '이거 냉장고에도 효과 있나요?', '2025-11-04 02:55:26.751131 +00:00', '2025-11-04 02:55:26.751131 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 49, 33, null, '필터지 말고 천주머니도 되나요?', '2025-11-04 02:55:26.751131 +00:00', '2025-11-04 02:55:26.751131 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 49, 47, null, '향 유지기간이 얼마나 되나요?', '2025-11-04 02:55:26.751131 +00:00', '2025-11-04 02:55:26.751131 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 49, 1, 233, '네, 냉장고용으로도 아주 좋아요 ☕', '2025-11-04 02:55:26.765015 +00:00', '2025-11-04 02:55:26.765015 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 51, 35, null, '계란 껍질은 생껍질 써도 되나요?', '2025-11-04 02:55:26.783270 +00:00', '2025-11-04 02:55:26.783270 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 51, 43, null, '세제 대신 베이킹소다 가능할까요?', '2025-11-04 02:55:26.783270 +00:00', '2025-11-04 02:55:26.783270 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 51, 49, null, '정말 깨끗하게 닦이네요 👍', '2025-11-04 02:55:26.783270 +00:00', '2025-11-04 02:55:26.783270 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 51, 1, 238, '베이킹소다도 괜찮아요. 껍질은 깨끗이 씻어서 사용하세요 🍳', '2025-11-04 02:55:26.801390 +00:00', '2025-11-04 02:55:26.801390 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 52, 36, null, '페인트마카 냄새 심하지 않나요?', '2025-11-04 02:55:26.819554 +00:00', '2025-11-04 02:55:26.819554 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 52, 45, null, '마카 말고 아크릴물감으로도 되나요?', '2025-11-04 02:55:26.819554 +00:00', '2025-11-04 02:55:26.819554 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 52, 48, null, '이거 아이들과 해도 괜찮을까요?', '2025-11-04 02:55:26.819554 +00:00', '2025-11-04 02:55:26.819554 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 52, 1, null, '아크릴물감도 가능합니다. 다만 건조 시간은 좀 더 필요해요 🎨', '2025-11-04 02:55:26.837590 +00:00', '2025-11-04 02:55:26.837590 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 53, 37, null, '컵은 열에 강한 게 좋을까요?', '2025-11-04 02:55:26.857908 +00:00', '2025-11-04 02:55:26.857908 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 53, 44, null, '붙이는 스티커가 물에 안 떨어지나요?', '2025-11-04 02:55:26.857908 +00:00', '2025-11-04 02:55:26.857908 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 53, 46, null, '선물용으로 해봐야겠어요 🎁', '2025-11-04 02:55:26.857908 +00:00', '2025-11-04 02:55:26.857908 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 53, 1, 245, '열에도 강하지만 내열유리를 추천드립니다 ☕', '2025-11-04 02:55:26.874077 +00:00', '2025-11-04 02:55:26.874077 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 54, 38, null, '철망 감쌀 때 손 안 다칠까요?', '2025-11-04 02:55:26.894882 +00:00', '2025-11-04 02:55:26.894882 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 54, 47, null, '바다유리 크기는 어느 정도가 좋아요?', '2025-11-04 02:55:26.894882 +00:00', '2025-11-04 02:55:26.894882 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 54, 50, null, '이거 커플템으로도 좋겠네요 💖', '2025-11-04 02:55:26.894882 +00:00', '2025-11-04 02:55:26.894882 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 54, 1, 249, '철망은 부드러운 코팅 와이어를 사용하면 안전해요 🧵', '2025-11-04 02:55:26.913107 +00:00', '2025-11-04 02:55:26.913107 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 55, 39, null, '가죽에 문지르면 얼룩 안 남나요?', '2025-11-04 02:55:26.928280 +00:00', '2025-11-04 02:55:26.928280 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 55, 48, null, '껍질 냄새가 좀 남을까요?', '2025-11-04 02:55:26.928280 +00:00', '2025-11-04 02:55:26.928280 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 55, 50, null, '이거 진짜 광택 나요 😳', '2025-11-04 02:55:26.928280 +00:00', '2025-11-04 02:55:26.928280 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 55, 1, 254, '부드럽게 닦고 마른 천으로 마무리하면 냄새도 거의 없습니다 🍌', '2025-11-04 02:55:26.942359 +00:00', '2025-11-04 02:55:26.942359 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 56, 41, null, '비율 조정해도 되나요?', '2025-11-04 02:55:26.953738 +00:00', '2025-11-04 02:55:26.953738 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 56, 43, null, '화분 냄새 안 나죠?', '2025-11-04 02:55:26.953738 +00:00', '2025-11-04 02:55:26.953738 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 56, 49, null, '커피 찌꺼기 말린 걸 써야 하나요?', '2025-11-04 02:55:26.953738 +00:00', '2025-11-04 02:55:26.953738 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 56, 1, 259, '말린 찌꺼기가 곰팡이 방지에 더 좋아요 ☕', '2025-11-04 02:55:26.965698 +00:00', '2025-11-04 02:55:26.965698 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 57, 44, null, '껍질로 닦을 때 미끄럽지 않나요?', '2025-11-04 02:55:26.977843 +00:00', '2025-11-04 02:55:26.977843 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 57, 46, null, '냄새 남지 않나요?', '2025-11-04 02:55:26.977843 +00:00', '2025-11-04 02:55:26.977843 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 57, 50, null, '광택이 진짜 나네요! 놀라워요 🍉', '2025-11-04 02:55:26.977843 +00:00', '2025-11-04 02:55:26.977843 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 57, 1, 261, '닦은 뒤 마른 천으로 마무리하면 미끄럽지 않아요 ✨', '2025-11-04 02:55:26.990089 +00:00', '2025-11-04 02:55:26.990089 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 59, 42, null, '껍질이 너무 잘 부서지는데 괜찮나요?', '2025-11-04 02:55:27.003939 +00:00', '2025-11-04 02:55:27.003939 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 59, 45, null, '베이킹소다랑 같이 써도 돼요?', '2025-11-04 02:55:27.003939 +00:00', '2025-11-04 02:55:27.003939 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 59, 48, null, '욕실 청소에 딱이네요 🛁', '2025-11-04 02:55:27.003939 +00:00', '2025-11-04 02:55:27.003939 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 59, 1, 266, '네, 베이킹소다와 함께 써도 효과가 좋아요 🧽', '2025-11-04 02:55:27.020430 +00:00', '2025-11-04 02:55:27.020430 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 60, 43, null, '귤껍질 말린 것도 되나요?', '2025-11-04 02:55:27.035843 +00:00', '2025-11-04 02:55:27.035843 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 60, 47, null, '과일껍질 대신 커피찌꺼기도 되나요?', '2025-11-04 02:55:27.035843 +00:00', '2025-11-04 02:55:27.035843 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 60, 49, null, '이거 꿀팁이네요 🍊', '2025-11-04 02:55:27.035843 +00:00', '2025-11-04 02:55:27.035843 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 60, 1, 269, '말린 껍질도 좋아요! 향이 더 오래가요 🍋', '2025-11-04 02:55:27.049187 +00:00', '2025-11-04 02:55:27.049187 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 62, 45, null, '솜 대신 휴지 넣어도 될까요?', '2025-11-04 02:55:27.063206 +00:00', '2025-11-04 02:55:27.063206 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 62, 47, null, '하트 모양 너무 귀여워요 💖', '2025-11-04 02:55:27.063206 +00:00', '2025-11-04 02:55:27.063206 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 62, 49, null, '끈이 잘 떨어지지 않나요?', '2025-11-04 02:55:27.063206 +00:00', '2025-11-04 02:55:27.063206 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 62, 1, 273, '휴지보다 솜이 모양이 오래 유지됩니다 🧷', '2025-11-04 02:55:27.075673 +00:00', '2025-11-04 02:55:27.075673 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 63, 46, null, '천은 아무색이나 괜찮나요?', '2025-11-04 02:55:27.090931 +00:00', '2025-11-04 02:55:27.090931 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 63, 48, null, '매듭 묶는 거 어려워요 😅', '2025-11-04 02:55:27.090931 +00:00', '2025-11-04 02:55:27.090931 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 63, 50, null, '한복 느낌 너무 예뻐요 🇰🇷', '2025-11-04 02:55:27.090931 +00:00', '2025-11-04 02:55:27.090931 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 63, 1, 277, '색상은 자유롭게, 다만 너무 얇은 천은 피해주세요 🎀', '2025-11-04 02:55:27.103506 +00:00', '2025-11-04 02:55:27.103506 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 64, 47, null, '진짜 먹을 수 있나요?', '2025-11-04 02:55:27.126277 +00:00', '2025-11-04 02:55:27.126277 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 64, 49, null, '천에서 사탕이 되다니 신기해요 🍬', '2025-11-04 02:55:27.126277 +00:00', '2025-11-04 02:55:27.126277 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 64, 50, null, '색소는 천연 거 써야겠네요!', '2025-11-04 02:55:27.126277 +00:00', '2025-11-04 02:55:27.126277 +00:00');
INSERT INTO public.qna_comments ( recycling_id, user_id, parent_id, content, created_at, updated_at) VALUES ( 64, 1, 281, '네, 식용 포도당 기반이라 안전하지만 식품용은 아닙니다 ⚗️', '2025-11-04 02:55:27.145695 +00:00', '2025-11-04 02:55:27.145695 +00:00');
