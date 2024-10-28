library Indy.SocketsDebug;

{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.dll'}


uses
  IdASN1Util in '..\..\Source\IdASN1Util.pas',
  IdAllAuthentications in '..\..\Source\IdAllAuthentications.pas',
  IdAllFTPListParsers in '..\..\Source\IdAllFTPListParsers.pas',
  IdAllHeaderCoders in '..\..\Source\IdAllHeaderCoders.pas',
  IdAntiFreezeBase in '..\..\Source\IdAntiFreezeBase.pas',
  IdAssignedNumbers in '..\..\Source\IdAssignedNumbers.pas',
  IdAttachment in '..\..\Source\IdAttachment.pas',
  IdAttachmentFile in '..\..\Source\IdAttachmentFile.pas',
  IdAttachmentMemory in '..\..\Source\IdAttachmentMemory.pas',
  IdAuthentication in '..\..\Source\IdAuthentication.pas',
  IdAuthenticationDigest in '..\..\Source\IdAuthenticationDigest.pas',
  IdAuthenticationManager in '..\..\Source\IdAuthenticationManager.pas',
  IdBaseComponent in '..\..\Source\IdBaseComponent.pas',
  IdBlockCipherIntercept in '..\..\Source\IdBlockCipherIntercept.pas',
  IdBuffer in '..\..\Source\IdBuffer.pas',
  IdCarrierStream in '..\..\Source\Security\IdCarrierStream.pas',
  IdChargenServer in '..\..\Source\IdChargenServer.pas',
  IdChargenUDPServer in '..\..\Source\IdChargenUDPServer.pas',
  IdCharsets in '..\..\Source\IdCharsets.pas',
  IdCmdTCPClient in '..\..\Source\IdCmdTCPClient.pas',
  IdCmdTCPServer in '..\..\Source\IdCmdTCPServer.pas',
  IdCoder in '..\..\Source\IdCoder.pas',
  IdCoder00E in '..\..\Source\IdCoder00E.pas',
  IdCoder3to4 in '..\..\Source\IdCoder3to4.pas',
  IdCoderBinHex4 in '..\..\Source\IdCoderBinHex4.pas',
  IdCoderHeader in '..\..\Source\IdCoderHeader.pas',
  IdCoderMIME in '..\..\Source\IdCoderMIME.pas',
  IdCoderQuotedPrintable in '..\..\Source\IdCoderQuotedPrintable.pas',
  IdCoderUUE in '..\..\Source\IdCoderUUE.pas',
  IdCoderXXE in '..\..\Source\IdCoderXXE.pas',
  IdCommandHandlers in '..\..\Source\IdCommandHandlers.pas',
  IdComponent in '..\..\Source\IdComponent.pas',
  IdConnectThroughHttpProxy in '..\..\Source\IdConnectThroughHttpProxy.pas',
  IdContainers in '..\..\Source\IdContainers.pas',
  IdContext in '..\..\Source\IdContext.pas',
  IdCookie in '..\..\Source\IdCookie.pas',
  IdCookieManager in '..\..\Source\IdCookieManager.pas',
  IdCustomHTTPServer in '..\..\Source\IdCustomHTTPServer.pas',
  IdCustomTCPServer in '..\..\Source\IdCustomTCPServer.pas',
  IdCustomTransparentProxy in '..\..\Source\IdCustomTransparentProxy.pas',
  IdDICT in '..\..\Source\IdDICT.pas',
  IdDICTCommon in '..\..\Source\IdDICTCommon.pas',
  IdDICTServer in '..\..\Source\IdDICTServer.pas',
  IdDNSCommon in '..\..\Source\IdDNSCommon.pas',
  IdDNSResolver in '..\..\Source\IdDNSResolver.pas',
  IdDNSServer in '..\..\Source\IdDNSServer.pas',
  IdDateTimeStamp in '..\..\Source\IdDateTimeStamp.pas',
  IdDayTime in '..\..\Source\IdDayTime.pas',
  IdDayTimeServer in '..\..\Source\IdDayTimeServer.pas',
  IdDayTimeUDP in '..\..\Source\IdDayTimeUDP.pas',
  IdDayTimeUDPServer in '..\..\Source\IdDayTimeUDPServer.pas',
  IdDiscardServer in '..\..\Source\IdDiscardServer.pas',
  IdDiscardUDPServer in '..\..\Source\IdDiscardUDPServer.pas',
  IdEMailAddress in '..\..\Source\IdEMailAddress.pas',
  IdEcho in '..\..\Source\IdEcho.pas',
  IdEchoServer in '..\..\Source\IdEchoServer.pas',
  IdEchoUDP in '..\..\Source\IdEchoUDP.pas',
  IdEchoUDPServer in '..\..\Source\IdEchoUDPServer.pas',
  IdException in '..\..\Source\IdException.pas',
  IdExceptionCore in '..\..\Source\IdExceptionCore.pas',
  IdExplicitTLSClientServerBase in '..\..\Source\IdExplicitTLSClientServerBase.pas',
  IdFSP in '..\..\Source\IdFSP.pas',
  IdFTP in '..\..\Source\IdFTP.pas',
  IdFTPBaseFileSystem in '..\..\Source\IdFTPBaseFileSystem.pas',
  IdFTPCommon in '..\..\Source\IdFTPCommon.pas',
  IdFTPList in '..\..\Source\IdFTPList.pas',
  IdFTPListOutput in '..\..\Source\IdFTPListOutput.pas',
  IdFTPListParseAS400 in '..\..\Source\IdFTPListParseAS400.pas',
  IdFTPListParseBase in '..\..\Source\IdFTPListParseBase.pas',
  IdFTPListParseBullGCOS7 in '..\..\Source\IdFTPListParseBullGCOS7.pas',
  IdFTPListParseBullGCOS8 in '..\..\Source\IdFTPListParseBullGCOS8.pas',
  IdFTPListParseChameleonNewt in '..\..\Source\IdFTPListParseChameleonNewt.pas',
  IdFTPListParseCiscoIOS in '..\..\Source\IdFTPListParseCiscoIOS.pas',
  IdFTPListParseDistinctTCPIP in '..\..\Source\IdFTPListParseDistinctTCPIP.pas',
  IdFTPListParseEPLF in '..\..\Source\IdFTPListParseEPLF.pas',
  IdFTPListParseHellSoft in '..\..\Source\IdFTPListParseHellSoft.pas',
  IdFTPListParseKA9Q in '..\..\Source\IdFTPListParseKA9Q.pas',
  IdFTPListParseMPEiX in '..\..\Source\IdFTPListParseMPEiX.pas',
  IdFTPListParseMVS in '..\..\Source\IdFTPListParseMVS.pas',
  IdFTPListParseMicrowareOS9 in '..\..\Source\IdFTPListParseMicrowareOS9.pas',
  IdFTPListParseMusic in '..\..\Source\IdFTPListParseMusic.pas',
  IdFTPListParseNCSAForDOS in '..\..\Source\IdFTPListParseNCSAForDOS.pas',
  IdFTPListParseNCSAForMACOS in '..\..\Source\IdFTPListParseNCSAForMACOS.pas',
  IdFTPListParseNovellNetware in '..\..\Source\IdFTPListParseNovellNetware.pas',
  IdFTPListParseNovellNetwarePSU in '..\..\Source\IdFTPListParseNovellNetwarePSU.pas',
  IdFTPListParseOS2 in '..\..\Source\IdFTPListParseOS2.pas',
  IdFTPListParsePCNFSD in '..\..\Source\IdFTPListParsePCNFSD.pas',
  IdFTPListParseStercomOS390Exp in '..\..\Source\IdFTPListParseStercomOS390Exp.pas',
  IdFTPListParseStercomUnixEnt in '..\..\Source\IdFTPListParseStercomUnixEnt.pas',
  IdFTPListParseStratusVOS in '..\..\Source\IdFTPListParseStratusVOS.pas',
  IdFTPListParseSuperTCP in '..\..\Source\IdFTPListParseSuperTCP.pas',
  IdFTPListParseTOPS20 in '..\..\Source\IdFTPListParseTOPS20.pas',
  IdFTPListParseTSXPlus in '..\..\Source\IdFTPListParseTSXPlus.pas',
  IdFTPListParseTandemGuardian in '..\..\Source\IdFTPListParseTandemGuardian.pas',
  IdFTPListParseUnisysClearPath in '..\..\Source\IdFTPListParseUnisysClearPath.pas',
  IdFTPListParseUnix in '..\..\Source\IdFTPListParseUnix.pas',
  IdFTPListParseVM in '..\..\Source\IdFTPListParseVM.pas',
  IdFTPListParseVMS in '..\..\Source\IdFTPListParseVMS.pas',
  IdFTPListParseVSE in '..\..\Source\IdFTPListParseVSE.pas',
  IdFTPListParseVxWorks in '..\..\Source\IdFTPListParseVxWorks.pas',
  IdFTPListParseWfFTP in '..\..\Source\IdFTPListParseWfFTP.pas',
  IdFTPListParseWinQVTNET in '..\..\Source\IdFTPListParseWinQVTNET.pas',
  IdFTPListParseWindowsNT in '..\..\Source\IdFTPListParseWindowsNT.pas',
  IdFTPListParseXecomMicroRTOS in '..\..\Source\IdFTPListParseXecomMicroRTOS.pas',
  IdFTPListTypes in '..\..\Source\IdFTPListTypes.pas',
  IdFTPServer in '..\..\Source\IdFTPServer.pas',
  IdFTPServerContextBase in '..\..\Source\IdFTPServerContextBase.pas',
  IdFinger in '..\..\Source\IdFinger.pas',
  IdFingerServer in '..\..\Source\IdFingerServer.pas',
  IdGlobal in '..\..\Source\IdGlobal.pas',
  IdGlobalCore in '..\..\Source\IdGlobalCore.pas',
  IdGlobalProtocols in '..\..\Source\IdGlobalProtocols.pas',
  IdGopher in '..\..\Source\IdGopher.pas',
  IdGopherConsts in '..\..\Source\IdGopherConsts.pas',
  IdGopherServer in '..\..\Source\IdGopherServer.pas',
  IdHMAC in '..\..\Source\IdHMAC.pas',
  IdHMACMD5 in '..\..\Source\IdHMACMD5.pas',
  IdHMACSHA1 in '..\..\Source\IdHMACSHA1.pas',
  IdHTTP in '..\..\Source\IdHTTP.pas',
  IdHTTPHeaderInfo in '..\..\Source\IdHTTPHeaderInfo.pas',
  IdHTTPProxyServer in '..\..\Source\IdHTTPProxyServer.pas',
  IdHTTPServer in '..\..\Source\IdHTTPServer.pas',
  IdHash in '..\..\Source\IdHash.pas',
  IdHashCRC in '..\..\Source\IdHashCRC.pas',
  IdHashElf in '..\..\Source\IdHashElf.pas',
  IdHashMessageDigest in '..\..\Source\IdHashMessageDigest.pas',
  IdHashSHA in '..\..\Source\IdHashSHA.pas',
  IdHeaderCoderBase in '..\..\Source\IdHeaderCoderBase.pas',
  IdHeaderCoderDotNet in '..\..\Source\IdHeaderCoderDotNet.pas',
  IdHeaderCoderPlain in '..\..\Source\IdHeaderCoderPlain.pas',
  IdHeaderList in '..\..\Source\IdHeaderList.pas',
  IdIMAP4 in '..\..\Source\IdIMAP4.pas',
  IdIMAP4Server in '..\..\Source\IdIMAP4Server.pas',
  IdIOHandler in '..\..\Source\IdIOHandler.pas',
  IdIOHandlerSocket in '..\..\Source\IdIOHandlerSocket.pas',
  IdIOHandlerStack in '..\..\Source\IdIOHandlerStack.pas',
  IdIOHandlerStream in '..\..\Source\IdIOHandlerStream.pas',
  IdIOHandlerTls in '..\..\Source\Security\IdIOHandlerTls.pas',
  IdIPAddrMon in '..\..\Source\IdIPAddrMon.pas',
  IdIPAddress in '..\..\Source\IdIPAddress.pas',
  IdIPMCastBase in '..\..\Source\IdIPMCastBase.pas',
  IdIPMCastClient in '..\..\Source\IdIPMCastClient.pas',
  IdIPMCastServer in '..\..\Source\IdIPMCastServer.pas',
  IdIPWatch in '..\..\Source\IdIPWatch.pas',
  IdIRC in '..\..\Source\IdIRC.pas',
  IdIcmpClient in '..\..\Source\IdIcmpClient.pas',
  IdIdent in '..\..\Source\IdIdent.pas',
  IdIdentServer in '..\..\Source\IdIdentServer.pas',
  IdIntercept in '..\..\Source\IdIntercept.pas',
  IdInterceptSimLog in '..\..\Source\IdInterceptSimLog.pas',
  IdInterceptThrottler in '..\..\Source\IdInterceptThrottler.pas',
  IdIrcServer in '..\..\Source\IdIrcServer.pas',
  IdLPR in '..\..\Source\IdLPR.pas',
  IdLogBase in '..\..\Source\IdLogBase.pas',
  IdLogDebug in '..\..\Source\IdLogDebug.pas',
  IdLogEvent in '..\..\Source\IdLogEvent.pas',
  IdLogFile in '..\..\Source\IdLogFile.pas',
  IdLogStream in '..\..\Source\IdLogStream.pas',
  IdMailBox in '..\..\Source\IdMailBox.pas',
  IdMappedFTP in '..\..\Source\IdMappedFTP.pas',
  IdMappedPOP3 in '..\..\Source\IdMappedPOP3.pas',
  IdMappedPortTCP in '..\..\Source\IdMappedPortTCP.pas',
  IdMappedPortUDP in '..\..\Source\IdMappedPortUDP.pas',
  IdMappedTelnet in '..\..\Source\IdMappedTelnet.pas',
  IdMessage in '..\..\Source\IdMessage.pas',
  IdMessageBuilder in '..\..\Source\IdMessageBuilder.pas',
  IdMessageClient in '..\..\Source\IdMessageClient.pas',
  IdMessageCoder in '..\..\Source\IdMessageCoder.pas',
  IdMessageCoderMIME in '..\..\Source\IdMessageCoderMIME.pas',
  IdMessageCoderQuotedPrintable in '..\..\Source\IdMessageCoderQuotedPrintable.pas',
  IdMessageCoderUUE in '..\..\Source\IdMessageCoderUUE.pas',
  IdMessageCoderXXE in '..\..\Source\IdMessageCoderXXE.pas',
  IdMessageCoderYenc in '..\..\Source\IdMessageCoderYenc.pas',
  IdMessageCollection in '..\..\Source\IdMessageCollection.pas',
  IdMessageHelper in '..\..\Source\IdMessageHelper.pas',
  IdMessageParts in '..\..\Source\IdMessageParts.pas',
  IdMultipartFormData in '..\..\Source\IdMultipartFormData.pas',
  IdNNTP in '..\..\Source\IdNNTP.pas',
  IdNNTPServer in '..\..\Source\IdNNTPServer.pas',
  IdNetworkCalculator in '..\..\Source\IdNetworkCalculator.pas',
  IdOSFileName in '..\..\Source\IdOSFileName.pas',
  IdOTPCalculator in '..\..\Source\IdOTPCalculator.pas',
  IdPOP3 in '..\..\Source\IdPOP3.pas',
  IdPOP3Server in '..\..\Source\IdPOP3Server.pas',
  IdQOTDUDP in '..\..\Source\IdQOTDUDP.pas',
  IdQOTDUDPServer in '..\..\Source\IdQOTDUDPServer.pas',
  IdQotd in '..\..\Source\IdQotd.pas',
  IdQotdServer in '..\..\Source\IdQotdServer.pas',
  IdRSH in '..\..\Source\IdRSH.pas',
  IdRSHServer in '..\..\Source\IdRSHServer.pas',
  IdRawBase in '..\..\Source\IdRawBase.pas',
  IdRawClient in '..\..\Source\IdRawClient.pas',
  IdRawFunctions in '..\..\Source\IdRawFunctions.pas',
  IdRawHeaders in '..\..\Source\IdRawHeaders.pas',
  IdRemoteCMDClient in '..\..\Source\IdRemoteCMDClient.pas',
  IdRemoteCMDServer in '..\..\Source\IdRemoteCMDServer.pas',
  IdReply in '..\..\Source\IdReply.pas',
  IdReplyFTP in '..\..\Source\IdReplyFTP.pas',
  IdReplyIMAP4 in '..\..\Source\IdReplyIMAP4.pas',
  IdReplyPOP3 in '..\..\Source\IdReplyPOP3.pas',
  IdReplyRFC in '..\..\Source\IdReplyRFC.pas',
  IdReplySMTP in '..\..\Source\IdReplySMTP.pas',
  IdResourceStrings in '..\..\Source\IdResourceStrings.pas',
  IdResourceStringsCore in '..\..\Source\IdResourceStringsCore.pas',
  IdResourceStringsProtocols in '..\..\Source\IdResourceStringsProtocols.pas',
  IdRexec in '..\..\Source\IdRexec.pas',
  IdRexecServer in '..\..\Source\IdRexecServer.pas',
  IdSASL in '..\..\Source\IdSASL.pas',
  IdSASLAnonymous in '..\..\Source\IdSASLAnonymous.pas',
  IdSASLCollection in '..\..\Source\IdSASLCollection.pas',
  IdSASLDigest in '..\..\Source\IdSASLDigest.pas',
  IdSASLExternal in '..\..\Source\IdSASLExternal.pas',
  IdSASLLogin in '..\..\Source\IdSASLLogin.pas',
  IdSASLOAuth in '..\..\Source\IdSASLOAuth.pas',
  IdSASLOTP in '..\..\Source\IdSASLOTP.pas',
  IdSASLPlain in '..\..\Source\IdSASLPlain.pas',
  IdSASLSKey in '..\..\Source\IdSASLSKey.pas',
  IdSASLUserPass in '..\..\Source\IdSASLUserPass.pas',
  IdSASL_CRAMBase in '..\..\Source\IdSASL_CRAMBase.pas',
  IdSASL_CRAM_MD5 in '..\..\Source\IdSASL_CRAM_MD5.pas',
  IdSASL_CRAM_SHA1 in '..\..\Source\IdSASL_CRAM_SHA1.pas',
  IdSMTP in '..\..\Source\IdSMTP.pas',
  IdSMTPBase in '..\..\Source\IdSMTPBase.pas',
  IdSMTPRelay in '..\..\Source\IdSMTPRelay.pas',
  IdSMTPServer in '..\..\Source\IdSMTPServer.pas',
  IdSNPP in '..\..\Source\IdSNPP.pas',
  IdSNTP in '..\..\Source\IdSNTP.pas',
  IdSSL in '..\..\Source\IdSSL.pas',
  IdSSLDotNET in '..\..\Source\IdSSLDotNET.pas',
  IdScheduler in '..\..\Source\IdScheduler.pas',
  IdSchedulerOfThread in '..\..\Source\IdSchedulerOfThread.pas',
  IdSchedulerOfThreadDefault in '..\..\Source\IdSchedulerOfThreadDefault.pas',
  IdSchedulerOfThreadPool in '..\..\Source\IdSchedulerOfThreadPool.pas',
  IdServerIOHandler in '..\..\Source\IdServerIOHandler.pas',
  IdServerIOHandlerSocket in '..\..\Source\IdServerIOHandlerSocket.pas',
  IdServerIOHandlerStack in '..\..\Source\IdServerIOHandlerStack.pas',
  IdServerIOHandlerTls in '..\..\Source\Security\IdServerIOHandlerTls.pas',
  IdServerInterceptLogBase in '..\..\Source\IdServerInterceptLogBase.pas',
  IdServerInterceptLogEvent in '..\..\Source\IdServerInterceptLogEvent.pas',
  IdServerInterceptLogFile in '..\..\Source\IdServerInterceptLogFile.pas',
  IdSimpleServer in '..\..\Source\IdSimpleServer.pas',
  IdSocketHandle in '..\..\Source\IdSocketHandle.pas',
  IdSocketStream in '..\..\Source\Security\IdSocketStream.pas',
  IdSocks in '..\..\Source\IdSocks.pas',
  IdSocksServer in '..\..\Source\IdSocksServer.pas',
  IdStack in '..\..\Source\IdStack.pas',
  IdStackConsts in '..\..\Source\IdStackConsts.pas',
  IdStackDotNet in '..\..\Source\IdStackDotNet.pas',
  IdStream in '..\..\Source\IdStream.pas',
  IdStreamNET in '..\..\Source\IdStreamNET.pas',
  IdStrings in '..\..\Source\IdStrings.pas',
  IdStruct in '..\..\Source\IdStruct.pas',
  IdSync in '..\..\Source\IdSync.pas',
  IdSysLog in '..\..\Source\IdSysLog.pas',
  IdSysLogMessage in '..\..\Source\IdSysLogMessage.pas',
  IdSysLogServer in '..\..\Source\IdSysLogServer.pas',
  IdSystat in '..\..\Source\IdSystat.pas',
  IdSystatServer in '..\..\Source\IdSystatServer.pas',
  IdSystatUDP in '..\..\Source\IdSystatUDP.pas',
  IdSystatUDPServer in '..\..\Source\IdSystatUDPServer.pas',
  IdTCPClient in '..\..\Source\IdTCPClient.pas',
  IdTCPConnection in '..\..\Source\IdTCPConnection.pas',
  IdTCPServer in '..\..\Source\IdTCPServer.pas',
  IdTCPStream in '..\..\Source\IdTCPStream.pas',
  IdTask in '..\..\Source\IdTask.pas',
  IdTelnet in '..\..\Source\IdTelnet.pas',
  IdTelnetServer in '..\..\Source\IdTelnetServer.pas',
  IdText in '..\..\Source\IdText.pas',
  IdThread in '..\..\Source\IdThread.pas',
  IdThreadComponent in '..\..\Source\IdThreadComponent.pas',
  IdThreadSafe in '..\..\Source\IdThreadSafe.pas',
  IdTime in '..\..\Source\IdTime.pas',
  IdTimeServer in '..\..\Source\IdTimeServer.pas',
  IdTimeUDP in '..\..\Source\IdTimeUDP.pas',
  IdTimeUDPServer in '..\..\Source\IdTimeUDPServer.pas',
  IdTlsClientOptions in '..\..\Source\Security\IdTlsClientOptions.pas',
  IdTlsServerOptions in '..\..\Source\Security\IdTlsServerOptions.pas',
  IdTraceRoute in '..\..\Source\IdTraceRoute.pas',
  IdTrivialFTP in '..\..\Source\IdTrivialFTP.pas',
  IdTrivialFTPBase in '..\..\Source\IdTrivialFTPBase.pas',
  IdTrivialFTPServer in '..\..\Source\IdTrivialFTPServer.pas',
  IdUDPBase in '..\..\Source\IdUDPBase.pas',
  IdUDPClient in '..\..\Source\IdUDPClient.pas',
  IdUDPServer in '..\..\Source\IdUDPServer.pas',
  IdURI in '..\..\Source\IdURI.pas',
  IdUnixTime in '..\..\Source\IdUnixTime.pas',
  IdUnixTimeServer in '..\..\Source\IdUnixTimeServer.pas',
  IdUnixTimeUDP in '..\..\Source\IdUnixTimeUDP.pas',
  IdUnixTimeUDPServer in '..\..\Source\IdUnixTimeUDPServer.pas',
  IdUserAccounts in '..\..\Source\IdUserAccounts.pas',
  IdUserPassProvider in '..\..\Source\IdUserPassProvider.pas',
  IdVCard in '..\..\Source\IdVCard.pas',
  IdWebDAV in '..\..\Source\IdWebDAV.pas',
  IdWhoIsServer in '..\..\Source\IdWhoIsServer.pas',
  IdWhois in '..\..\Source\IdWhois.pas',
  IdYarn in '..\..\Source\IdYarn.pas',
  IdZLibCompressorBase in '..\..\Source\IdZLibCompressorBase.pas',
  IdAssemblyInfo in '..\..\Source\IdAssemblyInfo.pas';


//
// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Revision and Build Numbers
// by using the '*' as shown below:


//
// In order to sign your assembly you must specify a key to use. Refer to the
// Microsoft .NET Framework documentation for more information on assembly signing.
//
// Use the attributes below to control which key is used for signing.
//
// Notes:
//   (*) If no key is specified, the assembly is not signed.
//   (*) KeyName refers to a key that has been installed in the Crypto Service
//       Provider (CSP) on your machine. KeyFile refers to a file which contains
//       a key.
//   (*) If the KeyFile and the KeyName values are both specified, the
//       following processing occurs:
//       (1) If the KeyName can be found in the CSP, that key is used.
//       (2) If the KeyName does not exist and the KeyFile does exist, the key
//           in the KeyFile is installed into the CSP and used.
//   (*) In order to create a KeyFile, you can use the sn.exe (Strong Name) utility.
//       When specifying the KeyFile, the location of the KeyFile should be
//       relative to the project output directory. For example, if your KeyFile is
//       located in the project directory, you would specify the AssemblyKeyFile
//       attribute as [assembly: AssemblyKeyFile('mykey.snk')], provided your output
//       directory is the project directory (the default).
//   (*) Delay Signing is an advanced option - see the Microsoft .NET Framework
//       documentation for more information on this.
//

//
// Use the attributes below to control the COM visibility of your assembly. By
// default the entire assembly is visible to COM. Setting ComVisible to false
// is the recommended default for your assembly. To then expose a class and interface
// to COM set ComVisible to true on each one. It is also recommended to add a
// Guid attribute.
//

//[assembly: Guid(')]
//[assembly: TypeLibVersion(1, 0)]

begin

end.