USE test_db;

DROP TABLE student;
DROP TABLE course;
DROP TABLE sc;
DROP TABLE tmp;
DROP VIEW IS_Student;
DROP VIEW Student_VIEW;
DROP VIEW S_G;
DROP VIEW XK_VIEW;


-- 一、数据定义

-- 1，创建、修改、删除表
-- 创建如下：
CREATE TABLE Student(
	Sno CHAR(8) PRIMARY KEY,   
	Sname CHAR(8),       
	Ssex CHAR(2) NOT NULL, 
	Sage INT, 
	Sdept CHAR(20)      
); 
DESC Student;

CREATE TABLE Course(
	Cno CHAR(4) PRIMARY KEY,  
	Cname CHAR(40) NOT NULL, 
	Cpno CHAR(4),    
	Ccredit SMALLINT
);
DESC Course;

CREATE TABLE  SC(
	Sno CHAR(8),
	Cno CHAR(4),   
	Grade SMALLINT,
	FOREIGN KEY (Sno) REFERENCES Student(Sno)  
); 
DESC SC;

CREATE TABLE tmp(
	id INT
);

-- 修改如下：
ALTER TABLE Student ADD Sclass CHAR(4);
ALTER TABLE Student MODIFY Sage SMALLINT;
DESC Student;

ALTER TABLE Course ADD UNIQUE(Cname);
DESC Course;

-- 删除如下：
DROP TABLE tmp;
DESC tmp;

-- 2.创建引索
CREATE INDEX iCname ON Course(Cname);
CREATE UNIQUE INDEX iCpno ON Course(Cpno);
SHOW INDEX FROM Course;

CREATE UNIQUE INDEX iSname ON Student(Sname);
SHOW INDEX FROM Student;


-- 3.创建视图
CREATE VIEW IS_Student 
	AS ( SELECT Sno,Sname,Sage
		FROM  Student 
		WHERE  Sdept= 'IS');
DESC IS_Student;	



-- 二、数据操作

-- 1.插入数据
INSERT INTO Student VALUES('20100001','李勇','男',20,'CS','1001');
INSERT INTO Student VALUES('20100002','刘晨','女',19,'CS','1001'); 
INSERT INTO Student(Sno,Sname,Ssex,Sage,Sdept,Sclass) VALUES('20100021','王敏','女',18,'MA','1002'); 
INSERT INTO Student(Sno,Sname,Ssex,Sage,Sdept,sclass) VALUES('20100031','张立','男',19,'IS','1003'); 
INSERT INTO Student(Sno,Sname,Ssex,sclass) VALUES('20100003','刘洋','女','1001');
INSERT INTO Student(Sno,Sname,Ssex,Sage,Sdept,sclass) VALUES('20100010','赵斌','男','19','IS','1005');
INSERT INTO Student VALUES('20100022','张明明','男',19,'CS','1002');
SELECT * FROM Student;

INSERT INTO Course(Cno,Cname,Cpno,Ccredit) VALUES('1','数据库系统原理', '5',4); 
INSERT INTO Course(Cno,Cname,Cpno,Ccredit) VALUES('2','高等数学',  NULL,2);
INSERT INTO Course(Cno,Cname,Cpno,Ccredit) VALUES('3','管理信息系统','1',4);
INSERT INTO Course VALUES('4', '操作系统原理', '6', 3),
	('5', '数据结构', '7', 4),
	('6', '数据处理', NULL, 2),
	('7', 'C语言', NULL, 4);
SELECT * FROM Course;

INSERT INTO SC VALUES('20100001','1',92); 
INSERT INTO SC VALUES('20100002','2',80);
INSERT INTO SC(Sno,Cno) VALUES('20100003','1');
INSERT INTO SC(Sno,Cno,Grade) VALUES('20100010','3',NULL); 
INSERT INTO SC VALUES('20100001','2',85), 
	('20100001','3',88),
	('20100001','1',90);
SELECT * FROM SC;


-- 2.修改数据
UPDATE student SET Sage = 22 WHERE Sno='20100001';
UPDATE Student SET Sage = Sage + 1;
UPDATE student SET sno = '20100025' 
	WHERE sno = '20100021';
SELECT * FROM student;

UPDATE SC SET Grade = 85 
	WHERE Sno='20100010' AND Cno='3';
UPDATE sc SET Grade=Grade + 5 
	WHERE 'CS'=(SELECT Sdept FROM student WHERE student.Sno=sc.Sno); 
UPDATE sc SET Grade = 80
	WHERE Sno = (
		SELECT Sno FROM student
		WHERE sname = '刘晨'
	) AND cno = 2;
SELECT * FROM sc;


-- 3.删除数据
DELETE FROM Student WHERE Sno='20100022';

CREATE TABLE tmpSC LIKE sc;
INSERT INTO tmpSC (SELECT * FROM sc);
DELETE FROM tmpSC WHERE Sno='20100001' AND Cno='1';
DELETE FROM tmpSC WHERE Sno='20100002';
DELETE FROM tmpSC WHERE 'CS'=(SELECT Sdept FROM student WHERE student.Sno=tmpSC.Sno );
DELETE FROM tmpSC;
SELECT * FROM tmpSC;

DROP TABLE tmpSC;



-- 三、数据查询
-- 1.单表查询
SELECT * FROM  Student;
SELECT Sno,Sname,Sage FROM Student;
SELECT Sname,'Year of Birth: ',
	2004-Sage,LOWER(Sdept)  
	FROM Student;
SELECT Sname, 'Year of Birth:' AS BIRTH, 
	2000-Sage AS BIRTHDAY, 
	LCASE(Sdept) AS DEPARTMENT  
	FROM Student;
