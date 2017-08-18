-- DAY3 ��������

-- ������(SINGLE ROW) �Լ�(FUNCTION)
-- N���� ���� �о N���� ����� �����ϴ� �Լ�
-- ���ڿ��Լ�, ��¥���� �Լ�, ����ȯ�Լ�, ���а����Լ� ��

-- �׷�(GROUP) �Լ�
-- N���� ���� �о �� ���� ����� �����ϴ� �Լ�
-- SUM, AVG, COUNT, MAX, MIN

-- SELECT ���� ������ �Լ��� �׷� �Լ� �Բ� ��� �� ��
-- ��� ���� ������ �ٸ��� ������

SELECT EMP_NAME, UPPER(EMAIL)
FROM EMPLOYEE;

SELECT SUM(SALARY)
FROM EMPLOYEE;

SELECT UPPER(EMAIL), SUM(SALARY)
FROM EMPLOYEE;  -- ERROR

-- �Լ��� SELECT ���� ��� ������ ��� ������
-- ���������� ������� �� ������ ��� : FROM, ORDER BY��

-- SELECT �� : �������Լ��� �׷��Լ� ���� ��� �� ��
-- WHERE �� : �׷��Լ� ��� �� ��, ������ �Լ��� ����� �� ����
-- HAVING �� : �׷��Լ��� ����� �� ����, ������ �Լ� ��� �� ��

-- ������ �Լ� ************************************
-- ���ڿ� �Լ� : ���ڿ����� �о ���ڿ� �Ǵ� ���ڸ� �����ϴ� �Լ�

-- LENGTH('���ڿ���' | ���ڿ��� ��ϵ� �÷���)
-- ���ڰ���(NUMBER)�� ������
SELECT LENGTH('ORACLE'), LENGTH('����Ŭ')
FROM DUAL;

SELECT LENGTH(EMP_NAME), LENGTH(EMAIL)
FROM EMPLOYEE;

-- �������� ���ڿ�(CHAR)�� �������� ���ڿ�(VARCHAR2) ��
CREATE TABLE TYPETEST(
  CHARTYPE  CHAR(20),
  VARCHAR2TYPE VARCHAR2(20)
);

INSERT INTO TYPETEST VALUES('ORACLE', 'ORACLE');
INSERT INTO TYPETEST VALUES('JAVA', 'JAVA');
INSERT INTO TYPETEST VALUES('����Ŭ', '����Ŭ');

SELECT * FROM TYPETEST;

-- CHAR �� VARCHAR2 �� ���ڰ��� ��
SELECT LENGTH(CHARTYPE), LENGTH(VARCHAR2TYPE)
FROM TYPETEST;

-- LENGTHB('���ڿ���' | ���ڿ��� ��ϵ� �÷���)
-- ����Ʈ ���� ������
SELECT LENGTHB(CHARTYPE), LENGTHB(VARCHAR2TYPE)
FROM TYPETEST;

-- INSTR('���ڿ���' | ���ڿ��� ��ϵ� �÷���, 'ã������'[, ã��������ġ[, ���° ����]])
-- ã�� ������ ��ġ�� ������
SELECT EMAIL, INSTR(EMAIL, '@')
FROM EMPLOYEE;

-- �̸��� �ּҿ��� '@' ���� �ٷ� �ڿ� �ִ� 'k' ������ ��ġ ��ȸ, 
-- ��, �ڿ��� ���� �˻���
SELECT EMAIL, INSTR(EMAIL, 'k', -1, 3)
FROM EMPLOYEE;

-- ������ �Լ��� ��ø ��� ������
-- �Լ�(�Լ�())

-- �̸��� �ּҿ��� '.' �ٷ� �� ������ ��ġ ��ȸ
-- ��, '.' ���� �ٷ� �ձ��ں��� �˻��� �����ϵ��� ��
SELECT EMAIL, INSTR(EMAIL, 'c', INSTR(EMAIL, '.') - 1)
FROM EMPLOYEE;

-- LPAD / RPAD(���� ���ڿ� | �÷���, ��½�ų �ʺ��� ���ڼ�����[, ���� ������ ä�� ����])
-- 3��° ���ڰ� �����Ǹ� �ڵ� ���鹮�ڷ� ä����
SELECT EMAIL ����, LENGTH(EMAIL) ��������,
        LPAD(EMAIL, 20, '*') ä�����,
        LENGTH(LPAD(EMAIL, 20, '*')) �������,
        RPAD(EMAIL, 20, '*') ä�����,
        LENGTH(RPAD(EMAIL, 20, '*')) �������
FROM EMPLOYEE;


