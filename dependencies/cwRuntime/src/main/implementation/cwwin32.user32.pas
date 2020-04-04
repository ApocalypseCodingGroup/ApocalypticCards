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
unit cwWin32.User32;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef MSWINDOWS}
uses
 cwWin32.Types
;

const
  cLibName = 'user32.dll';


// USER32.1; Index 1502;		Information not available
// Wow64Transition; Index 1503;		Information not available
// AddClipboardFormatListener; Index 1505;	Information not available
// AdjustWindowRectExForDpi; Index 1508;	Information not available
// AlignRects; Index 1509;		Information not available
// AllowForegroundActivation; Index 1510;	Information not available
// AllowSetForegroundWindow; Index 1511;	Information not available
// AreDpiAwarenessContextsEqual; Index 1516;	Information not available
// BlockInput; Index 1521;		Information not available
// BroadcastSystemMessageExA; Index 1525;	Information not available
// BroadcastSystemMessageExW; Index 1526;	Information not available
// BuildReasonArray; Index 1528;	Information not available
// CalcMenuBar; Index 1529;		Information not available
// CalculatePopupWindowPosition; Index 1530;	Information not available
// CallMsgFilter; Index 1531;		Information not available
// CancelShutdown; Index 1537;		Information not available
// CascadeChildWindows; Index 1538;	Information not available
// ChangeWindowMessageFilter; Index 1547;	Information not available
// ChangeWindowMessageFilterEx; Index 1548;	Information not available
// USER32.49; Index 1550;		Information not available
// USER32.50; Index 1551;		Information not available
// USER32.51; Index 1552;		Information not available
// USER32.52; Index 1553;		Information not available
// USER32.53; Index 1554;		Information not available
// CheckDBCSEnabledExt; Index 1572;	Information not available
// CheckProcessForClipboardAccess; Index 1576;	Information not available
// CheckProcessSession; Index 1577;	Information not available
// CheckWindowThreadDesktop; Index 1579;	Information not available
// CliImmSetHotKey; Index 1582;		Information not available
// ClientThreadSetup; Index 1583;	Information not available
// CloseGestureInfoHandle; Index 1588;	Information not available
// CloseTouchInputHandle; Index 1589;	Information not available
// ConsoleControl; Index 1592;		Information not available
// ControlMagnification; Index 1593;	Information not available
// CreateDCompositionHwndTarget; Index 1604;	Information not available
// CreateDesktopExA; Index 1606;	Information not available
// CreateDesktopExW; Index 1607;	Information not available
// CreateDialogIndirectParamAorW; Index 1610;	Information not available
// CreateSystemThreads; Index 1622;	Information not available
// CreateWindowInBand; Index 1625;	Information not available
// CreateWindowInBandEx; Index 1626;	Information not available
// CreateWindowIndirect; Index 1627;	Information not available
// CsrBroadcastSystemMessageExW; Index 1630;	Information not available
// CtxInitUser32; Index 1631;		Information not available
// DdeGetQualityOfService; Index 1649;	Information not available
// DdeImpersonateClient; Index 1650;	Information not available
// DefRawInputProc; Index 1671;		Information not available
// DeferWindowPosAndBand; Index 1675;	Information not available
// DeregisterShellHookWindow; Index 1677;	Information not available
// DestroyDCompositionHwndTarget; Index 1681;	Information not available
// DestroyReasons; Index 1684;		Information not available
// DialogBoxIndirectParamAorW; Index 1687;	Information not available
// DisableProcessWindowsGhosting; Index 1691;	Information not available
// DisplayConfigGetDeviceInfo; Index 1694;	Information not available
// DisplayConfigSetDeviceInfo; Index 1695;	Information not available
// DisplayExitWindowsWarnings; Index 1696;	Information not available
// DoSoundConnect; Index 1705;		Information not available
// DoSoundDisconnect; Index 1706;	Information not available
// DrawCaptionTempA; Index 1711;	Information not available
// DrawCaptionTempW; Index 1712;	Information not available
// DrawFrame; Index 1715;		Information not available
// DrawMenuBarTemp; Index 1720;		Information not available
// DwmGetDxSharedSurface; Index 1727;	Information not available
// DwmGetRemoteSessionOcclusionEvent; Index 1728;	Information not available
// DwmGetRemoteSessionOcclusionState; Index 1729;	Information not available
// DwmKernelShutdown; Index 1730;	Information not available
// DwmKernelStartup; Index 1731;	Information not available
// DwmLockScreenUpdates; Index 1732;	Information not available
// DwmValidateWindow; Index 1733;	Information not available
// EditWndProc; Index 1734;		Information not available
// EnableMouseInPointer; Index 1737;	Information not available
// EnableNonClientDpiScaling; Index 1738;	Information not available
// EnableSessionForMMCSS; Index 1740;	Information not available
// EndDeferWindowPosEx; Index 1743;	Information not available
// EndTask; Index 1747;			Information not available
// EnterReaderModeHelper; Index 1748;	Information not available
// EnumDisplaySettingsExA; Index 1758;	Information not available
// EnumDisplaySettingsExW; Index 1759;	Information not available
// EvaluateProximityToPolygon; Index 1770;	Information not available
// EvaluateProximityToRect; Index 1771;	Information not available
// FrostCrashedWindow; Index 1783;	Information not available
// GetAltTabInfo; Index 1785;		Information not available
// GetAppCompatFlags2; Index 1789;	Information not available
// GetAppCompatFlags; Index 1790;	Information not available
// GetAutoRotationState; Index 1792;	Information not available
// GetAwarenessFromDpiAwarenessContext; Index 1793;	Information not available
// GetCIMSSM; Index 1794;		Information not available
// GetClipboardAccessToken; Index 1809;	Information not available
// GetCurrentInputMessageSource; Index 1817;	Information not available
// GetCursorFrameInfo; Index 1819;	Information not available
// GetDesktopID; Index 1824;		Information not available
// GetDisplayAutoRotationPreferences; Index 1827;	Information not available
// GetDisplayConfigBufferSizes; Index 1828;	Information not available
// GetDpiForMonitorInternal; Index 1835;	Information not available
// GetDpiForSystem; Index 1836;		Information not available
// GetDpiForWindow; Index 1837;		Information not available
// GetGestureConfig; Index 1841;	Information not available
// GetGestureExtraArgs; Index 1842;	Information not available
// GetGestureInfo; Index 1843;		Information not available
// GetIconInfoExA; Index 1846;		Information not available
// GetIconInfoExW; Index 1847;		Information not available
// GetInputDesktop; Index 1848;		Information not available
// GetInputLocaleInfo; Index 1849;	Information not available
// GetInternalWindowPos; Index 1851;	Information not available
// GetLayeredWindowAttributes; Index 1864;	Information not available
// GetMagnificationDesktopColorEffect; Index 1866;	Information not available
// GetMagnificationDesktopMagnification; Index 1867;	Information not available
// GetMagnificationLensCtxInformation; Index 1868;	Information not available
// GetMonitorInfoA; Index 1888;		Information not available
// GetMouseMovePointsEx; Index 1890;	Information not available
// GetPhysicalCursorPos; Index 1895;	Information not available
// GetPointerCursorId; Index 1896;	Information not available
// GetPointerDevice; Index 1897;	Information not available
// GetPointerDeviceCursors; Index 1898;	Information not available
// GetPointerDeviceProperties; Index 1899;	Information not available
// GetPointerDeviceRects; Index 1900;	Information not available
// GetPointerDevices; Index 1901;	Information not available
// GetPointerFrameArrivalTimes; Index 1902;	Information not available
// GetPointerFrameInfo; Index 1903;	Information not available
// GetPointerFrameInfoHistory; Index 1904;	Information not available
// GetPointerFramePenInfo; Index 1905;	Information not available
// GetPointerFramePenInfoHistory; Index 1906;	Information not available
// GetPointerFrameTouchInfo; Index 1907;	Information not available
// GetPointerFrameTouchInfoHistory; Index 1908;	Information not available
// GetPointerInfo; Index 1909;		Information not available
// GetPointerInfoHistory; Index 1910;	Information not available
// GetPointerInputTransform; Index 1911;	Information not available
// GetPointerPenInfo; Index 1912;	Information not available
// GetPointerPenInfoHistory; Index 1913;	Information not available
// GetPointerTouchInfo; Index 1914;	Information not available
// GetPointerTouchInfoHistory; Index 1915;	Information not available
// GetPointerType; Index 1916;		Information not available
// GetProcessDefaultLayout; Index 1918;	Information not available
// GetProcessDpiAwarenessInternal; Index 1919;	Information not available
// GetProgmanWindow; Index 1921;	Information not available
// GetRawInputBuffer; Index 1925;	Information not available
// GetRawInputData; Index 1926;		Information not available
// GetRawInputDeviceInfoA; Index 1927;	Information not available
// GetRawInputDeviceInfoW; Index 1928;	Information not available
// GetRawInputDeviceList; Index 1929;	Information not available
// GetRawPointerDeviceData; Index 1930;	Information not available
// GetReasonTitleFromReasonCode; Index 1931;	Information not available
// GetRegisteredRawInputDevices; Index 1932;	Information not available
// GetSendMessageReceiver; Index 1937;	Information not available
// GetShellWindow; Index 1938;		Information not available
// GetSystemMetricsForDpi; Index 1944;	Information not available
// GetTaskmanWindow; Index 1947;	Information not available
// GetThreadDpiAwarenessContext; Index 1949;	Information not available
// GetTitleBarInfo; Index 1950;		Information not available
// GetTopLevelWindow; Index 1951;	Information not available
// GetTouchInputInfo; Index 1953;	Information not available
// GetUnpredictedMessagePos; Index 1954;	Information not available
// GetUpdatedClipboardFormats; Index 1957;	Information not available
// GetWinStationInfo; Index 1961;	Information not available
// GetWindowBand; Index 1963;		Information not available
// GetWindowCompositionAttribute; Index 1964;	Information not available
// GetWindowCompositionInfo; Index 1965;	Information not available
// GetWindowDisplayAffinity; Index 1968;	Information not available
// GetWindowDpiAwarenessContext; Index 1969;	Information not available
// GetWindowFeedbackSetting; Index 1970;	Information not available
// GetWindowMinimizeRect; Index 1974;	Information not available
// GetWindowModuleFileName; Index 1975;	Information not available
// GetWindowRgnBox; Index 1981;		Information not available
// GetWindowRgnEx; Index 1982;		Information not available
// GhostWindowFromHungWindow; Index 1989;	Information not available
// HungWindowFromGhostWindow; Index 1994;	Information not available
// IMPGetIMEA; Index 1995;		Information not available
// IMPGetIMEW; Index 1996;		Information not available
// IMPQueryIMEA; Index 1997;		Information not available
// IMPQueryIMEW; Index 1998;		Information not available
// IMPSetIMEA; Index 1999;		Information not available
// IMPSetIMEW; Index 2000;		Information not available
// USER32.500; Index 2001;		Information not available
// USER32.501; Index 2002;		Information not available
// USER32.504; Index 2005;		Information not available
// InheritWindowMonitor; Index 2008;	Information not available
// InitDManipHook; Index 2009;		Information not available
// USER32.509; Index 2010;		Information not available
// InitializeInputDeviceInjection; Index 2011;	Information not available
// InitializeLpkHooks; Index 2012;	Information not available
// InitializePointerDeviceInjection; Index 2013;	Information not available
// InitializeTouchInjection; Index 2014;	Information not available
// InjectDeviceInput; Index 2015;	Information not available
// InjectKeyboardInput; Index 2016;	Information not available
// InjectMouseInput; Index 2017;	Information not available
// InjectPointerInput; Index 2018;	Information not available
// InjectTouchInput; Index 2019;	Information not available
// InternalGetWindowIcon; Index 2024;	Information not available
// InternalGetWindowText; Index 2025;	Information not available
// IsDialogMessage; Index 2040;		Information not available
// IsGUIThread; Index 2044;		Information not available
// IsHungAppWindow; Index 2045;		Information not available
// IsImmersiveProcess; Index 2047;	Information not available
// IsInDesktopWindowBand; Index 2048;	Information not available
// IsMouseInPointerEnabled; Index 2050;	Information not available
// IsProcessDPIAware; Index 2051;	Information not available
// IsQueueAttached; Index 2052;		Information not available
// IsSETEnabled; Index 2054;		Information not available
// IsServerSideWindow; Index 2055;	Information not available
// IsThreadDesktopComposited; Index 2056;	Information not available
// IsTopLevelWindow; Index 2057;	Information not available
// IsTouchWindow; Index 2058;		Information not available
// IsValidDpiAwarenessContext; Index 2059;	Information not available
// IsWinEventHookInstalled; Index 2060;	Information not available
// IsWindowArranged; Index 2062;	Information not available
// IsWindowInDestroy; Index 2064;	Information not available
// IsWindowRedirectedForPrint; Index 2065;	Information not available
// IsWow64Message; Index 2068;		Information not available
// LoadKeyboardLayoutEx; Index 2084;	Information not available
// LoadLocalFonts; Index 2086;		Information not available
// LoadRemoteFonts; Index 2091;		Information not available
// LockSetForegroundWindow; Index 2094;	Information not available
// LockWindowStation; Index 2095;	Information not available
// LogicalToPhysicalPoint; Index 2098;	Information not available
// LogicalToPhysicalPointForPerMonitorDPI; Index 2099;	Information not available
// MBToWCSEx; Index 2102;		Information not available
// MBToWCSExt; Index 2103;		Information not available
// MB_GetString; Index 2104;		Information not available
// MenuWindowProcA; Index 2112;		Information not available
// MenuWindowProcW; Index 2113;		Information not available
// MessageBoxTimeoutA; Index 2120;	Information not available
// MessageBoxTimeoutW; Index 2121;	Information not available
// MonitorFromPoint; Index 2125;	Information not available
// MonitorFromRect; Index 2126;		Information not available
// MonitorFromWindow; Index 2127;	Information not available
// NotifyOverlayWindow; Index 2131;	Information not available
// OpenThreadDesktop; Index 2144;	Information not available
// PackTouchHitTestingProximityEvaluation; Index 2148;	Information not available
// PaintMenuBar; Index 2150;		Information not available
// PaintMonitor; Index 2151;		Information not available
// PhysicalToLogicalPoint; Index 2154;	Information not available
// PhysicalToLogicalPointForPerMonitorDPI; Index 2155;	Information not available
// PrintWindow; Index 2161;		Information not available
// PrivateExtractIconExA; Index 2162;	Information not available
// PrivateExtractIconExW; Index 2163;	Information not available
// PrivateExtractIconsA; Index 2164;	Information not available
// PrivateExtractIconsW; Index 2165;	Information not available
// PrivateRegisterICSProc; Index 2166;	Information not available
// QueryBSDRWindow; Index 2168;		Information not available
// QueryDisplayConfig; Index 2169;	Information not available
// QuerySendMessage; Index 2170;	Information not available
// RIMAddInputObserver; Index 2171;	Information not available
// RIMAreSiblingDevices; Index 2172;	Information not available
// RIMDeviceIoControl; Index 2173;	Information not available
// RIMFreeInputBuffer; Index 2174;	Information not available
// RIMGetDevicePreparsedData; Index 2175;	Information not available
// RIMGetDevicePreparsedDataLockfree; Index 2176;	Information not available
// RIMGetDeviceProperties; Index 2177;	Information not available
// RIMGetPhysicalDeviceRect; Index 2178;	Information not available
// RIMGetSourceProcessId; Index 2179;	Information not available
// RIMObserveNextInput; Index 2180;	Information not available
// RIMOnPnpNotification; Index 2181;	Information not available
// RIMOnTimerNotification; Index 2182;	Information not available
// RIMReadInput; Index 2183;		Information not available
// RIMRegisterForInput; Index 2184;	Information not available
// RIMRemoveInputObserver; Index 2185;	Information not available
// RIMSetTestModeStatus; Index 2186;	Information not available
// RIMUnregisterForInput; Index 2187;	Information not available
// RIMUpdateInputObserverRegistration; Index 2188;	Information not available
// RealGetWindowClass; Index 2190;	Information not available
// ReasonCodeNeedsBugID; Index 2193;	Information not available
// ReasonCodeNeedsComment; Index 2194;	Information not available
// RecordShutdownReason; Index 2195;	Information not available
// RegisterBSDRWindow; Index 2197;	Information not available
// RegisterDManipHook; Index 2204;	Information not available
// RegisterErrorReportingDialog; Index 2207;	Information not available
// RegisterFrostWindow; Index 2208;	Information not available
// RegisterGhostWindow; Index 2209;	Information not available
// RegisterLogonProcess; Index 2211;	Information not available
// RegisterManipulationThread; Index 2212;	Information not available
// RegisterMessagePumpHook; Index 2213;	Information not available
// RegisterPointerDeviceNotifications; Index 2214;	Information not available
// RegisterPointerInputTarget; Index 2215;	Information not available
// RegisterPointerInputTargetEx; Index 2216;	Information not available
// RegisterPowerSettingNotification; Index 2217;	Information not available
// RegisterRawInputDevices; Index 2218;	Information not available
// RegisterServicesProcess; Index 2219;	Information not available
// RegisterSessionPort; Index 2220;	Information not available
// RegisterShellHookWindow; Index 2221;	Information not available
// RegisterSuspendResumeNotification; Index 2222;	Information not available
// RegisterSystemThread; Index 2223;	Information not available
// RegisterTasklist; Index 2224;	Information not available
// RegisterTouchHitTestingWindow; Index 2225;	Information not available
// RegisterTouchWindow; Index 2226;	Information not available
// RegisterUserApiHook; Index 2227;	Information not available
// ReleaseDwmHitTestWaiters; Index 2232;	Information not available
// RemoveClipboardFormatListener; Index 2233;	Information not available
// RemoveInjectionDevice; Index 2234;	Information not available
// ResolveDesktopForWOW; Index 2239;	Information not available
// ScrollChildren; Index 2242;		Information not available
// SendIMEMessageExA; Index 2248;	Information not available
// SendIMEMessageExW; Index 2249;	Information not available
// SetCoalescableTimer; Index 2268;	Information not available
// SetCursorContents; Index 2270;	Information not available
// SetDeskWallpaper; Index 2273;	Information not available
// SetDisplayAutoRotationPreferences; Index 2274;	Information not available
// SetDisplayConfig; Index 2275;	Information not available
// SetFeatureReportResponse; Index 2280;	Information not available
// SetGestureConfig; Index 2283;	Information not available
// SetInternalWindowPos; Index 2284;	Information not available
// SetLayeredWindowAttributes; Index 2287;	Information not available
// SetMagnificationDesktopColorEffect; Index 2288;	Information not available
// SetMagnificationDesktopMagnification; Index 2289;	Information not available
// SetMagnificationLensCtxInformation; Index 2290;	Information not available
// SetManipulationInputTarget; Index 2291;	Information not available
// SetMirrorRendering; Index 2301;	Information not available
// SetPhysicalCursorPos; Index 2303;	Information not available
// SetProcessDPIAware; Index 2304;	Information not available
// SetProcessDefaultLayout; Index 2305;	Information not available
// SetProcessDpiAwarenessContext; Index 2306;	Information not available
// SetProcessDpiAwarenessInternal; Index 2307;	Information not available
// SetProcessRestrictionExemption; Index 2308;	Information not available
// SetProgmanWindow; Index 2310;	Information not available
// SetShellWindow; Index 2318;		Information not available
// SetShellWindowEx; Index 2319;	Information not available
// SetSysColorsTemp; Index 2321;	Information not available
// SetSystemMenu; Index 2323;		Information not available
// SetTaskmanWindow; Index 2324;	Information not available
// SetThreadDpiAwarenessContext; Index 2326;	Information not available
// SetThreadInputBlocked; Index 2327;	Information not available
// SetWindowBand; Index 2333;		Information not available
// SetWindowCompositionAttribute; Index 2334;	Information not available
// SetWindowCompositionTransition; Index 2335;	Information not available
// SetWindowDisplayAffinity; Index 2337;	Information not available
// SetWindowFeedbackSetting; Index 2338;	Information not available
// SetWindowRgnEx; Index 2344;		Information not available
// SetWindowStationUser; Index 2345;	Information not available
// ShowStartGlass; Index 2357;		Information not available
// ShowSystemCursor; Index 2358;	Information not available
// ShutdownBlockReasonCreate; Index 2361;	Information not available
// ShutdownBlockReasonDestroy; Index 2362;	Information not available
// ShutdownBlockReasonQuery; Index 2363;	Information not available
// SignalRedirectionStartComplete; Index 2364;	Information not available
// SkipPointerFrameMessages; Index 2365;	Information not available
// SoftModalMessageBox; Index 2366;	Information not available
// SoundSentry; Index 2367;		Information not available
// SwitchDesktopWithFade; Index 2371;	Information not available
// SwitchToThisWindow; Index 2372;	Information not available
// SystemParametersInfoForDpi; Index 2374;	Information not available
// TileChildWindows; Index 2378;	Information not available
// TranslateAccelerator; Index 2387;	Information not available
// TranslateMessageEx; Index 2392;	Information not available
// UnlockWindowStation; Index 2398;	Information not available
// UnregisterMessagePumpHook; Index 2404;	Information not available
// UnregisterPointerInputTarget; Index 2405;	Information not available
// UnregisterPointerInputTargetEx; Index 2406;	Information not available
// UnregisterPowerSettingNotification; Index 2407;	Information not available
// UnregisterSessionPort; Index 2408;	Information not available
// UnregisterSuspendResumeNotification; Index 2409;	Information not available
// UnregisterTouchWindow; Index 2410;	Information not available
// UnregisterUserApiHook; Index 2411;	Information not available
// UpdateDefaultDesktopThumbnail; Index 2412;	Information not available
// UpdateLayeredWindow; Index 2413;	Information not available
// UpdateLayeredWindowIndirect; Index 2414;	Information not available
// UpdatePerUserSystemParameters; Index 2415;	Information not available
// UpdateWindowInputSinkHints; Index 2417;	Information not available
// UpdateWindowTransform; Index 2418;	Information not available
// User32InitializeImmEntryTable; Index 2419;	Information not available
// UserClientDllInitialize; Index 2420;	Information not available
// UserLpkPSMTextOut; Index 2422;	Information not available
// UserLpkTabbedTextOut; Index 2423;	Information not available
// UserRealizePalette; Index 2424;	Information not available
// UserRegisterWowHandlers; Index 2425;	Information not available
// VRipOutput; Index 2426;		Information not available
// VTagOutput; Index 2427;		Information not available
// WCSToMBEx; Index 2434;		Information not available
// WINNLSEnableIME; Index 2435;		Information not available
// WINNLSGetEnableStatus; Index 2436;	Information not available
// WINNLSGetIMEHotkey; Index 2437;	Information not available
// WaitForRedirectionStartComplete; Index 2439;	Information not available
// WindowFromPhysicalPoint; Index 2444;	Information not available
// _UserTestTokenForInteractive; Index 2446;	Information not available
// gSharedInfo; Index 2447;		Information not available
// gapfnScSendMessage; Index 2448;	Information not available
// USER32.954; Index 2455;		Information not available
// USER32.955; Index 2456;		Information not available
// USER32.956; Index 2457;		Information not available
// USER32.957; Index 2458;		Information not available
// USER32.958; Index 2459;		Information not available
// USER32.959; Index 2460;		Information not available
// USER32.960; Index 2461;		Information not available
// USER32.961; Index 2462;		Information not available
// USER32.962; Index 2463;		Information not available
// USER32.963; Index 2464;		Information not available
// USER32.964; Index 2465;		Information not available
// USER32.965; Index 2466;		Information not available
// USER32.966; Index 2467;		Information not available
// USER32.967; Index 2468;		Information not available
// USER32.968; Index 2469;		Information not available
// USER32.969; Index 2470;		Information not available
// USER32.970; Index 2471;		Information not available
// USER32.971; Index 2472;		Information not available
// USER32.972; Index 2473;		Information not available
// USER32.973; Index 2474;		Information not available
// USER32.974; Index 2475;		Information not available
// USER32.975; Index 2476;		Information not available
// USER32.976; Index 2477;		Information not available
// USER32.977; Index 2478;		Information not available
// USER32.978; Index 2479;		Information not available
// USER32.979; Index 2480;		Information not available
// USER32.980; Index 2481;		Information not available
// USER32.981; Index 2482;		Information not available
// USER32.982; Index 2483;		Information not available
// USER32.983; Index 2484;		Information not available
// USER32.984; Index 2485;		Information not available
// USER32.985; Index 2486;		Information not available
// USER32.986; Index 2487;		Information not available
// USER32.987; Index 2488;		Information not available
// USER32.988; Index 2489;		Information not available
// USER32.989; Index 2490;		Information not available
// USER32.990; Index 2491;		Information not available
// USER32.991; Index 2492;		Information not available
// USER32.992; Index 2493;		Information not available
// USER32.993; Index 2494;		Information not available
// USER32.994; Index 2495;		Information not available
// USER32.995; Index 2496;		Information not available
// USER32.996; Index 2497;		Information not available
// USER32.997; Index 2498;		Information not available
// USER32.998; Index 2499;		Information not available
// USER32.999; Index 2500;		Information not available
// USER32.1000; Index 2501;		Information not available
// USER32.1001; Index 2502;		Information not available
// USER32.1002; Index 2503;		Information not available
// USER32.1003; Index 2504;		Information not available
// USER32.1004; Index 2505;		Information not available
// USER32.1005; Index 2506;		Information not available
// USER32.1006; Index 2507;		Information not available
// USER32.1007; Index 2508;		Information not available
// USER32.1008; Index 2509;		Information not available
// USER32.1009; Index 2510;		Information not available
// USER32.1010; Index 2511;		Information not available
// USER32.1011; Index 2512;		Information not available
// USER32.1012; Index 2513;		Information not available
// USER32.1013; Index 2514;		Information not available
// USER32.1014; Index 2515;		Information not available
// USER32.1015; Index 2516;		Information not available
// USER32.1016; Index 2517;		Information not available
// USER32.1017; Index 2518;		Information not available
// USER32.1018; Index 2519;		Information not available
// USER32.1019; Index 2520;		Information not available
// USER32.1020; Index 2521;		Information not available
// USER32.1021; Index 2522;		Information not available
// USER32.1022; Index 2523;		Information not available
// USER32.1023; Index 2524;		Information not available
// USER32.1024; Index 2525;		Information not available
// USER32.1025; Index 2526;		Information not available
// USER32.1026; Index 2527;		Information not available
// IsThreadMessageQueueAttached; Index 2528;	Information not available
// USER32.1028; Index 2529;		Information not available
// USER32.1029; Index 2530;		Information not available
// USER32.1030; Index 2531;		Information not available
// USER32.1031; Index 2532;		Information not available
// USER32.1032; Index 2533;		Information not available
// USER32.1033; Index 2534;		Information not available
// USER32.1034; Index 2535;		Information not available
// USER32.1035; Index 2536;		Information not available
// USER32.1036; Index 2537;		Information not available
// USER32.1037; Index 2538;		Information not available
// USER32.1038; Index 2539;		Information not available
// USER32.1039; Index 2540;		Information not available
// USER32.1040; Index 2541;		Information not available
// USER32.1041; Index 2542;		Information not available
// USER32.1042; Index 2543;		Information not available
// USER32.1043; Index 2544;		Information not available
// USER32.1044; Index 2545;		Information not available
// USER32.1045; Index 2546;		Information not available
// USER32.1046; Index 2547;		Information not available
// USER32.1047; Index 2548;		Information not available
// USER32.1048; Index 2549;		Information not available
// USER32.1049; Index 2550;		Information not available
// USER32.1050; Index 2551;		Information not available
// USER32.1051; Index 2552;		Information not available
// USER32.1052; Index 2553;		Information not available
// USER32.1053; Index 2554;		Information not available
// USER32.1054; Index 2555;		Information not available
// USER32.1055; Index 2556;		Information not available
// USER32.1056; Index 2557;		Information not available
// USER32.1057; Index 2558;		Information not available
// USER32.1058; Index 2559;		Information not available
// USER32.1059; Index 2560;		Information not available
// USER32.1060; Index 2561;		Information not available
// USER32.1061; Index 2562;		Information not available
// USER32.1062; Index 2563;		Information not available
// USER32.1063; Index 2564;		Information not available
// USER32.1064; Index 2565;		Information not available
// USER32.1065; Index 2566;		Information not available
// USER32.1066; Index 2567;		Information not available
// USER32.1067; Index 2568;		Information not available
// USER32.1068; Index 2569;		Information not available
// USER32.1069; Index 2570;		Information not available
// USER32.1070; Index 2571;		Information not available
// USER32.1071; Index 2572;		Information not available
// USER32.1072; Index 2573;		Information not available
// USER32.1073; Index 2574;		Information not available
// USER32.1074; Index 2575;		Information not available
// USER32.1075; Index 2576;		Information not available
// USER32.1076; Index 2577;		Information not available
// USER32.1077; Index 2578;		Information not available
// USER32.1078; Index 2579;		Information not available
// USER32.1079; Index 2580;		Information not available
// USER32.1080; Index 2581;		Information not available
// USER32.1081; Index 2582;		Information not available
// USER32.1082; Index 2583;		Information not available
// USER32.1083; Index 2584;		Information not available
// USER32.1084; Index 2585;		Information not available
// USER32.1085; Index 2586;		Information not available
// USER32.1086; Index 2587;		Information not available
// USER32.1087; Index 2588;		Information not available
// USER32.1088; Index 2589;		Information not available
// USER32.1089; Index 2590;		Information not available
// USER32.1090; Index 2591;		Information not available
// USER32.1091; Index 2592;		Information not available
// USER32.1092; Index 2593;		Information not available
// USER32.1093; Index 2594;		Information not available
// USER32.1094; Index 2595;		Information not available
// USER32.1095; Index 2596;		Information not available
// USER32.1096; Index 2597;		Information not available
// USER32.1097; Index 2598;		Information not available
// USER32.1098; Index 2599;		Information not available
// USER32.1099; Index 2600;		Information not available
// USER32.1100; Index 2601;		Information not available
// USER32.1101; Index 2602;		Information not available
// USER32.1102; Index 2603;		Information not available
// USER32.1103; Index 2604;		Information not available
// USER32.1104; Index 2605;		Information not available
// USER32.1105; Index 2606;		Information not available
// USER32.1106; Index 2607;		Information not available
// USER32.1107; Index 2608;		Information not available
// USER32.1108; Index 2609;		Information not available
// USER32.1109; Index 2610;		Information not available
// USER32.1110; Index 2611;		Information not available
// USER32.1111; Index 2612;		Information not available
// USER32.1112; Index 2613;		Information not available
// USER32.1113; Index 2614;		Information not available
// USER32.1114; Index 2615;		Information not available
// USER32.1115; Index 2616;		Information not available
// USER32.1116; Index 2617;		Information not available
// USER32.1117; Index 2618;		Information not available
// USER32.1118; Index 2619;		Information not available
// USER32.1119; Index 2620;		Information not available
// USER32.1120; Index 2621;		Information not available
// USER32.1121; Index 2622;		Information not available
// USER32.1122; Index 2623;		Information not available
// USER32.1123; Index 2624;		Information not available
// USER32.1124; Index 2625;		Information not available
// USER32.1125; Index 2626;		Information not available
// USER32.1126; Index 2627;		Information not available
// USER32.1127; Index 2628;		Information not available
// USER32.1128; Index 2629;		Information not available
// USER32.1129; Index 2630;		Information not available
// USER32.1130; Index 2631;		Information not available
// USER32.1131; Index 2632;		Information not available
// USER32.1132; Index 2633;		Information not available
// USER32.1133; Index 2634;		Information not available
// USER32.1134; Index 2635;		Information not available
// USER32.1135; Index 2636;		Information not available
// USER32.1136; Index 2637;		Information not available
// USER32.1137; Index 2638;		Information not available
// USER32.1138; Index 2639;		Information not available
// USER32.1139; Index 2640;		Information not available
// USER32.1140; Index 2641;		Information not available
// USER32.1141; Index 2642;		Information not available
// USER32.1142; Index 2643;		Information not available
// USER32.1143; Index 2644;		Information not available
// USER32.1144; Index 2645;		Information not available
// USER32.1145; Index 2646;		Information not available
// USER32.1146; Index 2647;		Information not available
// USER32.1147; Index 2648;		Information not available
// USER32.1148; Index 2649;		Information not available
// USER32.1149; Index 2650;		Information not available
// USER32.1150; Index 2651;		Information not available
// USER32.1151; Index 2652;		Information not available
// USER32.1152; Index 2653;		Information not available
// USER32.1153; Index 2654;		Information not available
// USER32.1154; Index 2655;		Information not available
// USER32.1155; Index 2656;		Information not available
// USER32.1156; Index 2657;		Information not available
// USER32.1157; Index 2658;		Information not available
// USER32.1158; Index 2659;		Information not available
// USER32.1159; Index 2660;		Information not available
// USER32.1160; Index 2661;		Information not available
// USER32.1161; Index 2662;		Information not available
// USER32.1162; Index 2663;		Information not available
// USER32.1163; Index 2664;		Information not available
// USER32.1164; Index 2665;		Information not available
// USER32.1165; Index 2666;		Information not available
// USER32.1166; Index 2667;		Information not available
// USER32.1167; Index 2668;		Information not available
// USER32.1168; Index 2669;		Information not available
// USER32.1169; Index 2670;		Information not available
// USER32.1170; Index 2671;		Information not available
// USER32.1171; Index 2672;		Information not available
// USER32.1172; Index 2673;		Information not available
// USER32.1173; Index 2674;		Information not available
// USER32.1174; Index 2675;		Information not available
// USER32.1175; Index 2676;		Information not available
// USER32.1176; Index 2677;		Information not available
// USER32.1177; Index 2678;		Information not available
// USER32.1178; Index 2679;		Information not available
// USER32.1179; Index 2680;		Information not available
// USER32.1180; Index 2681;		Information not available
// USER32.1181; Index 2682;		Information not available
// USER32.1182; Index 2683;		Information not available
// USER32.1183; Index 2684;		Information not available
// USER32.1184; Index 2685;		Information not available
// USER32.1185; Index 2686;		Information not available
// USER32.1186; Index 2687;		Information not available
// USER32.1187; Index 2688;		Information not available
// USER32.1188; Index 2689;		Information not available
// USER32.1189; Index 2690;		Information not available
// USER32.1190; Index 2691;		Information not available
// USER32.1191; Index 2692;		Information not available
// USER32.1192; Index 2693;		Information not available
// USER32.1193; Index 2694;		Information not available
// USER32.1194; Index 2695;		Information not available
// USER32.1195; Index 2696;		Information not available
// USER32.1196; Index 2697;		Information not available
// USER32.1197; Index 2698;		Information not available
// USER32.1198; Index 2699;		Information not available
// USER32.1199; Index 2700;		Information not available
// USER32.1200; Index 2701;		Information not available
// USER32.1201; Index 2702;		Information not available
// USER32.1202; Index 2703;		Information not available
// USER32.1203; Index 2704;		Information not available
// USER32.1204; Index 2705;		Information not available
// USER32.1205; Index 2706;		Information not available
// USER32.1206; Index 2707;		Information not available
// USER32.1207; Index 2708;		Information not available


