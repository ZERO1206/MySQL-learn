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

#2.2 指定表查询结果---结果来自指定表格数据
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

#查询所有员工信息
SELECT * FROM t_employee;

#查询所有员工信息 并且添加一列etype 值固定为"总部"
SELECT * , '总部' etype FROM t_employee;

#查询所有员工姓名、工资和工作地址
SELECT ename , salary , work_place FROM t_employee;

#查询所有员工姓名、薪资和年薪（年薪等于月薪*12）
SELECT ename , salary , salary*12 AS 年薪 FROM t_employee;

#查询所有员工姓名、月薪、每月奖金、每月总收入
SELECT ename , salary 月薪, salary * IFNULL(commission_pct, 0) 每月奖金 , salary * (IFNULL(commission_pct, 0) + 1) 每月收入 FROM t_employee;
#NULL运算 任何值 = NULL; --> ifnull(列, 默认值);

#查询所有员工一共有几种薪资
SELECT DISTINCT salary 薪资 FROM t_employee;

/*
2.3 显示表结构---使用命令查看表中的列和列的特征
	describe 表名
	desc 表名
 */
DESC t_employee;

/*
2.4 过滤数据（条件查询）
	select 列 from 表 where [条件 and | or | xor 条件 ...] true | false;
	from ---> 执行参照和查询表
	where ---> 进行表中行的数据筛选
	select ---> 进行符合条件行的数据类的筛选
 */

#查询工资高于9000的员工信息
SELECT * FROM t_employee WHERE salary > 9000;

#查询年薪高于100000的员工姓名、薪资和年薪信息
SELECT ename 姓名 , salary 薪资 , salary*12 年薪 FROM t_employee WHERE salary*12 > 100000;

#查询工资高于8000且性别为女的员工信息
SELECT * FROM t_employee WHERE salary > 8000 AND gender = '女';

/*
3.1 算术运算符---对列进行算术运算
	+ - * /(div) %(MOD)
	注意
	 1./浮点除法 div 整数除法 
	 2./0不会抛出异常 结果是NULL
	 3.和浮点类型进行运算 结构也是浮点类型
	 4.优先级和之前一样 提升优先级 使用()
 */

#查询薪资奖金和大于12000的员工信息
SELECT * FROM t_employee WHERE salary*(IFNULL(commission_pct, 0) + 1) > 12000;

#查询薪资减去奖金的差小于8000的员工信息
SELECT * FROM t_employee WHERE salary*(1 - IFNULL(commission_pct, 0)) < 8000;

#查询所有员工的姓名、工资、奖金数额
SELECT ename 姓名, salary 工资, salary*IFNULL(commission_pct, 0) 奖金数额 FROM t_employee;

#查询员工编号偶数的员工信息
SELECT * FROM t_employee WHERE eid%2 = 0;

/*
3.3 比较运算符
	等于对比
	=(不能做空判断 null = null -> false   null <=> null ->  true(方言) -> is null) 
	不等于对比
	<> 标准语法 !=(mysql方言)
	大于、小于、大于等于、小于等于 > < >= <=
	空值处理
	if null      is not null
	区间比较
	between [min] and [max]      not between [min] and [max]
	范围比较
	key in(x, y, z) key = x or key = y or key = z	not in(...) ...
	模糊匹配
	like | not like -> key like '?%'  key like '_?%'
 */

#查询员工编号为1的员工信息
SELECT * FROM t_employee WHERE eid = 1;  # -> SELECT * FROM t_employee WHERE eid = '1'; 

#查询薪资大于5000的员工信息
SELECT * FROM t_employee WHERE salary > 5000;

#查询有奖金的员工信息
SELECT * FROM t_employee WHERE commission_pct IS NULL;  # -> SELECT * FROM t_employee WHERE commission_pct <=> NULL;

#查询出生日期在'1990-01-01'和'1995-05-01'之间的员工信息
SELECT * FROM t_employee WHERE birthday BETWEEN '1990-01-01' AND '1995-05-01';

#查询性别为女性的员工 
SELECT * FROM t_employee WHERE gender = '女';

#查询手机号码以'138'开头的员工信息
SELECT * FROM t_employee WHERE tel LIKE '138%';

#查询邮箱以'@abc.com'结尾的员工信息 
SELECT * FROM t_employee WHERE email LIKE '%@abc.com';

#查询工作地点为'北京','上海','深圳'的员工信息
SELECT * FROM t_employee WHERE work_place IN ('北京', '上海', '深圳');

/*
3.5 逻辑运算符
	and && - or || - not ! - xor
 */

