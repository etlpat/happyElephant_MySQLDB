-- 一、声明完整性约束

DROP TABLE student;
DROP TABLE course;
DROP TABLE sc;

-- 1.创建基本表及约束
CREATE TABLE Student(   
	Sno CHAR(8) PRIMARY KEY,   
	Sname CHAR(8) NOT NULL,       
	Ssex CHAR(2) CHECK ( Ssex IN ('男','女')), 
	Sage SMALLINT, 
	Sdept CHAR(20), 
	Sclass CHAR(4) NOT NULL,  
	Stotal SMALLINT DEFAULT 0 
); 
DESC student;

CREATE TABLE Course (    
	Cno CHAR(4) PRIMARY KEY,  
	Cname CHAR(40),  
	Cpno CHAR(4),  
	Ccredit SMALLINT
);
DESC course;

CREATE TABLE SC(
	Sno  CHAR(8), 
	Cno  CHAR(4),   
	Grade SMALLINT CHECK(Grade >0 AND Grade<100),        
	PRIMARY KEY (Sno,Cno),
	FOREIGN KEY (Sno) REFERENCES Student(Sno),
	FOREIGN KEY (Cno) REFERENCES Course(Cno) 
);
DESC course;


-- 2.插入数据
INSERT INTO Student VALUES('20100001','李勇','男',20,'CS','1001',0);
INSERT INTO Student VALUES('20100002','刘晨','女',19,'CS','1001',0);
INSERT INTO student VALUES('20100021', '王敏', '女', 18, 'MA','1002',0),
	('20100031', '张立', '男', 19, 'IS','1003',0),
	('20100003', '刘洋', '女', NULL, NULL,'1001',0),
	('20100010', '赵斌', '男', 19, 'IS','1005',0),
	('20100022', '张明明', '男', 19, 'CS','1002',0);
SELECT * FROM student;

INSERT INTO Course(Cno,Cname,Cpno,Ccredit) VALUES('1','数据库系统原理', '5',4);
INSERT INTO Course(Cno,Cname,Cpno,Ccredit) VALUES('2','高等数学',  NULL,2);
INSERT INTO course VALUES('3','管理信息系统', '1',4),
	('4','操作系统原理', '6',3),
	('5','数据结构', '7',4),
	('6','数据处理', NULL,2),
	('7','C语言', NULL,4);
SELECT * FROM course;
	
INSERT INTO SC VALUES('20100001','1',92);
INSERT INTO SC VALUES('20100002','2',80);
INSERT INTO sc VALUES('20100001','2',85),
	('20100001','3',88),
	('20100002','1',90),
	('20100003','1',NULL),
	('20100010','3',NULL);
SELECT * FROM sc;


-- 3.修改约束
ALTER TABLE Course ADD UNIQUE(Cname);
ALTER TABLE Course ADD FOREIGN KEY (Cpno) REFERENCES  Course(Cno);
SHOW KEYS FROM course;

ALTER TABLE SC ADD CONSTRAINT SC_CHECK CHECK(Grade >=0 AND Grade<=100);
SHOW KEYS FROM sc;



-- 二、检查完整性约束
INSERT INTO Student VALUES('20100101','李斌','男',20,'CS','1001',0);
INSERT INTO Student VALUES('20100001','李斌','男',20,'CS','1001',0); -- 失败：主键具有唯一性
UPDATE Student SET Sno='20100021' WHERE Sname = '张立'; -- 失败，同上

INSERT INTO SC VALUES('20100001','1',78); -- 失败：主键具有唯一性
INSERT INTO SC VALUES('20100001',NULL,78); -- 失败：复合主键的字段都不能为空

INSERT INTO Course VALUES('8','JAVA',7, 3);
INSERT INTO Course VALUES('9','数据结构',7, 3);  -- 失败：unique具有唯一性

INSERT INTO Student(Sno,Sname,Ssex,Sclass) VALUES('20100102','张盛','男','1008'); -- 不输入数据，默认填充null
SELECT * FROM Student WHERE Sno='20100102';

INSERT INTO Student(Sno,Sname,Ssex,Sclass) VALUES('20100103','张盛','男',NULL); -- 失败：非空约束不能为null
INSERT INTO Student(Sno,Sname,Ssex) VALUES('20100104','张盛','男'); -- 失败：同上

INSERT INTO SC VALUES('20100301','1',95); -- 失败：从表的外键必须插入主表主键(unique)中存在的值
INSERT INTO SC VALUES('20100001','10',95); -- 失败：同上
UPDATE SC SET Cno = '10'  WHERE Cno='1'; -- 失败：同上
UPDATE Course SET Cno = '10'  WHERE Cno='3';  -- 失败：同上

DELETE Student WHERE Sno='20100021'; -- 失败：若主表的主键与从表的外键建立了关联关系，那么若想删除主表主键，必须先删除与之关联的全部外键，否则报错
DELETE Student WHERE Sno='20100001'; -- 失败：同上
UPDATE Course SET Cno = '10' WHERE Cname = '数据库系统原理'; -- 失败：同上