-- DAY9 수업내용

-- DDL(Data Definition Language)
-- CREATE, ALTER, DROP 문
-- 객체를 만들고, 수정하고, 삭제할 때 사용하는 구문
-- 객체(OBJECT) : 테이블(TABLE), 뷰(VIEW), 인덱스(INDEX), 패키지(PACKAGE),
--     함수(FUNCTION), 프로시저(PROCEDURE), 트리거(TRIGGER), 시퀀스(SEQUENCE)
--     동의어(SYNONYM), 사용자(USER), 롤(ROLE)

-- 테이블 만들기
/*
  CREATE TABLE 테이블명(
    컬럼명   자료형(크기 [BYTE]|CHAR),
    컬럼명   자료형(크기)  DEFAULT 기본값  [제약조건],
    컬럼명   자료형(크기) CONSTRAINT 이름 제약조건종류,
    CONSTRAINT 이름 제약조건종류 (적용할컬럼명)
  );
  
  COMMENT ON COLUMN 테이블명.컬럼명 IS 설명문구; 
*/

-- 회원 정보 저장용 테이블 작성 예
DROP TABLE MEMBER CASCADE CONSTRAINTS;

CREATE TABLE MEMBER (
  ID  VARCHAR2(15),
  PASSWD VARCHAR2(15)  CONSTRAINT NN_MEMPWD NOT NULL,
  NAME VARCHAR2(20) CONSTRAINT NN_MEMNAME NOT NULL,
  GENDER CHAR(3) CONSTRAINT CHK_MEMGEN CHECK (GENDER IN ('남', '여')),
  EMAIL VARCHAR2(20),
  ADDRESS VARCHAR2(100),
  PHONE VARCHAR2(13),
  ENROLL_DATE  DATE  DEFAULT SYSDATE,
  CONSTRAINT PK_MEMBERID PRIMARY KEY (ID)
);

COMMENT ON COLUMN MEMBER.ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.PASSWD IS '회원암호';
COMMENT ON COLUMN MEMBER.NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '회원성별';
COMMENT ON COLUMN MEMBER.EMAIL IS '회원이메일';
COMMENT ON COLUMN MEMBER.ADDRESS IS '회원주소';
COMMENT ON COLUMN MEMBER.PHONE IS '회원전화번호';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원가입날짜';


-- DML (Data Manipulation Language)
-- 데이터 조작 언어
-- INSERT, UPDATE, DELETE 문
-- INSERT 문 : 테이블에 값을 기록(행 추가됨)
-- UPDATE 문 : 테이블에 기록된 값을 수정(행 갯수에 변화없음)
-- DELETE 문 : 기록된 값에 대한 행을 삭제함(행 갯수가 줄어듬), 복구 가능함
-- TRUNCATE 문 : 테이블의 모든 행을 삭제함, 복구 안 됨

-- INSERT 문
/*
  INSERT INTO 테이블명 [(값기록에 사용할 컬럼명, 컬럼명, ......)]
  VALUES (컬럼에 기록할 값, 값, ...);
  
  컬럼 기술 부분이 생략되면, 테이블의 모든 컬럼에 컬럼생성순서에 맞춰서 값을 기록해야 함
*/

INSERT INTO MEMBER 
(ID, PASSWD, NAME, GENDER, EMAIL, ADDRESS, PHONE, ENROLL_DATE)
VALUES ('admin', 'admin', '관리자', '남', 'admin@iei.or.kr', '서울시 강남구 역삼동',
'010-1234-5678', DEFAULT);

INSERT INTO MEMBER
VALUES ('user11', 'pass11', '홍길동', '남', 'hong123@iei.or.kr', 
'서울시 강남구 삼성동 123', '010-1111-2222', 
TO_DATE('2017-08-21', 'RRRR-MM-DD'));

INSERT INTO MEMBER
VALUES ('user22', 'pass22', '신사임당', '여', 'shin555@iei.or.kr',
'강원도 강릉시 오죽헌', '010-5555-5555', DEFAULT);

COMMIT;

SELECT * FROM MEMBER;

DROP TABLE NOTICE CASCADE CONSTRAINTS;

