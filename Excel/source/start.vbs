Set objExcel = CreateObject("Excel.Application")
set ws=CreateObject("WScript.Shell") 
'mydir= ws.CurrentDirectory&"\auto.xlsm"
mydir= "C:\driver\tmp\tmp\auto.xlsm"
Set objWorkbook = objExcel.Workbooks.open(mydir)
objExcel.run "start"
objWorkbook.Close False
objExcel.Quit
Set objWorkbook = Nothing
Set objExcel = Nothing
