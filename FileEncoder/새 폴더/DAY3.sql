-- DAY3 수업내용

-- 단일행(SINGLE ROW) 함수(FUNCTION)
-- N개의 값을 읽어서 N개의 결과를 리턴하는 함수
-- 문자열함수, 날짜관련 함수, 형변환함수, 수학관련함수 등

-- 그룹(GROUP) 함수
-- N개의 값을 읽어서 한 개의 결과를 리턴하는 함수
-- SUM, AVG, COUNT, MAX, MIN

-- SELECT 절에 단일행 함수와 그룹 함수 함께 사용 못 함
-- 결과 행의 갯수가 다르기 때문임

SELECT EMP_NAME, UPPER(EMAIL)
FROM EMPLOYEE;

SELECT SUM(SALARY)
FROM EMPLOYEE;

SELECT UPPER(EMAIL), SUM(SALARY)
FROM EMPLOYEE;  -- ERROR

-- 함수는 SELECT 구문 모든 절에서 사용 가능함
-- 서브쿼리를 사용했을 때 가능한 경우 : FROM, ORDER BY절

-- SELECT 절 : 단일행함수와 그룹함수 같이 사용 못 함
-- WHERE 절 : 그룹함수 사용 못 함, 단일행 함수만 사용할 수 있음
-- HAVING 절 : 그룹함수만 사용할 수 있음, 단일행 함수 사용 못 함

-- 단일행 함수 ************************************
-- 문자열 함수 : 문자열값을 읽어서 문자열 또는 숫자를 리턴하는 함수

-- LENGTH('문자열값' | 문자열이 기록된 컬럼명)
-- 글자갯수(NUMBER)를 리턴함
SELECT LENGTH('ORACLE'), LENGTH('오라클')
FROM DUAL;

SELECT LENGTH(EMP_NAME), LENGTH(EMAIL)
FROM EMPLOYEE;

-- 고정길이 문자열(CHAR)과 가변길이 문자열(VARCHAR2) 비교
CREATE TABLE TYPETEST(
  CHARTYPE  CHAR(20),
  VARCHAR2TYPE VARCHAR2(20)
);

INSERT INTO TYPETEST VALUES('ORACLE', 'ORACLE');
INSERT INTO TYPETEST VALUES('JAVA', 'JAVA');
INSERT INTO TYPETEST VALUES('오라클', '오라클');

SELECT * FROM TYPETEST;

-- CHAR 과 VARCHAR2 의 글자갯수 비교
SELECT LENGTH(CHARTYPE), LENGTH(VARCHAR2TYPE)
FROM TYPETEST;

-- LENGTHB('문자열값' | 문자열이 기록된 컬럼명)
-- 바이트 값을 리턴함
SELECT LENGTHB(CHARTYPE), LENGTHB(VARCHAR2TYPE)
FROM TYPETEST;

-- INSTR('문자열값' | 문자열이 기록된 컬럼명, '찾을문자'[, 찾을시작위치[, 몇번째 문자]])
-- 찾을 문자의 위치를 리턴함
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- 이메일 주소에서 '@' 문자 바로 뒤에 있는 'k' 문자의 위치 조회, 
-- 단, 뒤에서 부터 검색함
SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3)
FROM EMPLOYEE;

-- 단일행 함수는 중첩 사용 가능함
-- 함수(함수())

-- 이메일 주소에서 '.' 바로 뒤 문자의 위치 조회
-- 단, '.' 문자 바로 앞글자부터 검색을 시작하도록 함
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') - 1)
FROM EMPLOYEE;

-- LPAD / RPAD(읽을 문자열 | 컬럼명, 출력시킬 너비의 글자수지정[, 남는 영역에 채울 문자])
-- 3번째 인자가 생략되면 자동 공백문자로 채워짐
SELECT EMAIL 원본, LENGTH(EMAIL) 원본길이,
        LPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(LPAD(EMAIL, 20, '*')) 결과길이,
        RPAD(EMAIL, 20, '*') 채우기결과,
        LENGTH(RPAD(EMAIL, 20, '*')) 결과길이
FROM EMPLOYEE;


