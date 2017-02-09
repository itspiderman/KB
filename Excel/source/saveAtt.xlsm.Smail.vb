Public Declare Function SetTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerfunc As Long) As Long
Public Declare Function KillTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Function WinProcA(ByVal hwnd As Long, ByVal uMsg As Long, ByVal idEvent As Long, ByVal SysTime As Long) As Long

    KillTimer 0, idEvent
    DoEvents
    Sleep 100
    'use Alt+S to send email,to void the warning message due to security issue.
    Application.SendKeys "%s"

End Function

' Send one email sub function

Sub SendMail(ByVal to_who As String, ByVal cc_who As String, ByVal subject As String, ByVal body As String, ByVal attachement As String)

    Dim objOL As Object
    Dim itmNewMail As Object
    'refer Microsoft Outlook object
    Set objOL = CreateObject("Outlook.Application")
    Set itmNewMail = objOL.CreateItem(olMailItem)
    With itmNewMail
        .subject = subject
        .BodyFormat = olFormatHTML
        .HTMLBody = body
        .To = to_who
        .CC = cc_who
        '.Attachments.Add attachement
        .Display  'start Outlook
        'SetTimer 0, 0, 0, AddressOf WinProcA
    End With

    Set objOL = Nothing
    Set itmNewMail = Nothing

End Sub

'send the batch email
Sub BatchSendMail()
    Dim rowCount, endRowNo
    endRowNo = Cells(1, 1).CurrentRegion.Rows.Count
    'send the email row by row
    'For rowCount = 1 To endRowNo
        'SendMail Cells(rowCount, 1), Cells(rowCount, 2), Cells(rowCount, 3), Cells(rowCount, 4)
    'Next
    
    'Send report
    '[mm-yyyy]
    '[mm.dd.yy]
    Dim strSubject As String, strBody As String, strTo As String, strCC As String, strAttachment As String
    Dim mm_yyyy As String, mm_dd_yy As String, ddMM As String
    mm_yyyy = Format(Date, "mm-yyyy")
    mm_dd_yy = Format(Date, "mm.dd.yy")
    ddMM = Format(Date, "ddMMM")
    strSubject = ThisWorkbook.Sheets("semail").Cells(1, 3) & ddMM
    strBody = ThisWorkbook.Sheets("semail").Cells(2, 3)
    strBody = Replace(strBody, "[mm-yyyy]", mm_yyyy)
    strBody = Replace(strBody, "[mm.dd.yy]", mm_dd_yy)
    
    strTo = ThisWorkbook.Sheets("semail").Cells(3, 3)
    strCC = ThisWorkbook.Sheets("semail").Cells(4, 3)
    SendMail strTo, strCC, strSubject, strBody, strAttachment
End Sub

