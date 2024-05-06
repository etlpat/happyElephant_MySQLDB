CREATE DATABASE test_db;
USE test_db;
CREATE TABLE stu(
	id INT,
	`name` VARCHAR(32),
	email VARCHAR(32)
);


-- (1)添加普通引索
-- 方法1：利用CREATE语句添加
CREATE TABLE stu1 LIKE stu; 
CREATE INDEX index_name ON stu1(`name`);
CREATE INDEX index_id ON stu1(id);
SHOW INDEX FROM stu1;

-- 方法2：利用ALTER语句添加
CREATE TABLE stu2 LIKE stu;
ALTER TABLE stu2 ADD INDEX index_name(`name`);
ALTER TABLE stu2 ADD INDEX index_id(id);
SHOW INDEX FROM stu2;



-- (2)添加主键引索
-- 方法1：在创建表时添加主键约束
CREATE TABLE stu3(
	id INT PRIMARY KEY,
	`name` VARCHAR(32),
	email VARCHAR(32)
);
DESC stu3;
SHOW INDEX FROM stu3;

-- 方法2：利用ALTER添加主键约束
CREATE TABLE stu4 LIKE stu;
ALTER TABLE stu4 ADD PRIMARY KEY (id);
DESC stu4;
SHOW INDEX FROM stu4;



-- (3)添加唯一引索
-- 方法1：在创建表时添加唯一约束
CREATE TABLE stu5(
	id INT,
	`name` VARCHAR(32),
	email VARCHAR(32) UNIQUE
);
DESC stu5;
SHOW INDEX FROM stu5;

-- 方法2：利用CREATE关键字创建唯一引索
CREATE TABLE stu6 LIKE stu;
CREATE UNIQUE INDEX index_email ON stu6(email);
DESC stu6;
SHOW INDEX FROM stu6;

-- 方法3：利用ALTER关键字添加唯一约束
CREATE TABLE stu7 LIKE stu;
ALTER TABLE stu7 ADD UNIQUE (email);
DESC stu7;
SHOW INDEX FROM stu7;



-- 创建索引测试案例
CREATE TABLE tmp (
	id INT,
	`name` VARCHAR(32),
	sex VARCHAR(10),
	address1 VARCHAR(32),
	address2 VARCHAR(32),
	address3 VARCHAR(32),
	phone CHAR(13),
	email VARCHAR(32)
);
DESC tmp;
SHOW INDEX FROM tmp;

ALTER TABLE tmp ADD PRIMARY KEY (id);
ALTER TABLE tmp ADD UNIQUE (`name`);
ALTER TABLE tmp ADD UNIQUE phone_index(phone);
CREATE UNIQUE INDEX email_index ON tmp(email);
CREATE INDEX address1_index ON tmp(address1);
ALTER TABLE tmp ADD INDEX address2_index(address2);

DROP TABLE tmp;



-- 删除主键索引
CREATE TABLE tmp1 LIKE tmp;
ALTER TABLE tmp1 DROP PRIMARY KEY;
DESC tmp1;
SHOW INDEX FROM tmp1;


-- 删除唯一索引（方法和删除普通索引相同）
CREATE TABLE tmp2 LIKE tmp;
ALTER TABLE tmp2 DROP INDEX `name`;
DROP INDEX phone_index ON tmp2;
DROP INDEX email_index ON tmp2;
DESC tmp2;
SHOW INDEX FROM tmp2;


-- 删除普通索引
CREATE TABLE tmp3 LIKE tmp;
ALTER TABLE tmp3 DROP INDEX address1_index;
DROP INDEX address2_index ON tmp3;
DESC tmp3;
SHOW INDEX FROM tmp3;



-- 显示索引的几种单独
SHOW INDEX FROM tmp;
SHOW INDEXES FROM tmp;
SHOW KEYS FROM tmp;
DESC tmp;



-- 综合案例
CREATE TABLE menu(
	id INT,
	`name` VARCHAR(16),
	chef VARCHAR(16),
	customer VARCHAR(16),
	price DOUBLE
);

ALTER TABLE menu ADD PRIMARY KEY (id);
ALTER TABLE menu ADD UNIQUE (chef);
CREATE UNIQUE INDEX customer_index ON menu(customer);
ALTER TABLE menu ADD INDEX name_index(`name`);
CREATE INDEX price_index ON menu(price);
SHOW INDEX FROM menu;

