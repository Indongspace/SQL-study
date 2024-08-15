# '경제' 카테고리에 속하는 도서들의 도서 ID(BOOK_ID), 저자명(AUTHOR_NAME), 출판일(PUBLISHED_DATE) 리스트를 출력하는 SQL문을 작성해주세요.
# 결과는 출판일을 기준으로 오름차순 정렬해주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : 경제 카테고리 속한 도서들의 정보 / 출판일 기준 오름차순
# 쿼리 계산 방법 : JOIN / WHERE / DATE_FORMAT / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : BOOK / AUTHOR
# Join KEY : AUTHOR_ID
# 데이터 특징 : 

SELECT
    B.BOOK_ID,
    A.AUTHOR_NAME,
    DATE_FORMAT(B.PUBLISHED_DATE, "%Y-%m-%d") AS PUBLISHED_DATE
FROM BOOK AS B
LEFT JOIN AUTHOR AS A
ON B.AUTHOR_ID = A.AUTHOR_ID
WHERE
    B.CATEGORY = '경제'
ORDER BY
    PUBLISHED_DATE ASC
    