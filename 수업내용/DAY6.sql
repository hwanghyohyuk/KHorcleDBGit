-- DAY6 수업내용

-- JOIN(조인)
-- 여러 개의 테이블을 하나의 큰 테이블로 합친 결과를 원할 때 사용함
-- 오라클에서만 사용하는 오라클 전용 구문과 
-- 모든 DBMS 가 공통으로 사용하는 표준구문인 ANSI 표준구문이 있음

-- 오라클 전용구문 : 합칠 테이블명을 FROM 절에 , 로 구분해서 나열함
-- 테이블명.컬럼명으로 이름이 중복되는 컬럼명 앞에 테이블명을 명시해야 함
-- 테이블명을 간단하게 표현하기 위한 테이블 별칭을 지정할 수 있음
-- FROM 테이블명 별칭, 테이블명 별칭
-- 테이블을 합치기 위해 사용되는 컬럼명과 조건식을 WHERE 절에 명시함
-- 단점은 WHERE 절에 조인을 위한 조건식과 행을 추출하기 위한 조건식이 함께 사용됨

-- 예 : EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인할 경우
SELECT * 
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;

-- 테이블의 별칭을 적용한 경우
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

--사원명, 부서코드, 부서명 조회
SELECT EMP_NAME, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;


-- ANSI 표준구문
-- 조인 처리를 위한 구문을 별도로 작성함
-- 모든 DBMS 가 공통으로 사용하는 표준 구문임
-- FROM 절 바로 아래에 JOIN 이라는 키워드를 사용하여 조인을 표현함
/*
  FROM 메인테이블명
  [INNER] JOIN 합칠 테이블명 USING (합치기에 사용할 컬럼명) -- 컬럼명이 같을 경우
  JOIN 테이블명 ON (컬럼명 = 컬럼명)  -- 기록된 값은 같으나 컬럼명이 다를 경우
  LEFT/RIGHT/FULL [OUTER] JOIN 테이블명 ON (컬럼명 = 컬럼명) -- 테이블 별칭 사용 가능함
  LEFT/RIGHT/FULL [OUTER] JOIN 테이블명 USING (컬럼명) -- 테이블 별칭 사용 못 함
  NATURAL JOIN 테이블명  -- 두 테이블의 기본키(PRIMARY KEY) 컬럼끼리 조인함
  CROSS JOIN 테이블명 -- 각 테이블의 행수 X 행수 한 조인결과를 얻음
*/
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);

SELECT *
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);

-- INNER JOIN
-- 합치기에 사용할 컬럼에 기록된 값들을 연결해서 행 단위로 연결 처리함
-- 두 테이블의 공통으로 기록된 값들만 연결 처리함
-- 두 테이블의 컬럼값이 일치하지 않은 행은 조인에서 제외됨
-- EMPLOYEE 의 90 = DEPARTMENT 의 90 이 조인으로 연결됨
-- EMPLOYEE 의 NULL = DEPARTMENT 의 NULL 이 연결되어야 함
-- NULL 값이 기록된 행은 DEPARTMENT 에 일치하는 값이 없으므로 조인에서 제외됨

-- 만약에 EMPLOYEE 의 일치하는 NULL 을 가진 직원들도 조인에 포함시켜야 할 경우
-- 즉, EMPLOYEE 의 모든 행을 조인에 포함시키고자 할 경우에는 OUTER 조인을 사용함
-- 일치하지 않은 값을 가진 행도 조인에 포함시키는 것을 OUTER 조인이라고 함

-- INNER JOIN 오라클전용구문
SELECT *
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE
INNER JOIN JOB USING (JOB_ID);

-- EMPLOYEE 의 모든 직원들을 조인에 포함시키려면
-- OUTER JOIN 오라클전용구문
SELECT *
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+);

SELECT EMP_NAME, E.JOB_ID, J.JOB_ID, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+);

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE
--LEFT OUTER JOIN JOB USING (JOB_ID);
LEFT JOIN JOB USING (JOB_ID);

SELECT EMP_ID, JOB_ID, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID);

-- INNER JOIN 과 OUTER JOIN은 둘 다 EQUIL JOIN 임
-- 두 테이블의 연결할 컬럼의 값이 일치하는 행끼리 연결 조인됨

SELECT EMP_NAME, E.DEPT_ID, D.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM DEPARTMENT
RIGHT OUTER JOIN EMPLOYEE USING (DEPT_ID);

-- EMPLOYEE 와 DEPARTMENT 를 조인할 경우
-- DEPARTMENT 의 모든 행의 정보를 조인에 포함시키고자 한다면

-- 오라클전용구문
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;

-- ANSI 표준구문
SELECT *
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT USING (DEPT_ID);

-- 두 테이블의 모든 행의 정보를 조인에 포함시키고자 한다면, FULL OUTER JOIN 이라고 함

-- 오라클전용구문에서는 FULL OUTER JOIN 처리 못 함
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);

-- ANSI 표준 구문
SELECT *
FROM EMPLOYEE
--FULL OUTER JOIN DEPARTMENT USING (DEPT_ID);
FULL JOIN DEPARTMENT USING (DEPT_ID);


