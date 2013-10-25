Attribute VB_Name = "Module1"


Public Declare Sub vbrb_init Lib "mydll" ()
Public Declare Sub vbrb_cleanup Lib "mydll" ()
Public Declare Sub vbrb_eval_string Lib "mydll" (ByVal ss As String)


Public Declare Sub t Lib "mydll" ()

Public Declare Function nt Lib "mydll" () As Integer
Public Declare Function st Lib "mydll" () As String

Public Declare Sub ti Lib "mydll" (ByVal i As Integer)
Public Declare Function ts Lib "mydll" (ByVal s As String) As String

Public Declare Function encode Lib "mydll" (ByVal data As String, ByVal i As Long) As String



Public Declare Function rb_eval_string Lib "msvcrt-ruby200" (ByVal i As String) As Integer



Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long

