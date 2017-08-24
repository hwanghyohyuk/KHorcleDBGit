-- *****************************************
-- DDL(Data Definition Language)
-- 테이블 만들기, 테이블 수정하기, 테이블 삭제하기
-- 테이블 만들기 : CREATE TABLE
-- 테이블 수정하기 : ALTER TABLE
-- 테이블 삭제하기 : DROP TABLE
-- 이름 변경 : RANAME 

-- 테이블 만들기
-- CREATE TABLE 테이블명(
--        컬럼명 자료형(자릿수) [DEFAULT 기본값],
--        컬럼명 자료형(바이트사이즈) [컬럼레벨 제약조건],
--        CONSTRAINT 저장할이름 제약조건 (적용할컬럼명)
--        (테이블레벨 제약조건)               
--  );

-- ROWID
SELECT ROWID, EMP_ID, EMP_NAME
FROM EMPLOYEE;

-- 테이블 만들기
CREATE TABLE TEST1
(
       TNAME VARCHAR2(30),
       TPRICE NUMBER(10),
       TCONTENT VARCHAR2(100)
);

-- 서브쿼리로 새 테이블 만들고, 기존 테이블의 내용을 복사하기
CREATE TABLE EMP_COPY
AS SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
   FROM EMPLOYEE;
-- 서브쿼리로 기존 테이블의 내용을 복사해서 새 테이블에
-- 복사될 때, 기존 테이블의 제약조건은 복사 안 됨
-- 단, NOT NULL 제약조건만 복사됨   
   
SELECT * FROM EMP_COPY;   

-- 실습 : EMPLOYEE 테이블에서 남자 직원의 정보만 추려내서
-- EMP_MAN 테이블에 저장함
CREATE TABLE EMP_MAN
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

SELECT * FROM EMP_MAN;

-- 여자 직원의 정보만 추려내서, EMP_FEMAIL 테이블에 저장함
CREATE TABLE EMP_FEMAIL
AS
SELECT * FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT * FROM EMP_FEMAIL;


-- 컬럼에 주석 달기
-- COMMANT ON COLUMN 테이블명.컬럼명 IS '주석';

-- 실습 : 부서별 직원의 명단을 따로 PART_LIST 테이블에 저장함
-- DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID 로 구성함
-- 주석달기 : 부서명, 직급명, 사원명, 사번
CREATE TABLE PART_LIST
AS
SELECT DEPT_NAME, JOB_TITLE, EMP_NAME, EMP_ID
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID) 
ORDER BY DEPT_NAME;

SELECT * FROM PART_LIST;

COMMENT ON COLUMN PART_LIST.DEPT_NAME IS '부서명';
COMMENT ON COLUMN PART_LIST.JOB_TITLE IS '직급명';
COMMENT ON COLUMN PART_LIST.EMP_NAME IS '사원명';
COMMENT ON COLUMN PART_LIST.EMP_ID IS '사번';

-- 서브쿼리로 테이블의 구조만 복사하고, 데이터는 없는 빈 테이블
-- 만들기 : WHERE 절에 1 = 0 입력함
CREATE TABLE EMP_DESC_COPY
AS 
SELECT * FROM EMPLOYEE
WHERE 1 = 0;

SELECT * FROM EMP_DESC_COPY;



-- 테이블 삭제하기
-- DROP TABLE 테이블명 [삭제룰 제약조건];
DROP TABLE TEST1;

-- 새 테이블 만들 때, 기본키 설정하기
-- PRIMARY KEY : 컬럼레벨, 테이블레벨
-- UNIQUE + NOT NULL
CREATE TABLE TEST1
(
       TCODE NUMBER(3) PRIMARY KEY,
       TNAME VARCHAR2(30)     NOT NULL,
       TPRICE NUMBER(10, 2),
       TDATE DATE
);

-- *********************************************************************
-- DML(Data Management Language)
-- 테이블에 값 기록하기, 값 수정하기, 값 삭제하기
-- INSERT, UPDATE, DELETE

