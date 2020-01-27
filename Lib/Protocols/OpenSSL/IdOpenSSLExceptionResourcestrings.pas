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

unit IdOpenSSLExceptionResourcestrings;

interface

{$i IdCompilerDefines.inc}

resourcestring
  RIdOpenSSLSetExDataError = 'Failed to set ex data.';
  RIdOpenSSLGetExDataError = 'Failed to get ex data.';
  RIdOpenSSLSetCipherListError = 'Failed to set cipher list.';
  RIdOpenSSLSetCipherSuiteError = 'Failed to set cipher suites.';
  RIdOpenSSLSetVerifyLocationError = 'The processing at one of the locations specified failed.';
  RIdOpenSSLNewSSLCtxError = 'The creation of a new SSL_CTX object failed.';
  RIdOpenSSLNewSSLError = 'The creation of a new SSL structure failed.';
  RIdOpenSSLShutdownError = 'Failed to shutdown with result reason code %d.';

implementation

end.
