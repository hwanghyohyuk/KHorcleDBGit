--13
--[Additional SELECT - Option]
--1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
--정렬은 이름으로 오름차순 표시하도록 한다.
--학생 이름 주소지
---------------------- ----------------------------------------------------------
--감현제 서울강서등촌동691-3부영@102-505
--강동연 경기도 의정부시 민락동 694 산들마을 대림아파트 404-1404
--…
--황형철 전남 숚천시 생목동 현대ⓐ 106/407 T.061-772-2101
--황효종 인천시서구 석남동 564-4번지
--588 rows selected

SELECT STUDENT_NAME 학생이름,STUDENT_ADDRESS 주소지
FROM TB_STUDENT;

--2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
--STUDENT_NAME STUDENT_SSN
---------------------- --------------
--릴희권 871222-1124648
--황효종 871125-1129980
--전효선 871030-2176192
--김진호 871013-1140536
--…
--…
--91 rows selected

SELECT STUDENT_NAME 학생이름, STUDENT_SSN 주민번호
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY MONTHS_BETWEEN(SYSDATE,TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD'))/12 ASC;

--3. 주소지가 강원도나 경기도인 학생들 중 1900 년대 학번을 가진 학생들의 이름과 학번,
--주소를 이름의 오름차순으로 화면에 출력하시오. 단, 출력헤더에는 "학생이름","학번",
--"거주지 주소" 가 출력되도록 한다.
--학생이름 학번 거주지 주소
---------------------- ---------- -------------------------------------------------------------
--김계영 9919024 경기도 용인시 수지구 풍덕천2동 신정마을 임광 305-1703호
--박규상 9931111 경기도 성남시 분당구 탑마을 526 경남아파트 710-1302
--송귺우 9931165 경기도 부천시 원미구 중2동 386-1186 복사골아파트 1701-405
--송정삼 9995148 경기도 남양주시 도농동 부영그린타운 306-2304
--이기범 9931248 경기도 굮포시 산본동 한양목련아파트1224-2002
--이춘평 9811176 경기도 고양시 일산구 일산동1107후곡마을1209-705
--전기성 9931277 경기도 용인시 수지구 풍덕천동 239-3 중앙빌딩 3층
--정기웅 9931285 경기도 성남시 분당구 야탑동 기산아파트 307-801호
--조기환 9931312 경기도 시흥시 매화동 194-1 동진아파트 1-305
--9 rows selected
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '강원도%' OR STUDENT_ADDRESS LIKE '경기도%')
AND STUDENT_NO LIKE '9%'
ORDER BY STUDENT_NAME ASC;

--4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인핛 수 있는 SQL 문장을
--작성하시오. (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아
--내도록 하자)
--PROFESSOR_NAME PROFESSOR_SSN
---------------------- --------------
--홍남수 540304-1112251
--김선희 551030-2159000
--임진숙 640125-1143548
--이미경 741016-2103506
SELECT PROFESSOR_NAME 교수이름, PROFESSOR_SSN 주민번호
FROM TB_PROFESSOR
INNER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '법학과'
ORDER BY MONTHS_BETWEEN(SYSDATE,TO_DATE(SUBSTR(PROFESSOR_SSN,1,6),'RRMMDD'))/12 DESC;

--5. 2004 년 2 학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 학점이
--높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을
--작성해보시오.
--STUDENT_NO POINT
------------ -----
--A352017 4.00
--A115270 3.50
--A215247 3.00
--A417074 3.00
--A131046 2.50
--A219089 2.50
--A331076 2.00
--7 rows selected
SELECT STUDENT_NO 학번, POINT 학점
FROM TB_GRADE
WHERE SUBSTR(TERM_NO,1,4) LIKE '2004' AND SUBSTR(TERM_NO,5,2) LIKE '02' AND CLASS_NO LIKE 'C3118100'
ORDER BY POINT DESC, STUDENT_NO ASC;

--6. 학생 번호, 학생 이름, 학과 이름을 이름 가나다 순서로 정렬하여 출력하는 SQL 문을
--작성하시오.
--STUDENT_NO STUDENT_NAME DEPARTMENT_NAME
------------ ------------- --------------------
--A411001 감현제 치의학과
--A131004 강동연 디자인학과
--9931003 강민성 치의학과
--…
--A411335 황형철 사회학과
--A511332 황효종 컴퓨터공학과
--588 rows selected
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME
FROM TB_STUDENT
INNER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME ASC;

