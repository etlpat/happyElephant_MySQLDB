-- 1.主键约束
CREATE TABLE stu1(
	id INT PRIMARY KEY, -- 将id声明为主键
	`name` VARCHAR(32),
	sex VARCHAR(10)
);

DESC stu1;
INSERT INTO stu1
	VALUES(1,'jack','man'),(2,'bob','man'),(3,'kity','woman');

INSERT INTO stu1 VALUES(1,'jack','man'); -- 报错，主键不能重复	
INSERT INTO stu1 VALUES(NULL,'jack','man'); -- 报错，主键不能为空	
INSERT INTO stu1 VALUES(4,'kobe','man');	
	
SELECT * FROM stu1;


CREATE TABLE stu2(
	id INT PRIMARY KEY,
	`name` VARCHAR(32) PRIMARY KEY, -- 报错，列级定义主键，最多只能定义1列为主键
	sex VARCHAR(10)
);

CREATE TABLE stu2(
	id INT,
	`name` VARCHAR(32),
	sex VARCHAR(10),
	PRIMARY KEY(id) -- 表极定义主键
);
DESC stu2;


CREATE TABLE stu3(
	id INT,
	`name` VARCHAR(32),
	sex VARCHAR(10),
	primary key(id, `name`) -- 表极可以定义复合主键
);
desc stu3;
INSERT INTO stu3 VALUES(1,'jack','man');
INSERT INTO stu3 VALUES(2,'jack','man');
INSERT INTO stu3 VALUES(1,null,'man'); -- 报错



-- 2.not null 与 unique 约束
create table stu4(
	id int primary key,
	`name` varchar(32) not null default '',
	sex varchar(10) not null,
	email varchar(64) unique
);
desc stu4;
insert into stu4 values(1, 'tom', 'man', 'tom@dmail.com');
INSERT INTO stu4 VALUES(2, 'cat', 'woman', 'cat@dmail.com');
insert into stu4(id, sex) values(3,'man');
INSERT INTO stu4 VALUES(4,null, null, '123'); -- 报错：not null字段不能为空
INSERT INTO stu4 VALUES(4,'hury','man', 'tom@dmail.com'); -- 报错，unique字段不能重复
INSERT INTO stu4 VALUES(4,'hury','man', 'hury@dmail.com');
select * from stu4;



-- 3.外键约束
create table class( -- 创建主表
	Cno int primary key,
	Cname varchar(32)
);

create table stu5(
	id int primary key,
	`name` varchar(32),
	Cno int,
	foreign key (Cno) references class(Cno) -- 建立外键约束
);

insert into class values(1,'chinese'),(2,'math'),(3,'english');
insert into stu5 values(1, 'jack', 1);
INSERT INTO stu5 VALUES(2, 'mack', 2);
INSERT INTO stu5 VALUES(3, 'lucy', 3);
INSERT INTO stu5 VALUES(4, 'joe', 2);
INSERT INTO stu5 VALUES(5, 'alex', 1);

desc class;
desc stu5;
select * from class;
select * from stu5;

INSERT INTO stu5 VALUES(6, 'bob', 6); -- 报错：从表的外键只能添加主表主键中存在的值
delete from class where Cno = 1; -- 报错：不能删除已经和外键建立关联了的主键
INSERT INTO stu5 VALUES(7, 'hank', null); -- 外键可以为空



-- check约束
create table stu6(
	id int primary key,
	`name` varchar(32),
	age int check(age between 0 and 130),
	sex varchar(10) check(sex in ('男', '女'))
);
desc stu6;





-- 约束章节案例：创建商店售货系统表三张
create database shop_db;
use shou_db;

create table goods( -- 商品表
	Gid int primary key, -- 主键：商品编号
	Gname varchar(32),
	price double check (price between 0.1 and 9999.99),
	category varchar(32), -- 商品类别
	provider varchar(32) -- 供应商
);

create table customer( -- 顾客表
	Cid int primary key, -- 主键：顾客编号
	`name` varchar(32) not null default '',
	address varchar(32),
	email varchar(32) unique,
	sex varchar(5) check (sex in ('男', '女')),
	card_id int unique
);

create table purchase( -- 购买表
	order_id int primary key, -- 主键：订单号
	Gid int,
	Cid int,
	nums int,
	foreign key (Gid) references goods(Gid),
	FOREIGN KEY (Cid) REFERENCES customer(Cid)
);

desc goods;
desc customer;
desc purchase;





-- auto_increment 自增长
create table tmp(
	id int primary key auto_increment,
	`name` varchar(32) not null default ''
);
desc tmp;
select * from tmp;

insert into tmp values (null, '张三');
insert into tmp(name) values ('李四');
insert into tmp(name) values ('王五'), ('赵六'), ('孙七');



-- 修改自增长数的值
create table stu1(
	id int primary key auto_increment,
	`sname` varchar(32)
);

alter table stu1 auto_increment = 100; -- 通过alter修改

insert into stu1 values(null, '刘备');
INSERT INTO stu1 VALUES(NULL, '张飞');
INSERT INTO stu1 VALUES(NULL, '关羽');

select * from stu1;

insert into stu1 values(200, '赵云'); -- 通过赋新值修改
INSERT INTO stu1 VALUES(NULL, '吕蒙');
