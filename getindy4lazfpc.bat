@ECHO off
set DESTDIR="%homedrive%%homepath%\Indy"
if "%~1"=="" goto DEFAULTDEST
set DESTDIR="%~1"
:DEFAULTDEST

set SRCROOT="%~dp0"
echo Processing %SRCROOT%
echo Output to %DESTDIR%


mkdir %DESTDIR%\design
mkdir %DESTDIR%\runtime\core 
mkdir %DESTDIR%\runtime\protocols 
mkdir %DESTDIR%\runtime\system
mkdir %DESTDIR%\runtime\protocols\opensslHdrs
mkdir %DESTDIR%\includes


copy %SRCROOT%\README.md %DESTDIR%
copy %SRCROOT%\README.OpenSSL.txt %DESTDIR%
copy %SRCROOT%\Lib\fpcnotes\COPYING %DESTDIR%
copy %SRCROOT%\Lib\fpcnotes\COPYING.modifiedBSD %DESTDIR%
copy %SRCROOT%\Lib\fpcnotes\COPYING.MPL %DESTDIR%

#Copy fpc specific files
copy %SRCROOT%\fpc\indylaz.pas %DESTDIR%
copy %SRCROOT%\fpc\indylaz.lpk %DESTDIR%
copy %SRCROOT%\fpc\indycore.pas %DESTDIR%
copy %SRCROOT%\fpc\indycore.lpk %DESTDIR%
copy %SRCROOT%\fpc\indysystem.pas %DESTDIR%
copy %SRCROOT%\fpc\indysystem.lpk %DESTDIR%
copy %SRCROOT%\fpc\indyprotocols.pas %DESTDIR%
copy %SRCROOT%\fpc\indyprotocols.lpk %DESTDIR%
copy %SRCROOT%\fpc\Makefile.fpc %DESTDIR%
copy %SRCROOT%\fpc\README.lazarus-fpc %DESTDIR%
copy %SRCROOT%\fpc\runtime\core\* %DESTDIR%\runtime\core
copy %SRCROOT%\fpc\runtime\system\* %DESTDIR%\runtime\system
copy %SRCROOT%\fpc\runtime\protocols\* %DESTDIR%\runtime\protocols

#Copy Lazarus Design time files
copy %SRCROOT%\Lib\System\IdCompilerDefines.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdAboutVCL.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Core\IdAboutVCL.lrs %DESTDIR%\design
copy %SRCROOT%\Lib\Core\IdAntiFreeze.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Core\IdCoreDsnRegister.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Core\IdDsnCoreResourceStrings.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Core\IdDsnPropEdBindingVCL.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Core\IdRegisterCore.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Core\IdRegisterCore.lrs %DESTDIR%\design
copy %SRCROOT%\Lib\Protocols\IdDsnRegister.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Protocols\IdDsnResourceStrings.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Protocols\IdDsnSASLListEditorFormVCL.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Protocols\IdDsnSASLListEditorFormVCL.lrs %DESTDIR%\design
copy %SRCROOT%\Lib\Protocols\IdRegister.pas %DESTDIR%\design
copy %SRCROOT%\Lib\Protocols\IdRegister.lrs %DESTDIR%\design


#Copy fpc Runtime files

