DROP DATABASE db1;
CREATE DATABASE db1;
USE db1;


-- 创建学生信息表
CREATE TABLE student(
	`id` INT,
	`name` VARCHAR(20),
	`phone_number` CHAR(13),
	`birthday` DATETIME
);

INSERT INTO student VALUES(114514, '李田所', '1145141919810', '1997-06-18 13:28:00');
INSERT INTO student VALUES(233333, '张三', '18659871568', '2000-12-24 00:00:00');

SELECT * FROM student;


-- 测试时间戳类型
CREATE TABLE t1(
	id INT,
	`time_stamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO t1(id) VALUES(1);
select * from t1;

insert into t1(id) values(3);
select * from t1;



-- 练习：创建员工表
create table employee(
	id int,
	`name` varchar(20),
	sex varchar(10),
	birthday date,
	entry_date date,
	job varchar(255),
	salary double,
	`resume` text
) charset utf8 collate utf8_bin;

insert into employee values(123,'张三','男','1999-6-14',
	'2023-12-5','会计','5555.55','你好，我是张三');
INSERT INTO employee VALUES(456,'李四','女','1994-10-15',
	'2023-12-5','会计','5555.55','大家好，我是李四');

select * from employee;
drop table employee; 