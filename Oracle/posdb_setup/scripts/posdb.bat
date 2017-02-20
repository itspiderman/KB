OLD_UMASK=`umask`
umask 0027
mkdir D:\app\Administrator\admin\posdb\adump
mkdir D:\app\Administrator\admin\posdb\dpdump
mkdir D:\app\Administrator\admin\posdb\pfile
mkdir D:\app\Administrator\cfgtoollogs\dbca\posdb
mkdir D:\app\Administrator\flash_recovery_area
mkdir D:\app\Administrator\flash_recovery_area\posdb
mkdir D:\app\Administrator\oradata\posdb
mkdir D:\app\Administrator\product\11.2.0\dbhome_1\database
umask ${OLD_UMASK}
set ORACLE_SID=posdb
set PATH=%ORACLE_HOME%\bin;%PATH%
D:\app\Administrator\product\11.2.0\dbhome_1\bin\oradim.exe -new -sid POSDB -startmode manual -spfile 
D:\app\Administrator\product\11.2.0\dbhome_1\bin\oradim.exe -edit -sid POSDB -startmode auto -srvcstart system 
D:\app\Administrator\product\11.2.0\dbhome_1\bin\sqlplus /nolog @D:\app\Administrator\admin\posdb\scripts\posdb.sql
