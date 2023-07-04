/*
    < TCL : TRANSACTION CONTROL LANGUAGE>
    트랜젝션 제어 언어
    
    ** 트랜젝션 (TRANSACTION) 
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항 (DML 추가 , 수정, 삭제)등을 하나의 트랜젝션에 묶어서 처리
    - DML문 한개를 수행할 때 트랜젝션이 존재하면 해당 트랜젝션에 같이 묶어서 처리
                         트랜젝션이 존재하지 않으면 트랜젝션 만들어서 묶음
    COMMIT 하기 전까지 변경사항들을 하나의 트랜젝션에 담게된다
    커밋을 해야만이 실제 디비에 반영이 된다고 생각하면 된다
    
    -트랜젝션의 대상이 되는 SQL :  INSERT , UPDATE , DELETE (DML)
    -COMMIT : 트랜젝션 종료 처리 후 확정 
    -ROLLBACK : 트랜젝션 취소
    -SAVEPOINT : 임시저장
    
    -COMMIT 진행 : 한트랜젝션에 담겨있는 변경사항들을 실제 DB에 반영 시키겠다는 의미(후에 트랜젝션은 사라진다)
    -ROLLBACK 진행 : 한 트랜젝션에 담겨 있는 변경사항들이 삭제(취소) 한 후 마지막 커밋 시점으로 돌아감
    -SAVEPOINT 포인트명; 진행: 현재 이 시점에서 해당 포인트 명으로 임시저장점을 정의해두는 것
                        ROLLBACK 진행시 전체 변경사항들을 다 삭제하는게 아니라 일부만 롤백 가능 
*/

SELECT * FROM EMP_01;

--사번이 900번인 사원 지우기 
DELETE FROM EMP_01
WHERE EMP_ID = 900;
--삭제된 것 처럼 보인다.
DELETE FROM EMP_01
WHERE EMP_ID = 901;

ROLLBACK;
--변경사항이 취소되고 , 트랜젝션도 없어진다. 데이터 다시 되살아 난다.


DELETE FROM EMP_01
WHERE EMP_ID = 200;

--800번 황민현,총무부 사원 추가
INSERT INTO EMP_01 VALUES(800,'황민현','총무부');
COMMIT;

--실제 DB에 반영된 상태
SELECT * FROM EMP_01;
ROLLBACK; -- 커밋을 한 상태이기 떄문에 돌아갈 수 없다.

-------------------------------------------------------------------------------
--217,216,214 사원 지우기
DELETE FROM EMP_01 
WHERE EMP_ID IN (217,216,214);

--임시 저장점 잡기 

SAVEPOINT SP;

--------------------------------------------------------------------------------
--900,901 사원 지우기

DELETE FROM EMP_01
WHERE EMP_ID IN (900,901);

DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT *FROM EMP_01;


--DDL문
CREATE TABLE TEST(
    TEST_ID NUMBER
);

ROLLBACK;

SAVEPOINT SP;


--801,안효섭 ,인사관리부 사원 추가
INSERT INTO EMP_01 VALUES(801,'안효섭','인사관리부');
--218삭제
DELETE FROM EMP_01 
WHERE EMP_ID = '218';

SELECT * FROM EMP_01;

--801 안효섭 추가 와 218삭제만 취소하고 싶다.
ROLLBACK TO SP;
COMMIT;

/*
DDL문(CRATE,ALTER,DROP)을 수행하는 순간 기존에 트랜젝션에 있던 변경사항들을 
무조건 COMMIT(실제 DB 반영)
즉 DDL 문 수행 전 변경사항이 있었다면 정확히 픽스(COMMIT 또는 ROLLBACK) 하고 수행해야한다.
*/

