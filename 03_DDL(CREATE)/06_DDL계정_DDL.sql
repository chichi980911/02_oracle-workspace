/*
    DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� ������ �����(CREATE),������ ����(ALTER),���� ��ü�� ����(DROP) �ϴ� ���
    ��, ��ü ������ ���� �ƴ� ������ �����ϴ� ���
    �ַ� DB������,�����ڰ� �����
    
    ����Ŭ���� �����ϴ� ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE),
                                �ε���(INDEX), ��Ű��(PACKAGE),Ʈ����(TRIGGER),
                                ���ν���(PROCEDURE),�Լ�(FUNCTION),���Ǿ�(SYNONYM), �����(USER)
    < CREATE >
    ��ü�� ������ �����ϴ� ����
*/

/*
    1.���̺� ����
     - ���̺��̶�? ��(ROW)�� ��(COLLUMM)�� ���� �⺻���� �����ͺ��̽� ��ü
                ��� �����͵��� ���̺��� ���ؼ� �����!!
                (DBMS ��� �� �ϳ���, �����͸� ������ ǥ ���·� ǥ���� ��!)
                
    [ ǥ���� ]
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� (ũ��),
        �÷��� �ڷ��� (ũ��),
        �÷Ÿ� �ڷ���,
        
    
    
    
    );
    
    *�ڷ��� 
    1.����: (CHAR(����Ʈ ũ��) | VARCHAR2(����Ʈũ��) => �ݵ�� ũ�� ���� �ؾ���
   
    > CHAR : �ִ� 2000����Ʈ���� ���� ����. 
            ������ ���� �ȿ����� ����Ѵ�./
            �������� (������ ũ�⺸�� �� ���� ���� ���͵� �������� ä������.)
            ������ ���ڼ��� �����͸��� ��� ��� ��� 
            => �Ϲ������� �ѱ��ڻ��� ���ȴ�. EX)�������� Y/N , M/F
    > VARCHAR2 : �ִ� 4000����Ʈ ���� ���� ����. 
                ���� ����(��� ���� ���� ������ ũ�Ⱑ ��������.)
                �� ������ �����Ͱ� ������ �𸣴� ��� + ���
    2.���� (NUMBER)
    
    
    3.��¥ (DATE)
*/

--ȸ���� ���� �����͸� ��� ���� ���̺� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PW VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

--���̺� ������ �÷��� ��Ÿ�� �߻��� ��� ������ ���� �� �ٽ� �������Ѵ�.
--DROP TABLE (���̺��);

--������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺��
--[����] USER_TABLE : ���� �� ������ ������ �ִ� ���̺� ���� �� �� ����
SELECT * FROM USER_TABLES;

--[����] USER_TAB_COLUMNS : �� ����ڰ� ������ �ִ� ���̺���� ��� �÷� �� �� ����
SELECT * FROM USER_TAB_COLUMNS;

------------------------------------------------------------------------------
/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ��������)
    
    [ǥ����]
    COMMENT ON COLUMN : ���̺��.�÷��� IS '�ּ�����';
    >>�߸� �ۼ���  ���� �� �ٽ� ����
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ������';
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';

COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PW IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

--���̺��� �����ϰ��� �� �� : DROP TABLE ���̺��;

--���̺� ������ �߰���Ű�� ����(DML : INSERT) �̶� �ڼ��ϰ� ���
--INSERT INTO ���̺�� VALUES (��1,��2,��3,...);
SELECT * 
FROM MEMBER;

--INSERT INTO MEMBER VALUES(1,'user01','pass01','ȫ�浿');
--INSERT�� ������ �÷��� �����͸� �Է��� �� ���� �Է����� ������ ������ �߻��Ѵ�.

INSERT INTO MEMBER VALUES(1,'user01','pass01','ȫ�浿','��','010-111-2222','shkim3657@naver.com','20/12/30');
INSERT INTO MEMBER VALUES(2,'user02','pass02','ȫ���','��',null,NULL,SYSDATE);

