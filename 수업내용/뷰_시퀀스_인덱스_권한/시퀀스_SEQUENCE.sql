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

-- 데이터 딕셔너리에 저장됨
DESC USER_SEQUENCES;

SELECT * FROM USER_SEQUENCES;

-- 데이터 딕셔너리에서 시퀀스 정보 확인
SELECT SEQUENCE_NAME,
       CACHE_SIZE,
       LAST_NUMBER
FROM USER_SEQUENCES
WHERE SEQUENCE_NAME IN ('SEQ_EMPID','SEQ2_EMPID');
-- LAST_NUMBER 값은
-- CACHE 미사용 : 새로 반환될 시퀀스값
-- CACHE 사용 : CACHE로 생성된 이후 시퀀스값
--          (메모리에 생성된 시퀀스도 사용된 것으로 간주함)


-- 시퀀스 사용
SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- MAXVALUE 값에 도달했고 NOCYCLE 이기 때문에
-- 4회 사용시 에러 발생


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


-- 시퀀스 사용방법 ***************************
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
NOCYCLE NOCACHE;

SELECT SEQ3_EMPID.CURRVAL FROM DUAL;
-- NEXTVAL 속성 사용 전에는 사용할 수 없음

SELECT SEQ3_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ3_EMPID.CURRVAL FROM DUAL;

-- 시퀀스 사용 
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


