-- Login with system, and exect below sql to create help table
-- @D:\app\Administrator\product\11.2.0\dbhome_1\sqlplus\admin\help\hlpbld.sql
--help index
--set linesize 200;
--set autotrace on;
--The statistic feature requires that the user is granted select on v_$sesstat, v_$statname and v_$session.
select * from user_views where view_name in ('V_$SESSTAT','V_$STATNAME','V_$SESSION');

grant select on V_$SESSTAT to posusr;
grant select on V_$STATNAME to posusr;
grant select on V_$SESSION to posusr;

grant execute on flush_cache to posusr;


alter system set events ='immediate trace name flush_cache';  -- cache area
alter system flush shared_pool;  -- share pool, hard resolve
set autotrace traceonly statistics;
set autotrace on;
select * from posusr.employees where deparment_id=60;
select * from posusr.employees where deparment_id=60 and EMPLOYEE_ID=103;
select * from posusr.employees where deparment_id=60£¨dbms_xplan.display);

set timing on;
set autotrace on explain;
select * from posusr.employees where deparment_id=60 and EMPLOYEE_ID=103;
select * from posusr.employees where deparment_id=60;