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
unit cwWin32.Types;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef MSWINDOWS}
uses
  cwWin32.Constants
;

type
  DWORD         = uint32;
  PDWORD        = ^DWORD;
  LPDWORD       = ^DWORD;
  DWORD_PTR     = Longword;
  UINT          = uint32;
  PUINT         = ^uint32;
  LPUINT        = ^uint32;
  LONG          = int32;
  Longint       = int32;
  BOOL          = Boolean;
  LPCSTR        = PAnsiChar;
  LPSTR         = PAnsiChar;
  LPWSTR        = PWideChar;
  LPCWSTR       = PWideChar;
  SHORT         = Smallint;
  USHORT        = WORD;
  LCID          = DWORD;
  LCTYPE        = DWORD;
  ULONG_PTR     = Longword;
  LONG_PTR      = Longint;
  LPVOID        = pointer;
  PBool         = ^BOOL;
  LPBYTE        = ^BYTE;
  CALID         = DWORD;
  CALTYPE       = DWORD;
  PLargeInteger = ^int64;
  LANGID        = WORD;
  PLANGID       = ^LANGID;
  SIZE_T        = ULONG_PTR;
  HDEVNOTIFY    = Pointer;
  UINT_PTR      = ^uint32;
  va_list       = PAnsiChar;
  PDesignVector = Pointer;
  FLOAT         = Single;
  COLORREF      = DWORD;
  LCSCSTYPE     = LONG;
  LCSGAMUTMATCH = LONG;
  FXPT2DOT30    = Longint;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa383751(v=vs.85).aspx
  ///  </summary>
  THandle              = nativeuint;
  THKL                 = THandle;
  THDWP                = THandle;
  THDC                 = THandle;
  THWND                = THandle;
  THMenu               = THandle;
  THInstance           = THandle;
  THIcon               = THandle;
  THCursor             = THandle;
  THBrush              = THandle;
  THFont               = THandle;
  THHOOK               = THandle;
  THDESK               = THandle;
  THWINSTA             = THandle;
  THACCEL              = THandle;
  THBITMAP             = THandle;
  THConv               = THandle;
  THDDEData            = THandle;
  THSZ                 = THandle;
  THConvList           = THandle;
  THINST               = THandle;
  THLocal              = THandle;
  THFILE               = THandle;
  THRGN                = THandle;
  THWINEVENTHOOK       = THandle;
  THPALETTE            = THandle;
  THMETAFILE           = THandle;
  THENHMETAFILE        = THandle;
  THPEN                = THandle;
  THCOLORSPACE         = THandle;
  THGDIOBJ             = THandle;
  TServiceStatusHandle = THandle;
  THRSRC               = THandle;
  THMONITOR            = THandle;
  PHandle              = ^THandle;
  PHandleArray         = ^THandle;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648029(v=vs.85).aspx
  ///  </summary>
  TMakeIntResource = pWideChar;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa383751(v=vs.85).aspx
  ///  </summary>
  THModule = NativeUInt;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa383751(v=vs.85).aspx
  ///  </summary>
  TAtom = uint16;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162805(v=vs.85).aspx
  ///  </summary>
  TPoint = record
     x: int32;
     y: int32;
  end;
  PPoint = ^TPoint;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa383751(v=vs.85).aspx
  ///  </summary>
  TWParam = NativeUInt;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa383751(v=vs.85).aspx
  ///  </summary
  TLParam = NativeInt;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa383751(v=vs.85).aspx
  ///  </summary>
  TLResult = NativeInt;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363214(v=vs.85).aspx
  ///  </summary>
  TDCB = record
    DCBlength:         DWORD;
    BaudRate:          DWORD;
    fBinary:           DWORD;
    fParity:           DWORD;
    fOutxCtsFlow:      DWORD;
    fOutxDsrFlow:      DWORD;
    fDtrControl:       DWORD;
    fDsrSensitivity:   DWORD;
    fTXContinueOnXoff: DWORD;
    fOutX:             DWORD;
    fInX:              DWORD;
    fErrorChar:        DWORD;
    fNull:             DWORD;
    fRtsControl:       DWORD;
    fAbortOnError:     DWORD;
    fDummy2:           DWORD;
    wReserved:         WORD;
    XonLim:            WORD;
    XoffLim:           WORD;
    ByteSize:          BYTE;
    Parity:            BYTE;
    StopBits:          BYTE;
    XonChar:           uint8;
    XoffChar:          uint8;
    ErrorChar:         uint8;
    EofChar:           uint8;
    EvtChar:           uint8;
    wReserved1:        WORD;
  end;
  PDCB = ^TDCB;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms644958(v=vs.85).aspx
  ///  </summary>
  TMsg = record
    hwnd: NativeUInt;
    message: DWORD;
    wParam: TWParam;
    lParam: TLParam;
    time: uint32;
    pt: TPoint;
  end;
  pMsg = ^TMsg;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa383713(v=vs.85).aspx
  ///  </summary>
  TLargeInteger = int64;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633573(v=vs.85).aspx
  ///  </summary>
  TWndProc = function( hWnd: THWnd; uMsg: uint32; wParam: TwParam; lParam: TlParam ): TLResult; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms645469(v=vs.85).aspx
  ///  </summary>
  TDlgProc = function( hwndDlg: THWND; wMsg: UINT; wParam: TWPARAM; lParam: TLPARAM): nativeint; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162497(v=vs.85).aspx
  ///  </summary>
  TDrawStateProc = function(hdc: THDC; lData: TLPARAM; wData: TWPARAM; cx, cy: Integer): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648742(v=vs.85).aspx
  ///  </summary>
  TDDECallback = function( uType: uint; uFmt: uint; hconv: THConv; hsz1, hsz2: THSZ; hdata: THDDEDATA; dwData1, dwData2: pointer ):THDDEData; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363854(v=vs.85).aspx
  ///  </summary>
  TCopyProgressRoutine = function( TotalFileSize: TLargeInteger; TotalBytesTransferred: TLargeInteger; StreamSize: TLargeInteger; StreamBytesTransferred: TLargeInteger; dwStreamNumber: DWORD; dwCallbackReason: DWORD; hSourceFile: THANDLE; hDestinationFile: THANDLE; lpData: LPVOID): DWORD; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682660(v=vs.85).aspx
  ///  </summary>
  TFiberProc = procedure(lpFiberParameter: LPVOID); stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms686736(v=vs.85).aspx
  ///  </summary>
  TThreadProc = function( lpParameter: LPVOID ): DWORD; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317806(v=vs.85).aspx
  ///  </summary>
  TCalInfoEnumProcA = function(lpCalendarInfoString: LPSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317806(v=vs.85).aspx
  ///  </summary>
  TCalInfoEnumProcW = function(lpCalendarInfoString: LPWSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317813(v=vs.85).aspx
  ///  </summary>
  TDateFmtEnumProcA = function(lpDateFormatString: LPSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317813(v=vs.85).aspx
  ///  </summary>
  TDateFmtEnumProcW = function(lpDateFormatString: LPWSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648033(v=vs.85).aspx
  ///  </summary>
  TEnumResLangProcA = function(hModule: HMODULE; lpType, lpName: LPCSTR; wLanguage: WORD; lParam: LONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648033(v=vs.85).aspx
  ///  </summary>
  TEnumResLangProcW = function(hModule: HMODULE; lpType, lpName: LPCWSTR; wLanguage: WORD; lParam: LONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648034(v=vs.85).aspx
  ///  </summary>
  TEnumResNameProcA = function(hModule: HMODULE; lpType: LPCSTR; lpName: LPSTR; lParam: LONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648034(v=vs.85).aspx
  ///  </summary>
  TEnumResNameProcW = function(hModule: HMODULE; lpType: LPCWSTR; lpName: LPWSTR; lParam: LONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648041(v=vs.85).aspx
  ///  </summary>
  TEnumResTypeProcA = function(hModule: HMODULE; lpType: LPSTR; lParam: LONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648041(v=vs.85).aspx
  ///  </summary>
  TEnumResTypeProcW = function(hModule: HMODULE; lpType: LPWSTR; lParam: LONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317809(v=vs.85).aspx
  ///  </summary>
  TEnumCodePageProcA = function(lpCodePAgeString: LPSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317809(v=vs.85).aspx
  ///  </summary>
  TEnumCodePageProcW = function(lpCodePAgeString: LPWSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317822(v=vs.85).aspx
  ///  </summary>
  TEnumLocaleProcA = function(lpLocaleString: LPSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317822(v=vs.85).aspx
  ///  </summary>
  TEnumLocaleProcW = function(lpLocaleString: LPWSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317832(v=vs.85).aspx
  ///  </summary>
  TEnumTimeFmtProcA = function(lpTimeFormatString: LPSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317832(v=vs.85).aspx
  ///  </summary>
  TEnumTimeFmtProcW = function(lpTimeFormatString: LPWSTR): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms681947(v=vs.85).aspx
  ///  </summary>
  TAPCProc = procedure(dwParam: ULONG_PTR); stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683242(v=vs.85).aspx
  ///  </summary>
  THandlerRoutine = function(CtrlType: DWORD): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724950(v=vs.85).aspx
  ///  </summary>
  TSystemTime = record
    wYear: WORD;
    wMonth: WORD;
    wDayOfWeek: WORD;
    wDay: WORD;
    wHour: WORD;
    wMinute: WORD;
    wSecond: WORD;
    wMilliseconds: WORD;
  end;
  PSystemTime = ^TSystemTime;

  ///  <summary>
  ///    Critical Section structres.
  ///  </summary>
  PLIST_ENTRY = ^TLIST_ENTRY;
  TLIST_ENTRY = record
    Flink: PLIST_ENTRY;
    Blink: PLIST_ENTRY;
  end;
  PRTL_CRITICAL_SECTION_DEBUG = ^TRTL_CRITICAL_SECTION_DEBUG;
  TRTL_CRITICAL_SECTION_DEBUG = record
    _Type: WORD;
    CreatorBackTraceIndex: WORD;
    CriticalSection: PRTL_CRITICAL_SECTION_DEBUG;
    ProcessLocksList: TLIST_ENTRY;
    EntryCount: DWORD;
    ContentionCount: DWORD;
    Spare: array [0..1] of DWORD;
  end;
  TRTL_CRITICAL_SECTION = record
    DebugInfo: PRTL_CRITICAL_SECTION_DEBUG;
    LockCount: LONG;
    RecursionCount: LONG;
    OwningThread: THANDLE;        // from the thread's ClientId->UniqueThread
    LockSemaphore: THANDLE;
    SpinCount: ULONG_PTR;        // force size on 64-bit systems when packed
  end;
  PRTL_CRITICAL_SECTION = ^TRTL_CRITICAL_SECTION;
  TRTLCriticalSection = TRTL_CRITICAL_SECTION;


  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms686331(v=vs.85).aspx
  ///  </summary>
  TStartupInfoA = record
    cb: DWORD;
    lpReserved: LPSTR;
    lpDesktop: LPSTR;
    lpTitle: LPSTR;
    dwX: DWORD;
    dwY: DWORD;
    dwXSize: DWORD;
    dwYSize: DWORD;
    dwXCountChars: DWORD;
    dwYCountChars: DWORD;
    dwFillAttribute: DWORD;
    dwFlags: DWORD;
    wShowWindow: WORD;
    cbReserved2: WORD;
    lpReserved2: LPBYTE;
    hStdInput: THANDLE;
    hStdOutput: THANDLE;
    hStdError: THANDLE;
  end;
  PStartupInfoA = ^TStartupInfoA;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms686331(v=vs.85).aspx
  ///  </summary>
  TStartupInfoW = record
    cb: DWORD;
    lpReserved: LPWSTR;
    lpDesktop: LPWSTR;
    lpTitle: LPWSTR;
    dwX: DWORD;
    dwY: DWORD;
    dwXSize: DWORD;
    dwYSize: DWORD;
    dwXCountChars: DWORD;
    dwYCountChars: DWORD;
    dwFillAttribute: DWORD;
    dwFlags: DWORD;
    wShowWindow: WORD;
    cbReserved2: WORD;
    lpReserved2: LPBYTE;
    hStdInput: THANDLE;
    hStdOutput: THANDLE;
    hStdError: THANDLE;
  end;
  PStartupInfoW = ^TStartupInfoW;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633576(v=vs.85).aspx
  ///  </summary>
  TWndClassA = record
    Style: uint32;
    lpfnWndProc: TWndProc;
    cbClsExtra: int32;
    cbWndExtra: int32;
    hInstance: THInstance;
    hIcon: THIcon;
    hCursor: THCursor;
    hbrBackground: THBrush;
    lpszMenuName: LPCSTR;
    lpszClassName: LPCSTR;
  end;
  pWndClassA = ^TWndClassA;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633576(v=vs.85).aspx
  ///  </summary>
  TWndClassW = record
    style: UINT;
    lpfnWndProc: TWndProc;
    cbClsExtra: int32;
    cbWndExtra: int32;
    hInstance: THInstance;
    hIcon: THIcon;
    hCursor: THCursor;
    hbrBackground: THBrush;
    lpszMenuName: LPCWSTR;
    lpszClassName: LPCWSTR;
  end;
  pWndClassW = ^TWndClassW;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633577(v=vs.85).aspx
  ///  </summary>
  TWndClassExA = record
    cbSize: UINT;
    style: UINT;
    lpfnWndProc: TWndProc;
    cbClsExtra: int32;
    cbWndExtra: int32;
    hInstance: THInstance;
    hIcon: THIcon;
    hCursor: THCursor;
    hbrBackground: THBrush;
    lpszMenuName: LPCSTR;
    lpszClassName: LPCSTR;
    hIconSm: THIcon;
  end;
  pWndClassExA = ^TWndClassExA;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633577(v=vs.85).aspx
  ///  </summary>
  TWndClassExW = record
    cbSize: UINT;
    style: UINT;
    lpfnWndProc: TWNDPROC;
    cbClsExtra: Integer;
    cbWndExtra: Integer;
    hInstance: THInstance;
    hIcon: THIcon;
    hCursor: THCursor;
    hbrBackground: THBrush;
    lpszMenuName: LPCWSTR;
    lpszClassName: LPCWSTR;
    hIconSm: THIcon;
  end;
  pWndClassExW = ^TWndClassExW;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162897(v=vs.85).aspx
  ///  </summary>
  TRECT = record
    left: LONG;
    top: LONG;
    right: LONG;
    bottom: LONG;
  end;
  pRect = ^TRECT;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/bb775939(v=vs.85).aspx
  ///  </summary>
  TComboBoxInfo = record
    cbSize: DWORD;
    rcItem: TRect;
    rcButton: TRect;
    stateButton: DWORD;
    hwndCombo: THWND;
    hwndItem: THWND;
    hwndList: THWND;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms686311(v=vs.85).aspx
  ///  </summary>
  TSmallRect = record
    Left: SHORT;
    Top: SHORT;
    Right: SHORT;
    Bottom: SHORT;
  end;
  PSmallRect = ^TSmallRect;

  TIconInfo = record
    fIcon: BOOL;
    xHotspot: DWORD;
    yHotspot: DWORD;
    hbmMask: THBITMAP;
    hbmColor: THBITMAP;
  end;
  PIconInfo = ^TIconInfo;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162768(v=vs.85).aspx
  ///  </summary>
  TPaintStruct = record
    hdc: THDC;
    fErase: boolean;
    rcPaint: TRECT;
    fRestore: boolean;
    fIncUpdate: boolean;
    rgbReserved: array[0..31] of uint8;
  end;
  pPaintStruct = ^TPaintStruct;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa379574(v=vs.85).aspx
  ///    Need accurate values?
  ///  </summary>
  TSECURITY_CONTEXT_TRACKING_MODE = (
    SECURITY_STATIC_TRACKING,
    SECURITY_DYNAMIC_TRACKING
  );

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa379572(v=vs.85).aspx
  ///    Need accurate values?
  ///  </summary>
  TSECURITY_IMPERSONATION_LEVEL = (SecurityAnonymous, SecurityIdentification, SecurityImpersonation, SecurityDelegation);

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa379574(v=vs.85).aspx
  ///  </summary>
  TSECURITY_QUALITY_OF_SERVICE = record
    Length: DWORD;
    ImpersonationLevel: TSECURITY_IMPERSONATION_LEVEL;
    ContextTrackingMode: TSECURITY_CONTEXT_TRACKING_MODE;
    EffectiveOnly: Boolean;
  end;
  PSECURITY_QUALITY_OF_SERVICE = ^TSECURITY_QUALITY_OF_SERVICE;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648730(v=vs.85).aspx
  ///  </summary>
  TConvContext = record
    cb: UINT;
    wFlags: UINT;
    wCountryID: UINT;
    iCodePage: int32;
    dwLangID: DWORD;
    dwSecurity: DWORD;
    qos: TSECURITY_QUALITY_OF_SERVICE;
  end;
  pConvContext = ^TConvContext;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145196(v=vs.85).aspx
  ///  </summary>
  TVideoParameters = record
    guid: TGUID;// = ['{02C62061-1097-11d1-920F-00A024DF156E}'];
    dwOffset: uint32;
    dwCommand: uint32;
    dwFlags: uint32;
    dwMode: uint32;
    dwTVStandard: uint32;
    dwAvailableModes: uint32;
    dwAvailableTVStandard: uint32;
    dwFlickerFilter: uint32;
    dwOverScanX: uint32;
    dwOverScanY: uint32;
    dwMaxUnscaledX: uint32;
    dwMaxUnscaledY: uint32;
    dwPositionX: uint32;
    dwPositionY: uint32;
    dwBrightness: uint32;
    dwContrast: uint32;
    dwCPType: uint32;
    dwCPCommand: uint32;
    dwCPStandard: uint32;
    dwCPKey: uint32;
    bCP_APSTriggerBits: uint32;
    bOEMCopyProtection: array[0..255] of uint8; //- ascii char
  end;
  pVideoParameters = ^TVideoParameters;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162807(v=vs.85).aspx
  ///  </summary>
  TPointL = record
    x: Long;
    y: Long;
  end;
  pPointL = ^TPointL;

  TDmDisplayFlagsUnion = record
    case Integer of
      0: (dmDisplayFlags: DWORD);
      1: (dmNup: DWORD);
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183565(v=vs.85).aspx
  ///  </summary>
  TDeviceModeW = record
    dmDeviceName: array [0..CCHDEVICENAME - 1] of uint16;
    dmSpecVersion: WORD;
    dmDriverVersion: WORD;
    dmSize: WORD;
    dmDriverExtra: WORD;
    dmFields: DWORD;
    union1: record
    case Integer of
      // printer only fields
      0: (
        dmOrientation: Smallint;
        dmPaperSize: Smallint;
        dmPaperLength: Smallint;
        dmPaperWidth: Smallint;
        dmScale: Smallint;
        dmCopies: Smallint;
        dmDefaultSource: Smallint;
        dmPrintQuality: Smallint);
      // display only fields
      1: (
        dmPosition: TPointL;
        dmDisplayOrientation: DWORD;
        dmDisplayFixedOutput: DWORD);
    end;
    dmColor: Shortint;
    dmDuplex: Shortint;
    dmYResolution: Shortint;
    dmTTOption: Shortint;
    dmCollate: Shortint;
    dmFormName: array [0..CCHFORMNAME - 1] of uint16;
    dmLogPixels: WORD;
    dmBitsPerPel: DWORD;
    dmPelsWidth: DWORD;
    dmPelsHeight: DWORD;
    dmDisplayFlags: TDmDisplayFlagsUnion;
    dmDisplayFrequency: DWORD;
    dmICMMethod: DWORD;
    dmICMIntent: DWORD;
    dmMediaType: DWORD;
    dmDitherType: DWORD;
    dmReserved1: DWORD;
    dmReserved2: DWORD;
    dmPanningWidth: DWORD;
    dmPanningHeight: DWORD;
  end;
  PDeviceModeW = ^TDeviceModeW;

  TDeviceModeA = record
    dmDeviceName: array [0..CCHDEVICENAME - 1] of uint8;
    dmSpecVersion: WORD;
    dmDriverVersion: WORD;
    dmSize: WORD;
    dmDriverExtra: WORD;
    dmFields: DWORD;
    union1: record
    case Integer of
      // printer only fields
      0: (
        dmOrientation: Smallint;
        dmPaperSize: Smallint;
        dmPaperLength: Smallint;
        dmPaperWidth: Smallint;
        dmScale: Smallint;
        dmCopies: Smallint;
        dmDefaultSource: Smallint;
        dmPrintQuality: Smallint);
      // display only fields
      1: (
        dmPosition: TPointL;
        dmDisplayOrientation: DWORD;
        dmDisplayFixedOutput: DWORD);
    end;
    dmColor: Shortint;
    dmDuplex: Shortint;
    dmYResolution: Shortint;
    dmTTOption: Shortint;
    dmCollate: Shortint;
    dmFormName: array [0..CCHFORMNAME - 1] of BYTE;
    dmLogPixels: WORD;
    dmBitsPerPel: DWORD;
    dmPelsWidth: DWORD;
    dmPelsHeight: DWORD;
    dmDisplayFlags: TDmDisplayFlagsUnion;
    dmDisplayFrequency: DWORD;
    dmICMMethod: DWORD;
    dmICMIntent: DWORD;
    dmMediaType: DWORD;
    dmDitherType: DWORD;
    dmReserved1: DWORD;
    dmReserved2: DWORD;
    dmPanningWidth: DWORD;
    dmPanningHeight: DWORD;
  end;
  PDeviceModeA = ^TDeviceModeA;


  TDLGTEMPLATE = packed record
    style: DWORD;
    dwExtendedStyle: DWORD;
    cdit: WORD;
    x: SHORT;
    y: SHORT;
    cx: SHORT;
    cy: SHORT;
  end;
  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368826(v=vs.85).aspx
  ///  </summary>
  TPixelFormatDescriptor = record
    nSize: uint16;
    nVersion: uint16;
    dwFlags: uint32;
    iPixelType: uint8;
    cColorBits: uint8;
    cRedBits: uint8;
    cRedShift: uint8;
    cGreenBits: uint8;
    cGreenShift: uint8;
    cBlueBits: uint8;
    cBlueShift: uint8;
    cAlphaBits: uint8;
    cAlphaShift: uint8;
    cAccumBits: uint8;
    cAccumRedBits: uint8;
    cAccumGreenBits: uint8;
    cAccumBlueBits: uint8;
    cAccumAlphaBits: uint8;
    cDepthBits: uint8;
    cStencilBits: uint8;
    cAuxBuffers: uint8;
    iLayerType: uint8;
    bReserved: uint8;
    dwLayerMask: uint32;
    dwVisibleMask: uint32;
    dwDamageMask: uint32;
  end;
  pPixelFormatDescriptor = ^TPixelFormatDescriptor;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685138(v=vs.85).aspx
  ///  </summary>
  TServiceMainFunction = procedure( dwArgc: uint32; lpszArgv: pwidechar ) stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683240(v=vs.85).aspx
  ///  <summary>
  THandler = procedure ( fdwControl: uint32 ) stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683241(v=vs.85).aspx
  ///  <summary>
  THandlerEx = procedure ( dwControl: uint32; dwEventType: uint32; lpEventData: pointer; lpContext: pointer ); stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633498(v=vs.85).aspx
  ///  <summary>
  TWndEnumProc = function(hwnd: THWND; lParam: TLPARAM): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682612(v=vs.85).aspx
  ///  <summary>
  TDeskTopEnumProcA = function(lpstr: LPSTR; lParam: TLPARAM): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682612(v=vs.85).aspx
  ///  <summary>
  TDeskTopEnumProcW = function(lpstr: LPWSTR; lParam: TLPARAM): BOOL; stdcall;

(*  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms685996(v=vs.85).aspx
  ///  </summary>
  TSERVICE_STATUS = record
    dwServiceType: uint32;
    dwCurrentState: uint32;
    dwControlsAccepted: uint32;
    dwWin32ExitCode: uint32;
    dwServiceSpecificExitCode: uint32;
    dwCheckPoint: uint32;
    dwWaitHint: uint32;
  end;
  pSERVICE_STATUS = ^TSERVICE_STATUS; *)

  SID_NAME_USE = uint32;
  HKEY = ^NativeUInt;
  REGSAM = uint32;


  THandlerFunction = procedure(dwControl: uint32); stdcall;

  TSECURITY_INFORMATION = uint32;
  PSECURITY_INFORMATION = ^TSECURITY_INFORMATION;
  SC_LOCK = pointer;

  TSIDIdentifierAuthority = record
    value: array [0..5] of uint8;
  end;
  PSIDIdentifierAuthority = ^TSIDIdentifierAuthority;

  SECURITY_DESCRIPTOR_CONTROL = uint16;

  TSID = record
    Revision: uint8;
    SubAuthorityCount: uint8;
    IdentifierAuthority: TSIDIdentifierAuthority;
    SubAuthority: array [0..ANYSIZE_ARRAY-1] of uint32;
  end;
  PSID = ^TSID;

  TACL = record
    AclRevision: uint8;
    Sbz1: uint8;
    AclSize: uint16;
    AceCount: uint16;
    Sbz2: uint16;
  end;
  pACL = ^TACL;

  TSecurityDescriptor = record
    Revision: Byte;
    Sbz1: Byte;
    Control: SECURITY_DESCRIPTOR_CONTROL;
    Owner: PSID;
    Group: PSID;
    Sacl: PACL;
    Dacl: PACL;
  end;
  PSecurityDescriptor = ^TSecurityDescriptor;

  TACCESS_MASK = uint32;

  TGenericMapping = record
    GenericRead: TACCESS_MASK;
    GenericWrite: TACCESS_MASK;
    GenericExecute: TACCESS_MASK;
    GenericAll: TACCESS_MASK;
  end;

  TLUID = record
    LowPart: uint32;
    HighPart: int32;
  end;

  TLUID_AND_ATTRIBUTES = record
    Luid: TLUID;
    Attributes: uint32;
  end;

  TPrivilegeSet = record
    PrivilegeCount: uint32;
    Control: uint32;
    Privilege: array [0..ANYSIZE_ARRAY - 1] of TLUID_AND_ATTRIBUTES;
  end;
  pPrivilegeSet = ^TPrivilegeSet;

  TGUID = record
    D1: int32;
    D2: uint16;
    D3: uint16;
    D4: array[0..7] of uint8;
  end;
  PGUID = ^TGUID;

  TObjectTypeList = record
    Level: uint16;
    Sbz: uint16;
    ObjectType: PGUID;
  end;
  PObjectTypeList = ^TObjectTypeList;

  TAUDIT_EVENT_TYPE = (AuditEventObjectAccess, AuditEventDirectoryServiceAccess);

  TSID_AND_ATTRIBUTES = record
    Sid: PSID;
    Attributes: uint32;
  end;

  TTokenGroups = record
    GroupCount: uint32;
    Groups: array [0..ANYSIZE_ARRAY - 1] of TSID_AND_ATTRIBUTES;
  end;
  PTokenGroups = ^TTokenGroups;

  TTokenPrivileges = record
    PrivilegeCount: uint32;
    Privileges: array [0..ANYSIZE_ARRAY - 1] of TLUID_AND_ATTRIBUTES;
  end;
  PTokenPrivileges = ^TTokenPrivileges;

  TSC_HANDLE = THANDLE;
  LPUINT32 = ^uint32;
  puint32 = ^uint32;
  puint8 = ^uint8;
  pint = ^uint32;

  TServiceStatus = record
    dwServiceType: uint32;
    dwCurrentState: uint32;
    dwControlsAccepted: uint32;
    dwWin32ExitCode: uint32;
    dwServiceSpecificExitCode: uint32;
    dwCheckPoint: uint32;
    dwWaitHint: uint32;
  end;
  PServiceStatus = ^TServiceStatus;

  TSecurityAttributes = record
    nLength: uint32;
    lpSecurityDescriptor: pointer;
    bInheritHandle: boolean;
  end;
  PSecurityAttributes = ^TSecurityAttributes;

  TProcessInformation = record
    hProcess: THandle;
    hThread: THandle;
    dwProcessId: uint32;
    dwThreadId: uint32;
  end;
  PProcessInformation = ^TProcessInformation;


  TTokenType = (TokenTPad, TokenPrimary, TokenImpersonation);

  TEnumServiceStatusA = record
    lpServiceName: LPSTR;
    lpDisplayName: LPSTR;
    ServiceStatus: TServiceStatus;
  end;

  TEnumServiceStatusW = record
    lpServiceName: LPWStr;
    lpDisplayName: LPWStr;
    ServiceStatus: TServiceStatus;
  end;

  TAclInformationClass = (AclInfoPad, AclRevisionInformation, AclSizeInformation);

  THWProfileInfoA = record
    dwDockInfo: uint32;
    szHwProfileGuid: packed array[0..HW_PROFILE_GUIDLEN-1] of AnsiChar;
    szHwProfileName: packed array[0..MAX_PROFILE_LEN-1] of AnsiChar;
  end;
  pHWPProfileInfoA = ^THWProfileInfoA;

  THWProfileInfoW = record
    dwDockInfo: uint32;
    szHwProfileGuid: packed array[0..HW_PROFILE_GUIDLEN-1] of WideChar;
    szHwProfileName: packed array[0..MAX_PROFILE_LEN-1] of WideChar;
  end;
  pHWPProfileInfoW = ^THWProfileInfoW;

  TTokenInformationClass = (
    TokenUser = 1,
    TokenGroups,
    TokenPrivileges,
    TokenOwner,
    TokenPrimaryGroup,
    TokenDefaultDacl,
    TokenSource,
    TokenType,
    TokenImpersonationLevel,
    TokenStatistics,
    TokenRestrictedSids,
    TokenSessionId,
    TokenGroupsAndPrivileges,
    TokenSessionReference,
    TokenSandBoxInert,
    TokenAuditPolicy,
    TokenOrigin,
    TokenElevationType,
    TokenLinkedToken,
    TokenElevation,
    TokenHasRestrictions,
    TokenAccessInformation,
    TokenVirtualizationAllowed,
    TokenVirtualizationEnabled,
    TokenIntegrityLevel,
    TokenUIAccess,
    TokenMandatoryPolicy,
    TokenLogonSid,
    vMaxTokenInfoClass
  );

  TQueryServiceConfigA = record
    dwServiceType: uint32;
    dwStartType: uint32;
    dwErrorControl: uint32;
    lpBinaryPathName: LPSTR;
    lpLoadOrderGroup: LPSTR;
    dwTagId: uint32;
    lpDependencies: LPSTR;
    lpServiceStartName: LPSTR;
    lpDisplayName: LPSTR;
  end;
  PQueryServiceConfigA = ^TQueryServiceConfigA;

  TQueryServiceConfigW = record
    dwServiceType: uint32;
    dwStartType: uint32;
    dwErrorControl: uint32;
    lpBinaryPathName: LPWSTR;
    lpLoadOrderGroup: LPWSTR;
    dwTagId: uint32;
    lpDependencies: LPWSTR;
    lpServiceStartName: LPWSTR;
    lpDisplayName: LPWSTR;
  end;
  PQueryServiceConfigW = ^TQueryServiceConfigW;

  TQueryServiceLockStatusA = record
    fIsLocked: uint32;
    lpLockOwner: LPSTR;
    dwLockDuration: uint32
  end;
  pQueryServiceLockStatusA = ^TQueryServiceLockStatusA;

  TQueryServiceLockStatusW = record
    fIsLocked: uint32;
    lpLockOwner: LPWSTR;
    dwLockDuration: uint32;
  end;
  PQueryServiceLockStatusW = ^TQueryServiceLockStatusW;

  TSECURITY_DESCRIPTOR = record
    Revision: uint8;
    Sbz1: uint8;
    Control: SECURITY_DESCRIPTOR_CONTROL;
    Owner: PSID;
    Group: PSID;
    Sacl: PACL;
    Dacl: PACL;
  end;
  PSECURITY_DESCRIPTOR = ^TSECURITY_DESCRIPTOR;

  TFileTime = record
    dwLowDateTime: uint32;
    dwHighDateTime: uint32;
  end;
  PFileTime = ^TFileTime;

  LPSERVICE_MAIN_FUNCTIONW = procedure(dwNumServicesArgs: uint32; lpServiceArgVectors: LPWSTR); stdcall;
  LPSERVICE_MAIN_FUNCTIONA = procedure(dwNumServicesArgs: uint32; lpServiceArgVectors: LPSTR); stdcall;

  TServiceTableEntryA = record
    lpServiceName: LPSTR;
    lpServiceProc: LPSERVICE_MAIN_FUNCTIONA;
  end;
  PServiceTableEntryA = ^TServiceTableEntryA;

  TServiceTableEntryW = record
    lpServiceName: LPWSTR;
    lpServiceProc: LPSERVICE_MAIN_FUNCTIONW;
  end;
  PServiceTableEntryW = ^TServiceTableEntryW;

(*  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms686001(v=vs.85).aspx
  ///  </summary>
  TSERVICE_TABLE_ENTRY = record
    lpServiceName: pWideChar;
    lpServiceProc: TServiceMainFunction;
  end;
  pSERVICE_TABLE_ENTRY = ^TSERVICE_TABLE_ENTRY;
*)

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648731(v=vs.85).aspx
  ///  </summary>
  TConvInfo = record
    cb: DWORD;
    hUser: ^DWORD;
    hConvPartner: THCONV;
    hszSvcPartner: THSZ;
    hszServiceReq: THSZ;
    hszTopic: THSZ;
    hszItem: THSZ;
    wFmt: UINT;
    wType: UINT;
    wStatus: UINT;
    wConvst: UINT;
    wLastError: UINT;
    hConvList: THConvList;
    ConvCtxt: TConvContext;
    hwnd: THWND;
    hwndPartner: THWND;
  end;
  PConvInfo = ^ TConvInfo;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162500(v=vs.85).aspx
  ///  </summary>
  TDrawTextParams = record
    cbSize: UINT;
    iTabLength: Integer;
    iLeftMargin: Integer;
    iRightMargin: Integer;
    uiLengthDrawn: UINT;
  end;
  PDrawTextParams = ^TDrawTextParams;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363190(v=vs.85).aspx
  ///  </summary>
  TCOMMTIMEOUTS = record
    ReadIntervalTimeout: DWORD;         // Maximum time between read chars.
    ReadTotalTimeoutMultiplier: DWORD;  // Multiplier of characters.
    ReadTotalTimeoutConstant: DWORD;    // Constant in milliseconds.
    WriteTotalTimeoutMultiplier: DWORD; // Multiplier of characters.
    WriteTotalTimeoutConstant: DWORD;   // Constant in milliseconds.
  end;
  PCOMMTIMEOUTS = ^TCOMMTIMEOUTS;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363200(v=vs.85).aspx
  ///  </summary>
  TComStat = record
    Flags: DWORD;
    cbInQue: DWORD;
    cbOutQue: DWORD;
  end;
  PCOMSTAT = ^TComStat;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363188(v=vs.85).aspx
  ///  </summary>
  TCommConfig = record
    dwSize: DWORD;            // Size of the entire struct
    wVersion: Word;           // version of the structure
    wReserved: Word;          // alignment
    dcb: TDCB;                 // device control block
    dwProviderSubType: DWORD; // ordinal value for identifying provider-defined data structure format
    dwProviderOffset: DWORD;  // Specifies the offset of provider specific data field in bytes from the start
    dwProviderSize: DWORD;    // size of the provider-specific data field
    wcProviderData: array [0..0] of uint16; // provider-specific data
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684342(v=vs.85).aspx
  ///  </summary>
  TOverlapped = record
    Internal: ULONG_PTR;
    InternalHigh: ULONG_PTR;
    Union: record
    case Integer of
      0: ( Offset: DWORD; OffsetHigh: DWORD );
      1: ( ptr: pointer );
    end;
    hEvent: THANDLE;
  end;
  POverlapped = ^TOverlapped;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa364052(v=vs.85).aspx
  ///  </summary>
  TFileIOCompletionRoutine =  procedure(dwErrorCode: DWORD; dwNumberOfBytesTransfered: DWORD; lpOverlapped: POverlapped); stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682119(v=vs.85).aspx
  ///  </summary>
  TCoord = record
    X: SHORT;
    Y: SHORT;
  end;
  PCoord = ^TCoord;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365740(v=vs.85).aspx
  ///  </summary>
  TWIN32FindDataA = record
    dwFileAttributes: DWORD;
    ftCreationTime: TFileTime;
    ftLastAccessTime: TFileTime;
    ftLastWriteTime: TFileTime;
    nFileSizeHigh: DWORD;
    nFileSizeLow: DWORD;
    dwReserved0: DWORD;
    dwReserved1: DWORD;
    cFileName: array [0..MAX_PATH - 1] of AnsiChar;
    cAlternateFileName: array [0..13] of AnsiChar;
  end;
  PWIN32FindDataA = ^TWIN32FindDataA;


  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365740(v=vs.85).aspx
  ///  </summary>
  TWIN32FindDataW = record
    dwFileAttributes: DWORD;
    ftCreationTime: TFileTime;
    ftLastAccessTime: TFileTime;
    ftLastWriteTime: TFileTime;
    nFileSizeHigh: DWORD;
    nFileSizeLow: DWORD;
    dwReserved0: DWORD;
    dwReserved1: DWORD;
    cFileName: array [0..MAX_PATH - 1] of WideChar;
    cAlternateFileName: array [0..13] of WideChar;
  end;
  PWIN32FindDataW = ^TWIN32FindDataw;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa364415(v=vs.85).aspx
  ///  </summary>
  TFindexInfoLevels = ( FindExInfoStandard, FindExInfoBasic, FindExInfoMaxInfoLevel );

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa364416(v=vs.85).aspx
  ///  </summary>
  TFindexSearchOps = ( FindExSearchNameMatch, FindExSearchLimitToDirectories, FindExSearchLimitToDevices );

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317780(v=vs.85).aspx
  ///  </summary>
  TCPInfo = record
    MaxCharSize: UINT; // max length (in bytes) of a AnsiChar
    DefaultChar: array [0..MAX_DEFAULTCHAR - 1] of BYTE; // default character
    LeadByte: array [0..MAX_LEADBYTES - 1] of BYTE; // lead byte ranges
  end;
  PCPInfo = ^TCPInfo;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363189(v=vs.85).aspx
  ///  </summary>
  TCOMMPROP = record
    wPacketLength: Word;
    wPacketVersion: Word;
    dwServiceMask: DWORD;
    dwReserved1: DWORD;
    dwMaxTxQueue: DWORD;
    dwMaxRxQueue: DWORD;
    dwMaxBaud: DWORD;
    dwProvSubType: DWORD;
    dwProvCapabilities: DWORD;
    dwSettableParams: DWORD;
    dwSettableBaud: DWORD;
    wSettableData: Word;
    wSettableStopParity: Word;
    dwCurrentTxQueue: DWORD;
    dwCurrentRxQueue: DWORD;
    dwProvSpec1: DWORD;
    dwProvSpec2: DWORD;
    wcProvChar: array [0..0] of WideChar;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682068(v=vs.85).aspx
  ///  </summary>
  TConsoleCursorInfo = record
    dwSize: DWORD;
    bVisible: BOOL;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682093(v=vs.85).aspx
  ///  </summary>
  TConsoleScreenBufferInfo = record
    dwSize: TCoord;
    dwCursorPosition: TCoord;
    wAttributes: WORD;
    srWindow: TSmallRect;
    dwMaximumWindowSize: TCoord;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317784(v=vs.85).aspx
  ///  </summary>
  TCurrencyFmtA = record
    NumDigits: UINT;
    LeadingZero: UINT;
    Grouping: UINT;
    lpDecimalSep: LPSTR;
    lpThousandSep: LPSTR;
    NegativeOrder: UINT;
    PositiveOrder: UINT;
    lpCurrencySymbol: LPSTR;
  end;
  PCurrencyFmtA = ^TCurrencyFmtA;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317784(v=vs.85).aspx
  ///  </summary>
  TCurrencyFmtW = record
    NumDigits: UINT;
    LeadingZero: UINT;
    Grouping: UINT;
    lpDecimalSep: LPWSTR;
    lpThousandSep: LPWSTR;
    NegativeOrder: UINT;
    PositiveOrder: UINT;
    lpCurrencySymbol: LPWSTR;
  end;
  PCurrencyFmtW = ^TCurrencyFmtW;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/bb736257(v=vs.85).aspx
  ///  </summary>
  TGetFileEXInfoLevels = (GetFileExInfoStandard, GetFileExMaxInfoLevel);

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363788(v=vs.85).aspx
  ///  </summary>
  TByHandleFileInformation = record
    dwFileAttributes: DWORD;
    ftCreationTime: TFileTime;
    ftLastAccessTime: TFileTime;
    ftLastWriteTime: TFileTime;
    dwVolumeSerialNumber: DWORD;
    nFileSizeHigh: DWORD;
    nFileSizeLow: DWORD;
    nNumberOfLinks: DWORD;
    nFileIndexHigh: DWORD;
    nFileIndexLow: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd319095(v=vs.85).aspx
  ///  </summary>
  TNumberFmtA = record
    NumDigits: UINT;
    LeadingZero: UINT;
    Grouping: UINT;
    lpDecimalSep: LPSTR;
    lpThousandSep: LPSTR;
    NegativeOrder: UINT;
  end;
  PNumberFmtA = ^TNumberFmtA;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd319095(v=vs.85).aspx
  ///  </summary>
  TNumberFmtW = record
    NumDigits: UINT;
    LeadingZero: UINT;
    Grouping: UINT;
    lpDecimalSep: LPWSTR;
    lpThousandSep: LPWSTR;
    NegativeOrder: UINT;
  end;
  PNumberFmtW = ^TNumberFmtW;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724958(v=vs.85).aspx
  ///  </summary>
  TSystemInfo = record
    case Integer of
    0: (
      dwOemId: DWORD);
    1: (
      wProcessorArchitecture: WORD;
      wReserved: WORD;
      dwPageSize: DWORD;
      lpMinimumApplicationAddress: LPVOID;
      lpMaximumApplicationAddress: LPVOID;
      dwActiveProcessorMask: DWORD_PTR;
      dwNumberOfProcessors: DWORD;
      dwProcessorType: DWORD;
      dwAllocationGranularity: DWORD;
      wProcessorLevel: WORD;
      wProcessorRevision: WORD);
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa373232(v=vs.85).aspx
  ///  </summary>
  TSystemPowerStatus = record
    ACLineStatus: BYTE;
    BatteryFlag: BYTE;
    BatteryLifePercent: BYTE;
    Reserved1: BYTE;
    BatteryLifeTime: DWORD;
    BatteryFullLifeTime: DWORD;
  end;

  TFloatingSaveArea = record
    ControlWord: DWORD;
    StatusWord: DWORD;
    TagWord: DWORD;
    ErrorOffset: DWORD;
    ErrorSelector: DWORD;
    DataOffset: DWORD;
    DataSelector: DWORD;
    RegisterArea: array [0..SIZE_OF_80387_REGISTERS - 1] of BYTE;
    Cr0NpxState: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679284(v=vs.85).aspx
  ///  </summary>
  TContext  = record
    ContextFlags: DWORD;
    Dr0: DWORD;
    Dr1: DWORD;
    Dr2: DWORD;
    Dr3: DWORD;
    Dr6: DWORD;
    Dr7: DWORD;
    FloatSave: TFloatingSaveArea;
    SegGs: DWORD;
    SegFs: DWORD;
    SegEs: DWORD;
    SegDs: DWORD;
    Edi: DWORD;
    Esi: DWORD;
    Ebx: DWORD;
    Edx: DWORD;
    Ecx: DWORD;
    Eax: DWORD;
    Ebp: DWORD;
    Eip: DWORD;
    SegCs: DWORD;              // MUST BE SANITIZED
    EFlags: DWORD;             // MUST BE SANITIZED
    Esp: DWORD;
    SegSs: DWORD;
    ExtendedRegisters: array [0..MAXIMUM_SUPPORTED_EXTENSION - 1] of BYTE;
  end;
  PContext = ^TContext;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms680348(v=vs.85).aspx
  ///  </summary>
  TLDTEntry = record
    LimitLow: WORD;
    BaseLow: WORD;
    BaseMid: BYTE;
    Flags1: BYTE;
    Flags2: BYTE;
    BaseHi: BYTE;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms725481(v=vs.85).aspx
  ///  </summary>
  TTimeZoneInformation = record
    Bias: LONG;
    StandardName: array [0..31] of WideChar;
    StandardDate: TSystemTime;
    StandardBias: LONG;
    DaylightName: array [0..31] of WideChar;
    DaylightDate: TSystemTime;
    DaylightBias: LONG;
  end;
  PTimeZoneInformation = ^TTimeZoneInformation;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724834(v=vs.85).aspx
  ///  </summary>
  TOSVersionInfoA = record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array [0..127] of AnsiChar;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms724834(v=vs.85).aspx
  ///  </summary>
  TOSVersionInfoW = record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array [0..127] of WideChar;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa366772(v=vs.85).aspx
  ///  </summary>
  TMemoryStatus = record
    dwLength: DWORD;
    dwMemoryLoad: DWORD;
    dwTotalPhys: SIZE_T;
    dwAvailPhys: SIZE_T;
    dwTotalPageFile: SIZE_T;
    dwAvailPageFile: SIZE_T;
    dwTotalVirtual: SIZE_T;
    dwAvailVirtual: SIZE_T;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683443(v=vs.85).aspx
  ///  </summary>
  THeapEntry32 = record
    dwSize: SIZE_T;
    hHandle: THandle;
    dwAddress: ULONG_PTR;
    dwBlockSize: SIZE_T;
    dwFlags: DWORD;
    dwLockCount: DWORD;
    dwResvd: DWORD;
    th32ProcessID: DWORD;
    th32HeapID: ULONG_PTR;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683449(v=vs.85).aspx
  ///  </summary>
  THeapList32 = record
    dwSize: SIZE_T;
    th32ProcessID: DWORD;   // owning process
    th32HeapID: ULONG_PTR;  // heap (in owning process's context!)
    dwFlags: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa366798(v=vs.85).aspx
  ///  </summary>
  TProcessHeapEntry = record
    lpData: Pointer;
    cbData: DWORD;
    cbOverhead: BYTE;
    iRegionIndex: BYTE;
    wFlags: WORD;
    case Integer of
      0: (
        hMem: THandle;
        dwReserved: array [0..2] of DWORD);
      1: (
        dwComittedSize: DWORD;
        dwUnComittedSize: DWORD;
        lpFirstBlock: LPVOID;
        lpLastBlock: LPVOID);
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684225(v=vs.85).aspx
  ///  </summary>
  TModuleEntry32W = record
    dwSize: DWORD;
    th32ModuleID: DWORD;       // This module
    th32ProcessID: DWORD;      // owning process
    GlblcntUsage: DWORD;       // Global usage count on the module
    ProccntUsage: DWORD;       // Module usage count in th32ProcessID's context
    modBaseAddr: LPBYTE;       // Base address of module in th32ProcessID's context
    modBaseSize: DWORD;        // Size in bytes of module starting at modBaseAddr
    hModule: HMODULE;          // The hModule of this module in th32ProcessID's context
    szModule: array [0..MAX_MODULE_NAME32] of WideChar;
    szExePath: array [0..MAX_PATH - 1] of WideChar;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684225(v=vs.85).aspx
  ///  </summary>
  TModuleEntry32A = record
    dwSize: DWORD;
    th32ModuleID: DWORD;       // This module
    th32ProcessID: DWORD;      // owning process
    GlblcntUsage: DWORD;       // Global usage count on the module
    ProccntUsage: DWORD;       // Module usage count in th32ProcessID's context
    modBaseAddr: LPBYTE;       // Base address of module in th32ProcessID's context
    modBaseSize: DWORD;        // Size in bytes of module starting at modBaseAddr
    hModule: HMODULE;          // The hModule of this module in th32ProcessID's context
    szModule: array [0..MAX_MODULE_NAME32] of AnsiChar;
    szExePath: array [0..MAX_PATH - 1] of AnsiChar;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa365282(v=vs.85).aspx
  ///  </summary>
  TOFStruct = record
    cBytes: Byte;
    fFixedDisk: Byte;
    nErrCode: Word;
    Reserved1: Word;
    Reserved2: Word;
    szPathName: array [0..OFS_MAXPATHNAME - 1] of AnsiChar;
  end;

  TCharUnion = record
    case Integer of
      0: (UnicodeChar: WideChar);
      1: (AsciiChar: AnsiChar);
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684166(v=vs.85).aspx
  ///  </summary>
  TKeyEventRecord = record
    bKeyDown: BOOL;
    wRepeatCount: WORD;
    wVirtualKeyCode: WORD;
    wVirtualScanCode: WORD;
    uChar: TCharUnion;
    dwControlKeyState: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684239(v=vs.85).aspx
  ///  </summary>
  TMouseEventRecord = record
    dwMousePosition: TCoord;
    dwButtonState: DWORD;
    dwControlKeyState: DWORD;
    dwEventFlags: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms687093(v=vs.85).aspx
  ///  </summary>
  TWindowBufferSizeEventRecord = record
    dwSize: TCoord;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684213(v=vs.85).aspx
  ///  </summary>
  TMenuEventRecord = record
    dwCommandId: UINT;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683149(v=vs.85).aspx
  ///  </summary>
  TFocusEventRecord = record
    bSetFocus: BOOL;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms683499(v=vs.85).aspx
  ///  </summary>
  TInputRecord = record
    EventType: WORD;
    case Integer of
      0: (KeyEvent: TKeyEventRecord);
      1: (MouseEvent: TMouseEventRecord);
      2: (WindowBufferSizeEvent: TWindowBufferSizeEventRecord);
      3: (MenuEvent: TMenuEventRecord);
      4: (FocusEvent: TFocusEventRecord);
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684839(v=vs.85).aspx
  ///  </summary>
  TProcessEntry32W = record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ProcessID: DWORD;
    th32DefaultHeapID: ULONG_PTR;
    th32ModuleID:DWORD;
    cntThreads: DWORD;
    th32ParentProcessID: DWORD;
    pcPriClassBase: LONG;
    dwFlags: DWORD;
    szExeFile: array [0..MAX_PATH - 1] of WideChar;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms684839(v=vs.85).aspx
  ///  </summary>
  TProcessEntry32A = record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ProcessID: DWORD;
    th32DefaultHeapID: ULONG_PTR;
    th32ModuleID: DWORD;
    cntThreads: DWORD;
    th32ParentProcessID: DWORD;
    pcPriClassBase: LONG;
    dwFlags: DWORD;
    szExeFile: array [0..MAX_PATH - 1] of AnsiChar;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682013(v=vs.85).aspx
  ///  </summary>
  TCharInfo = record
    uChar: TCharUnion;
    Attributes: WORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363188(v=vs.85).aspx
  ///  </summary>
  TCommConfigW = record
    dwSize: DWORD;
    wVersion: Word;
    wReserved: Word;
    dcb: TDCB;
    dwProviderSubType: DWORD;
    dwProviderOffset: DWORD;
    dwProviderSize: DWORD;
    wcProviderData: array [0..0] of WideChar;
  end;
  PCommConfigW = ^ TCommConfigW;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363188(v=vs.85).aspx
  ///  </summary>
  TCommConfigA = record
    dwSize: DWORD;
    wVersion: Word;
    wReserved: Word;
    dcb: TDCB;
    dwProviderSubType: DWORD;
    dwProviderOffset: DWORD;
    dwProviderSize: DWORD;
    wcProviderData: array [0..0] of AnsiChar;
  end;
  PCommConfigA = ^ TCommConfigA;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa363082(v=vs.85).aspx
  ///  </summary>
  PExceptionRecord = ^TExceptionRecord;
  TExceptionRecord = record
    ExceptionCode: DWORD;
    ExceptionFlags: DWORD;
    ExceptionRecord: PExceptionRecord;
    ExceptionAddress: Pointer;
    NumberParameters: DWORD;
    ExceptionInformation: array [0..EXCEPTION_MAXIMUM_PARAMETERS - 1] of ULONG_PTR;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679331(v=vs.85).aspx
  ///  </summary>
  TExceptionPointers = record
    ExceptionRecord: PExceptionRecord;
    ContextRecord: PCONTEXT;
  end;
  PExceptionPointers = ^TExceptionPointers;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms681401(v=vs.85).aspx
  ///  </summary>
  TUnhandledExceptionFilter = function(ExceptionInfo: PExceptionPointers): LONG; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms686786(v=vs.85).aspx
  ///  </summary>
  TimerAPCProc = procedure(lpArgToCompletionRoutine: LPVOID; dwTimerLowValue, dwTimerHighValue: DWORD); stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms686735(v=vs.85).aspx
  ///  </summary>
  TThreadEntry32 = record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ThreadID: DWORD;       // this thread
    th32OwnerProcessID: DWORD; // Process this thread is associated with
    tpBasePri: LONG;
    tpDeltaPri: LONG;
    dwFlags: DWORD;
  end;


  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/aa366775(v=vs.85).aspx
  ///  </summary>
  TMemoryBasicInformation = record
    BaseAddress: Pointer;
    AllocationBase: Pointer;
    AllocationProtect: DWORD;
    RegionSize: SIZE_T;
    State: DWORD;
    Protect: DWORD;
    _Type: DWORD;
  end;

  ///  <summary>
  ///    MSDN:
  ///  </summary>
 TThreadStartRoutine = function(lpThreadParameter: LPVOID): DWORD; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679326(v=vs.85).aspx
  ///  </summary>
  TExceptionDebugInfo = record
    ExceptionRecord: TExceptionRecord;
    dwFirstChance: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679287(v=vs.85).aspx
  ///  </summary>
  TCreateThreadDebugInfo = record
    hThread: THandle;
    lpThreadLocalBase: LPVOID;
    lpStartAddress: TThreadStartRoutine;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679286(v=vs.85).aspx
  ///  </summary>
  TCreateProcessDebugInfo = record
    hFile: THandle;
    hProcess: THandle;
    hThread: THandle;
    lpBaseOfImage: LPVOID;
    dwDebugInfoFileOffset: DWORD;
    nDebugInfoSize: DWORD;
    lpThreadLocalBase: LPVOID;
    lpStartAddress: TThreadStartRoutine;
    lpImageName: LPVOID;
    fUnicode: Word;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679335(v=vs.85).aspx
  ///  </summary>
  TExitThreadDebugInfo = record
    dwExitCode: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679334(v=vs.85).aspx
  ///  </summary>
  TExitProcessDebugInfo = record
    dwExitCode: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms680351(v=vs.85).aspx
  ///  </summary>
  TLoadDLLDebugInfo = record
    hFile: THandle;
    lpBaseOfDll: LPVOID;
    dwDebugInfoFileOffset: DWORD;
    nDebugInfoSize: DWORD;
    lpImageName: LPVOID;
    fUnicode: Word;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms681403(v=vs.85).aspx
  ///  </summary>
  TUnloadDLLDebugInfo = record
    lpBaseOfDll: LPVOID;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms680545(v=vs.85).aspx
  ///  </summary>
  TOutputDebugStringInfo = record
    lpDebugStringData: LPSTR;
    fUnicode: Word;
    nDebugStringLength: Word;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms680587(v=vs.85).aspx
  ///  </summary>
  TRIPDebugInfo = record
    dwError: DWORD;
    dwType: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679308(v=vs.85).aspx
  ///  </summary>
  TDebugEvent = record
    dwDebugEventCode: DWORD;
    dwProcessId: DWORD;
    dwThreadId: DWORD;
    case Integer of
      0: (Exception: TExceptionDebugInfo);
      1: (CreateThread: TCreateThreadDebugInfo);
      2: (CreateProcessInfo: TCreateProcessDebugInfo);
      3: (ExitThread: TExitThreadDebugInfo);
      4: (ExitProcess: TExitProcessDebugInfo);
      5: (LoadDll: TLoadDLLDebugInfo);
      6: (UnloadDll: TUnloadDLLDebugInfo);
      7: (DebugString: TOutputDebugStringInfo);
      8: (RipInfo: TRIPDebugInfo);
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183569(v=vs.85).aspx
  ///  </summary>
  TDisplayDeviceA = record
    cb: DWORD;
    DeviceName: array [0..32 - 1] of AnsiChar;
    DeviceString: array [0..128 - 1] of AnsiChar;
    StateFlags: DWORD;
    DeviceID: array [0..128 - 1] of AnsiChar;
    DeviceKey: array [0..128 - 1] of AnsiChar;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183569(v=vs.85).aspx
  ///  </summary>
  TDisplayDeviceW = record
    cb: DWORD;
    DeviceName: array [0..32 - 1] of WideChar;
    DeviceString: array [0..128 - 1] of WideChar;
    StateFlags: DWORD;
    DeviceID: array [0..128 - 1] of WideChar;
    DeviceKey: array [0..128 - 1] of WideChar;
  end;

(*  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183569(v=vs.85).aspx
  ///  </summary>
  TDisplayDevice = record
    cb: uint32;
    DeviceName: array[0..31] of uint16;
    DeviceString: array[0..127] of uint16;
    StateFlags: uint32;
    DeviceID: array[0..127] of uint16;
    DeviceKey: array[0..127] of uint16;
  end;
  pDisplayDevice = ^TDisplayDevice; *)

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633562(v=vs.85).aspx
  ///  </summary>
  TPropEnumProcA = function(hwnd: THWND; lpszString: LPCSTR; hData: THANDLE): BOOL; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633562(v=vs.85).aspx
  ///  </summary>
  TPropEnumProcW = function(hwnd: THWND; lpszString: LPCWSTR; hData: THANDLE): BOOL; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633563(v=vs.85).aspx
  ///  </summary>
  TPropEnumProcEXA = function(hwnd: THWND; lpszString: LPSTR; hData: THandle; dwData: ULONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms633563(v=vs.85).aspx
  ///  </summary>
  TPropEnumProcEXW = function(hwnd: THWND; lpszString: LPWSTR; hData: THandle; dwData: ULONG_PTR): BOOL; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682644(v=vs.85).aspx
  ///  </summary>
  TEnumWinStatProcA = function(lpstr: LPSTR; lParam: TLPARAM): BOOL; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms682644(v=vs.85).aspx
  ///  </summary>
  TEnumWinStatProcW = function(lpstr: LPWSTR; lParam: TLPARAM): BOOL; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms679348(v=vs.85).aspx
  ///  </summary>
  TFlashWInfo = record
    cbSize: UINT;
    hwnd: THWND;
    dwFlags: DWORD;
    uCount: UINT;
    dwTimeout: DWORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632601(v=vs.85).aspx
  ///  </summary>
  TAltTabInfo = record
    cbSize: DWORD;
    cItems: Integer;
    cColumns: Integer;
    cRows: Integer;
    iColFocus: Integer;
    iRowFocus: Integer;
    cxItem: Integer;
    cyItem: Integer;
    ptStart: TPoint;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648389(v=vs.85).aspx
  ///  </summary>
  TCursorInfo = record
    cbSize: DWORD;
    flags: DWORD;
    hCursor: THCURSOR;
    ptScreenPos: TPoint;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632604(v=vs.85).aspx
  ///  </summary>
  TGUIThreadInfo = record
    cbSize: DWORD;
    flags: DWORD;
    hwndActive: THwnd;
    hwndFocus: THwnd;
    hwndCapture: THwnd;
    hwndMenuOwner: THwnd;
    hwndMoveSize: THwnd;
    hwndCaret: THwnd;
    rcCaret: TRect;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646272(v=vs.85).aspx
  ///  </summary>
  TLastInputInfo = record
    cbSize: UINT;
    dwTime: DWORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms647564(v=vs.85).aspx
  ///  </summary>
  TMenuBarInfo = record
    cbSize: DWORD;
    rcBar: TRECT;
    hMenu: THMENU;
    hwndMenu: THWND;
    Flags: DWORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms647575(v=vs.85).aspx
  ///  </summary>
  TMenuInfo = record
    cbSize: DWORD;
    fMask: DWORD;
    dwStyle: DWORD;
    cyMax: UINT;
    hbrBack: THBRUSH;
    dwContextHelpID: DWORD;
    dwMenuData: ULONG_PTR;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms647578(v=vs.85).aspx
  ///  </summary>
  TMenuItemInfoA = record
    cbSize: UINT;
    fMask: UINT;
    fType: UINT;
    fState: UINT;
    wID: UINT;
    hSubMenu: THMENU;
    hbmpChecked: THBITMAP;
    hbmpUnchecked: THBITMAP;
    dwItemData: ULONG_PTR;
    dwTypeData: LPSTR;
    cch: UINT;
    hbmpItem: THBITMAP;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms647578(v=vs.85).aspx
  ///  </summary>
  TMenuItemInfoW = record
    cbSize: UINT;
    fMask: UINT;
    fType: UINT;
    fState: UINT;
    wID: UINT;
    hSubMenu: THMENU;
    hbmpChecked: THBITMAP;
    hbmpUnchecked: THBITMAP;
    dwItemData: ULONG_PTR;
    dwTypeData: LPWSTR;
    cch: UINT;
    hbmpItem: THBITMAP;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/bb787535(v=vs.85).aspx
  ///  </summary>
  TScrollBarInfo = record
    cbSize: DWORD;
    rcScrollBar: TRECT;
    dxyLineButton: int32;
    xyThumbTop: int32;
    xyThumbBottom: int32;
    reserved: int32;
    rgstate: array [0..CCHILDREN_SCROLLBAR] of DWORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/bb787537(v=vs.85).aspx
  ///  </summary>
  TScrollInfo = record
    cbSize: UINT;
    fMask: UINT;
    nMin: int32;
    nMax: int32;
    nPage: UINT;
    nPos: int32;
    nTrackPos: int32;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632610(v=vs.85).aspx
  ///  </summary>
  TWindowInfo = record
    cbSize: DWORD;
    rcWindow: TRECT;
    rcClient: TRECT;
    dwStyle: DWORD;
    dwExStyle: DWORD;
    dwWindowStatus: DWORD;
    cxWindowBorders: UINT;
    cyWindowBorders: UINT;
    atomWindowType: TATOM;
    wCreatorVersion: WORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632611(v=vs.85).aspx
  ///  </summary>
  TWindowPlacement = record
    length: UINT;
    flags: UINT;
    showCmd: UINT;
    ptMinPosition: TPOINT;
    ptMaxPosition: TPOINT;
    rcNormalPosition: TRECT;
  end;
  PWindowPlacement = ^TWindowPlacement;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162756(v=vs.85).aspx
  ///  </summary>
  TOutputProc = function(hdc: THDC; lpData: TLPARAM; cchData: int32): BOOL; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/bb773313(v=vs.85).aspx
  ///  </summary>
  THelpInfo = record
    cbSize: UINT;
    iContextType: int32;
    iCtrlId: int32;
    hItemHandle: THandle;
    dwContextId: DWORD_PTR;
    MousePos: TPoint;
  end;

  ///  <summary>
  ///   MSDN:
  ///  </summary>
  TMsgBoxCallback = procedure(var lpHelpInfo: THelpInfo); stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms645402(v=vs.85).aspx
  ///  </summary>
  TMsgBoxParamsA = record
    cbSize: UINT;
    hwndOwner: THWND;
    hInstance: THInstance;
    lpszText: LPCSTR;
    lpszCaption: LPCSTR;
    dwStyle: DWORD;
    lpszIcon: LPCSTR;
    dwContextHelpId: DWORD_PTR;
    lpfnMsgBoxCallback: TMsgBoxCallback;
    dwLanguageId: DWORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms645402(v=vs.85).aspx
  ///  </summary>
  TMsgBoxParamsW = record
    cbSize: UINT;
    hwndOwner: THWND;
    hInstance: THInstance;
    lpszText: LPCWSTR;
    lpszCaption: LPCWSTR;
    dwStyle: DWORD;
    lpszIcon: LPCWSTR;
    dwContextHelpId: DWORD_PTR;
    lpfnMsgBoxCallback: TMsgBoxCallback;
    dwLanguageId: DWORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646273(v=vs.85).aspx
  ///  </summary>
  TMouseInput = record
    dx: LONG;
    dy: LONG;
    mouseData: DWORD;
    dwFlags: DWORD;
    time: DWORD;
    dwExtraInfo: ULONG_PTR;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646271(v=vs.85).aspx
  ///  </summary>
  TKeyBdInput = record
    wVk: WORD;
    wScan: WORD;
    dwFlags: DWORD;
    time: DWORD;
    dwExtraInfo: ULONG_PTR;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646269(v=vs.85).aspx
  ///  </summary>
  THardwareInput = record
    uMsg: DWORD;
    wParamL: WORD;
    wParamH: WORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646270(v=vs.85).aspx
  ///  </summary>
  TInput = record
    type_: DWORD;
    case Integer of
      0: (mi: TMouseInput);
      1: (ki: TKeyBdInput);
      2: (hi: THardwareInput);
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms644949(v=vs.85).aspx
  ///  </summary>
  TSendASyncProc = procedure(hwnd: THWND; uMsg: UINT; dwData: ULONG_PTR; lResult: TLRESULT); stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms644907(v=vs.85).aspx
  ///  </summary>
  TTimerProc = procedure(hwnd: THWND; uMsg: UINT; idEvent: UINT_PTR; dwTime: DWORD); stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd373885(v=vs.85).aspx
  ///  </summary>
  TWinEventProc = procedure(hWinEventHook: THWINEVENTHOOK; event: DWORD; hwnd: THWND; idObject, idChild: LONG; idEventThread, dwmsEventTime: DWORD); stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632589(v=vs.85).aspx
  ///  </summary>
  THookProc = function(nCode: Integer; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms645604(v=vs.85).aspx
  ///  </summary>
  TTrackMouseEvent = record
    cbSize: DWORD;
    dwFlags: DWORD;
    hwndTrack: THWND;
    dwHoverTime: DWORD;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms648003(v=vs.85).aspx
  ///  </summary>
  TTPMParams = record
    cbSize: UINT;
    rcExclude: TRECT;
  end;
  PTPMParams = ^TTPMParams;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/bb280362(v=vs.85).aspx
  ///  </summary>
  TPaletteEntry = record
    peRed: BYTE;
    peGreen: BYTE;
    peBlue: BYTE;
    peFlags: BYTE;
  end;
  PPaletteEntry = ^TPaletteEntry;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145228(v=vs.85).aspx
  ///  </summary>
  TXForm = record
    eM11: FLOAT;
    eM12: FLOAT;
    eM21: FLOAT;
    eM22: FLOAT;
    eDx: FLOAT;
    eDy: FLOAT;
  end;
  PXForm = ^TXForm;

  ///  <summary>
  ///   MSDN:  https://msdn.microsoft.com/en-us/library/windows/desktop/dd183371(v=vs.85).aspx
  ///  </summary>
  TBitmap = record
    bmType: LONG;
    bmWidth: LONG;
    bmHeight: LONG;
    bmWidthBytes: LONG;
    bmPlanes: WORD;
    bmBitsPixel: WORD;
    bmBits: LPVOID;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145035(v=vs.85).aspx
  ///  </summary>
  TLogBrush = record
    lbStyle: UINT;
    lbColor: COLORREF;
    lbHatch: ULONG_PTR;
  end;

  ///  <summary>
  ///   MSDN:
  ///  </summary>
  TCIEXYZ = record
    ciexyzX: FXPT2DOT30;
    ciexyzY: FXPT2DOT30;
    ciexyzZ: FXPT2DOT30;
  end;

  ///  <summary>
  ///   MSDN:
  ///  </summary>
  TCIEXYZTriple = record
    ciexyzRed: TCIEXYZ;
    ciexyzGreen: TCIEXYZ;
    ciexyzBlue: TCIEXYZ;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd372165(v=vs.85).aspx
  ///  </summary>
  TLogColorSpaceA = record
    lcsSignature: DWORD;
    lcsVersion: DWORD;
    lcsSize: DWORD;
    lcsCSType: LCSCSTYPE;
    lcsIntent: LCSGAMUTMATCH;
    lcsEndpoints: TCIEXYZTriple;
    lcsGammaRed: DWORD;
    lcsGammaGreen: DWORD;
    lcsGammaBlue: DWORD;
    lcsFilename: array [0..MAX_PATH - 1] of AnsiChar;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd372165(v=vs.85).aspx
  ///  </summary>
  TLogColorSpaceW = record
    lcsSignature: DWORD;
    lcsVersion: DWORD;
    lcsSize: DWORD;
    lcsCSType: LCSCSTYPE;
    lcsIntent: LCSGAMUTMATCH;
    lcsEndpoints: TCIEXYZTriple;
    lcsGammaRed: DWORD;
    lcsGammaGreen: DWORD;
    lcsGammaBlue: DWORD;
    lcsFilename: array [0..MAX_PATH - 1] of WideChar;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183375(v=vs.85).aspx
  ///  </summary>
  TBitmapInfoHeader = record
    biSize: DWORD;
    biWidth: LONG;
    biHeight: LONG;
    biPlanes: WORD;
    biBitCount: WORD;
    biCompression: DWORD;
    biSizeImage: DWORD;
    biXPelsPerMeter: LONG;
    biYPelsPerMeter: LONG;
    biClrUsed: DWORD;
    biClrImportant: DWORD;
  end;

  ///  <summary>
  ///   MSDN:  https://msdn.microsoft.com/en-us/library/windows/desktop/dd162938(v=vs.85).aspx
  ///  </summary>
  TRGBQuad = record
    rgbBlue: BYTE;
    rgbGreen: BYTE;
    rgbRed: BYTE;
    rgbReserved: BYTE;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183375(v=vs.85).aspx
  ///  </summary>
  TBitmapInfo = record
    bmiHeader: TBitmapInfoHeader;
    bmiColors: array [0..0] of TRGBQuad;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145037(v=vs.85).aspx
  ///  </summary>
  TLogFontA = record
    lfHeight: LONG;
    lfWidth: LONG;
    lfEscapement: LONG;
    lfOrientation: LONG;
    lfWeight: LONG;
    lfItalic: BYTE;
    lfUnderline: BYTE;
    lfStrikeOut: BYTE;
    lfCharSet: BYTE;
    lfOutPrecision: BYTE;
    lfClipPrecision: BYTE;
    lfQuality: BYTE;
    lfPitchAndFamily: BYTE;
    lfFaceName: array [0..LF_FACESIZE - 1] of AnsiChar;
  end;
  PLogFontA = ^TLogFontA;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145037(v=vs.85).aspx
  ///  </summary>
  TLogFontW = record
    lfHeight: LONG;
    lfWidth: LONG;
    lfEscapement: LONG;
    lfOrientation: LONG;
    lfWeight: LONG;
    lfItalic: BYTE;
    lfUnderline: BYTE;
    lfStrikeOut: BYTE;
    lfCharSet: BYTE;
    lfOutPrecision: BYTE;
    lfClipPrecision: BYTE;
    lfQuality: BYTE;
    lfPitchAndFamily: BYTE;
    lfFaceName: array [0..LF_FACESIZE - 1] of WideChar;
  end;
  PLogFontW = ^TLogFontW;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183551(v=vs.85).aspx
  ///  </summary>
  TDesignVector = record
    dvReserved: DWORD;
    dvNumAxes: DWORD;
    dvValues: array [0..MM_MAX_NUMAXES - 1] of LONG;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162627(v=vs.85).aspx
  ///  </summary>
  TEnumLogFontExA = record
    elfLogFont: TLogFontA;
    elfFullName: array [0..LF_FULLFACESIZE - 1] of BYTE;
    elfStyle: array [0..LF_FACESIZE - 1] of BYTE;
    elfScript: array [0..LF_FACESIZE - 1] of BYTE;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162627(v=vs.85).aspx
  ///  </summary>
  TEnumLogFontExW = record
    elfLogFont: TLogFontW;
    elfFullName: array [0..LF_FULLFACESIZE - 1] of WideChar;
    elfStyle: array [0..LF_FACESIZE - 1] of WideChar;
    elfScript: array [0..LF_FACESIZE - 1] of WideChar;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162628(v=vs.85).aspx
  ///  </summary>
  TEnumLogFontExDvA = record
    elfEnumLogfontEx: TEnumLogFontExA;
    elfDesignVector: TDesignVector;
  end;
  PEnumLogFontExDvA = ^TEnumLogFontExDvA;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162628(v=vs.85).aspx
  ///  </summary>
  TEnumLogFontExDvW = record
    elfEnumLogfontEx: TEnumLogFontExW;
    elfDesignVector: TDesignVector;
  end;
  PEnumLogFontExDvW = ^TEnumLogFontExDvW;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145040(v=vs.85).aspx
  ///  </summary>
  TLogPalette = record
    palVersion: WORD;
    palNumEntries: WORD;
    palPalEntry: array [0..0] of TPaletteEntry;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/windows/dd145041(v=vs.80)
  ///  </summary>
  TLogPen = record
    lopnStyle: UINT;
    lopnWidth: TPOINT;
    lopnColor: COLORREF;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd144965(v=vs.85).aspx
  ///  </summary>
  THandleTable = record
    objectHandle: array [0..0] of THGDIOBJ;
  end;
  PHandleTable = ^THandleTable;

  ///  <summary>
  ///   MSDN:
  ///  </summary>
  TENHMetaRecord = record
    iType: DWORD; // Record type EMR_XXX
    nSize: DWORD; // Record size in bytes
    dParm: array [0..0] of DWORD; // Parameters
  end;
  PENHMetaRecord = ^TENHMetaRecord;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162606(v=vs.85).aspx
  ///  </summary>
  TEnhMetaFileProc = function(hdc: THDC; lpHTable: PHandleTable; lpEMFR: PENHMetaRecord; nObj: int32; lpData: TLPARAM): Integer; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145132(v=vs.85).aspx
  ///  </summary>
  TTextMetricA = record
    tmHeight: LONG;
    tmAscent: LONG;
    tmDescent: LONG;
    tmInternalLeading: LONG;
    tmExternalLeading: LONG;
    tmAveCharWidth: LONG;
    tmMaxCharWidth: LONG;
    tmWeight: LONG;
    tmOverhang: LONG;
    tmDigitizedAspectX: LONG;
    tmDigitizedAspectY: LONG;
    tmFirstChar: BYTE;
    tmLastChar: BYTE;
    tmDefaultChar: BYTE;
    tmBreakChar: BYTE;
    tmItalic: BYTE;
    tmUnderlined: BYTE;
    tmStruckOut: BYTE;
    tmPitchAndFamily: BYTE;
    tmCharSet: BYTE;
  end;
  PTextMetricA = ^TTextMetricA;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145132(v=vs.85).aspx
  ///  </summary>
  TTextMetricW = record
    tmHeight: LONG;
    tmAscent: LONG;
    tmDescent: LONG;
    tmInternalLeading: LONG;
    tmExternalLeading: LONG;
    tmAveCharWidth: LONG;
    tmMaxCharWidth: LONG;
    tmWeight: LONG;
    tmOverhang: LONG;
    tmDigitizedAspectX: LONG;
    tmDigitizedAspectY: LONG;
    tmFirstChar: WideChar;
    tmLastChar: WideChar;
    tmDefaultChar: WideChar;
    tmBreakChar: WideChar;
    tmItalic: BYTE;
    tmUnderlined: BYTE;
    tmStruckOut: BYTE;
    tmPitchAndFamily: BYTE;
    tmCharSet: BYTE;
  end;
  PTextMetricW = ^TTextMetricW;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162623(v=vs.85).aspx
  ///  </summary>
  TEnumFontsProcA = function(lpelf: PLogFontA; lpntm: PTextMetricA; FontType: DWORD; lParam: TLPARAM): Integer; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162623(v=vs.85).aspx
  ///  </summary>
  TEnumFontsProcW = function(lpelf: PLogFontW; lpntm: PTextMetricW; FontType: DWORD; lParam: TLPARAM): Integer; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/vs/alm/dd316891(v=vs.85).aspx
  ///  </summary>
  TICMEnumProcA = function(lpszFileName: LPSTR; lParam: TLPARAM): Integer; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/vs/alm/dd316891(v=vs.85).aspx
  ///  </summary>
  TICMEnumProcW = function(lpszFileName: LPWSTR; lParam: TLPARAM): Integer; stdcall;

  ///  <summary>
  ///   MSDN:
  ///  </summary>
  TMetaRecord = record
    rdSize: DWORD;
    rdFunction: WORD;
    rdParm: array [0..0] of WORD;
  end;
  PMetaRecord = ^TMetaRecord;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162630(v=vs.85).aspx
  ///  </summary>
  TEnumMetaFileProc = function(hdc: THDC; lpHTable: PHandleTable; lpMFR: PMetaRecord; nObj: Integer; lpClientData: TLPARAM): Integer; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162686(v=vs.85).aspx
  ///  </summary>
  TEnumObjectsProc = function(lpLogObject: LPVOID; lpData: TLPARAM): Integer; stdcall;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162941(v=vs.85).aspx
  ///  </summary>
  TRGNDataHeader = record
    dwSize: DWORD;
    iType: DWORD;
    nCount: DWORD;
    nRgnSize: DWORD;
    rcBound: TRect;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162940(v=vs.85).aspx
  ///  </summary>
  TRGNData = record
    rdh: TRGNDataHeader;
    Buffer: array [0..0] of AnsiChar;
  end;
  PRGNData = ^TRGNData;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145106(v=vs.85).aspx
  ///  </summary>
  TSize = record
    cx: LONG;
    cy: LONG;
  end;
  PSize = ^TSize;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd144842(v=vs.85).aspx
  ///  </summary>
  TGCP_ResultsA = record
    lStructSize: DWORD;
    lpOutString: LPSTR;
    lpOrder: LPUINT;
    lpDx: PINT;
    lpCaretPos: PINT;
    lpClass: LPSTR;
    lpGlyphs: LPWSTR;
    nGlyphs: UINT;
    nMaxFit: Integer;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd144842(v=vs.85).aspx
  ///  </summary>
  TGCP_ResultsW = record
    lStructSize: DWORD;
    lpOutString: LPWSTR;
    lpOrder: LPUINT;
    lpDx: PINT;
    lpCaretPos: PINT;
    lpClass: LPSTR;
    lpGlyphs: LPWSTR;
    nGlyphs: UINT;
    nMaxFit: Integer;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183448(v=vs.85).aspx
  ///  </summary>
  TColorAdjustment = record
    caSize: WORD;
    caFlags: WORD;
    caIlluminantIndex: WORD;
    caRedGamma: WORD;
    caGreenGamma: WORD;
    caBlueGamma: WORD;
    caReferenceBlack: WORD;
    caReferenceWhite: WORD;
    caContrast: SHORT;
    caBrightness: SHORT;
    caColorfulness: SHORT;
    caRedGreenTint: SHORT;
  end;

  ///  <summary>
  ///   MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162607(v=vs.85).aspx
  ///  </summary>
  TEnhMetaHeader = record
    iType: DWORD;
    nSize: DWORD;
    rclBounds: TRect;
    rclFrame: TRect;
    dSignature: DWORD;
    nVersion: DWORD;
    nBytes: DWORD;
    nRecords: DWORD;
    nHandles: WORD ;
    sReserved: WORD ;
    nDescription: DWORD;
    offDescription: DWORD;
    nPalEntries: DWORD;
    szlDevice: TSize;
    szlMillimeters: TSize;
    cbPixelFormat: DWORD;
    offPixelFormat: DWORD;
    bOpenGL: DWORD;
    szlMicrometers: TSize;
  end;
  PEnhMetaHeader = ^TEnhMetaHeader;

  ///  <summary>
  ///    MSDN:
  ///  </summary>
  TWCRange = record
    wcLow: Widechar;
    cGlyphs: USHORT;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd144956(v=vs.85).aspx
  ///  </summary>
  TGlyphSet = record
    cbThis: DWORD;
    flAccel: DWORD;
    cGlyphsSupported: DWORD;
    cRanges: DWORD;
    ranges: array [0..0] of TWCRange;
  end;
  PGlyphSet = ^TGlyphSet;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd144955(v=vs.85).aspx
  ///  </summary>
  TGlyphMetrics = record
    gmBlackBoxX: UINT;
    gmBlackBoxY: UINT;
    gmptGlyphOrigin: TPoint;
    gmCellIncX: short;
    gmCellIncY: short;
  end;

  TFixed = record
    fract: WORD;
    value: short;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145048(v=vs.85).aspx
  ///  </summary>
  TMAT2 = record
    eM11: TFixed;
    eM12: TFixed;
    eM21: TFixed;
    eM22: TFixed;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162891(v=vs.85).aspx
  ///  </summary>
  TRasterizerStatus = record
    nSize: short;
    wFlags: short;
    nLanguageID: short;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd318064(v=vs.85).aspx
  ///  </summary>
  TFontSignature = record
    fsUsb: array [0..3] of DWORD;
    fsCsb: array [0..1] of DWORD;
  end;
  PFontSignature = ^TFontSignature;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd145026(v=vs.85).aspx
  ///  </summary>
  TLineDDAProc = procedure(X, Y: Integer; lpData: TLPARAM); stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162820(v=vs.85).aspx
  ///  </summary>
  TPolyTextA = record
    x: uint32;
    y: uint32;
    n: UINT;
    lpstr: LPCSTR;
    uiFlags: UINT;
    rcl: TRect;
    pdx: PINT;
  end;
  PPolyTextA = ^TPolyTextA;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd162820(v=vs.85).aspx
  ///  </summary>
  TPolyTextW = record
    x: uint32;
    y: uint32;
    n: UINT;
    lpstr: LPCWSTR;
    uiFlags: UINT;
    rcl: TRect;
    pdx: PINT;
  end;
  PPolyTextW = ^TPolyTextW;

  ///  <summary>
  ///    MSDN:  https://msdn.microsoft.com/en-us/library/windows/desktop/dd162459(v=vs.85).aspx
  ///  </summary>
  TAbortProc = function(hdc: THDC; iError: Integer): BOOL; stdcall;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/ms649017(v=vs.85).aspx
  ///  </summary>
  TMetaFilePicT = record
    mm: LONG;
    xExt: LONG;
    yExt: LONG;
    hMF: THMETAFILE;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183574(v=vs.85).aspx
  ///  </summary>
  TDocInfoA = record
    cbSize: Integer;
    lpszDocName: LPCSTR;
    lpszOutput: LPCSTR;
    lpszDatatype: LPCSTR;
    fwType: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd183574(v=vs.85).aspx
  ///  </summary>
  TDocInfoW = record
    cbSize: Integer;
    lpszDocName: LPCWSTR;
    lpszOutput: LPCWSTR;
    lpszDatatype: LPCWSTR;
    fwType: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://msdn.microsoft.com/en-us/library/windows/desktop/dd317750(v=vs.85).aspx
  ///  </summary>
  TCharsetInfo = record
    ciCharset: UINT;
    ciACP: UINT;
    fs: TFontSignature;
  end;

  TSRWLOCK = record
    ptr: pointer;
  end;

  TCONDITION_VARIABLE = TSRWLOCK;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nc-winuser-monitorenumproc
  ///  </summary>
  TMonitorEnumProc = function( Arg1: THMonitor; Arg2: THDC; Arg3: pRect; Arg4: TLPARAM ): longbool; stdcall;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/ns-winuser-tagmonitorinfo
  ///  </summary>
  TMonitorInfo = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
  end;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/ns-winuser-tagmonitorinfoexa
  ///  </summary>
  TMonitorInfoEx = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
    szDevice: array[ 0..pred(CCHDEVICENAME) ] of widechar;
  end;
  pMonitorInfoEx = ^TMonitorInfoEx;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/wingdi/ns-wingdi-taglayerplanedescriptor
  ///  </summary>
  TLAYERPLANEDESCRIPTOR = record
    nSize: word;
    nVersion: word;
    dwFlags: dword;
    iPixelType: byte;
    cColorBits: byte;
    cRedBits: byte;
    cRedShift: byte;
    cGreenBits: byte;
    cGreenShift: byte;
    cBlueBits: byte;
    cBlueShift: byte;
    cAlphaBits: byte;
    cAlphaShift: byte;
    cAccumBits: byte;
    cAccumRedBits: byte;
    cAccumGreenBits: byte;
    cAccumBlueBits: byte;
    cAccumAlphaBits: byte;
    cDepthBits: byte;
    cStencilBits: byte;
    cAuxBuffers: byte;
    iLayerPlane: byte;
    bReserved: byte;
    crTransparent: COLORREF;
  end;
  PLAYERPLANEDESCRIPTOR = ^TLAYERPLANEDESCRIPTOR;


  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/wingdi/ns-wingdi-_pointfloat
  ///  </summary>
  TPointFloat = record
    x: single;
    y: single;
  end;

  ///  <summary>
  ///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/wingdi/ns-wingdi-_glyphmetricsfloat
  ///  </summary>
  TGLYPHMETRICSFLOAT = record
    gmfBlackBoxX: single;
    gmfBlackBoxY: single;
    gmfptGlyphOrigin: TPointFloat;
    gmfCellIncX: single;
    gmfCellIncY: single;
  end;
  PGLYPHMETRICSFLOAT = ^TGLYPHMETRICSFLOAT;

{$endif}
implementation

end.



