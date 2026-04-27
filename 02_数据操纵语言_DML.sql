#3.数据操作语言

/*
3.1数据操作语言【插入】
	全列插入【不推荐】
		insert into 表名 values | value (值，值，值...)
		值的数量要等于表的所有列的数量
		值的类型和顺序要和表的类的类型和顺序相对应
	指定列插入【推荐】
		insert into 表名 （列名，列名，列名...）values | value (值，值，值...)
		值的数量要等于表的指定列的数量
		值的类型和顺序要和表的指定列的类型和顺序相对应
	多行插入
		insert into 表名 values | value (值，值，值...)，(值，值，值...)
		insert into 表名 （列名，列名，列名...）values | value (值，值，值...)，(值，值，值...)
	注意
		1.values 或者 value 推荐使用values
		2.插入的是字符串或者时间的类型 + ''
		3.值的顺序和类型要和表的列名或者指定的列名相对应
*/ 

CREATE DATABASE IF NOT EXISTS dml_dl;
USE dml_dl;

CREATE TABLE student(
	stu_id INT COMMENT '学号',
	stu_name VARCHAR(100) COMMENT '姓名',
	stu_age TINYINT UNSIGNED COMMENT '年龄',
	stu_birthday DATE COMMENT '生日',
	stu_height DECIMAL(4,1) DEFAULT 200 COMMENT '身高'
);

#插入一名学生的所有信息 包括学号、名字、年龄、生日和身高
INSERT INTO student VALUES (1,'张山',18,'1990-02-05',185.5);
INSERT INTO student (stu_id, stu_name, stu_age, stu_birthday, stu_height) VALUES (1, '张山', 18, '1990-02-05', 185.5);

#插入一名学生的学号、名字、年龄、其他列使用默认值
INSERT INTO student (stu_id, stu_name, stu_age) VALUES (3, '老六', 25);

#插入一名学生的信息 只提供学号、名字和年龄 其他为空
INSERT INTO student (stu_id, stu_name, stu_age, stu_birthday, stu_height) VALUES (6, '啥子', 23, NULL, NULL);

DESC student;
SELECT * FROM student;

/*
3.2 数据操作语言【修改】
	全表修改【全行修改】
	update 表名 set 列名 = 新值 , 列名 = 值 , 列名 = 值 ...
	条件修改【条件筛选行】
	update 表名 set 列名 = 新值 , 列名 = 值 , 列名 = 值 ... where 条件
	注意
	 1.不添加where 代表修改一个表中的所有行的数据 反之 只修改符合where条件的行
	 2.如果修改多个列 set 列名 = 值 , 列名 = 值 , 列名 = 值 ...
*/

#将学号为6的学生修改为'黄六'
UPDATE student SET stu_name = '黄六' WHERE stu_id = 6;

#将年龄小于20岁的学生的升高增加2.0
UPDATE student SET stu_height = stu_height + 2.0 WHERE stu_age < 20;

#将学号为3的学生的生日修改为'2003-07-10' 且年龄改为21
UPDATE student SET stu_birthday = '2003-07-10' , stu_age = 21 WHERE stu_id = 3;

#将所有学生的年龄减少1
UPDATE student SET stu_age = stu_age - 1;

/*
3.3 数据操作语言【删除】
	全表删除
	delete from 表名;
	条件行删除
	delete from 表名 where 条件;
	注意
	 1.开发中很少使用全表删除
	 2.delete删除和清空表truncate删除 都会删除表中的全部数据 truncate不仅删除表数据 还会删除数据库id的最大记录值
*/

INSERT INTO student VALUES (8, '刘亦菲', 26, '2020-12-12', 150);

#删除年龄大于23的学员
DELETE FROM student WHERE stu_age > 23;

#将身高高于190且学号大于1的数据移除
DELETE FROM student WHERE stu_height > 190 AND stu_id > 1;

#将所有学生数据移除
DELETE FROM student;













