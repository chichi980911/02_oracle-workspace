/*
    <함수>
    전달된 컬럼값을 읽어들어서 함수를 실행한 결과를 반환한다.
    
    -단일행 함수 : N개의 값을 읽어들어서 N개의 결과값을 리턴한다(매 행 마다 함수 실행 결과 반환)
    -그룹 함수 : N개의 값을 읽어들여서  1개의 결과값을 리턴 (그룹을 지어 그룹별로 함수 실행 결과 반환)
    
    >> SELECT 절에 단일행함수, 그룹함수를 함께 사용 못함
    왜? 결과 행의 개수가 다르기 떄문 
    >> 함수식을 기술 할 수 있는 위치 : SELECT절, WHERE절, ORDER BY 절, GROUP BY절, HAVING절    
*/

/*
     <문자 처리 함수>
     
     *LENGTH / LENGTHB => 결과값 NUMBER 타입
     LENGTH(컬럼 | '문자열 값') : 해당 문자열 값의 글자수 반환
     LENGTHB(컬럼 | '문자열 값') : 해당 문자열 값의 바이트 수 반환 
     
     '김','나','ㄱ', 한글자당 3BYTE
     영문자, 숫자 , 특문 한글자당 1BYTE
 
*/
SELECT SYSDATE
FROM DUAL; -- 가상테이블 

SELECT LENGTH('오라클'),LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('oracle'),LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME,LENGTH(EMP_NAME),LENGTHB(EMP_NAME),
EMAIL,LENGTH(EMAIL),LENGTHB(EMAIL)
FROM EMPLOYEE; --매행마다 다 실행되고 있다 =>단일행 함수

/*
    *INSTR
    문자열로부터 특정 문자의 시작위치를 찾아서 반환한다
    
    -INSTR(컬럼),'문자열''찾고자하는 문자',['찾을위치의 시작값',[순번]] => 결과값은 NUMBERT 타입
    
    찾을 위치의 시작값
    1 : 앞에서부터 찾겠다
    -1 : 뒤에서부터 찾겠다
*/

SELECT INSTR ('AAABAACAABBAA','B') FROM DUAL; -- 찾을 위치의 시작값 : 1 기본값 => 앞에서부터 찾음, 순번도  1 기본값
SELECT INSTR ('AAABAACAABBAA','B',1) FROM DUAL;
SELECT INSTR ('AAABAACAABBAA','B',-1) FROM DUAL;
SELECT INSTR ('AAABAACAABBAA','B',1,2) FROM DUAL;
SELECT INSTR ('AAABAACAABBAA','B',-1,2) FROM DUAL;

SELECT EMAIL, INSTR (EMAIL,'_',1,1) AS "_위치", INSTR(EMAIL,'@') AS "@ 위치"
FROM EMPLOYEE;

-------------------------------------------------------------

/*
    *SUBSTR
    문자열에서 특정 문자열을 추출해서 반환 (자바에서 SUBSTRING() 메서드와 유사)
    
    SUBSTR(STRING , 자를 시작위치 인덱스, LENGTH(몇개자를건지))) =>결과값 CHARACTER 타입
    -STRING : 문자타입컬럼 또는 '문자열 값'
    -POSTION : 문자열을 추출할 시작 위치값
    -LENGTH : 추출할 문자 개수 (생략시 끝까지 의미)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) AS "성별"
FROM EMPLOYEE;

--여자사원만 조회
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1)= '2' OR SUBSTR(EMP_NO ,8 ,1) ='4';
WHERE SUBSTR(EMP_NO,8,1)  IN ('2','4'); 

--내부 형변환-
SELECT EMP_NAME,EMP_NO,EMP_ID
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)  IN (2,4)
ORDER BY 1; --기본적으로는 오름차순


--함수 중첩사용
SELECT EMP_NAME,EMAIL ,SUBSTR(EMAIL, 1,INSTR(EMAIL,'@')-1) AS "아이디"
FROM EMPLOYEE;
--------------------------------------------------------------------------------

/*
    *LPAD / RPAD
    문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
    
    LPAD / RPAD (STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자 하는 문자 ])
    
    문자열에 덧붙이고자 하는 문자를 왼쪽 오른쪽에 덧붙여서 최종 N길이 만큼의 문자열을 반환
    
*/


