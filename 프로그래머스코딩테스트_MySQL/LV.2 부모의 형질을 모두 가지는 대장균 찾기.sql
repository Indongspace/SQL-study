# 부모의 형질을 모두 보유한 대장균의 ID(ID), 대장균의 형질(GENOTYPE), 부모 대장균의 형질(PARENT_GENOTYPE)을 출력하는 SQL 문을 작성해주세요. 
# 이때 결과는 ID에 대해 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 부모가 있고, 부모의 형질과 같은 형질을 같이 가지고 있는 대장균 정보 출력, PARENT_ID, GENOTYPE
# 쿼리 계산 방법 : WHERE &, JOIN, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ECOLI_DATA
# Join KEY :
# 데이터 특징 :

SELECT
    CHILD.ID,
    CHILD.GENOTYPE,
    PARENT.GENOTYPE AS PARENT_GENOTYPE
FROM ECOLI_DATA AS CHILD
LEFT JOIN ECOLI_DATA AS PARENT
ON CHILD.PARENT_ID = PARENT.ID
WHERE
    PARENT.GENOTYPE IS NOT NULL AND
    (CHILD.GENOTYPE | PARENT.GENOTYPE) = CHILD.GENOTYPE
ORDER BY
    CHILD.ID