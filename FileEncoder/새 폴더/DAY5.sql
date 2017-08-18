-- DAY5 ��������

-- HAVING �� : GROUP BY �� �Ʒ��� �����
-- �ݵ�� GROUP BY �� �Բ� ����ؾ� ��
-- �׷� ��� ����� �׷��Լ� ������� ���� ����ó����.
-- SELECT �������� HAVING ó���� ���� ��ȸ��.

-- �μ��� �޿��հ� �� 9�鸸�� �ʰ��ϴ� �μ��� �޿��հ� ��ȸ
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING SUM(SALARY) > 9000000;

-- �м��Լ�
-- RANK() �Լ� : ���(����) ó���� ���

-- �ش� ���� ���� ������ �˰��� �� ��
-- RANK(������ �˰��� �ϴ� ��) WITHIN GROUP (ORDER BY �÷��� ���Ĺ��)

-- �޿� 230������ ��ü �޿� �� ������� �ش�Ǵ��� ��ȸ(�޿� ���� �������� ����)
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) ����
FROM EMPLOYEE;

-- ��ü ���� ������ �ű���� �� ���
-- RANK() OVER (ORDER BY �÷��� ���Ĺ��)
SELECT EMP_NAME, SALARY, 
        RANK() OVER (ORDER BY SALARY DESC) ����
FROM EMPLOYEE;

-- ROLLUP �Լ� : GROUP BY �������� �����
-- �׷캰�� ��� ���� ����� ���� �����踦 ���� �� �����
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY DEPT_ID;

SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);

SELECT DEPT_ID, SUM(SALARY), MAX(SALARY), MIN(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID);

-- CUBE �Լ� : GROUP BY �������� �����
-- ������ ����� ����. ���谪�� ���� ǥ�õ�
SELECT DEPT_ID, SUM(SALARY), MAX(SALARY), MIN(SALARY), AVG(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID);

-- ���� ���� �÷��� ��� �׷� ó���� ���
-- �μ��� ���޺� �޿��� �հ�

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID, JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID), ROLLUP(JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID), CUBE(JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(JOB_ID), ROLLUP(DEPT_ID);

-- GROUPING
-- SELECT ���� GROUP BY �������� �����
-- �÷� �׷� ���� �� �����
-- �׷� ��� ���� ���谪(1)����, �ƴ���(0) �����ϴ� �뵵�� �����
-- ROLLUP �� CUBE �Լ� ���� �̿��ϴ� �Լ���

SELECT DEPT_ID, JOB_ID, SUM(SALARY),
        GROUPING(DEPT_ID) "�μ��� �׷칭�� ����",
        GROUPING(JOB_ID) "���޺� �׷칭�� ����"
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY ROLLUP(DEPT_ID, JOB_ID);

SELECT DEPT_ID, JOB_ID, SUM(SALARY),
        GROUPING(DEPT_ID) "�μ��� �׷칭�� ����",
        GROUPING(JOB_ID) "���޺� �׷칭�� ����"
FROM EMPLOYEE
WHERE DEPT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY CUBE(DEPT_ID, JOB_ID);

-- GROUPING SETS
-- �׷캰�� ��� ����� ���� ���� SELECT ������ �ϳ��� ��ģ ����� ���� �� �����
-- ���տ�����(SET OPERATOR) �߿��� UNION ALL ���� ����� ������

SELECT DEPT_ID, JOB_ID, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID, JOB_ID, MGR_ID
UNION ALL
SELECT DEPT_ID, NULL, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID, MGR_ID
UNION ALL
SELECT NULL, JOB_ID, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY JOB_ID, MGR_ID;

-- ���� ó�������� GROUPING SETS ���� �ٲٸ�
SELECT DEPT_ID, JOB_ID, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_ID, JOB_ID, MGR_ID),
                           (DEPT_ID, MGR_ID),
                           (JOB_ID, MGR_ID));

SELECT DEPT_ID, JOB_ID, MGR_ID, AVG(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, (JOB_ID, MGR_ID));

-- ROWID : ���̺� �� �߰��� �ڵ����� �ο��Ǵ� ����̵�
-- ROWNUM ���� �ٸ�
-- �����ͺ��̽��� �ڵ����� �ο���. ���� �� ��. ��ȸ�� �� �� ����
SELECT ROWID, EMP_ID
FROM EMPLOYEE;

-- *****************************************
-- ����(JOIN) 
-- ���� ���� ���̺��� �ϳ��� ū ���̺�� ��ģ ����� ���� �� �����
-- ���� ������ ����Ŭ������ ����ϴ� ����Ŭ ���뱸���� 
-- ��� DBMS �� �������� ����ϴ� ǥ�ر����� ANSI ǥ�ر��� �� ������ ����� �� ����

-- ����Ŭ ���� ���� 
-- ��ĥ ���̺����� FROM ���� , �� �����ؼ� ������
-- ���̺��� ��ġ�� ���� �÷���� ���ǽ��� WHERE ���� �����
SELECT *
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;

