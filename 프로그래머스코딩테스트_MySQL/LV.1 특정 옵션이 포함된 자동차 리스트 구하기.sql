-- CAR_RENTAL_COMPANY_CAR 테이블에서 '네비게이션' 옵션이 포함된 자동차 리스트를 출력하는 SQL문을 작성해주세요. 
-- 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 네비게이션 옵션 포함 / CAR ID 내림차순
# 쿼리 계산 방법 : LIKE "%네비게이션%" / ORDER BY CAR_ID DESC
# 데이터의 기간 : 
# 사용할 테이블 : CAR_RENTAL_COMPANY_CAR
# Join KEY :
# 데이터 특징 :

SELECT
    CAR_ID,
    CAR_TYPE,
    DAILY_FEE,
    OPTIONS
FROM CAR_RENTAL_COMPANY_CAR
WHERE
    OPTIONS LIKE '%네비게이션%'
ORDER BY
    CAR_ID DESC
    