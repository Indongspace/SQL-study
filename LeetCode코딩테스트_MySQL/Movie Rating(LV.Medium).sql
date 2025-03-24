# 쿼리를 작성하는 목표, 확인할 지표 : 가장 많이 평가를 남긴 유저 이름 & 가장 높은 평가를 받은 영화 이름 출력 / user_id, rating
# 쿼리 계산 방법 : 1. group by user_id -> 2. order by로 count 내림차순, name오름차순 limit 1로 첫 행만 추출 -> 3. 2020년 2월에 한해서 group by movie_id -> 4. order by로 avg 내림차순, title오름차순 limit 1 -> 5. union all
# 데이터의 기간 : avg 구할때 한해서 2020년 2월
# 사용할 테이블 : movies, users, movierating
# JOIN KEY : movie_id, user_id
# 데이터 특징 : x
WITH name AS (
    SELECT
        u.name
    FROM movierating AS mr
    INNER JOIN users AS u
    ON mr.user_id = u.user_id
    GROUP BY
        mr.user_id
    ORDER BY
        COUNT(*) DESC, u.name ASC
    LIMIT 1
), title AS (
    SELECT
        m.title
    FROM movierating AS mr
    INNER JOIN movies AS m
    ON mr.movie_id = m.movie_id
    WHERE
        DATE_FORMAT(created_at, '%Y-%m') = '2020-02'
    GROUP BY
        mr.movie_id
    ORDER BY
        AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
)
SELECT
    name AS results
FROM name
UNION ALL
SELECT
    title
FROM title