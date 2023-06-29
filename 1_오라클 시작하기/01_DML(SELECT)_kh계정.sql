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

select *
from employee;
--EMPLOYEE 테이블의 사번 , 이름 ,급여조회

SELECT EMP_NO,EMP_NAME,SALARY
FROM EMPLOYEE;

--JOB테이블의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE;
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
FROM EMPLOYEE;

---------------------------------------------------------------------------
/*
<컬럼명에 별칭 지정하기>
산술연산을 하게 되면 컬럼명이 지저분하기 떄문에 컬럼명 별칭 부여 가능

[표현법]
컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 칼람명 AS "병칠"
AS 사용 여부 관곙벗이 별칭에 듸어쓰기 혹은 특수문자가 포함될 경우 반드시 ""로 묶어야한다.

*/
SELECT EMP_NAME 사원명,SALARY,SALARY*12 AS 급여 , (SALARY+SALARY*BONUS)*12 AS "보너스가 포함된 연봉" 
FROM EMPLOYEE;

--------------------------------------------------------------------------
/*  <리터럴>
    임의로 지정한 문자열 ('')
    SELECT 절에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 길이 출력
*/

--EMPOLYEE 테이블의 사번, 사원명, 급여 조회
SELECT EMP_NO,EMP_NAME,SALARY, '원' AS "단위" 
FROM EMPLOYEE;

/*
<연결 연산자 : || >
여러 컬럼 값들을 마치 하나의 컬럼인 것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
*/

--사번 , 이름 , 급여를 하나의 컬럼으로 조회 
SELECT EMP_NO || EMP_NAME || SALARY ""
FROM EMPLOYEE;

--컬럼값과 리터럴값 연결

---이름 의 월급은 XXX원 입니다 <<별칭은 급여정보

SELECT EMP_NAME || '의 월급은 ' ||  SALARY || '원 입니다 ' AS "급여정보"
FROM EMPLOYEE;

------------------------------------------
/*
    <DISTINCT> 
컬럼에 중복된 값들을 한번 씩만 표현하고자 할 때 사용한다.

*/
--현재 우리회사에 어떤 직급의 사람들이 존재하는지 

SELECT JOB_CODE  
FROM EMPLOYEE; --현재는 23명의 직급이 전부다 조회가 됨.

--EMPLOYEE 에 직급코드 중복제거 

SELECT DISTINCT JOB_CODE 
FROM EMPLOYEE; ---중복 제거 돼서 7행만 조회

--사원들이 어떤 부서에 속해있는지 
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; --NULL 아직 부서배치 안된사람

--유의사항 : DISTINCT 는 SELECT 절에 딱 한번만 기술 가능 
/*구문오류 
SELECT DISTINCT JOB_CODE , DISTINCT DEPT_CODE 
FROM EMPLOYEEL;
*/

--해결방법

SELECT DISTINCT JOB_CODE , DEPT_CODE
FROM EMPLOYEE;
--JOB CODE,DEPT_CODE 쌍으로 묶어서  중복판별

/*
  <WHERE 절>
  조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
  이때 WHERE 절에 조건식을 제시 한다.
  조건식에는 다양한 연산자를 사용가능하다 
  
  [표현식]
  SELECT 컬럼1, 컬럼2 ...
  FROM 테이블명
  WHERE 조건식, 
  
  [비교연산자] 
  > , < , >= , <= --> 대소비교
  =               --> 동등비교
  !=, ^= , <>     --> 동등하지 않은지 비교 
*/

--EMPLOYEE 에서 부서코드가 'D9'인 사원들만 조회(이때, 모든 칼럼 조회)
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--EMPLOYEE에서 부서코드가 'D1' 인 사원들의  사원명, 급여 , 부서코드만 조회
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
/*SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';*/
/*
SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D1';
*/
SELECT EMP_NO, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE ^= 'D1';

--급여가 400만원 이상인 사원들의 사원명,부서코드,급여조회
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY >= '4000000';


--EMPLOYEE에서 재직중인 (EMP_YN 컬럼값이 'N')인 사원들의 사번, 이름 , 입사일

SELECT EMP_ID,EMP_NAME,HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

------------------------------------실습문제-------------------------------
--1. 급여가 300만원 이상인 사원들의 사원명, 급여 , 입사일, 연봉(보너스 미포함)
SELECT EMP_NAME,SALARY,HIRE_DATE,SALARY*12
FROM EMPLOYEE
WHERE SALARY >= 3000000;
--WHERE SALARY >= '3000000';  // WHERE절에서는 SELECT 절에 작성된 별칭 사용불가 

--쿼리 실행 순서
--FROM절  => WHERE절 => SELECT절

--2. 연봉 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드
SELECT EMP_NAME,SALARY,SALARY*12,DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;

--3. 직급코드 'J3' 이 아닌 사원들의 사번,사원명,직급코드,퇴사여부 조회
SELECT EMP_ID, EMP_NAME,DEPT_CODE, ENT_YN
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D3';

--부서코드 'D9' 이면서 급여가 500만원 이상인 사원들의 사번,사원명,급여,부서코드를 조회
SELECT  EMP_ID , EMP_NAME , SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY > 5000000;

--부서코드가 'D6' 이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

--급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY 
FROM EMPLOYEE
WHERE SALARY >= 3500000  AND  SALARY <= 6000000;

----------------------------------
/*
    < BETWEEN AND >
    조건식에서 사용되는 구문
    몇 이상 몇 이하인 범위에 대한 조건을 제할 때 사용되는 연산자
    
    [표현법]
    비교대상컬럼 BETWEEN A(값1) AND B(값2)
    =>해당 컬럼의 값이 A 이상이고 B이하인 경우
*/

SELECT EMP_NAME, EMP_ID, SALARY 
FROM EMPLOYEE
WHERE SALARY BETWEEN  3500000  AND   6000000;

-- 350000 600000 이외의 사람들을 조회하고 싶다면? 350미만 + 600초과

SELECT EMP_NAME, EMP_ID, SALARY 
FROM EMPLOYEE
--WHERE SALARY < 3500000  OR  SALARY > 6000000;
--WHERE NOT SALARY BETWEEN  3500000  AND   6000000;
WHERE  SALARY NOT BETWEEN  3500000  AND   6000000;
--NOT : 논리 부정 연산자 = > 자바에서의 !
--컬럼명 앞 또는 BETWEEN 앞에 기입가능

--입사일이 '90/01/01 ~ '01/01/01'
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE > '90/01/01' AND HIRE_DATE < '01/01/01'; --DATE 형식은 대소비교 가능
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/10';

/*
    <LIKE>
    비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    -특정 패턴 제시시 '%' ,'_'를 와일드카드로 사용할 수있다.
    '%'  : 0글자 이상
    EX) 비교대상 컬럼 LIKE '문자%' =>비교대상의 컬럼값이 문자로 "시작" 되는 데이터 조회
        비교대상 컬럼 LIKE '%문자' =>비교대상의 컬럼값이 문자로 "끝"나는 데이터 조회
        비교대상 컬럼 LIKE '%문자%' =>비교대상의 컬럼값 내 문자가 "포함" 되는것을 조회 (키워드 조회)
        
    >> '_' :1글자 이상 
    EX) 비교대상컬럼 LIKE '_문자' => 비교대상의 컬럼값의 문자앞에 무조건 한글자만 오는 경우 조회
        비교대상컬럼 LIKE '_문자'  => 비교대상의 컬럼값의 문자앞에 무조건 두글자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_' => 비교대상의 컬럼값에 문자 앞과 문자 뒤에 무조건 한글자씩 올 경우
*/
--사원들 중 성이 전씨인 사원들의 사원명, 급여 ,입사일 조회
SELECT EMP_NAME , SALARY , HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
--이름이 하로 끝나는 사원들의 사원명,주민번호,전화번호 조회
SELECT EMP_NAME , EMP_NO,PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하';

--이름에 하 가 포함된 사원들의 사원명,주민번호,전화번호

SELECT EMP_NAME , EMP_NO,PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';


--이름의 가운데 글자가 하 인 사원들의 사원명,전화번호 조회
SELECT EMP_NAME , EMP_NO
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

--전화번호 3번째 자리가 1인사원들의 사번,사원명,전화번호,이메일조회
--와일드카드 : _ (1글자), %(0글자이상)
SELECT EMP_NO, EMP_NAME, PHONE,EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

--**특이케이스
-- 이메일 중 _ 기준으로 앞글자가 3글자인 사원들의 사번, 이름 , 이메일 조회 
--EX) SIM_BS@KH.SDKSLAD.COM
SELECT EMP_ID,EMP_NAME,EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; --원했던 결과 도출 못함 
--와일드카드로 사용되고 있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 조회되지 않음
--어떤게 와일드카드고 어떤게 데이터 값인지 구분지어야함
--데이터 값으로 취급하고자 하는 값 앞에 나만의 와일드 카드를 제시하고 나만의 와일드 카드를 ESCAPE OPTION으로 등록해야함

--위의 사원들이 아닌 그 외의 사원들 조회
SELECT EMP_ID,EMP_NAME,EMAIL
FROM EMPLOYEE
WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$' ;


---------------------------실습문제--------------------------------------------
--1. EMPLOYEE에서 이름이 '연'으로 끝나는 사원들의 사원명,입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';


--2. EMPLOYEE에서 전화번호 처음 3자리가  010 이 아닌 사원들의 사원명, 전화번호 조회

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

--3. EMPLOYEE에서 이름에 '하' 가 포함되어 있고 급여가 240만원 이상인 사원들의 사원명,급여 조회

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY > 2400000;

--4. DEPARTMENT에서 해외 영업부인 부서들의 코드와 부서명을 조회
SELECT DEPT_ID,DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%'; 




SELECT BONUS 
FROM EMPLOYEE;
/*
<IS NULL / IS NOT NULL >
컬럼값에 NULL이 있을 경우 NULL값 비교에 사용되는 연산자
*/

-- 보너스를 받지 않는 사원(BONUS 값이 NULL) 들의 사번, 이름 ,급여 ,보너스 조회
SELECT EMP_ID, EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
--WHERE BONUS  = NULL;
WHERE BONUS IS NULL;

--보너스를 받는 사원BONUS 값이 NULL이 아닌)들의 사번,이름,급여,보너스 조회

SELECT EMP_ID,EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
--WHERE BOBUS != NULL;
WHERE BONUS IS NOT NULL;
--NOT은 컬럼명 또는 IS 뒤에서 사용 가능

--사수가 없는 사원들의 사원명, 사수사번,부서코드조회

SELECT EMP_NAME,EMP_NO,DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--부서배치를 아직 받지는 않았지만(DEPT_CODE 값이 NULL인), 보너스는 받는 사원(BONUS 값이 NULL이 아닌)이름,보너스,부서코드조회

SELECT EMP_NAME ,BONUS,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--------------------------------------
--부서코드 D6이거나 D8 이거나 D5인 부서원 이름 코드 급여조회
/*
    <IN>
    비교대상컬럼값이 내가 제시한 목록중에 일치하는 값이 있는지 
    
    <표현법>
    WHRER 비교대상 컬럼 IN ('값1','값2','값3'....);
    
*/


SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6','D8','D5');

-그 외의 사람들 
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6','D8','D5');

/*
<연산자 우선 순위>
0. ()
1. 산술연산자
2. 연결연산자
3. 비교연산자
4. IS NULL / LIKE '특정패턴' / IN 
5. BETWEEN AND
6. NOT(논리연산자)
7. AND(논리연산자)
8. OR(논리연산자)
*/

