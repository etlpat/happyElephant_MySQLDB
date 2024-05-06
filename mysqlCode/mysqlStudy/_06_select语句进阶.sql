DROP TABLE student1;
CREATE TABLE student1(
	id INT,
	`name` VARCHAR(10),
	chinese INT,
	math INT,
	english INT
);
DESC student1;
INSERT INTO student1 
	VALUES (20240001, '张三', 84, 65, 86),
	(20240002, '李四', 46, 87, 93),
	(20240003, '刘备', 93, 86, 73),
	(20240004, '关羽', 27, 78, 49),
	(20240005, '张飞', 82, 52, 95),
	(20240006, '李逵', 85, 67, 73),
	(20240007, '时迁', 83, 99, 72);


SELECT * FROM student1;

SELECT `name`, (chinese+math+english) FROM student1; -- select关键字可以查看表达式的值

SELECT `name` AS stu_name, (chinese+math+english) AS total_score
	FROM student1; -- 可以用AS关键字对字段/表达式取别名
	
	
-- where子句的使用
SELECT id,`name`,english 
	FROM student1
	WHERE english >= 90;
	
SELECT `name`, chinese, chinese+math+english AS total_score 
	FROM student1
	WHERE chinese+math+english >= 200 AND chinese >= 70;
	
SELECT * FROM student1
	WHERE `name` LIKE '张_%' OR `name` LIKE '李_%';
	
SELECT * FROM student1
	WHERE `name` IN('刘备','关羽','张飞');

SELECT * FROM student1
	WHERE english BETWEEN 73 AND 93;
	
SELECT * FROM student1
	WHERE chinese IN(84,85,86);

SELECT * FROM student1
	ORDER BY id; -- 默认升序(ASC)排序
	
SELECT `name` AS stu_name, chinese+math+english AS total_score 
	FROM student1
	ORDER BY total_score DESC;
	
SELECT `name`
	FROM student1
	WHERE `name` LIKE '__'
	ORDER BY chinese*0.6 + math + english*0.8 DESC;
	