SELECT EMP_NAME, LPAD(EMAIL,20)
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL , 20 , '#')
FROM EMPLOYEE;

--850101-2****** 조회
SELECT RPAD('850101-2', 14 , '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(주민번호값으로 성별까지 추출한 문자열, 14 , '*')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8), 14 , '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO , 1, 8) ||'******'
FROM EMPLOYEE;

/*
    LTRIM/RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    LTRIM/RTRIM (STRING,['제거할 문자들 ']) => 생략하면 공백 제거
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거 후 반환
*/
SELECT LTRIM('             K   R')FROM DUAL;  - 공백 찾아서 제거하고 공백아닌 문자가 나오면 끝난다
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL;

SELECT RTRIM('5782KH123','0123456789') FROM DUAL;

/*
    *TRIM
    문자열의 앞 / 뒤 / 양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    TRIM(LEAING,TRAILING,BOTH)제거하고자 하는 문자들 FROM STRING)
*/

--기본적으로 양쪽에 있는 문자들 다 찾아서 제거 
SELECT TRIM('        K   H           ') FROM DUAL;

SELECT TRIM('Z' FROM 'ZZZZKHZZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -- LEADING: 앞  <> LTRIM과 유사
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -- TRAILING : 뒤 <> RTRIM과 유사
SELECT TRIM(BOTH 'Z' FROM 'ZZZZKHZZZ') FROM DUAL; -- BOTH 앞/뒤 <> TRIM과 유사

/*
    *LOWER / UPPER /INITCAP

    LOWER / UPPER /INITCAP (STRING) => 결과값은 CHARACTER 타입
    
    LOWER : 다 소문자로  변경한 문자열 반환(자바에서의 toLowerCase() 메서드와 유사)
    UPPER : 다 대문자로  변경한 문자열 반환(자바에서의 toUpperCase() 메서드와 유사)
    INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
    
*/

SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('Welcome To My World') FROM DUAL;

-----------------------------------------------------------------
/*
    CONCAT
    문자열 두개 전달받아 하나로 합친 후 결과 반환
    
    CONCAT(STRING,STRING) => 결과값 CHAPACTER 타입
*/
SELECT CONCAT('ABC','초콜릿') FROM DUAL;
SELECT 'ABC' || '초콜릿' FROM DUAL;

--차이점
-- CONCAT 2개이상 사용불가능하다 

SELECT CONCAT('ABC','초코릿',123) FROM DUAL; 
SELECT 'ABC' || '초콜릿' || 123 FROM DUAL;
-------------------------------------------------------------------------------
/*
    *REPLACE
    
    REPLACE(STRING,STR1,STR2) =>결과값은 CHARACTER 타입
    
*/
SELECT EMP_NAME, EMAIL,  REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*
  ABS
  숫자의 절대값을 구해주는 함수 
  ABS(NUMBER)  => 결과값은 NUMBER 타입
*/
SELECT ABS(-10) FROM DUAL; 
SELECT ABS(-5.7) FROM DUAL;

-------------------------------------------------------------------------------
/*
    *MOD
    두 수를 나눈 나머지값을 반환해주는 함수
    
    MOD(NUMBER,NUMBER) => 결과값 NUMBER 탕비

*/
SELECT MOD (10,3) FROM DUAL;

SELECT MOD (10.9, 3) FROM DUAL;

-------------------------------------------------------------------------------
/*

    *ROUND
    반올림한 결과를 반환
    
    ROUND(NUMBER , [위치]) = > 결과값 NUMBER
    
*/
SELECT ROUND(123.656,) FROM DUAL;  --위치 생략시 0
SELECT ROUND(123.656, 1 ) FROM DUAL; 
SELECT ROUND(123.656, 4 ) FROM DUAL; -- 그대로 나옴
SELECT ROUND(123.656, -1 ) FROM DUAL;

-------------------------------------------------------------------------------
/*
    *CEIL
    올림처리 해주는 함수
    CEIL(NUMBER)
    
*/
SELECT CEIL(123.152) FROM DUAL; -- 5이상이 아니여도 무조건 그냥 올린다 (위치지정 불가)

-------------------------------------------------------------------------------
/*
    *FLOOR
    소숫점 아래 자리를 버림처리 해주는 함수 
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.752) FROM DUAL; --5미만이 아니여도 무조건 그냥 버린다 (위치지정 불가)
-------------------------------------------------------------------------------
/*
    *TRUNC (절삭하다)
    위치 지정 가능한 버림처리해주는 함수
    TRUNC(NUMBER,[위치])
    
*/
SELECT TRUNC(123.456) FROM DUAL; --위치지정하지 않으면 FLOOR(버림)이랑 동일
SELECT TRUNC(123.456,1) FROM DUAL;

----------------------------------날짜처리함수 --------------------------------

/*
    * SYSDATE : 시스템 날짜 및 시간 반환 (현재 날짜 및 시간)
    
*/

SELECT SYSDATE FROM DUAL;

--* MONTHS_BETWEEN(DATE1,DATE2): 두 날짜 사이의 개월 수 = > 내부적으로 DATE1과 DATE2 후 나누기 30,31 진행된다.
--=>결과값 NUMBER 타입

SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE), 
CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) 
FROM EMPLOYEE;

