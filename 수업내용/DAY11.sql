-- DAY11 수업내용

-- TCL (Transaction Controll Language)
-- 트랜잭션을 관리하기 위한 명령 구문
-- COMMIT, ROLLBACK, SAVEPOINT

-- 트랜잭션의 시작
-- DDL 구문 실행 : 이전 트랜잭션 자동 COMMIT 하고 새 트랜잭션 시작함
-- DML 구문 실행 : 이전 트랜잭션 종료 후 처음 실행되는 DML 구문

ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT FK_MGRID;  -- 트랜잭션 시작

SAVEPOINT S0;

INSERT INTO DEPARTMENT
VALUES ('40', '기획전략팀', 'A1');

SELECT * FROM DEPARTMENT;

SAVEPOINT S1;

UPDATE EMPLOYEE
SET DEPT_ID = '40'
WHERE DEPT_ID IS NULL;

SELECT * FROM EMPLOYEE
WHERE DEPT_ID = '40';

SAVEPOINT S2;

DELETE FROM EMPLOYEE;

--SELECT TABLE_NAME
--FROM USER_CONSTRAINTS
--WHERE Constraint_Name = 'SYS_C007146';
--
--DROP TABLE TESTFK;

SELECT COUNT(*) FROM EMPLOYEE;

ROLLBACK TO S2;

SELECT COUNT(*) FROM EMPLOYEE;
-- S2까지만 취소된 상태

SELECT COUNT(*) FROM EMPLOYEE
WHERE DEPT_ID = '40';

ROLLBACK TO S1; 
-- UPDATE 취소

SELECT COUNT(*) FROM EMPLOYEE
WHERE DEPT_ID = '40';

SELECT * FROM DEPARTMENT;

ROLLBACK TO S0;
-- INSERT 취소

SELECT * FROM DEPARTMENT;


-- VIEW (뷰) **********************************************
-- SELECT 쿼리 실행의 결과 화면을 저장한 객체 (실행 결과 화면)
-- 뷰 객체를 가상의 테이블처럼 사용할 수 있음
-- 마치 결과화면을 사진찍어서 보관한다는 개념임 (뷰 == 사진)
-- 사용 목적
-- 1. 보안에 유리 : 중요한 쿼리문을 안 보이게 하고 결과만 보여줌
-- 2. 복잡하고 긴 쿼리문을 뷰를 통해 봄으로써 쿼리문을 실행하지 않아도 됨

/*
  * 뷰 만들기
  CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름 [(컬럼별칭, ....)]
  AS 서브쿼리
  [WITH CHECK OPTION CONSTRAINT 제약조건이름]
  [WITH READ ONLY CONSTRAINT 제약조건이름];
  
  * 뷰 삭제
  DROP VIEW 뷰이름;
  
  * 뷰 수정 기능은 없음, ALTER VIEW 는 없음
  
  * CREATE OR REPLACE
    : 지정하는 이름의 뷰가 없으면 새로 뷰를 만들고, 있으면 수정함(OVERWRITER)
    
  * FORCE | NOFORCE(기본값)
    - NOFORCE : 베이스테이블이 존재하는 경우에만 뷰 생성함
    - FORCE : 베이스테이블이 존재하지 않아도 뷰 생성함
    
  * (컬럼별칭,...)
    : 뷰에서 사용할 컬럼명 (의미 : 컬럼명 AS 별칭)
      서브쿼리 SELECT 절의 항목수와 반드시 갯수가 같아야 함
      서브쿼리 SELECT 항목에 별칭 적용하는 것과 결과는 같음
      
  * 제약조건 : 별도의 이름으로 저장할 수도 있음
  WITH CHECK OPTION : 뷰를 통해 베이스테이블에 DML을 수행할 수 있음
  WITH READ ONLY : 뷰를 통한 베이스테이블의 DML 수행 불가능임.
  CONSTRAINT 이름 으로 저장함.
*/

-- CREATE VIEW 에 대한 권한 설정해야 함
-- system 계정에서 : GRANT CREATE VIEW TO student;

