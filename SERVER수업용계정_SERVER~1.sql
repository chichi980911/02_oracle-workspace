---로그인 요청시 실행될 SQL문

SELECT * FROM MEMBER;


SELECT * 
    FROM MEMBER
WHERE USER_ID = 'user01'
  AND USER_PWD = 'pass01'
  AND STATUS = 'Y';
  

SELECT
      USER_NO
    , USER_ID
    , USER_PWD
    , USER_NAME
    , PHONE
    , EMAIL
    , INTEREST
    , ENROLL_DATE
    , MODIFY_DATE
    , STATUS
    FROM MEMBER
WHERE USER_ID = 'admin'
  AND USER_PWD = '1234'
  AND STATUS = 'Y';
  
  
  SELECT
		  USER_NO
		, USER_ID
		, USER_PWD
		, USER_NAME
		, PHONE
		, EMAIL
		, INTEREST
		, ENROLL_DATE
		, MODIFY_DATE
		, STATUS
	FROM MEMBER
	WHERE USER_ID = 'admin'
	AND USER_PWD = '1234'
	AND STATUS = 'Y';

