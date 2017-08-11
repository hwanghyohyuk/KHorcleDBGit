--﻿JOIN 연습문제
--
--1. 2020년 12월 25일이 무슨 요일인지 조회하시오
SELECT TO_CHAR(TO_DATE('20201225','YYYYMMDD'),'DAY')AS "무슨요일?" FROM DUAL;
--
--
--2. 주민번호가 60년대 생이면서 성별이 여자이고, 성이 김씨인 직원들의 
--사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT EMP_NAME, EMP_NO,DEPT_NAME,JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
JOIN DEPARTMENT USING(DEPT_ID)
WHERE EMP_NO LIKE '6%' AND EMP_NO LIKE '%-2%' AND EMP_NAME LIKE '김%';
--
--
--3. 가장 나이가 적은 직원의 사번, 사원명, 나이, 부서명, 직급명을 조회하시오.
SELECT EMP_ID, EMP_NAME, TRUNC(MONTHS_BETWEEN(SYSDATE,TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD'))/12)+1 AS 나이, DEPT_NAME,JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
JOIN DEPARTMENT USING(DEPT_ID) 
WHERE 
ORDER BY (TRUNC(MONTHS_BETWEEN(SYSDATE,TO_DATE(SUBSTR(EMP_NO,1,6),'RRMMDD'))/12)+1) ASC;

--
--
--
--4. 이름에 '성'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
--
--
--
--5. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
--
--
--
--6. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
--
--
--
--7. 부서코드가 20인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
--
--
--
--8. 직급별 연봉의 최소급여(MIN_SAL)보다 많이 받는 직원들의
--사원명, 직급명, 급여, 연봉을 조회하시오.
--연봉에 보너스포인트를 적용하시오.
--
--
--
--9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--사원명(emp_name), 부서명(dept_name), 지역명(loc_describe), 국가명(country_name)을 조회하시오.
--
--
--10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
--self join 사용
--
--
--
--11. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
--단, join과 IN 사용할 것
--
--
--12. 기혼인 직원과 미혼인 직원의 수를 조회하시오.