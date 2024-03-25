{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}
unit IdResourceStringsOpenSSL;

interface

resourcestring
  {IdOpenSSL}
  RSOSSFailedToLoad = 'Failed to load %s.';
  RSOSSFailedToLoad_WithErrCode = 'Failed to load %s (error #%d).';
  RSOSSMissingExport_WithErrCode = '%s (error #%d)';
  RSOSSUnsupportedVersion = 'Unsupported SSL Library version: %.8x.';
  RSOSSUnsupportedLibrary = 'Unsupported SSL Library: %s.';
  RSOSSLModeNotSet = 'Mode has not been set.';
  RSOSSLCouldNotLoadSSLLibrary = 'Could not load SSL library.';
  RSOSSLStatusString = 'SSL status: "%s"';
  RSOSSLConnectionDropped = 'SSL connection has dropped.';
  RSOSSLCertificateLookup = 'SSL certificate request error.';
  RSOSSLInternal = 'SSL library internal error.';
  ROSSLCantGetSSLVersionNo = 'Unable to determine SSL Library Version number';
  ROSSLAPIFunctionNotPresent = 'OpenSSL API Function/Procedure %s not found in SSL Library';
  ROSUnrecognisedLibName = 'Unrecognised SSL Library name (%s)';
  ROSCertificateNotAddedToStore = 'Unable to add X.509 Certificate to cert store';
  ROSUnsupported = 'Not Supported';
  //callback where strings
  RSOSSLAlert =  '%s Alert';
  RSOSSLReadAlert =  '%s Read Alert';
  RSOSSLWriteAlert =  '%s Write Alert';
  RSOSSLAcceptLoop = 'Accept Loop';
  RSOSSLAcceptError = 'Accept Error';
  RSOSSLAcceptFailed = 'Accept Failed';
  RSOSSLAcceptExit =  'Accept Exit';
  RSOSSLConnectLoop =  'Connect Loop';
  RSOSSLConnectError = 'Connect Error';
  RSOSSLConnectFailed = 'Connect Failed';
  RSOSSLConnectExit =  'Connect Exit';
  RSOSSLHandshakeStart = 'Handshake Start';
  RSOSSLHandshakeDone =  'Handshake Done';
  RSOSSLProcLoadErrorHdr = 'The following functions were not loaded';
  {IdSSLOpenSSLFIPS}
  RSOSSLEVPDigestExError = 'EVP_DigestInit_ex error';
  RSOSSLEVPDigestUpdateError = 'EVP_DigestUpdate error';

implementation

end.
