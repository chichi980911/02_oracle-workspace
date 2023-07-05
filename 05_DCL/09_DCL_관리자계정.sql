--���󵵽�
/*
    <DCL> :DATA CONTROL LANGUAGE
    ������ ���� ���
    
    �������� �ý��� ���� �� ��ü ���� ���� �ο�(GRANT) �� ȸ��(REVOKE)�ϴ� ����
    > �ý��� ���� : DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ���� 
    > ��ü���� ���� : Ư�� ��ü���� ������ �� �ִ� ����
*/

/*
    *�ý��۱��� ����
    -CREATE SESSION : ������ �� �ִ� ����
    -CERATE TABLE : ���̺��� ������ �� �ִ� ����
    -CREATE VIEW : �並 ������ �� �ִ� ���� 
    -CREATE SEQUENCE : �������� ������ �� �ִ� ���� 
    .....: �Ϻδ� CONNECT �ȿ� ���ԵǾ� �ִ�.
*/

-- 1. SAMPLE / SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
--����: ���� -�׽�Ʈ ����: ORA-01045: user SAMPLE lacks CREATE SESSION privilege; logon denied

--2. ������ ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;

--3-1. ���̺� ���� �� �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

--3-2. TABLESPACE �Ҵ� (SAMPLE ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

-------------------------------------------------------------------------------
/*
    *��ü ���� ����
    Ư�� ��ü�� �����ؼ� ������ �� �ִ� ����
    
    ��������    Ư����ü 
    SELECT  TABLE / VIEW / SEQUENCE
    INSERT  TABLE / VIEW  
    UPDATE  TABLE / VIEW 
    DELETE  TABLE / VIEW 
    ...
    
    [ǥ����]
    GRANT �������� ON Ư����ü TO ����
*/

GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
-----------------------------------------------------------------
GRANT CONNECT, RESOURCE TO  ������;

/*
    <�� ROLE > 
    -Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ�����
    
    CONNECT : ������ �� �ִ±��� CREATE SESSION
    RESOURCE : Ư�� ��ü���� ������ �� �ִ� ���� CREATE TABLE , CREATE SEQUENCE...
*/

SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT','RESOURCE')
ORDER BY 1;