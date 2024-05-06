USE db1;
DROP TABLE content_datetime;

CREATE TABLE content_datetime(
	id INT,
	content VARCHAR(32),
	send_datetime DATETIME
);

DESC content_datetime;

INSERT INTO content_datetime VALUE(1, '北京新闻', NOW());
INSERT INTO content_datetime VALUE(2, '上海新闻', NOW());
INSERT INTO content_datetime VALUE(3, '山西新闻', NOW());
INSERT INTO content_datetime VALUE(4, '广州新闻', NOW());
INSERT INTO content_datetime VALUE(5, '黑龙江新闻', NOW());
INSERT INTO content_datetime VALUE(6, '深圳新闻', NOW());

SELECT * FROM content_datetime;



-- 获取当前datetime
SELECT NOW() FROM DUAL;

-- 获取当前date
SELECT CURRENT_DATE() FROM DUAL;

-- 获取当前time
SELECT CURRENT_TIME() FROM DUAL;

-- 获取当前时间戳
SELECT CURRENT_TIMESTAMP() FROM DUAL;

-- 获取1970-1-1到现在的秒数
SELECT UNIX_TIMESTAMP(), UNIX_TIMESTAMP()/(3600*24*365) FROM DUAL;

-- 获取datetime的date部分
SELECT id, content, DATE(send_datetime) 
	FROM content_datetime;

-- 获取datetime的time部分
SELECT id, content, TIME(send_datetime) 
	FROM content_datetime;

-- 获取datetime的年/月/日/时/分/秒部分
SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW()), HOUR(NOW()), MINUTE(NOW()), SECOND(NOW()) FROM DUAL;

-- 在已有datetime的基础上增加时间
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 10 HOUR) FROM DUAL;

-- 在已有datetime的基础上减少时间
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 50 MINUTE) FROM DUAL;

-- 案例：获取content_datetime表中，前20分钟内发布的新闻
SELECT * FROM content_datetime
	WHERE send_datetime >= DATE_SUB(NOW(), INTERVAL 20 MINUTE); -- 发布时间>=20分钟前	
SELECT * FROM content_datetime
	WHERE DATE_ADD(send_datetime, INTERVAL 20 MINUTE) >= NOW();
	
-- 求两个datetime的日期差
SELECT DATEDIFF(NOW(), '2000-1-1 0:0:0') FROM DUAL;
SELECT DATEDIFF('2001-1-1 0:0:0', '2000-1-1 0:0:0') FROM DUAL;

-- 求两个datetime的时间差
SELECT TIMEDIFF(NOW(), send_datetime) FROM content_datetime;
SELECT TIMEDIFF('2000-1-2 12:59:59', '2000-1-1 0:0:0') FROM DUAL;

-- 案例：求出你活了多少天（假设生日为'2000-10-24'）
SELECT DATEDIFF(NOW(), '2000-10-24') FROM DUAL;
-- 案例：假设你能活到80岁，求出你还能活多少天（假设生日为'2000-10-24'）
SELECT DATEDIFF(DATE_ADD('2000-10-24', INTERVAL 80 YEAR), NOW()) FROM DUAL;


-- 获取1970-1-1到现在的时间戳（秒）
SELECT UNIX_TIMESTAMP() FROM DUAL;

-- 将时间戳（秒）转换成datetime
SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(), '%Y-%m-%d %H:%i:%s') FROM DUAL;
SELECT FROM_UNIXTIME(1770000000, '%Y-%m-%d') FROM DUAL;