/*
  공지사항 정보를 저장할 테이블 : NOTICE
  컬럼 : 글번호(숫자), 글제목(가변문자 30바이트), 작성자아이디(가변문자 15바이트), 
      작성날짜(날짜)
      작성내용(가변문자 2000바이트), 첨부파일경로명(가변문자 50바이트)
  NOTICE_NO, NOTICE_TITLE, NOTICE_WRITER, NOTICE_DATE, NOTICE_CONTENT, 
  FILE_PATH
  작성날짜의 기본값은 SYSDATE
  
  첫번째 글 추가 : 
  1, '첫번째 공지글', 'user01', '안녕하세요. 공지사항을 알려드립니다.'
  두번째 글 추가 : 
  글번호의 가장 큰 값 + 1, '두번째 공지글', 'user02', '알립니다. 두번째'
*/

CREATE TABLE NOTICE(
  NOTICE_NO NUMBER,
  NOTICE_TITLE VARCHAR2(30),
  NOTICE_WRITER VARCHAR2(15),
  NOTICE_DATE DATE DEFAULT SYSDATE,
  NOTICE_CONTENT VARCHAR2(2000),
  FILE_PATH VARCHAR2(50)
);

INSERT INTO NOTICE
VALUES (1, '첫번째 공지글', 'user01', DEFAULT, 
'안녕하세요. 공지사항을 알려드립니다.', NULL);

INSERT INTO NOTICE
VALUES ((SELECT MAX(NOTICE_NO) + 1 FROM NOTICE), 
        '두번째 공지글', 'user02', DEFAULT, '알립니다. 두번째', NULL);
COMMIT;

SELECT * FROM NOTICE;

-- ***********************************************************
-- 테이블 만들 때 서브쿼리 사용할 수 있음
-- 테이블 복사 기능으로 이용할 수 있음
-- SELECT 조회 결과를 새로운 테이블에 기록 저장할 수도 있음
/*
  CREATE TABLE 테이블명 [(컬럼명, 컬럼명, ....)]
  AS 서브쿼리문;
  
  컬럼명, 자료형, NOT NULL 제약조건이 복사됨
  다른 제약조건은 복사 안 됨.
*/

CREATE TABLE EMP_DEPT_JOB
AS 
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID);

SELECT * FROM EMP_DEPT_JOB;


-- 서브쿼리를 이용한 테이블 생성시 테이블명 옆에 생성될 컬럼명을 따로 지정할 수 있음
-- 서브쿼리 SELECT 절의 컬럼 갯수와 반드시 같아야 함
CREATE TABLE EMP_DEPT_JOB2 (EID, ENAME, SAL, DNAME, JTITLE)
AS 
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID);

SELECT * FROM EMP_DEPT_JOB2;


-- 테이블 생성시 서브쿼리가 SELECT 한 컬럼명에 대해 선택적으로 다른 이름을 지정하려면
-- 서브쿼리 SELECT 절 컬럼명에 대해 별칭(ALIAS) 적용하면 됨
CREATE TABLE EMP_DEPT_JOB3 
AS 
SELECT EMP_ID EID, EMP_NAME ENAME, SALARY, 
        DEPT_NAME DNAME, JOB_TITLE JTITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID);

SELECT * FROM EMP_DEPT_JOB3;

-- 서브쿼리를 이용한 테이블 생성시, 테이블명 옆에 컬럼명 새로 지정시 제약조건도 함께
-- 지정할 수 있음
-- 단, 서브쿼리가 SELECT 한 결과값에 각 컬럼별 제약조건이 위배되지 않는 값만 존재해야함
CREATE TABLE EMP_DEPT_JOB4 (
  EID PRIMARY KEY, 
  ENAME, 
  SAL CHECK (SAL > 2000000), 
  DNAME, 
  JTITLE NOT NULL)
AS 
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT USING (DEPT_ID)
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY > 2000000
AND JOB_TITLE IS NOT NULL;

DROP TABLE EMP_DEPT_JOB4;

--DESCRIBE EMP_DEPT_JOB4;
DESC EMP_DEPT_JOB4;  -- 테이블 구조 확인용 SQL PLUS 명령어


-- 데이터 딕셔너리
-- 오라클에 의해서 자동 저장 관리되고 있는 테이블
-- 사용자 정보, 테이블 정보, 제약조건 정보, 컬럼 정보 등
-- 데이터베이스에서 발생하는 모든 정보를 기록 저장 관리하는 시스템 정보임
-- 사용자는 조회만 할 수 있고, 손은 댈 수 없음(수정, 삭제 불가)

