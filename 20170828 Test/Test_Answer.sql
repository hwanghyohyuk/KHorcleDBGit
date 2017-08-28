--1. 2001 년에 입학 한 사학과 학생이 몇 명인지 학생수를 조회하시오. 사학과 코드는 TB_DEPARTMENT 에서
--검색한다. (Join 을 사용하지 않는다.)
--출력예 학생수
-------------
--2

SELECT COUNT(*)
FROM TB_STUDENT
WHERE ENTRANCE_DATE LIKE '01/%'
AND DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '사학%');

--2. 계열이 ‘공학’인 학과 중 입학정원이 20 명 이상, 30 명 이하인 학과의 계열, 학과이름, 정원을 조회하시오.
--단 학과이름을 기준으로 오름차순 정렬하시오.”
--출력예 계열 학과이름 정원
----------------------------------------------------
--공학 동서의료학과 20
--공학 전자공학과 28

SELECT CATEGORY 계열, DEPARTMENT_NAME 학과이름, CAPACITY 정원
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '공학' AND CAPACITY >=20 AND CAPACITY <=30
ORDER BY 2 ASC;

--3. ‘학’자가 들어간 계열의 소속 학과가 몇 개 있는지 계열, 학과수를 출력하시오. 단 학과수가 많은 순으로
--정렬하시오.
--출력예 계열 학과수
-----------------------------
-- 자연과학 20
-- 공학 11

SELECT CATEGORY 계열, COUNT(*) 학과수
FROM TB_DEPARTMENT
WHERE CATEGORY LIKE '%학%'
GROUP BY CATEGORY
ORDER BY 2 DESC;

--4. ‘영어영문학과’ 교수이름, 출생년도, 주소를 조회하고 나이가 많은 순으로 정렬하시오. 영어영문학과 코드는
--TB_DEPARTMENT 에서 검색한다. (Join 을 사용하지 않는다.)
--출력예 교수이름 출생년도 주소
---------------------------------------------------------------------------------------
--이지현 61 경기도 고양시 주엽동 강선마을 동신아파트 406-704 호
--이종석 65 과천시 별양동 주공@ 410-703 호

SELECT PROFESSOR_NAME 교수이름, 
CASE
WHEN SUBSTR(PROFESSOR_SSN,1,2) >50 THEN '19'||SUBSTR(PROFESSOR_SSN,1,2)
ELSE '20'||SUBSTR(PROFESSOR_SSN,1,2)
END AS 출생년도,
PROFESSOR_ADDRESS 주소
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '영어영문%')
ORDER BY MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(PROFESSOR_SSN,1,6),'RRMMDD'))/12 DESC;

--5. 국어국문학과 학생 중 서울에 거주하는 학생의 학과번호, 학생이름, 휴학여부를 조회하고 학생이름으로
--오름차순 정렬하시오. 단 휴학여부는 값이 ‘Y’이면 ‘휴학’으로 ‘N’이면 ‘정상’으로 출력한다. 국어국문학과
--코드는 TB_DEPARTMENT 에서 찾는다. (Join 을 사용하지 않는다)
--출력예 학과번호 학생이름 휴학여부
--------------------------------------------------
-- 001 강승우 정상
-- 001 송영준 휴학

SELECT DEPARTMENT_NO 학과번호, STUDENT_NAME 학생이름, 
CASE
WHEN ABSENCE_YN = 'Y' THEN '휴학'
ELSE '정상'
END AS 휴학여부
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '국어국문%')
AND STUDENT_ADDRESS LIKE '%서울%'
ORDER BY 2 ASC;

--6. 80 년생인 여학생 중 성이 ‘김’씨인 학생의 주민번호, 학생이름을 조회하시오. 단 학생이름으로 오름차순
--정렬하시오.
--출력예 [주민번호] 학생이름
--------------------------------------------------
-- [801211-2******] 김계영
--[800401-2******] 김나루

SELECT SUBSTR(STUDENT_SSN,1,8)||'******' "[주민번호]", STUDENT_NAME 학생이름
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_SSN,1,2) = '80' AND SUBSTR(STUDENT_SSN,8,1) = '2' AND STUDENT_NAME LIKE '김%'
ORDER BY 2 ASC;

--7. 계열이 ‘예체능’인 학과의 정원을 기준으로 40 명 이상이면 ‘대강의실’, 30 명 이상이면 ‘중강의실’, 30 명
--미만이면 ‘소강의실’로 출력한다. 단, 정원이 많은 순으로 정렬 한다.
--출력예 학과이름 정원 강의실크기
----------------------------------------------------------------------
--공연예술학과 36 대강의실
--도예학과 36 중강의실

