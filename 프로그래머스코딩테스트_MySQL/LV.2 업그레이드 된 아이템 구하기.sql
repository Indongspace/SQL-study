# 아이템의 희귀도가 'RARE'인 아이템들의 모든 다음 업그레이드 아이템의 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME), 아이템의 희귀도(RARITY)를 출력하는 SQL 문을 작성해 주세요. 
# 이때 결과는 아이템 ID를 기준으로 내림차순 정렬주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 아이템 회귀도가 RARE인 아이템.의 다음 업그레이드 아이템 정보 / 내림차순
# 쿼리 계산 방법 : JOIN WHERE / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : ITEM_INFO, ITEM_TREE
# Join KEY : ITEM_ID
# 데이터 특징 :

SELECT
    TREE.ITEM_ID,
    INFO.ITEM_NAME,
    INFO.RARITY
FROM ITEM_TREE AS TREE
LEFT JOIN ITEM_INFO AS INFO
ON TREE.ITEM_ID = INFO.ITEM_ID
WHERE TREE.PARENT_ITEM_ID IN (
    SELECT
        ITEM_ID
    FROM ITEM_INFO
    WHERE RARITY = 'RARE'
)
ORDER BY
    TREE.ITEM_ID DESC
    