-- 사용자가 소유한 테이블 정보 : USER_TABLES
SELECT * FROM USER_TABLES;
DESC USER_TABLES;

-- 사용자가 만든 제약조건 정보 : USER_CONSTRAINTS
SELECT * FROM USER_CONSTRAINTS;
DESC USER_CONSTRAINTS;

-- 사용자가 만든 시퀀스 정보 : USER_SEQUENCES
SELECT * FROM USER_SEQUENCES;

-- 사용자가 만든 인덱스 정보 : USER_INDEXES
SELECT * FROM USER_INDEXES;

-- 사용자가 만든 뷰 정보 : USER_VIEWS
SELECT * FROM USER_VIEWS;

-- 현재 사용자가 접근할 수 있는 모든 테이블 정보 : ALL_TABLES
SELECT * FROM ALL_TABLES;

-- DBA(데이터베이스 관리자)가 접근할 수 있는 테이블 조회 : DBA_TABLES
SELECT * FROM DBA_TABLES;  -- system 계정으로 로그온해서 조회함


-- INSERT INTO 문
-- 테이블에 새로운 행을 추가하면서, 행의 갯수를 늘림

CREATE TABLE DEPT (
  DEPTID CHAR(2),
  DEPTNAME VARCHAR2(20)
);

SELECT COUNT(*) FROM DEPT;

INSERT INTO DEPT
VALUES ('10', '회계팀');

SELECT COUNT(*) FROM DEPT;

INSERT INTO DEPT
VALUES ('20', '인사팀');

SELECT COUNT(*) FROM DEPT;

COMMIT;

-- EMPLOYEE 테이블에 새로운 행 추가시 : 새 직원 정보 입력
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME, EMAIL, PHONE, 
                        HIRE_DATE, JOB_ID, SALARY, BONUS_PCT, 
                        MARRIAGE, MGR_ID, DEPT_ID)
VALUES ('900', '811126-1484710', '오윤하', 'oyuh@KH.org', '01012345678', 
          '06/01/01', 'J7', 3000000, 0, 'N', '176', '90');
        
SELECT * FROM EMPLOYEE
WHERE EMP_ID = '900';

ROLLBACK;  -- INSERT 취소

-- INSERT 시 컬럼명을 생략하고 값 추가시에는 반드시
-- 테이블 생성시 컬럼 생성 순서에 맞추어서 값 기록해야 함
INSERT INTO EMPLOYEE 
VALUES ('910', '이병언', '781010-1443269', 'TK1@VCC.COM', '01077886655', 
         '04/01/01', 'J7', 3500000, 0.1, 'N','176', '90');

SELECT * FROM EMPLOYEE;

-- INSERT 시 컬럼의 값을 NULL 처리하고자 할 경우
-- 기록할 컬럼명을 제외시키는 방법이 있고,
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME, PHONE, HIRE_DATE,
                        JOB_ID, SALARY, BONUS_PCT, MARRIAGE)
VALUES ('880', '860412-2377610', '한채연', '0193382662', '06/01/01', 'J7', 
          3000000, 0, 'N');

SELECT * FROM EMPLOYEE
WHERE EMP_ID = '880';

-- 컬럼 값에 NULL 을 명시할 수 있다.
INSERT INTO EMPLOYEE VALUES
('840', '하지언', '870115-2253408', 'ju_ha@vcc.com', NULL, '07/06/15',
'J7', NULL, NULL, 'N', '', '');  -- '' 도 NULL 임.

SELECT * FROM EMPLOYEE
WHERE EMP_ID = '840';

-- INSERT 시 DEFAULT 키워드 사용할 수 있음
-- DEFAULT 가 설정된 컬럼일 때는 지정한 DEFAULT 값이 기록에 사용됨
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME, SALARY, MARRIAGE)
VALUES ('860', '810429-2165344', '선예진', DEFAULT, DEFAULT);
-- DEFAULT 가 설정되지 않은 컬럼일 경우에는 NULL 처리됨.

SELECT * FROM EMPLOYEE
WHERE EMP_ID = '860';


-- 서브쿼리를 이용해서 INSERT 할 수도 있음
-- VALUES 키워드를 사용하지 않고 서브쿼리 작성함
CREATE TABLE EMP (
  EMP_ID CHAR(3),
  EMP_NAME VARCHAR2(20),
  DEPT_NAME VARCHAR2(20)
);

