WITH null_data AS (
  SELECT
    game_id,
    name,
    genre_id,
    critic_score,
    critic_count,
    user_score,
    user_count
  FROM games
  WHERE
    year >= 2015 AND
    (critic_score IS NULL OR critic_count IS NULL OR user_score IS NULL OR user_count IS NULL)
), avg_score AS (
  SELECT
    genre_id,
    ROUND(AVG(critic_score), 3) AS avg_critic_score,
    CAST(AVG(critic_count) AS INTEGER) + (CASE WHEN AVG(critic_count) > CAST(AVG(critic_count) AS INTEGER) THEN 1 ELSE 0 END) AS avg_critic_count,
    ROUND(AVG(user_score), 3) AS avg_user_score,
    CAST(AVG(user_count) AS INTEGER) + (CASE WHEN AVG(user_count) > CAST(AVG(user_count) AS INTEGER) THEN 1 ELSE 0 END) AS avg_user_count  
  FROM games
  GROUP BY
    genre_id
)
SELECT
  n.game_id,
  n.name,
  COALESCE(n.critic_score, a.avg_critic_score) AS critic_score,
  COALESCE(n.critic_count, a.avg_critic_count) AS critic_count,
  COALESCE(n.user_score, a.avg_user_score) AS user_score,
  COALESCE(n.user_count, a.avg_user_count) AS user_count
FROM null_data AS n 
LEFT JOIN avg_score AS a 
ON n.genre_id = a.genre_id 
