/*
        * 서브쿼리 (SUBQUERY)
        - 하나의 SQL문 안에 포함된 또다른 SELECT문
        - 메인 SQL문을 위해 보조 역할을 하는 쿼리문
*/

-- 간단 서브쿼리 예시1
-- 노옹철 사원과 같은 부서에 속한 사원들 조회하고 싶음!!

-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; -- D9

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- > 위의 2단계를 하나의 쿼리문으로
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE =  (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');    
                    
-- 간단 서브쿼리 예시2
-- 전 직원의 평균 급여보다 더 많은 급여를 받는 사원들의 사번, 이름, 직급코드, 급여 조회

-- 1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE; -- 대략 3047663원인 걸 알아냄!!

-- 2) 급여가 3047663원 이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);

--------------------------------------------------------------------------------
/*
        * 서브쿼리의 구분
        서브쿼리 수행한 결과값이 몇 행 몇 열이냐에 따라서 분류됨
        
        - 단일행 서브쿼리 : 서브쿼리의 조회 결과값의 개수가 오로지 한 개일 때 (한 행 한 열)
        - 다중행 서브쿼리 : 서브쿼리의 조회 결과값이 여러행일 때 (여러행 한 열) => 동명이인 노옹철 2명일 때
        - 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 한 행이지만 컬럼이 여러개일 때 (한 행 여러열)
        - 다중행 다중열 서브쿼리 : 서브쿼리 조회 결과값이 여러행 여러 컬럼일 때 (여러행 여러열)
        
        >> 서브쿼리 종류가 뭐냐에 따라서 서브쿼리 앞에 붙는 연산자가 달라짐!!
*/

/*
        1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
        서브쿼리의 조회 결과값의 개수가 오로지 1개일 때 (한 행 한 열)
        일반 비교 연산자 사용 가능
        =, !=, ^=, <>, <, >, >=, ...
*/

-- 1) 전 직원의 평균급여보다 급여를 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
-- WHERE SALARY < 전직원의 평균 급여
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
-- 2) 최저 급여를 받는 사원의 사번, 이름, 급여, 입사일
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
-- WHERE SALARY = 전직원들중 최저급여;
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);
                
-- 3) 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE SALARY > 노옹철 사원의 급여
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');
                
-- >> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '노옹철');


-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '노옹철');
              
-- 4) 부서별 급여합이 가장 큰 부서의 부서코드, 급여 합 조회
-- 4_1) 먼저 부서별 급여합 중에서도 가장 큰 값 하나만 조회
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- 17700000

-- 4_2) 부서별 급여합이 17700000원인 부서 조회 (부서코드, 급여합)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- 위의 두 단계를 하나의 쿼리문으로!!
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (  SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);
                        
-- 직접해보기
-- 전지연 사원과 같은 부서원들의 사번, 사원명, 전화번호, 입사일, 부서명
-- 단, 전지연은 제외!

-- 전지연 사원의 부서
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전지연'; -- D1

-- D1 부서원들의 사번, 사원명, 전화번호, 입사일, 부서명 (전지연 제외)
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND EMP_NAME != '전지연'
AND DEPT_CODE = 'D1';

-- >> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND EMP_NAME != '전지연'
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '전지연');

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE EMP_NAME != '전지연'
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '전지연');
                 
-------------------------------------------------------------------------------
/*
        2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
        서브쿼리를 수행한 결과값이 여러 행일 때 (컬럼(열)은 한 개)
        
        - IN 서브쿼리 : 여러개의 결과값 중에서 한 개라도 일치하는 값이 있다면
        
        - > ANY 서브쿼리 : 여러개의 결과값 중에서 "한 개라도" 클 경우 (여러개의 결과값 중 가장 작은 값보다 클 경우)
        - < ANY 서브쿼리 : 여러개의 결과값 중에서 "한 개라도" 작을 경우 (여러개의 결과값 중 가장 큰 값보다 작을 경우)
        
        비교대상 > ANY (값1, 값2, 값3)
        비교대상 > 값1 OR 값2 OR 값3
        
        - > ALL 서브쿼리 : 여러개의 "모든" 결과값들보다 클 경우
        - < ALL 서브쿼리 : 여러개의 "모든" 결과값들보다 작을 경우
        
        비교대상 > ALL (값1, 값2, 값3)
        비교대상 > 값1 AND 값2 AND 값3
*/

-- 1) 유재식 또는 윤은해 사원과 같은 직급인 사원들의 사번, 사원명, 직급코드, 급여 조회
-- 1_1) 유재식 또는 윤은해 사원이 어떤 직급인지 조회
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해'); -- J3, J7

-- 1_2) J3 OR J7인 직급의 사원들 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- 위의 두 단계를 하나의 쿼리로
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ( SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('유재식', '윤은해')); -- = 이라고 쓰면 에러남!! 여러행으로 조회됐기 때문
                    -- 만약에 결과값이 여러개 나올 것 같으면 그냥 안전빵으로 IN으로 가자
                    
-- 사원 => 대리 => 과장 => 차장 => 부장 ...
-- 2) 대리 직급임에도 불구하고 과장 직급 급여들 중 최소 급여보다 많이 받는 직원 조회 (사번, 이름, 직급, 급여)

-- 2_1) 먼저 과장 직급인 사원들의 급여 조회
SELECT SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND J.JOB_NAME = '과장'; -- 2200000 2500000 3760000

-- 2_2) 직급이 대리이면서 급여값이 위의 목록들 값 중에 하나라도 큰 사원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (2200000, 2500000, 3760000);

-- 위의 두 단계를 하나의 쿼리문으로 작성
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY (  SELECT SALARY
                    FROM EMPLOYEE E, JOB J
                    WHERE E.JOB_CODE = J.JOB_CODE
                    AND J.JOB_NAME = '과장');
                    
-- 단일행 서브쿼리로도 가능!!
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > (SELECT MIN(SALARY)
              FROM EMPLOYEE E, JOB J
              WHERE E.JOB_CODE = J.JOB_CODE
              AND J.JOB_NAME = '과장');
              
-- 3) 과장 직급임에도 불구하고 모든 차장직급인 사원들의 급여보다도 더 많이 받는 사원들의 사번, 이름, 직급명, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장'
-- AND SALARY > (차장 직급인 애들의 급여들)
AND SALARY > ALL (SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING (JOB_CODE)
                WHERE JOB_NAME = '차장');

-------------------------------------------------------------------------------
/*
        3. 다중열 서브쿼리
        결과값은 한 행이지만 나열된 컬럼수가 여러개일 경우
*/

-- 1) 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회 
-- (사원명, 부서코드, 직급코드, 입사일)
-- 단일행 서브쿼리 ** 2개의 서브쿼리로 작성할 것!

-- 하이유 사원의 부서코드
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'; -- D5

-- 하이유 사원의 직급코드
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'; -- J5

-- 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들 조회 (메인 쿼리)
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME != '하이유'
AND DEPT_CODE = 'D5' 
AND JOB_CODE = 'J5';

-- 메인 퀴리 + 서브 쿼리
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME != '하이유'
AND DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '하이유')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '하이유');
                
-- >> 다중열 서브쿼리로!!                
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
-- WHERE (DEPT_CODE, JOB_CODE) = (하이유 사원의 부서코드, 하이유 사원의 직급코드);
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '하이유'); -- 순서 중요함!! 개수도 맞춰야함!!
-- AND EMP_NAME != '하이유';

-- 박나라 사원과 같은 직급코드, 같은 사수를 가지고 있는 사원들의 사번, 사원명, 직급코드, 사수사번 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME != '박나라'
AND (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '박나라');
        
--------------------------------------------------------------------------------
/*
        4. 다중행 다중열 서브쿼리
        서브쿼리 조회 결과값이 여러행 여러열인 경우
*/

-- 1) 각 직급별 최소급여를 받는 사원 조회 (사번, 사원명, 직급코드, 급여)
-- >> 각 직급별 최소급여 조회
SELECT JOB_CODE, MIN(SALARY) -- 3
FROM EMPLOYEE -- 1
GROUP BY JOB_CODE;-- 2

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 3700000
OR    JOB_CODE = 'J7' AND SALARY = 1380000
...;

-- 서브쿼리를 적용해서 해보자
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);
                            
-- 2) 각 부서별 최고 급여를 받는 사원들의 사번, 사원명, 부서코드, 급여
-- 각 부서별 최고 급여 조회
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 최고 급여를 받는 사원들의 사번, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE);

-------------------------------------------------------------------------------
/*
        5. 인라인 뷰 (INLINE - VIEW)
        
        서브쿼리를 수행한 결과를 마치 테이블처럼 사용!
*/

-- 사원들의 사번, 이름, 보너스 포함 연봉 (별칭 부여 : 연봉), 부서코드 조회 => 보너스 포함 연봉이 절대 NULL이 안 나오게
-- 단, 보너스 포함 연봉이 3000만원 이상인 사원들만 조회
SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "연봉", DEPT_CODE -- 3
FROM EMPLOYEE -- 1
WHERE (SALARY + SALARY * NVL(BONUS, 0)) * 12 >= 30000000; -- 2

SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "연봉", DEPT_CODE
FROM EMPLOYEE;
-- 이걸 마치 존재하는 테이블인 거 마냥 사용할 수 있음!! 그게 인라인 뷰

SELECT EMP_NO, EMP_NAME, 연봉, DEPT_CODE--, MANAGER_ID => 이건 오류남!!
FROM (SELECT EMP_NO, EMP_NAME, (SALARY + SALARY * NVL(BONUS, 0)) * 12 AS "연봉", DEPT_CODE
        FROM EMPLOYEE) -- 1
WHERE 연봉 >= 30000000;

-- >> 인라인 뷰를 주로 사용하는 예 => TOP-N 분석  (상위 몇개만 보여주고 싶을 때 => BEST 상품)