-- *ADD_MONTHS(DATE,NUMBER) : 특정날짜에 해당 숫자만큼의 개월수를 더해서 날짜를 리턴
-- => 결과값 DATE 타입

SELECT ADD_MONTHS(SYSDATE,6) FROM DUAL;

--EMPLOYEE에서 사원명, 입사일, 입사후 6개월된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) AS "수습이 끝난 날짜"
FROM EMPLOYEE;

-- *NEXT_DAY(DATE, 요일) : 특정날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수
-- => 결과값은 DATE 타입
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;

--언어변경
SELECT * FROM NLS_SESSION_PARAMETERS;


ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--* LAST_DAY (DATE) : 해당 월의 마지막 일을 구해서 반환 = > 결과값 DATE 타입
SELECT  LAST_DAY(SYSDATE)
FROM DUAL;

--EMPLOYEE에서 사원명, 입사일 ,입사한달의 마지막 날짜 , 입사한 달의 근무한 일수
SELECT EMP_NAME,HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE
FROM EMPLOYEE;

-------------------------------------------------------------------------------
/*

    *EXTRACT : 특정 날짜로부터 년도/월/일 값을 추출해서 반환하는 함수 
    EXTRACT(YEAR FROM DATE): 연도만 추출
    EXTRACT(MONTH FROM DATE): 월만 추출
    EXTRACT(DAY FROM DATE): 일만 추출
    =>결과값 NUMBER타입
*/

--사원명,입사연도,입사월,입사일 조회
SELECT EMP_NAME,EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도"
,EXTRACT(MONTH FROM HIRE_DATE) AS  "입사월"
,EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
ORDER BY "입사년도" ,"입사월", "입사일";


--------------------------------형 변환 함수---------------------------------
/*
    <형변환 함수>
    *TO_CHAR : 숫자 타입 또는 날짜 타입의 값을 문자타입으로 변환시켜주는 함수 
    
    TO_CHAR([숫자]날짜, [포맷]) =>결과값 CHARACTER 타입

*/

--숫자 타입  >> 문자타입

SELECT TO_CHAR(123456) FROM DUAL;

SELECT TO_CHAR(1234, '99999') FROM DUAL; --5칸 짜리 공간 확보, 오른쪽 정렬 , 빈칸 공백

SELECT TO_CHAR(1234, '00000') FROM DUAL;

SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- 현재 설정된 나라(LOCAL) 화폐 단위로 출력

SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999') FROM EMPLOYEE;

--날짜타입 => 문자타입
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 클랙해보면 다름
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; --HH : 12시간 형식
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- HH24 : 24시간 형식
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME,TO_CHAR(HIRE_DATE,'YYYY-MM-DD DY')
FROM EMPLOYEE;

