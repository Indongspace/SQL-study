# 쿼리를 작성하는 목표, 확인할 지표 : 성적이 오른 학생 찾기 / subject, score, exam_date
# 쿼리 계산 방법 : 1. 시험을 두 번 이상 본 학생만 추출 -> 2. 과목별 첫 시험의 성적과 비교해서 가장 최근에 본 성적이 더 높은 학생만 추출 -> 3. 정렬
# 데이터의 기간 : x
# 사용할 테이블 : scores
# JOIN KEY : student_id, subject
# 데이터 특징 : x
WITH twice AS (
    # 1
    SELECT
        student_id,
        subject,
        COUNT(*) AS subject_cnt
    FROM scores
    GROUP BY
        student_id, subject
    HAVING
        COUNT(*) > 1
), base AS (
    SELECT
        s.student_id,
        s.subject,
        s.score,
        s.exam_date
    FROM scores AS s
    # 1
    INNER JOIN twice AS t
    ON s.student_id = t.student_id AND
        s.subject = t.subject
)
# 2
SELECT
    DISTINCT
        student_id,
        subject,
        first_score,
        latest_score
FROM (
SELECT
    student_id,
    subject,
    FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS first_score,
    LAST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS latest_score
FROM base   
) AS a
WHERE
    first_score < latest_score
# 3
ORDER BY
    student_id, subject