-- ���̺���� ��Ī ��� ������
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- �����, �μ��� ��ȸ
SELECT EMP_NAME, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- ANSI ǥ�� ���� : ���� ó���� ���� ������ ������ �ۼ���
-- ��� DBMS �� �������� ����ϴ� ǥ�ر�����
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);

-- �⺻ JOIN �� EQUIL JOIN ��
-- ���ο� ���Ǵ� �÷����� ��ġ�ϴ� ��鸸 ������
SELECT EMP_NAME, DEPT_ID, LOC_ID, DEPT_NAME
FROM EMPLOYEE2
JOIN DEPARTMENT USING (DEPT_ID, LOC_ID);


-- ���ο� ����� �÷����� �ٸ� ��쿡�� ON �����
-- �÷��� �ٸ���, ��ϵ� ���� ���ƾ� ��
SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- ����Ŭ ���� ����
SELECT *
FROM DEPARTMENT, LOCATION
WHERE LOC_ID = LOCATION_ID;

-- ���, �����, ���޸� ��ȸ
-- ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;

-- ANSI ǥ�� ����
SELECT EMP_ID, EMP_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID);


-- JOIN ��������

-- 1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'YYYYMMDD DAY') 
FROM DUAL;


-- 2. �ֹι�ȣ�� 60��� ���̸鼭 ������ �����̰�, 
-- ���� �达�� �������� 
-- �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, EMP_NO, DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NO LIKE '6%'
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '��%';


-- 3. ���� ���̰� ���� ������ 
-- ���, �����, ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.

--������ �ּҰ� ��ȸ
SELECT MIN(TRUNC((MONTHS_BETWEEN(SYSDATE,
          TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) / 12))) ���� 
FROM EMPLOYEE;       

-- ��ȸ�� ������ �ּҰ��� �̿��� ������ ���� ��ȸ��
-- outer join �ʿ���.
SELECT EMP_ID, EMP_NAME, 
       MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 2), 
       'RR')) / 12))) ���� ,
       DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 2), 
       'RR')) / 12))) = 28;

-- ���������� ����� ��� *****************************
SELECT EMP_ID, EMP_NAME, 
       MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 2), 
       'RR')) / 12))) ���� ,
       DEPT_NAME, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
LEFT JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY EMP_ID, EMP_NAME, DEPT_NAME, JOB_TITLE
HAVING MIN(TRUNC((MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 2), 
       'RR')) / 12))) = (SELECT MIN(TRUNC((MONTHS_BETWEEN
                      (SYSDATE, 
                      TO_DATE(SUBSTR(EMP_NO, 1, 2), 
                                 'RR')) / 12))) ���� 
                      FROM EMPLOYEE);

-- 4. �̸��� '��'�ڰ� ���� �������� 
-- ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
WHERE EMP_NAME LIKE '%��%';


-- 5. �ؿܿ������� �ٹ��ϴ� 
-- �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_TITLE, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
WHERE DEPT_NAME LIKE '�ؿܿ���%'
ORDER BY 4;


-- 6. ���ʽ�����Ʈ�� �޴� �������� 
-- �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, BONUS_PCT, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
WHERE BONUS_PCT IS NOT NULL
AND BONUS_PCT <> 0.0;


-- 7. �μ��ڵ尡 20�� �������� 
-- �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
WHERE DEPT_ID = '20';


-- 8. ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�.
SELECT EMP_NAME, JOB_TITLE, SALARY, 
       (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 ����
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)       
WHERE (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 
      > MIN_SAL;


-- 9 . �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
-- �����(emp_name), �μ���(dept_name), ������(loc_describe),
--  ������(country_name)�� ��ȸ�Ͻÿ�.
SELECT EMP_NAME �����, DEPT_NAME �μ���,
       LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
JOIN COUNTRY USING (COUNTRY_ID)       
WHERE COUNTRY_ID IN ('KO', 'JP');

-- 10. ���� �μ��� �ٹ��ϴ� �������� 
-- �����, �μ��ڵ�, �����̸�, �μ��ڵ带 ��ȸ�Ͻÿ�.
-- self join ���
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, 
       C.EMP_NAME �����̸�, C.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E, EMPLOYEE C
WHERE E.EMP_NAME <> C.EMP_NAME
AND E.DEPT_ID = C.DEPT_ID
ORDER BY E.EMP_NAME;



-- 11. ���ʽ�����Ʈ�� ���� ������ �߿��� 
-- �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.

-- ��, join�� IN ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7') AND BONUS_PCT IS NULL;

-- ��, join�� set operator ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID = 'J4' AND BONUS_PCT IS NULL
UNION
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID = 'J7' AND BONUS_PCT IS NULL;



-- 12. �ҼӺμ��� 50 �Ǵ� 90�� ������ 
-- ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ') ��ȥ����, 
       COUNT(*) ������
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ')
ORDER BY 1;




