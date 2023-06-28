SELECT * FROM EMPLOYEE; --D9
SELECT * FROM DEPARTMENT --�ѹ���
WHERE DEPT_ID = 'D9';
SELECT * FROM LOCATION
WHERE LOCAL_CODE = 'L1';
SELECT * FROM NATIONAL
WHERE NATIONAL_CODE = 'KO';

/*
    < JOIN >
    �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ���´�
    
    ������ ������ ���̽��� �ּ����� �����ͷ� ������ ���̺� �����͸� ��� ���� (�ߺ��� �ּ�ȭ �ϱ� ���� �ִ��� �ɰ��� ����)
    
    --� ����� ��μ��� �����ִ��� �ñ��� ��Ȳ
    --������ �����ͺ��̽����� SQL���� �̿��� ���̺� ���� '����"�� �δ� ���
    (������ �� ��ȸ�� �ϴ°� �ƴ϶� �� ���̺� ������ν��� �����͸� ��Ī�ؼ� ��ȸ ���Ѿ��Ѵ�.)

    JOIN �� ũ�� 1.����Ŭ ���뱸�� 2.ANSI ����(�̱�����ǥ����ȸ) �ƽ�Ű�ڵ�ǥ ����� ��ü
 --------------------------------------------------------------------------
 ����Ŭ ���뱸��              |           ANSI ����
--------------------------------------------------------------------------
�����                    |           ��������([INNER JOIN]) => JOIN USING /ON
EQUAL JOIN                |           �ڿ� ����(NATUAL JOIN) =? JOIN USING 
--------------------------------------------------------------------------
��������                    |           ���� �ܺ����� [LEFT OUTER JOIN] 
[LEFT OUTER]              |           ������ �ܺ����� [RIGHT OUTER JOIN]
[RIGHT OUTER]             |            ��ü �ܺ����� [PULL OUTER JOIN] 
--------------------------------------------------------------------------
��ü����(SELF JOIN)         |           JOIN ON
�� ���� (NON EQULAL JOIN |
--------------------------------------------------------------------------
*/

SELECT EMP_NAME,DEPT_CODE FROM EMPLOYEE;

--��ü ������� ���, ����� ,�μ��ڵ� ,�μ��� ��ȸ�ϰ��� �Ҷ�
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID , DEPT_TITLE
FROM DEPARTMENT;

--��ü ������� ��� ,�����,�����ڵ�,���޸� ��ȸ
SELECT EMP_ID ,EMP_NAME ,JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE,JOB_NAME
FROM JOB;

/*
    1.� ���� (EQUAL,JOIN) / ��������(INNER JOIN)
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ (��ġ�ϴ� ���� ���� ���� ��ȸ���� ����)
*/

-->����Ŭ ���뱸��
--FROM ���� ��ȸ�ϰ��� �ϴ� ���̺���� ���� (,�����ڷ�)
--WHERE ���� ��Ī��ų Į��(�����)��[���� ������ ������


--1)������ �� �÷����� �ٸ���� (EMPLOYEE : DEPT_CODE , DEPARTMENT : DEPT_ID)
-- 1)���,�����,�μ��ڵ�,�μ����� ���� ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

--��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵȰ� Ȯ�ΰ��� 
--DEPT_CODE�� NULL�� ��� ��ȸ X,DEPT_ID �� D3 D4 D7��ȸX

--2)������ �� �÷����� ���� ��� (EMPLOYEE : JOB_CODE DEPARTMENT : JOB_CODE)
--��� ,�����,�����ڵ�,���޸�
SELECT EMP_ID, EMP_NAME,JOB_CODE , JOB_NAME
FROM EMPLOYEE, JOB
--column ambiguously defined  -> �ָ��ϴ�
WHERE JOB_CODE = JOB_CODE;


-- �ذ��� 1) ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME,EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

--�ذ��� 2) ���̺� ��Ī�� �ο��ϴ� ���
SELECT EMP_ID, EMP_NAME,E.JOB_CODE,JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->ANSI ����
--FROM���� ������ �Ǵ� ���̺��� �ϳ� ��� �� ��
--JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���ǵ� ���
--JOIN USING, JOIN ON 

