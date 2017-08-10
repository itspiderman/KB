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
insert into tfundtype(fundtypecode,typename) values('1','股票型');
insert into tfundtype(fundtypecode,typename) values('2','混合型');
insert into tfundtype(fundtypecode,typename) values('3','债券型');
insert into tfundtype(fundtypecode,typename) values('4','指数型');
insert into tfundtype(fundtypecode,typename) values('5','ETF联接');
insert into tfundtype(fundtypecode,typename) values('6','QDII');
insert into tfundtype(fundtypecode,typename) values('7','LOF');
insert into tfundtype(fundtypecode,typename) values('8','货币型');
insert into tfundtype(fundtypecode,typename) values('9','ICBC8');
select * from tfundtype;

create table tfund(
fundcode char(6),
fundname varchar(30),
fundurl VARCHAR(50),
fundtypecode char,
crtDateTime timestamp
);
alter table tfund add primary key (fundcode);
alter table tfund add foreign key fk_fundtype(fundtypecode) references tfundtype(fundtypecode);
# alter table tfund modify fundname varchar(30);
# alter table tfund add(crtDateTime date);
# alter table tfund modify crtDateTime timestamp;
select * from tfund;

# alter table tfunds rename to tfund;
# alter table tfund rename column typecode to fundtypecode;
# select fundcode,fundname,fundurl,fundtypecode,crtDateTime from tfund order by fundname;
# truncate table tfund;
# commit;
# alter table tfund add(fundurl VARCHAR(50));
# select length('http://fund.eastmoney.com/001781.html') from tfund;
# update tfund set fundurl='http://fund.eastmoney.com/001781.html' where fundcode='340009';
# alter table tfund add(typecode char);
# alter table tfund drop constraint fk_fundtype;
# update tfund set typecode='1' where  fundcode='340009';
# select * from tfund order by fundtypecode asc, FUNDCODE asc;
# select * from tfund where fundcode in ('290008','160135','000041','501025');
# select * from tfund where fundtypecode='8';
# select * from tfund where fundtypecode='9';
# select count(1) from tfund;
# select fundurl,length(fundurl),substr(fundurl,1,26)||'f10/jdzf_'||substr(fundurl,27,11) from tfund where fundurl not like '%f10%';
# update tfund set fundurl=substr(fundurl,1,26)||'f10/jdzf_'||substr(fundurl,27,11) where fundurl not like '%f10%';
# create table tfundbk as select * from tfund;
# select count(1) from tfundbk;
# drop table TFunds;
# drop table TTUNDs;
# commit;
/*
1.
13-4月 -17 05.37.49.634000000 下午
13-4月 -17 05.40.15.610000000 下午
*/

# COMMIT;
# FUNDRATERPT table
# drop table FUNDRATERPT;
create table fundraterpt (
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
lst1wPct float,
lst1mPct float,
lst3mPct float,
lst6mPct float,
lst1yPct float,
lst2yPct float,
lst3yPct float,
lst5yPct float,
sinceFoundPct float,
lstUpdDate date
);
alter table fundraterpt add primary key(fundcode);

-- add column,
-- SQL 错误: ORA-00904: : 标识符无效
-- alter table FUNDRATERPT add(lst1wPct,number);  -- ==> no need comma
/*
-- drop column
alter table fundraterpt drop column fundAmt;
--alter table fundraterpt drop column LST1WPCT;
alter table fundraterpt drop column LST1MPCT;
alter table fundraterpt drop column LST3MPCT;
alter table fundraterpt drop column LST6MPCT;
alter table fundraterpt drop column CURYEARPCT;
alter table fundraterpt drop column LST1YPCT;
alter table fundraterpt drop column LST2YPCT;
alter table fundraterpt drop column LST3YPCT;
alter table fundraterpt drop column LST5YPCT;
alter table fundraterpt drop column SINCEFOUNDPCT;
*/
/*

alter table fundraterpt add(fundAmt float);
alter table fundraterpt add(sfundAmt VARCHAR2(10));

alter table FUNDRATERPT add(lst1wPct number);
--alter table fundraterpt add(lst1mPct number);     
--alter table fundraterpt add(lst3mPct number);     
alter table fundraterpt add(lst6mPct number);     
alter table fundraterpt add(curyearPct number);   
alter table fundraterpt add(lst1yPct number);   
alter table fundraterpt add(lst2yPct number);     
alter table fundraterpt add(lst3yPct number);     
alter table fundraterpt add(lst5yPct number);     
--alter table fundraterpt add(sinceFoundPct number);
alter table fundraterpt add(lstUpdDate,date);
--modify
alter table fundraterpt modify(sfundAmt VARCHAR2(20));
alter table FUNDRATERPT modify(lst1wPct VARCHAR2(8));
alter table fundraterpt modify(lst1mPct VARCHAR2(8));     
alter table fundraterpt modify(lst3mPct VARCHAR2(8));     
alter table fundraterpt modify(lst6mPct VARCHAR2(8));     
--alter table fundraterpt modify(curyearPct VARCHAR2(8));   
alter table fundraterpt modify(lst1yPct VARCHAR2(8));   
alter table fundraterpt modify(lst2yPct VARCHAR2(8));     
alter table fundraterpt modify(lst3yPct VARCHAR2(8));     
alter table fundraterpt modify(lst5yPct VARCHAR2(8));     
alter table fundraterpt modify(sinceFoundPct VARCHAR2(8));
*/

