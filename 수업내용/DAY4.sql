-- DAY4 수업내용

-- 형변환 함수
-- 자동형변환이 되는 경우
SELECT 20 + '10'
FROM DUAL;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE EMP_ID = 100;  -- 자동형변환됨 100 -> '100'
--WHERE EMP_ID = '100';
WHERE EMP_ID = TO_CHAR(100);  -- 형변환을 명시한 경우

-- 자동형변환이 안 되는 경우 : 직접 자료형을 바꾸어야 됨
SELECT SYSDATE - '15/03/15'
FROM DUAL;  -- ERROR
-- 형변환을 명시해야 함
SELECT SYSDATE - TO_DATE('15/03/15', 'YY/MM/DD')
FROM DUAL;

-- TO_CHAR(숫자 | 날짜, '포맷문자')
-- 숫자나 날짜 데이터를 원하는 포맷을 적용해서 출력 처리할 때 사용

-- 숫자에 포맷 적용한 경우
SELECT TO_CHAR(1234, '99999') FROM DUAL; --1234
SELECT TO_CHAR(1234, '09999') FROM DUAL; --01234
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; --￦1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL; --1,234
SELECT TO_CHAR(1234, '09,999') FROM DUAL; --01,234
SELECT TO_CHAR(1000, '9.9EEEE') FROM DUAL; --1.0E+03
SELECT TO_CHAR(1234, '999') FROM DUAL; --#### : 자릿수가 모자라서 에러난 경우

SELECT EMP_NAME, 
        TO_CHAR(SALARY, 'L99,999,999') 급여,
        TO_CHAR(NVL(BONUS_PCT, 0), '90.00') 보너스포인트
FROM EMPLOYEE;

-- 날짜 데이터에 포맷 적용시에도 TO_CHAR() 사용함
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; --오후 20:57:11
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; --오후 08:57:11
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL; --1월 월, 2010
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL; --2010-1-4 월요일
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-fmDD DAY') FROM DUAL; --2010-01-4 월요일
SELECT TO_CHAR(SYSDATE, 'Year, Q') FROM DUAL; --Twenty Seventeen, 3
--'fm' 모델을 사용하면 '01' 형식이 '1' 형식으로 표현됨

-- 직급이 J7인 직원들의 이름과 입사일 조회, 입사일에 포맷 적용
SELECT EMP_NAME AS 이름,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS 입사일
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME AS 이름,
        TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS 입사일
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME AS 이름,
        SUBSTR(HIRE_DATE, 1, 2) || '년 ' ||
        SUBSTR(HIRE_DATE, 4, 2) || '월 ' ||
        SUBSTR(HIRE_DATE, 7, 2) || '일' AS 입사일
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

-- 년도에 대한 포맷
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
        TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY "년"'), TO_CHAR(HIRE_DATE, 'RRRR "년"'),
        TO_CHAR(HIRE_DATE, 'YY "년"'), TO_CHAR(HIRE_DATE, 'RR "년"'),
        TO_CHAR(HIRE_DATE, 'YEAR')
FROM EMPLOYEE;

-- 월에 대한 포맷
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY"년" MM"월"'),
        TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'),
        TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 날짜에 대한 포맷
SELECT SYSDATE,
        TO_CHAR(SYSDATE, '"1년 기준" DDD "일째"'),
        TO_CHAR(SYSDATE, '"달 기준" DD "일째"'),
        TO_CHAR(SYSDATE, '"주 기준" D "일째"')
FROM DUAL;

