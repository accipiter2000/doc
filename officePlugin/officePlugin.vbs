Dim App
Dim Doc

Dim SplitArray
Dim FileType
Dim Operation
Dim FilePath

If WScript.Arguments.Count < 1 Then
	WScript.Echo "wrong parameters"
	WScript.Quit
End If

SplitArray = Split(WScript.Arguments.Item(0), "$", -1)

If ubound(SplitArray) < 2 Then
	WScript.Echo "wrong parameters"
	WScript.Quit
End If

FileType = Mid(SplitArray(0), 10)
Operation = SplitArray(1)
For i = 2 To ubound(SplitArray)
	FilePath = FilePath + SplitArray(i)
	If i < ubound(SplitArray) Then
		FilePath = FilePath + "$"
	End If  
Next

If FileType <> "word" And FileType <> "excel" Then
	WScript.Echo "wrong file type"
	WScript.Quit
End If

If Operation <> "open" And Operation <> "print" And Operation <> "preview" Then
	WScript.Echo "wrong operation"
	WScript.Quit
End If

'��WordӦ�ó���
If FileType = "word" Then
	Set App = CreateObject("Word.application")
	Set Doc = App.Documents.Open(FilePath)
End If

'��ExcelӦ�ó���
If FileType = "excel" Then
	Set App = CreateObject("Excel.application")
	Set Doc = App.Workbooks.Open(FilePath)
End If

App.Visible = True
'App.Activate
Doc.Activate

If Operation = "preview" Then
	Doc.PrintPreview
End If

'��ӡ���ر��ĵ���Ӧ�ó���
If Operation = "print" Then
	Doc.PrintOut
	Doc.Close
	App.Quit
End If

'�ͷŶ���
Set Doc = Nothing
Set WordApp = Nothing
