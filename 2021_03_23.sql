월별실적
             반도체      핸드폰       냉장고
2021년 1월 :  500         300         400

2021년 1월 :  500         300         400

2021년 1월 :  500         300         400

.
.
.

2021년 1월 :  500         300         400

OUTERHOIN1) 
BUYPROD테이블에 구매일자가 2005년 1월 25일인 데이터
SELECT buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0)
FROM   buyprod,prod
WHERE  buyprod.buy_prod(+) = prod.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

OUTERHOIN2-3) 
buy_date컬럼이 null인 항목이 안나오도록 다음처럼 데이터를 채워지도록 쿼리를 작성하세요.

SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0)
FROM   buyprod,prod
WHERE  buyprod.buy_prod(+) = prod.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

OUTERHOIN4) 
cycle, product테이블을 이용하여 고객이 애음하는 제품명칭을 표현하고, 애음하지 않는 제품도 다음과 같이 조회되도록 쿼리 작성
(고객은 cid=1인 고객만 나오도록 제한, null처리)
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT product.*, cid, day, cnt
FROM product LEFT OUTER JOIN cycle ON( product.pid = cycle.pid AND cid = 1);

SELECT product.*, :cid, NVL(day, 0) day, NVL(cnt,0) cnt
FROM product LEFT OUTER JOIN cycle ON( product.pid = cycle.pid AND cid = :cid); -- :cid 동일하다

SELECT product.*, :cid, NVL(day, 0) day, NVL(cnt,0) cnt
FROM product, cycle 
WHERE product.pid = cycle.pid(+)
AND cid(+) = :cid;


OUTERHOIN5)
OUTERHOIN4를 바탕으로 고객이름 컬럼 추가하기

WHERE, GROUP BY(그룹핑), JOIN

JOIN
문법
 : ANSI / ORALCE
논리적 형태
 : SELF JOIN, NON-EQUI-JOIN <==> EQUI-JOIN
연결조건 성공 실패에 따라 조회여부 결저
 : OUTER JOIN <==> INNER JOIN : 연결이 성공적으로 이루어진 행에 대해서만 조회가 되는 조인


SELECT *
FROM dept INNER JOIN emp ON(dept.deptno = emp.deptno);

CROSS JOIN
 : 별도의 연결 조건이 없는 조인
  - 묻지마 조인
  - 두 테이블의 행간 연결가능한 모든 경우의 수로 연결
    ==> CROSS JOIN의 결과는 두 테이블의 행의 수를 곱한 값과 같은 행이 반환된다.
  - 데이터 복제를 위해 사용

SELECT *
 FROM emp CROSS JOIN dept;
 
 
SELECT *
 FROM emp, dept;
 
 
CROSSJOIN1)
customer, product 테이블을 이용하여 고객이 애음 가능한 모든 제품의 정보를 결합하여 다음과 같이 조회되도록 쿼리를 작성하세요
SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM customer CROSS JOIN product;

SELECT STORECATEGORY
FROM BURGERSTORE
WHERE SIDO ='대전'
GROUP BY STORECATEGORY;


-- 대전 중구
도시발전지수 : (KFC + 맥도날드 + 버거킹) / 롯데리아

SELECT *
FROM BURGERSTORE
WHERE SIDO ='대전'
 AND SIGUNGU ='중구';
 
SELECT SIDO, SIGUNGU
FROM BURGERSTORE
WHERE SIDO ='대전'
  AND SIGUNGU ='중구';

SELECT sum(count(STORECATEGORY)) sum
 FROM  BURGERSTORE
 WHERE STORECATEGORY IN('BURGER KING', 'MACDONALD', 'KFC')
 AND SIDO ='대전'
 AND SIGUNGU ='중구'
 GROUP BY STORECATEGORY ;


--도시발전지수 구하기
SELECT SIDO, SIGUNGU, sum / lotteria 도시발전지수
FROM BURGERSTORE B,
 ( SELECT sum(count(STORECATEGORY)) sum
     FROM  BURGERSTORE
     WHERE STORECATEGORY IN('BURGER KING', 'MACDONALD', 'KFC')
     AND SIDO ='대전'
    AND SIGUNGU ='중구'
    GROUP BY STORECATEGORY),
 ( SELECT sum(count(STORECATEGORY)) lotteria
 FROM  BURGERSTORE
 WHERE STORECATEGORY = 'LOTTERIA'
 AND SIDO ='대전'
 AND SIGUNGU ='중구'
 GROUP BY STORECATEGORY)
    
WHERE SIDO ='대전'
  AND STORECATEGORY = 'LOTTERIA'
  AND SIGUNGU ='중구'
  
GROUP BY SIDO;
  
  
-- 분자  
SELECT sum(count(STORECATEGORY)) sum
 FROM  BURGERSTORE
 WHERE STORECATEGORY IN('BURGER KING', 'MACDONALD', 'KFC')
 AND SIDO ='대전'
 AND SIGUNGU ='중구'
 GROUP BY STORECATEGORY;
 
-- 분모
SELECT sum(count(STORECATEGORY)) lotteria
 FROM  BURGERSTORE
 WHERE STORECATEGORY = 'LOTTERIA'
 AND SIDO ='대전'
 AND SIGUNGU ='중구'
 GROUP BY STORECATEGORY
 
 
-- 행을 컬럼으로 변경(PIVOT)
SELECT sido, sigungu, storecategory,
        ROUND ( SUM(DECODE(storecategory, 'BURGER KING', 1, 0)) bk, 
        SUM(DECODE(storecategory, 'KFC', 1, 0)) kfc,
        SUM(DECODE(storecategory, 'MACDONALD', 1, 0)) mac,
       DECODE( SUM(DECODE(storecategory, 'LOTTERIA', 1, 0)), 0, 1 ,SUM(DECODE(storecategory, 'LOTTERIA',1,0))),2) l
        
--        CASE
--            WHEN storecategory = 'BURGER KING' THEN 1
--            ELSE 0
--        END bk

FROM burgerstore
GROUP BY sido, sigungu
ORDER BY sido, sigungu;

--        storecategort가 BURGER KING 이면 1, 0,
--        storecategort가 KFC 이면 1, 0,
--        storecategort가 MACDONALD 이면 1, 0,
--        storecategort가 LOTTERIA 이면 1, 0,