INSERT INTO EMP
(SELECT EMP_ID, EMP_NAME, DEPT_NAME
 FROM EMPLOYEE
 LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID) );

SELECT * FROM EMP;

-- INSERT 시에 각 컬럼별 제약조건에 위배되지 않는 값만 기록할 수 있다.
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, MARRIAGE, JOB_ID, 
                        DEPT_ID)
VALUES ('777', '이영희', '770130-2123456', 'N', 'J7', '30');                        

ROLLBACK;

-- 기존의 테이블 복사
CREATE TABLE DEPTCPY
AS
SELECT * FROM DEPARTMENT;

SELECT * FROM DEPTCPY;

-- 또는
-- 기존 테이블의 구조만 복사함
CREATE TABLE DEPTCPY2
AS
SELECT * FROM DEPARTMENT
WHERE 1 = 0;


SELECT * FROM DEPTCPY2;

-- INSERT 문에 서브쿼리 사용
INSERT INTO DEPTCPY2
(SELECT * FROM DEPARTMENT);


-- UPDATE 문 ***************************************
/*
  UPDATE 테이블명
  SET 컬럼명 = 바꿀값, 컬럼명 = 바꿀값, ....
  WHERE 컬럼명 비교연산자 비교값;
*/

SELECT * FROM DEPTCPY;

-- 본사 인사팀을 인사팀으로 수정하려면
UPDATE DEPTCPY
SET DEPT_NAME = '인사팀';
-- WHERE 절이 생략되면 해당 컬럼의 값이 모두 변경됨

ROLLBACK;  -- 방금 실행한 DML 구문 실행 취소시킴

-- WHERE 절 사용시
UPDATE DEPTCPY
SET DEPT_NAME = '인사팀'
WHERE DEPT_ID = '10';

SELECT * FROM DEPTCPY;


-- UPDATE 문에 서브쿼리 사용할 수 있음
-- SET 절에서는 바꿀값 자리에 사용할 수 있음
-- WHERE 절에서는 비교값 자리에 사용할 수 있음

-- 심하균 직원의 직급코드와 급여를 성해교 직원의 직급코드와 급여와 같은 값으로 수정하시오.
-- 성해교의 직급코드와 급여 조회
SELECT JOB_ID, SALARY
FROM EMPLOYEE
--WHERE EMP_NAME = '성해교';
WHERE EMP_NAME = '심하균';


UPDATE EMPLOYEE
SET JOB_ID = (SELECT JOB_ID FROM EMPLOYEE
              WHERE EMP_NAME = '성해교'),
    SALARY = (SELECT SALARY FROM EMPLOYEE
              WHERE EMP_NAME = '성해교')
WHERE EMP_NAME = '심하균';    

ROLLBACK;

-- 다중열 서브쿼리로 바꾼다면
UPDATE EMPLOYEE
SET (JOB_ID, SALARY) = (SELECT JOB_ID, SALARY
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '성해교')
WHERE EMP_NAME = '심하균';


SELECT EMP_NAME, JOB_ID, SALARY
FROM EMPLOYEE
WHERE EMP_NAME IN ('심하균', '성해교');

-- 값 변경시 DEFAULT 키워드를 바꿀 값으로 사용해도 됨
SELECT EMP_NAME, MARRIAGE
FROM EMPLOYEE
WHERE EMP_ID = '210';

UPDATE EMPLOYEE
SET MARRIAGE = DEFAULT
WHERE EMP_ID = '210';

ROLLBACK;

-- UPDATE 문 WHERE 절에도 서브쿼리 사용할 수 있음

-- 해외영업2팀 직원들의 보너스포인터를 모두 0.3으로 변경하시오.
-- 확인
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM DEPARTMENT
                  WHERE DEPT_NAME = '해외영업2팀');

UPDATE EMPLOYEE
SET BONUS_PCT = 0.3
WHERE DEPT_ID = (SELECT DEPT_ID
                  FROM DEPARTMENT
                  WHERE DEPT_NAME = '해외영업2팀');


-- DELETE 문 ****************************************
-- 테이블의 한 행을 삭제하는 구문
-- 테이블 전체 행수가 줄어듬
/*
  DELETE FROM 테이블명
  WHERE 컬럼명 비교연산자 비교값;
*/

