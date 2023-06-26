/*
    <�Լ�>
    ���޵� �÷����� �о�� �Լ��� ������ ����� ��ȯ�Ѵ�.
    
    -������ �Լ� : N���� ���� �о�� N���� ������� �����Ѵ�(�� �� ���� �Լ� ���� ��� ��ȯ)
    -�׷� �Լ� : N���� ���� �о�鿩��  1���� ������� ���� (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT ���� �������Լ�, �׷��Լ��� �Բ� ��� ����
    ��? ��� ���� ������ �ٸ��� ���� 
    >> �Լ����� ��� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY ��, GROUP BY��, HAVING��    
*/

/*
     <���� ó�� �Լ�>
     
     *LENGTH / LENGTHB => ����� NUMBER Ÿ��
     LENGTH(�÷� | '���ڿ� ��') : �ش� ���ڿ� ���� ���ڼ� ��ȯ
     LENGTHB(�÷� | '���ڿ� ��') : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ 
     
     '��','��','��', �ѱ��ڴ� 3BYTE
     ������, ���� , Ư�� �ѱ��ڴ� 1BYTE
 
*/
SELECT SYSDATE
FROM DUAL; -- �������̺� 

SELECT LENGTH('����Ŭ'),LENGTHB('����Ŭ')
FROM DUAL;

SELECT LENGTH('oracle'),LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME,LENGTH(EMP_NAME),LENGTHB(EMP_NAME),
EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE; --���ึ�� �� ����ǰ� �ִ� =>������ �Լ�

/*
    *INSTR
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ�Ѵ�
    
    -INSTR(�÷�),'���ڿ�''ã�����ϴ� ����',['ã����ġ�� ���۰�',[����]] => ������� NUMBERT Ÿ��
    
    ã�� ��ġ�� ���۰�
    1 : �տ������� ã�ڴ�
    -1 : �ڿ������� ã�ڴ�
*/

SELECT INSTR ('AAABAACAABBAA','B') FROM DUAL; -- ã�� ��ġ�� ���۰� : 1 �⺻�� => �տ������� ã��, ������  1 �⺻��
SELECT INSTR ('AAABAACAABBAA','B',1) FROM DUAL;
SELECT INSTR ('AAABAACAABBAA','B',-1) FROM DUAL;
SELECT INSTR ('AAABAACAABBAA','B',1,2) FROM DUAL;
SELECT INSTR ('AAABAACAABBAA','B',-1,2) FROM DUAL;

SELECT EMAIL, INSTR (EMAIL,'_',1,1) AS "_��ġ", INSTR(EMAIL,'@') AS "@ ��ġ"
FROM EMPLOYEE;

-------------------------------------------------------------

/*
    *SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ (�ڹٿ��� SUBSTRING() �޼���� ����)
    
    SUBSTR(STRING , �ڸ� ������ġ �ε���, LENGTH(��ڸ�����))) =>����� CHARACTER Ÿ��
    -STRING : ����Ÿ���÷� �Ǵ� '���ڿ� ��'
    -POSTION : ���ڿ��� ������ ���� ��ġ��
    -LENGTH : ������ ���� ���� (������ ������ �ǹ�)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) AS "����"
FROM EMPLOYEE;

--���ڻ���� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1)= '2' OR SUBSTR(EMP_NO ,8 ,1) ='4';
WHERE SUBSTR(EMP_NO,8,1)  IN ('2','4'); 

--���� ����ȯ-
SELECT EMP_NAME,EMP_NO,EMP_ID
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)  IN (2,4)
ORDER BY 1; --�⺻�����δ� ��������


--�Լ� ��ø���
SELECT EMP_NAME,EMAIL ,SUBSTR(EMAIL, 1,INSTR(EMAIL,'@')-1) AS "���̵�"
FROM EMPLOYEE;
--------------------------------------------------------------------------------

/*
    *LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD / RPAD (STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ���� ])
    
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �����ʿ� ���ٿ��� ���� N���� ��ŭ�� ���ڿ��� ��ȯ
    
*/


SELECT EMP_NAME, LPAD(EMAIL,20)
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL , 20 , '#')
FROM EMPLOYEE;

--850101-2****** ��ȸ
SELECT RPAD('850101-2', 14 , '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(�ֹι�ȣ������ �������� ������ ���ڿ�, 14 , '*')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8), 14 , '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO , 1, 8) ||'******'
FROM EMPLOYEE;

/*
    LTRIM/RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM/RTRIM (STRING,['������ ���ڵ� ']) => �����ϸ� ���� ����
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ��ȯ
*/
SELECT LTRIM('             K   R')FROM DUAL;  - ���� ã�Ƽ� �����ϰ� ����ƴ� ���ڰ� ������ ������
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL;

