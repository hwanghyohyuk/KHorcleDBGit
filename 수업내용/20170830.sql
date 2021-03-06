SELECT * FROM EMP;

SHOW SERVEROUTPUT;
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TR_WELCOME
AFTER INSERT ON EMP
BEGIN
  DBMS_OUTPUT.PUT_LINE('입사를 환영합니다.');
END;
/
INSERT INTO EMP VALUES('999','황효혁','개발팀');
ROLLBACK;
COMMIT;

CREATE TABLE EMP03(
EMPNO NUMBER(4) PRIMARY KEY,
ENAME VARCHAR2(15),
SAL NUMBER(7,2)
);

CREATE TABLE SALARY(
NO NUMBER PRIMARY KEY,
EMPNO NUMBER(4),
SAL NUMBER(7,2)
);

CREATE SEQUENCE SALARY_SEQ
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;
---> INSERT INTO EMP03 VALUES (8000, '홍길동', 3000);
---> INSERT INTO SALARY VALUES (1, 8000, 3000);
INSERT INTO EMP03 VALUES(, '홍길동', 4000);
CREATE OR REPLACE TRIGGER TR_SALARY
AFTER INSERT ON EMP03
FOR EACH ROW
BEGIN
INSERT INTO SALARY
VALUES(SALARY_SEQ.NEXTVAL, :NEW.EMPNO, :NEW.SAL);
END;
/
SELECT * FROM EMP03;
SELECT * FROM SALARY;


CREATE TABLE 상품
(
상품코드 CHAR(4) CONSTRAINT 상품_PK PRIMARY KEY --a001
, 상품명 VARCHAR(15) NOT NULL
, 제조사 VARCHAR(15)
, 소비자가격 NUMBER
, 재고수량 NUMBER DEFAULT 0
);
--상품등록
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격)
VALUES('a001', '마우스', 'LC', 1000);
INSERT INTO 상품 VALUES('a002', '키보드', '삼송', 2000, 0);
INSERT INTO 상품 VALUES('a003', '모니터', 'HB', 10000, 0);

CREATE TABLE 입고
(
입고번호 NUMBER PRIMARY KEY
, 상품코드 CHAR(4) REFERENCES 상품(상품코드)
, 입고일자 DATE
, 입고수량 NUMBER
, 입고단가 NUMBER
, 입고금액 NUMBER
);

CREATE SEQUENCE 입고_SEQ
START WITH 1
INCREMENT BY 1
NOCYCLE
NOCACHE;
/
CREATE OR REPLACE PROCEDURE SP_PRO_INSERT(
CODE CHAR
, SU NUMBER
, WON NUMBER
)
IS
BEGIN
INSERT INTO 입고
VALUES(입고_SEQ.NEXTVAL, CODE, SYSDATE, SU, WON, SU*WON);
END;
/

-- TRIGGER INSERT
CREATE OR REPLACE TRIGGER TR_PRODUCT_INSERT
AFTER INSERT ON 입고
FOR EACH ROW
BEGIN
UPDATE 상품 SET
재고수량 = 재고수량 + :NEW.입고수량
WHERE 상품코드 = :NEW.상품코드;
END;
/
/*
UPDATE 입고 SET
입고금액 = 입고수량 * 입고단가;
ORA-04091: SCOTT.입고 테이블이 변경되어 트리거/함수가 볼 수 없습니다.
ORA-06512: "SCOTT.TR_PRODUCT_INSERT", 6 행
ORA-04088: 트리거 'SCOTT.TR_PRODUCT_INSERT'의 수행시 오류
*/
----> 프로시저로 INSERT 함으로 해결
-- TRIGGER UPDATE
CREATE OR REPLACE TRIGGER TR_PRODUCT_UPDATE
AFTER UPDATE ON 입고
FOR EACH ROW
BEGIN
UPDATE 상품 SET
재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
WHERE 상품코드 = :OLD.상품코드;
END;
/
-- TRIGGER DELETE
CREATE OR REPLACE TRIGGER TR_PRODUCT_DELETE
AFTER DELETE ON 입고
FOR EACH ROW
BEGIN
UPDATE 상품 SET
재고수량 = 재고수량 - :OLD.입고수량
WHERE 상품코드 = :NEW.상품코드;
END;
/
EXECSP_PRO_INSERT('a002', 20, 3000);
EXECSP_PRO_INSERT('a002', 10, 3000);
UPDATE 입고 SET 입고수량 = 15 WHERE 입고번호 = 7;
