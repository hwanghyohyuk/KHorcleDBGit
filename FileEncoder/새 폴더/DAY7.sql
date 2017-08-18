-- DAY7 ��������

-- ��������(SUBQUERY)
-- ������ �ȿ��� ���Ǵ� ������
-- ���������� ��ȸ�� ������� ���������� ����ϰ� ��
-- ���������� ���� : ������ ��������, ������ ��������, ���߿� ��������, ���߿� ������ ��������
-- ��[ȣ��]����������, ��Į�� �������� ���� ����

-- ������ ��������(SINGLE ROW SUBQUERY)
-- ���������� ��ȸ�� ������� ������ �� ���� ���
-- �������� �տ� �Ϲ� �񱳿����� ����� �� ����
-- <, > , <=, >=, = , !=/<>/^=

-- �μ��� �޿��� �հ� �� ���� ū �� ��ȸ
-- �μ���, �޿��հ�
SELECT DEPT_NAME, SUM(SALARY)
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID);  -- ������ ��������

-- ���������� SELECT, FROM, WHERE, HAVING, ORDER BY ������ ��� ������

-- ������(MULTI ROW) ��������
-- ���������� ��ȸ�� ������� ������ ���� ���� ���

-- �μ��� ���� �޿� ��ȸ
SELECT MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID;

-- �μ����� �� �μ����� ���� �޿��� �ް� �ִ� ���� ��ȸ
-- ���, �޿�
SELECT EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                  FROM EMPLOYEE
                  GROUP BY DEPT_ID);  -- ������ ��������

-- ������ �������� �տ��� �Ϲ� �񱳿����� ��� �� ��
-- �Ϲ� �񱳿����ڴ� �� ���� ���� ������ ���ϱ� ������
-- ���� ���� ������ �� �����ϴ� �����ڸ� ����ؾ� ��
-- IN | NOT IN (���� ���� �� ����)
--   : ���� ���� �� �߿� �� ���� ���� ���� �ִٸ� | ���ٸ�

SELECT EMP_ID, EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY)
                  FROM EMPLOYEE
                  GROUP BY DEPT_ID);  -- ������ ��������

-- �÷��� > ANY | < ANY (������ ��������)
--  : ���� ���� �� �߿� �Ѱ��� ū | ���� ���
--   �ּҰ����� ũ��? | �ִ밪���� ������?

-- �÷��� > ALL | < ALL (������ ��������)
--  : ���������� ��ȸ�� ��� ������ ū | ���� ���
--   �ִ밪���� ũ��? | �ּҰ����� ������?

-- �÷��� EXIST | NOT EXIST (������ ��������)
-- �ش� �÷����� �������� ������� �����ϴ��� | �������� �ʴ���?

-- IN | NOT IN
-- ���� ���� ���� ���ؼ� ���� ���� �ִ��� | ���� ���� ������ ����

-- ������ ��� ��ȸ : 15���� ����� ���� => ���������� ����ϸ�, ������ ����������
SELECT MGR_ID
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL;

-- ���� �������� �����ڸ� ��ȸ
-- ���, �̸�, '������' ����
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE)
UNION
-- �����ڰ� �ƴ� ������ ��ȸ
-- ���, �̸�, '����' ����
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT MGR_ID FROM EMPLOYEE 
                      WHERE MGR_ID IS NOT NULL)
ORDER BY 3, 1;                      

-- SELECT �������� �������� ����� �� ����
-- ���� ����� �����ϰ� ���� ���
SELECT EMP_ID, EMP_NAME,
        CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) THEN '������'
              ELSE '����'        
        END
FROM EMPLOYEE
ORDER BY 3, 1;


-- > ANY : ���� ���� ������ ũ�� 
-- < ANY : ���� ū �� ���� ������

-- �븮 ������ ���� �߿��� ���� ������ �ּ� �޿����� ���� �޴� ���� ��ȸ
-- ���, �̸�, ���޸�, �޿� 
SELECT EMP_ID, EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮' 
AND SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEE
                    LEFT JOIN JOB USING (JOB_ID)
                    WHERE JOB_TITLE = '����');


