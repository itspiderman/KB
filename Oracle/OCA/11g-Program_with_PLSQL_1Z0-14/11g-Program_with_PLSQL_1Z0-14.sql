--1. Blocks
set serveroutput on;  --default is off
declare 
   msg varchar2(20):='hello, world!';
begin
   dbms_output.put_line(msg);
end;

