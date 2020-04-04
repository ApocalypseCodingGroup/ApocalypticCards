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
unit cwWin32.Gdi32;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef MSWINDOWS}
uses
 cwWin32.Types;

const
  cLibName = 'gdi32.dll';

//GDI32.1; Index 1000;			Information not available
//GDI32.2; Index 1001;			Information not available
//GDI32.3; Index 1002;			Information not available
//GDI32.4; Index 1003;			Information not available
//GDI32.5; Index 1004;			Information not available
//GDI32.6; Index 1005;			Information not available
//GDI32.7; Index 1006;			Information not available
//GDI32.8; Index 1007;			Information not available
//GDI32.9; Index 1008;			Information not available
//GDI32.10; Index 1009;		Information not available
//GDI32.11; Index 1010;		Information not available
//pldcGet; Index 1011;			Information not available
// GDI32.14; Index 1013;		Information not available
// DwmCreatedBitmapRemotingOutput; Index 1014;	Information not available
// AbortDocImpl; Index 1015;		Information not available
// AddFontResourceAStub; Index 1019;	Information not available
// AddFontResourceTracking; Index 1022;	Information not available
// AddFontResourceWImpl; Index 1024;	Information not available
// AnimatePaletteStub; Index 1027;	Information not available
// AnyLinkedFonts; Index 1028;		Information not available
// ArcStub; Index 1030;			Information not available
// BRUSHOBJ_hGetColorTransform; Index 1032;	Information not available
// BRUSHOBJ_pvAllocRbrush; Index 1033;	Information not available
// BRUSHOBJ_pvGetRbrush; Index 1034;	Information not available
// BRUSHOBJ_ulGetBrushColor; Index 1035;	Information not available
// BeginGdiRendering; Index 1036;	Information not available
// BeginPathImpl; Index 1038;		Information not available
// CLIPOBJ_bEnum; Index 1040;		Information not available
// CLIPOBJ_cEnumStart; Index 1041;	Information not available
// CLIPOBJ_ppoGetPath; Index 1042;	Information not available
// ClearBitmapAttributes; Index 1047;	Information not available
// ClearBrushAttributes; Index 1048;	Information not available
// CloseFigureImpl; Index 1051;		Information not available
// ConfigureOPMProtectedOutput; Index 1057;	Information not available
// CreateBitmapFromDxSurface2; Index 1063;	Information not available
// CreateBitmapFromDxSurface; Index 1064;	Information not available
// CreateBrushIndirectStub; Index 1067;	Information not available
// CreateDCAImpl; Index 1073;		Information not available
// CreateEllipticRgnIndirectStub; Index 1082;	Information not available
// CreateFontAStub; Index 1086;		Information not available
// CreateFontIndirectWImpl; Index 1091;	Information not available
// CreateOPMProtectedOutput; Index 1099;	Information not available
// CreateOPMProtectedOutputs; Index 1100;	Information not available
// CreatePenIndirectStub; Index 1105;	Information not available
// CreatePolyPolygonRgnStub; Index 1107;	Information not available
// CreateRoundRectRgnStub; Index 1112;	Information not available
// CreateScalableFontResourceWImpl; Index 1115;	Information not available
// CreateSessionMappedDIBSection; Index 1116;	Information not available
// D3DKMTAbandonSwapChain; Index 1118;	Information not available
// D3DKMTAcquireKeyedMutex2; Index 1119;	Information not available
// D3DKMTAcquireKeyedMutex; Index 1120;	Information not available
// D3DKMTAcquireSwapChain; Index 1121;	Information not available
// D3DKMTAdjustFullscreenGamma; Index 1122;	Information not available
// D3DKMTCacheHybridQueryValue; Index 1123;	Information not available
// D3DKMTChangeVideoMemoryReservation; Index 1124;	Information not available
// D3DKMTCheckExclusiveOwnership; Index 1125;	Information not available
// D3DKMTCheckMonitorPowerState; Index 1126;	Information not available
// D3DKMTCheckMultiPlaneOverlaySupport2; Index 1127;	Information not available
// D3DKMTCheckMultiPlaneOverlaySupport3; Index 1128;	Information not available
// D3DKMTCheckMultiPlaneOverlaySupport; Index 1129;	Information not available
// D3DKMTCheckOcclusion; Index 1130;	Information not available
// D3DKMTCheckSharedResourceAccess; Index 1131;	Information not available
// D3DKMTCheckVidPnExclusiveOwnership; Index 1132;	Information not available
// D3DKMTCloseAdapter; Index 1133;	Information not available
// D3DKMTConfigureSharedResource; Index 1134;	Information not available
// D3DKMTCreateAllocation2; Index 1135;	Information not available
// D3DKMTCreateAllocation; Index 1136;	Information not available
// D3DKMTCreateContext; Index 1137;	Information not available
// D3DKMTCreateContextVirtual; Index 1138;	Information not available
// D3DKMTCreateDCFromMemory; Index 1139;	Information not available
// D3DKMTCreateDevice; Index 1140;	Information not available
// D3DKMTCreateKeyedMutex2; Index 1141;	Information not available
// D3DKMTCreateKeyedMutex; Index 1142;	Information not available
// D3DKMTCreateOutputDupl; Index 1143;	Information not available
// D3DKMTCreateOverlay; Index 1144;	Information not available
// D3DKMTCreatePagingQueue; Index 1145;	Information not available
// D3DKMTCreateSwapChain; Index 1146;	Information not available
// D3DKMTCreateSynchronizationObject2; Index 1147;	Information not available
// D3DKMTCreateSynchronizationObject; Index 1148;	Information not available
// D3DKMTDestroyAllocation2; Index 1149;	Information not available
// D3DKMTDestroyAllocation; Index 1150;	Information not available
// D3DKMTDestroyContext; Index 1151;	Information not available
// D3DKMTDestroyDCFromMemory; Index 1152;	Information not available
// D3DKMTDestroyDevice; Index 1153;	Information not available
// D3DKMTDestroyKeyedMutex; Index 1154;	Information not available
// D3DKMTDestroyOutputDupl; Index 1155;	Information not available
// D3DKMTDestroyOverlay; Index 1156;	Information not available
// D3DKMTDestroyPagingQueue; Index 1157;	Information not available
// D3DKMTDestroySynchronizationObject; Index 1158;	Information not available
// D3DKMTEnumAdapters2; Index 1159;	Information not available
// D3DKMTEnumAdapters; Index 1160;	Information not available
// D3DKMTEscape; Index 1161;		Information not available
// D3DKMTEvict; Index 1162;		Information not available
// D3DKMTFlipOverlay; Index 1163;	Information not available
// D3DKMTFlushHeapTransitions; Index 1164;	Information not available
// D3DKMTFreeGpuVirtualAddress; Index 1165;	Information not available
// D3DKMTGetCachedHybridQueryValue; Index 1166;	Information not available
// D3DKMTGetContextInProcessSchedulingPriority; Index 1167;	Information not available
// D3DKMTGetContextSchedulingPriority; Index 1168;	Information not available
// D3DKMTGetDWMVerticalBlankEvent; Index 1169;	Information not available
// D3DKMTGetDeviceState; Index 1170;	Information not available
// D3DKMTGetDisplayModeList; Index 1171;	Information not available
// D3DKMTGetMultisampleMethodList; Index 1172;	Information not available
// D3DKMTGetOverlayState; Index 1173;	Information not available
// D3DKMTGetPresentHistory; Index 1174;	Information not available
// D3DKMTGetPresentQueueEvent; Index 1175;	Information not available
// D3DKMTGetProcessSchedulingPriorityClass; Index 1176;	Information not available
// D3DKMTGetResourcePresentPrivateDriverData; Index 1177;	Information not available
// D3DKMTGetRuntimeData; Index 1178;	Information not available
// D3DKMTGetScanLine; Index 1179;	Information not available
// D3DKMTGetSetSwapChainMetadata; Index 1180;	Information not available
// D3DKMTGetSharedPrimaryHandle; Index 1181;	Information not available
// D3DKMTGetSharedResourceAdapterLuid; Index 1182;	Information not available
// D3DKMTInvalidateActiveVidPn; Index 1183;	Information not available
// D3DKMTInvalidateCache; Index 1184;	Information not available
// D3DKMTLock2; Index 1185;		Information not available
// D3DKMTLock; Index 1186;		Information not available
// D3DKMTMakeResident; Index 1187;	Information not available
// D3DKMTMapGpuVirtualAddress; Index 1188;	Information not available
// D3DKMTMarkDeviceAsError; Index 1189;	Information not available
// D3DKMTNetDispGetNextChunkInfo; Index 1190;	Information not available
// D3DKMTNetDispQueryMiracastDisplayDeviceStatus; Index 1191;	Information not available
// D3DKMTNetDispQueryMiracastDisplayDeviceSupport; Index 1192;	Information not available
// D3DKMTNetDispStartMiracastDisplayDevice2; Index 1193;	Information not available
// D3DKMTNetDispStartMiracastDisplayDevice; Index 1194;	Information not available
// D3DKMTNetDispStartMiracastDisplayDeviceEx; Index 1195;	Information not available
// D3DKMTNetDispStopMiracastDisplayDevice; Index 1196;	Information not available
// D3DKMTNetDispStopSessions; Index 1197;	Information not available
// D3DKMTOfferAllocations; Index 1198;	Information not available
// D3DKMTOpenAdapterFromDeviceName; Index 1199;	Information not available
// D3DKMTOpenAdapterFromGdiDisplayName; Index 1200;	Information not available
// D3DKMTOpenAdapterFromHdc; Index 1201;	Information not available
// D3DKMTOpenAdapterFromLuid; Index 1202;	Information not available
// D3DKMTOpenKeyedMutex2; Index 1203;	Information not available
// D3DKMTOpenKeyedMutex; Index 1204;	Information not available
// D3DKMTOpenNtHandleFromName; Index 1205;	Information not available
// D3DKMTOpenResource2; Index 1206;	Information not available
// D3DKMTOpenResource; Index 1207;	Information not available
// D3DKMTOpenResourceFromNtHandle; Index 1208;	Information not available
// D3DKMTOpenSwapChain; Index 1209;	Information not available
// D3DKMTOpenSyncObjectFromNtHandle2; Index 1210;	Information not available
// D3DKMTOpenSyncObjectFromNtHandle; Index 1211;	Information not available
// D3DKMTOpenSyncObjectNtHandleFromName; Index 1212;	Information not available
// D3DKMTOpenSynchronizationObject; Index 1213;	Information not available
// D3DKMTOutputDuplGetFrameInfo; Index 1214;	Information not available
// D3DKMTOutputDuplGetMetaData; Index 1215;	Information not available
// D3DKMTOutputDuplGetPointerShapeData; Index 1216;	Information not available
// D3DKMTOutputDuplPresent; Index 1217;	Information not available
// D3DKMTOutputDuplReleaseFrame; Index 1218;	Information not available
// D3DKMTPinDirectFlipResources; Index 1219;	Information not available
// D3DKMTPollDisplayChildren; Index 1220;	Information not available
// D3DKMTPresent; Index 1221;		Information not available
// D3DKMTPresentMultiPlaneOverlay2; Index 1222;	Information not available
// D3DKMTPresentMultiPlaneOverlay3; Index 1223;	Information not available
// D3DKMTPresentMultiPlaneOverlay; Index 1224;	Information not available
// D3DKMTQueryAdapterInfo; Index 1225;	Information not available
// D3DKMTQueryAllocationResidency; Index 1226;	Information not available
// D3DKMTQueryClockCalibration; Index 1227;	Information not available
// D3DKMTQueryFSEBlock; Index 1228;	Information not available
// D3DKMTQueryProcessOfferInfo; Index 1229;	Information not available
// D3DKMTQueryRemoteVidPnSourceFromGdiDisplayName; Index 1230;	Information not available
// D3DKMTQueryResourceInfo; Index 1231;	Information not available
// D3DKMTQueryResourceInfoFromNtHandle; Index 1232;	Information not available
// D3DKMTQueryStatistics; Index 1233;	Information not available
// D3DKMTQueryVidPnExclusiveOwnership; Index 1234;	Information not available
// D3DKMTQueryVideoMemoryInfo; Index 1235;	Information not available
// D3DKMTReclaimAllocations2; Index 1236;	Information not available
// D3DKMTReclaimAllocations; Index 1237;	Information not available
// D3DKMTRegisterTrimNotification; Index 1238;	Information not available
// D3DKMTReleaseKeyedMutex2; Index 1239;	Information not available
// D3DKMTReleaseKeyedMutex; Index 1240;	Information not available
// D3DKMTReleaseProcessVidPnSourceOwners; Index 1241;	Information not available
// D3DKMTReleaseSwapChain; Index 1242;	Information not available
// D3DKMTRender; Index 1243;		Information not available
// D3DKMTReserveGpuVirtualAddress; Index 1244;	Information not available
// D3DKMTSetAllocationPriority; Index 1245;	Information not available
// D3DKMTSetContextInProcessSchedulingPriority; Index 1246;	Information not available
// D3DKMTSetContextSchedulingPriority; Index 1247;	Information not available
// D3DKMTSetDisplayMode; Index 1248;	Information not available
// D3DKMTSetDisplayPrivateDriverFormat; Index 1249;	Information not available
// D3DKMTSetDodIndirectSwapchain; Index 1250;	Information not available
// D3DKMTSetFSEBlock; Index 1251;	Information not available
// D3DKMTSetGammaRamp; Index 1252;	Information not available
// D3DKMTSetHwProtectionTeardownRecovery; Index 1253;	Information not available
// D3DKMTSetProcessSchedulingPriorityClass; Index 1254;	Information not available
// D3DKMTSetQueuedLimit; Index 1255;	Information not available
// D3DKMTSetStablePowerState; Index 1256;	Information not available
// D3DKMTSetStereoEnabled; Index 1257;	Information not available
// D3DKMTSetSyncRefreshCountWaitTarget; Index 1258;	Information not available
// D3DKMTSetVidPnSourceHwProtection; Index 1259;	Information not available
// D3DKMTSetVidPnSourceOwner1; Index 1260;	Information not available
// D3DKMTSetVidPnSourceOwner; Index 1261;	Information not available
// D3DKMTShareObjects; Index 1262;	Information not available
// D3DKMTSharedPrimaryLockNotification; Index 1263;	Information not available
// D3DKMTSharedPrimaryUnLockNotification; Index 1264;	Information not available
// D3DKMTSignalSynchronizationObject2; Index 1265;	Information not available
// D3DKMTSignalSynchronizationObject; Index 1266;	Information not available
// D3DKMTSignalSynchronizationObjectFromCpu; Index 1267;	Information not available
// D3DKMTSignalSynchronizationObjectFromGpu2; Index 1268;	Information not available
// D3DKMTSignalSynchronizationObjectFromGpu; Index 1269;	Information not available
// D3DKMTSubmitCommand; Index 1270;	Information not available
// D3DKMTTrimProcessCommitment; Index 1271;	Information not available
// D3DKMTUnlock2; Index 1272;		Information not available
// D3DKMTUnlock; Index 1273;		Information not available
// D3DKMTUnpinDirectFlipResources; Index 1274;	Information not available
// D3DKMTUnregisterTrimNotification; Index 1275;	Information not available
// D3DKMTUpdateAllocationProperty; Index 1276;	Information not available
// D3DKMTUpdateGpuVirtualAddress; Index 1277;	Information not available
// D3DKMTUpdateOverlay; Index 1278;	Information not available
// D3DKMTWaitForIdle; Index 1279;	Information not available
// D3DKMTWaitForSynchronizationObject2; Index 1280;	Information not available
// D3DKMTWaitForSynchronizationObject; Index 1281;	Information not available
// D3DKMTWaitForSynchronizationObjectFromCpu; Index 1282;	Information not available
// D3DKMTWaitForSynchronizationObjectFromGpu; Index 1283;	Information not available
// D3DKMTWaitForVerticalBlankEvent2; Index 1284;	Information not available
// D3DKMTWaitForVerticalBlankEvent; Index 1285;	Information not available
// DDCCIGetCapabilitiesString; Index 1286;	Information not available
// DDCCIGetCapabilitiesStringLength; Index 1287;	Information not available
// DDCCIGetTimingReport; Index 1288;	Information not available
// DDCCIGetVCPFeature; Index 1289;	Information not available
// DDCCISaveCurrentSettings; Index 1290;	Information not available
// DDCCISetVCPFeature; Index 1291;	Information not available
// DdCreateFullscreenSprite; Index 1293;	Information not available
// DdDestroyFullscreenSprite; Index 1294;	Information not available
// DdEntry0; Index 1295;		Information not available
// DdEntry10; Index 1296;		Information not available
// DdEntry11; Index 1297;		Information not available
// DdEntry12; Index 1298;		Information not available
// DdEntry13; Index 1299;		Information not available
// DdEntry14; Index 1300;		Information not available
// DdEntry15; Index 1301;		Information not available
// DdEntry16; Index 1302;		Information not available
// DdEntry17; Index 1303;		Information not available
// DdEntry18; Index 1304;		Information not available
// DdEntry19; Index 1305;		Information not available
// DdEntry1; Index 1306;		Information not available
// DdEntry20; Index 1307;		Information not available
// DdEntry21; Index 1308;		Information not available
// DdEntry22; Index 1309;		Information not available
// DdEntry23; Index 1310;		Information not available
// DdEntry24; Index 1311;		Information not available
// DdEntry25; Index 1312;		Information not available
// DdEntry26; Index 1313;		Information not available
// DdEntry27; Index 1314;		Information not available
// DdEntry28; Index 1315;		Information not available
// DdEntry29; Index 1316;		Information not available
// DdEntry2; Index 1317;		Information not available
// DdEntry30; Index 1318;		Information not available
// DdEntry31; Index 1319;		Information not available
// DdEntry32; Index 1320;		Information not available
// DdEntry33; Index 1321;		Information not available
// DdEntry34; Index 1322;		Information not available
// DdEntry35; Index 1323;		Information not available
// DdEntry36; Index 1324;		Information not available
// DdEntry37; Index 1325;		Information not available
// DdEntry38; Index 1326;		Information not available
// DdEntry39; Index 1327;		Information not available
// DdEntry3; Index 1328;		Information not available
// DdEntry40; Index 1329;		Information not available
// DdEntry41; Index 1330;		Information not available
// DdEntry42; Index 1331;		Information not available
// DdEntry43; Index 1332;		Information not available
// DdEntry44; Index 1333;		Information not available
// DdEntry45; Index 1334;		Information not available
// DdEntry46; Index 1335;		Information not available
// DdEntry47; Index 1336;		Information not available
// DdEntry48; Index 1337;		Information not available
// DdEntry49; Index 1338;		Information not available
// DdEntry4; Index 1339;		Information not available
// DdEntry50; Index 1340;		Information not available
// DdEntry51; Index 1341;		Information not available
// DdEntry52; Index 1342;		Information not available
// DdEntry53; Index 1343;		Information not available
// DdEntry54; Index 1344;		Information not available
// DdEntry55; Index 1345;		Information not available
// DdEntry56; Index 1346;		Information not available
// DdEntry5; Index 1347;		Information not available
// DdEntry6; Index 1348;		Information not available
// DdEntry7; Index 1349;		Information not available
// DdEntry8; Index 1350;		Information not available
// DdEntry9; Index 1351;		Information not available
// DdNotifyFullscreenSpriteUpdate; Index 1352;	Information not available
// DdQueryVisRgnUniqueness; Index 1353;	Information not available
// DeleteEMFSpoolData; Index 1356;	Information not available
// DestroyOPMProtectedOutput; Index 1361;	Information not available
// DestroyPhysicalMonitorInternal; Index 1362;	Information not available
// DeviceCapabilitiesExA; Index 1363;	Information not available
// DeviceCapabilitiesExW; Index 1364;	Information not available
// DocumentEventEx; Index 1365;		Information not available
// DwmGetDirtyRgnImpl; Index 1367;	Information not available
// DxTrimNotificationListHead; Index 1368;	Information not available
// EllipseStub; Index 1370;		Information not available
// EnableEUDC; Index 1371;		Information not available
// EndDocImpl; Index 1373;		Information not available
// EndFormPage; Index 1374;		Information not available
// EndGdiRendering; Index 1375;		Information not available
// EndPageImpl; Index 1377;		Information not available
// EndPathImpl; Index 1379;		Information not available
// EngAcquireSemaphore; Index 1380;	Information not available
// EngAlphaBlend; Index 1381;		Information not available
// EngAssociateSurface; Index 1382;	Information not available
// EngBitBlt; Index 1383;		Information not available
// EngCheckAbort; Index 1384;		Information not available
// EngComputeGlyphSet; Index 1385;	Information not available
// EngCopyBits; Index 1386;		Information not available
// EngCreateBitmap; Index 1387;		Information not available
// EngCreateClip; Index 1388;		Information not available
// EngCreateDeviceBitmap; Index 1389;	Information not available
// EngCreateDeviceSurface; Index 1390;	Information not available
// EngCreatePalette; Index 1391;	Information not available
// EngCreateSemaphore; Index 1392;	Information not available
// EngDeleteClip; Index 1393;		Information not available
// EngDeletePalette; Index 1394;	Information not available
// EngDeletePath; Index 1395;		Information not available
// EngDeleteSemaphore; Index 1396;	Information not available
// EngDeleteSurface; Index 1397;	Information not available
// EngEraseSurface; Index 1398;		Information not available
// EngFillPath; Index 1399;		Information not available
// EngFindResource; Index 1400;		Information not available
// EngFreeModule; Index 1401;		Information not available
// EngGetCurrentCodePage; Index 1402;	Information not available
// EngGetDriverName; Index 1403;	Information not available
// EngGetPrinterDataFileName; Index 1404;	Information not available
// EngGradientFill; Index 1405;		Information not available
// EngLineTo; Index 1406;		Information not available
// EngLoadModule; Index 1407;		Information not available
// EngLockSurface; Index 1408;		Information not available
// EngMarkBandingSurface; Index 1409;	Information not available
// EngMultiByteToUnicodeN; Index 1410;	Information not available
// EngMultiByteToWideChar; Index 1411;	Information not available
// EngPaint; Index 1412;		Information not available
// EngPlgBlt; Index 1413;		Information not available
// EngQueryEMFInfo; Index 1414;		Information not available
// EngQueryLocalTime; Index 1415;	Information not available
// EngReleaseSemaphore; Index 1416;	Information not available
// EngStretchBlt; Index 1417;		Information not available
// EngStretchBltROP; Index 1418;	Information not available
// EngStrokeAndFillPath; Index 1419;	Information not available
// EngStrokePath; Index 1420;		Information not available
// EngTextOut; Index 1421;		Information not available
// EngTransparentBlt; Index 1422;	Information not available
// EngUnicodeToMultiByteN; Index 1423;	Information not available
// EngUnlockSurface; Index 1424;	Information not available
// EngWideCharToMultiByte; Index 1425;	Information not available
// EnumEnhMetaFileStub; Index 1427;	Information not available
// EscapeImpl; Index 1440;		Information not available
// EudcLoadLinkW; Index 1441;		Information not available
// EudcUnloadLinkW; Index 1442;		Information not available
// ExtEscapeImpl; Index 1447;		Information not available
// ExtSelectClipRgnImpl; Index 1450;	Information not available
// ExtTextOutAImpl; Index 1452;		Information not available
// ExtTextOutWImpl; Index 1454;		Information not available
// FONTOBJ_cGetAllGlyphHandles; Index 1455;	Information not available
// FONTOBJ_cGetGlyphs; Index 1456;	Information not available
// FONTOBJ_pQueryGlyphAttrs; Index 1457;	Information not available
// FONTOBJ_pfdg; Index 1458;		Information not available
// FONTOBJ_pifi; Index 1459;		Information not available
// FONTOBJ_pvTrueTypeFontFile; Index 1460;	Information not available
// FONTOBJ_pxoGetXform; Index 1461;	Information not available
// FONTOBJ_vGetInfo; Index 1462;	Information not available
// FillPathImpl; Index 1464;		Information not available
// FillRgnStub; Index 1466;		Information not available
// FixBrushOrgEx; Index 1467;		Information not available
// FontIsLinked; Index 1470;		Information not available
// FrameRgnStub; Index 1472;		Information not available
// Gdi32DllInitialize; Index 1473;	Information not available
// GdiAddFontResourceW; Index 1474;	Information not available
// GdiAddGlsBounds; Index 1475;		Information not available
// GdiAddGlsRecord; Index 1476;		Information not available
// GdiAlphaBlend; Index 1477;		Information not available
// GdiArtificialDecrementDriver; Index 1478;	Information not available
// GdiBatchLimit; Index 1479;		Information not available
// GdiCleanCacheDC; Index 1480;		Information not available
// GdiCommentStub; Index 1482;		Information not available
// GdiConsoleTextOut; Index 1483;	Information not available
// GdiConvertAndCheckDC; Index 1484;	Information not available
// GdiConvertBitmap; Index 1485;	Information not available
// GdiConvertBitmapV5; Index 1486;	Information not available
// GdiConvertBrush; Index 1487;		Information not available
// GdiConvertDC; Index 1488;		Information not available
// GdiConvertEnhMetaFile; Index 1489;	Information not available
// GdiConvertFont; Index 1490;		Information not available
// GdiConvertMetaFilePict; Index 1491;	Information not available
// GdiConvertPalette; Index 1492;	Information not available
// GdiConvertRegion; Index 1493;	Information not available
// GdiConvertToDevmodeW; Index 1494;	Information not available
// GdiCreateLocalEnhMetaFile; Index 1495;	Information not available
// GdiCreateLocalMetaFilePict; Index 1496;	Information not available
// GdiDeleteLocalDC; Index 1497;	Information not available
// GdiDeleteSpoolFileHandle; Index 1498;	Information not available
// GdiDescribePixelFormat; Index 1499;	Information not available
// GdiDllInitialize; Index 1500;	Information not available
// GdiDllInitializeWrapper; Index 1501;	Information not available
// GdiDrawStream; Index 1502;		Information not available
// GdiEndDocEMF; Index 1503;		Information not available
// GdiEndPageEMF; Index 1504;		Information not available
// GdiEntry10; Index 1505;		Information not available
// GdiEntry11; Index 1506;		Information not available
// GdiEntry12; Index 1507;		Information not available
// GdiEntry13; Index 1508;		Information not available
// GdiEntry14; Index 1509;		Information not available
// GdiEntry15; Index 1510;		Information not available
// GdiEntry16; Index 1511;		Information not available
// GdiEntry1; Index 1512;		Information not available
// GdiEntry2; Index 1513;		Information not available
// GdiEntry3; Index 1514;		Information not available
// GdiEntry4; Index 1515;		Information not available
// GdiEntry5; Index 1516;		Information not available
// GdiEntry6; Index 1517;		Information not available
// GdiEntry7; Index 1518;		Information not available
// GdiEntry8; Index 1519;		Information not available
// GdiEntry9; Index 1520;		Information not available
// GdiFixUpHandle; Index 1521;		Information not available
// GdiFullscreenControl; Index 1523;	Information not available
// GdiGetBitmapBitsSize; Index 1525;	Information not available
// GdiGetCharDimensions; Index 1526;	Information not available
// GdiGetCodePage; Index 1527;		Information not available
// GdiGetDC; Index 1528;		Information not available
// GdiGetDevmodeForPage; Index 1529;	Information not available
// GdiGetEntry; Index 1530;		Information not available
// GdiGetLocalBrush; Index 1531;	Information not available
// GdiGetLocalDC; Index 1532;		Information not available
// GdiGetLocalFont; Index 1533;		Information not available
// GdiGetPageCount; Index 1534;		Information not available
// GdiGetPageHandle; Index 1535;	Information not available
// GdiGetSpoolFileHandle; Index 1536;	Information not available
// GdiGetSpoolMessage; Index 1537;	Information not available
// GdiGradientFill; Index 1538;		Information not available
// GdiInitSpool; Index 1539;		Information not available
// GdiInitializeLanguagePack; Index 1540;	Information not available
// GdiIsMetaFileDC; Index 1541;		Information not available
// GdiIsMetaPrintDC; Index 1542;	Information not available
// GdiIsPlayMetafileDC; Index 1543;	Information not available
// GdiIsScreenDC; Index 1544;		Information not available
// GdiIsUMPDSandboxingEnabled; Index 1545;	Information not available
// GdiLoadType1Fonts; Index 1546;	Information not available
// GdiPlayDCScript; Index 1547;		Information not available
// GdiPlayEMF; Index 1548;		Information not available
// GdiPlayJournal; Index 1549;		Information not available
// GdiPlayPageEMF; Index 1550;		Information not available
// GdiPlayPrivatePageEMF; Index 1551;	Information not available
// GdiPlayScript; Index 1552;		Information not available
// GdiPrinterThunk; Index 1553;		Information not available
// GdiProcessSetup; Index 1554;		Information not available
// GdiQueryFonts; Index 1555;		Information not available
// GdiQueryTable; Index 1556;		Information not available
// GdiRealizationInfo; Index 1557;	Information not available
// GdiReleaseDC; Index 1558;		Information not available
// GdiReleaseLocalDC; Index 1559;	Information not available
// GdiResetDCEMF; Index 1560;		Information not available
// GdiSetAttrs; Index 1561;		Information not available
// GdiSetLastError; Index 1563;		Information not available
// GdiSetPixelFormat; Index 1564;	Information not available
// GdiSetServerAttr; Index 1565;	Information not available
// GdiStartDocEMF; Index 1566;		Information not available
// GdiStartPageEMF; Index 1567;		Information not available
// GdiSupportsFontChangeEvent; Index 1568;	Information not available
// GdiSwapBuffers; Index 1569;		Information not available
// GdiTransparentBlt; Index 1570;	Information not available
// GdiValidateHandle; Index 1571;	Information not available
// GetBitmapAttributes; Index 1574;	Information not available
// GetBrushAttributes; Index 1580;	Information not available
// GetCOPPCompatibleOPMInformation; Index 1582;	Information not available
// GetCertificate; Index 1583;		Information not available
// GetCertificateByHandle; Index 1584;	Information not available
// GetCertificateSize; Index 1585;	Information not available
// GetCertificateSizeByHandle; Index 1586;	Information not available
// GetCharWidthInfo; Index 1598;	Information not available
// GetClipBoxImpl; Index 1603;		Information not available
// GetCodePage; Index 1605;		Information not available
// GetCurrentDpiInfo; Index 1608;	Information not available
// GetCurrentPositionExStub; Index 1611;	Information not available
// GetETM; Index 1619;			Information not available
// GetEUDCTimeStamp; Index 1620;	Information not available
// GetEUDCTimeStampExW; Index 1621;	Information not available
// GetEnhMetaFileAStub; Index 1623;	Information not available
// GetEnhMetaFileDescriptionAStub; Index 1626;	Information not available
// GetFontAssocStatus; Index 1632;	Information not available
// GetFontDataImpl; Index 1634;		Information not available
// GetFontFileData; Index 1635;		Information not available
// GetFontFileInfo; Index 1636;		Information not available
// GetFontRealizationInfo; Index 1638;	Information not available
// GetFontResourceInfoW; Index 1639;	Information not available
// GetGlyphOutline; Index 1643;		Information not available
// GetGlyphOutlineAStub; Index 1645;	Information not available
// GetGlyphOutlineWow; Index 1647;	Information not available
// GetHFONT; Index 1649;		Information not available
// GetKerningPairsA; Index 1653;	Information not available
// GetKerningPairsW; Index 1654;	Information not available
// GetLayout; Index 1655;		Information not available
// GetNumberOfPhysicalMonitors; Index 1666;	Information not available
// GetOPMInformation; Index 1667;	Information not available
// GetOPMRandomNumber; Index 1668;	Information not available
// GetPhysicalMonitorDescription; Index 1676;	Information not available
// GetPhysicalMonitors; Index 1677;	Information not available
// GetProcessSessionFonts; Index 1681;	Information not available
// GetROP2Stub; Index 1683;		Information not available
// GetRandomRgn; Index 1684;		Information not available
// GetRasterizerCapsStub; Index 1686;	Information not available
// GetRelAbs; Index 1688;		Information not available
// GetStringBitmapA; Index 1692;	Information not available
// GetStringBitmapW; Index 1693;	Information not available
// GetSuggestedOPMProtectedOutputArraySize; Index 1694;	Information not available
// GetTextCharacterExtraStub; Index 1699;	Information not available
// GetTextExtentExPointAStub; Index 1704;	Information not available
// GetTextExtentExPointWPri; Index 1707;	Information not available
// GetTextExtentPoint32AStub; Index 1709;	Information not available
// GetTextExtentPointAStub; Index 1712;	Information not available
// GetTextFaceAliasW; Index 1716;	Information not available
// GetTextMetricsAImpl; Index 1719;	Information not available
// GetTransform; Index 1721;		Information not available
// HT_Get8BPPFormatPalette; Index 1728;	Information not available
// HT_Get8BPPMaskPalette; Index 1729;	Information not available
// IcmDeleteLocalDC; Index 1730;	Information not available
// IcmReleaseCachedColorSpace; Index 1731;	Information not available
// InternalDeleteDC; Index 1732;	Information not available
// IntersectClipRectImpl; Index 1734;	Information not available
// InvertRgnStub; Index 1736;		Information not available
// IsValidEnhMetaRecord; Index 1737;	Information not available
// IsValidEnhMetaRecordOffExt; Index 1738;	Information not available
// LineToImpl; Index 1742;		Information not available
// LpkDrawTextEx; Index 1743;		Information not available
// LpkEditControl; Index 1744;		Information not available
// LpkExtTextOut; Index 1745;		Information not available
// LpkGetCharacterPlacement; Index 1746;	Information not available
// LpkGetEditControl; Index 1747;	Information not available
// LpkGetTextExtentExPoint; Index 1748;	Information not available
// LpkInitialize; Index 1749;		Information not available
// LpkPSMTextOut; Index 1750;		Information not available
// LpkPresent; Index 1751;		Information not available
// LpkTabbedTextOut; Index 1752;	Information not available
// LpkUseGDIWidthCache; Index 1753;	Information not available
// LpkpEditControlSize; Index 1754;	Information not available
// LpkpInitializeEditControl; Index 1755;	Information not available
// MF16_DeleteObject; Index 1756;	Information not available
// MF_DeleteObject; Index 1757;		Information not available
// MirrorRgn; Index 1759;		Information not available
// ModerncoreGdiInit; Index 1760;	Information not available
// MoveToExImpl; Index 1763;		Information not available
// NamedEscape; Index 1764;		Information not available
// NtGdiAbortDoc; Index 1765;		Information not available
// NtGdiAbortPath; Index 1766;		Information not available
// NtGdiAddEmbFontToDC; Index 1767;	Information not available
// NtGdiAddFontMemResourceEx; Index 1768;	Information not available
// NtGdiAddFontResourceW; Index 1769;	Information not available
// NtGdiAddRemoteFontToDC; Index 1770;	Information not available
// NtGdiAddRemoteMMInstanceToDC; Index 1771;	Information not available
// NtGdiAlphaBlend; Index 1772;		Information not available
// NtGdiAngleArc; Index 1773;		Information not available
// NtGdiAnyLinkedFonts; Index 1774;	Information not available
// NtGdiArcInternal; Index 1775;	Information not available
// NtGdiBRUSHOBJ_DeleteRbrush; Index 1776;	Information not available
// NtGdiBRUSHOBJ_hGetColorTransform; Index 1777;	Information not available
// NtGdiBRUSHOBJ_pvAllocRbrush; Index 1778;	Information not available
// NtGdiBRUSHOBJ_pvGetRbrush; Index 1779;	Information not available
// NtGdiBRUSHOBJ_ulGetBrushColor; Index 1780;	Information not available
// NtGdiBeginGdiRendering; Index 1781;	Information not available
// NtGdiBeginPath; Index 1782;		Information not available
// NtGdiBitBlt; Index 1783;		Information not available
// NtGdiCLIPOBJ_bEnum; Index 1784;	Information not available
// NtGdiCLIPOBJ_cEnumStart; Index 1785;	Information not available
// NtGdiCLIPOBJ_ppoGetPath; Index 1786;	Information not available
// NtGdiCancelDC; Index 1787;		Information not available
// NtGdiChangeGhostFont; Index 1788;	Information not available
// NtGdiCheckBitmapBits; Index 1789;	Information not available
// NtGdiClearBitmapAttributes; Index 1790;	Information not available
// NtGdiClearBrushAttributes; Index 1791;	Information not available
// NtGdiCloseFigure; Index 1792;	Information not available
// NtGdiColorCorrectPalette; Index 1793;	Information not available
// NtGdiCombineRgn; Index 1794;		Information not available
// NtGdiCombineTransform; Index 1795;	Information not available
// NtGdiComputeXformCoefficients; Index 1796;	Information not available
// NtGdiConfigureOPMProtectedOutput; Index 1797;	Information not available
// NtGdiConvertMetafileRect; Index 1798;	Information not available
// NtGdiCreateBitmap; Index 1799;	Information not available
// NtGdiCreateBitmapFromDxSurface2; Index 1800;	Information not available
// NtGdiCreateBitmapFromDxSurface; Index 1801;	Information not available
// NtGdiCreateClientObj; Index 1802;	Information not available
// NtGdiCreateColorSpace; Index 1803;	Information not available
// NtGdiCreateColorTransform; Index 1804;	Information not available
// NtGdiCreateCompatibleBitmap; Index 1805;	Information not available
// NtGdiCreateCompatibleDC; Index 1806;	Information not available
// NtGdiCreateDIBBrush; Index 1807;	Information not available
// NtGdiCreateDIBSection; Index 1808;	Information not available
// NtGdiCreateDIBitmapInternal; Index 1809;	Information not available
// NtGdiCreateEllipticRgn; Index 1810;	Information not available
// NtGdiCreateHalftonePalette; Index 1811;	Information not available
// NtGdiCreateHatchBrushInternal; Index 1812;	Information not available
// NtGdiCreateMetafileDC; Index 1813;	Information not available
// NtGdiCreateOPMProtectedOutput; Index 1814;	Information not available
// NtGdiCreateOPMProtectedOutputs; Index 1815;	Information not available
// NtGdiCreatePaletteInternal; Index 1816;	Information not available
// NtGdiCreatePatternBrushInternal; Index 1817;	Information not available
// NtGdiCreatePen; Index 1818;		Information not available
// NtGdiCreateRectRgn; Index 1819;	Information not available
// NtGdiCreateRoundRectRgn; Index 1820;	Information not available
// NtGdiCreateServerMetaFile; Index 1821;	Information not available
// NtGdiCreateSessionMappedDIBSection; Index 1822;	Information not available
// NtGdiCreateSolidBrush; Index 1823;	Information not available
// NtGdiD3dContextCreate; Index 1824;	Information not available
// NtGdiD3dContextDestroy; Index 1825;	Information not available
// NtGdiD3dContextDestroyAll; Index 1826;	Information not available
// NtGdiD3dDrawPrimitives2; Index 1827;	Information not available
// NtGdiD3dValidateTextureStageState; Index 1828;	Information not available
// NtGdiDDCCIGetCapabilitiesString; Index 1829;	Information not available
// NtGdiDDCCIGetCapabilitiesStringLength; Index 1830;	Information not available
// NtGdiDDCCIGetTimingReport; Index 1831;	Information not available
// NtGdiDDCCIGetVCPFeature; Index 1832;	Information not available
// NtGdiDDCCISaveCurrentSettings; Index 1833;	Information not available
// NtGdiDDCCISetVCPFeature; Index 1834;	Information not available
// NtGdiDdAddAttachedSurface; Index 1835;	Information not available
// NtGdiDdAlphaBlt; Index 1836;		Information not available
// NtGdiDdAttachSurface; Index 1837;	Information not available
// NtGdiDdBeginMoCompFrame; Index 1838;	Information not available
// NtGdiDdBlt; Index 1839;		Information not available
// NtGdiDdCanCreateD3DBuffer; Index 1840;	Information not available
// NtGdiDdCanCreateSurface; Index 1841;	Information not available
// NtGdiDdColorControl; Index 1842;	Information not available
// NtGdiDdCreateD3DBuffer; Index 1843;	Information not available
// NtGdiDdCreateDirectDrawObject; Index 1844;	Information not available
// NtGdiDdCreateFullscreenSprite; Index 1845;	Information not available
// NtGdiDdCreateMoComp; Index 1846;	Information not available
// NtGdiDdCreateSurface; Index 1847;	Information not available
// NtGdiDdCreateSurfaceEx; Index 1848;	Information not available
// NtGdiDdCreateSurfaceObject; Index 1849;	Information not available
// NtGdiDdDDIAbandonSwapChain; Index 1850;	Information not available
// NtGdiDdDDIAcquireKeyedMutex2; Index 1851;	Information not available
// NtGdiDdDDIAcquireKeyedMutex; Index 1852;	Information not available
// NtGdiDdDDIAcquireSwapChain; Index 1853;	Information not available
// NtGdiDdDDIAdjustFullscreenGamma; Index 1854;	Information not available
// NtGdiDdDDICacheHybridQueryValue; Index 1855;	Information not available
// NtGdiDdDDIChangeVideoMemoryReservation; Index 1856;	Information not available
// NtGdiDdDDICheckExclusiveOwnership; Index 1857;	Information not available
// NtGdiDdDDICheckMonitorPowerState; Index 1858;	Information not available
// NtGdiDdDDICheckMultiPlaneOverlaySupport2; Index 1859;	Information not available
// NtGdiDdDDICheckMultiPlaneOverlaySupport3; Index 1860;	Information not available
// NtGdiDdDDICheckMultiPlaneOverlaySupport; Index 1861;	Information not available
// NtGdiDdDDICheckOcclusion; Index 1862;	Information not available
// NtGdiDdDDICheckSharedResourceAccess; Index 1863;	Information not available
// NtGdiDdDDICheckVidPnExclusiveOwnership; Index 1864;	Information not available
// NtGdiDdDDICloseAdapter; Index 1865;	Information not available
// NtGdiDdDDIConfigureSharedResource; Index 1866;	Information not available
// NtGdiDdDDICreateAllocation; Index 1867;	Information not available
// NtGdiDdDDICreateContext; Index 1868;	Information not available
// NtGdiDdDDICreateContextVirtual; Index 1869;	Information not available
// NtGdiDdDDICreateDCFromMemory; Index 1870;	Information not available
// NtGdiDdDDICreateDevice; Index 1871;	Information not available
// NtGdiDdDDICreateKeyedMutex2; Index 1872;	Information not available
// NtGdiDdDDICreateKeyedMutex; Index 1873;	Information not available
// NtGdiDdDDICreateOutputDupl; Index 1874;	Information not available
// NtGdiDdDDICreateOverlay; Index 1875;	Information not available
// NtGdiDdDDICreatePagingQueue; Index 1876;	Information not available
// NtGdiDdDDICreateSwapChain; Index 1877;	Information not available
// NtGdiDdDDICreateSynchronizationObject; Index 1878;	Information not available
// NtGdiDdDDIDestroyAllocation2; Index 1879;	Information not available
// NtGdiDdDDIDestroyAllocation; Index 1880;	Information not available
// NtGdiDdDDIDestroyContext; Index 1881;	Information not available
// NtGdiDdDDIDestroyDCFromMemory; Index 1882;	Information not available
// NtGdiDdDDIDestroyDevice; Index 1883;	Information not available
// NtGdiDdDDIDestroyKeyedMutex; Index 1884;	Information not available
// NtGdiDdDDIDestroyOutputDupl; Index 1885;	Information not available
// NtGdiDdDDIDestroyOverlay; Index 1886;	Information not available
// NtGdiDdDDIDestroyPagingQueue; Index 1887;	Information not available
// NtGdiDdDDIDestroySynchronizationObject; Index 1888;	Information not available
// NtGdiDdDDIEnumAdapters2; Index 1889;	Information not available
// NtGdiDdDDIEnumAdapters; Index 1890;	Information not available
// NtGdiDdDDIEscape; Index 1891;	Information not available
// NtGdiDdDDIEvict; Index 1892;		Information not available
// NtGdiDdDDIFlipOverlay; Index 1893;	Information not available
// NtGdiDdDDIFlushHeapTransitions; Index 1894;	Information not available
// NtGdiDdDDIFreeGpuVirtualAddress; Index 1895;	Information not available
// NtGdiDdDDIGetCachedHybridQueryValue; Index 1896;	Information not available
// NtGdiDdDDIGetContextInProcessSchedulingPriority; Index 1897;	Information not available
// NtGdiDdDDIGetContextSchedulingPriority; Index 1898;	Information not available
// NtGdiDdDDIGetDWMVerticalBlankEvent; Index 1899;	Information not available
// NtGdiDdDDIGetDeviceState; Index 1900;	Information not available
// NtGdiDdDDIGetDisplayModeList; Index 1901;	Information not available
// NtGdiDdDDIGetMultisampleMethodList; Index 1902;	Information not available
// NtGdiDdDDIGetOverlayState; Index 1903;	Information not available
// NtGdiDdDDIGetPresentHistory; Index 1904;	Information not available
// NtGdiDdDDIGetPresentQueueEvent; Index 1905;	Information not available
// NtGdiDdDDIGetProcessSchedulingPriorityClass; Index 1906;	Information not available
// NtGdiDdDDIGetResourcePresentPrivateDriverData; Index 1907;	Information not available
// NtGdiDdDDIGetRuntimeData; Index 1908;	Information not available
// NtGdiDdDDIGetScanLine; Index 1909;	Information not available
// NtGdiDdDDIGetSetSwapChainMetadata; Index 1910;	Information not available
// NtGdiDdDDIGetSharedPrimaryHandle; Index 1911;	Information not available
// NtGdiDdDDIGetSharedResourceAdapterLuid; Index 1912;	Information not available
// NtGdiDdDDIInvalidateActiveVidPn; Index 1913;	Information not available
// NtGdiDdDDIInvalidateCache; Index 1914;	Information not available
// NtGdiDdDDILock2; Index 1915;		Information not available
// NtGdiDdDDILock; Index 1916;		Information not available
// NtGdiDdDDIMakeResident; Index 1917;	Information not available
// NtGdiDdDDIMapGpuVirtualAddress; Index 1918;	Information not available
// NtGdiDdDDIMarkDeviceAsError; Index 1919;	Information not available
// NtGdiDdDDINetDispGetNextChunkInfo; Index 1920;	Information not available
// NtGdiDdDDINetDispQueryMiracastDisplayDeviceStatus; Index 1921;	Information not available
// NtGdiDdDDINetDispQueryMiracastDisplayDeviceSupport; Index 1922;	Information not available
// NtGdiDdDDINetDispStartMiracastDisplayDevice; Index 1923;	Information not available
// NtGdiDdDDINetDispStopMiracastDisplayDevice; Index 1924;	Information not available
// NtGdiDdDDINetDispStopSessions; Index 1925;	Information not available
// NtGdiDdDDIOfferAllocations; Index 1926;	Information not available
// NtGdiDdDDIOpenAdapterFromDeviceName; Index 1927;	Information not available
// NtGdiDdDDIOpenAdapterFromHdc; Index 1928;	Information not available
// NtGdiDdDDIOpenAdapterFromLuid; Index 1929;	Information not available
// NtGdiDdDDIOpenKeyedMutex2; Index 1930;	Information not available
// NtGdiDdDDIOpenKeyedMutex; Index 1931;	Information not available
// NtGdiDdDDIOpenNtHandleFromName; Index 1932;	Information not available
// NtGdiDdDDIOpenResource; Index 1933;	Information not available
// NtGdiDdDDIOpenResourceFromNtHandle; Index 1934;	Information not available
// NtGdiDdDDIOpenSwapChain; Index 1935;	Information not available
// NtGdiDdDDIOpenSyncObjectFromNtHandle2; Index 1936;	Information not available
// NtGdiDdDDIOpenSyncObjectFromNtHandle; Index 1937;	Information not available
// NtGdiDdDDIOpenSyncObjectNtHandleFromName; Index 1938;	Information not available
// NtGdiDdDDIOpenSynchronizationObject; Index 1939;	Information not available
// NtGdiDdDDIOutputDuplGetFrameInfo; Index 1940;	Information not available
// NtGdiDdDDIOutputDuplGetMetaData; Index 1941;	Information not available
// NtGdiDdDDIOutputDuplGetPointerShapeData; Index 1942;	Information not available
// NtGdiDdDDIOutputDuplPresent; Index 1943;	Information not available
// NtGdiDdDDIOutputDuplReleaseFrame; Index 1944;	Information not available
// NtGdiDdDDIPinDirectFlipResources; Index 1945;	Information not available
// NtGdiDdDDIPollDisplayChildren; Index 1946;	Information not available
// NtGdiDdDDIPresent; Index 1947;	Information not available
// NtGdiDdDDIPresentMultiPlaneOverlay2; Index 1948;	Information not available
// NtGdiDdDDIPresentMultiPlaneOverlay3; Index 1949;	Information not available
// NtGdiDdDDIPresentMultiPlaneOverlay; Index 1950;	Information not available
// NtGdiDdDDIQueryAdapterInfo; Index 1951;	Information not available
// NtGdiDdDDIQueryAllocationResidency; Index 1952;	Information not available
// NtGdiDdDDIQueryClockCalibration; Index 1953;	Information not available
// NtGdiDdDDIQueryFSEBlock; Index 1954;	Information not available
// NtGdiDdDDIQueryProcessOfferInfo; Index 1955;	Information not available
// NtGdiDdDDIQueryRemoteVidPnSourceFromGdiDisplayName; Index 1956;	Information not available
// NtGdiDdDDIQueryResourceInfo; Index 1957;	Information not available
// NtGdiDdDDIQueryResourceInfoFromNtHandle; Index 1958;	Information not available
// NtGdiDdDDIQueryStatistics; Index 1959;	Information not available
// NtGdiDdDDIQueryVidPnExclusiveOwnership; Index 1960;	Information not available
// NtGdiDdDDIQueryVideoMemoryInfo; Index 1961;	Information not available
// NtGdiDdDDIReclaimAllocations2; Index 1962;	Information not available
// NtGdiDdDDIReclaimAllocations; Index 1963;	Information not available
// NtGdiDdDDIReleaseKeyedMutex2; Index 1964;	Information not available
// NtGdiDdDDIReleaseKeyedMutex; Index 1965;	Information not available
// NtGdiDdDDIReleaseProcessVidPnSourceOwners; Index 1966;	Information not available
// NtGdiDdDDIReleaseSwapChain; Index 1967;	Information not available
// NtGdiDdDDIRender; Index 1968;	Information not available
// NtGdiDdDDIReserveGpuVirtualAddress; Index 1969;	Information not available
// NtGdiDdDDISetAllocationPriority; Index 1970;	Information not available
// NtGdiDdDDISetContextInProcessSchedulingPriority; Index 1971;	Information not available
// NtGdiDdDDISetContextSchedulingPriority; Index 1972;	Information not available
// NtGdiDdDDISetDisplayMode; Index 1973;	Information not available
// NtGdiDdDDISetDisplayPrivateDriverFormat; Index 1974;	Information not available
// NtGdiDdDDISetDodIndirectSwapchain; Index 1975;	Information not available
// NtGdiDdDDISetFSEBlock; Index 1976;	Information not available
// NtGdiDdDDISetGammaRamp; Index 1977;	Information not available
// NtGdiDdDDISetHwProtectionTeardownRecovery; Index 1978;	Information not available
// NtGdiDdDDISetProcessSchedulingPriorityClass; Index 1979;	Information not available
// NtGdiDdDDISetQueuedLimit; Index 1980;	Information not available
// NtGdiDdDDISetStablePowerState; Index 1981;	Information not available
// NtGdiDdDDISetStereoEnabled; Index 1982;	Information not available
// NtGdiDdDDISetSyncRefreshCountWaitTarget; Index 1983;	Information not available
// NtGdiDdDDISetVidPnSourceHwProtection; Index 1984;	Information not available
// NtGdiDdDDISetVidPnSourceOwner1; Index 1985;	Information not available
// NtGdiDdDDISetVidPnSourceOwner; Index 1986;	Information not available
// NtGdiDdDDIShareObjects; Index 1987;	Information not available
// NtGdiDdDDISharedPrimaryLockNotification; Index 1988;	Information not available
// NtGdiDdDDISharedPrimaryUnLockNotification; Index 1989;	Information not available
// NtGdiDdDDISignalSynchronizationObject; Index 1990;	Information not available
// NtGdiDdDDISignalSynchronizationObjectFromCpu; Index 1991;	Information not available
// NtGdiDdDDISignalSynchronizationObjectFromGpu2; Index 1992;	Information not available
// NtGdiDdDDISignalSynchronizationObjectFromGpu; Index 1993;	Information not available
// NtGdiDdDDISubmitCommand; Index 1994;	Information not available
// NtGdiDdDDITrimProcessCommitment; Index 1995;	Information not available
// NtGdiDdDDIUnlock2; Index 1996;	Information not available
// NtGdiDdDDIUnlock; Index 1997;	Information not available
// NtGdiDdDDIUnpinDirectFlipResources; Index 1998;	Information not available
// NtGdiDdDDIUpdateAllocationProperty; Index 1999;	Information not available
// CreateDCExW; Index 2000;		Information not available
// NtGdiDdDDIUpdateGpuVirtualAddress; Index 2001;	Information not available
// NtGdiDdDDIUpdateOverlay; Index 2002;	Information not available
// NtGdiDdDDIWaitForIdle; Index 2003;	Information not available
// NtGdiDdDDIWaitForSynchronizationObject; Index 2004;	Information not available
// NtGdiDdDDIWaitForSynchronizationObjectFromCpu; Index 2005;	Information not available
// NtGdiDdDDIWaitForSynchronizationObjectFromGpu; Index 2006;	Information not available
// NtGdiDdDDIWaitForVerticalBlankEvent2; Index 2007;	Information not available
// NtGdiDdDDIWaitForVerticalBlankEvent; Index 2008;	Information not available
// NtGdiDdDeleteDirectDrawObject; Index 2009;	Information not available
// NtGdiDdDeleteSurfaceObject; Index 2010;	Information not available
// NtGdiDdDestroyD3DBuffer; Index 2011;	Information not available
// NtGdiDdDestroyFullscreenSprite; Index 2012;	Information not available
// NtGdiDdDestroyMoComp; Index 2013;	Information not available
// NtGdiDdDestroySurface; Index 2014;	Information not available
// NtGdiDdEndMoCompFrame; Index 2015;	Information not available
// NtGdiDdFlip; Index 2016;		Information not available
// NtGdiDdFlipToGDISurface; Index 2017;	Information not available
// NtGdiDdGetAvailDriverMemory; Index 2018;	Information not available
// NtGdiDdGetBltStatus; Index 2019;	Information not available
// NtGdiDdGetDC; Index 2020;		Information not available
// NtGdiDdGetDriverInfo; Index 2021;	Information not available
// NtGdiDdGetDriverState; Index 2022;	Information not available
// NtGdiDdGetDxHandle; Index 2023;	Information not available
// NtGdiDdGetFlipStatus; Index 2024;	Information not available
// NtGdiDdGetInternalMoCompInfo; Index 2025;	Information not available
// NtGdiDdGetMoCompBuffInfo; Index 2026;	Information not available
// NtGdiDdGetMoCompFormats; Index 2027;	Information not available
// NtGdiDdGetMoCompGuids; Index 2028;	Information not available
// NtGdiDdGetScanLine; Index 2029;	Information not available
// NtGdiDdLock; Index 2030;		Information not available
// NtGdiDdLockD3D; Index 2031;		Information not available
// NtGdiDdNotifyFullscreenSpriteUpdate; Index 2032;	Information not available
// NtGdiDdQueryDirectDrawObject; Index 2033;	Information not available
// NtGdiDdQueryMoCompStatus; Index 2034;	Information not available
// NtGdiDdQueryVisRgnUniqueness; Index 2035;	Information not available
// NtGdiDdReenableDirectDrawObject; Index 2036;	Information not available
// NtGdiDdReleaseDC; Index 2037;	Information not available
// NtGdiDdRenderMoComp; Index 2038;	Information not available
// NtGdiDdResetVisrgn; Index 2039;	Information not available
// NtGdiDdSetColorKey; Index 2040;	Information not available
// NtGdiDdSetExclusiveMode; Index 2041;	Information not available
// NtGdiDdSetGammaRamp; Index 2042;	Information not available
// NtGdiDdSetOverlayPosition; Index 2043;	Information not available
// NtGdiDdUnattachSurface; Index 2044;	Information not available
// NtGdiDdUnlock; Index 2045;		Information not available
// NtGdiDdUnlockD3D; Index 2046;	Information not available
// NtGdiDdUpdateOverlay; Index 2047;	Information not available
// NtGdiDdWaitForVerticalBlank; Index 2048;	Information not available
// NtGdiDeleteClientObj; Index 2049;	Information not available
// NtGdiDeleteColorSpace; Index 2050;	Information not available
// NtGdiDeleteColorTransform; Index 2051;	Information not available
// NtGdiDeleteObjectApp; Index 2052;	Information not available
// NtGdiDescribePixelFormat; Index 2053;	Information not available
// NtGdiDestroyOPMProtectedOutput; Index 2054;	Information not available
// NtGdiDestroyPhysicalMonitor; Index 2055;	Information not available
// NtGdiDoBanding; Index 2056;		Information not available
// NtGdiDoPalette; Index 2057;		Information not available
// NtGdiDrawEscape; Index 2058;		Information not available
// NtGdiDrawStream; Index 2059;		Information not available
// NtGdiDvpAcquireNotification; Index 2060;	Information not available
// NtGdiDvpCanCreateVideoPort; Index 2061;	Information not available
// NtGdiDvpColorControl; Index 2062;	Information not available
// NtGdiDvpCreateVideoPort; Index 2063;	Information not available
// NtGdiDvpDestroyVideoPort; Index 2064;	Information not available
// NtGdiDvpFlipVideoPort; Index 2065;	Information not available
// NtGdiDvpGetVideoPortBandwidth; Index 2066;	Information not available
// NtGdiDvpGetVideoPortConnectInfo; Index 2067;	Information not available
// NtGdiDvpGetVideoPortField; Index 2068;	Information not available
// NtGdiDvpGetVideoPortFlipStatus; Index 2069;	Information not available
// NtGdiDvpGetVideoPortInputFormats; Index 2070;	Information not available
// NtGdiDvpGetVideoPortLine; Index 2071;	Information not available
// NtGdiDvpGetVideoPortOutputFormats; Index 2072;	Information not available
// NtGdiDvpGetVideoSignalStatus; Index 2073;	Information not available
// NtGdiDvpReleaseNotification; Index 2074;	Information not available
// NtGdiDvpUpdateVideoPort; Index 2075;	Information not available
// NtGdiDvpWaitForVideoPortSync; Index 2076;	Information not available
// NtGdiDwmCreatedBitmapRemotingOutput; Index 2077;	Information not available
// NtGdiDxgGenericThunk; Index 2078;	Information not available
// NtGdiEllipse; Index 2079;		Information not available
// NtGdiEnableEudc; Index 2080;		Information not available
// NtGdiEndDoc; Index 2081;		Information not available
// NtGdiEndGdiRendering; Index 2082;	Information not available
// NtGdiEndPage; Index 2083;		Information not available
// NtGdiEndPath; Index 2084;		Information not available
// NtGdiEngAlphaBlend; Index 2085;	Information not available
// NtGdiEngAssociateSurface; Index 2086;	Information not available
// NtGdiEngBitBlt; Index 2087;		Information not available
// NtGdiEngCheckAbort; Index 2088;	Information not available
// NtGdiEngComputeGlyphSet; Index 2089;	Information not available
// NtGdiEngCopyBits; Index 2090;	Information not available
// NtGdiEngCreateBitmap; Index 2091;	Information not available
// NtGdiEngCreateClip; Index 2092;	Information not available
// NtGdiEngCreateDeviceBitmap; Index 2093;	Information not available
// NtGdiEngCreateDeviceSurface; Index 2094;	Information not available
// NtGdiEngCreatePalette; Index 2095;	Information not available
// NtGdiEngDeleteClip; Index 2096;	Information not available
// NtGdiEngDeletePalette; Index 2097;	Information not available
// NtGdiEngDeletePath; Index 2098;	Information not available
// NtGdiEngDeleteSurface; Index 2099;	Information not available
// NtGdiEngEraseSurface; Index 2100;	Information not available
// NtGdiEngFillPath; Index 2101;	Information not available
// NtGdiEngGradientFill; Index 2102;	Information not available
// NtGdiEngLineTo; Index 2103;		Information not available
// NtGdiEngLockSurface; Index 2104;	Information not available
// NtGdiEngMarkBandingSurface; Index 2105;	Information not available
// NtGdiEngPaint; Index 2106;		Information not available
// NtGdiEngPlgBlt; Index 2107;		Information not available
// NtGdiEngStretchBlt; Index 2108;	Information not available
// NtGdiEngStretchBltROP; Index 2109;	Information not available
// NtGdiEngStrokeAndFillPath; Index 2110;	Information not available
// NtGdiEngStrokePath; Index 2111;	Information not available
// NtGdiEngTextOut; Index 2112;		Information not available
// NtGdiEngTransparentBlt; Index 2113;	Information not available
// NtGdiEngUnlockSurface; Index 2114;	Information not available
// NtGdiEnumFonts; Index 2115;		Information not available
// NtGdiEnumObjects; Index 2116;	Information not available
// NtGdiEqualRgn; Index 2117;		Information not available
// NtGdiEudcLoadUnloadLink; Index 2118;	Information not available
// NtGdiExcludeClipRect; Index 2119;	Information not available
// NtGdiExtCreatePen; Index 2120;	Information not available
// NtGdiExtCreateRegion; Index 2121;	Information not available
// NtGdiExtEscape; Index 2122;		Information not available
// NtGdiExtFloodFill; Index 2123;	Information not available
// NtGdiExtGetObjectW; Index 2124;	Information not available
// NtGdiExtSelectClipRgn; Index 2125;	Information not available
// NtGdiExtTextOutW; Index 2126;	Information not available
// NtGdiFONTOBJ_cGetAllGlyphHandles; Index 2127;	Information not available
// NtGdiFONTOBJ_cGetGlyphs; Index 2128;	Information not available
// NtGdiFONTOBJ_pQueryGlyphAttrs; Index 2129;	Information not available
// NtGdiFONTOBJ_pfdg; Index 2130;	Information not available
// NtGdiFONTOBJ_pifi; Index 2131;	Information not available
// NtGdiFONTOBJ_pvTrueTypeFontFile; Index 2132;	Information not available
// NtGdiFONTOBJ_pxoGetXform; Index 2133;	Information not available
// NtGdiFONTOBJ_vGetInfo; Index 2134;	Information not available
// NtGdiFillPath; Index 2135;		Information not available
// NtGdiFillRgn; Index 2136;		Information not available
// NtGdiFlattenPath; Index 2137;	Information not available
// NtGdiFlush; Index 2138;		Information not available
// NtGdiFontIsLinked; Index 2139;	Information not available
// NtGdiForceUFIMapping; Index 2140;	Information not available
// NtGdiFrameRgn; Index 2141;		Information not available
// NtGdiFullscreenControl; Index 2142;	Information not available
// NtGdiGetAndSetDCDword; Index 2143;	Information not available
// NtGdiGetAppClipBox; Index 2144;	Information not available
// NtGdiGetBitmapBits; Index 2145;	Information not available
// NtGdiGetBitmapDimension; Index 2146;	Information not available
// NtGdiGetBoundsRect; Index 2147;	Information not available
// NtGdiGetCOPPCompatibleOPMInformation; Index 2148;	Information not available
// NtGdiGetCertificate; Index 2149;	Information not available
// NtGdiGetCertificateByHandle; Index 2150;	Information not available
// NtGdiGetCertificateSize; Index 2151;	Information not available
// NtGdiGetCertificateSizeByHandle; Index 2152;	Information not available
// NtGdiGetCharABCWidthsW; Index 2153;	Information not available
// NtGdiGetCharSet; Index 2154;		Information not available
// NtGdiGetCharWidthInfo; Index 2155;	Information not available
// NtGdiGetCharWidthW; Index 2156;	Information not available
// NtGdiGetCharacterPlacementW; Index 2157;	Information not available
// NtGdiGetColorAdjustment; Index 2158;	Information not available
// NtGdiGetColorSpaceforBitmap; Index 2159;	Information not available
// NtGdiGetCurrentDpiInfo; Index 2160;	Information not available
// NtGdiGetDCDword; Index 2161;		Information not available
// NtGdiGetDCObject; Index 2162;	Information not available
// NtGdiGetDCPoint; Index 2163;		Information not available
// NtGdiGetDCforBitmap; Index 2164;	Information not available
// NtGdiGetDIBitsInternal; Index 2165;	Information not available
// NtGdiGetDeviceCaps; Index 2166;	Information not available
// NtGdiGetDeviceCapsAll; Index 2167;	Information not available
// NtGdiGetDeviceGammaRamp; Index 2168;	Information not available
// NtGdiGetDeviceWidth; Index 2169;	Information not available
// NtGdiGetDhpdev; Index 2170;		Information not available
// NtGdiGetETM; Index 2171;		Information not available
// NtGdiGetEmbUFI; Index 2172;		Information not available
// NtGdiGetEmbedFonts; Index 2173;	Information not available
// NtGdiGetEntry; Index 2174;		Information not available
// NtGdiGetEudcTimeStampEx; Index 2175;	Information not available
// NtGdiGetFontData; Index 2176;	Information not available
// NtGdiGetFontFileData; Index 2177;	Information not available
// NtGdiGetFontFileInfo; Index 2178;	Information not available
// NtGdiGetFontResourceInfoInternalW; Index 2179;	Information not available
// NtGdiGetFontUnicodeRanges; Index 2180;	Information not available
// NtGdiGetGlyphIndicesW; Index 2181;	Information not available
// NtGdiGetGlyphIndicesWInternal; Index 2182;	Information not available
// NtGdiGetGlyphOutline; Index 2183;	Information not available
// NtGdiGetKerningPairs; Index 2184;	Information not available
// NtGdiGetLinkedUFIs; Index 2185;	Information not available
// NtGdiGetMiterLimit; Index 2186;	Information not available
// NtGdiGetMonitorID; Index 2187;	Information not available
// NtGdiGetNearestColor; Index 2188;	Information not available
// NtGdiGetNearestPaletteIndex; Index 2189;	Information not available
// NtGdiGetNumberOfPhysicalMonitors; Index 2190;	Information not available
// NtGdiGetOPMInformation; Index 2191;	Information not available
// NtGdiGetOPMRandomNumber; Index 2192;	Information not available
// NtGdiGetObjectBitmapHandle; Index 2193;	Information not available
// NtGdiGetOutlineTextMetricsInternalW; Index 2194;	Information not available
// NtGdiGetPath; Index 2195;		Information not available
// NtGdiGetPerBandInfo; Index 2196;	Information not available
// NtGdiGetPhysicalMonitorDescription; Index 2197;	Information not available
// NtGdiGetPhysicalMonitors; Index 2198;	Information not available
// NtGdiGetPixel; Index 2199;		Information not available
// NtGdiGetRandomRgn; Index 2200;	Information not available
// NtGdiGetRasterizerCaps; Index 2201;	Information not available
// NtGdiGetRealizationInfo; Index 2202;	Information not available
// NtGdiGetRegionData; Index 2203;	Information not available
// NtGdiGetRgnBox; Index 2204;		Information not available
// NtGdiGetServerMetaFileBits; Index 2205;	Information not available
// NtGdiGetSpoolMessage; Index 2206;	Information not available
// NtGdiGetStats; Index 2207;		Information not available
// NtGdiGetStringBitmapW; Index 2208;	Information not available
// NtGdiGetSuggestedOPMProtectedOutputArraySize; Index 2209;	Information not available
// NtGdiGetSystemPaletteUse; Index 2210;	Information not available
// NtGdiGetTextCharsetInfo; Index 2211;	Information not available
// NtGdiGetTextExtent; Index 2212;	Information not available
// NtGdiGetTextExtentExW; Index 2213;	Information not available
// NtGdiGetTextFaceW; Index 2214;	Information not available
// NtGdiGetTextMetricsW; Index 2215;	Information not available
// NtGdiGetTransform; Index 2216;	Information not available
// NtGdiGetUFI; Index 2217;		Information not available
// NtGdiGetUFIPathname; Index 2218;	Information not available
// NtGdiGetWidthTable; Index 2219;	Information not available
// NtGdiGradientFill; Index 2220;	Information not available
// NtGdiHLSurfGetInformation; Index 2221;	Information not available
// NtGdiHLSurfSetInformation; Index 2222;	Information not available
// NtGdiHT_Get8BPPFormatPalette; Index 2223;	Information not available
// NtGdiHT_Get8BPPMaskPalette; Index 2224;	Information not available
// NtGdiHfontCreate; Index 2225;	Information not available
// NtGdiIcmBrushInfo; Index 2226;	Information not available
// NtGdiInit; Index 2227;		Information not available
// NtGdiInitSpool; Index 2228;		Information not available
// NtGdiIntersectClipRect; Index 2229;	Information not available
// NtGdiInvertRgn; Index 2230;		Information not available
// NtGdiLineTo; Index 2231;		Information not available
// NtGdiMakeFontDir; Index 2232;	Information not available
// NtGdiMakeInfoDC; Index 2233;		Information not available
// NtGdiMakeObjectUnXferable; Index 2234;	Information not available
// NtGdiMakeObjectXferable; Index 2235;	Information not available
// NtGdiMaskBlt; Index 2236;		Information not available
// NtGdiMirrorWindowOrg; Index 2237;	Information not available
// NtGdiModifyWorldTransform; Index 2238;	Information not available
// NtGdiMonoBitmap; Index 2239;		Information not available
// NtGdiMoveTo; Index 2240;		Information not available
// NtGdiOffsetClipRgn; Index 2241;	Information not available
// NtGdiOffsetRgn; Index 2242;		Information not available
// NtGdiOpenDCW; Index 2243;		Information not available
// NtGdiPATHOBJ_bEnum; Index 2244;	Information not available
// NtGdiPATHOBJ_bEnumClipLines; Index 2245;	Information not available
// NtGdiPATHOBJ_vEnumStart; Index 2246;	Information not available
// NtGdiPATHOBJ_vEnumStartClipLines; Index 2247;	Information not available
// NtGdiPATHOBJ_vGetBounds; Index 2248;	Information not available
// NtGdiPatBlt; Index 2249;		Information not available
// NtGdiPathToRegion; Index 2250;	Information not available
// NtGdiPlgBlt; Index 2251;		Information not available
// NtGdiPolyDraw; Index 2252;		Information not available
// NtGdiPolyPatBlt; Index 2253;		Information not available
// NtGdiPolyPolyDraw; Index 2254;	Information not available
// NtGdiPolyTextOutW; Index 2255;	Information not available
// NtGdiPtInRegion; Index 2256;		Information not available
// NtGdiPtVisible; Index 2257;		Information not available
// NtGdiQueryFontAssocInfo; Index 2258;	Information not available
// NtGdiQueryFonts; Index 2259;		Information not available
// NtGdiRectInRegion; Index 2260;	Information not available
// NtGdiRectVisible; Index 2261;	Information not available
// NtGdiRectangle; Index 2262;		Information not available
// NtGdiRemoveFontMemResourceEx; Index 2263;	Information not available
// NtGdiRemoveFontResourceW; Index 2264;	Information not available
// NtGdiRemoveMergeFont; Index 2265;	Information not available
// NtGdiResetDC; Index 2266;		Information not available
// NtGdiResizePalette; Index 2267;	Information not available
// NtGdiRestoreDC; Index 2268;		Information not available
// NtGdiRoundRect; Index 2269;		Information not available
// NtGdiSTROBJ_bEnum; Index 2270;	Information not available
// NtGdiSTROBJ_bEnumPositionsOnly; Index 2271;	Information not available
// NtGdiSTROBJ_bGetAdvanceWidths; Index 2272;	Information not available
// NtGdiSTROBJ_dwGetCodePage; Index 2273;	Information not available
// NtGdiSTROBJ_vEnumStart; Index 2274;	Information not available
// NtGdiSaveDC; Index 2275;		Information not available
// NtGdiScaleViewportExtEx; Index 2276;	Information not available
// NtGdiScaleWindowExtEx; Index 2277;	Information not available
// NtGdiSelectBitmap; Index 2278;	Information not available
// NtGdiSelectBrush; Index 2279;	Information not available
// NtGdiSelectClipPath; Index 2280;	Information not available
// NtGdiSelectFont; Index 2281;		Information not available
// NtGdiSelectPen; Index 2282;		Information not available
// NtGdiSetBitmapAttributes; Index 2283;	Information not available
// NtGdiSetBitmapBits; Index 2284;	Information not available
// NtGdiSetBitmapDimension; Index 2285;	Information not available
// NtGdiSetBoundsRect; Index 2286;	Information not available
// NtGdiSetBrushAttributes; Index 2287;	Information not available
// NtGdiSetBrushOrg; Index 2288;	Information not available
// NtGdiSetColorAdjustment; Index 2289;	Information not available
// NtGdiSetColorSpace; Index 2290;	Information not available
// NtGdiSetDIBitsToDeviceInternal; Index 2291;	Information not available
// NtGdiSetDeviceGammaRamp; Index 2292;	Information not available
// NtGdiSetFontEnumeration; Index 2293;	Information not available
// NtGdiSetFontXform; Index 2294;	Information not available
// NtGdiSetIcmMode; Index 2295;		Information not available
// NtGdiSetLayout; Index 2296;		Information not available
// NtGdiSetLinkedUFIs; Index 2297;	Information not available
// NtGdiSetMagicColors; Index 2298;	Information not available
// NtGdiSetMetaRgn; Index 2299;		Information not available
// NtGdiSetMiterLimit; Index 2300;	Information not available
// NtGdiSetOPMSigningKeyAndSequenceNumbers; Index 2301;	Information not available
// NtGdiSetPUMPDOBJ; Index 2302;	Information not available
// NtGdiSetPixel; Index 2303;		Information not available
// NtGdiSetPixelFormat; Index 2304;	Information not available
// NtGdiSetRectRgn; Index 2305;		Information not available
// NtGdiSetSizeDevice; Index 2306;	Information not available
// NtGdiSetSystemPaletteUse; Index 2307;	Information not available
// NtGdiSetTextJustification; Index 2308;	Information not available
// NtGdiSetUMPDSandboxState; Index 2309;	Information not available
// NtGdiSetVirtualResolution; Index 2310;	Information not available
// NtGdiStartDoc; Index 2311;		Information not available
// NtGdiStartPage; Index 2312;		Information not available
// NtGdiStretchBlt; Index 2313;		Information not available
// NtGdiStretchDIBitsInternal; Index 2314;	Information not available
// NtGdiStrokeAndFillPath; Index 2315;	Information not available
// NtGdiStrokePath; Index 2316;		Information not available
// NtGdiSwapBuffers; Index 2317;	Information not available
// NtGdiTransformPoints; Index 2318;	Information not available
// NtGdiTransparentBlt; Index 2319;	Information not available
// NtGdiUMPDEngFreeUserMem; Index 2320;	Information not available
// NtGdiUnloadPrinterDriver; Index 2321;	Information not available
// NtGdiUnmapMemFont; Index 2322;	Information not available
// NtGdiUnrealizeObject; Index 2323;	Information not available
// NtGdiUpdateColors; Index 2324;	Information not available
// NtGdiUpdateTransform; Index 2325;	Information not available
// NtGdiWidenPath; Index 2326;		Information not available
// NtGdiXFORMOBJ_bApplyXform; Index 2327;	Information not available
// NtGdiXFORMOBJ_iGetXform; Index 2328;	Information not available
// NtGdiXLATEOBJ_cGetPalette; Index 2329;	Information not available
// NtGdiXLATEOBJ_hGetColorTransform; Index 2330;	Information not available
// NtGdiXLATEOBJ_iXlate; Index 2331;	Information not available
// PATHOBJ_bEnum; Index 2336;		Information not available
// PATHOBJ_bEnumClipLines; Index 2337;	Information not available
// PATHOBJ_vEnumStart; Index 2338;	Information not available
// PATHOBJ_vEnumStartClipLines; Index 2339;	Information not available
// PATHOBJ_vGetBounds; Index 2340;	Information not available
// PieStub; Index 2345;			Information not available
// PolyBezierStub; Index 2352;		Information not available
// PolyBezierToImpl; Index 2354;	Information not available
// PolyDrawImpl; Index 2356;		Information not available
// PolyPatBlt; Index 2357;		Information not available
// PolyPolygonStub; Index 2359;		Information not available
// PolygonStub; Index 2364;		Information not available
// PolylineToImpl; Index 2367;		Information not available
// QueryFontAssocStatus; Index 2370;	Information not available
// RectangleImpl; Index 2375;		Information not available
// RemoveFontResourceAStub; Index 2378;	Information not available
// RemoveFontResourceTracking; Index 2381;	Information not available
// RemoveFontResourceWImpl; Index 2383;	Information not available
// ResetDCWImpl; Index 2386;		Information not available
// ResizePaletteStub; Index 2388;	Information not available
// RestoreDCImpl; Index 2390;		Information not available
// RoundRectStub; Index 2392;		Information not available
// STROBJ_bEnum; Index 2393;		Information not available
// STROBJ_bEnumPositionsOnly; Index 2394;	Information not available
// STROBJ_bGetAdvanceWidths; Index 2395;	Information not available
// STROBJ_dwGetCodePage; Index 2396;	Information not available
// STROBJ_vEnumStart; Index 2397;	Information not available
// SaveDCImpl; Index 2399;		Information not available
// ScriptApplyDigitSubstitution; Index 2402;	Information not available
// ScriptApplyLogicalWidth; Index 2403;	Information not available
// ScriptBreak; Index 2404;		Information not available
// ScriptCPtoX; Index 2405;		Information not available
// ScriptCacheGetHeight; Index 2406;	Information not available
// ScriptFreeCache; Index 2407;		Information not available
// ScriptGetCMap; Index 2408;		Information not available
// ScriptGetFontAlternateGlyphs; Index 2409;	Information not available
// ScriptGetFontFeatureTags; Index 2410;	Information not available
// ScriptGetFontLanguageTags; Index 2411;	Information not available
// ScriptGetFontProperties; Index 2412;	Information not available
// ScriptGetFontScriptTags; Index 2413;	Information not available
// ScriptGetGlyphABCWidth; Index 2414;	Information not available
// ScriptGetLogicalWidths; Index 2415;	Information not available
// ScriptGetProperties; Index 2416;	Information not available
// ScriptIsComplex; Index 2417;		Information not available
// ScriptItemize; Index 2418;		Information not available
// ScriptItemizeOpenType; Index 2419;	Information not available
// ScriptJustify; Index 2420;		Information not available
// ScriptLayout; Index 2421;		Information not available
// ScriptPlace; Index 2422;		Information not available
// ScriptPlaceOpenType; Index 2423;	Information not available
// ScriptPositionSingleGlyph; Index 2424;	Information not available
// ScriptRecordDigitSubstitution; Index 2425;	Information not available
// ScriptShape; Index 2426;		Information not available
// ScriptShapeOpenType; Index 2427;	Information not available
// ScriptStringAnalyse; Index 2428;	Information not available
// ScriptStringCPtoX; Index 2429;	Information not available
// ScriptStringFree; Index 2430;	Information not available
// ScriptStringGetLogicalWidths; Index 2431;	Information not available
// ScriptStringGetOrder; Index 2432;	Information not available
// ScriptStringOut; Index 2433;		Information not available
// ScriptStringValidate; Index 2434;	Information not available
// ScriptStringXtoCP; Index 2435;	Information not available
// ScriptString_pLogAttr; Index 2436;	Information not available
// ScriptString_pSize; Index 2437;	Information not available
// ScriptString_pcOutChars; Index 2438;	Information not available
// ScriptSubstituteSingleGlyph; Index 2439;	Information not available
// ScriptTextOut; Index 2440;		Information not available
// ScriptXtoCP; Index 2441;		Information not available
// SelectBrushLocal; Index 2442;	Information not available
// SelectClipPathImpl; Index 2444;	Information not available
// SelectClipRgnImpl; Index 2446;	Information not available
// SelectFontLocal; Index 2447;		Information not available
// SelectObjectImpl; Index 2449;	Information not available
// SetBitmapAttributes; Index 2453;	Information not available
// SetBitmapBitsStub; Index 2455;	Information not available
// SetBkModeImpl; Index 2459;		Information not available
// SetBrushAttributes; Index 2461;	Information not available
// SetFontEnumeration; Index 2472;	Information not available
// SetICMModeImpl; Index 2475;		Information not available
// SetLayout; Index 2478;		Information not available
// SetLayoutWidth; Index 2479;		Information not available
// SetMagicColors; Index 2480;		Information not available
// SetMiterLimitImpl; Index 2486;	Information not available
// SetOPMSigningKeyAndSequenceNumbers; Index 2487;	Information not available
// SetPaletteEntriesStub; Index 2489;	Information not available
// SetPolyFillModeImpl; Index 2494;	Information not available
// SetROP2Stub; Index 2496;		Information not available
// SetRelAbs; Index 2498;		Information not available
// SetStretchBltModeImpl; Index 2500;	Information not available
// SetTextAlignImpl; Index 2503;	Information not available
// SetTextColorImpl; Index 2506;	Information not available
// SetVirtualResolution; Index 2510;	Information not available
// SetWorldTransformImpl; Index 2515;	Information not available
// StartDocWImpl; Index 2518;		Information not available
// StartFormPage; Index 2519;		Information not available
// StartPageImpl; Index 2521;		Information not available
// StretchDIBitsImpl; Index 2524;	Information not available
// StrokePathImpl; Index 2527;		Information not available
// TextOutAStub; Index 2530;		Information not available
// UnloadNetworkFonts; Index 2533;	Information not available
// UnloadUserModePrinterDriver; Index 2534;	Information not available
// UnrealizeObjectStub; Index 2536;	Information not available
// UpdateColorsStub; Index 2538;	Information not available
// UspAllocCache; Index 2541;		Information not available
// UspAllocTemp; Index 2542;		Information not available
// UspFreeMem; Index 2543;		Information not available
// XFORMOBJ_bApplyXform; Index 2545;	Information not available
// XFORMOBJ_iGetXform; Index 2546;	Information not available
// XLATEOBJ_cGetPalette; Index 2547;	Information not available
// XLATEOBJ_hGetColorTransform; Index 2548;	Information not available
// XLATEOBJ_iXlate; Index 2549;		Information not available
// XLATEOBJ_piVector; Index 2550;	Information not available
// bCreateDCW; Index 2551;		Information not available
// bDeleteLDC; Index 2552;		Information not available
// bInitSystemAndFontsDirectoriesW; Index 2553;	Information not available
// bMakePathNameW; Index 2554;		Information not available
// cGetTTFFromFOT; Index 2555;		Information not available
// fpClosePrinter; Index 2556;		Information not available
// ftsWordBreak; Index 2557;		Information not available
// gMaxGdiHandleCount; Index 2558;	Information not available
// gW32PID; Index 2559;			Information not available
// gdiPlaySpoolStream; Index 2560;	Information not available
// ghICM; Index 2561;			Information not available
// hGetPEBHandle; Index 2562;		Information not available
// hdcCreateDCW; Index 2563;		Information not available
// pGdiDevCaps; Index 2564;		Information not available
// pGdiSharedHandleTable; Index 2565;	Information not available
// pGdiSharedMemory; Index 2566;	Information not available
// plinkGet; Index 2567;		Information not available
// semDxTrimNotification; Index 2568;	Information not available
// vDeleteLOCALFONT; Index 2569;	Information not available
// vFreeUFIHashTable; Index 2570;	Information not available
// vSetPldc; Index 2571;		Information not available

