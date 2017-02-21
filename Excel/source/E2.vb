'sleep不是vb自带的函数，属于windows API函数。
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Dim Rcode
Dim dWinFolder As New ShellWindows
'May cause User-defined type not defined, please add lib
' Tool|References,select "Microsoft Internet Control"
Dim IE As Object
Dim objIE As Object

Dim iEURL
Sub start_Click()
start
End Sub

Function start()
'Test
Dim fname
Dim iFname
Dim iExit
'end test
'Set IE = CreateObject("InternetExplorer.Application")
'error: Run-time error '-2147023179(800706b5)'
Set IE = New InternetExplorerMedium
IE.Visible = True
'IE.Visible = False
'
'Set oShellApp = CreateObject("Shell.Application")
'Set oShellAppWindows = oShellApp.Windows
'Set dWinFolder = oShellApp.Windows
'

iEURL = "https://www.baidu.com/auth"
Rcode = IE.Navigate(iEURL, 2, "_self")

Do While (IE.Busy Or IE.ReadyState <> 4)
  Sleep 1000
Loop

'If InStr(1, IE.FullName, "IEXPLORE.EXE", vbTextCompare) <> 0 Then
  Set objDoc = IE.Document
  On Error Resume Next
  '1. login E2
  objDoc.getelementbyid("id_userName").Focus
  objDoc.getelementbyid("id_userName").innerText = "baiduaccount"
  objDoc.getelementbyid("id_password").innerText = "#124password"
  Sleep 1000
  Rcode = objDoc.forms(0).submit()
  Sleep 4000
'End If
  '2. call add orchestration function
  'addOrchestrestion
  '3. add task
Rcode = addTask()
   
'Close browser
Sleep 4000
iExit = iExit + 0
objDoc.Close
Set IE = Nothing
IE.Quit


End Function
Function addOrchestrestion()
  'Add orchestration
  'orchestration names list
  Dim ornames(6)
  ornames(0) = "BAIDU-IP_PRD_WEB"
  ornames(1) = "BAIDU-IP_PRD_WAS"
  ornames(2) = "BAIDU-US_PRD_WEB"
  ornames(3) = "BAIDU-US_PRD_WAS"
  ornames(4) = "BAIDU-GS_PRD_WEB"
  ornames(5) = "BAIDU-GS_PRD_WAS"
  
  For i = 2 To 5
    iEURL = "https://www.baidu.com/orchestrations/add_orch/"
    Rcode = IE.Navigate(iEURL, 2, "_self")
    Do While (IE.Busy Or IE.ReadyState <> 4)
      Sleep 1000
    Loop
    objDoc.Close
    Set objDoc = IE.Document
    objDoc.getelementbyid("id_name").innerText = ornames(i)
    objDoc.getelementbyid("id_description").innerText = ornames(i)
    Rcode = objDoc.forms(0).submit()
    Sleep 3000
  Next
End Function
Function addTask()
  'Orchestration manage task URL
  'ornames(0) = "baidu-IP_PRD_WEB"
  iEURL = "https://www.baidu.com/orchestrations/taskview/?orchestration=585"
  Rcode = addWebTask(585, 67, 67, 4)
  'ornames(1) = "SasS-AMH-IP_PRD_WAS"
  iEURL = "https://www.baidu.com/orchestrations/taskview/?orchestration=586"
  
  'ornames(2) = "baidu-US_PRD_WEB"
  iEURL = "https://www.baidu.com/orchestrations/taskview/?orchestration=589"
  'ornames(3) = "baidu-US_PRD_WAS"
  iEURL = "https://www.baidu.com/orchestrations/taskview/?orchestration=590"
  'ornames(4) = "baidu-GS_PRD_WEB"
  iEURL = "https://www.baidu.com/orchestrations/taskview/?orchestration=591"
  'ornames(5) = "baidu-GS_PRD_WAS"
  iEURL = "https://www.baidu.com/orchestrations/taskview/?orchestration=592"
End Function
Function addWebTask(orID, iRowStart, iRowEnd, iColumn)
  Dim orURL, searchURL
  Dim tSeq, sInx, rAmount
  Dim sName, iName, taskID
  Dim elIDidx As Integer
  
  Dim sIHS, sWAS
  sIHS = " - ihs80"
  sWAS = " - was80"
  Dim objSearchDoc As Object
  
  tSeq = 1
  sInx = 10  ' server hostname length
  iRowStart = iRowStart
  iColumn = iColumn  'No need to change
  orURL = "https://www.baidu.com/orchestrations/add_task/?orchestration=" & orID
  'Test
  tSeq = 10
  
  'End Test
  Rcode = IE.Navigate(orURL, 2, "_self")
  Do While (IE.Busy Or IE.ReadyState <> 4)
    Sleep 1000
  Loop
  
  Set objDoc = IE.Document
  
  
'  For i = iRowStart To iRowEnd
    'Ordinal
    objDoc.getelementbyid("id_ordinal").innerText = tSeq
    'select task, for IHS: 0-start/graceful stop - Performs a start or graceful stop on selected servers. Only works with IHS
    objDoc.getelementbyid("id_task").Value = 0
    objDoc.getelementbyid("addserverinstlink").Click
    Sleep 2000
    'searchURL = "https://www.baidu.com/helpers/show_find_serverinst/" 'After click

    
    For Each objIE In dWinFolder
     iExit = iExit + 1
     Do While InStr(1, objIE.FullName, "IEXPLORE.EXE", vbTextCompare) <> 0
       If Left(objIE.LocationURL, 55) = "https://www.baidu.com/helpers/show_find_serverinst/" Then
         iName = ThisWorkbook.Sheets("AMH_Orchestrations").Cells(iRowStart, iColumn)
         sName = Right(iName, sInx)
         Set objSearchDoc = objIE.Document
         objSearchDoc.getelementbyid("id_first").innerText = sName
         objSearchDoc.getelementbyid("id_last").innerText = iName

         'search button item4
         objSearchDoc.getElementsByTagName("input")(3).Click
         Sleep 3000
         Do While (IE.Busy Or IE.ReadyState <> 4)
           Sleep 1000
         Loop
         'taskID = sName + " - " + iName + " - ihs80"
         taskID = " - " + iName + sIHS
         
         For Each el In objSearchDoc.forms("select_server").getElementsByTagName("input")
           
           elIDidx = InStr(el.getAttribute("id"), taskID)
           If elIDidx > 0 Then
             el.Click
             Sleep 3000
             Exit For
           End If
         Next
       End If
       iExit = iExit + 1
       Exit Do
     Loop
    Next
    Set objIE = Nothing
    Set objSearchDoc = Nothing
    
    
    Rcode = objDoc.forms(0).submit()
    Sleep 3000

'  Next
  
  
End Function
Function addWasTask()

End Function


