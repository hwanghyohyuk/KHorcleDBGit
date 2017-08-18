/*
분석함수
WINDOW 
PARTITON
CUME_DIST
WITH [NAME] AS [QUERY]
NTILE

http://bysql.net/index.php?document_srl=20905&mid=W201102S

*/

/*
1. WINDOW FUNCTION 개요

   행과 행간의 관계를 쉽게 정의하기 위해 만든 함수

 

·      WINDOW FUNCTION 종류
 
-      순위(RANK) 관련 함수 : RANK, DENSE_RANK, ROW_NUMBER  
(ANSI/ISO SQL 표준 / Oracle / SQL Server 등 대부분 DBMS 지원)

-      집계(AGGREGATE) 관련 함수 : SUM, MAX, MIN, AVG, COUNT  
(ANSI/ISO SQL 표준 / Oracle / SQL Server 등 대부분 DBMS지원)
* SQL Server의 경우 집계 함수는 OVER 절 내의 ORDER BY 구문을 지원하지 않는다.

-      행 순서 관련 함수 : FIRST_VALUE, LAST_VALUE, LAG, LEAD  
(Oracle에서만 지원되는 함수)

-      비율 관련 함수 : CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT, RATIO_TO_REPORT
(CUME_DIST, PERCENT_RANK : ANSI/ISO SQL 표준/Oracle 지원
 NTILE : Oracle / SQL Server 지원
 RATIO_TO_REPORT: Oracle 지원)

-      선형 분석을 포함한 통계 분석 관련 함수

(참조) Oracle의 통계 관련 함수
CORR, COVAR_POP, COVAR_SAMP, STDDEV, STDDEV_POP, STDDEV_SAMP, VARIANCE, VAR_POP, VAR_SAMP, REGR_(LINEAR REGRESSION), REGR_SLOPE, REGR_INTERCEPT, REGR_COUNT, REGR_R2, REGR_AVGX, REGR_AVGY, REGR_SXX, REGR_SYY, REGR_SXY

·        
  WINDOW FUNCTION SYNTAX
 
- WINDOW 함수에는 OVER 문구 필수
SELECT WINDOW_FUNCTION (ARGUMENTS) OVER ( PARTITION BY 칼럼 ORDER BY 절 WINDOWING 절 ) 
FROM 테이블 명;

- ARGUMENTS (인수)  : 함수에 따라 0 ~ N개의 인수 
- PARTITION BY 절 : 전체 집합을 기준에 의해 소그룹으로 나눌 수 있다. 
- ORDER BY 절 : 어떤 항목에 대해 순위를 지정할 지 ORDER BY 절을 기술한다. 
- WINDOWING 절 : WINDOWING 절은 함수의 대상이 되는 행 기준의 범위를 강력하게 지정할 수 있다. ROWS는 물리적인 결과 행의 수를, RANGE는 논리적인 값에 의한 범위를 나타내는데, 둘 중의 하나를 선택해서 사용할 수 있다. 
(다만, WINDOWING 절은 SQL Server에서는 지원하지 않는다.)

BETWEEN 사용 타입 
ROWS | RANGE BETWEEN 
UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING AND 
UNBOUNDED FOLLOWING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING

BETWEEN 미사용 타입 
ROWS | RANGE 
UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING

*/
/*
2. 그룹 내 순위 함수
*/
/*
가. RANK 함수 - 특정 항목(칼럼) / 특정 범위(PARTITION) / 전체 데이터에 대한 순위를 구하는 함수 
- 동일한 값에 대해서는 동일한 순위
*/
--예제 사원 데이터에서 급여가 높은 순서와 JOB 별로 급여가 높은 순서를 같이 출력한다.
SELECT JOB, ENAME, SAL, 
RANK( ) OVER (ORDER BY SAL DESC)  ALL_RANK, 
RANK( ) OVER (PARTITION BY JOB ORDER BY SAL DESC)  JOB_RANK 
FROM EMP;
-- ORDER BY SAL DESC 조건과 PARTITION BY JOB 조건이 충돌 : JOB 별로는 정렬 X, ORDER BY SAL DESC 조건으로 정렬(ALL_RANK과 JOB_RANK의 순서와는 상관없음)

SELECT JOB, ENAME, SAL, 
RANK( ) OVER (ORDER BY SAL DESC) ALL_RANK
FROM EMP;
-- 업무 구분이 없는 ALL_RANK 칼럼에서 같은 값이 있을 경우 동일 순번 반환
-- 동일 순번일 때 다음 순위를 뛰어넘고 출력. 예) 1, 2, 2, 4

 SELECT JOB, ENAME, SAL, 
 RANK( ) OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK 
 FROM EMP;
-- 업무를 PARTITION으로 구분한 JOB_RANK의 경우 같은 업무 내 범위에서만 순위를 부여