SELECT DEPARTMENT_NAME 학과이름, CAPACITY 정원, 
CASE
WHEN CAPACITY >= 40 THEN '대강의실'
WHEN CAPACITY >=30 THEN '중강의실'
ELSE '소강의실'
END AS 강의실크기
FROM TB_DEPARTMENT
WHERE CATEGORY = '예체능'
ORDER BY 2 DESC;

--8. 주소지가 ‘경기’ 또는 ‘인천’인 학생 중 1900년대에 입학 한 학생들을 조회 하고자 한다. 오늘날짜를 기준
--으로 입학 후 기간을 계산하여 입학 후 기간이 오래된 순으로 정렬 한다. (단 입학 후 기간의 단위는 년(年)으
--로 하고, 소수점 이하 자리는 버린다. 또한 입학 후 기간이 같을 경우 이름으로 오름차순 정렬한다.)
--출력예 학과이름 입학일자 입학후기간(년)
-----------------------------------------------------------------
--이춘평 98 년 03 월 01 일 13 년
--장충미 98 년 03 월 01 일 13 년

SELECT STUDENT_NAME 학생이름, TO_CHAR(ENTRANCE_DATE,'RR "년" MM "월" DD "일"') 입학일자, TRUNC(MONTHS_BETWEEN(SYSDATE,ENTRANCE_DATE)/12,0) 입학후기간
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%경기%' OR STUDENT_ADDRESS LIKE '%인천%') AND TO_CHAR(ENTRANCE_DATE,'RRRR') LIKE '19__'
ORDER BY 3 DESC, 1 ASC;

--9. 학과별 서울에 거주하는 교수 중 나이가 가장 적은 교수의 나이를 조회한다. 단, 나이가 적은 순으로 정렬
--한다.
--출력예 학과번호 나이
--------------------------------------------------
--040 36
--053 38

SELECT DEPARTMENT_NO 학과번호, 
MIN(TRUNC(MONTHS_BETWEEN(SYSDATE,TO_DATE('19'||SUBSTR(PROFESSOR_SSN,1,6),'RRRRMMDD'))/12,0)) 나이
FROM TB_PROFESSOR
WHERE PROFESSOR_ADDRESS LIKE '%서울%'
GROUP BY DEPARTMENT_NO
ORDER BY 2 ASC;

--10. 2005년1월1일부터 2006년12월31일까지의 기간에 입학한 학생 중 주소가 등록되지 않은 남학생의 학과번
--호, 학생이름, 지도교수번호, 입학년도를 조회하시오. 입학년도를 기준으로 오름차순 정렬한다.
--출력예 학과번호 학생이름 지도교수번호 입학년도
-------------------------------------------------------------------------------
--032 이호준 P042 2005 년
--045 김정명 P048 2005 년

SELECT DEPARTMENT_NO 학과번호, STUDENT_NAME 학생이름, COACH_PROFESSOR_NO 지도교수번호, TO_CHAR(ENTRANCE_DATE,'RRRR "년"') 입학년도
FROM TB_STUDENT
WHERE (ENTRANCE_DATE >= '05/01/01' AND ENTRANCE_DATE <= '06/12/31') AND STUDENT_ADDRESS IS NULL
ORDER BY 4 ASC;


--11. 다음조건에 맞는 데이터를 조회 하시오.
-- “서가람” 학생의 지도 교수가 지도한 학생들의 년도 별 평점을 표시하는 구문을 작성한다.
-- 평점은 소수점 1 자리까지만 반올림하여 표시 한고 년도를 최근 순으로 정렬 한다.
--출력예 년도 평점
----------------------------------------------------
-- 2001 2.3
-- 2000 3.6
--…

SELECT SUBSTR(TERM_NO,1,4) 년도, ROUND(AVG(POINT),1) 평점
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE COACH_PROFESSOR_NO = (SELECT COACH_PROFESSOR_NO FROM TB_STUDENT WHERE STUDENT_NAME = '서가람') 
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY 1 DESC;

