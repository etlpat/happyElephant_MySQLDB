SELECT * FROM emp;
SELECT * FROM dept1
SELECT * FROM salgrade;



-- 1.基础select练习
SELECT * FROM emp
	WHERE hiredate >= '1991-05-01'
	ORDER BY hiredate ASC;
	
SELECT ename, sal 
	FROM emp
	WHERE ename LIKE 'S%' OR ename LIKE '%S';
	
SELECT * FROM emp
	WHERE mgr IS NULL;
	
SELECT * FROM emp
	ORDER BY deptno ASC, sal DESC; -- 先按deptno排序，之后在deptno值相同的组中再按sal排序
	
	
	
-- 2.分页查找语句
SELECT * FROM emp
	LIMIT 0, 5;
	
SELECT * FROM emp
	LIMIT 5, 5;
	
-- 案例：按照雇员的empno号降序取出，每页5条记录，分别显示第3、5页的内容
SELECT * FROM emp
	ORDER BY empno DESC
	LIMIT 10, 5;
	
SELECT * FROM emp
	ORDER BY empno DESC
	LIMIT 20, 5;
	
-- 案例：统计各行业的平均工资，若大于1300则将其降序排列，取出前3行记录
SELECT job, AVG(sal) AS avg_sal
	FROM emp
	GROUP BY job
	HAVING avg_sal > 1300
	ORDER BY avg_sal DESC
	LIMIT 0, 3;
	
	
	
-- 3.多表查询语句
-- （1）多表连接
SELECT * FROM emp, dept; -- 基本格式：返回emp表和dept表元素的笛卡尔积

SELECT ename, sal, dept.deptno, dname -- 当两表存在相同列名时，必须用【表名.列名】加以区分，否则报错
	FROM emp, dept
	WHERE emp.deptno = dept.deptno;

	
-- 案例：显示部门号为10的部门名、员工名、工资
select dname, ename, sal
	from emp, dept
	where emp.deptno = 10 and dept.deptno = 10;


-- 案例：显示各员工的姓名、工资、工资级别
select ename, sal, grade
	from emp, salgrade
	where sal >= losal and sal <= hisal;
	
	
-- （2）自连接
-- 案例：显示各员工的姓名与其上级管理员的姓名
select worker.ename as '员工名', manager.ename as '上级名'
	from emp as worker, emp as manager
	where worker.mgr = manager.empno;
	
select eee.ename as hhh, eee.sal
	from emp as eee
	where eee.ename = 'FORD';