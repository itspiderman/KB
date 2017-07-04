/*
Tigger

*/
-- Test case
/*
create table TFUNDHIS as select * from TFUND where rownum<11;
create table TFUNDBCK as select * from TFUND where 1=2;
select * from TFUNDHIS;
select * from TFUNDBCK;
*/
create or replace trigger backupfund
before DELETE 
on posusr.TFUNDHIS
referencing OLD as old
for each row
begin
 insert into TFUNDBCK(FUNDCODE,FUNDNAM,FUNDURL,FUNDTYPECODE,CRTDATETIME) values(:old.FUNDCODE,:old.FUNDNAM,:old.FUNDURL,:old.FUNDTYPECODE,:old.CRTDATETIME);
end;
/*
delete TFUNDHIS where FUNDCODE='502023';
select * from TFUNDBCK;
*/

create table salary
(
empnum varchar(6),
salary decimal(10,2),
dept varchar(10)
);
alter table salary add constraint emp_pk primary key(empnum);

select * from salary;
/*
insert into salary values('001',500,'HR');
insert into salary values('002',500,'HR');
insert into salary values('003',500,'HR');
insert into salary values('004',500,'HR');
insert into salary values('005',500,'MG');
insert into salary values('006',500,'MG');
insert into salary values('007',500,'MG');
insert into salary values('008',500,NULL);
*/

create or replace trigger updsalarytrigger
before UPDATE of salary
on salary
for each row
declare incRate float
begin
  if :NEW.salary<= :OLD.salary then
    RAISE_APPLICATION_ERROR(-20001, '修改后的薪金要大于修改前的薪金');  
  end if;
  
  select incRate=:NEW.salary/:OLD.salary;   
  if incRate >1.1 then
    RAISE_APPLICATION_ERROR(-20001, '工资增量不能超过原工资的10%');  
  end if;  
  
  if OLD.dep is null then
    RAISE_APPLICATION_ERROR(-20001, '目前没有单位的职工不能涨工资');  
  end if;  
end;

select empnum,salary,sum(salary) over(order by empnum) amt from salary;
