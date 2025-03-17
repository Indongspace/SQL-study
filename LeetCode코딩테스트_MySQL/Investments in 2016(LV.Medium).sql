# 쿼리를 작성하는 목표, 확인할 지표 : tiv_2015값이 같으면 tiv_2016을 합한다. tiv_2015의 lat,lon은 고유의 값이어야 계산에 포함. / tiv_2015, lat, lon, tiv_2016
# 쿼리 계산 방법 : 1. 같은 tiv_2015 값을 갖고 있는 경우 추출 -> 2. (lat, lon)이 고유한 값인 경우만 추출 -> 3. tiv_2016의 총합 계산
# 데이터의 기간 : x
# 사용할 테이블 : insurance
# JOIN KEY : x
# 데이터 특징 : x
SELECT
    # 3
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM insurance
WHERE
    # 1
    tiv_2015 IN (SELECT tiv_2015 FROM insurance GROUP BY tiv_2015 HAVING COUNT(*) > 1) AND
    # 2
    (lat, lon) IN (SELECT lat, lon FROM insurance GROUP BY lat, lon HAVING COUNT(*) = 1)