--직급 코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

*/

--------------------<실습문제>-------------------------

-- 1. 사수가 없고 부서배치도 받지 않은 ㅅㅏ원들의 (사원명,사번,부서코드)
SELECT EMP_NAME,EMP_NO,DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND MANAGER_ID IS NULL;

-- 2. 연봉(보너스미포함)이 3000만원 이상이고 보너스를 받지 않는 사원들의 (사번,사원명,급여,보너스)
SELECT EMP_NO ,EMP_NAME,SALARY,BONUS
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000 AND BONUS IS NULL;

-- 3. 입사일이 '95/01/01/' 이상이고 부서배치를 받은 사원들의 (사번 ,사원명, 입사일, 부서코드) 조회
SELECT EMP_NO,EMP_NAME,HIRE_DATE,DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;

-- 4. 급여가 200만원 이상 500만원 이하이고 입사일이 '01/01/01' 이상이고 보너스를 받지 않는 사원들의 
-- (사번 , 사원명 , 급여 , 입사일, 보너스)조회

SELECT EMP_NO, EMP_NAME,SALARY,HIRE_DATE,BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000  AND HIRE_DATE >= ' 01/01/01' AND BONUS IS  NULL ; 

-- 5. 보너스포함연봉이 null 이 아니고 이름에 '하' 가 포함되어 있는 사원들의 (사번, 사원명, 급여 ,보너스포함연봉) 조회

SELECT EMP_NO,EMP_NAME,SALARY,((SALARY+BONUS*SALARY)*12)
FROM EMPLOYEE
WHERE ((SALARY+BONUS*SALARY)*12) IS NOT NULL AND EMP_NAME LIKE '%하%';

SELECT EMP_NO,EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

/*
    < ORDER BY 절>
    가장 마지막 줄에 작성! 뿐만 아니라 실행순서 또한 마지막에 실행
    
    [표현법]
    SELECT 조회할 컬럼, 컬럼 , 산술연삭시 AS "별칭", ...
    FROM 조회할 테이블
    WHERE 조건식
    ORDER BY  정렬하고 싶은 컬럼! 별칭! 컬럼순번 [ASC/DESC] [NULLS FIRST | NULLS LAST]

    ASC- 오름차순 정렬 (생략시 기본값)
    DESC-내림차순 정렬 
    NULLS FIRST- 정렬하고자 하는 컬럼값에 NULL이 있다면 해당 데이터를 앞쪽에 배치 (생략시 DESC일때의 기본값)
    NULLS LAST- 정렬하고자 하는 컬럼값에 NULL이 있다면 해당 데이터를 뒤쪽에 배치 (생략시 ASC일떄의 기본값)
    
*/
--오름차순
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;  -- 또는 ORDER BY BONUS ASC 
ORDER BY BONUS NULLS FIRST;
-- 오름차순 정렬일 때 기본적으로 NULLS FIRST 임을 알 수 있다.


--내림차순
SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC;
-- 오름차순 정렬일 때 기본적으로 NULLS LAST 임을 알 수 있다.

SELECT *
FROM EMPLOYEE
ORDER BY BONUS DESC, SALARY ASC;

--정렬기준 여러개 제시 가능 (첫번째 기준의 컬럼값이 동일한 경우 두번째 기준 컬럼값으로 검사  EX)BONUS 0.2 로 같을 떄 다음 SALART 로 정렬)


--전사원의 사원명, 연봉조회 (이때 연봉별 내림차순 정렬조회)
SELECT EMP_NAME,SALARY*12 AS "연봉"
FROM EMPLOYEE
--ORDER BY SALARY*12 DESC;
--ORDER BY 연봉 DESC; 별칭사용가능
ORDER BY 2 DESC; --  컬럼의 순번으로 사용 가능하다








