USE db1;

-- 查找用户信息
SELECT * FROM mysql.user;
SELECT `host`,`user`,`authentication_string` FROM mysql.user;


-- 创建用户
CREATE USER '张三'@'localhost' IDENTIFIED BY '123456';
CREATE USER '李四'@'localhost' IDENTIFIED BY '123456';
SELECT * FROM mysql.user;


-- 修改用户密码
SET PASSWORD FOR '李四'@'localhost' = PASSWORD('123456');


-- 删除用户
DROP USER '李四'@'localhost';
SELECT * FROM mysql.user;


-- 查看用户权限
SHOW GRANTS FOR '张三'@'localhost';


-- 为用户授权
GRANT SELECT ON db1.* TO '张三'@'localhost';
SHOW GRANTS FOR '张三'@'localhost';

GRANT SELECT,INSERT,DELETE,UPDATE ON test_db.* TO '张三'@'localhost';
SHOW GRANTS FOR '张三'@'localhost';


-- 撤销用户权限
REVOKE INSERT,DELETE,UPDATE ON test_db.* FROM '张三'@'localhost';
SHOW GRANTS FOR '张三'@'localhost';




-- 课堂案例
-- 创建用户
CREATE USER '李四'@'localhost' IDENTIFIED BY '123456';
SELECT * FROM mysql.user;

-- 设置权限
GRANT SELECT,INSERT 
	ON db1.*
	TO '李四'@'localhost';
GRANT SELECT, DELETE, UPDATE
	ON test_db.*
	TO '李四'@'localhost';
SHOW GRANTS FOR '李四'@'localhost';

-- 修改密码
SET PASSWORD FOR '李四'@'localhost' = PASSWORD('abcdef');

-- 撤销权限
REVOKE INSERT, DELETE, UPDATE
	ON db1.*
	FROM '李四'@'localhost';
REVOKE INSERT, DELETE, UPDATE
	ON test_db.*
	FROM '李四'@'localhost';
SHOW GRANTS FOR '李四'@'localhost';

-- 删除用户
DROP USER '李四'@'localhost';
SELECT * FROM mysql.user;