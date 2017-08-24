-- VIEW (뷰)  **************************************
 : SELECT 쿼리 실행의 결과를 보여주는 화면
 - 결과화면을 가상의 테이블처럼 저장해 두고 사용할 수 있음.
 - 마치 결과화면을 사진 찍어 보관한다는 개념임.
 - 사용목적 : 
	1. 보안에 유리 : 보관된 결과 화면만 봄으로써 쿼리문 안 보이게 함
	2. 복잡하고 긴 쿼리문을 뷰를 통해 봄으로써 매번 쿼리문을 실행
	  시키지 않아도 됨

/*CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 
       view_name[( alias[, alias ...])]
AS Subquery
[WITH CHECK OPTION[ CONSTRAINT constraint_name]]
[WITH READ ONLY[ CONSTRAINT constraint_name]] ;

* CREATE OR REPLACE
   :지정한 이름의 뷰가 없으면 새로 생성하고,
   동일 이름이 존재하면 수정(Overwrite) 함
   
* FORCE | NOFORCE
 - NOFORCE : 베이스 테이블이 존재하는 경우에만 뷰생성 가능
 - FORCE : 베이스 테이블이 존재하지 않아도 뷰생성 가능

* ALIAS
 : 뷰에서 사용할 표현식 이름(테이블 컬럼 이름 의미)
  생략하면 SUBQUERY에서 SELECT 한 이름 적용됨
 - ALIAS 개수는 SUBQUERY에서 사용한 SELECT LIST
    개수와 일치해야 함
    
* SUBQUERY
  : 뷰에서 표현하는 데이터를 생성하는 SELECT 구문

* 제약조건
- WITH CHECK OPTION : 뷰를 통해 접근 가능한 데이터에
        대해서만 DML 작업 허용
        베이스 테이블이 1개 일때만 가능함.
  - WITH READ ONLY : 뷰를 통해 DML 작업 허용 안 함
  - 제약조건으로 간주되므로 별도 이름 지정가능
*/

-- 권한 설정해야 함
-- system 계정으로 접속
GRANT CREATE VIEW TO STUDENT01;

-- 뷰 만들기 : 서브쿼리 사용함
-- 뷰를 생성할 때 사용하는 서브쿼리는 일반적인 SELECT 구문을
-- 사용
-- 생성된 뷰는 테이블처럼 취급됨 
-- 쿼리가 실행한 결과화면을 저장함 


CREATE VIEW V_EMP_DEPT90
AS
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

-- 확인
SELECT * FROM V_EMP_DEPT90;


CREATE OR REPLACE VIEW V_EMP
AS SELECT EMP_NAME, JOB_TITLE, SALARY
   FROM EMPLOYEE
   LEFT JOIN JOB USING (JOB_ID)
   WHERE DEPT_ID = '90';

-- 뷰 확인
SELECT * FROM V_EMP;

-- 데이터 딕셔너리에는 뷰의 서브쿼리가 저장됨
SELECT * FROM USER_VIEWS;

DESC USER_VIEWS;
-- VIEW_NAME : 저장된 뷰이름
-- TEXT : 서브쿼리문

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'V_EMP';


-- 실습 :
-- 직급명이 '사원'인 모든 직원들의 사원명, 부서명, 직급명을 
-- 조회한 결과를 뷰로 저장하시오.
-- 뷰 이름 : V_EMP_DEPT_JOB
 
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
   FROM EMPLOYEE
   LEFT JOIN DEPARTMENT USING (DEPT_ID)
   LEFT JOIN JOB USING (JOB_ID)
   WHERE JOB_TITLE = '사원';
   
-- 확인
SELECT * FROM V_EMP_DEPT_JOB;

-- 뷰도 테이블처럼  객체로 조회 가능함
SELECT COLUMN_NAME, DATA_TYPE, NULLABLE 
FROM USER_TAB_COLS
WHERE TABLE_NAME = 'V_EMP_DEPT_JOB';   

