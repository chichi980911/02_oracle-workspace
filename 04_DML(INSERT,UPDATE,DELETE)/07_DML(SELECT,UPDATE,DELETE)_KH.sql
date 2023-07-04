/*
    DQL (QUERY������ ���� ���) : SELECT
    
    DML (MANIPULATION ������ ���� ���) : [SELECT]INSERT,UPDATE, DELETE
    DDL (DEFINTION ������ ���� ���) : CRATE ,ALTER , DROP
    DCL (CONTRIOL ������ ���� ���) : GRANT,REVOKE [COMMIT ,ROLLBACK ]
    
    TCL (TRANSACTION Ʈ������ ���� ���) : COMMIT ,ROLLBACK 
    
    <DML : DATA MANIPULATION LAGUAGE >
    ������ ���۾��
    
    ���̺� ���� ����(INSERT) �ϰų�, ����(UPDATE)�ϰų�, ����(DELETE) �ϴ� ����
*/

/*
    1.INSERT
    ���̺� ���ο� ���� �߰��ϴ� ����
    
    [ǥ����]
    1) INSERT INTO ���̺�� VALUES(��1,��2,..);
        ���̺� ��� �÷��� ���� ���� ���� �����ؼ� �� �� INSERT �ϰ��� �� �� ���
        �÷������� ���Ѽ� VALUES�� ���� �����ؾߵ�!
        
        
        �����ϰ� ���� �������� ��� not enough values �����߻� 
        ���� �� ���� �������� ��� too many values �����߻�
        
        
*/
INSERT INTO EMPLOYEE
VALUES(900,'������','900101-1234567','cha00@kh.or.kr','01011112222',
'D1','J7','S3',4000000,0.2,200,SYSDATE,NULL,DEFAULT);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '������';
/*
    2)INSERT INTO ���̺�� (�÷���,�÷���,�÷���) VALUES (��1,��2,��3);
    ���� ������ �÷��� ���ؼ��� ���� INSERT�� �� �ִ�.
    �� �� ������ �߰��Ǳ� ������ ������ �ȵ� �÷��� �⺻�����δ� NULL�� ��
    NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �� ���� 
    ��, DEFAULT ���� �ִ� ���� NULL�� �ƴ� DEFAULT ���� ����
*/
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES(901,'������','888888-1654212','J1','S2',SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME,EMP_NO,JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES(902,'����ȯ','888888-1654312','J1','S2',SYSDATE);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '����ȯ';
--ENT_NO�� ����Ʈ������ �� ����

INSERT
  INTO EMPLOYEE
       (
        EMP_ID
       ,EMP_NAME
       ,EMP_NO
       ,JOB_CODE
       ,SAL_LEVEL
       ,HIRE_DATE
       )
VALUES
       (
        901
       ,'������'
       ,'980202-1111111'
       ,'J1'
       ,'S2'
       ,SYSDATE
       );
       
------------------------------------------------------------------------------
/*
    3)INSERT INTO ���̺�� (��������);
      VALUES�� ���� ���� ����ϴ°� ���
      �������� ��ȸ�� ������� ��°�� INSERT ����(������ INSERT ����)
*/

--���ο� ���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-->��ü ������� ���, �̸�, �μ��� ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01(
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;

/*
    2.INSERT ALL
    
*/

-->�켱 �׽�Ʈ�� ���̺� �����
--������ �賢��
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME,DEPT_CODE,HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0;

SELECT * FROM EMP_DEPT;


CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID,EMP_NAME,MANAGER_ID
FROM EMPLOYEE
WHERE 1 = 0;

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;


--�μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ� ,�λ縻, ������ ��ȸ
SELECT EMP_ID,EMP_NAME,DEPT_CODE,HIRE_DATE,MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';


/*
    [ǥ����]
    INSERT ALL
    INTO ���̺��1 VALUES(�÷���, �÷���,...) 
    INTO ���̺��2 VALUES(�÷���, �÷���,...)
    ��������;
    
*/

INSERT ALL 
INTO EMP_DEPT VALUES(EMP_ID,EMP_NAME,DEPT_CODE,HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID,EMP_NAME,DEPT_CODE,HIRE_DATE,MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    

SELECT * FROM EMP_DEPT;
--=============================================================================
-- ������ ����ؼ� �� ���̺� INSERT ����

--2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
--���̺� ������ �貸�� ���� �����

CREATE TABLE EMP_OLD
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;

--2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
--���̺� ������ �貸�� ���� �����

 --2000�⵵ ���� �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
--���̺� ������ �貸�� ���� �����

CREATE TABLE EMP_NEW
AS SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY
    FROM EMPLOYEE
    WHERE 1 = 0;   

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;


/*
    [ǥ����]
    INSERT ALL
    WHEN ����1 THEN
        INTO ���̺��1 VALUES(�÷���,�÷���)
    WHEN ����2 THEN
        INTO ���̺��2 VALUES(�÷���,�÷���)
    ��������;
*/


INSERT ALL 
    WHEN HIRE_DATE < '2020/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    WHEN HIRE_DATE >= '2020/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
    SELECT EMP_ID,EMP_NAME,HIRE_DATE,SALARY 
    FROM EMPLOYEE;
    
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

------------------------------------------------------------------------------

/*

    3.UPDATE
    ���̺� ��ϵǾ� �ִ� ������ �����͸� �����ϴ� ����
    
    [ǥ����]
    UPDATE ���̺�� 
    SET �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�,
        �÷��� = �ٲܰ�,
        ...             -->�������� �÷��� ���ú��� ����(,�� �����ؾ��Ѵ�.)
    [WHERE ����];        -->�����ϸ� ��� �����Ͱ� ����ȴ�     
    */
    
--���̺� ���� �� �׽�Ʈ    
CREATE TABLE DEPARTMENT_COPY
AS SELECT * FROM DEPARTMENT; 

SELECT * FROM DEPARTMENT_COPY;

--D9 �μ��� �μ����� '������ȹ��'���� ����

UPDATE DEPARTMENT_COPY
SET DEPT_TITLE = '������ȹ��'; --�ѹ���

ROLLBACK;

UPDATE DEPARTMENT_COPY
SET DEPT_TITLE = '������ȹ��' --�ѹ���
WHERE DEPT_ID ='D9';

SELECT * FROM DEPARTMENT_COPY;


--�켱 ���纻 ���� ���� 
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,EMP_NAME,DEPT_CODE,SALARY,BONUS 
    FROM EMPLOYEE;

SELECT * FROM EMP_SALARY;

--���ö ����� �޿��� 100�������� ���� +������ ���
UPDATE EMP_SALARY
SET SALARY = 1000000 --3700000 
WHERE EMP_NAME = '���ö';

--������ ����� �޿��� 700�������� ���� +���ʽ� 0.2����
UPDATE EMP_SALARY
SET SALARY = 7000000, --8000000
    BONUS = 0.2       --0.3
WHERE EMP_NAME = '������';


--��ü ����� �޿��� ������ �޿��� 10���� �λ��� �ݾ� (�����ݾ�)
UPDATE EMP_SALARY
SET SALARY = SALARY+SALARY*0.1;

-- *UPDATE�� ���������� ��� ���� 
/*
    UPDATE ���̺��
    SET �÷��� = ��������
    WHERE ����;
*/

--���� ����� �޿��� ���ʽ����� ����� ����� �޿��� ���ʽ� ������ ����

--������ ��������
SELECT EMP_NAME,SALARY,BONUS
FROM EMP_SALARY --1300000 ,NULL
WHERE EMP_NAME = '����';

SELECT EMP_NAME,SALARY,BONUS
FROM EMPLOYEE --3400000 ,0.2
WHERE EMP_NAME = '�����';

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME = '�����'),
    BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '����';

--������ ��������
UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY,BONUS FROM EMP_SALARY WHERE EMP_NAME = '�����') 
WHERE EMP_NAME = '����';

SELECT EMP_NAME,SALARY,BONUS
FROM EMP_SALARY --1300000 ,NULL
WHERE EMP_NAME = '����';


--ASIA �������� �ٹ��ϴ� ������� ���ʽ� ���� 0.3���� �����ϴ� ����
--ASIA �������� �ٹ��ϴ� �����

SELECT * FROM LOCATION;
SELECT * FROM DEPARTMENT;
SELECT * FROM EMP_SALARY;

SELECT * FROM DEPARTMENT;


SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME IN ('ASIA1','ASIA2','ASIA3');


UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID 
                FROM EMP_SALARY
                JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                WHERE LOCAL_NAME IN ('ASIA1','ASIA2','ASIA3'));

