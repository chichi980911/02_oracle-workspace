--�����ϱ�
----------------------QUIZ ---------------------
--���ʽ��� ���� ������ �μ���ġ�� �� ��� ��ȸ 
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
--NULL ���� ���� ���������� �� ó�� ���� ����;

--������ : NULL���� ���ҋ��� �ܼ��� �Ϲ� �񱳿����ڸ� ���� ���� �� ����.
--�ذ��� IS NULL /IS NOT NULL �����ڸ� �̿��ؼ� ���ؾߵ�

--��ġ�� SQL�� 
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;


---------------------------QUIZ2-----------------

--�˻��ϰ��� �ϴ� ����
--JOB_CODE J7 �̰ų� J6 �̸鼭 SALARY ���� 200���� �̻��̰�
--BONUS�� �ְ� �����̸� �̸����ּҴ� _�տ� 3���ڸ� �ִ� ����� 
--EMP_NAME, EMP_NO, JOB_CODE,SARALY, BONUS�� ��ȭ�Ϸ��� �Ѵ�.
--���������� ��ȸ�� �ߵȴٸ� �������� 2���̾�� �Ѵ�.


--���� ������ �����Ű���� �ۼ��� SQL���� �Ʒ��� ����.
SELECT EMP_NAME,JOB_CODE, DEPT_CODE,SALARY,BONUS
FROM EMPLOYEE
WHERE JOB_CODE ='J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE'____' ESCAPE '$'AND BONUS IS NULL ;

--___$_%' ESCAPE '%'
--���� SQL ����� ���ϴ� ����� ����� ��ȸ���� �ʴ´� (5���� ������)
--��� ã�Ƽ� �����ϰ� �Ϻ��� SQL�� �ۼ��ϱ�
/*

1)���� SALARY ���� 200���� �̻��ε� > ���   1)��ġ >=
2)���� OR �� AND �񱳽� �켱������ AND �� ���� ������ 2��° �÷��� 3��° �÷��� ���� �����ϰ� �ȴ�.
  ��ġ- OR �÷����� �����ش�. ()
3)���� EMAIL -�տ� 3���ڸ� �ִ� ����� ��ȸ �ؾ��ϴµ� _4���� �ν��Ͽ�  ������ �ʿ���
 ��ġ ESCAPE����Ͽ� ���� �ʿ�
4)���� BONUS IS NULL �� NULL�� ��ȸ
��ġ IS NOT NULL ���
5)���ڸ� ��ȸ�ؾ��ϴϱ� ���ο� SQL �ۼ�
SUBSTR(EMP_NO,8,1)
SUBSTR(�÷��� ,�ڸ��⸦ ������ �ε�����ȣ,�ڸ� ���� )
*/

SELECT EMP_NAME,EMP_NO,JOB_CODE, DEPT_CODE,SALARY,BONUS
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE'___$_%' ESCAPE '$' AND BONUS IS NOT NULL AND
SUBSTR(EMP_NO,8,1) IN ('2','4'); 

------------------------QUIZ3-------------------------
--(�������� ����) CREATE USER ������ INDENTIFIED BY ��й�ȣ
--������ :SCOTT,��й�ȣ:TIGER ������ �����ϰ� �ʹ�
--�̶� �Ϲݻ���� ������ KH ������ �����ؼ� CREATE USER SCOTT;�� �����ϴ� ���� �߻�

-- ����1. ����� ���� ������ ������ �����ڰ��������� �����ϴ�
-- ����2. SQL���� �߸� �Ǿ��� ��й�ȣ ���� �Է� �ؾ��Ѵ�.

--��ġ����.1 �����ڰ��� ���� 
--��ġ����.2 CREATE USER SCOTT IDENTIFIED BY TIGER;

--���� SQL(CREATE)���� ���� �� ������ ����� ������ �Ϸ��� �ߴ��� ����
--�Ӹ� �ƴ϶� �ش� ������ ���̺� ���� ���� �͵� ���� �ʴ´� 

--����1. ����� ���� ���� �� �ּ����� ���� �ο� 
--��ġ���� GRANT CONNECT, RESOURCE TO SCOTT;




