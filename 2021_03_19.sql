데이터 결합 : JOIN
RDMBS는 중복을 최소화하는 데이터베이스

데이터를 확장(결합)
1. 컬럼에 대한 확장 : JOIN
2. 행에 대한 확장 : 집합연산자(UNION ALL, UNION(합집합), MINUS(차집합), INTERSECT(교집합)

grp3

emp테이블을 이용하여 다음을 구하시오

grp2에서 작성한 쿼리를 활요앟여

deptno 대신 부서명이 나올수 있도록 수정하시오



SELECT DECODE(deptno,

        max(sal), min(sal), round(avg(sal),2), sum(sal), count(sal), count(mgr), count(*)

FROM emp

GROUP BY deptno;



grp4

emp테이블을 이용하여 다음을 구하시오

직원의 입사 년월별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요

SELECT TO_CHAR(hiredate,'yyyymm')hire_yyyymm ,count(*)cnt

FROM emp

GROUP BY TO_CHAR(hiredate,'yyyymm');



grp5

emp테이블을 이용하여 다음을 구하시오

직원의 입사 년별로 몇명의 직원이 입사했는지 조회하는 쿼리를 작성하세요

SELECT TO_CHAR(hiredate,'yyyy')hire_yyyymm ,count(*)cnt

FROM emp

GROUP BY TO_CHAR(hiredate,'yyyy');



grp6

SELECT COUNT(*)

FROM dept;



SELECT *

FROM emp;



grp7

직원이 속한 부서의 개수를 조회하는 쿼리를 작성하시오(emp 테이블 사용)

SELECT COUNT(*) CNT

FROM

(SELECT deptno

FROM emp

GROUP BY deptno);







데이터를 확장(결합)

1. 컬럼에 대한 확장 : JOIN

2. goddp eogks ghkrwkd : 집합연산자(UNION ALL, UNION, MINUS, INTERSECT)



JOIN

1. 표준 SQL => ANSI SQL

2. 비표준 SQL - DBMS를 만드는 회사에서 만든 고유의 SQL 문법



ANSI : SQL

ORACLE : SQL



ANSI - NATURAL JOIN

 . 조회하고자 하는 테이블의 연결컬럼 명(타입도 동일)이 동일한 경우(emp, deptno, dept, deptno)

 . 연결 컬럼의 값이 동일할 때(=) 컬럼이 확장된다

 

SELECT *

FROM emp NATURAL JOIN dept;







ORACLE join : 

1. FROM 절에 조인할 테이블을 (,)콤마로 구분하여 나열

2. WHERE : 조인할 테이블의 연결조건을 기술



SELECT *

FROM emp, dept

WHERE emp.deptno = dept.deptno;



7369 SMITH, 7902 FORD

SELECT e.empno, e.ename, m.empno, m.ename

FROM emp e, emp m

WHERE e.mgr = m.empno;





ANSI SQL : JOIN WITH USING

조인 하려고 하는 테이블의 컬럼명과 타입이 같은 컬럼이 두개 이상인 상황에서

두 컬럼을 모두 조인 조건으로 참여시키지 않고, 개발자가 원하는 특정 컬럼으로만 연결을 시키고 싶을 때 사용





SELECT *

FROM emp JOIN dept USING(deptno);



SELECT *

FROM emp, dept

WHERE emp.deptno = dept.deptno;





JOIN WITH ON : NATURAL JOIN, JOIN WITH USING 을 대처할 수 있는 보편적인 문법

조인 컬럼을 개발자가 임의로 지정



SELECT *

FROM emp JOIN dept ON (emp.deptno = dept.deptno);



사원 번호, 사원이름, 해당사원의 상사 사번, 해당사원의 상사 이름 : join with on 을 이용하여 쿼리 작성

단 사원의 번호가 7369에서 7698인 사원들만 조회



SELECT e.empno, e.ename, m.empno, m.ename

FROM emp e JOIN emp m ON (e.mgr = m.empno)

WHERE e.empno BETWEEN 7369 AND 7698;



SELECT e.empno, e.ename, m.empno, m.ename

FROM emp e, emp m 

WHERE e.mgr = m.empno

  AND e.empno BETWEEN 7369 AND 7698;





논리적인 조인 형태

1. SELF JOIN : 조인 테이블이 같은 경우

   - 계층구조

2. NONEQUI-JOIN : 조인 조건이 =(equals)가 아닌 조인 



SELECT *

FROM emp, dept

WHERE emp.deptno != dept.deptno; --조인이 여러번 됨



SELECT *

FROM salgrade;



--salgrade를 이용해여 직원의 급여 등급 구하기

-- empno, ename, sal, 급여등급

-- ansi, oracle

SELECT *

FROM emp;



SELECT e.empno, e.ename, e.sal, s.grade

FROM emp e, salgrade s

WHERE e.sal BETWEEN s.losal AND s.hisal;



SELECT e.empno, e.ename, e.sal, s.grade

FROM emp e JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal);



데이터결합 실습 join0

emp, dept테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요



SELECT e.empno, e.ename, d.deptno, d.dname

FROM emp e JOIN dept d ON(e.deptno = d.deptno)

ORDER BY deptno;



SELECT empno, ename, emp.deptno, dname

FROM emp, dept

WHERE emp.deptno = dept.deptno;



join0_1 부서번호가 10,30인 데이터만 조회

SELECT empno, ename, emp.deptno, dname

FROM emp, dept

WHERE emp.deptno = dept.deptno

  AND emp.deptno IN (10,30);



join0_3 급여가 2500초과

SELECT empno, ename, sal, emp.deptno, dname

FROM emp, dept

WHERE emp.deptno = dept.deptno

  AND sal > 2500

ORDER BY deptno;



join0_3(급여가 2500초과 사번이 7600보다 큰 직원)

SELECT empno, ename, sal, emp.deptno, dname

FROM emp, dept

WHERE emp.deptno = dept.deptno

  AND sal > 2500

  AND empno >7600

ORDER BY deptno;



join0_4

(급여 2500초과, 사번이 7600보다 크고, RESEARCH부서에 속하는 직원)

SELECT empno, ename, sal, emp.deptno, dname

FROM emp, dept

WHERE emp.deptno = dept.deptno

  AND sal > 2500

  AND empno >7600

  AND dname = 'RESEARCH'

ORDER BY deptno;