--------------------------------------------------------------------------------
--UPDATE �ÿ��� �ش� �÷��� ���� �������� ����Ǹ� �ȵ�
--����� 200���� ����� �Ƹ��� NULL�� ����

UPDATE EMP_SALARY
SET EMP_NAME = NULL
WHERE EMP_ID = 200;

--Cannot update ("KH"."EMP_SALARY"."EMP_NAME") to NULL
--NOT NULL �������� ���� !!

--���ö ����� �����ڵ� J9�� ���� 
UPDATE EMPLOYEE
SET JOB_CODE = 'J9'
WHERE EMP_NAME = '���ö';
--ORA-02291: integrity constraint (KH.SYS_C007214) violated - parent key not foun
--FOREIGN KEY �������� ���� !!
COMMIT;
-------------------------------------------------------------------------------------
/*
    4.  <DELETE>
        ���̺� ��ϵ� �����͸� �����ϴ� ���� (�� �� ������ ������)
        
        [ǥ����]
        DELETE FROM ���̺��
        [WHERE ����;] -->WHERE �� ���� ���� ���ϸ� ��ü �� �� �����ȴ�.
*/

--������ ����� ������ �����
DELETE FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
ROLLBACK;--������ Ŀ�� �������� ���ư���.

DELETE FROM EMPLOYEE
WHERE EMP_ID = '222';

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '������';


COMMIT;

ROLLBACK;

--DEPT_ID �� D1�κμ�����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
--child record found 
--�ܷ�Ű �������� D1�� ���� �ڽ� �����Ͱ� �ִ�.

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';

SELECT * FROM DEPARTMENT;

ROLLBACK;

--*TRUNCATE : ���̺��� ��ü ���� ������ �� ���Ǵ� ����
--            ���� : DELETE ���� ����ӵ��� ������.
--            ������ ���� ���� �Ұ� , ROLLBACK �Ұ��ϴ�
--            [ǥ����]TRUNCATE TABLE ���̺��

SELECT * FROM EMP_SALARY;
COMMIT;

DELETE FROM EMP_SALARY;
ROLLBACK;

TRUNCATE TABLE EMP_SALARY;