# CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 
# 이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 지정된 옵션이 포함된 자동차가 종류별로 몇 대 인지 / OPTIONS
# 쿼리 계산 방법 : WHERE OR / GROUP BY / COUNT / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : CAR_RENTAL_COMPANY_CAR
# Join KEY :
# 데이터 특징 :

SELECT
    CAR_TYPE,
    COUNT(DISTINCT CAR_ID) AS CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE
    OPTIONS LIKE "%가죽시트%" OR
    OPTIONS LIKE "%통풍시트%" OR
    OPTIONS LIKE "%열선시트%"
GROUP BY
    CAR_TYPE
ORDER BY
    CAR_TYPE ASC
    