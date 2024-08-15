# AIR_POLLUTION 테이블에서 수원 지역의 연도 별 평균 미세먼지 오염도와 평균 초미세먼지 오염도를 조회하는 SQL문을 작성해주세요. 
# 이때, 평균 미세먼지 오염도와 평균 초미세먼지 오염도의 컬럼명은 각각 PM10, PM2.5로 해 주시고, 값은 소수 셋째 자리에서 반올림해주세요.
# 결과는 연도를 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 수원 지역, 연도별 평균 미세먼지,초미세먼지, 반올림, 오름차순 / LOCATION2, YM, PM_VAL1, PM_VAL2
# 쿼리 계산 방법 : WHERE, DATE_FORMAT, GROUP BY, AVG, ROUND, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : AIR_POLLUTION
# Join KEY :
# 데이터 특징 :

SELECT
    YEAR(YM) AS YEAR,
    ROUND(AVG(PM_VAL1), 2) AS PM10,
    ROUND(AVG(PM_VAL2), 2) AS 'PM2.5'
FROM AIR_POLLUTION
WHERE
    LOCATION2 = '수원'
GROUP BY
    YEAR(YM)
ORDER BY
    YEAR ASC