#查询薪资大于5000且工作地点为'北京'的员工信息
SELECT * FROM t_employee WHERE salary > 5000 AND work_place LIKE '%北京%';
#find_in_set ('值', 列名) -> 值是否出现 --- 出现 1 不出现 0
SELECT ename, FIND_IN_SET('北京', work_place) FROM t_employee;
SELECT * FROM t_employee WHERE salary > 5000 AND FIND_IN_SET('北京', work_place) > 0;

#查询奖金比例为NULL或者地址为NULL的员工信息
SELECT * FROM t_employee WHERE commission_pct IS NULL OR address IS NULL;

#查询出生日期在'1995-01-01'之前或者薪资小于4000的员工信息
SELECT * FROM t_employee WHERE birthday < '1995-01-01' OR salary < 4000;

#查询性别为男且工作地点不为'上海'的员工信息
SELECT * FROM t_employee WHERE gender = '男' AND FIND_IN_SET('上海', work_place) = 0;

#查询薪资大于5000且工作地点为'北京'或者'上海'的员工信息
SELECT * FROM t_employee WHERE salary > 5000 AND (FIND_IN_SET('北京', work_place) > 0 OR FIND_IN_SET('上海', work_place) > 0);

#3.7 运算符优先级和结合性
#1.（）圆括号---最高优先级的运算符
SELECT * FROM TABLE WHERE (a+b)*c>d;
#2.一元运算符 -（符号）、 ！（非）、 ～（按位反）等
SELECT !1+1;
#3.算法运算符 *、/、%、DIV、MOD
SELECT 1+1*2;
#4.算术运算符 + -
SELECT 1+2*3>=2
#5.比较运算符 = > >= < <= != is LIKE IN等
#6.逻辑运算符 AND OR XOR
SELECT 1>1 AND 1=1;

#4.3 单行函数---数值函数
/*
abs()---取绝对值  ceil()---向上取整  floor()---向下取整  rand()---完全随机数  rand(x)---固定随机数x
round(x)---四舍五入取整  round(x,y)---指定精度(保留y位小数 对y+1位小数四舍五入) truncate(x,y)---保留y位小数不进行四舍五入
*/
SELECT ABS(-5), CEIL(2.3), CEIL(-2.3), FLOOR(2.3), FLOOR(-2.3), RAND(), RAND(8),
       ROUND(2.3), ROUND(2.36,1), TRUNCATE(2.36,1); 

#4.4 单行函数---字符串函数
/*
char_length(字符)---返回字符数  concat(x,x,x,x)---字符拼接  find_in_set(x,y)---在y的数据中找x出现的位置
!! find_in_set(x,y)  y是一种set数据格式 从'x,x,x,x'中找x的存在的位置 位置从1开始 找到第一个出现的位置截至
*/
SELECT CHAR_LENGTH('abc'), CONCAT('%','md','fuck'), FIND_IN_SET('aa', 'cc,dd,aa,cv,aa,gg');

#4.5 单行函数---时间函数
/*
获取当前时间:
	now()---返回当前系统日期和时间  curdate()---只返回当前日期  curtime()---值返回当前时间 考虑系统时区
	utc_date() utc_time() 不考虑系统时区
时间部分提取:
	year(时间)---年  month(时间)---月  week(时间)---周  weekday(时间)---星期几(0是星期一) 
	dayofweek(时间)---星期几(1是星期天)
时间运算:
	adddate | date_add (时间锚点, interval +-值 运算的时间单位的英文[day month year...])
	subdate | date_sub (时间锚点, interval +-值 运算的时间单位的英文[day month year...])
	addtime(时间,秒)---时间的+-秒运算
	datediff(日期,日期)---算两个日期之间间隔天数
	timediff(时间,时间)---算两个时间间隔时差 时:分:秒
时间格式化函数:
	date_format(时间,'格式字符串') time_format(时间,'格式字符串') --- 格式化时间生成一个自定义格式的时间字符串
	str_to_date('非标注时间字符串','非标注时间字符串对应的格式') --- 非标注时间字符串 --- 转成标注时间
*/
SELECT NOW(), CURDATE(), CURTIME(), UTC_DATE(), UTC_TIME(), YEAR(NOW()), MONTH(NOW()), 
	   WEEK(NOW()), WEEKDAY(NOW()), DAYOFWEEK(NOW());

SELECT ADDDATE(NOW(),INTERVAL 1 MONTH), ADDDATE(NOW(),INTERVAL -1 MONTH), ADDTIME('10:10:10',20),
	   DATEDIFF(CURDATE(),'2024-11-11'), TIMEDIFF(CURTIME(),'10:00:00');

SELECT DATE_FORMAT(NOW(),'%Y年%m月%d日'), TIME_FORMAT(NOW(),'%H:%i:%s'), 
	   STR_TO_DATE('2024年12月15日','%Y年%m月%d日');


