INSERT INTO MEMBER VALUES(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
--��ȿ���� ���� �����Ͱ� ���� �ִ� - ������ �ɾ�����Ѵ�

-------------------------------------------------------------------------------
/*
    *�������� CONSTRAINTS
    -���ϴ� ������ �� (������ �����ǰ�)�� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ��������
    -������ ���Ἲ ������ �������� �Ѵ�
    
    *���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY  
*/

/*
    *NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ߸� �� ��� (��, �ش� �÷��� ���� NULL�� ���ͼ��� �ȵǴ� ���)
    ���� / ������ NULL ���� ������� �ʵ��� ����
    
    ���� ������ �ο��ϴ� ����� ũ�� 2������ ���� (�÷�������� / ���̺������)
    * NOT NULL ���������� ������ �÷�������� �ۿ� �ȵ� 
*/

--�÷�������� : �÷��� �ڷ��� �������� 
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2 (20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);


SELECT * FROM MEM_NOTNULL;
INSERT INTO MEM_NOTNULL VALUES (1,'user01','pass01','�����','��',null,null);

INSERT INTO MEM_NOTNULL VALUES (2,'user02','pass02',null,'��',null,null);
--cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_NAME")
--�ǵ��ߴ� ��� ������ �߻��ߴ�. (NOT NULL �������ǿ� ����Ǿ� ������ �߻�
INSERT INTO MEM_NOTNULL VALUES (2,'user01','pass01','�̽¿�',NULL,NULL,NULL);
--���̵� �ߺ��Ǿ��������� �ұ��ϰ� �� �߰��ȴ�.

-------------------------------------------------------------------------------
/*
    *UNIQUE
    �ش� �÷��� �ߺ��� ���� ������ �ȵ� ��� �÷����� �ߺ����� �����ϴ� ��������
    ����/����
*/

CREATE TABLE MEM_UNIQUE(--�÷��������
    MEM_NO NUMBER NOT NULL ,
    MEM_ID VARCHAR2 (20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL ,
    MEM_ID VARCHAR2 (20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -->���̺� �������
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','�����',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01','pass01','�̰���',null,null,null);
--unique constraint (DDL.SYS_C007116) violated
--> UNIQUE �������ǿ� ����Ǿ���! INSERT ����!
--> ���������� �������Ǹ����� �˷���!! (Ư�� �÷��� � ������ �ִ��� ���� �˷����� ����)
--> ���� �ľ��ϱ� �����!
--> �������� �ο��� �������Ǹ��� ���������� ������ �ý��ۿ��� ������ �������Ǹ��� �ο��ع���

/*
    * �������� �ο��� �������Ǹ���� �����ִ� ���
   
    > �÷��������
    CREATE TABLE ���̺��(
        �÷��� �ڷ��� (CONSTRAINT �������Ǹ�)(��������)
        �÷��� �ڷ���
    );
    > ���̺������
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���
        (CONSTRAINT �������Ǹ�] ��������(�÷���)
    );
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL ,
    MEM_ID VARCHAR2 (20) CONSTRAINT MEMID_NN NOT NULL ,
    MEM_PW VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user02','pass02','�����',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01','pass01','�̰���',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03','pass03','�̽¿�','��',null,null);
--������ ������ ���� �ƴѰ� ���͵� �� INSERT�� �ȴ� 
SELECT * FROM MEM_UNIQUE;

-------------------------------------------------------------------------------
/*
    *CHECK(���ǽ�) ��������
    �ش� �÷��� ���� �� �ִ� ���� ���� ������ �����ص� �� �ִ�.
    �ش� ���ǿ� �����ϴ� ������ ���� ��� �� �ִ�.
    
*/

CREATE TABLE MEM_CHECK(--�÷��������
    MEM_NO NUMBER NOT NULL ,
    MEM_ID VARCHAR2 (20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), --�÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
   -- CHECK(GENDER IN ('��','��')) --���̺� ���� ��� 
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(1, 'user01','pass01','�����','��',null,null);
INSERT INTO MEM_CHECK VALUES(2, 'user02','pass02','�̰���','��',null,null);
--check constraint (DDL.SYS_C007126) violated
--���� ���ǿ� ����Ʊ� ������ ���� �߻� 
INSERT INTO MEM_CHECK VALUES(2, 'user02','pass02','�̰���','��',null,null);
--���� GENDER �÷��� ������ ���� �ְ��� �Ѵٸ� CHECK �������ǿ� �����ϴ� ���� �־���Ѵ�.
--NOT NULL �ƴϸ� NULL�� �����ϱ� ��
INSERT INTO MEM_CHECK 
VALUES(2, 'user03','pass03','�̽¿�','��',null,null);

--ȸ����ȣ�� �����ص� ���������� INSER �Ź�����...
-------------------------------------------------------------------------------
/*
    <PRIMARY KEY(�⺻Ű)��������)=>PK
    ���̺��� �� �ൿ�� �ĺ��ϱ� ���� ���� �÷��� �ο��ϴ� �������� (�ĺ����� ����)
    EX)ȸ����ȣ, �й�, �����ȣ , �μ��ڵ� , �����ڵ� , �ֹ���ȣ, �����ȣ,
    
    PRIMARY KEY ���������� �ο��ϸ� �� �÷��� �ڵ����� NOT NULL , UNIQUE ���������� ������.
    
    *���ǻ���- �� ���̺�� ������ �Ѱ��� ���� 
    --CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO)
*/


CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY ,
    MEM_ID VARCHAR2 (20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), --�÷��������
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI VALUES(1, 'user01','pass01','�����','��',null,null);
INSERT INTO MEM_PRI VALUES(1, 'user02','pass02','�̰���','��',null,null);
--unique constraint (DDL.MEMNO_PK) violated
--�⺻Ű�� �ߺ����� �������� �� �� (UNIQUE �������� ����)

INSERT INTO MEM_PRI VALUES(2, 'user02','pass02','�̰���','��',null,null);
 --cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
 --�⺻Ű�� NULL�� ������ �� �� NOT NULL �������ǿ� �����
 
 
 --table can have only one primary key 
--�⺻Ű �ϳ��� �ȴ� - �÷��������
 CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER ,
    MEM_ID VARCHAR2 (20),
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO,MEM_ID)--��� PRIMARY KEY �������� �ο� (����Ű)
);
INSERT INTO MEM_PRI2 
VALUES(1, 'user01','pass01','�����',NULL,null,null);

INSERT INTO MEM_PRI2
VALUES(1, 'user02','pass02','�����',NULL,null,null);

INSERT INTO MEM_PRI2 
VALUES(2, 'user02','pass02','�̽¿�',NULL,null,null);

INSERT INTO MEM_PRI2 
VALUES(NULL, 'user01','pass01','�����',NULL,null,null);
--cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
--PRIMARY KEY�� �����ִ� �� �÷����� ���� NULL�� ��������� ����
SELECT * FROM MEM_PRI2;


--����Ű ��� ���� (���ϱ�, ���ƿ� ,����)
--���ϱ� : �� ��ǰ�� ������ �ѹ��� �� �� �� ���� 
--� ȸ���� � ��ǰ�� ���ϴ����� ���� �����и� �����ϴ� ���̺� 

CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRODUCT_NAME VARCHAR2(30),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO,PRODUCT_NAME)
);
SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE VALUES(1,'����',SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'����',SYSDATE);
INSERT INTO TB_LIKE VALUES(1,'����',SYSDATE); --���� �߻� �ѹ��� �� �����ϴ�.
INSERT INTO TB_LIKE VALUES(2,'����',SYSDATE);

-------------------------------------------------------------------------------
--ȸ����޿� ���� �����͸� ���� �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GEADE_NAME VARCHAR2(30) NOT NULL
);
SELECT *
FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10,'�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20,'���ȸ��');
INSERT INTO MEM_GRADE VALUES(30,'Ư��ȸ��');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2 (20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER --ȸ���� ��޹�ȣ ���� ������ �÷�
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1,'USER01','PASS01','�����','��',NULL,NULL,NULL);
INSERT INTO MEM
VALUES(2,'USER02','PASS02','�̰���','��',NULL,NULL,10);
INSERT INTO MEM
VALUES(3,'USER03','PASS03','�̽¿�','��',NULL,NULL,40);
--��ȿ�� ȸ����� ��ȣ�� �ƴԿ��� �ұ��ϰ� �� INSERT �ȴ�

-------------------------------------------------------------------------------
/*
    <FOREIGN KEY>(�ܷ�Ű) ��������
    �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷��� �ο��ϴ� �������� 
    --> �ٸ� ���̺��� �����Ѵ�
    -->�ַ� FOREIGN KEY �������ǿ� ���� ���̺��� ���谡 �����ȴ�.
    
    >>�÷��������
     �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ������ ���̺�� [�������� ������ �÷���]
    
    >>���̺������
     [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ������ ���̺�� [�������� ������ �÷���]
     
     --������ �÷��� ������ ������ ���̺� PRIMARY KEY�� ������ �÷����� �ڵ���Ī

*/
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2 (20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) --�÷����� ���
    --FOREIGNKEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

SELECT * FROM MEM;

INSERT INTO MEM
VALUES(1,'USER01','PASS01','�����','��',NULL,NULL,NULL);
INSERT INTO MEM
VALUES(2,'USER02','PASS02','�̰���','��',NULL,NULL,10);
INSERT INTO MEM
VALUES(3,'USER03','PASS03','�̽¿�','��',NULL,NULL,40);
--integrity constraint (DDL.SYS_C007153) violated - parent key not found

INSERT INTO MEM
VALUES(4,'USER04','PASS04','����ȯ',NULL,NULL,NULL,10);
SELECT * FROM MEM;
--MEM_GRADE (�θ����̺�) MEM(�ڽ����̺�)
-- �̶� �θ����̺� (MEM_GRADE)���� ���� ������ ��� � ������ �߻��Ѵ�.
-- ������ ���� : DELETE FROM ���̺�� WHERE ����,

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--integrity constraint (DDL.SYS_C007153) violated - child record found
--�ڽ����̺� (MEM)�� 10�̶�� ���� ����ϰ� �ֱ� ������ ������ ���� �ʴ´�.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;
-->�ڽ����̺� (MEM��) 30�̶�� ���� ����ϰ� ���� �ʱ� ������ ������ �� �ȴ�

--�ڽ����̺� �̹� ����ϰ� �ִ� ���� ���� ���
--�θ����̺�κ��� ������ ������ �ȵǰ� �ϴ� �������� �ɼ��� �ɷ��ִ�.

SELECT  * FROM MEM_GRADE;

ROLLBACK;

-------------------------------------------------------------------------------
/*
    �ڽ����̺� ������ �ܷ�Ű �������� �ο��� �� ���� �ɼ� �������� 
    * �����ɼ�: �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� 
    �ڽĵ��� ���̺��� ���� ��� ó���Ұ���
    
    1.ON DELETE RESTRICTED (�⺻��)
        �������� �ɼ����� , �ڽĵ����ͷ� ���̴� �θ����ʹ� ���� �ƿ� �ȵǰԲ�
    2.ON DELETE SET NULL 
        �θ����� ������ �ش� �����͸� ���� �ִ� �ڽĵ������� ���� NULL�� ����
    3.ON DELETE CASCADE
        �θ����� ������ �ش� �����͸� ���� �ִ� �ڽĵ����͵� ���� ������Ŵ
*/

DROP TABLE MEM;


--
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2 (20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
    );
    
    SELECT * FROM MEM;
    
INSERT INTO MEM
VALUES(1,'USER01','PASS01','�����','��',NULL,NULL,NULL);

INSERT INTO MEM
VALUES(2,'USER02','PASS02','�̰���','��',NULL,NULL,10);

INSERT INTO MEM
VALUES(3,'USER03','PASS03','�̽¿�','��',NULL,NULL,20);

INSERT INTO MEM
VALUES(4,'USER04','PASS04','����ȯ',NULL,NULL,NULL,30);

COMMIT;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE =10;
--�� �����ȴ� 

SELECT * FROM MEM;

ROLLBACK;

DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY ,
    MEM_ID VARCHAR2 (20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE  CASCADE
);

INSERT INTO MEM
VALUES(1,'USER01','PASS01','�����','��',NULL,NULL,NULL);

INSERT INTO MEM
VALUES(2,'USER02','PASS02','�̰���','��',NULL,NULL,10);

INSERT INTO MEM
VALUES(3,'USER03','PASS03','�̽¿�','��',NULL,NULL,20);

INSERT INTO MEM
VALUES(4,'USER04','PASS04','����ȯ',NULL,NULL,NULL,30);

SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

/*
    <DEFAULT �⺻�� > < **�������� �ƴ�**>
    �÷��� �������� �ʰ� INSERT �� BULL�� �ƴ� �⺻���� INSERT �ϰ��� �� �� ������ �� �� �ִ°�
    
*/

DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_ACE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);
  
  SELECT * FROM MEMBER;
  
  INSERT INTO MEMBER
  VALUES(1,'�����',20,'�౸','22/1/01');
  
  INSERT INTO MEMBER
  VALUES(2,'�̰���',NULL,NULL,NULL);
  
  INSERT INTO MEMBER
  VALUES(3,'����ȯ',NULL,DEFAULT,DEFAULT);
  
  INSERT INTO MEMBER
  VALUES(4,'�����',20,'�౸','22/1/01'); -- ���� ������ ����Ʈ ������ ����
  
  --INSERT INTO ���̺��  (�÷��� ,�÷��� ) VALUES (��1,��2)
  --NOT NULL�ΰ� �� ����Ѵ�
  
  INSERT INTO MEMBER
(MEM_NO,MEM_NAME)VALUES (4,'����ȯ');
--���õ��� ���� �÷� �⺻������ NULL�� ����.
--�� �ش� Ŀ���� DEFAULT���� ���� ��� NULL�� �ƴ� DEFAULT���� ����.


------------------------------------------------------------------------------
/*
 ==============================KH ����==========================
 <SUBQUETY>�� �̿��� ���̺� ����
 ���̺� ���� �ߴ� ����

    [ǥ����]
    CERATE TABEL ���̺��
    AS �������� ;

*/
  --EMPLOYEE ���̺��� ������ ���ο� ���̺� ����
  CREATE TABLE EMPLOYEE_COPY 
  AS SELECT * FROM EMPLOYEE;
  
  DROP TABLE EMPLOYEE_CAPF2;
  
  SELECT * FROM EMPLOYEE_COPY;
-->>�÷�, ������ ��, �������� ���� ��� NOT NULL�� ����ȴ�.

CREATE TABLE EMPLOYEE_COPE2
AS SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE --���̺� ������ �����´�
WHERE 1 = 0;

SELECT * FROM EMPLOYEE_COPE2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID,EMP_NAME,SALARY,SALARY * 12  AS "����"
FROM EMPLOYEE;
--must name this expression with a column alias 
--> alias : ��Ī 
-->�������� SELECT ���� ����� �Ǵ� �Լ��� ����� ��� �ݵ�� ��Ī�� �����ؾ���
SELECT * FROM EMPLOYEE_COPY3;

DROP TABLE EMPLOYEE_COPY3;

--------------------------------------------------------------------------------
/*
    *���̺� ���� ���� �� �ڴʰ� ���������� �߰� 
    ALTER TABLE ���̺�� ������ ����,
    
    -PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY (�÷���);
    -FROEION KEY : ALETER TABLE ���̺�� ADD FOREION KEY (�÷���) REFERENCES ������ ���̺��[(������ �÷���)]; 
    -UBIQUE : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    -CHECK : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�)
    -NOT NULL :ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL; **�ణ Ư����
    
*/

--���������� �̿��ؼ� ������ ���̺� NN �������� ���� �������ȵ�
--EMPLOYEE_COPY ���̺� PRIMARY KEY �������� �߰� (EMP_ID)

ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);


--EMPLOYEE ���̺� DEPT_CODE �� �ܷ�Ű �������� �߰� (�����ϴ� ���̺�(�θ�) : DEPARTMENT(DEPT_ID))
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT; -- �����ϸ� �θ����̺��� PK �� �ڵ�������


--EMPLOYEE ���̺� JOB_CODE �� �ܷ�Ű �������� �߰� (JOB ����)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);


--EMPLOYEE ���̺� SAL_LEVEL�� �ܷ�Ű �������� �߰� (SAL_GRADE ����)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE(SAL_LEVEL);


--DEPARTMENT ���̺� LOCATION_ID �� �ַ�Ű �������� �߰� (LOCATION ����)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);

SELECT * FROM DEPARTMENT;
INSERT INTO DEPARTMENT VALUES('D10','���񽺺�','L6');