-- LTRIM/RTRIM('���ڿ���' | ���ڿ��� ��ϵ� �÷���[, '������ ����'])
-- ������ ���� �����Ǹ� �⺻�� ���鹮����
SELECT LTRIM('   tech') FROM DUAL;  --tech
SELECT LTRIM('   tech', ' ') FROM DUAL;  --tech
SELECT LTRIM('000123', '0') FROM DUAL;  --123
SELECT LTRIM('123123Tech', '123') FROM DUAL;  --Tech
SELECT LTRIM('123123Tech123', '123') FROM DUAL;  --Tech123
SELECT LTRIM('xyxzyyyTech', 'xyz') FROM DUAL;  --Tech
SELECT LTRIM('6372Tech', '0123456789') FROM DUAL;  --Tech

SELECT RTRIM('tech   ') FROM DUAL; --tech
SELECT RTRIM('tech   ', ' ') FROM DUAL; --tech
SELECT RTRIM('123000', '0') FROM DUAL; --123
SELECT RTRIM('Tech123123', '123') FROM DUAL; --Tech
SELECT RTRIM('123Tech123', '123') FROM DUAL; --123Tech
SELECT RTRIM('Techxyxzyyy', 'xyz') FROM DUAL; --Tech
SELECT RTRIM('Tech6372', '0123456789') FROM DUAL; --Tech

-- TRIM(LEADING | TRAILING | BOTH '������ ����' FROM '���ڿ���' | �÷���)
SELECT TRIM('  tech  ') FROM DUAL; --tech
SELECT TRIM('a' FROM 'aatechaaa') FROM DUAL; --tech
SELECT TRIM(LEADING '0' FROM '000123') FROM DUAL; --123
SELECT TRIM(TRAILING '1' FROM 'Tech1') FROM DUAL; --Tech
SELECT TRIM(BOTH '1' FROM '123Tech111') FROM DUAL; --23Tech
SELECT TRIM(LEADING FROM '  Tech  ') FROM DUAL; --Tech  


-- SUBSTR('���ڿ���' | ���ڿ��� ��ϵ� �÷���, ������ ������ġ, ������ ���ڰ���)
-- ������ ��ġ : ���(�տ��������� ��ġ), ����(�ڿ��������� ��ġ)
SELECT SUBSTR('This is a test', 6, 2) FROM DUAL; --is
SELECT SUBSTR('This is a test', 6) FROM DUAL; --is a test
SELECT SUBSTR('�̰��� �����Դϴ�', 3, 4) FROM DUAL; --�� ����
SELECT SUBSTR('TechOnTheNet', 1, 4) FROM DUAL; --Tech
SELECT SUBSTR('TechOnTheNet', -3, 3) FROM DUAL; --Net
SELECT SUBSTR('TechOnTheNet', -6, 3) FROM DUAL; --The
SELECT SUBSTR('TechOnTheNet', -8, 2) FROM DUAL; --On

-- �������� �ֹι�ȣ���� ����, ����, ������ ���� �и� ��ȸ
SELECT EMP_NO �ֹι�ȣ,
        SUBSTR(EMP_NO, 1, 2) || '��' ����,
        SUBSTR(EMP_NO, 3, 2) || '��' ����,
        SUBSTR(EMP_NO, 5, 2) || '��' ����
FROM EMPLOYEE;

-- ��¥ �����Ϳ��� ������ �� ����
-- �������� �Ի��Ͽ��� �Ի�⵵, �Ի��, �Ի����� �и� ��ȸ
SELECT HIRE_DATE �Ի���,
        SUBSTR(HIRE_DATE, 1, 2) || '��' �Ի�⵵,
        SUBSTR(HIRE_DATE, 4, 2) || '��' �Ի��,
        SUBSTR(HIRE_DATE, 7, 2) || '�� �Ի�' �Ի���
FROM EMPLOYEE;

-- SUBSTRB('���ڿ�' | ���ڿ��� ��ϵ� �÷���, ������ ����Ʈ ��ġ, ������ ����Ʈ)
SELECT SUBSTR('ORACLE', 3, 2), SUBSTRB('ORACLE', 3, 2)
FROM DUAL;

SELECT SUBSTR('����Ŭ', 2, 2), SUBSTRB('����Ŭ', 4, 6)
FROM DUAL;

-- UPPER('���ڿ���' | ���ڿ��� ��ϵ� �÷���) : �빮�ڷ� �ٲٴ� �Լ�
-- LOWER('���ڿ���' | �÷���) : �ҹ��ڷ� �ٲٴ� �Լ�
-- INITCAP('���ڿ���' | �÷���) : ù���ڸ� �빮�ڷ� �ٲٴ� �Լ�
SELECT UPPER('ORACLE'), UPPER('oracle'),
        LOWER('ORACLE'), LOWER('oracle'),
        INITCAP('ORACLE'), INITCAP('oracle')
