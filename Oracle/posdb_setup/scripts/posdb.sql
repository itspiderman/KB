set verify off
ACCEPT sysPassword CHAR PROMPT 'Enter new password for SYS: ' HIDE
ACCEPT systemPassword CHAR PROMPT 'Enter new password for SYSTEM: ' HIDE
ACCEPT sysmanPassword CHAR PROMPT 'Enter new password for SYSMAN: ' HIDE
ACCEPT dbsnmpPassword CHAR PROMPT 'Enter new password for DBSNMP: ' HIDE
host D:\app\Administrator\product\11.2.0\dbhome_1\bin\orapwd.exe file=D:\app\Administrator\product\11.2.0\dbhome_1\database\PWDposdb.ora force=y
@D:\app\Administrator\admin\posdb\scripts\CloneRmanRestore.sql
@D:\app\Administrator\admin\posdb\scripts\cloneDBCreation.sql
@D:\app\Administrator\admin\posdb\scripts\postScripts.sql
@D:\app\Administrator\admin\posdb\scripts\lockAccount.sql
@D:\app\Administrator\admin\posdb\scripts\postDBCreation.sql
