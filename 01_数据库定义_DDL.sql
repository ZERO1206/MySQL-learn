# 1.DDL之数据库操作
/*
1.1 数据库创建
	创建数据库
	create database 数据库名;
	判断再创建数据库
	create database if not exists 数据库名;
	创建数据库指定字符集
	create database 数据库名 character set 字符集;
	创建数据库指定排序方式
	create database 数据库名 collate 排序方式;
	创建数据库指定字符集和排序方式
	create database 数据库名 character set 字符集 collate 排序方式;
	查询数据库的字符集和排序方式
	mysql8: 默认 utf8mb4 utf8mb4_0900_ai_ci
	show variables like 'character_set_database';
	show variables like 'collation_database';
*/
CREATE database IF NOT EXISTS ddl_d1 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
show variables like 'character_set_database';
show variables like 'collation_database';

/*
1.2 数据库查看
	查看所以库
	show databases;
	查看当前使用库
	select database();
	查看库下所有表
	show tables from 数据库名;
	查看创建库的信息和语句
	show create database 数据库名;
	选中和切换库
	use 数据库名;
	注意:对数据进行操作之前 必须要选中库！use 数据库; use 数据库名;
*/

show databases;

select database();

use mysql;

show tables from mysql;

show create database ddl_d1;

/*
1.3 数据库修改
	修改字符集
	alter database 数据库名 character set 字符集;
	修改排序方式
	alter database 数据库名 collate 排序方式;
	修改字符集和排序方式
	alter database 数据库名 character set 字符集 collate 排序方式;
	注意：数据库中没有修改名称的指令 如果想修改名称->备份数据->删除旧库->创建新库->恢复数据 即可
*/

/*
1.4 数据库删除
	直接删除
	drop database 数据库名;
	判断删除
	drop database if exists 数据库名;
	注意：删除是一个危险命令 确认明确再操作！
*/

# 2.DDL之数据表操作
/*
2.1 表管理：创建表
create table [if not exists] 表名{
	列名 类型[列可选约束] [comment'列可选注释'],  #列之间使用,分割
	列名 类型[列可选约束] [comment'列可选注释']
}[表可选约束][comment'表可选注释'];

建表事项：
	1.表名 列名 列类型必须填写
	2.推荐使用if not exists
	3.注释不是不须的 但是很有必要
	4.列之间,隔开 最后一列没有
*/

CREATE DATABASE IF NOT EXISTS book_libs CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_as_cs;

USE book_libs;

CREATE TABLE IF NOT EXISTS books(
	book_name varchar(20) COMMENT '图书名称',
	book_price double(4, 1) COMMENT '图书价格',
	book_num int COMMENT '图书数量'
)CHARSET = utf8mb4 COMMENT '图书表';

SHOW TABLES FROM book_libs;

/*
2.3 建表类型(整型)
	整数类型(类型 占有空间 范围)
	标准sql:
		int / integer	4字节	无符号:0 ~ 2^32-1	有符号:-2^31 ~ 2^31-1
		smallint 		2字节	无符号:0 ~ 2^16-1	有符号:-2^17 ~ 2^17-1
		
	mysql:
		tinyint			1字节	无符号:0 ~ 2^8-1	有符号:-2^7 ~ 2^7-1
		mediumint		3字节	无符号:0 ~ 2^24-1	有符号:-2^23 ~ 2^23-1
		bigint			8字节	无符号:0 ~ 2^64-1	有符号:-2^63 ~ 2^63-1
	
	有符号: 列名 整数类型 -> 有符号|有符号  有负值和正值
		   列名 整数类型 unsigned -> 无符号|无符号 没有负值 都是正值 将负数部分绝对值后加入正值部分
		   
	注意: 选合适范围 范围合适先占有空间最小的
*/

CREATE TABLE IF NOT EXISTS t1(
	t1_age TINYINT UNSIGNED comment '年龄 无符号 范围是0~255',
	t1_number bigint UNSIGNED comment '学号 最大的 且无符号'
);

SHOW TABLES FROM book_libs;

/*
2.4 建表类型（浮点/定值）
	浮点类型（类型 M D）
		float(m,d)	4字节	m 24	d 8
		double(m,d)	8字节	m 53	d 30
	定值类型（类型 M D）
		decimal(m,d)	动态占有	m 65	d 30
	使用对比：
		精度要求不高 例如：身高 体重 float double
		精度要求特别高 例如：钱 工资 decimal
*/

/*
2.6 建表类型（字符串）
	字符串类型
		char	固定长度类型 一旦声明固定占有对应的空间 M 最大255
		varchar 可变长度类型 一旦声明 可插入小于的长度 自动进行伸缩 M 占有的空间不能超过一行的最大显示65535字节
		1.char声明的时候可以不写m char = char(1)
		2.char声明了最大长度限制 输入的文本小于长度限制 会在右侧补全空格 char(5) -> 'abc' -> 'abc  '
		3.char类型在读取的时候 会自动去掉右侧的空格 'abc ' -> 'abc'
		4.varchar声明的时候 必须添加m限制 varchar(m)
		5.mysql14.0以下版本 varchar(20) -> 20字节限制 mb3 -> 6
		6.mysql15.0以上版本 varchar(20) -> 20字节限制
		7.varchar类型中识别空格 插入空格 读取也是有空格
		
	演示varchar最大限制
		前提：mysql中一行数量最大的占有空间是65535字节 除了TEXT or BLOBs类型的列(不占有65535限制)
			一行 -> name1列 -> name1列占有的最大空间65535字节
			varchar类型默认会使用1字节标识是否为null -> 65535-1=65534
			字符集utf8mb4 1个字符 = 4个字节 65534/4=16383.xxx
	解决方案：
		1.缩小字符大小限制 m变小[不合理]
		2.可以修改字符集[不合理]
		3.可以将字符集类型变成TEXT 不占有一行的限制、
*/

CREATE TABLE IF NOT EXISTS t2(
	name1 varchar(16000),
	name2 TEXT
)charset=utf8mb4;