SELECT RTRIM('5782KH123','0123456789') FROM DUAL;

/*
    *TRIM
    ���ڿ��� �� / �� / ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    TRIM(LEAING,TRAILING,BOTH)�����ϰ��� �ϴ� ���ڵ� FROM STRING)
*/

--�⺻������ ���ʿ� �ִ� ���ڵ� �� ã�Ƽ� ���� 
SELECT TRIM('        K   H           ') FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -- LEADING: ��  <> LTRIM�� ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -- TRAILING : �� <> RTRIM�� ����
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -- BOTH ��/�� <> TRIM�� ����

/*
    *LOWER / UPPER /INITCAP

    LOWER / UPPER /INITCAP (STRING) => ������� CHARACTER Ÿ��
    
    LOWER : �� �ҹ��ڷ�  ������ ���ڿ� ��ȯ(�ڹٿ����� toLowerCase() �޼���� ����)
    UPPER : �� �빮�ڷ�  ������ ���ڿ� ��ȯ(�ڹٿ����� toUpperCase() �޼���� ����)
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
    
*/

SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('Welcome To My World') FROM DUAL;

-----------------------------------------------------------------
/*
    CONCAT
    ���ڿ� �ΰ� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING,STRING) => ����� CHAPACTER Ÿ��
*/
SELECT CONCAT('ABC','���ݸ�') FROM DUAL;
SELECT 'ABC' || '���ݸ�' FROM DUAL;

--������
-- CONCAT 2���̻� ���Ұ����ϴ� 

SELECT CONCAT('ABC','���ڸ�',123) FROM DUAL; 
SELECT 'ABC' || '���ݸ�' || 123 FROM DUAL;
-------------------------------------------------------------------------------
/*
    *REPLACE
    
    REPLACE(STRING,STR1,STR2) =>������� CHARACTER Ÿ��
    
*/
SELECT EMP_NAME, EMAIL,  REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*
  ABS
  ������ ���밪�� �����ִ� �Լ� 
  ABS(NUMBER)  => ������� NUMBER Ÿ��
*/
SELECT ABS(-10) FROM DUAL; 
SELECT ABS(-5.7) FROM DUAL;

-------------------------------------------------------------------------------
/*
    *MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ�
    
    MOD(NUMBER,NUMBER) => ����� NUMBER ����

*/
SELECT MOD (10,3) FROM DUAL;

SELECT MOD (10.9, 3) FROM DUAL;

-------------------------------------------------------------------------------
/*

    *ROUND
    �ݿø��� ����� ��ȯ
    
    ROUND(NUMBER , [��ġ]) = > ����� NUMBER
    
*/
SELECT ROUND(123.656,) FROM DUAL;  --��ġ ������ 0
SELECT ROUND(123.656, 1 ) FROM DUAL; 
SELECT ROUND(123.656, 4 ) FROM DUAL; -- �״�� ����
SELECT ROUND(123.656, -1 ) FROM DUAL;

-------------------------------------------------------------------------------
/*
    *CEIL
    �ø�ó�� ���ִ� �Լ�
    CEIL(NUMBER)
    
*/
SELECT CEIL(123.152) FROM DUAL; -- 5�̻��� �ƴϿ��� ������ �׳� �ø��� (��ġ���� �Ұ�)

-------------------------------------------------------------------------------
/*
    *FLOOR
    �Ҽ��� �Ʒ� �ڸ��� ����ó�� ���ִ� �Լ� 
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.752) FROM DUAL; --5�̸��� �ƴϿ��� ������ �׳� ������ (��ġ���� �Ұ�)
-------------------------------------------------------------------------------
/*
    *TRUNC (�����ϴ�)
    ��ġ ���� ������ ����ó�����ִ� �Լ�
    TRUNC(NUMBER,[��ġ])
    
*/
SELECT TRUNC(123.456) FROM DUAL; --��ġ�������� ������ FLOOR(����)�̶� ����
SELECT TRUNC(123.456,3) FROM DUAL;

----------------------------------��¥ó���Լ� --------------------------------

/*
    * SYSDATE : �ý��� ��¥ �� �ð� ��ȯ (���� ��¥ �� �ð�)
    
*/

SELECT SYSDATE FROM DUAL;

--* MONTHS_BETWEEN(DATE1,DATE2): �� ��¥ ������ ���� �� = > ���������� DATE1�� DATE2 �� ������ 30,31 ����ȴ�.
--=>����� NUMBER Ÿ��

SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE), CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) 
FROM EMPLOYEE;

-- *ADD_MONTHS(DATE,NUMBER) : Ư����¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� ����
-- => ����� DATE Ÿ��

