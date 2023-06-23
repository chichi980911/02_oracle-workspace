/*
<SELECT> -�����͸� ��ȸ�� �� ���Ǵ� ����
 >>RESULT SET : SELECT���� ���� ��ȸ�� �����(��, ��ȸ�� �ൿ�� ������ �ǹ�)
 
 [ǥ����]
 SELECT ��ȸ�ϰ��� �ϴ� �÷�1, �÷�2, ... 
 FROM ���̺��,
 **�ݵ�� �����ϴ� �÷����� �Է� �ؾ��Ѵ� �ƴҽ� ���� �߻�

*/

--EMPLOYEE ������̺� ��ȸ

SELECT *
FROM EMPLOYEE;

--EMPLOYEE ���̺��� ��� , �̸� ,�޿���ȸ

SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

--JOB���̺��� ��� �÷� ��ȸ

SELECT *
FROM JOB;

--�ǽ�����--
--JOB���̺��� ���޸� ��ȸ
SELECT JOB_NAME
FROM JOB;

--DEPARTMENT ���̺��� ��� �÷���ȸ
SELECT *
FROM DEPARTMENT;

--DEPARTMENT ���̺��� �μ��ڵ�,�μ��� ��ȸ
SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT;

--EMPLOYEE ���̺��� �����,�̸���,��ȭ��ȣ,�Ի���,�޿���ȸ
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE,SALARY
FROM EMPLOYEE;

/*
<�÷����� ���� �������>
SELECT�� �÷��� �ۼ��κп� ������� ��� ���� (�̶� ��������� �� ��� ��ȸ)
*/

--EMPOLYEE ���̺��� �����, ����ǿ��� (�޿� *12) ��ȸ
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

--EMPOLYEE ���̺��� �����, �޿� , ���ʽ� ��ȸ
SELECT EMP_NAME,SALARY,BONUS
FROM EMPLOYEE;

--EMPLOYEE ���̺��� �����, �޿� , ���ʽ�, ���� , ���ʽ� ���Ե� ���� ((�޿�+���ʽ�*�޿�)*12)
SELECT EMP_NAME,SALARY,BONUS, SALARY*12 , ((SALARY+BONUS*SALARY)*12)
FROM EMPLOYEE;
--������� ���� �� �÷��� ���� NULL �� ������ ��� ��������� ����� ������ ������ NULL�� ���´�.

--EMPLOYEE ���̺��� �����, �Ի���
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

--EMPLOYEE�� ����� , �Ի��� ,�ٹ��ϼ�(���ó�¥ - �Ի���) 
--DATE Ÿ�� ������ ���� �����ϴ�
--**���� ��¥ : SYSDATE 
--DATE -DATE : ������� �� ������ ������ ��,��,�� ���� ������ �־ ������� �ٸ���.
SELECT EMP_NAME,HIRE_DATE,(SYSDATE - HIRE_DATE) 
FROM EMPLOYEE




