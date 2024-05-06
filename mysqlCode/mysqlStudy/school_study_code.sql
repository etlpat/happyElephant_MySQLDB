CREATE DATABASE school_db;
USE school_db;

DROP TABLE student;
DROP TABLE course;
DROP TABLE sc;


CREATE TABLE student( -- 学生表
	sno INT PRIMARY KEY, -- 学号
	sname VARCHAR(32), -- 姓名
	ssex VARCHAR(5), -- 性别
	sage INT, -- 年龄
	sdept VARCHAR(32) -- 所在专业
);
DESC student;

INSERT INTO student VALUES(200215121,'李勇','男',20,'CS'),
	(200215122,'刘辰','女',19,'CS'),
	(200215123,'王敏','女',18,'MA'),
	(200215125,'张立','男',19,'IS');
INSERT INTO student VALUES(200215128,'陈东','男',19,'IS'),
	(200215126,'张怀民','男',18,'CS');
SELECT * FROM student;


CREATE TABLE course( -- 课程表
	cno INT PRIMARY KEY AUTO_INCREMENT, -- 课程号
	cname VARCHAR(32) UNIQUE, -- 课程名
	cpno INT, -- 先修课
	ccredit INT -- 学分
);
DESC course;

INSERT INTO course VALUES(NULL, '数据库', 5, 4), -- 由于主键设置了AUTO_INCREMENT自增长，输入null默认从1开始递增
	(NULL, '数学', NULL, 2),
	(NULL, '信息系统', 1, 4),
	(NULL, '操作系统', 6, 3),
	(NULL, '数据结构', 7, 4),
	(NULL, '数据处理', NULL, 2),
	(NULL, 'java语言', 6, 4);
ALTER TABLE course ADD FOREIGN KEY (cpno) REFERENCES course(cno);	
SELECT * FROM course;

	
CREATE TABLE sc( -- 学生选课表
	sno INT, -- 学号
	cno INT, -- 课程号
	grade INT, -- 成绩
	PRIMARY KEY (sno, cno),
	FOREIGN KEY (sno) REFERENCES student(sno),
	FOREIGN KEY (cno) REFERENCES course(cno)
);
DESC sc;

INSERT INTO sc VALUES(200215121, 1, 92),
	(200215121, 2, 85),
	(200215121, 3, 88),
	(200215122, 2, 90),
	(200215122, 3, 80);
INSERT INTO sc VALUES(200215128, 1, NULL);
SELECT * FROM sc;



SHOW TABLES;
DESC student;
DESC course;
DESC sc;
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM sc;



-- 案例1：区分外连接与内连接
-- 左外连接：若右表数据与左表不匹配，则拿null填充
SELECT c1.*, c2.cname AS '先修课' 
	FROM course AS c1 LEFT JOIN course AS c2
	ON c1.cpno = c2.cno;

-- 内连接：只返回两表中匹配的数据
SELECT c1.*, c2.cname AS '先修课' 
	FROM course AS c1 INNER JOIN course AS c2
	ON c1.cpno = c2.cno;
	
-- 内连接：INNER JOIN 可简写为 JOIN
SELECT c1.*, c2.cname AS '先修课' 
	FROM course AS c1 JOIN course AS c2
	ON c1.cpno = c2.cno;
	


