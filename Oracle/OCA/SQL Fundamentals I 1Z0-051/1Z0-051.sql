select top 3 * from CUSTOMERS;
select * from CUSTOMERS where rownum<=10 ;
select * from CUSTOMERS order by CUS_ID OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;