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
--휴대폰 번호가 ‘019’로 시작하는 김씨 성을 가진 작가를 이름순으로 정렬했을 때 가장 먼저 표시되는 작가
--이름과 사무실 전화번호, 집 전화번호, 휴대폰 전화번호를 표시하는 SQL 구문을 작성하시오.

SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO ,MOBILE_NO
FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019' AND SUBSTR(WRITER_NM,1,1) = '김' 
ORDER BY WRITER_NM;

SELECT ROWNUM, WRITER_NM, OFFICE_TELNO, HOME_TELNO ,MOBILE_NO
FROM(SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO ,MOBILE_NO
FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019' AND SUBSTR(WRITER_NM,1,1) = '김' 
ORDER BY WRITER_NM)
WHERE ROWNUM <= 1;


--5. 저작 형태가 “옮김”에 해당하는 작가들이 총 몇 명인지 계산하는 SQL 구문을 작성하시오. (결과 헤더는
--“작가(명)”으로 표시되도록 할 것)
SELECT COUNT(DISTINCT(WRITER_NO))  AS "작가 (명)"  FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '옮김';


--6. 300권 이상 등록된 도서의 저작 형태 및 등록된 도서 수량을 표시하는 SQL 구문을 작성하시오.(저작
--형태가 등록되지 않은 경우는 제외할 것)

SELECT * FROM TB_BOOK_AUTHOR
GROUP BY COMPOSE_TYPE;


SELECT COMPOSE_TYPE,COUNT(COMPOSE_TYPE) FROM TB_BOOK
JOIN TB_BOOK_AUTHOR USING (BOOK_NO)
GROUP BY COMPOSE_TYPE
HAVING COUNT(COMPOSE_TYPE) >= 300;

--7. 가장 최근에 발간된 최신작 이름과 발행일자, 출판사 이름을 표시하는 SQL 구문을 작성하시오.
SELECT BOOK_NM,ISSUE_DATE,PUBLISHER_NM 
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC;

SELECT ROWNUM,BOOK_NM,ISSUE_DATE,PUBLISHER_NM
FROM(SELECT BOOK_NM,ISSUE_DATE,PUBLISHER_NM 
FROM TB_BOOK
ORDER BY ISSUE_DATE DESC)
WHERE ROWNUM <= 1;


--8. 가장 많은 책을 쓴 작가 3명의 이름과 수량을 표시하되, 많이 쓴 순서대로 표시하는 SQL 구문을 작성하시오.
--단, 동명이인(同名異人) 작가는 없다고 가정한다. (결과 헤더는 “작가 이름”, “권 수”로 표시되도록 할것)

SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_WRITER;

SELECT COUNT(WRITE_NO) AS "권수"
FROM TB_WRITER
GROUP BY WRITER_NO
ORDER BY 권수 DESC;

SELECT WRITER_NM AS "작가 이름",COUNT(WRITER_NO) AS "권수"
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NO,WRITER_NM
ORDER BY 권수 DESC
;

SELECT "작가 이름" , "권수"
FROM (SELECT WRITER_NM AS "작가 이름",COUNT(WRITER_NO) AS "권수", 
    RANK() OVER (ORDER BY COUNT(WRITER_NO) DESC) AS TOCE 
FROM TB_BOOK_AUTHOR
JOIN TB_WRITER USING (WRITER_NO)
GROUP BY WRITER_NO,WRITER_NM
) 
WHERE TOCE <= 3;


/*9. 작가 정보 테이블의 모든 등록일자 항목이 누락되어 있는 걸 발견하였다. 누락된 등록일자 값을 각 작가의
‘최초 출판도서의 발행일과 동일한 날짜’로 변경시키는 SQL 구문을 작성하시오. (COMMIT 처리할 것)*/

--
--TB_WRITER에서 중복값없이 작가명 추출 WRITER_NO 이용해서 TB_BOOK_AUTHOR 에서 책번호 찾기
--책번호를 가지고 TB_BOOK 에서  동일한 작가가 발행한  ISSUE_DATE 책중에서 가장 최근 날짜를 구해서 다시 그날짜를작가의 발행일자에 박기

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

/*10 현재 도서저자 정보 테이블은 저서와 번역서를 구분 없이 관리하고 있다. 앞으로는 번역서는 따로 관리하려
고 한다. 제시된 내용에 맞게 “TB_BOOK_ TRANSLATOR” 테이블을 생성하는 SQL 구문을 작성하시오.
(Primary Key 제약 조건 이름은 “PK_BOOK_TRANSLATOR”로 하고, Reference 제약 조건 이름은
“FK_BOOK_TRANSLATOR_01”, “FK_BOOK_TRANSLATOR_02”로 할 것)*/

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
도서 저작 형태(compose_type)가 '옮김', '역주', '편역', '공역'에 해당하는 데이터는
도서 저자 정보 테이블에서 도서 역자 정보 테이블(TB_BOOK_ TRANSLATOR)로 옮기는 SQL
구문을 작성하시오. 단, “TRANS_LANG” 컬럼은 NULL 상태로 두도록 한다. (이동된 데이터는 더
이상 TB_BOOK_AUTHOR 테이블에 남아 있지 않도록 삭제할 것)

*/

