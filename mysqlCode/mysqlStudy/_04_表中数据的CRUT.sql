CREATE TABLE goods(
	id INT,
	goods_name VARCHAR(10),
	price DOUBLE
)CHARSET utf8 COLLATE utf8_bin;

DROP TABLE goods;
USE DB1;
DESC goods;


-- 插入语句
INSERT INTO goods(id, goods_name, price) VALUES(1,'苹果',3.5);
INSERT INTO goods 
	VALUES(2,'香蕉',2.5),(3,'栗子',8.8),(4,'香肠',20),(5,'茄子',6);


-- 修改语句
UPDATE goods SET goods_name='李子' WHERE goods_name='栗子';
UPDATE goods SET price=17.5 WHERE id=4;
UPDATE goods SET price=price+10 WHERE goods_name='香蕉';

ALTER TABLE goods ADD is_sell VARCHAR(10) NOT NULL DEFAULT 'false';
UPDATE goods SET is_sell='true'; -- 若不写WHERE语句，则更新所有记录

UPDATE goods SET goods_name='圆茄子',price=price-1 WHERE goods_name='茄子';


-- 删除语句
DELETE FROM goods WHERE id=3;
DELETE FROM goods WHERE goods_name='香肠';
DELETE FROM goods; -- 若不写where子句，则删除全部数据

SELECT * FROM goods;
