-- DAY8 ��������

-- WITH �̸� AS (������)
-- SELECT * FROM �̸�;
-- �ַ� �ζ��� ��� ���� ���������� ����
-- ���� ���������� ���� �� ���� ��� �������� ����� �ߺ��� ���� �� �ְ�
-- ���� �ӵ��� �������ٴ� ������ ����

-- NATURAL JOIN
-- ������ ���̺��� �⺻Ű(PRIMARY KEY) �÷��� �̿��� EQUIL JOIN + INNER JOIN ��
SELECT *
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT;

-- �μ��� �޿��� �հ谡 ��ü �޿� ������ 20%���� ���� �޴� 
-- �μ���, �μ��� �޿��հ� ��ȸ��

-- �Ϲ� SQL ��
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT  -- department �� �⺻Ű�� join ��.
GROUP BY DEPT_NAME
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2
                        FROM EMPLOYEE);

-- WITH ��� SQL ��
WITH TOTAL_SAL AS (SELECT DEPT_NAME, SUM(SALARY) SSAL
                    FROM EMPLOYEE
                    NATURAL JOIN DEPARTMENT
                    GROUP BY DEPT_NAME)
SELECT DEPT_NAME, SSAL
FROM TOTAL_SAL   -- �ζ��� ��
WHERE SSAL > (SELECT SUM(SALARY) * 0.2
                FROM EMPLOYEE);

-- *********************************************************
-- �м��Լ�(�������Լ�)
/*
����Ŭ �м��Լ��� �����͸� �м��ϴ� �Լ��̴�.
�м� �Լ��� ����ϸ�, ���� ������ ����� RESULT SET �� ������� ��
��ü �׷캰�� �ƴ� �ұ׷캰�� �� �࿡ ���� �м� ������� ������ 

�Ϲ� �׷��Լ���� �ٸ� ���� �м��Լ��� �м��Լ��� �׷��� ������ �����ؼ�
�� �׷��� ������� ����� �����Ѵٴ� ���̴�.

�̶� �м��Լ��� �׷��� ����Ŭ������ ������(WINDOW)��� �θ���.
*/

-- �������
/*
�м��Լ��� ([��������1, ��������2, ��������3]) OVER ([���� PARTITION��] 
                                           [ORDER BY ��] 
                                           [WINDOW ��])
FROM ���̺��;

�м��Լ� ���� : AVG, SUM, RANK, MAX, MIN, COUNT ��
�������� : �м��Լ��� ���� 0~3���� ���� ����� �� ����
���� PARTITION �� : PARTITION BY ǥ����
            PARTITION BY �� �����ϸ�, ǥ���Ŀ� ���� �׷캰�� ���� ��������� �и���
            ��, �м��Լ��� ��� ��� �׷��� �����ϴ� ������
ORDER BY �� : PARTITION �� �ڿ� ��ġ�ϸ�, ��� ��� �׷��� ������ ������
            ORDER BY �÷��� ���Ĺ��(ASC|DESC)
WINDOW �� : �м� ����� �Ǵ� �����͸� �� �������� ������ �� ���������� ������
            PARTITION BY �� ���� �������� �׷� �ȿ��� �м��� ������ ������
*/

-- ��� �ű�� �Լ� : RANK
-- ���� ����� ���� �� ���� ���� ���� ������� �ǳʶ�
-- �� : 1, 2, 2, 4

-- �޿��� ������ �ű�ٸ�
SELECT EMP_ID, EMP_NAME, SALARY,
        RANK() OVER (ORDER BY SALARY DESC) �޿�����
FROM EMPLOYEE;

-- ���ϴ� ���� ������ ��ȸ�ϰ� �ʹٸ�
-- �޿� 230���� ���� ��ȸ
SELECT RANK(2300000) WITHIN GROUP (ORDER BY SALARY DESC) ����
FROM EMPLOYEE;

-- DENSE_RANK() : ���� ������ ���� ���϶� ���� ������ �ǳʶ��� ����
-- �� : 1, 2, 2, 3
SELECT EMP_NAME, DEPT_ID, SALARY,
        RANK() OVER (ORDER BY SALARY DESC) "����1",
        DENSE_RANK() OVER (ORDER BY SALARY DESC) "����2",
        DENSE_RANK() OVER (PARTITION BY DEPT_ID
                             ORDER BY SALARY DESC) "����3"
FROM EMPLOYEE
ORDER BY DEPT_ID;

-- RANK �� �̿��� TOP-N �м�
SELECT *
FROM (SELECT EMP_NAME, SALARY,
       RANK() OVER (ORDER BY SALARY DESC) ����
       FROM EMPLOYEE)
WHERE ���� <= 5; -- ���� 5���� ���� ��ȸ       

-- �޿� ������(��������) 11������ �ش��ϴ� ���� ���� ��ȸ
-- �̸� �޿� ����
SELECT * 
FROM (SELECT EMP_NAME, SALARY,
               RANK() OVER (ORDER BY SALARY DESC) ����
       FROM EMPLOYEE)
WHERE ���� = 11;

