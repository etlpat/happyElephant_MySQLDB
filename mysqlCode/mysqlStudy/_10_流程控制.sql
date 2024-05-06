-- if(exp1,exp2,exp3)函数
-- 功能：若exp1为真，则返回exp2；否则返回exp3
SELECT IF(TRUE, 'a', 'b') FROM DUAL;
SELECT IF(FALSE, 'a', 'b') FROM DUAL;


-- ifnull(exp1, exp2)函数
-- 功能：若exp1不为空，则返回exp1；否则返回exp2
SELECT IFNULL('a', 'b') FROM DUAL;
SELECT IFNULL(123, 456) FROM DUAL;
SELECT IFNULL(NULL, 'b') FROM DUAL;


-- case表达式
-- 功能：从上到下找到首个为真的when语句，返回对应的then语句
SELECT CASE
	WHEN FALSE THEN 'a'
	WHEN FALSE THEN 'b'
	WHEN TRUE THEN 'c'
	WHEN TRUE THEN 'd'
	ELSE 'e'
	END;

SELECT CASE
	WHEN FALSE THEN 'a'
	WHEN FALSE THEN 'b'
	WHEN FALSE THEN 'c'
	ELSE 'd'
	END;
	
	
-- 案例1：查询emp表，若comm列为null，则显示0.0
SELECT ename, comm, IFNULL(comm, 0.0) FROM emp;

SELECT ename, comm, IF(comm IS NULL, 0.0, comm) FROM emp;


-- 案例2：查询emp表，若job值为'CLERK'则显示'职员'；
--	若job值为'MANAGER'则显示'管理员'；
-- 	若job值为'SALESMAN'则显示'销售员'；
--	若job值为其它则显示原本的值；

SELECT ename, job, (SELECT CASE
		WHEN job='CLERK' THEN '职员'
		WHEN job='MANAGER' THEN '管理员'
		WHEN job='SALESMAN' THEN '销售员'
		ELSE job
		END) AS job_cn1
	FROM emp;
	
SELECT ename, job, IF(job='CLERK', '职员', IF(job='MANAGER', '管理员', IF(job='SALESMAN', '销售员', job))) AS job_cn2
	FROM emp;
	
	