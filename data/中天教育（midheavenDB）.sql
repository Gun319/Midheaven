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
insert into Member values('admin','admin','潘俊杰','男',21,'15897703377','湖北襄阳',1,0)		--添加管理员
insert into Member values('彭老师','123456','彭慧','女',20,'15748625881','湖北武汉',2,0)			--添加老师
insert into Member(UserName,Password,RealName,R_ID) values('杨老师','123456','杨智雯',2)				
insert into Member(UserName,Password,RealName,R_ID) values('黄老师','123456','黄蓉',2)					
insert into Member(UserName,Password,RealName,R_ID) values('何老师','123456','何秀芬',2)
insert into Member values('杨同学','112233','杨如意','男',20,'17683802203','湖北孝感',3,0)			--添加学生
insert into Member(UserName,Password,RealName,R_ID) values('肖同学','112233','肖文清',3)				
insert into Member(UserName,Password,RealName,R_ID) values('祝同学','112233','祝世新',3)
insert into Member(UserName,Password,RealName,R_ID) values('刘同学','112233','刘航',3)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('赵同学','112233','赵六',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('钱同学','112233','钱进',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('孙同学','112233','孙悟空',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('李同学','112233','李四',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('猪同学','112233','猪八戒',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('沙同学','112233','沙悟净',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('唐同学','112233','唐三藏',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('姚同学','112233','姚乾沭',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('程同学','112233','程成',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('汪同学','112233','汪二狗',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('吴同学','112233','吴邪',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('冯同学','112233','冯小风',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('吕同学','112233','吕小布',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('诸葛同学','112233','诸葛亮',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('魏同学','112233','魏亮',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('易同学','112233','易良',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('窦同学','112233','窦娥',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('郑同学','112233','郑云',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('高同学','112233','高亮',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('贾同学','112233','贾路',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('江同学','112233','江童',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('梅同学','112233','梅盛',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('林同学','112233','林刁',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('项同学','112233','项祝',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('韩同学','112233','韩杨',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('蒋同学','112233','蒋沈',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('金同学','112233','金魏',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('陶同学','112233','陶姜',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('戚同学','112233','戚谢',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('邹同学','112233','邹喻',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('柏同学','112233','柏水',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('云同学','112233','云苏',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('彭同学','112233','彭郎',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('鲁同学','112233','鲁韦',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('袁同学','112233','袁柳',3,0)	
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('史同学','112233','史唐',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('雷同学','112233','雷贺',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('倪同学','112233','倪汤',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('罗同学','112233','罗毕',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('郝同学','112233','郝邬',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('安同学','112233','安常',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('时同学','112233','时傅',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('齐同学','112233','齐康',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('伍同学','112233','伍余',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('顾同学','112233','顾孟',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('平同学','112233','平黄',3,0)
insert into Member(UserName,Password,RealName,R_ID,M_Flog) values('和同学','112233','和穆萧',3,0)				
go

--创建课程表 Course
create table Course
(
	C_ID int primary key identity(1,1), --课程编号
	C_Name varchar(100),					--课程名称
	C_Desc varchar(2000),				--课程描述
	C_img varchar(20),					--课程图片
	M_ID int,							--成员编号
	C_flog int check(C_flog=0 or C_flog=1) default(0)--课程状态(0 是  1 否 默认已审核，未审核不可在客户端展示）
)
go
--向课程表添加数据
insert into Course values('微信小程序从0基础到精通','一站式掌握小程序生态，打造站内零基础精通小程序的最佳路径。','01.png',2,0)
insert into Course values('Python高薪工程师精进路线','专为Pythoner进阶高新定制，从高级语法到主流源码再到源码，系统提升高薪技能。','02.png',3,0)
insert into Course values('Android工程师高薪面试突破路线','路线汇集Android高级工程师面试的关键技能，还原面试官视角，助力面试顺利通关。','03.png',4,0)
insert into Course values('5G时代音视频开发与视频直播技术高手之路','对标大岗位需求，从音视频基础入门、处理核心技术到服务器设计开发，全面培养5G时代人才','04.png',5,0)
insert into Course values('从0入门人工智能学习','路线面向0基础用户，从最基础的开发语言Python开始学起，带你进入人工智能的世界。','05.jpg',2,0)
insert into Course values('Java功能测试转型自动化测试之路','专为想要转型的Java功能测试人群设计，系统吃透自动化测试的专业点。','06.png',3,0)
insert into Course values('大数据零基础入门求职路线','路线面向零基础用户，从入门到大数据综合实战，助力大家快速入行转型。','07.png',4,0)
insert into Course values('大学计算机专业数学学习路线','提升编程内功，精选程序员必修的数学基础课，带你打好人工智能等领域的数学基础。','08.png',5,0)
insert into Course values('Python功能测试到自动化测试路线','自动化测试效率更高，路线旨在帮Python功能测试从业者成功转型。','09.png',2,0)
insert into Course values('Laravel重构企业级电商项目','一站式构建项目重构技术完整体系，全面强化你的职场核心竞争力！','10.png',2,0)				--
insert into Course values('Vue3.0（正式版） + TS 仿知乎专栏企业级项目','第一时间解锁Vue3.0 ，先人一步掌握未来发展趋势！','15.jpg',3,0)
insert into Course values('体系课—数据可视化入门到精通打造前端差异化竞争力','数据可视化就是前端未来的标配，就是前端未来竞争的破冰利器。','13.jpg',4,0)
insert into Course values('PyTorch入门到进阶实战计算机视觉与自然语言处理项目','理论基础+技术讲解+实战开发，快速掌握PyTorch框架。','14.png',5,0)
insert into Course values('Spring Cloud分布式微服务实战养成应对复杂业务的综合技术能力','分布式/前后端分离/项目分层聚合 一体化开发门户平台＋媒体中心+运营中心3大业务平台。','16.png',2,0)
insert into Course values('全面系统Python3.8入门+进阶（程序员必备第二语言）','从基础语法开始，体验python语言之美。','18.jpg',3,0)
insert into Course values('2020 重学C++重构你的C++知识体系','百度10年C++开发工程师的经验心得，带你深入底层、深入细节、深入思想，重学C++。','17.png',4,0)
insert into Course values('微信小程序入门与实战-2020全新版','神课再迭代，历时4年，学员20000+，始终与微信官方同步，缔造全网首屈一指的精品课程。','11.jpg',5,0)
go

--创建学生课程表 StudentCourse
create table StudentCourse
(
	ID int primary key identity(1,1), --编号
	C_ID int,						  --课程编号
	M_ID int						  --成员（学生）编号
)
go

select COUNT(M_ID) from StudentCourse group by(C_ID)
--根据课程id进行分组，显示课程id  nae
select c.C_ID,C_Name,C_Desc,C_img,C_flog,COUNT(sc.C_ID)as'选课人数' from Course c,StudentCourse sc 
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
insert into CourseComment values(1,'有些费脑子。',6,'2020.09.29 14:27')
insert into CourseComment values(2,'学废了学废了。',7,'2020.09.28 13:25')
insert into CourseComment values(3,'懂了懂了这就去求职。',8,'2020.09.28 20:19')
insert into CourseComment values(4,'学习到了很多实用的东西！',9,'2020.09.17 08:15')
insert into CourseComment values(5,'现在面试到了一份不错的工作呢。',6,'2020.09.29 11:56')
insert into CourseComment values(6,'知识讲的很到位，赞！',7,'2020.09.19 12:15')
insert into CourseComment values(7,'爱了爱了，发量明显减少，专业知识明显增多。',8,'2020.09.21 18:16')
insert into CourseComment values(8,'发际线后移了，这是怎么回事？',9,'2020.09.30 21:26')
insert into CourseComment values(9,'这知识它不进脑子呀。',6,'2020.09.14 06:35')

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