-- 테이블에 값 기록하기
-- INSERT INTO 테이블명 [(컬럼명, 컬럼명, 컬럼명)]
-- VALUES (기록할 값, 기록할 값, 기록할 값);
-- 나열된 컬럼명 순서에 맞춰서 기록할 값을 나열함.
-- 컬럼명 나열이 생략되면, 테이블에 작성된 모든 컬럼에 순서대로
-- 기록한다는 의미임.

INSERT INTO TEST1
VALUES (110, '갤럭시 노트3', 999000, SYSDATE);

SELECT * FROM TEST1;

-- ** PRIMARY KEY 제약조건이 설정된 컬럼에는 
-- NULL 사용 못하고, 같은 값 중복기록 못함
INSERT INTO TEST1
VALUES (NULL, '아이폰 5', 1200000.00, 
TO_DATE('2013/08/15', 'YYYY/MM/DD')
);

-- 중복 에러
INSERT INTO TEST1
VALUES (110, '아이폰 5', 1200000.00, 
TO_DATE('2013/08/15', 'YYYY/MM/DD')
);

INSERT INTO TEST1
VALUES (120, '아이폰 5', 1200000.00, 
TO_DATE('2013/08/15', 'YYYY/MM/DD')
);

SELECT * FROM TEST1;

-- NOT NULL 이 설정된 컬럼에 값 기록 또는 수정시
-- 절대 널값 사용못함.
INSERT INTO TEST1 (TCODE, TNAME)
VALUES (130, NULL);

INSERT INTO TEST1 (TCODE, TNAME)
VALUES (130, '옵티머스');

-- SQL> 에서
-- DESC USER_CONSTRAINTS;
-- 사용자가 설정한 제약조건들을 데이터 딕셔너리에서 볼 수 있음
-- 데이터 딕셔너리에서 원하는 정보만 추출해서 볼 수도 있음
SELECT CONSTRAINT_NAME, 
       CONSTRAINT_TYPE,
       TABLE_NAME
FROM USER_CONSTRAINTS;       

-- CONSTRAINT_TYPE
-- P : PRIMARY KEY
-- R : FOREIGN KEY
-- U : UNIQUE
-- C : CHECK, NOT NULL

CREATE TABLE TESTNN
(
       COL1 CHAR(2) NOT NULL,  -- 컬럼 레벨
       COL2 CHAR(2)--,
       -- 테이블 레벨에서 제약조건 설정시에는
       -- CONSTRAINT 저장할 이름 제약조건 (적용할컬럼명)
       -- CONSTRAINT NN_TSTNNCOL2 NOT NULL (COL2)
      -- NOT NULL 제약조건은 컬럼레벨에서만 설정할 수 있음
);

-- UNIQUE 제약조건
-- 해당 컬럼에 같은 값 중복 입력 못하게 함
CREATE TABLE TESTUN
(
       UCOL1 CHAR(2) UNIQUE,
       UCOL2 CHAR(2) CONSTRAINT UN_TUCOL2 UNIQUE,
       UCOL3 CHAR(2),
       CONSTRAINT UN_TUCOL3 UNIQUE (UCOL3)
);

INSERT INTO TESTUN
VALUES ('AA', 'AB', 'AC');

SELECT * FROM TESTUN;
-- 다시 입력
INSERT INTO TESTUN
VALUES ('AA', 'AB', 'AC');

-- FOREIGN KEY 제약조건
-- 외부 참조 컬럼을 의미함
-- 일단 다른 테이블과 관계(RELATION) 처리를 해야 함.
-- 새로 만들 컬럼에 기록되는 값을 다른 테이블에서 제공하는 값만
-- 사용하게 할 목적으로 지정함
-- 제공되는 값만 사용하고, 제공되지 않는 값은 사용못하게 막기위함.
-- 단, NULL 은 예외임.
-- 일반적으로는 참조되는 테이블의 기본키가 지정된 컬럼이 기본으로
-- 연결됨

