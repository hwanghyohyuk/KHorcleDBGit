SELECT EMP_NAME AS 이름,
TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS 입사일
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME AS 이름,
TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS 입사일
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME AS 이름,
SUBSTR(HIRE_DATE,1,2)||'년 '||
SUBSTR(HIRE_DATE,4,2)||'월 '||
SUBSTR(HIRE_DATE,7,2)||'일' AS 입사일
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME AS 이름,
HIRE_DATE AS 기본입사일,
TO_CHAR(HIRE_DATE,
'YYYY/MM/DD HH24:MI:SS') AS 상세입사일
FROM EMPLOYEE
WHERE JOB_ID IN ('J1','J2');

SELECT EMP_NAME
FROM EMPLOYEE
WHERE HIRE_DATE = '04/04/30';

SELECT EMP_NAME
FROM EMPLOYEE
WHERE HIRE_DATE = '90/04/01';

SELECT HIRE_DATE,
          TO_CHAR(HIRE_DATE,'YYYY "년"'),
          TO_CHAR(HIRE_DATE,'RRRR "년"'),
          TO_CHAR(HIRE_DATE,'YY "년"'),
          TO_CHAR(HIRE_DATE,'RR "년"'),
          TO_CHAR(HIRE_DATE,'YEAR')
          FROM EMPLOYEE;
          
          
SELECT HIRE_DATE,
          TO_CHAR(HIRE_DATE,'YYYY "년" MM"월"'),
          TO_CHAR(HIRE_DATE,'MM'),
          TO_CHAR(HIRE_DATE,'MONTH'),
          TO_CHAR(HIRE_DATE,'MON'),
          TO_CHAR(HIRE_DATE,'RM')
          FROM EMPLOYEE;
          
SELECT TO_DATE( '20100101', 'YYYYMMDD') FROM DUAL; 
SELECT TO_CHAR( '20100101', 'YYYY, MON') FROM DUAL;
SELECT TO_CHAR( TO_DATE( '20100101', 'YYYYMMDD'),'YYYY, MON') FROM DUAL; 
SELECT TO_DATE( '041030 143000', 'YYMMDD HH24MISS' ) FROM DUAL;
SELECT TO_CHAR( TO_DATE( '041030 143000', 'YYMMDD HH24MISS' ),'DD-MON-YY HH:MI:SS PM' ) FROM DUAL;
SELECT TO_DATE( '980630', 'YYMMDD' ) FROM DUAL;
SELECT TO_CHAR( TO_DATE( '980630', 'YYMMDD' ),'YYYY.MM.DD') FROM DUAL; 
          
--TO_DATE는 포멧 형식 지켜야하고
--TO_CHAR는 포멧 형식을 입력한 값에 맞춰야함

SELECT EMP_NAME,
HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE =
TO_DATE('900401 133030','YYMMDD HH24MISS');
--날짜와 시간으로 데이터를 찾을때는 TO_CHAR 보다 TO_DATE를 사용한다

SELECT EMP_NAME,
HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYMMDD') = '900401';
--문자열 형식으로 데이터를 찾는다
--LIKE를 쓰지않아도 나온다(LIKE써도 나옴)

SELECT EMP_NAME,
HIRE_DATE,
TO_CHAR(HIRE_DATE, 'YYYY/MM/DD')
FROM EMPLOYEE
WHERE EMP_NAME = '한선기';
--YY는 항상 현재 세기를 나타냄


SELECT '2009/10/14' AS 현재,
'95/10/27' AS 입력,
TO_CHAR(TO_DATE('95/10/27','YY/MM/DD'),'YYYY/MM/DD') AS YY형식1,
TO_CHAR(TO_DATE('95/10/27','YY/MM/DD'),'RRRR/MM/DD') AS YY형식2,
TO_CHAR(TO_DATE('95/10/27','RR/MM/DD'),'YYYY/MM/DD') AS RR형식1,
TO_CHAR(TO_DATE('95/10/27','RR/MM/DD'),'RRRR/MM/DD') AS RR형식2
FROM DUAL;
--TO_CHAR의 YY/RR형식은 입력값의 형식
--TO_DATE의 YY/RR형식은 날짜의 기본 포멧 형식을 현재 세기냐 이전세기냐로 판단

