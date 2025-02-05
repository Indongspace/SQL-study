WITH x_flipper_length_mm AS (
  SELECT
    species,
    AVG(flipper_length_mm) AS x_mean
  FROM penguins
  GROUP BY
    species
), y_body_mass_g AS (
  SELECT
    species,
    AVG(body_mass_g) AS y_mean
  FROM penguins
  GROUP BY
    species
)
SELECT
  species,
  ROUND(cov / std, 3) AS corr
FROM (
  SELECT
    species,
    SUM((flipper_length_mm - (SELECT x_mean FROM x_flipper_length_mm WHERE penguins.species = x_flipper_length_mm.species)) * 
    (body_mass_g - (SELECT y_mean FROM y_body_mass_g WHERE penguins.species = y_body_mass_g.species))) AS cov,
    SQRT(SUM(POWER((flipper_length_mm - (SELECT x_mean FROM x_flipper_length_mm WHERE penguins.species = x_flipper_length_mm.species)), 2))) * 
    SQRT(SUM(POWER((body_mass_g - (SELECT y_mean FROM y_body_mass_g WHERE penguins.species = y_body_mass_g.species)), 2))) AS std
  FROM penguins
  GROUP BY
    species
)