SELECT DISTINCT Sno FROM SC; 
SELECT Sname FROM Student  WHERE Sdept='CS';
SELECT Sname FROM Student  WHERE Sdept='CS';
SELECT Sname,Sdept,Sage  FROM Student WHERE Sage BETWEEN 20 AND 23;
SELECT Sname,Ssex FROM Student WHERE Sdept IN ('IS','MA','CS'); 
SELECT Sname,Sno,Ssex  FROM Student  WHERE  Sname LIKE '刘%';
SELECT Sno,Cno FROM sc WHERE Grade IS NULL; 
SELECT Sname FROM student WHERE Sdept='CS' AND Sage<20; 
SELECT * FROM  Student  ORDER BY Sdept,Sage DESC;

SELECT sno AS '编号', sname AS '姓名', -- 解题如下：
	ssex AS '性别', sage AS '年龄',
	sdept AS '专业', sclass AS '班级'
	FROM student; 

SELECT sno, sname FROM student
	WHERE sage > 23;
	
SELECT sno, sname, sage FROM student
	WHERE sage IN (17,18,20,23);
	
SELECT sname, sdept, sage FROM student
	WHERE sage NOT BETWEEN 21 AND 24;
	
	
-- 2.分组查询
SELECT COUNT(*) FROM  Student;
SELECT COUNT(DISTINCT Sno) FROM SC;
SELECT MAX(Grade) FROM SC;
SELECT SUM(grade) AS '总分',AVG(grade) AS '均分',MAX(grade) AS '最高分' 
	FROM sc WHERE Cno='2';
SELECT cno AS '课程号',COUNT(*) AS '人数',
	AVG(grade) AS '均分',MAX(grade) AS '最高分'
	FROM sc GROUP BY Cno;
SELECT cno AS '课程号',COUNT(*) AS '人数',
	AVG(grade) AS '均分',MAX(grade) AS '最高分'
	FROM sc GROUP BY Cno 
	HAVING AVG(grade) > 90;

SELECT sno, COUNT(*), AVG(grade), MAX(grade) -- 解题如下:
	FROM sc GROUP BY sno;

SELECT sclass, cno, COUNT(*), AVG(grade), MAX(grade)
	FROM (SELECT sclass, cno, grade
		FROM student JOIN sc
		ON student.sno = sc.sno) AS tmp
	GROUP BY sclass, cno;
	
	
-- 3.连接查询
SELECT  Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade 
	FROM  Student,SC 
	WHERE  Student.Sno = SC.Sno;
SELECT * 
	FROM course FIRST,course SECOND  
	WHERE first.Cpno=second.Cno; 
SELECT first.Cno,second.Cpno  
	FROM course FIRST,course SECOND  
	WHERE first.Cpno=second.Cno; 
SELECT Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade 
	FROM Student JOIN SC 
	ON (Student.Sno=SC.Sno);
SELECT Student.Sno,Sname,Ssex,Sage,Sdept,Cno,Grade 
	FROM  Student LEFT OUTER JOIN SC 
	ON (Student.Sno=SC.Sno);
SELECT Student.Sno, Sname 
	FROM Student JOIN SC 
	ON (Student.Sno = SC.Sno)
	WHERE SC.Cno= '2' AND SC.Grade > 90;
SELECT Student.Sno,Sname,Cname,Grade 
	FROM  Student,SC,Course  
	WHERE Student.Sno = SC.Sno AND
		SC.Cno = Course.Cno;

SELECT sc.sno, sname -- 解题如下：
	FROM student JOIN sc
	ON student.sno = sc.sno 
		AND cno = 2;
		
SELECT sc.cno, cname, sno
	FROM course JOIN sc
	ON course.cno = sc.cno;
	
SELECT sno, sname, grade 
	FROM course JOIN (
		SELECT sc.sno, cno, sname, grade 
		FROM student JOIN sc
		ON student.sno = sc.sno) AS tmp
	ON course.cno = tmp.cno 
		AND cname = '数据库系统原理';
		
		
-- 4.嵌套查询
SELECT Sno,Sname,Sdept FROM Student 
	WHERE Sdept IN ( SELECT Sdept FROM Student WHERE Sname= '刘晨'); 
SELECT Sno, Cno  FROM  SC  X 
	WHERE Grade >= ( SELECT AVG(Grade)  FROM  SC Y 
	WHERE y.Sno=x.Sno);
SELECT Sname,Sage  FROM Student 
	WHERE Sage < ALL ( SELECT Sage FROM Student WHERE Sdept= 'CS')    
	AND  Sdept <> 'CS' ;
SELECT Sname  FROM Student 
	WHERE EXISTS (SELECT * FROM SC WHERE Sno=Student.Sno AND Cno= '1');
	
	
-- 5.集合查询
SELECT *  FROM Student WHERE Sdept= 'CS' 
	UNION SELECT *  FROM Student  WHERE Sage<=19;



-- 四.视图操作

-- 1.创建视图
CREATE  VIEW Student_VIEW
	AS ( SELECT Sno,Sname,Ssex,Sage,Sdept,Sclass 
		FROM  Student);
SELECT * FROM  Student_VIEW;	
	
CREATE VIEW S_G(Sno,Gavg)  
	AS ( SELECT Sno,AVG(Grade)  
		FROM SC GROUP BY Sno);
SELECT * FROM S_G;
	
CREATE VIEW XK_VIEW 
	AS ( SELECT Student.*,Course.*,Grade 
		FROM  Student,SC,Course  
		WHERE Student.Sno = SC.Sno  AND 
			SC.Cno = Course.Cno);
SELECT Sno,Sname,Cname,Grade
	FROM XK_VIEW;