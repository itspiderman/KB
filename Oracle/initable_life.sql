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
typecode char
);
alter table tfunds add constraint fund_key primary key(fundcode);
alter table tfunds modify fundname varchar(30);
insert into tfunds(fundcode,fundname) values('340009','兴全磐稳增利债券');
select * from tfunds;
alter table tfunds rename to tfund;
select * from tfund;
--alter table tfund add(fundurl VARCHAR(50));
select length('http://fund.eastmoney.com/001781.html') from tfund;
update tfund set fundurl='http://fund.eastmoney.com/001781.html' where fundcode='340009';

--alter table tfund add(typecode char);
alter table tfund add constraint fk_fundtype foreign key(typecode) references tfundtype(typecode);
update tfund set typecode='1' where  fundcode='340009';
select * from tfund;

-- Fund type table
drop table tfundtype;
create table tfundtype
(
typecode char primary key,
typename varchar2(10)
);
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








