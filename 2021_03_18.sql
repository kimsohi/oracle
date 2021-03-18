날짜관련 함수
MONTHS_BTWEEN : 인자 - start date, end date, 반환값 : 두 일자 사이의 개월 수

ADD_MONTHS (***)
인자 : date, number 더할 개월 수 : date로 부터 x개월 뒤의 날짜

date + 90
1/15 3개월 뒤의 날짜

NEXT_DAY (***) 
인자 : date, number(weekday, 주간일자)
date 이후의 가장 첫 번째 주간 일자에 해당하는 date를 반환

LAST_DAY (***)
인자 : date : date가 속한 월의 마지막 일자를 date로 반환

MONTHS_BETWEEN
SELECT ename, TO_CHAR(hiredate, 'yyyy/mm/dd HH24:mi:ss') hiredate,
       MONTHS_BETWEEN(sysdate, hiredate),
       ADD_MONTHS(SYSDATE,5)ADD_MONTHS,
       ADD_MONTHS(TO_DATE('2021-02-15', 'YYYY-MM-DD'), 5)ADD_MONTHS2,
       NEXT_DAY(SYSDATE,1) NEXT_DAY,
       LAST_DAY(SYSDATE) LAST_DAY,
       TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM')  || '01', 'YYYYMMDD') FIRST_DAY
FROM emp;

 /*  SYSDATE를 이용하여 SYSDATE가 속한 월의 첫번째 날짜 구하기
        SYSDATE를 이용해서 년월까지 문자로 구하기 + || '01'
                 '202103' || '01' ==> '20210301'
                  TO_DATE('20210301','YYYYMMDD;) */


SELECT TO_DATE('2021', 'YYYY')
FROM dual;

SELECT TO_DATE('2021' || '0101', 'YYYYMMDD')
FROM dual;


FUNCTION 3)
파라미터로 YYYYMM형식의 문자열을 사용하여 해당 년월에 해당하는 일자 수를 구해보세요
SELECT :YYYYM,
        TO_CHAR(LAST_DAY(TO_DATE(:YYYYMM,'YYYYMM')),'DD') DT
FROM dual;

형변환
- 명시적 형변환
    TO_DATE, TO_CHAR, TO_NUBER
- 묵시적 형변환

SELECT *
FROM emp
where empno = '7369';

NULL 처리 함수 : 4가지
NVL(exprl, expr2) : expr1이 NULL 값이 아니면 exprl을 사용하고, exprl이 NULL값이면 expr2로 대체해서 사용한다
if(exprl == null)
    System.out.println(expr2)
else 
    System.out.println(expr1)
    
emp 테이블에서 comm컬럼의 값이 null일 경우 0으로 대체해서 조회하기
SELECT empno, sal, comm, sal + NVL(comm, 0) nvl_sal_comm,
NVL(sal+comm,0) nvl_sal_comm2
FROM emp;


NVL2(expr1, expr2, expr3)
if(exprl != NULL)
    System.out.println(expr2);
else
    System. out.print1n(expr3);

comm이 null이 아니면 sal + comm을 반환,
comm이 null이면 sal을 반환
emp 테이블에서 comm컬럼의 값이 null일 경우 0으로 대체해서 조회하기
SELECT empno, sal, comm, sal,
        NVL2(comm, sal+comm, sal)
FROM emp;


NULLIF(expr1, expr2)
if(expr1 == expr2)
    System.out.println(null)
else
    System.out.println(expr1)
    
SELECT empno, sal, comm, sal,
        NVLLIF(sal, 1250)
FROM emp;


COALESCE(exprl, expr2, expr3....)
인자들 중에 가장 먼저 등장하는 null이 아닌 인자를 반환
if(exprl != null)
    System.out.println(expr1);
else
    COALESCE(expr2, expr3....);
    
    
SELECT ename, sal, comm, COALESCE
FROMemp;


FUNCTION4)
emp테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요.
SELECT empno, ename, mgr, NVL(mgr,9999) mgr_n, NVL2(mgr, mgr, 9999) mgr_n_1, COALESCE(mgr, null,9999) mgr_nn_2
FROM emp;

FUNCTION5)
users 테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요
reg_dt가 null일 경우 sasdate 적용

SELECT userid, usernm, reg_dt, NVL(reg_dt,SYSDATE) n_reg_dt
FROM users
WHERE  userid   IN('cony', 'sally', 'james', 'moon');


조건분기
1. CASE 절
    WHEN expr1 비교식(참거짓을 판단할 수 있는 수식) THEN 사용할 값     => if
    WHEN expr2 비교식(참거짓을 판단할 수 있는 수식) THEN 사용할 값2    => else if
    WHEN expr3 비교식(참거짓을 판단할 수 있는 수식) THEN 사용할 값3    => else if
    ELSE 사용할 값4                                                => else
   END
   
2. DECODE 함수 => COALESCE 함수처럼 가변인자 사용
DECODE(expr1, eearch1, return1, search2, return2, search3, return3, ...[,default])
if(expr1 == search1)
    System.out.println(retur1)
else if(expr1 == search2)
    System.out.println(retur2)
else if(expr1 == search3)
    System.out.println(retur3)
