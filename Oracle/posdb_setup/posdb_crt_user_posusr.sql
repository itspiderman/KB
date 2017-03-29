--1. create temp table space
create temporary tablespace posdbspace_temp
tempfile 'D:\app\Administrator\oradata\posdb\posdbspace_temp.dbf'
size 32M
autoextend on
next 32M maxsize unlimited
extent management local;
--2. create table space
create tablespace posdbspace
logging
datafile 'D:\app\Administrator\oradata\posdb\posdbspace.dbf'
size 32M
autoextend on
next 32M maxsize 2048M
extent management local;
-- select * from dba_tablespaces;

--2. create user posusr  
create user posusr identified by posusr
account unlock
default TABLESPACE posdbspace
TEMPORARY TABLESPACE posdbspace_temp;
-- select * from dba_users where username='posusr';

select * from all_users where username='posusr';   
select * from user_users; 
-- grant right to user
grant connect,resource,dba to posusr; 
-- select username,default_tablespace from user_users;