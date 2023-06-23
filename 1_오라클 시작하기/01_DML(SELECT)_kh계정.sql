/*
<SELECT> -데이터를 조회할 떄 사용되는 구문
 >>RESULT SET : SELECT문을 통해 조회된 결과물(즉, 조회된 행동의 집합을 의미)
 
 [표현법]
 SELECT 조회하고자 하는 컬럼1, 컬럼2, ... 
 FROM 테이블명,
 **반드시 존재하는 컬럼으로 입력 해야한다 아닐시 오류 발생

*/

--EMPLOYEE 모든테이블 조회

SELECT *
FROM EMPLOYEE;

--EMPLOYEE 테이블의 사번 , 이름 ,급여조회

SELECT EMP_ID,EMP_NAME,SALARY
FROM EMPLOYEE;

--JOB테이블의 모든 컬럼 조회

SELECT *
FROM JOB;

--실습문제--
--JOB테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

--DEPARTMENT 테이블의 모든 컬럼조회
SELECT *
FROM DEPARTMENT;

--DEPARTMENT 테이블의 부서코드,부서명만 조회
SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT;

--EMPLOYEE 테이블의 사원명,이메일,전화번호,입사일,급여조회
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE,SALARY
FROM EMPLOYEE;

/*
<컬럼값을 통한 산술연산>
SELECT절 컬럼명 작성부분에 산술연산 기술 가능 (이때 산술연산이 된 결과 조회)
*/

--EMPOLYEE 테이블의 사원명, 사원의연봉 (급여 *12) 조회
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

--EMPOLYEE 테이블의 사원명, 급여 , 보너스 조회
SELECT EMP_NAME,SALARY,BONUS
FROM EMPLOYEE;

--EMPLOYEE 테이블의 사원명, 급여 , 보너스, 연봉 , 보너스 포함된 연봉 ((급여+보너스*급여)*12)
SELECT EMP_NAME,SALARY,BONUS, SALARY*12 , ((SALARY+BONUS*SALARY)*12)
FROM EMPLOYEE;
--산술연산 과정 중 컬럼내 값이 NULL 이 존재할 경우 산술연산한 결과값 마저도 무조건 NULL로 나온다.

--EMPLOYEE 테이블의 사원명, 입사일
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE;

--EMPLOYEE에 사원명 , 입사일 ,근무일수(오늘날짜 - 입사일) 
--DATE 타입 끼리도 연산 가능하다
--**오늘 날짜 : SYSDATE 
--DATE -DATE : 결과값은 일 단위가 맞지만 시,분,초 까지 가지고 있어서 결과값이 다르다.
SELECT EMP_NAME,HIRE_DATE,(SYSDATE - HIRE_DATE) 
FROM EMPLOYEE




