SELECT
    rest_id,
    rest_name,
    food_type,
    favorites,
    address,
    ROUND(AVG(review_score), 2) AS score
FROM (
    SELECT
        i.rest_id,
        i.rest_name,
        i.food_type,
        i.favorites,
        i.address,
        r.review_score
    FROM rest_info AS i
    INNER JOIN rest_review AS r
    ON i.rest_id = r.rest_id 
    WHERE
        i.address LIKE '서울%'
) AS seoul
GROUP BY
    rest_id
ORDER BY
    score DESC, favorites DESC 
    