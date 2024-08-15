# 다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다. CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

# CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고, 대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여 자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL문을 작성해주세요. 
# 이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022년 10월 16일을 기준으로 대여 여부를 표시하는 컬럼 추가 / start_date, end_date, car_id
# 쿼리 계산 방법 : WITH, case when 10/16, 
# 데이터의 기간 : 2022-10-16 기준
# 사용할 테이블 : CAR_RENTAL_COMPANY_RENTAL_HISTORY
# Join KEY :
# 데이터 특징 :

# 1번 풀이
WITH RENT AS (
    SELECT
        CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE
        START_DATE <= '2022-10-16' AND
        END_DATE >= '2022-10-16'
)

SELECT
    DISTINCT CAR_ID,
    CASE
        WHEN CAR_ID IN (SELECT CAR_ID FROM RENT) THEN '대여중'
        ELSE '대여 가능'
    END AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
ORDER BY
    CAR_ID DESC;
    
# 2번 풀이
