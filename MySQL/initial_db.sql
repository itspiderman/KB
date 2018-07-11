START transaction;
# 01. create database;
create database if not exists posdb DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
use posdb;
# create schema posach; # this is for create database as well
# 02. create user
# delete from mysql.user where user='posusr' and host='localhost';
CREATE USER posausr@localhost IDENTIFIED BY 'posausr';
# 3. grant right to user
SHOW GRANTS FOR posausr@localhost;
revoke ALL on posdb.* FROM posausr@localhost;

grant ALL on posdb.* to posausr@localhost  identified by 'posausr';
grant select,insert,update,delete,create,drop,alter,references,Index,Execute on posdb.* to posausr@113.66.105.192 identified by 'posausr';
grant select,insert,update,delete,create,drop,alter,references,Index,Execute on posdb.* to posausr@116.22.52.205 identified by 'posausr';
#
-- any privilege change, run below flush command
flush privileges;

# 4. check user privilidage
select Host,User,
Select_priv,Insert_priv,Update_priv,Delete_priv,Create_priv,
Drop_priv,Reload_priv,Shutdown_priv,Process_priv,File_priv,
Grant_priv,References_priv,Index_priv,Alter_priv,Show_db_priv,
Super_priv,Create_tmp_table_priv,Lock_tables_priv,Execute_priv,Repl_slave_priv,
Repl_client_priv,Create_view_priv,Show_view_priv,Create_routine_priv,Alter_routine_priv,
Create_user_priv,Event_priv,Trigger_priv,Create_tablespace_priv,ssl_type,
ssl_cipher,x509_issuer,x509_subject,max_questions,max_updates,
max_connections,max_user_connections,plugin,authentication_string,password_expired
from mysql.user;

select * from mysql.user where User='posausr';

select Host,User,Password from mysql.user where User='posausr' and Host='116.22.52.205';
update mysql.user set Password='posausr' where User='posausr' and Host='host';
mysql -uroot -ptao020.
mysql -uposausr -pposausr
#
select Host,User,Password,Select_priv from mysql.user where User='posausr';
update mysql.user set Password=PASSWORD('posausr') where User='posausr';
select Host,User,Password from mysql.user where User='posausr';
SHOW GRANTS FOR posusr@localhost;
ROLLBACK