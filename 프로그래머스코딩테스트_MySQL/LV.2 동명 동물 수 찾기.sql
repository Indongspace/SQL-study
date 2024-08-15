# 동물 보호소에 들어온 동물 이름 중 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수를 조회하는 SQL문을 작성해주세요. 이때 결과는 이름이 없는 동물은 집계에서 제외하며, 결과는 이름 순으로 조회해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 두 번 이상 쓰인 이름과 해당 이름이 쓰인 횟수 조회
# 쿼리 계산 방법 : WHERE IS NOT NULL / GROUP BY NAME / HAVING / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_INS
# Join KEY :
# 데이터 특징 :

SELECT
    NAME,
    COUNT(ANIMAL_ID) AS COUNT
FROM ANIMAL_INS
WHERE
    NAME IS NOT NULL
GROUP BY
    NAME
HAVING
    COUNT >= 2
ORDER BY
    NAME
    