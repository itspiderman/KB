select sysdate from dual;
TRUNCATE table tinvest;
insert into tinvest(acc,invcode,amt,valuedate) values('cmb',101,9000.58,sysdate);
insert into tinvest(acc,invcode,amt,valuedate) values('cmb',201,193.94,sysdate);
--
insert into tinvest(acc,invcode,amt,valuedate) values('cmbc',101,1005.07,sysdate);
insert into tinvest(acc,invcode,amt,valuedate) values('cmbc',201,550,sysdate);
--
insert into tinvest(acc,invcode,amt,valuedate) values('ttjj',101,6043.44,sysdate);
--
insert into tinvest(acc,invcode,amt,valuedate) values('ant',101,10932.4,sysdate);
--
insert into tinvest(acc,invcode,amt,valuedate) values('boci',102,11402.47,sysdate);

with
A as (
select acc,invcode,amt,max(valuedate) valuedate from tinvest group by acc,invcode,amt
)
select A.acc,b.invname,A.amt
from A join tinvtype b
on A.invcode=b.invcode
--group by ROLLUP(A.acc,b.invname)
--group by cube(A.acc,b.invname)
order by A.acc;

select sum(amt) from
(
select max(valuedate), acc,invcode,sum(amt) amt from tinvest
--where valuedate=max(valuedate);
group by acc,invcode
);