--12. 아래 조건에 맞는 내용을 검색 하시오.
-- 전체 남학생 중 휴학한 학생의 입학 일자를 조회한다.
-- 입학일자가 2001 년 1 월 1 일(포함)부터 현재까지(포함)인 학생만 표시하는 구문을 작성한다.
-- 입학 일자가 최근 순으로 정렬한다.
--출력예 학과명 학생명 입학일자
-------------------------------------------------
-- 영어국문학과 이길기 03/03/01
-- 중어중문학과 이술옹 01/03/01
-- …

SELECT DEPARTMENT_NAME, STUDENT_NAME, ENTRANCE_DATE
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE SUBSTR(STUDENT_SSN,8,1) IN ('1','3') AND ABSENCE_YN = 'Y' AND
ENTRANCE_DATE >='01/01/01' AND ENTRANCE_DATE <=SYSDATE
ORDER BY 3 DESC;

--13. 아래 조건에 맞는 내용을 검색 하시오
-- 과목을 하나도 배정 받지 못한 교수가 지도교수인 학생수를 표시하는 구문을 작성한다.
--출력예 지도교수 학생수
------------------------------------------
-- 김가희 4
-- 임정희 9
--…
--
SELECT PROFESSOR_NAME 지도교수, COUNT(STUDENT_NO) 학생수
FROM TB_PROFESSOR 
LEFT JOIN TB_CLASS_PROFESSOR  USING(PROFESSOR_NO)
LEFT JOIN TB_STUDENT  ON(COACH_PROFESSOR_NO =PROFESSOR_NO)
WHERE CLASS_NO IS NULL
GROUP BY PROFESSOR_NAME;

--14. 다음조건에 맞는 데이터를 조회 하시오.
-- “공학”계열의 학생들 중 2009 년도 평점 이 4.0 이상인 학생을 표시하는 구문을 작성한다.
-- 평점은 소수점 1 자리까지만 반올림하여 표시 한다.
-- 점수가 높은 순으로 정렬 하고 같으면 학생이름순(가나다순)으로 정렬 한다.
--출력예 학생이름 학기 학점
----------------------------------------
--이수길 200201 4.5
--조훈정 200103 4.2
--…
--

SELECT STUDENT_NAME 학생이름, TERM_NO 학기, ROUND(AVG(POINT),1) 학점
FROM TB_STUDENT
JOIN TB_GRADE USING (STUDENT_NO)
WHERE DEPARTMENT_NO IN (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE CATEGORY ='공학')
AND TERM_NO LIKE '2009%'
GROUP BY STUDENT_NAME, TERM_NO
HAVING ROUND(AVG(POINT),1)>=4.0
ORDER BY 3 DESC, 1 ASC;


--15. 다음조건에 맞는 데이터를 조회 하시오
-- “김고운” 학생이 있는 과의 2007 년, 2008 년 학기 별 평점과
--년도 별 누적 평점, 총 평점을 표시하는 구문을 작성한다. (평점은 소수점 1 자리까지만 반올림)
--출력예 년도 학기 평점
----------------------------------------------
-- 2007 01 3.3
-- 2007 02 3.6
-- 2007 03 4.3
-- 2007 3.6
-- 2008 01 3.8
-- 2008 02 3.7
-- 2008 03 3
-- 2008 3.6
-- 01 3.5
-- 02 3.6
-- 03 3.6
-- 3.6
--
SELECT SUBSTR(TERM_NO,1,4) 년도, SUBSTR(TERM_NO,5,2) 학기, ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO FROM TB_STUDENT WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE STUDENT_NAME ='김고운'))
AND SUBSTR(TERM_NO,1,4) IN ('2007','2008')
GROUP BY ROLLUP(SUBSTR(TERM_NO,5,2)),ROLLUP(SUBSTR(TERM_NO,1,4))
ORDER BY 1,2 ASC;

