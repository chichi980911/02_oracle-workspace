/*

    <GROUP BY ��> 
    �׷������ ���� �� �� �ִ� ���� (�ش� �׷���غ��� ���� �׷��� ���� �� ����)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; -->��ü ����� �ϳ��� �׷����� ��� ������ ���� ��� 

--���μ��� �� �޿� ��
SELECT DEPT_CODE ,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--���μ��� ��� �� 
SELECT DEPT_CODE , COUNT(*) ,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

SELECT JOB_CODE,COUNT(*),SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--�� ���޺� �� ����� ,���ʽ� �޴� ����� , �޿���, ��ձ޿�,�����޿�,�ִ�޿� ��Ī��� , ���޺� ������������
SELECT JOB_CODE,
COUNT(*) AS "�� �����",
COUNT(BONUS) AS "���ʽ� �޴� �����",
SUM(SALARY) AS "�޿���",
FLOOR(AVG(SALARY)) AS "��ձ޿�", 
MAX(SALARY) AS "�ִ�޿�",
MIN(SALARY) AS "�����޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

--GROUP BY ���� �Լ��� ��� ����
SELECT DECODE (SUBSTR(EMP_NO,8,1) , '1', '��' , '2', '��')
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);


--GROUP BY ���� �����÷� ��� �����ϴ�
SELECT DEPT_CODE,JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE
ORDER BY 1;

-------------------------------------------------------------------------------

/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ���Ǵ� ����( �ַ� �׷��Լ����� ������ ������ ������ �� ���)

*/

-- �� �μ��� ��� �޿� ��ȸ (�μ��ڵ� , ��ձ޿�)
SELECT DEPT_CODE , AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

--�μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ

SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >=3000000
GROUP BY DEPT_CODE; --���� �߻�; (�׷��Լ��� ������ ���� ���ý� WHERE ��� �Ұ���)


SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>=3000000;

--���޺� �� �޿���(�� ���޺� �޿��� 10,000,000�̻��� ���޸��� ��ȸ ) �����ڵ� , �޿���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

--�μ��� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ �μ��ڵ�, ���ʽ��� �޴� ����� �� 
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

-------------------------------------------------------------------------------
/*
    <SELECT�� ���� ����>
    5.SELECT * | ��ȸ�ϰ��� �ϴ� �÷� ��Ī | ����� "��Ī" | �Լ��� AS "��Ī"
    1.FROM ��ȸ�ϰ��� �ϴ� ���̺�� 
    2.WHERE ���ǽ� (�����ڸ� ������ ���)
    3.GROUP BY �׷�������� ���� �÷� | �Լ���
    4.HAVING ���ǽ� (�׷��Լ��� ������ ���)
    6.ORDER BY �÷��� | �÷����� | ��Ī [ 'ASC' |DESC  ] [NULLS FIRST | NULLS LAST]

*/

-------------------------------------------------------------------------------
/*
    < ���� ������ == SET OPERATION >
    
    �������� �������� ������ �ϳ��� ���������� ����� ������
    -- UNION : OR | ������ [�� ������ ������ ������� ���� �� �ߺ��Ǵ� ���� �ѹ��� ����������]
    -- INTERSECT : AND | ������{�� ������ ������ ������� �ߺ��� �����}
    -- UNION ALL : ������ + ������ (�ߺ��Ǵ� �κ��� �ι� ǥ���� �� �ִ�)
    -- MINUS     : ���� ��������� ���� ������� �� ������ (������)
    
*/

--�μ��ڵ尡 D5�� ��� /�Ǵ� �޿��� 300���� �ʰ��� ���/�� ��ȸ (���,�̸�,�μ��ڵ�,�޿�)
SELECT EMP_ID ,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


--1.UNION (������)
SELECT EMP_ID ,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--���� ������ ��� �Ʒ�ó�� WHERE ���� OR �ᵵ �ذ� ����
SELECT EMP_ID ,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

--2.INTERSECT(������)
--�μ��ڵ尡 D5�̸鼭 �޿������� 300���� �ʰ� ��� ��ȸ 
SELECT EMP_ID ,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--�Ʒ�ó���� ��밡���ϴ�.
SELECT EMP_ID ,EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

------------------------------------------------------------------------------
SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- UNION���� �� �������� SELECT���� �ۼ��Ǿ� �ִ� �÷� ������ �����ؾ��Ѵ�.

SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,BONUS--HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;

--�÷� ���� �Ӹ� �ƴ϶� �� �÷� �ڸ����� ������ Ÿ������ ����ؾ��Ѵ�.

SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
--ORDER BY EMP_NAME
UNION
SELECT EMP_ID,EMP_NAME,DEPT_CODE,BONUS--HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;

--ORDER BY ���� ���̰��� �Ѵٸ� �������� ����ؾ��Ѵ� (�ߺ� ��� �Ұ���)
-------------------------------------------------------------------------------

--3.UNION ALL : �������� ���� ����� ������ �� ���ϴ� ������(�ߺ��� ����)

SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY--HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;

--4.MINUS : ���� SELECT ������� ���� SELECT ����� �A ������ (������)
--�μ��ڵ尡 D5�� ����� �� �޿��� 300���� �ʰ��� ������� �����ؼ� ��ȸ
SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY--HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;
--�Ʒ�ó�� ǥ�� ����
SELECT EMP_ID, EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;



