WITH dead_artist AS (
  SELECT
    artwork_id,
    artist_id
  FROM artworks_artists
  WHERE
    artist_id IN (SELECT artist_id FROM artists WHERE death_year IS NOT NULL)
)
SELECT
  artist_id,
  name 
FROM artists 
WHERE
  artist_id NOT IN (SELECT artist_id FROM dead_artist) AND
  death_year IS NOT NULL 