-- 전 직원 중 급여가 가장 높은 상위 5명만 조회
-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- FROM -> SELECT ROWNUM (이때 순번이 부여됨. 정렬도 하기전에 이미 순번 부여)

-- 뭔가 좀 이상함... 실행순서 때문

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- > 정상적인 결과가 조회되지 않음!! (정렬이 되기도 전에 5명이 추려지고나서 정렬)

-- ORDER BY 절이 다 수행된 결과를 가지고 ROWNUM 부여 후 5명 추려야함!!
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, * -- EMP_NAME, SALARY -- 3
FROM (SELECT * -- EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC) -- 1
WHERE ROWNUM <= 5; -- 2

-- ROWNUM이랑 전체컬럼 조회하고 싶음 => 별칭 부여하는 방법으로
SELECT ROWNUM, E.* -- EMP_NAME, SALARY -- 3
FROM (SELECT * -- EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
        ORDER BY SALARY DESC) E -- 1
WHERE ROWNUM <= 5; -- 2

-- 1. 가장 최근에 입사한 사원 5명 조회 (사원명, 급여, 입사일)
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT ROWNUM AS "순번", E.*
FROM (SELECT EMP_NAME AS "사원명", SALARY AS "급여", HIRE_DATE AS "입사일"
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <= 5;

-- 2. 각 부서별 평균급여가 높은 3개의 부서 조회 (부서코드, 평균급여)
SELECT NVL(DEPT_CODE, '부서없음'), FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY ROUND(AVG(SALARY)) DESC;

SELECT 부서코드, FLOOR(AVG(SALARY))
FROM (SELECT NVL(DEPT_CODE, '부서없음') AS "부서코드", AVG(SALARY)
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY 2 DESC) E
WHERE ROWNUM <= 3;

-->>인라인 뷰를 주로 사용하는 예 

--전직원중 급여가 가장 높은 상위 5명만 조회
--ROWNUM :오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼
SELECT ROWNUM, EMP_NAME,SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- FROM -> SELECT ROWNUM (이때 순번이 부여됨. 정렬도 하기전에 이미 순번이 부여되어 있음)

SELECT ROWNUM, EMP_NAME,SALARY
FROM EMPLOYEE
--WHERE ROWNUM <= 5 
ORDER BY SALARY DESC;
-->정상적인 결과가 조회되지 않습니다. (정렬이 되기도 전에 5명이 추려지고 나서 정렬)

--> ORDER BY 절이 다 수행된 결과를 가지고 ROWNUM을 부여 후 5명을 추려야 한다.
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM,E.*, EMP_NAME ,SALARY --3
FROM (SELECT * -- EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
ORDER BY SALARY DESC) E --1
WHERE ROWNUM <=5; --2

--ROWNUM이랑 전체컬럼을 조회하고 싶은상황 -->

--1..가장 최근에 입사한 사원 5명 조회(사원명 급여 입사일)

SELECT EMP_NAME,HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT ROWNUM, EMP_NAME,HIRE_DATE
FROM(SELECT EMP_NAME,HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5 ;

--2. 각 부서별 평균 급여가 높은 3개의 부서 조회 (부서코드 ,평균급여)

SELECT DEPT_CODE,AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

SELECT ROWNUM, DEPT_CODE , FLOOR(평균급여)
FROM(SELECT DEPT_CODE,AVG(SALARY) AS "평균급여"
FROM EMPLOYEE E
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <= 3;

SELECT DEPT_CODE,AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY AVG(SALARY) DESC;

------------------------------------------------------------------------------
/*
    *순위 매기는 함수 (WINDOW FUCTION) 
    RANK() OVER(정렬기준)           |       DENSE_RANK() OVER(정렬기준)
    
    -RANK() OVER(정렬기준) : 동일한 순위 이후의 등수를 동일한 인원수 만큼 건너뛰고 순위 계산
                            EX) 공동 1위가 2명 그 다음 순위는 3위 => 1 1 3 
    -DENSE_RANK() OVER(정렬기준)  : 동일한 순위가 있다고 해도 그 다음 등수를 무조건 1씩 증가시킴
                                  EX) 공동 1위가 2명이더라도 그 다음 순위를 2위 ==> 1  1 2
*/
--급여가 높은 순대로 순위를 매겨서 조회 
SELECT EMP_NAME, SALARY , RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
--공동 19위 2명 그 뒤의 순위는 21 => 마지막 순위랑 조회만 행수랑 같다.

SELECT EMP_NAME, SALARY , DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
--공동 19위 2명 그뒤의 순위는 20 -->마지막 순위랑 조회된 행수가 다름 

--상위 5명만 조회
SELECT EMP_NAME, SALARY , RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE
--WHERE 순위 <= 5; --2
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5;

--인라인 뷰를 써야한다.

SELECT*
FROM(SELECT EMP_NAME, SALARY , RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE)
WHERE 순위 <= 5;

