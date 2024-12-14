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
  Rev 1.11    1/9/2005 6:08:30 PM  JPMugaas
  New FSP Messages.

  Rev 1.10    24.08.2004 18:01:42  Andreas Hausladen
  Added AttachmentBlocked property to TIdAttachmentFile.

  Rev 1.9    7/29/2004 2:15:32 AM  JPMugaas
  New property for controlling what AUTH command is sent.  Fixed some minor
  issues with FTP properties.  Some were not set to defaults causing
  unpredictable results -- OOPS!!!

  Rev 1.8    7/28/2004 8:26:48 AM  JPMugaas
  Further work on the SMTP Server.  Not tested yet.

  Rev 1.7    7/16/2004 4:28:44 AM  JPMugaas
  CCC Support in TIdFTP to complement that capability in TIdFTPServer.

  Rev 1.6    7/13/2004 3:31:20 AM  JPMugaas
  Messages for a new FTP server feature, CCC.

  Rev 1.5    6/20/2004 8:17:20 PM  JPMugaas
  Message for FTP Deflate FXP.

  Rev 1.4    6/16/04 12:52:36 PM  RLebeau
  Changed wording of RSPOP3SvrInternalError

  Rev 1.2    3/2/2004 6:38:58 AM  JPMugaas
  Stuff for more comprehensive help in the FTP Server.

  Rev 1.1    2/3/2004 4:12:28 PM  JPMugaas
  Fixed up units so they should compile.

  Rev 1.0    2004.02.03 7:46:06 PM  czhower
  New names

  Rev 1.26    2/1/2004 4:47:50 AM  JPMugaas
  Resource strings from the MappedPort units.

  Rev 1.25    1/5/2004 11:53:32 PM  JPMugaas
  Some messages moved to resource strings.  Minor tweeks.  EIdException no
  longer raised.

  Rev 1.24    30/12/2003 23:27:22  CCostelloe
  Added RSIMAP4DisconnectedProbablyIdledOut

  Rev 1.23    11/28/2003 4:10:10 PM  JPMugaas
  RS for empty names in FTP upload.

  Rev 1.22    11/13/2003 5:44:38 PM  VVassiliev
  Add RSQueryInvalidIpV6 for DNSResolver

  Rev 1.21    10/20/2003 12:58:18 PM  JPMugaas
  Exception messages moved to RS.

    Rev 1.20    10/17/2003 1:15:26 AM  DSiders
  Added resource strings used in Message Client, HTTP, IMAP4.

  Rev 1.19    2003.10.14 1:28:00 PM  czhower
  DotNet

  Rev 1.18    10/9/2003 10:15:46 AM  JPMugaas
  FTP SSCN FXP Message.

  Rev 1.17    9/8/2003 02:24:36 AM  JPMugaas
  New message for custom FTP Proxy support.

    Rev 1.16    8/10/2003 11:05:22 AM  BGooijen
  fixed typo

  Rev 1.15    6/17/2003 03:14:38 PM  JPMugaas
  FTP Structured help message.

  Rev 1.14    6/17/2003 09:08:00 AM  JPMugaas
  Improved SITE HELP handling.

  Rev 1.13    10/6/2003 4:07:14 PM  SGrobety
  IdCoder3to4 addition for exception handling

  Rev 1.12    6/9/2003 05:14:54 AM  JPMugaas
  Fixed crical error.
  Supports HDR and OVER commands defined in
  http://www.ietf.org/internet-drafts/draft-ietf-nntpext-base-18.txt if feature
  negotiation indicates that they are supported.
  Added XHDR data parsing routine.
  Added events for when we receive a line of data with XOVER or XHDR as per
  John Jacobson's request.

  Rev 1.11    6/8/2003 02:59:26 AM  JPMugaas
  RFC 2449 and RFC 3206 support.

  Rev 1.10    5/22/2003 05:26:08 PM  JPMugaas
  RFC 2034

  Rev 1.9    5/19/2003 08:12:46 PM  JPMugaas
  Strings for IdPOP3Reply unit.

  Rev 1.8    5/8/2003 03:18:20 PM  JPMugaas
  Flattened ou the SASL authentication API, made a custom descendant of SASL
  enabled TIdMessageClient classes.

  Rev 1.7    5/8/2003 02:18:12 AM  JPMugaas
  Fixed an AV in IdPOP3 with SASL list on forms.  Made exceptions for SASL
  mechanisms missing more consistant, made IdPOP3 support feature feature
  negotiation, and consolidated some duplicate code.

  Rev 1.6    3/27/2003 05:46:44 AM  JPMugaas
  Updated framework with an event if the TLS negotiation command fails.
  Cleaned up some duplicate code in the clients.

  Rev 1.5    3/19/2003 02:42:18 AM  JPMugaas
  Added more strings for the SMTP server.

  Rev 1.4    3/17/2003 02:28:32 PM  JPMugaas
  Updated with some TLS strings.

  Rev 1.3    3/9/2003 02:11:48 PM  JPMugaas
  Removed server support for MODE B and MODE C.  It turns out that we do not
  support those modes properly.  We only implemented Stream mode.  We now
  simply return a 504 for modes we don't support instead of a 200 okay.  This
  was throwing off Opera 7.02.

  Rev 1.2    2/24/2003 07:55:16 PM  JPMugaas
  Added /bin/ls strings to make the server look mroe like Unix.

  Rev 1.1    2/16/2003 10:51:00 AM  JPMugaas
  Attempt to implement:

  http://www.ietf.org/internet-drafts/draft-ietf-ftpext-data-connection-assuranc
  e-00.txt

  Currently commented out because it does not work.

  Rev 1.0    11/13/2002 07:59:36 AM  JPMugaas
}

unit IdResourceStringsProtocols;

interface

