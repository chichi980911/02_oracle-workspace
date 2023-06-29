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

select *
from employee;
--EMPLOYEE ���̺��� ��� , �̸� ,�޿���ȸ

SELECT EMP_NO,EMP_NAME,SALARY
FROM EMPLOYEE;

--JOB���̺��� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE;
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
FROM EMPLOYEE;

---------------------------------------------------------------------------
/*
<�÷��� ��Ī �����ϱ�>
��������� �ϰ� �Ǹ� �÷����� �������ϱ� ������ �÷��� ��Ī �ο� ����

[ǥ����]
�÷��� ��Ī / �÷��� AS ��Ī / �÷��� "��Ī" / Į���� AS "��ĥ"
AS ��� ���� ���ڹ��� ��Ī�� ���� Ȥ�� Ư�����ڰ� ���Ե� ��� �ݵ�� ""�� ������Ѵ�.

*/
SELECT EMP_NAME �����,SALARY,SALARY*12 AS �޿� , (SALARY+SALARY*BONUS)*12 AS "���ʽ��� ���Ե� ����" 
FROM EMPLOYEE;

--------------------------------------------------------------------------
/*  <���ͷ�>
    ���Ƿ� ������ ���ڿ� ('')
    SELECT ���� ���ͷ��� �����ϸ� ��ġ ���̺�� �����ϴ� ������ó�� ��ȸ ����
    ��ȸ�� RESULT SET�� ��� �࿡ �ݺ������� ���� ���
*/

--EMPOLYEE ���̺��� ���, �����, �޿� ��ȸ
SELECT EMP_NO,EMP_NAME,SALARY, '��' AS "����" 
FROM EMPLOYEE;

/*
<���� ������ : || >
���� �÷� ������ ��ġ �ϳ��� �÷��� ��ó�� �����ϰų�, �÷����� ���ͷ��� ������ �� ����
*/

--��� , �̸� , �޿��� �ϳ��� �÷����� ��ȸ 
SELECT EMP_NO || EMP_NAME || SALARY ""
FROM EMPLOYEE;

--�÷����� ���ͷ��� ����

---�̸� �� ������ XXX�� �Դϴ� <<��Ī�� �޿�����

SELECT EMP_NAME || '�� ������ ' ||  SALARY || '�� �Դϴ� ' AS "�޿�����"
FROM EMPLOYEE;

------------------------------------------
/*
    <DISTINCT> 
�÷��� �ߺ��� ������ �ѹ� ���� ǥ���ϰ��� �� �� ����Ѵ�.

*/
--���� �츮ȸ�翡 � ������ ������� �����ϴ��� 

SELECT JOB_CODE  
FROM EMPLOYEE; --����� 23���� ������ ���δ� ��ȸ�� ��.

--EMPLOYEE �� �����ڵ� �ߺ����� 

SELECT DISTINCT JOB_CODE 
FROM EMPLOYEE; ---�ߺ� ���� �ż� 7�ุ ��ȸ

--������� � �μ��� �����ִ��� 
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; --NULL ���� �μ���ġ �ȵȻ��

--���ǻ��� : DISTINCT �� SELECT ���� �� �ѹ��� ��� ���� 
/*�������� 
SELECT DISTINCT JOB_CODE , DISTINCT DEPT_CODE 
FROM EMPLOYEEL;
*/

--�ذ���

SELECT DISTINCT JOB_CODE , DEPT_CODE
FROM EMPLOYEE;
--JOB CODE,DEPT_CODE ������ ���  �ߺ��Ǻ�

/*
  <WHERE ��>
  ��ȸ�ϰ��� �ϴ� ���̺�κ��� Ư�� ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ��� �� �� ���
  �̶� WHERE ���� ���ǽ��� ���� �Ѵ�.
  ���ǽĿ��� �پ��� �����ڸ� ��밡���ϴ� 
  
  [ǥ����]
  SELECT �÷�1, �÷�2 ...
  FROM ���̺��
  WHERE ���ǽ�, 
  
  [�񱳿�����] 
  > , < , >= , <= --> ��Һ�
  =               --> �����
  !=, ^= , <>     --> �������� ������ �� 
*/

