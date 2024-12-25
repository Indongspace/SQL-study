# 다음은 고객의 정보를 담은 MEMBER_PROFILE테이블과 식당의 리뷰 정보를 담은 REST_REVIEW 테이블입니다. MEMBER_PROFILE 테이블은 다음과 같으며 MEMBER_ID, MEMBER_NAME, TLNO, GENDER, DATE_OF_BIRTH는 회원 ID, 회원 이름, 회원 연락처, 성별, 생년월일을 의미합니다.

# REST_REVIEW 테이블은 다음과 같으며 REVIEW_ID, REST_ID, MEMBER_ID, REVIEW_SCORE, REVIEW_TEXT,REVIEW_DATE는 각각 리뷰 ID, 식당 ID, 회원 ID, 점수, 리뷰 텍스트, 리뷰 작성일을 의미합니다.

# 문제
# MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL문을 작성해주세요. 회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고, 결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 리뷰 가장 많이 작성한 회원 리뷰 조회 / COUNT(MEMBER_ID)
# 쿼리 계산 방법 : 1. GROUP BY COUNT()를 이용해서 id별 리뷰 개수 추출  -> 2. WHERE 조건으로 MAX(review_cnt)를 이용해서 리뷰 가장 많이 작성한 회원id 추출 -> 3. WHERE 조건으로 가장 많은 리뷰를 달은 회원(id)의 정보만 추출 -> 4. ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : MEMBER_PROFILE, REST_REVIEW
# Join KEY : MEMBER_ID
# 데이터 특징 :
WITH review_count AS (
    SELECT
        m.member_id,
        COUNT(*) AS review_cnt
    FROM member_profile AS m
    INNER JOIN rest_review AS r
    ON m.member_id = r.member_id
    GROUP BY
        m.member_id
), max_review_id AS (
    SELECT
        member_id
    FROM review_count
    WHERE
        review_cnt = (SELECT MAX(review_cnt) FROM review_count)
)
SELECT
    m.member_name,
    r.review_text,
    DATE_FORMAT(r.review_date, '%Y-%m-%d') AS review_date
FROM member_profile AS m
INNER JOIN rest_review AS r
ON m.member_id = r.member_id
WHERE
    m.member_id IN (SELECT member_id FROM max_review_id)
ORDER BY
    review_date ASC, review_text ASC 
    
    
    