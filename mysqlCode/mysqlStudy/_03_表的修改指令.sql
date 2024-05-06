DROP TABLE employee;

CREATE TABLE employee(
	id INT,
	`name` VARCHAR(20),
	sex VARCHAR(10),
	birthday DATE,
	entry_date DATE,
	job VARCHAR(255),
	salary DOUBLE,
	`resume` TEXT
) CHARSET utf8 COLLATE utf8_bin;

DESC employee;

-- 添加字段
ALTER TABLE employee ADD email VARCHAR(255) NOT NULL DEFAULT '' AFTER sex;
ALTER TABLE employee ADD user_text TEXT;

-- 修改字段类型
ALTER TABLE employee MODIFY job VARCHAR(30);
ALTER TABLE employee MODIFY sex VARCHAR(5);

-- 修改字段名称+类型
ALTER TABLE employee CHANGE `name` user_name VARCHAR(20); -- 修改名称+类型
ALTER TABLE employee CHANGE id uid INT; -- 仅修改名称
alter table employee change sex sex varchar(10); -- 仅修改类型

-- 删除字段
alter table employee drop email;
alter table employee drop birthday;

-- 修改表名
rename table employee to emp;
rename table emp to employee;


-- 修改表的字符集
alter table employee charset utf8;

desc employee;
