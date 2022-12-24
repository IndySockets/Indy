{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.51    3/28/2005 1:12:36 PM  JPMugaas
  Package build errors.

  Rev 1.50    2/10/2005 2:24:40 PM  JPMugaas
  Minor Restructures for some new UnixTime Service components.

  Rev 1.49    12/12/2004 20:26:16  ANeillans
  Fixed compile error

    Rev 1.48    12/10/2004 4:57:52 PM  DSiders
  Added TIdIPAddrMon to Misc pallette.

  Rev 1.47    11/14/2004 10:30:10 PM  JPMugaas
  FSP added.

  Rev 1.46    10/22/2004 7:24:14 AM  Joerg
  Fix .NET bitmaps again after previous checkin.

  Rev 1.45    10/22/2004 1:43:58 PM  BGooijen
  Removed  IdHL7 from palette

  Rev 1.42    6/15/2004 5:51:56 PM  JPMugaas
  Added Compressor class for ZLibEx.

  Rev 1.41    3/8/2004 10:08:52 AM  JPMugaas
  IdDICT now compiles with new code.  IdDICT now added to palette.

  Rev 1.40    3/3/2004 6:51:22 PM  JPMugaas
  TIdHTTPProxyServer added to servers tab.

  Rev 1.39    2/29/2004 1:36:08 PM  JPMugaas
  Hack for missing property editor.

  Rev 1.38    10/02/2004 12:53:20  ANeillans
  IdCoreResourceStrings renamed to IdResourceStringsCore

  Rev 1.37    2/3/2004 4:29:14 PM  JPMugaas
  Should compile.

  Rev 1.36    2/2/2004 5:04:04 PM  JPMugaas
  IdMappedFTP now works in DotNET.

  Rev 1.35    2/2/2004 4:28:54 PM  JPMugaas
  Recased IdMappedPOP3.  Added some MappedPort components to DotNET because
  those now compile.

  Rev 1.34    2/1/2004 3:37:34 PM  JPMugaas
  Updated for unit change I made.  I forgot to fix this, sorry.

  Rev 1.33    1/31/2004 4:26:58 PM  JPMugaas
  Updated with package move for FTP materials and fixed for DotNET.

  Rev 1.32    1/25/2004 3:23:20 PM  JPMugaas
  IdSASLList dropped.

  Rev 1.31    1/4/2004 12:39:16 AM  BGooijen
  Added TIdFTPServer

  Rev 1.30    11/22/2003 11:53:08 PM  BGooijen
  Icons for DotNet

  Rev 1.29    11/11/2003 7:03:48 PM  BGooijen
  DotNet

  Rev 1.28    2003.10.19 1:35:46 PM  czhower
  Moved Borland define to .inc

  Rev 1.27    2003.10.17 6:19:50 PM  czhower
  Temporarily commented out FTPServer.

  Rev 1.26    2003.10.14 1:27:58 PM  czhower
  DotNet

  Rev 1.25    10/12/2003 1:49:58 PM  BGooijen
  Changed comment of last checkin

  Rev 1.24    10/12/2003 1:43:42 PM  BGooijen
  Changed IdCompilerDefines.inc to Core\IdCompilerDefines.inc

  Rev 1.23    9/20/2003 04:33:08 PM  JPMugaas
  Removed reference to IdThreadComponent from In the protcols packages.  It
  should be in the core package.

  Rev 1.22    9/19/2003 04:27:08 PM  JPMugaas
  Removed IdFTPServer so Indy can compile with Kudzu's new changes.

  Rev 1.21    9/16/2003 11:58:12 PM  JPMugaas
  Updated packages with TIdSocksServer and IdHL7.

  Rev 1.20    7/13/2003 06:28:56 PM  JPMugaas
  Added TIdCompressorBorZLib to palette for HTTP compression (gzip, deflate).

  Rev 1.19    6/16/2003 09:53:26 PM  JPMugaas
  IdIMAP4 now added back into the packages.

  Rev 1.18    6/15/2003 03:26:06 PM  JPMugaas
  Renamed IdDirectSMTP to IdSMTPRelay.

  Rev 1.17    6/2/2003 01:59:34 AM  JPMugaas
  Temporarily removed IMAP4.

  Rev 1.16    5/11/2003 05:33:32 AM  JPMugaas

  Rev 1.15    5/10/2003 10:11:22 PM  JPMugaas
  Added S/Key SASL mechanism.

  Rev 1.14    10/5/2003 10:26:42 AM  SGrobety
  CRAM-MD5 added

  Rev 1.13    5/7/2003 04:38:22 AM  JPMugaas
  IMAP4 added back.

  Rev 1.12    4/23/2003 05:16:20 PM  JPMugaas
  Temporarily removed IMAP4.  That unit does not compile.

  Rev 1.11    4/10/2003 02:43:44 PM  JPMugaas
  Fixed compile error.

    Rev 1.10    4/10/2003 4:36:54 PM  BGooijen
  Added TIdServerCompressionIntercept

    Rev 1.9    3/22/2003 11:11:26 PM  BGooijen
  Added TIdServerInterceptLogEvent and TIdServerInterceptLogFile

  Rev 1.8    3/13/2003 11:06:26 AM  JPMugaas
  Classes were renamed in OpenSSL unit.

  Rev 1.7    2/24/2003 10:16:40 PM  JPMugaas
  Removed IdSocksServer from unit.

  Rev 1.6    2/24/2003 08:15:28 AM  JPMugaas
  IOHandlerSSL included.

  Rev 1.5    2/6/2003 03:18:24 AM  JPMugaas
  Updated components that compile with Indy 10.

  Rev 1.4    1/9/2003 07:19:18 AM  JPMugaas
  Temporarily removed Tunnel components until we can get them working with the
  Context class.

  Rev 1.3    12/16/2002 03:34:40 AM  JPMugaas
  Added OTP SASL mechanism to palette.

  Rev 1.2    12/15/2002 05:50:16 PM  JPMugaas
  SMTP and IMAP4 compile.  IdPOP3, IdFTP, IMAP4, and IdSMTP now restored in
  IdRegister.

  Rev 1.1    12/7/2002 06:43:24 PM  JPMugaas
  These should now compile except for Socks server.  IPVersion has to be a
  property someplace for that.

  Rev 1.0    11/13/2002 07:58:56 AM  JPMugaas
}

