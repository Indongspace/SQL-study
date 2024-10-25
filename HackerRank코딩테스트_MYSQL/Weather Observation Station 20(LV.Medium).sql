-- A median is defined as a number separating the higher half of a data set from the lower half. 
-- Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places. 

-- Input Format
-- The STATION table is described as follows:
-- where LAT_N is the northern latitude and LONG_W is the western longitude.
-- 중앙값(Median)은 데이터 집합의 상위 절반과 하위 절반을 나누는 값으로 정의됩니다. 
-- STATION 테이블에서 북위(LAT_N)의 중앙값을 구하고, 그 답을 소수점 4자리까지 반올림하세요.

-- 입력 형식
-- STATION 테이블은 다음과 같이 설명됩니다:
-- 여기서 LAT_N은 북위이고, LONG_W는 서경입니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 북위(lat_n)의 중앙값을 소수점 4자리까지 반올림 / row_number, count(*), lat_n
# 쿼리 계산 방법 :
# 1. 윈도우 함수 row_number(북위 오름차순), count(*)로 북위 컬럼 옆에 북위 오름순 행의 순위를 숫자로 한 컬럼, 전체 행의 수 컬럼을 붙임 ->
# 2. 조건문으로 전체 행의 수가 짝수면 정가운데 행 & 그 다음 행의 북위값 평균값을 구하게 하고, ->
# 3. 전체 행의 수가 홀수면 (올림)정가운데 행의 북위값을 가져온다 ->
# 4. 중복값 제거
# 데이터의 기간 : X
# 사용할 테이블 : station
# Join KEY : X
# 데이터 특징 : X 
WITH row_num_and_total_cnt AS (
    SELECT
        lat_n,
        # 1. 윈도우 함수 row_number(북위 오름차순), count(*)로 북위 컬럼 옆에 북위 오름순 행의 순위를 숫자로 한 컬럼, 전체 행의 수 컬럼을 붙임
        ROW_NUMBER() OVER(ORDER BY lat_n ASC) AS row_num,
        COUNT(*) OVER() AS total_cnt
    FROM station
)
SELECT
    # 4. 중복값 제거
    DISTINCT median
FROM (
    SELECT
        # 2. 조건문으로 전체 행의 수가 짝수면 정가운데 행 & 그 다음 행의 북위값 평균값을 구하게 하고,
        CASE
            WHEN total_cnt % 2 = 0 THEN (SELECT 
                                            ROUND(AVG(lat_n), 4)
                                         FROM row_num_and_total_cnt 
                                         WHERE row_num IN (total_cnt / 2, (total_cnt / 2) + 1))
            # 3. 전체 행의 수가 홀수면 (올림)정가운데 행의 북위값을 가져온다
            ELSE (SELECT 
                    ROUND(lat_n, 4) 
                  FROM row_num_and_total_cnt
                  WHERE
                    row_num = CEIL(total_cnt / 2))
        END AS median
    FROM row_num_and_total_cnt
) AS BASE

