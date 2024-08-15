# 다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다. CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

# CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요. 결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 
# 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 8~10월까지 총 대여 횟수 5회 이상, 월별 자동차 ID 별 총 대여 횟수 출력, 오름차순 / START_DATE, CAR_ID
# 쿼리 계산 방법 : WHERE START_DATE 8~10, GROUP BY, COUNT(CAR_ID), HAVING, ORDER BY
# 데이터의 기간 : 2022년 8월 ~ 2022년 10월
# 사용할 테이블 : CAR_RENTAL_COMPANY_RENTAL_HISTORY 
# Join KEY :
# 데이터 특징 :

SELECT
    MONTH,
    CAR_ID,
    RECORDS
FROM (SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(*) AS RECORDS
      FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
      WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31' 
      AND   CAR_ID IN (SELECT CAR_ID 
                       FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
                       WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
                       GROUP BY CAR_ID
                       HAVING COUNT(*) >= 5)
     GROUP BY
        MONTH,
        CAR_ID
     ) AS RENT
ORDER BY
    MONTH ASC,
    CAR_ID DESC

    