SELECT ADD_MONTHS(SYSDATE,6) FROM DUAL;

--EMPLOYEE���� �����, �Ի���, �Ի��� 6������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) AS "������ ���� ��¥"
FROM EMPLOYEE;

-- *NEXT_DAY(DATE, ����) : Ư����¥ ���Ŀ� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�
-- => ������� DATE Ÿ��
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;

--����
SELECT * FROM NLS_SESSION_PARAMETERS;


ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--* LAST_DAY (DATE) : �ش� ���� ������ ���� ���ؼ� ��ȯ = > ����� DATE Ÿ��
SELECT  LAST_DAY(SYSDATE)
FROM DUAL;

--EMPLOYEE���� �����, �Ի��� ,�Ի��Ѵ��� ������ ��¥ , �Ի��� ���� �ٹ��� �ϼ�
SELECT EMP_NAME,HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*

    *EXTRACT : Ư�� ��¥�κ��� �⵵/��/�� ���� �����ؼ� ��ȯ�ϴ� �Լ� 
    EXTRACT(YEAR FROM DATE): ������ ����
    EXTRACT(MONTH FROM DATE): ���� ����
    EXTRACT(DAY FROM DATE): �ϸ� ����
    =>����� NUMBERŸ��
*/

--�����,�Ի翬��,�Ի��,�Ի��� ��ȸ
SELECT EMP_NAME,EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵"
,EXTRACT(MONTH FROM HIRE_DATE) AS  "�Ի��"
,EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵" ,"�Ի��", "�Ի���";


--------------------------------�� ��ȯ �Լ�---------------------------------
/*
    <����ȯ �Լ�>
    *TO_CHAR : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ� 
    
    TO_CHAR([����]��¥, [����]) =>����� CHARACTER Ÿ��

*/

--���� Ÿ��  >> ����Ÿ��

SELECT TO_CHAR(123456) FROM DUAL;

SELECT TO_CHAR(1234, '99999') FROM DUAL; --5ĭ ¥�� ���� Ȯ��, ������ ���� , ��ĭ ����

SELECT TO_CHAR(1234, '00000') FROM DUAL;

SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- ���� ������ ����(LOCAL) ȭ�� ������ ���

SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999') FROM EMPLOYEE;

--��¥Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- Ŭ���غ��� �ٸ�
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; --HH : 12�ð� ����
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- HH24 : 24�ð� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME,TO_CHAR(HIRE_DATE,'YYYY-MM-DD DY')
FROM EMPLOYEE;

--EX) 1990�� 02 �� 06 ���� ���� 
SELECT TO_CHAR(HIRE_DATE,'YYYY"��" MM"��" DD"��"') --���� ���� ���� �� ������ "" ����� ����
FROM EMPLOYEE;

--�⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE,'YYYY'),
       TO_CHAR(SYSDATE,'YY'),
       TO_CHAR(SYSDATE,'RRRR'),
       TO_CHAR(SYSDATE,'RR'),
       TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

--���� ���õ� ����

SELECT TO_CHAR(SYSDATE,'MM'),
       TO_CHAR(SYSDATE,'MON'),
       TO_CHAR(SYSDATE,'MONTH'),
       TO_CHAR(SYSDATE,'RM')
FROM DUAL;

--�ϰ� ���õ� ���� 
SELECT TO_CHAR(SYSDATE,'DDD'), --���� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE,'DD'),   --�� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE,'D')     --�� �������� ������ ��ĥ°����
FROM DUAL;

--���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE,'DAY'),
       TO_CHAR(SYSDATE,'DY')
FROM DUAL;

-------------------------------------------------------------------------------
/*
    *TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ�� �����͸� ��¥ Ÿ������ ��ȯ �����ִ� �Լ�
    
    TO_DATE(����|����, [����])

*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL; -- ����
SELECT TO_DATE('070101') FROM DUAL; --ù���ڰ� 0�� ��� ����Ÿ������ �����ϰ� �ؾ��Ѵ�

SELECT TO_DATE('041030 143000','YYMMDD HH24MISS') FROM DUAL; -- ���� 
SELECT TO_DATE('140630','YYMMDD') FROM DUAL; --2014��
SELECT TO_DATE('980630','YYMMDD') FROM DUAL; --2098�� => ������ ���� ����� �ݿ��Ѵ�.

SELECT TO_DATE('140630','RRMMDD') FROM DUAL;
SELECT TO_DATE('980630','RRMMDD') FROM DUAL;
-- RR : �ش� ���ڸ� �⵵ ���� 50 �̸��� ��� ���� ���� �ݿ� , 50�̻��� ��� �������� �ݿ�
