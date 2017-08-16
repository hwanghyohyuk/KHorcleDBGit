-- DAY6 ��������

-- JOIN(����)
-- ���� ���� ���̺��� �ϳ��� ū ���̺�� ��ģ ����� ���� �� �����
-- ����Ŭ������ ����ϴ� ����Ŭ ���� ������ 
-- ��� DBMS �� �������� ����ϴ� ǥ�ر����� ANSI ǥ�ر����� ����

-- ����Ŭ ���뱸�� : ��ĥ ���̺���� FROM ���� , �� �����ؼ� ������
-- ���̺��.�÷������� �̸��� �ߺ��Ǵ� �÷��� �տ� ���̺���� ����ؾ� ��
-- ���̺���� �����ϰ� ǥ���ϱ� ���� ���̺� ��Ī�� ������ �� ����
-- FROM ���̺�� ��Ī, ���̺�� ��Ī
-- ���̺��� ��ġ�� ���� ���Ǵ� �÷���� ���ǽ��� WHERE ���� �����
-- ������ WHERE ���� ������ ���� ���ǽİ� ���� �����ϱ� ���� ���ǽ��� �Բ� ����

-- �� : EMPLOYEE ���̺�� DEPARTMENT ���̺��� ������ ���
SELECT * 
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_ID = DEPARTMENT.DEPT_ID;

-- ���̺��� ��Ī�� ������ ���
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

--�����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_NAME, E.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;


-- ANSI ǥ�ر���
-- ���� ó���� ���� ������ ������ �ۼ���
-- ��� DBMS �� �������� ����ϴ� ǥ�� ������
-- FROM �� �ٷ� �Ʒ��� JOIN �̶�� Ű���带 ����Ͽ� ������ ǥ����
/*
  FROM �������̺��
  [INNER] JOIN ��ĥ ���̺�� USING (��ġ�⿡ ����� �÷���) -- �÷����� ���� ���
  JOIN ���̺�� ON (�÷��� = �÷���)  -- ��ϵ� ���� ������ �÷����� �ٸ� ���
  LEFT/RIGHT/FULL [OUTER] JOIN ���̺�� ON (�÷��� = �÷���) -- ���̺� ��Ī ��� ������
  LEFT/RIGHT/FULL [OUTER] JOIN ���̺�� USING (�÷���) -- ���̺� ��Ī ��� �� ��
  NATURAL JOIN ���̺��  -- �� ���̺��� �⺻Ű(PRIMARY KEY) �÷����� ������
  CROSS JOIN ���̺�� -- �� ���̺��� ��� X ��� �� ���ΰ���� ����
*/
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID);

SELECT *
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM EMPLOYEE
INNER JOIN DEPARTMENT USING (DEPT_ID);

-- INNER JOIN
-- ��ġ�⿡ ����� �÷��� ��ϵ� ������ �����ؼ� �� ������ ���� ó����
-- �� ���̺��� �������� ��ϵ� ���鸸 ���� ó����
-- �� ���̺��� �÷����� ��ġ���� ���� ���� ���ο��� ���ܵ�
-- EMPLOYEE �� 90 = DEPARTMENT �� 90 �� �������� �����
-- EMPLOYEE �� NULL = DEPARTMENT �� NULL �� ����Ǿ�� ��
-- NULL ���� ��ϵ� ���� DEPARTMENT �� ��ġ�ϴ� ���� �����Ƿ� ���ο��� ���ܵ�

-- ���࿡ EMPLOYEE �� ��ġ�ϴ� NULL �� ���� �����鵵 ���ο� ���Խ��Ѿ� �� ���
-- ��, EMPLOYEE �� ��� ���� ���ο� ���Խ�Ű���� �� ��쿡�� OUTER ������ �����
-- ��ġ���� ���� ���� ���� �൵ ���ο� ���Խ�Ű�� ���� OUTER �����̶�� ��

-- INNER JOIN ����Ŭ���뱸��
SELECT *
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID;

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE
INNER JOIN JOB USING (JOB_ID);

-- EMPLOYEE �� ��� �������� ���ο� ���Խ�Ű����
-- OUTER JOIN ����Ŭ���뱸��
SELECT *
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+);

