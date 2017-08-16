-- DAY2 ���� ����

/*
  SQL : SELECT (������ �˻��� ����)
  
  -- �ۼ����
5  SELECT [DISTINCT] �÷��� [[AS] ��Ī], ����, �Լ���
1  FROM ����ȸ�� ����� ���̺��
2  WHERE �÷��� �񱳿����� �񱳰�
3  GROUP BY �׷� ���� �÷���
4  HAVING �׷��Լ�(�÷���) �񱳿����� �񱳰�
6  ORDER BY ���ı����÷��� ���Ĺ��;
*/

SELECT *
FROM EMPLOYEE;

SELECT EMP_ID AS ���, SALARY * 12 ���, LENGTH(EMAIL)
FROM EMPLOYEE;

-- DISTINCT Ű����
-- SELECT ���� �� �ѹ� ����� �� ����
-- �÷���, ���� �տ� �����
-- �ߺ��� ���ܽ��Ѽ� �Ѱ��� ������
SELECT DISTINCT DEPT_ID, JOB_ID
FROM EMPLOYEE;

-- �μ� ���̺��� �μ��ڵ�� �μ����� ��ȸ
SELECT DEPT_ID, DEPT_NAME
FROM DEPARTMENT;

SELECT * FROM COUNTRY;

-- ���� ���̺��� ������, 1��ġ�޿�, ���ʽ�����Ʈ�� ����� ���� ��ȸ
SELECT EMP_NAME AS �����, 
        SALARY * 12 "1��޿�", 
        BONUS_PCT "���ʽ� ����Ʈ",
        (SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12 "���ʽ�����Ʈ����(��)"
FROM EMPLOYEE;
-- ��꿡 ����� �÷��� ��� ���� ���(NULL�� ���)
-- ����� ����� NULL ��
-- ���� NULL �� �÷��� �ٸ� ������ �ٲپ� �־�� ��
-- NVL(�÷���, �ٲܰ�) : NULL �϶� ���� �ٲٴ� �Լ���

SELECT BONUS_PCT, NVL(BONUS_PCT, 0)
FROM EMPLOYEE;

-- ���ͷ�(LITERAL)
-- ���̺��� ������ �ִ� �÷�ó�� ���� ä���� �� ���
-- ä�ﰪ [AS] ��Ī
SELECT EMP_ID ���, EMP_NAME �����, 
       '����' �ٹ�����  -- ���ͷ��̶�� ��
FROM EMPLOYEE;

-- WHERE ��(������)
-- WHERE �÷��� ������ �񱳰�
-- �񱳿����ڿ� �������� �ַ� ���� : TRUE/FALSE ����� ���;� ��
-- �񱳿����� : > (ũ��/�ʰ�), < (������/�̸�),
--    >= (ũ�ų� ������/�̻�), <= (�۰ų� ������/����)
--    =(������), !=(�����ʴ���, ^=, <>)
-- �������� : NOT(������), AND, OR

-- ���� ���̺��� �����, �μ��ڵ� ��ȸ
-- ��, 90�� �μ��� �Ҽӵ� ������ ��ȸ��
-- 90�� �μ��� �Ҽӵ� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME �̸�, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_ID = '90';

-- �޿��� 4�鸸�� �ʰ��ϴ�(4�鸸���� ���� �޴�) �����̸�, �޿� ��ȸ
SELECT EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE SALARY > 4000000;

-- 90�� �μ��� �Ҽӵ� ������ �߿��� 2�鸸�� �ʰ��ϴ� �޿��� �޴� ���� ��ȸ
-- ������, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME ������, SALARY �޿�, DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE DEPT_ID = '90' AND SALARY > 2000000;

-- 90 �Ǵ� 20�� �μ��� �Ҽӵ� ������, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID = '90' OR DEPT_ID = '20';

-- ���Ῥ���� : ||
SELECT EMP_NAME || ' ������ ����� ' || EMP_ID || '���̴�.'
FROM EMPLOYEE;

SELECT EMP_ID || '����� ���� �޿��� ' || SALARY || '���̴�.'
FROM EMPLOYEE;

-- �÷��� BETWEEN ���Ѱ� AND ���Ѱ�
-- ���Ѱ� �̻� ���Ѱ� ����

-- 350�� �̻� 550�� ������ ������ �ش��ϴ� �޿��� �޴� ���� ��ȸ
-- ������, �μ��ڵ�, �����ڵ�, �޿�
SELECT EMP_NAME, DEPT_ID, JOB_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 5500000;
WHERE SALARY BETWEEN 3500000 AND 5500000;

-- �޿��� 350�� �̸��̰ų� �޿��� 550�� �ʰ��� ���� ��ȸ
SELECT EMP_NAME, DEPT_ID, JOB_ID, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 5500000;

SELECT EMP_NAME, DEPT_ID, JOB_ID, SALARY
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 5500000;


-- �÷��� LIKE '��������'
-- �÷��� ��ϵ� ���ڰ��� �ش� ���ϰ� ��ġ�ϴ� ���� ã����� ����
-- % : 0�� �̻��� ���ڸ� �ǹ���
-- _ : ���� �� ���� ����

-- ���� �达�� ���� ���� ��ȸ
-- �̸�, �ֹι�ȣ, �̸���
SELECT EMP_NAME, EMP_NO, EMAIL
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- ���� �达�� �ƴ� ���� ��ȸ
SELECT EMP_NAME, EMP_NO, EMAIL
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%';

SELECT EMP_NAME, EMP_NO, EMAIL
FROM EMPLOYEE
WHERE NOT EMP_NAME LIKE '��%';

-- ��ȭ��ȣ 4��° �ڸ���(����)�� 9�� ���� ��ȸ
-- �̸� , ��ȭ��ȣ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
--WHERE PHONE LIKE '___9%';
WHERE PHONE LIKE '___9_______';

-- �������Ͽ� ���Ǵ� ���ϵ�ī�幮�ڿ� ������ ���ڰ� ��ϵǾ� �ִ� ���
-- ��ϵ� ���ڿ� ���ϵ�ī�� ���ڴ� ���Ͽ� ����� ������ �ʿ���
-- ESCAPE �ɼ� �����
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
--WHERE EMAIL LIKE '____%';
--WHERE EMAIL LIKE '___\_%' ESCAPE '\';
WHERE EMAIL LIKE '___#_%' ESCAPE '#';


-- NULL ���� ���� ��, �÷��� = NULL �� ������
-- �÷��� IS NULL, �÷��� IS NOT NULL

-- �μ������� ���� �ʰ�, ������ ������ ���� ���� ���� ��ȸ
SELECT EMP_NAME, MGR_ID, DEPT_ID
FROM EMPLOYEE
WHERE MGR_ID IS NULL AND DEPT_ID IS NULL;

-- �μ��� ������ �������� ���� ���� �̸� ��ȸ
SELECT EMP_NAME, DEPT_ID, JOB_ID
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND JOB_ID IS NULL;

-- �μ��� �������� ��������, ���ʽ��� �ް� �ִ� ���� ��ȸ
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;


-- IN ������ : OR �������� ���� ���� ���� ���� �� ���
-- �÷��� IN (�񱳰�, �񱳰�, ....)

-- 60�� �Ǵ� 90�� �μ��� �ٹ��ϴ� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME �̸�, DEPT_ID �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
--WHERE DEPT_ID = '60' OR DEPT_ID = '90';
WHERE DEPT_ID IN ('60', '90');

-- 60��, 90���� ������ �ٸ� �μ��� �ٹ��ϴ� ���� ��ȸ
SELECT EMP_NAME �̸�, DEPT_ID �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
--WHERE NOT DEPT_ID IN ('60', '90');
WHERE DEPT_ID NOT IN ('60', '90');

-- ������ �켱 ���� �׽�Ʈ
-- �μ��ڵ尡 20, 90�̸鼭 3�鸸�� �ʰ��ϴ� �޿��� �ް� �ִ� ������ȸ
-- �̸�, �μ��ڵ�, �޿�
SELECT EMP_NAME, DEPT_ID, SALARY
FROM EMPLOYEE
--WHERE (DEPT_ID = '20' OR DEPT_ID = '90') AND SALARY > 3000000;
WHERE DEPT_ID IN ('20', '90') AND SALARY > 3000000;













