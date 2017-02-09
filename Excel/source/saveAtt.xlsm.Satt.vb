Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Sub start_Click()
Call SaveAttach
End Sub

Sub SaveAttach()
If testing Then Exit Sub

    Dim olItems As Outlook.Items
    Dim olMailItem As Outlook.MailItem
    Dim olMailItemReply As Outlook.MailItem

    Dim objNS As Namespace


    Dim olApp As Outlook.Application
    Set olApp = New Outlook.Application


    Set objNS = olApp.GetNamespace("MAPI")
    'Set olItems = objNS.GetDefaultFolder(olFolderInbox).Items
    Set olItems = objNS.GetDefaultFolder(olFolderInbox).Folders("AppD_DailyReport").Items

    Dim objAtt As Outlook.Attachment
    Dim saveFolder As String
    saveFolder = "C:\Ddriver\project\Daily_Report\mailrpt\"
    Dim i As Integer
    For i = 1 To olItems.Count
        If TypeOf olItems(i) Is MailItem Then
            Set olMailItem = olItems(i)
            'If StartsWith(olMailItem.Subject, "Testing") Then
            If StartsWith(olMailItem.subject, "Metrics Reporting (Daily)") Then
                If olMailItem.ReceivedTime > Date Then
                    If olMailItem.Attachments.Count > 0 Then
                        For Each objAtt In olMailItem.Attachments
                            'objAtt.SaveAsFile saveFolder & objAtt.DisplayName
                        Next
                        Set objAtt = Nothing
                    End If
                End If
            End If
        End If
    Next
    Set objNS = Nothing
    Set olApp = Nothing
    
    'Call bat lcrpt.bat
    Call Shell(ThisWorkbook.Sheets("saveAtt").Cells(1, 3))
    'run in b/e , not tested.
    'Set ws = CreateObject("Wscript.Shell")
    'ws.Run "cmd /c C:\**.bat", vbHide
    Sleep 1000
    'Sleep 121000
    Call Smail.BatchSendMail
End Sub
Function StartsWith(str1 As String, str2 As String)
StartsWith = InStr(1, str1, str2, vbTextCompare)
End Function
