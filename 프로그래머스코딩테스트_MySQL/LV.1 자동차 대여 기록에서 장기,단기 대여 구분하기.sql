-- CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일이 2022년 9월에 속하는 대여 기록에 대해서 
-- 대여 기간이 30일 이상이면 '장기 대여' 그렇지 않으면 '단기 대여' 로 표시하는 컬럼(컬럼명: RENT_TYPE)을 추가하여 대여기록을 출력하는 SQL문을 작성해주세요. 
-- 결과는 대여 기록 ID를 기준으로 내림차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022년 9월~ / 30일 이상이면 장기 아니면 단기 / id 내림차순
# 쿼리 계산 방법 : WHERE > 2022-09-01 / CASE WHEN >= 2022-09-30 / ORDER BY DESC 
# 데이터의 기간 :
# 사용할 테이블 : CAR_RENTAL_COMPANY_RENTAL_HISTORY
# Join KEY :
# 데이터 특징 :

SELECT
    HISTORY_ID,
    CAR_ID,
    DATE_FORMAT(START_DATE, '%Y-%m-%d') AS START_DATE,
    DATE_FORMAT(END_DATE, '%Y-%m-%d') AS END_DATE,
    CASE
        WHEN DATEDIFF(END_DATE, START_DATE) >= 29 THEN '장기 대여'
        ELSE '단기 대여'
    END AS RENT_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY  
WHERE
    YEAR(START_DATE) = 2022 AND MONTH(START_DATE) = 9
ORDER BY
    HISTORY_ID DESC 