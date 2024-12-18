WITH in_ani AS (
    SELECT
        animal_id,
        animal_type,
        name,
        sex_upon_intake
    FROM animal_ins
    WHERE
        sex_upon_intake LIKE('Intact%')
), out_ani AS (
    SELECT
        animal_id,
        animal_type,
        name,
        sex_upon_outcome
    FROM animal_outs
    WHERE
        sex_upon_outcome LIKE('Spayed%') OR sex_upon_outcome LIKE('Neutered%')
)
SELECT
    i.animal_id,
    i.animal_type,
    i.name 
FROM in_ani AS i
INNER JOIN out_ani AS o
ON i.animal_id = o.animal_id
ORDER BY
    animal_id ASC
    