--EX) 1990년 02 월 06 형식 으로 
SELECT TO_CHAR(HIRE_DATE,'YYYY"년" MM"월" DD"일"') --없는 포맷 제시 할 때에는 "" 여기로 묶기
FROM EMPLOYEE;

--년도와 관련된 포맷
SELECT TO_CHAR(SYSDATE,'YYYY'),
       TO_CHAR(SYSDATE,'YY'),
       TO_CHAR(SYSDATE,'RRRR'),
       TO_CHAR(SYSDATE,'RR'),
       TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

--월과 관련된 포맷

SELECT TO_CHAR(SYSDATE,'MM'),
       TO_CHAR(SYSDATE,'MON'),
       TO_CHAR(SYSDATE,'MONTH'),
       TO_CHAR(SYSDATE,'RM')
FROM DUAL;

--일과 관련된 포맷 
SELECT TO_CHAR(SYSDATE,'DDD'), --올해 기준으로 오늘이 며칠째인지
       TO_CHAR(SYSDATE,'DD'),   --월 기준으로 오늘이 며칠째인지
       TO_CHAR(SYSDATE,'D')     --주 기준으로 오늘이 며칠째인지
FROM DUAL;

--요일에 대한 포맷
SELECT TO_CHAR(SYSDATE,'DAY'),
       TO_CHAR(SYSDATE,'DY')
FROM DUAL;

-------------------------------------------------------------------------------
/*
    *TO_DATE : 숫자타입 또는 문자타입 데이터를 날짜 타입으로 변환 시켜주는 함수
    
    TO_DATE(숫자|문자, [포맷])

*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL; -- 에러
SELECT TO_DATE('070101') FROM DUAL; --첫글자가 0인 경우 문자타입으로 변경하고 해야한다

SELECT TO_DATE('041030 143000','YYMMDD HH24MISS') FROM DUAL; -- 에러 
SELECT TO_DATE('140630','YYMMDD') FROM DUAL; --2014년
SELECT TO_DATE('980630','YYMMDD') FROM DUAL; --2098년 => 무조건 현재 세기로 반영한다.

SELECT TO_DATE('140630','RRMMDD') FROM DUAL;
SELECT TO_DATE('980630','RRMMDD') FROM DUAL;
-- RR : 해당 두자리 년도 값이 50 미만인 경우 현재 제가 반영 , 50이상일 경우 이전세기 반영

-------------------------------------------------------------------------------
/*
    *TO_NUMBER : 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    TO_NUMBER(문자, [포맷])  =>결과값은 NUMBER타입
    
*/
SELECT TO_NUMBER('05123475') FROM DUAL; ----0이 빠져서 숫자타입으로 저장됨

SELECT '1000000' + '55000' --> 오라클에서는 자동형변환 잘 되어있다

SELECT '10,000,000' + '55,000' FROM DUAL; --안에 숫자만 있어야 자동 형변환 된다.

SELECT TO_NUMBER('10,000,000','99,999,999')+ TO_NUMBER('55,000','99,999') FROM DUAL;

-------------------------------------------------------------------------------
/*
    <NULL 처리함수>
    
    NVL(컬럼, 해당 컬럼이 BULL일 경우 반환할 값 )
*/

SELECT EMP_NAME,BONUS,NVL(BONUS,0)
FROM EMPLOYEE;

--전 사원의 이름 보너스포함 연봉
SELECT EMP_NAME, (SALARY + SALARY * BONUS)*12,(SALARY + SALARY * NVL(BONUS , 0))*12 AS "보너스포함 연봉"
FROM EMPLOYEE;

SELECT DEPT_CODE , NVL(DEPT_CODE , '부서없음')
FROM EMPLOYEE;

--NVL2(컬럼,반환값1,반환값2)
--컬럽값이 존재할 경우 반환값 1 반환 
--컬럼값이 NULL인 경우 반환값2 반환

SELECT EMP_NAME, BONUS , NVL2(BONUS,0.7,0.1)
FROM EMPLOYEE;

SELECT DEPT_CODE, NVL2(DEPT_CODE,'부서있음','부서없음')
FROM EMPLOYEE;

