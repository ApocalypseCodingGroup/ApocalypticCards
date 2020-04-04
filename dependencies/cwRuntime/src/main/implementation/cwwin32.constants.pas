{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be
     used to endorse or promote products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
  IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
{$endif}
/// <remarks>
///   cwWin32.xxx represents an incomplete Win32 API binding.
/// </remarks>
unit cwWin32.Constants;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
const
  ANYSIZE_ARRAY = 1;
  HW_PROFILE_GUIDLEN = 39;                 { 36 + Z Z Z }
  MAX_PROFILE_LEN = 80;
  CCHDEVICENAME = 32;
  CCHFORMNAME = 32;
  MAX_PATH = 260;
  MAX_DEFAULTCHAR = 2;
  MAX_LEADBYTES   = 12;
  SIZE_OF_80387_REGISTERS = 80;
  MAXIMUM_SUPPORTED_EXTENSION = 512;
  MAX_MODULE_NAME32 = 255;
  OFS_MAXPATHNAME = 128;
  EXCEPTION_MAXIMUM_PARAMETERS = 15;
  CCHILDREN_SCROLLBAR = 5;
  LF_FACESIZE = 32;
  LF_FULLFACESIZE = 64;
  MM_MAX_NUMAXES     = 16;

  INVALID_HANDLE           = -1;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms644943(v=vs.85).aspx
  ///  </summary>
  PM_NOREMOVE               = $00;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms644943(v=vs.85).aspx
  ///  </summary>
  PM_REMOVE                 = $01;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms644943(v=vs.85).aspx
  ///  </summary>
  PM_NOYIELD                = $02;

const
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632613(v=vs.85).aspx
  ///  </summary>
  MN_GETHMENU               = $01E1;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648055(v=vs.85).aspx
  ///  </summary>
  WM_ERASEBKGND             = $0014;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632624(v=vs.85).aspx
  ///  </summary>
  WM_GETFONT                = $0031;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632627(v=vs.85).aspx
  ///  </summary>
  WM_GETTEXT                = $000D;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632628(v=vs.85).aspx
  ///  </summary>
  WM_GETTEXTLENGTH          = $000E;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632642(v=vs.85).aspx
  ///  </summary>
  WM_SETFONT                = $0030;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632643(v=vs.85).aspx
  ///  </summary>
  WM_SETICON                = $0080;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632644(v=vs.85).aspx
  ///  </summary>
  WM_SETTEXT                = $000C;

  ///  <summary>
  ///  </summary>
  INFINITE = Cardinal($FFFFFFFF);

const
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632614(v=vs.85).aspx
  ///  </summary>
  WM_ACTIVATEAPP            = $001C;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632615(v=vs.85).aspx
  ///  </summary>
  WM_CANCELMODE             = $001F;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632616(v=vs.85).aspx
  ///  </summary>
  WM_CHILDACTIVATE          = $0022;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632617(v=vs.85).aspx
  ///  </summary>
  WM_CLOSE                  = $0010;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632618(v=vs.85).aspx
  ///  </summary>
  WM_COMPACTING             = $0041;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632619(v=vs.85).aspx
  ///  </summary>
  WM_CREATE                 = $0001;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632620(v=vs.85).aspx
  ///  </summary>
  WM_DESTROY                = $0002;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dn312083(v=vs.85).aspx
  ///  </summary>
  WM_DPICHANGED             = $02E0;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632621(v=vs.85).aspx
  ///  </summary>
  WM_ENABLE                 = $000A;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632622(v=vs.85).aspx
  ///  </summary>
  WM_ENTERSIZEMOVE          = $0231;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632623(v=vs.85).aspx
  ///  </summary>
  WM_EXITSIZEMOVE           = $0232;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632625(v=vs.85).aspx
  ///  </summary>
  WM_GETICON                = $007F;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632626(v=vs.85).aspx
  ///  </summary>
  WM_GETMINMAXINFO          = $0024;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632629(v=vs.85).aspx
  ///  </summary>
  WM_INPUTLANGCHANGE        = $0051;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632630(v=vs.85).aspx
  ///  </summary>
  WM_INPUTLANGCHANGEREQUEST = $0050;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632631(v=vs.85).aspx
  ///  </summary>
  WM_MOVE                   = $0003;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632632(v=vs.85).aspx
  ///  </summary>
  WM_MOVING                 = $0216;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632633(v=vs.85).aspx
  ///  </summary>
  WM_NCACTIVATE             = $0086;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632634(v=vs.85).aspx
  ///  </summary>
  WM_NCCALCSIZE             = $0083;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632635(v=vs.85).aspx
  ///  </summary>
  WM_NCCREATE               = $0081;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632636(v=vs.85).aspx
  ///  </summary>
  WM_NCDESTROY              = $0082;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632637(v=vs.85).aspx
  ///  </summary>
  WM_NULL                   = $0000;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632639(v=vs.85).aspx
  ///  </summary>
  WM_QUERYDRAGICON          = $0037;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632640(v=vs.85).aspx
  ///  </summary>
  WM_QUERYOPEN              = $0013;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632641(v=vs.85).aspx
  ///  </summary>
  WM_QUIT                   = $0012;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632645(v=vs.85).aspx
  ///  </summary>
  WM_SHOWWINDOW             = $0018;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632646(v=vs.85).aspx
  ///  </summary>
  WM_SIZE                   = $0005;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632647(v=vs.85).aspx
  ///  </summary>
  WM_SIZING                 = $0214;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632648(v=vs.85).aspx
  ///  </summary>
  WM_STYLECHANGED           = $007D;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632649(v=vs.85).aspx
  ///  </summary>
  WM_STYLECHANGING          = $007C;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632650(v=vs.85).aspx
  ///  </summary>
  WM_THEMECHANGED           = $031A;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632651(v=vs.85).aspx
  ///  </summary>
  WM_USERCHANGED            = $0054;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632652(v=vs.85).aspx
  ///  </summary>
  WM_WINDOWPOSCHANGED       = $0047;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632653(v=vs.85).aspx
  ///  </summary>
  WM_WINDOWPOSCHANGING      = $0046;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646274(v=vs.85).aspx
  ///  </summary>
  WM_ACTIVATE = $0006;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646283(v=vs.85).aspx
  ///  </summary>
  WM_SETFOCUS = $0007;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646282(v=vs.85).aspx
  ///  </summary>
  WM_KILLFOCUS = $0008;

  ///  <summary>
  ///  </summary>
  WM_SETREDRAW = $000b;

  ///  <summary>
  ///  </summary>
  WM_PAINT = $000f;

  ///  <summary>
  ///  </summary>
  WM_QUERYENDSESSION = $0011;

  ///  <summary>
  ///  </summary>
  WM_SYSCOLORCHANGE = $0015;

  ///  <summary>
  ///  </summary>
  WM_ENDSESSION = $0015;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLOR = $0015;

  ///  <summary>
  ///  </summary>
  WM_WININICHANGE = $0015;

  ///  <summary>
  ///  </summary>
  WM_DEVMODECHANGE = $0015;

  ///  <summary>
  ///  </summary>
  WM_FONTCHANGE = $0015;

  ///  <summary>
  ///  </summary>
  WM_TIMECHANGE = $0015;

  ///  <summary>
  ///  </summary>
  WM_SETCURSOR = $0015;

  ///  <summary>
  ///  </summary>
  WM_MOUSEACTIVATE = $0015;

  ///  <summary>
  ///  </summary>
  WM_QUEUESYNC = $0015;

  ///  <summary>
  ///  </summary>
  WM_PAINTICON = $0015;

  ///  <summary>
  ///  </summary>
  WM_ICONERASEBKGND = $0015;

  ///  <summary>
  ///  </summary>
  WM_NEXTDLGCTL = $0015;

  ///  <summary>
  ///  </summary>
  WM_SPOOLERSTATUS = $0015;

  ///  <summary>
  ///  </summary>
  WM_DRAWITEM = $0015;

  ///  <summary>
  ///  </summary>
  WM_MEASUREITEM = $0015;

  ///  <summary>
  ///  </summary>
  WM_DELETEITEM = $0015;

  ///  <summary>
  ///  </summary>
  WM_VKEYTOITEM = $0015;

  ///  <summary>
  ///  </summary>
  WM_CHARTOITEM = $0015;

  ///  <summary>
  ///  </summary>
  WM_SETHOTKEY = $0015;

  ///  <summary>
  ///  </summary>
  WM_GETHOTKEY = $0015;

  ///  <summary>
  ///  </summary>
  WM_COMPAREITEM = $0015;

  ///  <summary>
  ///  </summary>
  WM_GETOBJECT = $0015;

  ///  <summary>
  ///  </summary>
  WM_COMMNOTIFY = $0015;

  ///  <summary>
  ///  </summary>
  WM_POWER = $0015;

  ///  <summary>
  ///  </summary>
  WM_COPYGLOBALDATA = $0015;

  ///  <summary>
  ///  </summary>
  WM_COPYDATA = $0015;

  ///  <summary>
  ///  </summary>
  WM_CANCELJOURNAL = $0015;

  ///  <summary>
  ///  </summary>
  WM_NOTIFY = $0015;

  ///  <summary>
  ///  </summary>
  WM_TCARD = $0015;

  ///  <summary>
  ///  </summary>
  WM_HELP = $0015;

  ///  <summary>
  ///  </summary>
  WM_NOTIFYFORMAT = $0015;

  ///  <summary>
  ///  </summary>
  WM_CONTEXTMENU = $0015;

  ///  <summary>
  ///  </summary>
  WM_DISPLAYCHANGE = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCHITTEST = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCPAINT = $0015;

  ///  <summary>
  ///  </summary>
  WM_GETDLGCODE = $0015;

  ///  <summary>
  ///  </summary>
  WM_SYNCPAINT = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCMOUSEMOVE = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCLBUTTONDOWN = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCLBUTTONUP = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCLBUTTONDBLCLK = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCRBUTTONDOWN = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCRBUTTONUP = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCRBUTTONDBLCLK = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCMBUTTONDOWN = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCMBUTTONUP = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCMBUTTONDBLCLK = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCXBUTTONDOWN = $0015;

  ///  <summary>
  ///  </summary>
  WM_NCXBUTTONUP = $00ac;

  ///  <summary>
  ///  </summary>
  WM_NCXBUTTONDBLCLK = $00ad;

  ///  <summary>
  ///  </summary>
  EM_GETSEL = $00b0;

  ///  <summary>
  ///  </summary>
  EM_SETSEL = $00b1;

  ///  <summary>
  ///  </summary>
  EM_GETRECT = $00b2;

  ///  <summary>
  ///  </summary>
  EM_SETRECT = $00b3;

  ///  <summary>
  ///  </summary>
  EM_SETRECTNP = $00b4;

  ///  <summary>
  ///  </summary>
  EM_SCROLL = $00b5;

  ///  <summary>
  ///  </summary>
  EM_LINESCROLL = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SCROLLCARET = $00b5;

  ///  <summary>
  ///  </summary>
  EM_GETMODIFY = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SETMODIFY = $00b5;

  ///  <summary>
  ///  </summary>
  EM_GETLINECOUNT = $00b5;

  ///  <summary>
  ///  </summary>
  EM_LINEINDEX = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SETHANDLE = $00b5;

  ///  <summary>
  ///  </summary>
  EM_GETHANDLE = $00b5;

  ///  <summary>
  ///  </summary>
  EM_GETTHUMB = $00b5;

  ///  <summary>
  ///  </summary>
  EM_LINELENGTH = $00b5;

  ///  <summary>
  ///  </summary>
  EM_REPLACESEL = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SETFONT = $00b5;

  ///  <summary>
  ///  </summary>
  EM_GETLINE = $00b5;

  ///  <summary>
  ///  </summary>
  EM_LIMITTEXT = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SETLIMITTEXT = $00b5;

  ///  <summary>
  ///  </summary>
  EM_CANUNDO = $00b5;

  ///  <summary>
  ///  </summary>
  EM_UNDO = $00b5;

  ///  <summary>
  ///  </summary>
  EM_FMTLINES = $00b5;

  ///  <summary>
  ///  </summary>
  EM_LINEFROMCHAR = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SETWORDBREAK = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SETTABSTOPS = $00b5;

  ///  <summary>
  ///  </summary>
  EM_SETPASSWORDCHAR = $00b5;

  ///  <summary>
  ///  </summary>
  EM_EMPTYUNDOBUFFER = $00cd;

  ///  <summary>
  ///  </summary>
  EM_GETFIRSTVISIBLELINE = $00ce;

  ///  <summary>
  ///  </summary>
  EM_SETREADONLY = $00cf;

  ///  <summary>
  ///  </summary>
  EM_SETWORDBREAKPROC = $00d0;

  ///  <summary>
  ///  </summary>
  EM_GETWORDBREAKPROC = $00d1;

  ///  <summary>
  ///  </summary>
  EM_GETPASSWORDCHAR = $00d2;

  ///  <summary>
  ///  </summary>
  EM_SETMARGINS = $00d2;

  ///  <summary>
  ///  </summary>
  EM_GETMARGINS = $00d2;

  ///  <summary>
  ///  </summary>
  EM_GETLIMITTEXT = $00d2;

  ///  <summary>
  ///  </summary>
  EM_POSFROMCHAR = $00d2;

  ///  <summary>
  ///  </summary>
  EM_CHARFROMPOS = $00d2;

  ///  <summary>
  ///  </summary>
  EM_SETIMESTATUS = $00d2;

  ///  <summary>
  ///  </summary>
  EM_GETIMESTATUS = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_SETPOS = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_GETPOS = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_SETRANGE = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_GETRANGE = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_ENABLE_ARROWS = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_SETRANGEREDRAW = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_SETSCROLLINFO = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_GETSCROLLINFO = $00d2;

  ///  <summary>
  ///  </summary>
  SBM_GETSCROLLBARINFO = $00d2;

  ///  <summary>
  ///  </summary>
  BM_GETCHECK = $00d2;

  ///  <summary>
  ///  </summary>
  BM_SETCHECK = $00d2;

  ///  <summary>
  ///  </summary>
  BM_GETSTATE = $00d2;

  ///  <summary>
  ///  </summary>
  BM_SETSTATE = $00d2;

  ///  <summary>
  ///  </summary>
  BM_SETSTYLE = $00d2;

  ///  <summary>
  ///  </summary>
  BM_CLICK = $00d2;

  ///  <summary>
  ///  </summary>
  BM_GETIMAGE = $00d2;

  ///  <summary>
  ///  </summary>
  BM_SETIMAGE = $00d2;

  ///  <summary>
  ///  </summary>
  BM_SETDONTCLICK = $00d2;

  ///  <summary>
  ///  </summary>
  WM_INPUT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_KEYDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_KEYFIRST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_KEYUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CHAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_DEADCHAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SYSKEYDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SYSKEYUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SYSCHAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SYSDEADCHAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_KEYLAST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_UNICHAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_WNT_CONVERTREQUESTEX = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CONVERTREQUEST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CONVERTRESULT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_INTERIM = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_STARTCOMPOSITION = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_ENDCOMPOSITION = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_COMPOSITION = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_KEYLAST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_INITDIALOG = $00d2;

  ///  <summary>
  ///  </summary>
  WM_COMMAND = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SYSCOMMAND = $00d2;

  ///  <summary>
  ///  </summary>
  WM_TIMER = $00d2;

  ///  <summary>
  ///  </summary>
  WM_HSCROLL = $00d2;

  ///  <summary>
  ///  </summary>
  WM_VSCROLL = $00d2;

  ///  <summary>
  ///  </summary>
  WM_INITMENU = $00d2;

  ///  <summary>
  ///  </summary>
  WM_INITMENUPOPUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SYSTIMER = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MENUSELECT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MENUCHAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_ENTERIDLE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MENURBUTTONUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MENUDRAG = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MENUGETOBJECT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_UNINITMENUPOPUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MENUCOMMAND = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CHANGEUISTATE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_UPDATEUISTATE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_QUERYUISTATE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLORMSGBOX = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLOREDIT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLORLISTBOX = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLORBTN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLORDLG = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLORSCROLLBAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLCOLORSTATIC = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MOUSEFIRST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MOUSEMOVE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_LBUTTONDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_LBUTTONUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_LBUTTONDBLCLK = $00d2;

  ///  <summary>
  ///  </summary>
  WM_RBUTTONDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_RBUTTONUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_RBUTTONDBLCLK = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MBUTTONDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MBUTTONUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MBUTTONDBLCLK = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MOUSELAST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MOUSEWHEEL = $00d2;

  ///  <summary>
  ///  </summary>
  WM_XBUTTONDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_XBUTTONUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_XBUTTONDBLCLK = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PARENTNOTIFY = $00d2;

  ///  <summary>
  ///  </summary>
  WM_ENTERMENULOOP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_EXITMENULOOP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_NEXTMENU = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CAPTURECHANGED = $00d2;

  ///  <summary>
  ///  </summary>
  WM_POWERBROADCAST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_DEVICECHANGE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDICREATE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDIDESTROY = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDIACTIVATE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDIRESTORE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDINEXT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDIMAXIMIZE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDITILE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDICASCADE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDIICONARRANGE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDIGETACTIVE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDISETMENU = $00d2;

  ///  <summary>
  ///  </summary>
  WM_DROPFILES = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MDIREFRESHMENU = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_REPORT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_SETCONTEXT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_NOTIFY = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_CONTROL = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_COMPOSITIONFULL = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_SELECT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_CHAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_REQUEST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IMEKEYDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_KEYDOWN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IMEKEYUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_IME_KEYUP = $00d2;

  ///  <summary>
  ///  </summary>
  WM_NCMOUSEHOVER = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MOUSEHOVER = $00d2;

  ///  <summary>
  ///  </summary>
  WM_NCMOUSELEAVE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_MOUSELEAVE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CUT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_COPY = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PASTE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CLEAR = $00d2;

  ///  <summary>
  ///  </summary>
  WM_UNDO = $00d2;

  ///  <summary>
  ///  </summary>
  WM_RENDERFORMAT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_RENDERALLFORMATS = $00d2;

  ///  <summary>
  ///  </summary>
  WM_DESTROYCLIPBOARD = $00d2;

  ///  <summary>
  ///  </summary>
  WM_DRAWCLIPBOARD = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PAINTCLIPBOARD = $00d2;

  ///  <summary>
  ///  </summary>
  WM_VSCROLLCLIPBOARD = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SIZECLIPBOARD = $00d2;

  ///  <summary>
  ///  </summary>
  WM_ASKCBFORMATNAME = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CHANGECBCHAIN = $00d2;

  ///  <summary>
  ///  </summary>
  WM_HSCROLLCLIPBOARD = $00d2;

  ///  <summary>
  ///  </summary>
  WM_QUERYNEWPALETTE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PALETTEISCHANGING = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PALETTECHANGED = $00d2;

  ///  <summary>
  ///  </summary>
  WM_HOTKEY = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PRINT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PRINTCLIENT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_APPCOMMAND = $00d2;

  ///  <summary>
  ///  </summary>
  WM_HANDHELDFIRST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_HANDHELDLAST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_AFXFIRST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_AFXLAST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PENWINFIRST = $00d2;

  ///  <summary>
  ///  </summary>
  WM_RCRESULT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_HOOKRCRESULT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_GLOBALRCCHANGE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PENMISCINFO = $00d2;

  ///  <summary>
  ///  </summary>
  WM_SKB = $00d2;

  ///  <summary>
  ///  </summary>
  WM_HEDITCTL = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PENCTL = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PENMISC = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CTLINIT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PENEVENT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PENWINLAST = $00d2;

  ///  <summary>
  ///  </summary>
  DDM_SETFMT = $00d2;

  ///  <summary>
  ///  </summary>
  DM_GETDEFID = $00d2;

  ///  <summary>
  ///  </summary>
  NIN_SELECT = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETPOS = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PSD_PAGESETUPDLG = $00d2;

  ///  <summary>
  ///  </summary>
  WM_USER = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_INSERTITEMA = $00d2;

  ///  <summary>
  ///  </summary>
  DDM_DRAW = $00d2;

  ///  <summary>
  ///  </summary>
  DM_SETDEFID = $00d2;

  ///  <summary>
  ///  </summary>
  HKM_SETHOTKEY = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_SETRANGE = $00d2;

  ///  <summary>
  ///  </summary>
  RB_INSERTBANDA = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SETTEXTA = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ENABLEBUTTON = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETRANGEMIN = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_ACTIVATE = $00d2;

  ///  <summary>
  ///  </summary>
  WM_CHOOSEFONT_GETLOGFONT = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PSD_FULLPAGERECT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_SETIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  DDM_CLOSE = $00d2;

  ///  <summary>
  ///  </summary>
  DM_REPOSITION = $00d2;

  ///  <summary>
  ///  </summary>
  HKM_GETHOTKEY = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_SETPOS = $00d2;

  ///  <summary>
  ///  </summary>
  RB_DELETEBAND = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETTEXTA = $00d2;

  ///  <summary>
  ///  </summary>
  TB_CHECKBUTTON = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETRANGEMAX = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PSD_MINMARGINRECT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_GETIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  DDM_BEGIN = $00d2;

  ///  <summary>
  ///  </summary>
  HKM_SETRULES = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_DELTAPOS = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETBARINFO = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETTEXTLENGTHA = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETTIC = $00d2;

  ///  <summary>
  ///  </summary>
  TB_PRESSBUTTON = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETDELAYTIME = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PSD_MARGINRECT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_GETITEMA = $00d2;

  ///  <summary>
  ///  </summary>
  DDM_END = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_SETSTEP = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETBARINFO = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SETPARTS = $00d2;

  ///  <summary>
  ///  </summary>
  TB_HIDEBUTTON = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETTIC = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_ADDTOOLA = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PSD_GREEKTEXTRECT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_SETITEMA = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_STEPIT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_INDETERMINATE = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETPOS = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_DELTOOLA = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PSD_ENVSTAMPRECT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_GETCOMBOCONTROL = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_SETRANGE32 = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETBANDINFOA = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETPARTS = $00d2;

  ///  <summary>
  ///  </summary>
  TB_MARKBUTTON = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETRANGE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_NEWTOOLRECTA = $00d2;

  ///  <summary>
  ///  </summary>
  WM_PSD_YAFULLPAGERECT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_GETEDITCONTROL = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_GETRANGE = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETPARENT = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETBORDERS = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETRANGEMIN = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_RELAYEVENT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_SETEXSTYLE = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_GETPOS = $00d2;

  ///  <summary>
  ///  </summary>
  RB_HITTEST = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SETMINHEIGHT = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETRANGEMAX = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETTOOLINFOA = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_GETEXSTYLE = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_GETEXTENDEDSTYLE = $00d2;

  ///  <summary>
  ///  </summary>
  PBM_SETBARCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETRECT = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SIMPLE = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ISBUTTONENABLED = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_CLEARTICS = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETTOOLINFOA = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_HASEDITCHANGED = $00d2;

  ///  <summary>
  ///  </summary>
  RB_INSERTBANDW = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETRECT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ISBUTTONCHECKED = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETSEL = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_HITTESTA = $00d2;

  ///  <summary>
  ///  </summary>
  WIZ_QUERYNUMPAGES = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_INSERTITEMW = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETBANDINFOW = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SETTEXTW = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ISBUTTONPRESSED = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETSELSTART = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETTEXTA = $00d2;

  ///  <summary>
  ///  </summary>
  WIZ_NEXT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_SETITEMW = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETBANDCOUNT = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETTEXTLENGTHW = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ISBUTTONHIDDEN = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETSELEND = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_UPDATETIPTEXTA = $00d2;

  ///  <summary>
  ///  </summary>
  WIZ_PREV = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_GETITEMW = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETROWCOUNT = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETTEXTW = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ISBUTTONINDETERMINATE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETTOOLCOUNT = $00d2;

  ///  <summary>
  ///  </summary>
  CBEM_SETEXTENDEDSTYLE = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETROWHEIGHT = $00d2;

  ///  <summary>
  ///  </summary>
  SB_ISSIMPLE = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ISBUTTONHIGHLIGHTED = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETPTICS = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_ENUMTOOLSA = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SETICON = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETTICPOS = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETCURRENTTOOLA = $00d2;

  ///  <summary>
  ///  </summary>
  RB_IDTOINDEX = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SETTIPTEXTA = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETNUMTICS = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_WINDOWFROMPOINT = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETTOOLTIPS = $00d2;

  ///  <summary>
  ///  </summary>
  SB_SETTIPTEXTW = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETSELSTART = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETSTATE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_TRACKACTIVATE = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETTOOLTIPS = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETTIPTEXTA = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETSTATE = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETSELEND = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_TRACKPOSITION = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETBKCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETTIPTEXTW = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ADDBITMAP = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_CLEARSEL = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETTIPBKCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETBKCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  SB_GETICON = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ADDBUTTONSA = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETTICFREQ = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETTIPTEXTCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETTEXTCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  TB_INSERTBUTTONA = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETPAGESIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETDELAYTIME = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETTEXTCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  TB_DELETEBUTTON = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETPAGESIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETTIPBKCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SIZETORECT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETBUTTON = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETLINESIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETTIPTEXTCOLOR = $00d2;

  ///  <summary>
  ///  </summary>
  RB_BEGINDRAG = $00d2;

  ///  <summary>
  ///  </summary>
  TB_BUTTONCOUNT = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETLINESIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETMAXTIPWIDTH = $00d2;

  ///  <summary>
  ///  </summary>
  RB_ENDDRAG = $00d2;

  ///  <summary>
  ///  </summary>
  TB_COMMANDTOINDEX = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETTHUMBRECT = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETMAXTIPWIDTH = $00d2;

  ///  <summary>
  ///  </summary>
  RB_DRAGMOVE = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETCHANNELRECT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SAVERESTOREA = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETMARGIN = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETBARHEIGHT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_CUSTOMIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETTHUMBLENGTH = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETMARGIN = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETBANDINFOW = $00d2;

  ///  <summary>
  ///  </summary>
  TB_ADDSTRINGA = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETTHUMBLENGTH = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_POP = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETBANDINFOA = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETITEMRECT = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETTOOLTIPS = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_UPDATE = $00d2;

  ///  <summary>
  ///  </summary>
  RB_MINIMIZEBAND = $00d2;

  ///  <summary>
  ///  </summary>
  TB_BUTTONSTRUCTSIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETTOOLTIPS = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETBUBBLESIZE = $00d2;

  ///  <summary>
  ///  </summary>
  RB_MAXIMIZEBAND = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETTIPSIDE = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETBUTTONSIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_ADJUSTRECT = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_SETBUDDY = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETBITMAPSIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETTITLEA = $00d2;

  ///  <summary>
  ///  </summary>
  MSG_FTS_JUMP_VA = $00d2;

  ///  <summary>
  ///  </summary>
  TB_AUTOSIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TBM_GETBUDDY = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETTITLEW = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETBANDBORDERS = $00d2;

  ///  <summary>
  ///  </summary>
  MSG_FTS_JUMP_QWORD = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SHOWBAND = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETTOOLTIPS = $00d2;

  ///  <summary>
  ///  </summary>
  MSG_REINDEX_REQUEST = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETTOOLTIPS = $00d2;

  ///  <summary>
  ///  </summary>
  MSG_FTS_WHERE_IS_IT = $00d2;

  ///  <summary>
  ///  </summary>
  RB_SETPALETTE = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETPARENT = $00d2;

  ///  <summary>
  ///  </summary>
  RB_GETPALETTE = $00d2;

  ///  <summary>
  ///  </summary>
  RB_MOVEBAND = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETROWS = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETROWS = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETBITMAPFLAGS = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETCMDID = $00d2;

  ///  <summary>
  ///  </summary>
  RB_PUSHCHEVRON = $00d2;

  ///  <summary>
  ///  </summary>
  TB_CHANGEBITMAP = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETBITMAP = $00d2;

  ///  <summary>
  ///  </summary>
  MSG_GET_DEFFONT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETBUTTONTEXTA = $00d2;

  ///  <summary>
  ///  </summary>
  TB_REPLACEBITMAP = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETINDENT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  TB_LOADIMAGES = $00d2;

  ///  <summary>
  ///  </summary>
  EM_CANPASTE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_ADDTOOLW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_DISPLAYBAND = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETRECT = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_DELTOOLW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_EXGETSEL = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETHOTIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_NEWTOOLRECTW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_EXLIMITTEXT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETHOTIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETTOOLINFOW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_EXLINEFROMCHAR = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETDISABLEDIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_SETTOOLINFOW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_EXSETSEL = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETDISABLEDIMAGELIST = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_HITTESTW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_FINDTEXT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETSTYLE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETTEXTW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_FORMATRANGE = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETSTYLE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_UPDATETIPTEXTW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_GETCHARFORMAT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETBUTTONSIZE = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_ENUMTOOLSW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_GETEVENTMASK = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETBUTTONWIDTH = $00d2;

  ///  <summary>
  ///  </summary>
  TTM_GETCURRENTTOOLW = $00d2;

  ///  <summary>
  ///  </summary>
  EM_GETOLEINTERFACE = $00d2;

  ///  <summary>
  ///  </summary>
  TB_SETMAXTEXTROWS = $00d2;

  ///  <summary>
  ///  </summary>
  EM_GETPARAFORMAT = $00d2;

  ///  <summary>
  ///  </summary>
  TB_GETTEXTROWS = $043d;

  ///  <summary>
  ///  </summary>
  EM_GETSELTEXT = $043e;

  ///  <summary>
  ///  </summary>
  TB_GETOBJECT = $043e;

  ///  <summary>
  ///  </summary>
  EM_HIDESELECTION = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETBUTTONINFOW = $043f;

  ///  <summary>
  ///  </summary>
  EM_PASTESPECIAL = $043f;

  ///  <summary>
  ///  </summary>
  TB_SETBUTTONINFOW = $043f;

  ///  <summary>
  ///  </summary>
  EM_REQUESTRESIZE = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETBUTTONINFOA = $043f;

  ///  <summary>
  ///  </summary>
  EM_SELECTIONTYPE = $043f;

  ///  <summary>
  ///  </summary>
  TB_SETBUTTONINFOA = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETBKGNDCOLOR = $043f;

  ///  <summary>
  ///  </summary>
  TB_INSERTBUTTONW = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETCHARFORMAT = $043f;

  ///  <summary>
  ///  </summary>
  TB_ADDBUTTONSW = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETEVENTMASK = $043f;

  ///  <summary>
  ///  </summary>
  TB_HITTEST = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETOLECALLBACK = $043f;

  ///  <summary>
  ///  </summary>
  TB_SETDRAWTEXTFLAGS = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETPARAFORMAT = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETHOTITEM = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETTARGETDEVICE = $043f;

  ///  <summary>
  ///  </summary>
  TB_SETHOTITEM = $043f;

  ///  <summary>
  ///  </summary>
  EM_STREAMIN = $043f;

  ///  <summary>
  ///  </summary>
  TB_SETANCHORHIGHLIGHT = $043f;

  ///  <summary>
  ///  </summary>
  EM_STREAMOUT = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETANCHORHIGHLIGHT = $043f;

  ///  <summary>
  ///  </summary>
  EM_GETTEXTRANGE = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETBUTTONTEXTW = $043f;

  ///  <summary>
  ///  </summary>
  EM_FINDWORDBREAK = $043f;

  ///  <summary>
  ///  </summary>
  TB_SAVERESTOREW = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETOPTIONS = $043f;

  ///  <summary>
  ///  </summary>
  TB_ADDSTRINGW = $043f;

  ///  <summary>
  ///  </summary>
  EM_GETOPTIONS = $043f;

  ///  <summary>
  ///  </summary>
  TB_MAPACCELERATORA = $043f;

  ///  <summary>
  ///  </summary>
  EM_FINDTEXTEX = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETINSERTMARK = $043f;

  ///  <summary>
  ///  </summary>
  EM_GETWORDBREAKPROCEX = $043f;

  ///  <summary>
  ///  </summary>
  TB_SETINSERTMARK = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETWORDBREAKPROCEX = $043f;

  ///  <summary>
  ///  </summary>
  TB_INSERTMARKHITTEST = $043f;

  ///  <summary>
  ///  </summary>
  EM_SETUNDOLIMIT = $043f;

  ///  <summary>
  ///  </summary>
  TB_MOVEBUTTON = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETMAXSIZE = $043f;

  ///  <summary>
  ///  </summary>
  EM_REDO = $043f;

  ///  <summary>
  ///  </summary>
  TB_SETEXTENDEDSTYLE = $043f;

  ///  <summary>
  ///  </summary>
  EM_CANREDO = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETEXTENDEDSTYLE = $043f;

  ///  <summary>
  ///  </summary>
  EM_GETUNDONAME = $043f;

  ///  <summary>
  ///  </summary>
  TB_GETPADDING = $043f;

  ///  <summary>
  ///  </summary>
  EM_GETREDONAME = $0457;

  ///  <summary>
  ///  </summary>
  TB_SETPADDING = $0457;

  ///  <summary>
  ///  </summary>
  EM_STOPGROUPTYPING = $0458;

  ///  <summary>
  ///  </summary>
  TB_SETINSERTMARKCOLOR = $0458;

  ///  <summary>
  ///  </summary>
  EM_SETTEXTMODE = $0459;

  ///  <summary>
  ///  </summary>
  TB_GETINSERTMARKCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETTEXTMODE = $0459;

  ///  <summary>
  ///  </summary>
  TB_MAPACCELERATORW = $0459;

  ///  <summary>
  ///  </summary>
  EM_AUTOURLDETECT = $0459;

  ///  <summary>
  ///  </summary>
  TB_GETSTRINGW = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETAUTOURLDETECT = $0459;

  ///  <summary>
  ///  </summary>
  TB_GETSTRINGA = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETPALETTE = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETTEXTEX = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETTEXTLENGTHEX = $0459;

  ///  <summary>
  ///  </summary>
  EM_SHOWSCROLLBAR = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETTEXTEX = $0459;

  ///  <summary>
  ///  </summary>
  TAPI_REPLY = $0459;

  ///  <summary>
  ///  </summary>
  ACM_OPENA = $0459;

  ///  <summary>
  ///  </summary>
  BFFM_SETSTATUSTEXTA = $0459;

  ///  <summary>
  ///  </summary>
  CDM_FIRST = $0459;

  ///  <summary>
  ///  </summary>
  CDM_GETSPEC = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETPUNCTUATION = $0459;

  ///  <summary>
  ///  </summary>
  IPM_CLEARADDRESS = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_UNICODE_START = $0459;

  ///  <summary>
  ///  </summary>
  ACM_PLAY = $0459;

  ///  <summary>
  ///  </summary>
  BFFM_ENABLEOK = $0459;

  ///  <summary>
  ///  </summary>
  CDM_GETFILEPATH = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETPUNCTUATION = $0459;

  ///  <summary>
  ///  </summary>
  IPM_SETADDRESS = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETCURSEL = $0459;

  ///  <summary>
  ///  </summary>
  UDM_SETRANGE = $0459;

  ///  <summary>
  ///  </summary>
  WM_CHOOSEFONT_SETLOGFONT = $0459;

  ///  <summary>
  ///  </summary>
  ACM_STOP = $0459;

  ///  <summary>
  ///  </summary>
  BFFM_SETSELECTIONA = $0459;

  ///  <summary>
  ///  </summary>
  CDM_GETFOLDERPATH = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETWORDWRAPMODE = $0459;

  ///  <summary>
  ///  </summary>
  IPM_GETADDRESS = $0459;

  ///  <summary>
  ///  </summary>
  PSM_REMOVEPAGE = $0459;

  ///  <summary>
  ///  </summary>
  UDM_GETRANGE = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_SET_CALLBACK_ERRORW = $0459;

  ///  <summary>
  ///  </summary>
  WM_CHOOSEFONT_SETFLAGS = $0459;

  ///  <summary>
  ///  </summary>
  ACM_OPENW = $0459;

  ///  <summary>
  ///  </summary>
  BFFM_SETSELECTIONW = $0459;

  ///  <summary>
  ///  </summary>
  CDM_GETFOLDERIDLIST = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETWORDWRAPMODE = $0459;

  ///  <summary>
  ///  </summary>
  IPM_SETRANGE = $0459;

  ///  <summary>
  ///  </summary>
  PSM_ADDPAGE = $0459;

  ///  <summary>
  ///  </summary>
  UDM_SETPOS = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_SET_CALLBACK_STATUSW = $0459;

  ///  <summary>
  ///  </summary>
  BFFM_SETSTATUSTEXTW = $0459;

  ///  <summary>
  ///  </summary>
  CDM_SETCONTROLTEXT = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETIMECOLOR = $0459;

  ///  <summary>
  ///  </summary>
  IPM_SETFOCUS = $0459;

  ///  <summary>
  ///  </summary>
  PSM_CHANGED = $0459;

  ///  <summary>
  ///  </summary>
  UDM_GETPOS = $0459;

  ///  <summary>
  ///  </summary>
  CDM_HIDECONTROL = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETIMECOLOR = $0459;

  ///  <summary>
  ///  </summary>
  IPM_ISBLANK = $0459;

  ///  <summary>
  ///  </summary>
  PSM_RESTARTWINDOWS = $0459;

  ///  <summary>
  ///  </summary>
  UDM_SETBUDDY = $0459;

  ///  <summary>
  ///  </summary>
  CDM_SETDEFEXT = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETIMEOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  PSM_REBOOTSYSTEM = $0459;

  ///  <summary>
  ///  </summary>
  UDM_GETBUDDY = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETIMEOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  PSM_CANCELTOCLOSE = $0459;

  ///  <summary>
  ///  </summary>
  UDM_SETACCEL = $0459;

  ///  <summary>
  ///  </summary>
  EM_CONVPOSITION = $0459;

  ///  <summary>
  ///  </summary>
  PSM_QUERYSIBLINGS = $0459;

  ///  <summary>
  ///  </summary>
  UDM_GETACCEL = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETZOOM = $0459;

  ///  <summary>
  ///  </summary>
  PSM_UNCHANGED = $0459;

  ///  <summary>
  ///  </summary>
  UDM_SETBASE = $0459;

  ///  <summary>
  ///  </summary>
  PSM_APPLY = $0459;

  ///  <summary>
  ///  </summary>
  UDM_GETBASE = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETTITLEA = $0459;

  ///  <summary>
  ///  </summary>
  UDM_SETRANGE32 = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETWIZBUTTONS = $0459;

  ///  <summary>
  ///  </summary>
  UDM_GETRANGE32 = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_DRIVER_GET_NAMEW = $0459;

  ///  <summary>
  ///  </summary>
  PSM_PRESSBUTTON = $0459;

  ///  <summary>
  ///  </summary>
  UDM_SETPOS32 = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_DRIVER_GET_VERSIONW = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETCURSELID = $0459;

  ///  <summary>
  ///  </summary>
  UDM_GETPOS32 = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETFINISHTEXTA = $0459;

  ///  <summary>
  ///  </summary>
  PSM_GETTABCONTROL = $0459;

  ///  <summary>
  ///  </summary>
  PSM_ISDIALOGMESSAGE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_REALIZE = $0459;

  ///  <summary>
  ///  </summary>
  PSM_GETCURRENTPAGEHWND = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_SETTIMEFORMATA = $0459;

  ///  <summary>
  ///  </summary>
  PSM_INSERTPAGE = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETLANGOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETTIMEFORMATA = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETTITLEW = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_FILE_SET_CAPTURE_FILEW = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETLANGOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_VALIDATEMEDIA = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETFINISHTEXTW = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_FILE_GET_CAPTURE_FILEW = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETIMECOMPMODE = $0459;

  ///  <summary>
  ///  </summary>
  EM_FINDTEXTW = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_PLAYTO = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_FILE_SAVEASW = $0459;

  ///  <summary>
  ///  </summary>
  EM_FINDTEXTEXW = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETFILENAMEA = $0459;

  ///  <summary>
  ///  </summary>
  EM_RECONVERSION = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETDEVICEA = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETHEADERTITLEA = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_FILE_SAVEDIBW = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETIMEMODEBIAS = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETPALETTE = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETHEADERTITLEW = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETIMEMODEBIAS = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_SETPALETTE = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETHEADERSUBTITLEA = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETERRORA = $0459;

  ///  <summary>
  ///  </summary>
  PSM_SETHEADERSUBTITLEW = $0459;

  ///  <summary>
  ///  </summary>
  PSM_HWNDTOINDEX = $0459;

  ///  <summary>
  ///  </summary>
  PSM_INDEXTOHWND = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_SETINACTIVETIMER = $0459;

  ///  <summary>
  ///  </summary>
  PSM_PAGETOINDEX = $0459;

  ///  <summary>
  ///  </summary>
  PSM_INDEXTOPAGE = $0459;

  ///  <summary>
  ///  </summary>
  DL_BEGINDRAG = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETINACTIVETIMER = $0459;

  ///  <summary>
  ///  </summary>
  PSM_IDTOINDEX = $0459;

  ///  <summary>
  ///  </summary>
  DL_DRAGGING = $0459;

  ///  <summary>
  ///  </summary>
  PSM_INDEXTOID = $0459;

  ///  <summary>
  ///  </summary>
  DL_DROPPED = $0459;

  ///  <summary>
  ///  </summary>
  PSM_GETRESULT = $0459;

  ///  <summary>
  ///  </summary>
  DL_CANCELDRAG = $0459;

  ///  <summary>
  ///  </summary>
  PSM_RECALCPAGESIZES = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GET_SOURCE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_PUT_SOURCE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GET_DEST = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_PUT_DEST = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_CAN_PLAY = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_CAN_WINDOW = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_CAN_RECORD = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_CAN_SAVE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_CAN_EJECT = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_CAN_CONFIG = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETINK = $0459;

  ///  <summary>
  ///  </summary>
  IE_MSGFIRST = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_PALETTEKICK = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETINK = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETPENTIP = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETPENTIP = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETERASERTIP = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETERASERTIP = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETBKGND = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETBKGND = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETGRIDORIGIN = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETGRIDORIGIN = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETGRIDPEN = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETGRIDPEN = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETGRIDSIZE = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETGRIDSIZE = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETMODE = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETMODE = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETINKRECT = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_SET_MCI_DEVICEW = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_GET_MCI_DEVICEW = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_PAL_OPENW = $0459;

  ///  <summary>
  ///  </summary>
  WM_CAP_PAL_SAVEW = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETAPPDATA = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETAPPDATA = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETDRAWOPTS = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETDRAWOPTS = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETFORMAT = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETFORMAT = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETINKINPUT = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETINKINPUT = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETNOTIFY = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETNOTIFY = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETRECOG = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETRECOG = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETSECURITY = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETSECURITY = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETSEL = $0459;

  ///  <summary>
  ///  </summary>
  IE_SETSEL = $0459;

  ///  <summary>
  ///  </summary>
  CDM_LAST = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETBIDIOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  IE_DOCOMMAND = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_NOTIFYMODE = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETBIDIOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETCOMMAND = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETTYPOGRAPHYOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETTYPOGRAPHYOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETGESTURE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_NOTIFYMEDIA = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETEDITSTYLE = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETMENU = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETEDITSTYLE = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETPAINTDC = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_NOTIFYERROR = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETPDEVENT = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETSELCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETSELITEMS = $0459;

  ///  <summary>
  ///  </summary>
  IE_GETSTYLE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_SETTIMEFORMATW = $0459;

  ///  <summary>
  ///  </summary>
  EM_OUTLINE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETTIMEFORMATW = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETSCROLLPOS = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETSCROLLPOS = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETFONTSIZE = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETZOOM = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETFILENAMEW = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETZOOM = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETDEVICEW = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETVIEWKIND = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETVIEWKIND = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETPAGE = $0459;

  ///  <summary>
  ///  </summary>
  MCIWNDM_GETERRORW = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETPAGE = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETHYPHENATEINFO = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETHYPHENATEINFO = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETPAGEROTATE = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETPAGEROTATE = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETCTFMODEBIAS = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETCTFMODEBIAS = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETCTFOPENSTATUS = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETCTFOPENSTATUS = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETIMECOMPTEXT = $0459;

  ///  <summary>
  ///  </summary>
  EM_ISIME = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETIMEPROPERTY = $0459;

  ///  <summary>
  ///  </summary>
  EM_GETQUERYRTFOBJ = $0459;

  ///  <summary>
  ///  </summary>
  EM_SETQUERYRTFOBJ = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETFOCUS = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETDRIVEINFOA = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETSELCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETSELCOUNTLFN = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETFILESELA = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETFILESELLFNA = $0459;

  ///  <summary>
  ///  </summary>
  FM_REFRESH_WINDOWS = $0459;

  ///  <summary>
  ///  </summary>
  FM_RELOAD_EXTENSIONS = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETDRIVEINFOW = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETFILESELW = $0459;

  ///  <summary>
  ///  </summary>
  FM_GETFILESELLFNW = $0459;

  ///  <summary>
  ///  </summary>
  WLX_WM_SAS = $0459;

  ///  <summary>
  ///  </summary>
  SM_GETSELCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETSELCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  WM_CPL_LAUNCH = $0459;

  ///  <summary>
  ///  </summary>
  SM_GETSERVERSELA = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETUSERSELA = $0459;

  ///  <summary>
  ///  </summary>
  WM_CPL_LAUNCHED = $0459;

  ///  <summary>
  ///  </summary>
  SM_GETSERVERSELW = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETUSERSELW = $0459;

  ///  <summary>
  ///  </summary>
  SM_GETCURFOCUSA = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETGROUPSELA = $0459;

  ///  <summary>
  ///  </summary>
  SM_GETCURFOCUSW = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETGROUPSELW = $0459;

  ///  <summary>
  ///  </summary>
  SM_GETOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETCURFOCUSA = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETCURFOCUSW = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETOPTIONS = $0459;

  ///  <summary>
  ///  </summary>
  UM_GETOPTIONS2 = $0459;

  ///  <summary>
  ///  </summary>
  LVM_FIRST = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETBKCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETBKCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETIMAGELIST = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETIMAGELIST = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_INSERTITEMA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_DELETEITEM = $0459;

  ///  <summary>
  ///  </summary>
  LVM_DELETEALLITEMS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETCALLBACKMASK = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETCALLBACKMASK = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETNEXTITEM = $0459;

  ///  <summary>
  ///  </summary>
  LVM_FINDITEMA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMRECT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMPOSITION = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMPOSITION = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETSTRINGWIDTHA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_HITTEST = $0459;

  ///  <summary>
  ///  </summary>
  LVM_ENSUREVISIBLE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SCROLL = $0459;

  ///  <summary>
  ///  </summary>
  LVM_REDRAWITEMS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_ARRANGE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_EDITLABELA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETEDITCONTROL = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETCOLUMNA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETCOLUMNA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_INSERTCOLUMNA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_DELETECOLUMN = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETCOLUMNWIDTH = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETCOLUMNWIDTH = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETHEADER = $0459;

  ///  <summary>
  ///  </summary>
  LVM_CREATEDRAGIMAGE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETVIEWRECT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETTEXTCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETTEXTCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETTEXTBKCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETTEXTBKCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETTOPINDEX = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETCOUNTPERPAGE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETORIGIN = $0459;

  ///  <summary>
  ///  </summary>
  LVM_UPDATE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMSTATE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMSTATE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMTEXTA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMTEXTA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SORTITEMS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMPOSITION32 = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETSELECTEDCOUNT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMSPACING = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETISEARCHSTRINGA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETICONSPACING = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETEXTENDEDLISTVIEWSTYLE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETEXTENDEDLISTVIEWSTYLE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETSUBITEMRECT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SUBITEMHITTEST = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETCOLUMNORDERARRAY = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETCOLUMNORDERARRAY = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETHOTITEM = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETHOTITEM = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETHOTCURSOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETHOTCURSOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_APPROXIMATEVIEWRECT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETWORKAREAS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETSELECTIONMARK = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETSELECTIONMARK = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETBKIMAGEA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETBKIMAGEA = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETWORKAREAS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETHOVERTIME = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETHOVERTIME = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETNUMBEROFWORKAREAS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETTOOLTIPS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_INSERTITEMW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETTOOLTIPS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_FINDITEMW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETSTRINGWIDTHW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETCOLUMNW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETCOLUMNW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_INSERTCOLUMNW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETITEMTEXTW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETITEMTEXTW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETISEARCHSTRINGW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_EDITLABELW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETBKIMAGEW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETSELECTEDCOLUMN = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETTILEWIDTH = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETVIEW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETVIEW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_INSERTGROUP = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETGROUPINFO = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETGROUPINFO = $0459;

  ///  <summary>
  ///  </summary>
  LVM_REMOVEGROUP = $0459;

  ///  <summary>
  ///  </summary>
  LVM_MOVEGROUP = $0459;

  ///  <summary>
  ///  </summary>
  LVM_MOVEITEMTOGROUP = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETGROUPMETRICS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETGROUPMETRICS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_ENABLEGROUPVIEW = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SORTGROUPS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_INSERTGROUPSORTED = $0459;

  ///  <summary>
  ///  </summary>
  LVM_REMOVEALLGROUPS = $0459;

  ///  <summary>
  ///  </summary>
  LVM_HASGROUP = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETTILEVIEWINFO = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETTILEVIEWINFO = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETTILEINFO = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETTILEINFO = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETINSERTMARK = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETINSERTMARK = $0459;

  ///  <summary>
  ///  </summary>
  LVM_INSERTMARKHITTEST = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETINSERTMARKRECT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETINSERTMARKCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETINSERTMARKCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETINFOTIP = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETSELECTEDCOLUMN = $0459;

  ///  <summary>
  ///  </summary>
  LVM_ISGROUPVIEWENABLED = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETOUTLINECOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETOUTLINECOLOR = $0459;

  ///  <summary>
  ///  </summary>
  LVM_CANCELEDITLABEL = $0459;

  ///  <summary>
  ///  </summary>
  LVM_MAPINDEXTOID = $0459;

  ///  <summary>
  ///  </summary>
  LVM_MAPIDTOINDEX = $0459;

  ///  <summary>
  ///  </summary>
  LVM_ISITEMVISIBLE = $0459;

  ///  <summary>
  ///  </summary>
  OCM__BASE = $0459;

  ///  <summary>
  ///  </summary>
  LVM_SETUNICODEFORMAT = $0459;

  ///  <summary>
  ///  </summary>
  LVM_GETUNICODEFORMAT = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLOR = $0459;

  ///  <summary>
  ///  </summary>
  OCM_DRAWITEM = $0459;

  ///  <summary>
  ///  </summary>
  OCM_MEASUREITEM = $0459;

  ///  <summary>
  ///  </summary>
  OCM_DELETEITEM = $0459;

  ///  <summary>
  ///  </summary>
  OCM_VKEYTOITEM = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CHARTOITEM = $0459;

  ///  <summary>
  ///  </summary>
  OCM_COMPAREITEM = $0459;

  ///  <summary>
  ///  </summary>
  OCM_NOTIFY = $0459;

  ///  <summary>
  ///  </summary>
  OCM_COMMAND = $0459;

  ///  <summary>
  ///  </summary>
  OCM_HSCROLL = $0459;

  ///  <summary>
  ///  </summary>
  OCM_VSCROLL = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLORMSGBOX = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLOREDIT = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLORLISTBOX = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLORBTN = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLORDLG = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLORSCROLLBAR = $0459;

  ///  <summary>
  ///  </summary>
  OCM_CTLCOLORSTATIC = $0459;

  ///  <summary>
  ///  </summary>
  OCM_PARENTNOTIFY = $0459;

  ///  <summary>
  ///  </summary>
  WM_APP = $8000;

  ///  <summary>
  ///  </summary>
  WM_RASDIALEVENT = $cccd;

const
  ///  <summary>
  ///    From MSDN:
  ///    Dark shadow for three-dimensional display elements.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_3DDKSHADOW = 21;

  ///  <summary>
  ///    From MSDN:
  ///    Face color for three-dimensional display elements and for
  ///    dialog box backgrounds.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_3DFACE = 15;

  ///  <summary>
  ///    From MSDN:
  ///    Highlight color for three-dimensional display elements (for edges
  ///    facing the light source.)
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_3DHIGHLIGHT = 20;

  ///  <summary>
  ///    From MSDN:
  ///    Highlight color for three-dimensional display elements (for edges
  ///    facing the light source.)
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_3DHILIGHT = 20;

  ///  <summary>
  ///    From MSDN:
  ///    Light color for three-dimensional display elements (for edges facing
  ///    the light source.)
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_3DLIGHT = 22;

  ///  <summary>
  ///    From MSDN:
  ///    Shadow color for three-dimensional display elements (for edges facing
  ///    away from the light source).
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_3DSHADOW = 16;

  ///  <summary>
  ///    From MSDN:
  ///    Active window border.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_ACTIVEBORDER = 10;

  ///  <summary>
  ///    From MSDN:
  ///    Active window title bar.
  ///    Specifies the left side color in the color gradient of an active
  ///    window's title bar if the gradient effect is enabled.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_ACTIVECAPTION = 2;

  ///  <summary>
  ///    From MSDN:
  ///    Background color of multiple document interface (MDI) applications.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_APPWORKSPACE = 12;

  ///  <summary>
  ///    From MSDN:
  ///    Desktop.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_BACKGROUND = 1;

  ///  <summary>
  ///    From MSDN:
  ///    Face color for three-dimensional display elements and for
  ///    dialog box backgrounds.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_BTNFACE = 15;

  ///  <summary>
  ///    From MSDN:
  ///    Highlight color for three-dimensional display elements (for edges
  ///    facing the light source.)
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_BTNHIGHLIGHT = 20;

  ///  <summary>
  ///    From MSDN:
  ///    Highlight color for three-dimensional display elements (for edges
  ///    facing the light source.)
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_BTNHILIGHT = 20;

  ///  <summary>
  ///    From MSDN:
  ///    Shadow color for three-dimensional display elements (for edges
  ///    facing away from the light source).
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_BTNSHADOW = 16;

  ///  <summary>
  ///    From MSDN:
  ///    Text on push buttons.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_BTNTEXT = 18;

  ///  <summary>
  ///    From MSDN:
  ///    Text in caption, size box, and scroll bar arrow box.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_CAPTIONTEXT = 9;

  ///  <summary>
  ///    From MSDN:
  ///    Desktop.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_DESKTOP = 1;

  ///  <summary>
  ///    From MSDN:
  ///    Right side color in the color gradient of an active window's title
  ///    bar. COLOR_ACTIVECAPTION specifies the left side color. Use
  ///    SPI_GETGRADIENTCAPTIONS with the SystemParametersInfo function to
  ///    determine whether the gradient effect is enabled.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_GRADIENTACTIVECAPTION = 27;

  ///  <summary>
  ///    From MSDN:
  ///    Right side color in the color gradient of an inactive window's
  ///    title bar. COLOR_INACTIVECAPTION specifies the left side color.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_GRADIENTINACTIVECAPTION = 28;

  ///  <summary>
  ///    From MSDN:
  ///    Grayed (disabled) text. This color is set to 0 if the current
  ///    display driver does not support a solid gray color.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_GRAYTEXT = 17;

  ///  <summary>
  ///    From MSDN:
  ///    Item(s) selected in a control.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_HIGHLIGHT = 13;

  ///  <summary>
  ///    From MSDN:
  ///    Text of item(s) selected in a control.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_HIGHLIGHTTEXT = 14;

  ///  <summary>
  ///    From MSDN:
  ///    Color for a hyperlink or hot-tracked item.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_HOTLIGHT = 26;

  ///  <summary>
  ///    From MSDN:
  ///    Inactive window border.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_INACTIVEBORDER = 11;

  ///  <summary>
  ///    From MSDN:
  ///    Inactive window caption.
  ///    Specifies the left side color in the color gradient of an inactive
  ///    window's title bar if the gradient effect is enabled.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_INACTIVECAPTION = 3;

  ///  <summary>
  ///    From MSDN:
  ///    Color of text in an inactive caption.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_INACTIVECAPTIONTEXT = 19;

  ///  <summary>
  ///    From MSDN:
  ///    Background color for tooltip controls.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_INFOBK = 24;

  ///  <summary>
  ///    From MSDN:
  ///    Text color for tooltip controls.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_INFOTEXT = 23;

  ///  <summary>
  ///    From MSDN:
  ///    Menu background.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_MENU = 4;

  ///  <summary>
  ///    From MSDN:
  ///    The color used to highlight menu items when the menu appears as a
  ///    flat menu (see SystemParametersInfo). The highlighted menu item is
  ///    outlined with COLOR_HIGHLIGHT.
  ///    Windows 2000:  This value is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_MENUHILIGHT = 29;

  ///  <summary>
  ///    From MSDN:
  ///    The background color for the menu bar when menus appear as
  ///    flat menus (see SystemParametersInfo). However, COLOR_MENU continues
  ///    to specify the background color of the menu popup.
  ///    Windows 2000:  This value is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_MENUBAR = 30;

  ///  <summary>
  ///    From MSDN:
  ///    Text in menus.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_MENUTEXT = 7;

  ///  <summary>
  ///    From MSDN:
  ///    Scroll bar gray area.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_SCROLLBAR = 0;

  ///  <summary>
  ///    From MSDN:
  ///    Window background.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_WINDOW = 5;

  ///  <summary>
  ///    From MSDN:
  ///    Window frame.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_WINDOWFRAME = 6;

  ///  <summary>
  ///    From MSDN:
  ///    Text in windows
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724371(v=vs.85).aspx
  ///  </summary>
  COLOR_WINDOWTEXT = 8;

  ///  <summary>
  ///    From MSDN:
  ///    Aligns the window's client area on a byte boundary (in the x direction).
  ///    This style affects the width of the window and its horizontal placement
  ///    on the display.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_BYTEALIGNCLIENT = $1000;

  ///  <summary>
  ///    From MSDN:
  ///    Aligns the window on a byte boundary (in the x direction).
  ///    This style affects the width of the window and its horizontal
  ///    placement on the display.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_BYTEALIGNWINDOW = $2000;

  ///  <summary>
  ///    From MSDN:
  ///    Allocates one device context to be shared by all windows in the class.
  ///    Because window classes are process specific, it is possible for multiple
  ///    threads of an application to create a window of the same class. It is
  ///    also possible for the threads to attempt to use the device context
  ///    simultaneously. When this happens, the system allows only one thread
  ///    to successfully finish its drawing operation.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_CLASSDC = $0040;

  ///  <summary>
  ///    From MSDN:
  ///    Sends a double-click message to the window procedure when the user
  ///    double-clicks the mouse while the cursor is within a window
  ///    belonging to the class.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_DBLCLKS = $0008;

  ///  <summary>
  ///    From MSDN:
  ///    Enables the drop shadow effect on a window. The effect is turned
  ///    on and off through SPI_SETDROPSHADOW. Typically, this is enabled
  ///    for small, short-lived windows such as menus to emphasize their
  ///    Z-order relationship to other windows. Windows created from a
  ///    class with this style must be top-level windows; they may not be
  ///    child windows.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_DROPSHADOW = $00020000;

  ///  <summary>
  ///    From MSDN:
  ///    Indicates that the window class is an application global class.
  ///    For more information, see the "Application Global Classes" section
  ///    of About Window Classes.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_GLOBALCLASS = $4000;

  ///  <summary>
  ///    From MSDN:
  ///    Redraws the entire window if a movement or size adjustment
  ///    changes the width of the client area.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_HREDRAW = $0002;

  ///  <summary>
  ///    From MSDN:
  ///    Disables Close on the window menu.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_NOCLOSE = $0200;

  ///  <summary>
  ///    From MSDN:
  ///    Allocates a unique device context for each window in the class.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_OWNDC = $0020;

  ///  <summary>
  ///    From MSDN:
  ///    Sets the clipping rectangle of the child window to that of the
  ///    parent window so that the child can draw on the parent. A window
  ///    with the CS_PARENTDC style bit receives a regular device context
  ///    from the system's cache of device contexts. It does not give the
  ///    child the parent's device context or device context settings.
  ///    Specifying CS_PARENTDC enhances an application's performance.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_PARENTDC = $0080;

  ///  <summary>
  ///    From MSDN:
  ///    Saves, as a bitmap, the portion of the screen image obscured by a
  ///    window of this class. When the window is removed, the system uses
  ///    the saved bitmap to restore the screen image, including other
  ///    windows that were obscured. Therefore, the system does not send
  ///    WM_PAINT messages to windows that were obscured if the memory
  ///    used by the bitmap has not been discarded and if other screen
  ///    actions have not invalidated the stored image.
  ///    This style is useful for small windows (for example, menus or
  ///    dialog boxes) that are displayed briefly and then removed before
  ///    other screen activity takes place. This style increases the time
  ///    required to display the window, because the system must first
  ///    allocate memory to store the bitmap.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_SAVEBITS = $0800;

  ///  <summary>
  ///    From MSDN:
  ///    Redraws the entire window if a movement or size adjustment changes
  ///    the height of the client area.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff729176(v=vs.85).aspx
  ///  </summary>
  CS_VREDRAW = $0001;

const
  ///  <summary>
  ///    From MSDN:
  ///    Default application icon.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_APPLICATION = 32512;

  ///  <summary>
  ///    From MSDN:
  ///    Asterisk icon. Same as IDI_INFORMATION.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_ASTERISK = 32516;

  ///  <summary>
  ///    From MSDN:
  ///    Hand-shaped icon.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_ERROR = 32513;

  ///  <summary>
  ///    From MSDN:
  ///    Exclamation point icon. Same as IDI_WARNING.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_EXCLAMATION = 32515;

  ///  <summary>
  ///    From MSDN:
  ///    Hand-shaped icon. Same as IDI_ERROR.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_HAND = 32513;

  ///  <summary>
  ///    From MSDN:
  ///    Asterisk icon.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_INFORMATION = 32516;

  ///  <summary>
  ///    From MSDN:
  ///    Question mark icon.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_QUESTION = 32514;

  ///  <summary>
  ///    From MSDN:
  ///    Security Shield icon.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_SHIELD = 32518;

  ///  <summary>
  ///    From MSDN:
  ///    Exclamation point icon.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_WARNING = 32515;

  ///  <summary>
  ///    From MSDN:
  ///    Default application icon.
  ///    Windows 2000:  Windows logo icon.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648072(v=vs.85).aspx
  ///  </summary>
  IDI_WINLOGO = 32517;


   ///  <summary>
   ///    From MSDN:
   ///    Standard arrow and small hourglass
   ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
   ///  </summary>
  DC_APPSTARTING = 32650;

   ///  <summary>
   ///    From MSDN:
   ///    Standard arrow
   ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
   ///  </summary>
  IDC_ARROW = 32512;

   ///  <summary>
   ///    From MSDN:
   ///    Crosshair
   ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
   ///  </summary>
  IDC_CROSS = 32515;

   ///  <summary>
   ///    From MSDN:
   ///    Hand
   ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
   ///  </summary>
  IDC_HAND = 32649;

   ///  <summary>
   ///    From MSDN:
   ///    Arrow and question mark
   ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
   ///  </summary>
  IDC_HELP = 32651;

   ///  <summary>
   ///    From MSDN:
   ///    I-beam
   ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
   ///  </summary>
  IDC_IBEAM = 32513;

  ///  <summary>
  ///    From MSDN:
  ///    Obsolete for applications marked version 4.0 or later.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_ICON = 32641;

  ///  <summary>
  ///    From MSDN:
  ///    Slashed circle
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_NO = 32648;

  ///  <summary>
  ///    From MSDN:
  ///    Obsolete for applications marked version 4.0 or later. Use IDC_SIZEALL.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_SIZE = 32640;

  ///  <summary>
  ///    From MSDN:
  ///    Four-pointed arrow pointing north, south, east, and west
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_SIZEALL = 32646;

  ///  <summary>
  ///    From MSDN:
  ///    Double-pointed arrow pointing northeast and southwest
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_SIZENESW = 32643;

  ///  <summary>
  ///    From MSDN:
  ///    Double-pointed arrow pointing north and south
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_SIZENS = 32645;

  ///  <summary>
  ///    From MSDN:
  ///    Double-pointed arrow pointing northwest and southeast
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_SIZENWSE = 32642;

  ///  <summary>
  ///    From MSDN:
  ///    Double-pointed arrow pointing west and east
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_SIZEWE = 32644;

  ///  <summary>
  ///    From MSDN:
  ///    Vertical arrow
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_UPARROW = 32516;

  ///  <summary>
  ///    From MSDN:
  ///    Hourglass
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648391(v=vs.85).aspx
  ///  </summary>
  IDC_WAIT = 32514;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a thin-line border.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  <summary>
  WS_BORDER = $00800000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a title bar (includes the WS_BORDER style).
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_CAPTION = $00C00000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is a child window. A window with this style cannot have
  ///    a menu bar. This style cannot be used with the WS_POPUP style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_CHILD = $40000000;

  ///  <summary>
  ///    From MSDN:
  ///    Same as the WS_CHILD style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_CHILDWINDOW = $40000000;

  ///  <summary>
  ///    From MSDN:
  ///    Excludes the area occupied by child windows when drawing occurs
  ///    within the parent window. This style is used when creating the
  ///    parent window.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_CLIPCHILDREN = $02000000;

  ///  <summary>
  ///    From MSDN:
  ///    Clips child windows relative to each other; that is, when a
  ///    particular child window receives a WM_PAINT message, the
  ///    WS_CLIPSIBLINGS style clips all other overlapping child windows
  ///    out of the region of the child window to be updated.
  ///    If WS_CLIPSIBLINGS is not specified and child windows overlap,
  ///    it is possible, when drawing within the client area of a child
  ///    window, to draw within the client area of a neighboring child window.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_CLIPSIBLINGS = $04000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is initially disabled. A disabled window cannot receive
  ///    input from the user. To change this after a window has been created,
  ///    use the EnableWindow function.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_DISABLED = $08000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a border of a style typically used with dialog boxes.
  ///    A window with this style cannot have a title bar.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_DLGFRAME = $00400000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is the first control of a group of controls. The group
  ///    consists of this first control and all controls defined after it,
  ///    up to the next control with the WS_GROUP style. The first control
  ///    in each group usually has the WS_TABSTOP style so that the user can
  ///    move from group to group. The user can subsequently change the
  ///    keyboard focus from one control in the group to the next control
  ///    in the group by using the direction keys.
  ///    You can turn this style on and off to change dialog box navigation.
  ///    To change this style after a window has been created, use the
  ///    SetWindowLong function.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_GROUP = $00020000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a horizontal scroll bar.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_HSCROLL = $00100000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is initially minimized. Same as the WS_MINIMIZE style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_ICONIC = $20000000;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_MAXIMIZE = $01000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a maximize button. Cannot be combined with
  ///    the WS_EX_CONTEXTHELP style. The WS_SYSMENU style must also
  ///    be specified.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_MAXIMIZEBOX = $00010000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is initially minimized. Same as the WS_ICONIC style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_MINIMIZE = $20000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a minimize button. Cannot be combined with the
  ///    WS_EX_CONTEXTHELP style. The WS_SYSMENU style must also be specified.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_MINIMIZEBOX = $00020000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is an overlapped window. An overlapped window has a
  ///    title bar and a border. Same as the WS_TILED style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_OVERLAPPED = $00000000;

  ///  <summary>
  ///    From MSDN:
  ///    The windows is a pop-up window. This style cannot be used with the
  ///    WS_CHILD style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_POPUP = $80000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a sizing border. Same as the WS_THICKFRAME style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_SIZEBOX = $00040000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a window menu on its title bar. The WS_CAPTION style
  ///    must also be specified.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_SYSMENU = $00080000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is a control that can receive the keyboard focus when the
  ///    user presses the TAB key. Pressing the TAB key changes the keyboard
  ///    focus to the next control with the WS_TABSTOP style.
  ///    You can turn this style on and off to change dialog box navigation.
  ///    To change this style after a window has been created, use the
  ///    SetWindowLong function. For user-created windows and modeless dialogs
  ///    to work with tab stops, alter the message loop to call the
  ///    IsDialogMessage function.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_TABSTOP = $00010000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a sizing border. Same as the WS_SIZEBOX style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_THICKFRAME = $00040000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is an overlapped window. An overlapped window has a
  ///    title bar and a border. Same as the WS_OVERLAPPED style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_TILED = $00000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is initially visible.
  ///    This style can be turned on and off by using the ShowWindow or
  ///    SetWindowPos function.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_VISIBLE = $10000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a vertical scroll bar.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_VSCROLL = $00200000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is an overlapped window.
  ///    Same as the WS_OVERLAPPEDWINDOW style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_TILEDWINDOW = (WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_THICKFRAME or WS_MINIMIZEBOX or WS_MAXIMIZEBOX);

  ///  <summary>
  ///    From MSDN:
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_THICKFRAME or WS_MINIMIZEBOX or WS_MAXIMIZEBOX);

  ///  <summary>
  ///    From MSDN:
  ///    The window is a pop-up window. The WS_CAPTION and WS_POPUPWINDOW
  ///    styles must be combined to make the window menu visible.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632600(v=vs.85).aspx
  ///  </summary>
  WS_POPUPWINDOW = (WS_POPUP or WS_BORDER or WS_SYSMENU);



  ///  <summary>
  ///    From MSDN:
  ///    The window accepts drag-drop files.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_ACCEPTFILES = $00000010;

  ///  <summary>
  ///    From MSDN:
  ///    Forces a top-level window onto the taskbar when the window is visible.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_APPWINDOW = $00040000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a border with a sunken edge.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_CLIENTEDGE = $00000200;

  ///  <summary>
  ///    From MSDN:
  ///    Paints all descendants of a window in bottom-to-top painting order
  ///    using double-buffering. For more information, see Remarks. This
  ///    cannot be used if the window has a class style of either CS_OWNDC or
  ///    CS_CLASSDC.
  ///    Windows 2000:  This style is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_COMPOSITED = $02000000;

  ///  <summary>
  ///    From MSDN:
  ///    The title bar of the window includes a question mark. When the user
  ///    clicks the question mark, the cursor changes to a question mark with
  ///    a pointer. If the user then clicks a child window, the child receives
  ///    a WM_HELP message. The child window should pass the message to the
  ///    parent window procedure, which should call the WinHelp function
  ///    using the HELP_WM_HELP command. The Help application displays a
  ///    pop-up window that typically contains help for the child window.
  ///    WS_EX_CONTEXTHELP cannot be used with the WS_MAXIMIZEBOX or
  ///    WS_MINIMIZEBOX styles.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_CONTEXTHELP = $00000400;

  ///  <summary>
  ///    From MSDN:
  ///    The window itself contains child windows that should take part in
  ///    dialog box navigation. If this style is specified, the dialog
  ///    manager recurses into children of this window when performing
  ///    navigation operations such as handling the TAB key, an arrow key,
  ///    or a keyboard mnemonic.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_CONTROLPARENT = $00010000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a double border; the window can, optionally, be
  ///    created with a title bar by specifying the WS_CAPTION style in
  ///    the dwStyle parameter.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_DLGMODALFRAME = $00000001;

  ///  <summary>
  ///    From MSDN:
  ///    The window is a layered window. This style cannot be used if
  ///    the window has a class style of either CS_OWNDC or CS_CLASSDC.
  ///    Windows 8:  The WS_EX_LAYERED style is supported for top-level
  ///    windows and child windows. Previous Windows versions support
  ///    WS_EX_LAYERED only for top-level windows.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_LAYERED = $0008000;

  ///  <summary>
  ///    From MSDN:
  ///    If the shell language is Hebrew, Arabic, or another language that
  ///    supports reading order alignment, the horizontal origin of the
  ///    window is on the right edge. Increasing horizontal values advance
  ///    to the left.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_LAYOUTRTL = $00400000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has generic left-aligned properties. This is the default.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_LEFT = $00000000;

  ///  <summary>
  ///    From MSDN:
  ///    If the shell language is Hebrew, Arabic, or another language that
  ///    supports reading order alignment, the vertical scroll bar (if present)
  ///    is to the left of the client area. For other languages, the style is
  ///    ignored.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_LEFTSCROLLBAR = $00004000;

  ///  <summary>
  ///    From MSDN:
  ///    The window text is displayed using left-to-right
  ///    reading-order properties. This is the default.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_LTRREADING = $00000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is a MDI child window.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_MDICHILD = $00000040;

  ///  <summary>
  ///    From MSDN:
  ///    A top-level window created with this style does not become the
  ///    foreground window when the user clicks it. The system does not
  ///    bring this window to the foreground when the user minimizes or
  ///    closes the foreground window.
  ///    To activate the window, use the SetActiveWindow or
  ///    SetForegroundWindow function.
  ///    The window does not appear on the taskbar by default. To force the
  ///    window to appear on the taskbar, use the WS_EX_APPWINDOW style.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_NOACTIVATE = $08000000;

  ///  <summary>
  ///    From MSDN:
  ///    The window does not pass its window layout to its child windows.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_NOINHERITLAYOUT = $00100000;

  ///  <summary>
  ///    From MSDN:
  ///    The child window created with this style does not send the
  ///    WM_PARENTNOTIFY message to its parent window when it is
  ///    created or destroyed.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_NOPARENTNOTIFY = $00000004;

  ///  <summary>
  ///    From MSDN:
  ///    The window does not render to a redirection surface. This is for
  ///    windows that do not have visible content or that use mechanisms
  ///    other than surfaces to provide their visual.
  ///    WS_EX_OVERLAPPEDWINDOW (WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE)
  ///    The window is an overlapped window.
  ///    WS_EX_PALETTEWINDOW
  ///    (WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST)
  ///    The window is palette window, which is a modeless dialog box that
  ///    presents an array of commands.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_NOREDIRECTIONBITMAP = $00200000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has generic "right-aligned" properties. This depends on
  ///    the window class. This style has an effect only if the shell language
  ///    is Hebrew, Arabic, or another language that supports reading-order
  ///    alignment; otherwise, the style is ignored.
  ///    Using the WS_EX_RIGHT style for static or edit controls has the same
  ///    effect as using the SS_RIGHT or ES_RIGHT style, respectively.
  ///    Using this style with button controls has the same effect as
  ///    using BS_RIGHT and BS_RIGHTBUTTON styles.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_RIGHT = $00001000;

  ///  <summary>
  ///    From MSDN:
  ///    The vertical scroll bar (if present) is to the right of the
  ///    client area. This is the default.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_RIGHTSCROLLBAR = $00000000;

  ///  <summary>
  ///    From MSDN:
  ///    If the shell language is Hebrew, Arabic, or another language that
  ///    supports reading-order alignment, the window text is displayed
  ///    using right-to-left reading-order properties. For other languages,
  ///    the style is ignored.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_RTLREADING = $00002000;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a three-dimensional border style intended to be used
  ///    for items that do not accept user input.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_STATICEDGE = $00020000;

  ///  <summary>
  ///    From MSDN:
  ///    The window is intended to be used as a floating toolbar. A tool
  ///    window has a title bar that is shorter than a normal title bar,
  ///    and the window title is drawn using a smaller font. A tool window
  ///    does not appear in the taskbar or in the dialog that appears when
  ///    the user presses ALT+TAB. If a tool window has a system menu, its
  ///    icon is not displayed on the title bar. However, you can display
  ///    the system menu by right-clicking or by typing ALT+SPACE.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_TOOLWINDOW = $00000080;

  ///  <summary>
  ///    From MSDN:
  ///    The window should be placed above all non-topmost windows and should
  ///    stay above them, even when the window is deactivated. To add or remove
  ///    this style, use the SetWindowPos function.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_TOPMOST = $00000008;

  ///  <summary>
  ///    From MSDN:
  ///    The window should not be painted until siblings beneath the window
  ///    (that were created by the same thread) have been painted. The window
  ///    appears transparent because the bits of underlying sibling windows
  ///    have already been painted.
  ///    To achieve transparency without these restrictions, use the
  ///    SetWindowRgn function.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_TRANSPARENT = $00000020;

  ///  <summary>
  ///    From MSDN:
  ///    The window has a border with a raised edge.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ff700543(v=vs.85).aspx
  ///  </summary>
  WS_EX_WINDOWEDGE = $00000100;