-- 분기와 요일 포맷
SELECT TO_CHAR(SYSDATE, 'Q "사분기"'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- 직원 테이블에서 이름, 입사일 조회
-- 입사일은 포맷을 적용해서 '2014년 05월 23일 (목)' 형식으로 출력 처리함
SELECT EMP_NAME 이름,
        TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" "("DY")"') 입사일,
        TO_CHAR(HIRE_DATE, 'YYYY"년" MON DD"일" "("DY")"') 입사일
FROM EMPLOYEE;

-- 사번이 100인 직원의 이름과 입사일 조회
-- 입사일은 '2017-8-10 오전 10:42:30' 형식으로 출력 처리함
SELECT EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH:MI:SS'),
        TO_CHAR(HIRE_DATE, 'YYYY-fmMM-DD AM HH:MI:SS'),
        TO_CHAR(HIRE_DATE, 'YYYY-fmMM-DD HH24:MI:SS')
FROM EMPLOYEE
WHERE EMP_ID = 100;



-- 날짜데이터 비교 연산시에 날짜만 기록되어 있는 값이면 날짜로 비교 가능함
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = '04/04/30';  -- 오라클 기본 포맷 'RR/MM/DD'

-- 시간이 포함된 날짜데이터 비교시 날짜만 비교하면 FALSE 의 결과가 나옴
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE = '90/04/01';  -- 결과가 안 나옴
--WHERE HIRE_DATE = '90/04/01 13:30:30'; -- 시간까지 비교되어야 함
WHERE HIRE_DATE = TO_DATE('90/04/01 13:30:30', 'YY/MM/DD HH24:MI:SS');

-- 해결방법 1
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YY/MM/DD') = '90/04/01';

-- 해결방법 2
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01';


-- TO_DATE('문자로 된 날짜나 시간', '앞의 값의 각 자리별 포맷문자')
-- 반드시 앞의 문자와 뒤의 포맷문자의 갯수가 같아야 함 : 해석의 의미로 적용됨
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL; --10/01/01
SELECT TO_CHAR('20100101', 'YYYY, MON') FROM DUAL; -- ERROR
SELECT TO_CHAR(TO_DATE( '20100101', 'YYYYMMDD'), 'YYYY, MON') 
FROM DUAL; --2010, 1월
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL; --04/10/30
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'),
                'DD-MON-YY HH:MI:SS PM') 
FROM DUAL; --30-10월-04 02:30:00 오후
SELECT TO_DATE('980630', 'YYMMDD' ) FROM DUAL; --98/06/30
SELECT TO_CHAR(TO_DATE( '980630', 'YYMMDD' ), 'YYYY.MM.DD') 
FROM DUAL; --2098.06.30

-- 기록된 년도가 두자리인 경우, 포맷을 적용해서 네자리로 바꿀 경우
-- YYYY 와 RRRR 의 차이

-- RR 을 적용할 때
-- 현재 년도(17)가 50 미만이고, 바꿀 년도가 50 미만이면 2000년도가 적용됨
-- 현재 년도가 50미만이고, 바꿀 년도가 50 이상이면 1900년도가 적용됨

SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'RRRR'), TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE;

-- 현재 년도와 바꿀 년도가 둘 다 50미만이면 Y/R 아무거나 사용하면 됨
SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'RRRR-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR-MM-DD')
FROM DUAL;

-- 현재 년도가 50 미만이고, 바꿀 년도가 50 이상일 때
-- 년도로 바꿀 때 Y 사용시 현재 세기(2000년)로 바뀜
-- 년도로 바꿀 때 R 사용시 이전 세기(1900년)로 바뀜
SELECT TO_CHAR(TO_DATE('990101', 'YYMMDD'), 'YYYY-MM-DD'), -- 2000년 적용
        TO_CHAR(TO_DATE('990101', 'RRMMDD'), 'RRRR-MM-DD'), -- 1900년 적용
        TO_CHAR(TO_DATE('990101', 'YYMMDD'), 'RRRR-MM-DD'), -- 2000년 적용
        TO_CHAR(TO_DATE('990101', 'RRMMDD'), 'YYYY-MM-DD') -- 1900년 적용
FROM DUAL;

-- 결론은 문자를 날짜로 바꿀 때 'R' 사용하면 됨


