-- 상반기에 판매된 아이스크림의 맛을 총주문량을 기준으로 내림차순 정렬하고 
-- 총주문량이 같다면 출하 번호를 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 총주문량 내림차순 / 출하번호 오름차순 / FLAVOR
# 쿼리 계산 방법 : ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : FIRST_HALF
# Join KEY :
# 데이터의 특징

SELECT
    FLAVOR
FROM FIRST_HALF
ORDER BY
    TOTAL_ORDER DESC,
    SHIPMENT_ID ASC
    