SELECT EMP_NAME, E.JOB_ID, J.JOB_ID, JOB_TITLE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID(+);

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE
--LEFT OUTER JOIN JOB USING (JOB_ID);
LEFT JOIN JOB USING (JOB_ID);

SELECT EMP_ID, JOB_ID, JOB_TITLE
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID);

-- INNER JOIN �� OUTER JOIN�� �� �� EQUIL JOIN ��
-- �� ���̺��� ������ �÷��� ���� ��ġ�ϴ� �ೢ�� ���� ���ε�

SELECT EMP_NAME, E.DEPT_ID, D.DEPT_ID, DEPT_NAME
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID(+);

SELECT EMP_NAME, DEPT_ID, DEPT_NAME
FROM DEPARTMENT
RIGHT OUTER JOIN EMPLOYEE USING (DEPT_ID);

-- EMPLOYEE �� DEPARTMENT �� ������ ���
-- DEPARTMENT �� ��� ���� ������ ���ο� ���Խ�Ű���� �Ѵٸ�

-- ����Ŭ���뱸��
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID;

-- ANSI ǥ�ر���
SELECT *
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT USING (DEPT_ID);

-- �� ���̺��� ��� ���� ������ ���ο� ���Խ�Ű���� �Ѵٸ�, FULL OUTER JOIN �̶�� ��

-- ����Ŭ���뱸�������� FULL OUTER JOIN ó�� �� ��
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID(+) = D.DEPT_ID(+);

-- ANSI ǥ�� ����
SELECT *
FROM EMPLOYEE
--FULL OUTER JOIN DEPARTMENT USING (DEPT_ID);
FULL JOIN DEPARTMENT USING (DEPT_ID);


-- ���� ���� �÷��� ��� USING ó���� ���
-- ������ �÷������� �ϳ��� ������ ���� EQUIL ó����
-- 10A1 = 10A1 ���ο� ���Ե�
-- 10A1 = 10A2 ���ο��� ���ܵ�
SELECT DEPT_ID, LOC_ID
FROM DEPARTMENT
ORDER BY DEPT_ID;

SELECT DEPT_ID, LOC_ID
FROM EMPLOYEE2
ORDER BY DEPT_ID;

SELECT EMP_ID, DEPT_ID, LOC_ID
FROM EMPLOYEE2
JOIN DEPARTMENT USING (DEPT_ID, LOC_ID);

-- ���� ������ �÷����� �ٸ� ���, �� ��ϰ��� ����
-- JOIN ON �����
SELECT *
FROM DEPARTMENT, LOCATION
WHERE LOC_ID = LOCATION_ID;

SELECT *
FROM DEPARTMENT
JOIN LOCATION ON (LOC_ID = LOCATION_ID);

-- CROSS JOIN 
-- �� ���̺��� ��ĥ ���� �÷��� ���� ��쿡 �����
-- ù��° ���̺��� ��� X �ι�° ���̺� ��� �� ����� ����
SELECT *
FROM DEPARTMENT, LOCATION;  -- 7�� X 5�� => 35���� ����

SELECT *
FROM DEPARTMENT
CROSS JOIN LOCATION;


-- NON EQUIL JOIN
-- ���ο� �����ϴ� �÷����� ��ġ�ϴ� ���� �ƴ϶�,
-- ���� ������ ���ԵǴ� ����� �����ϴ� ���� ���
SELECT *
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST);

-- SELF JOIN 
-- ���� ���̺��� �� �� �����ϴ� ���
-- ���� ���̺� ���� �ٸ� �÷��� �ܺ� ����Ű�� ����ϴ� ��쿡 �ַ� �����
SELECT *
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);

SELECT *
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- �����̸��� �� ������ �������̸� ��ȸ
SELECT E.EMP_NAME �����̸�, M.EMP_NAME �������̸�
FROM EMPLOYEE E
JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID);


-- N���� ���̺� ����
--SELECT *
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
JOIN COUNTRY USING (COUNTRY_ID);

-- ����Ŭ ���� ����
SELECT EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, COUNTRY_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND L.COUNTRY_ID = C.COUNTRY_ID;

