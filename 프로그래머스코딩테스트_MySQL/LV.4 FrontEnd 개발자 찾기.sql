# SKILLCODES 테이블은 개발자들이 사용하는 프로그래밍 언어에 대한 정보를 담은 테이블입니다. SKILLCODES 테이블의 구조는 다음과 같으며, NAME, CATEGORY, CODE는 각각 스킬의 이름, 스킬의 범주, 스킬의 코드를 의미합니다. 스킬의 코드는 2진수로 표현했을 때 각 bit로 구분될 수 있도록 2의 제곱수로 구성되어 있습니다.

# DEVELOPERS 테이블은 개발자들의 프로그래밍 스킬 정보를 담은 테이블입니다. DEVELOPERS 테이블의 구조는 다음과 같으며, ID, FIRST_NAME, LAST_NAME, EMAIL, SKILL_CODE는 각각 개발자의 ID, 이름, 성, 이메일, 스킬 코드를 의미합니다. SKILL_CODE 컬럼은 INTEGER 타입이고, 2진수로 표현했을 때 각 bit는 SKILLCODES 테이블의 코드를 의미합니다.

# 문제
# DEVELOPERS 테이블에서 Front End 스킬을 가진 개발자의 정보를 조회하려 합니다. 조건에 맞는 개발자의 ID, 이메일, 이름, 성을 조회하는 SQL 문을 작성해 주세요.

# 결과는 ID를 기준으로 오름차순 정렬해 주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : Front End 스킬을 가진 개발자의 정보를 조회 / CODE, SKILL_CODE
# 쿼리 계산 방법 : 1. WHERE SKILL_CODE & (SELECT SUM(CODE) FROM SKILLCODES WHERE CATEGORY = 'Front End') != 0로 1개라도 FrontEnd 기술을 가지고 있는 사람만 추출 -> 2. ORDER BY
# 데이터의 기간 :
# 사용할 테이블 : SKILLCODES, DEVELOPERS 
# Join KEY : CODE, SKILL_CODE
# 데이터 특징 : 비트 연산

# SKILLCODES 테이블에서 CATEGORY가 'Front End'로 되어있는 스킬들의 CODE를 이용해, 특정 개발자가 그 중 하나라도 보유했는지 확인하는 것.
# CODE 값들은 모두 2의 거듭제곱 형태라 bitwise 연산 사용 가능
# & 연산 결과가 0이 아니라면, 두 값에서 하나 이상의 비트가 겹친다는 뜻. 즉, 개발자가 적어도 하나의 FrontEnd기술을 보유하고 있다는 뜻. 0이라면, 겹치는 비트가 없으므로 해당 개발자는 FrontEnd 기술을 하나도 가지고 있지 않다는 뜻.
SELECT
    ID,
    EMAIL,
    FIRST_NAME,
    LAST_NAME
FROM DEVELOPERS
WHERE
    SKILL_CODE & (SELECT SUM(CODE) FROM SKILLCODES WHERE CATEGORY = 'Front End') != 0
ORDER BY
    ID ASC
    

