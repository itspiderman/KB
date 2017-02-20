SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool D:\app\Administrator\admin\posdb\scripts\cloneDBCreation.log append
Create controlfile reuse set database "posdb"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'D:\app\Administrator\oradata\posdb\SYSTEM01.DBF',
'D:\app\Administrator\oradata\posdb\SYSAUX01.DBF',
'D:\app\Administrator\oradata\posdb\UNDOTBS01.DBF',
'D:\app\Administrator\oradata\posdb\USERS01.DBF'
LOGFILE GROUP 1 ('D:\app\Administrator\oradata\posdb\redo01.log') SIZE 51200K,
GROUP 2 ('D:\app\Administrator\oradata\posdb\redo02.log') SIZE 51200K,
GROUP 3 ('D:\app\Administrator\oradata\posdb\redo03.log') SIZE 51200K RESETLOGS;
exec dbms_backup_restore.zerodbid(0);
shutdown immediate;
startup nomount pfile="D:\app\Administrator\admin\posdb\scripts\initposdbTemp.ora";
Create controlfile reuse set database "posdb"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'D:\app\Administrator\oradata\posdb\SYSTEM01.DBF',
'D:\app\Administrator\oradata\posdb\SYSAUX01.DBF',
'D:\app\Administrator\oradata\posdb\UNDOTBS01.DBF',
'D:\app\Administrator\oradata\posdb\USERS01.DBF'
LOGFILE GROUP 1 ('D:\app\Administrator\oradata\posdb\redo01.log') SIZE 51200K,
GROUP 2 ('D:\app\Administrator\oradata\posdb\redo02.log') SIZE 51200K,
GROUP 3 ('D:\app\Administrator\oradata\posdb\redo03.log') SIZE 51200K RESETLOGS;
alter system enable restricted session;
alter database "posdb" open resetlogs;
exec dbms_service.delete_service('seeddata');
exec dbms_service.delete_service('seeddataXDB');
alter database rename global_name to "posdb";
ALTER TABLESPACE TEMP ADD TEMPFILE 'D:\app\Administrator\oradata\posdb\TEMP01.DBF' SIZE 20480K REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED;
select tablespace_name from dba_tablespaces where tablespace_name='USERS';
alter system disable restricted session;
connect "SYS"/"&&sysPassword" as SYSDBA
@D:\app\Administrator\product\11.2.0\dbhome_1\demo\schema\mkplug.sql &&sysPassword change_on_install change_on_install change_on_install change_on_install change_on_install change_on_install D:\app\Administrator\product\11.2.0\dbhome_1\assistants\dbca\templates\example.dmp D:\app\Administrator\product\11.2.0\dbhome_1\assistants\dbca\templates\example01.dfb D:\app\Administrator\oradata\posdb\example01.dbf D:\app\Administrator\admin\posdb\scripts\ "'SYS/&&sysPassword as SYSDBA'";
connect "SYS"/"&&sysPassword" as SYSDBA
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup restrict pfile="D:\app\Administrator\admin\posdb\scripts\initposdbTemp.ora";
select sid, program, serial#, username from v$session;
alter database character set INTERNAL_CONVERT AL32UTF8;
alter database national character set INTERNAL_CONVERT AL16UTF16;
alter user sys account unlock identified by "&&sysPassword";
alter user system account unlock identified by "&&systemPassword";
alter system disable restricted session;
