# USED_GOODS_BOARD 테이블에서 2022년 10월 5일에 등록된 중고거래 게시물의 게시글 ID, 작성자 ID, 게시글 제목, 가격, 거래상태를 조회하는 SQL문을 작성해주세요. 
# 거래상태가 SALE 이면 판매중, RESERVED이면 예약중, DONE이면 거래완료 분류하여 출력해주시고, 
# 결과는 게시글 ID를 기준으로 내림차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022년 10월 5일 정보조회 / 거래상태에 따라 분류 / 내림차순 정렬 / CREATED_DATE,STATUS
# 쿼리 계산 방법 : WHERE / CASE WHEN / ORDER BY
# 데이터의 기간 : 
# 사용할 테이블 : USED_GOODS_BOARD
# Join KEY :
# 데이터 특징 :

SELECT
    BOARD_ID,
    WRITER_ID,
    TITLE,
    PRICE,
    CASE
        WHEN STATUS = 'SALE' THEN '판매중'
        WHEN STATUS = 'DONE' THEN '거래완료'
        ELSE '예약중'
    END AS STATUS
FROM USED_GOODS_BOARD
WHERE
    DATE_FORMAT(CREATED_DATE, '%Y-%m-%d') = '2022-10-05'
ORDER BY
    BOARD_ID DESC
    