else
    System.out.println(default)

직원들의 급여를 인상하려고 한다
job이 SALESMAN이면 현재 급여에서 5%를 인상
job이 MANAGER 이면 현재 급여에서 10%를 인상
job이 president 이면 현재 급여에서 20%를 인상
그 이외의 직군은 현재 급여를 유지

SELECT ename, job, sal,
        CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal * 1.0
        END sal_bonus,
        DECODE(job,
                'SALESMAN', sal * 1.05,
                'MANAGER', sal * 1.10,
                'PRESIDENT', sal * 1.20,
                sal * 1.) sal_bonus_decode
FROM emp;



CONDITION1)
emp 테이블을 이용하여 deptno에 따라 부서명으로 변경해서 다음과 같이 조회되는 쿼리를 작성하세요
10 > 'ACCCOUNTING'
20 > 'RESEARCH'
30 > 'SALES'
40 > 'OPERATIONS'
기타 > 'DDIT'

SELECT empno, ename, deptno,
       CASE
        WHEN deptno = 10 THEN 'ACCCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
       END dname
       DECODE
        10, 'ACCCOUNTING'
        20, 'RESEARCH'
        30, 'SALES'
        40, 'OPERATIONS'
        'DDOT') dname_decode
FROM emp;


CONDITION2)
emp 테이블을 이용하여 hiredate에 따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요
(생년을 기준으로 하나 여기서는 입사년도를 기준으로 한다.)
SELECT empno, ename, hiredate,
       CASE      -- 묵시적형변환
        WHEN MOD(TO_CHAR(hiredate,'YYYY'),2) = MOD(TO_CHAR(SYSDATE,'YYYY'),2) THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
       END contact_to_doctor
FROM emp;

CONDITION3)
users테이블을 이용하여 reg_dt에 따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요
(생년을 기준으로하나 여기서는 reg_dt를 기준으로 한다.)
SELECT *
FROM users;

SELECT userid, usernm, pass, reg_dt,
       CASE      -- 묵시적형변환
        WHEN MOD(TO_CHAR(reg_dt,'YYYY'),2) = MOD(TO_CHAR(SYSDATE,'YYYY'),2) THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
       END contact_to_doctor
FROM users
WHERE userid IN('brown','cpny', 'james', 'moon','slly');

GROUP FUNCTION : 여러행을 그룹으로 하여 하나의 행으로 결과값을 반환하는 함수
SELECT *
FROM emp;


--GROUP BY 
 그룹함수에서 NULL컬럼은 계산에서 제외된다
 group by절에 작성된 컬럼 이외의 컬럼이 welect 절에 올 수 없다.
 where절에 그룹함수를 조건으로 사용할 수 없다.
  *having 절 사용
--GROUP BY 절에 나온 컬럼이 SELECT절에 그룹함수가 적용되지 않은 채로 기술되면 에러

SELECT deptno, 'TEST', 100,
        MAX(sal), MIN(sal), 
        ROUND(AVG(sal),2), SUM(sal),
        COUNT(sal), -- 그룹핑된 행 중에 sal 컬럼의 값이 NULL이 아닌 행의 건수
        COUNT(mgr),-- 그룹핑된 행 중에 mgr 컬럼의 값이 NULL이 아닌 행의 건수
        COUNT(*),-- 그룹핑된 행 건수
        SUM(comm),
        SUM(NVL(comm,0)),
        NVL(SUM(comm),0)
FROM emp
WHERE LOWER(ename) = 'smith' --count(*) >= 4 그룹함수에서 사용할 수 없다. *HAVING 조건
GROUP BY deptno;


SELECT deptno, 'TEST', 100,
        MAX(sal), MIN(sal), 
        ROUND(AVG(sal),2), SUM(sal),
        COUNT(sal), -- 그룹핑된 행 중에 sal 컬럼의 값이 NULL이 아닌 행의 건수
        COUNT(mgr),-- 그룹핑된 행 중에 mgr 컬럼의 값이 NULL이 아닌 행의 건수
        COUNT(*),-- 그룹핑된 행 건수
        SUM(comm),
        SUM(NVL(comm,0)),
        NVL(SUM(comm),0)
FROM emp
HAVING COUNT(*) >= 4 --count(*) >= 4 그룹함수에서 사용할 수 없다. *HAVING 조건
GROUP BY deptno;


--GROUP BY를 사용하지 않을 경우 테이블의 모든행을 하나의 행으로 그룹핑한다
SELECT COUNT(*), MAX(sal), MIN(sal), ROUND(AVG(sal),2), SUM(sal)
FROM emp;


GROUP FUNCTION11)
-emp테이블을 이용하여 다음을 구하시오
 직원 중 가장 높은 급여
 직원 중 가장 낮은 급여
 직원의 급여 평균(소수점 두자리까지 나오도록 반올림)
 직원의 급여 합
 직원 중 급여가 있는 직원의 수(null제외)
 직원 중 상급자가 있는 직원의 수 (null제외)
 전체 직원의 수
 
SELECT MAX(sal), MIN(sal), ROUND(AVG(sal),2), SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
FROM emp
GROUP BY deptno;

