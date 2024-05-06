USE db1;
SELECT * FROM student1;



-- 测试通过修改视图，实际修改的是基表数据
CREATE VIEW v1 AS (
	SELECT id, `name`, chinese + math + english AS grade
	FROM student1
	WHERE `id` = 20240001
);
DROP VIEW v1;


START TRANSACTION;
SAVEPOINT s1;

SELECT * FROM v1;
UPDATE v1 SET NAME = '007';
SELECT * FROM student1;

ROLLBACK TO s1;
COMMIT;





-- 测试复合主键的每一项字段均不能为空
CREATE TABLE stu7(
	id INT,
	class INT,
	`name` VARCHAR(32),
	PRIMARY KEY (id, class)
);

DESC stu7;
INSERT INTO stu7 VALUES (1, 1, 'jack');
INSERT INTO stu7 VALUES (1, 0, 'sam');
INSERT INTO stu7 VALUES (0, 1, 'smith');
INSERT INTO stu7 VALUES (NULL, 1, 'hank'); -- 注意：复合主键的每一项均不能为null
SELECT * FROM stu7;





-- 测试外键不一定引用主码，还可以引用unique字段
CREATE TABLE stu8(
	id INT PRIMARY KEY,
	`name` VARCHAR(32),
	email VARCHAR(64) UNIQUE
);

CREATE TABLE tmp4(
	tid INT PRIMARY KEY,
	email1 VARCHAR(64),
	email2 VARCHAR(64),
	FOREIGN KEY (email1) REFERENCES stu8(email), -- 外键可以为其它表的unique字段
	FOREIGN KEY (email2) REFERENCES stu8(email) -- 一个表可以有多个外键
);
DROP TABLE tmp4;
DESC tmp4;




		

SELECT sno AS `no`, sname
	FROM student
	-- where `no` BETWEEN 20100001 AND 20100003;
	GROUP BY `no`;
	
	
	
	
-- 案例：查询先修课为1的学生姓名
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM sc;

SELECT sname FROM student
	WHERE sno IN (
		SELECT DISTINCT sno FROM sc
		WHERE cno IN (SELECT cno
			FROM course
			WHERE cpno = 1));
		
			

-- 案例：查询选修全部课程的学生学号、姓名
SELECT tmp.sno, sname
	FROM student RIGHT JOIN (
		SELECT sno -- 返回选修了全部课程的学生学号
			FROM sc
			GROUP BY sno
			HAVING COUNT(cno) = (SELECT COUNT(*) FROM course) -- 将sc按照学号分组，当一个学生的选课数量=课程总数，则表示选修全部课程)
			) AS tmp
	ON student.sno = tmp.sno;



-- 案例：用内连接获取员工极其上司
USE db1;
SELECT emp.*, mgr_emp.ename AS '上司'
	FROM emp JOIN emp AS mgr_emp
	ON emp.mgr = mgr_emp.empno;
		
		