-- LTRIM/RTRIM('문자열값' | 문자열이 기록된 컬럼명[, '제거할 문자'])
-- 제거할 문자 생략되면 기본은 공백문자임
SELECT LTRIM('   tech') FROM DUAL;  --tech
SELECT LTRIM('   tech', ' ') FROM DUAL;  --tech
SELECT LTRIM('000123', '0') FROM DUAL;  --123
SELECT LTRIM('123123Tech', '123') FROM DUAL;  --Tech
SELECT LTRIM('123123Tech123', '123') FROM DUAL;  --Tech123
SELECT LTRIM('xyxzyyyTech', 'xyz') FROM DUAL;  --Tech
SELECT LTRIM('6372Tech', '0123456789') FROM DUAL;  --Tech

SELECT RTRIM('tech   ') FROM DUAL; --tech
SELECT RTRIM('tech   ', ' ') FROM DUAL; --tech
SELECT RTRIM('123000', '0') FROM DUAL; --123
SELECT RTRIM('Tech123123', '123') FROM DUAL; --Tech
SELECT RTRIM('123Tech123', '123') FROM DUAL; --123Tech
SELECT RTRIM('Techxyxzyyy', 'xyz') FROM DUAL; --Tech
SELECT RTRIM('Tech6372', '0123456789') FROM DUAL; --Tech

-- TRIM(LEADING | TRAILING | BOTH '제거할 문자' FROM '문자열값' | 컬럼명)
SELECT TRIM('  tech  ') FROM DUAL; --tech
SELECT TRIM('a' FROM 'aatechaaa') FROM DUAL; --tech
SELECT TRIM(LEADING '0' FROM '000123') FROM DUAL; --123
SELECT TRIM(TRAILING '1' FROM 'Tech1') FROM DUAL; --Tech
SELECT TRIM(BOTH '1' FROM '123Tech111') FROM DUAL; --23Tech
SELECT TRIM(LEADING FROM '  Tech  ') FROM DUAL; --Tech  


-- SUBSTR('문자열값' | 문자열이 기록된 컬럼명, 추출할 시작위치, 추출할 글자갯수)
-- 추출할 위치 : 양수(앞에서부터의 위치), 음수(뒤에서부터의 위치)
SELECT SUBSTR('This is a test', 6, 2) FROM DUAL; --is
SELECT SUBSTR('This is a test', 6) FROM DUAL; --is a test
SELECT SUBSTR('이것은 연습입니다', 3, 4) FROM DUAL; --은 연습
SELECT SUBSTR('TechOnTheNet', 1, 4) FROM DUAL; --Tech
SELECT SUBSTR('TechOnTheNet', -3, 3) FROM DUAL; --Net
SELECT SUBSTR('TechOnTheNet', -6, 3) FROM DUAL; --The
SELECT SUBSTR('TechOnTheNet', -8, 2) FROM DUAL; --On

-- 직원들의 주민번호에서 생년, 생월, 생일을 각각 분리 조회
SELECT EMP_NO 주민번호,
        SUBSTR(EMP_NO, 1, 2) || '년' 생년,
        SUBSTR(EMP_NO, 3, 2) || '월' 생월,
        SUBSTR(EMP_NO, 5, 2) || '일' 생일
FROM EMPLOYEE;

-- 날짜 데이터에도 적용할 수 있음
-- 직원들의 입사일에서 입사년도, 입사월, 입사일을 분리 조회
SELECT HIRE_DATE 입사일,
        SUBSTR(HIRE_DATE, 1, 2) || '년' 입사년도,
        SUBSTR(HIRE_DATE, 4, 2) || '월' 입사월,
        SUBSTR(HIRE_DATE, 7, 2) || '일 입사' 입사일
FROM EMPLOYEE;

-- SUBSTRB('문자열' | 문자열이 기록된 컬럼명, 추출할 바이트 위치, 추출할 바이트)
SELECT SUBSTR('ORACLE', 3, 2), SUBSTRB('ORACLE', 3, 2)
FROM DUAL;

SELECT SUBSTR('오라클', 2, 2), SUBSTRB('오라클', 4, 6)
FROM DUAL;

-- UPPER('문자열값' | 문자열이 기록된 컬럼명) : 대문자로 바꾸는 함수
-- LOWER('문자열값' | 컬럼명) : 소문자로 바꾸는 함수
-- INITCAP('문자열값' | 컬럼명) : 첫글자만 대문자로 바꾸는 함수
SELECT UPPER('ORACLE'), UPPER('oracle'),
        LOWER('ORACLE'), LOWER('oracle'),
        INITCAP('ORACLE'), INITCAP('oracle')
