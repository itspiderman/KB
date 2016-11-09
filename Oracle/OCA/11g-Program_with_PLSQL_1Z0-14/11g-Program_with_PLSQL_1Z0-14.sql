--1. Blocks
--set serveroutput on;  --default is off
declare 
   myname varchar2(20);
   msg varchar2(20):='hello, world!';   
begin
   dbms_output.put_line(msg);
   myname:='Jackson';
   dbms_output.put_line('my name is ' || myname);
    /* Exception
    dbms_output.put_line(mynmae); */
   /* expection handling*/
end;
--2. variable in SQL

select * from employees;

-- declare lsname varchart(20):='Hunold';
set autoprint on;

declare 
emp_id NUMBER(4,0);
lsname varchar2(20);
ecount number;
strslq varchar2(500);
begin
lsname:='Hunold';
strslq:='select count(1) into :x from employees where last_name=:y';
execute immediate strslq into ecount using lsname;
dbms_output.put_line('total employees is ' || ecount);
end;

--3. 
set echo on;
alter system flush shared_pool;
--below statement run to sqlplus
variable x numeric;
exec:x:=104;
select * from employees where employee_id=:x;

--4.Neste block and valiable with label
set serveroutput on
<<outer_block>>
declare
v_test number :=123;
begin
DBMS_OUTPUT.PUT_LINE('Outer_block, v_test:'|| v_test);
  <<inner_block>>
  declare
  v_test number := 456;
  begin
  DBMS_OUTPUT.PUT_LINE('Inner_block,v_test:'|| v_test);
  DBMS_OUTPUT.PUT_LINE('Inner_block,outer_block.v_test:'|| outer_block.v_test);
  end inner_block;
end outer_block;

== output result ==
Outer_block, v_test:123
Inner_block,v_test:456
Inner_block,outer_block.v_test:123

