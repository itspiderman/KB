--1. Blocks
set serveroutput on;
declare 
   msg varchar2(20):='hello, world!';
begin
   dbms_output.put_line(msg);
end;