-- 직원 정보에서 부서코드가 90인 직원들의 정보를 조회하고, 결과를 뷰로 저장함
-- 이름, 부서명, 직급명, 급여 조회함
CREATE OR REPLACE VIEW DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

-- 뷰 확인 : 뷰도 테이블처럼 사용함
SELECT * FROM DEPT90;

-- 데이터 딕셔너리에서 뷰 정보 확인
SELECT * FROM USER_VIEWS;

CREATE OR REPLACE VIEW V_EMP
AS 
SELECT EMP_NAME, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID = '90';

SELECT * FROM V_EMP;

-- 생성된 뷰는 테이블처럼 취급됨. 데이터 딕셔너리 확인
SELECT COLUMN_NAME, DATA_TYPE, NULLABLE
FROM USER_TAB_COLS
WHERE TABLE_NAME = 'V_EMP';
-- 뷰가 사용한 베이스테이블의 컬럼을 의미함

-- 실습 :
-- 직급명이 '사원'인 모든 직원들의 사원명, 부서명, 직급명을 
-- 조회한 결과를 뷰로 저장하시오.
-- 뷰 이름 : V_EMP_DEPT_JOB

CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS 
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원';

-- 확인
SELECT * FROM V_EMP_DEPT_JOB;

-- 뷰 생성시, 뷰이름 옆에 별칭 표시할 수 있음
-- 뷰이름 (alias, alias, ...)
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB (ENAME, DNAME, JTITLE)
AS 
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원';

-- 확인
SELECT * FROM V_EMP_DEPT_JOB;

-- 또는 서브쿼리 SELECT 절 항목 옆에 직접 별칭을 붙여줘도 결과는 같음
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB 
AS 
SELECT EMP_NAME ENAME, DEPT_NAME DNAME, JOB_TITLE JTITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '사원';

-- 확인
SELECT * FROM V_EMP_DEPT_JOB;

-- 서브쿼리 SELECT 절에 함수식 | 계산식이 사용이 되었을 때는
-- 뷰 생성시 반드시 별칭 지정해 주어야 함
-- 계산식에 별칭 없으면 에러 발생함
CREATE OR REPLACE VIEW V_EMP --(GENDER, YEARS) -- 갯수가 일치해야 함
AS
SELECT EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남자', '3', '남자', '여자') GENDER,
       ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12, 0) YEARS
FROM EMPLOYEE;       

SELECT * FROM V_EMP;

-- 뷰 생성시 제약조건 설정할 수 있음
-- WITH READ ONLY : 뷰를 이용해서 베이스테이블에 DML 수행 불가능
-- WITH CHECK OPTION : 뷰를 이용해서 베이스테이블에 DML 수행 가능
--      COMMIT / ROLLBACK 필요함
--      뷰를 통한 DML 수행시 제한사항이 있음

-- WITH READ ONLY 테스트
CREATE OR REPLACE VIEW V_EMP
AS
SELECT * FROM EMPLOYEE
WITH READ ONLY;

UPDATE V_EMP
SET PHONE = NULL;  -- ERROR

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO)
VALUES ('666', '오현정', '666666-6666666');  -- ERROR

DELETE FROM V_EMP;  -- ERROR

-- WITH CHECK OPTION 테스트
-- 조건에 따라 INSERT / UPDATE 는 사용에 제한이 있음
-- DELETE 는 제한없음

CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMP_ID, EMP_NAME, EMP_NO, MARRIAGE
FROM EMPLOYEE
WHERE MARRIAGE = 'N'
WITH CHECK OPTION;

-- INSERT 시에는 WHERE 절의 조건과 일치하는 값으로만 행을 추가할 수 있음.
INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('666', '오현정', '666666-6666666', 'Y');  -- ERROR

UPDATE V_EMP
SET MARRIAGE = 'Y';  -- ERROR

-- 뷰 생성시 WHERE 절 조건에 해당되지 않는 컬럼은 제한이 없음
UPDATE V_EMP
SET EMP_ID = '000'
WHERE EMP_ID = '124';  -- 뷰에 보여지는 데이터에 대해 UPDATE 가능함

SELECT * FROM V_EMP;

