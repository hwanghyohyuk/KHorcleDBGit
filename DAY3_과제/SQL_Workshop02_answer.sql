--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
--순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가
--표시되도록 한다.)
--
SELECT STUDENT_NO 학번,STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE ASC;

--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의
--이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. 
--(* 이때 올바르게 작성한 SQL문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)
SELECT PROFESSOR_NAME 교수이름, PROFESSOR_SSN 주민번호
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';
--
--3. 춘 기술대학교의 남자 교수들의 이름을 출력하는 SQL 문장을 작성하시오. 단 이때
--나이가 적은 사람에서 많은 사람 순서(나이가 같다면 이름의 가나다 순서)로 화면에
--출력되도록 만드시오. (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름"
--으로 한다. 나이는 ‘만’으로 계산한다.)
--
SELECT PROFESSOR_NAME 교수이름
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1)=1
ORDER BY SUBSTR(PROFESSOR_SSN,1,2) DESC;

--4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는
--‚이름‛이 찍히도록 한다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
--
SELECT SUBSTR(PROFESSOR_NAME,2,LENGTH(PROFESSOR_NAME))
FROM TB_PROFESSOR;

--5. 춘 기술대학교의 재수생 입학자 학번과 이름을 표시하시오.(이때, 19 살에 입학하면
--재수를 하지 않은 것으로 간주)
--
SELECT STUDENT_NO 학번,STUDENT_NAME 이름
FROM TB_STUDENT
WHERE FLOOR(MONTHS_BETWEEN(ENTRANCE_DATE,TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD'))/12)+1 >19;

--6. 2020 년 크리스마스는 무슨 요일인가?
--
SELECT TO_CHAR(TO_DATE('20201225','YYYYMMDD'), 'DAY')AS CRISTMAS FROM DUAL;

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까? 
--또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YYYY/MM/DD'),TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YYYY/MM/DD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'YYYY/MM/DD'),TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'),'YYYY/MM/DD') FROM DUAL;
--
--8. 춘 기술대학교의 2000 년도 이후 입학자들은 학번이 A 로 시작하게 되어있다. 2000 년도
--이전 학번을 받은 학생들의 학번과 이름을 학번 순서로 표시하는 SQL 문장을 작성하시오.
SELECT STUDENT_NO 학번, STUDENT_NAME 이름
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%'
ORDER BY STUDENT_NO ASC;
--
--9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단,
--이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한
--자리까지만 표시한다.
SELECT TB_STUDENT.STUDENT_NO 학번, TB_STUDENT.STUDENT_NAME 이름, ROUND(AVG(TB_GRADE.POINT),1) 평점
FROM TB_STUDENT,TB_GRADE
WHERE TB_STUDENT.STUDENT_NO = TB_GRADE.STUDENT_NO AND TB_STUDENT.STUDENT_NO = 'A517178' 
GROUP BY TB_GRADE.STUDENT_NO, TB_STUDENT.STUDENT_NO, TB_STUDENT.STUDENT_NAME;
--
--10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이
--출력되도록 하시오.
SELECT  DEPARTMENT_NO 학과번호,COUNT(*)||'(명)' 학생수
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ASC;
--
--11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을
--작성하시오.
--
SELECT COUNT(*)||'(명)' 지도교수미배정학생수
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단,
--이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여
--소수점 이하 한 자리까지만 표시한다.
SELECT SUBSTR(TERM_NO,1,4)년도, ROUND(AVG(POINT),1) 년도별평점
FROM TB_GRADE
WHERE STUDENT_NO LIKE 'A112113' 
GROUP BY SUBSTR(TERM_NO,1,4);
--
--13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
--작성하시오.
--
SELECT DEPARTMENT_NO 학과코드명, COUNT(DECODE(ABSENCE_YN,'Y','재학생','')) 휴학생수
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

--14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 SQL
--문장을 사용하면 가능하겠는가
SELECT STUDENT_NAME 동명이인학생이름
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*)>1
ORDER BY STUDENT_NAME ASC;
--
--15. 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총
--평점을 년도 순서로 표시하는 SQL 문을 작성하시오. (단, 평점은 소수점 1 자리까지만
--반올림하여 표시한다.)

SELECT SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2), ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2));
