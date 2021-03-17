함수명을 보고
1. 파라미터가 어떤게 들어갈까?
2. 몇개의 파라미터가 들어갈까?
3. 반환되는 값은 무엇일까?

SELECT *
FROM emp

- LOWER : 대문자 > 소문자
- UPPER : 소문자 > 대문자
- INITCAP : 첫글자만 대문자, 나머지 소문자

SELECT ename, LOWER(ename), UPPER(ename), INITCAP(ename)
FROM emp;

- CONCAT
- SUBSTR
- LENGTH

SELECT ename, LOWER(ename), LOWER('TEST'),
       SUBSTR(ename, 1, 3) --SMITH > SMI
FROM emp;

SELECT ename, LOWER(ename), LOWER('TEST'),
       SUBSTR(ename, 2, 3) --SMITH > MIT
       SUBSTR(ename, 2 ) -- 두번째부터 마지막까지 MITH
FROM emp;


--REPLACE
SELECT ename, LOWER(ename), LOWER('TEST'),
       SUBSTR(ename, 2, 3),
       REPLACE (ename, 'S', 'T')
FROM emp;

-- WHERE절이 행의 개수 결정
-- 불필요한 행도 출력
SELECT 4
FROM emp;

-- dual 
   : DUMMY컬럼 하나만 존재하면 값은 X이고 데이터는 한 행만 존재
SELECT *
FROM dual;


SINGLE ROW FUNCTION :WHERE 절에서도 사용 가능
emp 테이블에 등록된 직원들 중에 직원의 이름의 길이가 5글자를 초과하는 직원만 조회

SELECT *
FROM emp
WHERE LENGTH(ename) > 5;

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; // DB컬럼 가공하지말기 > 실행횟수가 많아지므로 권장하지 않음

SELECT *
FROM emp
WHERE ename = UPPER('smith');

SELECT *
FROM emp
WHERE ename = 'SMITH'; 


-- ORACLE 문자열 할수

SELECT 'HELLO' || ',' || 'WORLE',
--      CONCAT ('HELLO', ', ', 'WOERLE') //CONCAT은 두개의 인자만 받는다
        CONCAT ('HELLO', CONCAT(', ', 'WOERLE')) CONCAT,
        SUBSTR('HELLO, WORLD', 1, 5) SUBSTR, -- 1번째부터 5글자
        LENGTH('HELLO, WORLD') LENGTH,
        INSTR('HELLO, WORLD', 'O') INSTR1, -- 문자 'O'가 있는 위치 출력
        INSTR('HELLO, WORLD', 'O', 6) INSTR2, -- 6번째부터 문자 'O'가 있는 위치 출력
        LPAD('HELLO, WORLD', 15, '*') LPAD,
        RPAD('HELLO, WORLD', 15, '-') RPAD,
        REPLACE('HELLO, WORLD', 'O', 'X') REPLACE,
        TRIM (' HELLO, WORLD ') TRIM1, -- 공백을 제거, 문자열의 앞과 뒤부분에 있는 공백만, 가운데는 X
        TRIM ('D' FROM 'HELLO, WORLD') TRIM2
FROM dual;

피제수, 제수
SELECT mod(10, 3)
FROM dual;

--반올림
SELECT
ROUND(105, 54, 1) round1, -- 반올림 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.5
ROUND(105, 55, 1) round2, -- 반올림 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.6
ROUND(105, 55, 0) round3, -- 반올림 결과가 첫번째 자리(일의 자리)까지 나오도록 : 소수점 첫째 자리에서 반올림 :106
ROUND(105, 55, -1) round4, -- 반올림 결과가 두번째 자리(십의 자리)까지 나오도록 : 정수 첫째 자리에서 반올림 : 110
ROUND(105, 55) round5
FROM dual;


--버림
SELECT
TRUNC(105, 54, 1) trunc1, -- 절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.5
TRUNC(105, 55, 1) trunc2, -- 절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.5
TRUNC(105, 55, 0) trunc3, -- 절삭 결과가 첫번째 자리(일의 자리)까지 나오도록 : 소수점 첫째 자리에서 반올림 :105
TRUNC(105, 55, -1) trunc4, -- 절삭 결과가 두번째 자리(십의 자리)까지 나오도록 : 정수 첫째 자리에서 반올림 : 100
TRUNC(105, 55) trunc5
FROM dual;


--ex : 7499, ALLEN, 1600, 1, 600
SELECT empno, ename, sal -- sal을 1000으로 나눴을 때의 몫, sal을 1000으로 나눴을 때의 나머지
FROM emp;

SELECT empno, ename, sal, TRUNC(sal/1000), MOD(sal, 1000)
FROM emp;

날짜 <==> 문자
서버의 현재 시간 : SYSDATE
SELECT SYSDATE
FROM dual;

SELECT SYSDATE, SYSDATE + 1, SYSDATE + 1/24, SYSDATE + 1/24/60, SYSDATE + 1/24/60/60
FROM dual;


Functon 1)
1. 2019년 12월 31일을 date 형으로 표현
2. 2019년 12월 31일을 date형으로 표현하고 5일 이전 날짜
3. 현재 날짜
4. 현재 날짜에서 3일 전 값

위 4개 컬럼을 생성하여 다음과 같이 조회하는 쿼리를 작성하세요

SELECT TO_DATE('2019/12/31','YYYY/MM/DD')lastday,
       TO_DATE('2019/12/31','YYYY/MM/DD')-5 lastday_defore5,
       SYSDATE now, 
       SYSDATE - 3 now_before3
FROM dual;


TO_DATE : 인자-문자, 문자의 형식
TO_CHAR : 인자-날짜, 문자의 형식


NLS : YYYY/MM/DD HH24:MI:SS
[date]
-- YYYY : 4자리 년도, MM : 2자리 월, DD : 2자리 일자
-- D: 주간일자(1~7), DD : 주차(1~53), HH HH12 : 2자리 시간(12시간표현), HH24 : 2자리 시간(24시간표현), MI : 2자리 1분, SS : 2자리 초
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'HH24'), TO_CHAR(SYSDATE, 'IW')
FROM dual;


FUNCTION 2)
오늘 날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하시오
1. 년-월-일
2. 년-월-일 시간(24)-분 -초
3. 일-월-년

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE, 'YYY-MM-DD HH24:MI:SS') DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;


TO_DATE(문자열, 문자열 포맷)
TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')

SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')
FROM dual;

'2021-03-17' ==> '2021-03-17 12:41:00'

TO_CHAR(날짜, 포맷팅 문자열)
SELECT TO_CHAR(TO_DATE('2021-03-17', 'YYYY-MM-DD'),'YYYY-MM-DD HH24:MI:SS')
FROM dual;
