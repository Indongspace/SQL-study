# 다음은 중고 거래 게시판 정보를 담은 USED_GOODS_BOARD 테이블과 중고 거래 게시판 사용자 정보를 담은 USED_GOODS_USER 테이블입니다. USED_GOODS_BOARD 테이블은 다음과 같으며 BOARD_ID, WRITER_ID, TITLE, CONTENTS, PRICE, CREATED_DATE, STATUS, VIEWS는 게시글 ID, 작성자 ID, 게시글 제목, 게시글 내용, 가격, 작성일, 거래상태, 조회수를 의미합니다.

# USED_GOODS_USER 테이블은 다음과 같으며 USER_ID, NICKNAME, CITY, STREET_ADDRESS1, STREET_ADDRESS2, TLNO는 각각 회원 ID, 닉네임, 시, 도로명 주소, 상세 주소, 전화번호를 를 의미합니다.

# 문제
# USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 결과는 총거래금액을 기준으로 오름차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 완료된&70만원이상 거래한 사람의 정보 출력 / STATUS, PRICE
# 쿼리 계산 방법 : GROUP BY, WHERE STATUS, HAVING PRICE, ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : USED_GOODS_BOARD, USED_GOODS_USER
# Join KEY : WRITER_ID, USER_ID
# 데이터 특징 :

SELECT
    USER.USER_ID,
    USER.NICKNAME,
    SUM(BOARD.PRICE) AS TOTAL_SALES
FROM USED_GOODS_BOARD AS BOARD
LEFT JOIN USED_GOODS_USER AS USER
ON BOARD.WRITER_ID = USER.USER_ID
WHERE
    BOARD.STATUS = 'DONE'
GROUP BY
    BOARD.WRITER_ID
HAVING
    TOTAL_SALES >= 700000
ORDER BY
    TOTAL_SALES
    