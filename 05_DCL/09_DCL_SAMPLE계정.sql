CREATE TABLE TEST (
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);

--CREATE SESSION : 접속할 수 있는 권한만 부여있다.
--해결방법
--3-1.CREATE TABLE 권한 받기
--3-2.TABLESPACE 할당 받기

SELECT * FROM TEST;

INSERT INTO TEST VALUES(10, '안녕');

--CREATE TABLE 권한을 받으면 테이블을 바로 조작 가능하다

------------------------------------------------------------


--KH계정에 있는 EMPLOYEE 테이블에 접근
--조회권한이 없다.
--4.SELECT ON KH.EMPLOYEE 권한 부여받음
SELECT * FROM KH.EMPLOYEE;
--5.INSERT ON KH.DEPARTMENT 권한을 부여 받음
INSERT INTO KH.DEPARTMENT VALUES('DD','회계부','L1');
COMMIT;

--6.
SELECT * FROM KH.DEPARTMENT;

DELETE FROM DEPARTMENT
WHERE DEPT_ID ='DD';