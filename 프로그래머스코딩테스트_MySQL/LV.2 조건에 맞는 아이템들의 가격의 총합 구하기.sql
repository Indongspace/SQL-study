# ITEM_INFO 테이블에서 희귀도가 'LEGEND'인 아이템들의 가격의 총합을 구하는 SQL문을 작성해 주세요. 
# 이때 컬럼명은 'TOTAL_PRICE'로 지정해 주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 희귀도 LEGEND 가격 총합 / RARITY, PRICE
# 쿼리 계산 방법 : WHERE / SUM
# 데이터의 기간 :
# 사용할 테이블 : ITEM_INFO
# Join KEY : 
# 데이터 특징 :

SELECT
    SUM(PRICE) AS TOTAL_PRICE
FROM ITEM_INFO
WHERE
    RARITY = 'LEGEND'