-- CUME_DIST() : CUMulativE DISTribution
-- PARTITION BY �� �׷��� ������, �� �׷� ���� �࿡ ���� ORDER BY ������ ����
-- �� �׷캰 �л�����(������� ��ġ)�� ���ϴ� �Լ���
-- �� ���� �׷� ���� �� ����� ���� ���� �ǹ���
-- 0 < �л����� <= 1 ������ ����

-- �μ��ڵ尡 50�� ������ �̸�, �޿�, �޿������л� ��ȸ
SELECT EMP_NAME, SALARY,
        ROUND(CUME_DIST() OVER (ORDER BY SALARY), 1) �޿������л�
FROM EMPLOYEE
WHERE DEPT_ID = '50';

-- NTILE()
-- PARTITION �� BUCKET �̶� �Ҹ��� �׷캰�� ������
-- PARTITION ���� �� ���� �� BUCKET �� ��ġ ����ϴ� �Լ�
-- ���� ��� PARTITION �ȿ� 100���� ���� �ִٸ�, BUCKET �� 4���� ���ϸ�
-- 1���� BUCKET�� 25���� ���� ��е�
-- ��Ȯ�ϰ� ��е��� ���� ���� �ٻ�ġ�� ����� �Ŀ� ���� ���� ���� ���� BUCKET �� �Ҵ�

-- �޿��� 4������� �з�
SELECT EMP_NAME, SALARY,
        NTILE(4) OVER (ORDER BY SALARY) ���
FROM EMPLOYEE;


-- ROW_NUMBER()
-- ROWNUM ���� ���谡 ����
-- �� PARTITION ���� ������ ORDER BY ���� ���� ������ ������ ������� ���� �ο���

-- ���, �̸�, �޿�, �Ի���, ����
-- �� ������ �޿��� ���� ������, ���� �޿��� �Ի����� ���� ������ �ο���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE,
        ROW_NUMBER() OVER (ORDER BY SALARY DESC, HIRE_DATE ASC) ����
FROM EMPLOYEE;


-- �����Լ�

-- ���� ���̺��� �μ��ڵ尡 60�� ��������
-- ���, �޿�, �ش� �μ��׷�(�������� ��) ������ ����� �������� �����ϰ�
-- �޿��� �հ踦 ù����� ����������� ���ؼ� WIN1 ��,
-- �������� ��������� ���� ��ġ������ �հ踦 ���ؼ� WIN2 ��,
-- �������� �����࿡�� ������������� �հ踦 ���ؼ� WIN3 �� �����

SELECT EMP_ID, SALARY,
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN UNBOUNDED PRECEDING
                            AND UNBOUNDED FOLLOWING) "WIN1",
-- ROWS : �κб׷��� �������� ������ �� ������ �ǹ���
-- UNBOUNDED PRECEDING : �������� ù ��
-- UNBOUNDED FOLLOWING : �������� ������ ��
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN UNBOUNDED PRECEDING
                            AND CURRENT ROW) "WIN2",
-- CURRENT ROW : ���� ��      
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN CURRENT ROW
                            AND UNBOUNDED FOLLOWING) "WIN3"
FROM EMPLOYEE
WHERE DEPT_ID = '60';


SELECT EMP_ID, SALARY,
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN 1 PRECEDING
                            AND 1 FOLLOWING) "WIN1",
-- 1 PRECEDING AND 1 FOLLOWING
-- ���� ���� �߽����� ������� �������� ���踦 �ǹ���
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN 1 PRECEDING
                            AND CURRENT ROW) "WIN2",
        SUM(SALARY) OVER (PARTITION BY DEPT_ID
                            ORDER BY EMP_ID
                            ROWS BETWEEN CURRENT ROW
                            AND 1 FOLLOWING) "WIN3"
FROM EMPLOYEE
WHERE DEPT_ID = '60';

-- RATIO_TO_REPORT
-- �ش� �������� �����ϴ� ������ �����ϴ� �Լ�

-- �������� �ѱ޿��� 2õ���� ������ų ��, ���� ���޺����� �����ؼ�
-- �� ������ �ްԵ� �޿��� ������ ��ȸ
SELECT EMP_NAME, SALARY,
        LPAD(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 100, 0), 5)
        || ' %' ����,
        TO_CHAR(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 20000000, 0),
        'L00,999,999') "�߰��� �ްԵ� �޿�"
FROM EMPLOYEE;


-- LAG(��ȸ�� ����, ������ġ, ���� ������ġ)
-- �����ϴ� �÷��� ���� ���� �������� ���� ��(��)�� ���� ��ȸ��
SELECT EMP_NAME, DEPT_ID, SALARY,
        LAG(SALARY, 1, 0) OVER (ORDER BY SALARY) ������,
        -- 1 : ���� �� ��, 0 : �������� ������ 0 ó����
        LAG(SALARY, 1, SALARY) OVER (ORDER BY SALARY) "��ȸ2",
        LAG(SALARY, 1, SALARY) OVER (PARTITION BY DEPT_ID
                                      ORDER BY SALARY) "��ȸ3"
        -- �μ� �׷� �ȿ����� ���� �ప ��ȸ��
FROM EMPLOYEE;











