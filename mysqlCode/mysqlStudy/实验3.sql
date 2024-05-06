USE test_db;

-- 使用SQL创建用户并授权

-- 1.创建数据库用户
CREATE USER '王明'@'localhost' IDENTIFIED BY '123456';
CREATE USER '李刚'@'localhost' IDENTIFIED BY '123456';
SELECT * FROM mysql.user;


-- 2.授予用户权限
SHOW GRANTS FOR '王明'@'localhost'; -- 检查王明权限

GRANT SELECT -- 为王明添加权限
	ON test_db.Student 
	TO '王明'@'localhost';
	
SHOW GRANTS FOR '王明'@'localhost';


SHOW GRANTS FOR '李刚'@'localhost'; -- 检查李刚权限

GRANT INSERT,UPDATE,DELETE,SELECT -- 为李刚增加权限
	ON test_db.Student 
	TO '李刚'@'localhost'; 
	
SHOW GRANTS FOR '李刚'@'localhost';

GRANT INSERT,UPDATE,DELETE,SELECT
	ON test_db.sc
	TO '李刚'@'localhost'; 

SHOW GRANTS FOR '李刚'@'localhost';
	

-- 3.回收用户权限
REVOKE SELECT -- 回收王明权限
	ON test_db.Student 
	FROM '王明'@'localhost';
	
SHOW GRANTS FOR '王明'@'localhost';


REVOKE INSERT,UPDATE,DELETE,SELECT -- 回收李刚权限
	ON test_db.Student 
	FROM '李刚'@'localhost'; 
REVOKE INSERT,UPDATE,DELETE,SELECT
	ON test_db.sc 
	FROM '李刚'@'localhost'; 

SHOW GRANTS FOR '李刚'@'localhost';


-- 删除用户
DROP USER '王明'@'localhost';
DROP USER '李刚'@'localhost';
SELECT * FROM mysql.user;