resourcestring
  // General
  RSIOHandlerPropInvalid = 'IOHandler value is not valid';

  //FIPS
  RSFIPSAlgorithmNotAllowed = 'Algorithm %s not permitted in FIPS mode';
  //FSP
  RSFSPNotFound = 'File Not Found';
  RSFSPPacketTooSmall = 'Packet too small';

  //SASL
  RSSASLNotReady = 'The specified SASL handlers are not ready!!';
  RSSASLNotSupported = 'Doesn''t support AUTH or the specified SASL handlers!!';
  RSSASLRequired = 'Need SASL mechanisms to login with it!!';

  //TIdSASLDigest
  RSSASLDigestMissingAlgorithm = 'missing algorithm in challange.';
  RSSASLDigestInvalidAlgorithm = 'invalid algorithm in challange.';
  RSSASLDigestAuthConfNotSupported = 'auth-conf not yet supported.';

  //  TIdEMailAddress
  RSEMailSymbolOutsideAddress = '@ Outside address';

  //ZLIB Intercept
  RSZLCompressorInitializeFailure = 'Unable to initialize compressor';
  RSZLDecompressorInitializeFailure = 'Unable to initialize decompressor';
  RSZLCompressionError = 'Compression error';
  RSZLDecompressionError = 'Decompression error';

  //MIME Types
  RSMIMEExtensionEmpty = 'Extension is empty';
  RSMIMEMIMETypeEmpty = 'Mimetype is empty';
  RSMIMEMIMEExtAlreadyExists = 'Extension already exists';

  // IdRegister
  RSRegSASL = 'Indy SASL';

  // Status Strings
  // TIdTCPClient
  // Message Strings
  RSIdMessageCannotLoad = 'Cannot load message from file %s';

  // MessageClient Strings
  RSMsgClientEncodingText = 'Encoding text';
  RSMsgClientEncodingAttachment = 'Encoding attachment';
  RSMsgClientInvalidEncoding = 'Invalid Encoding. UU only allows Body and Attachments.';
  RSMsgClientInvalidForTransferEncoding = 'Message parts cannot be used in a message which has a ContentTransferEncoding value.';

  // NNTP Exceptions
  RSNNTPConnectionRefused = 'Connection explicitly refused by NNTP server.';
  RSNNTPStringListNotInitialized = 'Stringlist not initialized!';
  RSNNTPNoOnNewsgroupList = 'No OnNewsgroupList event has been defined.';
  RSNNTPNoOnNewGroupsList = 'No OnNewGroupsList event has been defined.';
  RSNNTPNoOnNewNewsList = 'No OnNewNewsList event has been defined.';
  RSNNTPNoOnXHDREntry = 'No OnXHDREntry event has been defined.';
  RSNNTPNoOnXOVER = 'No OnXOVER event has been defined.';

  // HTTP Status
  RSHTTPChunkStarted = 'Chunk Started';
  RSHTTPContinue = 'Continue';
  RSHTTPSwitchingProtocols = 'Switching protocols';
  RSHTTPProcessing = 'Processing';
  RSHTTPEarlyHints = 'Early Hints';
  RSHTTPOK = 'OK';
  RSHTTPCreated = 'Created';
  RSHTTPAccepted = 'Accepted';
  RSHTTPNonAuthoritativeInformation = 'Non-authoritative Information';
  RSHTTPNoContent = 'No Content';
  RSHTTPResetContent = 'Reset Content';
  RSHTTPPartialContent = 'Partial Content';
  RSHTTPMultiStatus = 'Multi-Status';
  RSHTTPAlreadyReported = 'Already Reported';
  RSHTTPIMUsed = 'IM Used';
  RSHTTPMultipleChoices = 'Multiple Choices';
  RSHTTPMovedPermanently = 'Moved Permanently';
  RSHTTPMovedTemporarily = 'Moved Temporarily';
  RSHTTPSeeOther = 'See Other';
  RSHTTPNotModified = 'Not Modified';
  RSHTTPUseProxy = 'Use Proxy';
  RSHTTPTemporaryRedirect = 'Temporary Redirect';
  RSHTTPPermanentRedirect = 'Permanent Redirect';
  RSHTTPBadRequest = 'Bad Request';
  RSHTTPUnauthorized = 'Unauthorized';
  RSHTTPPaymentRequired = 'Payment Required';
  RSHTTPForbidden = 'Forbidden';
  RSHTTPNotFound = 'Not Found';
  RSHTTPMethodNotAllowed = 'Method not allowed';
  RSHTTPNotAcceptable = 'Not Acceptable';
  RSHTTPProxyAuthenticationRequired = 'Proxy Authentication Required';
  RSHTTPRequestTimeout = 'Request Timeout';
  RSHTTPConflict = 'Conflict';
  RSHTTPGone = 'Gone';
  RSHTTPLengthRequired = 'Length Required';
  RSHTTPPreconditionFailed = 'Precondition Failed';
  RSHTTPPreconditionRequired = 'Precondition Required';
  RSHTTPTooManyRequests = 'Too Many Requests';
  RSHTTPRequestHeaderFieldsTooLarge = 'Request Header Fields Too Large';
  RSHTTPNetworkAuthenticationRequired = 'Network Authentication Required';
  RSHTTPRequestEntityTooLong = 'Request Entity Too Long';
  RSHTTPRequestURITooLong = 'Request-URI Too Long. 256 Chars max';
  RSHTTPUnsupportedMediaType = 'Unsupported Media Type';
  RSHTTPRangeNotSatisfiable = 'Range Not Satisfiable';
  RSHTTPExpectationFailed = 'Expectation Failed';
  RSHTTPMisdirectedRequest = 'Misdirected Request';
  RSHTTPUnprocessableContent = 'Unprocessable Content';
  RSHTTPLocked = 'Locked';
  RSHTTPFailedDependency = 'Failed Dependency';
  RSHTTPTooEarly = 'Too Early';
  RSHTTPUpgradeRequired = 'Upgrade Required';
  RSHTTPInternalServerError = 'Internal Server Error';
  RSHTTPNotImplemented = 'Not Implemented';
  RSHTTPBadGateway = 'Bad Gateway';
  RSHTTPServiceUnavailable = 'Service Unavailable';
  RSHTTPGatewayTimeout = 'Gateway timeout';
  RSHTTPHTTPVersionNotSupported = 'HTTP version not supported';
  RSHTTPVariantAlsoNegotiates = 'Variant Also Negotiates';
  RSHTTPInsufficientStorage = 'Insufficient Storage';
  RSHTTPLoopDetected = 'Loop Detected';
  RSHTTPNotExtended = 'Not Extended';
  RSHTTPUnknownResponseCode = 'Unknown Response Code';

  // HTTP Other
  RSHTTPUnknownProtocol = 'Unknown Protocol';
  RSHTTPMethodRequiresVersion = 'Request method requires HTTP version 1.1';
  RSHTTPHeaderAlreadyWritten = 'Header has already been written.';
  RSHTTPErrorParsingCommand = 'Error in parsing command.';
  RSHTTPUnsupportedAuthorisationScheme = 'Unsupported authorization scheme.';
  RSHTTPCannotSwitchSessionStateWhenActive = 'Cannot change session state when the server is active.';
  RSHTTPCannotSwitchSessionListWhenActive = 'Cannot change session list when the server is active.';
  RSHTTPCannotSwitchSessionIDCookieNameWhenActive = 'Cannot change session ID cookie name when the server is active.';

  //HTTP Authentication
  RSHTTPAuthAlreadyRegistered = 'This authentication method is already registered with class name %s.';

  //HTTP Authentication Digeest
  RSHTTPAuthInvalidHash = 'Unsupported hash algorithm. This implementation supports only MD5 encoding.';

  // HTTP Cookies
  RSHTTPUnknownCookieVersion = 'Unsupported cookie version: %d';

  //Block Cipher Intercept
  RSBlockIncorrectLength = 'Incorrect length in received block (%d)';

  // FTP
  RSFTPInvalidNumberArgs = 'Invalid number of arguments %s';
  RSFTPHostNotFound = 'Host not found.';
  RSFTPUnknownHost = 'Unknown';
  RSFTPStatusReady = 'Connection established';
  RSFTPStatusStartTransfer = 'Starting FTP transfer';
  RSFTPStatusDoneTransfer  = 'Transfer complete';
  RSFTPStatusAbortTransfer = 'Transfer aborted';
  RSFTPParamError = 'Error in parameters to %s';
  RSFTPParamNotImp = 'Parameter %s Not Implemented';
  RSFTPInvalidPort = 'Invalid port number';
  RSFTPInvalidIP = 'Invalid IP Address';
  RSFTPOnCustomFTPProxyReq = 'OnCustomFTPProxy required but not assigned';
  RSFTPDataConnAssuranceFailure = 'Data connection assurance check failed.'#10#13+
                                  'Server reported IP: %s  Port: %d'#10#13+
                                  'Our socket IP: %s  Port: %d';
  RSFTPProtocolNotSupported = 'Protocol not supported, use'; { may not include '(' or ')' }
  RSFTPMustUseExtWithIPv6 = 'UseExtensionDataPort must be true for IPv6 connections.';
  RSFTPMustUseExtWithNATFastTrack = 'UseExtensionDataPort must be true for NAT fasttracking.';
  RSFTPFTPPassiveMustBeTrueWithNATFT = 'Can not use active transfers with NAT fastracking.';
  RSFTPServerSentInvalidPort = 'Server sent invalid port number (%s)';
  RSInvalidFTPListingFormat = 'Unknown FTP listing format';
  RSFTPNoSToSWithNATFastTrack = 'No Site to Site transfers are permitted with a FTP NAT fastracked connection.';
  RSFTPSToSNoDataProtection = 'Can''t use dataprotection on site to site transfer.';
  RSFTPSToSProtosMustBeSame = 'Transport protocols must be the same.';
  RSFTPSToSSSCNNotSupported = 'SSCN is not supported on both servers.';
  RSFTPNoDataPortProtectionAfterCCC = 'Can not set DataPortProtection after CCC issued.';
  RSFTPNoDataPortProtectionWOEncryption = 'Can not set DataPortProtection with unencrypted connections.';
  RSFTPNoCCCWOEncryption = 'Can not set CCC without encyption.';
  RSFTPNoAUTHWOSSL = 'Can not set AUTH without SSL.';
  RSFTPNoAUTHCon = 'Can not set AUTH while connected.';
  RSFTPSToSTransferModesMusbtSame = 'Transfer modes must be the same.';
  RSFTPNoListParseUnitsRegistered = 'No FTP list parsers have been registered.';
  RSFTPMissingCompressor = 'No Compressor is assigned.';
  RSFTPCompressorNotReady = 'Compressor is not ready.';
  RSFTPUnsupportedTransferMode = 'Unsupported transfer mode.';
  RSFTPUnsupportedTransferType = 'Unsupported transfer type.';

  // Property editor exceptions
  // Stack Error Messages

  RSCMDNotRecognized = 'command not recognized';

  RSGopherNotGopherPlus = '%s is not a Gopher+ server';

  RSCodeNoError     = 'RCode NO Error';
  RSCodeQueryServer = 'DNS Server Reports Query Server Error';
  RSCodeQueryFormat = 'DNS Server Reports Query Format Error';
  RSCodeQueryName   = 'DNS Server Reports Query Name Error';
  RSCodeQueryNotImplemented = 'DNS Server Reports Query Not Implemented Error';
  RSCodeQueryQueryRefused = 'DNS Server Reports Query Refused Error';
  RSCodeQueryUnknownError = 'Server Returned Unknown Error';

  RSDNSTimeout = 'TimedOut';
  RSDNSMFIsObsolete = 'MF is an Obsolete Command. USE MX.';
  RSDNSMDISObsolete = 'MD is an Obsolete Command. Use MX.';
  RSDNSMailAObsolete = 'MailA is an Obsolete Command. USE MX.';
  RSDNSMailBNotImplemented = '-Err 501 MailB is not implemented';

  RSQueryInvalidQueryCount = 'Invalid Query Count %d';
  RSQueryInvalidPacketSize = 'Invalid Packet Size %d';
  RSQueryLessThanFour = 'Received Packet is too small. Less than 4 bytes. %d';
  RSQueryInvalidHeaderID = 'Invalid Header Id %d';
  RSQueryLessThanTwelve = 'Received Packet is too small. Less than 12 bytes. %d';
  RSQueryPackReceivedTooSmall = 'Received Packet is too small. %d';
  RSQueryUnknownError = 'Unknown Error %d, Id %d';
  RSQueryInvalidIpV6 = 'Invalid IP V6 Address. %s';
  RSQueryMustProvideSOARecord = 'You have to provide a TIdRR_SOA object with Serial number and Name to progress IXFR. %d';
 
  { LPD Client Logging event strings }
  RSLPDDataFileSaved = 'Data file saved to %s';
  RSLPDControlFileSaved = 'Control file save to %s';
  RSLPDDirectoryDoesNotExist = 'Directory %s does not exist';
  RSLPDServerStartTitle = 'Winshoes LPD Server %s ';
  RSLPDServerActive = 'Server status: active';
  RSLPDQueueStatus  = 'Queue %s status: %s';
  RSLPDClosingConnection = 'closing connection';
  RSLPDUnknownQueue = 'Unknown queue %s';
  RSLPDConnectTo = 'connected with %s';
  RSLPDAbortJob = 'abort job';
  RSLPDReceiveControlFile = 'Receive control file';
  RSLPDReceiveDataFile = 'Receive data file';

  { LPD Exception Messages }
  RSLPDNoQueuesDefined = 'Error: no queues defined';

  { Trivial FTP Exception Messages }
  RSTimeOut = 'Timeout';
  RSTFTPUnexpectedOp = 'Unexpected operation from %s:%d';
  RSTFTPUnsupportedTrxMode = 'Unsupported transfer mode: "%s"';
  RSTFTPDiskFull = 'Unable to complete write request, progress halted at %d bytes';
  RSTFTPFileNotFound = 'Unable to open %s';
  RSTFTPAccessDenied = 'Access to %s denied';
  RSTFTPUnsupportedOption = 'Unsupported option: "%s"';
  RSTFTPUnsupportedOptionValue = 'Unsupported value "%s" for option: "%s"';

  { MESSAGE Exception messages }
  RSTIdTextInvalidCount = 'Invalid Text count. Must have more than 1 TIdText object.';
  RSTIdMessagePartCreate = 'TIdMessagePart can not be created.  Use descendant classes. ';
  RSTIdMessageErrorSavingAttachment = 'Error saving attachment.';
  RSTIdMessageErrorAttachmentBlocked = 'Attachment %s is blocked.';

  { POP Exception Messages }
  RSPOP3FieldNotSpecified = ' not specified';
  RSPOP3UnrecognizedPOP3ResponseHeader = 'Unrecognized POP3 Response Header:'#10'"%s"'; //APR: user will see Server response    {Do not Localize}
  RSPOP3ServerDoNotSupportAPOP = 'Server do not support APOP (no timestamp)';//APR    {Do not Localize}

  { IdIMAP4 Exception Messages }
  RSIMAP4ConnectionStateError = 'Unable to execute command, wrong connection state;' +
                                 'Current connection state: %s.';
  RSUnrecognizedIMAP4ResponseHeader = 'Unrecognized IMAP4 Response Header.';
  RSIMAP4NumberInvalid = 'Number parameter (relative message number or UID) is invalid; Must be 1 or greater.';
  RSIMAP4NumberInvalidString = 'Number parameter (relative message number or UID) is invalid; Cannot contain an empty string.';
  RSIMAP4NumberInvalidDigits = 'Number parameter (relative message number or UID) is invalid; Cannot contain non-digit characters.';
  RSIMAP4DisconnectedProbablyIdledOut = 'Server has gracefully disconnected you, possibly because the connection was idle for too long.';

  { IdIMAP4 UTF encoding error strings}
  RSIMAP4UTFIllegalChar = 'Illegal char #%d in UTF7 sequence.';

  RSIMAP4UTFIllegalBitShifting = 'Illegal bit shifting in MUTF7 string';
  RSIMAP4UTFUSASCIIInUTF = 'US-ASCII char #%d in UTF7 sequence.';
  { IdIMAP4 Connection State strings }
  RSIMAP4ConnectionStateAny = 'Any';
  RSIMAP4ConnectionStateNonAuthenticated = 'Non Authenticated';
  RSIMAP4ConnectionStateAuthenticated = 'Authenticated';
  RSIMAP4ConnectionStateSelected = 'Selected';
  RSIMAP4ConnectionStateUnexpectedlyDisconnected = 'Unexpectedly Disconnected';

  { Telnet Server }
  RSTELNETSRVUsernamePrompt = 'Username: ';
  RSTELNETSRVPasswordPrompt = 'Password: ';
  RSTELNETSRVInvalidLogin = 'Invalid Login.';
  RSTELNETSRVMaxloginAttempt = 'Allowed login attempts exceeded, good bye.';
  RSTELNETSRVNoAuthHandler = 'No authentication handler has been specified.';
  RSTELNETSRVWelcomeString = 'Indy Telnet Server';
  RSTELNETSRVOnDataAvailableIsNil = 'OnDataAvailable event is nil.';

  { Telnet Client }
  RSTELNETCLIConnectError = 'server not responding';
  RSTELNETCLIReadError = 'Server did not respond.';

  { Network Calculator }
  RSNETCALInvalidIPString     = 'The string %s does not translate into a valid IP.';
  RSNETCALCInvalidNetworkMask = 'Invalid network mask.';
  RSNETCALCInvalidValueLength = 'Invalid value length: Should be 32.';
  RSNETCALConfirmLongIPList = 'There is too many IP addresses in the specified range (%d) to be displayed at design time.';
  { IdentClient}
  RSIdentReplyTimeout = 'Reply Timed Out:  The server did not return a response and the query has been abandoned';
  RSIdentInvalidPort = 'Invalid Port:  The foreign or local port is not specified correctly or invalid';
  RSIdentNoUser = 'No User:  Port pair is not used or not used by an identifiable user';
  RSIdentHiddenUser = 'Hidden User:  Information was not returned at a user''s request';
  RSIdentUnknownError = 'Unknown or other error: Can not determine owner, other error, or the error can not be revealed.';

  {Standard dialog stock strings}
  {}

  { Tunnel messages }
  RSTunnelGetByteRange = 'Call to %s.GetByte [property Bytes] with index <> [0..%d]';
  RSTunnelTransformErrorBS = 'Error in transformation before send';
  RSTunnelTransformError = 'Transform failed';
  RSTunnelCRCFailed = 'CRC Failed';
  RSTunnelConnectMsg = 'Connecting';
  RSTunnelDisconnectMsg = 'Disconnect';
  RSTunnelConnectToMasterFailed = 'Cannt connect to the Master server';
  RSTunnelDontAllowConnections = 'Do not allow connctions now';
  RSTunnelMessageTypeError = 'Message type recognition error';
  RSTunnelMessageHandlingError = 'Message handling failed';
  RSTunnelMessageInterpretError = 'Interpretation of message failed';
  RSTunnelMessageCustomInterpretError = 'Custom message interpretation failed';

  { Socks messages }

  { FTP }
  RSDestinationFileAlreadyExists = 'Destination file already exists.';

  { SSL messages }
  RSSSLAcceptError = 'Error accepting connection with SSL.';
  RSSSLConnectError = 'Error connecting with SSL.';
  RSSSLSettingCipherError = 'SetCipher failed.';
  RSSSLCreatingSessionError = 'Error creating SSL session.';
  RSSSLCreatingContextError = 'Error creating SSL context.';
  RSSSLLoadingRootCertError = 'Could not load root certificate.';
  RSSSLLoadingCertError = 'Could not load certificate.';
  RSSSLLoadingKeyError = 'Could not load key, check password.';
  RSSSLLoadingDHParamsError = 'Could not load DH Parameters.';
  RSSSLGetMethodError = 'Error getting SSL method.';
  RSSSLFDSetError = 'Error setting File Descriptor for SSL';
  RSSSLDataBindingError = 'Error binding data to SSL socket.';
  RSSSLEOFViolation = 'EOF was observed that violates the protocol';
  RSSSLSettingTLSHostNameError = 'Error setting TLS hostname for SSL socket';

  {IdMessage Component Editor}
  RSMsgCmpEdtrNew = '&New Message Part...';
  RSMsgCmpEdtrExtraHead = 'Extra Headers Text Editor';
  RSMsgCmpEdtrBodyText = 'Body Text Editor';

  {IdNNTPServer}
  RSNNTPServerNotRecognized = 'Command not recognized';
  RSNNTPServerGoodBye = 'Goodbye';
  RSNNTPSvrImplicitTLSRequiresSSL = 'Implicit NNTP requires that IOHandler be set to a TIdSSLIOHandlerSocketBase.';
  RSNNTPRetreivedArticleFollows = ' article retrieved - head and body follow';
  RSNNTPRetreivedBodyFollows = ' article retrieved - body follows';
  RSNNTPRetreivedHeaderFollows =  ' article retrieved - head follows';
  RSNNTPRetreivedAStaticstsOnly = ' article retrieved - statistics only';
  RSNTTPNewsToMeSendArticle = 'News to me!  <CRLF.CRLF> to end.';
  RSNTTPArticleRetrievedRequestTextSeparately = ' article retrieved - request text separately';
  RSNTTPNotInNewsgroup = 'Not currently in newsgroup';
  RSNNTPExtSupported = 'Extensions supported:';
  
  //IdNNTPServer reply messages
  RSNTTPReplyHelpTextFollows = 'help text follows';
  RSNTTPReplyDebugOutput =  'debug output';
   
  RSNNTPReplySvrReadyPostingAllowed =  'server ready - posting allowed';
  RSNNTPReplySvrReadyNoPostingAllowed =  'server ready - no posting allowed';
  RSNNTPReplySlaveStatus =  'slave status noted';
  RSNNTPReplyClosingGoodby = 'closing connection - goodbye!';
  RSNNTPReplyNewsgroupsFollow = 'list of newsgroups follows';
  RSNNTPReplyHeadersFollow =  'Headers follow';
  RSNNTPReplyOverViewInfoFollows =  'Overview information follows';
  RSNNTPReplyNewNewsgroupsFollow =  'list of new newsgroups follows';
  RSNNTPReplyArticleTransferedOk =  'article transferred ok';
  RSNNTPReplyArticlePostedOk =  'article posted ok';
  RSNNTPReplyAuthAccepted = 'Authentication accepted';

  RSNNTPReplySendArtTransfer = 'send article to be transferred. End with <CR-LF>.<CR-LF>';
  RSNNTPReplySendArtPost =  'send article to be posted. End with <CR-LF>.<CR-LF>';
  RSNNTPReplyMoreAuthRequired = 'More authentication information required';
  RSNNTPReplyContinueTLSNegot = 'Continue with TLS negotiation';

  RSNNTPReplyServiceDiscont =  'service discontinued';
  RSNNTPReplyTLSTempUnavail =  'TLS temporarily not available';
  RSNNTPReplyNoSuchNewsgroup =  'no such news group';
  RSNNTPReplyNoNewsgroupSel =  'no newsgroup has been selected';
  RSNNTPReplyNoArticleSel =  'no current article has been selected';
  RSNNTPReplyNoNextArt =  'no next article in this group';
  RSNNTPReplyNoPrevArt =  'no previous article in this group';
  RSNNTPReplyNoArtNumber =  'no such article number in this group';
  RSNNTPReplyNoArtFound =  'no such article found';
  RSNNTPReplyArtNotWanted =  'article not wanted - do not send it';
  RSNNTPReplyTransferFailed =  'transfer failed - try again later';
  RSNNTPReplyArtRejected =  'article rejected - do not try again.';
  RSNNTPReplyNoPosting =  'posting not allowed';
  RSNNTPReplyPostingFailed =  'posting failed';
  RSNNTPReplyAuthorizationRequired =  'Authorization required for this command';
  RSNNTPReplyAuthorizationRejected = 'Authorization rejected';
  RSNNTPReplyAuthRejected =  'Authentication required';
  RSNNTPReplyStrongEncryptionRequired =  'Strong encryption layer is required';

  RSNNTPReplyCommandNotRec =  'command not recognized';
  RSNNTPReplyCommandSyntax =  'command syntax error';
  RSNNTPReplyPermDenied =  'access restriction or permission denied';
  RSNNTPReplyProgramFault = 'program fault - command not performed';
  RSNNTPReplySecAlreadyActive =  'Security layer already active';

  {IdGopherServer}
  RSGopherServerNoProgramCode = 'Error: No program code to return request!';

  {IdSyslog}
  RSInvalidSyslogPRI = 'Invalid syslog message: incorrect PRI section';
  RSInvalidSyslogPRINumber = 'Invalid syslog message: incorrect PRI number "%s"';
  RSInvalidSyslogTimeStamp = 'Invalid syslog message: incorrect timestamp "%s"';
  RSInvalidSyslogPacketSize = 'Invalid Syslog message: packet too large (%d bytes)';
  RSInvalidHostName = 'Invalid host name. A SYSLOG host name cannot contain any space ("%s")+';

  {IdWinsockStack}
  RSWSockStack = 'Winsock stack';

  {IdSMTPServer}
  RSSMTPSvrCmdNotRecognized = 'Command Not Recognised';
  RSSMTPSvrQuit = 'Signing Off';
  RSSMTPSvrOk   = 'Ok';
  RSSMTPSvrStartData = 'Start mail input; end with <CRLF>.<CRLF>';
  RSSMTPSvrAddressOk = '%s Address Okay';
  RSSMTPSvrAddressError = '%s Address Error';
  RSSMTPSvrNotPermitted = '%s Sender Not Permitted';
    // !!!YES!!! - do not relay for third parties - otherwise you have a server
    //waiting to be abused by some spammer.
  RSSMTPSvrNoRelay = 'We do not relay %s';
  RSSMTPSvrWelcome = 'Welcome to the INDY SMTP Server';
  RSSMTPSvrHello = 'Hello %s';
  RSSMTPSvrNoHello = 'Polite people say HELO';
  RSSMTPSvrCmdGeneralError = 'Syntax Error - Command not understood: %s';
  RSSMTPSvrXServer = 'Indy SMTP Server';
  RSSMTPSvrReceivedHeader = 'by DNSName [127.0.0.1] running Indy SMTP';
  RSSMTPSvrAuthFailed = 'Authentication Failed';
  RSSMTPSvrAddressWillForward = '%s User not local, Will forward';
  RSSMTPSvrReqSTARTTLS = 'Must issue a STARTTLS command first';
  RSSMTPSvrParmErrMailFrom = 'Parameter error! Example: mail from:<user@domain.com>';
  RSSMTPSvrParmErrRcptTo = 'Command parameter error! Example: rcpt to:<a@b.c>';
  RSSMTPSvrParmErr = 'Syntax error in parameters or arguments';
  RSSMTPSvrParmErrNoneAllowed = 'Syntax error (no parameters allowed)';
  RSSMTPSvrReadyForTLS = 'Ready to start TLS';
  RSSMTPSvrCmdErrSecurity = 'Command refused due to lack of security'; // errorcode 554
  RSSMTPSvrImplicitTLSRequiresSSL = 'Implicit SMTP TLS requires that IOHandler be set to a TIdServerIOHandlerSSL.';
  RSSMTPSvrBadSequence = 'Bad sequence of commands';
  RSSMTPNotLoggedIn = 'Not logged in';
  RSSMTPMailboxUnavailable = 'Requested action not taken: mailbox unavailable';
  RSSMTPUserNotLocal = 'User %s not local; please try <%s>';
  RSSMTPUserNotLocalNoAddr = 'User %s not local; no forwarding address';
  RSSMTPUserNotLocalFwdAddr = 'User %s not local; will forward to <%s>';
  RSSMTPTooManyRecipients = 'Too Many recipients.';
  RSSMTPAccountDisabled = '%s Account Disabled';
  RSSMTPLocalProcessingError = 'Local Processing Error';
  RSSMTPNoOnRcptTo = 'No OnRcptTo event';
  //data command error replies
  RSSMTPSvrExceededStorageAlloc = 'Requested mail action aborted: exceeded storage allocation';
  RSSMTPSvrMailBoxNameNotAllowed = 'Requested action not taken: mailbox name not allowed';
  RSSMTPSvrTransactionFailed = ' Transaction failed';
  RSSMTPSvrLocalError = 'Requested action aborted: local error in processing';
  RSSMTPSvrInsufficientSysStorage = 'Requested action not taken: insufficient system storage ';
  RSSMTPMsgLenLimit = 'Message length exceeds administrative limit';
  // SPF replies
  RSSMTPSvrSPFCheckFailed = 'SPF %s check failed';
  RSSMTPSvrSPFCheckError = 'SPF %s check error';

  { IdPOP3Server }
  RSPOP3SvrImplicitTLSRequiresSSL = 'Implicit POP3 requires that IOHandler be set to a TIdServerIOHandlerSSL.';
  RSPOP3SvrMustUseSTLS = 'Must use STLS';
  RSPOP3SvrNotHandled = 'Command Not Handled: %s';
  RSPOP3SvrNotPermittedWithTLS = 'Command not permitted when TLS active';
  RSPOP3SvrNotInThisState = 'Command not permitted in this state';
  RSPOP3SvrBeginTLSNegotiation = 'Begin TLS negotiation';
  RSPOP3SvrLoginFirst = 'Please login first';
  RSPOP3SvrInvalidSyntax = 'Invalid Syntax';
  RSPOP3SvrClosingConnection = 'Closing Connection Channel.';
  RSPOP3SvrPasswordRequired = 'Password required';
  RSPOP3SvrLoginFailed = 'Login failed';
  RSPOP3SvrLoginOk = 'Login OK';
  RSPOP3SvrWrongState = 'Wrong State';
  RSPOP3SvrInvalidMsgNo = 'Invalid Message Number';
  RSPOP3SvrNoOp = 'NOOP';
  RSPOP3SvrReset = 'Reset';
  RSPOP3SvrCapaList = 'Capability list follows';
  RSPOP3SvrWelcome = 'Welcome to Indy POP3 Server';
  RSPOP3SvrUnknownCmd = 'Sorry, Unknown Command';
  RSPOP3SvrUnknownCmdFmt = 'Sorry, Unknown Command: %s';
  RSPOP3SvrInternalError = 'Unknown Internal Error';
  RSPOP3SvrHelpFollows = 'Help follows';
  RSPOP3SvrTooManyCons = 'Too many connections. Try again later.';
  RSPOP3SvrWelcomeAPOP = 'Welcome ';

  // TIdCoder3to4
  RSUnevenSizeInDecodeStream = 'Uneven size in DecodeToStream.';
  RSUnevenSizeInEncodeStream = 'Uneven size in Encode.';
  RSIllegalCharInInputString = 'Illegal character in input string.';

  // TIdMessageCoder
  RSMessageDecoderNotFound = 'Message decoder not found';
  RSMessageEncoderNotFound = 'Message encoder not found';

  // TIdMessageCoderMIME
  RSMessageCoderMIMEUnrecognizedContentTrasnferEncoding = 'Unrecognized content trasnfer encoding.';

  // TIdMessageCoderUUE
  RSUnrecognizedUUEEncodingScheme = 'Unrecognized UUE encoding scheme.';

  { IdFTPServer }
  RSFTPDefaultGreeting = 'Indy FTP Server ready.';
  RSFTPOpenDataConn = 'Data connection already open; transfer starting.';
  RSFTPDataConnToOpen = 'File status okay; about to open data connection.';
  RSFTPDataConnList = 'Opening ASCII mode data connection for /bin/ls.';
  RSFTPDataConnNList = 'Opening ASCII mode data connection for file list.';
  RSFTPDataConnMLst = 'Opening ASCII data connection for directory listing';
  RSFTPCmdSuccessful = '%s Command successful.';
  RSFTPServiceOpen = 'Service ready for new user.';
  RSFTPServerClosed = 'Service closing control connection.';
  RSFTPDataConn = 'Data connection open; no transfer in progress.';
  RSFTPDataConnClosed = 'Closing data connection.';
  RSFTPDataConnEPLFClosed = 'Success.';
  RSFTPDataConnClosedAbnormally = 'Data connection closed abnormally.';
  RSFTPPassiveMode = 'Entering Passive Mode (%s).';
  RSFTPUserLogged = 'User logged in, proceed.';
  RSFTPAnonymousUserLogged = 'Anonymous user logged in, proceed.';
  RSFTPFileActionCompleted = 'Requested file action okay, completed.';
  RSFTPDirFileCreated = '"%s" created.';
  RSFTPUserOkay = 'User name okay, need password.';
  RSFTPAnonymousUserOkay = 'Anonymous login OK, send e-mail as password.';
  RSFTPNeedLoginWithUser = 'Login with USER first.';
  RSFTPNotAfterAuthentication = 'Not in authorization state, already logged in.';
  RSFTPFileActionPending = 'Requested file action pending further information.';
  RSFTPServiceNotAvailable = 'Service not available, closing control connection.';
  RSFTPCantOpenDataConn = 'Can''t open data connection.';
  RSFTPFileActionNotTaken = 'Requested file action not taken.';
  RSFTPFileActionAborted = 'Requested action aborted: local error in processing.';
  RSFTPEnteringEPSV = 'Entering Extended Passive Mode (%s)';
  RSFTPClosingConnection = 'Service not available, closing control connection.';
  RSFTPPORTDisabled = 'PORT/EPRT Command disabled.';
  RSFTPPORTRange    = 'PORT/EPRT Command disabled for reserved port range (1-1024).';
  RSFTPSameIPAddress = 'Data port can only be used by the same IP address used by the control connection.';
  RSFTPCantOpenData = 'Can''t open data connection.';
  RSFTPEPSVAllEntered = ' EPSV ALL sent, now only accepting EPSV connections';
  RSFTPNetProtNotSup = 'Network protocol not supported, use (%s)';
  RSFTPFileOpSuccess = 'File Operation Successful';
  RSFTPIsAFile = '%s: Is a file.';
  RSFTPInvalidOps = 'Invalid %s options';
  RSFTPOptNotRecog = 'Option not recognized.';
  RSFTPPropNotNeg = 'Property can not be a negative number.';
  RSFTPClntNoted = 'Noted.';
  RSFTPQuitGoodby = 'Goodbye.';
  RSFTPPASVBoundPortMaxMustBeGreater = 'PASVBoundPortMax must be greater than PASVBoundPortMax.';
  RSFTPPASVBoundPortMinMustBeLess = 'PASVBoundPortMin must be less than PASVBoundPortMax.';
  RSFTPRequestedActionNotTaken = 'Requested action not taken.';
  RSFTPCmdNotRecognized = '''%s'': command not understood.';
  RSFTPCmdNotImplemented = '"%s" Command not implemented.';
  RSFTPCmdHelpNotKnown = 'Unknown command %s.';
  RSFTPUserNotLoggedIn = 'Not logged in.';
  RSFTPActionNotTaken = 'Requested action not taken.';
  RSFTPActionAborted = 'Requested action aborted: page type unknown.';
  RSFTPRequestedFileActionAborted = 'Requested file action aborted.';
  RSFTPRequestedFileActionNotTaken = 'Requested action not taken.';
  RSFTPMaxConnections = 'Maximum connections limit exceeded. Try again later.';
  RSFTPDataConnToOpenStou = 'About to open data connection for %s';
  RSFTPNeedAccountForLogin = 'Need account for login.';
  RSFTPAuthSSL = 'AUTH Command OK. Initializing SSL';
  RSFTPDataProtBuffer0 = 'PBSZ Command OK. Protection buffer size set to 0.';
  RSFTPDeniedForPolicyReasons = 'Request denied for policy reasons.';

  RSFTPInvalidProtTypeForMechanism = 'Requested PROT level not supported by mechanism.';
  RSFTPProtTypeClear   = 'PROT Command OK. Using Clear data connection';
  RSFTPProtTypePrivate = 'PROT Command OK. Using Private data connection';
  RSFTPClearCommandConnection = 'Command channel switched to clear-text.';
  RSFTPClearCommandNotPermitted = 'Clear command channel is not permitted.';
  RSFTPPBSZAuthDataRequired = 'AUTH Data required.';
  RSFTPPBSZNotAfterCCC = 'Not permitted after CCC';
  RSFTPPROTProtBufRequired = 'PBSZ Data Buffer Size required.';
  RSFTPInvalidForParam = 'Command not implemented for that parameter.';
  RSFTPNotAllowedAfterEPSVAll = '%s not allowed after EPSV ALL';

  RSFTPOTPMethod = 'Unknown OTP method';
  RSFTPIOHandlerWrong = 'IOHandler is of wrong type.';
  RSFTPFileNameCanNotBeEmpty = 'The destination filename can not be empty';

  //Note to translators, it may be best to leave the stuff in quotes as the very first
  //part of any phrase otherwise, a FTP client might get confused.
  RSFTPCurrentDirectoryIs = '"%s" is working directory.';
  RSFTPTYPEChanged = 'Type set to %s.';
  RSFTPMODEChanged = 'Mode set to %s.';
  RSFTPMODENotSupported = 'Unimplemented mode.';
  RSFTPSTRUChanged = 'Structure set to %s.';
  RSFTPSITECmdsSupported = 'The following SITE commands are supported:';
  RSFTPDirectorySTRU = '%s directory structure.';
  RSFTPCmdStartOfStat = 'System status';
  RSFTPCmdEndOfStat = 'End of Status';
  RSFTPCmdExtsSupportedStart = 'Extensions supported:';
  RSFTPCmdExtsSupportedEnd = 'End of extentions.';
  RSFTPNoOnDirEvent = 'No OnListDirectory event found!';
  RSFTPImplicitTLSRequiresSSL = 'Implicit FTP requires that IOHandler be set to a TIdServerIOHandlerSSL.';

  //%s number of attributes changes
  RSFTPSiteATTRIBMsg = 'site attrib';
  RSFTPSiteATTRIBInvalid = ' failed, invalid attribute.';
  RSFTPSiteATTRIBDone = ' done, total %s attributes changed.';
  //%s is the umask number
  RSFTPUMaskIs = 'Current UMASK is %.3d';
  //first %d is the new value, second one is the old value
  RSFTPUMaskSet = 'UMASK set to %.3d (was %.3d)';
  RSFTPPermissionDenied = 'Permission denied.';
  RSFTPCHMODSuccessful = 'CHMOD command successful.';
  RSFTPHelpBegining = 'The following commands are recognized (* => unimplemented, + => extension).';
  //toggles for DIRSTYLE SITE command in IIS
  RSFTPOn = 'on';
  RSFTPOff = 'off';
  RSFTPDirStyle = 'MSDOS-like directory output is %s';

  {SYSLog Message}
  // facility
  STR_SYSLOG_FACILITY_KERNEL     = 'kernel messages';
  STR_SYSLOG_FACILITY_USER       = 'user-level messages';
  STR_SYSLOG_FACILITY_MAIL       = 'mail system';
  STR_SYSLOG_FACILITY_SYS_DAEMON = 'system daemons';
  STR_SYSLOG_FACILITY_SECURITY1  = 'security/authorization messages (1)';
  STR_SYSLOG_FACILITY_INTERNAL   = 'messages generated internally by syslogd';
  STR_SYSLOG_FACILITY_LPR        = 'line printer subsystem';
  STR_SYSLOG_FACILITY_NNTP       = 'network news subsystem';
  STR_SYSLOG_FACILITY_UUCP       = 'UUCP subsystem';
  STR_SYSLOG_FACILITY_CLOCK1     = 'clock daemon (1)';
  STR_SYSLOG_FACILITY_SECURITY2  = 'security/authorization messages (2)';
  STR_SYSLOG_FACILITY_FTP        = 'FTP daemon';
  STR_SYSLOG_FACILITY_NTP        = 'NTP subsystem';
  STR_SYSLOG_FACILITY_AUDIT      = 'log audit';
  STR_SYSLOG_FACILITY_ALERT      = 'log alert';
  STR_SYSLOG_FACILITY_CLOCK2     = 'clock daemon (2)';
  STR_SYSLOG_FACILITY_LOCAL0     = 'local use 0  (local0)';
  STR_SYSLOG_FACILITY_LOCAL1     = 'local use 1  (local1)';
  STR_SYSLOG_FACILITY_LOCAL2     = 'local use 2  (local2)';
  STR_SYSLOG_FACILITY_LOCAL3     = 'local use 3  (local3)';
  STR_SYSLOG_FACILITY_LOCAL4     = 'local use 4  (local4)';
  STR_SYSLOG_FACILITY_LOCAL5     = 'local use 5  (local5)';
  STR_SYSLOG_FACILITY_LOCAL6     = 'local use 6  (local6)';
  STR_SYSLOG_FACILITY_LOCAL7     = 'local use 7  (local7)';
  STR_SYSLOG_FACILITY_UNKNOWN    = 'Unknown or illegale facility code';

  // Severity
  STR_SYSLOG_SEVERITY_EMERGENCY     = 'Emergency: system is unusable';
  STR_SYSLOG_SEVERITY_ALERT         = 'Alert: action must be taken immediately';
  STR_SYSLOG_SEVERITY_CRITICAL      = 'Critical: critical conditions';
  STR_SYSLOG_SEVERITY_ERROR         = 'Error: error conditions';
  STR_SYSLOG_SEVERITY_WARNING       = 'Warning: warning conditions';
  STR_SYSLOG_SEVERITY_NOTICE        = 'Notice: normal but significant condition';
  STR_SYSLOG_SEVERITY_INFORMATIONAL = 'Informational: informational messages';
  STR_SYSLOG_SEVERITY_DEBUG         = 'Debug: debug-level messages';
  STR_SYSLOG_SEVERITY_UNKNOWN       = 'Unknown or illegale security code';

  {LPR Messages}
  RSLPRError = 'Reply %d on Job ID %s';
  RSLPRUnknown = 'Unknown';
  RSCannotBindRange = 'Cannot bind to a LPR port from range %d to %d (No free Port)';

  {IRC Messages}
  RSIRCCanNotConnect = 'IRC Connect Failed';
  // RSIRCNotConnected = 'Not connected to server.';
  // RSIRCClientVersion =  'TIdIRC 1.061 by Steve Williams';
  // RSIRCClientInfo = '%s Non-visual component for 32-bit Delphi.';
  // RSIRCNick = 'Nick';
  // RSIRCAltNick = 'OtherNick';
  // RSIRCUserName = 'ircuser';
  // RSIRCRealName = 'Real name';
  // RSIRCTimeIsNow = 'Local time is %s'; // difficult to strip for clients

  {HL7 Lower Layer Protocol Messages}
  RSHL7StatusStopped           = 'Stopped';
  RSHL7StatusNotConnected      = 'Not Connected';
  RSHL7StatusFailedToStart     = 'Failed to Start: %s';
  RSHL7StatusFailedToStop      = 'Failed to Stop: %s';
  RSHL7StatusConnected         = 'Connected';
  RSHL7StatusConnecting        = 'Connecting';
  RSHL7StatusReConnect         = 'Reconnect at %s: %s';
  RSHL7StatusTimedOut          = 'Timed out waiting for a message';
  RSHL7NotWhileWorking         = 'You cannot set %s while the HL7 Component is working';
  RSHL7NotWorking              = 'Attempt to %s while the HL7 Component is not working';
  RSHL7NotFailedToStop         = 'Interface is unusable due to failure to stop';
  RSHL7AlreadyStarted          = 'Interface was already started';
  RSHL7AlreadyStopped          = 'Interface was already stopped';
  RSHL7ModeNotSet              = 'Mode is not initialised';
  RSHL7NoAsynEvent             = 'Component is in Asynchronous mode but OnMessageArrive has not been hooked';
  RSHL7NoSynEvent              = 'Component is in Synchronous mode but  OnMessageReceive has not been hooked';
  RSHL7InvalidPort             = 'Assigned Port value %d is invalid';
  RSHL7ImpossibleMessage       = 'A message has been received but the commication mode is unknown';
  RSHL7UnexpectedMessage       = 'Unexpected message arrived to an interface that is not listening';
  RSHL7UnknownMode             = 'Unknown mode';
  RSHL7ClientThreadNotStopped  = 'Unable to stop client thread';
  RSHL7SendMessage             = 'Send a message';
  RSHL7NoConnectionFound       = 'Server Connection not locatable when sending message';
  RSHL7WaitForAnswer           = 'You cannot send a message while you are still waiting for an answer';
  //TIdHL7 error messages
  RSHL7ErrInternalsrNone       = 'Internal error in IdHL7.pas: SynchronousSend returned srNone';
  RSHL7ErrNotConn              = 'Not connected';
  RSHL7ErrInternalsrSent       = 'Internal error in IdHL7.pas: SynchronousSend returned srSent';
  RSHL7ErrNoResponse           = 'No response from remote system';
  RSHL7ErrInternalUnknownVal   = 'Internal error in IdHL7.pas: SynchronousSend returned an unknown value %d';
  RSHL7Broken                  = 'IdHL7 is broken in Indy 10 for the present';

  { TIdMultipartFormDataStream exceptions }
  RSMFDInvalidObjectType        = 'Unsupported object type. You can assign only one of the following types or their descendants: TStrings, TStream.';
  RSMFDInvalidTransfer          = 'Unsupported transfer type. You can assign only an empty string or one of the following values: 7bit, 8bit, binary, quoted-printable, base64.';
  RSMFDInvalidEncoding          = 'Unsupported encoding. You can assign only one of the following values: Q, B, 8.';

  { TIdURI exceptions }
  RSURINoProto                 = 'Protocol field is empty';
  RSURINoHost                  = 'Host field is empty';

  { TIdIOHandlerThrottle}
  RSIHTChainedNotAssigned      = 'You must chain this component to another I/O Handler before using it';

  { TIdSNPP}
  RSSNPPNoMultiLine            = 'TIdSNPP Mess command only supports single line Messages.';

  {TIdThread}
  RSUnassignedUserPassProv     = 'Unassigned UserPassProvider!';

  {TIdDirectSMTP}
  RSDirSMTPInvalidEMailAddress = 'Invalid Email Address %s';
  RSDirSMTPNoMXRecordsForDomain = 'No MX records for the domain %s';
  RSDirSMTPCantConnectToSMTPSvr = 'Can not connect to MX servers for address %s';
  RSDirSMTPCantAssignHost       = 'Can not assign Host property, it is resolved by IdDirectSMTP on the fly.';

  {TIdMessageCoderYenc}
  RSYencFileCorrupted           = 'File corrupted.';
  RSYencInvalidSize             = 'Invalid Size';
  RSYencInvalidCRC              = 'Invalid CRC';

  {TIdSocksServer}
  RSSocksSvrNotSupported        = 'Not supported';
  RSSocksSvrInvalidLogin        = 'Invalid Login';
  RSSocksSvrWrongATYP           = 'Wrong SOCKS5-ATYP';
  RSSocksSvrWrongSocksVersion   = 'Wrong SOCKS-version';
  RSSocksSvrWrongSocksCommand   = 'Wrong SOCKS-Command';
  RSSocksSvrAccessDenied        = 'Access Denied';
  RSSocksSvrUnexpectedClose     = 'Unexpected Close';
  RSSocksSvrPeerMismatch        = 'Peer IP mismatch';

  {TLS Framework}
  RSTLSSSLIOHandlerRequired = 'SSL IOHandler is required for this setting';
  RSTLSSSLCanNotSetWhileActive = 'This value can not be set while the server is active.';
  RSTLSSLCanNotSetWhileConnected = 'This value can not be set while the client is connected.';
  RSTLSSLSSLNotAvailable = 'SSL is not available on this server.';
  RSTLSSLSSLCmdFailed = 'Start SSL negotiation command failed.';
  RSTLSSLSSLHandshakeFailed = 'SSL negotiation failed.';

  ///IdPOP3Reply
  //user's provided reply will follow this string
  RSPOP3ReplyInvalidEnhancedCode = 'Invalid Enhanced Code: ';

  //IdSMTPReply
  RSSMTPReplyInvalidReplyStr = 'Invalid Reply String.';
  RSSMTPReplyInvalidClass = 'Invalid Reply Class.';

  RSUnsupportedOperation = 'Unsupported operation.';

  //Mapped port components
  RSEmptyHost = 'Host is empty';    {Do not Localize}
  RSPop3ProxyGreeting = 'POP3 proxy ready';    {Do not Localize}
  RSPop3UnknownCommand = 'command must be either USER or QUIT';    {Do not Localize}
  RSPop3QuitMsg = 'POP3 proxy signing off';    {Do not Localize}

  //IMAP4 Server
  RSIMAP4SvrBeginTLSNegotiation = 'Begin TLS negotiation now';
  RSIMAP4SvrNotPermittedWithTLS = 'Command not permitted when TLS active';
  RSIMAP4SvrImplicitTLSRequiresSSL = 'Implicit IMAP4 requires that IOHandler be set to a TIdServerIOHandlerSSLBase.';

  // OTP Calculator
  RSFTPFSysErrMsg = 'Permission Denied';
  RSOTPUnknownMethod = 'Unknown OTP method';

  // Message Header Encoding
  RSHeaderEncodeError = 'Could not encode header data using charset "%s"';
  RSHeaderDecodeError = 'Could not decode header data using charset "%s"';

  // message builder strings
  rsHtmlViewerNeeded = 'An HTML viewer is required to see this message';
  rsRtfViewerNeeded = 'An RTF viewer is required to see this message';

  // HTTP Web Broker Bridge strings
  RSWBBInvalidIdxGetDateVariable = 'Invalid Index %s in TIdHTTPAppResponse.GetDateVariable';
  RSWBBInvalidIdxSetDateVariable = 'Invalid Index %s in TIdHTTPAppResponse.SetDateVariable';
  RSWBBInvalidIdxGetIntVariable = 'Invalid Index %s in TIdHTTPAppResponse.GetIntegerVariable';
  RSWBBInvalidIdxSetIntVariable = 'Invalid Index %s in TIdHTTPAppResponse.SetIntegerVariable';
  RSWBBInvalidIdxGetStrVariable = 'Invalid Index %s in TIdHTTPAppResponse.GetStringVariable';
  RSWBBInvalidStringVar = 'TIdHTTPAppResponse.SetStringVariable: Cannot set the version';
  RSWBBInvalidIdxSetStringVar = 'Invalid Index %s in TIdHTTPAppResponse.SetStringVariable';

  RSHMACHashNotAvailable = 'HMAC hash algorithm "%s" is not available';

implementation

end.