/*
나. DENSE_RANK 함수

- RANK 함수와 흡사하나, 동일한 순위를 하나의 건수로 취급하는 것이 틀린 점
*/
--예제 사원데이터에서 급여가 높은 순서와, 동일한 순위를 하나의 등수로 간주한 결과도 같이 출력한다. 
SELECT JOB, ENAME, SAL, 
RANK( ) OVER (ORDER BY SAL DESC) RANK, 
DENSE_RANK( ) OVER (ORDER BY SAL DESC) DENSE_RANK 
FROM EMP;
/*
다. ROW_NUMBER 함수

RANK나 DENSE_RANK 함수가 동일한 값에 대해서는 동일한 순위를 부여하는데 반해, 동일한 값이라도 고유한 순위를 부여
*/
--예제 사원데이터에서 급여가 높은 순서와, 동일한 순위를 인정하지 않는 등수도 같이 출력한다. 
SELECT JOB, ENAME, SAL, 
RANK( ) OVER (ORDER BY SAL DESC) RANK, 
ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUMBER 
FROM EMP;
-- SALARY에서는 어떤 순서가 정해질지 알 수 없다. 데이터베이스 별로 틀린 결과가 나올 수 있다. (Oracle의 경우 rowid가 적은 행이 먼저 나온다)
-- 동일 값에 대한 순서까지 관리하고 싶으면 ROW_NUMBER( ) OVER (ORDER BY SAL DESC, ENAME) 같이 ORDER BY 절을 이용해 추가적인 정렬 기준을 정의
/*
3. 일반 집계 함수
*/
/*
가. SUM 함수 – 파티션별 윈도우의 합
*/
 --예제 사원들의 급여와 같은 매니저를 두고 있는 사원들의 SALARY 합을 구한다. 
SELECT MGR, ENAME, SAL, 
SUM(SAL) OVER (PARTITION BY MGR) MGR_SUM 
FROM EMP;

--예제 OVER 절 내에 ORDER BY 절을 추가해 파티션 내 데이터를 정렬하고 이전 SALARY 데이터까지의 누적값을 출력한다. 
--(SQL Server의 경우 집계 함수의 경우 OVER 절 내의 ORDER BY 절을 지원하지 않는다.) 
SELECT MGR, ENAME, SAL, 
SUM(SAL) OVER (PARTITION BY MGR ORDER BY SAL RANGE UNBOUNDED PRECEDING) as MGR_SUM 
FROM EMP;
--RANGE UNBOUNDED PRECEDING : 현재 행을 기준으로 파티션 내의 첫 번째 행까지의 범위를 지정

--표시된 7698-WARD와 7698-MARTIN의 급여가 같으므로, 같은 ORDER로 취급하여 950+1250+1250=3450의 값이 되었다. 
--7698-TURNER의 경우 950+1250+1250+1500=4950의 누적합을 가진다.
/*
나. MAX 함수 – 파티션별 윈도우의 최대값
*/
 --예제 사원들의 급여와 같은 매니저를 두고 있는 사원들의 SALARY 중 최대값을 같이 구한다. 
SELECT MGR, ENAME, SAL, MAX(SAL) OVER (PARTITION BY MGR) as MGR_MAX  FROM EMP;

--예제 추가로, INLINE VIEW를 이용해 파티션별 최대값을 가진 행만 추출할 수도 있다. 
SELECT MGR, ENAME, SAL 
FROM ( 
        SELECT MGR, ENAME, SAL, MAX(SAL) OVER (PARTITION BY MGR) as IV_MAX_SAL 
        FROM EMP) 
WHERE SAL = IV_MAX_SAL ;
/*
다. MIN 함수 – 파티션별 윈도우의 최소값
*/
--예제 사원들의 급여와 같은 매니저를 두고 있는 사원들을 입사일자를 기준으로 정렬하고, SALARY 최소값을 같이 구한다. 
SELECT MGR, ENAME, HIREDATE, SAL, MIN(SAL) OVER(PARTITION BY MGR ORDER BY HIREDATE) as MGR_MIN FROM EMP;
SELECT MGR, ENAME, HIREDATE, SAL, MIN(SAL) OVER(PARTITION BY MGR) as MGR_MIN FROM EMP;
/*
라. AVG 함수
*/
--예제 EMP 테이블에서 같은 매니저를 두고 있는 사원들의 평균 SALARY를 구하는데, 조건은 같은 매니저 내에서 자기 바로 앞의 사번과 바로 뒤의 사번인 직원만을 대상으로 한다. 
SELECT MGR, ENAME, HIREDATE, SAL, 
ROUND (AVG(SAL) OVER (PARTITION BY MGR ORDER BY HIREDATE ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)) as MGR_AVG 
FROM EMP; 
-- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING : 현재 행을 기준으로 파티션 내에서 앞의 한 건, 현재 행, 뒤의 한 건을 범위로 지정한다. (ROWS는 현재 행의 앞뒤 건수를 말하는 것임)

-- ALLEN의 경우 파티션 내에서 첫 번째 데이터이므로 본인의 데이터와 뒤의 한 건으로 평균값을 구한다. 
--  (1600 + 1250) / 2 = 1425 
-- TURNER의 경우 앞의 한 건과, 본인의 데이터와, 뒤의 한 건으로 평균값을 구한다. 
--  (1250 + 1500 + 1250) / 3 = 1333
-- JAMES의 경우 파티션 내에서 마지막 데이터이므로 뒤의 한 건을 제외한, 앞의 한 건과 본인의 데이터를 가지고 평균값을 구한다. 
--  (1250 + 950) / 2 = 1100
/*
마. COUNT 함수
*/
--예제 사원들을 급여 기준으로 정렬하고, 본인의 급여보다 50 이하가 적거나 150 이하로 많은 급여를 받는 인원수를 출력하라. 
SELECT ENAME, SAL, COUNT(*) OVER (ORDER BY SAL RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING) as SIM_CNT FROM EMP; 
--RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING : 현재 행의 급여값을 기준으로 급여가 -50에서 +150의 범위 내에 포함된 모든 행이 대상이 된다. (RANGE는 현재 행의 데이터 값을 기준으로 앞뒤 데이터 값의 범위를 표시하는 것임)