-- WHERE 절이 생략되면 테이블의 모든 행이 삭제됨
SELECT * FROM DEPTCPY;

DELETE FROM DEPTCPY;

ROLLBACK;  -- DELETE 는 복구할 수 있음

-- WHERE 절 사용
DELETE DEPTCPY
WHERE DEPT_ID = '30';


DELETE FROM DEPARTMENT
WHERE DEPT_ID = '90';
-- FOREIGN KEY 제약조건으로 연결되어 있는 컬럼의 값은 삭제할 수 없음
-- 참조하고 있는 컬럼에서 사용중인 값은 삭제 못 함

-- 사용되지 않는 값은 삭제해도 됨
DELETE FROM DEPARTMENT
WHERE DEPT_ID = '30';

ROLLBACK;

-- TRUNCATE 문 
-- 테이블의 모든 행을 삭제할 때 사용할 수 있음. 속도가 빠름
-- 복구 불가능, 제약조건이 있으면 삭제 못 함
TRUNCATE TABLE DEPARTMENT;

TRUNCATE TABLE DEPTCPY;
SELECT * FROM DEPTCPY;
ROLLBACK;

-- FOREIGN KEY 제약조건으로 연결된 부모키와 자식 레코드의 관계
-- 값을 사용하는 자식 레코드가 존재하면, 해당 값에 대한 부모키는 삭제 못함(RESTRICTED)
-- 외래키 제약조건 설정시 삭제룰을 정할 수 있음.
-- CONSTRAINT 이름 FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명 ON DELETE 삭제옵션

SELECT EMP_ID, EMP_NAME, MGR_ID
FROM EMPLOYEE
WHERE MGR_ID = '141';

DELETE FROM EMPLOYEE
WHERE EMP_ID = '141';

-- 기존의 설정된 외래키의 삭제룰을 변경하려면
-- 1. 기존의 설정된 외래키 제약조건을 제거함
-- 기존 테이블의 내용을 수정하려면, ALTER 문 사용함
ALTER TABLE EMPLOYEE
DROP CONSTRAINTS FK_MGRID;

-- 2. 테이블에 새로운 제약조건을 추가함
ALTER TABLE EMPLOYEE
ADD CONSTRAINTS FK_MGRID FOREIGN KEY (MGR_ID)
REFERENCES EMPLOYEE ON DELETE SET NULL;

-- SET NULL : 부모키 제거시 자식 레코드가 널이 됨
SELECT EMP_ID, EMP_NAME, MGR_ID
FROM EMPLOYEE
WHERE MGR_ID = '141';

DELETE FROM EMPLOYEE
WHERE EMP_ID = '141';

SELECT EMP_ID, EMP_NAME, MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NULL;

ROLLBACK;


-- CASCADE : 부모키 삭제시 자식레코드 행 전체가 같이 삭제됨
SELECT * FROM JOB;

DELETE FROM JOB
WHERE JOB_ID = 'J2';

SELECT * FROM EMPLOYEE
WHERE JOB_ID = 'J2';

-- 1.
ALTER TABLE EMPLOYEE 
DROP CONSTRAINTS FK_JOBID;

ALTER TABLE EMPLOYEE
ADD CONSTRAINTS FK_JOBID FOREIGN KEY (JOB_ID) 
REFERENCES JOB ON DELETE CASCADE;

SELECT * FROM JOB;

DELETE FROM JOB
WHERE JOB_ID = 'J2';

SELECT * FROM EMPLOYEE
WHERE JOB_ID IS NULL;

SELECT * FROM EMPLOYEE;

ROLLBACK;   -- 삭제 취소

-- 여러 개의 테이블에 한번에 INSERT 하기
-- 1. 빈 테이블 만들기
CREATE TABLE EMP_HIRE
AS
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0;

-- 2. 확인
SELECT * FROM EMP_HIRE;

-- 3. 부서코드가 '20'인 행의 데이터만 복사해 넣음
INSERT INTO EMP_HIRE
(SELECT EMP_ID, EMP_NAME, HIRE_DATE
 FROM EMPLOYEE
 WHERE DEPT_ID = '20');

-- 4. 확인
SELECT * FROM EMP_HIRE;

ROLLBACK; -- INSERT 취소, 빈 테이블 상태

