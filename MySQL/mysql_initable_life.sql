use posdb;

# upper case for transation
START TRANSACTION;
# alter session set current_schema= posusr;
# drop table tinvest;
create table tinvest(
acc varchar(10),
invcode int,
amt float,
valuedate date,
constraint pk_inv primary key(acc,invcode,valuedate)
);
select * from tinvest;

create table tinvtype(
invcode int primary key,
invname VARCHAR(20)
);
insert into tinvtype(invcode,invname) values(101,'Fund');
insert into tinvtype(invcode,invname) values(102,'Stock');
insert into tinvtype(invcode,invname) values(201,'Demand');
select * from tinvtype;

# SELECT * from user_cons_columns c where c.table_name = upper('tinvtype');
# desc user_cons_columns;
# desc user_constraints;
# CONSTRAINT_NAME :  SYS_C003697
# select * from user_constraints where TABLE_NAME=upper('tinvtype');
# alter table tinvtype drop constraint SYS_C003697;
# alter table tinvtype add constraint pk_invtype primary key(invcode);

-- Fund type table
-- drop table tfundtype;
create table tfundtype
(
fundtypecode char primary key,
typename varchar(10)
);
-- alter table tfundtype rename column typecode to fundtypecode;
alter table tfundtype add column typenameen varchar(30);
alter table tfundtype add primary key (fundtypecode);
desc tfundtype;

