SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\app\Administrator\admin\posdb\scripts\postDBCreation.log append
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute dbms_swrf_internal.cleanup_database(cleanup_local => FALSE);
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='D:\app\Administrator\product\11.2.0\dbhome_1\database\spfileposdb.ora' FROM pfile='D:\app\Administrator\admin\posdb\scripts\init.ora';
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup ;
host D:\app\Administrator\product\11.2.0\dbhome_1\bin\emca.bat -config dbcontrol db -silent -DB_UNIQUE_NAME posdb -PORT 1521 -EM_HOME D:\app\Administrator\product\11.2.0\dbhome_1 -LISTENER LISTENER -SERVICE_NAME posdb -SID posdb -ORACLE_HOME D:\app\Administrator\product\11.2.0\dbhome_1 -HOST localhost -LISTENER_OH D:\app\Administrator\product\11.2.0\dbhome_1 -LOG_FILE D:\app\Administrator\admin\posdb\scripts\emConfig.log;
spool off