unit IdRegister;


interface

{$i IdCompilerDefines.inc}

uses
  Classes;

// Procs
procedure Register;

implementation

uses
  IdDsnResourceStrings,
  {$IFDEF FPC}
  LResources,
  {$ENDIF}

  IdBlockCipherIntercept,
  IdChargenServer,
  IdChargenUDPServer,
  IdCoder3to4,
  IdCoderBinHex4,
  IdCoderMIME,
  IdCoderQuotedPrintable,
  IdCoderUUE,
  IdCoderXXE,
  {$IFDEF USE_ZLIB_UNIT}
  IdCompressorZLib,
  IdCompressionIntercept,
  {$ENDIF}
  IdConnectThroughHttpProxy,
  IdCookieManager,
  IdResourceStringsCore,
  IdDateTimeStamp,
  IdDayTime,
  IdDayTimeServer,
  IdDayTimeUDP,
  IdDayTimeUDPServer,
  IdDICT,
  IdDICTServer,
  IdDiscardServer,
  IdDiscardUDPServer,
  IdDsnRegister,
  IdDNSResolver,
  IdDNSServer,
  IdDsnCoreResourceStrings,
  IdEcho,
  IdEchoServer,
  IdEchoUDP,
  IdEchoUDPServer,
  IdFinger,
  IdFingerServer,
  IdFSP,
  IdFTP,
  IdFTPServer,
  IdGopher,
  IdGopherServer,
  IdHashMessageDigest,
  IdHL7,
  IdHTTP,
  IdHTTPProxyServer,
  IdHTTPServer,
  IdIPAddrMon,
  IdIdent,
  IdIdentServer,
  IdIMAP4,
  IdIMAP4Server,
  IdIPWatch,
  IdIRC,
  IdIrcServer,
  IdLPR,
  IdMailBox,
  IdMappedFTP,
  IdMappedPortTCP,
  IdMappedTelnet,
  IdMappedPOP3,
  IdMappedPortUDP,
  IdMessage,
  IdMessageCoderMIME,
  IdMessageCoderYenc,
  IdNetworkCalculator,
  IdNNTP,
  IdNNTPServer,
  IdPOP3,
  IdPOP3Server,
  IdQotd,
  IdQotdServer,
  IdQOTDUDP,
  IdQOTDUDPServer,
  IdResourceStrings,
  IdResourceStringsProtocols,
  IdRexec,
  IdRexecServer,
  IdRSH,
  IdRSHServer,
  IdSASLAnonymous,
  IdSASLDigest,
  IdSASLExternal,
  IdSASLLogin,
  IdSASLOTP,
  IdSASLPlain,
  IdSASLSKey,
  IdSASLUserPass,
  IdSASL_CRAM_MD5,
  IdSASL_CRAM_SHA1,
  IdServerInterceptLogEvent,
  IdServerInterceptLogFile,
  IdSMTP,
  IdSMTPRelay,
  IdSMTPServer,
  {$IFNDEF DOTNET}
  IdSNMP,
  {$ENDIF}
  IdSNPP,
  IdSNTP,
  IdSocksServer,
  {$IFDEF DOTNET_2_OR_ABOVE}
  IdSSLDotNET,
  {$ENDIF}
  {$IFDEF USE_OPENSSL}
  IdSSLOpenSSL,
  {$ENDIF}
  IdSysLog,
  IdSysLogMessage,
  IdSysLogServer,
  IdSystat,
  IdSystatServer,
  IdSystatUDP,
  IdSystatUDPServer,
  IdTelnet,
  IdTelnetServer,
  IdTime,
  IdTimeServer,
  IdTimeUDP,
  IdTimeUDPServer,

  IdTrivialFTP,
  IdTrivialFTPServer,

  //TODO:  IdTunnelMaster,
  //TODO:  IdTunnelSlave,
  IdUnixTime,
  IdUnixTimeServer,
  IdUnixTimeUDP,
  IdUnixTimeUDPServer,
  IdUserAccounts,
  IdUserPassProvider,
  IdVCard,
  IdWebDAV,
  IdWhois,
  IdWhoIsServer;

