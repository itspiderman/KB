Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Sub start_Click()
start
End Sub

Function start()
'Test
Dim fname
Dim iFname
Dim Rcode
'end test

Dim iExit

Dim dWinFolder As New ShellWindows
'May cause User-defined type not defined, please add lib
' Tool|References,select "Microsoft Internet Control"

Dim IE As Object
Dim objIE As Object
'Element ID / Element value
'5-element 1,6-element 2,...
Dim e1V, e2V, e3V, e4V, e5V, e6V, e7V, e9V, exV
Dim e1ID, e2ID, e3ID, e4ID, e5ID, e6ID, e7ID, e8ID, e9ID, exID
'Commont value
'1-sequence,
'   2-eType,3-url,4-domian
Dim eType, iEURL, iEDomain, iDlen
Dim typeArray, iLinkCount



Set IE = CreateObject("InternetExplorer.Application")
IE.Visible = True
'IE.Visible = False

iLinkCount = ThisWorkbook.Sheets("Value").UsedRange.Rows.Count
For i = 1 To iLinkCount
  eType = ThisWorkbook.Sheets("Value").Cells(i, 2)
  iEURL = ThisWorkbook.Sheets("Value").Cells(i, 3)
  iEDomain = ThisWorkbook.Sheets("Value").Cells(i, 4)
  iDlen = Len(iEDomain)
iExit = iExit + 1

  Rcode = IE.Navigate(iEURL, 2, "_self")
  
    Do While (IE.Busy Or IE.ReadyState <> 4)
      Sleep 1000
    Loop
  If InStr(1, IE.FullName, "IEXPLORE.EXE", vbTextCompare) <> 0 Then
    Set objDoc = IE.Document
    On Error Resume Next
      
      typeArray = Split(eType, ";")
      For j = 0 To UBound(typeArray)
        'Element ID / Element value
        e1ID = ThisWorkbook.Sheets("ID").Cells(i, j + 5)

        If typeArray(j) = 1 Then
          e1V = ThisWorkbook.Sheets("Value").Cells(i, j + 5)
          objDoc.getelementbyid(e1ID).Focus
          objDoc.getelementbyid(e1ID).innerText = e1V
        Else
        'redio, also is click even to check it.
          Sleep 1000
          objDoc.getelementbyid(e1ID).Click
          
          'If ThisWorkbook.Sheets("ID").Cells(i, 1) = 4 Then
            'objDoc.getelementbyid(e1ID).Click
          'Else
            'objDoc.getelementbyid(e1ID).Blur
          'End If
          
        End If
      Next
      
  End If
  Sleep 4000 ' To next row
Next

'Close browser
Sleep 4000
iExit = iExit + 0
objDoc.Close
IE.Quit
Set IE = Nothing

End Function

Function waitPro(objDoc, name)
    Dim i
    i = 0
    Do While i < 10
    On Error Resume Next
    If objDoc.getelementbyid(name) = Null Then
       Sleep 10000
    Else
       Exit Do
    
    End If
    i = i + 1
    Loop
End Function

