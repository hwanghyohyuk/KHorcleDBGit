-- DAY7 수업내용

-- 서브쿼리(SUBQUERY)
-- 쿼리문 안에서 사용되는 쿼리문
-- 서브쿼리가 조회한 결과값을 메인쿼리가 사용하게 됨
-- 서브쿼리의 종류 : 단일행 서브쿼리, 다중행 서브쿼리, 다중열 서브쿼리, 다중열 다중행 서브쿼리
-- 상[호연]관서브쿼리, 스칼라 서브쿼리 등이 있음

-- 단일행 서브쿼리(SINGLE ROW SUBQUERY)
-- 서브쿼리가 조회한 결과값의 갯수가 한 개인 경우
-- 서브쿼리 앞에 일반 비교연산자 사용할 수 있음
-- <, > , <=, >=, = , !=/<>/^=

-- 부서별 급여의 합계 중 가장 큰 값 조회
-- 부서명, 급여합계
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);  -- 단일행 서브쿼리

-- 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY 절에서 사용 가능함

-- 다중행(MULTI ROW) 서브쿼리
-- 서브쿼리가 조회한 결과값의 갯수가 여러 개인 경우

-- 부서별 최저 급여 조회
SELECT MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 부서별로 그 부서에서 최저 급여를 받고 있는 직원 조회
-- 사번, 급여
SELECT EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                  FROM EMPLOYEE
                  GROUP BY DEPT_ID);  -- 다중행 서브쿼리

-- 다중행 서브쿼리 앞에는 일반 비교연산자 사용 못 함
-- 일반 비교연산자는 한 개의 값을 가지고 비교하기 때문임
-- 여러 개의 값들을 비교 연산하는 연산자를 사용해야 함
-- IN | NOT IN (여러 개의 값 나열)
--   : 여러 개의 값 중에 한 개라도 같은 값이 있다면 | 없다면

SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)
                  FROM EMPLOYEE
                  GROUP BY DEPT_ID);  -- 다중행 서브쿼리

-- 컬럼명 > ANY | < ANY (다중행 서브쿼리)
--  : 여러 개의 값 중에 한개라도 큰 | 작은 경우
--   최소값보다 크냐? | 최대값보다 작으냐?

-- 컬럼명 > ALL | < ALL (다중행 서브쿼리)
--  : 서브쿼리가 조회한 모든 값보다 큰 | 작은 경우
--   최대값보다 크냐? | 최소값보다 작으냐?

-- 컬럼명 EXIST | NOT EXIST (다중행 서브쿼리)
-- 해당 컬럼값이 서브쿼리 결과값에 존재하는지 | 존재하지 않는지?

-- IN | NOT IN
-- 여러 개의 값과 비교해서 같은 값이 있는지 | 같은 값이 없는지 비교함

-- 관리자 사번 조회 : 15개의 결과가 나옴 => 서브쿼리로 사용하면, 다중행 서브쿼리임
SELECT MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- 직원 정보에서 관리자만 조회
-- 사번, 이름, '관리자' 구분
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE)
UNION
-- 관리자가 아닌 직원만 조회
-- 사번, 이름, '직원' 구분
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT MGR_ID FROM EMPLOYEE 
                      WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;                      

-- SELECT 절에서도 서브쿼리 사용할 수 있음
-- 위의 결과를 간단하게 줄일 경우
SELECT EMP_ID, EMP_NAME,
        CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '관리자'
              ELSE '직원'        
        END
FROM EMPLOYEE
ORDER BY 3, 1;


-- > ANY : 가장 작은 값보다 크냐 
-- < ANY : 가장 큰 값 보다 작으냐

-- 대리 직급의 직원 중에서 과장 직급의 최소 급여보다 많이 받는 직원 조회
-- 사번, 이름, 직급명, 급여 
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리' 
AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    LEFT JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '과장');


-- > ALL : 가장 큰 값보다 크냐
-- < ALL : 가장 작은 값보다 작으냐

-- 과장 직급의 급여중 가장 큰값보다 많이 받는 대리 직급의 직원 조회
-- 이름, 직급명, 급여
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ALL (SELECT SALARY
                   FROM EMPLOYEE
                   LEFT JOIN JOB USING (JOB_ID)
                   WHERE JOB_TITLE = '과장');

-- 서브쿼리의 사용 위치
-- SELECT 절, FROM 절, WHERE 절, GROUP BY 절, HAVING 절, ORDER BY 절
-- INSERT 문, UPDATE 문, CREATE TABLE 문, CREATE VIEW 문

-- 자기 직급의 평균 급여를 받는 직원 조회
-- 이름, 직급명, 급여
-- 비교값의 자릿수에 따른 반올림 또는 내림처리 필요함

-- 직급별 평균급여 조회
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;
-- 서브쿼리로 사용

SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                   FROM EMPLOYEE
                   GROUP BY JOB_ID);

-- FROM 절에서 서브쿼리 사용할 수 있음 : 테이블 대신에 사용함
-- FROM (서브쿼리) 별칭
-- 서브쿼리의 결과 RESULT SET 을 테이블 대신으로 사용함
-- 인라인 뷰(INLINE VIEW)라고 함 : FROM 절에 사용된 서브쿼리가 만든 결과집함

-- ANSI 표준 구문으로 조인 처리시 테이블 별칭 사용하는 경우는
-- ON 사용시에만 가능함

-- 자기 직급의 평균 급여를 받는 직원 조회 : INLINE VIEW 사용
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
       FROM EMPLOYEE
       GROUP BY JOB_ID) V  -- 인라인 뷰
