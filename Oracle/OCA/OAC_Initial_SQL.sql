--This SQL  file is for create DB object and initial object

DROP TABLE order_status;

create table order_status(
order_status_id INTEGER CONSTRAINT default_pk PRIMARY KEY,
status VARCHAR2(20) DEFAULT 'Order Placed' NOT NULL,
last_modified DATE DEFAULT SYSDATE,
last_upd_id INTEGER CONSTRAINT ck_upd_id CHECK (last_upd_id>10)
);

drop table TEST;
CREATE TABLE TEST
(
ID INTEGER CONSTRAINT default_key primary key,
CONSTRAINT ck_id check(ID>10)
);

drop table tfortrans;
create table tfortrans ( st_no int check ( st_no>0 ) );