--�ذ���1) ���̺�� �Ǵ� ��Ī�� �̿��ؼ� �ϴ¹��
--1)������ �� �÷����� �ٸ���� (EMPLOYEE: DEPT_CODE , DEPARTMENT : DEPT_ID)
--������ JOIN ON �������θ� ��밡��
--���,�����,�μ��ڵ�,�μ���
SELECT EMP_ID, EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--2)������ �� �÷����� ���� ��� (E:JOB_CODE, J:JOB_CODE)
-- JOIN ON, JOIN USING ���� ��� ����
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);



--�ذ���2) JOIN USING ���� ����ϴ� ��� (�� �÷����� ��ġ �� �� �� ��밡��)
SELECT EMP_ID, EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

---------------------------------�ڿ����� START----------------------------

-----[�������]
--�ڿ�����(NATURAL JOIN ) : �� ���̺� ���� ������ �÷��� �Ѱ��� ������ ���
SELECT EMP_ID,EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

--�߰����� ���ǵ� ���� ����
--������ �븮�� ����� �̸�, ���޸�, �޿� ��ȸ
-- >> ����Ŭ ���� ����
SELECT EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E ,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '�븮';

-- >>ANSI ����
SELECT EMP_NAME,JOB_NAME ,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮';

----------------------------------�ǽ�����----------------------------------
--1.�μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE ,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE = '�λ������';

-->> ANSI����
SELECT EMP_ID,EMP_NAME,BONUS
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

--2.DEPARTMENT �� LOCATION�� �����ؼ� ��ü �μ��� �μ��ڵ�,�μ���,�����ڵ�,������ ��ȸ
-->> ����Ŭ ���뱸��
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT,LOCATION
WHERE LOCATION_ID = LOCAL_CODE;


-->> ANSI����
SELECT DEPT_ID,DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID= LOCAL_CODE); 

--3.���ʽ��� �޴� ������� ���, ����� ,���ʽ� ,�μ��� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL ; 


-->> ANSI����
SELECT EMP_ID,EMP_NAME,BONUS,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
AND BONUS IS NOT NULL ; 

--4.�μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿�, �μ��� ��ȸ
-->> ����Ŭ ���뱸��
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_TITLE  != '�ѹ���';


-->> ANSI����
SELECT EMP_NAME,SALARY,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE  != '�ѹ���';
--���� DEPT_CODE�� NULL �ΰ��� ������ ���� �ʴ´�
----------------------------------------------------------------------------
/*
    2. ���� ���� / �ܺ� ���� (OUTER JOIN)
    �� ���̺� ���� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT / RIGHT �����ؾߵ�!! (������ �Ǵ� ���̺� ����)
    
*/

-- �����, �μ���, �޿�, ����
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--�μ� ��ġ�� �ȵ� ��� 2�� ���� ���� ��ȸ �Ұ����ϴ�
--�μ��� ������ ����� ���� �μ� ���� ��쵵 ��ȸ �Ұ����ϴ�

-- 1) LEFT[OUTER] JOIN : �� ���̺� �� ���� ����� ���̺� �������� JOIN
-->ANSI����
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12
FROM EMPLOYEE --LEFT JOIN�� ������ ����� ���̺��� ������ �� ��ȸ�ȴ�.
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--�μ���ġ�� ���� �ʾҴ� 2���� ��� ������ ��ȸ ��

--> ����Ŭ ���� ����
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);-- �������� ����� �ϴ� ���̺��� �ݴ��� �÷��ڿ� (+) ���̱�

