create or replace procedure queryFundSP
(
pFundCode IN char
)
as
begin
if(pFundCode='') then
  select fundcode,fundname,fundurl,fundtypecode,crtDateTime from tfund where rownum<200 order by fundname;
else
  select fundcode,fundname,fundurl,fundtypecode,crtDateTime from tfund where fundcode=pFundCode order by fundname;
end if;
end queryFundSP;

-- select fundcode,fundname,fundurl,fundtypecode,crtDateTime from tfund where rownum<200 order by fundname;