-- 여러 개의 컬럼을 묶어서 USING 처리한 경우
-- 묶여진 컬럼값들을 하나의 값으로 보고 EQUIL 처리함
-- 10A1 = 10A1 조인에 포함됨
-- 10A1 = 10A2 조인에서 제외됨
SELECT DEPT_ID, LOC_ID
FROM DEPARTMENT
ORDER BY DEPT_ID;

SELECT DEPT_ID, LOC_ID
FROM EMPLOYEE2
ORDER BY DEPT_ID;

SELECT EMP_ID, DEPT_ID, LOC_ID
FROM EMPLOYEE2
JOIN DEPARTMENT USING (DEPT_ID, LOC_ID);

-- 조인 연결할 컬럼명이 다를 경우, 단 기록값은 같음
-- JOIN ON 사용함
SELECT *
FROM DEPARTMENT, LOCATION
WHERE LOC_ID = LOCATION_ID;

SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- CROSS JOIN 
-- 두 테이블을 합칠 공통 컬럼이 없는 경우에 사용함
-- 첫번째 테이블의 행수 X 두번째 테이블 행수 의 결과를 얻음
SELECT *
FROM DEPARTMENT, LOCATION;  -- 7행 X 5행 => 35행이 나옴

SELECT *
FROM DEPARTMENT
CROSS JOIN LOCATION;


-- NON EQUIL JOIN
-- 조인에 연결하는 컬럼값이 일치하는 것이 아니라,
-- 값의 범위에 포함되는 행들을 연결하는 조인 방식
SELECT *
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN 
-- 같은 테이블을 두 번 조인하는 경우
-- 같은 테이블 안의 다른 컬럼을 외부 참조키로 사용하는 경우에 주로 사용함
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

SELECT *
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 직원이름과 그 직원의 관리자이름 조회
SELECT E.EMP_NAME 직원이름, M.EMP_NAME 관리자이름
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);


-- N개의 테이블 조인
--SELECT *
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID);

-- 오라클 전용 구문
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID;

-- 직급이 대리이면서, 아시아지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여 조회

-- ANSI 표준구문
SELECT EMP_ID, EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE JOB_TITLE = '대리' AND LOC_DESCRIBE LIKE '아시아%';

-- 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND JOB_TITLE = '대리' 
AND LOC_DESCRIBE LIKE '아시아%';


-- 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명(emp_name), 부서명(dept_name), 지역명(loc_describe), 국가명(country_name)을 조회하시오.

-- ANSI
SELECT EMP_NAME 사원명, DEPT_NAME 부서명,
       LOC_DESCRIBE 지역명, COUNTRY_NAME 국가명
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
JOIN COUNTRY USING (COUNTRY_ID)       
WHERE COUNTRY_ID IN ('KO', 'JP');
--WHERE COUNTRY_ID = 'KO' OR COUNTRY_ID = 'JP';

-- ORACLE
SELECT EMP_NAME 사원명, DEPT_NAME 부서명,
       LOC_DESCRIBE 지역명, COUNTRY_NAME 국가명
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID
AND L.LOCATION_ID = D.LOC_ID
AND L.COUNTRY_ID = C.COUNTRY_ID       
AND L.COUNTRY_ID IN ('KO', 'JP');


-- 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉은 보너스포인트를 적용하시오.

-- ANSI
SELECT EMP_NAME, JOB_TITLE, SALARY, 
       (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 연봉
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)       
WHERE (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;
      
-- ORACLE
SELECT EMP_NAME, JOB_TITLE, SALARY, 
       (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 연봉
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID       
AND (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;


-- 보너스포인트가 없는 직원들 중에서 
-- 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.

-- ANSI
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7') 
AND BONUS_PCT IS NULL OR BONUS_PCT = 0.0;

-- ORACLE
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID 
AND E.JOB_ID IN ('J4', 'J7') 
AND BONUS_PCT IS NULL OR BONUS_PCT = 0.0;


-- 같은 부서에 근무하는 직원들의 
-- 사원명, 부서코드, 동료이름, 부서코드를 조회하시오.
-- self join 사용

-- ANSI
SELECT E.EMP_NAME 사원명, E.DEPT_ID 부서코드, 
       C.EMP_NAME 동료이름, C.DEPT_ID 부서코드
FROM EMPLOYEE E
JOIN EMPLOYEE C ON (E.DEPT_ID = C.DEPT_ID)
WHERE E.EMP_NAME <> C.EMP_NAME
ORDER BY E.EMP_NAME;

-- ORACLE
SELECT E.EMP_NAME 사원명, E.DEPT_ID 부서코드, 
       C.EMP_NAME 동료이름, C.DEPT_ID 부서코드
FROM EMPLOYEE E, EMPLOYEE C
WHERE E.DEPT_ID = C.DEPT_ID
AND E.EMP_NAME <> C.EMP_NAME
ORDER BY E.EMP_NAME;


-- GROUP BY, 그룹함수 사용
-- 소속부서가 50 또는 90인 직원중 
-- 기혼인 직원과 미혼인 직원의 수를 조회하시오.
-- 결혼여부, 직원수 
SELECT DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼') 결혼여부, 
       COUNT(*) 직원수
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '기혼', 'N', '미혼')
ORDER BY 1;








