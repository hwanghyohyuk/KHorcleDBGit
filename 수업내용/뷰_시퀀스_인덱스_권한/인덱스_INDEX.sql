-- *********************************************
-- 인덱스 (INDEX)
   : SQL 명령문의 처리속도를 향상시키기 위해서 컬럼에 대해서 생성하는
	오라클 객체임.
-- 인덱스 내부 구조는 B* 트리 형식으로 구성되어 있음
-- 컬럼에 인덱스를 설정하면 이를 위한 B* 트리도 생성해야 하기 때문에
	인덱스를 생성하기 위한 시간도 필요하고, 인덱스를 위한 추가
	저장 공간이 필요함(반드시 좋은 것은 아님)
-- 인덱스 생성 후에 DML 작업을 수행하면, 인덱스가 사용된 컬럼값이
   변경되므로 B* 트리 내부 구조 역시 함께 수정되므로, DML 작업이 훨씬
   무거워지게 됨.

* 장점
 - 검색 속도가 빨라짐
 - 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킴
* 단점
 - 인덱스를 위한 추가적인 공간이 필요함
 - 인덱스를 생성하는 데 시간이 걸림
 - 데이터의 변경 작업(INSERT/UPDATE/DELETE)이 자주 일어날 경우에는
   오히려 성능이 저하됨.

-- 키워드와 해당 내용의 위치가 정렬된 상태로 구성됨
-- 키워드를 이용해 원하는 내용을 빠르게 찾기위한 목적으로 사용
-- 데이터베이스에서 인덱스는 컬럼값을 이용해 원하는 행을
-- 빠르게 찾기위한 목적으로 사용

-- 인덱스 구조 ------------------------------------------------
-- 정렬된 특정 컬럼값(Key)과 
-- 해당 컬럼값이 포함된 행위치(Rowid)로 구성


-- 인덱스 사용시 고려사항 ---------------------------------
-- 인덱스 특징
-- 테이블과 연관되지만 독립적인 객체
-- 자동적으로 사용되고 관리됨
-- DISK I/O를 줄임으로써 검색속도를 향상시킬 수 있음

-- 인덱스를 사용하는 것이 효율적인 경우
-- WHERE절이나 JOIN 조건에 주로 사용되는 컬럼
-- UNIQUE 속성의 컬럼이나 NULL이 많이 포함된 컬럼
-- 넓은 범위의 값이 포함된 컬럼

-- 인덱스를 사용하지 않는 것이 더 효율적인 경우
-- 테이블이 작은 경우(데이터가 적은 경우)
-- 테이블 갱신이 자주 발생하는 경우
-- 다량의 데이터가 조회되는 경우


-- 인덱스 생성 기본 구문
-- CREATE [UNIQUE] INDEX index_name 
-- ON table_name( column_list | function, expr );

* 인덱스의 종류
 1. 고유 인덱스(UNIQUE INDEX)
 2. 비고유 인덱스(NONUNIQUE INDEX)
 3. 단일 인덱스(SINGLE INDEX)
 4. 결합 인덱스(COMPOSITE INDEX)
 5. 함수 기반 인덱스(FUNCTION BASED INDEX)


-- 인덱스 유형 ------------------------------------------
-- 인덱스를 생성하는 대상 컬럼에 따라
-- Unique Index, Nonunique Index로 구분

-- Unique Index *************************************************
-- Unique Index가 생성된 컬럼에는 중복값이 포함될 수 없음
-- 오라클은 'PRIMARY KEY' 제약조건을 생성하면 자동으로
-- 해당 컬럼에 Unique Index를 생성
-- PRIMARY KEY를 이용하여 access하는 경우 성능향상 효과있음

-- Nonunique Index **********************************************
-- 빈번하게 사용되는 일반 컬럼을 대상으로 생성함
-- 주로 성능향상을 위한 목적으로 생성


-- UNIQUE INDEX 생성
CREATE UNIQUE INDEX IDX_DNM 
ON DEPARTMENT(DEPT_NAME);

-- NONUNIQUE INDEX 생성
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


-- 인덱스 삭제 ------------------------------------------
-- 인덱스 삭제 구문을 이용하여 삭제
-- 테이블이 삭제되면 관련된 인덱스는 함께 자동으로 삭제됨
-- DROP INDEX index_name ;
DROP INDEX IDX_JID;

-- 인덱스 정보 확인 -----------------------------------
-- EMPLOYEE 테이블에 생성된 인덱스 현황 조회
DESC USER_INDEXES;
DESC USER_IND_COLUMNS;

SELECT INDEX_NAME, 
       COLUMN_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES
JOIN USER_IND_COLUMNS 
     USING (INDEX_NAME, TABLE_NAME)
WHERE TABLE_NAME = 'EMPLOYEE';

-- 검색 속도 비교해 보기
-- EMPLOYEE 테이블의 모든 정보를 서브쿼리로 복사한
-- EMPL01, EMPL02 테이블을 만듦
-- EMPL01에 EMP_ID 컬럼에 대해 UNIQUE INDEX 만들기
-- 검색속도 비교 조회함 : 두 테이블에 대해 각각 테스트
-- EMP_ID 를 가지고 직원 정보 조회함 : 속도 확인함
CREATE TABLE EMPL01
AS
SELECT * FROM EMPLOYEE;

CREATE TABLE EMPL02
AS
SELECT * FROM EMPLOYEE;

CREATE UNIQUE INDEX IDX_EID
ON EMPL01(EMP_ID);

SELECT * FROM EMPL01
WHERE EMP_ID = '141';

SELECT * FROM EMPL02
WHERE EMP_ID = '141';

-- 결합 인덱스 **********************************************************
-- 한 개의 컬럼으로 구성한 인덱스 == 단일 인덱스
-- 결합 인덱스 : 두 개 이상의 컬럼으로 인덱스를 구성하는 것
CREATE TABLE DEPT01
AS SELECT * FROM DEPARTMENT;

-- 부서번호와 부서명을 결합하여 인덱스 생성하기
CREATE INDEX IDX_DEPT01_COMP
ON DEPT01 (DEPT_ID, DEPT_NAME);

-- 데이터 딕셔너리에서 확인해 봄
SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'DEPT01';


-- 함수 기반 인덱스  *************************************************
--  SELECT 절이나 WHERE 절에 산술계산식이나 함수식이 사용된 경우
-- 계산식은 인덱스의 적용을 받지 않는다.
-- 계산식으로 검색하는 경우가 많다면, 수식이나 함수식을 인덱스로 만듦
CREATE TABLE EMP01
AS SELECT * FROM EMPLOYEE;

CREATE INDEX IDX_EMP01_SALCALC
ON EMP01 ((SALARY + (SALARY * NVL(BONUS_PCT, 0)) * 12)); 

SELECT INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMP01';




