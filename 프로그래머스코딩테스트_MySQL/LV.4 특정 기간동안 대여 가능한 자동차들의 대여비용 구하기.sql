# 다음은 어느 자동차 대여 회사에서 대여 중인 자동차들의 정보를 담은 CAR_RENTAL_COMPANY_CAR 테이블과 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 자동차 종류 별 대여 기간 종류 별 할인 정책 정보를 담은 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블 입니다.

# CAR_RENTAL_COMPANY_CAR 테이블은 아래와 같은 구조로 되어있으며, CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 는 각각 자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트를 나타냅니다.

# 자동차 종류는 '세단', 'SUV', '승합차', '트럭', '리무진' 이 있습니다. 자동차 옵션 리스트는 콤마(',')로 구분된 키워드 리스트(예: ''열선시트,스마트키,주차감지센서'')로 되어있으며, 키워드 종류는 '주차감지센서', '스마트키', '네비게이션', '통풍시트', '열선시트', '후방카메라', '가죽시트' 가 있습니다.

# CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

# CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블은 아래와 같은 구조로 되어있으며, PLAN_ID, CAR_TYPE, DURATION_TYPE, DISCOUNT_RATE 는 각각 요금 할인 정책 ID, 자동차 종류, 대여 기간 종류, 할인율(%)을 나타냅니다.

# 할인율이 적용되는 대여 기간 종류로는 '7일 이상' (대여 기간이 7일 이상 30일 미만인 경우), '30일 이상' (대여 기간이 30일 이상 90일 미만인 경우), '90일 이상' (대여 기간이 90일 이상인 경우) 이 있습니다. 대여 기간이 7일 미만인 경우 할인정책이 없습니다.

# 문제
# CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 자동차 종류가 '세단' 또는 'SUV' 인 자동차 중 2022년 11월 1일부터 2022년 11월 30일까지 대여 가능하고 30일간의 대여 금액이 50만원 이상 200만원 미만인 자동차에 대해서 자동차 ID, 자동차 종류, 대여 금액(컬럼명: FEE) 리스트를 출력하는 SQL문을 작성해주세요. 결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 자동차 종류를 기준으로 오름차순 정렬, 자동차 종류까지 같은 경우 자동차 ID를 기준으로 내림차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 11-01 ~ 11-30일까지 대여할 수 있는 세단 OR SUV의 FEE 계산
# 쿼리 계산 방법 : 1. CAR_RENTAL_COMPANY_CAR 테이블에서 SUV와 세단의 정보 추출 -> 2. CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022-11-01 ~ 2022-11-30 까지 예약되어 있는 자동차 정보만 LEFT JOIN하여 NON_ABLE_SUV_OR_SEDAN 생성 -> 3. CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 DURATION_TYPE = 30일 이상 추출 -> 4. INNER JOIN CAR_TYPE으로. NON_ABLE_SUV_OR_SEDAN 에 30일 이상의 DISCOUNT_RATE 정보를 붙인다. 조건문으로 HISTORY_ID 가 없는(11월에 예약이 없는) 기록 출력, FEE의 한도설정 & ORDER BY
# 데이터의 기간 : 2022-11-01 ~ 2022-11-30
# 사용할 테이블 : CAR_RENTAL_COMPANY_CAR, CAR_RENTAL_COMPANY_RENTAL_HISTORY, CAR_RENTAL_COMPANY_DISCOUNT_PLAN
# Join KEY : CAR_ID, CAR_TYPE
# 데이터 특징 :

# CAR_RENTAL_COMPANY_CAR 테이블에서 SUV와 세단의 정보 추출
WITH SUV_OR_SEDAN AS (
    SELECT
        CAR_ID,
        CAR_TYPE,
        DAILY_FEE
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE
        CAR_TYPE = 'SUV' OR 
        CAR_TYPE = '세단'
), # CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022-11-01 ~ 2022-11-30 까지 예약되어 있는 자동차 정보만 LEFT JOIN하여 NON_ABLE_SUV_OR_SEDAN 생성 
NON_ABLE_SUV_OR_SEDAN AS (
    SELECT
        SS.CAR_ID,
        SS.CAR_TYPE,
        SS.DAILY_FEE,
        HIS.HISTORY_ID
    FROM SUV_OR_SEDAN AS SS
    LEFT JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY  AS HIS
    ON SS.CAR_ID = HIS.CAR_ID
    AND HIS.START_DATE <= '2022-11-30'
    AND HIS.END_DATE >= '2022-11-01'
), # CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 DURATION_TYPE = 30일 이상 추출
DIS AS (
    SELECT
        CAR_TYPE,
        DURATION_TYPE,
        DISCOUNT_RATE
    FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN 
    WHERE
        DURATION_TYPE = '30일 이상' 
) # INNER JOIN CAR_TYPE으로. NON_ABLE_SUV_OR_SEDAN 에 30일 이상의 DISCOUNT_RATE 정보를 붙인다.
# 조건문으로 HISTORY_ID 가 없는(11월에 예약이 없는) 기록 출력, FEE의 한도설정
# ORDER BY
SELECT
    NASS.CAR_ID,
    NASS.CAR_TYPE,
    ROUND(NASS.DAILY_FEE * 30 * (1 - DIS.DISCOUNT_RATE / 100)) AS FEE
FROM NON_ABLE_SUV_OR_SEDAN AS NASS
INNER JOIN DIS
ON NASS.CAR_TYPE = DIS.CAR_TYPE
WHERE
    NASS.HISTORY_ID IS NULL AND
    ROUND(NASS.DAILY_FEE * 30 * (1 - DIS.DISCOUNT_RATE / 100)) >= 500000 AND
    ROUND(NASS.DAILY_FEE * 30 * (1 - DIS.DISCOUNT_RATE / 100)) < 2000000
ORDER BY
    FEE DESC,
    CAR_TYPE ASC,
    CAR_ID DESC
    

    