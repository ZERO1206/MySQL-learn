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








