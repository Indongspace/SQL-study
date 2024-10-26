-- Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum and maximum values of Northern Latitude (LAT_N) and (c,d) 
-- are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION. 
-- Query the Euclidean Distance between points P1 and P2 and format your answer to display 4 decimal digits. 

-- Input Format
-- The STATION table is described as follows:   

-- where LAT_N is the northern latitude and LONG_W is the western longitude.

-- P1(a, c)와 P2(b, d)는 2D 평면상의 두 점이며, 여기서 (a, b)는 각각 STATION 테이블의 북위(LAT_N) 값의 최소값과 최대값이고, (c, d)는 서경(LONG_W) 값의 최소값과 최대값입니다.
-- 두 점 P1과 P2 사이의 유클리드 거리를 구하고, 소수점 네 자리까지 표시되도록 형식을 지정하세요.

-- 입력 형식:
-- STATION 테이블은 다음과 같이 설명됩니다:

-- LAT_N은 북위, LONG_W는 서경을 나타냅니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 두 점 P1, P2 사이의 유클리드 거리 구하기 / lat_n, long_w
# 쿼리 계산 방법 :
# 1. 북위의 최소값,최대값 a,b / 서경의 최소값,최대값 c,d ->
# 2. 카티션 곱으로 p1좌표, p2좌표 추출 ->
# 3. 유클리디안 좌표 구하는 공식 : 거리차의 제곱합의 제곱근
# 데이터의 기간 :
# 사용할 테이블 : station
# Join KEY : 
# 데이터 특징 : 
WITH ab AS (
    SELECT
    	# 1. 북위의 최소값,최대값 a,b
        Min(lat_n) AS a,
        MAX(lat_n) AS b
    FROM station
), cd AS (
    SELECT
    	# 1. 서경의 최소값,최대값 c,d
        Min(long_w) AS c,
        Max(long_w) AS d
    FROM station
), p1 AS (
    SELECT
    	# 2. 카티션 곱으로 p1좌표 추출
        ab.a,
        cd.c
    FROM ab,cd
), p2 AS (
    SELECT
    	# 2. 카티션 곱으로 p2좌표 추출
        ab.b,
        cd.d
    FROM ab,cd
)
SELECT
	# 3. 유클리디안 좌표 구하는 공식 : 거리차의 제곱합의 제곱근
    ROUND(SQRT(POWER(p1.a - p2.b, 2) + POWER(p1.c - p2.d, 2)), 4)
FROM p1,p2