FROM DUAL;        

-- �Լ� ��ø ��� : �Լ� �ȿ� �Լ� ��� ������
-- ������������ �̸�, ���̵� ��ȸ
-- ���̵�� �̸��Ͽ��� �и� ������
SELECT EMP_NAME �̸�,
        SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) ���̵�
FROM EMPLOYEE;


-- ���� ���̺��� �����, �ֹι�ȣ ��ȸ
-- �ֹι�ȣ�� �������- ������ ���̰� �ϰ� ���������� '*'�� ��� ó����
-- 781125-*******
SELECT EMP_NAME �����,
        RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') �ֹι�ȣ
FROM EMPLOYEE;


-- ����ó���Լ� : ROUND, TRUNC, FLOOR, ABS, MOD

-- ROUND(���ڰ� | ���ڰ��� ��ϵ� �÷��� | ����[, �ݿø��� �ڸ���])
-- �����ϴ� �ڸ��� ���� 5�̻��̸� �ڵ� �ݿø��� (�⺻���� 0��)
-- �����ϴ� �ڸ��� ���� 5�̸��̸� ������
-- �ڸ��� : ���(�Ҽ����Ʒ��� �ڸ��� �ǹ���), ����(������ �ڸ����� �ǹ���)
SELECT ROUND(123.456), 
        ROUND(123.456, 0),
        ROUND(123.456, 1),
        ROUND(123.456, -1)
FROM DUAL;
        
-- ���� �������� ���, �̸�, �޿�, ���ʽ�����Ʈ, ���ʽ�����Ʈ�� ����� ���� ��ȸ
-- �������� ��Ī : 1��޿�
-- ������ õ�������� �ݿø���
SELECT EMP_ID, EMP_NAME, SALARY, BONUS_PCT,
        ROUND((SALARY + (SALARY * NVL(BONUS_PCT, 0))) * 12, -4) "1��޿�"
FROM EMPLOYEE;

-- TRUNC(���� | ���� | ���ڰ� ��ϵ� �÷���, �ڸ���)
-- �ڸ����� ���� ������ �Լ�
SELECT TRUNC(125.315) FROM DUAL; --125
SELECT TRUNC(125.315, 0) FROM DUAL; --125
SELECT TRUNC(125.315, 1) FROM DUAL; --125.3
SELECT TRUNC(125.315, -1) FROM DUAL; --120
SELECT TRUNC(125.315, 3) FROM DUAL; --125.315
SELECT TRUNC(-125.315, -3) FROM DUAL; --0

-- ���� �������� �޿��� ����� ����
-- 10�������� ������
SELECT AVG(SALARY), TRUNC(AVG(SALARY), -2), FLOOR(AVG(SALARY))
FROM EMPLOYEE;

-- FLOOR(���� | ���� | �÷���) : �Ҽ��� �Ʒ��� ������ �Լ�(���� ����� �Լ�)
SELECT ROUND(123.45), TRUNC(123.45), FLOOR(123.45)
FROM DUAL;

-- ABS(���� | ���� | �÷���) : ���밪 ó�� �Լ�(������ ����� �ٲ�)
SELECT ABS(123), ABS(-123)
FROM DUAL;

-- �Ի��� - ���� ��¥, ���� ��¥ - �Ի��� ��ȸ : ��Ī�� �ѱٹ��ϼ�
-- �ٹ��ϼ��� ������ ó����, ��� ����� ��� ó����
SELECT ABS(FLOOR(HIRE_DATE - SYSDATE)) �ѱٹ��ϼ�,
        ABS(FLOOR(SYSDATE - HIRE_DATE)) �ѱٹ��ϼ�
FROM EMPLOYEE;


-- MOD(������, ������) : �������� �������� ���ϴ� �Լ�
SELECT FLOOR(25 / 7) ��, MOD(25, 7) ������
FROM DUAL;

-- ����� Ȧ���� �������� ��� ���� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE MOD(TO_NUMBER(EMP_ID), 2) = 1;
WHERE MOD(EMP_ID, 2) = 1;
-- ���ڷ� �� ���ڴ� ���� �ڵ� ���ڷ� �ٲ� : '100' -> 100

-- ������ ������ �������� �̸�, �μ��ڵ�, ������� ��ȸ
SELECT EMP_NAME, DEPT_ID, SUBSTR(EMP_NO, 1, 6) �������
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');


-- ��¥ ó�� �Լ�
-- SYSDATE �Լ� : �ý������� ���� ���� ��¥�� �ð��� ��ȸ�� �� ���
SELECT SYSDATE
FROM DUAL;  -- ���� ����Ŭ�� ���� �ѱ���, ��¥ ������ RR/MM/DD ��.