LEFT JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY
                           AND NVL(V.JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- 상[호연]관(COLLERATED) 서브쿼리
-- 대부분의 서브쿼리는 서브쿼리가 만든 결과를 메인쿼리가 사용하였음
-- 상관쿼리는 서브쿼리가 메인쿼리의 컬럼값을 가져다 결과를 만듦
-- 그렇기 때문에 메인쿼리의 컬럼값이 바뀌면, 서브쿼리의 결과도 달라지게 됨

-- 자기 직급의 평균 급여를 받는 직원 조회 : 상관쿼리를 사용한 경우
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                  FROM EMPLOYEE
                  WHERE NVL(JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
ORDER BY 2;


-- 다중행 다중열 서브쿼리
-- 서브쿼리가 SELECT 한 항목이 한 개이상인 경우(다중열), 
-- 서브쿼리의 실행결과도 여러행(다중행)
-- 서브쿼리와 비교할 항목은 
-- 반드시 서브쿼리의 SELECT 항목과 갯수와 자료형을 일치시켜야 함
-- 서브쿼리와 비교할 항목은 반드시 () 안에 적어주어야 함

-- 자기 직급의 평균 급여를 받는 직원 정보 조회  (다중행 다중열 서브쿼리를 사용한 경우)
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (NVL(JOB_ID, ' '), SALARY) IN (SELECT NVL(JOB_ID, ' '), TRUNC(AVG(SALARY), -5)
                                    FROM EMPLOYEE
                                    GROUP BY NVL(JOB_ID, ' '))
ORDER BY 2;


-- 서브쿼리가 만든 결과가 존재하는지 물어볼 때 EXISTS 연산자 사용함
-- 상[호연]관 쿼리를 사용할 경우 이용함

-- 관리자인 직원 정보 조회
SELECT EMP_ID, EMP_NAME, '관리자' 구분
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
-- 서브쿼리의 조건을 만족하는 행들만 추려냄

-- NOT EXISTS : 서브쿼리의 조건을 만족하는 행이 존재하지 않느냐?
SELECT EMP_ID, EMP_NAME, '직원' 구분
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                    FROM EMPLOYEE
                    WHERE E.EMP_ID = MGR_ID);
-- 서브쿼리의 조건을 만족하지 않는 행들만 추려냄

-- 스칼라 서브쿼리
-- 한 행의 한 컬럼의 값만 반환하는 상관 서브쿼리
-- 단일행 서브쿼리 + 상관쿼리

-- 사원명, 부서코드, 급여, 해당 직원이 소속된 부서의 급여 평균 조회
SELECT EMP_NAME, DEPT_ID, SALARY,
       (SELECT TRUNC(AVG(SALARY), -5) -- 소속부서의 급여 평균 값 1 개
        FROM EMPLOYEE
        WHERE DEPT_ID = E.DEPT_ID) AS AVGSAL
FROM EMPLOYEE E; 

-- CASE 표현식을 이용한 스칼라 서브쿼리 사용
-- 부서의 근무지역이 'OT' 이면 '지역팀', 아니면 '본사팀' 으로 직원의 근무지역에 대한
-- 소속을 조회함
-- 사번, 이름, 소속
SELECT EMP_ID, EMP_NAME,
        (CASE WHEN DEPT_ID = (SELECT DEPT_ID
                                FROM DEPARTMENT
                                WHERE LOC_ID = 'OT')
              THEN '지역팀'
              ELSE '본사팀'
         END) AS 소속
FROM EMPLOYEE
ORDER BY 소속 DESC;

-- ORDER BY 절에 스칼라 서브쿼리 사용 예
-- 직원이 소속된 부서의 부서명이 큰 값부터 정렬해서 직원 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME FROM DEPARTMENT
            WHERE DEPT_ID = E.DEPT_ID) DESC;


-- TOP-N 분석 ***********************************************
-- 상위 몇 개, 하위 몇 개를 조회할 때

-- 1. 인라인 뷰와 RANK() 함수를 이용한 TOP-N 분석 예
-- 직원 정보에서 급여를 많이 받는 직원 5명 조회
SELECT *
FROM (SELECT EMP_NAME, SALARY, 
               RANK() OVER (ORDER BY SALARY DESC) 순위
       FROM EMPLOYEE) 
WHERE 순위 <= 5;

-- ROWNUM(행번호) 을 이용한 TOP-N 분석
-- 원래 ROWNUM 은 SELECT 한 결과행에 부여되는 행 번호임
-- ORDER BY 한 결과에 ROWNUM 을 붙임 
--    => 원래는 ORDER BY 전에 ROWNUM 이 부여됨
--    해결은 서브쿼리를 이용함 : SELECT 전에 ORDER BY 처리하기 위함

SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- ORDER BY 전에 ROWNUM 이 부여되므로, 정렬되면서 ROWNUM 이 뒤섞임

-- 급여 많이 받는 직원 3명 조회
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 4
ORDER BY SALARY DESC;  -- 실제 결과는 틀림
-- 급여 많은 순으로 정렬 전에 ROWNUM 이 설정되었음
-- 정렬을 이용한 상위 몇 개를 골라내는 작업은 안 됨
-- 해결 방법은 정렬되고 나서 ROWNUM 이 부여되게끔 하면 가능함
-- 인라인 뷰를 이용하면 됨

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
       FROM EMPLOYEE
       ORDER BY SALARY DESC)  -- 정렬 후에 ROWNUM 부여되게 함
WHERE ROWNUM < 4;
