CREATE TABLE TESTFK
(
       -- 컬럼 레벨에서 외부키 지정시
       -- 컬럼명 자료형 REFERENCES 참조할테이블명[(컬럼명)]
       FDEPT_ID CHAR(2) REFERENCES DEPARTMENT,
       FJOB_ID CHAR(2),
       -- 테이블 레벨에서 외부키 설정시
       CONSTRAINT FK_TFKJ_ID FOREIGN KEY (FJOB_ID)
                  REFERENCES JOB(JOB_ID)
);

SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

-- FOREIGN KEY 가 설정된 컬럼에는 제공되는 값만 사용할 수
-- 있음
INSERT INTO TESTFK (FDEPT_ID, FJOB_ID)
VALUES ('20', 'J3');

-- 참조테이블이 제공하지 않는 값을 사용했을 경우
INSERT INTO TESTFK
VALUES ('44', 'J9');

-- NULL 은 사용 가능함
INSERT INTO TESTFK
VALUES (NULL, NULL);

SELECT * FROM TESTFK;

-- CHECK 제약조건
-- 해당 컬럼에 기록되는 값을 체크함
-- 값의 범위, 지정한 값 이 아닐 때 에러나도록 함
-- CHECK (컬럼명 연산자(값))

CREATE TABLE TESTCHK
(
       COL1 CHAR(1) CONSTRAINT CH_TSTCL1 
                    CHECK (COL1 IN ('M', 'F')),
       COL2 NUMBER,
       CONSTRAINT CH_TSTCL2 CHECK (COL2 BETWEEN 1000 AND 10000)
);

INSERT INTO TESTCHK
VALUES ('M', 500);          -- COL2 가 값의 범위를 벗어남

INSERT INTO TESTCHK
VALUES ('m', 5000);         -- COL1의 값이 소문자임.

INSERT INTO TESTCHK
VALUES ('F', 5000);

SELECT * FROM TESTCHK;


-- DEFAULT 값
-- 해당 컬럼에 값 기록 또는 수정시 값대신에 DEFAULT 를 사용함
-- 지정된 기본값이 해당 컬럼에 기록됨

CREATE TABLE TESTDFL
(
       ADDRESS VARCHAR2(100) DEFAULT 'SEOUL',
       HIRE_DATE DATE DEFAULT SYSDATE
);

INSERT INTO TESTDFL
VALUES ('BUSAN', TO_DATE('2013-11-04', 'YYYY-MM-DD'));

INSERT INTO TESTDFL
VALUES (DEFAULT, DEFAULT);

SELECT * FROM TESTDFL;

-- 여러 개의 컬럼을 하나의 기본키로 묶어서 설정했을 경우
CREATE TABLE TESTMULTIPK
(
       CL1 CHAR(2),
       CL2 NUMBER,
       CONSTRAINT PK_MULTI PRIMARY KEY(CL1, CL2)
);

-- 중복값 체크시, 묶여진 컬럼들을 이어서 하나의 값으로 인식함
INSERT INTO TESTMULTIPK
VALUES ('AA', 100);

INSERT INTO TESTMULTIPK
VALUES ('BB', 100);

INSERT INTO TESTMULTIPK
VALUES ('AA', 200);

INSERT INTO TESTMULTIPK
VALUES ('AA', 100);  -- UNIQUE ERROR

INSERT INTO TESTMULTIPK
VALUES ('BB', NULL); -- NULL ERROR

INSERT INTO TESTMULTIPK
VALUES (NULL, 100);  -- NULL ERROR

SELECT * FROM TESTMULTIPK;

-- 실습 : 제약조건이 설정된 테이블 만들기
-- 테이블명 : PHONEBOOK
-- 컬럼명 :  ID  CHAR(3) 기본키(저장이름 : PK_PBID)
--         PNAME      VARCHAR(20)  널 사용못함.
--                                 (NN_PBNAME) 
--         PHONE      VARCHAR(15)  널 사용못함
--                                 (NN_PBPHONE)
--                                 중복값 입력못함
--                                 (UN_PBPHONE)
--         ADDRESS    VARCHAR(100) 기본값 지정함
--                                 '서울시 구로구'