const
  ///  <summary>
  ///    From MSDN:
  ///    Minimizes a window, even if the thread that owns the window is not
  ///    responding. This flag should only be used when minimizing windows
  ///    from a different thread.
  ///  </summary>
  SW_FORCEMINIMIZE = 11;

  ///  <summary>
  ///    From MSDN:
  ///    Hides the window and activates another window.
  ///  </summary>
  SW_HIDE = 0;

  ///  <summary>
  ///    From MSDN:
  ///    Maximizes the specified window.
  ///  </summary>
  SW_MAXIMIZE = 3;

  ///  <summary>
  ///    From MSDN:
  ///    Minimizes the specified window and activates the next top-level
  ///    window in the Z order.
  ///  </summary>
  SW_MINIMIZE = 6;

  ///  <summary>
  ///    From MSDN:
  ///    Activates and displays the window. If the window is minimized or
  ///    maximized, the system restores it to its original size and position.
  ///    An application should specify this flag when restoring a minimized
  ///    window.
  ///  </summary>
  SW_RESTORE = 9;

  ///  <summary>
  ///    From MSDN:
  ///    Activates the window and displays it in its current size and position.
  ///  </summary>
  SW_SHOW = 5;

  ///  <summary>
  ///    From MSDN:
  ///    Sets the show state based on the SW_ value specified in the
  ///    STARTUPINFO structure passed to the CreateProcess function by
  ///    the program that started the application.
  ///  </summary>
  SW_SHOWDEFAULT = 10;

  ///  <summary>
  ///    From MSDN:
  ///    Activates the window and displays it as a maximized window.
  ///  </summary>
  SW_SHOWMAXIMIZED = 3;

  ///  <summary>
  ///    From MSDN:
  ///    Activates the window and displays it as a minimized window.
  ///  </summary>
  SW_SHOWMINIMIZED = 2;

  ///  <summary>
  ///    From MSDN:
  ///    Displays the window as a minimized window. This value is similar to
  ///    SW_SHOWMINIMIZED, except the window is not activated.
  ///  </summary>
  SW_SHOWMINNOACTIVE = 7;

  ///  <summary>
  ///    From MSDN:
  ///    Displays the window in its current size and position. This value is
  ///    similar to SW_SHOW, except that the window is not activated.
  ///  </summary>
  SW_SHOWNA = 8;

  ///  <summary>
  ///    From MSDN:
  ///    Displays a window in its most recent size and position. This value
  ///    is similar to SW_SHOWNORMAL, except that the window is not activated.
  ///  </summary>
  SW_SHOWNOACTIVATE = 4;

  ///  <summary>
  ///    From MSDN:
  ///    Activates and displays a window. If the window is minimized or
  ///    maximized, the system restores it to its original size and position.
  ///    An application should specify this flag when displaying the window
  ///    for the first time.
  ///  </summary>
  SW_SHOWNORMAL = 1;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_BITSPERPEL = $40000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_PELSWIDTH = $80000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_PELSHEIGHT = $100000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_DISPLAYFLAGS = $200000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_DISPLAYFREQUENCY = $400000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_DISPLAYORIENTATION: uint32 = $80;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_DISPLAYQUERYORIENTATION: uint32 = $01000000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DM_DISPLAYFIXEDOUTPUT: uint32 = $20000000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_UPDATEREGISTRY = 1;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_TEST = 2;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_FULLSCREEN = 4;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_GLOBAL = 8;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_SET_PRIMARY = $10;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_RESET = $40000000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_SETRECT = $20000000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  CDS_NORESET = $10000000;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_SUCCESSFUL = 0;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_RESTART = 1;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_BADFLAGS = -4;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_FAILED = -1;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_BADMODE = -2;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_NOTUPDATED = -3;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_BADPARAM = -5;

  ///  <summary>
  ///    No documentation found on MSDN, taken from header.
  ///  </summary>
  DISP_CHANGE_BADDUALVIEW = -6;


  ///  <summary>
  ///    From MSDN: The buffer can draw to a window or device surface.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_DRAW_TO_WINDOW = $4;

  ///  <summary>
  ///    From MSDN: The buffer can draw to a memory bitmap.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_DRAW_TO_BITMAP = $8;

  ///  <summary>
  ///    From MSDN: The buffer supports GDI drawing.
  ///    This flag and PFD_DOUBLEBUFFER are mutually exclusive in the current
  ///    generic implementation.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_SUPPORT_GDI = $10;

  ///  <summary>
  ///    From MSDN: The buffer supports OpenGL drawing.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_SUPPORT_OPENGL = $20;

  ///  <summary>
  ///    From MSDN: The pixel format is supported by a device driver that
  ///    accelerates the generic implementation. If this flag is clear and
  ///    the PFD_GENERIC_FORMAT flag is set, the pixel format is supported
  ///    by the generic implementation only.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_GENERIC_ACCELERATED = $1000;

  ///  <summary>
  ///    From MSDN: The pixel format is supported by the GDI software
  ///    implementation, which is also known as the generic implementation.
  ///    If this bit is clear, the pixel format is supported by a device
  ///    driver or hardware.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_GENERIC_FORMAT = $40;

  ///  <summary>
  ///    From MSDN: The buffer uses RGBA pixels on a palette-managed device.
  ///    A logical palette is required to achieve the best results for this
  ///    pixel type. Colors in the palette should be specified according to
  ///    the values of the cRedBits, cRedShift, cGreenBits, cGreenShift,
  ///    cBluebits, and cBlueShift members. The palette should be created
  ///    and realized in the device context before calling wglMakeCurrent.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_NEED_PALETTE = $80;

  ///  <summary>
  ///    From MSDN: Defined in the pixel format descriptors of hardware that
  ///    supports one hardware palette in 256-color mode only. For such
  ///    systems to use hardware acceleration, the hardware palette must
  ///    be in a fixed order (for example, 3-3-2) when in RGBA mode or
  ///    must match the logical palette when in color-index mode.
  ///    When this flag is set, you must call SetSystemPaletteUse in your
  ///    program to force a one-to-one mapping of the logical palette and the
  ///    system palette. If your OpenGL hardware supports multiple hardware
  ///    palettes and the device driver can allocate spare hardware palettes
  ///    for OpenGL, this flag is typically clear.
  ///    This flag is not set in the generic pixel formats.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_NEED_SYSTEM_PALETTE = $100;

  ///  <summary>
  ///    From MSDN: The buffer is double-buffered.
  ///    This flag and PFD_SUPPORT_GDI are mutually exclusive in the current
  ///    generic implementation.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_DOUBLEBUFFER = $1;

  ///  <summary>
  ///    From MSDN: The buffer is stereoscopic.
  ///    This flag is not supported in the current generic implementation.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_STEREO = $2;

  ///  <summary>
  ///    From MSDN: Indicates whether a device can swap individual layer
  ///    planes with pixel formats that include double-buffered overlay or
  ///    underlay planes. Otherwise all layer planes are swapped together as
  ///    a group. When this flag is set, wglSwapLayerBuffers is supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_SWAP_LAYER_BUFFERS = $800;

  ///  <summary>
  ///    From MSDN: The requested pixel format can either have or not have a
  ///    depth buffer. To select a pixel format without a depth buffer, you
  ///    must specify this flag. The requested pixel format can be with or
  ///    without a depth buffer. Otherwise, only pixel formats with a depth
  ///    buffer are considered.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_DEPTH_DONTCARE = $20000000;

  ///  <summary>
  ///    From MSDN: The requested pixel format can be either single-
  ///    or double-buffered.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_DOUBLEBUFFER_DONTCARE = $40000000;

  ///  <summary>
  ///    From MSDN: The requested pixel format can be either
  ///    monoscopic or stereoscopic.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_STEREO_DONTCARE = $80000000;

  ///  <summary>
  ///    From MSDN: Specifies the content of the back buffer in the
  ///    double-buffered main color plane following a buffer swap. Swapping
  ///    the color buffers causes the content of the back buffer to be copied
  ///    to the front buffer. The content of the back buffer is not affected
  ///    by the swap. PFD_SWAP_COPY is a hint only and might not be provided
  ///    by a driver.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_SWAP_COPY = $400;

  ///  <summary>
  ///    From MSDN: Specifies the content of the back buffer in the
  ///    double-buffered main color plane following a buffer swap. Swapping
  ///    the color buffers causes the exchange of the back buffer's content
  ///    with the front buffer's content. Following the swap, the back
  ///    buffer's content contains the front buffer's content before the swap.
  ///    PFD_SWAP_EXCHANGE is a hint only and might not be provided by a driver.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_SWAP_EXCHANGE = $200;

  ///  <summary>
  ///    From MSDN: RGBA pixels. Each pixel has four components in this
  ///    order: red, green, blue, and alpha.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_TYPE_RGBA = $0;

  ///  <summary>
  ///    From MSDN: Color-index pixels. Each pixel uses a color-index value.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  PFD_TYPE_COLORINDEX = $1;


  ///  <summary>
  ///    Unable to find documentation.
  ///  </summary>
  PFD_MAIN_PLANE = $0;

  ///  <summary>
  ///    From MSDN: The service is a file system driver.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_FILE_SYSTEM_DRIVER = $00000002;

  ///  <summary>
  ///    From MSDN: The service is a device driver.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_KERNEL_DRIVER = $00000001;

  ///  <summary>
  ///    From MSDN: The service runs in its own process.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_WIN32_OWN_PROCESS = $00000010;

  ///  <summary>
  ///    From MSDN: The service shares a proc
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_WIN32_SHARE_PROCESS = $00000020;

  ///  <summary>
  ///    From MSDN: The service can interact with the desktop. For more information, see Interactive Services.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_INTERACTIVE_PROCESS = $00000100;




  ///  <summary>
  ///    From MSDN: The service continue is pending.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTINUE_PENDING = $00000005;

  ///  <summary>
  ///    From MSDN: The service pause is pending.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_PAUSE_PENDING = $00000006;

  ///  <summary>
  ///    From MSDN: The service is paused.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_PAUSED = $00000007;

  ///  <summary>
  ///    From MSDN: The service is running.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_RUNNING = $00000004;

  ///  <summary>
  ///    From MSDN: The service is starting.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_START_PENDING = $00000002;

  ///  <summary>
  ///    From MSDN: The service is stopping.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_STOP_PENDING = $00000003;

  ///  <summary>
  ///    From MSDN: The service is not running.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_STOPPED = $00000001;

  ///  <summary>
  ///    From MSDN: The service is a network component that can accept changes
  ///               in its binding without being stopped and restarted.
  ///               This control code allows the service to receive
  ///               SERVICE_CONTROL_NETBINDADD, SERVICE_CONTROL_NETBINDREMOVE,
  ///               SERVICE_CONTROL_NETBINDENABLE, and
  ///               SERVICE_CONTROL_NETBINDDISABLE notifications.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_NETBINDCHANGE = $00000010;

  ///  <summary>
  ///    From MSDN: The service can reread its startup parameters without being
  ///               stopped and restarted. This control code allows the service
  ///               to receive SERVICE_CONTROL_PARAMCHANGE notifications.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_PARAMCHANGE = $00000008;

  ///  <summary>
  ///    From MSDN: The service can be paused and continued. This control code
  ///               allows the service to receive SERVICE_CONTROL_PAUSE and
  ///               SERVICE_CONTROL_CONTINUE notifications.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_PAUSE_CONTINUE = $00000002;

  ///  <summary>
  ///    From MSDN: The service can perform preshutdown tasks.
  ///               This control code enables the service to receive
  ///               SERVICE_CONTROL_PRESHUTDOWN notifications. Note that
  ///               ControlService and ControlServiceEx cannot send this
  ///               notification; only the system can send it.
  ///               Windows Server 2003 and Windows XP: This value is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_PRESHUTDOWN = $00000100;

  ///  <summary>
  ///    From MSDN: The service is notified when system shutdown occurs.
  ///               This control code allows the service to receive
  ///               SERVICE_CONTROL_SHUTDOWN notifications. Note that
  ///               ControlService and ControlServiceEx cannot send this
  ///               notification; only the system can send it.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_SHUTDOWN = $00000004;

  ///  <summary>
  ///    From MSDN: The service can be stopped.
  ///               This control code allows the service to receive
  ///               SERVICE_CONTROL_STOP notifications.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_STOP = $00000001;

  ///  <summary>
  ///    From MSDN: The service is notified when the computer's hardware
  ///               profile has changed. This enables the system to send
  ///               SERVICE_CONTROL_HARDWAREPROFILECHANGE notifications to
  ///               the service.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_HARDWAREPROFILECHANGE = $00000020;

  ///  <summary>
  ///    From MSDN: The service is notified when the computer's power status
  ///               has changed. This enables the system to send
  ///               SERVICE_CONTROL_POWEREVENT notifications to the service.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_POWEREVENT = $00000040;

  ///  <summary>
  ///    From MSDN: The service is notified when the computer's session status
  ///               has changed. This enables the system to send
  ///               SERVICE_CONTROL_SESSIONCHANGE notifications to the service.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_SESSIONCHANGE = $00000080;

  ///  <summary>
  ///    From MSDN: The service is notified when the system time has changed.
  ///               This enables the system to send SERVICE_CONTROL_TIMECHANGE
  ///               notifications to the service. Windows Server 2008,
  ///               Windows Vista, Windows Server 2003 and
  ///               Windows XP: This control code is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_TIMECHANGE = $00000200;

  ///  <summary>
  ///    From MSDN: The service is notified when an event for which the
  ///               service has registered occurs. This enables the system
  ///               to send SERVICE_CONTROL_TRIGGEREVENT notifications to
  ///               the service. Windows Server 2008, Windows Vista,
  ///               Windows Server 2003 and
  ///               Windows XP:  This control code is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_TRIGGEREVENT = $00000400;

  ///  <summary>
  ///    From MSDN: The services is notified when the user initiates a reboot.
  ///               Windows Server 2008 R2, Windows 7, Windows Server 2008,
  ///               Windows Vista, Windows Server 2003 and
  ///               Windows XP: This control code is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  SERVICE_ACCEPT_USERMODEREBOOT = $00000800;

  ///  <summary>
  ///    From MSDN: Notifies a paused service that it should resume.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_CONTINUE = $00000003;

  ///  <summary>
  ///    From MSDN: Notifies a service that it should report its current
  ///               status information to the service control manager.
  ///               The handler should simply return NO_ERROR; the SCM is
  ///               aware of the current state of the service.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_INTERROGATE = $00000004;

  ///  <summary>
  ///    From MSDN: Notifies a network service that there is a new component
  ///               for binding. The service should bind to the new component.
  ///               Applications should use Plug and Play functionality instead.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_NETBINDADD = $00000007;

  ///  <summary>
  ///    From MSDN: Notifies a network service that one of its bindings has
  ///               been disabled. The service should reread its binding
  ///               information and remove the binding.
  ///               Applications should use Plug and Play functionality instead.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_NETBINDDISABLE = $0000000A;

  ///  <summary>
  ///    From MSDN: Notifies a network service that a disabled binding has
  ///               been enabled. The service should reread its binding
  ///               information and add the new binding.
  ///               Applications should use Plug and Play functionality instead.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_NzETBINDENABLE = $00000009;

  ///  <summary>
  ///    From MSDN: Notifies a network service that a component for binding
  ///               has been removed. The service should reread its binding
  ///               information and unbind from the removed component.
  ///               Applications should use Plug and Play functionality instead.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_NETBINDREMOVE = $00000008;

  ///  <summary>
  ///    From MSDN: Notifies a service that its startup parameters have changed.
  ///               The service should reread its startup parameters.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_PARAMCHANGE = $00000006;

  ///  <summary>
  ///    From MSDN: Notifies a service that it should pause.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_PAUSE = $00000002;

  ///  <summary>
  ///    From MSDN: Notifies a service that the system is shutting down so
  ///               the service can perform cleanup tasks. If a service accepts
  ///               this control code, it must stop after it performs its
  ///               cleanup tasks and return NO_ERROR. After the SCM sends
  ///               this control code, it will not send other control codes
  ///               to the service. For more information, see Remarks.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_SHUTDOWN = $00000005;

  ///  <summary>
  ///    From MSDN: Notifies a service that it should stop.
  ///               If a service accepts this control code, it must stop upon
  ///               receipt and return NO_ERROR. After the SCM sends this
  ///               control code, it does not send other control codes.
  ///               Windows XP:  If the service returns NO_ERROR and continues
  ///               to run, it continues to receive control codes.
  ///               This behavior changed starting with Windows Server 2003 and
  ///               Windows XP with SP2.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_STOP = $00000001;

  ///  <summary>
  ///    From MSDN: Notifies a network service that a disabled binding has
  ///               been enabled. The service should reread its binding
  ///               information and add the new binding. Applications should
  ///               use Plug and Play functionality instead.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_NETBINDENABLE = $00000009;

  ///  <summary>
  ///    From MSDN: Notifies a service that the system will be shutting down.
  ///               Services that need additional time to perform cleanup tasks
  ///               beyond the tight time restriction at system shutdown can
  ///               use this notification. The service control manager sends
  ///               this notification to applications that have registered for
  ///               it before sending a SERVICE_CONTROL_SHUTDOWN notification
  ///               to applications that have registered for that notification.
  ///               A service that handles this notification blocks system
  ///               shutdown until the service stops or the preshutdown
  ///               time-out interval specified through
  ///               SERVICE_PRESHUTDOWN_INFO expires. Because this affects
  ///               the user experience, services should use this feature only
  ///               if it is absolutely necessary to avoid data loss or
  ///               significant recovery time at the next system start.
  ///               Windows Server 2003 and
  ///               Windows XP: This value is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_PRESHUTDOWN = $0000000F;

  ///  <summary>
  ///    From MSDN: Notifies a service of device events.
  ///               (The service must have registered to receive these
  ///               notifications using the RegisterDeviceNotification
  ///               function.) The dwEventType and lpEventData parameters
  ///               contain additional information.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_DEVICEEVENT = $0000000B;

  ///  <summary>
  ///    From MSDN: Notifies a service that the computer's hardware profile
  ///               has changed. The dwEventType parameter contains
  ///               additional information.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_HARDWAREPROFILECHANGE = $0000000C;

  ///  <summary>
  ///    From MSDN: Notifies a service of system power events.
  ///               The dwEventType parameter contains additional information.
  ///               If dwEventType is PBT_POWERSETTINGCHANGE, the lpEventData
  ///               parameter also contains additional information.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_POWEREVENT = $0000000D;

  ///  <summary>
  ///    From MSDN: Notifies a service of session change events. Note that a
  ///               service will only be notified of a user logon if it is
  ///               fully loaded before the logon attempt is made.
  ///               The dwEventType and lpEventData parameters contain
  ///               additional information.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_SESSIONCHANGE = $0000000E;

  ///  <summary>
  ///    From MSDN: Notifies a service that the system time has changed.
  ///               The lpEventData parameter contains additional information.
  ///               The dwEventType parameter is not used. Windows Server 2008,
  ///               Windows Vista, Windows Server 2003 and
  ///               Windows XP: This control code is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_TIMECHANGE = $00000010;

  ///  <summary>
  ///    From MSDN: Notifies a service registered for a service trigger
  ///               event that the event has occurred. Windows Server 2008,
  ///               Windows Vista, Windows Server 2003 and
  ///               Windows XP: This control code is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_TRIGGEREVENT = $00000020;

  ///  <summary>
  ///    From MSDN: Notifies a service that the user has initiated a reboot.
  ///               Windows Server 2008 R2, Windows 7, Windows Server 2008,
  ///               Windows Vista, Windows Server 2003 and
  ///               Windows XP: This control code is not supported.
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  </summary>
  SERVICE_CONTROL_USERMODEREBOOT = $00000040;

