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

--���ɫ�� Roles�������
insert into Roles values('����Ա','����Ա')
insert into Roles values('��ʦ','��ʦ')
insert into Roles values('ѧ��','ѧ��')
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
	M_Flog int check(M_Flog=0 or M_Flog=1) default(0)--�Ƿ�ͨ�����(0 ��  1 �� Ĭ������ˣ�δͨ����˽�ֹ��½)
)
go

--���Ա���������
insert into Member values('С��admin','admin','�˿���','��',21,'15897703377','��������',1,0)		--��ӹ���Ա
insert into Member values('PH','123456','���','Ů',20,'15748625881','�����人',2,0)			--�����ʦ
insert into Member(UserName,Password,RealName) values('YZW','123456','������')				
insert into Member(UserName,Password,RealName) values('HR','123456','����')					
insert into Member(UserName,Password,RealName) values('HXF','123456','�����')
insert into Member values('YRY','112233','������','��',20,'17683802203','����Т��',3,0)			--���ѧ��
insert into Member(UserName,Password,RealName) values('XWQ','112233','Ф����')				
insert into Member(UserName,Password,RealName) values('ZSX','112233','ף����')
insert into Member(UserName,Password,RealName) values('LH','112233','����')				
go

--�����γ̱� Course
create table Course
(
	C_ID int primary key identity(1,1), --�γ̱��
	C_Name varchar(100),					--�γ�����
	C_Desc varchar(2000),				--�γ�����
	C_img varchar(20),					--�γ�ͼƬ
	M_ID int,							--��Ա���
	C_flog int check(C_Flog=0 or C_Flog=1) default(0)--�γ�״̬(0 ��  1 �� Ĭ������ˣ�δ��˲����ڿͻ���չʾ��
)
go
--��γ̱��������
insert into Course values('΢��С�����0��������ͨ','һվʽ����С������̬������վ���������ͨС��������·����','01.png',2,0)
insert into Course values('Python��н����ʦ����·��','רΪPythoner���׸��¶��ƣ��Ӹ߼��﷨������Դ���ٵ�Դ�룬ϵͳ������н���ܡ�','02.png',3,0)
insert into Course values('Android����ʦ��н����ͻ��·��','·�߻㼯Android�߼�����ʦ���ԵĹؼ����ܣ���ԭ���Թ��ӽǣ���������˳��ͨ�ء�','03.png',4,0)
insert into Course values('5Gʱ������Ƶ��������Ƶֱ����������֮·','�Ա���λ���󣬴�����Ƶ�������š�������ļ�������������ƿ�����ȫ������5Gʱ���˲�','04.png',5,0)
insert into Course values('��0�����˹�����ѧϰ','·������0�����û�����������Ŀ�������Python��ʼѧ�𣬴�������˹����ܵ����硣','05.png',2,0)
insert into Course values('Java���ܲ���ת���Զ�������֮·','רΪ��Ҫת�͵�Java���ܲ�����Ⱥ��ƣ�ϵͳ��͸�Զ������Ե�רҵ�㡣','06.png',3,0)
insert into Course values('�����������������ְ·��','·������������û��������ŵ��������ۺ�ʵս��������ҿ�������ת�͡�','07.png',4,0)
insert into Course values('��ѧ�����רҵ��ѧѧϰ·��','��������ڹ�����ѡ����Ա���޵���ѧ�����Σ��������˹����ܵ��������ѧ������','08.png',5,0)
insert into Course values('Python���ܲ��Ե��Զ�������·��','�Զ�������Ч�ʸ��ߣ�·��ּ�ڰ�Python���ܲ��Դ�ҵ�߳ɹ�ת�͡�','09.png',2,0)
go

--����ѧ���γ̱� StudentCourse
create table StudentCourse
(
	ID int primary key identity(1,1), --���
	C_ID int,						  --�γ̱��
	M_ID int						  --��Ա��ѧ�������
)
go

--��ѧ���γ̱��������
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

--�����γ����۱� CourseComment
create table CourseComment
(
	ID int primary key identity(1,1), --���۱��
	C_ID int,						  --�γ̱��
	Info varchar(2000),				  --��������
	M_ID int,						  --��Ա���
	dtime datetime					  --����ʱ��
)
go

--��γ����۱�CourseComment�������
insert into CourseComment values(1,'��Щ������',6,'2020.09.29 14:27')
insert into CourseComment values(2,'ѧ����ѧ����',7,'2020.09.28 13:25')
insert into CourseComment values(3,'���˶������ȥ��ְ',8,'2020.09.28 20:19')
insert into CourseComment values(4,'ѧϰ���˺ܶ�ʵ�õĶ�����',9,'2020.09.17 08:15')
insert into CourseComment values(5,'�������Ե���һ�ݲ���Ĺ�����',6,'2020.09.29 11:56')
insert into CourseComment values(6,'֪ʶ���ĺܵ�λ����',7,'2020.09.19 12:15')
insert into CourseComment values(7,'���˰��ˣ��������Լ��٣�רҵ֪ʶ��������',8,'2020.09.21 18:16')
insert into CourseComment values(8,'�ҷ����ҵķ����ߺ������أ�������ô����',9,'2020.09.30 21:26')
insert into CourseComment values(9,'��֪ʶ����������ѽ',6,'2020.09.14 06:35')

--��ѯ��ɫ��
select * from Roles

--��ѯ��Ա�� Member
select * from Member

--��ѯ�γ̱� Course
select * from Course

--��ѯѧ���γ̱� StudentCourse
select * from StudentCourse

--��ѯ�γ����۱� CourseComment
select * from CourseComment