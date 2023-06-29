/*
    *�������� (SUBQUARY)
    -�ϳ��� SQL�� �ȿ� ���Ե� �� �ٸ� SELECT��
    -���� SQL���� ���� ���� ������ �ϴ� ������
    
*/

--���� �������� ����1
--��ȫö ����� ���� �μ��� ���� ����� ��ȸ�ϰ� ����!!
--1.��ȫö ��� �μ��ڵ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='���ö'; --D9

--2) �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';


-->1,2���� �ܰ踦 �ϳ��� ������
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö');
                    
--�������� ����2
--�� ������ ��ձ޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ

--1)�� ������ ��� �޿� ��ȸ - 3047663��
SELECT AVG(SALARY)
FROM EMPLOYEE;

--2)�޿��� 3047663�� �̻��� ����� ��ȸ
SELECT EMP_ID,EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >= (
SELECT AVG(SALARY)
FROM EMPLOYEE);
---------------------------------------------------------------------------
/*
    *���������� ����
    �������� ������ ������� �� �� ��̳Ŀ� ���� �з��ȴ�.
    
    -������ �������� : ���������� ��ȸ ������� ������ ������ 1���϶� (���� �ѿ�)
    -������ �������� : ���������� ��ȸ ������� ���� ���� �� => ��������(������ �ѿ�)
    -���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� �� (�� �� ������)
    -������ �̸鼭 ���� �� �������� : �������� ��ȸ ������� ������ ���� �÷��϶�
*/

/*
    1.������ �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ ������ 1���� �� (�� �� �� ��)
    �Ϲ� �� ������ ��밡��
    =, != ,^= , <>, < , > , >=, <=,...
    
*/
--1. �� ������ ��ձ޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
-- �������� ������� ���� ���ΰ��
SELECT EMP_NAME,JOB_CODE , SALARY
FROM EMPLOYEE
--WHERE SALARY < �������� ��� �޿�
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
--2)���� �޿��� �޴� ����� ���, �̸� ,�޿� ,�λ���
SELECT EMP_ID ,EMP_NAME, SALARY,HIRE_DATE
FROM EMPLOYEE
--WHERE SALARY = �������� �� �����޿�; 
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

--3.���ö ����� �޿����� �� ���� �޴� ������� ���, �̸� ,�μ��ڵ� ,�޿� ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
--WHERE SALARY > ���ö ����� �޿�
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-->>����Ŭ ���뱸��
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY > (SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
-->>ANSI ����
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY >(SELECT SALARY 
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');

-- 4) �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿� �� ��ȸ
--4-1) ���� �μ��� �޿��� �߿����� ���� ū �� ��ȸ 
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; --17700000

--4-2) �μ��� �޿����� 1770000 ���� �μ� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

--���� �� ������ �ϳ��� ������ �����

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                     FROM EMPLOYEE
                    GROUP BY DEPT_CODE);
                    
----------------�ǽ�----------------------------------
--1.������ ����� ���� �μ������� ���, �����, ��ȭ��ȣ ,�Ի��� ,�μ���
--�� �������� ����
SELECT *
FROM DEPARTMENT; --DEPT ID

SELECT *
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-->����Ŭ����
SELECT EMP_NO,EMP_NAME,PHONE,HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 

AND DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������')
AND EMP_NAME != '������';

--ANSI ����
SELECT EMP_NO,EMP_NAME,PHONE,HIRE_DATE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������')
AND EMP_NAME != '������';

---------------------------------------------------------------------------
/*
    2. ������ �������� (MULTI ROW SUBQUARY)
    ���������� ������ ������� ���� �� �϶� (�÷��� �Ѱ�)

    -IN �������� :�������� ����� �߿��� '�Ѱ��� ��ġ'�ϴ� ���� �ִٸ�
    
    - > ANY �������� : �������� ����� �߿��� '�Ѱ��� Ŭ ���'
        (�������� ����� �߿��� ���� ���� �� ���� Ŭ���)
        
     - < ANY �������� : �������� ����� �߿���'�Ѱ��� Ŭ ���'
        (�������� ����� �߿��� ���� ū ������ ���� ���)
        
    �񱳴�� > ANY(��1,��2,��3);
    �񱳴�� > ANY �񱳴�� > ��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3
    
    - > ALL �������� : �������� '���' ������麸�� Ŭ ���
    - < ALL �������� : �������� '���' ������� ���� ���� ���
    �񱳴�� > ALL (��1,��2,��3
    �񱳴�� > ALL �񱳴�� > ��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3
*/
--1)����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿�
--1-1) ����� �Ǵ� ������ ����� � �������� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������'); --J3 , J7

--1-2) J3,J7�� ������ ����� ��ȸ
SELECT EMP_ID ,EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3','J7');

