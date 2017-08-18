-- DAY8 수업내용

-- WITH 이름 AS (쿼리문)
-- SELECT * FROM 이름;
-- 주로 인라인 뷰로 사용될 서브쿼리에 사용됨
-- 같은 서브쿼리가 여러 번 사용될 경우 서브쿼리 사용의 중복을 줄일 수 있고
-- 실행 속도가 빨라진다는 장점이 있음

-- NATURAL JOIN
-- 조인할 테이블의 기본키(PRIMARY KEY) 컬럼을 이용한 EQUIL JOIN + INNER JOIN 임
SELECT *
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;

-- 부서별 급여의 합계가 전체 급여 총합의 20%보다 많이 받는 
-- 부서명, 부서별 급여합계 조회함

-- 일반 SQL 문
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT  -- department 의 기본키와 join 됨.
GROUP BY DEPT_NAME
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                        FROM EMPLOYEE);

-- WITH 사용 SQL 문
WITH TOTAL_SAL AS (SELECT DEPT_NAME, SUM(SALARY) SSAL
                    FROM EMPLOYEE
                    NATURAL JOIN DEPARTMENT
                    GROUP BY DEPT_NAME)
SELECT DEPT_NAME, SSAL
FROM TOTAL_SAL   -- 인라인 뷰
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
                FROM EMPLOYEE);

-- *********************************************************
-- 분석함수(윈도우함수)
/*
오라클 분석함수는 데이터를 분석하는 함수이다.
분석 함수를 사용하면, 쿼리 실행의 결과인 RESULT SET 을 대상으로 함
전체 그룹별이 아닌 소그룹별로 각 행에 대한 분석 결과값을 리턴함 

일반 그룹함수들과 다른 점은 분석함수는 분석함수용 그룹을 별도로 정의해서
그 그룹을 대상으로 계산을 수행한다는 것이다.

이때 분석함수용 그룹을 오라클에서는 윈도우(WINDOW)라고 부른다.
*/

-- 사용형식
/*
분석함수명 ([전달인자1, 전달인자2, 전달인자3]) OVER ([쿼리 PARTITION절] 
                                           [ORDER BY 절] 
                                           [WINDOW 절])
FROM 테이블명;

분석함수 종류 : AVG, SUM, RANK, MAX, MIN, COUNT 등
전달인자 : 분석함수에 따라서 0~3개의 값을 사용할 수 있음
쿼리 PARTITION 절 : PARTITION BY 표현식
            PARTITION BY 로 시작하며, 표현식에 따라 그룹별로 단일 결과집합을 분리함
            즉, 분석함수의 계산 대상 그룹을 지정하는 역할임
ORDER BY 절 : PARTITION 절 뒤에 위치하며, 계산 대상 그룹의 정렬을 수행함
            ORDER BY 컬럼명 정렬방식(ASC|DESC)
WINDOW 절 : 분석 대상이 되는 데이터를 행 기준으로 범위를 더 세부적으로 정의함
            PARTITION BY 에 의해 나누어진 그룹 안에서 분석의 범위를 지정함
*/

-- 등수 매기는 함수 : RANK
-- 같은 등수가 여러 개 있을 때는 다음 등수값이 건너뜀
-- 예 : 1, 2, 2, 4

-- 급여에 순위를 매긴다면
SELECT EMP_ID, EMP_NAME, SALARY,
        RANK() OVER (ORDER BY SALARY DESC) 급여순위
FROM EMPLOYEE;

-- 원하는 값의 순위를 조회하고 싶다면
-- 급여 230만의 순위 조회
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;

-- DENSE_RANK() : 같은 순위가 여러 개일때 다음 순위가 건너뛰지 않음
-- 예 : 1, 2, 2, 3
SELECT EMP_NAME, DEPT_ID, SALARY,
        RANK() OVER (ORDER BY SALARY DESC) "순위1",
        DENSE_RANK() OVER (ORDER BY SALARY DESC) "순위2",
        DENSE_RANK() OVER (PARTITION BY DEPT_ID
                             ORDER BY SALARY DESC) "순위3"
FROM EMPLOYEE
ORDER BY DEPT_ID;

-- RANK 를 이용한 TOP-N 분석
SELECT *
FROM (SELECT EMP_NAME, SALARY,
       RANK() OVER (ORDER BY SALARY DESC) 순위
       FROM EMPLOYEE)
WHERE 순위 <= 5; -- 상위 5개의 정보 조회       

-- 급여 적은순(내림차순) 11순위에 해당하는 직원 정보 조회
-- 이름 급여 순위
SELECT * 
FROM (SELECT EMP_NAME, SALARY,
               RANK() OVER (ORDER BY SALARY DESC) 순위
       FROM EMPLOYEE)
WHERE 순위 = 11;

-- CUME_DIST() : CUMulativE DISTribution
-- PARTITION BY 로 그룹을 나누고, 각 그룹 안의 행에 대해 ORDER BY 정렬한 다음
-- 각 그룹별 분산정도(상대적인 위치)을 구하는 함수임
-- 행 수를 그룹 내의 총 행수로 나눈 것을 의미함
-- 0 < 분산정도 <= 1 범위의 값임

-- 부서코드가 50인 직원의 이름, 급여, 급여누적분산 조회
SELECT EMP_NAME, SALARY,
        ROUND(CUME_DIST() OVER (ORDER BY SALARY), 1) 급여누적분산
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- NTILE()
-- PARTITION 을 BUCKET 이라 불리는 그룹별로 나누고
-- PARTITION 내의 각 행을 각 BUCKET 에 배치 배분하는 함수
-- 예를 들면 PARTITION 안에 100개의 행이 있다면, BUCKET 을 4개로 정하면
-- 1개의 BUCKET당 25개의 행이 배분됨
-- 정확하게 배분되지 않을 때는 근사치로 배분한 후에 남는 값에 대해 최초 BUCKET 에 할당

-- 급여를 4등급으로 분류
SELECT EMP_NAME, SALARY,
        NTILE(4) OVER (ORDER BY SALARY) 등급
FROM EMPLOYEE;


-- ROW_NUMBER()
-- ROWNUM 과는 관계가 없음
-- 각 PARTITION 내의 값들을 ORDER BY 절에 의해 정렬한 다음에 순서대로 순번 부여함

-- 사번, 이름, 급여, 입사일, 순번
-- 단 순번은 급여가 많은 순으로, 같은 급여는 입사일이 빠른 순으로 부여함
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE,
        ROW_NUMBER() OVER (ORDER BY SALARY DESC, HIRE_DATE ASC) 순번
FROM EMPLOYEE;


-- 집계함수

-- 직원 테이블에서 부서코드가 60인 직원들의
-- 사번, 급여, 해당 부서그룹(윈도우라고 함) 내에서 사번을 오름차순 정렬하고
-- 급여의 합계를 첫행부터 마지막행까지 구해서 WIN1 에,
-- 윈도우의 시작행부터 현재 위치까지의 합계를 구해서 WIN2 에,
-- 윈도우의 현재행에서 마지막행까지의 합계를 구해서 WIN3 에 출력함

SELECT EMP_ID, SALARY,
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN UNBOUNDED PRECEDING
                            AND UNBOUNDED FOLLOWING) "WIN1",
-- ROWS : 부분그룹인 윈도우의 물리적 행 단위를 의미함
-- UNBOUNDED PRECEDING : 윈도우의 첫 행
-- UNBOUNDED FOLLOWING : 윈도우의 마지막 행
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN UNBOUNDED PRECEDING
                            AND CURRENT ROW) "WIN2",
-- CURRENT ROW : 현재 행      
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN CURRENT ROW
                            AND UNBOUNDED FOLLOWING) "WIN3"
FROM EMPLOYEE
WHERE DEPT_ID = '60';


SELECT EMP_ID, SALARY,
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN 1 PRECEDING
                            AND 1 FOLLOWING) "WIN1",
-- 1 PRECEDING AND 1 FOLLOWING
-- 현재 행을 중심으로 이전행과 다음행의 집계를 의미함
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN 1 PRECEDING
                            AND CURRENT ROW) "WIN2",
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN CURRENT ROW
                            AND 1 FOLLOWING) "WIN3"
FROM EMPLOYEE
WHERE DEPT_ID = '60';

-- RATIO_TO_REPORT
-- 해당 구간에서 차지하는 비율을 리턴하는 함수

-- 직원들의 총급여를 2천만원 증가시킬 때, 기존 월급비율을 적용해서
-- 각 직원이 받게될 급여의 증가액 조회
SELECT EMP_NAME, SALARY,
        LPAD(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 100, 0), 5)
        || ' %' 비율,
        TO_CHAR(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 20000000, 0),
        'L00,999,999') "추가로 받게될 급여"
FROM EMPLOYEE;


-- LAG(조회할 범위, 이전위치, 기준 현재위치)
-- 지정하는 컬럼의 현재 행을 기준으로 이전 행(위)의 값을 조회함
SELECT EMP_NAME, DEPT_ID, SALARY,
        LAG(SALARY, 1, 0) OVER (ORDER BY SALARY) 이전값,
        -- 1 : 위의 행 값, 0 : 이전행이 없으면 0 처리함
        LAG(SALARY, 1, SALARY) OVER (ORDER BY SALARY) "조회2",
        LAG(SALARY, 1, SALARY) OVER (PARTITION BY DEPT_ID
                                      ORDER BY SALARY) "조회3"
        -- 부서 그룹 안에서의 이전 행값 조회함
FROM EMPLOYEE;











