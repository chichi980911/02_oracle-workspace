/*
    <트리거 TRIGGER>
    
    내가 지정한 테이블에 DML문에 의해 변경사항이 생길 때 
    (테이블 이벤트가 발생했을 떄 )
    자동으로 매번 실행할 내용을 미리 정의해둘 수 있는 객체 
    
    EX)
    회원탈퇴시 시존의 회원테이블에 데이터를 DELETE 후 곧바로 탈퇴한 회원들만 따로 보관하는 테이블에 자동으로 INSERT 처리
    신고횟수가 일정 수를 넘었을 떄 묵시적으로 해당 회원을 블랙리스트로 처리되게끔
    입출고에 대한 데이터가 기록 INSERT 될 떄 마다 해당 상품에 대한 재고수량 매번 수정(UPDATE)해야 될 때
    
    **트리거 종류 
    -SQL문의 실행시기
     -BEFORE TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
     -AFTER TRIGGER : 내가 지정한 테이블에 이벤트가 발생한 후에 트리거 실행
     
     
    -SQL문에 의해 영향을 받는 각 행에 따른 분류 
     -STATEMENT TRIGGER (문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
     -ROW TRIGGER(행 트리거) : 해당 SQL문 실행할 때 마다 매번 트리거 실행
                             (FOR EACH ROW 옵션 기술해야한다)
                            > :OLD = BEFORE UPDATE(수정전 자료), BEFORE DELETE(삭제전자료)
                            > :NEW = AFTER INSERT(추가된 자료), AFTER UPDATE(수정후 자료)
     [표현식]
     CREATE [OR REPLACE ] TRIGGER 트리거명
     BEFORE|AFTER  INSERT|UDATE|DELETE ON 테이블명
     [FOR EACH ROW]
     자동으로 실행할 내용;
        L [DELCLAER 
            변수선언]
          BEGIN
            실행내용(해당 위에 지정된 이벤트 발생시 묵시적으로 (자동으로) 실행할 구문)
          [EXCEPTION]
            예외처리 구문;]
          END;
          /
*/
--EMPLOYEE 테이블에 새로운 행이 INSERT가 될 떄마다 자동으로 메세지 출력되는 트리거 정의

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다');
END;
/

INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,EMP_NO,DEPT_CODE, JOB_CODE,SAL_LEVEL,HIRE_DATE)
VALUES (502,'이사라','990101-2222222','D7','J7','S2',SYSDATE);

SELECT * FROM EMPLOYEE;

---------------------------------------------------------------------
--상품 입고 및 출고 관련 예시
-->>테이블 및 시퀀스 생성

--1.상품에 대한 데이터 보관할 테이블 (TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,       --상품번호
    PNAME VARCHAR2(30) NOT NULL,    --상품이름
    BRAND VARCHAR2(30) NOT NULL,    --브랜드
    PRICE NUMBER,                   --가격
    STOCK NUMBER DEFAULT 0          --재고수량
);
SELECT * FROM TB_PRODUCT;

--상품번호 중복안되게끔 매번 새로운 번호 발생시키는 시퀀스 (SEQ_PCODE)

CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

--샘플데이터 추가

INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL , '갤럭시 S 23' , '삼성' , 1400000  , DEFAULT);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL , '아이폰 14' , '애플' , 1300000  , 10);
INSERT INTO TB_PRODUCT VALUES (SEQ_PCODE.NEXTVAL , '대륙폰' , '샤오미' , 600000  , 200);

COMMIT;

--2.상품 입출고 상세 이력 테이블(TB_PRODETAIL)
--어떤 상품이 어떤 날짜에 몇개가 입고 또는 출고 되었는지에 대한 데이터를 기록하는 테이블

CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,           --이력번호
    PCDOE NUMBER REFERENCES TB_PRODUCT, --상품번호
    PDATE DATE NOT NULL,                --상품 입출고일
    AMOUNT NUMBER NOT NULL,              --입출고 수량
    STATUS CHAR(6) CHECK(STATUS IN ('입고', '출고')) --상태(입/출고)
);
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;



--이력번호로 매번 새로운 번호를 발생시켜서 들어갈 수 있게 도와주는 시퀀스
CREATE SEQUENCE SEQ_DECODE
NOCACHE;

INSERT INTO TB_PRODETAIL VALUES(SEQ_DECODE.NEXTVAL,200,SYSDATE,10,'입고');
--200번 상품의 재고수량 10증가
UPDATE TB_PRODUCT
SET STOCK = STOCK +10
WHERE PCODE = 200;

----210번 상품이 오늘 날짜로 5개 출고
INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DECODE.NEXTVAL,210,SYSDATE,5,'출고'); 
--210번 상품의 재고수량 5감소
UPDATE TB_PRODUCT 
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;

INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DECODE.NEXTVAL,205,SYSDATE,20,'입고'); 

UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 200; --잘못 오기입

ROLLBACK;

INSERT INTO TB_PRODETAIL 
VALUES(SEQ_DECODE.NEXTVAL,205,SYSDATE,20,'입고'); 

UPDATE TB_PRODUCT 
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

--TB_PRODETAIL 테이블에 INSERT이벤트 발생시
--TB_PRODUCT 테이블에 매번 자동으로 재고수량(STOCK) 이 업데이트되게끔 트리거정의

/*
    --상품이 입고된 경우 --> 해당 상품 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK - STOCK + 현재입고된수량(INSERT된 자료의 AMOUNT값)
    WHERE PCODE = 입고된 상품번호 (INSERT된 자료의 PCODE값);
    
    --상품이 출고된 경우 --> 해당 상품 찾아서 재고수량 감소 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK - STOCK - 현재입고된수량(INSERT된 자료의 AMOUNT값)
    WHERE PCODE = 입고된 상품번호 (INSERT된 자료의 PCODE값);
*/

-- :NEW 

CREATE OR REPLACE TRIGGER TRG_O2
AFTER INSERT ON TB_PRODETAIL 
FOR EACH ROW
BEGIN
    --상품이 입고된 경우 > 재고수량증가
    IF(:NEW.STATUS = '입고') 
        THEN 
        UPDATE TB_PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCDOE;
        END IF;
    --상품이 출고된 경우 > 재고수량감소
    IF(:NEW.STATUS = '출고')
        THEN
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCDOE;
        END IF;
END;
/

--210번 상품이 오늘날짜로 7개 출고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL,210,SYSDATE,7,'출고');

INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL,210,SYSDATE,7,'입고');

SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;



