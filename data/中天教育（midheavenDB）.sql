--使用系统数据库
use master
go

--判断 midheavenDB 数据库是否存在
if exists(select * from sys.databases where name='midheavenDB')
	drop database midheavenDB
go

--创建 midheavenDB 数据库
create database midheavenDB
go

--使用 midheavenDB 数据库
use midheavenDB
go

--判断 Roles 表是否存在
if exists (select 1 from sys.objects where name='Roles')
   drop table Roles
go

--判断 Member 表是否存在
if exists (select 1 from sys.objects where name='Member')
   drop table Member
go

--判断 Course 表是否存在
if exists(select 1 from sys.objects where name='Course')
	drop table Course
go

--判断 StudentCourse 表是否存在
if exists(select 1 from sys.objects where name='StudentCourse')
	drop table StudentCourse
go

--判断 CourseComment 表是否存在
if exists(select 1 from sys.objects where name='CourseComment')
	drop table CourseComment
go

--创建角色表 Roles
create table Roles
(
	R_ID int primary key identity(1,1), --角色编号
	R_Name varchar(10),					--角色名称
	R_Desc varchar(20)					--角色描述
)
go

--向角色表 Roles添加数据
insert into Roles values('管理员','管理员')
insert into Roles values('教师','教师')
insert into Roles values('学生','学生')
go

--创建成员表 Member
create table Member
(
	M_ID int primary key identity(1,1),		--成员编号
	UserName varchar(20),					--登录名
	Password varchar(20),					--密码
	RealName varchar(20),					--真实姓名
	Sex char(2),							--性别
	Age int,								--年龄
	PhoneNum varchar(11),					--电话
	Address varchar(50),					--地址
	R_ID int,								--角色编号
	M_Flog int check(M_Flog=0 or M_Flog=1) default(0)--是否通过审核(0 是  1 否 默认已审核，未通过审核禁止登陆)
)
go

--向成员表添加数据
insert into Member values('小杰admin','admin','潘俊杰','男',21,'15897703377','湖北襄阳',1,0)		--添加管理员
insert into Member values('PH','123456','彭慧','女',20,'15748625881','湖北武汉',2,0)			--添加老师
insert into Member(UserName,Password,RealName) values('YZW','123456','杨智雯')				
insert into Member(UserName,Password,RealName) values('HR','123456','黄蓉')					
insert into Member(UserName,Password,RealName) values('HXF','123456','何秀芬')
insert into Member values('YRY','112233','杨如意','男',20,'17683802203','湖北孝感',3,0)			--添加学生
insert into Member(UserName,Password,RealName) values('XWQ','112233','肖文清')				
insert into Member(UserName,Password,RealName) values('ZSX','112233','祝世新')
insert into Member(UserName,Password,RealName) values('LH','112233','刘航')				
go

--创建课程表 Course
create table Course
(
	C_ID int primary key identity(1,1), --课程编号
	C_Name varchar(100),					--课程名称
	C_Desc varchar(2000),				--课程描述
	C_img varchar(20),					--课程图片
	M_ID int,							--成员编号
	C_flog int check(C_Flog=0 or C_Flog=1) default(0)--课程状态(0 是  1 否 默认已审核，未审核不可在客户端展示）
)
go
--向课程表添加数据
insert into Course values('微信小程序从0基础到精通','一站式掌握小程序生态，打造站内零基础精通小程序的最佳路径。','01.png',2,0)
insert into Course values('Python高薪工程师精进路线','专为Pythoner进阶高新定制，从高级语法到主流源码再到源码，系统提升高薪技能。','02.png',3,0)
insert into Course values('Android工程师高薪面试突破路线','路线汇集Android高级工程师面试的关键技能，还原面试官视角，助力面试顺利通关。','03.png',4,0)
insert into Course values('5G时代音视频开发与视频直播技术高手之路','对标大岗位需求，从音视频基础入门、处理核心技术到服务器设计开发，全面培养5G时代人才','04.png',5,0)
insert into Course values('从0入门人工智能学习','路线面向0基础用户，从最基础的开发语言Python开始学起，带你进入人工智能的世界。','05.png',2,0)
insert into Course values('Java功能测试转型自动化测试之路','专为想要转型的Java功能测试人群设计，系统吃透自动化测试的专业点。','06.png',3,0)
insert into Course values('大数据零基础入门求职路线','路线面向零基础用户，从入门到大数据综合实战，助力大家快速入行转型。','07.png',4,0)
insert into Course values('大学计算机专业数学学习路线','提升编程内功，精选程序员必修的数学基础课，带你打好人工智能等领域的数学基础。','08.png',5,0)
insert into Course values('Python功能测试到自动化测试路线','自动化测试效率更高，路线旨在帮Python功能测试从业者成功转型。','09.png',2,0)
go

--创建学生课程表 StudentCourse
create table StudentCourse
(
	ID int primary key identity(1,1), --编号
	C_ID int,						  --课程编号
	M_ID int						  --成员（学生）编号
)
go

--向学生课程表添加数据
insert into StudentCourse values(1,6)
insert into StudentCourse values(2,7)
insert into StudentCourse values(3,8)
insert into StudentCourse values(4,9)
insert into StudentCourse values(5,6)
insert into StudentCourse values(6,7)
insert into StudentCourse values(7,8)
insert into StudentCourse values(8,9)
insert into StudentCourse values(9,6)
go

--创建课程评论表 CourseComment
create table CourseComment
(
	ID int primary key identity(1,1), --评论编号
	C_ID int,						  --课程编号
	Info varchar(2000),				  --评论内容
	M_ID int,						  --成员编号
	dtime datetime					  --评论时间
)
go

--向课程评论表CourseComment添加数据
insert into CourseComment values(1,'有些费脑子',6,'2020.09.29 14:27')
insert into CourseComment values(2,'学废了学废了',7,'2020.09.28 13:25')
insert into CourseComment values(3,'懂了懂了这就去求职',8,'2020.09.28 20:19')
insert into CourseComment values(4,'学习到了很多实用的东西！',9,'2020.09.17 08:15')
insert into CourseComment values(5,'现在面试到了一份不错的工作呢',6,'2020.09.29 11:56')
insert into CourseComment values(6,'知识讲的很到位，赞',7,'2020.09.19 12:15')
insert into CourseComment values(7,'爱了爱了，发量明显减少，专业知识明显增多',8,'2020.09.21 18:16')
insert into CourseComment values(8,'我发现我的发际线后移了呢，这是怎么回事',9,'2020.09.30 21:26')
insert into CourseComment values(9,'这知识它不进脑子呀',6,'2020.09.14 06:35')

--查询角色表
select * from Roles

--查询成员表 Member
select * from Member

--查询课程表 Course
select * from Course

--查询学生课程表 StudentCourse
select * from StudentCourse

--查询课程评论表 CourseComment
select * from CourseComment