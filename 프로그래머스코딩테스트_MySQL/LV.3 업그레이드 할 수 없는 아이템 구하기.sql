# 어느 한 게임에서 사용되는 아이템들은 업그레이드가 가능합니다.
# 'ITEM_A'->'ITEM_B'와 같이 업그레이드가 가능할 때
# 'ITEM_A'를 'ITEM_B'의 PARENT 아이템,
# PARENT 아이템이 없는 아이템을 ROOT 아이템이라고 합니다.

# 예를 들어 'ITEM_A'->'ITEM_B'->'ITEM_C' 와 같이 업그레이드가 가능한 아이템이 있다면
# 'ITEM_C'의 PARENT 아이템은 'ITEM_B'
# 'ITEM_B'의 PARENT 아이템은 'ITEM_A'
# ROOT 아이템은 'ITEM_A'가 됩니다.

# 다음은 해당 게임에서 사용되는 아이템 정보를 담은 ITEM_INFO 테이블과 아이템 관계를 나타낸 ITEM_TREE 테이블입니다.

# ITEM_INFO 테이블은 다음과 같으며, ITEM_ID, ITEM_NAME, RARITY, PRICE는 각각 아이템 ID, 아이템 명, 아이템의 희귀도, 아이템의 가격을 나타냅니다.
# ITEM_TREE 테이블은 다음과 같으며, ITEM_ID, PARENT_ITEM_ID는 각각 아이템 ID, PARENT 아이템의 ID를 나타냅니다.

# 단, 각 아이템들은 오직 하나의 PARENT 아이템 ID 를 가지며, ROOT 아이템의 PARENT 아이템 ID 는 NULL 입니다.

# ROOT 아이템이 없는 경우는 존재하지 않습니다.

# 문제
# 더 이상 업그레이드할 수 없는 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력하는 SQL 문을 작성해 주세요. 이때 결과는 아이템 ID를 기준으로 내림차순 정렬해 주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 더이상 업그레이드 할 수 없는 아이템. 즉 LEAF(부모 아이디 집합에 없는 ITEM_ID)의 정보 출력 / ITEM_ID, PARENT_ITEM_ID
# 쿼리 계산 방법 : LEFT JOIN, WHERE NOT EXISTS, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ITEM_INFO, ITEM_TREE
# Join KEY : ITEM_ID
# 데이터 특징 :

SELECT
    INFO.ITEM_ID,
    INFO.ITEM_NAME,
    INFO.RARITY 
FROM ITEM_INFO AS INFO
LEFT JOIN ITEM_TREE AS TREE
ON INFO.ITEM_ID = TREE.ITEM_ID
WHERE NOT EXISTS
    (SELECT
        ITEM_ID
     FROM ITEM_TREE
     WHERE
        ITEM_TREE.PARENT_ITEM_ID = INFO.ITEM_ID)
ORDER BY
    INFO.ITEM_ID DESC
    