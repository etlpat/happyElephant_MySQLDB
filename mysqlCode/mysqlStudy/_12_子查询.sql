-- 基本子查询
-- 案例：显示与SMITH同一部门的所有员工
SELECT * FROM emp
	WHERE deptno = ( -- 返回单个值的子查询
		SELECT deptno
		FROM emp
		WHERE ename = 'SMITH'
	);


-- 案例：查询和部门编号为10的部门员工具有相同job的其它部门的员工	
SELECT * FROM emp
	WHERE job IN ( -- 返回一列值的子查询
		SELECT DISTINCT job
		FROM emp
		WHERE deptno = 10
	) AND deptno != 10;
	
	
-- 案例：查询各个job中工资最高的员工
-- 法1：子查询返回表，用于FROM语句笛卡尔即
SELECT ename, emp.job, sal
	FROM emp, (
		SELECT job, MAX(sal) AS max_sal
		FROM emp
		GROUP BY job	
	) AS msj
	WHERE emp.job = msj.job AND emp.sal = msj.max_sal;

-- 法2：子查询返回表，用于WHERE过滤
SELECT ename, job, sal
	FROM emp
	WHERE (job, sal) IN (
		SELECT job, MAX(sal)
		FROM emp
		GROUP BY job
	);


-- 案例：显示比部门号为30的所有员工sal都高的其余员工数据
-- 法1：max语句
SELECT * FROM emp
	WHERE sal > (
		SELECT MAX(sal)
		FROM emp
		WHERE deptno = 30	
	);

-- 法2：all操作符
SELECT * FROM emp
	WHERE sal > ALL(
		SELECT sal
		FROM emp
		WHERE deptno = 30	
	);
	
-- 案例：显示比部门和为30的任意一个员工工资高的其余员工数据
SELECT * FROM emp
	WHERE sal > ANY(
		SELECT sal
		FROM emp
		WHERE deptno = 30
	);
	
	
-- 案例：返回一行值的子查询
-- 案例：查询与ALLEN部门、岗位完全相同的所有雇员
SELECT * FROM emp
	WHERE (deptno, job) = (
		SELECT deptno, job
		FROM emp
		WHERE ename = 'ALLEN'	
	);
	

-- 案例：查找每个部门工资高于本部门平均工资的人的资料
SELECT *
	FROM emp, (
		SELECT deptno, AVG(sal) AS avg_sal
			FROM emp
			GROUP BY deptno
		) AS dept_avg_sal
	WHERE emp.deptno = dept_avg_sal.deptno AND
		emp.sal > dept_avg_sal.avg_sal;
		

-- 案例：查找每个部门工资最高人的资料
-- 法1：子查询返回表，用于from笛卡尔积
SELECT *
	FROM emp, (
		SELECT deptno, MAX(sal) AS max_sal
		FROM emp
		GROUP BY deptno
	) AS tmp
	WHERE emp.deptno = tmp.deptno AND
		emp.sal = tmp.max_sal;

-- 法2：子查询返回表，用于where语句过滤
SELECT *
	FROM emp
	WHERE (deptno, sal) IN (
		SELECT deptno, MAX(sal)
		FROM emp
		GROUP BY deptno	
	);


-- 案例：显示每个部门的部门名、部门编号、地址、人员数量
-- 注意：表名.* 可以直接将子表中的全部内容都打印出来
SELECT dept.*, emp_num
	FROM dept, (
		SELECT deptno, COUNT(*) AS emp_num
		FROM emp
		GROUP BY deptno
	) AS tmp
	WHERE dept.deptno = tmp.deptno;
	

-- 案例：列出部门的名称和员工的名称和工作，并显示出没有员工的部门
SELECT dname, ename, job
	FROM emp, dept
	WHERE emp.deptno = dept.deptno
	ORDER BY dname;

SELECT *
	FROM dept LEFT JOIN emp
	ON dept.deptno = emp.deptno
	ORDER BY dept.deptno;