///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-getmonitorinfow
///  </summary>
function GetMonitorInfo( hMonitor: THMonitor; mi: pMonitorInfoEx ): longbool; stdcall; external cLibName name 'GetMonitorInfoW';

///  <summary>
///    MSDN: https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-enumdisplaymonitors
///  </summary>
function EnumDisplayMonitors( hdc: THDC; lprcClip: pRect; lpfnEnum: TMonitorEnumProc; dwParam: TLPARAM ): longbool; stdcall; external cLibName name 'EnumDisplayMonitors';

function ActivateKeyboardLayout(hkl: THKL; Flags: UINT): THKL; stdcall; external cLibName name 'ActivateKeyboardLayout';
function AdjustWindowRect(var lpRect: TRect; dwStyle: DWORD; bMenu: BOOL): BOOL; stdcall; external cLibName name 'AdjustWindowRect';
function AdjustWindowRectEx(var lpRect: TRect; dwStyle: DWORD; bMenu: BOOL; dwExStyle: DWORD): BOOL; stdcall; external cLibName name 'AdjustWindowRectEx';
function AnimateWindow(hWnd: THWND; dwTime: DWORD; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'AnimateWindow';
function AnyPopup: BOOL; stdcall; external cLibName name 'AnyPopup';
function AppendMenu(hMenu: THMENU; uFlags, uIDNewItem: UINT; lpNewItem: PAnsiChar): BOOL; stdcall; external cLibName name 'AppendMenuA';
function AppendMenuW(hMenu: THMENU; uFlags, uIDNewItem: UINT; lpNewItem: PWideChar): BOOL; stdcall; external cLibName name 'AppendMenuW';
function ArrangeIconicWindows(hWnd: THWND): UINT; stdcall; external cLibName name 'ArrangeIconicWindows';
function AttachThreadInput(idAttach, idAttachTo: DWORD; fAttach: BOOL): BOOL; stdcall; external cLibName name 'AttachThreadInput';
function BeginDeferWindowPos(nNumWindows: Integer): THDWP; stdcall; external cLibName name 'BeginDeferWindowPos';
function BeginPaint(hWnd: THWND; var lpPaint: TPaintStruct): THDC; stdcall; external cLibName name 'BeginPaint';
function BringWindowToTop(hWnd: THWND): BOOL; stdcall; external cLibName name 'BringWindowToTop';
function BroadcastSystemMessage(Flags: DWORD; Recipients: PDWORD; uiMessage: UINT; wParam: TWPARAM; lParam: TLPARAM): Longint; stdcall; external cLibName name 'BroadcastSystemMessage';
//function BroadcastSystemMessage(Flags: DWORD; Recipients: PDWORD; uiMessage: UINT; wParam: TWPARAM; lParam: TLPARAM): Longint; stdcall; external cLibName name 'BroadcastSystemMessageA';
//function BroadcastSystemMessage(Flags: DWORD; Recipients: PDWORD; uiMessage: UINT; wParam: TWPARAM; lParam: TLPARAM): Longint; stdcall; external cLibName name 'BroadcastSystemMessageW';
function CallMsgFilter(var lpMsg: TMsg; nCode: Integer): BOOL; stdcall; external cLibName name 'CallMsgFilterA';
function CallMsgFilterW(var lpMsg: TMsg; nCode: Integer): BOOL; stdcall; external cLibName name 'CallMsgFilterW';
function CallNextHookEx(hhk: THHOOK; nCode: Integer; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'CallNextHookEx';
function CallWindowProc(lpPrevWndFunc: TWndProc; hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'CallWindowProcA';
function CallWindowProcW(lpPrevWndFunc: TWndProc; hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'CallWindowProcW';
function CascadeWindows(hwndParent: THWND; wHow: UINT; lpRect: PRect; cKids: UINT; lpKids: Pointer): Word; stdcall; external cLibName name 'CascadeWindows';
function ChangeClipboardChain(hWndRemove, hWndNewNext: THWND): BOOL; stdcall; external cLibName name 'ChangeClipboardChain';
function ChangeDisplaySettings(var lpDevMode: TDeviceModeA; dwFlags: DWORD): Longint; stdcall; external cLibName name 'ChangeDisplaySettingsA';
function ChangeDisplaySettingsEx(lpszDeviceName: PAnsiChar; var lpDevMode: TDeviceModeA; wnd: THWND; dwFlags: DWORD; lParam: Pointer): Longint; stdcall; external cLibName name 'ChangeDisplaySettingsExA';
function ChangeDisplaySettingsExW(lpszDeviceName: PWideChar; var lpDevMode: TDeviceModeW; wnd: THWND; dwFlags: DWORD; lParam: Pointer): Longint; stdcall; external cLibName name 'ChangeDisplaySettingsExW';
function ChangeDisplaySettingsW(var lpDevMode: TDeviceModeW; dwFlags: DWORD): Longint; stdcall; external cLibName name 'ChangeDisplaySettingsW';
function ChangeMenu(hMenu: THMENU; cmd: UINT; lpszNewItem: PAnsiChar; cmdInsert: UINT; flags: UINT): BOOL; stdcall; external cLibName name 'ChangeMenuA';
function ChangeMenuW(hMenu: THMENU; cmd: UINT; lpszNewItem: PWideChar; cmdInsert: UINT; flags: UINT): BOOL; stdcall; external cLibName name 'ChangeMenuW';
function CharLower(lpsz: PAnsiChar): PAnsiChar; stdcall; external cLibName name 'CharLowerA';
function CharLowerBuff(lpsz: PAnsiChar; cchLength: DWORD): DWORD; stdcall; external cLibName name 'CharLowerBuffA';
function CharLowerBuffW(lpsz: PWideChar; cchLength: DWORD): DWORD; stdcall; external cLibName name 'CharLowerBuffW';
function CharLowerW(lpsz: PWideChar): PWideChar; stdcall; external cLibName name 'CharLowerW';
function CharNext(lpsz: PAnsiChar): PAnsiChar; stdcall; external cLibName name 'CharNextA';
function CharNextEx(CodePage: Word; lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external cLibName name 'CharNextExA';
function CharNextW(lpsz: PWideChar): PWideChar; stdcall; external cLibName name 'CharNextW';
function CharPrev(lpszStart: PAnsiChar; lpszCurrent: PAnsiChar): PAnsiChar; stdcall; external cLibName name 'CharPrevA';
function CharPrevEx(CodePage: Word; lpStart, lpCurrentChar: LPCSTR; dwFlags: DWORD): LPSTR; stdcall; external cLibName name 'CharPrevExA';
function CharPrevW(lpszStart: PWideChar; lpszCurrent: PWideChar): PWideChar; stdcall; external cLibName name 'CharPrevW';
function CharToOem(lpszSrc: PAnsiChar; lpszDst: PAnsiChar): BOOL; stdcall; external cLibName name 'CharToOemA';
function CharToOemBuff(lpszSrc: PAnsiChar; lpszDst: PAnsiChar; cchDstLength: DWORD): BOOL; stdcall; external cLibName name 'CharToOemBuffA';
function CharToOemBuffW(lpszSrc: PWideChar; lpszDst: PWideChar; cchDstLength: DWORD): BOOL; stdcall; external cLibName name 'CharToOemBuffW';
function CharToOemW(lpszSrc: PWideChar; lpszDst: PWideChar): BOOL; stdcall; external cLibName name 'CharToOemW';
function CharUpper(lpsz: PAnsiChar): PAnsiChar; stdcall; external cLibName name 'CharUpperA';
function CharUpperBuff(lpsz: PAnsiChar; cchLength: DWORD): DWORD; stdcall; external cLibName name 'CharUpperBuffA';
function CharUpperBuffW(lpsz: PWideChar; cchLength: DWORD): DWORD; stdcall; external cLibName name 'CharUpperBuffW';
function CharUpperW(lpsz: PWideChar): PWideChar; stdcall; external cLibName name 'CharUpperW';
function CheckDlgButton(hDlg: THWND; nIDButton: Integer; uCheck: UINT): BOOL; stdcall; external cLibName name 'CheckDlgButton';
function CheckMenuItem(hMenu: THMENU; uIDCheckItem, uCheck: UINT): DWORD; stdcall; external cLibName name 'CheckMenuItem';
function CheckMenuRadioItem(hMenu: THMENU; First, Last, Check, Flags: UINT): BOOL; stdcall; external cLibName name 'CheckMenuRadioItem';
function CheckRadioButton(hDlg: THWND; nIDFirstButton, nIDLastButton, nIDCheckButton: Integer): BOOL; stdcall; external cLibName name 'CheckRadioButton';
function ChildWindowFromPoint(hWndParent: THWND; Point: TPoint): THWND; stdcall; external cLibName name 'ChildWindowFromPoint';
function ChildWindowFromPointEx(hWnd: THWND; Point: TPoint; Flags: UINT): THWND; stdcall; external cLibName name 'ChildWindowFromPointEx';
function ClientToScreen(hWnd: THWND; var lpPoint: TPoint): BOOL; stdcall; external cLibName name 'ClientToScreen';
function ClipCursor(lpRect: PRect): BOOL; stdcall; external cLibName name 'ClipCursor';
function CloseClipboard: BOOL; stdcall; external cLibName name 'CloseClipboard';
function CloseDesktop(hDesktop: THDESK): BOOL; stdcall; external cLibName name 'CloseDesktop';
function CloseWindow(hWnd: THWND): BOOL; stdcall; external cLibName name 'CloseWindow';
function CloseWindowStation(hWinSta: THWINSTA): BOOL; stdcall; external cLibName name 'CloseWindowStation';
function CopyAcceleratorTable(hAccelSrc: THACCEL; var lpAccelDst; cAccelEntries: Integer): Integer; stdcall; external cLibName name 'CopyAcceleratorTableA';
function CopyAcceleratorTableW(hAccelSrc: THACCEL; var lpAccelDst; cAccelEntries: Integer): Integer; stdcall; external cLibName name 'CopyAcceleratorTableW';
function CopyIcon(hIcon: THICON): THICON; stdcall; external cLibName name 'CopyIcon';
function CopyImage(hImage: THandle; ImageType: UINT; X, Y: Integer; Flags: UINT): THandle; stdcall; external cLibName name 'CopyImage';
function CopyRect(var lprcDst: TRect; const lprcSrc: TRect): BOOL; stdcall; external cLibName name 'CopyRect';
function CountClipboardFormats: Integer; stdcall; external cLibName name 'CountClipboardFormats';
function CreateAcceleratorTable(var Accel; Count: Integer): THACCEL; stdcall; external cLibName name 'CreateAcceleratorTableA';
function CreateAcceleratorTableW(var Accel; Count: Integer): THACCEL; stdcall; external cLibName name 'CreateAcceleratorTableW';
function CreateCaret(hWnd: THWND; hBitmap: THBITMAP; nWidth, nHeight: Integer): BOOL; stdcall; external cLibName name 'CreateCaret';
function CreateCursor(hInst: THINST; xHotSpot, yHotSpot, nWidth, nHeight: Integer; pvANDPlaneter, pvXORPlane: Pointer): THCURSOR; stdcall; external cLibName name 'CreateCursor';
function CreateDesktop(lpszDesktop, lpszDevice: PAnsiChar; pDevmode: PDeviceModeA; dwFlags: DWORD; dwDesiredAccess: DWORD; lpsa: PSecurityAttributes): THDESK; stdcall; external cLibName name 'CreateDesktopA';
function CreateDesktopW(lpszDesktop, lpszDevice: PWideChar; pDevmode: PDeviceModeW; dwFlags: DWORD; dwDesiredAccess: DWORD; lpsa: PSecurityAttributes): THDESK; stdcall; external cLibName name 'CreateDesktopW';
function CreateDialogIndirectParam(hInstance: THINST; const lpTemplate: TDlgTemplate; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): THWND; stdcall; external cLibName name 'CreateDialogIndirectParamA';
function CreateDialogIndirectParamW(hInstance: THINST; const lpTemplate: TDlgTemplate; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): THWND; stdcall; external cLibName name 'CreateDialogIndirectParamW';
function CreateDialogParam(hInstance: THINST; lpTemplateName: PAnsiChar; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): THWND; stdcall; external cLibName name 'CreateDialogParamA';
function CreateDialogParamW(hInstance: THINST; lpTemplateName: PWideChar; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): THWND; stdcall; external cLibName name 'CreateDialogParamW';
function CreateIcon(hInstance: THINST; nWidth, nHeight: Integer; cPlanes, cBitsPixel: Byte; lpbANDbits, lpbXORbits: Pointer): THICON; stdcall; external cLibName name 'CreateIcon';
function CreateIconFromResource(presbits: PByte; dwResSize: DWORD; fIcon: BOOL; dwVer: DWORD): THICON; stdcall; external cLibName name 'CreateIconFromResource';
function CreateIconFromResourceEx(presbits: PByte; dwResSize: DWORD; fIcon: BOOL; dwVer: DWORD; cxDesired, cyDesired: Integer; Flags: UINT): THICON; stdcall; external cLibName name 'CreateIconFromResourceEx';
function CreateIconIndirect(var piconinfo: TIconInfo): THICON; stdcall; external cLibName name 'CreateIconIndirect';
function CreateMDIWindow(lpClassName, lpWindowName: PAnsiChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer; hWndParent: THWND; hInstance: THINST; lParam: TLPARAM): THWND; stdcall; external cLibName name 'CreateMDIWindowA';
function CreateMDIWindowW(lpClassName, lpWindowName: PWideChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer; hWndParent: THWND; hInstance: THINST; lParam: TLPARAM): THWND; stdcall; external cLibName name 'CreateMDIWindowW';
function CreateMenu: THMENU; stdcall; external cLibName name 'CreateMenu';
function CreatePopupMenu: THMENU; stdcall; external cLibName name 'CreatePopupMenu';
function CreateWindowEx(dwExStyle: DWORD; lpClassName: PAnsiChar; lpWindowName: PAnsiChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer; hWndParent: THWND; hMenu: THMENU; hInstance: THINST; lpParam: Pointer): THWND; stdcall; external cLibName name 'CreateWindowExA';
function CreateWindowExW(dwExStyle: DWORD; lpClassName: PWideChar; lpWindowName: PWideChar; dwStyle: DWORD; X, Y, nWidth, nHeight: Integer; hWndParent: THWND; hMenu: THMENU; hInstance: THINST; lpParam: Pointer): THWND; stdcall; external cLibName name 'CreateWindowExW';
function CreateWindowStation(lpwinsta: PAnsiChar; dwReserved, dwDesiredAccess: DWORD; lpsa: PSecurityAttributes): THWINSTA; stdcall; external cLibName name 'CreateWindowStationA';
function CreateWindowStationW(lpwinsta: PWideChar; dwReserved, dwDesiredAccess: DWORD; lpsa: PSecurityAttributes): THWINSTA; stdcall; external cLibName name 'CreateWindowStationW';
function DdeAbandonTransaction(Inst: DWORD; Conv: THConv; Transaction: DWORD): BOOL; stdcall; external cLibName name 'DdeAbandonTransaction';
function DdeAccessData(Data: THDDEData; DataSize: PDWORD): Pointer; stdcall; external cLibName name 'DdeAccessData';
function DdeAddData(Data: THDDEData; Src: Pointer; cb, Off: DWORD): THDDEData; stdcall; external cLibName name 'DdeAddData';
function DdeClientTransaction(Data: Pointer; DataLen: DWORD; Conv: THConv; Item: THSZ; Fmt, DataType: UINT; Timeout: DWORD; Result: PDWORD): THDDEData; stdcall; external cLibName name 'DdeClientTransaction';
function DdeCmpStringHandles(hsz1, hsz2: THSZ): Integer; stdcall; external cLibName name 'DdeCmpStringHandles';
function DdeConnect(Inst: DWORD; Service, Topic: THSZ; CC: PConvContext): THConv; stdcall; external cLibName name 'DdeConnect';
function DdeConnectList(Inst: DWORD; Service, Topic: THSZ; ConvList: THConvList; CC: PConvContext): THConvList; stdcall; external cLibName name 'DdeConnectList';
function DdeCreateDataHandle(Inst: DWORD; Src: Pointer; cb, Off: DWORD; Item: THSZ; Fmt, Cmd: UINT): THDDEData; stdcall; external cLibName name 'DdeCreateDataHandle';
function DdeCreateStringHandle(Inst: DWORD; psz: PAnsiChar; CodePage: Integer): THSZ; stdcall; external cLibName name 'DdeCreateStringHandleA';
function DdeCreateStringHandleW(Inst: DWORD; psz: PWideChar; CodePage: Integer): THSZ; stdcall; external cLibName name 'DdeCreateStringHandleW';
function DdeDisconnect(Conv: THConv): BOOL; stdcall; external cLibName name 'DdeDisconnect';
function DdeDisconnectList(ConvList: THConvList): BOOL; stdcall; external cLibName name 'DdeDisconnectList';
function DdeEnableCallback(Inst: DWORD; Conv: THConv; Cmd: UINT): BOOL; stdcall; external cLibName name 'DdeEnableCallback';
function DdeFreeDataHandle(Data: THDDEData): BOOL; stdcall; external cLibName name 'DdeFreeDataHandle';
function DdeFreeStringHandle(Inst: DWORD; HSZ: THSZ): BOOL; stdcall; external cLibName name 'DdeFreeStringHandle';
function DdeGetData(Data: THDDEData; Dst: Pointer; Max, Off: DWORD): DWORD; stdcall; external cLibName name 'DdeGetData';
function DdeGetLastError(Inst: DWORD): UINT; stdcall; external cLibName name 'DdeGetLastError';
function DdeInitialize(var Inst: Longint; Callback: TDDECallback; Cmd, Res: Longint): Longint; stdcall; external cLibName name 'DdeInitializeA';
function DdeInitializeW(var Inst: Longint; Callback: TDDECallback; Cmd, Res: Longint): Longint; stdcall; external cLibName name 'DdeInitializeW';
function DdeKeepStringHandle(Inst: DWORD; HSZ: THSZ): BOOL; stdcall; external cLibName name 'DdeKeepStringHandle';
function DdeNameService(Inst: DWORD; hsz1, hsz2: THSZ; Cmd: UINT): THDDEData; stdcall; external cLibName name 'DdeNameService';
function DdePostAdvise(Inst: DWORD; Topic, Item: THSZ): BOOL; stdcall; external cLibName name 'DdePostAdvise';
function DdeQueryConvInfo(Conv: THConv; Transaction: DWORD; ConvInfo: PConvInfo): UINT; stdcall; external cLibName name 'DdeQueryConvInfo';
function DdeQueryNextServer(ConvList: THConvList; ConvPrev: THConv): THConv; stdcall; external cLibName name 'DdeQueryNextServer';
function DdeQueryString(Inst: DWORD; HSZ: THSZ; psz: PAnsiChar; Max: DWORD; CodePage: Integer): DWORD; stdcall; external cLibName name 'DdeQueryStringA';
function DdeQueryStringW(Inst: DWORD; HSZ: THSZ; psz: PWideChar; Max: DWORD; CodePage: Integer): DWORD; stdcall; external cLibName name 'DdeQueryStringW';
function DdeReconnect(Conv: THConv): THConv; stdcall; external cLibName name 'DdeReconnect';
function DdeSetQualityOfService(hWndClient: THWnd; const pqosNew: TSECURITY_QUALITY_OF_SERVICE; pqosPrev: PSECURITY_QUALITY_OF_SERVICE): BOOL; stdcall; external cLibName name 'DdeSetQualityOfService';
function DdeSetUserHandle(Conv: THConv; ID, User: DWORD): BOOL; stdcall; external cLibName name 'DdeSetUserHandle';
function DdeUnaccessData(Data: THDDEData): BOOL; stdcall; external cLibName name 'DdeUnaccessData';
function DdeUninitialize(Inst: DWORD): BOOL; stdcall; external cLibName name 'DdeUninitialize';
function DefDlgProc(hDlg: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefDlgProcA';
function DefDlgProcW(hDlg: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefDlgProcW';
function DefFrameProc(hWnd, hWndMDIClient: THWND; uMsg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefFrameProcA';
function DefFrameProcW(hWnd, hWndMDIClient: THWND; uMsg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefFrameProcW';
function DefMDIChildProc(hWnd: THWND; uMsg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefMDIChildProcA';
function DefMDIChildProcW(hWnd: THWND; uMsg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefMDIChildProcW';
function DefWindowProc(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefWindowProcA';
function DefWindowProcW(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'DefWindowProcW';
function DeferWindowPos(hWinPosInfo: THDWP; hWnd: THWND; hWndInsertAfter: THWND; x, y, cx, cy: Integer; uFlags: UINT): THDWP; stdcall; external cLibName name 'DeferWindowPos';
function DeleteMenu(hMenu: THMENU; uPosition, uFlags: UINT): BOOL; stdcall; external cLibName name 'DeleteMenu';
function DestroyAcceleratorTable(hAccel: THACCEL): BOOL; stdcall; external cLibName name 'DestroyAcceleratorTable';
function DestroyCaret: BOOL; stdcall; external cLibName name 'DestroyCaret';
function DestroyCursor(hCursor: THICON): BOOL; stdcall; external cLibName name 'DestroyCursor';
function DestroyIcon(hIcon: THICON): BOOL; stdcall; external cLibName name 'DestroyIcon';
function DestroyMenu(hMenu: THMENU): BOOL; stdcall; external cLibName name 'DestroyMenu';
function DestroyWindow(hWnd: THWND): BOOL; stdcall; external cLibName name 'DestroyWindow';
function DialogBoxIndirectParam(hInstance: THINST; const lpDialogTemplate: TDlgTemplate; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): Integer; stdcall; external cLibName name 'DialogBoxIndirectParamA';
function DialogBoxIndirectParamW(hInstance: THINST; const lpDialogTemplate: TDlgTemplate; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): Integer; stdcall; external cLibName name 'DialogBoxIndirectParamW';
function DialogBoxParam(hInstance: THINST; lpTemplateName: PAnsiChar; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): Integer; stdcall; external cLibName name 'DialogBoxParamA';
function DialogBoxParamW(hInstance: THINST; lpTemplateName: PWideChar; hWndParent: THWND; lpDialogFunc: TDlgProc; dwInitParam: TLPARAM): Integer; stdcall; external cLibName name 'DialogBoxParamW';
function DispatchMessage(const lpMsg: TMsg): Longint; stdcall; external cLibName name 'DispatchMessageA';
function DispatchMessageW(const lpMsg: TMsg): Longint; stdcall; external cLibName name 'DispatchMessageW';
function DlgDirList(hDlg: THWND; lpPathSpec: PAnsiChar; nIDListBox, nIDStaticPath: Integer; uFileType: UINT): Integer; stdcall; external cLibName name 'DlgDirListA';
function DlgDirListComboBox(hDlg: THWND; lpPathSpec: PAnsiChar; nIDComboBox, nIDStaticPath: Integer; uFiletype: UINT): Integer; stdcall; external cLibName name 'DlgDirListComboBoxA';
function DlgDirListComboBoxW(hDlg: THWND; lpPathSpec: PWideChar; nIDComboBox, nIDStaticPath: Integer; uFiletype: UINT): Integer; stdcall; external cLibName name 'DlgDirListComboBoxW';
function DlgDirListW(hDlg: THWND; lpPathSpec: PWideChar; nIDListBox, nIDStaticPath: Integer; uFileType: UINT): Integer; stdcall; external cLibName name 'DlgDirListW';
function DlgDirSelectComboBoxEx(hDlg: THWND; lpString: PAnsiChar; nCount, nIDComboBox: Integer): BOOL; stdcall; external cLibName name 'DlgDirSelectComboBoxExA';
function DlgDirSelectComboBoxExW(hDlg: THWND; lpString: PWideChar; nCount, nIDComboBox: Integer): BOOL; stdcall; external cLibName name 'DlgDirSelectComboBoxExW';
function DlgDirSelectEx(hDlg: THWND; lpString: PAnsiChar; nCount, nIDListBox: Integer): BOOL; stdcall; external cLibName name 'DlgDirSelectExA';
function DlgDirSelectExW(hDlg: THWND; lpString: PWideChar; nCount, nIDListBox: Integer): BOOL; stdcall; external cLibName name 'DlgDirSelectExW';
function DragDetect(p1: THWND; p2: TPoint): BOOL; stdcall; external cLibName name 'DragDetect';
function DragObject(p1, p2: THWND; p3: UINT; p4: DWORD; p5: THICON): DWORD; stdcall; external cLibName name 'DragObject';
function DrawAnimatedRects(hwnd: THWND; idAni: Integer; const lprcFrom, lprcTo: TRect): BOOL; stdcall; external cLibName name 'DrawAnimatedRects';
function DrawCaption(p1: THWND; p2: THDC; const p3: TRect; p4: UINT): BOOL; stdcall; external cLibName name 'DrawCaption';
function DrawEdge(hdc: THDC; var qrc: TRect; edge: UINT; grfFlags: UINT): BOOL; stdcall; external cLibName name 'DrawEdge';
function DrawFocusRect(hDC: THDC; const lprc: TRect): BOOL; stdcall; external cLibName name 'DrawFocusRect';
function DrawFrameControl(DC: THDC; const Rect: TRect; uType, uState: UINT): BOOL; stdcall; external cLibName name 'DrawFrameControl';
function DrawIcon(hDC: THDC; X, Y: Integer; hIcon: THICON): BOOL; stdcall; external cLibName name 'DrawIcon';
function DrawIconEx(hdc: THDC; xLeft, yTop: Integer; hIcon: THICON; cxWidth, cyWidth: Integer; istepIfAniCur: UINT; hbrFlickerFreeDraw: THBRUSH; diFlags: UINT): BOOL; stdcall; external cLibName name 'DrawIconEx';
function DrawMenuBar(hWnd: THWND): BOOL; stdcall; external cLibName name 'DrawMenuBar';
function DrawState(DC: THDC; p2: THBRUSH; p3: TDrawStateProc; p4: TLPARAM; p5: TWPARAM; p6, p7, p8, p9: Integer; p10: UINT): BOOL; stdcall; external cLibName name 'DrawStateA';
function DrawStateW(DC: THDC; p2: THBRUSH; p3: TDrawStateProc; p4: TLPARAM; p5: TWPARAM; p6, p7, p8, p9: Integer; p10: UINT): BOOL; stdcall; external cLibName name 'DrawStateW';
function DrawText(hDC: THDC; lpString: PAnsiChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer; stdcall; external cLibName name 'DrawTextA';
function DrawTextEx(DC: THDC; lpchText: PAnsiChar; cchText: Integer; var p4: TRect; dwDTFormat: UINT; DTParams: PDrawTextParams): Integer; stdcall; external cLibName name 'DrawTextExA';
function DrawTextExW(DC: THDC; lpchText: PWideChar; cchText: Integer; var p4: TRect; dwDTFormat: UINT; DTParams: PDrawTextParams): Integer; stdcall; external cLibName name 'DrawTextExW';
function DrawTextW(hDC: THDC; lpString: PWideChar; nCount: Integer; var lpRect: TRect; uFormat: UINT): Integer; stdcall; external cLibName name 'DrawTextW';
function EmptyClipboard: BOOL; stdcall; external cLibName name 'EmptyClipboard';
function EnableMenuItem(hMenu: THMENU; uIDEnableItem, uEnable: UINT): BOOL; stdcall; external cLibName name 'EnableMenuItem';
function EnableScrollBar(hWnd: THWND; wSBflags, wArrows: UINT): BOOL; stdcall; external cLibName name 'EnableScrollBar';
function EnableWindow(hWnd: THWND; bEnable: BOOL): BOOL; stdcall; external cLibName name 'EnableWindow';
function EndDeferWindowPos(hWinPosInfo: THDWP): BOOL; stdcall; external cLibName name 'EndDeferWindowPos';
function EndDialog(hDlg: THWND; nResult: Integer): BOOL; stdcall; external cLibName name 'EndDialog';
function EndMenu: BOOL; stdcall; external cLibName name 'EndMenu';
function EndPaint(hWnd: THWND; const lpPaint: TPaintStruct): BOOL; stdcall; external cLibName name 'EndPaint';
function EnumChildWindows(hWndParent: THWND; lpEnumFunc: TWndEnumProc; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumChildWindows';
function EnumClipboardFormats(format: UINT): UINT; stdcall; external cLibName name 'EnumClipboardFormats';
function EnumDesktopWindows(hDesktop: THDESK; lpfn: TWndEnumProc; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumDesktopWindows';
function EnumDesktops(hwinsta: THWINSTA; lpEnumFunc: TDeskTopEnumProcA; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumDesktopsA';
function EnumDesktopsW(hwinsta: THWINSTA; lpEnumFunc: TDeskTopEnumProcW; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumDesktopsW';
function EnumDisplayDevices(Unused: Pointer; iDevNum: DWORD; var lpDisplayDevice: TDisplayDeviceA; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumDisplayDevicesA';
function EnumDisplayDevicesW(Unused: Pointer; iDevNum: DWORD; var lpDisplayDevice: TDisplayDeviceW; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'EnumDisplayDevicesW';
function EnumDisplaySettings(lpszDeviceName: PAnsiChar; iModeNum: DWORD; var lpDevMode: TDeviceModeA): BOOL; stdcall; external cLibName name 'EnumDisplaySettingsA';
function EnumDisplaySettingsW(lpszDeviceName: PWideChar; iModeNum: DWORD; var lpDevMode: TDeviceModeW): BOOL; stdcall; external cLibName name 'EnumDisplaySettingsW';
function EnumProps(hWnd: THWND; lpEnumFunc: TPropEnumProcA): Integer; stdcall; external cLibName name 'EnumPropsA';
function EnumPropsEx(hWnd: THWND; lpEnumFunc: TPropEnumProcExA; lParam: TLPARAM): Integer; stdcall; external cLibName name 'EnumPropsExA';
function EnumPropsExW(hWnd: THWND; lpEnumFunc: TPropEnumProcExW; lParam: TLPARAM): Integer; stdcall; external cLibName name 'EnumPropsExW';
function EnumPropsW(hWnd: THWND; lpEnumFunc: TPropEnumProcW): Integer; stdcall; external cLibName name 'EnumPropsW';
function EnumThreadWindows(dwThreadId: DWORD; lpfn: TWndEnumProc; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumThreadWindows';
function EnumWindowStations(lpEnumFunc: TEnumWinStatProcA; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumWindowStationsA';
function EnumWindowStationsW(lpEnumFunc: TEnumWinStatProcW; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumWindowStationsW';
function EnumWindows(lpEnumFunc: TWndEnumProc; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'EnumWindows';
function EqualRect(const lprc1, lprc2: TRect): BOOL; stdcall; external cLibName name 'EqualRect';
function ExcludeUpdateRgn(hDC: THDC; hWnd: THWND): Integer; stdcall; external cLibName name 'ExcludeUpdateRgn';
function ExitWindowsEx(uFlags: UINT; dwReserved: DWORD): BOOL; stdcall; external cLibName name 'ExitWindowsEx';
function FillRect(hDC: THDC; const lprc: TRect; hbr: THBRUSH): Integer; stdcall; external cLibName name 'FillRect';
function FindWindow(lpClassName, lpWindowName: PAnsiChar): THWND; stdcall; external cLibName name 'FindWindowA';
function FindWindowEx(Parent, Child: THWND; ClassName, WindowName: PAnsiChar): THWND; stdcall; external cLibName name 'FindWindowExA';
function FindWindowExW(Parent, Child: THWND; ClassName, WindowName: PWideChar): THWND; stdcall; external cLibName name 'FindWindowExW';
function FindWindowW(lpClassName, lpWindowName: PWideChar): THWND; stdcall; external cLibName name 'FindWindowW';
function FlashWindow(hWnd: THWND; bInvert: BOOL): BOOL; stdcall; external cLibName name 'FlashWindow';
function FlashWindowEx(var pfwi: TFlashWInfo): BOOL; stdcall; external cLibName name 'FlashWindowEx';
function FrameRect(hDC: THDC; const lprc: TRect; hbr: THBRUSH): Integer; stdcall; external cLibName name 'FrameRect';
function FreeDDElParam(msg: UINT; lParam: Longint): BOOL; stdcall; external cLibName name 'FreeDDElParam';
function GetActiveWindow: THWND; stdcall; external cLibName name 'GetActiveWindow';
function GetAltTabInfo(hwnd: THWND; iItem: Integer; var pati: TAltTabInfo; pszItemText: PAnsiChar; cchItemText: UINT): BOOL; stdcall; external cLibName name 'GetAltTabInfoA';
function GetAltTabInfoW(hwnd: THWND; iItem: Integer; var pati: TAltTabInfo; pszItemText: PWideChar; cchItemText: UINT): BOOL; stdcall; external cLibName name 'GetAltTabInfoW';
function GetAncestor(hwnd: THWND; gaFlags: UINT): THWND; stdcall; external cLibName name 'GetAncestor';
function GetAsyncKeyState(vKey: Integer): SHORT; stdcall; external cLibName name 'GetAsyncKeyState';
function GetCapture: THWND; stdcall; external cLibName name 'GetCapture';
function GetCaretBlinkTime: UINT; stdcall; external cLibName name 'GetCaretBlinkTime';
function GetCaretPos(var lpPoint: TPoint): BOOL; stdcall; external cLibName name 'GetCaretPos';
function GetClassInfo(hInstance: THINST; lpClassName: PAnsiChar; var lpWndClass: TWndClassA): BOOL; stdcall; external cLibName name 'GetClassInfoA';
function GetClassInfoEx(Instance: THINST; Classname: PAnsiChar; var WndClass: TWndClassExA): BOOL; stdcall; external cLibName name 'GetClassInfoExA';
function GetClassInfoExW(Instance: THINST; Classname: PWideChar; var WndClass: TWndClassExW): BOOL; stdcall; external cLibName name 'GetClassInfoExW';
function GetClassInfoW(hInstance: THINST; lpClassName: PWideChar; var lpWndClass: TWndClassW): BOOL; stdcall; external cLibName name 'GetClassInfoW';
function GetClassLong(hWnd: THWND; nIndex: Integer): DWORD; stdcall; external cLibName name 'GetClassLongA';
function GetClassLongW(hWnd: THWND; nIndex: Integer): DWORD; stdcall; external cLibName name 'GetClassLongW';
function GetClassName(hWnd: THWND; lpClassName: PAnsiChar; nMaxCount: Integer): Integer; stdcall; external cLibName name 'GetClassNameA';
function GetClassNameW(hWnd: THWND; lpClassName: PWideChar; nMaxCount: Integer): Integer; stdcall; external cLibName name 'GetClassNameW';
function GetClassWord(hWnd: THWND; nIndex: Integer): Word; stdcall; external cLibName name 'GetClassWord';
function GetClientRect(hWnd: THWND; var lpRect: TRect): BOOL; stdcall; external cLibName name 'GetClientRect';
function GetClipCursor(var lpRect: TRect): BOOL; stdcall; external cLibName name 'GetClipCursor';
function GetClipboardData(uFormat: UINT): THandle; stdcall; external cLibName name 'GetClipboardData';
function GetClipboardFormatName(format: UINT; lpszFormatName: PAnsiChar; cchMaxCount: Integer): Integer; stdcall; external cLibName name 'GetClipboardFormatNameA';
function GetClipboardFormatNameW(format: UINT; lpszFormatName: PWideChar; cchMaxCount: Integer): Integer; stdcall; external cLibName name 'GetClipboardFormatNameW';
function GetClipboardOwner: THWND; stdcall; external cLibName name 'GetClipboardOwner';
function GetClipboardSequenceNumber: DWORD; stdcall; external cLibName name 'GetClipboardSequenceNumber';
function GetClipboardViewer: THWND; stdcall; external cLibName name 'GetClipboardViewer';
function GetComboBoxInfo(hwndCombo: THWND; var pcbi: TComboBoxInfo): BOOL; stdcall; external cLibName name 'GetComboBoxInfo';
function GetCursor: THCURSOR; stdcall; external cLibName name 'GetCursor';
function GetCursorInfo(var pci: TCursorInfo): BOOL; stdcall; external cLibName name 'GetCursorInfo';
function GetCursorPos(var lpPoint: TPoint): BOOL; stdcall; external cLibName name 'GetCursorPos';
function GetDC(hWnd: THWND): THDC; stdcall; external cLibName name 'GetDC';
function GetDCEx(hWnd: THWND; hrgnClip: THRGN; flags: DWORD): THDC; stdcall; external cLibName name 'GetDCEx';
function GetDesktopWindow: THWND; stdcall; external cLibName name 'GetDesktopWindow';
function GetDialogBaseUnits: Longint; stdcall; external cLibName name 'GetDialogBaseUnits';
function GetDlgCtrlID(hWnd: THWND): Integer; stdcall; external cLibName name 'GetDlgCtrlID';
function GetDlgItem(hDlg: THWND; nIDDlgItem: Integer): THWND; stdcall; external cLibName name 'GetDlgItem';
function GetDlgItemInt(hDlg: THWND; nIDDlgItem: Integer; var lpTranslated: BOOL; bSigned: BOOL): UINT; stdcall; external cLibName name 'GetDlgItemInt';
function GetDlgItemText(hDlg: THWND; nIDDlgItem: Integer; lpString: PAnsiChar; nMaxCount: Integer): UINT; stdcall; external cLibName name 'GetDlgItemTextA';
function GetDlgItemTextW(hDlg: THWND; nIDDlgItem: Integer; lpString: PWideChar; nMaxCount: Integer): UINT; stdcall; external cLibName name 'GetDlgItemTextW';
function GetDoubleClickTime: UINT; stdcall; external cLibName name 'GetDoubleClickTime';
function GetFocus: THWND; stdcall; external cLibName name 'GetFocus';
function GetForegroundWindow: THWND; stdcall; external cLibName name 'GetForegroundWindow';
function GetGUIThreadInfo(idThread: DWORD; var pgui: TGUIThreadinfo): BOOL; stdcall; external cLibName name 'GetGUIThreadInfo';
function GetGuiResources(hProcess: THandle; uiFlags: DWORD): DWORD; stdcall; external cLibName name 'GetGuiResources';
function GetIconInfo(hIcon: THICON; var piconinfo: TIconInfo): BOOL; stdcall; external cLibName name 'GetIconInfo';
function GetInputState: BOOL; stdcall; external cLibName name 'GetInputState';
function GetKBCodePage: UINT; stdcall; external cLibName name 'GetKBCodePage';
function GetKeyNameText(lParam: Longint; lpString: PAnsiChar; nSize: Integer): Integer; stdcall; external cLibName name 'GetKeyNameTextA';
function GetKeyNameTextW(lParam: Longint; lpString: PWideChar; nSize: Integer): Integer; stdcall; external cLibName name 'GetKeyNameTextW';
function GetKeyState(nVirtKey: Integer): SHORT; stdcall; external cLibName name 'GetKeyState';
function GetKeyboardLayout(dwLayout: DWORD): THKL; stdcall; external cLibName name 'GetKeyboardLayout';
function GetKeyboardLayoutList(nBuff: Integer; var List): UINT; stdcall; external cLibName name 'GetKeyboardLayoutList';
function GetKeyboardLayoutName(pwszKLID: PAnsiChar): BOOL; stdcall; external cLibName name 'GetKeyboardLayoutNameA';
function GetKeyboardLayoutNameW(pwszKLID: PWideChar): BOOL; stdcall; external cLibName name 'GetKeyboardLayoutNameW';
function GetKeyboardState(var KeyState: uint8): BOOL; stdcall; external cLibName name 'GetKeyboardState';
function GetKeyboardType(nTypeFlag: Integer): Integer; stdcall; external cLibName name 'GetKeyboardType';
function GetLastActivePopup(hWnd: THWND): THWND; stdcall; external cLibName name 'GetLastActivePopup';
function GetLastInputInfo(var plii: TLastInputInfo): BOOL; stdcall; external cLibName name 'GetLastInputInfo';
function GetListBoxInfo(hwnd: THWND): DWORD; stdcall; external cLibName name 'GetListBoxInfo';
function GetMenu(hWnd: THWND): THMENU; stdcall; external cLibName name 'GetMenu';
function GetMenuBarInfo(hend: THWND; idObject, idItem: Longint; var pmbi: TMenuBarInfo): BOOL; stdcall; external cLibName name 'GetMenuBarInfo';
function GetMenuCheckMarkDimensions: Longint; stdcall; external cLibName name 'GetMenuCheckMarkDimensions';
function GetMenuContextHelpId(hMenu: THMENU): DWORD; stdcall; external cLibName name 'GetMenuContextHelpId';
function GetMenuDefaultItem(hMenu: THMENU; fByPos, gmdiFlags: UINT): UINT; stdcall; external cLibName name 'GetMenuDefaultItem';
function GetMenuInfo(hMenu: THMENU; var lpmi: TMenuInfo): BOOL; stdcall; external cLibName name 'GetMenuInfo';
function GetMenuItemCount(hMenu: THMENU): Integer; stdcall; external cLibName name 'GetMenuItemCount';
function GetMenuItemID(hMenu: THMENU; nPos: Integer): UINT; stdcall; external cLibName name 'GetMenuItemID';
function GetMenuItemInfo(p1: THMENU; p2: UINT; p3: BOOL; var p4: TMenuItemInfoA): BOOL; stdcall; external cLibName name 'GetMenuItemInfoA';
function GetMenuItemInfoW(p1: THMENU; p2: UINT; p3: BOOL; var p4: TMenuItemInfoW): BOOL; stdcall; external cLibName name 'GetMenuItemInfoW';
function GetMenuItemRect(hWnd: THWND; hMenu: THMENU; uItem: UINT; var lprcItem: TRect): BOOL; stdcall; external cLibName name 'GetMenuItemRect';
function GetMenuState(hMenu: THMENU; uId, uFlags: UINT): UINT; stdcall; external cLibName name 'GetMenuState';
function GetMenuString(hMenu: THMENU; uIDItem: UINT; lpString: PAnsiChar; nMaxCount: Integer; uFlag: UINT): Integer; stdcall; external cLibName name 'GetMenuStringA';
function GetMenuStringW(hMenu: THMENU; uIDItem: UINT; lpString: PWideChar; nMaxCount: Integer; uFlag: UINT): Integer; stdcall; external cLibName name 'GetMenuStringW';
function GetMessage(var lpMsg: TMsg; hWnd: THWND; wMsgFilterMin, wMsgFilterMax: UINT): BOOL; stdcall; external cLibName name 'GetMessageA';
function GetMessageExtraInfo: Longint; stdcall; external cLibName name 'GetMessageExtraInfo';
function GetMessagePos: DWORD; stdcall; external cLibName name 'GetMessagePos';
function GetMessageTime: Longint; stdcall; external cLibName name 'GetMessageTime';
function GetMessageW(var lpMsg: TMsg; hWnd: THWND; wMsgFilterMin, wMsgFilterMax: UINT): BOOL; stdcall; external cLibName name 'GetMessageW';
function GetNextDlgGroupItem(hDlg: THWND; hCtl: THWND; bPrevious: BOOL): THWND; stdcall; external cLibName name 'GetNextDlgGroupItem';
function GetNextDlgTabItem(hDlg: THWND; hCtl: THWND; bPrevious: BOOL): THWND; stdcall; external cLibName name 'GetNextDlgTabItem';
function GetOpenClipboardWindow: THWND; stdcall; external cLibName name 'GetOpenClipboardWindow';
function GetParent(hWnd: THWND): THWND; stdcall; external cLibName name 'GetParent';
function GetPriorityClipboardFormat(var paFormatPriorityList; cFormats: Integer): Integer; stdcall; external cLibName name 'GetPriorityClipboardFormat';
function GetProcessWindowStation: THWINSTA; stdcall; external cLibName name 'GetProcessWindowStation';
function GetProp(hWnd: THWND; lpString: PAnsiChar): THandle; stdcall; external cLibName name 'GetPropA';
function GetPropW(hWnd: THWND; lpString: PWideChar): THandle; stdcall; external cLibName name 'GetPropW';
function GetQueueStatus(flags: UINT): DWORD; stdcall; external cLibName name 'GetQueueStatus';
function GetScrollBarInfo(hwnd: THWND; idObject: Longint; var psbi: TScrollBarInfo): BOOL; stdcall; external cLibName name 'GetScrollBarInfo';
function GetScrollInfo(hWnd: THWND; BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL; stdcall; external cLibName name 'GetScrollInfo';
function GetScrollPos(hWnd: THWND; nBar: Integer): Integer; stdcall; external cLibName name 'GetScrollPos';
function GetScrollRange(hWnd: THWND; nBar: Integer; var lpMinPos, lpMaxPos: Integer): BOOL; stdcall; external cLibName name 'GetScrollRange';
function GetSubMenu(hMenu: THMENU; nPos: Integer): THMENU; stdcall; external cLibName name 'GetSubMenu';
function GetSysColor(nIndex: Integer): DWORD; stdcall; external cLibName name 'GetSysColor';
function GetSysColorBrush(nIndex: Integer): THBRUSH; stdcall; external cLibName name 'GetSysColorBrush';
function GetSystemMenu(hWnd: THWND; bRevert: BOOL): THMENU; stdcall; external cLibName name 'GetSystemMenu';
function GetSystemMetrics(nIndex: Integer): Integer; stdcall; external cLibName name 'GetSystemMetrics';
function GetTabbedTextExtent(hDC: THDC; lpString: PAnsiChar; nCount, nTabPositions: Integer; var lpnTabStopPositions): DWORD; stdcall; external cLibName name 'GetTabbedTextExtentA';
function GetTabbedTextExtentW(hDC: THDC; lpString: PWideChar; nCount, nTabPositions: Integer; var lpnTabStopPositions): DWORD; stdcall; external cLibName name 'GetTabbedTextExtentW';
function GetThreadDesktop(dwThreadId: DWORD): THDESK; stdcall; external cLibName name 'GetThreadDesktop';
function GetTopWindow(hWnd: THWND): THWND; stdcall; external cLibName name 'GetTopWindow';
function GetUpdateRect(hWnd: THWND; var lpRect: TRect; bErase: BOOL): BOOL; stdcall; external cLibName name 'GetUpdateRect';
function GetUpdateRgn(hWnd: THWND; hRgn: THRGN; bErase: BOOL): Integer; stdcall; external cLibName name 'GetUpdateRgn';
function GetUserObjectInformation(hObj: THandle; nIndex: Integer; pvInfo: Pointer; nLength: DWORD; var lpnLengthNeeded: DWORD): BOOL; stdcall; external cLibName name 'GetUserObjectInformationA';
function GetUserObjectInformationW(hObj: THandle; nIndex: Integer; pvInfo: Pointer; nLength: DWORD; var lpnLengthNeeded: DWORD): BOOL; stdcall; external cLibName name 'GetUserObjectInformationW';
function GetUserObjectSecurity(hObj: THandle; var pSIRequested: DWORD; pSID: PSecurityDescriptor; nLength: DWORD; var lpnLengthNeeded: DWORD): BOOL; stdcall; external cLibName name 'GetUserObjectSecurity';
function GetWindow(hWnd: THWND; uCmd: UINT): THWND; stdcall; external cLibName name 'GetWindow';
function GetWindowContextHelpId(hWnd: THWND): DWORD; stdcall; external cLibName name 'GetWindowContextHelpId';
function GetWindowDC(hWnd: THWND): THDC; stdcall; external cLibName name 'GetWindowDC';
function GetWindowInfo(hwnd: THWND; var pwi: TWindowInfo): BOOL; stdcall; external cLibName name 'GetWindowInfo';
function GetWindowLong(hWnd: THWND; nIndex: Integer): Longint; stdcall; external cLibName name 'GetWindowLongA';
function GetWindowLongW(hWnd: THWND; nIndex: Integer): Longint; stdcall; external cLibName name 'GetWindowLongW';
function GetWindowModuleFileName(hwnd: THWND; pszFileName: PAnsiChar; cchFileNameMax: UINT): UINT; stdcall; external cLibName name 'GetWindowModuleFileNameA';
function GetWindowModuleFileNameW(hwnd: THWND; pszFileName: PAnsiChar; cchFileNameMax: UINT): UINT; stdcall; external cLibName name 'GetWindowModuleFileNameW';
function GetWindowPlacement(hWnd: THWND; WindowPlacement: PWindowPlacement): BOOL; stdcall; external cLibName name 'GetWindowPlacement';
function GetWindowRect(hWnd: THWND; var lpRect: TRect): BOOL; stdcall; external cLibName name 'GetWindowRect';
function GetWindowRgn(hWnd: THWND; hRgn: THRGN): Integer; stdcall; external cLibName name 'GetWindowRgn';
function GetWindowText(hWnd: THWND; lpString: PAnsiChar; nMaxCount: Integer): Integer; stdcall; external cLibName name 'GetWindowTextA';
function GetWindowTextLength(hWnd: THWND): Integer; stdcall; external cLibName name 'GetWindowTextLengthA';
function GetWindowTextLengthW(hWnd: THWND): Integer; stdcall; external cLibName name 'GetWindowTextLengthW';
function GetWindowTextW(hWnd: THWND; lpString: PWideChar; nMaxCount: Integer): Integer; stdcall; external cLibName name 'GetWindowTextW';
function GetWindowThreadProcessId(hWnd: THWND; lpdwProcessId: Pointer): DWORD; stdcall; external cLibName name 'GetWindowThreadProcessId';
function GetWindowWord(hWnd: THWND; nIndex: Integer): Word; stdcall; external cLibName name 'GetWindowWord';
function GrayString(hDC: THDC; hBrush: THBRUSH; lpOutputFunc: TOutputProc; lpData: TLPARAM; nCount, X, Y, nWidth, nHeight: Integer): BOOL; stdcall; external cLibName name 'GrayStringA';
function GrayStringW(hDC: THDC; hBrush: THBRUSH; lpOutputFunc: TOutputProc; lpData: TLPARAM; nCount, X, Y, nWidth, nHeight: Integer): BOOL; stdcall; external cLibName name 'GrayStringW';
function HideCaret(hWnd: THWND): BOOL; stdcall; external cLibName name 'HideCaret';
function HiliteMenuItem(hWnd: THWND; hMenu: THMENU; uIDHiliteItem: UINT; uHilite: UINT): BOOL; stdcall; external cLibName name 'HiliteMenuItem';
function ImpersonateDdeClientWindow(hWndClient: THWND; hWndServer: THWND): BOOL; stdcall; external cLibName name 'ImpersonateDdeClientWindow';
function InSendMessage: BOOL; stdcall; external cLibName name 'InSendMessage';
function InSendMessageeX(lpReserved: Pointer): DWORD; stdcall; external cLibName name 'InSendMessageeX';
function InflateRect(var lprc: TRect; dx, dy: Integer): BOOL; stdcall; external cLibName name 'InflateRect';
function InsertMenu(hMenu: THMENU; uPosition, uFlags, uIDNewItem: UINT; lpNewItem: PAnsiChar): BOOL; stdcall; external cLibName name 'InsertMenuA';
function InsertMenuItem(p1: THMENU; p2: UINT; p3: BOOL; const p4: TMenuItemInfoA): BOOL; stdcall; external cLibName name 'InsertMenuItemA';
function InsertMenuItemW(p1: THMENU; p2: UINT; p3: BOOL; const p4: TMenuItemInfoW): BOOL; stdcall; external cLibName name 'InsertMenuItemW';
function InsertMenuW(hMenu: THMENU; uPosition, uFlags, uIDNewItem: UINT; lpNewItem: PWideChar): BOOL; stdcall; external cLibName name 'InsertMenuW';
function IntersectRect(var lprcDst: TRect; const lprcSrc1, lprcSrc2: TRect): BOOL; stdcall; external cLibName name 'IntersectRect';
function InvalidateRect(hWnd: THWND; lpRect: PRect; bErase: BOOL): BOOL; stdcall; external cLibName name 'InvalidateRect';
function InvalidateRgn(hWnd: THWND; hRgn: THRGN; bErase: BOOL): BOOL; stdcall; external cLibName name 'InvalidateRgn';
function InvertRect(hDC: THDC; const lprc: TRect): BOOL; stdcall; external cLibName name 'InvertRect';
function IsCharAlpha(ch: AnsiChar): BOOL; stdcall; external cLibName name 'IsCharAlphaA';
function IsCharAlphaNumeric(ch: AnsiChar): BOOL; stdcall; external cLibName name 'IsCharAlphaNumericA';
function IsCharAlphaNumericW(ch: WideChar): BOOL; stdcall; external cLibName name 'IsCharAlphaNumericW';
function IsCharAlphaW(ch: WideChar): BOOL; stdcall; external cLibName name 'IsCharAlphaW';
function IsCharLower(ch: AnsiChar): BOOL; stdcall; external cLibName name 'IsCharLowerA';
function IsCharLowerW(ch: WideChar): BOOL; stdcall; external cLibName name 'IsCharLowerW';
function IsCharUpper(ch: AnsiChar): BOOL; stdcall; external cLibName name 'IsCharUpperA';
function IsCharUpperW(ch: WideChar): BOOL; stdcall; external cLibName name 'IsCharUpperW';
function IsChild(hWndParent, hWnd: THWND): BOOL; stdcall; external cLibName name 'IsChild';
function IsClipboardFormatAvailable(format: UINT): BOOL; stdcall; external cLibName name 'IsClipboardFormatAvailable';
function IsDialogMessage(hDlg: THWND; var lpMsg: TMsg): BOOL; stdcall; external cLibName name 'IsDialogMessageA';
function IsDialogMessageW(hDlg: THWND; var lpMsg: TMsg): BOOL; stdcall; external cLibName name 'IsDialogMessageW';
function IsDlgButtonChecked(hDlg: THWND; nIDButton: Integer): UINT; stdcall;external cLibName name 'IsDlgButtonChecked';
function IsIconic(hWnd: THWND): BOOL; stdcall; external cLibName name 'IsIconic';
function IsMenu(hMenu: THMENU): BOOL; stdcall; external cLibName name 'IsMenu';
function IsRectEmpty(const lprc: TRect): BOOL; stdcall; external cLibName name 'IsRectEmpty';
function IsWindow(hWnd: THWND): BOOL; stdcall; external cLibName name 'IsWindow';
function IsWindowEnabled(hWnd: THWND): BOOL; stdcall; external cLibName name 'IsWindowEnabled';
function IsWindowUnicode(hWnd: THWND): BOOL; stdcall; external cLibName name 'IsWindowUnicode';
function IsWindowVisible(hWnd: THWND): BOOL; stdcall; external cLibName name 'IsWindowVisible';
function IsZoomed(hWnd: THWND): BOOL; stdcall; external cLibName name 'IsZoomed';
function KillTimer(hWnd: THWND; uIDEvent: UINT): BOOL; stdcall; external cLibName name 'KillTimer';
function LoadAccelerators(hInstance: THINST; lpTableName: PAnsiChar): THACCEL; stdcall; external cLibName name 'LoadAcceleratorsA';
function LoadAcceleratorsW(hInstance: THINST; lpTableName: PWideChar): THACCEL; stdcall; external cLibName name 'LoadAcceleratorsW';
function LoadBitmap(hInstance: THINST; lpBitmapName: PAnsiChar): THBITMAP; stdcall; external cLibName name 'LoadBitmapA';
function LoadBitmapW(THINSTance: THINST; lpBitmapName: PAnsiChar): THBITMAP; stdcall; external cLibName name 'LoadBitmapW';
function LoadCursor(THINSTance: THINST; lpCursorName: PAnsiChar): THCURSOR; stdcall; external cLibName name 'LoadCursorA';
function LoadCursorFromFile(lpFileName: PAnsiChar): THCURSOR; stdcall; external cLibName name 'LoadCursorFromFileA';
function LoadCursorFromFileW(lpFileName: PAnsiChar): THCURSOR; stdcall; external cLibName name 'LoadCursorFromFileW';
function LoadCursorW(THINSTance: THINST; lpCursorName: PWideChar): THCURSOR; stdcall; external cLibName name 'LoadCursorW';
function LoadIcon(THINSTance: THINST; lpIconName: PAnsiChar): THICON; stdcall; external cLibName name 'LoadIconA';
function LoadIconW(THINSTance: THINST; lpIconName: PWideChar): THICON; stdcall; external cLibName name 'LoadIconW';
function LoadImage(THINST: THINST; ImageName: PAnsiChar; ImageType: UINT; X, Y: Integer; Flags: UINT): THandle; stdcall; external cLibName name 'LoadImageA';
function LoadImageW(THINST: THINST; ImageName: PWideChar; ImageType: UINT; X, Y: Integer; Flags: UINT): THandle; stdcall; external cLibName name 'LoadImageW';
function LoadKeyboardLayout(pwszKLID: PAnsiChar; Flags: UINT): THKL; stdcall; external cLibName name 'LoadKeyboardLayoutA';
function LoadKeyboardLayoutW(pwszKLID: PWideChar; Flags: UINT): THKL; stdcall; external cLibName name 'LoadKeyboardLayoutW';
function LoadMenu(THINSTance: THINST; lpMenuName: PAnsiChar): THMENU; stdcall; external cLibName name 'LoadMenuA';
function LoadMenuIndirect(lpMenuTemplate: Pointer): THMENU; stdcall; external cLibName name 'LoadMenuIndirectA';
function LoadMenuIndirectW(lpMenuTemplate: Pointer): THMENU; stdcall; external cLibName name 'LoadMenuIndirectW';
function LoadMenuW(THINSTance: THINST; lpMenuName: PAnsiChar): THMENU; stdcall; external cLibName name 'LoadMenuW';
function LoadString(THINSTance: THINST; uID: UINT; lpBuffer: PAnsiChar; nBufferMax: Integer): Integer; stdcall; external cLibName name 'LoadStringA';
function LoadStringW(THINSTance: THINST; uID: UINT; lpBuffer: PWideChar; nBufferMax: Integer): Integer; stdcall; external cLibName name 'LoadStringW';
function LockWindowUpdate(hWndLock: THWND): BOOL; stdcall; external cLibName name 'LockWindowUpdate';
function LockWorkStation: BOOL; stdcall; external cLibName name 'LockWorkStation';
function LookupIconIdFromDirectory(presbits: PByte; fIcon: BOOL): Integer; stdcall; external cLibName name 'LookupIconIdFromDirectory';
function LookupIconIdFromDirectoryEx(presbits: PByte; fIcon: BOOL; cxDesired, cyDesired: Integer; Flags: UINT): Integer; stdcall; external cLibName name 'LookupIconIdFromDirectoryEx';
function MapDialogRect(hDlg: THWND; var lpRect: TRect): BOOL; stdcall; external cLibName name 'MapDialogRect';
function MapVirtualKey(uCode, uMapType: UINT): UINT; stdcall; external cLibName name 'MapVirtualKeyA';
function MapVirtualKeyEx(uCode, uMapType: UINT; dwhkl: THKL): UINT; stdcall; external cLibName name 'MapVirtualKeyExA';
function MapVirtualKeyExW(uCode, uMapType: UINT; dwhkl: THKL): UINT; stdcall; external cLibName name 'MapVirtualKeyExW';
function MapVirtualKeyW(uCode, uMapType: UINT): UINT; stdcall; external cLibName name 'MapVirtualKeyW';
function MapWindowPoints(hWndFrom, hWndTo: THWND; var lpPoints; cPoints: UINT): Integer; stdcall; external cLibName name 'MapWindowPoints';
function MenuItemFromPoint(hWnd: THWND; hMenu: THMENU; ptScreen: TPoint): BOOL; stdcall; external cLibName name 'MenuItemFromPoint';
function MessageBeep(uType: UINT): BOOL; stdcall; external cLibName name 'MessageBeep';
function MessageBox(hWnd: THWND; lpText, lpCaption: PAnsiChar; uType: UINT): Integer; stdcall; external cLibName name 'MessageBoxA';
function MessageBoxEx(hWnd: THWND; lpText, lpCaption: PAnsiChar; uType: UINT; wLanguageId: Word): Integer; stdcall; external cLibName name 'MessageBoxExA';
function MessageBoxExW(hWnd: THWND; lpText, lpCaption: PWideChar; uType: UINT; wLanguageId: Word): Integer; stdcall; external cLibName name 'MessageBoxExW';
function MessageBoxIndirect(const MsgBoxParams: TMsgBoxParamsA): BOOL; stdcall; external cLibName name 'MessageBoxIndirectA';
function MessageBoxIndirectW(const MsgBoxParams: TMsgBoxParamsW): BOOL; stdcall; external cLibName name 'MessageBoxIndirectW';
function MessageBoxW(hWnd: THWND; lpText, lpCaption: PWideChar; uType: UINT): Integer; stdcall; external cLibName name 'MessageBoxW';
function ModifyMenu(hMnu: THMENU; uPosition, uFlags, uIDNewItem: UINT; lpNewItem: PAnsiChar): BOOL; stdcall; external cLibName name 'ModifyMenuA';
function ModifyMenuW(hMnu: THMENU; uPosition, uFlags, uIDNewItem: UINT; lpNewItem: PWideChar): BOOL; stdcall; external cLibName name 'ModifyMenuW';
function MoveWindow(hWnd: THWND; X, Y, nWidth, nHeight: Integer; bRepaint: BOOL): BOOL; stdcall; external cLibName name 'MoveWindow';
function MsgWaitForMultipleObjects(nCount: DWORD; var pHandles; fWaitAll: BOOL; dwMilliseconds, dwWakeMask: DWORD): DWORD; stdcall; external cLibName name 'MsgWaitForMultipleObjects';
function MsgWaitForMultipleObjectsEx(nCount: DWORD; var pHandles; dwMilliseconds, dwWakeMask, dwFlags: DWORD): DWORD; stdcall; external cLibName name 'MsgWaitForMultipleObjectsEx';
procedure NotifyWinEvent(event: DWORD; hwnd: THWND; idObject, idChild: Longint); external cLibName name 'NotifyWinEvent';
function OemKeyScan(wOemChar: Word): DWORD; stdcall; external cLibName name 'OemKeyScan';
function OemToChar(lpszSrc: PAnsiChar; lpszDst: PAnsiChar): BOOL; stdcall; external cLibName name 'OemToCharA';
function OemToCharBuff(lpszSrc: PAnsiChar; lpszDst: PAnsiChar; cchDstLength: DWORD): BOOL; stdcall; external cLibName name 'OemToCharBuffA';
function OemToCharBuffW(lpszSrc: PWideChar; lpszDst: PWideChar; cchDstLength: DWORD): BOOL; stdcall; external cLibName name 'OemToCharBuffW';
function OemToCharW(lpszSrc: PWideChar; lpszDst: PWideChar): BOOL; stdcall; external cLibName name 'OemToCharW';
function OffsetRect(var lprc: TRect; dx, dy: Integer): BOOL; stdcall; external cLibName name 'OffsetRect';
function OpenClipboard(hWndNewOwner: THWND): BOOL; stdcall; external cLibName name 'OpenClipboard';
function OpenDesktop(lpszDesktop: PAnsiChar; dwFlags: DWORD; fInherit: BOOL; dwDesiredAccess: DWORD): THDESK; stdcall; external cLibName name 'OpenDesktopA';
function OpenDesktopW(lpszDesktop: PWideChar; dwFlags: DWORD; fInherit: BOOL; dwDesiredAccess: DWORD): THDESK; stdcall; external cLibName name 'OpenDesktopW';
function OpenIcon(hWnd: THWND): BOOL; stdcall; external cLibName name 'OpenIcon';
function OpenInputDesktop(dwFlags: DWORD; fInherit: BOOL; dwDesiredAccess: DWORD): THDESK; stdcall; external cLibName name 'OpenInputDesktop';
function OpenWindowStation(lpszWinSta: PAnsiChar; fInherit: BOOL; dwDesiredAccess: DWORD): THWINSTA; stdcall; external cLibName name 'OpenWindowStationA';
function OpenWindowStationW(lpszWinSta: PWideChar; fInherit: BOOL; dwDesiredAccess: DWORD): THWINSTA; stdcall; external cLibName name 'OpenWindowStationW';
function PackDDElParam(msg: UINT; uiLo: UINT; uiHi: UINT): Longint; stdcall; external cLibName name 'PackDDElParam';
function PaintDesktop(hdc: THDC): BOOL; stdcall; external cLibName name 'PaintDesktop';
function PeekMessage(var lpMsg: TMsg; hWnd: THWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; stdcall; external cLibName name 'PeekMessageA';
function PeekMessageW(var lpMsg: TMsg; hWnd: THWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; stdcall; external cLibName name 'PeekMessageW';
function PostMessage(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'PostMessageA';
function PostMessageW(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'PostMessageW';
procedure PostQuitMessage(nExitCode: Integer); stdcall; external cLibName name 'PostQuitMessage';
function PostThreadMessage(idThread: DWORD; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'PostThreadMessageA';
function PostThreadMessageW(idThread: DWORD; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'PostThreadMessageW';
function PtInRect(const lprc: TRect; pt: TPoint): BOOL; stdcall; external cLibName name 'PtInRect';
function RealChildWindowFromPoint(hwndParent: THWND; ptParentClientCoords: TPoint): THWND; stdcall; external cLibName name 'RealChildWindowFromPoint';
function RealGetWindowClass(hwnd: THWND; pszType: PAnsiChar; cchType: UINT): UINT; stdcall; external cLibName name 'RealGetWindowClassA';
function RealGetWindowClassW(hwnd: THWND; pszType: PWideChar; cchType: UINT): UINT; stdcall; external cLibName name 'RealGetWindowClassW';
function RedrawWindow(hWnd: THWND; lprcUpdate: PRect; hrgnUpdate: THRGN; flags: UINT): BOOL; stdcall; external cLibName name 'RedrawWindow';
function RegisterClass(const lpWndClass: TWndClassA): TATOM; stdcall; external cLibName name 'RegisterClassA';
function RegisterClassEx(const WndClass: TWndClassExA): TATOM; stdcall; external cLibName name 'RegisterClassExA';
function RegisterClassExW(const WndClass: TWndClassExW): TATOM; stdcall; external cLibName name 'RegisterClassExW';
function RegisterClassW(const lpWndClass: TWndClassW): TATOM; stdcall; external cLibName name 'RegisterClassW';
function RegisterClipboardFormat(lpszFormat: PAnsiChar): UINT; stdcall; external cLibName name 'RegisterClipboardFormatA';
function RegisterClipboardFormatW(lpszFormat: PWideChar): UINT; stdcall; external cLibName name 'RegisterClipboardFormatW';
function RegisterDeviceNotification(hRecipient: THandle; NotificationFilter: Pointer; Flags: DWORD): HDEVNOTIFY; stdcall; external cLibName name 'RegisterDeviceNotificationA';
function RegisterDeviceNotificationW(hRecipient: THandle; NotificationFilter: Pointer; Flags: DWORD): HDEVNOTIFY; stdcall; external cLibName name 'RegisterDeviceNotificationW';
function RegisterHotKey(hWnd: THWND; id: Integer; fsModifiers, vk: UINT): BOOL; stdcall; external cLibName name 'RegisterHotKey';
function RegisterWindowMessage(lpString: PAnsiChar): UINT; stdcall; external cLibName name 'RegisterWindowMessageA';
function RegisterWindowMessageW(lpString: PWideChar): UINT; stdcall; external cLibName name 'RegisterWindowMessageW';
function ReleaseCapture: BOOL; stdcall; external cLibName name 'ReleaseCapture';
function ReleaseDC(hWnd: THWND; hDC: THDC): Integer; stdcall; external cLibName name 'ReleaseDC';
function RemoveMenu(hMenu: THMENU; uPosition, uFlags: UINT): BOOL; stdcall; external cLibName name 'RemoveMenu';
function RemoveProp(hWnd: THWND; lpString: PAnsiChar): THandle; stdcall; external cLibName name 'RemovePropA';
function RemovePropW(hWnd: THWND; lpString: PWideChar): THandle; stdcall; external cLibName name 'RemovePropW';
function ReplyMessage(lResult: TLRESULT): BOOL; stdcall; external cLibName name 'ReplyMessage';
function ReuseDDElParam(lParam: Longint; msgIn: UINT; msgOut: UINT; uiLo: UINT; uiHi: UINT): Longint; stdcall; external cLibName name 'ReuseDDElParam';
function ScreenToClient(hWnd: THWND; var lpPoint: TPoint): BOOL; stdcall; external cLibName name 'ScreenToClient';
function ScrollDC(DC: THDC; DX, DY: Integer; var Scroll, Clip: TRect; Rgn: THRGN; Update: PRect): BOOL; stdcall; external cLibName name 'ScrollDC';
function ScrollWindow(hWnd: THWND; XAmount, YAmount: Integer; Rect, ClipRect: PRect): BOOL; stdcall; external cLibName name 'ScrollWindow';
function ScrollWindowEx(hWnd: THWND; dx, dy: Integer; prcScroll, prcClip: PRect; hrgnUpdate: THRGN; prcUpdate: PRect; flags: UINT): BOOL; stdcall; external cLibName name 'ScrollWindowEx';
function SendDlgItemMessage(hDlg: THWND; nIDDlgItem: Integer; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): Longint; stdcall; external cLibName name 'SendDlgItemMessageA';
function SendDlgItemMessageW(hDlg: THWND; nIDDlgItem: Integer; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): Longint; stdcall; external cLibName name 'SendDlgItemMessageW';
function SendInput(cInputs: UINT; var pInputs: TInput; cbSize: Integer): UINT; stdcall; external cLibName name 'SendInput';
function SendMessage(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'SendMessageA';
function SendMessageCallback(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM; lpResultCallBack: TSendASyncProc; dwData: DWORD): BOOL; stdcall; external cLibName name 'SendMessageCallbackA';
function SendMessageCallbackW(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM; lpResultCallBack: TSendASyncProc; dwData: DWORD): BOOL; stdcall; external cLibName name 'SendMessageCallbackW';
function SendMessageTimeout(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM; fuFlags, uTimeout: UINT; var lpdwResult: DWORD): TLRESULT; stdcall; external cLibName name 'SendMessageTimeoutA';
function SendMessageTimeoutW(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM; fuFlags, uTimeout: UINT; var lpdwResult: DWORD): TLRESULT; stdcall; external cLibName name 'SendMessageTimeoutW';
function SendMessageW(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): TLRESULT; stdcall; external cLibName name 'SendMessageW';
function SendNotifyMessage(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'SendNotifyMessageA';
function SendNotifyMessageW(hWnd: THWND; Msg: UINT; wParam: TWPARAM; lParam: TLPARAM): BOOL; stdcall; external cLibName name 'SendNotifyMessageW';
function SetActiveWindow(hWnd: THWND): THWND; stdcall; external cLibName name 'SetActiveWindow';
function SetCapture(hWnd: THWND): THWND; stdcall; external cLibName name 'SetCapture';
function SetCaretBlinkTime(uMSeconds: UINT): BOOL; stdcall; external cLibName name 'SetCaretBlinkTime';
function SetCaretPos(X, Y: Integer): BOOL; stdcall; external cLibName name 'SetCaretPos';
function SetClassLong(hWnd: THWND; nIndex: Integer; dwNewLong: Longint): DWORD; stdcall; external cLibName name 'SetClassLongA';
function SetClassLongW(hWnd: THWND; nIndex: Integer; dwNewLong: Longint): DWORD; stdcall; external cLibName name 'SetClassLongW';
function SetClassWord(hWnd: THWND; nIndex: Integer; wNewWord: Word): Word; stdcall; external cLibName name 'SetClassWord';
function SetClipboardData(uFormat: UINT; hMem: THandle): THandle; stdcall; external cLibName name 'SetClipboardData';
function SetClipboardViewer(hWndNewViewer: THWND): THWND; stdcall; external cLibName name 'SetClipboardViewer';
function SetCursor(hCursor: THICON): THCURSOR; stdcall; external cLibName name 'SetCursor';
function SetCursorPos(X, Y: Integer): BOOL; stdcall; external cLibName name 'SetCursorPos';
procedure SetDebugErrorLevel(dwLevel: DWORD); stdcall; external cLibName name 'SetDebugErrorLevel';
function SetDlgItemInt(hDlg: THWND; nIDDlgItem: Integer; uValue: UINT; bSigned: BOOL): BOOL; stdcall; external cLibName name 'SetDlgItemInt';
function SetDlgItemText(hDlg: THWND; nIDDlgItem: Integer; lpString: PAnsiChar): BOOL; stdcall; external cLibName name 'SetDlgItemTextA';
function SetDlgItemTextW(hDlg: THWND; nIDDlgItem: Integer; lpString: PWideChar): BOOL; stdcall; external cLibName name 'SetDlgItemTextW';
function SetDoubleClickTime(Interval: UINT): BOOL; stdcall; external cLibName name 'SetDoubleClickTime';
function SetFocus(hWnd: THWND): THWND; stdcall; external cLibName name 'SetFocus';
function SetForegroundWindow(hWnd: THWND): BOOL; stdcall; external cLibName name 'SetForegroundWindow';
function SetKeyboardState(var KeyState: uint8): BOOL; stdcall; external cLibName name 'SetKeyboardState';
procedure SetLastErrorEx(dwErrCode, dwType: DWORD); stdcall; external cLibName name 'SetLastErrorEx';
function SetMenu(hWnd: THWND; hMenu: THMENU): BOOL; stdcall; external cLibName name 'SetMenu';
function SetMenuContextHelpId(hMenu: THMENU; HelpID: DWORD): BOOL; stdcall; external cLibName name 'SetMenuContextHelpId';
function SetMenuDefaultItem(hMenu: THMENU; uItem, fByPos: UINT): BOOL; stdcall; external cLibName name 'SetMenuDefaultItem';
function SetMenuInfo(hMenu: THMENU; const lpcmi: TMenuInfo): BOOL; stdcall; external cLibName name 'SetMenuInfo';
function SetMenuItemBitmaps(hMenu: THMENU; uPosition, uFlags: UINT; hBitmapUnchecked: THBITMAP; hBitmapChecked: THBITMAP): BOOL; stdcall; external cLibName name 'SetMenuItemBitmaps';
function SetMenuItemInfo(p1: THMENU; p2: UINT; p3: BOOL; const p4: TMenuItemInfoA): BOOL; stdcall; external cLibName name 'SetMenuItemInfoA';
function SetMenuItemInfoW(p1: THMENU; p2: UINT; p3: BOOL; const p4: TMenuItemInfoW): BOOL; stdcall; external cLibName name 'SetMenuItemInfoW';
function SetMessageExtraInfo(lParam: TLPARAM): TLPARAM; stdcall; external cLibName name 'SetMessageExtraInfo';
function SetMessageQueue(cMessagesMax: Integer): BOOL; stdcall; external cLibName name 'SetMessageQueue';
function SetParent(hWndChild, hWndNewParent: THWND): THWND; stdcall; external cLibName name 'SetParent';
function SetProcessWindowStation(hWinSta: THWINSTA): BOOL; stdcall; external cLibName name 'SetProcessWindowStation';
function SetProp(hWnd: THWND; lpString: PAnsiChar; hData: THandle): BOOL; stdcall; external cLibName name 'SetPropA';
function SetPropW(hWnd: THWND; lpString: PWideChar; hData: THandle): BOOL; stdcall; external cLibName name 'SetPropW';
function SetRect(var lprc: TRect; xLeft, yTop, xRight, yBottom: Integer): BOOL; stdcall; external cLibName name 'SetRect';
function SetRectEmpty(var lprc: TRect): BOOL; stdcall; external cLibName name 'SetRectEmpty';
function SetScrollInfo(hWnd: THWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer; stdcall; external cLibName name 'SetScrollInfo';
function SetScrollPos(hWnd: THWND; nBar, nPos: Integer; bRedraw: BOOL): Integer; stdcall; external cLibName name 'SetScrollPos';
function SetScrollRange(hWnd: THWND; nBar, nMinPos, nMaxPos: Integer; bRedraw: BOOL): BOOL; stdcall; external cLibName name 'SetScrollRange';
function SetSysColors(cElements: Integer; const lpaElements; const lpaRgbValues): BOOL; stdcall; external cLibName name 'SetSysColors';
function SetSystemCursor(hcur: THICON; id: DWORD): BOOL; stdcall; external cLibName name 'SetSystemCursor';
function SetThreadDesktop(hDesktop: THDESK): BOOL; stdcall; external cLibName name 'SetThreadDesktop';
function SetTimer(hWnd: THWND; nIDEvent, uElapse: UINT; lpTimerFunc: TTimerProc): UINT; stdcall; external cLibName name 'SetTimer';
function SetUserObjectInformation(hObj: THandle; nIndex: Integer; pvInfo: Pointer; nLength: DWORD): BOOL; stdcall; external cLibName name 'SetUserObjectInformationA';
function SetUserObjectInformationW(hObj: THandle; nIndex: Integer; pvInfo: Pointer; nLength: DWORD): BOOL; stdcall; external cLibName name 'SetUserObjectInformationW';
function SetUserObjectSecurity(hObj: THandle; var pSIRequested: DWORD; pSID: PSecurityDescriptor): BOOL; stdcall; external cLibName name 'SetUserObjectSecurity';
function SetWinEventHook(eventMin, eventMax: DWORD; hmodWinEventProc: HMODULE; pfnWinEventProc: TWinEventProc; idProcess, idThread, dwFlags: DWORD): THandle; stdcall; external cLibName name 'SetWinEventHook';
function SetWindowContextHelpId(hWnd: THWND; HelpID: DWORD): BOOL; stdcall; external cLibName name 'SetWindowContextHelpId';
function SetWindowLong(hWnd: THWND; nIndex: Integer; dwNewLong: Longint): Longint; stdcall; external cLibName name 'SetWindowLongA';
function SetWindowLongW(hWnd: THWND; nIndex: Integer; dwNewLong: Longint): Longint; stdcall; external cLibName name 'SetWindowLongW';
function SetWindowPlacement(hWnd: THWND; WindowPlacement: PWindowPlacement): BOOL; stdcall; external cLibName name 'SetWindowPlacement';
function SetWindowPos(hWnd: THWND; hWndInsertAfter: THWND; X, Y, cx, cy: Integer; uFlags: UINT): BOOL; stdcall; external cLibName name 'SetWindowPos';
function SetWindowRgn(hWnd: THWND; hRgn: THRGN; bRedraw: BOOL): BOOL; stdcall; external cLibName name 'SetWindowRgn';
function SetWindowText(hWnd: THWND; lpString: PAnsiChar): BOOL; stdcall; external cLibName name 'SetWindowTextA';
function SetWindowTextW(hWnd: THWND; lpString: PWideChar): BOOL; stdcall; external cLibName name 'SetWindowTextW';
function SetWindowWord(hWnd: THWND; nIndex: Integer; wNewWord: Word): Word; stdcall; external cLibName name 'SetWindowWord';
function SetWindowsHook(nFilterType: Integer; pfnFilterProc: THookProc): THHOOK; stdcall; external cLibName name 'SetWindowsHookA';
function SetWindowsHookEx(idHook: Integer; lpfn: THookProc; hmod: THINST; dwThreadId: DWORD): THHOOK; stdcall; external cLibName name 'SetWindowsHookExA';
function SetWindowsHookExW(idHook: Integer; lpfn: THookProc; hmod: THINST; dwThreadId: DWORD): THHOOK; stdcall; external cLibName name 'SetWindowsHookExW';
function SetWindowsHookW(nFilterType: Integer; pfnFilterProc: THookProc): THHOOK; stdcall; external cLibName name 'SetWindowsHookW';
function ShowCaret(hWnd: THWND): BOOL; stdcall; external cLibName name 'ShowCaret';
function ShowCursor(bShow: BOOL): Integer; stdcall; external cLibName name 'ShowCursor';
function ShowOwnedPopups(hWnd: THWND; fShow: BOOL): BOOL; stdcall; external cLibName name 'ShowOwnedPopups';
function ShowScrollBar(hWnd: THWND; wBar: Integer; bShow: BOOL): BOOL; stdcall; external cLibName name 'ShowScrollBar';
function ShowWindow(hWnd: THWND; nCmdShow: Integer): BOOL; stdcall; external cLibName name 'ShowWindow';
function ShowWindowAsync(hWnd: THWND; nCmdShow: Integer): BOOL; stdcall; external cLibName name 'ShowWindowAsync';
function SubtractRect(var lprcDst: TRect; const lprcSrc1, lprcSrc2: TRect): BOOL; stdcall; external cLibName name 'SubtractRect';
function SwapMouseButton(fSwap: BOOL): BOOL; stdcall; external cLibName name 'SwapMouseButton';
function SwitchDesktop(hDesktop: THDESK): BOOL; stdcall; external cLibName name 'SwitchDesktop';
function SystemParametersInfo(uiAction, uiParam: UINT; pvParam: Pointer; fWinIni: UINT): BOOL; stdcall; external cLibName name 'SystemParametersInfoA';
function SystemParametersInfoW(uiAction, uiParam: UINT; pvParam: Pointer; fWinIni: UINT): BOOL; stdcall; external cLibName name 'SystemParametersInfoW';
function TabbedTextOut(hDC: THDC; X, Y: Integer; lpString: PAnsiChar; nCount, nTabPositions: Integer; var lpnTabStopPositions; nTabOrigin: Integer): Longint; stdcall; external cLibName name 'TabbedTextOutA';
function TabbedTextOutW(hDC: THDC; X, Y: Integer; lpString: PWideChar; nCount, nTabPositions: Integer; var lpnTabStopPositions; nTabOrigin: Integer): Longint; stdcall; external cLibName name 'TabbedTextOutW';
function TileWindows(hwndParent: THWND; wHow: UINT; lpRect: PRect; cKids: UINT; lpKids: Pointer): Word; stdcall; external cLibName name 'TileWindows';
function ToAscii(uVirtKey, uScanCode: UINT; const KeyState: uint8; lpChar: PChar; uFlags: UINT): Integer; stdcall; external cLibName name 'ToAscii';
function ToAsciiEx(uVirtKey: UINT; uScanCode: UINT; const KeyState: uint8; lpChar: PChar; uFlags: UINT; dwhkl: THKL): Integer; stdcall; external cLibName name 'ToAsciiEx';
function ToUnicode(wVirtKey, wScanCode: UINT; const KeyState: uint8; var pwszBuff; cchBuff: Integer; wFlags: UINT): Integer; stdcall; external cLibName name 'ToUnicode';
function ToUnicodeEx(wVirtKey, wScanCode: UINT; lpKeyState: PByte; pwszBuff: PWideChar; cchBuff: Integer; wFlags: UINT; dwhkl: THKL): Integer; stdcall; external cLibName name 'ToUnicodeEx';
function TrackMouseEvent(var EventTrack: TTrackMouseEvent): BOOL; stdcall; external cLibName name 'TrackMouseEvent';
function TrackPopupMenu(hMenu: THMENU; uFlags: UINT; x, y, nReserved: Integer; hWnd: THWND; prcRect: PRect): BOOL; stdcall; external cLibName name 'TrackPopupMenu';
function TrackPopupMenuEx(hMenu: THMENU; Flags: UINT; x, y: Integer; Wnd: THWND; TPMParams: PTPMParams): BOOL; stdcall; external cLibName name 'TrackPopupMenuEx';
function TranslateAccelerator(hWnd: THWND; hAccTable: THACCEL; var lpMsg: TMsg): Integer; stdcall; external cLibName name 'TranslateAcceleratorA';
function TranslateAcceleratorW(hWnd: THWND; hAccTable: THACCEL; var lpMsg: TMsg): Integer; stdcall; external cLibName name 'TranslateAcceleratorW';
function TranslateMDISysAccel(hWndClient: THWND; const lpMsg: TMsg): BOOL; stdcall; external cLibName name 'TranslateMDISysAccel';
function TranslateMessage(const lpMsg: TMsg): BOOL; stdcall; external cLibName name 'TranslateMessage';
function UnhookWinEvent(hWinEventHook: THandle): BOOL; stdcall; external cLibName name 'UnhookWinEvent';
function UnhookWindowsHook(nCode: Integer; pfnFilterProc: THookProc): BOOL; stdcall; external cLibName name 'UnhookWindowsHook';
function UnhookWindowsHookEx(hhk: THHOOK): BOOL; stdcall; external cLibName name 'UnhookWindowsHookEx';
function UnionRect(var lprcDst: TRect; const lprcSrc1, lprcSrc2: TRect): BOOL; stdcall; external cLibName name 'UnionRect';
function UnloadKeyboardLayout(hkl: THKL): BOOL; stdcall; external cLibName name 'UnloadKeyboardLayout';
function UnpackDDElParam(msg: UINT; lParam: Longint; puiLo: PUINT; puiHi: PUINT): BOOL; stdcall; external cLibName name 'UnpackDDElParam';
function UnregisterClass(lpClassName: PAnsiChar; THINSTance: THINST): BOOL; stdcall; external cLibName name 'UnregisterClassA';
function UnregisterClassW(lpClassName: PWideChar; THINSTance: THINST): BOOL; stdcall; external cLibName name 'UnregisterClassW';
function UnregisterDeviceNotification(Handle: HDEVNOTIFY): BOOL; stdcall; external cLibName name 'UnregisterDeviceNotification';
function UnregisterHotKey(hWnd: THWND; id: Integer): BOOL; stdcall; external cLibName name 'UnregisterHotKey';
function UpdateWindow(hWnd: THWND): BOOL; stdcall; external cLibName name 'UpdateWindow';
function UserHandleGrantAccess(hUserHandle, hJob: THandle): BOOL; stdcall; external cLibName name 'UserHandleGrantAccess';
function ValidateRect(hWnd: THWND; lpRect: PRect): BOOL; stdcall; external cLibName name 'ValidateRect';
function ValidateRgn(hWnd: THWND; hRgn: THRGN): BOOL; stdcall; external cLibName name 'ValidateRgn';
function VkKeyScan(ch: AnsiChar): SHORT; stdcall; external cLibName name 'VkKeyScanA';
function VkKeyScanEx(ch: AnsiChar; dwhkl: THKL): SHORT; stdcall; external cLibName name 'VkKeyScanExA';
function VkKeyScanExW(ch: WideChar; dwhkl: THKL): SHORT; stdcall; external cLibName name 'VkKeyScanExW';
function VkKeyScanW(ch: WideChar): SHORT; stdcall; external cLibName name 'VkKeyScanW';
function WaitForInputIdle(hProcess: THandle; dwMilliseconds: DWORD): DWORD; stdcall; external cLibName name 'WaitForInputIdle';
function WaitMessage: BOOL; stdcall; external cLibName name 'WaitMessage';
function WinHelp(hWndMain: THWND; lpszHelp: PAnsiChar; uCommand: UINT; dwData: DWORD): BOOL; stdcall; external cLibName name 'WinHelpA';
function WinHelpW(hWndMain: THWND; lpszHelp: PWideChar; uCommand: UINT; dwData: DWORD): BOOL; stdcall; external cLibName name 'WinHelpW';
function WindowFromDC(hDC: THDC): THWND; stdcall; external cLibName name 'WindowFromDC';
function WindowFromPoint(Point: TPoint): THWND; stdcall; external cLibName name 'WindowFromPoint';
procedure keybd_event(bVk: Byte; bScan: Byte; dwFlags, dwExtraInfo: DWORD); stdcall; external cLibName name 'keybd_event';
procedure mouse_event(dwFlags, dx, dy, dwData, dwExtraInfo: DWORD); stdcall; external cLibName name 'mouse_event';
function wsprintf(Output: PAnsiChar; Format: PAnsiChar): Integer; stdcall; external cLibName name 'wsprintfA';
function wsprintfW(Output: PWideChar; Format: PWideChar): Integer; stdcall; external cLibName name 'wsprintfW';
function wvsprintf(Output: PAnsiChar; Format: PAnsiChar; arglist: va_list): Integer; stdcall; external cLibName name 'wvsprintfA';
function wvsprintfW(Output: PWideChar; Format: PWideChar; arglist: va_list): Integer; stdcall; external cLibName name 'wvsprintfW';

{$endif}
implementation

end.


