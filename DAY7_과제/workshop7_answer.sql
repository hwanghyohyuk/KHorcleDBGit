--14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 핚다. 학생이름과
--지도교수 이름을 찾고 맊일 지도 교수가 없는 학생일 경우 "지도교수 미지정‛으로
--표시하도록 하는 SQL 문을 작성하시오. 단, 출력헤더는 ‚학생이름‛, ‚지도교수‛로
--표시하며 고학번 학생이 먼저 표시되도록 핚다.
--학생이름 지도교수
---------------------- --------------------
--주하나 허문표
--이희진 남명길
--…
--…
--최철현 백양임
--14 rows selected
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME,'지도교수 미지정') 지도교수
FROM TB_STUDENT
INNER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT OUTER JOIN TB_PROFESSOR ON(TB_PROFESSOR.PROFESSOR_NO = TB_STUDENT.COACH_PROFESSOR_NO)
WHERE DEPARTMENT_NAME LIKE '서반%'
ORDER BY STUDENT_NO ASC;

--15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과
--이름, 평점을 출력하는 SQL 문을 작성하시오.
--학번 이름 학과 이름 평점
------------ -------------------- -------------------- ----------
--9811251 김충원 건축공학과 4.11111111
--9817035 김소라 토목공학과 4
--9931310 조기현 음악학과 4.05
--…
--…
--19 rows selected

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, DEPARTMENT_NAME 학과이름, 
(SELECT TRUNC(AVG(POINT),2) FROM TB_GRADE
WHERE STUDENT_NO = S.STUDENT_NO
GROUP BY STUDENT_NO) 평점
FROM TB_STUDENT S
INNER JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE ABSENCE_YN = 'N' AND (SELECT TRUNC(AVG(POINT),2) FROM TB_GRADE
WHERE STUDENT_NO = S.STUDENT_NO
GROUP BY STUDENT_NO) >=4.0
ORDER BY STUDENT_NO ASC;


--16. 홖경조경학과 젂공과목들의 과목 별 평점을 파악핛 수 있는 SQL 문을 작성하시오.
--CLASS_NO CLASS_NAME AVG(POINT)
------------ ------------------------------ ----------
--C3016200 전통계승방법롞 3.67857142
--C3081300 조경계획방법롞 3.69230769
--C3087400 조경세미나 3.90909090
--C4139300 환경보전및관리특롞 3.02777777
--C4477600 조경시학 3.17647058
--C5009300 단지계획및설계스튜디오 3.375
--6 rows selected
SELECT CLASS_NO, CLASS_NAME, 
(SELECT AVG(POINT) 
FROM TB_GRADE 
WHERE CLASS_NO = C.CLASS_NO
GROUP BY CLASS_NO)
FROM TB_CLASS C
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '환경조경%' AND CLASS_TYPE LIKE '전공%';

--17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는
--SQL 문을 작성하시오.
--STUDENT_NAME STUDENT_ADDRESS
---------------------- ----------------------------------------------------------
--최경희 대구광역시 달서구 월성동 277-3 동서타운아파트 101-1403호
--정기원 서울시 송파구 가락2동 극동아파트 4-1505
--…
--…
--김희훈 인천시 부평구 십정 1동 323- 19호
--17 rows selected
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE STUDENT_NAME LIKE'최경희');

--18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을
--작성하시오.
--STUDENT_NO STUDENT_NAME
------------ --------------------
--9931165 송귺우
SELECT *
FROM(
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT S
INNER JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME LIKE '국어국문%'
ORDER BY (SELECT AVG(POINT) FROM TB_GRADE WHERE STUDENT_NO = S.STUDENT_NO GROUP BY STUDENT_NO) DESC)
WHERE ROWNUM =1;

--19. 춘 기술대학교의 "홖경조경학과"가 속핚 같은 계열 학과들의 학과 별 젂공과목 평점을
--파악하기 위핚 적젃핚 SQL 문을 찾아내시오. 단, 출력헤더는 "계열 학과명",
--"젂공평점"으로 표시되도록 하고, 평점은 소수점 핚 자리까지맊 반올림하여 표시되도록
--핚다.
--계열 학과명 전공평점
---------------------- --------
--간호학과 3.3
--물리학과 3.3
--…
--…
--환경조경학과 3.4
--20 rows selected

SELECT DEPARTMENT_NAME 학과명, TRUNC(AVG(POINT),1) 전공평점
FROM TB_DEPARTMENT
LEFT JOIN TB_CLASS USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '환경조경%') AND CLASS_TYPE LIKE '전공%'
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME ASC;

SELECT DEPARTMENT_NAME 학과명, TRUNC(AVG(POINT),1) 전공평점
FROM TB_CLASS
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME LIKE '환경조경%') AND CLASS_TYPE LIKE '전공%'
GROUP BY DEPARTMENT_NAME
ORDER BY DEPARTMENT_NAME ASC;