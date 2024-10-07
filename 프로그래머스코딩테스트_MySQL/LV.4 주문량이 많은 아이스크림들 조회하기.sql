# 다음은 아이스크림 가게의 상반기 주문 정보를 담은 FIRST_HALF 테이블과 7월의 아이스크림 주문 정보를 담은 JULY 테이블입니다. FIRST_HALF 테이블 구조는 다음과 같으며, SHIPMENT_ID, FLAVOR, TOTAL_ORDER는 각각 아이스크림 공장에서 아이스크림 가게까지의 출하 번호, 아이스크림 맛, 상반기 아이스크림 총주문량을 나타냅니다. FIRST_HALF 테이블의 기본 키는 FLAVOR입니다. FIRST_HALF테이블의 SHIPMENT_ID는 JULY테이블의 SHIPMENT_ID의 외래 키입니다.

# JULY 테이블 구조는 다음과 같으며, SHIPMENT_ID, FLAVOR, TOTAL_ORDER 은 각각 아이스크림 공장에서 아이스크림 가게까지의 출하 번호, 아이스크림 맛, 7월 아이스크림 총주문량을 나타냅니다. JULY 테이블의 기본 키는 SHIPMENT_ID입니다. JULY테이블의 FLAVOR는 FIRST_HALF 테이블의 FLAVOR의 외래 키입니다. 7월에는 아이스크림 주문량이 많아 같은 아이스크림에 대하여 서로 다른 두 공장에서 아이스크림 가게로 출하를 진행하는 경우가 있습니다. 이 경우 같은 맛의 아이스크림이라도 다른 출하 번호를 갖게 됩니다.

# 문제
# 7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 7월 & 상반기 아이스크림 맛별로 총 주문량이 많은 상위 3개 맛 조회 / TOTAL_ORDER
# 쿼리 계산 방법 : 1. FIRST_HALF의 맛별로 SUM -> 2. JULY의 맛별로 SUM -> 3. INNER JOIN -> 4. ORDER BY DESC LIMIT 3
# 데이터의 기간 :
# 사용할 테이블 : FIRST_HALF, JULY
# Join KEY : FLAVOR
# 데이터 특징 :
WITH FIRST_HALF_CNT AS (
    SELECT
        FLAVOR,
        SUM(TOTAL_ORDER) AS CNT
    FROM FIRST_HALF
    GROUP BY
        FLAVOR
), JULY_CNT AS (
    SELECT
        FLAVOR,
        SUM(TOTAL_ORDER) AS CNT
    FROM JULY
    GROUP BY
        FLAVOR
)
SELECT
    FLAVOR
FROM (
    SELECT
        FH.FLAVOR,
        FH.CNT + JU.CNT AS TOTAL_CNT
    FROM FIRST_HALF_CNT AS FH
    INNER JOIN JULY_CNT AS JU
    ON FH.FLAVOR = JU.FLAVOR
) AS BASE
ORDER BY
    TOTAL_CNT DESC
LIMIT 3