--16. 다음조건에 맞는 데이터를 조회 하시오
-- “문학과생태학” 과목을 진행하는 과의 2004 년도 학기 별 평점과
--총 평점을 표시하는 구문을 작성한다.
-- 평점은 소수점 1 자리까지만 반올림하여 표시 한다.
--출력예 년도 학기 평점
----------------------------------------------------
--2004 01 3.4
--2004 02 2.2
--2004 03 3.1
--2004 - 2.9
--
SELECT SUBSTR(TERM_NO,1,4) 년도, SUBSTR(TERM_NO,5,2) 학기, ROUND(AVG(POINT),1) 평점
FROM TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO FROM TB_STUDENT WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_CLASS WHERE CLASS_NAME = '문학과생태학'))
AND SUBSTR(TERM_NO,1,4) = '2004'
GROUP BY ROLLUP(SUBSTR(TERM_NO,5,2)),SUBSTR(TERM_NO,1,4)
ORDER BY 1,2 ASC;
--17. 다음조건에 맞는 데이터를 조회 하시오.
-- 최근 10 년을 기준으로 누적 수강생수가 가장 많았던 과목 중 상위 3 순위를 표시하는 구문을 작성한다.
--상위 3 순위에 동일한 순위가 있을 경우 모두 표시 한다.
-- 누적 수강생수가 많은 순으로 정렬 한다.
--출력예 과목이름 누적수강생수
------------------------------------------------------------------
--영어국문학 48
--국어영문학 36
--무용학 36
--논문지도 1 30
--논문지도 30
--
SELECT * 
FROM(
SELECT CLASS_NAME 과목이름, COUNT(*) AS 누적수강생수
FROM TB_CLASS
JOIN TB_GRADE USING(CLASS_NO)
WHERE TO_NUMBER(TO_CHAR(SYSDATE,'RRRR')) - TO_NUMBER(SUBSTR(TERM_NO,1,4)) <=10
GROUP BY CLASS_NAME
ORDER BY 2 DESC
)WHERE ROWNUM <=3;

--18. 학생번호가 총 7 자리이고 'A'로 시작하며 4 번째 자리 데이터가 '3'인 학생 중 지도교수의 성이 '이'씨인
--학생을 학생이름 순(가나다순)으로 표시하는 구문을 작성 하시오.
--출력예 학생이름 지도교수
----------------------------------------------------
--이주희 이훈
--강민구 김지일

SELECT STUDENT_NAME, PROFESSOR_NAME
FROM TB_STUDENT S
JOIN TB_PROFESSOR P ON ( S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE STUDENT_NO LIKE 'A__3___' AND PROFESSOR_NAME LIKE '이%'
ORDER BY 1 ASC;


--19. 다음조건에 맞는 데이터를 조회 하시오
-- “예체능”과 “의학” 계열의 모든 학과를 학과이름과 학생수로 표시하는 구문을 작성 하시오.
-- 계열이름 순(가나다순)으로 정렬 하고 같으면 학생수가 많은 순으로 정렬 한다.
--출력예 계열 학과이름 학생수
---------------------------------------------------------------------
--예체능 공연예술학과 14
--예체능 도예학과 10
--…
--의학 의학과 18
--의학 치의학과 10
--
SELECT CATEGORY 계열, DEPARTMENT_NAME 학과이름, COUNT(*)
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
WHERE CATEGORY IN ('예체능','의학')
GROUP BY CATEGORY, DEPARTMENT_NAME
ORDER BY 1 ASC, 3 DESC;

--20. ‘행정학과’의 모든 과목을 선수 과목과 함께 과목이름순(가나다순)으로 표시하는 구문을 작성 하시오.
--(선수과목이 없을 출력되지 않는다.)
--출력예 과목 선수과목
------------------------------------------
--정책사례연구 정책사례연구
--지방행정론 지방행정론
--국제법연습 지방행정원론
--…

SELECT A.CLASS_NAME 과목, B.CLASS_NAME 선수과목
FROM TB_CLASS A, TB_CLASS B
WHERE A.PREATTENDING_CLASS_NO = B.CLASS_NO
AND A.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '행정%')
ORDER BY 1 ASC;

--21. 다음조건에 맞는 데이터를 조회 하시오
-- 최근 10 년을 기준으로 누적 수강생수가 가장 많았던 과목 중 상위 5 개를 조회 한다.
-- 누적 수강생수가 가장 많은 순으로 정렬 한다.
--출력예 과목번호 과목이름
----------------------------------------------
-- C1453800 정책사례연구
-- C1253400 지방행정론
-- C3037000 지방행정원론
-- C1927300 작품세미나
-- C3454000 행정학연구

SELECT 과목번호, 과목이름
FROM(
SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) AS 누적수강생수
FROM TB_CLASS
JOIN TB_GRADE USING(CLASS_NO)
WHERE TO_NUMBER(TO_CHAR(SYSDATE,'RRRR')) - TO_NUMBER(SUBSTR(TERM_NO,1,4)) <=10
GROUP BY CLASS_NO,CLASS_NAME
ORDER BY 3 DESC, 2 ASC
)WHERE ROWNUM <=5;

