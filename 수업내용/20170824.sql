/*
DAY 12 SEQUENCE
*/
/*
-- 시퀀스 생성 Syntax
CREATE SEQUENCE sequence_name
    [START WITH n]
    [INCREMENT BY n]
    [MAXVALUE n | NOMAXVALUE]
    [MINVALUE n | NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE | NOCACHE]
    
-- 시퀀스 수정 Syntax
ALTER SEQUENCE sequence_name
    [INCREMENT BY n]
    [MAXVALUE n | NOMAXVALUE]
    [MINVALUE n | NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE | NOCACHE]
*/


CREATE SEQUENCE SEQ_EMPLOYEE
START WITH 0
INCREMENT BY 1
MAXVALUE 100000
MINVALUE 0
CYCLE
NOCACHE;

SELECT SEQ_EMPLOYEE.NEXTVAL FROM DUAL;
SELECT SEQ_EMPLOYEE.CURRVAL FROM DUAL;

SELECT * FROM SYS.USER_SEQUENCES;

--
CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

--
CREATE SEQUENCE SEQID
INCREMENT BY 1
START WITH 300
MAXVALUE 310
NOCYCLE NOCACHE;

--
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL),
'850130-1558215', '김영민');
INSERT INTO EMPLOYEE (EMP_ID, EMP_NO, EMP_NAME)
VALUES (TO_CHAR(SEQID.NEXTVAL),
'840221-1361299', '구진표');
SELECT EMP_ID, EMP_NO, EMP_NAME
FROM EMPLOYEE
ORDER BY 1 DESC;


--

DROP SEQUENCE SEQID2;
CREATE SEQUENCE SEQID2
INCREMENT BY 1
START WITH 300
MAXVALUE 310
NOCYCLE NOCACHE;
SELECT SEQID2.NEXTVAL FROM DUAL;
SELECT SEQID2.NEXTVAL FROM DUAL;
ALTER SEQUENCE SEQID2
INCREMENT BY 5;
SELECT SEQID2.NEXTVAL FROM DUAL;

--
CREATE SEQUENCE SEQ1
INCREMENT BY 1
START WITH 1
NOCACHE;
SELECT SEQ1.NEXTVAL FROM DUAL;
SELECT SEQ1.CURRVAL FROM DUAL;

--
CREATE SEQUENCE SEQ2
INCREMENT BY 1
START WITH 1
CACHE 5;
SELECT SEQ2.NEXTVAL FROM DUAL;
SELECT SEQ2.CURRVAL FROM DUAL;

SELECT SEQUENCE_NAME,
CACHE_SIZE,
LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME IN ('SEQ1','SEQ2'); 

--
DROP SEQUENCE [SEQUENCE_NAME];

/*
인덱스
: 원하는 내용을 빠르게 찾기 위한 목적으로 사용

인덱스 사용 시 고려 사항

 인덱스 특징
 테이블과 연관되지만 독립적인 객체
 자동적으로 사용되고 관리됨
 DISK I/O를 줄임으로써 검색 속도를 향상시킬 수 있음

 인덱스를 사용하는 것이 효율적인 경우
 WHERE 젃이나 JOIN 조건에 주로 사용되는 컬럼
 UNIQUE 속성의 컬럼이나 NULL이 맋이 포함된 컬럼
 넓은 범위의 값이 포함된 컬럼

 인덱스를 사용하지 않는 것이 더 효율적인 경우
 테이블이 작은 경우(데이터가 적은 경우)
 테이블 갱싞이 자주 발생하는 경우
 다량의 데이터가 조회되는 경우

인덱스 유형
인덱스를 생성하는 대상 컬럼에 따라 Unique Index, Nonunique Index로 구분
 Unique Index
 Unique Index가 생성된 컬럼에는 중복 값이 포함될 수 없음
 오라클은 'PRIMARY KEY' 제약조건을 생성하면 자동으로 해당 컬럼에 Unique Index를 생성
 PRIMARY KEY를 이용하여 access 하는 경우 성능 향상 효과 있음
 Nonunique Index
 빈번하게 사용되는 일반 컬럼을 대상으로 생성함
 주로 성능 향상을 위한 목적으로 생성
*/

CREATE UNIQUE INDEX IDX_DNM ON DEPARTMENT(DEPT_NAME);
CREATE INDEX IDX_JID ON EMPLOYEE (JOB_ID);
CREATE UNIQUE INDEX IDX_ENM ON EMPLOYEE(EMP_NAME);
COMMIT;

SELECT INDEX_NAME, COLUMN_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES
JOIN USER_IND_COLUMNS USING (INDEX_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMPLOYEE';

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = '141';
SELECT EMP_NAME
FROM EMPLOYEE2
WHERE EMP_ID = '141';
--데이터 입력,갱신,삭제 시 인덱스효율은 떨어짐

--테이블을 삭제하면 관련 인덱스도 같이 삭제 됨

--인덱스 삭제
DROP INDEX [INDEX_NAME];


--결합 인덱스
--함수 기반 인덱스
--http://sungwoon.tistory.com/34

/****************************************************************
사용자 관리
사용자 계정과 암호 설정, 권한 부여

오라클 데이터베이스를 설치하면, 기본적으로 제공되는 계정은 
-SYS : XE MODULE에서는 접근 못 함
-SYSTEM : XE MODULE에서 접근 가능함 관리자계정
-SCOTT : 교육용 샘플계정임, XE에서는 제공안됨
-HR : 샘플계정임, 처음에는 LOCK 설정되어있음

보안을 위한 데이터베이스 관리자(DBA)
일반 사용자가 데이터베이스 객체(테이블, 뷰 등)에 대해 특정권한을 가질 수 있게 관리해야함
다수의 사용자가 공유하는 데이터베이스 정보에 대한 보안설정함

데이터베이스에서 접근하는 사용자 마다 서로 다른 권한과 롤을 부여함

권한 :  사용자가 테이블에 접근할 수 있도록 하거나 
          해당 테이블에 쿼리문을 사용할수 있도록 제한을 두는것
          
시스템권한 : 데이터베이스 관리자가 가지고 있는 권한
CREATE USER - 사용자 계정 만드는 것
DROP USER - 사용자 계정 삭제하는 것
DROP TABLE - 임의의 테이블 삭제
QUERY REWRITE - 함수 기반 인덱스 생성
BACKUP ANY TABLE - 테이블 백업

시스템 관리자가 사용자에게 부여하는 권한
CREATE SESSION - 데이터베이스에 접속
CREATE TABLE - 테이블 생성
CREATE VIEW - 뷰 생성
CREATE SEQUENCE - 시퀀스 생성
CREATE PROCEDURE - 프로시져 생성

객체 권한 : 객체를 조작할 수 있는 권한

사용자 계정 생성 *********************************************************
데이터베이스에 접근할 수 있는 아이디와 암호 만들기
/*
  CREATE USER [USER_ID] IDENTIFIED BY [USER_PW];
*/
CREATE USER manager IDENTIFIED BY manager;
--권한 부여 하기
--GRANT 권한종류 TO [USER_ID] [WITH ADMIN OPTION];
--사용자이름 (아이디) 대신 PUBLIC을 기술하면 모든 사용자에게 해당 권한을 부여하게됨
SHOW USER;
GRANT CREATE SESSION TO manager;
CONN manager/manager;


CREATE SYNONYM EP FOR EMPLOYEE;

select * from system.ep;