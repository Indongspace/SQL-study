-- USED_GOODS_BOARD와 USED_GOODS_REPLY 테이블에서 
-- 2022년 10월에 작성된 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회하는 SQL문을 작성해주세요. 
-- 결과는 댓글 작성일을 기준으로 오름차순 정렬해주시고, 댓글 작성일이 같다면 게시글 제목을 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022년 10월 / 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회 / 댓글 작성일 기준 오름차순 / 게시글 제목 기준 오름차순
# 쿼리 계산 방법 : WHERE CREATED_DATE BETWEEN '2022-10-01' AND '2022-10-31' / 
# 데이터의 기간 :
# 사용할 테이블 : USED_GOODS_BOARD / USED_GOODS_REPLY
# Join KEY : BOARD_ID
# 데이터 특징 : 

SELECT
    BOARD.TITLE,
    BOARD.BOARD_ID,
    REPLY.REPLY_ID,
    REPLY.WRITER_ID,
    REPLY.CONTENTS,
    DATE_FORMAT(REPLY.CREATED_DATE, '%Y-%m-%d') AS CREATED_DATE
FROM USED_GOODS_BOARD AS BOARD
INNER JOIN USED_GOODS_REPLY AS REPLY
ON BOARD.BOARD_ID = REPLY.BOARD_ID
WHERE
    BOARD.CREATED_DATE BETWEEN '2022-10-01' AND '2022-10-31'
ORDER BY
    REPLY.CREATED_DATE ASC,
    BOARD.TITLE ASC 