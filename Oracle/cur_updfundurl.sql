--  update tfund set fundurl = substr(fundurl,1,26)||'f10/jdzf_'||substr(fundurl,27,11) where instr(fundurl,'jdzf')=0;
select fundcode, fundurl from posusr.tfund;

-- oracle cursor
--- declare cursor cur_updfundurl  
is 
select fundcode, fundurl from tfund;
c_row cur_updfundurl%rowtype;
BEGIN
  open cur_updfundurl;  
  loop
    fetch cur_updfundurl into c_row;
    exit when cur_updfundurl%notfound;
    update tfund set fundurl = substr(fundurl,1,26)||'f10/jdzf_'||substr(fundurl,27,11) where fundcode=c_row.fundcode;
  end loop;
  close cur_updfundurl;
END;
-- commit;
-- rollback;