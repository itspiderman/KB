SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\app\Administrator\admin\posdb\scripts\postScripts.log append
@D:\app\Administrator\product\11.2.0\dbhome_1\rdbms\admin\dbmssml.sql;
execute dbms_datapump_utl.replace_default_dir;
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set current_schema=ORDSYS;
@D:\app\Administrator\product\11.2.0\dbhome_1\ord\im\admin\ordlib.sql;
alter session set current_schema=SYS;
connect "SYS"/"&&sysPassword" as SYSDBA
alter user CTXSYS account unlock identified by &&sysPassword;
connect "CTXSYS"/"&&sysPassword"
@D:\app\Administrator\product\11.2.0\dbhome_1\ctx\admin\defaults\dr0defdp.sql;
@D:\app\Administrator\product\11.2.0\dbhome_1\ctx\admin\defaults\dr0defin.sql "SIMPLIFIED CHINESE";
connect "SYS"/"&&sysPassword" as SYSDBA
alter user CTXSYS password expire account lock;
connect "SYS"/"&&sysPassword" as SYSDBA
execute ORACLE_OCM.MGMT_CONFIG_UTL.create_replace_dir_obj;