-- ������ �븮�̸鼭, �ƽþ������� �ٹ��ϴ� ���� ��ȸ
-- ���, �̸�, ���޸�, �μ���, �ٹ�������, �޿� ��ȸ

-- ANSI ǥ�ر���
SELECT EMP_ID, EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOC_ID = LOCATION_ID)
WHERE JOB_TITLE = '�븮' AND LOC_DESCRIBE LIKE '�ƽþ�%';

-- ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, JOB_TITLE, DEPT_NAME, LOC_DESCRIBE, SALARY
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_ID = J.JOB_ID
AND E.DEPT_ID = D.DEPT_ID
AND D.LOC_ID = L.LOCATION_ID
AND JOB_TITLE = '�븮' 
AND LOC_DESCRIBE LIKE '�ƽþ�%';


-- �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
-- �����(emp_name), �μ���(dept_name), ������(loc_describe), ������(country_name)�� ��ȸ�Ͻÿ�.

-- ANSI
SELECT EMP_NAME �����, DEPT_NAME �μ���,
       LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOC_ID)
JOIN COUNTRY USING (COUNTRY_ID)       
WHERE COUNTRY_ID IN ('KO', 'JP');
--WHERE COUNTRY_ID = 'KO' OR COUNTRY_ID = 'JP';

-- ORACLE
SELECT EMP_NAME �����, DEPT_NAME �μ���,
       LOC_DESCRIBE ������, COUNTRY_NAME ������
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, COUNTRY C
WHERE E.DEPT_ID = D.DEPT_ID
AND L.LOCATION_ID = D.LOC_ID
AND L.COUNTRY_ID = C.COUNTRY_ID       
AND L.COUNTRY_ID IN ('KO', 'JP');


-- ���޺� ������ �ּұ޿�(MIN_SAL)���� ���� �޴� ��������
-- �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- ������ ���ʽ�����Ʈ�� �����Ͻÿ�.

-- ANSI
SELECT EMP_NAME, JOB_TITLE, SALARY, 
       (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 ����
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)       
WHERE (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;
      
-- ORACLE
SELECT EMP_NAME, JOB_TITLE, SALARY, 
       (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 ����
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID       
AND (SALARY + NVL(BONUS_PCT, 0) * SALARY) * 12 > MIN_SAL;


-- ���ʽ�����Ʈ�� ���� ������ �߿��� 
-- �����ڵ尡 J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.

-- ANSI
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_ID IN ('J4', 'J7') 
AND BONUS_PCT IS NULL OR BONUS_PCT = 0.0;

-- ORACLE
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_ID = J.JOB_ID 
AND E.JOB_ID IN ('J4', 'J7') 
AND BONUS_PCT IS NULL OR BONUS_PCT = 0.0;


-- ���� �μ��� �ٹ��ϴ� �������� 
-- �����, �μ��ڵ�, �����̸�, �μ��ڵ带 ��ȸ�Ͻÿ�.
-- self join ���

-- ANSI
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, 
       C.EMP_NAME �����̸�, C.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E
JOIN EMPLOYEE C ON (E.DEPT_ID = C.DEPT_ID)
WHERE E.EMP_NAME <> C.EMP_NAME
ORDER BY E.EMP_NAME;

-- ORACLE
SELECT E.EMP_NAME �����, E.DEPT_ID �μ��ڵ�, 
       C.EMP_NAME �����̸�, C.DEPT_ID �μ��ڵ�
FROM EMPLOYEE E, EMPLOYEE C
WHERE E.DEPT_ID = C.DEPT_ID
AND E.EMP_NAME <> C.EMP_NAME
ORDER BY E.EMP_NAME;


-- GROUP BY, �׷��Լ� ���
-- �ҼӺμ��� 50 �Ǵ� 90�� ������ 
-- ��ȥ�� ������ ��ȥ�� ������ ���� ��ȸ�Ͻÿ�.
-- ��ȥ����, ������ 
SELECT DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ') ��ȥ����, 
       COUNT(*) ������
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
GROUP BY DECODE(MARRIAGE, 'Y', '��ȥ', 'N', '��ȥ')
ORDER BY 1;








