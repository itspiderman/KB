/*
oracle中函数和存储过程的区别和联系
http://www.cnblogs.com/zlbx/p/4818007.html
*/
--1. procedure
--1.1. 
create or replace procedure p1
as
begin
  dbms_output.put_line('hello world,without parameter,without return value');
end;
/*
set serveroutput on;
begin
  p1();
end;

set serveroutput on;
execute p1();
*/
--1.2. have parameter,have return value
create or replace procedure p2
(
name in varchar2, age int, msg out varchar2
)
as
begin
  msg:='姓名：' || name ||',年龄：'||age;  
end;
/*
set serveroutput on;
declare msg varchar2(100);
begin
  p2('张三',23,msg);
  dbms_output.put_line(msg);
end;
*/
--1.3 in out parameter
create or replace procedure p3
(
msg in out varchar2
)
as
begin
  dbms_output.put_line(msg);
  msg:='我是从存储过程中携带出来的值';
end;
/*
set serveroutput on;
declare msg1 varchar2(100) :='我是从携带进去的值';
begin  
  p3(msg1);
  dbms_output.put_line(msg1);
end;
*/
--1.4. Define the paremeter within procedure
create or replace procedure p4
as
name varchar(50);
begin
 name:='hello world, define parameter within procedure';
 dbms_output.put_line(name);
end;
/*
set serveroutput on;
execute p4();
*/
--2. function
create or replace function f1
return varchar
as
  msg varchar(50);
begin
  msg:='Hello World';
  return msg;
end;
/*
select f1() from dual;
set serveroutput on;
begin
  dbms_output.put_line(f1());
end;
*/