-- TO_NUMBER() : 문자를 숫자로 바꿀 때 사용
-- '100' --> 100 
SELECT EMP_NAME, EMP_NO,
        SUBSTR(EMP_NO, 1, 6)AS 앞부분,
        SUBSTR(EMP_NO, 8) AS 뒷부분,
        TO_NUMBER(SUBSTR(EMP_NO, 1, 6)) + 
                TO_NUMBER(SUBSTR(EMP_NO, 8)) AS 결과
FROM EMPLOYEE
WHERE EMP_ID = '101';


-- 기타함수

-- NVL(컬럼명, 컬럼의 값이 NULL 일 때 바꿀 값)
SELECT EMP_NAME, BONUS_PCT, DEPT_ID, JOB_ID
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(BONUS_PCT, 0), 
        NVL(DEPT_ID, '00'), NVL(JOB_ID, 'J0')
FROM EMPLOYEE;        

-- NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼의 값이 있으면 바꿀값1로 바꾸고, NULL이면 바꿀값2로 바꿈

-- 직원 정보에서 보너스포인트가 0.2 미만이거나 NULL 인 직원들을 조회
-- 사번, 사원명, 보너스포인트, 변경보너스포인트
-- 변경보너스포인트는 값이 있으면 0.15로 바꾸고, NULL이면 0.05로 바꿈
SELECT EMP_ID 사번, EMP_NAME 이름, BONUS_PCT 보너스포인트,
        NVL2(BONUS_PCT, 0.15, 0.05) 변경보너스포인트
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 OR BONUS_PCT IS NULL;


-- DECODE(함수식 | 컬럼명, 제시값1, 선택값1, 제시값2, 선택값2,.....제시값N, 선택값N, 
--         모든 제시값이 아닐 때 DEFAULT값)
-- SWITCH 문의 형식을 갖는 함수임

-- 50 번 부서에 속한 직원들의 이름과 성별 조회
-- 주민번호에서 성별값이 1 또는 3이면 남자, 2 또는 4이면 여자
SELECT EMP_NAME 이름, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '3', '남자', '여자') 성별
FROM EMPLOYEE
WHERE DEPT_ID = '50'
ORDER BY 성별, 이름;  -- 성별 오름차순정렬, 성별이 같으면 이름 오름차순정렬 처리


-- 직급코드 'J4' 인 직원의 사번과 이름과 관리자 사번 조회
-- 관리자 사번이 NULL 이면 '없음' 으로 바꿈
-- NVL 사용한 경우
SELECT EMP_ID 사번, EMP_NAME 이름, NVL(MGR_ID, '없음')
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

-- DECODE 사용한 경우
SELECT EMP_ID 사번, EMP_NAME, DECODE(MGR_ID, NULL, '없음', MGR_ID)
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

-- 직급별 급여 인상분이 다를 때
-- DECODE 함수 사용시
SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(DECODE(JOB_ID, 
                      'J7', SALARY*1.1,
                      'J6', SALARY*1.15,
                      'J5', SALARY*1.2,
                      SALARY*1.05), 'L99,999,999') AS 인상급여
FROM EMPLOYEE; 

-- CASE 표현식 사용시
SELECT EMP_NAME, JOB_ID, SALARY,
        CASE JOB_ID
        WHEN 'J7' THEN SALARY*1.1
        WHEN 'J6' THEN SALARY*1.15
        WHEN 'J5' THEN SALARY*1.2
        ELSE SALARY*1.05 
        END AS 인상급여
FROM EMPLOYEE;

-- CASE 표현식은 다중 IF 문처럼 사용할 수도 있음
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY <= 3000000 THEN '초급'
              WHEN SALARY <= 4000000 THEN '중급'
              ELSE '고급' 
        END AS 구분
FROM EMPLOYEE
ORDER BY 구분;   -- 오름차순 정렬 처리함



-- 그룹함수 ***************************
-- SUM, AVG, MIN, MAX, COUNT
SELECT SUM(SALARY), SUM(DISTINCT SALARY),
        FLOOR(AVG(SALARY)), AVG(DISTINCT SALARY),
        MIN(SALARY), MAX(SALARY),
        COUNT(SALARY), COUNT(*), COUNT(DISTINCT SALARY)
