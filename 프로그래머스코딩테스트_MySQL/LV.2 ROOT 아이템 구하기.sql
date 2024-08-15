# ROOT 아이템을 찾아 아이템 ID(ITEM_ID), 아이템 명(ITEM_NAME)을 출력하는 SQL문을 작성해 주세요. 
# 이때, 결과는 아이템 ID를 기준으로 오름차순 정렬해 주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : ROOT아이템 정보 출력 / 오름차순
# 쿼리 계산 방법 : WHERE JOIN / ORDER BY 
# 데이터의 기간 :
# 사용할 테이블 : ITEM_INFO, ITEM_TREE
# Join KEY : ITEM_ID
# 데이터 특징 :

SELECT
    INFO.ITEM_ID,
    INFO.ITEM_NAME
FROM (
    SELECT
        *
    FROM ITEM_TREE 
    WHERE
        PARENT_ITEM_ID IS NULL
) AS TREE
LEFT JOIN ITEM_INFO AS INFO
ON TREE.ITEM_ID = INFO.ITEM_ID
ORDER BY
    INFO.ITEM_ID ASC
    