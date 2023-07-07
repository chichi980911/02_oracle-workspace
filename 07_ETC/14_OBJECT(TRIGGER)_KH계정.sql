/*
    <Ʈ���� TRIGGER>
    
    ���� ������ ���̺� DML���� ���� ��������� ���� �� 
    (���̺� �̺�Ʈ�� �߻����� �� )
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü 
    
    EX)
    ȸ��Ż��� ������ ȸ�����̺� �����͸� DELETE �� ��ٷ� Ż���� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó��
    �Ű�Ƚ���� ���� ���� �Ѿ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ��� INSERT �� �� ���� �ش� ��ǰ�� ���� ������ �Ź� ����(UPDATE)�ؾ� �� ��
    
    **Ʈ���� ���� 
    -SQL���� ����ñ�
     -BEFORE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
     -AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
     
     
    -SQL���� ���� ������ �޴� �� �࿡ ���� �з� 
     -STATEMENT TRIGGER (����Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
     -ROW TRIGGER(�� Ʈ����) : �ش� SQL�� ������ �� ���� �Ź� Ʈ���� ����
                             (FOR EACH ROW �ɼ� ����ؾ��Ѵ�)
                            > :OLD = BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(�������ڷ�)
                            > :NEW = AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(������ �ڷ�)
     [ǥ����]
     CREATE [OR REPLACE ] TRIGGER Ʈ���Ÿ�
     BEFORE|AFTER  INSERT|UDATE|DELETE ON ���̺��
     [FOR EACH ROW]
     �ڵ����� ������ ����;
        L [DELCLAER 
            ��������]
          BEGIN
            ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ���������� (�ڵ�����) ������ ����)
          [EXCEPTION]
            ����ó�� ����;]
          END;
          /
*/
--EMPLOYEE ���̺� ���ο� ���� INSERT�� �� ������ �ڵ����� �޼��� ��µǴ� Ʈ���� ����

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�');
END;
/

INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE, JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES (502,'�̻��','990101-2222222','D7','J7','S2',SYSDATE);

SELECT * FROM EMPLOYEE;

---------------------------------------------------------------------
--��ǰ �԰� �� ��� ���� ����
-->>���̺� �� ������ ����

--1.��ǰ�� ���� ������ ������ ���̺� (TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,       --��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,    --��ǰ�̸�
    BRAND VARCHAR2(30) NOT NULL,    --�귣��
    PRICE NUMBER,                   --����
    STOCK NUMBER DEFAULT 0          --������
);
SELECT * FROM TB_PRODUCT;

--��ǰ��ȣ �ߺ��ȵǰԲ� �Ź� ���ο� ��ȣ �߻���Ű�� ������ (SEQ_PCODE)

CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

--���õ����� �߰�

INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL , '������ S 23' , '�Ｚ' , 1400000  , DEFAULT);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL , '������ 14' , '����' , 1300000  , 10);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL , '�����' , '������' , 600000  , 200);

COMMIT;

--2.��ǰ ����� �� �̷� ���̺�(TB_PRODETAIL)
--� ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǿ������� ���� �����͸� ����ϴ� ���̺�

CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,           --�̷¹�ȣ
    PCDOE NUMBER REFERENCES TB_PRODUCT, --��ǰ��ȣ
    PDATE DATE NOT NULL,                --��ǰ �������
    AMOUNT NUMBER NOT NULL,              --����� ����
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���')) --����(��/���)
);
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;



--�̷¹�ȣ�� �Ź� ���ο� ��ȣ�� �߻����Ѽ� �� �� �ְ� �����ִ� ������
CREATE SEQUENCE SEQ_DECODE
NOCACHE;

INSERT INTO TB_PRODETAIL VALUES(SEQ_DECODE.NEXTVAL,200,SYSDATE,10,'�԰�');
--200�� ��ǰ�� ������ 10����
UPDATE TB_PRODUCT
SET STOCK = STOCK +10
WHERE PCODE = 200;

----210�� ��ǰ�� ���� ��¥�� 5�� ���
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DECODE.NEXTVAL,210,SYSDATE,5,'���'); 
--210�� ��ǰ�� ������ 5����
UPDATE TB_PRODUCT 
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;

INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DECODE.NEXTVAL,205,SYSDATE,20,'�԰�'); 

UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 200; --�߸� ������

ROLLBACK;

INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DECODE.NEXTVAL,205,SYSDATE,20,'�԰�'); 

UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

--TB_PRODETAIL ���̺� INSERT�̺�Ʈ �߻���
--TB_PRODUCT ���̺� �Ź� �ڵ����� ������(STOCK) �� ������Ʈ�ǰԲ� Ʈ��������

/*
    --��ǰ�� �԰�� ��� --> �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK - STOCK + �����԰�ȼ���(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �԰�� ��ǰ��ȣ (INSERT�� �ڷ��� PCODE��);
    
    --��ǰ�� ���� ��� --> �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK - STOCK - �����԰�ȼ���(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �԰�� ��ǰ��ȣ (INSERT�� �ڷ��� PCODE��);
*/

-- :NEW 

CREATE OR REPLACE TRIGGER TRG_O2
AFTER INSERT ON TB_PRODETAIL 
FOR EACH ROW
BEGIN
    --��ǰ�� �԰�� ��� > ����������
    IF(:NEW.STATUS = '�԰�') 
        THEN 
        UPDATE TB_PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCDOE;
        END IF;
    --��ǰ�� ���� ��� > ����������
    IF(:NEW.STATUS = '���')
        THEN
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCDOE;
        END IF;
END;
/

--210�� ��ǰ�� ���ó�¥�� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL,210,SYSDATE,7,'���');

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL,210,SYSDATE,7,'�԰�');

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;



