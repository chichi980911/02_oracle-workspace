---ss
/*
    DDL (DATA DEFINETION LANGUAGE) : 데이터 정의 언어
    
    객체들을 생성 (CREATE), 변경(ALTER),삭제(DROP) 하는 구문 
    
    < ALTER >
    객체를 변경하는 구문 
    
    [표현식]
    ALTER TABLE 테이블명 변경할내용;
    * 변경할 내용
    1) 컬럼 추가 / 컬럼 수정/ 컬럼 삭제
    2) 제약조건 추가/삭제 --> 수정은 불가 (수정하고자 한다면 삭제한 후 새로이 추가 )
    3) 컬럼명/제약조건 명 / 테이블명 수정 
    
*/

--1) 컬럼 추가 / 수정 / 삭제
--1_1) 컬럼추가 (ADD) : ADD 컬럼명 자료형 [DEFAULT 기본값 ]제약조건

--DEPARTMENT_COPY 에 CNAME 컬럼 추가
ALTER TABLE DEPARTMENT_COPY ADD CNAME VARCHAR2(20);
-->새로운 컬럼이 만들어지고 기본적으로 NULL로 채워진다.

--LNAME 컬럼 추가
ALTER TABLE DEPARTMENT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';

SELECT *
FROM DEPARTMENT_COPY;

--1_2) 컬럼 수정(MODIFY)
-->자료형 수정 : MODIFY 컬럼명 바꾸고자 하는 자료형 
-->DEFAULT 값 수정 : MODIFY 컬렴명 DEFALUT 바꾸고자하는 기본값
-->DEFAULT값 수정 

ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_ID VARCHAR(3);

ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_ID NUMBER;
--이건 오류가 난다 데이터가 숫자가 아닌것도 들어있다
--전재하는 데이;터가 없어야만 바꿀 수 있따.
ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_TITLE VARCHAR(10);
--오류 이미 담겨있는 데이터가 16ㅏ이트 보다 큼


-- DEPT TITLE 컬럼을 VARCHAR2(50)으로변경
ALTER TABLE DEPARTMENT_COPY MODIFY DEPT_TITLE VARCHAR(50);
-- LOCATION_ID 컬럼을 VARCHAR2(4)으로변경
ALTER TABLE DEPARTMENT_COPY MODIFY LOCATION_ID VARCHAR(4);
--LNAME 컬럼의 기본을 '미국으로' 변경
ALTER TABLE DEPARTMENT_COPY MODIFY LNAME DEFAULT '미국';

--다중 변경 가능
ALTER TABLE DEPARTMENT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '영국';
    
--1_3) 컬럼 삭제 (DROP COLUMN): DROP COLUMN 삭제하고자 하는 컬럼명

--삭제를 위한 복사본 테이블 생성

CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPARTMENT_COPY;

SELECT * FROM DEPT_COPY2;
COMMIT;
--DEPT_COPT2 로부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2 
    DROP COLUMN CNAME
    DROP COLUMN LNAME;
    --컬럼 삭제는 다중 삭제 불가능
    
ALTER TABLE DEPT_COPY2 
    DROP COLUMN CNAME;
    
ALTER TABLE DEPT_COPY2 
    DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 
    DROP COLUMN LOCATION_ID;
    --cannot drop all columns in a table
    --최소 한개의 컬럼은 존재해야한다.
-----------------------------------------------------------------------------

--2) 제약조건 추가 / 삭제 
/*
    2_1) 제약조건 추가 
    PRIMARY KEY : ADD PRIMARY KEY (컬럼명)
    FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명(컬럼명)
    UNIQUE : ADD UNIQUE(컬럼명)
    CHECK :  ADD CHECK(컬럼에 대한 조건)
    NOT NULL : MODIFY 컬럼명 NOT NULL | NULL => 이거쓰면 널 허용
    
    제약조건명을 지정하고자 한다면 [CONSTRAINT 제약조건명] 제약조건 앞에

*/
--DEPT_ID  PRIMARY KET 제약조건 추가 ADD
--DEPT_TITLE에 UNIQUE 제약조건 추가 ADD
--LNAME에 NOT NULL 제약조건 추가 MODIFY

ALTER TABLE DEPARTMENT_COPY     
    ADD CONSTRAINT DCOPY_PK PRIMARY KEY (DEPT_ID)
    ADD CONSTRAINT DCOPY_UQ UNIQUE (DEPT_TITLE)
    MODIFY LNAME CONSTRAINT DCOPY_MN NOT NULL;
    
--2_2)제약조건 삭제 : DROP CONSTRAINT 제약조건명 
--NOT NULL 삭제말고 MODIFY 컬럼명 NULL 로 간다 

ALTER TABLE DEPARTMENT_COPY DROP CONSTRAINT DCOPY_PK;

ALTER TABLE DEPARTMENT_COPY 
    DROP CONSTRAINT DCOPY_UQ
    MODIFY LNAME NULL;
    
------------------------------------------------------------------------------

-- 3) 컬럼명 / 제약조건명 / 테이블명 변경 (RENAME)

-- 3_1)컬럼명 변경 : RENAME COLUMN 기존컬렁명 TO 바꿀 컬럼명 

--DEPT_TITLE 을 DEPT_NAME으로 변경
ALTER TABLE DEPARTMENT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
   
--3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건 --SYS_C007226

ALTER TABLE DEPARTMENT_COPY RENAME CONSTRAINT SYS_C007226 TO DCOPY_LID_MN;

--3_3) 테이블명 변경 : RENAME [기존테이블명] TO 바꿀테이블명
ALTER TABLE DEPARTMENT_COPY RENAME TO DEPT_TEST; 

SELECT * FROM DEPT_TEST;

-------------------------------------------------------------------------------
/*
    < DROP>
    테이블을 삭제하는 구문 
    
*/

-- 테이블 삭제 
DROP TABLE DEPT_TEST;

--단 ,어딘가에서 참조되고 있는 부모테이블은 함부로 삭제가 되지 않는다.
--만약 삭제하고자 한다면 
--방법1.자식테이블을 먼저 삭제 한 후 부모테이블 삭제하는 방법
--방법2.부모 테이블 삭제 + 제약조건 같이 삭제
--      DROP TABLE  테이블명 CASCADE CONSTRAINT;
--      

