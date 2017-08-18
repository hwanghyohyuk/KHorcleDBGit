-- DAY2 수업 내용

/*
  SQL : SELECT (데이터 검색용 구문)
  
  -- 작성방법
5  SELECT [DISTINCT] 컬럼명 [[AS] 별칭], 계산식, 함수식
1  FROM 값조회에 사용할 테이블명
2  WHERE 컬럼명 비교연산자 비교값
3  GROUP BY 그룹 묶을 컬럼명
4  HAVING 그룹함수(컬럼명) 비교연산자 비교값
6  ORDER BY 정렬기준컬럼명 정렬방식;
*/

SELECT *
FROM EMPLOYEE;

SELECT EMP_ID AS 사번, SALARY * 12 년봉, LENGTH(EMAIL)
FROM EMPLOYEE;

-- DISTINCT 키워드
-- SELECT 절에 딱 한번 사용할 수 있음
-- 컬럼명, 계산식 앞에 사용함
-- 중복을 제외시켜서 한개만 선택함
SELECT DISTINCT DEPT_ID, JOB_ID
FROM EMPLOYEE;

-- 부서 테이블에서 부서코드와 부서명을 조회
SELECT DEPT_ID, DEPT_NAME
FROM DEPARTMENT;

SELECT * FROM COUNTRY;

-- 직원 테이블에서 직원명, 1년치급여, 보너스포인트가 적용된 연봉 조회
SELECT EMP_NAME AS 사원명, 
        SALARY * 12 "1년급여", 
        BONUS_PCT "보너스 포인트",
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "보너스포인트적용(원)"
FROM EMPLOYEE;
-- 계산에 사용할 컬럼이 비어 있을 경우(NULL인 경우)
-- 계산의 결과도 NULL 임
-- 계산시 NULL 인 컬럼을 다른 값으로 바꾸어 주어야 함
-- NVL(컬럼명, 바꿀값) : NULL 일때 값을 바꾸는 함수임

SELECT BONUS_PCT, NVL(BONUS_PCT, 0)
FROM EMPLOYEE;

-- 리터럴(LITERAL)
-- 테이블이 가지고 있는 컬럼처럼 값을 채워줄 때 사용
-- 채울값 [AS] 별칭
SELECT EMP_ID 사번, EMP_NAME 사원명, 
       '재직' 근무여부  -- 리터럴이라고 함
FROM EMPLOYEE;

-- WHERE 절(조건절)
-- WHERE 컬럼명 연산자 비교값
-- 비교연산자와 논리연산자 주로 사용됨 : TRUE/FALSE 결과가 나와야 함
-- 비교연산자 : > (크냐/초과), < (작으냐/미만),
--    >= (크거나 같으냐/이상), <= (작거나 같으냐/이하)
--    =(같으냐), !=(같지않느냐, ^=, <>)
-- 논리연산자 : NOT(논리부정), AND, OR

-- 직원 테이블에서 사원명, 부서코드 조회
-- 단, 90번 부서에 소속된 직원만 조회함
-- 90번 부서에 소속된 직원의 이름, 부서코드 조회
SELECT EMP_NAME 이름, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- 급여가 4백만을 초과하는(4백만보다 많이 받는) 직원이름, 급여 조회
SELECT EMP_NAME 이름, SALARY 급여
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 90번 부서에 소속된 직원들 중에서 2백만을 초과하는 급여를 받는 직원 조회
-- 직원명, 급여, 부서코드 조회
SELECT EMP_NAME 직원명, SALARY 급여, DEPT_ID 부서코드
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND SALARY > 2000000;

-- 90 또는 20번 부서에 소속된 직원명, 급여, 부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID = '90' OR DEPT_ID = '20';

-- 연결연산자 : ||
SELECT EMP_NAME || ' 직원의 사번은 ' || EMP_ID || '번이다.'
FROM EMPLOYEE;

SELECT EMP_ID || '사번의 직원 급여는 ' || SALARY || '원이다.'
FROM EMPLOYEE;

-- 컬럼명 BETWEEN 하한값 AND 상한값
-- 하한값 이상 상한값 이하

-- 350만 이상 550만 이하의 범위에 해당하는 급여를 받는 직원 조회
-- 직원명, 부서코드, 직급코드, 급여
SELECT EMP_NAME, DEPT_ID, JOB_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 5500000;
WHERE SALARY BETWEEN 3500000 AND 5500000;

-- 급여가 350만 미만이거나 급여가 550만 초과인 직원 조회
SELECT EMP_NAME, DEPT_ID, JOB_ID, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 5500000;

SELECT EMP_NAME, DEPT_ID, JOB_ID, SALARY
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 5500000;


-- 컬럼명 LIKE '문자패턴'
-- 컬럼에 기록된 문자값이 해당 패턴과 일치하는 값을 찾으라는 뜻임
-- % : 0개 이상의 문자를 의미함
-- _ : 문자 한 개를 뜻함

-- 성이 김씨인 직원 정보 조회
-- 이름, 주민번호, 이메일
SELECT EMP_NAME, EMP_NO, EMAIL
FROM EMPLOYEE
WHERE EMP_NAME LIKE '김%';

-- 성이 김씨가 아닌 직원 조회
SELECT EMP_NAME, EMP_NO, EMAIL
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';

SELECT EMP_NAME, EMP_NO, EMAIL
FROM EMPLOYEE
WHERE NOT EMP_NAME LIKE '김%';

-- 전화번호 4번째 자리값(국번)이 9인 직원 조회
-- 이름 , 전화번호
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
--WHERE PHONE LIKE '___9%';
WHERE PHONE LIKE '___9_______';

-- 문자패턴에 사용되는 와일드카드문자와 동일한 문자가 기록되어 있는 경우
-- 기록된 문자와 와일드카드 문자는 패턴에 적용시 구분이 필요함
-- ESCAPE 옵션 사용함
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '____%';
--WHERE EMAIL LIKE '___\_%' ESCAPE '\';
WHERE EMAIL LIKE '___#_%' ESCAPE '#';


-- NULL 인지 물을 때, 컬럼명 = NULL 은 에러임
-- 컬럼명 IS NULL, 컬럼명 IS NOT NULL

-- 부서배정도 받지 않고, 관리자 배정도 받지 않은 직원 조회
SELECT EMP_NAME, MGR_ID, DEPT_ID
FROM EMPLOYEE
WHERE MGR_ID IS NULL AND DEPT_ID IS NULL;

-- 부서와 직급을 배정받지 못한 직원 이름 조회
SELECT EMP_NAME, DEPT_ID, JOB_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND JOB_ID IS NULL;

-- 부서는 배정받지 못했으나, 보너스는 받고 있는 직원 조회
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;


-- IN 연산자 : OR 연산으로 여러 개의 값을 물을 때 사용
-- 컬럼명 IN (비교값, 비교값, ....)

-- 60번 또는 90번 부서에 근무하는 직원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME 이름, DEPT_ID 부서코드, SALARY 급여
FROM EMPLOYEE
--WHERE DEPT_ID = '60' OR DEPT_ID = '90';
WHERE DEPT_ID IN ('60', '90');

-- 60번, 90번을 제외한 다른 부서에 근무하는 직원 조회
SELECT EMP_NAME 이름, DEPT_ID 부서코드, SALARY 급여
FROM EMPLOYEE
--WHERE NOT DEPT_ID IN ('60', '90');
WHERE DEPT_ID NOT IN ('60', '90');

-- 연산자 우선 순위 테스트
-- 부서코드가 20, 90이면서 3백만을 초과하는 급여를 받고 있는 직원조회
-- 이름, 부서코드, 급여
SELECT EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
--WHERE (DEPT_ID = '20' OR DEPT_ID = '90') AND SALARY > 3000000;
WHERE DEPT_ID IN ('20', '90') AND SALARY > 3000000;