--7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 학과 이름 가나다 순서로 출력하는
--SQL 문장을 작성하시오.
--CLASS_NAME DEPARTMENT_NAME
-------------------------------- --------------------
--간호이론 간호학과
--논문지도2 간호학과
--상급간호연구방법론 간호학과
--…
--논문지도1 회계학과
--회계학연구방법론1 회계학과
--882 rows selected
SELECT CLASS_NAME 과목이름, DEPARTMENT_NAME 학과이름
FROM TB_CLASS
INNER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY DEPARTMENT_NAME ASC;

--8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을
--작성하시오.
--CLASS_NAME PROFESSOR_NAME
-------------------------------- --------------------
--고전시가론특강 김선정
--국어어휘론특강 김선정
--국어음성학연구 김선정
--…
--…
--논문지도1 백은정
--776 rows selected
SELECT CLASS_NAME 과목이름, PROFESSOR_NAME 교수이름
FROM TB_CLASS
INNER JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
INNER JOIN TB_PROFESSOR USING(PROFESSOR_NO);

--9. 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다. 이에
--해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
--CLASS_NAME PROFESSOR_NAME
-------------------------------- --------------------
--고전시가론특강 김선정
--국어어휘론특강 김선정
--…
--…
--논문지도2 강혁
--197 rows selected
SELECT CLASS_NAME 학과이름, PROFESSOR_NAME 교수이름
FROM TB_CLASS
INNER JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
INNER JOIN TB_PROFESSOR USING(PROFESSOR_NO)
INNER JOIN TB_DEPARTMENT ON(TB_DEPARTMENT.DEPARTMENT_NO = TB_PROFESSOR.DEPARTMENT_NO)
WHERE CATEGORY LIKE '인문사회';

--10. ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름",
--"젂체 평점"을 평점이 높은 순서(평점이 동일하면 학번 순서)로 출력하는 SQL 문장을
--작성하시오. (단, 평점은 소수점 1 자리까지맊 반올림하여 표시한다.)
--학번 학생 이름 전체 평점
------------ -------------------- ----------
--9931310 조기현 4.1
--A612052 신광현 4.1
--A431021 구병훈 3.9
--A431358 조상진 3.7
--A411116 박현화 3.6
--A354020 양재영 3.5
--A557031 이정범 3.3
--A415245 조지선 3.2
--8 rows selected
SELECT S.STUDENT_NO 학번, S.STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1)
FROM TB_STUDENT S
INNER JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
INNER JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '음악학과'
GROUP BY  S.STUDENT_NO, S.STUDENT_NAME
ORDER BY  ROUND(AVG(POINT),1) DESC;

--11. 학번이 A313047 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 젂달하기
--위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용핛 SQL 문을
--작성하시오. 단, 출력헤더는 ‚학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로
--출력되도록 한다.
--학과이름 학생이름 지도교수이름
---------------------- -------------------- --------------------
--경제학과 손건영 박태환
SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME
FROM TB_STUDENT
INNER JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
INNER JOIN TB_PROFESSOR ON(TB_STUDENT.COACH_PROFESSOR_NO = TB_PROFESSOR.PROFESSOR_NO)
WHERE STUDENT_NO LIKE 'A313047';

--12. 2007 년도에 '인갂관계론' 과목을 수강한 학생을 찾아 학생이름과 수강학기를 이름
--가나다 순서로 표시하는 SQL 문장을 작성하시오.
--STUDENT_NAME TERM_NO
---------------------- --------------------
--김혜원 200701
--오진형 200701
--이정호 200703
SELECT STUDENT_NAME 학생이름, TERM_NO 수강학기
FROM TB_STUDENT
INNER JOIN TB_GRADE USING (STUDENT_NO)
INNER JOIN TB_CLASS ON (TB_GRADE.CLASS_NO = TB_CLASS.CLASS_NO)
WHERE SUBSTR(TERM_NO,1,4) LIKE '2007' AND CLASS_NAME LIKE '인간관계론'
ORDER BY STUDENT_NAME ASC;

--13. 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 그 과목
--이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
--CLASS_NAME DEPARTMENT_NAME
-------------------------------- --------------------
--드로잉 미술학과
--미술시장,경영론 미술학과
--…
--…
--운동처방연구 체육학과
--해부학실험 체육학과
--44 rows selected
--
----13번 답
--SELECT CLASS_NAME, DEPARTMENT_NAME
--FROM TB_CLASS
--INNER JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
--LEFT OUTER JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
--WHERE (DEPARTMENT_NO>=56 AND DEPARTMENT_NO<=63) AND PROFESSOR_NO IS NULL;
