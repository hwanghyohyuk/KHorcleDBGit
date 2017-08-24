-- DAY12 수업내용

-- *********************************************
-- 시퀀스(SEQUENCE) 
-- 자동 번호 발생기
-- 순차적으로 정수 값을 자동으로 생성하는 객체

/*
   형식
   CREATE SEQUENCE sequence_name
   [ INCREMENT BY N] 
   [ START WITH N]
   [ {MAXVALUE N | NOMAXVALUE}] 
   [ {MINVALUE N | NOMINVALUE} ]
   [ {CYCLE | NOCYCLE} ] 
   [ { CACHE N| NOCACHE} ] ;
   
* INCREMENT BY N
  : 시퀀스 번호 증가 / 감소 간격(N은 정수,기본값 1)
  
* START WITH N
 : 시퀀스 시작번호(N은 정수,기본값 1)

* MAXVALUE / NOMAXVALUE,
  MINVALUE / NOMINVALUE
 - MAXVALUE N : 시퀀스의 최대값 임의 지정(N은 정수)
 - NOMAXVALUE : 표현 가능한 최대값
              (오름차순 : 1027, 내림차순 : -1)까지 생성
 - MINVALUE N : 시퀀스의 최소값 임의 지정(N은 정수)
 - NOMINVALUE : 표현 가능한 최소값
              (오름차순 : 1, 내림차순 : -1026)까지 생성
              
* CYCLE / NOCYCLE
  : 최대 / 최소값 도달시 반복여부 결정
  
* CACHE / NOCACHE
  : 지정한 수량만큼 미리 메모리에 생성여부 결정
  (최소값 2,기본값 20)
   
*/

-- 시퀀스 만들기 1
CREATE SEQUENCE SEQ_EMPID
START WITH 300  -- 초기값 : 300부터 시작
INCREMENT BY 5  -- 증가값 : 5씩 증가
MAXVALUE 310    -- 310까지 생성
NOCYCLE         -- (310)까지 생성후 더 이상 생성안됨
NOCACHE;        -- 미리 메모리에 생성하지 않음


-- 시퀀스 사용
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- MAXVALUE 값에 도달했고 NOCYCLE 이기 때문에
-- 4회 사용시 에러 발생

-- 시퀀스의 현재 값 확인
SELECT SEQ_EMPID.CURRVAL FROM DUAL;

-- 데이터 딕셔너리에 기록 저장됨
DESC USER_SEQUENCES;

-- 데이터 딕셔너리에서 해당 시퀀스 정보 확인
SELECT SEQUENCE_NAME, CACHE_SIZE, LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME IN ('SEQ_EMPID', 'SEQ2_EMPID');
-- LAST_NUMBER 값은 
-- CACHE 미사용 : 새로 반환될 시퀀스값
-- CACHE 사용 : CACHE로 생성된 이후 시퀀스값
--           (메모리에 생성된 시퀀스도 사용된 것으로 간주함)

-- 시퀀스 만들기 2
CREATE SEQUENCE SEQ2_EMPID
START WITH 5    -- 초기값 : 5부터 시작
INCREMENT BY 5  -- 증가값 : 5씩 증가
MAXVALUE 15     -- 15까지 생성
CYCLE           -- (15)까지 생성후 1부터 5씩 증가하여
                -- MAXVALUE 범위 안에서 반복 생성됨
NOCACHE;        -- 미리 메모리에 생성하지 않음

-- 사용
SELECT SEQ2_EMPID.NEXTVAL FROM DUAL;
-- 4회 사용부터 1, 6, 11이 반복적으로 생성됨

-- 시퀀스 값 발생, 조회방법 ***************************
-- NEXTVAL 속성
-- 새로운 시퀀스 값을 반환홖
-- 'sequence_name.NEXTVAL' 형태로 사용

