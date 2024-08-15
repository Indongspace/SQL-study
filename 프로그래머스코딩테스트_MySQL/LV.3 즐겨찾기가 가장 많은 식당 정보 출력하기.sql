# 다음은 식당의 정보를 담은 REST_INFO 테이블입니다. REST_INFO 테이블은 다음과 같으며 REST_ID, REST_NAME, FOOD_TYPE, VIEWS, FAVORITES, PARKING_LOT, ADDRESS, TEL은 식당 ID, 식당 이름, 음식 종류, 조회수, 즐겨찾기수, 주차장 유무, 주소, 전화번호를 의미합니다.

# REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 음식종류별로 즐겨찾기 수가 가장 많은 식당정보 조회, 음식종류 내림차순/ FOOD_TYPE, FAVORITES
# 쿼리 계산 방법 : WITH, GROUP BY, IN, MAX, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : REST_INFO
# Join KEY :
# 데이터 특징 :

WITH TYPE AS (
    SELECT
        FOOD_TYPE,
        MAX(FAVORITES)
    FROM REST_INFO
    GROUP BY
        FOOD_TYPE
)

SELECT
    FOOD_TYPE,
    REST_ID,
    REST_NAME,
    FAVORITES
FROM REST_INFO
WHERE
    (FOOD_TYPE, FAVORITES) IN (SELECT * FROM TYPE)
ORDER BY
    FOOD_TYPE DESC
    