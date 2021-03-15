2021-03-12 복습
조건에 맞는 데이터 조회 : WHERE절 - 기술한 조건을 ;

-- row : 14개. col : 8개
SELECT *
FROM emp
where 1 = 1;

SELECR *
FROM emp
WHERE deptno = deptno; 


TO_DATE('81/03/01', 'YY/MM/DD');


-- 입사일자가 1982년 1월 1일 이후인 모든 직원 조회하는 SELECT 쿼리를 작성하세요
SELECT *
FROM emp
WHERE HIREDATE  >= TO_DATE('1982/01/01', 'YYYY/MM/DD') ;

SELECT *
FROM emp
WHERE HIREDATE  >= TO_DATE('19820101', 'YYYY/MM/DD') ;

SELECT *
FROM emp
WHERE HIREDATE  >= TO_DATE('1982-01-01', 'YYYY/MM/DD') ;


WHERE절에서 사용 가능한 연산자
(비교 ( =, !=, >, < ....)

a + b;
a++ ==> a =a + 1;
++a ==> a =a + 1;



--BETWEEN AND : 포함(이상, 이하)
                초과, 미만의 개념을 적용하려면 비교 연산자를 사용해야한다.
                
비교 대상 BETWEEN 비교 대상의 허용 시작 값 AND 비교 대상의 허용 종료 값
ex : 부서번호가 10번에서 20번 사이의 속한 지원들만 조회
    10, 1, 12 ..... 20
SELECT *
FROM emp
WHERE deptno BETWEEN 10 AND 20;

emp 테이블에서 급여(sal)가 1000보다 크거나 같고 2000보다 작거나 같은 직원들만 조회
    sal >= 1000 AND sal <=2000
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <=2000;

SELECT *
FROM emp
WHERE sal >= 1000 
  AND sal <=2000
  AND deptno = 10;
  
  
실습(WHERE 1)
--emp 테이블에서 입사 일자가 1982년 월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND TO_DATE('1983/01/01', 'YYYY/MM/DD');


true AND true ==> true
true AND false ==> false



--IN 연산자
대상자 IN (대상자와 비교할 값1, 대상자와 비교할 값2, 대상자와 비교할 값3....)
deptno IN(10, 20) ==> deptno값이 10이나 20번이면 TRUE;

SELECT *
FROM emp
WHERE deptno IN (10, 20);

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 20;
   
   
-- 10은 10과 같거나 10은 20과 같다
        TRUE OR FALSE ==> TRUE
SELECT *
FROM emp
WHERE 10 IN (10, 20);


true OR true ==> true
true OR false ==> true


-- WHERE 3
-- users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회하시오

SELECT *
FROM users ;

SELECT userid AS 아이디, usernm AS 이름, alias AS 별명
FROM users 
WHERE userid IN ('brown', 'cony', 'sally');



-- LIKE 연산자 : 문자열 매칭 조회
게시물 : 제목, 검색, 내용 검색
        제목에 맥북에어가 들어가는 게시글란 조회
        
        1. 얼마 안된 맥북에어 팔아요
        2. 맥북에어 팔아요
        3. 팝니다. 맥북에어
        
SELECT *
FROM 게시글
WHERE 제목 LIKE '%매북에어%'
    OR 내용 LIKE '%매북에어%';
        
% : 0개 이상의 문자
_ : 1개의 문자

userid 가 c로 시작하는 모든 사용자
SELECT *
FROM users
WHERE userid LIKE 'c%';


userid가 c로 시작하면서 c이후에 3개의 글자가 오는 사용자
SELECT *
FROM users
WHERE userid LIKE 'C__';

useriddp l이 들어가는 모든 사용자 조회
SELECT *
FROM users
WHERE userid LIKE '%l%';

--where4
member 테이블에서 회원의 성이[신]씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

--where5
member 테이블에서 회원의 이름에 글자 [이]가 들어가는 모든 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';


-- IS, IS NOT (NULL비교) : NULL을 표현할 때는 = , != 이 아닌 IS, IS NOT 으로 해야한다.
emp 테이블에서 comm 컬럼의 값이 NULL인 사람만 조회
SELECT *
FROM emp
where comm IS NULL;

SELECT *
FROM emp
where comm IS NOT NULL;

emp 테이블에서 매니저가 없는 직원만 조회
SELECT *
FROM emp
WHERE mgr IS NULL;

BETWEEN AND, IN, LIK, IS
논리 연산자 : AND, OR, NOT
AND : 두 가지 조건을 동시에 만족시키는지 확인할 때
     조건1 AND 조건2
OR : 두 가지 조건 중 하나라도 만족시키는지 확인할 때
     조건1 OR 조건2
NOT : 부정형 논리연산자, 특정 조건을 부정
     mgr IS NULL : mgr 컬럼의 값이 NULL인 사람만 조회
     mgr IS NOT NULL : mgr 컬럼의 값이 NULL이 아닌 사람만 조회
     
emp 테이블에서 mgr의 사번이 7698이면서 sal값이 1000보다 큰 직원만 조회;
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE mgr = 7698
  AND sal > 1000;


AND 조건이 많아지면 : 조회되는 데이터 건수는 줄어든다.
OR  조건이 많아지면 : 조회되는 데이터 건수는 많아진다.

NOT : 부정형 연산자, 다른 연산자와 결합하여 쓰인다.
    IS NOT, NOT IN, NOT LIKE


--직원의 부서번호가 30번이 아닌 직원들;
SELECT *
FROM emp
WHERE deptno != 30;

SELECT *
FROM emp
WHERE deptno NOT IN(30);

--직원의 이름이 S로 시작하는 이름이 아닌 직원들
SELECT *
FROM emp
WHERE ename NOT LIKE 'S%';

-- NOT IN 연산자 사용시 주의점 : 비교 값 중에 NULL이 포함되면 데이터가 조회되지 않는다
SELECT *
FROM emp
WHERE mgr IN(7698, 7839, NULL);
*해석 : mgr =7698 OR mgr =7839 OR mgr = NULL


SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839, NULL);
*해석[시험] : mgr != 7698 AND mgr != 7839 AND mgr != NULL 
        TRUE FALSE 의미가 없음 AND FALSE

mgr 7698 ==> mgr != 7698
OR       ==> AND

--WHERE 7
emp 테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--WHERE 8
emp테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE deptno != 10  --deptno NOT IN (10)
 AND hiredate  >= TO_DATE('1981/06/01', 'YYYY/MM/DD') ;

--WHERE 10
emp테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
(부서는 10, 20, 30 만 있다고 가정하고 IN 연산자를 사용)
SELECT *
FROM emp
WHERE deptno IN(20, 30) 
  AND hiredate  >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--WHERE 11
emp테이블에서 job이 SALESMAN 이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR hiredate  >= TO_DATE('1981/06/01', 'YYYY/MM/DD'); 
   

--WHERE 12
emp테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회하세요
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno LIKE '78%' ; -- 묵시적 형변환 (숫자타입 -> 문자타입)
   
   
--WHERE 13 (과제)
emp테이블에서 job이 SALESMAN 이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회하세요
(LIKE연산자를 사용불가)
SELECT *
FROM emp
WHERE job = 'SALESMAN'
   OR empno BETWEEN 7800 AND 7899 ;