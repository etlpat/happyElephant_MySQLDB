-- 创建一份和emp表结果完全相同的空表
CREATE TABLE tmp LIKE emp;

-- 将emp表的内容全部复制到tmp表中
INSERT INTO tmp
	SELECT * FROM emp;

-- 将tmp表的内容进行自我复制
INSERT INTO tmp
	SELECT * FROM tmp;
	
SELECT COUNT(*) FROM tmp;


-- 对tmp表进行去重
-- 步骤：①创建与原始表结构完全相同的空临时表
--	 ②利用SELECT语句和DISTINCT关键字，向临时表中插入去重后的原始表数据
--	 ③清空原始表
--	 ④将临时表中的数据拷贝到原始表
-- 	 ⑤删除临时表

CREATE TABLE tmp1 LIKE tmp;

INSERT INTO tmp1
	SELECT DISTINCT * FROM tmp;
	
delete from tmp;

insert into tmp 
	select * from tmp1;

drop table tmp1;


select * from tmp;
select * from tmp1;



-- 将两个select的查询结果合并
-- union all：不去重
select * from emp where sal > 2500 union all
	select * from emp where job = 'MANAGER';

-- union：去重
SELECT * FROM emp WHERE sal > 2500 UNION
	SELECT * FROM emp WHERE job = 'MANAGER';