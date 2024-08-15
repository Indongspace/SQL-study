# FISH_INFO 테이블에서 2021년도에 잡은 물고기 수를 출력하는 SQL 문을 작성해주세요.
# 이 때 컬럼명은 'FISH_COUNT' 로 지정해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2021년도에 잡은 물고기 COUNT
# 쿼리 계산 방법 : WHERE 2022 / COUNT
# 데이터의 기간 : 2021
# 사용할 테이블 : FISH_INFO
# Join KEY : 
# 데이터 특징 :

SELECT
    COUNT(ID) AS FISH_COUNT
FROM FISH_INFO
WHERE
    TIME BETWEEN '2021-01-01' AND '2021-12-31'