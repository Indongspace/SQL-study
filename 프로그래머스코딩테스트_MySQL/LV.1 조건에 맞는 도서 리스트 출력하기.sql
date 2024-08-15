-- BOOK 테이블에서 2021년에 출판된 '인문' 카테고리에 속하는 도서 리스트를 찾아서 
-- 도서 ID(BOOK_ID), 출판일 (PUBLISHED_DATE)을 출력하는 SQL문을 작성해주세요.
-- 결과는 출판일을 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2021년 출판 / 인문 카테고리 / 출판일 오름차순
# 쿼리 계산 방법 : WHERE BETWEEN 2021 / CATEGORY = '인문' / 출판일 오름차순 
# 데이터의 기간 :
# 사용할 테이블 : BOOK
# Join KEY :
# 데이터 특징 :

SELECT
    BOOK_ID,
    DATE_FORMAT(PUBLISHED_DATE, "%Y-%m-%d") AS PUBLISHED_DATE
FROM BOOK
WHERE
    CATEGORY = '인문' 
    AND
    PUBLISHED_DATE BETWEEN '2021-01-01' AND '2021-12-31'
ORDER BY
    PUBLISHED_DATE ASC