//* -------------------------- ERROR HANDLING -------------------------------*//

const
  ///  <summary>
  ///  FROM MSDN: The operation completed successfully.
  ///  </summary>
  ERROR_SUCCESS                                              = $0;
  ///  <summary>
  ///  FROM MSDN: Incorrect function.
  ///  </summary>
  ERROR_INVALID_FUNCTION                                     = $1;
  ///  <summary>
  ///  FROM MSDN: The system cannot find the file specified.
  ///  </summary>
  ERROR_FILE_NOT_FOUND                                       = $2;
  ///  <summary>
  ///  FROM MSDN: The system cannot find the path specified.
  ///  </summary>
  ERROR_PATH_NOT_FOUND                                       = $3;
  ///  <summary>
  ///  FROM MSDN: The system cannot open the file.
  ///  </summary>
  ERROR_TOO_MANY_OPEN_FILES                                  = $4;
  ///  <summary>
  ///  FROM MSDN: Access is denied.
  ///  </summary>
  ERROR_ACCESS_DENIED                                        = $5;
  ///  <summary>
  ///  FROM MSDN: The handle is invalid.
  ///  </summary>
  ERROR_INVALID_HANDLE                                       = $6;
  ///  <summary>
  ///  FROM MSDN: The storage control blocks were destroyed.
  ///  </summary>
  ERROR_ARENA_TRASHED                                        = $7;
  ///  <summary>
  ///  FROM MSDN: Not enough storage is available to process this command.
  ///  </summary>
  ERROR_NOT_ENOUGH_MEMORY                                    = $8;
  ///  <summary>
  ///  FROM MSDN: The storage control block address is invalid.
  ///  </summary>
  ERROR_INVALID_BLOCK                                        = $9;
  ///  <summary>
  ///  FROM MSDN: The environment is incorrect.
  ///  </summary>
  ERROR_BAD_ENVIRONMENT                                      = $A;
  ///  <summary>
  ///  FROM MSDN: An attempt was made to load a program with an incorrect format.
  ///  </summary>
  ERROR_BAD_FORMAT                                           = $B;
  ///  <summary>
  ///  FROM MSDN: The access code is invalid.
  ///  </summary>
  ERROR_INVALID_ACCESS                                       = $C;
  ///  <summary>
  ///  FROM MSDN: The data is invalid.
  ///  </summary>
  ERROR_INVALID_DATA                                         = $D;
  ///  <summary>
  ///  FROM MSDN: Not enough storage is available to complete this operation.
  ///  </summary>
  ERROR_OUTOFMEMORY                                          = $E;
  ///  <summary>
  ///  FROM MSDN: The system cannot find the drive specified.
  ///  </summary>
  ERROR_INVALID_DRIVE                                        = $F;
  ///  <summary>
  ///  FROM MSDN: The directory cannot be removed.
  ///  </summary>
  ERROR_CURRENT_DIRECTORY                                    = $10;
  ///  <summary>
  ///  FROM MSDN: The system cannot move the file to a different disk drive.
  ///  </summary>
  ERROR_NOT_SAME_DEVICE                                      = $11;
  ///  <summary>
  ///  FROM MSDN: There are no more files.
  ///  </summary>
  ERROR_NO_MORE_FILES                                        = $12;
  ///  <summary>
  ///  FROM MSDN: The media is write protected.
  ///  </summary>
  ERROR_WRITE_PROTECT                                        = $13;
  ///  <summary>
  ///  FROM MSDN: The system cannot find the device specified.
  ///  </summary>
  ERROR_BAD_UNIT                                             = $14;
  ///  <summary>
  ///  FROM MSDN: The device is not ready.
  ///  </summary>
  ERROR_NOT_READY                                            = $15;
  ///  <summary>
  ///  FROM MSDN: The device does not recognize the command.
  ///  </summary>
  ERROR_BAD_COMMAND                                          = $16;
  ///  <summary>
  ///  FROM MSDN: Data error (cyclic redundancy check).
  ///  </summary>
  ERROR_CRC                                                  = $17;
  ///  <summary>
  ///  FROM MSDN: The program issued a command but the command length is incorrect.
  ///  </summary>
  ERROR_BAD_LENGTH                                           = $18;
  ///  <summary>
  ///  FROM MSDN: The drive cannot locate a specific area or track on the disk.
  ///  </summary>
  ERROR_SEEK                                                 = $19;
  ///  <summary>
  ///  FROM MSDN: The specified disk or diskette cannot be accessed.
  ///  </summary>
  ERROR_NOT_DOS_DISK                                         = $1A;
  ///  <summary>
  ///  FROM MSDN: The drive cannot find the sector requested.
  ///  </summary>
  ERROR_SECTOR_NOT_FOUND                                     = $1B;
  ///  <summary>
  ///  FROM MSDN: The printer is out of paper.
  ///  </summary>
  ERROR_OUT_OF_PAPER                                         = $1C;
  ///  <summary>
  ///  FROM MSDN: The system cannot write to the specified device.
  ///  </summary>
  ERROR_WRITE_FAULT                                          = $1D;
  ///  <summary>
  ///  FROM MSDN: The system cannot read from the specified device.
  ///  </summary>
  ERROR_READ_FAULT                                           = $1E;
  ///  <summary>
  ///  FROM MSDN: A device attached to the system is not functioning.
  ///  </summary>
  ERROR_GEN_FAILURE                                          = $1F;
  ///  <summary>
  ///  FROM MSDN: The process cannot access the file because it is being used by another process.
  ///  </summary>
  ERROR_SHARING_VIOLATION                                    = $20;
  ///  <summary>
  ///  FROM MSDN: The process cannot access the file because another process has locked a portion of the file.
  ///  </summary>
  ERROR_LOCK_VIOLATION                                       = $21;
  ///  <summary>
  ///  FROM MSDN: The wrong diskette is in the drive. Insert %2 (Volume Serial Number: %3) into drive %1.
  ///  </summary>
  ERROR_WRONG_DISK                                           = $22;
  ///  <summary>
  ///  FROM MSDN: Too many files opened for sharing.
  ///  </summary>
  ERROR_SHARING_BUFFER_EXCEEDED                              = $24;
  ///  <summary>
  ///  FROM MSDN: Reached the end of the file.
  ///  </summary>
  ERROR_HANDLE_EOF                                           = $26;
  ///  <summary>
  ///  FROM MSDN: The disk is full.
  ///  </summary>
  ERROR_HANDLE_DISK_FULL                                     = $27;
  ///  <summary>
  ///  FROM MSDN: The request is not supported.
  ///  </summary>
  ERROR_NOT_SUPPORTED                                        = $32;
  ///  <summary>
  ///  FROM MSDN: Windows cannot find the network path. Verify that the network path is correct and the destination computer is not busy or turned off. If Windows still cannot find the network path, contact your network administrator.
  ///  </summary>
  ERROR_REM_NOT_LIST                                         = $33;
  ///  <summary>
  ///  FROM MSDN: You were not connected because a duplicate name exists on the network. If joining a domain, go to System in Control Panel to change the computer name and try again. If joining a workgroup, choose another workgroup name.
  ///  </summary>
  ERROR_DUP_NAME                                             = $34;
  ///  <summary>
  ///  FROM MSDN: The network path was not found.
  ///  </summary>
  ERROR_BAD_NETPATH                                          = $35;
  ///  <summary>
  ///  FROM MSDN: The network is busy.
  ///  </summary>
  ERROR_NETWORK_BUSY                                         = $36;
  ///  <summary>
  ///  FROM MSDN: The specified network resource or device is no longer available.
  ///  </summary>
  ERROR_DEV_NOT_EXIST                                        = $37;
  ///  <summary>
  ///  FROM MSDN: The network BIOS command limit has been reached.
  ///  </summary>
  ERROR_TOO_MANY_CMDS                                        = $38;
  ///  <summary>
  ///  FROM MSDN: A network adapter hardware error occurred.
  ///  </summary>
  ERROR_ADAP_HDW_ERR                                         = $39;
  ///  <summary>
  ///  FROM MSDN: The specified server cannot perform the requested operation.
  ///  </summary>
  ERROR_BAD_NET_RESP                                         = $3A;
  ///  <summary>
  ///  FROM MSDN: An unexpected network error occurred.
  ///  </summary>
  ERROR_UNEXP_NET_ERR                                        = $3B;
  ///  <summary>
  ///  FROM MSDN: The remote adapter is not compatible.
  ///  </summary>
  ERROR_BAD_REM_ADAP                                         = $3C;
  ///  <summary>
  ///  FROM MSDN: The printer queue is full.
  ///  </summary>
  ERROR_PRINTQ_FULL                                          = $3D;
  ///  <summary>
  ///  FROM MSDN: Space to store the file waiting to be printed is not available on the server.
  ///  </summary>
  ERROR_NO_SPOOL_SPACE                                       = $3E;
  ///  <summary>
  ///  FROM MSDN: Your file waiting to be printed was deleted.
  ///  </summary>
  ERROR_PRINT_CANCELLED                                      = $3F;
  ///  <summary>
  ///  FROM MSDN: The specified network name is no longer available.
  ///  </summary>
  ERROR_NETNAME_DELETED                                      = $40;
  ///  <summary>
  ///  FROM MSDN: Network access is denied.
  ///  </summary>
  ERROR_NETWORK_ACCESS_DENIED                                = $41;
  ///  <summary>
  ///  FROM MSDN: The network resource type is not correct.
  ///  </summary>
  ERROR_BAD_DEV_TYPE                                         = $42;
  ///  <summary>
  ///  FROM MSDN: The network name cannot be found.
  ///  </summary>
  ERROR_BAD_NET_NAME                                         = $43;
  ///  <summary>
  ///  FROM MSDN: The name limit for the local computer network adapter card was exceeded.
  ///  </summary>
  ERROR_TOO_MANY_NAMES                                       = $44;
  ///  <summary>
  ///  FROM MSDN: The network BIOS session limit was exceeded.
  ///  </summary>
  ERROR_TOO_MANY_SESS                                        = $45;
  ///  <summary>
  ///  FROM MSDN: The remote server has been paused or is in the process of being started.
  ///  </summary>
  ERROR_SHARING_PAUSED                                       = $46;
  ///  <summary>
  ///  FROM MSDN: No more connections can be made to this remote computer at this time because there are already as many connections as the computer can accept.
  ///  </summary>
  ERROR_REQ_NOT_ACCEP                                        = $47;
  ///  <summary>
  ///  FROM MSDN: The specified printer or disk device has been paused.
  ///  </summary>
  ERROR_REDIR_PAUSED                                         = $48;
  ///  <summary>
  ///  FROM MSDN: The file exists.
  ///  </summary>
  ERROR_FILE_EXISTS                                          = $50;
  ///  <summary>
  ///  FROM MSDN: The directory or file cannot be created.
  ///  </summary>
  ERROR_CANNOT_MAKE                                          = $52;
  ///  <summary>
  ///  FROM MSDN: Fail on INT 24.
  ///  </summary>
  ERROR_FAIL_I24                                             = $53;
  ///  <summary>
  ///  FROM MSDN: Storage to process this request is not available.
  ///  </summary>
  ERROR_OUT_OF_STRUCTURES                                    = $54;
  ///  <summary>
  ///  FROM MSDN: The local device name is already in use.
  ///  </summary>
  ERROR_ALREADY_ASSIGNED                                     = $55;
  ///  <summary>
  ///  FROM MSDN: The specified network password is not correct.
  ///  </summary>
  ERROR_INVALID_PASSWORD                                     = $56;
  ///  <summary>
  ///  FROM MSDN: The parameter is incorrect.
  ///  </summary>
  ERROR_INVALID_PARAMETER                                    = $57;
  ///  <summary>
  ///  FROM MSDN: A write fault occurred on the network.
  ///  </summary>
  ERROR_NET_WRITE_FAULT                                      = $58;
  ///  <summary>
  ///  FROM MSDN: The system cannot start another process at this time.
  ///  </summary>
  ERROR_NO_PROC_SLOTS                                        = $59;
  ///  <summary>
  ///  FROM MSDN: Cannot create another system semaphore.
  ///  </summary>
  ERROR_TOO_MANY_SEMAPHORES                                  = $64;
  ///  <summary>
  ///  FROM MSDN: The exclusive semaphore is owned by another process.
  ///  </summary>
  ERROR_EXCL_SEM_ALREADY_OWNED                               = $65;
  ///  <summary>
  ///  FROM MSDN: The semaphore is set and cannot be closed.
  ///  </summary>
  ERROR_SEM_IS_SET                                           = $66;
  ///  <summary>
  ///  FROM MSDN: The semaphore cannot be set again.
  ///  </summary>
  ERROR_TOO_MANY_SEM_REQUESTS                                = $67;
  ///  <summary>
  ///  FROM MSDN: Cannot request exclusive semaphores at interrupt time.
  ///  </summary>
  ERROR_INVALID_AT_INTERRUPT_TIME                            = $68;
  ///  <summary>
  ///  FROM MSDN: The previous ownership of this semaphore has ended.
  ///  </summary>
  ERROR_SEM_OWNER_DIED                                       = $69;
  ///  <summary>
  ///  FROM MSDN: Insert the diskette for drive %1.
  ///  </summary>
  ERROR_SEM_USER_LIMIT                                       = $6A;
  ///  <summary>
  ///  FROM MSDN: The program stopped because an alternate diskette was not inserted.
  ///  </summary>
  ERROR_DISK_CHANGE                                          = $6B;
  ///  <summary>
  ///  FROM MSDN: The disk is in use or locked by another process.
  ///  </summary>
  ERROR_DRIVE_LOCKED                                         = $6C;
  ///  <summary>
  ///  FROM MSDN: The pipe has been ended.
  ///  </summary>
  ERROR_BROKEN_PIPE                                          = $6D;
  ///  <summary>
  ///  FROM MSDN: The system cannot open the device or file specified.
  ///  </summary>
  ERROR_OPEN_FAILED                                          = $6E;
  ///  <summary>
  ///  FROM MSDN: The file name is too long.
  ///  </summary>
  ERROR_BUFFER_OVERFLOW                                      = $6F;
  ///  <summary>
  ///  FROM MSDN: There is not enough space on the disk.
  ///  </summary>
  ERROR_DISK_FULL                                            = $70;
  ///  <summary>
  ///  FROM MSDN: No more internal file identifiers available.
  ///  </summary>
  ERROR_NO_MORE_SEARCH_HANDLES                               = $71;
  ///  <summary>
  ///  FROM MSDN: The target internal file identifier is incorrect.
  ///  </summary>
  ERROR_INVALID_TARGET_HANDLE                                = $72;
  ///  <summary>
  ///  FROM MSDN: The IOCTL call made by the application program is not correct.
  ///  </summary>
  ERROR_INVALID_CATEGORY                                     = $75;
  ///  <summary>
  ///  FROM MSDN: The verify-on-write switch parameter value is not correct.
  ///  </summary>
  ERROR_INVALID_VERIFY_SWITCH                                = $76;
  ///  <summary>
  ///  FROM MSDN: The system does not support the command requested.
  ///  </summary>
  ERROR_BAD_DRIVER_LEVEL                                     = $77;
  ///  <summary>
  ///  FROM MSDN: This function is not supported on this system.
  ///  </summary>
  ERROR_CALL_NOT_IMPLEMENTED                                 = $78;
  ///  <summary>
  ///  FROM MSDN: The semaphore timeout period has expired.
  ///  </summary>
  ERROR_SEM_TIMEOUT                                          = $79;
  ///  <summary>
  ///  FROM MSDN: The data area passed to a system call is too small.
  ///  </summary>
  ERROR_INSUFFICIENT_BUFFER                                  = $7A;
  ///  <summary>
  ///  FROM MSDN: The filename, directory name, or volume label syntax is incorrect.
  ///  </summary>
  ERROR_INVALID_NAME                                         = $7B;
  ///  <summary>
  ///  FROM MSDN: The system call level is not correct.
  ///  </summary>
  ERROR_INVALID_LEVEL                                        = $7C;
  ///  <summary>
  ///  FROM MSDN: The disk has no volume label.
  ///  </summary>
  ERROR_NO_VOLUME_LABEL                                      = $7D;
  ///  <summary>
  ///  FROM MSDN: The specified module could not be found.
  ///  </summary>
  ERROR_MOD_NOT_FOUND                                        = $7E;
  ///  <summary>
  ///  FROM MSDN: The specified procedure could not be found.
  ///  </summary>
  ERROR_PROC_NOT_FOUND                                       = $7F;
  ///  <summary>
  ///  FROM MSDN: There are no child processes to wait for.
  ///  </summary>
  ERROR_WAIT_NO_CHILDREN                                     = $80;
  ///  <summary>
  ///  FROM MSDN: The %1 application cannot be run in Win32 mode.
  ///  </summary>
  ERROR_CHILD_NOT_COMPLETE                                   = $81;
  ///  <summary>
  ///  FROM MSDN: Attempt to use a file handle to an open disk partition for an operation other than raw disk I/O.
  ///  </summary>
  ERROR_DIRECT_ACCESS_HANDLE                                 = $82;
  ///  <summary>
  ///  FROM MSDN: An attempt was made to move the file pointer before the beginning of the file.
  ///  </summary>
  ERROR_NEGATIVE_SEEK                                        = $83;
  ///  <summary>
  ///  FROM MSDN: The file pointer cannot be set on the specified device or file.
  ///  </summary>
  ERROR_SEEK_ON_DEVICE                                       = $84;
  ///  <summary>
  ///  FROM MSDN: A JOIN or SUBST command cannot be used for a drive that contains previously joined drives.
  ///  </summary>
  ERROR_IS_JOIN_TARGET                                       = $85;
  ///  <summary>
  ///  FROM MSDN: An attempt was made to use a JOIN or SUBST command on a drive that has already been joined.
  ///  </summary>
  ERROR_IS_JOINED                                            = $86;
  ///  <summary>
  ///  FROM MSDN: An attempt was made to use a JOIN or SUBST command on a drive that has already been substituted.
  ///  </summary>
  ERROR_IS_SUBSTED                                           = $87;
  ///  <summary>
  ///  FROM MSDN: The system tried to delete the JOIN of a drive that is not joined.
  ///  </summary>
  ERROR_NOT_JOINED                                           = $88;
  ///  <summary>
  ///  FROM MSDN: The system tried to delete the substitution of a drive that is not substituted.
  ///  </summary>
  ERROR_NOT_SUBSTED                                          = $89;
  ///  <summary>
  ///  FROM MSDN: The system tried to join a drive to a directory on a joined drive.
  ///  </summary>
  ERROR_JOIN_TO_JOIN                                         = $8A;
  ///  <summary>
  ///  FROM MSDN: The system tried to substitute a drive to a directory on a substituted drive.
  ///  </summary>
  ERROR_SUBST_TO_SUBST                                       = $8B;
  ///  <summary>
  ///  FROM MSDN: The system tried to join a drive to a directory on a substituted drive.
  ///  </summary>
  ERROR_JOIN_TO_SUBST                                        = $8C;
  ///  <summary>
  ///  FROM MSDN: The system tried to SUBST a drive to a directory on a joined drive.
  ///  </summary>
  ERROR_SUBST_TO_JOIN                                        = $8D;
  ///  <summary>
  ///  FROM MSDN: The system cannot perform a JOIN or SUBST at this time.
  ///  </summary>
  ERROR_BUSY_DRIVE                                           = $8E;
  ///  <summary>
  ///  FROM MSDN: The system cannot join or substitute a drive to or for a directory on the same drive.
  ///  </summary>
  ERROR_SAME_DRIVE                                           = $8F;
  ///  <summary>
  ///  FROM MSDN: The directory is not a subdirectory of the root directory.
  ///  </summary>
  ERROR_DIR_NOT_ROOT                                         = $90;
  ///  <summary>
  ///  FROM MSDN: The directory is not empty.
  ///  </summary>
  ERROR_DIR_NOT_EMPTY                                        = $91;
  ///  <summary>
  ///  FROM MSDN: The path specified is being used in a substitute.
  ///  </summary>
  ERROR_IS_SUBST_PATH                                        = $92;
  ///  <summary>
  ///  FROM MSDN: Not enough resources are available to process this command.
  ///  </summary>
  ERROR_IS_JOIN_PATH                                         = $93;
  ///  <summary>
  ///  FROM MSDN: The path specified cannot be used at this time.
  ///  </summary>
  ERROR_PATH_BUSY                                            = $94;
  ///  <summary>
  ///  FROM MSDN: An attempt was made to join or substitute a drive for which a directory on the drive is the target of a previous substitute.
  ///  </summary>
  ERROR_IS_SUBST_TARGET                                      = $95;
  ///  <summary>
  ///  FROM MSDN: System trace information was not specified in your CONFIG.SYS file, or tracing is disallowed.
  ///  </summary>
  ERROR_SYSTEM_TRACE                                         = $96;
  ///  <summary>
  ///  FROM MSDN: The number of specified semaphore events for DosMuxSemWait is not correct.
  ///  </summary>
  ERROR_INVALID_EVENT_COUNT                                  = $97;
  ///  <summary>
  ///  FROM MSDN: DosMuxSemWait did not execute; too many semaphores are already set.
  ///  </summary>
  ERROR_TOO_MANY_MUXWAITERS                                  = $98;
  ///  <summary>
  ///  FROM MSDN: The DosMuxSemWait list is not correct.
  ///  </summary>
  ERROR_INVALID_LIST_FORMAT                                  = $99;
  ///  <summary>
  ///  FROM MSDN: The volume label you entered exceeds the label character limit of the target file system.
  ///  </summary>
  ERROR_LABEL_TOO_LONG                                       = $9A;
  ///  <summary>
  ///  FROM MSDN: Cannot create another thread.
  ///  </summary>
  ERROR_TOO_MANY_TCBS                                        = $9B;
  ///  <summary>
  ///  FROM MSDN: The recipient process has refused the signal.
  ///  </summary>
  ERROR_SIGNAL_REFUSED                                       = $9C;
  ///  <summary>
  ///  FROM MSDN: The segment is already discarded and cannot be locked.
  ///  </summary>
  ERROR_DISCARDED                                            = $9D;
  ///  <summary>
  ///  FROM MSDN: The segment is already unlocked.
  ///  </summary>
  ERROR_NOT_LOCKED                                           = $9E;
  ///  <summary>
  ///  FROM MSDN: The address for the thread ID is not correct.
  ///  </summary>
  ERROR_BAD_THREADID_ADDR                                    = $9F;
  ///  <summary>
  ///  FROM MSDN: One or more arguments are not correct.
  ///  </summary>
  ERROR_BAD_ARGUMENTS                                        = $A0;
  ///  <summary>
  ///  FROM MSDN: The specified path is invalid.
  ///  </summary>
  ERROR_BAD_PATHNAME                                         = $A1;
  ///  <summary>
  ///  FROM MSDN: A signal is already pending.
  ///  </summary>
  ERROR_SIGNAL_PENDING                                       = $A2;
  ///  <summary>
  ///  FROM MSDN: No more threads can be created in the system.
  ///  </summary>
  ERROR_MAX_THRDS_REACHED                                    = $A4;
  ///  <summary>
  ///  FROM MSDN: Unable to lock a region of a file.
  ///  </summary>
  ERROR_LOCK_FAILED                                          = $A7;
  ///  <summary>
  ///  FROM MSDN: The requested resource is in use.
  ///  </summary>
  ERROR_BUSY                                                 = $AA;
  ///  <summary>
  ///  FROM MSDN: Device's command support detection is in progress.
  ///  </summary>
  ERROR_DEVICE_SUPPORT_IN_PROGRESS                           = $AB;
  ///  <summary>
  ///  FROM MSDN: A lock request was not outstanding for the supplied cancel region.
  ///  </summary>
  ERROR_CANCEL_VIOLATION                                     = $AD;
  ///  <summary>
  ///  FROM MSDN: The file system does not support atomic changes to the lock type.
  ///  </summary>
  ERROR_ATOMIC_LOCKS_NOT_SUPPORTED                           = $AE;
  ///  <summary>
  ///  FROM MSDN: The system detected a segment number that was not correct.
  ///  </summary>
  ERROR_INVALID_SEGMENT_NUMBER                               = $B4;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_INVALID_ORDINAL                                      = $B6;
  ///  <summary>
  ///  FROM MSDN: Cannot create a file when that file already exists.
  ///  </summary>
  ERROR_ALREADY_EXISTS                                       = $B7;
  ///  <summary>
  ///  FROM MSDN: The flag passed is not correct.
  ///  </summary>
  ERROR_INVALID_FLAG_NUMBER                                  = $BA;
  ///  <summary>
  ///  FROM MSDN: The specified system semaphore name was not found.
  ///  </summary>
  ERROR_SEM_NOT_FOUND                                        = $BB;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_INVALID_STARTING_CODESEG                             = $BC;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_INVALID_STACKSEG                                     = $BD;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_INVALID_MODULETYPE                                   = $BE;
  ///  <summary>
  ///  FROM MSDN: Cannot run %1 in Win32 mode.
  ///  </summary>
  ERROR_INVALID_EXE_SIGNATURE                                = $BF;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_EXE_MARKED_INVALID                                   = $C0;
  ///  <summary>
  ///  FROM MSDN: %1 is not a valid Win32 application.
  ///  </summary>
  ERROR_BAD_EXE_FORMAT                                       = $C1;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_ITERATED_DATA_EXCEEDS_64k                            = $C2;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_INVALID_MINALLOCSIZE                                 = $C3;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run this application program.
  ///  </summary>
  ERROR_DYNLINK_FROM_INVALID_RING                            = $C4;
  ///  <summary>
  ///  FROM MSDN: The operating system is not presently configured to run this application.
  ///  </summary>
  ERROR_IOPL_NOT_ENABLED                                     = $C5;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_INVALID_SEGDPL                                       = $C6;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run this application program.
  ///  </summary>
  ERROR_AUTODATASEG_EXCEEDS_64k                              = $C7;
  ///  <summary>
  ///  FROM MSDN: The code segment cannot be greater than or equal to 64K.
  ///  </summary>
  ERROR_RING2SEG_MUST_BE_MOVABLE                             = $C8;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_RELOC_CHAIN_XEEDS_SEGLIM                             = $C9;
  ///  <summary>
  ///  FROM MSDN: The operating system cannot run %1.
  ///  </summary>
  ERROR_INFLOOP_IN_RELOC_CHAIN                               = $CA;
  ///  <summary>
  ///  FROM MSDN: The system could not find the environment option that was entered.
  ///  </summary>
  ERROR_ENVVAR_NOT_FOUND                                     = $CB;
  ///  <summary>
  ///  FROM MSDN: No process in the command subtree has a signal handler.
  ///  </summary>
  ERROR_NO_SIGNAL_SENT                                       = $CD;
  ///  <summary>
  ///  FROM MSDN: The filename or extension is too long.
  ///  </summary>
  ERROR_FILENAME_EXCED_RANGE                                 = $CE;
  ///  <summary>
  ///  FROM MSDN: The ring 2 stack is in use.
  ///  </summary>
  ERROR_RING2_STACK_IN_USE                                   = $CF;
  ///  <summary>
  ///  FROM MSDN: The global filename characters, * or ?, are entered incorrectly or too many global filename characters are specified.
  ///  </summary>
  ERROR_META_EXPANSION_TOO_LONG                              = $D0;
  ///  <summary>
  ///  FROM MSDN: The signal being posted is not correct.
  ///  </summary>
  ERROR_INVALID_SIGNAL_NUMBER                                = $D1;
  ///  <summary>
  ///  FROM MSDN: The signal handler cannot be set.
  ///  </summary>
  ERROR_THREAD_1_INACTIVE                                    = $D2;
  ///  <summary>
  ///  FROM MSDN: The segment is locked and cannot be reallocated.
  ///  </summary>
  ERROR_LOCKED                                               = $D4;
  ///  <summary>
  ///  FROM MSDN: Too many dynamic-link modules are attached to this program or dynamic-link module.
  ///  </summary>
  ERROR_TOO_MANY_MODULES                                     = $D6;
  ///  <summary>
  ///  FROM MSDN: Cannot nest calls to LoadModule.
  ///  </summary>
  ERROR_NESTING_NOT_ALLOWED                                  = $D7;
  ///  <summary>
  ///  FROM MSDN: This version of %1 is not compatible with the version of Windows you're running. Check your computer's system information and then contact the software publisher.
  ///  </summary>
  ERROR_EXE_MACHINE_TYPE_MISMATCH                            = $D8;
  ///  <summary>
  ///  FROM MSDN: The image file %1 is signed, unable to modify.
  ///  </summary>
  ERROR_EXE_CANNOT_MODIFY_SIGNED_BINARY                      = $D9;
  ///  <summary>
  ///  FROM MSDN: The image file %1 is strong signed, unable to modify.
  ///  </summary>
  ERROR_EXE_CANNOT_MODIFY_STRONG_SIGNED_BINARY               = $DA;
  ///  <summary>
  ///  FROM MSDN: This file is checked out or locked for editing by another user.
  ///  </summary>
  ERROR_FILE_CHECKED_OUT                                     = $DC;
  ///  <summary>
  ///  FROM MSDN: The file must be checked out before saving changes.
  ///  </summary>
  ERROR_CHECKOUT_REQUIRED                                    = $DD;
  ///  <summary>
  ///  FROM MSDN: The file type being saved or retrieved has been blocked.
  ///  </summary>
  ERROR_BAD_FILE_TYPE                                        = $DE;
  ///  <summary>
  ///  FROM MSDN: The file size exceeds the limit allowed and cannot be saved.
  ///  </summary>
  ERROR_FILE_TOO_LARGE                                       = $DF;
  ///  <summary>
  ///  FROM MSDN: Access Denied. Before opening files in this location, you must first add the web site to your trusted sites list, browse to the web site, and select the option to login automatically.
  ///  </summary>
  ERROR_FORMS_AUTH_REQUIRED                                  = $E0;
  ///  <summary>
  ///  FROM MSDN: Operation did not complete successfully because the file contains a virus or potentially unwanted software.
  ///  </summary>
  ERROR_VIRUS_INFECTED                                       = $E1;
  ///  <summary>
  ///  FROM MSDN: This file contains a virus or potentially unwanted software and cannot be opened. Due to the nature of this virus or potentially unwanted software, the file has been removed from this location.
  ///  </summary>
  ERROR_VIRUS_DELETED                                        = $E2;
  ///  <summary>
  ///  FROM MSDN: The pipe is local.
  ///  </summary>
  ERROR_PIPE_LOCAL                                           = $E5;
  ///  <summary>
  ///  FROM MSDN: The pipe state is invalid.
  ///  </summary>
  ERROR_BAD_PIPE                                             = $E6;
  ///  <summary>
  ///  FROM MSDN: All pipe instances are busy.
  ///  </summary>
  ERROR_PIPE_BUSY                                            = $E7;
  ///  <summary>
  ///  FROM MSDN: The pipe is being closed.
  ///  </summary>
  ERROR_NO_DATA                                              = $E8;
  ///  <summary>
  ///  FROM MSDN: No process is on the other end of the pipe.
  ///  </summary>
  ERROR_PIPE_NOT_CONNECTED                                   = $E9;
  ///  <summary>
  ///  FROM MSDN: More data is available.
  ///  </summary>
  ERROR_MORE_DATA                                            = $EA;
  ///  <summary>
  ///  FROM MSDN: The session was canceled.
  ///  </summary>
  ERROR_VC_DISCONNECTED                                      = $F0;
  ///  <summary>
  ///  FROM MSDN: The specified extended attribute name was invalid.
  ///  </summary>
  ERROR_INVALID_EA_NAME                                      = $FE;
  ///  <summary>
  ///  FROM MSDN: The extended attributes are inconsistent.
  ///  </summary>
  ERROR_EA_LIST_INCONSISTENT                                 = $FF;
  ///  <summary>
  ///  FROM MSDN: The wait operation timed out.
  ///  </summary>
  WAIT_TIMEOUT                                               = $102;
  ///  <summary>
  ///  FROM MSDN: No more data is available.
  ///  </summary>
  ERROR_NO_MORE_ITEMS                                        = $103;
  ///  <summary>
  ///  FROM MSDN: The copy functions cannot be used.
  ///  </summary>
  ERROR_CANNOT_COPY                                          = $10A;
  ///  <summary>
  ///  FROM MSDN: The directory name is invalid.
  ///  </summary>
  ERROR_DIRECTORY                                            = $10B;
  ///  <summary>
  ///  FROM MSDN: The extended attributes did not fit in the buffer.
  ///  </summary>
  ERROR_EAS_DIDNT_FIT                                        = $113;
  ///  <summary>
  ///  FROM MSDN: The extended attribute file on the mounted file system is corrupt.
  ///  </summary>
  ERROR_EA_FILE_CORRUPT                                      = $114;
  ///  <summary>
  ///  FROM MSDN: The extended attribute table file is full.
  ///  </summary>
  ERROR_EA_TABLE_FULL                                        = $115;
  ///  <summary>
  ///  FROM MSDN: The specified extended attribute handle is invalid.
  ///  </summary>
  ERROR_INVALID_EA_HANDLE                                    = $116;
  ///  <summary>
  ///  FROM MSDN: The mounted file system does not support extended attributes.
  ///  </summary>
  ERROR_EAS_NOT_SUPPORTED                                    = $11A;
  ///  <summary>
  ///  FROM MSDN: Attempt to release mutex not owned by caller.
  ///  </summary>
  ERROR_NOT_OWNER                                            = $120;
  ///  <summary>
  ///  FROM MSDN: Too many posts were made to a semaphore.
  ///  </summary>
  ERROR_TOO_MANY_POSTS                                       = $12A;
  ///  <summary>
  ///  FROM MSDN: Only part of a ReadProcessMemory or WriteProcessMemory request was completed.
  ///  </summary>
  ERROR_PARTIAL_COPY                                         = $12B;
  ///  <summary>
  ///  FROM MSDN: The oplock request is denied.
  ///  </summary>
  ERROR_OPLOCK_NOT_GRANTED                                   = $12C;
  ///  <summary>
  ///  FROM MSDN: An invalid oplock acknowledgment was received by the system.
  ///  </summary>
  ERROR_INVALID_OPLOCK_PROTOCOL                              = $12D;
  ///  <summary>
  ///  FROM MSDN: The volume is too fragmented to complete this operation.
  ///  </summary>
  ERROR_DISK_TOO_FRAGMENTED                                  = $12E;
  ///  <summary>
  ///  FROM MSDN: The file cannot be opened because it is in the process of being deleted.
  ///  </summary>
  ERROR_DELETE_PENDING                                       = $12F;
  ///  <summary>
  ///  FROM MSDN: Short name settings may not be changed on this volume due to the global registry setting.
  ///  </summary>
  ERROR_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING = $130;
  ///  <summary>
  ///  FROM MSDN: Short names are not enabled on this volume.
  ///  </summary>
  ERROR_SHORT_NAMES_NOT_ENABLED_ON_VOLUME                    = $131;
  ///  <summary>
  ///  FROM MSDN: The security stream for the given volume is in an inconsistent state. Please run CHKDSK on the volume.
  ///  </summary>
  ERROR_SECURITY_STREAM_IS_INCONSISTENT                      = $132;
  ///  <summary>
  ///  FROM MSDN: A requested file lock operation cannot be processed due to an invalid byte range.
  ///  </summary>
  ERROR_INVALID_LOCK_RANGE                                   = $133;
  ///  <summary>
  ///  FROM MSDN: The subsystem needed to support the image type is not present.
  ///  </summary>
  ERROR_IMAGE_SUBSYSTEM_NOT_PRESENT                          = $134;
  ///  <summary>
  ///  FROM MSDN: The specified file already has a notification GUID associated with it.
  ///  </summary>
  ERROR_NOTIFICATION_GUID_ALREADY_DEFINED                    = $135;
  ///  <summary>
  ///  FROM MSDN: An invalid exception handler routine has been detected.
  ///  </summary>
  ERROR_INVALID_EXCEPTION_HANDLER                            = $136;
  ///  <summary>
  ///  FROM MSDN: Duplicate privileges were specified for the token.
  ///  </summary>
  ERROR_DUPLICATE_PRIVILEGES                                 = $137;
  ///  <summary>
  ///  FROM MSDN: No ranges for the specified operation were able to be processed.
  ///  </summary>
  ERROR_NO_RANGES_PROCESSED                                  = $138;
  ///  <summary>
  ///  FROM MSDN: Operation is not allowed on a file system internal file.
  ///  </summary>
  ERROR_NOT_ALLOWED_ON_SYSTEM_FILE                           = $139;
  ///  <summary>
  ///  FROM MSDN: The physical resources of this disk have been exhausted.
  ///  </summary>
  ERROR_DISK_RESOURCES_EXHAUSTED                             = $13A;
  ///  <summary>
  ///  FROM MSDN: The token representing the data is invalid.
  ///  </summary>
  ERROR_INVALID_TOKEN                                        = $13B;
  ///  <summary>
  ///  FROM MSDN: The device does not support the command feature.
  ///  </summary>
  ERROR_DEVICE_FEATURE_NOT_SUPPORTED                         = $13C;
  ///  <summary>
  ///  FROM MSDN: The system cannot find message text for message number 0x%1 in the message file for %2.
  ///  </summary>
  ERROR_MR_MID_NOT_FOUND                                     = $13D;
  ///  <summary>
  ///  FROM MSDN: The scope specified was not found.
  ///  </summary>
  ERROR_SCOPE_NOT_FOUND                                      = $13E;
  ///  <summary>
  ///  FROM MSDN: The Central Access Policy specified is not defined on the target machine.
  ///  </summary>
  ERROR_UNDEFINED_SCOPE                                      = $13F;
  ///  <summary>
  ///  FROM MSDN: The Central Access Policy obtained from Active Directory is invalid.
  ///  </summary>
  ERROR_INVALID_CAP                                          = $140;
  ///  <summary>
  ///  FROM MSDN: The device is unreachable.
  ///  </summary>
  ERROR_DEVICE_UNREACHABLE                                   = $141;
  ///  <summary>
  ///  FROM MSDN: The target device has insufficient resources to complete the operation.
  ///  </summary>
  ERROR_DEVICE_NO_RESOURCES                                  = $142;
  ///  <summary>
  ///  FROM MSDN: A data integrity checksum error occurred. Data in the file stream is corrupt.
  ///  </summary>
  ERROR_DATA_CHECKSUM_ERROR                                  = $143;
  ///  <summary>
  ///  FROM MSDN: An attempt was made to modify both a KERNEL and normal Extended Attribute (EA) in the same operation.
  ///  </summary>
  ERROR_INTERMIXED_KERNEL_EA_OPERATION                       = $144;
  ///  <summary>
  ///  FROM MSDN: Device does not support file-level TRIM.
  ///  </summary>
  ERROR_FILE_LEVEL_TRIM_NOT_SUPPORTED                        = $146;
  ///  <summary>
  ///  FROM MSDN: The command specified a data offset that does not align to the device's granularity/alignment.
  ///  </summary>
  ERROR_OFFSET_ALIGNMENT_VIOLATION                           = $147;
  ///  <summary>
  ///  FROM MSDN: The command specified an invalid field in its parameter list.
  ///  </summary>
  ERROR_INVALID_FIELD_IN_PARAMETER_LIST                      = $148;
  ///  <summary>
  ///  FROM MSDN: An operation is currently in progress with the device.
  ///  </summary>
  ERROR_OPERATION_IN_PROGRESS                                = $149;
  ///  <summary>
  ///  FROM MSDN: An attempt was made to send down the command via an invalid path to the target device.
  ///  </summary>
  ERROR_BAD_DEVICE_PATH                                      = $14A;
  ///  <summary>
  ///  FROM MSDN: The command specified a number of descriptors that exceeded the maximum supported by the device.
  ///  </summary>
  ERROR_TOO_MANY_DESCRIPTORS                                 = $14B;
  ///  <summary>
  ///  FROM MSDN: Scrub is disabled on the specified file.
  ///  </summary>
  ERROR_SCRUB_DATA_DISABLED                                  = $14C;
  ///  <summary>
  ///  FROM MSDN: The storage device does not provide redundancy.
  ///  </summary>
  ERROR_NOT_REDUNDANT_STORAGE                                = $14D;
  ///  <summary>
  ///  FROM MSDN: An operation is not supported on a resident file.
  ///  </summary>
  ERROR_RESIDENT_FILE_NOT_SUPPORTED                          = $14E;
  ///  <summary>
  ///  FROM MSDN: An operation is not supported on a compressed file.
  ///  </summary>
  ERROR_COMPRESSED_FILE_NOT_SUPPORTED                        = $14F;
  ///  <summary>
  ///  FROM MSDN: An operation is not supported on a directory.
  ///  </summary>
  ERROR_DIRECTORY_NOT_SUPPORTED                              = $150;
  ///  <summary>
  ///  FROM MSDN: The specified copy of the requested data could not be read.
  ///  </summary>
  ERROR_NOT_READ_FROM_COPY                                   = $151;
  ///  <summary>
  ///  FROM MSDN: No action was taken as a system reboot is required.
  ///  </summary>
  ERROR_FAIL_NOACTION_REBOOT                                 = $15E;
  ///  <summary>
  ///  FROM MSDN: The shutdown operation failed.
  ///  </summary>
  ERROR_FAIL_SHUTDOWN                                        = $15F;
  ///  <summary>
  ///  FROM MSDN: The restart operation failed.
  ///  </summary>
  ERROR_FAIL_RESTART                                         = $160;
  ///  <summary>
  ///  FROM MSDN: The maximum number of sessions has been reached.
  ///  </summary>
  ERROR_MAX_SESSIONS_REACHED                                 = $161;
  ///  <summary>
  ///  FROM MSDN: The thread is already in background processing mode.
  ///  </summary>
  ERROR_THREAD_MODE_ALREADY_BACKGROUND                       = $190;
  ///  <summary>
  ///  FROM MSDN: The thread is not in background processing mode.
  ///  </summary>
  ERROR_THREAD_MODE_NOT_BACKGROUND                           = $191;
  ///  <summary>
  ///  FROM MSDN: The process is already in background processing mode.
  ///  </summary>
  ERROR_PROCESS_MODE_ALREADY_BACKGROUND                      = $192;
  ///  <summary>
  ///  FROM MSDN: The process is not in background processing mode.
  ///  </summary>
  ERROR_PROCESS_MODE_NOT_BACKGROUND                          = $193;
  ///  <summary>
  ///  FROM MSDN: Attempt to access invalid address.
  ///  </summary>
  ERROR_INVALID_ADDRESS                                      = $1E7;