{$IFDEF DOTNET}
  {$R IconsDotNet\TIdBlockCipherIntercept.bmp}
  {$R IconsDotNet\TIdChargenServer.bmp}
  {$R IconsDotNet\TIdChargenUDPServer.bmp}
  {$R IconsDotNet\TIdConnectThroughHttpProxy.bmp}
  {$R IconsDotNet\TIdCookieManager.bmp}
  {$R IconsDotNet\TIdDateTimeStamp.bmp}
  {$R IconsDotNet\TIdDayTime.bmp}
  {$R IconsDotNet\TIdDayTimeServer.bmp}
  {$R IconsDotNet\TIdDayTimeUDP.bmp}
  {$R IconsDotNet\TIdDayTimeUDPServer.bmp}
  {$R IconsDotNET\TIdDecoderBinHex4.bmp}  
  {$R IconsDotNet\TIdDecoderMIME.bmp}
  {$R IconsDotNet\TIdDecoderQuotedPrintable.bmp}
  {$R IconsDotNet\TIdDecoderUUE.bmp}
  {$R IconsDotNet\TIdDecoderXXE.bmp}
  {$R IconsDotNet\TIdDICT.bmp}
  {$R IconsDotNet\TIdDICTServer.bmp}
  {$R IconsDotNet\TIdDISCARDServer.bmp}
  {$R IconsDotNet\TIdDiscardUDPServer.bmp}
  {$R IconsDotNet\TIdDNSResolver.bmp}
  {$R IconsDotNet\TIdDNSServer.bmp}
  {$R IconsDotNet\TIdEcho.bmp}
  {$R IconsDotNet\TIdECHOServer.bmp}
  {$R IconsDotNet\TIdEchoUDP.bmp}
  {$R IconsDotNet\TIdEchoUDPServer.bmp}
  {$R IconsDotNet\TIdEncoderBinHex4.bmp}
  {$R IconsDotNet\TIdEncoderMIME.bmp}
  {$R IconsDotNet\TIdEncoderQuotedPrintable.bmp}
  {$R IconsDotNet\TIdEncoderUUE.bmp}
  {$R IconsDotNet\TIdEncoderXXE.bmp}
  {$R IconsDotNet\TIdFinger.bmp}
  {$R IconsDotNet\TIdFingerServer.bmp}
  {$R IconsDotNet\TIdFTP.bmp}
  {$R IconsDotNet\TIdFSP.bmp}
  {$R IconsDotNet\TIdFTPServer.bmp}
  {$R IconsDotNet\TIdGopher.bmp}
  {$R IconsDotNet\TIdGopherServer.bmp}
  {$R IconsDotNet\TIdHostnameServer.bmp}
  {$R IconsDotNet\TIdHTTP.bmp}
  {$R IconsDotNet\TIdHTTPProxyServer.bmp}
  {$R IconsDotNet\TIdHTTPServer.bmp}
  {$R IconsDotNet\TIdIdent.bmp}
  {$R IconsDotNet\TIdIdentServer.bmp}
  {$R IconsDotNet\TIdIMAP4.bmp}
  {$R IconsDotNet\TIdIMAP4Server.bmp}
  {$R IconsDotNet\TIdIOHandlerChain.bmp}
  {$R IconsDotNet\TIdIOHandlerSocket.bmp}
  {$R IconsDotNet\TIdIOHandlerThrottle.bmp}
  {$R IconsDotNet\TIdIPWatch.bmp}
  {$R IconsDotNet\TIdIPAddrMon.bmp}
  {$R IconsDotNet\TIdIRC.bmp}
  {$R IconsDotNet\TIdIRCServer.bmp}
  {$R IconsDotNet\TIdLPR.bmp}
  {$R IconsDotNet\TIdMailBox.bmp}
  {$R IconsDotNet\TIdMappedFTP.bmp}
  {$R IconsDotNet\TIdMappedPOP3.bmp}
  {$R IconsDotNet\TIdMappedPortTCP.bmp}
  {$R IconsDotNet\TIdMappedPortUDP.bmp}
  {$R IconsDotNet\TIdMappedTelnet.bmp}
  {$R IconsDotNet\TIdMessage.bmp}
  {$R IconsDotNet\TIdMessageDecoderMIME.bmp}
  {$R IconsDotNet\TIdMessageDecoderYENC.bmp}
  {$R IconsDotNet\TIdMessageEncoderMIME.bmp}
  {$R IconsDotNet\TIdMessageEncoderYENC.bmp}
  {$R IconsDotNet\TIdNetworkCalculator.bmp}
  {$R IconsDotNet\TIdNNTP.bmp}
  {$R IconsDotNet\TIdNNTPServer.bmp}
  {$R IconsDotNet\TIdPOP3.bmp}
  {$R IconsDotNet\TIdPOP3Server.bmp}
  {$R IconsDotNet\TIdQOTD.bmp}
  {$R IconsDotNet\TIdQOTDServer.bmp}
  {$R IconsDotNet\TIdQOTDUDP.bmp}
  {$R IconsDotNet\TIdQotdUDPServer.bmp}
  {$R IconsDotNet\TIdRexec.bmp}
  {$R IconsDotNet\TIdRexecServer.bmp}
  {$R IconsDotNet\TIdRSH.bmp}
  {$R IconsDotNet\TIdRSHServer.bmp}
  {$R IconsDotNet\TIdSASL.bmp}
  {$R IconsDotNet\TIdSASLAnonymous.bmp}
  {$R IconsDotNet\TIdSASLCRAMMD5.bmp}
  {$R IconsDotNet\TIdSASLDigest.bmp}
  {$R IconsDotNet\TIdSASLExternal.bmp}
  {$R IconsDotNet\TIdSASLList.bmp}
  {$R IconsDotNet\TIdSASLLogin.bmp}
  {$R IconsDotNet\TIdSASLOTP.bmp}
  {$R IconsDotNet\TIdSASLPlain.bmp}
  {$R IconsDotNet\TIdSASLSKey.bmp}
  {$R IconsDotNet\TIdServerCompressionIntercept.bmp}
  {$R IconsDotNet\TIdServerInterceptLogEvent.bmp}
  {$R IconsDotNet\TIdServerInterceptLogFile.bmp}
  {$R IconsDotNet\TIdServerIOHandlerSocket.bmp}
  {$R IconsDotNet\TIdServerIOHandlerStream.bmp}
  {$IFDEF DOTNET_2_OR_ABOVE}
  {$R IconsDotNet\TIdSSLIOHandlerSocketNET.bmp}
  {$R IconsDotNet\TIdServerIOHandlerSSLNET.bmp}
  {$ENDIF}
  {$R IconsDotNet\TIdSMTP.bmp}
  {$R IconsDotNet\TIdSMTPRelay.bmp}
  {$R IconsDotNet\TIdSMTPServer.bmp}
  {$R IconsDotNet\TIdSNPP.bmp}
  {$R IconsDotNet\TIdSNTP.bmp}
  {$R IconsDotNet\TIdSocksServer.bmp}
  {$R IconsDotNet\TIdSysLog.bmp}
  {$R IconsDotNet\TIdSysLogMessage.bmp}
  {$R IconsDotNet\TIdSyslogServer.bmp}
  {$R IconsDotNet\TIdSystat.bmp}
  {$R IconsDotNet\TIdSystatServer.bmp}
  {$R IconsDotNet\TIdSystatUDP.bmp}
  {$R IconsDotNet\TIdSystatUDPServer.bmp}
  {$R IconsDotNet\TIdTelnet.bmp}
  {$R IconsDotNet\TIdTelnetServer.bmp}
  {$R IconsDotNet\TIdTime.bmp}
  {$R IconsDotNet\TIdTimeServer.bmp}
  {$R IconsDotNet\TIdTimeUDP.bmp}
  {$R IconsDotNet\TIdTimeUDPServer.bmp}
  {$R IconsDotNet\TIdTrivialFTP.bmp}
  {$R IconsDotNet\TIdTrivialFTPServer.bmp}
  {$R IconsDotNet\TIdUnixTime.bmp}
  {$R IconsDotNet\TIdUnixTimeServer.bmp}
  {$R IconsDotNet\TIdUnixTimeUDP.bmp}
  {$R IconsDotNet\TIdUnixTimeUDPServer.bmp}
  {$R IconsDotNet\TIdUserAccounts.bmp}
  {$R IconsDotNet\TIdUserManager.bmp}
  {$R IconsDotNet\TIdUserPassProvider.bmp}
  {$R IconsDotNet\TIdWebDav.bmp}
  {$R IconsDotNet\TIdVCard.bmp}
  {$R IconsDotNet\TIdWhois.bmp}
  {$R IconsDotNet\TIdWhoIsServer.bmp}

