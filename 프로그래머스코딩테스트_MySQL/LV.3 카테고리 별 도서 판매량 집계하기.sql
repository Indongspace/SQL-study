# 다음은 어느 한 서점에서 판매중인 도서들의 도서 정보(BOOK), 판매 정보(BOOK_SALES) 테이블입니다.
# BOOK 테이블은 각 도서의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.
# BOOK_ID	INTEGER	FALSE	도서 ID
# CATEGORY	VARCHAR(N)	FALSE	카테고리 (경제, 인문, 소설, 생활, 기술)
# AUTHOR_ID	INTEGER	FALSE	저자 ID
# PRICE	INTEGER	FALSE	판매가 (원)
# PUBLISHED_DATE	DATE	FALSE	출판일

# BOOK_SALES 테이블은 각 도서의 날짜 별 판매량 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.
# BOOK_ID	INTEGER	FALSE	도서 ID
# SALES_DATE	DATE	FALSE	판매일
# SALES	INTEGER	FALSE	판매량

# 2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
# 결과는 카테고리명을 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 2022년 1월 추출, 카테코리 별 도서 판매량 합산, 정보 출력, 오름차순 / SALES_DATE, CATEGORY, SALES
# 쿼리 계산 방법 : WHERE 2022 1, GROUP BY, SUM, ORDER BY
# 데이터의 기간 : 2022년 1월
# 사용할 테이블 : BOOK, BOOK_SALES
# Join KEY : BOOK_ID
# 데이터 특징 :

SELECT
    BOOK.CATEGORY,
    SUM(SALES.SALES) AS TOTAL_SALES
FROM BOOK
LEFT JOIN BOOK_SALES AS SALES
ON BOOK.BOOK_ID = SALES.BOOK_ID
WHERE
    DATE_FORMAT(SALES.SALES_DATE, '%Y-%m') = '2022-01'
GROUP BY
    BOOK.CATEGORY
ORDER BY
    BOOK.CATEGORY ASC
    