-- CURRVAL 속성
-- 현재 시퀀스 값을 반환 
-- (NEXTVAL 속성에 의해 가장 마지막으로 반환된 시퀀스값)
-- 'sequence_name.CURRVAL' 형태로 사용
-- 처음에 NEXTVAL 속성이 먼저 실행되어야 사용가능

CREATE SEQUENCE SEQ3_EMPID
INCREMENT BY 5
START WITH 300
MAXVALUE 310
NOCYCLE
NOCACHE;

-- 시퀀스이름.NEXTVAL 사용 전에 CURRVAL 사용할 수 없음
SELECT SEQ3_EMPID.CURRVAL FROM DUAL;

-- 반드시 시퀀스 객체 생성후 NEXTVAL 사용 후에 CURRVAL 사용할 수 있음
SELECT SEQ3_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ3_EMPID.CURRVAL FROM DUAL;

-- 시퀀스 객체의 실제 사용 
CREATE SEQUENCE SEQID
INCREMENT BY 1
START WITH 300
MAXVALUE 310
NOCYCLE NOCACHE;

INSERT INTO EMPLOYEE 
       (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL),
                '850130-1558215', '김영민');
-- 시퀀스 값을 사용하려는 EMP_ID 컬럼 타입이 
-- CHAR 타입이기 때문에 TO_CHAR 함수를 사용하여
-- 타입을 변환하였음
       
INSERT INTO EMPLOYEE 
       (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL),
                '840221-1361299', '구진표');   
    
SELECT EMP_ID, EMP_NO, EMP_NAME
FROM EMPLOYEE
ORDER BY 1 DESC;

-- 시퀀스 사용 안 할 경우 서브쿼리 사용할 수 있음
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO)
VALUES ((SELECT MAX(EMP_ID) + 1 FROM EMPLOYEE), 
         '홍길순', '881225-2123456');


-- 시퀀스 수정 
/*
시퀀스 수정 구문

ALTER SEQUENCE sequence_name
[ INCREMENT BY N]
[ {MAXVALUE N | NOMAXVALUE}] 
[ {MINVALUE N | NOMINVALUE} ]
[ {CYCLE | NOCYCLE} ] 
[ { CACHE N| NOCACHE} ] ;

 * START WITH 값은 수정 불가
 * 시작값을 변경하려면 삭제후 새로 생성
 * 한번도 사용하지 않은 경우에도 수정 불가
 * 변경된 값은 이후 시퀀스부터 적용

*/

-- 시퀀스 수정 예
CREATE SEQUENCE SEQID2
INCREMENT BY 1
START WITH 300
MAXVALUE 310
NOCYCLE NOCACHE;

SELECT SEQID2.NEXTVAL FROM DUAL;
SELECT SEQID2.NEXTVAL FROM DUAL;

ALTER SEQUENCE SEQID2
INCREMENT BY 5;
-- 수정 확인
SELECT SEQID2.NEXTVAL FROM DUAL;


-- 시퀀스 삭제 구문
-- DROP SEQUENCE sequence_name;
DROP SEQUENCE SEQID2;


-- 시퀀스 객체 생성시 CACHE 사용 여부에 따라 LAST_NUMBER 가 다름
CREATE SEQUENCE SEQ1
INCREMENT BY 1
START WITH 1
NOCACHE;

SELECT SEQ1.NEXTVAL FROM DUAL;
SELECT SEQ1.CURRVAL FROM DUAL;

CREATE SEQUENCE SEQ2
INCREMENT BY 1
START WITH 1
CACHE 5;  -- 값 5개를 메모리에 미리 저장해 둔다는 의미임

SELECT SEQ2.NEXTVAL FROM DUAL;
SELECT SEQ2.CURRVAL FROM DUAL;

-- 데이터 딕셔너리를 통해 LAST_NUMBER 확인
SELECT SEQUENCE_NAME,
CACHE_SIZE,
LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME IN ('SEQ1','SEQ2'); 