--EMPLOYEE ���� �μ��ڵ尡 'D9'�� ����鸸 ��ȸ(�̶�, ��� Į�� ��ȸ)
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--EMPLOYEE���� �μ��ڵ尡 'D1' �� �������  �����, �޿� , �μ��ڵ常 ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--EMPLOYEE���� �μ��ڵ尡 'D1'�� �ƴ� ������� ���, �����, �μ��ڵ� ��ȸ
/*SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';*/
/*
SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D1';
*/
SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ^= 'D1';

--�޿��� 400���� �̻��� ������� �����,�μ��ڵ�,�޿���ȸ
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >= '4000000';


--EMPLOYEE���� �������� (EMP_YN �÷����� 'N')�� ������� ���, �̸� , �Ի���

SELECT EMP_ID,EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

------------------------------------�ǽ�����-------------------------------
--1. �޿��� 300���� �̻��� ������� �����, �޿� , �Ի���, ����(���ʽ� ������)
SELECT EMP_NAME,SALARY,HIRE_DATE,SALARY*12
FROM EMPLOYEE
WHERE SALARY >= 3000000;
--WHERE SALARY >= '3000000';  // WHERE�������� SELECT ���� �ۼ��� ��Ī ���Ұ� 

--���� ���� ����
--FROM��  => WHERE�� => SELECT��

--2. ���� 5000���� �̻��� ������� �����, �޿�, ����, �μ��ڵ�
SELECT EMP_NAME,SALARY,SALARY*12,DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;

--3. �����ڵ� 'J3' �� �ƴ� ������� ���,�����,�����ڵ�,��翩�� ��ȸ
SELECT EMP_ID, EMP_NAME,DEPT_CODE, ENT_YN
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D3';

--�μ��ڵ� 'D9' �̸鼭 �޿��� 500���� �̻��� ������� ���,�����,�޿�,�μ��ڵ带 ��ȸ
SELECT  EMP_ID , EMP_NAME , SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY > 5000000;

--�μ��ڵ尡 'D6' �̰ų� �޿��� 300���� �̻��� ������� �����, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

--�޿��� 350���� �̻� 600���� ���ϸ� �޴� ������� �����, ���, �޿� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY 
FROM EMPLOYEE
WHERE SALARY >= 3500000  AND  SALARY <= 6000000;

----------------------------------
/*
    < BETWEEN AND >
    ���ǽĿ��� ���Ǵ� ����
    �� �̻� �� ������ ������ ���� ������ ���� �� ���Ǵ� ������
    
    [ǥ����]
    �񱳴���÷� BETWEEN A(��1) AND B(��2)
    =>�ش� �÷��� ���� A �̻��̰� B������ ���
*/

SELECT EMP_NAME, EMP_ID, SALARY 
FROM EMPLOYEE
WHERE SALARY BETWEEN  3500000  AND   6000000;

-- 350000 600000 �̿��� ������� ��ȸ�ϰ� �ʹٸ�? 350�̸� + 600�ʰ�

SELECT EMP_NAME, EMP_ID, SALARY 
FROM EMPLOYEE
--WHERE SALARY < 3500000  OR  SALARY > 6000000;
--WHERE NOT SALARY BETWEEN  3500000  AND   6000000;
WHERE  SALARY NOT BETWEEN  3500000  AND   6000000;
--NOT : �� ���� ������ = > �ڹٿ����� !
--�÷��� �� �Ǵ� BETWEEN �տ� ���԰���

--�Ի����� '90/01/01 ~ '01/01/01'
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE > '90/01/01' AND HIRE_DATE < '01/01/01'; --DATE ������ ��Һ� ����
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/10';

/*
    <LIKE>
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    �񱳴���÷� LIKE 'Ư������'
    -Ư�� ���� ���ý� '%' ,'_'�� ���ϵ�ī��� ����� ���ִ�.
    '%'  : 0���� �̻�
    EX) �񱳴�� �÷� LIKE '����%' =>�񱳴���� �÷����� ���ڷ� "����" �Ǵ� ������ ��ȸ
        �񱳴�� �÷� LIKE '%����' =>�񱳴���� �÷����� ���ڷ� "��"���� ������ ��ȸ
        �񱳴�� �÷� LIKE '%����%' =>�񱳴���� �÷��� �� ���ڰ� "����" �Ǵ°��� ��ȸ (Ű���� ��ȸ)
        
    >> '_' :1���� �̻� 
    EX) �񱳴���÷� LIKE '_����' => �񱳴���� �÷����� ���ھտ� ������ �ѱ��ڸ� ���� ��� ��ȸ
        �񱳴���÷� LIKE '_����'  => �񱳴���� �÷����� ���ھտ� ������ �α��ڰ� �� ��� ��ȸ
        �񱳴���÷� LIKE '_����_' => �񱳴���� �÷����� ���� �հ� ���� �ڿ� ������ �ѱ��ھ� �� ���
*/
--����� �� ���� ������ ������� �����, �޿� ,�Ի��� ��ȸ
SELECT EMP_NAME , SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
--�̸��� �Ϸ� ������ ������� �����,�ֹι�ȣ,��ȭ��ȣ ��ȸ
SELECT EMP_NAME , EMP_NO,PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--�̸��� �� �� ���Ե� ������� �����,�ֹι�ȣ,��ȭ��ȣ

