--DAY10 수업내용 
/*
DDL은 관계 데이터베이스에서 사용될 
테이블, 스키마, 도메인, 인덱스, 뷰 등 을 정의(생성)하거나 수정, 제거하기 위해 사용되는 언어이다.
*/

/*
CREATE

1. CREATE TABLE 테이블_이름
지정한 '테이블_이름'으로 테이블 생성
2. ({속성_이름 데이터_타입 [NOT NULL],}
테이블을 구성하는 속성 수만큼 속성 이름과 데이터 타입 기입
[NOT NULL] : 테이블 생성 시 특정 속성 값에 'NULL' 이 없도록 지정할 때 사용하며 생략가능
3. [PRIMARY KEY(속성_이름),]
테이블에서 기본키 속성을 지정할 때 사용
4. [UNIQUE(속성_이름),]
대체키 지정 시 사용
속성의 모든 값이 소유한 값을 가지도록 지정할 때 사용
5. [FOREIGN KEY(속성_이름) REFERENCES 참조테이블(속성_이름)]
외래키를 지정할 때 사용
FOREIGN KEY(속성_이름) : 외래키로 사용될 속성 이름 기입
찹조 테이블(속성_이름) : 참조할 테이블 이름과 속성 이름 기입
  [ON DELETE CASCADE | SET NULL | SET DEFAULT | NO ACTION]
  참조 테이블의 튜플이 삭제되면 기본 테이블은 어떤 형태로 대처할지 선택
  [ON UPDATE CASCADE | SET NULL | SET DEFAULT | NO ACTION],
  참조 테이블의 튜플이 변경되면 어떤 형태로 대처할지 선택
  CASCADE 참조 테이블의 튜플에 삭제, 변화가 있는 경우 기본 테이블도 같이 연쇄적으로 삭제/변화 되도록 할 때 사용
  SET NULL 참조 테이블에 삭제, 변화가 있는 경우 기본 테이블의 관련된 속성 값을 NULL값으로 변경할 때 사용
  NO ACTION 참조 테이블의 튜플에 삭제, 변화가 있는 경우 기본 테이블에 아무런 변화가 없도록 지정할 때 사용
[CONSTRAINT 제약조건_이름 CHECK(속성_이름 = 범위 값)]
테이블을 생성할 때 특정 속성에 대해 속성값의 범위를 지정할 때 사용
);
*/

/*
데이터 타입
INT, NUMBER(ORACLE) 정수
FLOAT 또는 REL, NUMBER(ORACLE) 실수
CHAR(문자 수) 고정 길이 문자
VARCHAR, VARCHAR(ORACLE)(문자 수) 가변 길이 문자
TIME 시간
DATE 날짜(ORACLE에서는 DATE 사용)
*/

/*
ALTER 
컬럼 추가 및 삭제
컬럼 이름 변경 및 데이터 타입 변경, DEFAULT 변경

제약조건 추가 및 삭제
제약조건 이름 변경

테이블 이름 변경

테이블 수정
구문
ALTER TABLE table_name
ADD ( column_name datatype [DEFAULT expr] [, …] ) |
{ ADD [CONSTRAINT constraint_name ] constraint_type (column_name) } ... |
MODIFY ( column_name datatype [DEFAULT expr] [, …] ) |
DROP { [COLUMN column_name] | (column_name, …) } [CASCADE CONSTRAINTS] |
DROP PRIMARY KEY [CASCADE] |
{ UNIQUE (column_name, …) [CASCADE] } ... |
CONSTRAINT constraint_name [CASCADE];

이름 변경 구문
ALTER TABLE old_table_name RENAME TO new_table_name ;
RENAME old_table_name TO new_table_name ;
ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name ;
ALTER TABLE table_name RENAME CONSTRAINT old_const_name TO new_const_name ;
*/
DROP TABLE CONSTRAINT_EMP;
CREATE TABLE CONSTRAINT_EMP(
ENAME VARCHAR2(20) CONSTRAINT NENAME NOT NULL,
ENO CHAR(14) CONSTRAINT NENO NOT NULL,
MARRIAGE CHAR(1) DEFAULT 'N',
EID CHAR(3),
EMAIL VARCHAR2(25),
JID CHAR(2),
MID CHAR(3),
DID CHAR(2),
CONSTRAINT CHK CHECK (MARRIAGE IN('Y','N')),
CONSTRAINT PKEID PRIMARY KEY (EID),
CONSTRAINT UENO UNIQUE(ENO),
CONSTRAINT UEMAIL UNIQUE(EMAIL),
CONSTRAINT FKJID FOREIGN KEY(JID) REFERENCES JOB(JOB_ID) 
ON DELETE SET NULL,
CONSTRAINT FKMID FOREIGN KEY(MID) REFERENCES CONSTRAINT_EMP(EID)
ON DELETE SET NULL,
CONSTRAINT FKDID FOREIGN KEY(DID) REFERENCES DEPARTMENT(DEPT_ID)
ON DELETE CASCADE
);

SELECT * FROM CONSTRAINT_EMP;

ALTER TABLE CONSTRAINT_EMP 
DROP CONSTRAINT NENAME 
DROP CONSTRAINT NENO;

ALTER TABLE CONSTRAINT_EMP
DROP UNIQUE (ENO)
DROP UNIQUE (EMAIL);

ALTER TABLE CONSTRAINT_EMP
DROP CONSTRAINT CHK;
