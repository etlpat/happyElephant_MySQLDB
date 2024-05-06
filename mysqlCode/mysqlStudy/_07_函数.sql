USE db1;
DROP TABLE student2;

CREATE TABLE student2(
	id INT,
	`name` VARCHAR(24),
	chinese INT,
	math INT,
	english INT
);
DESC student2;

DELETE FROM student2;

INSERT INTO student2
	VALUES(1,'宋江',86,71,95),
		(2,'鲁智深',74,36,83),
		(3,'林冲',68,49,95),
		(4,'花容',94,57,78),
		(5,'武松',84,49,82),
		(6,'秦明',76,85,67),
		(7,'呼延灼',87,89,78),
		(8,'史进',68,94,86),
		(9,'阮小二',76,82,38),
		(10,'卢俊义',91,81,73);


SELECT * FROM student2;
SELECT id , `name`, chinese, math, english, chinese+math+english AS total_score
	FROM student2
	ORDER BY total_score DESC;
	
-- （1）统计函数
-- count函数
SELECT COUNT(*) 
	FROM student2;
	
SELECT COUNT(*) AS two_character_name
	FROM student2 
	WHERE `name` LIKE '__';

SELECT COUNT(*)
	FROM student2
	WHERE chinese+math+english >= 230;
	

-- sum函数
SELECT SUM(chinese) 
	FROM student2;

SELECT SUM(chinese + math + english) AS score_sum
	FROM student2;
	
SELECT (SUM(chinese + math + english) / COUNT(*)) AS average_score -- 统计每人的平均总成绩
	FROM student2;	
	

-- avg函数
SELECT AVG(math)
	FROM student2;
	
SELECT AVG(chinese) AS chinese_avg, AVG(math) AS math_avg, AVG(english) AS english_avg -- 统计每科的均值
	FROM student2;
	
SELECT AVG(chinese + math + english) -- 统计每人的平均总成绩
	FROM student2;


-- max/min函数
SELECT MAX(math) FROM student2;

SELECT MIN(english) FROM student2;
	
SELECT MAX(chinese + math + english), MIN(chinese + math + english)
	FROM student2;


-- （2）字符串函数
-- 查看字符串的字符集
SELECT `name`, CHARSET(`name`) FROM student2;

-- 查看字符串所占字节长度（单位：字节）
SELECT `name`, LENGTH(`name`) FROM student2;

-- 查看字符串的元素个数
SELECT `name`, CHAR_LENGTH(`name`) FROM student2;

-- 将字符串转换为大/小写
SELECT UCASE('abcde') FROM DUAL;
SELECT LCASE('ABCDE') FROM DUAL;

-- 去除字符串左/右的空格
SELECT LTRIM('   hello   ') FROM DUAL;
SELECT RTRIM('   hello   ') FROM DUAL;
SELECT TRIM('   hello   ') FROM DUAL;

-- 连接多个字符串
SELECT `name`, CONCAT(`name`, ' 总分是 ', chinese+math+english) FROM student2;

-- 比较两字符串大小
SELECT STRCMP('abc', 'bbc') FROM DUAL;
SELECT STRCMP('abc', 'abc') FROM DUAL;
SELECT STRCMP('bbc', 'abc') FROM DUAL;

-- 返回子串位置
SELECT INSTR('abcdefg', 'ef') FROM DUAL;

-- 截取左/右子串
SELECT `name`, LEFT(`name`, 1), RIGHT(`name`, CHAR_LENGTH(`name`) - 1) FROM student2;

-- 截取指定位置子串
SELECT `name`, SUBSTRING(`name`, 1, 1), SUBSTRING(`name`, 2) FROM student2;

-- 替换子串
SELECT `id`, REPLACE(`name`, '鲁智深', 'luzhishen') FROM student2;


-- 练习：以首字母小写，其它字母不变的形式，显示emp表的员工姓名
SELECT ename, CONCAT(LCASE(SUBSTRING(ename, 1, 1)), SUBSTRING(ename, 2))
	FROM emp;
	
SELECT ename, CONCAT(LCASE(LEFT(ename, 1)), RIGHT(ename, CHAR_LENGTH(ename)-1))
	FROM emp;
	

-- （3）数学函数
-- 取绝对值
SELECT ABS(-1), ABS(-10) FROM DUAL;

-- 取余
SELECT MOD(10, 3), MOD(10, 4) FROM DUAL;

-- 保留n位小数（会四舍五入）
SELECT FORMAT(3.1415926, 2), FORMAT(3.1415926, 4), FORMAT(2.718, 0) FROM DUAL;

-- 向上/下取整数
SELECT CEILING(1.5), CEILING(-1.5) FROM DUAL;
SELECT FLOOR(1.5), FLOOR(-1.5) FROM DUAL;

-- 取最小值
SELECT LEAST(1,2,33,4) FROM DUAL;

-- 生成(0,1)的随机数
SELECT RAND() FROM DUAL; -- 每次不一样的随机数
SELECT RAND(3), RAND(55) FROM DUAL; -- 加入种子后变成固定的伪随机数

-- 十进制转二/十六进制
SELECT BIN(8) FROM DUAL;
SELECT HEX(11) FROM DUAL;

-- 任意进制间相互转换
SELECT CONV(11, 10, 16) FROM DUAL;
SELECT CONV(11, 10, 2) FROM DUAL;
SELECT CONV('ABCDEF', 16, 10) FROM DUAL;



-- （4）系统、加密函数
-- 查询登陆的用户
SELECT USER() FROM DUAL;

-- 查询当前数据库
SELECT DATABASE() FROM DUAL;

-- 对字符串进行MD5加密
SELECT MD5('123456'), LENGTH(MD5('12345')) FROM DUAL;
SELECT MD5('qwertyuiop'), LENGTH(MD5('qwertyuiop')) FROM DUAL;

-- 用password()对字符串进行加密
SELECT PASSWORD('123456'), LENGTH(PASSWORD('12345')) FROM DUAL;
SELECT PASSWORD('qwertyuiop'), LENGTH(PASSWORD('qwertyuiop')) FROM DUAL;