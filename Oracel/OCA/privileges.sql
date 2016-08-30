sqlplus system/system@posdb
show parameter REMOTE_LOGIN_PASSWORDFILE;
alter system set REMOTE_LOGIN_PASSWORDFILE=SHARED scope=spfile;
--check user default tablespace
select username,default_tablespace from user_users;
select * from dba_data_files order by tablespace_name;

select * from dba_tablespaces;
select t.tablespace_name, round(sum(bytes/(1024*1024)),0) ts_size   
from dba_tablespaces t, dba_data_files d where t.tablespace_name = d.tablespace_name   
group by t.tablespace_name;

-- check user's tables;
select * from user_tables;
-- User privilege
select * from user_sys_privs where USERNAME='posusr';
select * from user_role_privs;
select * from user_tab_privs_recd;

-- role privilege
select * from ROLE_ROLE_PRIVS;
select * from ROLE_SYS_PRIVS;
select * from ROLE_TAB_PRIVS;