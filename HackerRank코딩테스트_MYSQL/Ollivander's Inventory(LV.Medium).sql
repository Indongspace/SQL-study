-- Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
-- Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.
-- Input Format
-- The following tables contain data on the wands in Ollivander's inventory:
-- Wands: The id is the id of the wand, code is the code of the wand, coins_needed is the total number of gold galleons needed to buy the wand, and power denotes the quality of the wand (the higher the power, the better the wand is).
-- Wands_Property: The code is the code of the wand, age is the age of the wand, and is_evil denotes whether the wand is good for the dark arts. If the value of is_evil is 0, it means that the wand is not evil. The mapping between code and age is one-one, meaning that if there are two pairs,
-- (code1, age1) and (code2, age2), then code1 != code2 and age1 != age2

-- Sample Output
-- 9 45 1647 10
-- 12 17 9897 10
-- 1 20 3688 8
-- 15 40 6018 7
-- 19 20 7651 6
-- 11 40 7587 5
-- 10 20 504 5
-- 18 40 3312 3
-- 20 17 5689 3
-- 5 45 6020 2
-- 14 40 5408 1

-- Explanation
-- The data for wands of age 45 (code 1):
-- The minimum number of galleons needed for wand(age=45, power=2) = 6020
-- The minimum number of galleons needed for wand(age=45, power=10) = 1647
-- The data for wands of age 40 (code 2):
-- The minimum number of galleons needed for wand(age=40, power=1) = 5408 
-- The minimum number of galleons needed for wand(age=40, power=3) = 3312
-- The minimum number of galleons needed for wand(age=40, power=5) = 7587
-- The minimum number of galleons needed for wand(age=40, power=7) = 6018

-- 해리 포터와 친구들이 론과 함께 올리밴더의 가게에 와서 찰리의 오래된 부러진 지팡이를 마침내 교체하려고 합니다.
-- 헤르미온느는 각 고성능의 비악한(non-evil) 지팡이를 사는 데 필요한 최소 금액의 골드 갈레온(galleon)을 찾는 것이 가장 좋은 선택 방법이라고 생각합니다. 론이 관심 있는 지팡이의 id, age, coins_needed, 그리고 power를 출력하는 쿼리를 작성하세요. 결과는 power의 내림차순으로 정렬해야 하며, 만약 여러 지팡이가 동일한 power를 가질 경우, age의 내림차순으로 정렬합니다.
-- 입력 형식
-- 다음 표는 올리밴더의 재고에 있는 지팡이에 대한 데이터를 포함하고 있습니다:
-- Wands: id는 지팡이의 식별자이고, code는 지팡이의 코드이며, coins_needed는 지팡이를 사는 데 필요한 총 골드 갈레온의 수를 나타내고, power는 지팡이의 품질을 나타냅니다 (power가 높을수록 더 좋은 지팡이임).
-- Wands_Property: code는 지팡이의 코드이고, age는 지팡이의 나이이며, is_evil은 그 지팡이가 어둠의 마법에 적합한지 여부를 나타냅니다. is_evil의 값이 0이면 지팡이가 악하지 않다는 것을 의미합니다. code와 age의 매핑은 일대일 관계이므로 (code1, age1)과 (code2, age2) 쌍이 있다면 code1 != code2이고 age1 != age2입니다.

-- 출력 예시
-- 9 45 1647 10
-- 12 17 9897 10
-- 1 20 3688 8
-- 15 40 6018 7
-- 19 20 7651 6
-- 11 40 7587 5
-- 10 20 504 5
-- 18 40 3312 3
-- 20 17 5689 3
-- 5 45 6020 2
-- 14 40 5408 1
-- 설명
-- 나이 45(age=45)의 지팡이에 대한 데이터:
-- power=2인 지팡이를 사는 데 필요한 최소 가렁의 수는 6020입니다.
-- power=10인 지팡이를 사는 데 필요한 최소 가렁의 수는 1647입니다.
-- 나이 40(age=40)의 지팡이에 대한 데이터:
-- power=1인 지팡이를 사는 데 필요한 최소 가렁의 수는 5408입니다.
-- power=3인 지팡이를 사는 데 필요한 최소 가렁의 수는 3312입니다.
-- power=5인 지팡이를 사는 데 필요한 최소 가렁의 수는 7587입니다.
-- power=7인 지팡이를 사는 데 필요한 최소 가렁의 수는 6018입니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 각 NON-EVIL한 지팡이별 최소 금액의 지팡이를 찾는다 / AGE,POWER,COINS_NEEDED
# 쿼리 계산 방법 : 
# 1. INNER JOIN 후 IS_EVIL = 0으로 비악한 지팡이 조건 걸기 BASE 생성 ->
# 2. INNER JOIN 후 IS_EVIL 조건, AGE별,POWER별 그룹화로 갈레온 MIN값 추출 MIN_GAL 생성 ->
# 3. BASE와 MIN_GAL의 JOIN으로 AGE와 POWER와 갈레온(COINS_NEEDED & MIN_GAL)을 KEY로 설정해야 한다. ->
# 4. 정렬
# 데이터의 기간 : 
# 사용할 테이블 : WANDS, WANDS_PROPERTY
# Join KEY : CODE / AGE,POWER,COINS_NEEDED,MIN_GAL
# 데이터 특징 :
SELECT
    BASE.ID,
    BASE.AGE,
    BASE.COINS_NEEDED,
    BASE.POWER
FROM (
    SELECT
        W.ID,
        WP.AGE,
        W.COINS_NEEDED,
        W.POWER
    FROM WANDS AS W
    # 1. INNER JOIN 후 IS_EVIL = 0으로 비악한 지팡이 조건 걸기 BASE 생성
    INNER JOIN WANDS_PROPERTY AS WP
    ON W.CODE = WP.CODE
    WHERE
        WP.IS_EVIL = 0
) AS BASE
INNER JOIN (
    SELECT
        WP.AGE,
        W.POWER,
        # 2. INNER JOIN 후 IS_EVIL 조건, AGE별,POWER별 그룹화로 갈레온 MIN값 추출 MIN_GAL 생성
        MIN(W.COINS_NEEDED) AS MIN_GAL
    FROM WANDS AS W
    INNER JOIN WANDS_PROPERTY AS WP
    ON W.CODE = WP.CODE
    WHERE
        WP.IS_EVIL = 0
    GROUP BY
        WP.AGE,
        W.POWER
) AS MIN_GAL
# 3. BASE와 MIN_GAL의 JOIN으로 AGE와 POWER와 갈레온(COINS_NEEDED & MIN_GAL)을 KEY로 설정해야 한다.
ON BASE.AGE = MIN_GAL.AGE
AND BASE.POWER = MIN_GAL.POWER
AND BASE.COINS_NEEDED = MIN_GAL.MIN_GAL
# 4. 정렬
ORDER BY
    POWER DESC,
    AGE DESC
    