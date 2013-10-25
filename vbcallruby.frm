VERSION 5.00
Begin VB.Form VbCallRuby 
   Caption         =   "Form1"
   ClientHeight    =   6930
   ClientLeft      =   60
   ClientTop       =   360
   ClientWidth     =   7095
   LinkTopic       =   "Form1"
   ScaleHeight     =   6930
   ScaleWidth      =   7095
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin VB.TextBox txtRbstr 
      Height          =   1215
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   8
      Text            =   "vbcallruby.frx":0000
      Top             =   5040
      Width           =   6855
   End
   Begin VB.CommandButton btnevalrubystring 
      Caption         =   "eval ruby string"
      Height          =   495
      Left            =   3000
      TabIndex        =   7
      Top             =   6360
      Width           =   2295
   End
   Begin VB.CommandButton btnencode 
      Caption         =   "encode"
      Height          =   495
      Left            =   3120
      TabIndex        =   6
      Top             =   3720
      Width           =   1215
   End
   Begin VB.CommandButton btnts 
      Caption         =   "ts"
      Height          =   495
      Left            =   3120
      TabIndex        =   5
      Top             =   3000
      Width           =   1215
   End
   Begin VB.CommandButton btnti 
      Caption         =   "ti"
      Height          =   495
      Left            =   3120
      TabIndex        =   4
      Top             =   2400
      Width           =   1215
   End
   Begin VB.CommandButton btnst 
      Caption         =   "st"
      Height          =   495
      Left            =   3120
      TabIndex        =   3
      Top             =   1560
      Width           =   1215
   End
   Begin VB.CommandButton btnnt 
      Caption         =   "nt"
      Height          =   495
      Left            =   3120
      TabIndex        =   2
      Top             =   960
      Width           =   1215
   End
   Begin VB.CommandButton btnt 
      Caption         =   "t"
      Height          =   495
      Left            =   3120
      TabIndex        =   1
      Top             =   360
      Width           =   1215
   End
   Begin VB.CommandButton btnTestSys 
      Caption         =   "Test Syste Dll"
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   1575
   End
End
Attribute VB_Name = "VbCallRuby"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

'ruby function is cdecl, must convert to stdcall.
Private Sub init()
    'Dim Argv() As String

    'Call ruby_sysinit("1", Argv)
    'Call ruby_init
    
    Call vbrb_init
End Sub

Private Sub cleanup()
    Call vbrb_cleanup
End Sub

Private Sub Form_Load()
    init
End Sub

Private Sub Form_Unload(Cancel As Integer)
    cleanup
End Sub


'#################################################################

Private Sub btnTestSys_Click()
    Dim WinPath As String
    WinPath = String(145, Chr(0))
    Windowsdirectory = Left(WinPath, GetWindowsDirectory(WinPath, 145))
    
    MsgBox Windowsdirectory
End Sub


Private Sub btnt_Click()
    t
    MsgBox "no error"
End Sub

Private Sub btnnt_Click()
    Dim res As Integer
    res = nt
    MsgBox "rerurn: " & CStr(res)
End Sub

Private Sub btnst_Click()
    ' Bug, not receive string
    Dim res As String
    res = st
    MsgBox "return: " & st, vbCritical
End Sub


Private Sub btnti_Click()
    Dim i As Integer
    i = 19090
    ti (i)
    MsgBox "no error"
End Sub

Private Sub btnts_Click()
    Dim s As String
    Dim s2 As String
    s = "hello"
    s2 = ts(s)
    MsgBox s2
    
    Dim WinPath As String
    Dim s3 As String
    WinPath = String(32, "a")
    s3 = ts(WinPath)
    MsgBox s3
End Sub


Private Sub btnencode_Click()
    Dim hh() As Byte
    hh = StrConv("user", vbFromUnicode)
    Dim ii As String
    ii = encode(hh(0), UBound(hh) + 1)
    MsgBox ii
End Sub

Private Sub btnevalrubystring_Click()

'    Call vbrb_init
'On Error GoTo EERR
    
    Dim hh As String
    Dim res As Integer
    hh = txtRbstr.Text
    
    res = vbrb_eval_string(hh)
   ' rb_eval_string (hh)
    
    If res = 0 Then
        MsgBox "rb_eval_string  no error."
    Else
        MsgBox "rb_eval_string  return error", vbCritical
    End If
    Exit Sub
EERR:
    MsgBox "On Err end"

End Sub
