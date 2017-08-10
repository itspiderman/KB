START transaction;
create database if not exists posdb DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
# create schema posach; # this is for create database as well
create user posusr@localhost identified by 'posusr';
select * from mysql.user;
# delete from mysql.user where user='posusr' and host='localhost';
grant select,insert,update,delete,create,drop,alter,references on posdb.* to posusr@localhost;
flush privileges;
select * from mysql.user;
SHOW GRANTS FOR posusr@localhost;
use posdb;
ROLLBACK;