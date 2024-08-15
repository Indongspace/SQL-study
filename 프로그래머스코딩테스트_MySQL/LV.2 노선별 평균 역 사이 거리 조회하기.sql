# SUBWAY_DISTANCE 테이블에서 노선별로 노선, 총 누계 거리, 평균 역 사이 거리를 노선별로 조회하는 SQL문을 작성해주세요.
# 총 누계거리는 테이블 내 존재하는 역들의 역 사이 거리의 총 합을 뜻합니다. 
# 총 누계 거리와 평균 역 사이 거리의 컬럼명은 각각 TOTAL_DISTANCE, AVERAGE_DISTANCE로 해주시고, 총 누계거리는 소수 둘째자리에서, 평균 역 사이 거리는 소수 셋째 자리에서 반올림 한 뒤 단위(km)를 함께 출력해주세요.
# 결과는 총 누계 거리를 기준으로 내림차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 노선 별 정보, D_BETWEEN_DIST
# 쿼리 계산 방법 : GROUP BY, SUM, AVG, ROUND, CONCAT, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : SUBWAY_DISTANCE
# Join KEY :
# 데이터 특징 :

SELECT
    ROUTE,
    CONCAT(ROUND(SUM(D_BETWEEN_DIST), 1),'km') AS TOTAL_DISTANCE,
    CONCAT(ROUND(AVG(D_BETWEEN_DIST), 2),'km') AS AVERAGE_DISTANCE
FROM SUBWAY_DISTANCE
GROUP BY
    ROUTE
ORDER BY
    SUM(D_BETWEEN_DIST) DESC
    