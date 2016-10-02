--1. Blocks
set serveroutput on;  --default is off
declare 
   msg varchar2(20):='hello, world!';
begin
   dbms_output.put_line(msg);
   
   Exception
   dbms_output.put_line('exception');
   /* expection handling*/
end;

