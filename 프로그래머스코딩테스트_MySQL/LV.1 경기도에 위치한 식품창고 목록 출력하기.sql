-- FOOD_WAREHOUSE 테이블에서 경기도에 위치한 창고의 ID, 이름, 주소, 냉동시설 여부를 조회하는 SQL문을 작성해주세요. 
-- 이때 냉동시설 여부가 NULL인 경우, 'N'으로 출력시켜 주시고 결과는 창고 ID를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 경기도에 위치한 창고 정보 / 냉동시설이 NULL이면 N 출력 / 창고 ID 오름차순
# 쿼리 계산 방법 : LIKE "%경기도%" / COALESCE(FREEZER_YN, 'N') / WAREHOUSE_ID ASC
# 데이터의 기간 : 
# 사용할 테이블 : FOOD_WAREHOUSE
# Join KEY :
# 데이터의 특징 :

SELECT
    WAREHOUSE_ID,
    WAREHOUSE_NAME,
    ADDRESS,
    COALESCE(FREEZER_YN, 'N') AS FREEZER_YN
FROM FOOD_WAREHOUSE
WHERE
    ADDRESS LIKE "%경기도%"
ORDER BY
    WAREHOUSE_ID ASC