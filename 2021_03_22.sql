JOIN2)
erd 다이어그램을 참고하여 buyer, prod 테이블을 조인하여 buyer별 담당하는 제품정보를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요
SELECT *
FROM buyer;

SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name
FROM buyer b, prod p
WHERE p.prod_buyer = b.buyer_id;

JOIN3)
erd 다이어그램을 참고하여 member, cart, prod 테이블을 조인하여 회원별 장바구니에 담은 제품 정보를 다음과 같은 결과가 나오는 쿼리를 작성해보세요
SELECT *
FROM cart;

SELECT m.mem_id, m.mem_name, p.prod_id, p.prod_name, c.cart_qty
FROM member m, cart c, prod p
WHERE m.mem_id = c.cart_member
  AND c.cart_prod = p.prod_id;
 
-- 조인 사용하기 
FROM member JOIN cart ON(m.mem_id = c.cart_member) 
            JOIN prod ON(c.cart_prod = p.prod_id);
           
           
JOIN4)
erd 다이어그램을 참고하여 customer, cycle 테이블을 조인하여 고객별 애음 제품, 애음요일, 개수를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요.
SELECT *
FROM customer;

SELECT *
FROM cycle;

SELECT cu.cid, cu.cnm, cy.pid, cy.day, cy.cnt
FROM customer cu, cycle cy
WHERE cu.cnm IN('brown', 'sally')
AND cu.cid = cy.cid;



JOIN5)
erd 다이어그램을 참고하여 customer, cycle, product 테이블을 조인하여 고객별 애음 제품, 애음용일, 개수, 제품명을 다음과 같은 결과가 나오도록 쿼리를 작성해보세요
SELECT *
FROM product;

SELECT cu.cid, cu.cnm, cy.pid, p.pnm, cy.day, cy.cnt
FROM customer cu, cycle cy, product p
WHERE cu.cid IN(1,2)
AND cu.cid = cy.cid
AND cy.pid = p.pid;



JOIN6)
SUM(cycle.cnt)

GROUP BY cu.cid, cu.cnm, cy.pid, p.pnm

--과제 (system)
SELECT *
FROM dba_users;

ALTER USER hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY java;

hr에 접속해서 과제하기




OUTER JOIN : 컬럼 연결이 실패해도 [기준]이 되는 테이블 쪽의 컬럼 정보는 나오도록 하는 조인
LEFT OUTER JOIN : 기준이 왼쪽에 기술한 테이블이 되는 OUTER JOIN
RIGHT OUTER JOIN : 기준이 오른쪽에 기술한 테이블이 되는  OUTER JOIN
FULL OUTER JOIN : LEFT OUTER JOIN + RIGHT OUTER JOIN - 중복 데이터 제거

테이블1 JOIN 테이블2

테이블1 LEFT OUTER JOIN 테이블2
== 테이블2 RIGHT OUTER JOIN 테이블1

직원의 이름, 직원의 상사 이름 두개의 컬럼이 나오도록 join query 작성
13건(KING이 안나와도 괜찮음)

SELECT e.name, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno

SELECT e.name, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

SELECT e.name, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);


--ORACLE SAL OUTER JOIN 표기 : (+)
--OUTER 조인으로 인해 데이터가 안나오는 쪽 컬럼에 (+)를 붙여준다

SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.ename, m.ename, m.deptno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+)
 AND m.deptno = 10;


SELECT e.ename, m.ename, m.deptno
FROM emp e ,emp m
WHERE e.mgr = m.empno(+)
 AND m.deptno(+) = 10;


SELECT e.ename, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT e.ename, m.ename, m.deptno
FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);

--데이터는 몇건이 나올까 그려볼것

SELECT e.ename, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);


--FRULL OUTER : LEFT OUTER(14) + RIGHT OUTE(21)R - 중복데이터 1개만 남기고 제거(13) = 22
SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

--FULL OUTER 조인은 오라클 SQL문법으로 제공하지 않는다
SELECT e.ename, m.ename
FROM emp e, emp m
WHERE e.mgr(+) = m.empno (+); --한쪽만 가능하다

ouerjoin1)
SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM buyprod e RIGHT OUTER JOIN prod m ON ( e.buy_prod - m.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));


모든 제품을 다 보여주고, 실제 구매가 있을 때는 구매수량을 조회, 없을 경우는 null로 표현
제품코드 : 수량

SELECT *
FROM prod;