FROM DUAL;        

-- 함수 중첩 사용 : 함수 안에 함수 사용 가능함
-- 직원정보에서 이름, 아이디 조회
-- 아이디는 이메일에서 분리 추출함
SELECT EMP_NAME 이름,
        SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) 아이디
FROM EMPLOYEE;


-- 직원 테이블에서 사원명, 주민번호 조회
-- 주민번호는 생년월일- 까지만 보이게 하고 나머지값은 '*'로 출력 처리함
-- 781125-*******
SELECT EMP_NAME 사원명,
        RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') 주민번호
FROM EMPLOYEE;


-- 숫자처리함수 : ROUND, TRUNC, FLOOR, ABS, MOD

-- ROUND(숫자값 | 숫자값이 기록된 컬럼명 | 계산식[, 반올림할 자릿수])
-- 지정하는 자리의 값이 5이상이면 자동 반올림됨 (기본값이 0임)
-- 지정하는 자리의 값이 5미만이면 버려짐
-- 자릿수 : 양수(소숫점아래쪽 자리를 의미함), 음수(정수부 자릿수를 의미함)
SELECT ROUND(123.456), 
        ROUND(123.456, 0),
        ROUND(123.456, 1),
        ROUND(123.456, -1)
FROM DUAL;
        
-- 직원 정보에서 사번, 이름, 급여, 보너스포인트, 보너스포인트가 적용된 연봉 조회
-- 연봉에는 별칭 : 1년급여
-- 연봉은 천단위에서 반올림함
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT,
        ROUND((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12, -4) "1년급여"
FROM EMPLOYEE;

-- TRUNC(숫자 | 계산식 | 숫자가 기록된 컬럼명, 자릿수)
-- 자릿수의 값을 버리는 함수
SELECT TRUNC(125.315) FROM DUAL; --125
SELECT TRUNC(125.315, 0) FROM DUAL; --125
SELECT TRUNC(125.315, 1) FROM DUAL; --125.3
SELECT TRUNC(125.315, -1) FROM DUAL; --120
SELECT TRUNC(125.315, 3) FROM DUAL; --125.315
SELECT TRUNC(-125.315, -3) FROM DUAL; --0

-- 직원 정보에서 급여의 평균을 구함
-- 10단위에서 절삭함
SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2), FLOOR(AVG(SALARY))
FROM EMPLOYEE;

-- FLOOR(숫자 | 계산식 | 컬럼명) : 소숫점 아래값 버리는 함수(정수 만드는 함수)
SELECT ROUND(123.45), TRUNC(123.45), FLOOR(123.45)
FROM DUAL;

-- ABS(숫자 | 계산식 | 컬럼명) : 절대값 처리 함수(음수를 양수로 바꿈)
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- 입사일 - 오늘 날짜, 오늘 날짜 - 입사일 조회 : 별칭은 총근무일수
-- 근무일수는 정수로 처리함, 모두 양수로 출력 처리함
SELECT ABS(FLOOR(HIRE_DATE - SYSDATE)) 총근무일수,
        ABS(FLOOR(SYSDATE - HIRE_DATE)) 총근무일수
FROM EMPLOYEE;


-- MOD(나눌값, 나눌수) : 나누기한 나머지를 구하는 함수
SELECT FLOOR(25 / 7) 몫, MOD(25, 7) 나머지
FROM DUAL;

-- 사번이 홀수인 직원들의 모든 정보 조회
SELECT *
FROM EMPLOYEE
--WHERE MOD(TO_NUMBER(EMP_ID), 2) = 1;
WHERE MOD(EMP_ID, 2) = 1;
-- 숫자로 된 문자는 계산시 자동 숫자로 바뀜 : '100' -> 100

-- 성별이 여자인 직원들의 이름, 부서코드, 생년월일 조회
SELECT EMP_NAME, DEPT_ID, SUBSTR(EMP_NO, 1, 6) 생년월일
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');


