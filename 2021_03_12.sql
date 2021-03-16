-- sem 계정에 있는 prod 테이블의 모든 컬럼을 조회하는 SELECT쿼리(SQL) 작성
SELECT *
FROM prod;

-- sem 계정에 있는 prod 테이블의 prod_id, prod_name 두 개의 컬럼을 조회하는 SELECT쿼리(SQL) 작성
SELECT prod_id, prod_name
FROM prod;

-- [ SELECT(실습 select1) ]
-- lprod 테이블에서 모든 데이터를 조회하는 쿼리를 작성
SELECT *
FROM lprod;

-- buyer 테이블에서 buyer_id, buyer_name 컬럼만 조회하는 쿼리를 작성
SELECT buyer_id, buyer_name
FROM buyer;

-- cart 테이블에서 모든 데이터를 조회하는 쿼리를 작성
SELECT *
FROM cart;

-- member 테이블에서 mem_id, mem_pass, mem_name 컬럼만 조회하는 쿼리를 작성
SELECT mem_id, mem_pass, mem_name
FROM member;

컬럼 정보를 보는 방법
1. SELECT * ==> 컬럼의 이름을 알 수 있다.
2. SQL DEVELOPMENT의 테이블 객체를 클릭하여 정보확인
3. DESC 테이블명; //DESCRIBE 설명하다

DESC emp;

--NUMBER(7,2) : 전체 자리 7자리, 소수점은 둘째 자릿 수까지 올 수 있다.
--VARCHAR2(9 BYTE) : 9BYTE까지 저장 가능

empno : number;
empno+10 ==> expession
SELECT empno empnumber, empno+10 emp_plus, 10,
       hiredate, hiredate - 10
FROM emp;


숫자, 날짜에서 사용가능한 연산자 (날짜에서는 + - 연산만 가능)
일반적인 사칙연산 + - / * 우선순위연산자()


ALIAS : 컬럼의 이름을 변경
        컬럼| expressiont [AS] [별칭명] -- 시험문제
SELECT empno "emp no", empno+10 AS emp_plus
FROM emp;

NULL : 아직 모르는 값
        0과 공백은 NULL과 다르다
        *** NULL을 포함한 연산은 결과가 항상 NULL ***
        ==> null 값을 다
SELECT ename, sal, comm, sal +comm, comm + 100 -- sal + NULL = NULL
FROM emp; -- sal + NULL = NULL



--[실습 select2]
--prod 테이블에서 prod_id, prod_name 두컬럼을 조회하는 쿼리 작성 (별칭 : id, name)
SELECT prod_id "id", prod_name "name"
FROM prod;

--1prod테이블에서 1prod_gu, 1prod_nm 두컬럼을 조회하는 쿼리 작성 (별칭 : gu, nm)
SELECT lprod_gu "gu", lprod_nm "nm"
FROM lprod;

--buyer 테이블에서 buyer_id, buyer_name 두 컬럼을 조회하는 쿼리 작성 (별칭 : 바이어아이디, 이름)
SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;


literal : 값 자체
literal 표기법 : 값을 표현하는 방법


*****************************************
java 정수 값을 어떻게 표현할 까(10) ?
int a = 10;
float f = 10f;
long l = 10L;
string s ="Hello World!";


-- 문자 ''로 표현
SELECT empno, 10, 'Hello World' 
FROM emp;

******************************************

java : String msg = "Hello" + ", World";

-- 문자열 연산 ||
--concat은 두개의 입력값만 받는다 세개는 오류 / 결합할 두개의 문자열을 입력받아 결합하고 결합된 문자영을 변환 해준다.
  --오류 CONCAT(ename,'Hello', ', world')
  --CONCAT(문자열1, 문자열2)
   ==> CONCAT(문자열1과 문자열2가 결합된 문자열, 문자열3)
   ==> CONCAT(CONCAT(문자열1, 문자열2), 문자열3)
SELECT empno + 10, ename || ',world', 
CONCAT(ename, 'world')
FROM emp;

DESC emp;

아이디 : brown
아이디 : apeach
.
.

SELECT '아이디 : ' || userid,
        CONCAT('아이디 :', userid)
FROM users;


SELECT table_name
FROM user_tables;

--CONCAT으로 문자열3개 표현하기
SELECT 'SELECT * FROM ' || table_name || ';' AS QUERY,
        CONCAT ('SELECT * FROM ' || table_name, ';'),
        CONCAT (CONCAT ('SELECT * FROM ', table_name), ';')
FROM user_tables;

--WHERE
--부서번호가 10인 직원들만 조회
--부서번호 : deptno
SELECT *
FROM emp
WHERE deptno = 10;


-- users 테이블에서 userid 컬럼의 값이 brown인 사용자만 조회

SELECT *
FROM users
WHERE userid = 'brown'; -- 데이터값은 대소문자  > 'BROWN'은 없는 데이터 값

--emp 테이블에서 부서번호가 20번보다 큰부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno > 20;

--emp 테이블에서 부서번호가 20번 부서에 속하지 않은 모든 직원 조회
SELECT *
FROM emp
WHERE deptno !=20;

-- WHERE : 기술한 조건을 참(TRUE)으로 만족하는 행들만 조회한다(FILTER)
SELECT *
FROM emp
WHERE 30 !=20; -- 항상 참이므로 모든 데이터 출력

SELECT *
FROM emp
WHERE 1=1; -- 항상 참이므로 모든 데이터 출력

SELECT *
FROM emp
WHERE 1=2; --거짓이므로 데이터 출력X

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= '81/03/01' ; -- 81년 3월 1일 나짜 값을 표기하는 방법

-- 표기 방법이 다를 수 있어 권장하지 않음
yyy/mm/dd 
mm/dd/yy

문자열을 날짜 타입으로 변환하는 방법
TO_DATE(날짜 문자열, 날짜 문자열의 포맷팅)
TO_DATE('1981/03/01', 'YYYY/MM/DD') -- 년,월,일 위치를 알려줌

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1981/03/01', 'YYYY/MM/DD') ; 