copy %SRCROOT%\Lib\Core\IdAssignedNumbers.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdBuffer.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdCmdTCPClient.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdCmdTCPServer.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdCommandHandlers.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdContext.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdCustomTCPServer.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdCustomTransparentProxy.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdExceptionCore.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdGlobalCore.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIOHandler.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIOHandlerSocket.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIOHandlerStack.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIOHandlerStream.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIPAddress.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIPMCastBase.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIPMCastClient.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIPMCastServer.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIcmpClient.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdIntercept.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdInterceptSimLog.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdInterceptThrottler.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdLogBase.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdLogDebug.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdLogEvent.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdLogFile.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdLogStream.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdRawBase.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdRawClient.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdRawFunctions.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdRawHeaders.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdReply.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdReplyRFC.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdResourceStringsCore.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdScheduler.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdSchedulerOfThread.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdSchedulerOfThreadDefault.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdSchedulerOfThreadPool.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdServerIOHandler.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdServerIOHandlerSocket.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdServerIOHandlerStack.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdSimpleServer.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdSocketHandle.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdSocks.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdSync.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdTCPClient.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdTCPConnection.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdTCPServer.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdTCPStream.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdTask.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdThread.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdThreadComponent.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdThreadSafe.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdTraceRoute.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdUDPBase.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdUDPClient.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdUDPServer.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdYarn.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\indycorefpc.pas %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdCore90ASM90.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IddclCore90ASM90.inc %DESTDIR%\runtime\core
copy %SRCROOT%\Lib\Core\IdDeprecatedImplBugOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdDeprecatedImplBugOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdSymbolDeprecatedOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdSymbolDeprecatedOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdSymbolPlatformOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdSymbolPlatformOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdUnitPlatformOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Core\IdUnitPlatformOn.inc %DESTDIR%\includes


copy %SRCROOT%\Lib\System\IdAntiFreezeBase.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdBaseComponent.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdCTypes.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdComponent.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdException.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdGlobal.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdResourceStrings.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdResourceStringsUnix.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStack.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStackBSDBase.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStackUnix.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStackConsts.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStream.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStreamVCL.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStruct.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\indysystemfpc.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdDeprecatedImplBugOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdDeprecatedImplBugOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdOverflowCheckingOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdOverflowCheckingOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdRangeCheckingOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdRangeCheckingOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdStackFramesOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdStackFramesOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdSymbolDeprecatedOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdSymbolDeprecatedOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdSymbolPlatformOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdSymbolPlatformOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdSystem90ASM90.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdUnitPlatformOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdUnitPlatformOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdVers.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdObjectChecksOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdObjectChecksOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\System\IdWinsock2.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdWship6.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdStackWindows.pas %DESTDIR%\runtime\system
copy %SRCROOT%\Lib\System\IdIDN.pas %DESTDIR%\runtime\system