-- **************************************************************
-- 인덱스(INDEX)
-- SQL 명령문의 처리 속도를 향상시키기 위해서 컬럼에 대해서 생성하는 오라클 객체임
-- 인덱스 내부 구조는 B* 트리(이진탐색트리) 형식으로 구성되어 있음
-- 컬럼에 인덱스를 설정하면 이에 대한 이진 트리도 같이 생성되어야 하기 때문에
-- 인덱스를 생성하기 위한 시간도 필요하고, 인덱스를 위한 추가 저장공간이 필요함
-- 반드시 좋은 것은 아님
-- 인덱스 생성 후에 DML 작업을 수행하면, 인덱스가 사용한 컬럼값이 변경되므로
-- 이진트리 내부 구조도 함께 수정되므로, DML 작업이 훨씬 무거워짐

-- 장점
-- 검색 속도가 빨라짐
-- 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킴
-- 단점
-- 인덱스를 위한 추가적인 공간이 필요함
-- 인덱스를 생성하는 데 시간이 걸림
-- 데이터 변경 작업 (INSERT/UPDATE/DELETE)이 자주 일어날 경우 성능이 저하됨


-- 인덱스의 구조
-- 정렬된 컬럼값(KEY)과 해당 컬럼값이 기록된 행위치(ROWID)로 구성
-- 키워드와 해당 내용의 위치가 정렬된 상태로 구성됨

-- 인덱스의 종류
-- 1. 고유 인덱스(UNIQUE INDEX)
-- 2. 비고유 인덱스(NONUNIQUE INDEX)
-- 3. 단일 인덱스(SINGLE INDEX)
-- 4. 결합 인덱스(COMPOSITE INDEX)
-- 5. 함수 기반 인덱스(FUNCTION BASED INDEX)

-- 인덱스를 생성하는 대상 컬럼에 따라 UNIQUE INDEX, NONUNIQUE INDEX 로 구분됨

-- UNIQUE INDEX
-- UNIQUE INDEX 가 적용된 컬럼에는 같은 값 두번 기록 못함
-- 오라클은 PRIMARY KEY 제약조건을 컬럼에 적용하면, 자동으로 해당 컬럼에
-- UNIQUE INDEX 생성함
-- 테이블에 PRIMARY KEY 를 설정하면 검색 속도가 빨라지게 됨

CREATE UNIQUE INDEX IDX_DNM
ON DEPARTMENT (DEPT_NAME);

-- NONUNIQUE INDEX 
-- 빈번하게 사용되는 일반 컬럼에 적용할 때 사용
-- 주로 성능 향상을 위한 목적으로 생성함
CREATE INDEX IDX_JID
ON EMPLOYEE (JOB_ID);


-- 인덱스 생성 실습 -------------------------------------------

-- 1. EMPLOYEE 테이블의 EMP_NAME 컬럼에
--    'IDX_ENM' 이름의 Unique Index를 생성하시오.

CREATE UNIQUE INDEX IDX_ENM 
ON EMPLOYEE(EMP_NAME);

-- 2. 다음과 같이 새로운 데이터를 입력해 보고,
-- 오류 원인을 생각해 보시오.
INSERT INTO EMPLOYEE 
       (EMP_ID, EMP_NO, EMP_NAME)
VALUES ('400', '871120-1243877', '감우섭');

-- EMP_NAME 컬럼에 이미 '감우섭' 이름의 데이터가
-- 존재하기 때문에 중복되는 값은 입력될 수 없음
-- Unique Index는 UNIQUE 제약조건의 기능을 수행

-- 3. EMPLOYEE 테이블의 DEPT_ID 컬럼에
-- 'IDX_DID' 이름의 Unique Index를 생성해 보고
-- 오류 원인을 생각해 보시오.
CREATE UNIQUE INDEX IDX_DID 
ON EMPLOYEE(DEPT_ID);
-- 같은 값들이 여러 번 사용되고 있는 컬럼이므로
-- UNIQUE INDEX 생성 못 함.

