SELECT
    base.name
FROM (
    SELECT
        st.id,
        st.name,
        pa.salary,
        fr.friend_id
    FROM students AS st
    INNER JOIN friends AS fr
    ON st.id = fr.id
    INNER JOIN packages AS pa
    ON st.id = pa.id
) AS base
INNER JOIN packages AS pa
ON base.friend_id = pa.id
WHERE
    base.salary < pa.salary
ORDER BY
    pa.salary ASC
