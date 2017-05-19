drop table tinvest;
create table tinvest(
acc varchar(10),
invcode int,
amt NUMERIC(10,4),
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

SELECT * from user_cons_columns c where c.table_name = upper('tinvtype');
desc user_cons_columns;
desc user_constraints;
-- CONSTRAINT_NAME :  SYS_C003697
select * from user_constraints where TABLE_NAME=upper('tinvtype');
alter table tinvtype drop constraint SYS_C003697;
alter table tinvtype add constraint pk_invtype primary key(invcode);

create table tfund(
fundcode char(6),
fundname varchar(20),
fundurl VARCHAR(50),
fundtypecode char
);
alter table tfund add constraint fund_key primary key(fundcode);
alter table tfund modify fundname varchar(30);
alter table tfund add(crtDateTime date);
alter table tfund modify crtDateTime timestamp;
insert into tfunds(fundcode,fundname) values('340009','兴全磐稳增利债券');
select * from tfund;
alter table tfunds rename to tfund;
alter table tfund rename column typecode to fundtypecode;
select fundcode,fundname,fundurl,fundtypecode,crtDateTime from tfund order by fundname;
--truncate table tfund;
--commit;
--alter table tfund add(fundurl VARCHAR(50));
select length('http://fund.eastmoney.com/001781.html') from tfund;
update tfund set fundurl='http://fund.eastmoney.com/001781.html' where fundcode='340009';
--alter table tfund add(typecode char);
alter table tfund add constraint fk_fundtype foreign key(fundtypecode) references tfundtype(fundtypecode);
alter table tfund drop constraint fk_fundtype;
update tfund set typecode='1' where  fundcode='340009';
select * from tfund order by fundtypecode asc, FUNDCODE asc;
select * from tfund where fundcode in ('167301','160135','000041','501025');
select * from tfund where fundtypecode='8';
select count(1) from tfund;

select fundurl,length(fundurl),substr(fundurl,1,26)||'f10/jdzf_'||substr(fundurl,27,11) from tfund where rownum<5;
--create table tfundbk as select * from tfund;
--select count(1) from tfundbk;

/*
1.
13-4月 -17 05.37.49.634000000 下午
13-4月 -17 05.40.15.610000000 下午
*/

-- Fund type table
-- drop table tfundtype;
create table tfundtype
(
typecode char primary key,
typename varchar2(10)
);
-- alter table tfundtype rename column typecode to fundtypecode;
insert into tfundtype(typecode,typename) values('1','股票型');
insert into tfundtype(typecode,typename) values('2','混合型');
insert into tfundtype(typecode,typename) values('3','债券型');
insert into tfundtype(typecode,typename) values('4','指数型');
insert into tfundtype(typecode,typename) values('5','ETF联接');
insert into tfundtype(typecode,typename) values('6','QDII');
insert into tfundtype(typecode,typename) values('7','LOF');
insert into tfundtype(typecode,typename) values('8','货币型');
select * from tfundtype;
--insert into tfundtype(typecode,typename) values('9','');
-- FUNDRATERPT table
drop table FUNDRATERPT;
create table FUNDRATERPT(
fundcode char(6),
lst1wRate VARCHAR2(8),
lst1mRate VARCHAR2(8),
lst3mRate VARCHAR2(8),
lst6mRate VARCHAR2(8),
curyearRate VARCHAR2(8),
lst1yRate VARCHAR2(8)
);
alter table FUNDRATERPT add constraint pk_fund primary key(fundcode);
-- add column,
-- SQL 错误: ORA-00904: : 标识符无效
-- alter table FUNDRATERPT add(lst1wPct,number);  -- ==> no need comma
/*
alter table FUNDRATERPT add(lst1wPct number);
alter table fundraterpt add(lst1mPct number);     
alter table fundraterpt add(lst3mPct number);     
alter table fundraterpt add(lst6mPct number);     
alter table fundraterpt add(curyearPct number);   
alter table fundraterpt add(lst1yPct number);   
alter table fundraterpt add(lst2yPct number);     
alter table fundraterpt add(lst3yPct number);     
alter table fundraterpt add(lst5yPct number);     
alter table fundraterpt add(sinceFoundPct number);
alter table fundraterpt add(lstUpdDate,date);
*/
select * from FUNDRATERPT;
select count(1) from FUNDRATERPT;

select * from tfund a where not exists(select 1 from FUNDRATERPT where fundcode=a.fundcode);
order by a.fundtypecode asc, a.fundcode asc;

select count(1) from tfund a where exists(select 1 from FUNDRATERPT where fundcode=a.fundcode);
select count(1) from tfund a where not exists(select 1 from FUNDRATERPT where fundcode=a.fundcode);

select fundcode,lst1wRate,lst1mRate,lst3mRate,lst6mRate from FUNDRATERPT where lst1wRate='优秀' and lst1mRate='优秀' and lst3mRate='优秀' and lst6mRate='优秀' and curyearRate='优秀' and lst1yRate='优秀';

-- fund rate report
--'1','股票型'
select a.fundcode, a.fundname,a.fundurl from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='1' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀';


--('3','债券型');
select a.fundcode, a.fundname,a.fundurl from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='3' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀';
-- '6','QDII'
select a.fundcode, a.fundname,a.fundurl from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='6' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀';


--'8','货币型'
select a.fundcode, a.fundname,a.fundurl from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='8' and b.lst1wRate='优秀' and b.lst1mRate='优秀' and b.lst3mRate='优秀' and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀';


select a.fundcode, a.fundname,a.fundurl,b.lst1wRate,b.lst1mRate,b.lst3mRate,b.lst6mRate,b.curyearRate,b.lst1yRate
from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode  and instr(fundname,'B')=0 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='8' and b.lst1wRate in ('优秀','良好') and b.lst1mRate in ('优秀','良好') and b.lst3mRate in ('优秀','良好') and b.lst6mRate='优秀' and b.curyearRate='优秀' and b.lst1yRate='优秀';

select a.fundcode, a.fundname,a.fundurl,b.lst1wRate,b.lst1mRate,b.lst3mRate,b.lst6mRate,b.curyearRate,b.lst1yRate
from tfund a join FUNDRATERPT b on a.fundcode=b.fundcode  and instr(a.fundname,'工银')>0 
join tfundtype c on a.fundtypecode=c.fundtypecode where c.fundtypecode='8' 

select * from FUNDRATERPT where  fundcode='000848';
---

--fund steps
drop table tfundratestep;
create table tfundratestep(
fundcode char(6),
seq int,
controlid varchar2(100),
controlname varchar2(100),
action char not null,
inputvalue varchar2(100) null,
constraint pk_fundstep primary key(fundcode,seq)
);
select * from tfundratestep;
 -- alter table tfundratestep add constraint fk_controlact foreign key(controltype,action) references tcontrolaction(controltype,action);
alter table tfundratestep add constraint fk_controlact foreign key(action) references tcontrolaction(action);

insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','1','TANGRAM__PSP_3__smsSwitch','','2','');
insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','2','TANGRAM__PSP_3__smsPhone','','1','13536496649');
insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','3','TANGRAM__PSP_3__smsTimer','','2','');
insert into tfundratestep(fundcode,seq,controlid,controlname,action,inputvalue) values('001781','4','TANGRAM__PSP_3__smsRegPromptBtn','','2','');
select * from tfundratestep;
--control action table
create table tcontrolaction(
controltype varchar2(10),  -- html control type
action char,
actiondes varchar2(10),
constraint pk_controlaction primary key(controltype,action)
);
insert into tcontrolaction(controltype,action,actiondes) values('textbox','1','input');
insert into tcontrolaction(controltype,action,actiondes) values('button','2','click');
--insert into tcontrolaction(controltype,action,actiondes) values('','','');
select * from tcontrolaction;

select * from v$sql;
select * from v$sqlarea;
select * from user_tables;
SELECT 
--OBJECT_NAME ,CREATED 
* FROM ALL_OBJECTS WHERE OBJECT_NAME='TFUND' AND OBJECT_TYPE='TABLE' AND OWNER='POSUSR' ORDER BY CREATED DESC;
-- 12-4月 -17, 	12-4月 -17	, 2017-04-12:22:02:09
desc ALL_OBJECTS;