function AbortDoc(DC: THDC): Integer; stdcall; external cLibName name 'AbortDoc';
function AbortPath(DC: THDC): BOOL; stdcall; external cLibName name 'AbortPath';
function AddFontMemResourceEx(p1: Pointer; p2: DWORD; p3: PDesignVector; p4: LPDWORD): THandle; stdcall; external cLibName name 'AddFontMemResourceEx';
function AddFontResource(p1: PAnsiChar): Integer; stdcall; external cLibName name 'AddFontResourceA';
function AddFontResourceEx(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): Integer; stdcall; external cLibName name 'AddFontResourceExA';
function AddFontResourceExW(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): Integer; stdcall; external cLibName name 'AddFontResourceExW';
function AddFontResourceW(p1: PWideChar): Integer; stdcall; external cLibName name 'AddFontResourceW';
function AngleArc(DC: THDC; p2, p3: Integer; p4: DWORD; p5, p6: Single): BOOL; stdcall; external cLibName name 'AngleArc';
function AnimatePalette(p1: THPALETTE; p2, p3: UINT; p4: PPaletteEntry): BOOL; stdcall; external cLibName name 'AnimatePalette';
function Arc(hDC: THDC; left, top, right, bottom, startX, startY, endX, endY: Integer): BOOL; stdcall; external cLibName name 'Arc';
function ArcTo(DC: THDC; RLeft, RTop, RRight, RBottom: Integer; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'ArcTo';
function BeginPath(DC: THDC): BOOL; stdcall; external cLibName name 'BeginPath';
function BitBlt(DestDC: THDC; X, Y, Width, Height: Integer; SrcDC: THDC; XSrc, YSrc: Integer; Rop: DWORD): BOOL; stdcall; external cLibName name 'BitBlt';
function CancelDC(DC: THDC): BOOL; stdcall; external cLibName name 'CancelDC';
function CheckColorsInGamut(DC: THDC; var RGBQuads, Results; Count: DWORD): BOOL; stdcall; external cLibName name 'CheckColorsInGamut';
function ChoosePixelFormat(DC: THDC; p2: PPixelFormatDescriptor): Integer; stdcall; external cLibName name 'ChoosePixelFormat';
function Chord(DC: THDC; X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer): BOOL; stdcall; external cLibName name 'Chord';
function CloseEnhMetaFile(DC: THDC): THENHMETAFILE; stdcall; external cLibName name 'CloseEnhMetaFile';
function CloseFigure(DC: THDC): BOOL; stdcall; external cLibName name 'CloseFigure';
function CloseMetaFile(DC: THDC): THMETAFILE; stdcall; external cLibName name 'CloseMetaFile';
function ColorCorrectPalette(DC: THDC; p2: THPALETTE; p3, p4: DWORD): BOOL; stdcall; external cLibName name 'ColorCorrectPalette';
function ColorMatchToTarget(DC: THDC; Target: THDC; Action: DWORD): BOOL; stdcall; external cLibName name 'ColorMatchToTarget';
function CombineRgn(p1, p2, p3: THRGN; p4: Integer): Integer; stdcall; external cLibName name 'CombineRgn';
function CombineTransform(var p1: TXForm; const p2, p3: TXForm): BOOL; stdcall; external cLibName name 'CombineTransform';
function CopyEnhMetaFile(p1: THENHMETAFILE; p2: PAnsiChar): THENHMETAFILE; stdcall; external cLibName name 'CopyEnhMetaFileA';
function CopyEnhMetaFileW(p1: THENHMETAFILE; p2: PWideChar): THENHMETAFILE; stdcall; external cLibName name 'CopyEnhMetaFileW';
function CopyMetaFile(p1: THMETAFILE; p2: PAnsiChar): THMETAFILE; stdcall; external cLibName name 'CopyMetaFileA';
function CopyMetaFileW(p1: THMETAFILE; p2: PWideChar): THMETAFILE; stdcall; external cLibName name 'CopyMetaFileW';
function CreateBitmap(Width, Height: Integer; Planes, BitCount: Longint; Bits: Pointer): THBITMAP; stdcall; external cLibName name 'CreateBitmap';
function CreateBitmapIndirect(const p1: TBitmap): THBITMAP; stdcall; external cLibName name 'CreateBitmapIndirect';
function CreateBrushIndirect(const p1: TLogBrush): THBRUSH; stdcall; external cLibName name 'CreateBrushIndirect';
function CreateColorSpace(var ColorSpace: TLogColorSpaceA): THCOLORSPACE; stdcall; external cLibName name 'CreateColorSpaceA';
function CreateColorSpaceW(var ColorSpace: TLogColorSpaceW): THCOLORSPACE; stdcall; external cLibName name 'CreateColorSpaceW';
function CreateCompatibleBitmap(DC: THDC; Width, Height: Integer): THBITMAP; stdcall; external cLibName name 'CreateCompatibleBitmap';
function CreateCompatibleDC(DC: THDC): THDC; stdcall; external cLibName name 'CreateCompatibleDC';
function CreateDC(lpszDriver, lpszDevice, lpszOutput: PAnsiChar; lpdvmInit: PDeviceModeA): THDC; stdcall; external cLibName name 'CreateDCA';
function CreateDCW(lpszDriver, lpszDevice, lpszOutput: PWideChar; lpdvmInit: PDeviceModeW): THDC; stdcall; external cLibName name 'CreateDCW';
function CreateDIBPatternBrush(p1: HGLOBAL; p2: UINT): THBRUSH; stdcall; external cLibName name 'CreateDIBPatternBrush';
function CreateDIBPatternBrushPt(const p1: Pointer; p2: UINT): THBRUSH; stdcall; external cLibName name 'CreateDIBPatternBrushPt';
function CreateDIBSection(DC: THDC; const p2: TBitmapInfo; p3: UINT; var p4: Pointer; p5: THandle; p6: DWORD): THBITMAP; stdcall; external cLibName name 'CreateDIBSection';
function CreateDIBitmap(DC: THDC; var InfoHeader: TBitmapInfoHeader; dwUsage: DWORD; InitBits: PChar; var InitInfo: TBitmapInfo; wUsage: UINT): THBITMAP; stdcall; external cLibName name 'CreateDIBitmap';
function CreateDiscardableBitmap(DC: THDC; p2, p3: Integer): THBITMAP; stdcall; external cLibName name 'CreateDiscardableBitmap';
function CreateEllipticRgn(p1, p2, p3, p4: Integer): THRGN; stdcall; external cLibName name 'CreateEllipticRgn';
function CreateEllipticRgnIndirect(const p1: TRect): THRGN; stdcall; external cLibName name 'CreateEllipticRgnIndirect';
function CreateEnhMetaFile(DC: THDC; p2: PAnsiChar; p3: PRect; p4: PAnsiChar): THDC; stdcall; external cLibName name 'CreateEnhMetaFileA';
function CreateEnhMetaFileW(DC: THDC; p2: PWideChar; p3: PRect; p4: PWideChar): THDC; stdcall; external cLibName name 'CreateEnhMetaFileW';
function CreateFont(nHeight, nWidth, nEscapement, nOrientaion, fnWeight: Integer; fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision, fdwClipPrecision, fdwQuality, fdwPitchAndFamily: DWORD; lpszFace: PAnsiChar): THFONT; stdcall; external cLibName name 'CreateFontA';
function CreateFontIndirect(const p1: TLogFontA): THFONT; stdcall; external cLibName name 'CreateFontIndirectA';
function CreateFontIndirectEx(const p1: PEnumLogFontExDVA): THFONT; stdcall; external cLibName name 'CreateFontIndirectExA';
function CreateFontIndirectExW(const p1: PEnumLogFontExDVW): THFONT; stdcall; external cLibName name 'CreateFontIndirectExW';
function CreateFontIndirectW(const p1: TLogFontW): THFONT; stdcall; external cLibName name 'CreateFontIndirectW';
function CreateFontW(nHeight, nWidth, nEscapement, nOrientaion, fnWeight: Integer; fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision, fdwClipPrecision, fdwQuality, fdwPitchAndFamily: DWORD; lpszFace: PWideChar): THFONT; stdcall; external cLibName name 'CreateFontW';
function CreateHalftonePalette(DC: THDC): THPALETTE; stdcall; external cLibName name 'CreateHalftonePalette';
function CreateHatchBrush(p1: Integer; p2: COLORREF): THBRUSH; stdcall; external cLibName name 'CreateHatchBrush';
function CreateIC(lpszDriver, lpszDevice, lpszOutput: PAnsiChar; lpdvmInit: PDeviceModeA): THDC; stdcall; external cLibName name 'CreateICA';
function CreateICW(lpszDriver, lpszDevice, lpszOutput: PWideChar; lpdvmInit: PDeviceModeW): THDC; stdcall; external cLibName name 'CreateICW';
function CreateMetaFile(p1: PAnsiChar): THDC; stdcall; external cLibName name 'CreateMetaFileA';
function CreateMetaFileW(p1: PWideChar): THDC; stdcall; external cLibName name 'CreateMetaFileW';
function CreatePalette(const LogPalette: TLogPalette): THPALETTE; stdcall; external cLibName name 'CreatePalette';
function CreatePatternBrush(Bitmap: THBITMAP): THBRUSH; stdcall; external cLibName name 'CreatePatternBrush';
function CreatePen(Style, Width: Integer; Color: COLORREF): THPEN; stdcall; external cLibName name 'CreatePen';
function CreatePenIndirect(const LogPen: TLogPen): THPEN; stdcall; external cLibName name 'CreatePenIndirect';
function CreatePolyPolygonRgn(const pPtStructs; const pIntArray; p3, p4: Integer): THRGN; stdcall; external cLibName name 'CreatePolyPolygonRgn';
function CreatePolygonRgn(const Points; Count, FillMode: Integer): THRGN; stdcall; external cLibName name 'CreatePolygonRgn';
function CreateRectRgn(p1, p2, p3, p4: Integer): THRGN; stdcall; external cLibName name 'CreateRectRgn';
function CreateRectRgnIndirect(const p1: TRect): THRGN; stdcall; external cLibName name 'CreateRectRgnIndirect';
function CreateRoundRectRgn(p1, p2, p3, p4, p5, p6: Integer): THRGN; stdcall; external cLibName name 'CreateRoundRectRgn';
function CreateScalableFontResource(p1: DWORD; p2, p3, p4: PAnsiChar): BOOL; stdcall; external cLibName name 'CreateScalableFontResourceA';
function CreateScalableFontResourceW(p1: DWORD; p2, p3, p4: PWideChar): BOOL; stdcall; external cLibName name 'CreateScalableFontResourceW';
function CreateSolidBrush(p1: COLORREF): THBRUSH; stdcall; external cLibName name 'CreateSolidBrush';
function DPtoLP(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'DPtoLP';
function DeleteColorSpace(ColorSpace: THCOLORSPACE): BOOL; stdcall; external cLibName name 'DeleteColorSpace';
function DeleteDC(DC: THDC): BOOL; stdcall; external cLibName name 'DeleteDC';
function DeleteEnhMetaFile(p1: THENHMETAFILE): BOOL; stdcall; external cLibName name 'DeleteEnhMetaFile';
function DeleteMetaFile(p1: THMETAFILE): BOOL; stdcall; external cLibName name 'DeleteMetaFile';
function DeleteObject(p1: THGDIOBJ): BOOL; stdcall; external cLibName name 'DeleteObject';
function DescribePixelFormat(DC: THDC; p2: Integer; p3: UINT; var p4: TPixelFormatDescriptor): BOOL; stdcall; external cLibName name 'DescribePixelFormat';
function DrawEscape(DC: THDC; p2, p3: Integer; p4: LPCSTR): BOOL; stdcall; external cLibName name 'DrawEscape';
function Ellipse(DC: THDC; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'Ellipse';
function EndDoc(DC: THDC): Integer; stdcall; external cLibName name 'EndDoc';
function EndPage(DC: THDC): Integer; stdcall; external cLibName name 'EndPage';
function EndPath(DC: THDC): BOOL; stdcall; external cLibName name 'EndPath';
function EnumEnhMetaFile(DC: THDC; p2: THENHMETAFILE; p3: TEnhMetaFileProc; p4: Pointer; const p5: TRect): BOOL; stdcall; external cLibName name 'EnumEnhMetaFile';
function EnumFontFamilies(DC: THDC; p2: PAnsiChar; p3: TEnumFontsProcA; p4: TLPARAM): BOOL; stdcall; external cLibName name 'EnumFontFamiliesA';
function EnumFontFamiliesW(DC: THDC; p2: PWideChar; p3: TEnumFontsProcW; p4: TLPARAM): BOOL; stdcall; external cLibName name 'EnumFontFamiliesW';
function EnumFontFamiliesEx(DC: THDC; var p2: TLogFontA; p3: TEnumFontsProcA; p4: TLPARAM; p5: DWORD): BOOL; stdcall; external cLibName name 'EnumFontFamiliesExA';
function EnumFontFamiliesExW(DC: THDC; var p2: TLogFontW; p3: TEnumFontsProcW; p4: TLPARAM; p5: DWORD): BOOL; stdcall; external cLibName name 'EnumFontFamiliesExW';
function EnumFonts(DC: THDC; lpszFace: PAnsiChar; fntenmprc: TEnumFontsProcA; lpszData: PChar): Integer; stdcall; external cLibName name 'EnumFontsA';
function EnumFontsW(DC: THDC; lpszFace: PWideChar; fntenmprc: TEnumFontsProcW; lpszData: PChar): Integer; stdcall; external cLibName name 'EnumFontsW';
function EnumICMProfiles(DC: THDC; ICMProc: TICMEnumProcA; p3: TLPARAM): Integer; stdcall; external cLibName name 'EnumICMProfilesA';
function EnumICMProfilesW(DC: THDC; ICMProc: TICMEnumProcW; p3: TLPARAM): Integer; stdcall; external cLibName name 'EnumICMProfilesW';
function EnumMetaFile(DC: THDC; p2: THMETAFILE; p3: TEnumMetaFileProc; p4: TLPARAM): BOOL; stdcall; external cLibName name 'EnumMetaFile';
function EnumObjects(DC: THDC; p2: Integer; p3: TEnumObjectsProc; p4: TLPARAM): Integer; stdcall; external cLibName name 'EnumObjects';
function EqualRgn(p1, p2: THRGN): BOOL; stdcall; external cLibName name 'EqualRgn';
function Escape(DC: THDC; p2, p3: Integer; p4: LPCSTR; p5: Pointer): Integer; stdcall; external cLibName name 'Escape';
function ExcludeClipRect(DC: THDC; p2, p3, p4, p5: Integer): Integer; stdcall; external cLibName name 'ExcludeClipRect';
function ExtCreatePen(PenStyle, Width: DWORD; const Brush: TLogBrush; StyleCount: DWORD; Style: Pointer): THPEN; stdcall; external cLibName name 'ExtCreatePen';
function ExtCreateRegion(p1: PXForm; p2: DWORD; const p3: TRgnData): THRGN; stdcall; external cLibName name 'ExtCreateRegion';
function ExtEscape(DC: THDC; p2, p3: Integer; const p4: LPCSTR; p5: Integer; p6: LPSTR): Integer; stdcall; external cLibName name 'ExtEscape';
function ExtFloodFill(DC: THDC; X, Y: Integer; Color: COLORREF; FillType: UINT): BOOL; stdcall; external cLibName name 'ExtFloodFill';
function ExtSelectClipRgn(DC: THDC; p2: THRGN; p3: Integer): Integer; stdcall; external cLibName name 'ExtSelectClipRgn';
function ExtTextOut(DC: THDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PAnsiChar; Count: Longint; Dx: PInteger): BOOL; stdcall; external cLibName name 'ExtTextOutA';
function ExtTextOutW(DC: THDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PWideChar; Count: Longint; Dx: PInteger): BOOL; stdcall; external cLibName name 'ExtTextOutW';
function FillPath(DC: THDC): BOOL; stdcall; external cLibName name 'FillPath';
function FillRgn(DC: THDC; p2: THRGN; p3: THBRUSH): BOOL; stdcall; external cLibName name 'FillRgn';
function FlattenPath(DC: THDC): BOOL; stdcall; external cLibName name 'FlattenPath';
function FloodFill(DC: THDC; nXStart, nYStart: Integer; crFill: COLORREF): BOOL; stdcall; external cLibName name 'FloodFill';
function FrameRgn(DC: THDC; p2: THRGN; p3: THBRUSH; p4, p5: Integer): BOOL; stdcall; external cLibName name 'FrameRgn';
function GdiComment(DC: THDC; p2: UINT; p3: PChar): BOOL; stdcall; external cLibName name 'GdiComment';
function GdiFlush: BOOL; stdcall; external cLibName name 'GdiFlush';
function GdiGetBatchLimit: DWORD; stdcall; external cLibName name 'GdiGetBatchLimit';
function GdiSetBatchLimit(Limit: DWORD): DWORD; stdcall; external cLibName name 'GdiSetBatchLimit';
function GetArcDirection(DC: THDC): Integer; stdcall; external cLibName name 'GetArcDirection';
function GetAspectRatioFilterEx(DC: THDC; var p2: TSize): BOOL; stdcall; external cLibName name 'GetAspectRatioFilterEx';
function GetBitmapBits(Bitmap: THBITMAP; Count: Longint; Bits: Pointer): Longint; stdcall; external cLibName name 'GetBitmapBits';
function GetBitmapDimensionEx(p1: THBITMAP; var p2: TSize): BOOL; stdcall; external cLibName name 'GetBitmapDimensionEx';
function GetBkColor(hDC: THDC): COLORREF; stdcall; external cLibName name 'GetBkColor';
function GetBkMode(hDC: THDC): Integer; stdcall; external cLibName name 'GetBkMode';
function GetBoundsRect(DC: THDC; var p2: TRect; p3: UINT): UINT; stdcall; external cLibName name 'GetBoundsRect';
function GetBrushOrgEx(DC: THDC; var p2: TPoint): BOOL; stdcall; external cLibName name 'GetBrushOrgEx';
function GetCharABCWidths(DC: THDC; p2, p3: UINT; const ABCStructs): BOOL; stdcall; external cLibName name 'GetCharABCWidthsA';
function GetCharABCWidthsFloat(DC: THDC; p2, p3: UINT; const ABCFloatSturcts): BOOL; stdcall; external cLibName name 'GetCharABCWidthsFloatA';
function GetCharABCWidthsFloatW(DC: THDC; p2, p3: UINT; const ABCFloatSturcts): BOOL; stdcall; external cLibName name 'GetCharABCWidthsFloatW';
function GetCharABCWidthsI(DC: THDC; p2, p3: UINT; p4: PWORD; const Widths): BOOL; stdcall; external cLibName name 'GetCharABCWidthsI';
function GetCharABCWidthsW(DC: THDC; p2, p3: UINT; const ABCStructs): BOOL; stdcall; external cLibName name 'GetCharABCWidthsW';
function GetCharWidth32(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidth32A';
function GetCharWidth32W(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidth32W';
function GetCharWidth(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthA';
function GetCharWidthFloat(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthFloatA';
function GetCharWidthFloatW(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthFloatW';
function GetCharWidthI(DC: THDC; p2, p3: UINT; p4: PWORD; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthI';
function GetCharWidthW(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthW';
function GetCharacterPlacement(DC: THDC; p2: PAnsiChar; p3, p4: BOOL; var p5: TGCP_ResultsA; p6: DWORD): DWORD; stdcall; external cLibName name 'GetCharacterPlacementA';
function GetCharacterPlacementW(DC: THDC; p2: PWideChar; p3, p4: BOOL; var p5: TGCP_ResultsW; p6: DWORD): DWORD; stdcall; external cLibName name 'GetCharacterPlacementW';
function GetClipBox(DC: THDC; var Rect: TRect): Integer; stdcall; external cLibName name 'GetClipBox';
function GetClipRgn(DC: THDC; rgn: THRGN): Integer; stdcall; external cLibName name 'GetClipRgn';
function GetColorAdjustment(DC: THDC; var p2: TColorAdjustment): BOOL; stdcall; external cLibName name 'GetColorAdjustment';
function GetColorSpace(DC: THDC): THandle; stdcall; external cLibName name 'GetColorSpace';
function GetCurrentObject(DC: THDC; p2: UINT): THGDIOBJ; stdcall; external cLibName name 'GetCurrentObject';
function GetCurrentPositionEx(DC: THDC; Point: PPoint): BOOL; stdcall; external cLibName name 'GetCurrentPositionEx';
function GetDCBrushColor(DC: THDC): COLORREF; stdcall; external cLibName name 'GetDCBrushColor';
function GetDCOrgEx(DC: THDC; var Origin: TPoint): BOOL; stdcall; external cLibName name 'GetDCOrgEx';
function GetDCPenColor(DC: THDC): COLORREF; stdcall; external cLibName name 'GetDCPenColor';
function GetDIBColorTable(DC: THDC; p2, p3: UINT; var RGBQuadStructs): UINT; stdcall; external cLibName name 'GetDIBColorTable';
function GetDIBits(DC: THDC; Bitmap: THBITMAP; StartScan, NumScans: UINT; Bits: Pointer; var BitInfo: TBitmapInfo; Usage: UINT): Integer; stdcall; external cLibName name 'GetDIBits';
function GetDeviceCaps(DC: THDC; Index: Integer): Integer; stdcall; external cLibName name 'GetDeviceCaps';
function GetDeviceGammaRamp(DC: THDC; var Ramp): BOOL; stdcall; external cLibName name 'GetDeviceGammaRamp';
function GetEnhMetaFile(p1: PAnsiChar): THENHMETAFILE; stdcall; external cLibName name 'GetEnhMetaFileA';
function GetEnhMetaFileBits(p1: THENHMETAFILE; p2: UINT; p3: PByte): UINT; stdcall; external cLibName name 'GetEnhMetaFileBits';
function GetEnhMetaFileDescription(p1: THENHMETAFILE; p2: UINT; p3: PAnsiChar): UINT; stdcall; external cLibName name 'GetEnhMetaFileDescriptionA';
function GetEnhMetaFileDescriptionW(p1: THENHMETAFILE; p2: UINT; p3: PWideChar): UINT; stdcall; external cLibName name 'GetEnhMetaFileDescriptionW';
function GetEnhMetaFileHeader(p1: THENHMETAFILE; p2: UINT; p3: PEnhMetaHeader): UINT; stdcall; external cLibName name 'GetEnhMetaFileHeader';
function GetEnhMetaFilePaletteEntries(p1: THENHMETAFILE; p2: UINT; p3: Pointer): UINT; stdcall; external cLibName name 'GetEnhMetaFilePaletteEntries';
function GetEnhMetaFilePixelFormat(p1: THENHMETAFILE; p2: Cardinal; var p3: TPixelFormatDescriptor): UINT; stdcall; external cLibName name 'GetEnhMetaFilePixelFormat';
function GetEnhMetaFileW(p1: PWideChar): THENHMETAFILE; stdcall; external cLibName name 'GetEnhMetaFileW';
function GetFontData(DC: THDC; p2, p3: DWORD; p4: Pointer; p5: DWORD): DWORD; stdcall; external cLibName name 'GetFontData';
function GetFontLanguageInfo(DC: THDC): DWORD; stdcall; external cLibName name 'GetFontLanguageInfo';
function GetFontUnicodeRanges(DC: THDC; lpgs: PGlyphSet): DWORD; stdcall; external cLibName name 'GetFontUnicodeRanges';
function GetGlyphIndices(DC: THDC; p2: PAnsiChar; p3: Integer; p4: PWORD; p5: DWORD): DWORD; stdcall; external cLibName name 'GetGlyphIndicesA';
function GetGlyphIndicesW(DC: THDC; p2: PAnsiChar; p3: Integer; p4: PWORD; p5: DWORD): DWORD; stdcall; external cLibName name 'GetGlyphIndicesW';
function GetGlyphOutline(DC: THDC; p2, p3: UINT; const p4: TGlyphMetrics; p5: DWORD; p6: Pointer; const p7: TMat2): DWORD; stdcall; external cLibName name 'GetGlyphOutlineA';
function GetGlyphOutlineW(DC: THDC; p2, p3: UINT; const p4: TGlyphMetrics; p5: DWORD; p6: Pointer; const p7: TMat2): DWORD; stdcall; external cLibName name 'GetGlyphOutlineW';
function GetGraphicsMode(DC: THDC): Integer; stdcall; external cLibName name 'GetGraphicsMode';
function GetICMProfile(DC: THDC; var Size: DWORD; Name: PAnsiChar): BOOL; stdcall; external cLibName name 'GetICMProfileA';
function GetICMProfileW(DC: THDC; var Size: DWORD; Name: PWideChar): BOOL; stdcall; external cLibName name 'GetICMProfileW';
function GetKerningPairs(DC: THDC; Count: DWORD; var KerningPairs): DWORD; stdcall; external cLibName name 'GetKerningPairs';
function GetLogColorSpace(p1: THCOLORSPACE; var ColorSpace: TLogColorSpaceA; Size: DWORD): BOOL; stdcall; external cLibName name 'GetLogColorSpaceA';
function GetLogColorSpaceW(p1: THCOLORSPACE; var ColorSpace: TLogColorSpaceW; Size: DWORD): BOOL; stdcall; external cLibName name 'GetLogColorSpaceW';
function GetMapMode(DC: THDC): Integer; stdcall; external cLibName name 'GetMapMode';
function GetMetaFile(p1: PAnsiChar): THMETAFILE; stdcall; external cLibName name 'GetMetaFileA';
function GetMetaFileBitsEx(p1: THMETAFILE; p2: UINT; p3: Pointer): UINT; stdcall; external cLibName name 'GetMetaFileBitsEx';
function GetMetaFileW(p1: PWideChar): THMETAFILE; stdcall; external cLibName name 'GetMetaFileW';
function GetMetaRgn(DC: THDC; rgn: THRGN): Integer; stdcall; external cLibName name 'GetMetaRgn';
function GetMiterLimit(DC: THDC; var Limit: Single): BOOL; stdcall; external cLibName name 'GetMiterLimit';
function GetNearestColor(DC: THDC; p2: COLORREF): COLORREF; stdcall; external cLibName name 'GetNearestColor';
function GetNearestPaletteIndex(p1: THPALETTE; p2: COLORREF): UINT; stdcall; external cLibName name 'GetNearestPaletteIndex';
function GetObject(p1: THGDIOBJ; p2: Integer; p3: Pointer): Integer; stdcall; external cLibName name 'GetObjectA';
function GetObjectType(h: THGDIOBJ): DWORD; stdcall; external cLibName name 'GetObjectType';
function GetObjectW(p1: THGDIOBJ; p2: Integer; p3: Pointer): Integer; stdcall; external cLibName name 'GetObjectW';
function GetOutlineTextMetrics(DC: THDC; p2: UINT; OTMetricStructs: Pointer): UINT; stdcall; external cLibName name 'GetOutlineTextMetricsA';
function GetOutlineTextMetricsW(DC: THDC; p2: UINT; OTMetricStructs: Pointer): UINT; stdcall; external cLibName name 'GetOutlineTextMetricsW';
function GetPaletteEntries(Palette: THPALETTE; StartIndex, NumEntries: UINT; var PaletteEntries): UINT; stdcall; external cLibName name 'GetPaletteEntries';
function GetPath(DC: THDC; var Points, Types; nSize: Integer): Integer; stdcall; external cLibName name 'GetPath';
function GetPixel(DC: THDC; X, Y: Integer): COLORREF; stdcall; external cLibName name 'GetPixel';
function GetPixelFormat(DC: THDC): Integer; stdcall; external cLibName name 'GetPixelFormat';
function GetPolyFillMode(DC: THDC): Integer; stdcall; external cLibName name 'GetPolyFillMode';
function GetROP2(DC: THDC): Integer; stdcall; external cLibName name 'GetROP2';
function GetRasterizerCaps(var p1: TRasterizerStatus; p2: UINT): BOOL; stdcall; external cLibName name 'GetRasterizerCaps';
function GetRegionData(RGN: THRGN; p2: DWORD; p3: PRgnData): DWORD; stdcall; external cLibName name 'GetRegionData';
function GetRgnBox(RGN: THRGN; var p2: TRect): Integer; stdcall; external cLibName name 'GetRgnBox';
function GetStockObject(Index: Integer): THGDIOBJ; stdcall; external cLibName name 'GetStockObject';
function GetStretchBltMode(DC: THDC): Integer; stdcall; external cLibName name 'GetStretchBltMode';
function GetSystemPaletteEntries(DC: THDC; StartIndex, NumEntries: UINT; var PaletteEntries): UINT; stdcall; external cLibName name 'GetSystemPaletteEntries';
function GetSystemPaletteUse(DC: THDC): UINT; stdcall; external cLibName name 'GetSystemPaletteUse';
function GetTextAlign(DC: THDC): UINT; stdcall; external cLibName name 'GetTextAlign';
function GetTextCharacterExtra(DC: THDC): Integer; stdcall; external cLibName name 'GetTextCharacterExtra';
function GetTextCharset(hdc: THDC): Integer; stdcall; external cLibName name 'GetTextCharset';
function GetTextCharsetInfo(hdc: THDC; lpSig: PFontSignature; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'GetTextCharsetInfo';
function GetTextColor(DC: THDC): COLORREF; stdcall; external cLibName name 'GetTextColor';
function GetTextExtentExPoint(DC: THDC; p2: PAnsiChar; p3, p4: Integer; p5, p6: PInteger; var p7: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentExPointA';
function GetTextExtentExPointI(DC: THDC; p2: PWORD; p3, p4: Integer; p5, p6: PINT; var p7: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentExPointI';
function GetTextExtentExPointW(DC: THDC; p2: PWideChar; p3, p4: Integer; p5, p6: PInteger; var p7: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentExPointW';
function GetTextExtentPoint32(DC: THDC; Str: PAnsiChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPoint32A';
function GetTextExtentPoint32W(DC: THDC; Str: PWideChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPoint32W';
function GetTextExtentPoint(DC: THDC; Str: PAnsiChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPointA';
function GetTextExtentPointI(DC: THDC; p2: PWORD; p3: Integer; var p4: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPointI';
function GetTextExtentPointW(DC: THDC; Str: PWideChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPointW';
function GetTextFace(DC: THDC; Count: Integer; Buffer: PAnsiChar): Integer; stdcall; external cLibName name 'GetTextFaceA';
function GetTextFaceW(DC: THDC; Count: Integer; Buffer: PWideChar): Integer; stdcall; external cLibName name 'GetTextFaceW';
function GetTextMetrics(DC: THDC; var TM: TTextMetricA): BOOL; stdcall; external cLibName name 'GetTextMetricsA';
function GetTextMetricsW(DC: THDC; var TM: TTextMetricW): BOOL; stdcall; external cLibName name 'GetTextMetricsW';
function GetViewportExtEx(DC: THDC; var Size: TSize): BOOL; stdcall; external cLibName name 'GetViewportExtEx';
function GetViewportOrgEx(DC: THDC; var Point: TPoint): BOOL; stdcall; external cLibName name 'GetViewportOrgEx';
function GetWinMetaFileBits(p1: THENHMETAFILE; p2: UINT; p3: PByte; p4: Integer; p5: THDC): UINT; stdcall; external cLibName name 'GetWinMetaFileBits';
function GetWindowExtEx(DC: THDC; var Size: TSize): BOOL; stdcall; external cLibName name 'GetWindowExtEx';
function GetWindowOrgEx(DC: THDC; var Point: TPoint): BOOL; stdcall; external cLibName name 'GetWindowOrgEx';
function GetWorldTransform(DC: THDC; var p2: TXForm): BOOL; stdcall; external cLibName name 'GetWorldTransform';
function IntersectClipRect(DC: THDC; X1, Y1, X2, Y2: Integer): Integer; stdcall; external cLibName name 'IntersectClipRect';
function InvertRgn(DC: THDC; p2: THRGN): BOOL; stdcall; external cLibName name 'InvertRgn';
function LPtoDP(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'LPtoDP';
function LineDDA(p1, p2, p3, p4: Integer; p5: TLineDDAProc; p6: TLPARAM): BOOL; stdcall; external cLibName name 'LineDDA';
function LineTo(DC: THDC; X, Y: Integer): BOOL; stdcall; external cLibName name 'LineTo';
function MaskBlt(DC: THDC; p2, p3, p4, p5: Integer; p6: THDC; p7, p8: Integer; p9: THBITMAP; p10, p11: Integer; p12: DWORD): BOOL; stdcall; external cLibName name 'MaskBlt';
function ModifyWorldTransform(DC: THDC; const p2: TXForm; p3: DWORD): BOOL; stdcall; external cLibName name 'ModifyWorldTransform';
function MoveToEx(DC: THDC; p2, p3: Integer; p4: PPoint): BOOL; stdcall; external cLibName name 'MoveToEx';
function OffsetClipRgn(DC: THDC; p2, p3: Integer): Integer; stdcall; external cLibName name 'OffsetClipRgn';
function OffsetRgn(RGN: THRGN; p2, p3: Integer): Integer; stdcall; external cLibName name 'OffsetRgn';
function OffsetViewportOrgEx(DC: THDC; X, Y: Integer; var Points): BOOL; stdcall; external cLibName name 'OffsetViewportOrgEx';
function OffsetWindowOrgEx(DC: THDC; X, Y: Integer; var Points): BOOL; stdcall; external cLibName name 'OffsetWindowOrgEx';
function PaintRgn(DC: THDC; RGN: THRGN): BOOL; stdcall; external cLibName name 'PaintRgn';
function PatBlt(DC: THDC; X, Y, Width, Height: Integer; Rop: DWORD): BOOL; stdcall; external cLibName name 'PatBlt';
function PathToRegion(DC: THDC): THRGN; stdcall; external cLibName name 'PathToRegion';
function Pie(DC: THDC; X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer): BOOL; stdcall; external cLibName name 'Pie';
function PlayEnhMetaFile(DC: THDC; p2: THENHMETAFILE; const p3: TRect): BOOL; stdcall; external cLibName name 'PlayEnhMetaFile';
function PlayEnhMetaFileRecord(DC: THDC; var p2: THandleTable; const p3: TEnhMetaRecord; p4: UINT): BOOL; stdcall; external cLibName name 'PlayEnhMetaFileRecord';
function PlayMetaFile(DC: THDC; MF: THMETAFILE): BOOL; stdcall; external cLibName name 'PlayMetaFile';
function PlayMetaFileRecord(DC: THDC; const p2: THandleTable; const p3: TMetaRecord; p4: UINT): BOOL; stdcall; external cLibName name 'PlayMetaFileRecord';
function PlgBlt(DC: THDC; const PointsArray; p3: THDC; p4, p5, p6, p7: Integer; p8: THBITMAP; p9, p10: Integer): BOOL; stdcall; external cLibName name 'PlgBlt';
function PolyBezier(DC: THDC; const Points; Count: DWORD): BOOL; stdcall; external cLibName name 'PolyBezier';
function PolyBezierTo(DC: THDC; const Points; Count: DWORD): BOOL; stdcall; external cLibName name 'PolyBezierTo';
function PolyDraw(DC: THDC; const Points, Types; cCount: Integer): BOOL; stdcall; external cLibName name 'PolyDraw';
function PolyPolygon(DC: THDC; var Points; var nPoints; p4: Integer): BOOL; stdcall; external cLibName name 'PolyPolygon';
function PolyPolyline(DC: THDC; const PointStructs; const Points; p4: DWORD): BOOL; stdcall; external cLibName name 'PolyPolyline';
function PolyTextOut(DC: THDC; const PolyTextArray: PPolyTextA; Strings: Integer): BOOL; stdcall; external cLibName name 'PolyTextOutA';
function PolyTextOutW(DC: THDC; const PolyTextArray: PPolyTextW; Strings: Integer): BOOL; stdcall; external cLibName name 'PolyTextOutW';
function Polygon(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'Polygon';
function Polyline(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'Polyline';
function PolylineTo(DC: THDC; const Points; Count: DWORD): BOOL; stdcall; external cLibName name 'PolylineTo';
function PtInRegion(RGN: THRGN; p2, p3: Integer): BOOL; stdcall; external cLibName name 'PtInRegion';
function PtVisible(DC: THDC; p2, p3: Integer): BOOL; stdcall; external cLibName name 'PtVisible';
function RealizePalette(DC: THDC): UINT; stdcall; external cLibName name 'RealizePalette';
function RectInRegion(RGN: THRGN; const p2: TRect): BOOL; stdcall; external cLibName name 'RectInRegion';
function RectVisible(DC: THDC; const Rect: TRect): BOOL; stdcall; external cLibName name 'RectVisible';
function Rectangle(DC: THDC; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'Rectangle';
function RemoveFontMemResourceEx(p1: THandle): BOOL; stdcall; external cLibName name 'RemoveFontMemResourceEx';
function RemoveFontResource(p1: PAnsiChar): BOOL; stdcall; external cLibName name 'RemoveFontResourceA';
function RemoveFontResourceEx(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): BOOL; stdcall; external cLibName name 'RemoveFontResourceExA';
function RemoveFontResourceExW(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): BOOL; stdcall; external cLibName name 'RemoveFontResourceExW';
function RemoveFontResourceW(p1: PWideChar): BOOL; stdcall; external cLibName name 'RemoveFontResourceW';
function ResetDC(DC: THDC; const p2: TDeviceModeA): THDC; stdcall; external cLibName name 'ResetDCA';
function ResetDCW(DC: THDC; const p2: TDeviceModeW): THDC; stdcall; external cLibName name 'ResetDCW';
function ResizePalette(p1: THPALETTE; p2: UINT): BOOL; stdcall; external cLibName name 'ResizePalette';
function RestoreDC(DC: THDC; SavedDC: Integer): BOOL; stdcall; external cLibName name 'RestoreDC';
function RoundRect(DC: THDC; X1, Y1, X2, Y2, X3, Y3: Integer): BOOL; stdcall; external cLibName name 'RoundRect';
function SaveDC(DC: THDC): Integer; stdcall; external cLibName name 'SaveDC';
function ScaleViewportExtEx(DC: THDC; XM, XD, YM, YD: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'ScaleViewportExtEx';
function ScaleWindowExtEx(DC: THDC; XM, XD, YM, YD: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'ScaleWindowExtEx';
function SelectClipPath(DC: THDC; Mode: Integer): BOOL; stdcall; external cLibName name 'SelectClipPath';
function SelectClipRgn(DC: THDC; p2: THRGN): Integer; stdcall; external cLibName name 'SelectClipRgn';
function SelectObject(DC: THDC; p2: THGDIOBJ): THGDIOBJ; stdcall; external cLibName name 'SelectObject';
function SelectPalette(DC: THDC; Palette: THPALETTE; ForceBackground: Bool): THPALETTE; stdcall; external cLibName name 'SelectPalette';
function SetAbortProc(DC: THDC; lpAbortProc: TAbortProc): Integer; stdcall; external cLibName name 'SetAbortProc';
function SetArcDirection(DC: THDC; Direction: Integer): Integer; stdcall; external cLibName name 'SetArcDirection';
function SetBitmapBits(p1: THBITMAP; p2: DWORD; bits: Pointer): Longint; stdcall; external cLibName name 'SetBitmapBits';
function SetBitmapDimensionEx(hBitmap: THBITMAP; Width, Height: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'SetBitmapDimensionEx';
function SetBkColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetBkColor';
function SetBkMode(DC: THDC; BkMode: Integer): Integer; stdcall; external cLibName name 'SetBkMode';
function SetBoundsRect(DC: THDC; p2: PRect; p3: UINT): UINT; stdcall; external cLibName name 'SetBoundsRect';
function SetBrushOrgEx(DC: THDC; X, Y: Integer; PrevPt: PPoint): BOOL; stdcall; external cLibName name 'SetBrushOrgEx';
function SetColorAdjustment(DC: THDC; const p2: TColorAdjustment): BOOL; stdcall; external cLibName name 'SetColorAdjustment';
function SetColorSpace(DC: THDC; ColorSpace: THCOLORSPACE): BOOL; stdcall; external cLibName name 'SetColorSpace';
function SetDCBrushColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetDCBrushColor';
function SetDCPenColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetDCPenColor';
function SetDIBColorTable(DC: THDC; p2, p3: UINT; var RGBQuadSTructs): UINT; stdcall; external cLibName name 'SetDIBColorTable';
function SetDIBits(DC: THDC; Bitmap: THBITMAP; StartScan, NumScans: UINT; Bits: Pointer; var BitsInfo: TBitmapInfo; Usage: UINT): Integer; stdcall; external cLibName name 'SetDIBits';
function SetDIBitsToDevice(DC: THDC; DestX, DestY: Integer; Width, Height: DWORD; SrcX, SrcY: Integer; nStartScan, NumScans: UINT; Bits: Pointer; var BitsInfo: TBitmapInfo; Usage: UINT): Integer; stdcall; external cLibName name 'SetDIBitsToDevice';
function SetDeviceGammaRamp(DC: THDC; var Ramp): BOOL; stdcall; external cLibName name 'SetDeviceGammaRamp';
function SetEnhMetaFileBits(p1: UINT; p2: PChar): THENHMETAFILE; stdcall; external cLibName name 'SetEnhMetaFileBits';
function SetGraphicsMode(hdc: THDC; iMode: Integer): Integer; stdcall; external cLibName name 'SetGraphicsMode';
function SetICMMode(DC: THDC; Mode: Integer): Integer; stdcall; external cLibName name 'SetICMMode';
function SetICMProfile(DC: THDC; Name: PAnsiChar): BOOL; stdcall; external cLibName name 'SetICMProfileA';
function SetICMProfileW(DC: THDC; Name: PWideChar): BOOL; stdcall; external cLibName name 'SetICMProfileW';
function SetMapMode(DC: THDC; p2: Integer): Integer; stdcall; external cLibName name 'SetMapMode';
function SetMapperFlags(DC: THDC; Flag: DWORD): DWORD; stdcall; external cLibName name 'SetMapperFlags';
function SetMetaFileBitsEx(p1: UINT; const p2: PChar): THMETAFILE; stdcall; external cLibName name 'SetMetaFileBitsEx';
function SetMetaRgn(DC: THDC): Integer; stdcall; external cLibName name 'SetMetaRgn';
function SetMiterLimit(DC: THDC; NewLimit: Single; OldLimit: PSingle): BOOL; stdcall; external cLibName name 'SetMiterLimit';
function SetPaletteEntries(Palette: THPALETTE; StartIndex, NumEntries: UINT; var PaletteEntries): UINT; stdcall; external cLibName name 'SetPaletteEntries';
function SetPixel(DC: THDC; X, Y: Integer; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetPixel';
function SetPixelFormat(DC: THDC; p2: Integer; p3: PPixelFormatDescriptor): BOOL; stdcall; external cLibName name 'SetPixelFormat';
function SetPixelV(DC: THDC; X, Y: Integer; Color: COLORREF): BOOL; stdcall; external cLibName name 'SetPixelV';
function SetPolyFillMode(DC: THDC; PolyFillMode: Integer): Integer; stdcall; external cLibName name 'SetPolyFillMode';
function SetROP2(DC: THDC; p2: Integer): Integer; stdcall; external cLibName name 'SetROP2';
function SetRectRgn(Rgn: THRGN; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'SetRectRgn';
function SetStretchBltMode(DC: THDC; p2: Integer): Integer; stdcall; external cLibName name 'SetStretchBltMode';
function SetSystemPaletteUse(DC: THDC; p2: UINT): UINT; stdcall; external cLibName name 'SetSystemPaletteUse';
function SetTextAlign(DC: THDC; Flags: UINT): UINT; stdcall; external cLibName name 'SetTextAlign';
function SetTextCharacterExtra(DC: THDC; CharExtra: Integer): Integer; stdcall; external cLibName name 'SetTextCharacterExtra';
function SetTextColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetTextColor';
function SetTextJustification(DC: THDC; BreakExtra, BreakCount: Integer): Integer; stdcall; external cLibName name 'SetTextJustification';
function SetViewportExtEx(DC: THDC; XExt, YExt: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'SetViewportExtEx';
function SetViewportOrgEx(DC: THDC; X, Y: Integer; Point: PPoint): BOOL; stdcall; external cLibName name 'SetViewportOrgEx';
function SetWinMetaFileBits(p1: UINT; p2: PChar; p3: THDC; const p4: TMetaFilePict): THENHMETAFILE; stdcall; external cLibName name 'SetWinMetaFileBits';
function SetWindowExtEx(DC: THDC; XExt, YExt: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'SetWindowExtEx';
function SetWindowOrgEx(DC: THDC; X, Y: Integer; Point: PPoint): BOOL; stdcall; external cLibName name 'SetWindowOrgEx';
function SetWorldTransform(DC: THDC; const p2: TXForm): BOOL; stdcall; external cLibName name 'SetWorldTransform';
function StartDoc(DC: THDC; const p2: TDocInfoA): Integer; stdcall; external cLibName name 'StartDocA';
function StartDocW(DC: THDC; const p2: TDocInfoW): Integer; stdcall; external cLibName name 'StartDocW';
function StartPage(DC: THDC): Integer; stdcall; external cLibName name 'StartPage';
function StretchBlt(DestDC: THDC; X, Y, Width, Height: Integer; SrcDC: THDC; XSrc, YSrc, SrcWidth, SrcHeight: Integer; Rop: DWORD): BOOL; stdcall; external cLibName name 'StretchBlt';
function StretchDIBits(DC: THDC; DestX, DestY, DestWidth, DestHegiht, SrcX, SrcY, SrcWidth, SrcHeight: Integer; Bits: Pointer; var BitsInfo: TBitmapInfo; Usage: UINT; Rop: DWORD): Integer; stdcall; external cLibName name 'StretchDIBits';
function StrokeAndFillPath(DC: THDC): BOOL; stdcall; external cLibName name 'StrokeAndFillPath';
function StrokePath(DC: THDC): BOOL; stdcall; external cLibName name 'StrokePath';
function SwapBuffers(DC: THDC): BOOL; stdcall; external cLibName name 'SwapBuffers';
function TextOut(DC: THDC; X, Y: Integer; Str: PAnsiChar; Count: Integer): BOOL; stdcall; external cLibName name 'TextOutA';
function TextOutW(DC: THDC; X, Y: Integer; Str: PWideChar; Count: Integer): BOOL; stdcall; external cLibName name 'TextOutW';
function TranslateCharsetInfo(var lpSrc: DWORD; var lpCs: TCharsetInfo; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'TranslateCharsetInfo';
function UnrealizeObject(hGDIObj: THGDIOBJ): BOOL; stdcall; external cLibName name 'UnrealizeObject';
function UpdateColors(DC: THDC): BOOL; stdcall; external cLibName name 'UpdateColors';
function UpdateICMRegKey(p1: DWORD; p2, p3: PAnsiChar; p4: UINT): BOOL; stdcall; external cLibName name 'UpdateICMRegKeyA';
function UpdateICMRegKeyW(p1: DWORD; p2, p3: PWideChar; p4: UINT): BOOL; stdcall; external cLibName name 'UpdateICMRegKeyW';
function WidenPath(DC: THDC): BOOL; stdcall; external cLibName name 'WidenPath';

{$endif}
implementation

end.
