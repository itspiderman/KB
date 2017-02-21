' Tools=>References
' Microseft Outlook X.0 Object Library

Public Sub AutoDeptId()
    If testing Then Exit Sub
    'Dim currentRow As Integer
    'currentRow = ActiveCell.Row
    'MsgBox GetFirstFailedVisibleRow(currentRow)
    Dim olItems As Outlook.Items
    Dim olMailItem As Outlook.MailItem

    Dim olMailItemReply As Outlook.MailItem

    Dim objNS As Namespace


    Dim olApp As Outlook.Application
    Set olApp = New Outlook.Application


    Set objNS = olApp.GetNamespace("test")
    Set olItems = objNS.GetDefaultFolder(olFolderInbox).Items

    'Dim fldr As MAPIFolder
    'Set fldr = olNs.GetDefaultFolder(olFolderInbox).Folders("mycust")
    Dim objAtt As Outlook.Attachment
    Dim saveFolder As String
    saveFolder = "C:\app\test\"
    Dim innerSaveFolder As String

    Dim dateStr As String
    Dim datetimeStr As String

    Dim xlBook As Workbook
    Dim xlSht As Worksheet

    'Dim xlApp As New Excel.Application
    Dim fso As Object
    Dim objFolder As Object
    Dim myFile As Object

    Dim i As Integer
    For i = olItems.count To olItems.count - 100 Step -1
        If TypeOf olItems(i) Is MailItem Then
            Set olMailItem = olItems(i)
            'If StartsWith(olMailItem.Subject, "Testing") Then
            If StartsWith(olMailItem.Subject, "Test to reply") Then

                If olMailItem.ReceivedTime > Date - 1 Then

                    MyMsgBox olMailItem.Subject, 5

                    If olMailItem.Attachments.count > 0 Then
                        dateStr = Format(olMailItem.ReceivedTime, "yyyyMMdd")
                        datetimeStr = Format(olMailItem.ReceivedTime, "yyyyMMddHHmmss")
                        innerSaveFolder = saveFolder & dateStr & "\"
                        CreateFolder saveFolder

                        For Each objAtt In olMailItem.Attachments
                            objAtt.SaveAsFile innerSaveFolder & datetimeStr & "_" & objAtt.DisplayName

                            'Unzip Replace(saveFolder & datetimeStr & "_" & objAtt.DisplayName, ".zip", ""), saveFolder & datetimeStr & "_" & objAtt.DisplayName

                            Unzip innerSaveFolder, innerSaveFolder & datetimeStr & "_" & objAtt.DisplayName
                            Kill innerSaveFolder & datetimeStr & "_" & objAtt.DisplayName


                            Set fso = CreateObject("Scripting.FileSystemObject")


                            Set objFolder = fso.GetFolder(innerSaveFolder)

                            For Each myFile In objFolder.Files
                                If InStr(myFile.Name, ".xlsx") > 0 Then
                                    MyMsgBox myFile.path, 5

                                    'xlApp.Visible = True
                                    'xlApp.EnableEvents = True
                                    Set xlBook = Application.Workbooks.Add(myFile.path)

                                    For Each xlSht In xlBook.Worksheets

                                        If xlSht.Cells(1, 1) <> "" And xlSht.Cells(1, 2) <> "" And xlSht.Cells(1, 3) <> "" And xlSht.Cells(1, 4) <> "" And xlSht.Cells(1, 5) <> "" Then
                                            If xlSht.Cells(1, 6) = "" Then
                                                xlSht.Cells(1, 6) = "#"
                                            End If
                                            'MsgBox xlSht.Cells(1, 1)
                                            xlSht.Activate
                                            Application.Run "Macro.xlam!ETbl"
                                            Application.Run "Macro.xlam!PUT"
                                            Application.Run "Macro.xlam!PPD"
                                        End If
                                    Next
                                    'xlApp.Quit
                                    xlBook.Close
                                    Set xlSht = Nothing
                                    Set xlBook = Nothing

                                    Kill myFile.path
                                End If
                            Next

                            Set objFolder = Nothing

                        Next
                        Set objAtt = Nothing

                        Set olMailItemReply = olMailItem.ReplyAll
                        olMailItemReply.Subject = olMailItemReply.Subject & " [done]"
                        olMailItemReply.BCC = olMailItemReply.SendUsingAccount
                        olMailItemReply.display
                        Sleep 5000
                        Application.SendKeys "%s"

                    End If

                End If
            End If
        End If
    Next

    Set objNS = Nothing
    Set olApp = Nothing
End Sub 
