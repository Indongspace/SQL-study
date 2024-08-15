-- DEVELOPER_INFOS 테이블에서 Python 스킬을 가진 개발자의 정보를 조회하려 합니다. 
-- Python 스킬을 가진 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.
-- 결과는 ID를 기준으로 오름차순 정렬해 주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : PYTHON 스킬 가진 개발자 조회 / SKILL
# 쿼리 계산 방법 : WHERE 
# 데이터의 기간 :
# 사용할 테이블 : DEVELOPER_INFOS
# Join KEY :
# 데이터 특징 :
SELECT
    ID,
    EMAIL,
    FIRST_NAME,
    LAST_NAME
FROM DEVELOPER_INFOS
WHERE
    SKILL_1 = 'Python' OR
    SKILL_2 = 'Python' OR
    SKILL_3 = 'Python'
ORDER BY
    ID ASC
    