copy %SRCROOT%\Lib\Protocols\IdASN1Util.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAllAuthentications.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAuthenticationSSPI.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAllFTPListParsers.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAllHeaderCoders.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAttachment.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAttachmentFile.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAttachmentMemory.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAuthentication.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAuthenticationDigest.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAuthenticationManager.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdBlockCipherIntercept.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdChargenServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdChargenUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCharsets.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoder.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoder00E.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoder3to4.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoderBinHex4.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoderHeader.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoderMIME.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoderQuotedPrintable.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoderUUE.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCoderXXE.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdConnectThroughHttpProxy.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdContainers.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCookie.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCookieManager.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCustomHTTPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDICT.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDICTCommon.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDICTServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDNSCommon.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDNSResolver.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDNSServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDateTimeStamp.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDayTime.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDayTimeServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDayTimeUDP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDayTimeUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDiscardServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdDiscardUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdEMailAddress.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdEcho.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdEchoServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdEchoUDP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdEchoUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdExplicitTLSClientServerBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFIPS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFSP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPBaseFileSystem.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPCommon.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPList.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListOutput.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseAS400.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseBullGCOS7.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseBullGCOS8.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseChameleonNewt.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseCiscoIOS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseDistinctTCPIP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseEPLF.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseHellSoft.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseIEFTPGateway.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseKA9Q.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseMPEiX.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseMVS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseMicrowareOS9.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseMusic.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseNCSAForDOS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseNCSAForMACOS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseNovellNetware.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseNovellNetwarePSU.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseOS2.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParsePCNFSD.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParsePCTCP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseStercomOS390Exp.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseStercomUnixEnt.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseStratusVOS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseSuperTCP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseTOPS20.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseTSXPlus.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseTandemGuardian.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseUnisysClearPath.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseUnix.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseVM.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseVMS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseVSE.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseVxWorks.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseWfFTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseWinQVTNET.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseWindowsNT.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListParseXecomMicroRTOS.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPListTypes.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFTPServerContextBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFinger.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdFingerServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdGlobalProtocols.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdGopher.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdGopherConsts.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdGopherServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHMAC.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHMACMD5.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHMACSHA1.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHTTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHTTPHeaderInfo.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHTTPProxyServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHTTPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHash.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHashAdler32.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHashCRC.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHashElf.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHashMessageDigest.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHashSHA.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHeaderCoder2022JP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHeaderCoderBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHeaderCoderIndy.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHeaderCoderPlain.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHeaderList.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdHL7.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIMAP4.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIMAP4Server.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIPAddrMon.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIPWatch.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIRC.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIdent.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIdentServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdIrcServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdLPR.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMailBox.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMappedFTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMappedPOP3.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMappedPortTCP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMappedPortUDP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMappedTelnet.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessage.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageBuilder.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageClient.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCoder.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCoderBinHex4.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCoderMIME.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCoderQuotedPrintable.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCoderUUE.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCoderXXE.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCoderYenc.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageCollection.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageHelper.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMessageParts.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdMultipartFormData.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdNNTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdNNTPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdNetworkCalculator.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdOSFileName.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdOTPCalculator.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdPOP3.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdPOP3Server.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdQOTDUDP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdQOTDUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdQotd.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdQotdServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdRSH.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdRSHServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdRemoteCMDClient.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdRemoteCMDServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdReplyFTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdReplyIMAP4.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdReplyPOP3.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdReplySMTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdResourceStringsProtocols.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdResourceStringsOpenSSL.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdResourceStringsUriUtils.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdRexec.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdRexecServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSSL.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASL.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLAnonymous.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLCollection.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLDigest.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLExternal.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLLogin.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLOTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLPlain.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLSKey.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASLUserPass.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASL_CRAMBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASL_CRAM_MD5.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSASL_CRAM_SHA1.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSMTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSMTPBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSMTPRelay.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSMTPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSNMP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSNPP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSNTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSocksServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSSPI.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdServerInterceptLogBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdServerInterceptLogEvent.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdServerInterceptLogFile.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdStrings.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSysLog.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSysLogMessage.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSysLogServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSystat.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSystatServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSystatUDP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSystatUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTelnet.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTelnetServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdText.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTime.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTimeServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTimeUDP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTimeUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTrivialFTP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTrivialFTPBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdTrivialFTPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdURI.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdUnixTime.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdUnixTimeServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdUnixTimeUDP.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdUnixTimeUDPServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdUriUtils.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdUserAccounts.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdUserPassProvider.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdVCard.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdWebDAV.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdWhoIsServer.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdWhois.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdZLib.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdZLibHeaders.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdZLibConst.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdZLibCompressorBase.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCompressorZLib.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdCompressionIntercept.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\indyprotocolsfpc.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IddclProtocols90ASM90.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdDeprecatedImplBugOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdDeprecatedImplBugOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdIOChecksOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdIOChecksOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdOverflowCheckingOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdOverflowCheckingOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdProtocols90ASM90.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdRangeCheckingOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdRangeCheckingOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdSecurity90ASM90.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdSymbolDeprecatedOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdSymbolDeprecatedOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdSymbolPlatformOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdSymbolPlatformOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdUnitPlatformOff.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdUnitPlatformOn.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\IdResourceStringsSSPI.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSSLOpenSSLDefines.inc %DESTDIR%\includes
copy %SRCROOT%\Lib\Protocols\opensslHdrs\*.pas %DESTDIR%\runtime\protocols\opensslHdrs
copy %SRCROOT%\Lib\Protocols\IdSSLOpenSSLConsts.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSSLOpenSSLLoader.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSSLOpenSSL.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdSSLOpenSSLExceptionHandlers.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdResourceStringsOpenSSL.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdAuthenticationNTLM.pas %DESTDIR%\runtime\protocols
copy %SRCROOT%\Lib\Protocols\IdNTLM.pas %DESTDIR%\runtime\protocols

echo Indy successfully extracted to %DESTDIR%