-- 1.显示所有部门名称
SELECT dname FROM dept;


-- 2.显示所有雇员名，以及年收入(月收入*12 + 分红)
SELECT ename, sal*12+IFNULL(comm, 0) AS year_sal FROM emp;


-- 3.显示工资低于2850的员工姓名、工资
SELECT ename, sal FROM emp WHERE sal < 2850;


-- 4.显示员工编号为7566的雇员名称、部门编号
SELECT ename, deptno FROM emp WHERE empno = 7566;


-- 5.显示部门号为10或30中，工资高于1500的员工
SELECT * FROM emp
	WHERE deptno IN (10, 30) AND sal >= 1500;
	

-- 6.显示无管理者的雇员
SELECT * FROM emp WHERE mgr IS NULL;


-- 7.显示在1991-2-1到1991-5-1日间入职的雇员，并按照入职日期排序
SELECT * FROM emp
	WHERE hiredate BETWEEN '1991-2-1' AND '1991-5-1'
	ORDER BY hiredate;


-- 8.显示获得补助的员工，并按照工资降序排序
SELECT * FROM emp
	WHERE comm IS NOT NULL
	ORDER BY sal DESC;


-- 9.找出部门10中的所有MANAGER、部门20中的所有CLERK、除了这两种job的薪水>=2000的员工信息
SELECT *
	FROM emp
	WHERE (deptno = 10 AND job = 'MANAGER') OR
		(deptno = 20 AND job = 'CLERK') OR
		(job NOT IN ('MANAGER', 'CLERK') AND sal >= 2000);

		
-- 9.找出收取佣金的员工的不同工作
SELECT DISTINCT job FROM emp
	WHERE comm IS NOT NULL;


-- 10.找出不受佣金或者佣金低于100的员工
SELECT * FROM emp
	WHERE comm IS NULL OR 
	(comm IS NOT NULL AND comm < 100);
	

-- 11.找出各月倒数第三天受雇的员工
SELECT * FROM emp
	WHERE DAY(DATE_ADD(hiredate, INTERVAL 3 DAY)) = '1';
	
	
-- 12.找出早于12年前受雇的员工
SELECT * FROM emp
	WHERE hiredate < DATE_SUB(NOW(), INTERVAL 12 YEAR);
	

-- 13.以首字母小写的方式显示员工姓名
SELECT CONCAT(LCASE(SUBSTRING(ename, 1, 1)), SUBSTRING(ename, 2))
	FROM emp;


-- 14.显示5个字符的员工姓名
SELECT ename FROM emp
	WHERE CHAR_LENGTH(ename) = 5;
	
	
-- 15.显示不带R字母的名字	
SELECT ename FROM emp
	WHERE INSTR(ename, 'R') = 0;
	

-- 16.显示所有员工姓名的前三个字符
SELECT SUBSTRING(ename, 1, 3) FROM emp;


-- 17.将所有员工姓名中的'A'替换为'a'
SELECT REPLACE(ename, 'A', 'a') FROM emp;


-- 18.显示满33年工作的员工姓名、工作日期
SELECT ename, hiredate FROM emp
	WHERE DATE_ADD(hiredate, INTERVAL 33 YEAR) < NOW();
	
	
-- 19.先按工作降序，后按薪水升序排序
SELECT ename, job, sal FROM emp
	ORDER BY job DESC, sal ASC;
	
	
-- 20.先按受雇月份升序排序，后按受雇年份升序排序
SELECT ename, hiredate FROM emp
	ORDER BY MONTH(hiredate), YEAR(hiredate);
	

-- 21.找出2月受聘的员工
SELECT * FROM emp
	WHERE MONTH(hiredate) = '2';
	
	
-- 22.以年月日的形式显示所有员工的工作年限
SELECT ename, CONCAT(FLOOR(DATEDIFF(NOW(), hiredate)/365), '-', FLOOR(DATEDIFF(NOW(), hiredate)%365/30), '-', DATEDIFF(NOW(), hiredate)%365%30)
	FROM emp;	
	

-- 23.写出至少有1个员工的部门
SELECT dname, tmp.deptno, emp_num
	FROM (SELECT deptno, COUNT(*) AS emp_num
		FROM emp
		GROUP BY deptno
		HAVING emp_num >= 1
	) AS tmp LEFT JOIN dept
	ON tmp.deptno = dept.deptno;
	
	
-- 24.列出薪水比SMITH多的员工
SELECT * FROM emp
	WHERE sal > (
		SELECT sal 
		FROM emp
		WHERE ename = 'SMITH'	
	);


-- 25.列出受雇日期晚于上级的所有员工
SELECT *
	FROM (SELECT emp.ename, emp.hiredate, 
			mgr_emp.ename AS mgr_ename, 
			mgr_emp.hiredate AS mgr_hiredate
		FROM emp LEFT JOIN emp AS mgr_emp
		ON emp.mgr = mgr_emp.empno) AS tmp
	WHERE hiredate > mgr_hiredate;
	
	
-- 26.列出部门名以及员工信息，同时列出没有员工的部门
SELECT dept.deptno, dname, ename, empno, job
	FROM dept LEFT JOIN emp
	ON dept.deptno = emp.deptno
	ORDER BY dept.deptno;
	
	
-- 27.列出所有job为CLERK的姓名和部门名称
SELECT ename, dname
	FROM (SELECT * 
		FROM emp
		WHERE job = 'CLERK'
	) AS tmp LEFT JOIN dept
	ON tmp.deptno = dept.deptno; 


-- 28.列出最低薪金高于1500的各种工作
SELECT job, MIN(sal) AS min_sal
	FROM emp
	GROUP BY job
	HAVING min_sal > 1500;


-- 29.列出部门为SALES的所有员工
SELECT * FROM emp
	WHERE deptno = (SELECT deptno
		FROM dept
		WHERE dname = 'SALES');


-- 30.列出薪水高于公司平均薪水的所有员工
SELECT * FROM emp
	WHERE sal > (SELECT AVG(sal) FROM emp);
	
	
-- 31.列出薪水高于部门30所有员工的职员信息
SELECT * FROM emp
	WHERE sal > ALL(SELECT sal 
		FROM emp 
		WHERE deptno = 30);
		

-- 32.列出每个部门工作的员工数量、平均工资、平均服务期限
SELECT deptno, COUNT(*) AS emp_num,
		FORMAT(AVG(sal), 3) AS avg_sal,
		FLOOR(AVG(DATEDIFF(NOW(), hiredate))) AS '工作天数'
	FROM emp
	GROUP BY deptno;
	

-- 33.列出所有部门信息和部门人数
SELECT dept.*, tmp.emp_num
	FROM dept LEFT JOIN (
		SELECT deptno, COUNT(*) AS emp_num
		FROM emp
		GROUP BY deptno) AS tmp
	ON dept.deptno = tmp.deptno;
	


-- 34.创建表
USE test_db;

CREATE TABLE department(
	departmentid INT PRIMARY KEY,
	deptname VARCHAR(32) UNIQUE
);

CREATE TABLE class(
	classid INT PRIMARY KEY,
	`subject` VARCHAR(32),
	deptname VARCHAR(32),
	enrolltime DATETIME,
	num INT,
	FOREIGN KEY (deptname) REFERENCES department(deptname)
	
);

CREATE TABLE student(
	studentid INT PRIMARY KEY,
	`name` VARCHAR(32) NOT NULL DEFAULT '',
	age INT,
	classid INT,
	FOREIGN KEY (classid) REFERENCES class(classid)
);

DESC department;
DESC class;
DESC student;
