-- DAY4 ��������

-- ����ȯ �Լ�
-- �ڵ�����ȯ�� �Ǵ� ���
SELECT 20 + '10'
FROM DUAL;

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE EMP_ID = 100;  -- �ڵ�����ȯ�� 100 -> '100'
--WHERE EMP_ID = '100';
WHERE EMP_ID = TO_CHAR(100);  -- ����ȯ�� ����� ���

-- �ڵ�����ȯ�� �� �Ǵ� ��� : ���� �ڷ����� �ٲپ�� ��
SELECT SYSDATE - '15/03/15'
FROM DUAL;  -- ERROR
-- ����ȯ�� ����ؾ� ��
SELECT SYSDATE - TO_DATE('15/03/15', 'YY/MM/DD')
FROM DUAL;

-- TO_CHAR(���� | ��¥, '���˹���')
-- ���ڳ� ��¥ �����͸� ���ϴ� ������ �����ؼ� ��� ó���� �� ���

-- ���ڿ� ���� ������ ���
SELECT TO_CHAR(1234, '99999') FROM DUAL; --1234
SELECT TO_CHAR(1234, '09999') FROM DUAL; --01234
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; --��1234
SELECT TO_CHAR(1234, '99,999') FROM DUAL; --1,234
SELECT TO_CHAR(1234, '09,999') FROM DUAL; --01,234
SELECT TO_CHAR(1000, '9.9EEEE') FROM DUAL; --1.0E+03
SELECT TO_CHAR(1234, '999') FROM DUAL; --#### : �ڸ����� ���ڶ� ������ ���

SELECT EMP_NAME, 
        TO_CHAR(SALARY, 'L99,999,999') �޿�,
        TO_CHAR(NVL(BONUS_PCT, 0), '90.00') ���ʽ�����Ʈ
FROM EMPLOYEE;

-- ��¥ �����Ϳ� ���� ����ÿ��� TO_CHAR() �����
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; --���� 20:57:11
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; --���� 08:57:11
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL; --1�� ��, 2010
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL; --2010-1-4 ������
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-fmDD DAY') FROM DUAL; --2010-01-4 ������
SELECT TO_CHAR(SYSDATE, 'Year, Q') FROM DUAL; --Twenty Seventeen, 3
--'fm' ���� ����ϸ� '01' ������ '1' �������� ǥ����

-- ������ J7�� �������� �̸��� �Ի��� ��ȸ, �Ի��Ͽ� ���� ����
SELECT EMP_NAME AS �̸�,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS �Ի���
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME AS �̸�,
        TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') AS �Ի���
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

SELECT EMP_NAME AS �̸�,
        SUBSTR(HIRE_DATE, 1, 2) || '�� ' ||
        SUBSTR(HIRE_DATE, 4, 2) || '�� ' ||
        SUBSTR(HIRE_DATE, 7, 2) || '��' AS �Ի���
FROM EMPLOYEE
WHERE JOB_ID = 'J7';

-- �⵵�� ���� ����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'RRRR'),
        TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'RR'),
        TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'YYYY "��"'), TO_CHAR(HIRE_DATE, 'RRRR "��"'),
        TO_CHAR(HIRE_DATE, 'YY "��"'), TO_CHAR(HIRE_DATE, 'RR "��"'),
        TO_CHAR(HIRE_DATE, 'YEAR')
FROM EMPLOYEE;

-- ���� ���� ����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY"��" MM"��"'),
        TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'),
        TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- ��¥�� ���� ����
SELECT SYSDATE,
        TO_CHAR(SYSDATE, '"1�� ����" DDD "��°"'),
        TO_CHAR(SYSDATE, '"�� ����" DD "��°"'),
        TO_CHAR(SYSDATE, '"�� ����" D "��°"')
FROM DUAL;

