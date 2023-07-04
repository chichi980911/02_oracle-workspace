---ss
/*
    DDL (DATA DEFINETION LANGUAGE) : ������ ���� ���
    
    ��ü���� ���� (CREATE), ����(ALTER),����(DROP) �ϴ� ���� 
    
    < ALTER >
    ��ü�� �����ϴ� ���� 
    
    [ǥ����]
    ALTER TABLE ���̺�� �����ҳ���;
    * ������ ����
    1) �÷� �߰� / �÷� ����/ �÷� ����
    2) �������� �߰�/���� --> ������ �Ұ� (�����ϰ��� �Ѵٸ� ������ �� ������ �߰� )
    3) �÷���/�������� �� / ���̺�� ���� 
    
*/

--1) �÷� �߰� / ���� / ����
--1_1) �÷��߰� (ADD) : ADD �÷��� �ڷ��� [DEFAULT �⺻�� ]��������

--DEPARTMENT_COPY �� CNAME �÷� �߰�
ALTER TABLE DEPARTMENT_COPY ADD CNAME VARCHAR2(20);
-->���ο� �÷��� ��������� �⺻������ NULL�� ä������.

--LNAME �÷� �߰�
ALTER TABLE DEPARTMENT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

SELECT *
FROM DEPARTMENT_COPY;

--1_2) �÷� ����(MODIFY)
-->�ڷ��� ���� : MODIFY �÷��� �ٲٰ��� �ϴ� �ڷ��� 
-->DEFAULT �� ���� : MODIFY �÷Ÿ� DEFALUT �ٲٰ����ϴ� �⺻��
-->DEFAULT�� ���� 

ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_ID VARCHAR(3);

ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_ID NUMBER;
--�̰� ������ ���� �����Ͱ� ���ڰ� �ƴѰ͵� ����ִ�
--�����ϴ� ����;�Ͱ� ����߸� �ٲ� �� �ֵ�.
ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_TITLE VARCHAR(10);
--���� �̹� ����ִ� �����Ͱ� 16����Ʈ ���� ŭ


-- DEPT TITLE �÷��� VARCHAR2(50)���κ���
ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_TITLE VARCHAR(50);
-- LOCATION_ID �÷��� VARCHAR2(4)���κ���
ALTER TABLE DEPARTMENT_COPY MODIFY LOCATION_ID VARCHAR(4);
--LNAME �÷��� �⺻�� '�̱�����' ����
ALTER TABLE DEPARTMENT_COPY MODIFY LNAME DEFAULT '�̱�';

--���� ���� ����
ALTER TABLE DEPARTMENT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '����';
    
--1_3) �÷� ���� (DROP COLUMN): DROP COLUMN �����ϰ��� �ϴ� �÷���

--������ ���� ���纻 ���̺� ����

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPARTMENT_COPY;

SELECT * FROM DEPT_COPY2;
COMMIT;
--DEPT_COPT2 �κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2 
    DROP COLUMN CNAME
    DROP COLUMN LNAME;
    --�÷� ������ ���� ���� �Ұ���
    
ALTER TABLE DEPT_COPY2 
    DROP COLUMN CNAME;
    
ALTER TABLE DEPT_COPY2 
    DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 
    DROP COLUMN LOCATION_ID;
    --cannot drop all columns in a table
    --�ּ� �Ѱ��� �÷��� �����ؾ��Ѵ�.
-----------------------------------------------------------------------------

--2) �������� �߰� / ���� 
/*
    2_1) �������� �߰� 
    PRIMARY KEY : ADD PRIMARY KEY (�÷���)
    FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ���������̺��(�÷���)
    UNIQUE : ADD UNIQUE(�÷���)
    CHECK :  ADD CHECK(�÷��� ���� ����)
    NOT NULL : MODIFY �÷��� NOT NULL | NULL => �̰ž��� �� ���
    
    �������Ǹ��� �����ϰ��� �Ѵٸ� [CONSTRAINT �������Ǹ�] �������� �տ�

*/
--DEPT_ID  PRIMARY KET �������� �߰� ADD
--DEPT_TITLE�� UNIQUE �������� �߰� ADD
--LNAME�� NOT NULL �������� �߰� MODIFY

ALTER TABLE DEPARTMENT_COPY     
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY (DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE (DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_MN NOT NULL;
    
--2_2)�������� ���� : DROP CONSTRAINT �������Ǹ� 
--NOT NULL �������� MODIFY �÷��� NULL �� ���� 

ALTER TABLE DEPARTMENT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPARTMENT_COPY 
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
    
------------------------------------------------------------------------------

-- 3) �÷��� / �������Ǹ� / ���̺�� ���� (RENAME)

-- 3_1)�÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ� �÷��� 

--DEPT_TITLE �� DEPT_NAME���� ����
ALTER TABLE DEPARTMENT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
   
--3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������� --SYS_C007226

ALTER TABLE DEPARTMENT_COPY RENAME CONSTRAINT SYS_C007226 TO DCOPY_LID_MN;

--3_3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
ALTER TABLE DEPARTMENT_COPY RENAME TO DEPT_TEST; 

SELECT * FROM DEPT_TEST;

-------------------------------------------------------------------------------
/*
    < DROP>
    ���̺��� �����ϴ� ���� 
    
*/

-- ���̺� ���� 
DROP TABLE DEPT_TEST;

--�� ,��򰡿��� �����ǰ� �ִ� �θ����̺��� �Ժη� ������ ���� �ʴ´�.
--���� �����ϰ��� �Ѵٸ� 
--���1.�ڽ����̺��� ���� ���� �� �� �θ����̺� �����ϴ� ���
--���2.�θ� ���̺� ���� + �������� ���� ����
--      DROP TABLE  ���̺�� CASCADE CONSTRAINT;
--      

