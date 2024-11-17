SELECT
    CASE
        WHEN gr.grade < 8 THEN NULL
        ELSE std.name
    END AS name,
    gr.grade,
    std.marks
FROM students AS std
INNER JOIN grades AS gr
ON std.marks BETWEEN gr.min_mark AND max_mark
ORDER BY
    grade DESC,
    CASE
        WHEN name IS NOT NULL THEN name
        ELSE NULL
    END ASC,
    CASE
        WHEN name IS NULL THEN marks
        ELSE NULL
    END ASC
    