-- 인덱스 삭제
-- 테이블을 삭제하면 관련된 인덱스도 같이 삭제됨
DROP INDEX IDX_JID;

-- 데이터 딕셔너리에서 인덱스 정보 확인
DESC USER_INDEXES;
DESC USER_IND_COLUMNS;

-- EMPLOYEE 테이블에 생성된 인덱스 현황 조회
SELECT INDEX_NAME, COLUMN_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES
JOIN USER_IND_COLUMNS USING (INDEX_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMPLOYEE';

-- 검색 속도 비교해 보기
-- 1. EMPLOYEE 테이블의 모든 정보를 서브쿼리로 복사한 EMPL01, EMPL02 테이블 만듦
CREATE TABLE EMPL01
AS SELECT * FROM EMPLOYEE;

CREATE TABLE EMPL02
AS SELECT * FROM EMPLOYEE;

-- 2. EMPL01 테이블의 EMP_ID 컬럼에 대해 UNIQUE INDEX 만들기 : IDX_EID
CREATE UNIQUE INDEX IDX_EID
ON EMPL01 (EMP_ID);

-- 3. 검색 속도 비교 조회함 : 두 테이블에 대해 각각 조회 테스트함
-- EMP_ID 를 가지고 직원 정보 조회함 : 속도 확인
SELECT * FROM EMPL01
WHERE EMP_ID = '141';

SELECT * FROM EMPL02
WHERE EMP_ID = '141';

-- 결합 인덱스
-- 한 개의 컬럼으로 생성되는 인덱스 == 단일(SINGLE) 인덱스
-- 결합 인덱스는 두 개이상의 컬럼을 조합해서 인덱스를 생성한 것
CREATE TABLE DEPT01
AS SELECT * FROM DEPARTMENT;

-- 부서코드와 부서명을 결합하여 인덱스 만들기
CREATE INDEX IDX_DEPT01_COMP
ON DEPT01 (DEPT_ID, DEPT_NAME);

-- 데이터 딕셔너리에서 확인해 봄
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'DEPT01';


-- 함수 기반 인덱스
-- SELECT 절이나 WHERE 절에 산술계산식이나 함수식이 사용된 경우
-- 계산식은 인덱스 만들기에 사용될 수 없음
-- 함수식은 인덱스 만들기에 사용될 수 있음
CREATE TABLE EMP01
AS SELECT * FROM EMPLOYEE;

CREATE INDEX IDX_EMP01_SALCALC
ON EMP01 ((SALARY + (SALARY * NVL(BONUS_PCT, 0)) * 12));

SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP01';


-- ******************************************************************
-- 사용자(USER) 관리
-- 사용자 계정(아이디)과 암호 설정, 권한 부여

-- 오라클 데이터베이스를 설치하면, 기본적으로 제공되는 계정은
-- SYS : XE 모듈에서는 접근 못 함, 관리자 계정
-- SYSTEM : XE 모듈에서 접근 가능함, 관리자 계정
-- SCOTT : 교육용 샘플 계정임. XE에서는 제공안됨
-- HR : 샘플 계정임. 처음에는 잠겨있음(LOCK)

-- 보안을 위한 데이터베이스 관리자(DBA)
-- 사용자가 데이터베이스 객체(테이블, 뷰 등)에 대해 특정 권한을 가질 수 있게 관리해야 함
-- 다수의 사용자가 공유하는 데이터베이스 정보에 대한 보안 설정함
-- 데이터베이스에 접근하는 사용자마다 서로 다른 권한과 롤을 부여함

-- 권한 : 사용자가 테이블에 접근할 수 있도록 하거나
--     해당 테이블에 SQL(SELECT/INSERT/UPDATE/DELETE)문을 사용할 수 있도록
--     제한을 두는 것

-- 시스템 권한 : 데이터베이스 관리자가 가지고 있는 권한
--   CREATE USER (사용자 계정 만들기)
--   DROP USER (사용자 계정 삭제)
--   DROP TABLE (임의의 테이블 삭제)
--   QUERY REWRITE (함수 기반 인덱스 생성)
--   BACKUP ANY TABLE (테이블 백업)

-- 시스템 관리자가 사용자에게 부여하는 권한
--  CREATE SESSION (데이터베이스에 접속)
--  CREATE TABLE (테이블 생성)
--  CREATE VIEW (뷰 생성)
--  CREATE SEQUENCE (시퀀스 생성)
--  CREATE PROCEDURE (프로시저 생성)

-- 객체 권한 : 객체를 조작할 수 있는 권한

-- 사용자 계정 생성 ***********************
-- 데이터베이스에 접근할 수 있는 아이디와 암호 만들기
/*
  CREATE USER 아이디 IDENTIFIED BY 암호;
*/

[실습] --------------------------------------------------------------
	1. system 계정으로 로그인
	SQL> CONN system/암호

	2. 로그인된 계정 확인
	SQL> SHOW USER

	3. 새로운 사용자 계정과 암호 만듦
	SQL> CREATE USER USER01 IDENTIFIED BY PASS01;

	4. 사용자 계정으로 로그인해 봄
	SQL> CONN USER01/PASS01
	-- 에러 발생함 : 사용자에게 권한을 부여하지 않았기 때문임.

-- 권한 부여하기 : GRANT 명령어 사용함
/*
  GRANT 권한종류 TO 아이디 [WITH ADMIN OPTION];
  
  사용자이름(아이디) 대신 PUBLIC 을 기술하면 모든 사용자에게 해당 권한을 부여하게 됨
*/
[실습] 로그인 권한 부여하기 -----------------------------------------
	1. system 게정에서
	SQL> GRANT CREATE SESSION TO USER01;

	2. USER01 로그인함
	SQL> CONN USER01/PASS01
	SQL> SHOW USER


	[실습] 테이블 생성 권한 부여하기 ----------------------------------
	1. USER01 계정에서
	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));
	-- 권한 불충분 에러 발생

	2. system 계정으로 로그인함
	SQL> CONN system/암호
	SQL> SHOW USER

	3. CREATE TABLE 권한 부여함
	SQL> GRANT CREATE TABLE TO USER01;

	4. USER01로 로그인 후, 테이블 다시 생성함
	SQL> CONN USER01/PASS01;
	SQL> SHOW USER

	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));

	5. CREATE TABLE 권한을 주었는데도 테이블이 생성되지 않음
	=> 디폴트 테이블스페이스인 USERS 에 쿼터(QUOTA)를 설정하지
	   않았기 때문임.

 - 테이블스페이스(Tablespace)
	: 테이블, 뷰, 그 밖의 데이터베이스 객체들이 저장되는 디스크상의
	장소
	오라클 설치시 scott 계정의 데이터를 저장하기 위한 USERS 라는
	테이블스페이스가 있음.

	[실습] 새로 생성한 USER01 사용자의 테이블스페이스를 확인하려면
	1. system 계정으로 연결된 상태에서
	SQL> CONN system/암호
	SQL> SHOW USER

	SQL> SELECT USERNAME, DEFAULT_TABLESPACE
		FROM DBA_USERS
		WHERE USERNAME = 'USER01';
	-- 테이블스페이스가 USERS 인 것 확인.

	2. 테이블스페이스 쿼터 할당
	: USER01 사용자가 사용할 테이블스페이스 영역을 할당함
	=> QUOTA 절 사용함. ( 10M, 5M, UNLIMITED 등)
	SQL> ALTER USER USER01
		QUOTA 2M ON SYSTEM;

	3. USER01 로 다시 연결함
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	4. 테이블 생성함
	SQL> CREATE TABLE EMP01(
		ENO 	NUMBER(4),
		ENAME 	VARCHAR2(20),
		JOB 	VARCHAR2(10),
		DPTNO 	NUMBER(2));

	5. 테이블 생성 확인함
	SQL> DESC EMP01;