/*
-- add
--alter table fundraterpt add(lst2yRate VARCHAR2(8));
--alter table fundraterpt add(lst3yRate VARCHAR2(8));
--alter table fundraterpt add(lst5yRate VARCHAR2(8));
--alter table fundraterpt add(sinceFoundRate VARCHAR2(8));
alter table FUNDRATERPT add(lst1wPct VARCHAR2(8));     
alter table fundraterpt add(lst1mPct VARCHAR2(8));     
alter table fundraterpt add(lst3mPct VARCHAR2(8));     
alter table fundraterpt add(lst6mPct VARCHAR2(8));     
alter table fundraterpt add(curyearPct VARCHAR2(8));   
alter table fundraterpt add(lst1yPct VARCHAR2(8));     
alter table fundraterpt add(lst2yPct VARCHAR2(8));     
alter table fundraterpt add(lst3yPct VARCHAR2(8));     
alter table fundraterpt add(lst5yPct VARCHAR2(8));     
alter table fundraterpt add(sinceFoundPct VARCHAR2(8));
alter table fundraterpt add(lstUpdDate date); 
*/

# select * from FUNDRATERPT order by LSTUPDDATE asc ;
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
# select * from FUNDRATERPT where fundAmt is not null;
# select * from FUNDRATERPT order by LSTUPDDATE ASC;
# select fundcode,lst1wRate,lst1mRate,lst3mRate,lst6mRate from FUNDRATERPT where lst1wRate='优秀' and lst1mRate='优秀' and lst3mRate='优秀' and lst6mRate='优秀' and curyearRate='优秀' and lst1yRate='优秀';

# fund rate report
# '1','股票型'
select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst1yPct,b.lst2yPct,b.lst3yPct from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='1' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀' 
and b.lst2yRate='优秀' and b.lst3yRate='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc,b.lst1yPct desc,b.lst2yPct desc;

# ('3','债券型');
select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst1yPct,b.lst2yPct from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='3' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
and b.LST2YRATE='优秀' 
# and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc,b.lst1yPct,b.lst2yPct;
select * from tfund where fundname like '%债券%' order by fundtypecode;

# '4','指数型'
select a.fundcode, a.fundname,a.fundurl,b.lst1yPct,b.lst2yPct from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='4' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
# and b.LST2YRATE='优秀' and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.lst1yPct,b.lst2yPct;

# '5','ETF联接'
select a.fundcode, a.fundname,a.fundurl,b.lst1yPct,b.lst2yPct from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='5' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
# and b.LST2YRATE='优秀' and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.lst1yPct,b.lst2yPct;

#  '6','QDII'
select a.fundcode, a.fundname,a.fundurl,b.fundAmt,b.lst1yPct,b.lst2yPct from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='6' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
# and b.LST2YRATE='优秀' and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc, b.lst2yPct desc;

# '8','货币型'
select a.fundcode, a.fundname,a.fundurl,b.fundAmt, b.lst1yPct, b.lst2yPct from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='8' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀'
# and b.LST2YRATE='优秀' and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc, b.lst2yPct desc;

select a.fundcode, a.fundname,a.fundurl,b.fundAmt, b.lst1yPct, b.lst2yPct from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='9' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate in ('优秀','良好')
# and b.LST2YRATE='优秀' and b.LST3YRATE='优秀' and b.lst5yRate='优秀'
order by b.fundAmt desc, b.lst2yPct desc;

select * from fundraterpt where fundcode='001061';
select * from tfund where fundcode='001061';

select a.fundcode, a.fundname,a.fundurl,b.lst1wRate,b.lst1mRate,b.lst3mRate,b.lst6mRate,b.curyearRate,b.lst1yRate
from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode  and instr(fundname,'B')=0 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='8' and b.lst1wRate in ('优秀','良好') and b.lst1mRate in ('优秀','良好') and b.lst3mRate in ('优秀','良好') and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀';

select a.fundcode, a.fundname,a.fundurl,b.lst1wRate,b.lst1mRate,b.lst3mRate,b.lst6mRate,b.curyearRate,b.lst1yRate
from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode  and instr(a.fundname,'工银')>0 
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





