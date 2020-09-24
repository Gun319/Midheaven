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
	M_Flog int check(M_Flog=0 or M_Flog=1) default(0),--是否通过审核(0 是  1 否 默认已审核，未通过审核禁止登陆)
)
go

--创建课程表 Course
create table Course
(
	C_ID int primary key identity(1,1), --课程编号
	C_Name varchar(20),					--课程名称
	C_Desc varchar(2000),				--课程描述
	C_img varchar(20),					--课程图片
	M_ID int,							--成员编号
	C_flog int							--课程状态
)
go

--创建学生课程表 StudentCourse
create table StudentCourse
(
	ID int primary key identity(1,1), --编号
	C_ID int,						  --课程编号
	M_ID int						  --成员（学生）编号
)
go

--创建课程评论表
create table CourseComment
(
	ID int primary key identity(1,1), --评论编号
	C_ID int,						  --课程编号
	Info varchar(2000),				  --评论内容
	M_ID int,						  --成员编号
)
go
