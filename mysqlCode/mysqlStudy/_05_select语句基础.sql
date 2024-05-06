DROP TABLE goods;
CREATE TABLE goods(
	id INT,
	`name` VARCHAR(20),
	price DOUBLE
);

DESC goods;

INSERT INTO goods 
	VALUES(1,'苹果',3.5),(2,'梨',2.5),(3,'香蕉',1),(4,'桃子',5.5),(5,'葡萄',7.5);
	
SELECT * FROM goods;
SELECT * FROM goods WHERE id=1 OR id=2;
SELECT `name`,price FROM goods WHERE id>=2 AND id<=4;

INSERT INTO goods VALUES(6,'苹果',3.5);
SELECT `name`,price FROM goods;
SELECT DISTINCT `name`,price FROM goods; -- DISTINCT关键字：对查询结果去重
DELETE FROM goods WHERE id=6;
