# 다음은 식당의 정보를 담은 REST_INFO 테이블과 식당의 리뷰 정보를 담은 REST_REVIEW 테이블입니다. REST_INFO 테이블은 다음과 같으며 REST_ID, REST_NAME, FOOD_TYPE, VIEWS, FAVORITES, PARKING_LOT, ADDRESS, TEL은 식당 ID, 식당 이름, 음식 종류, 조회수, 즐겨찾기수, 주차장 유무, 주소, 전화번호를 의미합니다.

# REST_REVIEW 테이블은 다음과 같으며 REVIEW_ID, REST_ID, MEMBER_ID, REVIEW_SCORE, REVIEW_TEXT,REVIEW_DATE는 각각 리뷰 ID, 식당 ID, 회원 ID, 점수, 리뷰 텍스트, 리뷰 작성일을 의미합니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 서울에 있는 식당 정보출력 & 평균 리뷰점수 추출 / ADDRESS, REVIEW_SCORE
# 쿼리 계산 방법 : WITH문 (INNER JOIN -> WHERE ADDRESS 서울) -> GROUP BY ROUND(AVG) -> ORDER BY 
# 데이터의 기간 :
# 사용할 테이블 : REST_INFO, REST_REVIEW
# Join KEY : REST_ID
# 데이터 특징 :
WITH ADD_SEOUL AS (
    SELECT
        INFO.REST_ID,
        INFO.REST_NAME,
        INFO.FOOD_TYPE,
        INFO.FAVORITES,
        INFO.ADDRESS,
        REV.REVIEW_SCORE
    FROM REST_INFO AS INFO
    INNER JOIN REST_REVIEW AS REV
    ON INFO.REST_ID = REV.REST_ID
    WHERE
        INFO.ADDRESS LIKE '서울%'
)

SELECT
    REST_ID,
    REST_NAME,
    FOOD_TYPE,
    FAVORITES,
    ADDRESS,
    ROUND(AVG(REVIEW_SCORE), 2) AS SCORE
FROM ADD_SEOUL
GROUP BY
    REST_ID
ORDER BY
    SCORE DESC,
    FAVORITES DESC
    