-- > ALL : ���� ū ������ ũ��
-- < ALL : ���� ���� ������ ������

-- ���� ������ �޿��� ���� ū������ ���� �޴� �븮 ������ ���� ��ȸ
-- �̸�, ���޸�, �޿�
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ALL (SELECT SALARY
                   FROM EMPLOYEE
                   LEFT JOIN JOB USING (JOB_ID)
                   WHERE JOB_TITLE = '����');

-- ���������� ��� ��ġ
-- SELECT ��, FROM ��, WHERE ��, GROUP BY ��, HAVING ��, ORDER BY ��
-- INSERT ��, UPDATE ��, CREATE TABLE ��, CREATE VIEW ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ
-- �̸�, ���޸�, �޿�
-- �񱳰��� �ڸ����� ���� �ݿø� �Ǵ� ����ó�� �ʿ���

-- ���޺� ��ձ޿� ��ȸ
SELECT JOB_ID, TRUNC(AVG(SALARY), -5)
FROM EMPLOYEE
GROUP BY JOB_ID;
-- ���������� ���

SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE SALARY IN (SELECT TRUNC(AVG(SALARY), -5)
                   FROM EMPLOYEE
                   GROUP BY JOB_ID);

-- FROM ������ �������� ����� �� ���� : ���̺� ��ſ� �����
-- FROM (��������) ��Ī
-- ���������� ��� RESULT SET �� ���̺� ������� �����
-- �ζ��� ��(INLINE VIEW)��� �� : FROM ���� ���� ���������� ���� �������

-- ANSI ǥ�� �������� ���� ó���� ���̺� ��Ī ����ϴ� ����
-- ON ���ÿ��� ������

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ : INLINE VIEW ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY), -5) JOBAVG
       FROM EMPLOYEE
       GROUP BY JOB_ID) V  -- �ζ��� ��
LEFT JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY
                           AND NVL(V.JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
ORDER BY 3, 2;

-- ��[ȣ��]��(COLLERATED) ��������
-- ��κ��� ���������� ���������� ���� ����� ���������� ����Ͽ���
-- ��������� ���������� ���������� �÷����� ������ ����� ����
-- �׷��� ������ ���������� �÷����� �ٲ��, ���������� ����� �޶����� ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ��ȸ : ��������� ����� ���
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_ID = J.JOB_ID)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY), -5)
                  FROM EMPLOYEE
                  WHERE NVL(JOB_ID, ' ') = NVL(E.JOB_ID, ' '))
ORDER BY 2;


-- ������ ���߿� ��������
-- ���������� SELECT �� �׸��� �� ���̻��� ���(���߿�), 
-- ���������� �������� ������(������)
-- ���������� ���� �׸��� 
-- �ݵ�� ���������� SELECT �׸�� ������ �ڷ����� ��ġ���Ѿ� ��
-- ���������� ���� �׸��� �ݵ�� () �ȿ� �����־�� ��

-- �ڱ� ������ ��� �޿��� �޴� ���� ���� ��ȸ  (������ ���߿� ���������� ����� ���)
SELECT EMP_NAME, JOB_TITLE, SALARY
FROM EMPLOYEE
LEFT JOIN JOB USING (JOB_ID)
WHERE (NVL(JOB_ID, ' '), SALARY) IN (SELECT NVL(JOB_ID, ' '), TRUNC(AVG(SALARY), -5)
                                    FROM EMPLOYEE
                                    GROUP BY NVL(JOB_ID, ' '))
ORDER BY 2;


-- ���������� ���� ����� �����ϴ��� ��� �� EXISTS ������ �����
-- ��[ȣ��]�� ������ ����� ��� �̿���

-- �������� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, '������' ����
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
                FROM EMPLOYEE
                WHERE E.EMP_ID = MGR_ID);
