# 다음은 어느 의류 쇼핑몰에 가입한 회원 정보를 담은 USER_INFO 테이블과 온라인 상품 판매 정보를 담은 ONLINE_SALE 테이블 입니다. USER_INFO 테이블은 아래와 같은 구조로 되어있으며 USER_ID, GENDER, AGE, JOINED는 각각 회원 ID, 성별, 나이, 가입일을 나타냅니다.
# GENDER 컬럼은 비어있거나 0 또는 1의 값을 가지며 0인 경우 남자를, 1인 경우는 여자를 나타냅니다.

# ONLINE_SALE 테이블은 아래와 같은 구조로 되어있으며 ONLINE_SALE_ID, USER_ID, PRODUCT_ID, SALES_AMOUNT, SALES_DATE는 각각 온라인 상품 판매 ID, 회원 ID, 상품 ID, 판매량, 판매일을 나타냅니다.

# 문제
# USER_INFO 테이블과 ONLINE_SALE 테이블에서 2021년에 가입한 전체 회원들 중 상품을 구매한 회원수와 상품을 구매한 회원의 비율(=2021년에 가입한 회원 중 상품을 구매한 회원수 / 2021년에 가입한 전체 회원 수)을 년, 월 별로 출력하는 SQL문을 작성해주세요. 상품을 구매한 회원의 비율은 소수점 두번째자리에서 반올림하고, 전체 결과는 년을 기준으로 오름차순 정렬해주시고 년이 같다면 월을 기준으로 오름차순 정렬해주세요.

# 쿼리를 작성하는 목표, 확인할 지표 : 2021년에 가입한 회원들 중 년 월 별로 상품을 구매한 회원의 비율 구하기 / JOINED, SALES_DATE, COUNT(USER_ID)
# 쿼리 계산 방법 : 1. WHERE로 2021년 가입자 정보만 사용 -> 2. SALES_DATE를 년, 월별로 GROUP BY -> 3. 여러 개 산 사람도 있기 때문에 COUNT(DISTINCT)
# 데이터의 기간 : 2021
# 사용할 테이블 : USER_INFO, ONLINE_SALE 
# Join KEY : USER_ID
# 데이터 특징 :

SELECT
    YEAR(SALE.SALES_DATE) AS YEAR,
    MONTH(SALE.SALES_DATE) AS MONTH,
    # 여러 개 산 사람도 있기 때문에 DISTINCT
    COUNT(DISTINCT SALE.USER_ID) AS PURCHASED_USERS,
    ROUND(COUNT(DISTINCT SALE.USER_ID) / (SELECT COUNT(*) FROM USER_INFO WHERE YEAR(JOINED) = '2021'), 1) AS PURCHASED_RATIO
FROM USER_INFO AS US
INNER JOIN ONLINE_SALE AS SALE
ON US.USER_ID = SALE.USER_ID
# 2021년 가입자 정보만 사용
WHERE
    US.JOINED BETWEEN '2021-01-01' AND '2021-12-31'
# SALES_DATE를 년, 월별로 GROUP BY JOINED는 가입한 회원의 날짜이므로 사용 X
GROUP BY
    YEAR(SALE.SALES_DATE),
    MONTH(SALE.SALES_DATE)
ORDER BY
    YEAR,
    MONTH