FROM EMPLOYEE;

-- SUM([DISTINCT] 컬럼명) : 합계 구함
SELECT SUM(SALARY), SUM(DISTINCT SALARY)
FROM EMPLOYEE
WHERE DEPT_ID = '50'
OR DEPT_ID IS NULL;

-- AVG([DISTINCT] 컬럼명) : NULL 을 제외한 값들의 평균 구함
SELECT AVG(BONUS_PCT) AS 기본평균,
        AVG(DISTINCT BONUS_PCT) AS 중복제거평균,
        AVG(NVL(BONUS_PCT,0)) AS NULL포함평균
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
OR DEPT_ID IS NULL;

-- MIN(컬럼명) : 최소값 구함
-- MAX(컬럼명) : 최대값 구함
SELECT MAX(JOB_ID), MIN(JOB_ID),
        MAX(HIRE_DATE), MIN(HIRE_DATE),
        MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90');

-- COUNT(* | [DISTINCT] 컬럼명) : 행 수를 리턴함
SELECT COUNT(*),
        COUNT(JOB_ID),
        COUNT(DISTINCT JOB_ID)
FROM EMPLOYEE
WHERE DEPT_ID = '50'
OR DEPT_ID IS NULL;


-- ORDER BY 절 *****************************************
-- SELECT 구문 맨 마지막에 사용함.
-- SELECT 한 결과를 가지고 정렬 처리함
-- ORDER BY 정렬기준 정렬방식, 정렬기준 정렬방식, ....
-- 정렬기준은 SELECT 절에 기술한 컬럼명, 별칭, 컬럼나열순번을 사용할 수 있음
-- 정렬방식은 ASC(오름차순정렬) | DESC(내림차순정렬) 사용함
-- ASC 는 생략해도 됨

/*
5 SELECT 컬럼명, 계산식, 함수식 별칭
1 FROM 테이블명
2 WHERE 컬럼명 | 단일행함수 비교연산자 비교값 | 단일행함수
3 GROUP BY 컬럼명
4 HAVING 그룹함수 비교연산자 비교값
6 ORDER BY 컬럼명 | 별칭 | 순번 정렬방식 NULLS FIRST | LAST;
*/

SELECT EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL
--ORDER BY SALARY DESC, 1 ASC;
ORDER BY 급여 DESC, 이름;

-- 2003년 1월 1일 이후에 입사한 직원 정보 조회
-- 부서코드 기준 내림차순정렬하고, 같은 부서코드일 때는 입사일 기준 오름차순정렬하고,
-- 입사일이 같으면 이름 기준 오름차순정렬 처리함
-- 이름, 입사일, 부서코드, 급여 조회함, 별칭 처리함
-- 부서코드의 NULL 은 아래쪽에 위치하게 함
SELECT EMP_NAME 이름, HIRE_DATE 입사일, DEPT_ID 부서코드, SALARY 급여
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101', 'RRRRMMDD')
ORDER BY 부서코드 DESC NULLS LAST, 입사일, 이름;


-- GROUP BY 절 *******************************
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE
ORDER BY DEPT_ID NULLS LAST;

-- 같은 값끼리 그룹을 묶어서 계산 처리를 할 필요가 있을 때 사용함
-- GROUP BY 컬럼명 | 함수식
-- 여러 개의 값들을 하나로 묶어서 처리할 목적으로 사용함
-- 그룹 묶은 값에 대한 그룹함수 사용은 SELECT 절에 기술함

-- 부서별 급여의 합계를 조회
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY DEPT_ID NULLS LAST;

-- 직급별 급여의 합계, 급여의 평균, 직원수 조회
SELECT JOB_ID, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_ID
ORDER BY JOB_ID NULLS LAST;

-- 성별별 급여합계, 급여평균(천단위에서 반올림처리), 직원수 조회
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '3', '남', '여') 성별,
        SUM(SALARY), ROUND(AVG(SALARY), -4), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '3', '남', '여')
ORDER BY 성별;



















