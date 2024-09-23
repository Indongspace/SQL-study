# 대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
# 다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.

# 문제
# 대장균 개체의 크기가 100 이하라면 'LOW', 100 초과 1000 이하라면 'MEDIUM', 1000 초과라면 'HIGH' 라고 분류합니다. 대장균 개체의 ID(ID) 와 분류(SIZE)를 출력하는 SQL 문을 작성해주세요.이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 대장균 크기별로 사이즈 구분표기 / SIZE_OF_COLONY
# 쿼리 계산 방법 : CASE WHEN, ORDER BY 
# 데이터의 기간 :
# 사용할 테이블 : ECOLI_DATA
# Join KEY :
# 데이터 특징 :

SELECT
    ID,
    CASE
        WHEN SIZE_OF_COLONY <= 100 THEN 'LOW'
        WHEN SIZE_OF_COLONY > 100 AND SIZE_OF_COLONY <= 1000 THEN 'MEDIUM'
        WHEN SIZE_OF_COLONY > 1000 THEN 'HIGH'
    END AS SIZE
FROM ECOLI_DATA
ORDER BY
    ID
    