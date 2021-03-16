연산자 우선순위 (AND가 OR보다 우선순위가 높다)
==> 헷갈리면 ()를 사용하여 우선순위를 조정한다

SELECT *
FROM emp
WHERE ename = 'SMITH' OR ename = 'ALLEN' AND job = 'SALESMAN' ;
 
 ==> 직원의 이름이 ALLEN 이면서 job이 SALESMAN 이거나
     직원의 이름이 SMITH 인 직원 정보를 조회
     
 ==> 직원의 이름이 ALLEN 이거나 SMITH 이면서
     job이 SALESMAN 인 직원을 조회
     
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN' )  AND job = 'SALESMAN' ;


WHERE14)
emp 테이블에서
1. job이 SALESMAN이거나
2. 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요

SELECT *
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%' AND hiredate >= TO_DATE ('1981-06-01', 'YYYY-MM-DD');



[데이터 정렬]
-- 데이터 정렬이 필요한 이유?
1. TABLE 객체에는 데이터를 저장/조회시 순서를 보장하지 않음
 ==> 오늘 실행한 쿼리를 내일 실행할 경우 동일한 순서로 조회가 되지 않을 수도 있다.
 
2. 현실세계에서는 정렬된 데이터가 필요한 경우가 있다.
 ==> 게시판의 게시글은 보편적으로 가장 최신글이 처음에 나오고, 가장 오래된 글이 맨 밑에 있다.
 

: ORDER BY ==> SELECT > FROM > (WHERE) > ORDER BY
정렬방법 : ORDER BY 컬럼명 | 컬럼인덱스(순서) | 별칭 [정렬순서]
정렬순서 : 기본 ASC(오름차순), DESC(내림차순)

SELECT *
FROM emp
ORDER BY ename DESC;

SELECT *
FROM emp
ORDER BY job DESC, sal, ename;


정렬 : 컬럼명이 아니라 SELECT 절의 컬럼 순서(index)
SELECT *
FROM emp
ORDER by 2; --컬럼번호로 정렬가능

SELECT ename, empno, job, mgr
FROM emp
ORDER by 2; --선택된 컬럼을 기준으로 두번째

SELECT ename, empno, job, mgr AS m
FROM emp
ORDER by m; --명칭으로도 정렬가능


ORDER BY 1)
- dept테이블의 모든 정보를 부서이름으로 오름차순 저렬로 조회되도록 쿼리를 작성하세요
- dept테이블의 모든 정보를 부서위치로 내림차순 저렬로 조회되도록 쿼리를 작성하세요
SELECT *
FROM dept
ORDER BY dname, loc DESC ;


ORDER BY 2)
- emp 테이블에서 상여(comm)정보가 있는 사람들만 조회하고 상여(comm)를 많이 받는 사람이 먼저 조회되도록 정렬하고 
상여가 같을 경우 사번으로 내림차순 정렬하세요 (상여가 0인 사람은 상여가 없는 것으로 간주)
SELECT *
FROM emp
WHERE comm IS NOT NULL
  AND comm != 0
ORDER BY comm DESC, empno;

SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno;


ORDER BY 3)
- emp 테이블에서 관리자가 있는 사람들만 조회하고, 직군(job) 순으로 오름차순 정렬하고, 직구니 같을 경우 사번이 큰 사원이 먼저 조회되도록
  쿼리를 작성하세요
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

ORDER BY 4)
- emp 테이블에서 10번 부서 (deptno) 혹은 30번 부서에 속하는 사람 중 금여가 1500이 넘는 사람들만 조회하고 이름으로 내림차순 정렬되도록
  쿼리를 작성하세요
SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30) AND sal > 1500
ORDER BY ename; 

SELECT *
FROM emp
WHERE deptno IN (10, 30)  
  AND sal > 1500
ORDER BY ename;



