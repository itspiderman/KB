Set objExcel = CreateObject("Excel.Application")
set ws=CreateObject("WScript.Shell") 
mydir= ws.CurrentDirectory&"\saveAtt.xlsm"
Set objWorkbook = objExcel.Workbooks.open(mydir)
objExcel.run "start_Click"
objWorkbook.Close False
objExcel.Quit
Set objWorkbook = Nothing
Set objExcel = Nothing
