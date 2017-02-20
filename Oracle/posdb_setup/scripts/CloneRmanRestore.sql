SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\app\Administrator\admin\posdb\scripts\CloneRmanRestore.log append
startup nomount pfile="D:\app\Administrator\admin\posdb\scripts\init.ora";
@D:\app\Administrator\admin\posdb\scripts\rmanRestoreDatafiles.sql;
spool off