-- 날짜 처리 함수
-- SYSDATE 함수 : 시스템으로 부터 현재 날짜와 시간을 조회할 때 사용
SELECT SYSDATE
FROM DUAL;  -- 현재 오라클의 언어는 한국어, 날짜 포맷은 RR/MM/DD 임.

/*
오라클에서는 환경설정, 객체 관련 정보들을 모두 저장 관리하고 있음
데이터 딕셔너리(사전) 영역에 관련 정보들이 각각의 테이블의 형태로 저장 관리됨
데이터 딕셔너리는 DB 시스템이 직접 관리함.  사용자는 손댈 수 없음. 조회만 가능함
환경설정과 관련된 정보는 수정할 수 있음. (언어, 문자셋, 날짜 포맷 등)
*/
SELECT *
FROM SYS.NLS_SESSION_PARAMETERS;

-- 날짜 포맷과 관련된 변수 조회
SELECT VALUE
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- 날짜 포맷 수정
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

COMMIT;

-- 확인
SELECT SYSDATE
FROM DUAL;

-- 원래 포맷으로 변경
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

COMMIT;

-- 확인
SELECT SYSDATE FROM DUAL;

-- ADD_MONTHS('날짜데이터' | 날짜가 기록된 컬럼명, 더할 개월수)
-- 개월수를 더한 날짜가 리턴됨

-- 직원 테이블에서 입사일이 20년된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 240)
FROM EMPLOYEE;

-- 오늘부터 10년 뒤 날짜는?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

-- 직원들 중에서 근무년수가 20년 이상 근무한 직원 정보 조회
-- 사번, 이름, 부서코드, 직급코드, 입사일 ALIAS 처리함
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_ID 부서코드, JOB_ID 직급코드,
        HIRE_DATE 입사일
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜의 차이난 개월수를 리턴함

--'2010년 1월 1일' 기준으로 입사핚지 10년이 넘은 직원들의 근무년수 조회
SELECT EMP_NAME, HIRE_DATE,
        FLOOR(MONTHS_BETWEEN('10/01/01', HIRE_DATE)/12) AS 근무년수
FROM EMPLOYEE
WHERE MONTHS_BETWEEN('10/01/01', HIRE_DATE) > 120;


-- 직원들의 이름, 입사일, 현재까지의 근무일수, 근무개월수, 근무년수 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        FLOOR(SYSDATE - HIRE_DATE) 근무일수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) 근무개월수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 근무년수
FROM EMPLOYEE; 

-- NEXT_DAY('날짜데이터' | 컬럼명, '요일이름')
-- 지정한 날짜 뒤쪽 날짜에서 가장 가까운 지정한 요일의 날짜를 리턴함
SELECT SYSDATE, NEXT_DAY(SYSDATE, '일요일')
FROM DUAL;

-- 데이터베이스의 사용 언어가 한국어로 지정되어 있기 때문에 요일 이름에 한글 사용함
-- 요일이름을 영어로 쓰면 에러남
SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL;

-- 요일이름에 영어를 사용하려면 언어를 변경해야 함
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

COMMIT;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'WEDNESDAY')
FROM DUAL;

-- 한국어로 지정 바꿈
ALTER SESSION
SET NLS_LANGUAGE = KOREAN;

COMMIT;


-- LAST_DAY('날짜데이터' | 컬럼명) 
-- 지정한 날짜의 월에 대한 마지막 날짜를 리턴함
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;

-- 직원 테이블에서 사원명, 입사일, 입사한 달의 근무일수 조회
-- 주말 포함함
SELECT EMP_NAME 사원명, HIRE_DATE 입사일,
        LAST_DAY(HIRE_DATE) - HIRE_DATE "입사한 달의 근무일수"
FROM EMPLOYEE;        

-- 오늘 날짜 조회 함수
SELECT SYSDATE,
        SYSTIMESTAMP,
        CURRENT_DATE,
        CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(추출할 항목 FROM 날짜)
-- 날짜 데이터에서 원하는 정보만 추출함
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE) 년,
        EXTRACT(MONTH FROM SYSDATE) 월,
        EXTRACT(DAY FROM SYSDATE) 일
FROM DUAL;

-- 직원 정보에서 이름, 입사일, 근무년수 조회
SELECT EMP_NAME 이름, HIRE_DATE 입사일,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) 근무년수
FROM EMPLOYEE; 























