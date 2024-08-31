# 다음은 어느 자동차 대여 회사에서 대여 중인 자동차들의 정보를 담은 CAR_RENTAL_COMPANY_CAR 테이블과 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다. CAR_RENTAL_COMPANY_CAR 테이블은 아래와 같은 구조로 되어있으며, CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 는 각각 자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트를 나타냅니다.

# 자동차 종류는 '세단', 'SUV', '승합차', '트럭', '리무진' 이 있습니다. 자동차 옵션 리스트는 콤마(',')로 구분된 키워드 리스트(예: '열선시트', '스마트키', '주차감지센서')로 되어있으며, 키워드 종류는 '주차감지센서', '스마트키', '네비게이션', '통풍시트', '열선시트', '후방카메라', '가죽시트' 가 있습니다.
# CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

# 문제
# CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 자동차 종류가 '세단'인 자동차들 중 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력하는 SQL문을 작성해주세요. 자동차 ID 리스트는 중복이 없어야 하며, 자동차 ID를 기준으로 내림차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 자동차 종류 세단 중에서 대여시작 기록이 10월1일~ , 내림차순 / CAR_TYPE, START_DATE
# 쿼리 계산 방법 : LEFT JOIN / WHERE / SELECT DISTINCT / ORDER BY DESC
# 데이터의 기간 : START_DATE = 2022-10-01~
# 사용할 테이블 : CAR_RENTAL_COMPANY_CAR , CAR_RENTAL_COMPANY_RENTAL_HISTORY
# Join KEY : CAR_ID
# 데이터 특징 :

SELECT
    DISTINCT CAR.CAR_ID
FROM CAR_RENTAL_COMPANY_CAR AS CAR
LEFT JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY AS HIS
ON CAR.CAR_ID = HIS.CAR_ID
WHERE
    CAR.CAR_TYPE = '세단' AND
    HIS.START_DATE >= '2022-10-01'
ORDER BY
    CAR.CAR_ID DESC
    