{$ELSE}
  {$IFNDEF FPC}
    {$IFDEF BORLAND}
    {$R IdRegister.dcr}
    {$ELSE}
    {$R IdRegisterCool.dcr}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

procedure Register;
begin
  {$IFNDEF FPC}
  RegisterComponents(RSRegIndyClients, [
   TIdDayTime,
   TIdDayTimeUDP,
   TIdDICT,
   TIdDNSResolver,
   TIdEcho,
   TIdEchoUDP,
   TIdFinger,
   TIdFSP,
   TIdFTP,
   TIdGopher,
   TIdHTTP,
   TIdIdent,
   TIdIMAP4,
   TIdIRC,
   TIdLPR,
   TIdNNTP,
   TIdPOP3,
   TIdQOTD,
   TIdQOTDUDP,
   TIdRexec,
   TIdRSH,
   TIdSMTP,
   TIdSMTPRelay,
   {$IFNDEF DOTNET}
   TIdSNMP,
   {$ENDIF}
   TIdSNPP,
   TIdSNTP,

   TIdSysLog,
   TIdSystat,
   TIdSystatUDP,
   TIdTelnet,
   TIdTime,
   TIdTimeUDP,
   TIdTrivialFTP,
   TIdUnixTime,
   TIdUnixTimeUDP,
   TIdWebDAV,
   TIdWhois]);

  RegisterComponents(RSRegIndyServers, [
   TIdChargenServer,
   TIdChargenUDPServer,
   TIdDayTimeServer,
   TIdDayTimeUDPServer,
   TIdDICTServer,
   TIdDISCARDServer,
   TIdDiscardUDPServer,
   TIdDNSServer,
   TIdECHOServer,
   TIdEchoUDPServer,
   TIdFingerServer,
   TIdFTPServer,
   TIdGopherServer,
   TIdHTTPProxyServer,
   TIdHTTPServer,
   TIdIdentServer,
   TIdIMAP4Server,
   TIdIRCServer,
   TIdMappedFTP,
   TIdMappedPOP3,
   TIdMappedPortTCP,
   TIdMappedPortUDP,
   TIdMappedTelnet,
   TIdNNTPServer,
   TIdPOP3Server,
   TIdQOTDServer,
   TIdQotdUDPServer,
   TIdRexecServer,
   TIdRSHServer,
   TIdSMTPServer,
   TIdSocksServer,
   TIdSyslogServer,
   TIdSystatServer,
   TIdSystatUDPServer,
   TIdTelnetServer,
   TIdTimeServer,
   TIdTimeUDPServer,
   TIdTrivialFTPServer,
   //TODO:  TIdTunnelMaster,
   //TODO: TIdTunnelSlave,
   TIdUnixTimeServer,
   TIdUnixTimeUDPServer,
   TIdWhoIsServer
   ]);

  RegisterComponents(RSRegIndyIntercepts, [
   TIdBlockCipherIntercept,
   TIdServerBlockCipherIntercept,
   {$IFDEF USE_ZLIB_UNIT}
   TIdCompressionIntercept,
   TIdServerCompressionIntercept,
    {$ENDIF}
   TIdServerInterceptLogEvent,
   TIdServerInterceptLogFile
   ]);

   {$IFDEF DOTNET_2_OR_ABOVE}
   RegisterComponents(RSRegIndyIOHandlers, [
    TIdSSLIOHandlerSocketNET,
    TIdServerIOHandlerSSLNET
   ]);
  {$ENDIF}
  {$IFDEF USE_OPENSSL}
  RegisterComponents(RSRegIndyIOHandlers, [
   TIdServerIOHandlerSSLOpenSSL,
   TIdSSLIOHandlerSocketOpenSSL
   ]);
  {$ENDIF}

  RegisterComponents(RSRegSASL, [
   TIdSASLAnonymous,
   TIdSASLCRAMMD5,
   TIdSASLCRAMSHA1,
   TIdSASLDigest,
   TIdSASLExternal,
   TIdSASLLogin,
   TIdSASLOTP,
   TIdSASLPlain,
   TIdSASLSKey,
   TIdUserPassProvider
   ]);

  RegisterComponents(RSRegIndyMisc, [
   TIdConnectThroughHttpProxy,
   {$IFNDEF DOTNET}
   TIdCompressorZLib,
   {$ENDIF}
   TIdCookieManager,
   TIdEncoderBinHex4,
   TIdEncoderMIME,
   TIdEncoderUUE,
   TIdEncoderXXE,
   TIdEncoderQuotedPrintable,
   {$IFNDEF DOTNET}
   TIdDateTimeStamp,
   {$ENDIF}
   TIdDecoderBinHex4,
   TIdDecoderMIME,
   TIdDecoderUUE,
   TIdDecoderXXE,
   TIdDecoderQuotedPrintable,
   TIdIPWatch,
   TIdIPAddrMon,
   TIdHL7,
   TIdMailBox,
   TIdMessage,
   TIdMessageDecoderMIME,
   TIdMessageEncoderMIME,
   TIdMessageDecoderYenc,
   TIdMessageEncoderYenc,
   TIdNetworkCalculator,
   TIdSysLogMessage,
   TIdUserManager,
   TIdVCard
   ]);

  {$ELSE}

  //FreePascal Lazarus Registration
  RegisterComponents(RSRegIndyClients+ RSProtam, [
   //
   TIdDayTime,
   TIdDayTimeUDP,
   TIdDICT,
   TIdDNSResolver,
   TIdEcho,
   TIdEchoUDP,
   TIdFinger,
   TIdFSP,
   TIdFTP,
   TIdGopher,
   TIdHTTP,
   TIdIdent,
   TIdIMAP4,
   TIdIRC,
   TIdLPR]);

  RegisterComponents(RSRegIndyClients+RSProtnz, [
   TIdNNTP,
   TIdPOP3,
   TIdQOTD,
   TIdQOTDUDP,
   TIdRexec,
   TIdRSH,
   TIdSMTP,
   TIdSMTPRelay,
   TIdSNMP,
   TIdSNPP,
   TIdSNTP,
   TIdSysLog,
   TIdSystat,
   TIdSystatUDP,
   TIdTelnet,
   TIdTime,
   TIdTimeUDP,
   TIdTrivialFTP,
   TIdUnixTime,
   TIdUnixTimeUDP,
   TIdWhois]);

  RegisterComponents(RSRegIndyServers+RSProtam, [
   TIdChargenServer,
   TIdChargenUDPServer,
   TIdDayTimeServer,
   TIdDayTimeUDPServer,
   TIdDICTServer,
   TIdDISCARDServer,
   TIdDiscardUDPServer,
   TIdDNSServer,
   TIdECHOServer,
   TIdEchoUDPServer,
   TIdFingerServer,
   TIdFTPServer,
   TIdGopherServer,
   TIdHTTPProxyServer,
   TIdHTTPServer,
   TIdIdentServer,
   TIdIMAP4Server,
   TIdIRCServer]);

  RegisterComponents(RSRegIndyServers+RSProtnz, [
   TIdNNTPServer,
   TIdPOP3Server,
   TIdQOTDServer,
   TIdQotdUDPServer,
   TIdRexecServer,
   TIdRSHServer,
   TIdSMTPServer,
   TIdSocksServer,
   TIdSyslogServer,
   TIdSystatServer,
   TIdSystatUDPServer,
   TIdTelnetServer,
   TIdTimeServer,
   TIdTimeUDPServer,
   TIdTrivialFTPServer,
   //TODO:  TIdTunnelMaster,
   //TODO: TIdTunnelSlave,
   TIdUnixTimeServer,
   TIdUnixTimeUDPServer,
   TIdWhoIsServer]);

  RegisterComponents(RSRegIndyServers+RSMappedPort,[
   TIdMappedFTP,
   TIdMappedPOP3,
   TIdMappedPortTCP,
   TIdMappedPortUDP,
   TIdMappedTelnet]);

  RegisterComponents(RSRegIndyIntercepts+RSProt, [
   {$IFDEF USE_ZLIB_UNIT}
   TIdCompressionIntercept,
   TIdServerCompressionIntercept,
   {$ENDIF}
   TIdBlockCipherIntercept,
   TIdServerBlockCipherIntercept,
   TIdServerInterceptLogEvent,
   TIdServerInterceptLogFile
   ]);

  RegisterComponents(RSRegSASL+RSProt, [
   TIdSASLAnonymous,
   TIdSASLCRAMMD5,
   TIdSASLDigest,
   TIdSASLExternal,
   TIdSASLLogin,
   TIdSASLOTP,
   TIdSASLPlain,
   TIdSASLSKey,
   TIdUserPassProvider
   ]);

  {$IFDEF USE_OPENSSL}
  RegisterComponents(RSRegIndyIOHandlers+RSProt, [
   TIdServerIOHandlerSSLOpenSSL,
   TIdSSLIOHandlerSocketOpenSSL
   ]);
  {$ENDIF}

  RegisterComponents(RSRegIndyMisc+RSProt, [
   TIdConnectThroughHttpProxy,
   {$IFDEF USE_ZLIB_UNIT}
   TIdCompressorZLib,
   {$ENDIF}
   TIdCookieManager,
   TIdDateTimeStamp,

   TIdIPWatch,
   TIdIPAddrMon,
   TIdHL7,
   TIdMailBox,
   TIdMessage,
   TIdNetworkCalculator,
   TIdSysLogMessage,
   TIdUserManager,
   TIdVCard
   ]);

  RegisterComponents(RSRegIndyMisc+RSProt + RSEncoder, [
   TIdEncoderMIME,
   TIdEncoderUUE,
   TIdEncoderXXE,
   TIdEncoderQuotedPrintable,
   TIdMessageEncoderMIME,
   TIdMessageEncoderYenc
   ]);

  RegisterComponents(RSRegIndyMisc+RSProt + RSDecoder, [
   TIdDecoderMIME,
   TIdDecoderUUE,
   TIdDecoderXXE,
   TIdDecoderQuotedPrintable,
    TIdMessageDecoderMIME,
    TIdMessageDecoderYenc
   ]);

  {$ENDIF}
end;

{$IFDEF FPC}
initialization
{$i IdRegister.lrs}
{$ENDIF}

end.
