WITH all_users AS (
    SELECT user_id FROM users
    UNION
    SELECT user_a_id AS user_id FROM edges
    UNION
    SELECT user_b_id AS user_id FROM edges
),
friend_counts AS (
    SELECT user_id, COUNT(*) AS num_friends
    FROM (
        SELECT user_a_id AS user_id FROM edges
        UNION ALL
        SELECT user_b_id FROM edges
    ) AS all_friends
    GROUP BY user_id
)
SELECT au.user_id, COALESCE(fc.num_friends, 0) AS num_friends
FROM all_users au
LEFT JOIN friend_counts fc ON au.user_id = fc.user_id
ORDER BY num_friends DESC, au.user_id ASC;
