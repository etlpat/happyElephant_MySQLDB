-- 案例：列出部门名称和员工信息，同时列出那些没有员工的部门
-- ①左外连接实现
SELECT dept.deptno, dname, empno, ename, job
	FROM dept LEFT JOIN emp
	ON dept.deptno = emp.deptno
	ORDER BY dept.deptno;
	
-- ②右外连接实现
SELECT dept.deptno, dname, empno, ename, job
	FROM emp RIGHT JOIN dept
	ON dept.deptno = emp.deptno
	ORDER BY dept.deptno;	