/*
����Ŭ������ ȯ�漳��, ��ü ���� �������� ��� ���� �����ϰ� ����
������ ��ųʸ�(����) ������ ���� �������� ������ ���̺��� ���·� ���� ������
������ ��ųʸ��� DB �ý����� ���� ������.  ����ڴ� �մ� �� ����. ��ȸ�� ������
ȯ�漳���� ���õ� ������ ������ �� ����. (���, ���ڼ�, ��¥ ���� ��)
*/
SELECT *
FROM SYS.NLS_SESSION_PARAMETERS;

-- ��¥ ���˰� ���õ� ���� ��ȸ
SELECT VALUE
FROM NLS_SESSION_PARAMETERS
WHERE PARAMETER = 'NLS_DATE_FORMAT';

-- ��¥ ���� ����
ALTER SESSION
SET NLS_DATE_FORMAT = 'DD-MON-RR';

COMMIT;

-- Ȯ��
SELECT SYSDATE
FROM DUAL;

-- ���� �������� ����
ALTER SESSION
SET NLS_DATE_FORMAT = 'RR/MM/DD';

COMMIT;

-- Ȯ��
SELECT SYSDATE FROM DUAL;

-- ADD_MONTHS('��¥������' | ��¥�� ��ϵ� �÷���, ���� ������)
-- �������� ���� ��¥�� ���ϵ�

-- ���� ���̺��� �Ի����� 20��� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 240)
FROM EMPLOYEE;

-- ���ú��� 10�� �� ��¥��?
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 120)
FROM DUAL;

-- ������ �߿��� �ٹ������ 20�� �̻� �ٹ��� ���� ���� ��ȸ
-- ���, �̸�, �μ��ڵ�, �����ڵ�, �Ի��� ALIAS ó����
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_ID �μ��ڵ�, JOB_ID �����ڵ�,
        HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE ADD_MONTHS(HIRE_DATE, 240) <= SYSDATE;

-- MONTHS_BETWEEN(��¥1, ��¥2) : �� ��¥�� ���̳� �������� ������

--'2010�� 1�� 1��' �������� �Ի����� 10���� ���� �������� �ٹ���� ��ȸ
SELECT EMP_NAME, HIRE_DATE,
        FLOOR(MONTHS_BETWEEN('10/01/01', HIRE_DATE)/12) AS �ٹ����
FROM EMPLOYEE
WHERE MONTHS_BETWEEN('10/01/01', HIRE_DATE) > 120;


-- �������� �̸�, �Ի���, ��������� �ٹ��ϼ�, �ٹ�������, �ٹ���� ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        FLOOR(SYSDATE - HIRE_DATE) �ٹ��ϼ�,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) �ٹ�������,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE; 

-- NEXT_DAY('��¥������' | �÷���, '�����̸�')
-- ������ ��¥ ���� ��¥���� ���� ����� ������ ������ ��¥�� ������
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�Ͽ���')
FROM DUAL;

-- �����ͺ��̽��� ��� �� �ѱ���� �����Ǿ� �ֱ� ������ ���� �̸��� �ѱ� �����
-- �����̸��� ����� ���� ������
SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL;

-- �����̸��� ��� ����Ϸ��� �� �����ؾ� ��
ALTER SESSION
SET NLS_LANGUAGE = AMERICAN;

COMMIT;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'WEDNESDAY')
FROM DUAL;

-- �ѱ���� ���� �ٲ�
ALTER SESSION
SET NLS_LANGUAGE = KOREAN;

COMMIT;


-- LAST_DAY('��¥������' | �÷���) 
-- ������ ��¥�� ���� ���� ������ ��¥�� ������
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;

-- ���� ���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
-- �ָ� ������
SELECT EMP_NAME �����, HIRE_DATE �Ի���,
        LAST_DAY(HIRE_DATE) - HIRE_DATE "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;        

-- ���� ��¥ ��ȸ �Լ�
SELECT SYSDATE,
        SYSTIMESTAMP,
        CURRENT_DATE,
        CURRENT_TIMESTAMP
FROM DUAL;

-- EXTRACT(������ �׸� FROM ��¥)
-- ��¥ �����Ϳ��� ���ϴ� ������ ������
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE) ��,
        EXTRACT(MONTH FROM SYSDATE) ��,
        EXTRACT(DAY FROM SYSDATE) ��
FROM DUAL;

-- ���� �������� �̸�, �Ի���, �ٹ���� ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���,
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����,
        FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) �ٹ����
FROM EMPLOYEE; 























