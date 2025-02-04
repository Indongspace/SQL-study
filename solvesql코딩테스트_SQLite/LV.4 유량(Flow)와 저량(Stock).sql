SELECT
  *,
  SUM(`New acquisitions this year (Flow)`) OVER(ORDER BY `Acquisition year`) AS `Total collection size (Stock)`
FROM (
  SELECT
    DISTINCT strftime('%Y', acquisition_date) AS `Acquisition year`,
    COUNT(artwork_id) OVER(PARTITION BY strftime('%Y', acquisition_date) ORDER BY strftime('%Y', acquisition_date) ASC) AS `New acquisitions this year (Flow)` 
  FROM artworks 
  WHERE
    acquisition_date IS NOT NULL 
)
ORDER BY
   `Acquisition year`
