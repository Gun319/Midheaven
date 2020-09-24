--ʹ��ϵͳ���ݿ�
use master
go

--�ж� midheavenDB ���ݿ��Ƿ����
if exists(select * from sys.databases where name='midheavenDB')
	drop database midheavenDB
go

--���� midheavenDB ���ݿ�
create database midheavenDB
go

--ʹ�� midheavenDB ���ݿ�
use midheavenDB
go

--�ж� Roles ���Ƿ����
if exists (select 1 from sys.objects where name='Roles')
   drop table Roles
go

--�ж� Member ���Ƿ����
if exists (select 1 from sys.objects where name='Member')
   drop table Member
go

--�ж� Course ���Ƿ����
if exists(select 1 from sys.objects where name='Course')
	drop table Course
go

--�ж� StudentCourse ���Ƿ����
if exists(select 1 from sys.objects where name='StudentCourse')
	drop table StudentCourse
go

--�ж� CourseComment ���Ƿ����
if exists(select 1 from sys.objects where name='CourseComment')
	drop table CourseComment
go

--������ɫ�� Roles
create table Roles
(
	R_ID int primary key identity(1,1), --��ɫ���
	R_Name varchar(10),					--��ɫ����
	R_Desc varchar(20)					--��ɫ����
)
go

--������Ա�� Member
create table Member
(
	M_ID int primary key identity(1,1),		--��Ա���
	UserName varchar(20),					--��¼��
	Password varchar(20),					--����
	RealName varchar(20),					--��ʵ����
	Sex char(2),							--�Ա�
	Age int,								--����
	PhoneNum varchar(11),					--�绰
	Address varchar(50),					--��ַ
	R_ID int,								--��ɫ���
	M_Flog int check(M_Flog=0 or M_Flog=1) default(0),--�Ƿ�ͨ�����(0 ��  1 �� Ĭ������ˣ�δͨ����˽�ֹ��½)
)
go

--�����γ̱� Course
create table Course
(
	C_ID int primary key identity(1,1), --�γ̱��
	C_Name varchar(20),					--�γ�����
	C_Desc varchar(2000),				--�γ�����
	C_img varchar(20),					--�γ�ͼƬ
	M_ID int,							--��Ա���
	C_flog int							--�γ�״̬
)
go

--����ѧ���γ̱� StudentCourse
create table StudentCourse
(
	ID int primary key identity(1,1), --���
	C_ID int,						  --�γ̱��
	M_ID int						  --��Ա��ѧ�������
)
go

--�����γ����۱�
create table CourseComment
(
	ID int primary key identity(1,1), --���۱��
	C_ID int,						  --�γ̱��
	Info varchar(2000),				  --��������
	M_ID int,						  --��Ա���
)
go