-- 뷰 - 생성 예 : ALIAS 사용 ******************
-- 뷰 정의 부분에서 지정 가능
-- 서브쿼리 부분에서 지정 가능
CREATE OR REPLACE VIEW 
       V_EMP_DEPT_JOB (ENM, DNM, TITLE)
AS SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
   FROM EMPLOYEE
   LEFT JOIN DEPARTMENT USING (DEPT_ID)
   LEFT JOIN JOB USING (JOB_ID)
   WHERE JOB_TITLE = '사원';
   
SELECT * FROM V_EMP_DEPT_JOB;
   
-- 또는
CREATE OR REPLACE VIEW V_EMP_DEPT_JOB
AS SELECT EMP_NAME AS ENM,
   DEPT_NAME AS DNM,
   JOB_TITLE AS TITLE
   FROM EMPLOYEE
   LEFT JOIN DEPARTMENT USING (DEPT_ID)
   LEFT JOIN JOB USING (JOB_ID)
   WHERE JOB_TITLE = '사원';   
   
-- 뷰 컬럼이 함수나 표현식에서 만들어진 컬럼에는
-- ALIAS 반드시 사용해야 함  
CREATE OR REPLACE VIEW 
       V_EMP  ("Enm", "Gender", "Years") -- 생략시 에러확인
AS SELECT EMP_NAME, 
   DECODE(SUBSTR(EMP_NO, 8,1),'1','남자','3','남자','여자'),
   ROUND(MONTHS_BETWEEN
                 (SYSDATE, HIRE_DATE)/12, 0)
   FROM EMPLOYEE; 
   
-- 특정 컬럼에 선택적으로 ALIAS를 지정하는 것은
-- 서브쿼리 부분 에서만 가능
CREATE OR REPLACE VIEW V_EMP 
AS SELECT EMP_NAME, 
   DECODE(SUBSTR(EMP_NO, 8,1),'1','남자','3','남자','여자')
                         AS "Gender",
   ROUND(MONTHS_BETWEEN(
            SYSDATE, HIRE_DATE)/12,0) AS "Years"
   FROM EMPLOYEE;   

-- 에러 : 뷰생성 부분 에서는 전체 컬럼에 대해 지정해야 함   
CREATE OR REPLACE VIEW V_EMP ("Gender", "Years") 
AS
SELECT EMP_NAME ,
       DECODE(SUBSTR(EMP_NO, 8,1),
                     '1','남자','3','남자','여자'),
       ROUND(MONTHS_BETWEEN(
                     SYSDATE, HIRE_DATE)/12, 0)
FROM EMPLOYEE;

-- 뷰-생성예 : 제약조건  
-- 뷰의 원래 목적은 아니지만 뷰를 통한 DML작업 가능함
-- DML 작업 결과는 베이스 테이블의 데이터에 적용됨
-- COMMIT / ROLLBACK 작업 필요함
-- 뷰를 통한 DML작업은 여러가지 제한이 있음
-- 뷰 생성시 DML 작업에 대한 제한을 설정할 수 있음
-- WITH READ ONLY : 뷰를 통한 DML 작업 불가
-- WITH CHECK OPTION : 뷰를 통해 접근 가능한 데이터에
--            대해서 DML 작업 수행 가능함


-- WITH READ ONLY
CREATE OR REPLACE VIEW V_EMP
AS 
SELECT * FROM EMPLOYEE
WITH READ ONLY; 

-- DML 작업에 따라 에러 유형은 다르지만,
-- DML 작업을 허용하지 않는다
UPDATE V_EMP
SET PHONE = NULL;

INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO)
VALUES ('666', '오현정', '666666-6666666');

DELETE FROM V_EMP;

-- WITH CHECK OPTION
-- 조건에 따라 INSERT / UPDATE 작업 제한
-- DELETE는 제한 없음
CREATE OR REPLACE VIEW V_EMP
AS SELECT EMP_ID, EMP_NAME, EMP_NO, 
          MARRIAGE
   FROM EMPLOYEE
   WHERE MARRIAGE = 'N'