[연습] ----------------------------------------------------------------
	사용자명 : USER007
	암 호 : PASS007
	테이블스페이스 : 3M
	권 한 : DB 연결, 테이블 생성 허용함
	=> 실행 확인해 봄
	------------------------------------------------------------------------

- WITH ADMIN OPTION
	: 사용자에게 시스템 권한을 부여할 때 사용함
	권한을 부여받은 사용자는 다른 사용자에게 권한을 지정할 수 있음
	[형식]
	GRANT CREATE SESSION TO 사용자명
	WITH ADMIN OPTION;

 - 객체 권한 : 테이블이나 뷰, 시퀀스, 함수 등 각 객체별로 DML문을 사용할
	수 있는 권한을 설정하는 것
	[형식]
	GRANT 권한종류 [(컬럼명)] | ALL
	ON 객체명 | ROLE 이름 | PUBLIC
	TO 사용자이름;

	* 권한 종류	설정 객체
	ALTER	:	TABLE, SEQUENCE
	DELETE	:	TABLE, VIEW
	EXECUTE	:	PROCEDURE
	INDEX	:	TABLE
	INSERT	:	TABLE, VIEW
	REFERENCES : 	TABLE
	SELECT	:	TABLE, VIEW, SEQUENCE
	UPDATE	:	TABLE, VIEW


	[실습] -----------------------------------------------------
	: 다른 사용자가 가진 테이블을 조회하고자 한다면
	1. USER01 로 연결
	SQL> CONN USER01/PASS01
	SQL> SHOW USER

	2. USER007 사용자가 USER01이 가진 EMP01 테이블을 
	SELECT 하려면
	SQL> GRANT SELECT 
		ON EMP01
		TO USER007;

	3. USER007 로그인
	SQL> CONN USER007/PASS007
	SQL> SHOW USER

	4. 테이블 접근 확인
	SQL> SELECT * FROM USER01.EMP01;


 - 사용자에게 부여된 권한 조회하기
	: 사용자 권한과 관련된 데이터 딕셔너리

	- 자신에게 부여된 사용자 권한을 알고자 할 때
		* USER_TAB_PRIVS_RECD
	=> SELECT * FROM USER_TAB_PRIVS_RECE;

	- 현재 사용자가 다른 사용자에게 부여한 권한 정보 제공
		* USER_TAB_PRIVS_MADE
	=> SELECT * FROM USER_TAB_PRIVS_MADE;

 - 권한 철회
	: REVOKE 명령어 사용
	[형식]
	REVOKE 권한종류 | ALL
	ON 객체명
	FROM [사용자이름 | ROLE 이름 | PUBLIC];

	[실습] ------------------------------------------------------------
	1. USER01 로그인

	2. 해당 사용자가 설정한 권한 확인
	SQL> SELECT * FROM USER_TAB_PRIVS_MADE;

	3. SELECT 권한 해제함
	SQL> REVOKE SELECT ON EMP01 FROM USER007;

	4. 데이터 딕셔너리에서 삭제 확인함
	SQL> SELECT * FROM USER_TAB_PRIVS_MADE;

 - WITH GRANT OPTION 
	: 사용자가 해당 객체에 접근할 수 있는 권한을 부여 받으면서
	그 권한을 다른 사용자에게 다시 부여할 수 있음

	[실습] -----------------------------------------------------------------
	1. USER01 계정에서
	SQL> GRANT SELECT ON USER01.EMP01 TO USER007
		WITH GRANT OPTION;

	2. USER007 로 로그인
	SQL> GRANT SELECT ON USER01.EMP01 TO STUDENT;
	-- 다른 사용자에게 부여받은 권한을 다시 부여 확인.	