-- NOT NULL을 제외하고, 모두 테이블 레벨에서 지정함.

CREATE TABLE PHONEBOOK
(
       ID    CHAR(3),
       PNAME VARCHAR2(20) CONSTRAINT NN_PBNAME 
                                     NOT NULL,
       PHONE VARCHAR2(15) CONSTRAINT NN_PBPHONE 
                                     NOT NULL,
       ADDRESS VARCHAR2(100) DEFAULT '서울시 구로구',
       CONSTRAINT PK_PBID PRIMARY KEY (ID),
       CONSTRAINT UN_PBPHONE UNIQUE (PHONE)       
);

INSERT INTO PHONEBOOK
VALUES ('A01', '홍길동', '010-1234-5678', DEFAULT);

SELECT * FROM PHONEBOOK;

-- 저장된 제약조건 확인
SELECT CONSTRAINT_NAME,
       CONSTRAINT_TYPE,
       TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'PHONEBOOK';  


-- 기존 테이블의 제약조건 변경하기
-- 제약조건 추가하기
-- ALTER TABLE 테이블명
-- ADD [CONSTRAINT] [저장할 이름] 제약조건 (적용할컬럼명);

-- 서브쿼리로 EMP_DEPT90 테이블을 만들면서, 
-- 소속부서코드가 90인 직원들의 사번, 이름, 부서명, 급여 복사함
CREATE TABLE EMP_DEPT90
AS
SELECT EMP_ID, EMP_NAME, DEPT_NAME, SALARY
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_ID = '90';

SELECT * FROM EMP_DEPT90;

-- EMP_DEPT90 테이블에 제약조건 추가함
-- EMP_ID 는 EMPLOYEE 테이블의 기본키(EMP_ID)의 외부키로
-- SALARY 는 CHECK 추가 : 0이 아니면서 백만 이상만 기록가능
ALTER TABLE EMP_DEPT90
ADD CONSTRAINT FK_EMPDPT90 FOREIGN KEY (EMP_ID)
    REFERENCES EMPLOYEE (EMP_ID);

ALTER TABLE EMP_DEPT90
ADD CONSTRAINT CH_EMPDPT90 
    CHECK (SALARY <> 0 AND SALARY >= 1000000); 
    
-- 제약조건 설정 확인
SELECT CONSTRAINT_NAME,
       CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP_DEPT90';           
   
-- 실습 
CREATE TABLE TEST9
(
       EID CHAR(2) PRIMARY KEY,
       ENAME VARCHAR2(20) NOT NULL,
       SAL NUMBER CHECK (SAL > 1000000), -- 기록값 검사 기능
       MRI CHAR(1) DEFAULT 'N',
       CONSTRAINT HR_TST9_CHK_MRI 
                  CHECK (MRI IN ('Y', 'N')) -- 'Y' 또는 'N' 만 기록할 수 있음.
);

INSERT INTO TEST9
VALUES ('11', 'JOHN', 2100000, 'R');  -- mri check error

INSERT INTO TEST9 (eid, ename, sal, mri)
VALUES ('11', 'JOHN', 2100000, 'N');

INSERT INTO TEST9 (eid, ename, sal, mri)
VALUES ('13', 'JOHN', 500000, 'N');

SELECT * FROM TEST9;

-- 객체 정보 수정 : ALTER TABLE 테이블명 ....
-- 컬럼 추가, 컬럼의 자료형 또는 제약조건 수정, 컬럼명 수정, 
-- 컬럼 삭제

-- 컬럼 추가
ALTER TABLE TEST9
ADD (DID CHAR(2) DEFAULT '10');

-- 컬럼의 자료형 수정
ALTER TABLE TEST9
MODIFY (DID VARCHAR2(2));

-- 컬럼명 변경
ALTER TABLE TEST9 
RENAME COLUMN DID TO D_ID;

-- 컬럼 삭제하기 : 컬럼에 기록된 데이터가 없어야 함.
ALTER TABLE TEST9
DROP (D_ID);

