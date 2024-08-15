# DEVELOPERS 테이블에서 Python이나 C# 스킬을 가진 개발자의 정보를 조회하려 합니다. 
# 조건에 맞는 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.
# 결과는 ID를 기준으로 오름차순 정렬해 주세요.
# 쿼리를 작성하는 목표, 확인할 지표 : PYTHON OR C# 스킬 가진 개발자 정보 조회 / 오름차순
# 쿼리 계산 방법 : WHERE & / ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : SKILLCODES, DEVELOPERS
# Join KEY : SKILL_CODE, CODE
# 데이터 특징 : 비트 연산 해야 함

SELECT
    ID,
    EMAIL,
    FIRST_NAME,
    LAST_NAME
FROM DEVELOPERS
WHERE
    SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME LIKE 'Py%') OR
    SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME LIKE 'C#')
ORDER BY
    ID ASC
    