WITH CHECK OPTION;

-- 에러
INSERT INTO V_EMP (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE)
VALUES ('666', '오현정', '666666-6666666', 'Y');

-- 에러
UPDATE V_EMP SET MARRIAGE = 'Y';

-- 뷰를 생성할 때 사용한 WHERE 조건에 적용되는
-- 범위에서는 허용됨
UPDATE V_EMP
SET EMP_ID = '000'
WHERE EMP_ID = '124';

SELECT EMP_ID
FROM EMPLOYEE
WHERE EMP_ID = '000';

ROLLBACK;

-- 뷰 생성시 사용한 서브쿼리 자체가 데이터 딕셔너리에 저장됨
-- USER_VIEWS : 뷰 정보를 관리하는 데이터 딕셔너리
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'V_EMP';

-- VIEW 사용 1 ****************************
CREATE OR REPLACE VIEW V_EMP_INFO
AS 
SELECT EMP_NAME, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID);

-- 뷰가 가진 정보를 테이블처럼 조회할 수 있음
SELECT EMP_NAME
FROM V_EMP_INFO
WHERE DEPT_NAME = '해외영업1팀'
AND JOB_TITLE = '사원';


-- 뷰 사용 2
CREATE OR REPLACE VIEW V_DEPT_SAL 
       ("Did", "Dnm", "Davg")  -- ALIAS 사용시
AS
SELECT NVL(DEPT_ID,'NO'),
       NVL(DEPT_NAME,'NONE'),
       ROUND(AVG(SALARY),-3)
FROM DEPARTMENT
RIGHT JOIN EMPLOYEE USING (DEPT_ID)
GROUP BY DEPT_ID, DEPT_NAME;

-- "" 를 사용하여 alias를 지정한 경우에는 ""까지 기술해야 함
SELECT "Dnm", "Davg"
FROM V_DEPT_SAL
WHERE "Davg" > 3000000;

-- "" 사용 안 하면 에러 발생함 : 11g에서는 에러 안 남.
SELECT Dnm, Davg
FROM V_DEPT_SAL
WHERE Davg > 3000000;

-- 뷰 수정 : 별도 구문 없음 *************************
ALTER VIEW 구문 없음

-- 뷰를 삭제하고 새로 생성해야 함
-- 기존의 내용을 덮어써서 뷰가 수정되게 함
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
-- DROP VIEW view_name ;
DROP VIEW V_EMP;

-- FORCE 옵션 : 서브쿼리에서 사용된 테이블이 존재하지
--          않아도 뷰 생성됨
CREATE OR REPLACE FORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT;

-- NOFORCE 옵션
CREATE OR REPLACE NOFORCE VIEW V_EMP
AS
SELECT TCODE, TNAME, TCONTENT
FROM TTT; -- 테이블이 존재하지 않으면 에러남


-- 인라인 뷰(Inline View) 개념 ***********************
-- 일반적으로 FROM 절에서 사용된 서브쿼리에 별칭을 붙인 것
SELECT EMP_NAME, SALARY
FROM (SELECT NVL(DEPT_ID,'NO') AS "Did",
             ROUND(AVG(SALARY),-3) AS "Davg"
     FROM EMPLOYEE
     GROUP BY DEPT_ID) INLV
JOIN EMPLOYEE ON (NVL(DEPT_ID, 'NO') = INLV."Did")
WHERE SALARY > INLV."Davg"
ORDER BY 2 DESC;

-- 또는
-- 뷰 생성
CREATE OR REPLACE VIEW V_DEPT_SALAVG
       ("Did", "Davg")
AS 
SELECT NVL(DEPT_ID, 'N/A'),
       ROUND(AVG(SALARY),-3)
FROM EMPLOYEE
GROUP BY DEPT_ID;
   
-- 뷰 사용
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN V_DEPT_SALAVG ON (NVL(DEPT_ID, 'N/A') = "Did")
WHERE SALARY > "Davg"
ORDER BY 2 DESC;
