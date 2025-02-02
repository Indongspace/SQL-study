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
    critic_score IS NULL OR critic_count IS NULL OR user_score IS NULL OR user_count IS NULL 
), base AS (
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
    year >= 2015 AND critic_score IS NOT NULL AND critic_count IS NOT NULL AND user_score IS NOT NULL AND user_count IS NOT NULL
), avg_score AS (
  SELECT
    genre_id,
    AVG(critic_score) AS avg_critic_score,
    CEIL(AVG(critic_count)) AS avg_critic_count,
    AVG(user_score) AS avg_user_score,
    CEIL(AVG(user_count)) AS avg_user_count 
  FROM base
  GROUP BY
    genre_id
)
SELECT
  game_id,
  name,
  
FROM null_data