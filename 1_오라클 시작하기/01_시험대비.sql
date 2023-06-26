--저장하기
----------------------QUIZ ---------------------
--보너스를 받지 않지만 부서배치는 된 사원 조회 
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
--NULL 값에 대해 정상적으로 비교 처리 되지 않음;

--문제점 : NULL값을 비교할떄는 단순한 일반 비교연산자를 통해 비교할 수 없다.
--해결방법 IS NULL /IS NOT NULL 연산자를 이용해서 비교해야됨

--조치한 SQL문 
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;


---------------------------QUIZ2-----------------

--검색하고자 하는 내용
--JOB_CODE J7 이거나 J6 이면서 SALARY 값이 200만원 이상이고
--BONUS가 있고 여자이며 이메일주소는 _앞에 3글자만 있는 사원의 
--EMP_NAME, EMP_NO, JOB_CODE,SARALY, BONUS를 조화하려고 한다.
--정상적으로 조회가 잘된다면 실행결과는 2행이어야 한다.


--위의 내용을 실행시키고자 작성한 SQL문은 아래와 같다.
SELECT EMP_NAME,JOB_CODE, DEPT_CODE,SALARY,BONUS
FROM EMPLOYEE
WHERE JOB_CODE ='J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE'____' ESCAPE '$'AND BONUS IS NULL ;

--___$_%' ESCAPE '%'
--위의 SQL 실행시 원하는 결과가 제대로 조회되지 않는다 (5개의 문제점)
--모두 찾아서 서술하고 완벽한 SQL문 작성하기
/*

1)문제 SALARY 값이 200만원 이상인데 > 사용   1)조치 >=
2)문제 OR 과 AND 비교시 우선순위가 AND 가 높기 떄문에 2번째 컬럼과 3번째 컬럼을 먼저 연산하게 된다.
  조치- OR 컬럼들을 묶어준다. ()
3)문제 EMAIL -앞에 3글자만 있는 사원을 조회 해야하는데 _4개로 인식하여  구분이 필요함
 조치 ESCAPE사용하여 구분 필요
4)문제 BONUS IS NULL 은 NULL값 조회
조치 IS NOT NULL 사용
5)여자만 조회해야하니까 새로운 SQL 작성
SUBSTR(EMP_NO,8,1)
SUBSTR(컬럼명 ,자르기를 시작할 인덱스번호,자를 갯수 )
*/

SELECT EMP_NAME,EMP_NO,JOB_CODE, DEPT_CODE,SALARY,BONUS
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND EMAIL LIKE'___$_%' ESCAPE '$' AND BONUS IS NOT NULL AND
SUBSTR(EMP_NO,8,1) IN ('2','4'); 

------------------------QUIZ3-------------------------
--(계정생성 구문) CREATE USER 계정명 INDENTIFIED BY 비밀번호
--계정명 :SCOTT,비밀번호:TIGER 계정을 생성하고 싶다
--이때 일반사용자 계정인 KH 계정에 접속해서 CREATE USER SCOTT;로 실행하니 문제 발생

-- 문제1. 사용자 계정 생성은 무조건 관리자계정에서만 가능하다
-- 문제2. SQL문이 잘못 되었다 비밀번호 까지 입력 해야한다.

--조치내용.1 관리자계쩡 접속 
--조치내용.2 CREATE USER SCOTT IDENTIFIED BY TIGER;

--위의 SQL(CREATE)문만 실행 후 접속을 만들어 접속을 하려고 했더니 실패
--뿐만 아니라 해당 계정에 테이블 생성 같은 것도 되지 않는다 

--문제1. 사용자 계정 생성 후 최소한의 권한 부여 
--조치내용 GRANT CONNECT, RESOURCE TO SCOTT;