SELECT EMP_NAME , EMP_NO,PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';


--�̸��� ��� ���ڰ� �� �� ������� �����,��ȭ��ȣ ��ȸ
SELECT EMP_NAME , EMP_NO
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

--��ȭ��ȣ 3��° �ڸ��� 1�λ������ ���,�����,��ȭ��ȣ,�̸�����ȸ
--���ϵ�ī�� : _ (1����), %(0�����̻�)
SELECT EMP_NO, EMP_NAME, PHONE,EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

--**Ư�����̽�
-- �̸��� �� _ �������� �ձ��ڰ� 3������ ������� ���, �̸� , �̸��� ��ȸ 
--EX) SIM_BS@KH.SDKSLAD.COM
SELECT EMP_ID,EMP_NAME,EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; --���ߴ� ��� ���� ���� 
--���ϵ�ī��� ���ǰ� �ִ� ���ڿ� �÷����� ��� ���ڰ� �����ϱ� ������ ����� ��ȸ���� ����
--��� ���ϵ�ī��� ��� ������ ������ �����������
--������ ������ ����ϰ��� �ϴ� �� �տ� ������ ���ϵ� ī�带 �����ϰ� ������ ���ϵ� ī�带 ESCAPE OPTION���� ����ؾ���

--���� ������� �ƴ� �� ���� ����� ��ȸ
SELECT EMP_ID,EMP_NAME,EMAIL
FROM EMPLOYEE
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$' ;


---------------------------�ǽ�����--------------------------------------------
--1. EMPLOYEE���� �̸��� '��'���� ������ ������� �����,�Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';


--2. EMPLOYEE���� ��ȭ��ȣ ó�� 3�ڸ���  010 �� �ƴ� ������� �����, ��ȭ��ȣ ��ȸ

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

--3. EMPLOYEE���� �̸��� '��' �� ���ԵǾ� �ְ� �޿��� 240���� �̻��� ������� �����,�޿� ��ȸ

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%' AND SALARY > 2400000;

--4. DEPARTMENT���� �ؿ� �������� �μ����� �ڵ�� �μ����� ��ȸ
SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%'; 




SELECT BONUS 
FROM EMPLOYEE;
/*
<IS NULL / IS NOT NULL >
�÷����� NULL�� ���� ��� NULL�� �񱳿� ���Ǵ� ������
*/

-- ���ʽ��� ���� �ʴ� ���(BONUS ���� NULL) ���� ���, �̸� ,�޿� ,���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
--WHERE BONUS  = NULL;
WHERE BONUS IS NULL;

--���ʽ��� �޴� ���BONUS ���� NULL�� �ƴ�)���� ���,�̸�,�޿�,���ʽ� ��ȸ

SELECT EMP_ID,EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
--WHERE BOBUS != NULL;
WHERE BONUS IS NOT NULL;
--NOT�� �÷��� �Ǵ� IS �ڿ��� ��� ����

--����� ���� ������� �����, ������,�μ��ڵ���ȸ

SELECT EMP_NAME,EMP_NO,DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--�μ���ġ�� ���� ������ �ʾ�����(DEPT_CODE ���� NULL��), ���ʽ��� �޴� ���(BONUS ���� NULL�� �ƴ�)�̸�,���ʽ�,�μ��ڵ���ȸ

SELECT EMP_NAME ,BONUS,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--------------------------------------
--�μ��ڵ� D6�̰ų� D8 �̰ų� D5�� �μ��� �̸� �ڵ� �޿���ȸ
/*
    <IN>
    �񱳴���÷����� ���� ������ ����߿� ��ġ�ϴ� ���� �ִ��� 
    
    <ǥ����>
    WHRER �񱳴�� �÷� IN ('��1','��2','��3'....);
    
*/


SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6','D8','D5');

-�� ���� ����� 
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6','D8','D5');

/*
<������ �켱 ����>
0. ()
1. ���������
2. ���Ῥ����
3. �񱳿�����
4. IS NULL / LIKE 'Ư������' / IN 
5. BETWEEN AND
6. NOT(��������)
7. AND(��������)
8. OR(��������)
*/

--���� �ڵ尡 J7�̰ų� J2�� ����� �� �޿��� 200���� �̻��� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

*/

--------------------<�ǽ�����>-------------------------

-- 1. ����� ���� �μ���ġ�� ���� ���� ���������� (�����,���,�μ��ڵ�)
SELECT EMP_NAME,EMP_NO,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND MANAGER_ID IS NULL;

-- 2. ����(���ʽ�������)�� 3000���� �̻��̰� ���ʽ��� ���� �ʴ� ������� (���,�����,�޿�,���ʽ�)
SELECT EMP_NO ,EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000 AND BONUS IS NULL;

-- 3. �Ի����� '95/01/01/' �̻��̰� �μ���ġ�� ���� ������� (��� ,�����, �Ի���, �μ��ڵ�) ��ȸ
SELECT EMP_NO,EMP_NAME,HIRE_DATE,DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. �޿��� 200���� �̻� 500���� �����̰� �Ի����� '01/01/01' �̻��̰� ���ʽ��� ���� �ʴ� ������� 
-- (��� , ����� , �޿� , �Ի���, ���ʽ�)��ȸ

SELECT EMP_NO, EMP_NAME,SALARY,HIRE_DATE,BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000  AND HIRE_DATE >= ' 01/01/01' AND BONUS IS  NULL ; 

-- 5. ���ʽ����Կ����� null �� �ƴϰ� �̸��� '��' �� ���ԵǾ� �ִ� ������� (���, �����, �޿� ,���ʽ����Կ���) ��ȸ

SELECT EMP_NO,EMP_NAME,SALARY,((SALARY+BONUS*SALARY)*12)
FROM EMPLOYEE
WHERE ((SALARY+BONUS*SALARY)*12) IS NOT NULL AND EMP_NAME LIKE '%��%';

SELECT EMP_NO,EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

/*
    < ORDER BY ��>
    ���� ������ �ٿ� �ۼ�! �Ӹ� �ƴ϶� ������� ���� �������� ����
    
    [ǥ����]
    SELECT ��ȸ�� �÷�, �÷� , �������� AS "��Ī", ...
    FROM ��ȸ�� ���̺�
    WHERE ���ǽ�
    ORDER BY  �����ϰ� ���� �÷�! ��Ī! �÷����� [ASC/DESC] [NULLS FIRST | NULLS LAST]

    ASC- �������� ���� (������ �⺻��)
    DESC-�������� ���� 
    NULLS FIRST- �����ϰ��� �ϴ� �÷����� NULL�� �ִٸ� �ش� �����͸� ���ʿ� ��ġ (������ DESC�϶��� �⺻��)
    NULLS LAST- �����ϰ��� �ϴ� �÷����� NULL�� �ִٸ� �ش� �����͸� ���ʿ� ��ġ (������ ASC�ϋ��� �⺻��)
    
*/
--��������
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;  -- �Ǵ� ORDER BY BONUS ASC 
ORDER BY BONUS NULLS FIRST;
-- �������� ������ �� �⺻������ NULLS FIRST ���� �� �� �ִ�.


--��������
SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC;
-- �������� ������ �� �⺻������ NULLS LAST ���� �� �� �ִ�.

SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC, SALARY ASC;

--���ı��� ������ ���� ���� (ù��° ������ �÷����� ������ ��� �ι�° ���� �÷������� �˻�  EX)BONUS 0.2 �� ���� �� ���� SALART �� ����)


--������� �����, ������ȸ (�̶� ������ �������� ������ȸ)
SELECT EMP_NAME,SALARY*12 AS "����"
FROM EMPLOYEE
--ORDER BY SALARY*12 DESC;
--ORDER BY ���� DESC; ��Ī��밡��
ORDER BY 2 DESC; --  �÷��� �������� ��� �����ϴ�








