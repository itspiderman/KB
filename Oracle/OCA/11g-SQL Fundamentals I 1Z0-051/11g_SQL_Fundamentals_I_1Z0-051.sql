desc customers;
select * from customers;
--insert into CUSTOMERS values(11,'1314','love','06-Jan-1980','021-687-1258');
desc PROD_TYPE;
select * from PROD_TYPE;
desc PRODUCTS;
select * from products;

set define off;
select * from customers where PHONE='&id';
set define on;
select * from customers where FIRST_NAME='&fn' and LAST_NAME='&ln';

select * from customers;
select * from PROD_TYPE;
select * from products;

TO_CHAR, TO_NUMBER, and TO_DATE;

select TO_CHAR(DOB,'DD-MM-YYYY') from customers where LAST_NAME='love';
select FIRST_NAME,TO_NUMBER(FIRST_NAME,'99999.99'),TO_NUMBER('123.21','99999.999') 
from customers where LAST_NAME='love';
select TO_CHAR(CUS_ID,'0,999.00') from CUSTOMERS;
SELECT TO_NUMBER('123,456.78','999999D99') from dual;

select a.NAME, b.NAME from PROD_TYPE a join PRODUCTS b on a.PROD_TYPE_ID=b.PROD_TYPE_ID
group by a.NAME, b.NAME
having a.NAME='Book';

--minus : return first_table records without second_talbe
select * from PROD_TYPE
minus
select * from PROD_TYPE where PROD_TYPE_ID>3;

--intersect
select PROD_TYPE_ID,NAME from PROD_TYPE
intersect
select PROD_TYPE_ID,NAME from PROD_TYPE where PROD_TYPE_ID>3 order by NAME;

DESC PROD_TYPE;
desc CUSTOMERS;

COMMENT ON TABLE CUSTOMERS is 'This is the customer table for testing';
select * from user_tab_comments;
COMMENT ON COLUMN CUSTOMERS.CUS_ID is 'This is the primary key';
select * from USER_COL_COMMENTS where TABLE_NAME='CUSTOMERS';

select * from POSUSR.CUSTOMERS;

select top 3 * from CUSTOMERS;
select * from CUSTOMERS where rownum<=10 ;
select * from CUSTOMERS order by CUS_ID OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;

--- check the transaction
Insert into tfortrans values ( 1 );
Insert into tfortrans values ( -1 );
select * from tfortrans;





