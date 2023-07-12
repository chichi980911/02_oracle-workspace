--SDSD
--1

SELECT COUNT(*) FROM TB_BOOK;
SELECT COUNT(*) FROM TB_BOOK_AUTHOR;
SELECT COUNT(*) FROM TB_PUBLISHER;
SELECT COUNT(*) FROM TB_WRITER;

--2


--3
SELECT BOOK_NO,BOOK_NM
FROM TB_BOOK 
WHERE LENGTH(BOOK_NM) >= 25;

--4
--�޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
--�̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO ,MOBILE_NO
FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019' AND SUBSTR(WRITER_NM,1,1) = '��' 
ORDER BY WRITER_NM;

SELECT ROWNUM, WRITER_NM, OFFICE_TELNO, HOME_TELNO ,MOBILE_NO
FROM(SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO ,MOBILE_NO
FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019' AND SUBSTR(WRITER_NM,1,1) = '��' 
ORDER BY WRITER_NM)
WHERE ROWNUM <= 1;


--5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
--���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT COUNT(DISTINCT(WRITER_NO))  AS "�۰� (��)"  FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '�ű�';


--6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(����
--���°� ��ϵ��� ���� ���� ������ ��)

SELECT * FROM TB_BOOK_AUTHOR
GROUP BY COMPOSE_TYPE;


SELECT COMPOSE_TYPE,COUNT(COMPOSE_TYPE) FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
GROUP BY COMPOSE_TYPE
HAVING COUNT(COMPOSE_TYPE) >= 300;

--7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT BOOK_NM,ISSUE_DATE,PUBLISHER_NM 
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC;

SELECT ROWNUM,BOOK_NM,ISSUE_DATE,PUBLISHER_NM
FROM(SELECT BOOK_NM,ISSUE_DATE,PUBLISHER_NM 
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM <= 1;


--8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� �Ұ�)

SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_WRITER;

SELECT COUNT(WRITE_NO) AS "�Ǽ�"
FROM TB_WRITER
GROUP BY WRITER_NO
ORDER BY �Ǽ� DESC;

SELECT WRITER_NM AS "�۰� �̸�",COUNT(WRITER_NO) AS "�Ǽ�"
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NO,WRITER_NM
ORDER BY �Ǽ� DESC
;

SELECT "�۰� �̸�" , "�Ǽ�"
FROM (SELECT WRITER_NM AS "�۰� �̸�",COUNT(WRITER_NO) AS "�Ǽ�", 
    RANK() OVER (ORDER BY COUNT(WRITER_NO) DESC) AS TOCE 
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NO,WRITER_NM
) 
WHERE TOCE <= 3;


/*9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)*/

--
--TB_WRITER���� �ߺ������� �۰��� ���� WRITER_NO �̿��ؼ� TB_BOOK_AUTHOR ���� å��ȣ ã��
--å��ȣ�� ������ TB_BOOK ����  ������ �۰��� ������  ISSUE_DATE å�߿��� ���� �ֱ� ��¥�� ���ؼ� �ٽ� �׳�¥���۰��� �������ڿ� �ڱ�

SELECT WRITER_NO,MIN(ISSUE_DATE)
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR A USING(BOOK_NO)
GROUP BY WRITER_NO;



UPDATE TB_WRITER
SET REGIST_DATE = SELECT MIN(ISSUE_DATE)
FROM (SELECT WRITER_NO,MIN(ISSUE_DATE)
FROM TB_BOOK B
JOIN TB_BOOK_AUTHOR A USING(BOOK_NO)
GROUP BY WRITER_NO)
WHERE TB_WRITER.WRITER_NO =TB_BOOK_AUTHOR.WRITER_NO;


UPDATE TB_WRITER
SET REGIST_DATE = (
    SELECT MIN(ISSUE_DATE)
    FROM TB_BOOK B
    JOIN TB_BOOK_AUTHOR A ON B.BOOK_NO = A.BOOK_NO
    WHERE A.WRITER_NO = TB_WRITER.WRITER_NO
);



SELECT * FROM TB_WRITER

SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK;
SELECT WRITER_NO FROM TB_BOOK_AUTHOR;

/*10 ���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
�� �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�.
(Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)*/

CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) REFERENCES TB_BOOK NOT NULL,
    WRITER_NO VARCHAR2(10) REFERENCES TB_WRITER NOT NULL,
    TRANS_LANG VARCHAR2(60),
    PRIMARY KEY(BOOK_NO,WRITER_NO)
);

SELECT * FROM TB_BOOK_TRANSLATOR;

SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK;

/*
���� ���� ����(compose_type)�� '�ű�', '����', '����', '����'�� �ش��ϴ� �����ʹ�
���� ���� ���� ���̺����� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL
������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
�̻� TB_BOOK_AUTHOR ���̺��� ���� ���� �ʵ��� ������ ��)

*/
