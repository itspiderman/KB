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

create table tfunds(
fundcode char(6),
fundname varchar(20)
);
alter table tfunds add constraint fund_key primary key(fundcode);
alter table tfunds modify fundname varchar(30);
insert into tfunds(fundcode,fundname) values('340009','兴全磐稳增利债券');
select * from tfunds;



