# 2번 형질이 보유하지 않으면서 1번이나 3번 형질을 보유하고 있는 대장균 개체의 수(COUNT)를 출력하는 SQL 문을 작성해주세요. 
# 1번과 3번 형질을 모두 보유하고 있는 경우도 1번이나 3번 형질을 보유하고 있는 경우에 포함합니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 2번째 비트가 1이 아닌, / 1번째 비트가 1이거나 3번째 비트가 1인 GENOTYPE
# 쿼리 계산 방법 : (GENOTYPE & )
# 데이터의 기간 :
# 사용할 테이블 : ECOLI_DATA
# Join KEY :
# 데이터 특징 :

SELECT
    COUNT(ID) AS COUNT
FROM ECOLI_DATA
WHERE
    (GENOTYPE & 2) = 0 AND
    ((GENOTYPE & 1) = 1 OR (GENOTYPE & 4) = 4)
    