SELECT EMP_NAME, EMP_NO,
SUBSTR(EMP_NO,1,6)AS 앞부분,
SUBSTR(EMP_NO,8) AS 뒷부분,
TO_NUMBER( SUBSTR(EMP_NO,1,6) ) + TO_NUMBER( SUBSTR(EMP_NO,8) ) AS 결과
FROM EMPLOYEE
WHERE EMP_ID = '101';
--TO_NUMBER 는 문자열을 숫자로 받아들이는 함수

SELECT EMP_NAME, SALARY, NVL(BONUS_PCT,0)
FROM EMPLOYEE
WHERE SALARY > 3500000;
--NVL은 컬럼의 데이터가 NULL값일경우 기본데이터를 설정하는것

SELECT EMP_NAME,
(SALARY*12)+((SALARY*12)*BONUS_PCT)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME,
(SALARY*12)+
((SALARY*12)*NVL(BONUS_PCT,0))
FROM EMPLOYEE
WHERE SALARY > 3500000;

--SELECT 구문으로 IF-ELSE 논리를 제한적으로 구현한 오라클 DBMS 전용 함수
--DECODE(조건이,값1과 같으면,결과1을 반환...
SELECT EMP_NAME,
DECODE(SUBSTR(EMP_NO,8,1),
'1', '남', '2', '여', '3', '남', '4', '여') AS 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50';

SELECT EMP_NAME,
DECODE(SUBSTR(EMP_NO,8,1),
'1', '남', '3', '남', '여') AS 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50';


--DECODE(조건, 값, 결과, 기본결과)
SELECT EMP_ID, EMP_NAME,
DECODE(MGR_ID, NULL, '없음', MGR_ID) AS 관리자
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

--같은 결과값을 가지는 다른 풀이법
SELECT EMP_ID, EMP_NAME,
NVL(MGR_ID, '없음') AS 관리자
FROM EMPLOYEE
WHERE JOB_ID = 'J4'; 

SELECT EMP_NAME,
JOB_ID,
SALARY,
DECODE(JOB_ID,
'J7', SALARY*1.1,
'J6', SALARY*1.15,
'J5', SALARY*1.2,
SALARY*1.05) AS 인상급여
FROM EMPLOYEE;

SELECT EMP_NAME,
JOB_ID,
SALARY,
CASE JOB_ID
WHEN 'J7' THEN TO_CHAR(SALARY*1.1)
WHEN 'J6' THEN TO_CHAR(SALARY*1.15)
WHEN 'J5' THEN TO_CHAR(SALARY*1.2)
ELSE TO_CHAR(SALARY*1.05) END AS 인상급여
FROM EMPLOYEE;


SELECT EMP_ID,
EMP_NAME,
SALARY,
CASE WHEN SALARY <= 3000000 THEN '초급'
WHEN SALARY <= 4000000 THEN '중급'
ELSE '고급' END AS 구분
FROM EMPLOYEE;

--사원명, 이메일,
SELECT EMP_NAME,
EMAIL,
SUBSTR(EMAIL, 1,
INSTR(EMAIL, '@')-1) AS ID
FROM EMPLOYEE;

SELECT SUM(SALARY), SUM(DISTINCT SALARY)
FROM EMPLOYEE
WHERE DEPT_ID = '50'
OR DEPT_ID IS NULL;

SELECT AVG(BONUS_PCT) AS 기본평균,
AVG(DISTINCT BONUS_PCT) AS 중복제거평균,
AVG(NVL(BONUS_PCT,0)) AS NULL포함평균
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
OR DEPT_ID IS NULL;