//* -------------------------- HEAP MEMORY ---------------------------------*//
const

  /// <summary>
  ///   FROM MSDN: Serialized access will not be used. For more information, see Remarks. <br />
  ///   To ensure that serialized access is disabled for all calls to this
  ///   function, specify HEAP_NO_SERIALIZE in the call to HeapCreate. In this
  ///   case, it is not necessary to additionally specify HEAP_NO_SERIALIZE in
  ///   this function call. <br />Do not specify this value when accessing the
  ///   process heap. The system may create additional threads within the
  ///   application's process, such as a CTRL+C handler, that simultaneously
  ///   access the process heap.
  /// </summary>
  HEAP_NO_SERIALIZE         = $00000001;

  /// <summary>
  ///   FROM MSDN: The system will raise an exception to indicate a function failure, such
  ///   as an out-of-memory condition, instead of returning NULL. <br />To
  ///   ensure that exceptions are generated for all calls to this function,
  ///   specify HEAP_GENERATE_EXCEPTIONS in the call to HeapCreate. In this
  ///   case, it is not necessary to additionally specify
  ///   HEAP_GENERATE_EXCEPTIONS in this function call.
  /// </summary>
  HEAP_GENERATE_EXCEPTIONS  = $00000004;

  /// <summary>
  ///   FROM MSDN: The allocated memory will be initialized to zero. Otherwise, the memory
  ///   is not initialized to zero.
  /// </summary>
  HEAP_ZERO_MEMORY          = $00000008;