--2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
-->> ANSI����
SELECT EMP_NAME, DEPT_TITLE,SALARY,SALARY * 12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--> ����Ŭ ���� ����
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3)FULL[OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� ���� (����Ŭ ���� �������δ� �Ұ���)
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

/*
  3.�� ���� (non equal join) => 
  ��Ī��ų �÷��� ���� ���� �ۼ��� '=(��ȣ)' �� ������� �ʴ� ���ι�
  ANSI �������δ� JOIN ON�� ��� ����
  
*/

SELECT EMP_NAME,SALARY,SAL_LEVEL
FROM EMPLOYEE;

SELECT *
FROM SAL_GRADE;

--�����,�׿�, �ִ� ���� �ѵ�
-->>����Ŭ ����
SELECT EMP_NAME,SALARY,MAX_SAL
FROM EMPLOYEE,SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->>ANSI ����
SELECT EMP_NAME, SALARY, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

----------------------------------------------------------------
/*
    4.��ü����( SELF JOIN )
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
    
*/

SELECT *FROM EMPLOYEE;

--��ü ����� ���, �����, ��� �μ��ڵ�  -->EMPLOYEE E
--  ����� ���, �����,����μ��ڵ�      -->EMPLOYEE N

-->> ����Ŭ ���� ����
SELECT E.EMP_ID AS "����� ���",E.EMP_NAME AS "�����",E.DEPT_CODE AS "����μ��ڵ�",
    N.EMP_ID AS "����� ���",N.EMP_NAME AS "�����",N.DEPT_CODE AS "����� �μ��ڵ�"
FROM EMPLOYEE E, EMPLOYEE N
WHERE E.MANAGER_ID = N.EMP_ID;

-->> ANSI ���뱸��
SELECT E.EMP_ID AS "����� ���",E.EMP_NAME AS "�����",E.DEPT_CODE AS "����μ��ڵ�",
    N.EMP_ID AS "����� ���",N.EMP_NAME AS "�����",N.DEPT_CODE AS "����� �μ��ڵ�"
FROM EMPLOYEE E
JOIN EMPLOYEE N ON (E.MANAGER_ID = N.EMP_ID);

-------------------------------------------------------------------------------

/*
    < ���� JOIN >
    2�� �̻��� ���̺��� ������ JOIN �� ��
    
*/

-- ���, �����, �μ���, ���޸� ��ȸ
SELECT * FROM EMPLOYEE;  -- DEPT_CODE , JOB_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID
SELECT * FROM JOB; -- JOB_CODE

-->>����Ŭ ���� ����
SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE A,DEPARTMENT,JOB B
WHERE DEPT_CODE = DEPT_ID AND A.JOB_CODE = B.JOB_CODE;

-->>ANSI ����
SELECT EMP_ID ,EMP_NAME,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

--���,�����,�μ���,������

SELECT * FROM EMPLOYEE; -- DEPT_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID LOCATION_ID
SELECT * FROM LOCATION; --LOCAL_CODE , LOCAL_NAME

-->>����Ŭ ���� ����
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE,DEPARTMENT,LOCATION
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE; 

-->>ANSI ����

SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-----------------------------�ǽ�����----------------------------------
SELECT * FROM NATIONAL; --NATIONAL_CODE
SELECT * FROM LOCATION; --NATIONAL_CODE
SELECT * FROM DEPARTMENT;--DEPT_ID/LOCATION_ID 
SELECT * FROM EMPLOYEE; --DEPT_CODE


--1.���,�����,�μ���,������,������ ��ȸ (EMP,DEPA,LO,NAT)
-->>����Ŭ ���� ���� 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT,LOCATION L ,NATIONAL N 
WHERE DEPT_CODE = DEPT_ID 
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-->>ANSI ���� ����
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

SELECT * FROM SAL_GRADE; SAL_LEVEL;


--2.��� , �����,�μ���,���޸�,������,������,�ش� �޿���޿��� ���� �� �ִ� �ִ� �ݾ� ��ȸ
-->>����Ŭ ���� ���� 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME ,MIN_SAL ,MAX_SAL
FROM EMPLOYEE E, DEPARTMENT,LOCATION L ,NATIONAL N , SAL_GRADE S
WHERE DEPT_CODE = DEPT_ID 
AND LOCATION_ID = LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SAL_LEVEL = S.SAL_LEVEL;

-->>ANSI ���� ����

SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME,MIN_SAL ,MAX_SAL
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE USING (SAL_LEVEL);

--3.