-- NULLIF(비교대상1,비교대상2)
--  두 개의 값이 일치하면 NULL 반환
--두개의 값이 일치 하지 않으면 비교대상 : 반환

SELECT NULLIF('123','123') FROM DUAL;

SELECT NULLIF('123','456') FROM DUAL;

-------------------------------------------------------------------------------
/*
    <선택 함수>
    
    *동등비교*
    * DECODE(비교하고자 하는 대상(컬럼 |산술 연산 |합수식)), 비교값1,결과값1, 비교값2,결과값2,...)
    
    SWITCH(비교대상) : 
    CASE 비교값1 : BREAK;
*/

 --사번,사원명,주민번호
 SELECT EMP_ID, EMP_NAME  , EMP_NO, SUBSTR(EMP_NO,8,1),
 DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') AS "성별"
 FROM EMPLOYEE;
 
 --직원의 급여 조회시 각 직급별로 인상해서 조회
 -- J7인 사원은 급여를 10% 인상  (SALARY * 1.1)
 -- J6인 사원은 급여를 15% 인상 (SALARY * 1.15)
 -- J5인 사원은 급여를 20% 인상 (SALARY * 1.2)
 -- 그 외의 사원은 급여를 5% 인상(SALARY * 1.05)
 
 -- 사원명,직급코드, 기존급여,인상된급여
 
SELECT EMP_NAME,JOB_CODE,SALARY,
        DECODE(JOB_CODE,'J7', SALARY*1.1,
        'J6',SALARY*1.15,
        'J5',SALARY*1.2,
        SALARY * 1.05) AS "인상된급여"
FROM EMPLOYEE;
 


-------------------------------------------------------------------------------
/*
    *CASE WHEN THEN
        CASE WHEN 조건식1 THEN 결과값1
        CASE WHEN 조건식2 THEN 결과값2
         ...
         ELSE 결과값N
    END
    
    자바에서의 IF-ELSE IF -ELSE 문
*/

SELECT EMP_NAME,SALARY,
        CASE WHEN SALARY >= 5000000 THEN '고급 개발자'
             WHEN SALARY >= 3500000 THEN '중급 개발자'
             ELSE '초급'
        END AS "레벨"
FROM EMPLOYEE;
---------------------------- 그룹함수 ------------------------------------
/*
1.SUM(숫자타입컬럼)  :  해당 컬럼 값들의 총 합계를 구해서 반환해주는 함수 

--EMPLOYEE 테이블의 전 사원의 급여합

*/
SELECT SUM(SALARY)
FROM EMPLOYEE; --전체 사원이 한 그룹으로 묶임

--남자 사원들의 총 급여 합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

--부서코드 D5인 사원들의 총 연봉 합 

SELECT SUM(SALARY*12) AS "총 연봉 합"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2.AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환

SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--3.MIN(여러타입) : 해당 컬럼값들 중에 가장 작은 값 구해서 반환
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

--4.MAX(여러타입) : 해당 컬럼값들 중에 가장 큰값 구해서 반환
SELECT MAX(EMP_NAME) , MAX(SALARY),MAX(HIRE_DATE)
FROM EMPLOYEE;

--5.COUNT(* | 컬럼 | DISTINCT컬럼) : 조회 된 행 개수를 세서 반환
-- COUNT(*) :  조회된 결과의 모든 행 개수를 세서 반환
-- COUNT(컬럼) : 제시한 컬럼 값이 NULL이 아닌것만 행 개수를 세서 반환
-- COUNT(DISTINCT) : 해당 컬럼값 중복을 제거한 후 행 개수 세서 반환

SELECT COUNT(*)
FROM EMPLOYEE;

--여자사원수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO , 8 ,1) IN ('2','4');

-- 보너스를 받는 사원수 
SELECT COUNT(*) -- 컬럼이 NULL이 아닌것만 카운팅한다
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(*) 
FROM EMPLOYEE
WHERE BONUS IS NULL;

SELECT COUNT(BONUS)
FROM EMPLOYEE;

--부서배치 받은 사원 수
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

--현재 사원들이 몇개의 부서에 분포되어 있는지
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;