--�� �ΰ��� ������ ��ġ��
-- ***IN�� �ƴ� = ����** single-row subquery returns more than one row
-- ���������� �������� ���� 2�� �̻��̱� ������ = ����� �ƴ� IN ��� (������)
SELECT EMP_ID ,EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME IN ('�����', '������'));

-- 2) �븮 �����ӿ��� �ұ��ϰ� ���� ���� �޿��� �� �ּ� �޿����� ���� �޴� ���� ��ȸ
--��� ,�̸� ,����,�޿�

--2-1.���� ���� �޿���ȸ
SELECT SALARY
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '����'; --220,250,376

--2-1 ������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY(2200000,2500000,3760000);

--�� ���������� ���ϱ�
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY(SELECT SALARY
            FROM EMPLOYEE E , JOB J
            WHERE E.JOB_CODE = J.JOB_CODE
            AND J.JOB_NAME = '����');

--�� ������ ���������� ����
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT MIN(SALARY)
            FROM EMPLOYEE E , JOB J
            WHERE E.JOB_CODE = J.JOB_CODE
            AND J.JOB_NAME = '����');
            
-->3)���� �����ӿ��� �ұ��ϰ� ���������� ������� ��� �޿����ٵ� �� ���� �޴� ������� �� ����,�̸�,���޸�,�޿���ȸ
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';
--AND SALARY > [���� ���� �޿�]

SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����';

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL(SELECT SALARY
            FROM EMPLOYEE
            JOIN JOB USING(JOB_CODE)
            WHERE JOB_NAME = '����');
----------------------------------------------------------------

/*
    3. ���� �� �������� 
    ������� �� �������� ������ �÷����� �������� ��� 
*/

--1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ(�����, �μ��ڵ�, �����ڵ�, �Ի�����)
--������ �������� ** 2���� ���������� �۾��� ��
SELECT *
FROM EMPLOYEE; --DEPT_CODE JOB_CODE

SELECT *
FROM DEPARTMENT; -- DEPT_ID

SELECT *
FROM JOB; -- JOB_CODE



SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';  --D5 �μ��ڵ�

SELECT EMP_NAME,DEPT_CODE,JOB_CODE,HIRE_DATE
FROM EMPLOYEE
--WHERE (DEPT_CODE , JOB_CODE) =[�μ��ڵ� ,�����ڵ�]
WHERE(DEPT_CODE,JOB_CODE) = (SELECT DEPT_CODE,JOB_CODE
                            FROM EMPLOYEE
                            WHERE EMP_NAME = '������');


--�ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, ����� ,�����ڵ� ,������ ��ȸ

--1.�ڳ��� ����� �����ڵ�
SELECT DEPT_CODE , MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���';

SELECT EMP_NO,EMP_NAME,JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE , MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');
-------------------------------------------------------------------------------
/*
    4.������ ���߿� ��������
    �������� ��ȸ �ܷΰ����� ������ ������ �� ���
    
*/

--1)�� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���,�����,�����ڵ�,�޿�)
-- >> �� ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE , MIN(SALARY)--3
FROM EMPLOYEE --1
GROUP BY JOB_CODE; --2

SELECT EMP_IN, EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SARARLY =37000000
OR      JOB_CODE = 'J7' AND SARARLY =1380000
...;

--���������� ����
SELECT EMP_ID, EMP_NAME,JOB_CODE,SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE , MIN(SALARY)--3
                            FROM EMPLOYEE --1
                            GROUP BY JOB_CODE); --2);

--2) �� �μ��� �ְ� �޿��� �޴�  ������� ���,�����, �μ��ڵ� ,�޿�

SELECT DEPT_CODE , MAX(SALARY)
FROM EMPLOYEE
GROUP BY(DEPT_CODE);

SELECT EMP_NO,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE(DEPT_CODE,SALARY) IN (SELECT DEPT_CODE , MAX(SALARY)
                            FROM EMPLOYEE
                            GROUP BY(DEPT_CODE));
                            
                            
                            
----------------------------------------------------------------
/*
    5. �ζ��� �� (INLINE VIEW)
    ���������� ������ ����� ��ġ ���̺� ó�� ���
*/

--������� ��� ,�̸� ,���ʽ� ���� ���� (��Ī�ο� : ����),�μ��ڵ� ��ȸ =>���ʽ� ���� ������ ���� NULL�� �ȳ�����
--��, ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ

SELECT EMP_NO,EMP_NAME,(SALARY+ SALARY * NVL(BONUS,0))*12 AS "����" , DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY+ SALARY * NVL(BONUS,0))*12 AS "����" > =30000000;
--�̰� ��ġ �����ϴ� ���̺��ΰ� ���� ����� �� �ִ�

SELECT EMP_NO,EMP_NAME,����,DEPT_CODE  
FROM (SELECT EMP_NO,EMP_NAME,(SALARY+ SALARY * NVL(BONUS,0))*12 AS "����" , DEPT_CODE
FROM EMPLOYEE)
WHERE ���� >= 30000000;