ROLLBACK;



-- 뷰 사용 1
CREATE OR REPLACE VIEW V_EMP_INFO
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID);

-- 뷰가 가진 정보를 테이블처럼 조회할 수 있다.
SELECT EMP_NAME
FROM V_EMP_INFO
WHERE DEPT_NAME = '해외영업1팀'
AND JOB_TITLE = '사원';


-- 뷰 사용 2
CREATE OR REPLACE VIEW V_DEPT_SAL ("Did", "Dnm", "Davg")  -- ALIAS 사용시
AS
SELECT NVL(DEPT_ID, 'NO'),
       NVL(DEPT_NAME, 'NONE'),
       ROUND(AVG(SALARY), -3)
FROM DEPARTMENT
RIGHT JOIN EMPLOYEE USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME;

-- "" 를 사용하여 alias를 지정한 경우에는 ""까지 기술해야 함
SELECT "Dnm", "Davg"
FROM V_DEPT_SAL
WHERE "Davg" > 3000000;

-- "" 사용 안 하면 에러 발생함
SELECT Dnm, Davg
FROM V_DEPT_SAL
WHERE Davg > 3000000;

-- 뷰 수정 : 별도 구문 없음 *************************
-- ALTER VIEW 구문 없음
-- 뷰 수정 방법
-- 1. 뷰를 삭제하고 새로 생성해야 함
-- 2. 기존의 내용을 덮어써서 뷰가 수정되게 함
CREATE OR REPLACE VIEW V_EMP
AS SELECT EMP_NAME, JOB_ID
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT * FROM V_EMP;

-- 수정
CREATE OR REPLACE VIEW V_EMP
AS SELECT EMP_NAME, JOB_ID
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 이미 사용중인 V_EMP 이름이 중복되어 에러 발생함
CREATE VIEW V_EMP
AS SELECT EMP_NAME, JOB_ID
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 뷰 삭제
-- DROP VIEW 뷰이름;
DROP VIEW V_EMP;

-- FORCE 옵션 : 뷰 만드는 서브쿼리의 베이스 테이블이 존재하지 않아도 뷰 만들어짐
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT;

-- NOFORCE 옵션 : 기본값
-- 서브쿼리의 베이스 테이블이 존재해야 함
CREATE OR REPLACE NOFORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT;  -- 테이블이 존재하지 않으면 에러남

-- 인라인 뷰 (INLINE VIEW) 개념 ***************************
-- 일반적으로 FROM 절에서 사용되는 서브쿼리에 별칭을 붙인 것

-- 부서별 급여 평균보다 급여를 많이 받는 직원 조회
SELECT EMP_NAME, SALARY
FROM (SELECT NVL(DEPT_ID, 'NO') AS "Did",
              ROUND(AVG(SALARY), -3) AS "Davg"
      FROM EMPLOYEE
      GROUP BY DEPT_ID) INLV
JOIN EMPLOYEE ON (NVL(DEPT_ID, 'NO') = INLV."Did")
WHERE SALARY > INLV."Davg"
ORDER BY 2 DESC;

-- 또는 뷰를 별도로 생성하고 
CREATE OR REPLACE VIEW V_DEPT_SALAVG ("Did", "Davg")
AS 
SELECT NVL(DEPT_ID, 'NO'), ROUND(AVG(SALARY), -3)
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- 테이블 대신 별도의 뷰를 사용
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN V_DEPT_SALAVG ON (NVL(DEPT_ID, 'NO') = "Did")
WHERE SALARY > "Davg"
ORDER BY 2 DESC;

-- ROWNUM 과 인라인 뷰를 이용한 TOP-N 분석
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
      FROM (SELECT NVL(DEPT_ID, 'NO') AS "Did",
                    ROUND(AVG(SALARY), -3) AS "Davg"
            FROM EMPLOYEE
            GROUP BY DEPT_ID) INLV
      JOIN EMPLOYEE ON ( NVL(DEPT_ID, 'NO') = INLV."Did")
      WHERE SALARY > INLV."Davg"
      ORDER BY 2 DESC )
WHERE ROWNUM <= 5;