-- ���������� ������ �����ϴ� ��鸸 �߷���

-- NOT EXISTS : ���������� ������ �����ϴ� ���� �������� �ʴ���?
SELECT EMP_ID, EMP_NAME, '����' ����
FROM EMPLOYEE E
WHERE NOT EXISTS (SELECT NULL
                    FROM EMPLOYEE
                    WHERE E.EMP_ID = MGR_ID);
-- ���������� ������ �������� �ʴ� ��鸸 �߷���

-- ��Į�� ��������
-- �� ���� �� �÷��� ���� ��ȯ�ϴ� ��� ��������
-- ������ �������� + �������

-- �����, �μ��ڵ�, �޿�, �ش� ������ �Ҽӵ� �μ��� �޿� ��� ��ȸ
SELECT EMP_NAME, DEPT_ID, SALARY,
       (SELECT TRUNC(AVG(SALARY), -5) -- �ҼӺμ��� �޿� ��� �� 1 ��
        FROM EMPLOYEE
        WHERE DEPT_ID = E.DEPT_ID) AS AVGSAL
FROM EMPLOYEE E; 

-- CASE ǥ������ �̿��� ��Į�� �������� ���
-- �μ��� �ٹ������� 'OT' �̸� '������', �ƴϸ� '������' ���� ������ �ٹ������� ����
-- �Ҽ��� ��ȸ��
-- ���, �̸�, �Ҽ�
SELECT EMP_ID, EMP_NAME,
        (CASE WHEN DEPT_ID = (SELECT DEPT_ID
                                FROM DEPARTMENT
                                WHERE LOC_ID = 'OT')
              THEN '������'
              ELSE '������'
         END) AS �Ҽ�
FROM EMPLOYEE
ORDER BY �Ҽ� DESC;

-- ORDER BY ���� ��Į�� �������� ��� ��
-- ������ �Ҽӵ� �μ��� �μ����� ū ������ �����ؼ� ���� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_ID, HIRE_DATE
FROM EMPLOYEE E
ORDER BY (SELECT DEPT_NAME FROM DEPARTMENT
            WHERE DEPT_ID = E.DEPT_ID) DESC;


-- TOP-N �м� ***********************************************
-- ���� �� ��, ���� �� ���� ��ȸ�� ��

-- 1. �ζ��� ��� RANK() �Լ��� �̿��� TOP-N �м� ��
-- ���� �������� �޿��� ���� �޴� ���� 5�� ��ȸ
SELECT *
FROM (SELECT EMP_NAME, SALARY, 
               RANK() OVER (ORDER BY SALARY DESC) ����
       FROM EMPLOYEE) 
WHERE ���� <= 5;

-- ROWNUM(���ȣ) �� �̿��� TOP-N �м�
-- ���� ROWNUM �� SELECT �� ����࿡ �ο��Ǵ� �� ��ȣ��
-- ORDER BY �� ����� ROWNUM �� ���� 
--    => ������ ORDER BY ���� ROWNUM �� �ο���
--    �ذ��� ���������� �̿��� : SELECT ���� ORDER BY ó���ϱ� ����

SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- ORDER BY ���� ROWNUM �� �ο��ǹǷ�, ���ĵǸ鼭 ROWNUM �� �ڼ���

-- �޿� ���� �޴� ���� 3�� ��ȸ
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 4
ORDER BY SALARY DESC;  -- ���� ����� Ʋ��
-- �޿� ���� ������ ���� ���� ROWNUM �� �����Ǿ���
-- ������ �̿��� ���� �� ���� ��󳻴� �۾��� �� ��
-- �ذ� ����� ���ĵǰ� ���� ROWNUM �� �ο��ǰԲ� �ϸ� ������
-- �ζ��� �並 �̿��ϸ� ��

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
       FROM EMPLOYEE
       ORDER BY SALARY DESC)  -- ���� �Ŀ� ROWNUM �ο��ǰ� ��
WHERE ROWNUM < 4;
