--22. 다음조건에 맞는 VIEW 를 생성 하시오.
-- VIEW 이름: V_ENGLISH , VIEW 컬럼: “학생이름”과 “평점”
-- “영어영문학과” 학생들의 학생이름과 평점을 VIEW 로 생성 한다.
-- 평점은 소수점 1 자리까지만 반올림하여 표시 한다.
-- 점수가 높은 순으로 정렬 하고 같으면 학생 명으로 오름차순 정렬 한다.
--SELECT *
--FROM
--TB_ENGLISH
--결과
--학생이름 평점
----------------------------------------------
-- 이석훈 3.9
-- 임기훈 3.6
-- 석동훈 3.2
-- …



CREATE VIEW V_ENGLISH (학생이름, 평점)
AS SELECT STUDENT_NAME, ROUND(AVG(POINT),1)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '영어영문%')
GROUP BY STUDENT_NAME 
ORDER BY 2 DESC,1 ASC;

--23. 다음 조건에 맞게 데이터를 수정 하시오.
-- ‘이대은’학생과 ‘김김훈’ 학생이 2002 년 01 학기에 ‘현대생물학연구’ 과목을 같이 수강 하였다.
-- ‘이대은’ 학생의 점수를 ‘김김훈’ 학생의 점수로 수정 한다.

UPDATE TB_GRADE
SET POINT  = (SELECT POINT FROM TB_GRADE WHERE TERM_NO = '200201' 
AND STUDENT_NO = (SELECT STUDENT_NO FROM TB_STUDENT WHERE STUDENT_NAME ='김김훈') 
AND CLASS_NO = (SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME = '현대생물학연구'))
WHERE TERM_NO = '200201' 
AND STUDENT_NO = (SELECT STUDENT_NO FROM TB_STUDENT WHERE STUDENT_NAME ='이대은') 
AND CLASS_NO = (SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME = '현대생물학연구');

SELECT * FROM TB_GRADE WHERE TERM_NO = '200201' 
AND STUDENT_NO = (SELECT STUDENT_NO FROM TB_STUDENT WHERE STUDENT_NAME ='김김훈') 
AND CLASS_NO = (SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME = '현대생물학연구');

--24. 다음 조건에 맞는 DDL 을 작성 하시오.
-- 모든 계열 별 학생 수와 등록금의 합을 확인 할 수 있도록 TABLE 을 생성 한다.
-- 학생 일인당 등록금은 4 백만원이다.
-- Table 이름은 TB_TUITION 로 한다.
-- Table 의 컬럼명은 다음과 같다.
-- 카테고리: CATEGORY
-- 학생수: STUDENT_COUNT
-- 등록금합: TUITION_SUM
-- 서브쿼리를 이용하여 하나의 문장으로 작성 하시오
--SELECT *
--FROM
--TB_TUITION
--결과
--CATEGORY STUDENT_COUNT TUITION_SUM
----------------------------------------------
--공학 89 356000000
--자연과학 198 792000000
--…
CREATE TABLE TB_TUITION
AS SELECT CATEGORY, COUNT(*) AS STUDENT_COUNT, COUNT(*)*4000000  AS TUITION_SUM
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING (DEPARTMENT_NO)
GROUP BY CATEGORY;

--25. 아래의 Table 과 sequence 가 생성 되어 있다.
-- 이 TABLE 에 조건에서 주어진 데이터를 입력 하시오.
-- Table
--CREATE TABLE TB_BOOKS
--( BOOK_ID NUMBER PRIMARY KEY,
--BOOKNAME VARCHAR2(50)
--BOOKPRICE NUMBER
--);
-- sequence
--CREATE SEQUENCE SEQID
--INCREMENT BY 1
--START WITH 100
--MAXVALUE 999
--NOCYCLE NOCACHE;
-- 입력 데이터
--BOOK_ID: 새로운 시퀀스 값을 이용하여 입력 한다
--BOOKNAME: “JAVA Programming”
--BOOKPRICE: 30000

CREATE TABLE TB_BOOKS
( BOOK_ID NUMBER PRIMARY KEY,
BOOKNAME VARCHAR2(50),
BOOKPRICE NUMBER
);
CREATE SEQUENCE SEQID
INCREMENT BY 1
START WITH 100
MAXVALUE 999
NOCYCLE NOCACHE;

INSERT INTO TB_BOOKS VALUES(SEQID.NEXTVAL,'JAVA Programming',30000);

SELECT * FROM TB_BOOKS;

--수고하셨습니다.