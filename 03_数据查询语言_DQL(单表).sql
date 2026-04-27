CREATE DATABASE IF NOT EXISTS test04_dql;
USE test04_dql;

CREATE TABLE IF NOT EXISTS t_employee(
	eid int NOT NULL comment '员工编号',
	ename varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL comment '员工姓名',
	salary double NOT NULL comment '薪资',
	commission_pct decimal(3,2) DEFAULT NULL comment '奖金比例',
	birthday date NOT NULL comment '出生日期',
	gender enum('男','女') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '男' comment '性别',
	tel char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL comment '手机号码',
	email varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL comment '邮箱',
	address varchar(150) DEFAULT NULL comment '地址',
	work_place SET ('北京','深圳','上海','武汉') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '北京' comment '工作地点'                 
) ENGINE = INNODB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO t_employee (eid, ename, salary, commission_pct, birthday, gender, tel, email, address, work_place)
VALUES 
(1, '张三', 10000, 0.05, '1990-05-15', '男', '13800138000', 'zhangsan@example.com', '北京市朝阳区', '北京'),
(2, '李四', 12000, NULL, '1992-08-20', '女', '13900139000', 'lisi@work.com', '上海市浦东新区', '上海'),
(3, '王五', 8000, 0.10, '1995-02-10', '男', '13700137000', 'wangwu@test.com', NULL, '武汉'),
(4, '赵六', 15000, 0.08, '1988-11-30', '女', '13600136000', 'zhaoliu@abc.com', '深圳市南山区', '深圳'),
(5, '孙七', 9000, NULL, '1993-07-25', '男', '13500135000', 'sunqi@hello.com', NULL, '北京,上海'),
(6, '周八', 11000, 0.12, '1991-04-18', '女', '13400134000', 'zhouba@world.net', '杭州市西湖区', '上海,深圳'),
(7, '吴九', 13000, 0.07, '1987-09-05', '男', '13300133000', 'wujiu@example.org', '武汉市洪山区', '武汉,北京'),
(8, '郑十', 10500, NULL, '1994-01-23', '女', '13200132000', 'zhengshi@test.cn', '北京市海淀区', '北京'),
(9, '冯十一', 9500, 0.09, '1996-12-12', '男', '13100131000', 'feng11@work.com', NULL, '深圳'),
(10, '陈十二', 12500, 0.06, '1990-06-09', '女', '13000130000', 'chen12@job.com', '上海市静安区', '上海,武汉');

#2.1 基础语法
#1.非表查询---利用select关键字 快速输出一个运算结果或者函数
#select 运算，函数
SELECT NOW();

#2.指定表查询结果---结果来自指定表格数据
/*select 列名,列名,列名... from 表名
 *select 表名.列名,列名... from 表名（用于多表的列名重复）
 *select * | 表名.* from 表名 *->表中所有的列
 */
#查询全部员工信息
SELECT * FROM t_employee; #-> SELECT t_employee.* FROM t_employee;

#查询全部员工姓名和工资
SELECT ename,salary FROM t_employee;

#3.查询列并起别名
#select 列名 as 别名, 列名 别名... from 表名
SELECT ename AS NAME , salary SALARY FROM t_employee;

#4.去掉重复行数据---根据结果列进行重置值去除
#select distinct 列名,列名,列名... from 表名
#查看员工性别种类
SELECT DISTINCT gender FROM t_employee;

#5.查询常数列
#select 列,列名,'值' as 列名 from 表名
SELECT ename NAME,salary, '法拉利' AS company FROM t_employee;


















