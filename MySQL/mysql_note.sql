1. Add table primary key 
 
alter table tabelname 
add new_field_id int(5) unsigned default 0 not null auto_increment ,
add primary key (new_field_id);//增加一个新列  
 