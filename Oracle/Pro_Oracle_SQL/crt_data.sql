drop table dept60_bonuses;
drop table employees;
create table dept60_bonuses(
employee_id number primary key,
bonus_amt number);
insert into dept60_bonuses values(103,0);
insert into dept60_bonuses values(104,100);
insert into dept60_bonuses values(105,0);

create table employees(
employee_id     NUMBER(4) PRIMARY KEY,
first_name varchar(20),
last_name varchar(20),
salary number(6),
deparment_id number
);
insert into employees(employee_id,first_name,last_name,salary,deparment_id)
values(103,'','Hunold',9000,'60');
insert into employees(employee_id,first_name,last_name,salary,deparment_id)
values(104,'','Ernst',6000,'60');
insert into employees(employee_id,first_name,last_name,salary,deparment_id)
values(105,'','Austin',4800,'60');
insert into employees(employee_id,first_name,last_name,salary,deparment_id)
values(106,'','Pataballa',4800,'60');
insert into employees(employee_id,first_name,last_name,salary,deparment_id)
values(107,'','Lorentz',4200,'60');
commit;
create view v_employee as select * from employees;
select * from user_views;
select * from user_tab_privs_recd;


