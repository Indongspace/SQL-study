-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
-- Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. 
-- If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
-- Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
-- If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
-- Write a query to help Eve.

-- Sample Output
-- Maria 10 99
-- Jane 9 81
-- Julia 9 88 
-- Scarlet 8 78
-- NULL 7 63
-- NULL 7 68

-- Note
-- Print "NULL"  as the name if the grade is less than 8.

-- Explanation
-- So, the following students got 8, 9 or 10 grades:
-- Maria (grade 10)
-- Jane (grade 9)
-- Julia (grade 9)
-- Scarlet (grade 8)

-- Ketty는 Eve에게 세 개의 열(Name, Grade, Mark)로 구성된 보고서를 생성하는 과제를 주었습니다. Ketty는 8 미만의 점수를 받은 학생들의 이름이 포함되지 않기를 원합니다. 
-- 보고서는 Grade를 기준으로 내림차순으로 정렬되어야 합니다. 즉, 높은 등급이 먼저 나옵니다. 동일한 등급(8-10)을 받은 학생이 여러 명인 경우, 해당 학생들은 이름을 알파벳 순으로 정렬합니다. 
-- 마지막으로, Grade가 8 미만인 경우에는 이름을 "NULL"로 표시하고, 등급을 내림차순으로 정렬합니다. 동일한 등급(1-7)을 받은 학생이 여러 명인 경우, 이들은 Marks를 오름차순으로 정렬합니다.
-- Eve를 도와줄 쿼리를 작성하세요.

-- 예시 출력
-- Maria 10 99
-- Jane 9 81
-- Julia 9 88
-- Scarlet 8 78
-- NULL 7 63
-- NULL 7 68

-- 설명
-- 다음과 같이 8, 9, 10 등급을 받은 학생들은:
-- Maria (Grade 10)
-- Jane (Grade 9)
-- Julia (Grade 9)
-- Scarlet (Grade 8)
-- 입니다.
# 쿼리를 작성하는 목표, 확인할 지표 : 등급 기준으로 8미만이면 이름에 null & 정렬 조건을 설정 / grade, mark
# 쿼리 계산 방법 :
# 1. join 조건으로 students의 mark와 grade의 MIN_MAX 구간 사이의 mark를 설정 ->
# 2. case문으로 8등급 미만이면 이름을 null로 설정 ->
# 3. 조건1) 등급 기준 내림차순 / 조건2) 이름이 null이 아니면 st.name 기준 오름차순 / 조건3) 이름이 null이면 st.marks 기준 오름차순
# 데이터의 기간 :
# 사용할 테이블 : students, grades
# Join KEY : marks, min_mark/max_mark
# 데이터 특징 :
SELECT
 # 2. case문으로 8등급 미만이면 이름을 null로 설정 
 CASE
    WHEN gr.grade < 8 THEN NULL
    ELSE st.name
 END AS name,
 gr.grade,
 st.marks
FROM students AS st
# 1. join 조건으로 students의 mark와 grade의 MIN_MAX 구간 사이의 mark를 설정
INNER JOIN grades AS gr
ON st.marks BETWEEN gr.min_mark AND gr.max_mark
# 3. 조건1) 등급 기준 내림차순 / 조건2) 이름이 null이 아니면 st.name 기준 오름차순 / 조건3) 이름이 null이면 st.marks 기준 오름차순  
ORDER BY
    gr.grade DESC,
    CASE
        WHEN name IS NOT NULL THEN st.name
        ELSE NULL
    END ASC,
    CASE
        WHEN name IS NULL THEN st.marks
        ELSE NULL
    END ASC
    

