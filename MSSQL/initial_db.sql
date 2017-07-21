START transaction;
create database if not exists posadb DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
use posadb;
# create schema posach; # this is for create database as well
create user posusr@localhost identified by 'posusr';
select * from mysql.user;
--delete from mysql.user where user='posusr' and host='localhost';
grant select,insert,update,delete,create,drop on posadb.* to posusr@localhost identified by 'posusr';
flush privileges;
select * from mysql.user;
SHOW GRANTS FOR posusr@localhost;
ROLLBACK;