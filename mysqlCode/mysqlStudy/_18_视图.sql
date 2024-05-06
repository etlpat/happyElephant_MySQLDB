USE db1;
START TRANSACTION;


-- 创建视图
CREATE VIEW v1 AS (
	SELECT empno, `ename`, job, deptno 
	FROM emp
	);

	
-- 修改视图
ALTER VIEW v1 AS (
	SELECT empno, `ename`, job
	FROM emp
);


-- 删除视图
DROP VIEW v1;


SELECT * FROM v1;



-- 视图上也可以再创建视图
CREATE VIEW v2 AS (SELECT empno, ename FROM v1);
SELECT * FROM v2;
DROP VIEW v2;


COMMIT;


-- 案例：针对表emp、dept、salgrade三张表，创建一个视图
-- 	该视图要求显示：雇员编号、雇员名、雇员部门、薪水级别

-- 法1：外连接法
CREATE VIEW eds_view1 AS (
	SELECT empno, ename, dname, grade
	FROM salgrade RIGHT JOIN (
		SELECT empno, ename, sal, dname
		FROM emp LEFT JOIN dept
		ON emp.deptno = dept.deptno) AS tmp
	ON tmp.sal BETWEEN losal AND hisal
);

SELECT * FROM eds_view1;


-- 法2：笛卡尔积法
CREATE VIEW eds_view2 AS (
	SELECT empno, ename, dname, grade
	FROM salgrade, (
		SELECT empno, ename, sal, dname
		FROM emp, dept
		WHERE emp.deptno = dept.deptno) AS tmp
	WHERE tmp.sal BETWEEN losal AND hisal
);

SELECT * FROM eds_view2;