페이징 처리 : 전체 데이터를 조회하는게 아니라 페이지 사이즈가 정해졌을 때 원하는 페이지의 데이터만 가져오는 방법
 ( 1. 400건을 다 조회하고 필요한 20건만 사용하는 방법 --> 전체조회 (400)
   2. 400건의 데이터 중 원하는 페이지의 20건만 조회 --> 페이징 처리 (20) )
페이징 처리(게시글) ==> 정렬의 기준이 뭔데?? (일반적으로는 게시글의 작성일시 역순)
페이징 처리 시 고려할 변수 : 페이지 번호, 페이지 사이즈

ROWNUM : 행 번호를 부여하는 특수 키워드(오라클에서만 제공)
  * 제약사항
    ROWNUM은 WHERE 절에서도 사용 가능하다
     단, ROWNUM의 사용을 1부터 사용하는 경우에만 사용 가능
     WHERE ROWNUM BETWEEN 1 AND 5; ==> O
     WHERE ROWNUM BETWEEN 6 AND 10; ==> X
     WHERE ROWNUM = 1; ==> O
     WHERE ROWNUM = 2; ==> X
     WHERE ROWNUM < 10; ==> O
     WHERE ROWNUM > 10; ==> X
     
    
전체 데이터 : 14건
페이지사이즈 : 5건
1번째 페이지 : 1~5
2번째 페이지 : 6~10
3번째 페이지 : 11~15(14)

인라인 뷰
ALIAS


SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 5; --ROWNUM의 사용을 1부터 사용하는 경우에만 사용 가능

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 6 AND 10; --오류


sql 실행순서 : FROM > WHERE > SELECT > ORDER BY 
-- ORDER BY와 ROWNUM을 동시에 사용하면 정렬된 기준으로 ROWNUM이 부여되지 않는다
    ( SELECT 절이 먼저 실행되므로 ROWNUM이 부여된 상태에서 ORDER BY 절에 의해 정렬이 된다)
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

SELECT ROWNUM, empno, ename
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename);
 
-- 인라인을 사용하는 이유 : 정렬 순서, 페이징 1이 아닌 숫자
SELECT *
FROM
(SELECT ROWNUM AS rn, empno, ename -- ALIAS 별칭 사용
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename))
WHERE rn BETWEEN (:page-1)*:pageSize + 1 AND :page*:pageSize; --별칭 사용해서 6부터 가능


pageSize : 5건
1 page : rn BETWEEN 1 AND 5;
2 page : rn BETWEEN 6 AND 10;
3 page : rn BETWEEN 11 AND 15;
n page : rn BETWEEN (n-1)*pageSize + 1 AND n*pageSize;

WHERE rn BETWEEN (:page-1)*:pageSize + 1 AND :page*:pageSize; (:변수 - 변할 수 있는 값)


ROWNUM 1)
- emp 테이블에서  ROWNUM 값이 1~10인 값만 조회하는 쿼리를 작성해보세요
SELECT ROWNUM AS rn, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


ROWNUM 2)
- ROWNUM 값이 11~20(1~14)인 값만 조회하는 쿼리를 작성해보세요
SELECT rn, empno, ename
FROM(SELECT ROWNUM rn, empno, ename
     FROM emp)
WHERE rn BETWEEN 11 AND 20;

ROWNUM 3)
- emp 테이블의 사원정보를 이름 컬럼으로 오름차순 적용했을 때의 11~14번째 행을 다음과 같이 조회하는 쿼리를 작성해보세요
SELECT *
FROM (SELECT ROWNUM rn, empno, ename
      FROM ( SELECT *
             FROM emp
             ORDER BY ename))
WHERE rn BETWEEN 11 AND 20;


-- ROWNUM을 쓸때 모든컬럼 조회하는 방법
SELECT ROWNUM, emp.*
FROM emp
ORDER BY ename;

SELECT ROWNUM, e.* --FROM절에서 e라고 바꾸었으므로 emp가아닌 e사용
FROM emp e --FROM절에는 AS 쓸수 없다
ORDER BY ename;