-- 컬럼을 삭제하지 않고, 사용을 못하게 함
-- 나중에 삭제하기 위함
ALTER TABLE TEST9
SET UNUSED (SAL);

SELECT * FROM TEST9;
-- DESC 로 확인해 봄




-- 제약조건 추가
ALTER TABLE 테이블명 
ADD CONSTRAINT 이름 제약조건(컬럼명)
    [REFERENCE 참조테이블명(참조컬럼)];

-- 제약조건 삭제
ALTER TABLE 테이블명 
DROP CONSTRAINT 이름;

-- FK 설정되어 있을 경우
ALTER TABLE 테이블명 
DROP CONSTRAINT 이름 CASCADE;
-- 예를 들어, DEPARTMENT 테이블의  DEPT_ID 컬럼값은
-- EMPLOYEE 에서 참조해서 사용하고 있음.
-- 외부 참조로 사용되고 있는 값은 삭제할 수 없음.
DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90';    -- 삭제못함
-- 삭제를 원하면, 사용하고 있는 값들을 모두 찾아서 먼저 지워야함
-- 아니면 값을 쓰고 있는 테이블에서 외부키 설정을 제거해야함.

-- 테이블 삭제
/*1. 일반 사용자의 권한에서 자신의 모든 테이블을 삭제하고 싶을 시
SQL> ed drop
     Begin
     for c in (select table_name from user_tables)loop
     execute immediate ('drop table' ||c.table_name|| 'cascade constraints');
     end loop;
     End; 

위와 같이 작성하여 실행하면 자신의 모든 테이블이 삭제됨

2. 오라클에서는 table을 drop하면 테이블명 앞에 BIN$ 이런 문자가 붙어 
   쓰레기 테이블로 남음.
*/
SELECT * FROM TAB;
--(전체 테이블 조회) 

SELECT * FROM USER_RECYCLEBIN;
--(휴지통에 들어있는 전체 테이블 조회) --

--둘중 아무거나 실행해보면 쓰레기테이블들을 볼수있음
--혹시나 보이지 않는다면 

--SQL> ALTER SYSTEM SET "recyclebin" = on;

--으로 휴지통을 on으로 설정 해주면 된다. 

--그리고 이 쓰레기테이블들을 모두 지우려면 아래 명령어를 실행 

--SQL> PURGE RECYCLEBIN; 

--아래 명령어를 실행시 삭제하려는 테이블이 오라클 휴지통에 가지않고 바로 삭제됨.
※ SQL> DROP TABLE 테이블명 PURGE;


--쓰레기통  = 실제 SELECT 때는 보이지 않지만, 
--운영체제에는 남아있는 테이블.


--3. 오라클 데이타 복구하기
--실수로 데이터를 삭제나 업데이트 했을 시 
--오라클에서 TIMESTAMP를 사용하여 복원가능하다.

 SELECT * 
     FROM 테이블명 AS OF TIMESTAMP 
     (SYSTIMESTAMP-INTERVAL '30' MINUTE);

--TABLE = 복구하려는 테이블명 , '30' = 복구하려는 시점.
--이렇게하면 30분전의 데이터를 보여준다.

--※ 180분 이상은 복구가 불가능하니 참고.

--아래 명령문을 작성하여 데이터를 다시 생성.
 INSERT INTO 테이블명 
     SELECT * FROM TABLE AS OF TIMESTAMP
     (SYSTIMESTAMP-INTERVAL '30' MINUTE);
 

--4. DROP된 테이블 복구 방법

 FLASHBACK TABLE [RECYCLEBIN 안에 생성된 테이블 이름] 
     TO BEFORE DROP; 

--※ FLASHBACK TABLE 은 오라클 10g 이상에서만 사용가능.
*/

DROP TABLE TEST9;

--  테이블 안의 모든 데이터 삭제
SELECT * FROM EMP_COPY;

TRUNCATE TABLE EMP_COPY; -- 복구 못 함

-- 테이블 이름 변경하기
-- RENAME 원래이름 TO 새이름;
RENAME EMP_COPY TO EMPCPY;