{------------------------------------------------------------------------------}

  FILE_ANY_ACCESS                    = 0;
  FILE_SPECIAL_ACCESS                = FILE_ANY_ACCESS;
  FILE_READ_ACCESS                   = $0001;
  FILE_WRITE_ACCESS                  = $0002;
  FILE_SHARE_READ                    = $00000001;
  FILE_SHARE_WRITE                   = $00000002;
  FILE_SHARE_DELETE                  = $00000004;
  FILE_SHARE_VALID_FLAGS             = $00000007;
  FILE_ATTRIBUTE_READONLY            = $00000001;
  FILE_ATTRIBUTE_HIDDEN              = $00000002;
  FILE_ATTRIBUTE_SYSTEM              = $00000004;
  FILE_ATTRIBUTE_DIRECTORY           = $00000010;
  FILE_ATTRIBUTE_ARCHIVE             = $00000020;
  FILE_ATTRIBUTE_DEVICE              = $00000040;
  FILE_ATTRIBUTE_NORMAL              = $00000080;
  FILE_ATTRIBUTE_TEMPORARY           = $00000100;
  FILE_ATTRIBUTE_SPARSE_FILE         = $00000200;
  FILE_ATTRIBUTE_REPARSE_POINT       = $00000400;
  FILE_ATTRIBUTE_COMPRESSED          = $00000800;
  FILE_ATTRIBUTE_OFFLINE             = $00001000;
  FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = $00002000;
  FILE_ATTRIBUTE_ENCRYPTED           = $00004000;
  FILE_ATTRIBUTE_VALID_FLAGS         = $00007FB7;
  FILE_ATTRIBUTE_VALID_SET_FLAGS     = $000031A7;
  FILE_SUPERSEDE                     = $00000000;
  FILE_OPEN                          = $00000001;
  FILE_CREATE                        = $00000002;
  FILE_OPEN_IF                       = $00000003;
  FILE_OVERWRITE                     = $00000004;
  FILE_OVERWRITE_IF                  = $00000005;
  FILE_MAXIMUM_DISPOSITION           = $00000005;
  FILE_DIRECTORY_FILE                = $00000001;
  FILE_WRITE_THROUGH                 = $00000002;
  FILE_SEQUENTIAL_ONLY               = $00000004;
  FILE_NO_INTERMEDIATE_BUFFERING     = $00000008;
  FILE_SYNCHRONOUS_IO_ALERT          = $00000010;
  FILE_SYNCHRONOUS_IO_NONALERT       = $00000020;
  FILE_NON_DIRECTORY_FILE            = $00000040;
  FILE_CREATE_TREE_CONNECTION        = $00000080;
  FILE_COMPLETE_IF_OPLOCKED          = $00000100;
  FILE_NO_EA_KNOWLEDGE               = $00000200;
  FILE_OPEN_FOR_RECOVERY             = $00000400;
  FILE_RANDOM_ACCESS                 = $00000800;
  FILE_DELETE_ON_CLOSE               = $00001000;
  FILE_OPEN_BY_FILE_ID               = $00002000;
  FILE_OPEN_FOR_BACKUP_INTENT        = $00004000;
  FILE_NO_COMPRESSION                = $00008000;
  FILE_RESERVE_OPFILTER              = $00100000;
  FILE_OPEN_REPARSE_POINT            = $00200000;
  FILE_OPEN_NO_RECALL                = $00400000;
  FILE_OPEN_FOR_FREE_SPACE_QUERY     = $00800000;
  FILE_COPY_STRUCTURED_STORAGE       = $00000041;
  FILE_STRUCTURED_STORAGE            = $00000441;
  FILE_VALID_OPTION_FLAGS            = $00FFFFFF;
  FILE_VALID_PIPE_OPTION_FLAGS       = $00000032;
  FILE_VALID_MAILSLOT_OPTION_FLAGS   = $00000032;
  FILE_VALID_SET_FLAGS               = $00000036;
  FILE_SUPERSEDED                    = $00000000;
  FILE_OPENED                        = $00000001;
  FILE_CREATED                       = $00000002;
  FILE_OVERWRITTEN                   = $00000003;
  FILE_EXISTS                        = $00000004;
  FILE_DOES_NOT_EXIST                = $00000005;
  FILE_WRITE_TO_END_OF_FILE          = $FFFFFFFF;
  FILE_USE_FILE_POINTER_POSITION     = $FFFFFFFE;
  FILE_BYTE_ALIGNMENT                = $00000000;
  FILE_WORD_ALIGNMENT                = $00000001;
  FILE_LONG_ALIGNMENT                = $00000003;
  FILE_QUAD_ALIGNMENT                = $00000007;
  FILE_OCTA_ALIGNMENT                = $0000000F;
  FILE_32_BYTE_ALIGNMENT             = $0000001F;
  FILE_64_BYTE_ALIGNMENT             = $0000003F;
  FILE_128_BYTE_ALIGNMENT            = $0000007F;
  FILE_256_BYTE_ALIGNMENT            = $000000FF;
  FILE_512_BYTE_ALIGNMENT            = $000001FF;
  MAXIMUM_FILENAME_LENGTH            = 256;
  FILE_REMOVABLE_MEDIA               = $00000001;
  FILE_READ_ONLY_DEVICE              = $00000002;
  FILE_FLOPPY_DISKETTE               = $00000004;
  FILE_WRITE_ONCE_MEDIA              = $00000008;
  FILE_REMOTE_DEVICE                 = $00000010;
  FILE_DEVICE_IS_MOUNTED             = $00000020;
  FILE_VIRTUAL_VOLUME                = $00000040;
  FILE_AUTOGENERATED_DEVICE_NAME     = $00000080;
  FILE_DEVICE_SECURE_OPEN            = $00000100;

  //- error codes.

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Not all privileges or groups referenced are assigned to the caller.
  ///  </summary>
  ERROR_NOT_ALL_ASSIGNED = $514;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Some mapping between account names and security IDs was not done.
  ///  </summary>
  ERROR_SOME_NOT_MAPPED = $515;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No system quota limits are specifically set for this account.
  ///  </summary>
  ERROR_NO_QUOTAS_FOR_ACCOUNT = $516;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No encryption key is available. A well-known encryption key was returned.
  ///  </summary>
  ERROR_LOCAL_USER_SESSION_KEY = $517;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The password is too complex to be converted to a LAN Manager password. The LAN Manager password returned is a NULL string.
  ///  </summary>
  ERROR_NULL_LM_PASSWORD = $518;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The revision level is unknown.
  ///  </summary>
  ERROR_UNKNOWN_REVISION = $519;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Indicates two revision levels are incompatible.
  ///  </summary>
  ERROR_REVISION_MISMATCH = $51A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This security ID may not be assigned as the owner of this object.
  ///  </summary>
  ERROR_INVALID_OWNER = $51B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This security ID may not be assigned as the primary group of an object.
  ///  </summary>
  ERROR_INVALID_PRIMARY_GROUP = $51C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    An attempt has been made to operate on an impersonation token by a thread that is not currently impersonating a client.
  ///  </summary>
  ERROR_NO_IMPERSONATION_TOKEN = $51D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The group may not be disabled.
  ///  </summary>
  ERROR_CANT_DISABLE_MANDATORY = $51E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    There are currently no logon servers available to service the logon request.
  ///  </summary>
  ERROR_NO_LOGON_SERVERS = $51F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A specified logon session does not exist. It may already have been terminated.
  ///  </summary>
  ERROR_NO_SUCH_LOGON_SESSION = $520;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A specified privilege does not exist.
  ///  </summary>
  ERROR_NO_SUCH_PRIVILEGE = $521;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A required privilege is not held by the client.
  ///  </summary>
  ERROR_PRIVILEGE_NOT_HELD = $522;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The name provided is not a properly formed account name.
  ///  </summary>
  ERROR_INVALID_ACCOUNT_NAME = $523;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified account already exists.
  ///  </summary>
  ERROR_USER_EXISTS = $524;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified account does not exist.
  ///  </summary>
  ERROR_NO_SUCH_USER = $525;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified group already exists.
  ///  </summary>
  ERROR_GROUP_EXISTS = $526;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified group does not exist.
  ///  </summary>
  ERROR_NO_SUCH_GROUP = $527;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Either the specified user account is already a member of the specified group, or the specified group cannot be deleted because it contains a member.
  ///  </summary>
  ERROR_MEMBER_IN_GROUP = $528;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified user account is not a member of the specified group account.
  ///  </summary>
  ERROR_MEMBER_NOT_IN_GROUP = $529;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This operation is disallowed as it could result in an administration account being disabled, deleted or unable to log on.
  ///  </summary>
  ERROR_LAST_ADMIN = $52A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unable to update the password. The value provided as the current password is incorrect.
  ///  </summary>
  ERROR_WRONG_PASSWORD = $52B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unable to update the password. The value provided for the new password contains values that are not allowed in passwords.
  ///  </summary>
  ERROR_ILL_FORMED_PASSWORD = $52C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unable to update the password. The value provided for the new password does not meet the length, complexity, or history requirements of the domain.
  ///  </summary>
  ERROR_PASSWORD_RESTRICTION = $52D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The user name or password is incorrect.
  ///  </summary>
  ERROR_LOGON_FAILURE = $52E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Account restrictions are preventing this user from signing in. For example: blank passwords aren't allowed, sign-in times are limited, or a policy restriction has been enforced.
  ///  </summary>
  ERROR_ACCOUNT_RESTRICTION = $52F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Your account has time restrictions that keep you from signing in right now.
  ///  </summary>
  ERROR_INVALID_LOGON_HOURS = $530;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This user isn't allowed to sign in to this computer.
  ///  </summary>
  ERROR_INVALID_WORKSTATION = $531;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The password for this account has expired.
  ///  </summary>
  ERROR_PASSWORD_EXPIRED = $532;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This user can't sign in because this account is currently disabled.
  ///  </summary>
  ERROR_ACCOUNT_DISABLED = $533;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No mapping between account names and security IDs was done.
  ///  </summary>
  ERROR_NONE_MAPPED = $534;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Too many local user identifiers (LUIDs) were requested at one time.
  ///  </summary>
  ERROR_TOO_MANY_LUIDS_REQUESTED = $535;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No more local user identifiers (LUIDs) are available.
  ///  </summary>
  ERROR_LUIDS_EXHAUSTED = $536;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The subauthority part of a security ID is invalid for this particular use.
  ///  </summary>
  ERROR_INVALID_SUB_AUTHORITY = $537;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The access control list (ACL) structure is invalid.
  ///  </summary>
  ERROR_INVALID_ACL = $538;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The security ID structure is invalid.
  ///  </summary>
  ERROR_INVALID_SID = $539;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The security descriptor structure is invalid.
  ///  </summary>
  ERROR_INVALID_SECURITY_DESCR = $53A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The inherited access control list (ACL) or access control entry (ACE) could not be built.
  ///  </summary>
  ERROR_BAD_INHERITANCE_ACL = $53C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The server is currently disabled.
  ///  </summary>
  ERROR_SERVER_DISABLED = $53D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The server is currently enabled.
  ///  </summary>
  ERROR_SERVER_NOT_DISABLED = $53E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The value provided was an invalid value for an identifier authority.
  ///  </summary>
  ERROR_INVALID_ID_AUTHORITY = $53F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No more memory is available for security information updates.
  ///  </summary>
  ERROR_ALLOTTED_SPACE_EXCEEDED = $540;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified attributes are invalid, or incompatible with the attributes for the group as a whole.
  ///  </summary>
  ERROR_INVALID_GROUP_ATTRIBUTES = $541;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Either a required impersonation level was not provided, or the provided impersonation level is invalid.
  ///  </summary>
  ERROR_BAD_IMPERSONATION_LEVEL = $542;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot open an anonymous level security token.
  ///  </summary>
  ERROR_CANT_OPEN_ANONYMOUS = $543;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The validation information class requested was invalid.
  ///  </summary>
  ERROR_BAD_VALIDATION_CLASS = $544;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The type of the token is inappropriate for its attempted use.
  ///  </summary>
  ERROR_BAD_TOKEN_TYPE = $545;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unable to perform a security operation on an object that has no associated security.
  ///  </summary>
  ERROR_NO_SECURITY_ON_OBJECT = $546;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Configuration information could not be read from the domain controller, either because the machine is unavailable, or access has been denied.
  ///  </summary>
  ERROR_CANT_ACCESS_DOMAIN_INFO = $547;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The security account manager (SAM) or local security authority (LSA) server was in the wrong state to perform the security operation.
  ///  </summary>
  ERROR_INVALID_SERVER_STATE = $548;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The domain was in the wrong state to perform the security operation.
  ///  </summary>
  ERROR_INVALID_DOMAIN_STATE = $549;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This operation is only allowed for the Primary Domain Controller of the domain.
  ///  </summary>
  ERROR_INVALID_DOMAIN_ROLE = $54A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified domain either does not exist or could not be contacted.
  ///  </summary>
  ERROR_NO_SUCH_DOMAIN = $54B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified domain already exists.
  ///  </summary>
  ERROR_DOMAIN_EXISTS = $54C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    An attempt was made to exceed the limit on the number of domains per server.
  ///  </summary>
  ERROR_DOMAIN_LIMIT_EXCEEDED = $54D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unable to complete the requested operation because of either a catastrophic media failure or a data structure corruption on the disk.
  ///  </summary>
  ERROR_INTERNAL_DB_CORRUPTION = $54E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    An internal error occurred.
  ///  </summary>
  ERROR_INTERNAL_ERROR = $54F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Generic access types were contained in an access mask which should already be mapped to nongeneric types.
  ///  </summary>
  ERROR_GENERIC_NOT_MAPPED = $550;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A security descriptor is not in the right format (absolute or self-relative).
  ///  </summary>
  ERROR_BAD_DESCRIPTOR_FORMAT = $551;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The requested action is restricted for use by logon processes only. The calling process has not registered as a logon process.
  ///  </summary>
  ERROR_NOT_LOGON_PROCESS = $552;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot start a new logon session with an ID that is already in use.
  ///  </summary>
  ERROR_LOGON_SESSION_EXISTS = $553;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A specified authentication package is unknown.
  ///  </summary>
  ERROR_NO_SUCH_PACKAGE = $554;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The logon session is not in a state that is consistent with the requested operation.
  ///  </summary>
  ERROR_BAD_LOGON_SESSION_STATE = $555;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The logon session ID is already in use.
  ///  </summary>
  ERROR_LOGON_SESSION_COLLISION = $556;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A logon request contained an invalid logon type value.
  ///  </summary>
  ERROR_INVALID_LOGON_TYPE = $557;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unable to impersonate using a named pipe until data has been read from that pipe.
  ///  </summary>
  ERROR_CANNOT_IMPERSONATE = $558;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The transaction state of a registry subtree is incompatible with the requested operation.
  ///  </summary>
  ERROR_RXACT_INVALID_STATE = $559;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    An internal security database corruption has been encountered.
  ///  </summary>
  ERROR_RXACT_COMMIT_FAILURE = $55A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot perform this operation on built-in accounts.
  ///  </summary>
  ERROR_SPECIAL_ACCOUNT = $55B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot perform this operation on this built-in special group.
  ///  </summary>
  ERROR_SPECIAL_GROUP = $55C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot perform this operation on this built-in special user.
  ///  </summary>
  ERROR_SPECIAL_USER = $55D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The user cannot be removed from a group because the group is currently the user's primary group.
  ///  </summary>
  ERROR_MEMBERS_PRIMARY_GROUP = $55E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The token is already in use as a primary token.
  ///  </summary>
  ERROR_TOKEN_ALREADY_IN_USE = $55F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified local group does not exist.
  ///  </summary>
  ERROR_NO_SUCH_ALIAS = $560;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified account name is not a member of the group.
  ///  </summary>
  ERROR_MEMBER_NOT_IN_ALIAS = $561;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified account name is already a member of the group.
  ///  </summary>
  ERROR_MEMBER_IN_ALIAS = $562;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified local group already exists.
  ///  </summary>
  ERROR_ALIAS_EXISTS = $563;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Logon failure: the user has not been granted the requested logon type at this computer.
  ///  </summary>
  ERROR_LOGON_NOT_GRANTED = $564;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The maximum number of secrets that may be stored in a single system has been exceeded.
  ///  </summary>
  ERROR_TOO_MANY_SECRETS = $565;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The length of a secret exceeds the maximum length allowed.
  ///  </summary>
  ERROR_SECRET_TOO_LONG = $566;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The local security authority database contains an internal inconsistency.
  ///  </summary>
  ERROR_INTERNAL_DB_ERROR = $567;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    During a logon attempt, the user's security context accumulated too many security IDs.
  ///  </summary>
  ERROR_TOO_MANY_CONTEXT_IDS = $568;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Logon failure: the user has not been granted the requested logon type at this computer.
  ///  </summary>
  ERROR_LOGON_TYPE_NOT_GRANTED = $569;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A cross-encrypted password is necessary to change a user password.
  ///  </summary>
  ERROR_NT_CROSS_ENCRYPTION_REQUIRED = $56A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A member could not be added to or removed from the local group because the member does not exist.
  ///  </summary>
  ERROR_NO_SUCH_MEMBER = $56B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A new member could not be added to a local group because the member has the wrong account type.
  ///  </summary>
  ERROR_INVALID_MEMBER = $56C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Too many security IDs have been specified.
  ///  </summary>
  ERROR_TOO_MANY_SIDS = $56D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A cross-encrypted password is necessary to change this user password.
  ///  </summary>
  ERROR_LM_CROSS_ENCRYPTION_REQUIRED = $56E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Indicates an ACL contains no inheritable components.
  ///  </summary>
  ERROR_NO_INHERITANCE = $56F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The file or directory is corrupted and unreadable.
  ///  </summary>
  ERROR_FILE_CORRUPT = $570;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The disk structure is corrupted and unreadable.
  ///  </summary>
  ERROR_DISK_CORRUPT = $571;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    There is no user session key for the specified logon session.
  ///  </summary>
  ERROR_NO_USER_SESSION_KEY = $572;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The service being accessed is licensed for a particular number of connections. No more connections can be made to the service at this time because there are already as many connections as the service can accept.
  ///  </summary>
  ERROR_LICENSE_QUOTA_EXCEEDED = $573;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The target account name is incorrect.
  ///  </summary>
  ERROR_WRONG_TARGET_NAME = $574;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Mutual Authentication failed. The server's password is out of date at the domain controller.
  ///  </summary>
  ERROR_MUTUAL_AUTH_FAILED = $575;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    There is a time and/or date difference between the client and server.
  ///  </summary>
  ERROR_TIME_SKEW = $576;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This operation cannot be performed on the current domain.
  ///  </summary>
  ERROR_CURRENT_DOMAIN_NOT_ALLOWED = $577;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid window handle.
  ///  </summary>
  ERROR_INVALID_WINDOW_HANDLE = $578;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid menu handle.
  ///  </summary>
  ERROR_INVALID_MENU_HANDLE = $579;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid cursor handle.
  ///  </summary>
  ERROR_INVALID_CURSOR_HANDLE = $57A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid accelerator table handle.
  ///  </summary>
  ERROR_INVALID_ACCEL_HANDLE = $57B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid hook handle.
  ///  </summary>
  ERROR_INVALID_HOOK_HANDLE = $57C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid handle to a multiple-window position structure.
  ///  </summary>
  ERROR_INVALID_DWP_HANDLE = $57D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot create a top-level child window.
  ///  </summary>
  ERROR_TLW_WITH_WSCHILD = $57E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot find window class.
  ///  </summary>
  ERROR_CANNOT_FIND_WND_CLASS = $57F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid window; it belongs to other thread.
  ///  </summary>
  ERROR_WINDOW_OF_OTHER_THREAD = $580;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Hot key is already registered.
  ///  </summary>
  ERROR_HOTKEY_ALREADY_REGISTERED = $581;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Class already exists.
  ///  </summary>
  ERROR_CLASS_ALREADY_EXISTS = $582;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Class does not exist.
  ///  </summary>
  ERROR_CLASS_DOES_NOT_EXIST = $583;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Class still has open windows.
  ///  </summary>
  ERROR_CLASS_HAS_WINDOWS = $584;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid index.
  ///  </summary>
  ERROR_INVALID_INDEX = $585;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid icon handle.
  ///  </summary>
  ERROR_INVALID_ICON_HANDLE = $586;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Using private DIALOG window words.
  ///  </summary>
  ERROR_PRIVATE_DIALOG_INDEX = $587;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The list box identifier was not found.
  ///  </summary>
  ERROR_LISTBOX_ID_NOT_FOUND = $588;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No wildcards were found.
  ///  </summary>
  ERROR_NO_WILDCARD_CHARACTERS = $589;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Thread does not have a clipboard open.
  ///  </summary>
  ERROR_CLIPBOARD_NOT_OPEN = $58A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Hot key is not registered.
  ///  </summary>
  ERROR_HOTKEY_NOT_REGISTERED = $58B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The window is not a valid dialog window.
  ///  </summary>
  ERROR_WINDOW_NOT_DIALOG = $58C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Control ID not found.
  ///  </summary>
  ERROR_CONTROL_ID_NOT_FOUND = $58D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid message for a combo box because it does not have an edit control.
  ///  </summary>
  ERROR_INVALID_COMBOBOX_MESSAGE = $58E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The window is not a combo box.
  ///  </summary>
  ERROR_WINDOW_NOT_COMBOBOX = $58F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Height must be less than 256.
  ///  </summary>
  ERROR_INVALID_EDIT_HEIGHT = $590;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid device context (DC) handle.
  ///  </summary>
  ERROR_DC_NOT_FOUND = $591;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid hook procedure type.
  ///  </summary>
  ERROR_INVALID_HOOK_FILTER = $592;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid hook procedure.
  ///  </summary>
  ERROR_INVALID_FILTER_PROC = $593;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot set nonlocal hook without a module handle.
  ///  </summary>
  ERROR_HOOK_NEEDS_HMOD = $594;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This hook procedure can only be set globally.
  ///  </summary>
  ERROR_GLOBAL_ONLY_HOOK = $595;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The journal hook procedure is already installed.
  ///  </summary>
  ERROR_JOURNAL_HOOK_SET = $596;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The hook procedure is not installed.
  ///  </summary>
  ERROR_HOOK_NOT_INSTALLED = $597;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid message for single-selection list box.
  ///  </summary>
  ERROR_INVALID_LB_MESSAGE = $598;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    LB_SETCOUNT sent to non-lazy list box.
  ///  </summary>
  ERROR_SETCOUNT_ON_BAD_LB = $599;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This list box does not support tab stops.
  ///  </summary>
  ERROR_LB_WITHOUT_TABSTOPS = $59A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot destroy object created by another thread.
  ///  </summary>
  ERROR_DESTROY_OBJECT_OF_OTHER_THREAD = $59B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Child windows cannot have menus.
  ///  </summary>
  ERROR_CHILD_WINDOW_MENU = $59C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The window does not have a system menu.
  ///  </summary>
  ERROR_NO_SYSTEM_MENU = $59D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid message box style.
  ///  </summary>
  ERROR_INVALID_MSGBOX_STYLE = $59E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid system-wide (SPI_*) parameter.
  ///  </summary>
  ERROR_INVALID_SPI_VALUE = $59F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Screen already locked.
  ///  </summary>
  ERROR_SCREEN_ALREADY_LOCKED = $5A0;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    All handles to windows in a multiple-window position structure must have the same parent.
  ///  </summary>
  ERROR_HWNDS_HAVE_DIFF_PARENT = $5A1;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The window is not a child window.
  ///  </summary>
  ERROR_NOT_CHILD_WINDOW = $5A2;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid GW_* command.
  ///  </summary>
  ERROR_INVALID_GW_COMMAND = $5A3;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid thread identifier.
  ///  </summary>
  ERROR_INVALID_THREAD_ID = $5A4;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot process a message from a window that is not a multiple document interface (MDI) window.
  ///  </summary>
  ERROR_NON_MDICHILD_WINDOW = $5A5;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Popup menu already active.
  ///  </summary>
  ERROR_POPUP_ALREADY_ACTIVE = $5A6;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The window does not have scroll bars.
  ///  </summary>
  ERROR_NO_SCROLLBARS = $5A7;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Scroll bar range cannot be greater than MAXLONG.
  ///  </summary>
  ERROR_INVALID_SCROLLBAR_RANGE = $5A8;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Cannot show or remove the window in the way specified.
  ///  </summary>
  ERROR_INVALID_SHOWWIN_COMMAND = $5A9;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Insufficient system resources exist to complete the requested service.
  ///  </summary>
  ERROR_NO_SYSTEM_RESOURCES = $5AA;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Insufficient system resources exist to complete the requested service.
  ///  </summary>
  ERROR_NONPAGED_SYSTEM_RESOURCES = $5AB;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Insufficient system resources exist to complete the requested service.
  ///  </summary>
  ERROR_PAGED_SYSTEM_RESOURCES = $5AC;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Insufficient quota to complete the requested service.
  ///  </summary>
  ERROR_WORKING_SET_QUOTA = $5AD;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Insufficient quota to complete the requested service.
  ///  </summary>
  ERROR_PAGEFILE_QUOTA = $5AE;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The paging file is too small for this operation to complete.
  ///  </summary>
  ERROR_COMMITMENT_LIMIT = $5AF;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A menu item was not found.
  ///  </summary>
  ERROR_MENU_ITEM_NOT_FOUND = $5B0;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid keyboard layout handle.
  ///  </summary>
  ERROR_INVALID_KEYBOARD_HANDLE = $5B1;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Hook type not allowed.
  ///  </summary>
  ERROR_HOOK_TYPE_NOT_ALLOWED = $5B2;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This operation requires an interactive window station.
  ///  </summary>
  ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION = $5B3;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This operation returned because the timeout period expired.
  ///  </summary>
  ERROR_TIMEOUT = $5B4;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid monitor handle.
  ///  </summary>
  ERROR_INVALID_MONITOR_HANDLE = $5B5;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Incorrect size argument.
  ///  </summary>
  ERROR_INCORRECT_SIZE = $5B6;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The symbolic link cannot be followed because its type is disabled.
  ///  </summary>
  ERROR_SYMLINK_CLASS_DISABLED = $5B7;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This application does not support the current operation on symbolic links.
  ///  </summary>
  ERROR_SYMLINK_NOT_SUPPORTED = $5B8;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Windows was unable to parse the requested XML data.
  ///  </summary>
  ERROR_XML_PARSE_ERROR = $5B9;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    An error was encountered while processing an XML digital signature.
  ///  </summary>
  ERROR_XMLDSIG_ERROR = $5BA;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This application must be restarted.
  ///  </summary>
  ERROR_RESTART_APPLICATION = $5BB;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The caller made the connection request in the wrong routing compartment.
  ///  </summary>
  ERROR_WRONG_COMPARTMENT = $5BC;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    There was an AuthIP failure when attempting to connect to the remote host.
  ///  </summary>
  ERROR_AUTHIP_FAILURE = $5BD;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Insufficient NVRAM resources exist to complete the requested service. A reboot might be required.
  ///  </summary>
  ERROR_NO_NVRAM_RESOURCES = $5BE;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unable to finish the requested operation because the specified process is not a GUI process.
  ///  </summary>
  ERROR_NOT_GUI_PROCESS = $5BF;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The event log file is corrupted.
  ///  </summary>
  ERROR_EVENTLOG_FILE_CORRUPT = $5DC;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No event log file could be opened, so the event logging service did not start.
  ///  </summary>
  ERROR_EVENTLOG_CANT_START = $5DD;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The event log file is full.
  ///  </summary>
  ERROR_LOG_FILE_FULL = $5DE;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The event log file has changed between read operations.
  ///  </summary>
  ERROR_EVENTLOG_FILE_CHANGED = $5DF;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified task name is invalid.
  ///  </summary>
  ERROR_INVALID_TASK_NAME = $60E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified task index is invalid.
  ///  </summary>
  ERROR_INVALID_TASK_INDEX = $60F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The specified thread is already joining a task.
  ///  </summary>
  ERROR_THREAD_ALREADY_IN_TASK = $610;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The Windows Installer Service could not be accessed. This can occur if the Windows Installer is not correctly installed. Contact your support personnel for assistance.
  ///  </summary>
  ERROR_INSTALL_SERVICE_FAILURE = $641;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    User cancelled installation.
  ///  </summary>
  ERROR_INSTALL_USEREXIT = $642;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Fatal error during installation.
  ///  </summary>
  ERROR_INSTALL_FAILURE = $643;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Installation suspended, incomplete.
  ///  </summary>
  ERROR_INSTALL_SUSPEND = $644;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This action is only valid for products that are currently installed.
  ///  </summary>
  ERROR_UNKNOWN_PRODUCT = $645;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Feature ID not registered.
  ///  </summary>
  ERROR_UNKNOWN_FEATURE = $646;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Component ID not registered.
  ///  </summary>
  ERROR_UNKNOWN_COMPONENT = $647;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Unknown property.
  ///  </summary>
  ERROR_UNKNOWN_PROPERTY = $648;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Handle is in an invalid state.
  ///  </summary>
  ERROR_INVALID_HANDLE_STATE = $649;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The configuration data for this product is corrupt. Contact your support personnel.
  ///  </summary>
  ERROR_BAD_CONFIGURATION = $64A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Component qualifier not present.
  ///  </summary>
  ERROR_INDEX_ABSENT = $64B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The installation source for this product is not available. Verify that the source exists and that you can access it.
  ///  </summary>
  ERROR_INSTALL_SOURCE_ABSENT = $64C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This installation package cannot be installed by the Windows Installer service. You must install a Windows service pack that contains a newer version of the Windows Installer service.
  ///  </summary>
  ERROR_INSTALL_PACKAGE_VERSION = $64D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Product is uninstalled.
  ///  </summary>
  ERROR_PRODUCT_UNINSTALLED = $64E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    SQL query syntax invalid or unsupported.
  ///  </summary>
  ERROR_BAD_QUERY_SYNTAX = $64F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Record field does not exist.
  ///  </summary>
  ERROR_INVALID_FIELD = $650;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The device has been removed.
  ///  </summary>
  ERROR_DEVICE_REMOVED = $651;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Another installation is already in progress. Complete that installation before proceeding with this install.
  ///  </summary>
  ERROR_INSTALL_ALREADY_RUNNING = $652;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This installation package could not be opened. Verify that the package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer package.
  ///  </summary>
  ERROR_INSTALL_PACKAGE_OPEN_FAILED = $653;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This installation package could not be opened. Contact the application vendor to verify that this is a valid Windows Installer package.
  ///  </summary>
  ERROR_INSTALL_PACKAGE_INVALID = $654;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    There was an error starting the Windows Installer service user interface. Contact your support personnel.
  ///  </summary>
  ERROR_INSTALL_UI_FAILURE = $655;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Error opening installation log file. Verify that the specified log file location exists and that you can write to it.
  ///  </summary>
  ERROR_INSTALL_LOG_FAILURE = $656;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The language of this installation package is not supported by your system.
  ///  </summary>
  ERROR_INSTALL_LANGUAGE_UNSUPPORTED = $657;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Error applying transforms. Verify that the specified transform paths are valid.
  ///  </summary>
  ERROR_INSTALL_TRANSFORM_FAILURE = $658;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This installation is forbidden by system policy. Contact your system administrator.
  ///  </summary>
  ERROR_INSTALL_PACKAGE_REJECTED = $659;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Function could not be executed.
  ///  </summary>
  ERROR_FUNCTION_NOT_CALLED = $65A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Function failed during execution.
  ///  </summary>
  ERROR_FUNCTION_FAILED = $65B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid or unknown table specified.
  ///  </summary>
  ERROR_INVALID_TABLE = $65C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Data supplied is of wrong type.
  ///  </summary>
  ERROR_DATATYPE_MISMATCH = $65D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Data of this type is not supported.
  ///  </summary>
  ERROR_UNSUPPORTED_TYPE = $65E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The Windows Installer service failed to start. Contact your support personnel.
  ///  </summary>
  ERROR_CREATE_FAILED = $65F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The Temp folder is on a drive that is full or is inaccessible. Free up space on the drive or verify that you have write permission on the Temp folder.
  ///  </summary>
  ERROR_INSTALL_TEMP_UNWRITABLE = $660;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This installation package is not supported by this processor type. Contact your product vendor.
  ///  </summary>
  ERROR_INSTALL_PLATFORM_UNSUPPORTED = $661;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Component not used on this computer.
  ///  </summary>
  ERROR_INSTALL_NOTUSED = $662;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This update package could not be opened. Verify that the update package exists and that you can access it, or contact the application vendor to verify that this is a valid Windows Installer update package.
  ///  </summary>
  ERROR_PATCH_PACKAGE_OPEN_FAILED = $663;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This update package could not be opened. Contact the application vendor to verify that this is a valid Windows Installer update package.
  ///  </summary>
  ERROR_PATCH_PACKAGE_INVALID = $664;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    This update package cannot be processed by the Windows Installer service. You must install a Windows service pack that contains a newer version of the Windows Installer service.
  ///  </summary>
  ERROR_PATCH_PACKAGE_UNSUPPORTED = $665;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Another version of this product is already installed. Installation of this version cannot continue. To configure or remove the existing version of this product, use Add/Remove Programs on the Control Panel.
  ///  </summary>
  ERROR_PRODUCT_VERSION = $666;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Invalid command line argument. Consult the Windows Installer SDK for detailed command line help.
  ///  </summary>
  ERROR_INVALID_COMMAND_LINE = $667;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Only administrators have permission to add, remove, or configure server software during a Terminal services remote session. If you want to install or configure software on the server, contact your network administrator.
  ///  </summary>
  ERROR_INSTALL_REMOTE_DISALLOWED = $668;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The requested operation completed successfully. The system will be restarted so the changes can take effect.
  ///  </summary>
  ERROR_SUCCESS_REBOOT_INITIATED = $669;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The upgrade cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade.
  ///  </summary>
  ERROR_PATCH_TARGET_NOT_FOUND = $66A;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The update package is not permitted by software restriction policy.
  ///  </summary>
  ERROR_PATCH_PACKAGE_REJECTED = $66B;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    One or more customizations are not permitted by software restriction policy.
  ///  </summary>
  ERROR_INSTALL_TRANSFORM_REJECTED = $66C;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The Windows Installer does not permit installation from a Remote Desktop Connection.
  ///  </summary>
  ERROR_INSTALL_REMOTE_PROHIBITED = $66D;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Uninstallation of the update package is not supported.
  ///  </summary>
  ERROR_PATCH_REMOVAL_UNSUPPORTED = $66E;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The update is not applied to this product.
  ///  </summary>
  ERROR_UNKNOWN_PATCH = $66F;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    No valid sequence could be found for the set of updates.
  ///  </summary>
  ERROR_PATCH_NO_SEQUENCE = $670;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Update removal was disallowed by policy.
  ///  </summary>
  ERROR_PATCH_REMOVAL_DISALLOWED = $671;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The XML update data is invalid.
  ///  </summary>
  ERROR_INVALID_PATCH_XML = $672;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    Windows Installer does not permit updating of managed advertised products. At least one feature of the product must be installed before applying the update.
  ///  </summary>
  ERROR_PATCH_MANAGED_ADVERTISED_PRODUCT = $673;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The Windows Installer service is not accessible in Safe Mode. Please try again when your computer is not in Safe Mode or you can use System Restore to return your machine to a previous good state.
  ///  </summary>
  ERROR_INSTALL_SERVICE_SAFEBOOT = $674;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    A fail fast exception occurred. Exception handlers will not be invoked and the process will be terminated immediately.
  ///  </summary>
  ERROR_FAIL_FAST_EXCEPTION = $675;
  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/debug/system-error-codes--1300-1699-
  ///    The app that you are trying to run is not supported on this version of Windows.
  ///  </summary>
  ERROR_INSTALL_REJECTED = $676;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getwindowlonga
  ///  </summary>
  GWL_EXSTYLE = -20;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getwindowlonga
  ///  </summary>
  GWL_HINSTANCE = -6;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getwindowlonga
  ///  </summary>
  GWL_HWNDPARENT = -8;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getwindowlonga
  ///  </summary>
  GWL_ID = -12;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getwindowlonga
  ///  </summary>
  GWL_STYLE = -16;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getwindowlonga
  ///  </summary>
  GWL_USERDATA = -21;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getwindowlonga
  ///  </summary>
  GWL_WNDPROC = -4;


  KEY_ALL_ACCESS = $f003f;
  KEY_CREATE_LINK = 32;
  KEY_CREATE_SUB_KEY = 4;
  KEY_ENUMERATE_SUB_KEYS = 8;
  KEY_EXECUTE = $20019;
  KEY_NOTIFY = 16;
  KEY_QUERY_VALUE = 1;
  KEY_READ = $20019;
  KEY_SET_VALUE = 2;
  KEY_WOW64_64KEY = $0100;
  KEY_WOW64_32KEY = $0200;
  KEY_WRITE = $20006;
  HKEY_CLASSES_ROOT = nativeuint($80000000);
  HKEY_CURRENT_USER = nativeuint($80000001);
  HKEY_LOCAL_MACHINE = nativeuint($80000002);
  HKEY_USERS = nativeuint($80000003);
  HKEY_PERFORMANCE_DATA = nativeuint($80000004);
  HKEY_CURRENT_CONFIG = nativeuint($80000005);
  HKEY_DYN_DATA = nativeuint($80000006);


implementation

end.

