--1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
SELECT COMM
FROM EMP
WHERE COMM IS NOT NULL;

--2. EMP테이블에서 커미션을 받지 못하는 직원 조회
SELECT *
FROM EMP
WHERE COMM IS NULL OR COMM = 0;

--3. EMP테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM EMP
WHERE MGR IS NULL;


--4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회

SELECT *
FROM EMP
ORDER BY SAL DESC;
--5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
/*
서브쿼리(Subquery): 쿼리문 안에 다른 쿼리문을 포함시키는 개념입니다.
주어진 쿼리문에서는 IN 절 안에 서브쿼리가 사용되었습니다. 
이를 통해 EMP 테이블에서 중복된 SAL 값을 찾기 위해 서브쿼리를 사용하였습니다.

그룹화(Grouping): GROUP BY 절을 사용하여 특정 컬럼 기준으로 그룹을 형성하는 개념입니다. 
주어진 쿼리문에서는 EMP 테이블의 SAL 컬럼을 그룹화하였습니다.

그룹 조건(Having): HAVING 절을 사용하여 그룹화된 결과에 조건을 적용하는 개념입니다. 
주어진 쿼리문에서는 중복된 SAL 값을 가진 그룹들을 COUNT(SAL) > 1 조건으로 필터링하여 선택하였습니다.

정렬(Sorting): ORDER BY 절을 사용하여 결과를 특정 컬럼의 값에 따라 정렬하는 개념입니다. 
주어진 쿼리문에서는 COMM 컬럼을 내림차순으로 정렬하였습니다.
*/

--COMM 컬럼을 조회하는데 SAL 컬럼을 중복 비교해야 하는 상황이기 때문에 서브쿼리문 작성

SELECT COMM
FROM EMP
WHERE SAL IN(
SELECT SAL
FROM EMP
GROUP BY SAL
HAVING COUNT(SAL) > 1
)
ORDER BY COMM DESC;

--6. EMP테이블에서 사원번호, 사원명,직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT EMPNO,ENAME,JOB,HIREDATE
FROM EMP
ORDER BY HIREDATE ASC;


--7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT EMPNO,ENAME
FROM EMP
ORDER BY EMPNO DESC;

--8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회
--(부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
SELECT EMPNO,HIREDATE,ENAME,SAL
FROM EMP
ORDER BY DEPTNO ASC , HIREDATE ASC;


--9. 오늘 날짜에 대한 정보 조회

SELECT SYSDATE
FROM DUAL;
--10. EMP테이블에서 사번, 사원명, 급여 조회
--(단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO,ENAME,
FROM EMP;

--11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
--12. EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
--13. EMP테이블에서 9월에 입사한 직원의 정보 조회
--14. EMP테이블에서 81년도에 입사한 직원 조회
--15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
--16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
--16-1. LIKE 사용
--16-2. SUBSTR() 함수 사용
--17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
--18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
--19. 오늘 날짜에서 년도만 추출