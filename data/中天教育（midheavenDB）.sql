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
insert into Member values('admin','admin','�˿���','��',21,'15897703377','��������',1,0)		--��ӹ���Ա
insert into Member values('����ʦ','123456','���','Ů',20,'15748625881','�����人',2,0)			--�����ʦ
insert into Member(UserName,Password,RealName,R_ID) values('����ʦ','123456','������',2)				
insert into Member(UserName,Password,RealName,R_ID) values('����ʦ','123456','����',2)					
insert into Member(UserName,Password,RealName,R_ID) values('����ʦ','123456','�����',2)
insert into Member values('��ͬѧ','112233','������','��',20,'17683802203','����Т��',3,0)			--���ѧ��
insert into Member(UserName,Password,RealName,R_ID) values('Фͬѧ','112233','Ф����',3)				
insert into Member(UserName,Password,RealName,R_ID) values('ףͬѧ','112233','ף����',3)
insert into Member(UserName,Password,RealName,R_ID) values('��ͬѧ','112233','����',3)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('Ǯͬѧ','112233','Ǯ��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','�����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��˽�',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('ɳͬѧ','112233','ɳ��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','������',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('Ҧͬѧ','112233','ҦǬ��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','�̳�',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','������',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��а',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��С��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��С��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('���ͬѧ','112233','�����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('κͬѧ','112233','κ��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('�ͬѧ','112233','��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('֣ͬѧ','112233','֣��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��·',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��ͯ',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('÷ͬѧ','112233','÷ʢ',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','�ֵ�',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��ף',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��κ',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','�ս�',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��л',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','��ˮ',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('³ͬѧ','112233','³Τ',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('Ԭͬѧ','112233','Ԭ��',3,0)	
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('ʷͬѧ','112233','ʷ��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','�׺�',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','�ޱ�',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('ʱͬѧ','112233','ʱ��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','�뿵',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','����',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('ƽͬѧ','112233','ƽ��',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('��ͬѧ','112233','������',3,0)				
go

--�����γ̱� Course
create table Course
(
	C_ID int primary key identity(1,1), --�γ̱��
	C_Name varchar(100),					--�γ�����
	C_Desc varchar(2000),				--�γ�����
	C_img varchar(20),					--�γ�ͼƬ
	M_ID int,							--��Ա���
	C_flog int check(C_flog=0 or C_flog=1) default(0)--�γ�״̬(0 ��  1 �� Ĭ������ˣ�δ��˲����ڿͻ���չʾ��
)
go
--��γ̱��������
insert into Course values('΢��С�����0��������ͨ','һվʽ����С������̬������վ���������ͨС��������·����','01.png',2,0)
insert into Course values('Python��н����ʦ����·��','רΪPythoner���׸��¶��ƣ��Ӹ߼��﷨������Դ���ٵ�Դ�룬ϵͳ������н���ܡ�','02.png',3,0)
insert into Course values('Android����ʦ��н����ͻ��·��','·�߻㼯Android�߼�����ʦ���ԵĹؼ����ܣ���ԭ���Թ��ӽǣ���������˳��ͨ�ء�','03.png',4,0)
insert into Course values('5Gʱ������Ƶ��������Ƶֱ����������֮·','�Ա���λ���󣬴�����Ƶ�������š�������ļ�������������ƿ�����ȫ������5Gʱ���˲�','04.png',5,0)
insert into Course values('��0�����˹�����ѧϰ','·������0�����û�����������Ŀ�������Python��ʼѧ�𣬴�������˹����ܵ����硣','05.jpg',2,0)
insert into Course values('Java���ܲ���ת���Զ�������֮·','רΪ��Ҫת�͵�Java���ܲ�����Ⱥ��ƣ�ϵͳ��͸�Զ������Ե�רҵ�㡣','06.png',3,0)
insert into Course values('�����������������ְ·��','·������������û��������ŵ��������ۺ�ʵս��������ҿ�������ת�͡�','07.png',4,0)
insert into Course values('��ѧ�����רҵ��ѧѧϰ·��','��������ڹ�����ѡ����Ա���޵���ѧ�����Σ��������˹����ܵ��������ѧ������','08.png',5,0)
insert into Course values('Python���ܲ��Ե��Զ�������·��','�Զ�������Ч�ʸ��ߣ�·��ּ�ڰ�Python���ܲ��Դ�ҵ�߳ɹ�ת�͡�','09.png',2,0)
insert into Course values('Laravel�ع���ҵ��������Ŀ','һվʽ������Ŀ�ع�����������ϵ��ȫ��ǿ�����ְ�����ľ�������','10.png',2,0)				--
insert into Course values('Vue3.0����ʽ�棩 + TS ��֪��ר����ҵ����Ŀ','��һʱ�����Vue3.0 ������һ������δ����չ���ƣ�','15.jpg',3,0)
insert into Course values('��ϵ�Ρ����ݿ��ӻ����ŵ���ͨ����ǰ�˲��컯������','���ݿ��ӻ�����ǰ��δ���ı��䣬����ǰ��δ���������Ʊ�������','13.jpg',4,0)
insert into Course values('PyTorch���ŵ�����ʵս������Ӿ�����Ȼ���Դ�����Ŀ','���ۻ���+��������+ʵս��������������PyTorch��ܡ�','14.png',5,0)
insert into Course values('Spring Cloud�ֲ�ʽ΢����ʵս����Ӧ�Ը���ҵ����ۺϼ�������','�ֲ�ʽ/ǰ��˷���/��Ŀ�ֲ�ۺ� һ�廯�����Ż�ƽ̨��ý������+��Ӫ����3��ҵ��ƽ̨��','16.png',2,0)
insert into Course values('ȫ��ϵͳPython3.8����+���ף�����Ա�ر��ڶ����ԣ�','�ӻ����﷨��ʼ������python����֮����','18.jpg',3,0)
insert into Course values('2020 ��ѧC++�ع����C++֪ʶ��ϵ','�ٶ�10��C++��������ʦ�ľ����ĵã���������ײ㡢����ϸ�ڡ�����˼�룬��ѧC++��','17.png',4,0)
insert into Course values('΢��С����������ʵս-2020ȫ�°�','����ٵ�������ʱ4�꣬ѧԱ20000+��ʼ����΢�Źٷ�ͬ��������ȫ������һָ�ľ�Ʒ�γ̡�','11.jpg',5,0)
go

--����ѧ���γ̱� StudentCourse
create table StudentCourse
(
	ID int primary key identity(1,1), --���
	C_ID int,						  --�γ̱��
	M_ID int						  --��Ա��ѧ�������
)
go

select COUNT(M_ID) from StudentCourse group by(C_ID)
--���ݿγ�id���з��飬��ʾ�γ�id  nae
select c.C_ID,C_Name,C_Desc,C_img,C_flog,COUNT(sc.C_ID)as'ѡ������' from Course c,StudentCourse sc 
	where c.M_ID=2 and c.C_ID=sc.C_ID 
	group by c.C_ID,C_Name,C_Desc,C_img,C_flog,sc.C_ID


SELECT 
    [GroupBy1].[K1] AS [C_ID], 
    [GroupBy1].[K6] AS [C1], 
    [GroupBy1].[K2] AS [C_Name], 
    [GroupBy1].[K3] AS [C_Desc], 
    [GroupBy1].[K4] AS [C_img], 
    [GroupBy1].[K5] AS [C_flog], 
    [GroupBy1].[A1] AS [C2]
    FROM ( SELECT 
        [Filter1].[K1] AS [K1], 
        [Filter1].[K2] AS [K2], 
        [Filter1].[K3] AS [K3], 
        [Filter1].[K4] AS [K4], 
        [Filter1].[K5] AS [K5], 
        [Filter1].[K6] AS [K6], 
        COUNT([Filter1].[A1]) AS [A1]
        FROM ( SELECT 
            [Extent1].[C_ID] AS [K1], 
            [Extent1].[C_Name] AS [K2], 
            [Extent1].[C_Desc] AS [K3], 
            [Extent1].[C_img] AS [K4], 
            [Extent1].[C_flog] AS [K5], 
            1 AS [K6], 
            1 AS [A1]
            FROM  [dbo].[Course] AS [Extent1]
            INNER JOIN [dbo].[StudentCourse] AS [Extent2] ON [Extent1].[C_ID] = [Extent2].[C_ID]
            WHERE 2 = [Extent1].[M_ID]
        )  AS [Filter1]
        GROUP BY [K1], [K2], [K3], [K4], [K5], [K6]
    )  AS [GroupBy1]
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
insert into StudentCourse values(10,10)
insert into StudentCourse values(11,11)
insert into StudentCourse values(12,12)
insert into StudentCourse values(13,13)
insert into StudentCourse values(14,14)
insert into StudentCourse values(15,15)
insert into StudentCourse values(16,16)
insert into StudentCourse values(17,17)
insert into StudentCourse values(1,18)		--
insert into StudentCourse values(2,19)
insert into StudentCourse values(3,20)
insert into StudentCourse values(4,21)
insert into StudentCourse values(5,22)
insert into StudentCourse values(6,23)
insert into StudentCourse values(7,24)
insert into StudentCourse values(8,25)
insert into StudentCourse values(9,26)
insert into StudentCourse values(10,27)
insert into StudentCourse values(11,28)
insert into StudentCourse values(12,29)
insert into StudentCourse values(13,30)
insert into StudentCourse values(14,31)
insert into StudentCourse values(15,32)
insert into StudentCourse values(16,33)
insert into StudentCourse values(17,34)
insert into StudentCourse values(1,35)		--
insert into StudentCourse values(2,36)
insert into StudentCourse values(3,37)
insert into StudentCourse values(4,38)
insert into StudentCourse values(5,39)
insert into StudentCourse values(6,40)
insert into StudentCourse values(7,41)
insert into StudentCourse values(8,42)
insert into StudentCourse values(9,43)
insert into StudentCourse values(10,44)
insert into StudentCourse values(11,45)
insert into StudentCourse values(12,46)
insert into StudentCourse values(13,47)
insert into StudentCourse values(14,48)
insert into StudentCourse values(15,49)
insert into StudentCourse values(16,50)
insert into StudentCourse values(17,51)
insert into StudentCourse values(12,52)
insert into StudentCourse values(13,53)
insert into StudentCourse values(14,54)
insert into StudentCourse values(15,55)
insert into StudentCourse values(16,56)
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
insert into CourseComment values(1,'��Щ�����ӡ�',6,'2020.09.29 14:27')
insert into CourseComment values(2,'ѧ����ѧ���ˡ�',7,'2020.09.28 13:25')
insert into CourseComment values(3,'���˶������ȥ��ְ��',8,'2020.09.28 20:19')
insert into CourseComment values(4,'ѧϰ���˺ܶ�ʵ�õĶ�����',9,'2020.09.17 08:15')
insert into CourseComment values(5,'�������Ե���һ�ݲ���Ĺ����ء�',6,'2020.09.29 11:56')
insert into CourseComment values(6,'֪ʶ���ĺܵ�λ���ޣ�',7,'2020.09.19 12:15')
insert into CourseComment values(7,'���˰��ˣ��������Լ��٣�רҵ֪ʶ�������ࡣ',8,'2020.09.21 18:16')
insert into CourseComment values(8,'�����ߺ����ˣ�������ô���£�',9,'2020.09.30 21:26')
insert into CourseComment values(9,'��֪ʶ����������ѽ��',6,'2020.09.14 06:35')

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