-- 5. 두번째 빈 테이블 만들기
CREATE TABLE EMP_MGR
AS
SELECT EMP_ID, EMP_NAME, MGR_ID
FROM EMPLOYEE
WHERE 1 = 0;

SELECT * FROM EMP_MGR;

-- 부서코드 '20'인 직원 정보 복사해 넣음
INSERT INTO EMP_MGR
(SELECT EMP_ID, EMP_NAME, MGR_ID
 FROM EMPLOYEE
 WHERE DEPT_ID = '20');

SELECT * FROM EMP_MGR;

ROLLBACK;  -- INSERT 취소, 빈 테이블 상태

-- 두 개의 조건이 같고, 서브쿼리가 참조하는 테이블이 같다면
-- 한번에 두 개의 테이블에 INSERT 할 수 있음.
INSERT ALL
INTO EMP_HIRE VALUES (EMP_ID, EMP_NAME, HIRE_DATE)
INTO EMP_MGR VALUES (EMP_ID, EMP_NAME, MGR_ID)
(SELECT EMP_ID, EMP_NAME, HIRE_DATE, MGR_ID
 FROM EMPLOYEE
 WHERE DEPT_ID = '20');

SELECT * FROM EMP_HIRE;
SELECT * FROM EMP_MGR;

-- 조건을 만족하는 경우에만 INSERT ALL 되게 처리하려면
-- 1. 빈 테이블 만들기
CREATE TABLE EMP_HIRE2
AS
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0;

-- 2. 확인
SELECT * FROM EMP_HIRE2;

-- 3. 두번째 빈 테이블 만들기
CREATE TABLE EMP_SAL
AS
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE 1 = 0;

-- 4. 확인
SELECT * FROM EMP_SAL;

-- 5. 조건에 따른 INSERT ALL 처리
INSERT ALL
WHEN HIRE_DATE > TO_DATE('2000/01/01', 'RRRR/MM/DD') THEN
    INTO EMP_HIRE2 VALUES (EMP_ID, EMP_NAME, HIRE_DATE)
WHEN SALARY > 2500000 THEN
    INTO EMP_SAL VALUES (EMP_ID, EMP_NAME, SALARY)
(SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
 FROM EMPLOYEE);    

-- 확인
SELECT * FROM EMP_HIRE2;
SELECT * FROM EMP_SAL;

-- MERGE : 두 테이블을 비교해서 지정하는 조건의 값이 존재하면 UPDATE 가
--        존재하지 않으면 INSERT 가 작동되게 하는 구문

-- 1. EMPLOYEE 테이블 전체 복사함
CREATE TABLE EMPCPY
AS
SELECT * FROM EMPLOYEE;

SELECT * FROM EMPCPY;

-- 2. 직급이 'J7'인 직원들의 정보만 복사한 테이블 만들기
CREATE TABLE EMP_J7
AS
SELECT * FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT * FROM EMP_J7;

-- 3. MERGE 에서 기존 데이터가 UPDATE 되는지 확인하기 위해 'J7'을 'J1'로 바꿈
UPDATE EMP_J7
SET JOB_ID = 'J1';

-- 4. 없는 정보는 INSERT 되는지 확인하기 위해 새로운 행 추가함
INSERT INTO EMP_J7
VALUES ('999', '이순신', '751122-1234567', NULL, NULL, SYSDATE, NULL,
            3333330, 0.2, 'Y', NULL, NULL);
            
-- 5. 두 테이블을 합쳐봄
MERGE INTO EMPCPY
USING EMP_J7 ON (EMPCPY.EMP_ID = EMP_J7.EMP_ID)
WHEN MATCHED THEN
  UPDATE SET EMPCPY.JOB_ID = EMP_J7.JOB_ID              
WHEN NOT MATCHED THEN
 INSERT VALUES (EMP_J7.EMP_ID, 
                EMP_J7.EMP_NAME,
                EMP_J7.EMP_NO,
                EMP_J7.EMAIL,
                EMP_J7.PHONE,
                EMP_J7.HIRE_DATE,
                EMP_J7.JOB_ID,
                EMP_J7.SALARY,
                EMP_J7.BONUS_PCT,
                EMP_J7.MGR_ID,               
                EMP_J7.DEPT_ID);
 
SELECT * FROM EMPCPY; 