truncate table tfundtype;
insert into tfundtype(fundtypecode,typename,typenameen) values('1','股票型','Stock Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('2','混合型','Hybrid Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('3','债券型','Bond Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('4','指数型','Index Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('5','ETF联接',Null);
insert into tfundtype(fundtypecode,typename,typenameen) values('6','QDII','QDII Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('7','LOF','LOF Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('8','货币型','Monetary Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('9','ICBC8','ICBC Monetary Fund');
insert into tfundtype(fundtypecode,typename,typenameen) values('A','单市场ETF','Single market ETF');
insert into tfundtype(fundtypecode,typename,typenameen) values('B','跨市场ETF','Cross market ETF');
insert into tfundtype(fundtypecode,typename,typenameen) values('C','跨境ETF','Cross border ETF');
insert into tfundtype(fundtypecode,typename,typenameen) values('D','债券ETF','Bond ETF');
insert into tfundtype(fundtypecode,typename,typenameen) values('E','黄金ETF','Gold ETF');
select * from tfundtype where fundtypecode>'9';

# drop table tfund;
create table tfund(
fundcode char(6),
fundname varchar(200),
fundurl VARCHAR(200),
fundtypecode char,
crtDateTime timestamp,
rcdsts char(1)
);
alter table tfund add primary key (fundcode,fundtypecode);
alter table tfund add foreign key fk_fundtype(fundtypecode) references tfundtype(fundtypecode);
# alter table tfund modify fundname varchar(30);
# alter table tfund add(crtDateTime date);
# alter table tfund modify crtDateTime timestamp;
# alter table tfund add(rcdsts char(1) default 'A');
SET SQL_SAFE_UPDATES = 0;
update tfund set rcdsts='A' where 1=1;
update tfund set rcdsts='A' where fundcode in (
'519135',
'002464',
'660014',
'020029',
'519055',
'001395',
'002150',
'003654',
'003947',
'161822',
'161821',
'001767',
'000947',
'002113',
'002572',
'002571',
'001737',
'001020',
'001523',
'004188',
'004187'
);
select  @ROWNO := @ROWNO + 1 as 'RowNo', T.* from tfund T, (SELECT @ROWNO := 0) T3 where rcdsts='T' order by fundcode ;
# select fundcode,fundname,fundurl,fundtypecode,crtDateTime from tfund order by fundname;
# alter table tfunds rename to tfund;
# alter table tfund rename column typecode to fundtypecode;
# alter table tfund add(typecode char);
# alter table tfund drop constraint fk_fundtype;
# alter table tfund add(fundurl VARCHAR(50));
# truncate table tfund;
# commit;
# update tfund set fundurl='http://fund.eastmoney.com/f10/jdzf_001061.html' where fundcode='001061';
# update tfund set typecode='1' where  fundcode='340009';
# select * from tfund order by fundtypecode asc, FUNDCODE asc;
# select * from tfund where fundcode in ('290008','160135','000041','501025');
# select * from tfund where fundtypecode='8';
# select * from tfund where fundtypecode='9';
#truncate table tfund;
select count(1) from tfund;  #3371  # 3458
select * from tfund;
select * from tfund where fundtypecode>'9';
select * from tfund where fundcode='486002';
select fundcode,count(1) from tfund group by fundcode having count(1)>1;
# commit;
/*
1.
13-4月 -17 05.37.49.634000000 下午
13-4月 -17 05.40.15.610000000 下午
*/

# COMMIT;
# tfundraterpt table
# drop table tfundraterpt;
create table tfundraterpt (
fundcode char(6),
sfundAmt varchar(10),
fundAmt float,
curyearRate varchar(8),
lst1wRate varchar(8),
lst1mRate varchar(8),
lst3mRate varchar(8),
lst6mRate varchar(8),
lst1yRate varchar(8),
lst2yRate varchar(8),
lst3yRate varchar(8),
lst5yRate varchar(8),
sinceFoundRate varchar(8),
curyearPct varchar(8),
lst1wPct varchar(8),
lst1mPct varchar(8),
lst3mPct varchar(8),
lst6mPct varchar(8),
lst1yPct varchar(8),
lst2yPct varchar(8),
lst3yPct varchar(8),
lst5yPct varchar(8),
sinceFoundPct varchar(8),
lstUpdDate date,
rcdtstm timestamp
);

-- add column,
-- SQL 错误: ORA-00904: : 标识符无效
-- alter table FUNDRATERPT add(lst1wPct,number);  -- ==> no need comma
/*
-- drop column
alter table fundraterpt drop column fundAmt;

#alter table tfundraterpt add primary key(fundcode);
#alter table tfundraterpt add (rcdtstm timestamp);
#alter table tfundraterpt modify rcdtstm timestamp;
alter table tfundraterpt modify LST1WPCT varchar(8);
*/
/*
alter table fundraterpt add(fundAmt float);
alter table fundraterpt add(sfundAmt VARCHAR2(10));
alter table fundraterpt add(lst5yPct number);     
--alter table fundraterpt add(sinceFoundPct number);
alter table fundraterpt add(lstUpdDate,date);
--modify
alter table fundraterpt modify(sinceFoundPct VARCHAR2(8));
*/

/*
-- add
--alter table fundraterpt add(lst2yRate VARCHAR2(8));
alter table fundraterpt add(lstUpdDate date); 
*/

# select * from tfundraterpt order by LSTUPDDATE asc ;
# select count(1) from FUNDRATERPT where LSTUPDDATE='26-5月 -17';
# select count(1) from FUNDRATERPT where LSTUPDDATE<'26-5月 -17' OR LSTUPDDATE IS NULL;   -- 286
# select * from FUNDRATERPT where fundAmt is not null order by fundAmt desc;
# select * from FUNDRATERPT where FUNDCODE='000425';
# select * from FUNDRATERPT where LSTUPDDATE<'26-5月 -17' OR LSTUPDDATE IS NULL;
# select a.* from Fund a where not exists (select b.fundCode from FundRateRpt b where b.fundCode=a.fundCode and (b.lstUpdDate>'25-5月 -17' ) ) order by a.fundTypecode asc, a.fundCode asc;
# select substr(fundAmt,0,instr(fundAmt,'亿')-1),instr(fundAmt,'亿') from FUNDRATERPT where fundAmt is not null order by substr(fundAmt,0,instr(fundAmt,'亿')-1);
# SELECT DATE() FROM DUAL;
-- ORA-00905: 缺失关键字     00905. 00000 -  "missing keyword"
# SELECT * INTO FUNDRATERPTBCK FROM fundraterpt;  -- this MS-SQL
# drop table FUNDRATERPTBCK;
# CREATE TABLE FUNDRATERPTBCK AS SELECT * FROM FUNDRATERPT;
# COMMIT;
# truncate table FUNDRATERPTBCK;
# insert into FUNDRATERPTBCK select * from FUNDRATERPT;
# select * from FUNDRATERPTBCK;
# select * from FUNDRATERPTBCK where FUNDCODE='000082';
# select * from tfund a where not exists(select 1 from FUNDRATERPT where fundcode=a.fundcode);
# order by a.fundtypecode asc, a.fundcode asc;
# select count(1) from tfund a where exists(select 1 from FUNDRATERPT where fundcode=a.fundcode);
# select count(1) from tfund a where not exists(select 1 from FUNDRATERPT where fundcode=a.fundcode);
# select * from FUNDRATERPT where fundAmt is not null;s
# select * from FUNDRATERPT order by LSTUPDDATE ASC;
# select fundcode,lst1wRate,lst1mRate,lst3mRate,lst6mRate from FUNDRATERPT where lst1wRate='优秀' and lst1mRate='优秀' and lst3mRate='优秀' and lst6mRate='优秀' and curyearRate='优秀' and lst1yRate='优秀';

# fund rate report
select * from tfundraterpt where fundcode='519606';
select @ROWNO := @ROWNO + 1 as 'RowNo',T.* from tfundraterpt T,(SELECT @ROWNO := 0) T3 order by rcdtstm;
select * from tfundraterpt where lstUpdDate='2017-11-30';


select count(1) from tfund;  #--3458 
select count(1) from tfundraterpt where rcdtstm<'2018-06-21';
desc tfundraterpt;

select @ROWNO := @ROWNO + 1 as 'RowNo', T2.fundurl,T1.* from tfundraterpt T1 ,  tfund T2 ,(SELECT @ROWNO := 0) T3 
where 1=1 and T1.fundcode=T2.fundcode and rcdtstm>'2018-01-19'
#and T1.fundcode in ('540006','002464','660014');
order by rcdtstm desc;

select @ROWNO := @ROWNO + 1 as 'RowNo', T2.fundurl,T1.* from tfundraterpt T1 ,  tfund T2 ,(SELECT @ROWNO := 0) T3 
where 1=1 and T1.fundcode=T2.fundcode
order by rcdtstm;

# All fund
select a.fundcode, a.fundname,c.fundtypecode,a.fundurl,b.fundAmt,b.lst1wPct,b.lst1mPct,b.lst3mPct,b.lst6mPct,b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct 
from tfund a join tfundraterpt b on a.fundcode=b.fundcode join tfundtype c on a.fundtypecode=c.fundtypecode 
where b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀' 
and b.lst2yRate='优秀' and b.lst3yRate='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc;

# '1','ETF'
select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst3mPct,b.lst6mPct,b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct,c.fundtypecode from tfund a join tfundraterpt b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode>'9' 
and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' 
#and b.curyearRate='优秀' and b.lst1yRate='优秀' 
#and b.lst2yRate='优秀' and b.lst3yRate='优秀' and b.lst5yRate='优秀'
or a.fundcode='510050'
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc;

# '1','股票型'
select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct   from tfund a join tfundraterpt b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='1' 
and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀' 
and b.lst2yRate='优秀' and b.lst3yRate='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc;

select a.fundcode, a.fundname,a.fundurl,b.fundAmt,
b.curyearPct,b.lst1wPct,b.lst1mPct,b.lst3mPct,b.lst6mPct,
b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct  
from tfund a join tfundraterpt b on a.fundcode=b.fundcode join tfundtype c on a.fundtypecode=c.fundtypecode 
where c.fundtypecode='1' and b.lst1wRate in ('优秀','良好') and b.lst1mRate in ('优秀','良好') and b.lst3mRate in ('优秀','良好') and b.lst6mRate in ('优秀','良好')
and b.curyearRate in ('优秀','良好') and b.lst1yRate in ('优秀','良好')
and b.lst2yRate in ('优秀','良好') and b.lst3yRate in ('优秀','良好') and b.lst5yRate in ('优秀','良好')
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc,b.lst3yPct desc,b.lst5yPct desc;

# ('3','债券型');
select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst1yPct,b.lst2yPct from tfund a join tfundraterpt b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='3' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
and b.LST2YRATE='优秀' 
# and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc,b.lst1yPct,b.lst2yPct;
select * from tfund where fundname like '%债券%' order by fundtypecode;

# '4','指数型'
select a.fundcode, a.fundname,a.fundurl,b.lst1yPct,b.lst2yPct from tfund a join tfundraterpt b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='4' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
# and b.LST2YRATE='优秀' and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.lst1yPct,b.lst2yPct;

# '5','ETF联接'
select a.fundcode, a.fundname,a.fundurl,b.lst1yPct,b.lst2yPct from tfund a join tfundraterpt b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='5' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
# and b.LST2YRATE='优秀' and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.lst1yPct,b.lst2yPct;

#  '6','QDII'
select a.fundcode, a.fundname,c.fundtypecode,a.fundurl,b.fundAmt,b.lst1wPct,b.lst1mPct,b.lst3mPct,b.lst6mPct,b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct from tfund a join tfundraterpt b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where 
# c.fundtypecode='6' 
b.lstUpdDate='2017-10-26' AND b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
and b.LST2YRATE='优秀' #and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc, b.lst2yPct desc;

select a.fundcode, a.fundname,c.fundtypecode,a.fundurl,b.fundAmt,b.lst1wPct,b.lst1mPct,b.lst3mPct,b.lst6mPct,b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct from tfund a join tfundraterpt b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where 
# c.fundtypecode='6' 
b.lstUpdDate='2017-10-26' AND b.lst1wRate in ('优秀','良好') and b.lst1mRate in ('优秀','良好') and b.lst3mRate in ('优秀','良好') and b.lst6mRate in ('优秀','良好')
and b.curyearRate in ('优秀','良好') and b.lst1yRate in ('优秀','良好')
and b.lst2yRate in ('优秀','良好') and b.lst3yRate in ('优秀','良好') and b.lst5yRate in ('优秀','良好')
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc;

# '8','货币型'
select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct  
from tfund a join tfundraterpt b on a.fundcode=b.fundcode join tfundtype c on a.fundtypecode=c.fundtypecode 
where c.fundtypecode='8' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
and b.LST2YRATE='优秀' #and b.LST3YRATE='优秀' #and b.lst5yRate='优秀'
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc;

select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst1yPct,b.lst2yPct,b.lst3yPct,b.lst5yPct  
from tfund a join tfundraterpt b on a.fundcode=b.fundcode join tfundtype c on a.fundtypecode=c.fundtypecode 
where c.fundtypecode='8' and b.lst1wRate in ('优秀','良好') and b.lst1mRate in ('优秀','良好') and b.lst3mRate in ('优秀','良好') and b.lst6mRate in ('优秀','良好')
and b.curyearRate in ('优秀','良好') and b.lst1yRate in ('优秀','良好')
#and b.lst2yRate in ('优秀','良好') #and b.lst3yRate in ('优秀','良好') #and b.lst5yRate in ('优秀','良好')
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc;

select * from tfundraterpt where fundcode='001061';
select @ROWNO := @ROWNO + 1 as 'RowNo',T.* from tfund T,(SELECT @ROWNO := 0) T3
 where fundcode in ('000837','004060','002758','001666','000638',
                    '340005','002852');
select a.fundcode, a.fundname,a.fundurl,b.lst1wRate,b.lst1mRate,b.lst3mRate,b.lst6mRate,b.curyearRate,b.lst1yRate
from tfund a join tfundraterpt b on a.fundcode=b.fundcode  and instr(fundname,'B')=0 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='8' and b.lst1wRate in ('优秀','良好') and b.lst1mRate in ('优秀','良好') and b.lst3mRate in ('优秀','良好') and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀';

select a.fundcode, a.fundname,a.fundurl,b.lst1wRate,b.lst1mRate,b.lst3mRate,b.lst6mRate,b.curyearRate,b.lst1yRate
from tfund a join tfundraterpt b on a.fundcode=b.fundcode  and instr(a.fundname,'工银')>0 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='8' ;

# select * from FUNDRATERPT where  fundcode='000082';

# fund steps
# drop table tfundratestep;
create table tfundratestep(
fundcode char(6),
seq int,
controlid varchar(100),
controlname varchar(100),
action char not null,
inputvalue varchar(100) null,
constraint pk_fundstep primary key(fundcode,seq)
);
select * from tfundratestep;
alter table tfundratestep add foreign key fk_controlact(action) references tcontrolaction(action);

insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','1','TANGRAM__PSP_3__smsSwitch','','2','');
insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','2','TANGRAM__PSP_3__smsPhone','','1','13536496649');
insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','3','TANGRAM__PSP_3__smsTimer','','2','');
insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','4','TANGRAM__PSP_3__smsRegPromptBtn','','2','');
select * from tfundratestep;
# control action table
create table tcontrolaction(
controltype varchar(10),  -- html control type
action char,
actiondes varchar(10)
);
alter table tcontrolaction add primary key(controltype,action);
insert into tcontrolaction(controltype,action,actiondes) values('textbox','1','input');
insert into tcontrolaction(controltype,action,actiondes) values('button','2','click');
# insert into tcontrolaction(controltype,action,actiondes) values('','','');
select * from tcontrolaction;

rollback;





