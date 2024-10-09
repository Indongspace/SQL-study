# 다음은 어느 자동차 대여 회사에서 대여 중인 자동차들의 정보를 담은 CAR_RENTAL_COMPANY_CAR 테이블과 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 자동차 종류 별 대여 기간 종류 별 할인 정책 정보를 담은 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블 입니다.

# CAR_RENTAL_COMPANY_CAR 테이블은 아래와 같은 구조로 되어있으며, CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 는 각각 자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트를 나타냅니다.

# 자동차 종류는 '세단', 'SUV', '승합차', '트럭', '리무진' 이 있습니다. 자동차 옵션 리스트는 콤마(',')로 구분된 키워드 리스트(예: ''열선시트,스마트키,주차감지센서'')로 되어있으며, 키워드 종류는 '주차감지센서', '스마트키', '네비게이션', '통풍시트', '열선시트', '후방카메라', '가죽시트' 가 있습니다.

# CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

# CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블은 아래와 같은 구조로 되어있으며, PLAN_ID, CAR_TYPE, DURATION_TYPE, DISCOUNT_RATE 는 각각 요금 할인 정책 ID, 자동차 종류, 대여 기간 종류, 할인율(%)을 나타냅니다.

# 할인율이 적용되는 대여 기간 종류로는 '7일 이상' (대여 기간이 7일 이상 30일 미만인 경우), '30일 이상' (대여 기간이 30일 이상 90일 미만인 경우), '90일 이상' (대여 기간이 90일 이상인 경우) 이 있습니다. 대여 기간이 7일 미만인 경우 할인정책이 없습니다.

# 문제
# CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 자동차 종류가 '트럭'인 자동차의 대여 기록에 대해서 대여 기록 별로 대여 금액(컬럼명: FEE)을 구하여 대여 기록 ID와 대여 금액 리스트를 출력하는 SQL문을 작성해주세요. 결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 대여 기록 ID를 기준으로 내림차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 :
# 쿼리 계산 방법 :
# 데이터의 기간 :
# 사용할 테이블 : CAR_RENTAL_COMPANY_CAR, CAR_RENTAL_COMPANY_RENTAL_HISTORY, CAR_RENTAL_COMPANY_DISCOUNT_PLAN 
# Join KEY : CAR_ID / CAR_TYPE
# 데이터 특징 :
WITH HIS AS (
    SELECT
        *,
        CASE
            WHEN END_DATE - START_DATE BETWEEN 7 AND 29 THEN '7일 이상'
            WHEN END_DATE - START_DATE BETWEEN 30 AND 89 THEN '30일 이상'
            WHEN END_DATE - START_DATE >= 90 THEN '90일 이상'
        ELSE NULL
        END AS DISCOUNT_POL,
        END_DATE - START_DATE AS DIFF
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
), HIS_AND_CAR AS (
    SELECT
        CAR.CAR_ID,
        HIS.HISTORY_ID,
        CAR.CAR_TYPE,
        HIS.DISCOUNT_POL,
        CASE
            WHEN END_DATE - START_DATE = 0 THEN 1
            ELSE END_DATE - START_DATE
        END AS DIFF
    FROM CAR_RENTAL_COMPANY_CAR AS CAR
    INNER JOIN HIS
    ON CAR.CAR_ID = HIS.CAR_ID
    WHERE
        CAR.CAR_TYPE = '트럭'
)

SELECT
    DISTINCT HC.HISTORY_ID,
    CASE
        WHEN DISCOUNT_POL IS NULL THEN ROUND(DIFF * 26000)
        WHEN DISCOUNT_POL = '7일 이상' THEN ROUND(DIFF * 26000 * 0.95)
        WHEN DISCOUNT_POL = '30일 이상' THEN ROUND(DIFF * 26000 * 0.93)
        WHEN DISCOUNT_POL = '90일 이상' THEN ROUND(DIFF * 26000 * 0.9)
    END AS FEE
FROM HIS_AND_CAR AS HC
INNER JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN AS DIS
ON HC.CAR_TYPE = DIS.CAR_TYPE
ORDER BY
    FEE DESC,
    HISTORY_ID DESC
    

