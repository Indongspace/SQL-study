# ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다.

# 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.

# 쿼리를 작성하는 목표, 확인할 지표 : 시간대별로 입양 건수 출력 / DATETIME 
# 쿼리 계산 방법 : WITH RECURSIVE 0~23 생성 -> LEFT JOIN EXTRACT(HOUR) FROM ANUMAL_OUTS -> GROUP BY HOUR -> ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ANIMAL_OUTS
# Join KEY :
# 데이터 특징 : 0~23시 까지 표시되는 컬럼을 생성해줘야 함
WITH RECURSIVE TWENTY_FOUR_HOUR AS (
    SELECT 0 AS HOUR
    UNION ALL
    SELECT HOUR + 1
    FROM TWENTY_FOUR_HOUR
    WHERE HOUR < 23
), ORIGINAL_HOUR AS (
    SELECT
        *,
        EXTRACT(HOUR FROM DATETIME) AS HOUR
    FROM ANIMAL_OUTS
)

SELECT  
    TFH.HOUR AS HOUR,
    COUNT(OH.HOUR) AS COUNT
FROM TWENTY_FOUR_HOUR AS TFH
LEFT JOIN ORIGINAL_HOUR AS OH
ON TFH.HOUR = OH.HOUR
GROUP BY
    TFH.HOUR
ORDER BY
    HOUR
    