# 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 
# 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 
# 이때 결과는 시간대 순으로 정렬해야 합니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 시간별로 몇 건이나 발생했는지 / 시간대순 정렬
# 쿼리 계산 방법 : GROUP BY / COUNT / ORDER BY
# 데이터의 기간 : 9 AND 19:59
# 사용할 테이블 : ANIMAL_OUTS
# Join KEY :
# 데이터 특징 :

SELECT
    HOUR(DATETIME) AS HOUR,
    COUNT(DISTINCT ANIMAL_ID) AS COUNT
FROM ANIMAL_OUTS
WHERE HOUR(DATETIME) >= 9 AND HOUR(DATETIME) <= 19
GROUP BY
    HOUR(DATETIME)
ORDER BY
    HOUR