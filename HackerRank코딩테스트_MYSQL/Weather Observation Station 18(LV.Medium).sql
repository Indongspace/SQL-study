-- Consider P1(a,b) and P2(c,d) to be two points on a 2D plane. 
-- a happens to equal the minimum value in Northern Latitude (LAT_N in STATION). 
-- b happens to equal the minimum value in Western Longitude (LONG_W in STATION). 
-- c happens to equal the maximum value in Northern Latitude (LAT_N in STATION). 
-- d happens to equal the maximum value in Western Longitude (LONG_W in STATION). 
-- Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places. 

-- Input Format
-- The STATION table is described as follows:

-- where LAT_N is the northern latitude and LONG_W is the western longitude.
-- 2차원 평면에 두 점 P1(a, b)와 P2(c, d)가 있다고 하자.
-- 여기서 a는 북위(LAT_N)의 최소값이고, b는 서경(LONG_W)의 최소값이다. c는 북위(LAT_N)의 최대값이고, d는 서경(LONG_W)의 최대값이다.
-- P1과 P2 사이의 맨해튼 거리를 쿼리하여 소수점 네 자리까지 반올림하라.

-- 입력 형식
-- STATION 테이블은 다음과 같이 설명된다:

-- 여기서 LAT_N은 북위, LONG_W는 서경을 나타낸다.

# 쿼리를 작성하는 목표, 확인할 지표 : P1과 P2 사이의 맨해튼 거리 구하기 / lat_n, long_w
# 쿼리 계산 방법 :
# 1. min,max로 a,b,c,d 좌표 생성 ->
# 2. P1좌표 -> 3. P2좌표 -> 
# 4. 맨하튼 거리 구하는 공식에 대한 쿼리
# 데이터의 기간 :
# 사용할 테이블 : station
# Join KEY :
# 데이터 특징 :
WITH base AS (
    SELECT  
    	# 1. min,max로 a,b,c,d 좌표 생성
        MIN(lat_n) AS a,
        MIN(long_w) AS b,
        MAX(lat_n) AS c,
        MAX(long_w) AS d
    FROM station
),
# 2. P1좌표
p1 AS (
    SELECT
        a,b
    FROM base
), 
# 3. P2좌표
p2 AS (
    SELECT
        c,d
    FROM base
)
# 4. 맨하튼 거리 구하는 공식에 대한 쿼리
SELECT
    ROUND((ABS(a - c) + ABS(b - d)), 4)
FROM p1,p2
