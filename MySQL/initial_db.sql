START transaction;
# 01. create database;
create database if not exists posdb DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
use posdb;
# create schema posach; # this is for create database as well
# 02. create user
# delete from mysql.user where user='posusr' and host='localhost';
CREATE USER 'posausr'@'host' IDENTIFIED BY 'posa';
# 3. grant right to user
grant all PRIVILEGES on posdb.* to posausr@'localhost'  identified by 'posa';
grant all PRIVILEGES on posdb.* to posausr@'116.22.52.205'  identified by 'posa';
grant select,insert,update,delete,create,drop,alter,references,Index,Execute on posdb.* to posausr@116.22.52.205;
flush privileges;
# 4. check user privilidage
select Host,User,Password,Select_priv from mysql.user where User='posausr';
select * from mysql.user where User='posausr';
SHOW GRANTS FOR posusr@localhost;
ROLLBACK;