-- �б�� ���� ����
SELECT TO_CHAR(SYSDATE, 'Q "��б�"'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- ���� ���̺��� �̸�, �Ի��� ��ȸ
-- �Ի����� ������ �����ؼ� '2014�� 05�� 23�� (��)' �������� ��� ó����
SELECT EMP_NAME �̸�,
        TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" "("DY")"') �Ի���,
        TO_CHAR(HIRE_DATE, 'YYYY"��" MON DD"��" "("DY")"') �Ի���
FROM EMPLOYEE;

-- ����� 100�� ������ �̸��� �Ի��� ��ȸ
-- �Ի����� '2017-8-10 ���� 10:42:30' �������� ��� ó����
SELECT EMP_NAME,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD AM HH:MI:SS'),
        TO_CHAR(HIRE_DATE, 'YYYY-fmMM-DD AM HH:MI:SS'),
        TO_CHAR(HIRE_DATE, 'YYYY-fmMM-DD HH24:MI:SS')
FROM EMPLOYEE
WHERE EMP_ID = 100;



-- ��¥������ �� ����ÿ� ��¥�� ��ϵǾ� �ִ� ���̸� ��¥�� �� ������
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE = '04/04/30';  -- ����Ŭ �⺻ ���� 'RR/MM/DD'

-- �ð��� ���Ե� ��¥������ �񱳽� ��¥�� ���ϸ� FALSE �� ����� ����
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE = '90/04/01';  -- ����� �� ����
--WHERE HIRE_DATE = '90/04/01 13:30:30'; -- �ð����� �񱳵Ǿ�� ��
WHERE HIRE_DATE = TO_DATE('90/04/01 13:30:30', 'YY/MM/DD HH24:MI:SS');

-- �ذ��� 1
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YY/MM/DD') = '90/04/01';

-- �ذ��� 2
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '90/04/01';


-- TO_DATE('���ڷ� �� ��¥�� �ð�', '���� ���� �� �ڸ��� ���˹���')
-- �ݵ�� ���� ���ڿ� ���� ���˹����� ������ ���ƾ� �� : �ؼ��� �ǹ̷� �����
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL; --10/01/01
SELECT TO_CHAR('20100101', 'YYYY, MON') FROM DUAL; -- ERROR
SELECT TO_CHAR(TO_DATE( '20100101', 'YYYYMMDD'), 'YYYY, MON') 
FROM DUAL; --2010, 1��
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL; --04/10/30
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'),
                'DD-MON-YY HH:MI:SS PM') 
FROM DUAL; --30-10��-04 02:30:00 ����
SELECT TO_DATE('980630', 'YYMMDD' ) FROM DUAL; --98/06/30
SELECT TO_CHAR(TO_DATE( '980630', 'YYMMDD' ), 'YYYY.MM.DD') 
FROM DUAL; --2098.06.30

-- ��ϵ� �⵵�� ���ڸ��� ���, ������ �����ؼ� ���ڸ��� �ٲ� ���
-- YYYY �� RRRR �� ����

-- RR �� ������ ��
-- ���� �⵵(17)�� 50 �̸��̰�, �ٲ� �⵵�� 50 �̸��̸� 2000�⵵�� �����
-- ���� �⵵�� 50�̸��̰�, �ٲ� �⵵�� 50 �̻��̸� 1900�⵵�� �����

SELECT HIRE_DATE,
        TO_CHAR(HIRE_DATE, 'RRRR'), TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEE;

-- ���� �⵵�� �ٲ� �⵵�� �� �� 50�̸��̸� Y/R �ƹ��ų� ����ϸ� ��
SELECT TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'RRRR-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'RRMMDD'), 'YYYY-MM-DD'),
        TO_CHAR(TO_DATE('160505', 'YYMMDD'), 'RRRR-MM-DD')
FROM DUAL;

-- ���� �⵵�� 50 �̸��̰�, �ٲ� �⵵�� 50 �̻��� ��
-- �⵵�� �ٲ� �� Y ���� ���� ����(2000��)�� �ٲ�
-- �⵵�� �ٲ� �� R ���� ���� ����(1900��)�� �ٲ�
SELECT TO_CHAR(TO_DATE('990101', 'YYMMDD'), 'YYYY-MM-DD'), -- 2000�� ����
        TO_CHAR(TO_DATE('990101', 'RRMMDD'), 'RRRR-MM-DD'), -- 1900�� ����
        TO_CHAR(TO_DATE('990101', 'YYMMDD'), 'RRRR-MM-DD'), -- 2000�� ����
        TO_CHAR(TO_DATE('990101', 'RRMMDD'), 'YYYY-MM-DD') -- 1900�� ����
FROM DUAL;

-- ����� ���ڸ� ��¥�� �ٲ� �� 'R' ����ϸ� ��


-- TO_NUMBER() : ���ڸ� ���ڷ� �ٲ� �� ���
-- '100' --> 100 
SELECT EMP_NAME, EMP_NO,
        SUBSTR(EMP_NO, 1, 6)AS �պκ�,
        SUBSTR(EMP_NO, 8) AS �޺κ�,
        TO_NUMBER(SUBSTR(EMP_NO, 1, 6)) + 
                TO_NUMBER(SUBSTR(EMP_NO, 8)) AS ���
FROM EMPLOYEE
WHERE EMP_ID = '101';


-- ��Ÿ�Լ�

-- NVL(�÷���, �÷��� ���� NULL �� �� �ٲ� ��)
SELECT EMP_NAME, BONUS_PCT, DEPT_ID, JOB_ID
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(BONUS_PCT, 0), 
        NVL(DEPT_ID, '00'), NVL(JOB_ID, 'J0')
FROM EMPLOYEE;        

-- NVL2(�÷���, �ٲܰ�1, �ٲܰ�2)
-- �ش� �÷��� ���� ������ �ٲܰ�1�� �ٲٰ�, NULL�̸� �ٲܰ�2�� �ٲ�

-- ���� �������� ���ʽ�����Ʈ�� 0.2 �̸��̰ų� NULL �� �������� ��ȸ
-- ���, �����, ���ʽ�����Ʈ, ���溸�ʽ�����Ʈ
-- ���溸�ʽ�����Ʈ�� ���� ������ 0.15�� �ٲٰ�, NULL�̸� 0.05�� �ٲ�
SELECT EMP_ID ���, EMP_NAME �̸�, BONUS_PCT ���ʽ�����Ʈ,
        NVL2(BONUS_PCT, 0.15, 0.05) ���溸�ʽ�����Ʈ
FROM EMPLOYEE
WHERE BONUS_PCT < 0.2 OR BONUS_PCT IS NULL;


-- DECODE(�Լ��� | �÷���, ���ð�1, ���ð�1, ���ð�2, ���ð�2,.....���ð�N, ���ð�N, 
--         ��� ���ð��� �ƴ� �� DEFAULT��)
-- SWITCH ���� ������ ���� �Լ���

-- 50 �� �μ��� ���� �������� �̸��� ���� ��ȸ
-- �ֹι�ȣ���� �������� 1 �Ǵ� 3�̸� ����, 2 �Ǵ� 4�̸� ����
SELECT EMP_NAME �̸�, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '����', '3', '����', '����') ����
FROM EMPLOYEE
WHERE DEPT_ID = '50'
ORDER BY ����, �̸�;  -- ���� ������������, ������ ������ �̸� ������������ ó��


-- �����ڵ� 'J4' �� ������ ����� �̸��� ������ ��� ��ȸ
-- ������ ����� NULL �̸� '����' ���� �ٲ�
-- NVL ����� ���
SELECT EMP_ID ���, EMP_NAME �̸�, NVL(MGR_ID, '����')
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

-- DECODE ����� ���
SELECT EMP_ID ���, EMP_NAME, DECODE(MGR_ID, NULL, '����', MGR_ID)
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

-- ���޺� �޿� �λ���� �ٸ� ��
-- DECODE �Լ� ����
SELECT EMP_NAME, JOB_ID, SALARY,
        TO_CHAR(DECODE(JOB_ID, 
                      'J7', SALARY*1.1,
                      'J6', SALARY*1.15,
                      'J5', SALARY*1.2,
                      SALARY*1.05), 'L99,999,999') AS �λ�޿�
FROM EMPLOYEE; 

-- CASE ǥ���� ����
SELECT EMP_NAME, JOB_ID, SALARY,
        CASE JOB_ID
        WHEN 'J7' THEN SALARY*1.1
        WHEN 'J6' THEN SALARY*1.15
        WHEN 'J5' THEN SALARY*1.2
        ELSE SALARY*1.05 
        END AS �λ�޿�
FROM EMPLOYEE;

-- CASE ǥ������ ���� IF ��ó�� ����� ���� ����
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY <= 3000000 THEN '�ʱ�'
              WHEN SALARY <= 4000000 THEN '�߱�'
              ELSE '���' 
        END AS ����
FROM EMPLOYEE
ORDER BY ����;   -- �������� ���� ó����



-- �׷��Լ� ***************************
-- SUM, AVG, MIN, MAX, COUNT
SELECT SUM(SALARY), SUM(DISTINCT SALARY),
        FLOOR(AVG(SALARY)), AVG(DISTINCT SALARY),
        MIN(SALARY), MAX(SALARY),
        COUNT(SALARY), COUNT(*), COUNT(DISTINCT SALARY)
FROM EMPLOYEE;

-- SUM([DISTINCT] �÷���) : �հ� ����
SELECT SUM(SALARY), SUM(DISTINCT SALARY)
FROM EMPLOYEE
WHERE DEPT_ID = '50'
OR DEPT_ID IS NULL;

-- AVG([DISTINCT] �÷���) : NULL �� ������ ������ ��� ����
SELECT AVG(BONUS_PCT) AS �⺻���,
        AVG(DISTINCT BONUS_PCT) AS �ߺ��������,
        AVG(NVL(BONUS_PCT,0)) AS NULL�������
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90')
OR DEPT_ID IS NULL;

-- MIN(�÷���) : �ּҰ� ����
-- MAX(�÷���) : �ִ밪 ����
SELECT MAX(JOB_ID), MIN(JOB_ID),
        MAX(HIRE_DATE), MIN(HIRE_DATE),
        MAX(SALARY), MIN(SALARY)
FROM EMPLOYEE
WHERE DEPT_ID IN ('50', '90');

-- COUNT(* | [DISTINCT] �÷���) : �� ���� ������
SELECT COUNT(*),
        COUNT(JOB_ID),
        COUNT(DISTINCT JOB_ID)
FROM EMPLOYEE
WHERE DEPT_ID = '50'
OR DEPT_ID IS NULL;


-- ORDER BY �� *****************************************
-- SELECT ���� �� �������� �����.
-- SELECT �� ����� ������ ���� ó����
-- ORDER BY ���ı��� ���Ĺ��, ���ı��� ���Ĺ��, ....
-- ���ı����� SELECT ���� ����� �÷���, ��Ī, �÷����������� ����� �� ����
-- ���Ĺ���� ASC(������������) | DESC(������������) �����
-- ASC �� �����ص� ��

/*
5 SELECT �÷���, ����, �Լ��� ��Ī
1 FROM ���̺��
2 WHERE �÷��� | �������Լ� �񱳿����� �񱳰� | �������Լ�
3 GROUP BY �÷���
4 HAVING �׷��Լ� �񱳿����� �񱳰�
6 ORDER BY �÷��� | ��Ī | ���� ���Ĺ�� NULLS FIRST | LAST;
*/

SELECT EMP_NAME �̸�, SALARY �޿�
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL
--ORDER BY SALARY DESC, 1 ASC;
ORDER BY �޿� DESC, �̸�;

-- 2003�� 1�� 1�� ���Ŀ� �Ի��� ���� ���� ��ȸ
-- �μ��ڵ� ���� �������������ϰ�, ���� �μ��ڵ��� ���� �Ի��� ���� �������������ϰ�,
-- �Ի����� ������ �̸� ���� ������������ ó����
-- �̸�, �Ի���, �μ��ڵ�, �޿� ��ȸ��, ��Ī ó����
-- �μ��ڵ��� NULL �� �Ʒ��ʿ� ��ġ�ϰ� ��
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���, DEPT_ID �μ��ڵ�, SALARY �޿�
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101', 'RRRRMMDD')
ORDER BY �μ��ڵ� DESC NULLS LAST, �Ի���, �̸�;


-- GROUP BY �� *******************************
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE
ORDER BY DEPT_ID NULLS LAST;

-- ���� ������ �׷��� ��� ��� ó���� �� �ʿ䰡 ���� �� �����
-- GROUP BY �÷��� | �Լ���
-- ���� ���� ������ �ϳ��� ��� ó���� �������� �����
-- �׷� ���� ���� ���� �׷��Լ� ����� SELECT ���� �����

-- �μ��� �޿��� �հ踦 ��ȸ
SELECT DEPT_ID, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
ORDER BY DEPT_ID NULLS LAST;

-- ���޺� �޿��� �հ�, �޿��� ���, ������ ��ȸ
SELECT JOB_ID, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_ID
ORDER BY JOB_ID NULLS LAST;

-- ������ �޿��հ�, �޿����(õ�������� �ݿø�ó��), ������ ��ȸ
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��') ����,
        SUM(SALARY), ROUND(AVG(SALARY), -4), COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '3', '��', '��')
ORDER BY ����;



















