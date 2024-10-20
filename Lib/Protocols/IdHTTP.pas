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
  Rev 1.65    3/5/2005 3:33:52 PM  JPMugaas
  Fix for some compiler warnings having to do with TStream.Read being platform
  specific.  This was fixed by changing the Compressor API to use TIdStreamVCL
  instead of TStream.  I also made appropriate adjustments to other units for
  this.

    Rev 1.64    2/13/2005 3:09:20 PM  DSiders
  Modified TIdCustomHTTP.PrepareRequest to free the local URI instance if an
  exception occurs in the method. (try...finally)

  Rev 1.63    2/11/05 11:29:34 AM  RLebeau
  Removed compiler warning

  Rev 1.62    2/9/05 2:12:08 AM  RLebeau
  Fixes for Compiler errors

  Rev 1.61    2/8/05 6:43:42 PM  RLebeau
  Added OnHeaderAvailable event

  Rev 1.60    1/11/05 1:25:08 AM  RLebeau
  More changes to SetHostAndPort()

  Rev 1.59    1/6/05 2:28:52 PM  RLebeau
  Fix for SetHostAndPort() not using its local variables properly

  Rev 1.58    06/01/2005 22:23:04  CCostelloe
  Bug fix (typo, gizp instead of gzip)

  Rev 1.57    05/12/2004 23:10:58  CCostelloe
  Recoded fix to suit Delphi < 7

  Rev 1.56    30/11/2004 23:46:12  CCostelloe
  Bug fix for SSL connections giving a "Connection closed gracefully" exception
  and requested page not getting returned (IOHandler.Response is empty)

  Rev 1.55    25/11/2004 21:28:06  CCostelloe
  Bug fix for POSTing fields that have the same name

  Rev 1.54    10/26/2004 10:13:24 PM  JPMugaas
  Updated refs.

  Rev 1.53    7/16/04 1:19:20 AM  RLebeau
  Fix for compiler error

  Rev 1.52    7/15/04 8:19:30 PM  RLebeau
  Updated TIdHTTPProtocol.ProcessResponse() to treat 302 redirects like 303.

  Updated TIdHTTPProtocol.BuildAndSendRequest() to use a try...except block

    Rev 1.51    6/17/2004 8:30:04 AM  DSiders
  TIdCustomHTTP modified:
  - Fixed error in AuthRetries property reading wrong member var.
  - Added AuthProxyRetries and MaxAuthRetries properties to public interface.

  TIdHTTP modified to publish AuthRetries, AuthProxyRetries, and MaxAuthRetries.

  TIdHTTPProtocol.ProcessResponse modified to use public properties
  AuthRetries, AuthProxyRetries, and MaxAutrhRetries.

  Rev 1.50    2004.05.20 11:36:46 AM  czhower
  IdStreamVCL

  Rev 1.49    4/28/04 1:45:26 PM  RLebeau
  Updated TIdCustomHTTP.SetRequestParams() to strip off the trailing CRLF
  before encoding rather than afterwards

  Rev 1.48    2004.04.07 11:18:08 PM  czhower
  Bug and naming fix.

  Rev 1.47    7/4/2004 6:00:02 PM  SGrobety
  Reformatted to match project guidelines

  Rev 1.46    7/4/2004 4:58:24 PM  SGrobety
  Reformatted to match project guidelines

  Rev 1.45    6/4/2004 5:16:40 PM  SGrobety
  Added AMaxHeaderCount: integer parameter to TIdHTTPProtocol.RetrieveHeaders
  and MaxHeaderLines property to TIdCustomHTTP (default to 255)

  Rev 1.44    2004.03.06 10:39:52 PM  czhower
  Removed duplicate code

  Rev 1.43    2004.03.06 8:56:30 PM  czhower
  -Change to disconnect
  -Addition of DisconnectNotifyPeer
  -WriteHeader now write bufers

  Rev 1.42    3/3/2004 5:58:00 AM  JPMugaas
  Some IFDEF excluses were removed because the functionality is now in DotNET.

  Rev 1.41    2004.02.23 9:33:12 PM  czhower
  Now can optionally ignore response codes for exceptions.

  Rev 1.40    2/15/2004 6:34:02 AM  JPMugaas
  Fix for where I broke the HTTP client with a parameter change in the GZip
  decompress method.

  Rev 1.39    2004.02.03 5:43:44 PM  czhower
  Name changes

  Rev 1.38    2004.02.03 2:12:10 PM  czhower
  $I path change

  Rev 1.37    2004.01.27 11:41:18 PM  czhower
  Removed const arguments

  Rev 1.35    24/01/2004 19:22:34  CCostelloe
  Cleaned up warnings

  Rev 1.34    2004.01.22 5:29:02 PM  czhower
  TextIsSame

  Rev 1.33    2004.01.21 1:04:50 PM  czhower
  InitComponenet

  Rev 1.32    1/2/2004 11:41:48 AM  BGooijen
  Enabled IPv6 support

  Rev 1.31    22/11/2003 12:04:28 AM  GGrieve
  Add support for HTTP status code 303

  Rev 1.30    10/25/2003 06:51:58 AM  JPMugaas
  Updated for new API changes and tried to restore some functionality.

  Rev 1.29    2003.10.24 10:43:08 AM  czhower
  TIdSTream to dos

  Rev 1.28    24/10/2003 10:58:40 AM  SGrobety
  Made authentication work even if no OnAnthenticate envent handler present

  Rev 1.27    10/18/2003 1:53:10 PM  BGooijen
  Added include

    Rev 1.26    10/17/2003 12:08:48 AM  DSiders
  Added localization comments.

  Rev 1.25    2003.10.14 1:27:52 PM  czhower
  DotNet

  Rev 1.24    10/7/2003 11:33:54 PM  GGrieve
  Get works under DotNet

  Rev 1.23    10/7/2003 10:07:04 PM  GGrieve
  Get HTTP compiling for DotNet

  Rev 1.22    10/4/2003 9:15:58 PM  GGrieve
  fix to compile

  Rev 1.21    9/26/2003 01:41:48 PM  JPMugaas
  Fix for problem wihere "identity" was being added more than once to the
  accepted encoding contents.

  Rev 1.20    9/14/2003 07:54:20 PM  JPMugaas
  Published the Compressor property.

  Rev 1.19    7/30/2003 05:34:22 AM  JPMugaas
  Fix for bug where decompression was not done if the Content Length was
  specified.  I found that at http://www.news.com.
  Added Identity to the content encoding to be consistant with Opera.  Identity
  is the default Accept-Encoding (RFC 2616).

    Rev 1.18    7/13/2003 10:57:28 PM  BGooijen
  Fixed GZip and Deflate decoding

  Rev 1.17    7/13/2003 11:29:06 AM  JPMugaas
  Made sure some GZIP decompression stub code is in IdHTTP.

  Rev 1.15    10.7.2003 ã. 21:03:02  DBondzhev
  Fixed NTML proxy authorization

  Rev 1.14    6/19/2003 02:36:56 PM  JPMugaas
  Removed a connected check and it seems to work better that way.

  Rev 1.13    6/5/2003 04:53:54 AM  JPMugaas
  Reworkings and minor changes for new Reply exception framework.

  Rev 1.12    4/30/2003 01:47:24 PM  JPMugaas
  Added TODO concerning a ConnectTimeout.

    Rev 1.11    4/2/2003 3:18:30 PM  BGooijen
  fixed av when retrieving an url when no iohandler was assigned

    Rev 1.10    3/26/2003 5:13:40 PM  BGooijen
  TIdSSLIOHandlerSocketBase.URIToCheck is now set

  Rev 1.9    3/13/2003 11:05:26 AM  JPMugaas
  Now should work with 3rd party vendor SSL IOHandlers.

    Rev 1.8    3/11/2003 10:14:52 PM  BGooijen
  Undid the stripping of the CR

    Rev 1.7    2/27/2003 2:04:26 PM  BGooijen
  If any call to iohandler.readln returns a CR at the end, it is removed now.

    Rev 1.6    2/26/2003 11:50:08 AM  BGooijen
  things were messed up in TIdHTTPProtocol.RetrieveHeaders, because the call to
  readln doesn't strip the CR at the end (terminator=LF), therefore the end of
  the header was not found.

    Rev 1.5    2/26/2003 11:42:46 AM  BGooijen
  changed ReadLn (IOerror 6) to IOHandler.ReadLn

    Rev 1.4    2/4/2003 6:30:44 PM  BGooijen
  Re-enabled SSL-support

  Rev 1.3    1/17/2003 04:14:42 PM  JPMugaas
  Fixed warnings.

  Rev 1.2    12/7/2002 05:32:16 PM  JPMugaas
  Now compiles with destination removed.

  Rev 1.1    12/6/2002 05:29:52 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 07:54:12 AM  JPMugaas

2001-Nov Nick Panteleeff
 - Authentication and POST parameter extentsions

2001-Sept Doychin Bondzhev
 - New internal design and new Authentication procedures.
 - Bug fixes and new features in few other supporting components

2001-Jul-7 Doychin Bondzhev
 - new property AllowCookie
 - There is no more ExtraHeders property in Request/Response. Raw headers is used for that purpose.

2001-Jul-1 Doychin Bondzhev
 - SSL support is up again - Thanks to Gregor

2001-Jun-17 Doychin Bondzhev
 - New unit IdHTTPHeaderInfo.pas that contains the
   TIdHeaderInfo(TIdEntytiHeaderInfo, TIdRequestHeaderInfo and TIdResponseHeaderInfo)
 - Still in development and not verry well tested
   By default when there is no authorization object associated with HTTP compoenet and there is user name and password
   HTTP component creates and instance of TIdBasicAuthentication class. This behaivor is for both web server and proxy server
   authorizations

2001-Apr-17 Doychin Bondzhev
 - Added OnProxyAuthorization event. This event is called on 407 response from the HTTP Proxy.
 - Added 2 new properties in TIdHeaderInfo
    property AuthenticationScheme: TIdAuthenticationScheme - this property contains information for authentication scheme
      requested by the web server
    property ProxyAuthenticationScheme: TIdAuthenticationScheme - this property contains information for authentication scheme
      requested by the proxy server
 - Now the component authomaticly reconginizes the requested authorization scheme and it supports Basic like before and has been
   extend to support Digest authorization

2001-Mar-31 Doychin Bondzhev
 - If there is no CookieManager it does not support cookies.

2001-Feb-18 Doychin Bondzhev
 - Added OnAuthorization event. This event is called on 401 response from the HTTP server.
     This can be used to ask the user program to supply user name and password in order to acces
     the requested resource

2001-Feb-02 Doychin Bondzhev
 - Added Cookie support and relative paths on redirect

2000-Jul-25 Hadi Hariri
 - Overloaded POst and moved clearing to disconect.

2000-June-22 Hadi Hariri
  - Added Proxy support.

2000-June-10 Hadi Hariri
  - Added Chunk-Encoding support and HTTP version number. Some additional
    improvements.

2000-May-23 J. Peter Mugaas
  -added redirect capability and supporting properties.  Redirect is optional
   and is set with HandleRedirects.  Redirection is limited to RedirectMaximum
   to prevent stack overflow due to recursion and to prevent redirects between
   two places which would cause this to go on to infinity.

2000-May-22 J. Peter Mugaas
  -adjusted code for servers which returned LF instead of EOL
  -Headers are now retreived before an exception is raised.  This
   also facilitates server redirection where the server tells the client to
   get a document from another location.

2000-May-01 Hadi Hariri
  -Converted to Mercury

2000-May-01 Hadi Hariri
  -Added PostFromStream and some clean up

2000-Apr-10 Hadi Hariri
  -Re-done quite a few things and fixed GET bugs and finished POST method.

2000-Jan-13 MTL
  -Moved to the New Palette Scheme

2000-Jan-08 MTL
  -Cleaned up a few compiler hints during 7.038 build

1999-Dec-10 Hadi Hariri
  -Started.
}

unit IdHTTP;

{
  Implementation of the HTTP protcol as specified in RFC 2616, 2109, 2965.
  (See NOTE below for details of what is exactly implemented)

  Author: Hadi Hariri (hadi@urusoft.com)
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

  Initials: Hadi Hariri - HH
}
{
  TODO:  Figure out what to do with ConnectTimeout.
  Ideally, that should be in the core and is not the same as a read Timeout.
}

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdException, IdExceptionCore, IdAssignedNumbers, IdHeaderList, IdHTTPHeaderInfo, IdReplyRFC,
  IdSSL, IdZLibCompressorBase,
  IdTCPClient, IdURI, IdCookie, IdCookieManager, IdAuthentication, IdAuthenticationManager,
  IdMultipartFormData, IdGlobal, IdBaseComponent, IdUriUtils;

type
  // TO DOCUMENTATION TEAM
  // ------------------------
  // For internal use. No need of documentation
  // hmConnect - Used to connect trought CERN proxy to SSL enabled sites.
  TIdHTTPMethod = string;

const
  Id_HTTPMethodHead = 'HEAD';
  Id_HTTPMethodGet = 'GET';
  Id_HTTPMethodPost = 'POST';
  Id_HTTPMethodOptions = 'OPTIONS';
  Id_HTTPMethodTrace = 'TRACE';
  Id_HTTPMethodPut = 'PUT';
  Id_HTTPMethodDelete = 'DELETE';
  Id_HTTPMethodConnect = 'CONNECT';
  Id_HTTPMethodPatch = 'PATCH';
  //(hmHead, hmGet, hmPost, hmOptions, hmTrace, hmPut, hmDelete, hmConnect, hmPatch);

type
  TIdHTTPWhatsNext = (wnGoToURL, wnJustExit, wnDontKnow, wnReadAndGo, wnAuthRequest);
  TIdHTTPConnectionType = (ctNormal, ctSSL, ctProxy, ctSSLProxy);

  // Protocol options
  TIdHTTPOption = (hoInProcessAuth, hoKeepOrigProtocol, hoForceEncodeParams,
    hoNonSSLProxyUseConnectVerb, hoNoParseMetaHTTPEquiv, hoWaitForUnexpectedData,
    hoTreat302Like303, hoNoProtocolErrorException, hoNoReadMultipartMIME,
    hoNoParseXmlCharset, hoWantProtocolErrorContent, hoNoReadChunked
    );

  TIdHTTPOptions = set of TIdHTTPOption;

  // Must be documented
  TIdHTTPProtocolVersion = (pv1_0, pv1_1);

  TIdHTTPOnRedirectEvent = procedure(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: TIdHTTPMethod) of object;
  TIdHTTPOnHeadersAvailable = procedure(Sender: TObject; AHeaders: TIdHeaderList; var VContinue: Boolean) of object;
  TIdOnSelectAuthorization = procedure(Sender: TObject; var AuthenticationClass: TIdAuthenticationClass; AuthInfo: TIdHeaderList) of object;
  TIdOnAuthorization = procedure(Sender: TObject; Authentication: TIdAuthentication; var Handled: Boolean) of object;
  // TIdProxyOnAuthorization = procedure(Sender: TObject; Authentication: TIdAuthentication; var Handled: boolean) of object;
  TIdOnChunkReceived = procedure(Sender : TObject; var Chunk: TIdBytes) of object;

const
  Id_TIdHTTP_ProtocolVersion = pv1_1;
  Id_TIdHTTP_RedirectMax = 15;
  Id_TIdHTTP_MaxHeaderLines = 255;
  Id_TIdHTTP_HandleRedirects = False;
  Id_TIdHTTP_MaxAuthRetries = 3;

type
  TIdCustomHTTP = class;

  // TO DOCUMENTATION TEAM
  // ------------------------
  // The following classes are used internally and no need of documentation
  // Only TIdHTTP must be documented
  //
  TIdHTTPResponse = class(TIdResponseHeaderInfo)
  protected
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FHTTP: TIdCustomHTTP;
    FResponseCode: Integer;
    FResponseText: string;
    FKeepAlive: Boolean;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FContentStream: TStream;
    FResponseVersion: TIdHTTPProtocolVersion;
    FMetaHTTPEquiv :  TIdMetaHTTPEquiv;
    //
    function GetKeepAlive: Boolean;
    function GetResponseCode: Integer;

    procedure SetResponseText(const AValue: String);
    procedure ProcessMetaHTTPEquiv;
  public
    constructor Create(AHTTP: TIdCustomHTTP); reintroduce; virtual;
    destructor Destroy; override;
    procedure Clear; override;
    property KeepAlive: Boolean read GetKeepAlive write FKeepAlive;
    property MetaHTTPEquiv:  TIdMetaHTTPEquiv read FMetaHTTPEquiv;
    property ResponseText: string read FResponseText write SetResponseText;
    property ResponseCode: Integer read GetResponseCode write FResponseCode;
    property ResponseVersion: TIdHTTPProtocolVersion read FResponseVersion write FResponseVersion;
    property ContentStream: TStream read FContentStream write FContentStream;
  end;

  TIdHTTPRequest = class(TIdRequestHeaderInfo)
  protected
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FHTTP: TIdCustomHTTP;
    FURL: string;
    FMethod: TIdHTTPMethod;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FSourceStream: TStream;
    FUseProxy: TIdHTTPConnectionType;
    FIPVersion: TIdIPVersion;
    FDestination: string;
  public
    constructor Create(AHTTP: TIdCustomHTTP); reintroduce; virtual;
    property URL: string read FURL write FURL;
    property Method: TIdHTTPMethod read FMethod write FMethod;
    property Source: TStream read FSourceStream write FSourceStream;
    property UseProxy: TIdHTTPConnectionType read FUseProxy;
    property IPVersion: TIdIPVersion read FIPVersion write FIPVersion;
    property Destination: string read FDestination write FDestination;
  end;

  TIdHTTPProtocol = class(TObject)
  protected
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FHTTP: TIdCustomHTTP;
    FRequest: TIdHTTPRequest;
    FResponse: TIdHTTPResponse;
  public
    constructor Create(AConnection: TIdCustomHTTP);
    destructor Destroy; override;
    function ProcessResponse(AIgnoreReplies: array of Int16): TIdHTTPWhatsNext;
    procedure BuildAndSendRequest(AURI: TIdURI);
    procedure RetrieveHeaders(AMaxHeaderCount: integer);
    //
    property Request: TIdHTTPRequest read FRequest;
    property Response: TIdHTTPResponse read FResponse;
  end;

  TIdCustomHTTP = class(TIdTCPClientCustom)
  protected
    {Retries counter for WWW authorization}
    FAuthRetries: Integer;
    {Retries counter for proxy authorization}
    FAuthProxyRetries: Integer;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FCookieManager: TIdCookieManager;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FCompressor : TIdZLibCompressorBase;
    FImplicitCookieManager: Boolean;
    {Max retries for authorization}
    FMaxAuthRetries: Integer;
    FMaxHeaderLines: integer;
    FAllowCookies: Boolean;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FAuthenticationManager: TIdAuthenticationManager;
    FProtocolVersion: TIdHTTPProtocolVersion;

    {this is an internal counter for redirects}
    FRedirectCount: Integer;
    FRedirectMax: Integer;
    FHandleRedirects: Boolean;
    FOptions: TIdHTTPOptions;
    FURI: TIdURI;
    FHTTPProto: TIdHTTPProtocol;
    FProxyParameters: TIdProxyConnectionInfo;
    //
    FOnHeadersAvailable: TIdHTTPOnHeadersAvailable;
    FOnRedirect: TIdHTTPOnRedirectEvent;
    FOnSelectAuthorization: TIdOnSelectAuthorization;
    FOnSelectProxyAuthorization: TIdOnSelectAuthorization;
    FOnAuthorization: TIdOnAuthorization;
    FOnProxyAuthorization: TIdOnAuthorization;
    FOnChunkReceived: TIdOnChunkReceived;
    //
{
    procedure SetHost(const Value: string); override;
    procedure SetPort(const Value: integer); override;
}
    procedure DoRequest(const AMethod: TIdHTTPMethod; AURL: string;
      ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16); virtual;
    function CreateProtocol: TIdHTTPProtocol; virtual;
    procedure InitComponent; override;
    function InternalReadLn: String;
    procedure SetAuthenticationManager(Value: TIdAuthenticationManager);
    procedure SetCookieManager(ACookieManager: TIdCookieManager);
    procedure SetAllowCookies(AValue: Boolean);
    function GetResponseCode: Integer;
    function GetResponseText: string;
    function DoOnAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean; virtual;
    function DoOnProxyAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean; virtual;
    function DoOnRedirect(var Location: string; var VMethod: TIdHTTPMethod; RedirectCount: integer): boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ProcessCookies(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
    function SetHostAndPort: TIdHTTPConnectionType;
    procedure SetCookies(AURL: TIdURI; ARequest: TIdHTTPRequest);
    procedure ReadResult(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
    procedure PrepareRequest(ARequest: TIdHTTPRequest);
    procedure ConnectToHost(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
    function GetResponse: TIdHTTPResponse;
    function GetRequest: TIdHTTPRequest;
    function GetMetaHTTPEquiv: TIdMetaHTTPEquiv;
    procedure SetRequest(Value: TIdHTTPRequest);
    procedure SetProxyParams(AValue: TIdProxyConnectionInfo);

    function SetRequestParams(ASource: TStrings; AByteEncoding: IIdTextEncoding
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding{$ENDIF}
      ): string;

    procedure CheckAndConnect(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
    procedure DoOnDisconnected; override;
  public
    destructor Destroy; override;

    procedure Delete(AURL: string; AResponseContent: TStream); overload;
    function Delete(AURL: string
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;

    procedure Options(AURL: string; AResponseContent: TStream); overload;
    function Options(AURL: string
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;

    procedure Get(AURL: string; AResponseContent: TStream); overload;
    procedure Get(AURL: string; AResponseContent: TStream; AIgnoreReplies: array of Int16); overload;
    function Get(AURL: string
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    function Get(AURL: string; AIgnoreReplies: array of Int16
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;

    procedure Trace(AURL: string; AResponseContent: TStream); overload;
    function Trace(AURL: string
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    procedure Head(AURL: string);

    function Post(AURL: string; const ASourceFile: String
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    function Post(AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}): string; overload;
    function Post(AURL: string; ASource: TStream
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    function Post(AURL: string; ASource: TIdMultiPartFormDataStream
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;

    procedure Post(AURL: string; const ASourceFile: String; AResponseContent: TStream); overload;
    procedure Post(AURL: string; ASource: TStrings; AResponseContent: TStream; AByteEncoding: IIdTextEncoding = nil
      {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}); overload;
    procedure Post(AURL: string; ASource, AResponseContent: TStream); overload;
    procedure Post(AURL: string; ASource: TIdMultiPartFormDataStream; AResponseContent: TStream); overload;

    function Put(AURL: string; ASource: TStream
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
      ): string; overload;
    procedure Put(AURL: string; ASource, AResponseContent: TStream); overload;

    procedure Patch(AURL: string; ASource, AResponseContent: TStream); overload;
    function Patch(AURL: string; ASource: TStream
      {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
    ): string; overload;

    {This is an object that can compress and decompress HTTP Deflate encoding}
    property Compressor : TIdZLibCompressorBase read FCompressor write FCompressor;

    {This is the response code number such as 404 for File not Found}
    property ResponseCode: Integer read GetResponseCode;
    {This is the text of the message such as "404 File Not Found here Sorry"}
    property ResponseText: string read GetResponseText;
    property Response: TIdHTTPResponse read GetResponse;
    property MetaHTTPEquiv: TIdMetaHTTPEquiv read GetMetaHTTPEquiv;
    { This is the last processed URL }
    property URL: TIdURI read FURI;
    // number of retry attempts for Authentication
    property AuthRetries: Integer read FAuthRetries;
    property AuthProxyRetries: Integer read FAuthProxyRetries;
    // maximum number of Authentication retries permitted
    property MaxAuthRetries: Integer read FMaxAuthRetries write FMaxAuthRetries default Id_TIdHTTP_MaxAuthRetries;
    property AllowCookies: Boolean read FAllowCookies write SetAllowCookies default True;
    {Do we handle redirect requests or simply raise an exception and let the
     developer deal with it}
    property HandleRedirects: Boolean read FHandleRedirects write FHandleRedirects default Id_TIdHTTP_HandleRedirects;
    property ProtocolVersion: TIdHTTPProtocolVersion read FProtocolVersion write FProtocolVersion default Id_TIdHTTP_ProtocolVersion;
    //how many redirects were made in the last request
    property RedirectCount: Integer read FRedirectCount;
    {This is the maximum number of redirects we wish to handle, we limit this
     to prevent stack overflow due to recursion.  Recursion is safe ONLY if
     prevented for continuing to infinity}
    property RedirectMaximum: Integer read FRedirectMax write FRedirectMax default Id_TIdHTTP_RedirectMax;
    // S.G. 6/4/2004: This is to prevent the server from responding with too many header lines
    property MaxHeaderLines: integer read FMaxHeaderLines write FMaxHeaderLines default Id_TIdHTTP_MaxHeaderLines;
    property ProxyParams: TIdProxyConnectionInfo read FProxyParameters write SetProxyParams;
    property Request: TIdHTTPRequest read GetRequest write SetRequest;
    property HTTPOptions: TIdHTTPOptions read FOptions write FOptions;
    //
    property OnHeadersAvailable: TIdHTTPOnHeadersAvailable read FOnHeadersAvailable write FOnHeadersAvailable;
    // Fired when a rediretion is requested.
    property OnRedirect: TIdHTTPOnRedirectEvent read FOnRedirect write FOnRedirect;
    property OnSelectAuthorization: TIdOnSelectAuthorization read FOnSelectAuthorization write FOnSelectAuthorization;
    property OnSelectProxyAuthorization: TIdOnSelectAuthorization read FOnSelectProxyAuthorization write FOnSelectProxyAuthorization;
    property OnAuthorization: TIdOnAuthorization read FOnAuthorization write FOnAuthorization;
    property OnProxyAuthorization: TIdOnAuthorization read FOnProxyAuthorization write FOnProxyAuthorization;
    property OnChunkReceived: TIdOnChunkReceived read FOnChunkReceived write FOnChunkReceived;
    // Cookie stuff
    property CookieManager: TIdCookieManager read FCookieManager write SetCookieManager;
    //
    property AuthenticationManager: TIdAuthenticationManager read FAuthenticationManager write SetAuthenticationManager;
  end;

  TIdHTTP = class(TIdCustomHTTP)
  published
    // number of Authentication retries permitted
    property MaxAuthRetries;
    property AllowCookies;
    { Do we handle redirect requests or simply raise an exception and let the
     developer deal with it }
    property HandleRedirects;
    property ProtocolVersion;
    { This is the maximum number of redirects we wish to handle, we limit this
     to prevent stack overflow due to recursion.  Recursion is safe ONLY if
     prevented for continuing to infinity }
    property RedirectMaximum;
    property ProxyParams;
    property Request;
    property HTTPOptions;
    //
    property OnHeadersAvailable;
    // Fired when a rediretion is requested.
    property OnRedirect;
    property OnSelectAuthorization;
    property OnSelectProxyAuthorization;
    property OnAuthorization;
    property OnProxyAuthorization;
    property OnChunkReceived;
    // property Host;
    // property Port default IdPORT_HTTP;
    // Cookie stuff
    property CookieManager;
    // property AuthenticationManager: TIdAuthenticationManager read FAuthenticationManager write SetAuthenticationManager;
    // ZLib compression library object for use with deflate and gzip encoding
    property Compressor;
  end;

  EIdUnknownProtocol = class(EIdException);
  EIdHTTPProtocolException = class( EIdReplyRFCError )
  protected
    FErrorMessage: string;
  public
    constructor CreateError(const anErrCode: Integer; const asReplyMessage: string;
      const asErrorMessage: string); reintroduce; virtual;
    property ErrorMessage: string read FErrorMessage;
  end;

implementation

uses
  SysUtils,
  IdAllAuthentications, IdComponent, IdCoderMIME, IdTCPConnection,
  IdResourceStringsCore, IdResourceStringsProtocols, IdGlobalProtocols,
  IdIOHandler, IdIOHandlerSocket;

const
  ProtocolVersionString: array[TIdHTTPProtocolVersion] of string = ('1.0', '1.1'); {do not localize}

{ EIdHTTPProtocolException }

constructor EIdHTTPProtocolException.CreateError(const anErrCode: Integer;
  const asReplyMessage: string; const asErrorMessage: string);
begin
  inherited CreateError(anErrCode, asReplyMessage);
  FErrorMessage := asErrorMessage;
end;

{ TIdHTTP }

function IsContentTypeHtml(AInfo: TIdEntityHeaderInfo) : Boolean;
begin
  Result := IsHeaderMediaTypes(AInfo.ContentType, ['text/html', 'text/html-sandboxed','application/xhtml+xml']); {do not localize}
end;

function IsContentTypeAppXml(AInfo: TIdEntityHeaderInfo) : Boolean;
begin
  Result := IsHeaderMediaTypes(AInfo.ContentType,
    ['application/xml', 'application/xml-external-parsed-entity', 'application/xml-dtd'] {do not localize}
    );
  if not Result then
  begin
    Result := not IsHeaderMediaType(AInfo.ContentType, 'text'); {do not localize}
    if Result then begin
      Result := TextEndsWith(ExtractHeaderMediaSubType(AInfo.ContentType), '+xml') {do not localize}
    end;
  end;
end;

destructor TIdCustomHTTP.Destroy;
begin
  FreeAndNil(FHTTPProto);
  FreeAndNil(FURI);
  FreeAndNil(FProxyParameters);
  SetCookieManager(nil);
  inherited Destroy;
end;

procedure TIdCustomHTTP.Delete(AURL: string; AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodDelete, AURL, nil, AResponseContent, []);
end;

function TIdCustomHTTP.Delete(AURL: string
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    DoRequest(Id_HTTPMethodDelete, AURL, nil, LStream, []);
    LStream.Position := 0;
    Result := ReadStringAsCharset(LStream, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdCustomHTTP.Options(AURL: string; AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodOptions, AURL, nil, AResponseContent, []);
end;

function TIdCustomHTTP.Options(AURL: string
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    DoRequest(Id_HTTPMethodOptions, AURL, nil, LStream, []);
    LStream.Position := 0;
    Result := ReadStringAsCharset(LStream, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdCustomHTTP.Get(AURL: string; AResponseContent: TStream);
begin
  Get(AURL, AResponseContent, []);
end;

procedure TIdCustomHTTP.Trace(AURL: string; AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodTrace, AURL, nil, AResponseContent, []);
end;

procedure TIdCustomHTTP.Head(AURL: string);
begin
  DoRequest(Id_HTTPMethodHead, AURL, nil, nil, []);
end;

procedure TIdCustomHTTP.Post(AURL: string; ASource, AResponseContent: TStream);
var
  OldProtocol: TIdHTTPProtocolVersion;
begin
  // PLEASE READ CAREFULLY

  // Currently when issuing a POST, IdHTTP will automatically set the protocol
  // to version 1.0 independently of the value it had initially. This is because
  // there are some servers that don't respect the RFC to the full extent. In
  // particular, they don't respect sending/not sending the Expect: 100-Continue
  // header. Until we find an optimum solution that does NOT break the RFC, we
  // will restrict POSTS to version 1.0.
  OldProtocol := FProtocolVersion;
  try
    // If hoKeepOrigProtocol is SET, is possible to assume that the developer
    // is sure in operations of the server
    if not (hoKeepOrigProtocol in FOptions) then begin
      if Connected then begin
        Disconnect;
      end;
      FProtocolVersion := pv1_0;
    end;
    DoRequest(Id_HTTPMethodPost, AURL, ASource, AResponseContent, []);
  finally
    FProtocolVersion := OldProtocol;
  end;
end;

// RLebeau 12/21/2010: this is based on W3's HTML standards:
//
// HTML 4.01
// http://www.w3.org/TR/html401/
//
// HTML 5
// http://www.w3.org/TR/html5/

function WWWFormUrlEncode(const ASrc: string; AByteEncoding: IIdTextEncoding
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding{$ENDIF}
  ): string;
const
  // HTML 4.01 Section 17.13.4 ("Form content types") says:
  //
  //   application/x-www-form-urlencoded
  //
  //   Control names and values are escaped. Space characters are replaced by `+',
  // and then reserved characters are escaped as described in [RFC1738], section
  // 2.2: Non-alphanumeric characters are replaced by `%HH', a percent sign and
  // two hexadecimal digits representing the ASCII code of the character. Line
  // breaks are represented as "CR LF" pairs (i.e., `%0D%0A').
  //
  // On the other hand, HTML 5 Section 4.10.16.4 ("URL-encoded form data") says:
  //
  //   If the character isn't in the range U+0020, U+002A, U+002D, U+002E,
  // U+0030 .. U+0039, U+0041 .. U+005A, U+005F, U+0061 .. U+007A then replace
  // the character with a string formed as follows: Start with the empty string,
  // and then, taking each byte of the character when expressed in the selected
  // character encoding in turn, append to the string a U+0025 PERCENT SIGN
  // character (%) followed by two characters in the ranges U+0030 DIGIT ZERO (0)
  // to U+0039 DIGIT NINE (9) and U+0041 LATIN CAPITAL LETTER A to
  // U+005A LATIN CAPITAL LETTER Z representing the hexadecimal value of the
  // byte zero-padded if necessary).
  //
  //   If the character is a U+0020 SPACE character, replace it with a single
  // U+002B PLUS SIGN character (+).
  //
  // So, lets err on the side of caution and use the HTML 5.x definition, as it
  // encodes some of the characters that HTML 4.01 allows unencoded...
  //
  SafeChars: TIdUnicodeString = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789*-._'; {do not localize}
var
  I, J, CharLen, ByteLen: Integer;
  Buf: TIdBytes;
  {$IFDEF STRING_IS_ANSI}
  LChars: TIdWideChars;
  {$ENDIF}
  LChar: WideChar;
  Encoded: Boolean;
begin
  Result := '';

  // keep the compiler happy
  Buf := nil;
  {$IFDEF STRING_IS_ANSI}
  LChars := nil;
  {$ENDIF}

  if ASrc = '' then begin
    Exit;
  end;

  EnsureEncoding(AByteEncoding, encUTF8);
  {$IFDEF STRING_IS_ANSI}
  EnsureEncoding(ASrcEncoding, encOSDefault);
  LChars := ASrcEncoding.GetChars(
    {$IFNDEF VCL_6_OR_ABOVE}
    // RLebeau: for some reason, Delphi 5 causes a "There is no overloaded
    // version of 'GetChars' that can be called with these arguments" compiler
    // error if the PByte type-cast is used, even though GetChars() actually
    // expects a PByte as input.  Must be a compiler bug, as it compiles fine
    // in Delphi 6.  So, converting to TIdBytes until I find a better solution...
    RawToBytes(PAnsiChar(ASrc)^, Length(ASrc))
    {$ELSE}
    PByte(PAnsiChar(ASrc)), Length(ASrc)
    {$ENDIF}
  );
  {$ENDIF}

  // 2 Chars to handle UTF-16 surrogates
  SetLength(Buf, AByteEncoding.GetMaxByteCount(2));

  I := 0;
  while I < Length({$IFDEF STRING_IS_UNICODE}ASrc{$ELSE}LChars{$ENDIF}) do
  begin
    LChar := {$IFDEF STRING_IS_UNICODE}ASrc[I+1]{$ELSE}LChars[I]{$ENDIF};

    // RLebeau 1/7/09: using Ord() for #128-#255 because in D2009 and later, the
    // compiler may change characters >= #128 from their Ansi codepage value to
    // their true Unicode codepoint value, depending on the codepage used for
    // the source code. For instance, #128 may become #$20AC...

    if Ord(LChar) = 32 then
    begin
      Result := Result + '+'; {do not localize}
      Inc(I);
    end
    else if WideCharIsInSet(SafeChars, LChar) then
    begin
      Result := Result + Char(LChar);
      Inc(I);
    end else
    begin
      // HTML 5 Section 4.10.16.4 says:
      //
      // For each character ... that cannot be expressed using the selected character
      // encoding, replace the character by a string consisting of a U+0026 AMPERSAND
      // character (&), a U+0023 NUMBER SIGN character (#), one or more characters in
      // the range U+0030 DIGIT ZERO (0) to U+0039 DIGIT NINE (9) representing the
      // Unicode code point of the character in base ten, and finally a U+003B
      // SEMICOLON character (;).
      //
      CharLen := CalcUTF16CharLength(
        {$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF}
        ); // calculate length including surrogates
      ByteLen := AByteEncoding.GetBytes(
        {$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF},
        CharLen, Buf, 0); // explicit Unicode->Ansi conversion

      Encoded := (ByteLen > 0);
      if Encoded and (LChar <> '?') then begin  {do not localize}
        for J := 0 to ByteLen-1 do begin
          if Buf[J] = Ord('?') then begin  {do not localize}
            Encoded := False;
            Break;
          end;
        end;
      end;

      if Encoded then begin
        for J := 0 to ByteLen-1 do begin
          Result := Result + '%' + IntToHex(Ord(Buf[J]), 2);  {do not localize}
        end;
      end else begin
        J := GetUTF16Codepoint(
          {$IFDEF STRING_IS_UNICODE}ASrc, I+1{$ELSE}LChars, I{$ENDIF});
        Result := Result + '&#' + IntToStr(J) + ';';  {do not localize}
      end;

      Inc(I, CharLen);
    end;
  end;
end;

function TIdCustomHTTP.SetRequestParams(ASource: TStrings; AByteEncoding: IIdTextEncoding
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding{$ENDIF}
  ): string;
var
  i: Integer;
  LPos: integer;
  LStr: string;
  LTemp: TStringList;
  {$IFDEF HAS_TStrings_NameValueSeparator}
  LChar: string;
  J: Integer;
  {$ENDIF}

  function EncodeLineBreaks(AStrings: TStrings): String;
  begin
    if AStrings.Count > 1 then begin
      // break trailing CR&LF
      Result := ReplaceAll(Trim(AStrings.Text),
        {$IFDEF HAS_TStrings_LineBreak}AStrings.LineBreak{$ELSE}sLineBreak{$ENDIF},
        '&'); {do not localize}
    end else begin
      Result := Trim(AStrings.Text);
    end;
  end;

begin
  if Assigned(ASource) then begin
    if hoForceEncodeParams in FOptions then begin
      // make a copy of ASource so the caller's TStrings object is not modified
      LTemp := TStringList.Create;
      try
        LTemp.Assign(ASource);
        for i := 0 to LTemp.Count - 1 do begin
          LStr := LTemp[i];
          {$IFDEF HAS_TStrings_NameValueSeparator}
          // RLebeau 11/8/16: Calling Pos() with a Char as input creates a temporary
          // String.  Normally this is fine, but profiling reveils this to be a big
          // bottleneck for code that makes a lot of calls to Pos() in a loop, so we
          // will scan through the string looking for the character without a conversion...
          //
          // LPos := IndyPos(LTemp.NameValueSeparator, LStr);
          //
          LChar := LTemp.NameValueSeparator;
          LPos := 0;
          for J := 1 to Length(LStr) do begin
            //if CharEquals(LStr, LPos, LChar) then begin
            if LStr[J] = LChar then begin
              LPos := J;
              Break;
            end;
          end;
          {$ELSE}
          LPos := IndyPos('=', LStr); {do not localize}
          {$ENDIF}
          if LPos > 0 then begin
            LTemp[i] := WWWFormUrlEncode(LTemp.Names[i], AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF})
                        + '=' {do not localize}
                        + WWWFormUrlEncode(IndyValueFromIndex(LTemp, i), AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
          end else begin
            LTemp[i] := WWWFormUrlEncode(LStr, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
          end;
        end;
        Result := EncodeLineBreaks(LTemp);
      finally
        LTemp.Free;
      end;
    end else begin
      Result := EncodeLineBreaks(ASource);
    end;
  end else begin
    Result := '';
  end;
end;

function TIdCustomHTTP.Post(AURL: string; const ASourceFile: String
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LSource: TIdReadFileExclusiveStream;
begin
  LSource := TIdReadFileExclusiveStream.Create(ASourceFile);
  try
    Result := Post(AURL, LSource{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
  finally
    FreeAndNil(LSource);
  end;
end;

procedure TIdCustomHTTP.Post(AURL: string; const ASourceFile: String; AResponseContent: TStream);
var
  LSource: TStream;
begin
  LSource := TIdReadFileExclusiveStream.Create(ASourceFile);
  try
    Post(AURL, LSource, AResponseContent);
  finally
    FreeAndNil(LSource);
  end;
end;

procedure TIdCustomHTTP.Post(AURL: string; ASource: TStrings; AResponseContent: TStream;
  AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil{$ENDIF}
  );
var
  LParams: TMemoryStream;
begin
  // Usual posting request have default ContentType is application/x-www-form-urlencoded
  if (Request.ContentType = '') or IsContentTypeHtml(Request) then begin
    Request.ContentType := 'application/x-www-form-urlencoded'; {do not localize}
  end;

  if ASource <> nil then
  begin
    LParams := TMemoryStream.Create;
    try
      WriteStringToStream(LParams, SetRequestParams(ASource, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF}));
      LParams.Position := 0;
      Post(AURL, LParams, AResponseContent);
    finally
      FreeAndNil(LParams);
    end;
  end else begin
    Post(AURL, TStream(nil), AResponseContent);
  end;
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TStrings; AByteEncoding: IIdTextEncoding = nil
  {$IFDEF STRING_IS_ANSI}; ASrcEncoding: IIdTextEncoding = nil; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Post(AURL, ASource, LResponse, AByteEncoding{$IFDEF STRING_IS_ANSI}, ASrcEncoding{$ENDIF});
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Post(AURL, ASource, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

procedure TIdCustomHTTP.Put(AURL: string; ASource, AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodPut, AURL, ASource, AResponseContent, []);
end;

function TIdCustomHTTP.Put(AURL: string; ASource: TStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Put(AURL, ASource, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

function TIdCustomHTTP.Get(AURL: string
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
begin
  Result := Get(AURL, []{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;

function TIdCustomHTTP.Trace(AURL: string
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Trace(AURL, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

function TIdCustomHTTP.DoOnRedirect(var Location: string; var VMethod: TIdHTTPMethod; RedirectCount: integer): boolean;
begin
  // TODO: convert relative URLs to full URLs here...
  Result := HandleRedirects;
  if Assigned(FOnRedirect) then begin
    FOnRedirect(Self, Location, RedirectCount, Result, VMethod);
  end;
end;

procedure TIdCustomHTTP.SetCookies(AURL: TIdURI; ARequest: TIdHTTPRequest);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LCookieManager: TIdCookieManager;
begin
  if AllowCookies then begin
    LCookieManager := FCookieManager;
    if Assigned(LCookieManager) then
    begin
      // Send secure cookies only if we have Secured connection
      LCookieManager.GenerateClientCookies(
        AURL,
        TextIsSame(AURL.Protocol, 'HTTPS'), {do not localize}
        ARequest.RawHeaders);
    end;
  end;
end;

// This function sets the Host and Port and returns a boolean depending on
// whether a PROXY is being used or not.

function TIdCustomHTTP.SetHostAndPort: TIdHTTPConnectionType;
var
  LHost: string;
  LPort: Integer;
begin
  // First check to see if a Proxy has been specified.
  if Length(ProxyParams.ProxyServer) > 0 then begin
    if (not TextIsSame(FHost, ProxyParams.ProxyServer)) or (FPort <> ProxyParams.ProxyPort) then begin
      if Connected then begin
        Disconnect;
      end;
    end;
    LHost := ProxyParams.ProxyServer;
    LPort := ProxyParams.ProxyPort;
    if TextIsSame(URL.Protocol, 'HTTPS') then begin  {do not localize}
      Result := ctSSLProxy;
    end else begin
      Result := ctProxy;
    end;
  end else begin
    if Assigned(Socket) then begin
      if Assigned(Socket.Binding) then begin
        if URL.IPVersion <> Socket.Binding.IPVersion then begin
          if Connected then begin
            Disconnect; // get rid of current socket handle
          end;
        end;
      end;
    end;
    LHost := URL.Host;
    LPort := IndyStrToInt(URL.Port, IdPORT_HTTP);
    if (not TextIsSame(FHost, LHost)) or (LPort <> FPort) then begin
      if Connected then begin
        Disconnect;
      end;
    end;
    if TextIsSame(URL.Protocol, 'HTTPS') then begin  {do not localize}
      Result := ctSSL;
    end else begin
      Result := ctNormal;
    end;
  end;
  Host := LHost;
  Port := LPort;
end;

// TODO: move the XML charset detector below to the IdGlobalProtocols unit so
// it can be used in other components, like TIdMessageClient and TIdIMAP4...

type
  XmlEncoding = (xmlUCS4BE, xmlUCS4BEOdd, xmlUCS4LE, xmlUCS4LEOdd,
                 xmlUTF16BE, xmlUTF16LE, xmlUTF8, xmlEBCDIC, xmlUnknown
                 );

  XmlBomInfo = record
    Charset: String;
    BOMLen: Integer;
    BOM: UInt32;
    BOMMask: UInt32;
  end;

  XmlNonBomInfo = record
    CharLen: Integer;
    FirstChar: UInt32;
    LastChar: UInt32;
    CharMask: UInt32;
  end;

const
  XmlBOMs: array[xmlUCS4BE..xmlUTF8] of XmlBomInfo = (
    (Charset: 'UCS-4BE';  BOMLen: 4; BOM: $0000FEFF; BOMMask: $FFFFFFFF), {do not localize}
    (Charset: ''; {UCS-4} BOMLen: 4; BOM: $0000FFFE; BOMMask: $FFFFFFFF),
    (Charset: 'UCS-4LE';  BOMLen: 4; BOM: $FFFE0000; BOMMask: $FFFFFFFF), {do not localize}
    (Charset: ''; {UCS-4} BOMLen: 4; BOM: $FEFF0000; BOMMask: $FFFFFFFF),
    (Charset: 'UTF-16BE'; BOMLen: 2; BOM: $FEFF0000; BOMMask: $FFFF0000), {do not localize}
    (Charset: 'UTF-16LE'; BOMLen: 2; BOM: $FFFE0000; BOMMask: $FFFF0000), {do not localize}
    (Charset: 'UTF-8';    BOMLen: 3; BOM: $EFBBBF00; BOMMask: $FFFFFF00)  {do not localize}
    );

  XmlNonBOMs: array[xmlUCS4BE..xmlEBCDIC] of XmlNonBomInfo = (
    (CharLen: 4; FirstChar: $0000003C; LastChar: $0000003E; CharMask: $FFFFFFFF),
    (CharLen: 4; FirstChar: $00003C00; LastChar: $00003E00; CharMask: $FFFFFFFF),
    (CharLen: 4; FirstChar: $3C000000; LastChar: $3E000000; CharMask: $FFFFFFFF),
    (CharLen: 4; FirstChar: $003C0000; LastChar: $003E0000; CharMask: $FFFFFFFF),
    (CharLen: 2; FirstChar: $003C003F; LastChar: $003E0000; CharMask: $FFFF0000),
    (CharLen: 2; FirstChar: $3C003F00; LastChar: $3E000000; CharMask: $FFFF0000),
    (CharLen: 1; FirstChar: $3C3F786D; LastChar: $3E000000; CharMask: $FF000000),
    (CharLen: 1; FirstChar: $4C6FA794; LastChar: $6E000000; CharMask: $FF000000)
    );

  XmlUCS4AsciiIndex: array[xmlUCS4BE..xmlUCS4LEOdd] of Integer = (3, 2, 0, 1);

  // RLebeau: only interested in EBCDIC ASCII characters that are allowed in
  // an XML declaration, we'll treat everything else as #01 for now...
  XmlEBCDICTable: array[Byte] of Char = (
  {     -0   -1   -2   -3   -4   -5   -6   -7   -8   -9   -A   -B   -C   -D   -E   -F }
  {0-} #01, #01, #01, #01, #01, #09, #01, #01, #01, #01, #01, #01, #01, #13, #01, #01, {do not localize}
  {1-} #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, {do not localize}
  {2-} #01, #01, #01, #01, #01, #10, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, {do not localize}
  {3-} #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, {do not localize}
  {4-} ' ', #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, '.', '<', #01, #01, #01, {do not localize}
  {5-} #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, {do not localize}
  {6-} '-', #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, '_', '>', '?', {do not localize}
  {7-} #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #27, '=', '"', {do not localize}
  {8-} #01, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', #01, #01, #01, #01, #01, #01, {do not localize}
  {9-} #01, 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', #01, #01, #01, #01, #01, #01, {do not localize}
  {A-} #01, #01, 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', #01, #01, #01, #01, #01, #01, {do not localize}
  {B-} #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, #01, {do not localize}
  {C-} #01, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', #01, #01, #01, #01, #01, #01, {do not localize}
  {D-} #01, 'J', 'K', 'L', 'N', 'N', 'O', 'P', 'Q', 'R', #01, #01, #01, #01, #01, #01, {do not localize}
  {E-} #01, #01, 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', #01, #01, #01, #01, #01, #01, {do not localize}
  {F-} '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', #01, #01, #01, #01, #01, #01  {do not localize}
  );

function DetectXmlCharset(AStream: TStream): String;
var
  Buffer: TIdBytes;
  InBuf, StreamPos, CurPos: TIdStreamSize;
  XmlDec, XmlEnc: String;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
  I, Len: Integer;
  Enc: XmlEncoding;
  Signature: UInt32;

  function BufferToUInt32: UInt32;
  begin
    Result := (UInt32(Buffer[0]) shl 24) or
              (UInt32(Buffer[1]) shl 16) or
              (UInt32(Buffer[2]) shl 8) or
              UInt32(Buffer[3]);
  end;

begin
  // XML's default encoding is UTF-8 unless specified otherwise, either
  // by a BOM or an explicit "encoding" in the XML's prolog...

  Result := 'UTF-8'; {do not localize}

  if AStream = nil then begin
    Exit;
  end;

  StreamPos := AStream.Position;
  try
    AStream.Position := 0;

    SetLength(Buffer, 4);
    FillBytes(Buffer, 4, $00);

    InBuf := ReadTIdBytesFromStream(AStream, Buffer, 4);
    if InBuf < 3 then begin
      Exit;
    end;

    Signature := BufferToUInt32;

    // check for known BOMs first...

    for Enc := Low(XmlBOMs) to High(XmlBOMs) do begin
      if (Signature and XmlBOMs[Enc].BOMMask) = XmlBOMs[Enc].BOM then begin
        Inc(StreamPos, XmlBOMs[Enc].BOMLen);
        Result := XmlBOMs[Enc].Charset;
        Exit;
      end;
    end;

    // check for non-BOM'ed encodings now...

    if InBuf <> 4 then begin
      Exit;
    end;

    XmlDec := '';

    for Enc := Low(XmlNonBOMs) to High(XmlNonBOMs) do begin
      if Signature = XmlNonBOMs[Enc].FirstChar then begin
        FillBytes(Buffer, 4, $00);
        while (AStream.Size - AStream.Position) >= XmlNonBOMs[Enc].CharLen do
        begin
          ReadTIdBytesFromStream(AStream, Buffer, XmlNonBOMs[Enc].CharLen);
          Signature := BufferToUInt32;
          if (Signature and XmlNonBOMs[Enc].CharMask) = XmlNonBOMs[Enc].LastChar then
          begin
            CurPos := AStream.Position;
            AStream.Position := 0;
            case Enc of
              xmlUCS4BE, xmlUCS4LE, xmlUCS4BEOdd, xmlUCS4LEOdd: begin
                // TODO: create UCS-4 IIdTextEncoding implementations...
                Len := CurPos div XmlNonBOMs[Enc].CharLen;
                {$IFDEF STRING_IS_IMMUTABLE}
                LSB := TIdStringBuilder.Create(Len);
                {$ELSE}
                SetLength(XmlDec, Len);
                {$ENDIF}
                for I := 1 to Len do begin
                  ReadTIdBytesFromStream(AStream, Buffer, XmlNonBOMs[Enc].CharLen);
                  {$IFDEF STRING_IS_IMMUTABLE}
                  LSB.Append(Char(Buffer[XmlUCS4AsciiIndex[Enc]]));
                  {$ELSE}
                  XmlDec[I] := Char(Buffer[XmlUCS4AsciiIndex[Enc]]);
                  {$ENDIF}
                end;
                {$IFDEF STRING_IS_IMMUTABLE}
                XmlDec := LSB.ToString;
                LSB := nil;
                {$ENDIF}
              end;
              xmlUTF16BE: begin
                XmlDec := ReadStringFromStream(AStream, CurPos, IndyTextEncoding_UTF16BE);
              end;
              xmlUTF16LE: begin
                XmlDec := ReadStringFromStream(AStream, CurPos, IndyTextEncoding_UTF16LE);
              end;
              xmlUTF8: begin
                XmlDec := ReadStringFromStream(AStream, CurPos, IndyTextEncoding_UTF8);
              end;
              xmlEBCDIC: begin
                // TODO: create an EBCDIC IIdTextEncoding implementation...
                {$IFDEF STRING_IS_IMMUTABLE}
                Len := ReadTIdBytesFromStream(AStream, Buffer, CurPos);
                LSB := TStringBuilder.Create(Len);
                for I := 0 to Len-1 do begin
                  LSB.Append(XmlEBCDICTable[Buffer[I]]);
                end;
                XmlDec := LSB.ToString;
                {$ELSE}
                XmlDec := ReadStringFromStream(AStream, CurPos, IndyTextEncoding_8Bit);
                for I := 1 to Length(XmlDec) do begin
                  XmlDec[I] := XmlEBCDICTable[Byte(XmlDec[I])];
                end;
                {$ENDIF}
              end;
            end;
            Break;
          end;
        end;
        Break;
      end;
    end;

    if XmlDec = '' then begin
      Exit;
    end;

    I := Pos('encoding', XmlDec); {do not localize}
    if I = 0 then begin
      Exit;
    end;

    XmlDec := TrimLeft(Copy(XmlDec, I+8, MaxInt));
    if not CharEquals(XmlDec, 1, '=') then begin {do not localize}
      Exit;
    end;

    XmlDec := TrimLeft(Copy(XmlDec, 2, MaxInt));
    if XmlDec = '' then begin
      Exit;
    end;

    if XmlDec[1] = #$27 then begin
      XmlDec := Copy(XmlDec, 2, MaxInt);
      XmlEnc := Fetch(XmlDec, #$27);
    end
    else if XmlDec[1] = '"' then begin
      XmlDec := Copy(XmlDec, 2, MaxInt);
      XmlEnc := Fetch(XmlDec, '"');
    end;

    XmlEnc := Trim(XmlEnc);
    if XmlEnc = '' then begin
      Exit;
    end;

    Result := XmlEnc;
  finally
    AStream.Position := StreamPos;
  end;
end;

procedure TIdCustomHTTP.ReadResult(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
var
  LS: TStream;
  LOrigStream, LTmpStream : TStream;
  LParseMeth : Integer;
  //0 - no parsing
  //1 - html
  //2 - xml
  LCreateTmpContent : Boolean;
  LDecMeth : Integer;
  //0 - no compression was used or we can't support that feature
  //1 - deflate
  //2 - gzip
  // under ARC, convert a weak reference to a strong reference before working with it
  LCompressor: TIdZLibCompressorBase;

  function CheckForPendingData(ATimeout: Integer): Boolean;
  begin
    Result := not IOHandler.InputBufferIsEmpty;
    if not Result then begin
      IOHandler.CheckForDataOnSource(ATimeout);
      Result := not IOHandler.InputBufferIsEmpty;
    end;
  end;

  function ShouldRead: Boolean;
  var
    CanRead: Boolean;
  begin
    Result := False;
    if IndyPos('chunked', LowerCase(AResponse.TransferEncoding)) > 0 then begin {do not localize}
      CanRead := not (hoNoReadChunked in FOptions);
    end
    else if AResponse.HasContentLength then begin
      CanRead := AResponse.ContentLength > 0; // If chunked then this is also 0
    end
    else if IsHeaderMediaType(AResponse.ContentType, 'multipart') then begin {do not localize}
      CanRead := not (hoNoReadMultipartMIME in FOptions);
    end
    else begin
      CanRead := True;
    end;
    if CanRead then
    begin
      // DO NOT READ IF THE REQUEST IS HEAD!!!
      // The server is supposed to send a 'Content-Length' header without sending
      // the actual data. 1xx, 204, and 304 replies are not supposed to contain
      // entity bodies, either...
      if TextIsSame(ARequest.Method, Id_HTTPMethodHead) or
         ({TextIsSame(ARequest.Method, Id_HTTPMethodPost) and} TextIsSame(ARequest.MethodOverride, Id_HTTPMethodHead)) or
         // TODO: check for 'X-HTTP-Method' and 'X-METHOD-OVERRIDE' request headers as well...
         ((AResponse.ResponseCode div 100) = 1) or
         (AResponse.ResponseCode = 204) or
         (AResponse.ResponseCode = 304) then
      begin
        // Have noticed one case where a non-conforming server did send an
        // entity body in response to a HEAD request.  If requested, ignore
        // anything the server may send by accident
        if not (hoWaitForUnexpectedData in FOptions) then begin
          Exit;
        end;
        Result := CheckForPendingData(100);
      end
      else if (AResponse.ResponseCode div 100) = 3 then
      begin
        // This is a workaround for buggy HTTP 1.1 servers which
        // does not return any body with 302 response code
        Result := CheckForPendingData(5000);
      end else begin
        Result := True;
      end;
    end;
  end;

  function ChunkSize: integer;
  var
    j: Integer;
    s: string;
  begin
    s := InternalReadLn;
    j := IndyPos(';', s); {do not localize}
    if j > 0 then begin
      s := Copy(s, 1, j - 1);
    end;
    Result := IndyStrToInt('$' + Trim(s), 0);      {do not localize}
  end;

  procedure ReadChunked;
  var
    LSize: Integer;
    LTrailHeader: String;
    LChunk : TIdBytes;
  begin
    DoStatus(hsStatusText, [RSHTTPChunkStarted]);
    BeginWork(wmRead);
    try
      LSize := ChunkSize;
      while LSize <> 0 do begin
        // TODO: fire OnChunkReceived even if LS is nil? This way, the caller
        // can choose to pass AContentStream=nil and rely solely on OnChunkReceived
        // in cases where a chunked response is expected up front, like in
        // server-side pushes...
        if Assigned(LS) then begin
          if Assigned(FOnChunkReceived) then begin
            SetLength(LChunk, LSize);
            IOHandler.ReadBytes(LChunk, LSize, False);
            if Assigned(FOnChunkReceived) then begin
              FOnChunkReceived(Self, LChunk);
            end;
            WriteTIdBytesToStream(LS, LChunk);
          end else begin
            IOHandler.ReadStream(LS, LSize);
          end;
        end else begin
          IOHandler.Discard(LSize);
        end;
        InternalReadLn; // CRLF at end of chunk data
        LSize := ChunkSize;
      end;
      // read trailer headers
      LTrailHeader := InternalReadLn;
      while LTrailHeader <> '' do begin
        AResponse.RawHeaders.Add(LTrailHeader);
        LTrailHeader := InternalReadLn;
      end;
    finally
      EndWork(wmRead);
    end;
  end;

  procedure ReadMIME;
  var
    LMIMEBoundary: TIdBytes;
    LIndex: Integer;
    LSize: Integer;
  begin
    LMIMEBoundary := ToBytes('--' + ExtractHeaderSubItem(AResponse.ContentType, 'boundary', QuoteHTTP) + '--');
    BeginWork(wmRead);
    try
      try
        repeat
          LIndex := IOHandler.InputBuffer.IndexOf(LMIMEBoundary);
          if LIndex <> -1 then
          begin
            LSize := LIndex + Length(LMIMEBoundary);
            if Assigned(LS) then begin
              // TODO: use TIdBuffer.ExtractToStream() instead, bypassing the
              // overhead of TIdIOHandler.ReadStream() allocating a local buffer
              // and calling IOHandler.ReadBytes() to fill that buffer in even
              // multiples of the IOHandler's RecvBufferSize. The data we want
              // is already in the Buffer's memory, so just read it directly...
              //
              // IOHandler.InputBuffer.ExtractToStream(LS, LSize);
              IOHandler.ReadStream(LS, LSize);
            end else begin
              IOHandler.Discard(LSize);
            end;
            InternalReadLn; // CRLF at end of boundary
            Break;
          end;
          LSize := IOHandler.InputBuffer.Size - (Length(LMIMEBoundary)-1);
          if LSize > 0 then begin
            if Assigned(LS) then begin
              // TODO: use TIdBuffer.ExtractToStream() instead, bypassing the
              // overhead of TIdIOHandler.ReadStream() allocating a local buffer
              // and calling IOHandler.ReadBytes() to fill that buffer in even
              // multiples of the IOHandler's RecvBufferSize. The data we want
              // is already in the Buffer's memory, so just read it directly...
              //
              // IOHandler.InputBuffer.ExtractToStream(LS, LSize);
              IOHandler.ReadStream(LS, LSize);
            end else begin
              IOHandler.Discard(LSize);
            end;
          end;
          IOHandler.CheckForDataOnSource;
          IOHandler.CheckForDisconnect(True, True);
        until False;
      except
        on E: EIdConnClosedGracefully do begin
          if Assigned(LS) then begin
            IOHandler.InputBuffer.ExtractToStream(LS);
          end else begin
            IOHandler.InputBuffer.Clear;
          end;
        end;
      end;
    finally
      EndWork(wmRead);
    end;
  end;

begin
  if not ShouldRead then begin
    Exit;
  end;

  LParseMeth := 0;
  LDecMeth := 0;

  if Assigned(AResponse.ContentStream) then begin
    if IsContentTypeHtml(AResponse) then begin
      if not (hoNoParseMetaHTTPEquiv in FOptions) then begin
        LParseMeth := 1;
      end;
    end
    else if IsContentTypeAppXml(Response) then begin
      if not (hoNoParseXmlCharset in FOptions) then begin
        LParseMeth := 2;
      end;
    end;
  end;

  // under ARC, AResponse.ContentStream uses weak referencing, so need to
  // use local strong references to keep the streams alive...
  LOrigStream := AResponse.ContentStream;
  LCreateTmpContent := (LParseMeth <> 0) and not (LOrigStream is TCustomMemoryStream);
  if LCreateTmpContent then begin
    LTmpStream := TMemoryStream.Create;
  end else begin
    LTmpStream := nil;
  end;

  try
    if LCreateTmpContent then begin
      AResponse.ContentStream := LTmpStream;
    end;

    // we need to determine what type of decompression may need to be used
    // before we read from the IOHandler.  If there is compression, then we
    // use a local stream to download the compressed data and decompress it.
    // If no compression is used, ContentStream will be used directly

    LCompressor := Compressor;
    if Assigned(AResponse.ContentStream) then begin
      if Assigned(LCompressor) and LCompressor.IsReady then begin
        LDecMeth := PosInStrArray(AResponse.ContentEncoding, ['deflate', 'gzip'], False) + 1;  {do not localize}
      end;
      if LDecMeth > 0 then begin
        LS := TMemoryStream.Create;
      end else begin
        LS := AResponse.ContentStream;
      end;
    end else
    begin
      LS := nil;
    end;

    try
      if IndyPos('chunked', LowerCase(AResponse.TransferEncoding)) > 0 then begin {do not localize}
        ReadChunked;
      end
      else if AResponse.HasContentLength then begin
        if AResponse.ContentLength > 0 then begin// If chunked then this is also 0
          try
            if Assigned(LS) then begin
              IOHandler.ReadStream(LS, AResponse.ContentLength);
            end else begin
              IOHandler.Discard(AResponse.ContentLength);
            end;
          except
            // should this be caught here?  We are being told the size, so a
            // premature disconnect should be an error, right?
            on E: EIdConnClosedGracefully do begin end;
          end;
        end;
      end
      else if IsHeaderMediaType(AResponse.ContentType, 'multipart') then begin {do not localize}
        ReadMIME;
      end else begin
        if Assigned(LS) then begin
          IOHandler.ReadStream(LS, -1, True);
        end else begin
          IOHandler.DiscardAll;
        end;
      end;
      if LDecMeth > 0 then begin
        LS.Position := 0;
        case LDecMeth of
          1 : LCompressor.DecompressDeflateStream(LS, AResponse.ContentStream);
          2 : LCompressor.DecompressGZipStream(LS, AResponse.ContentStream);
        end;
      end;
    finally
      if LDecMeth > 0 then begin
        FreeAndNil(LS);
      end;
    end;
    case LParseMeth of
      1: begin
        // RLebeau 1/30/2012: parse HTML <meta> tags, update Response.CharSet ...
        AResponse.ProcessMetaHTTPEquiv;
      end;
      2: begin
        // the media type is not a 'text/...' based XML type, so ignore the
        // charset from the headers, if present, and parse the XML itself...
        AResponse.CharSet := DetectXmlCharset(AResponse.ContentStream);
      end;
    else
      // TODO: if a Charset is not specified, return an appropriate value
      // that is registered with IANA for the reported ContentType...
    end;
  finally
    if LCreateTmpContent then
    begin
      try
        LOrigStream.CopyFrom(LTmpStream, 0);
      finally
        {$IFNDEF USE_OBJECT_ARC}
        LTmpStream.Free;
        {$ENDIF}
        AResponse.ContentStream := LOrigStream;
      end;
    end;
  end;
end;

const
  Requires_HTTP_1_1: array[0..4] of String = (Id_HTTPMethodTrace, Id_HTTPMethodPut, Id_HTTPMethodOptions, Id_HTTPMethodDelete, Id_HTTPMethodPatch);
  Requires_Content_Length: array[0..1] of String = (Id_HTTPMethodPost, Id_HTTPMethodPut);

procedure TIdCustomHTTP.PrepareRequest(ARequest: TIdHTTPRequest);
var
  LURI: TIdURI;
  LHost: string;
begin
  LURI := TIdURI.Create(ARequest.URL);

  try
    if Length(LURI.Username) > 0 then begin
      ARequest.Username := LURI.Username;
      ARequest.Password := LURI.Password;
    end;

    FURI.Username := ARequest.Username;
    FURI.Password := ARequest.Password;

    FURI.Path := ProcessPath(FURI.Path, LURI.Path);
    FURI.Document := LURI.Document;
    FURI.Params := LURI.Params;

    if Length(LURI.Host) > 0 then begin
      FURI.Host := LURI.Host;
    end;

    if Length(LURI.Protocol) > 0 then begin
      FURI.Protocol := LURI.Protocol;
    end
    // non elegant solution - to be recoded, only for pointing the bug / GREGOR
    else if TextIsSame(FURI.Protocol, 'https') then begin {do not localize}
      FURI.Protocol := 'https'; {do not localize}
    end
    else begin
      FURI.Protocol := 'http';  {do not localize}
    end;

    if Length(LURI.Port) > 0 then begin
      FURI.Port := LURI.Port;
    end
    else if TextIsSame(LURI.Protocol, 'http') then begin     {do not localize}
      FURI.Port := IntToStr(IdPORT_HTTP);
    end
    else if TextIsSame(LURI.Protocol, 'https') then begin  {do not localize}
      FURI.Port := IntToStr(IdPORT_https);
    end
    else if Length(FURI.Port) = 0 then begin
      raise EIdUnknownProtocol.Create(RSHTTPUnknownProtocol);
    end;

    if (TextIsSame(ARequest.Method, Id_HTTPMethodOptions) or TextIsSame(ARequest.MethodOverride, Id_HTTPMethodOptions))
      and TextIsSame(LURI.Document, '*') then  {do not localize}
    begin
      ARequest.URL := LURI.Document;
    end else begin
      // The URL part is not URL encoded at this place
      ARequest.URL := URL.GetPathAndParams;
    end;

    ARequest.IPVersion := LURI.IPVersion;
    FURI.IPVersion := ARequest.IPVersion;

    // Check for valid HTTP request methods
    if (PosInStrArray(ARequest.Method, Requires_HTTP_1_1, False) > -1) or
      (PosInStrArray(ARequest.MethodOverride, Requires_HTTP_1_1, False) > -1) then
    begin
      if ProtocolVersion <> pv1_1 then  begin
        raise EIdException.Create(RSHTTPMethodRequiresVersion); // TODO: create a new Exception class for this
      end;
    end;

    if Assigned(ARequest.Source) then begin
      ARequest.ContentLength := ARequest.Source.Size;
    end
    else if PosInStrArray(ARequest.Method, Requires_Content_Length, False) > -1 then begin
      ARequest.ContentLength := 0;
    end else begin
      ARequest.ContentLength := -1;
    end;

    // RLebeau: wrap an IPv6 address in brackets, per RFC 2732, and RFC 3986 section 3.2.2...
    if (FURI.IPVersion = Id_IPv6) and (MakeCanonicalIPv6Address(FURI.Host) <> '') then begin
      LHost := '[' + FURI.Host + ']';    {do not localize}
    end else begin
      LHost := FURI.Host;
    end;

    if (TextIsSame(FURI.Protocol, 'http') and (FURI.Port = IntToStr(IdPORT_HTTP))) or  {do not localize}
      (TextIsSame(FURI.Protocol, 'https') and (FURI.Port = IntToStr(IdPORT_https))) then  {do not localize}
    begin
      ARequest.Host := LHost;
    end else begin
      ARequest.Host := LHost + ':' + FURI.Port;    {do not localize}
    end;
  finally
    FreeAndNil(LURI);  // Free URI Object
  end;
end;

procedure TIdCustomHTTP.CheckAndConnect(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
begin
  if not AResponse.KeepAlive then begin
    Disconnect;
  end;

  if Assigned(IOHandler) then begin
    IOHandler.InputBuffer.Clear;
  end;

  CheckForGracefulDisconnect(False);

  if not Connected then try
    IPVersion := FURI.IPVersion;

    case ARequest.UseProxy of
      ctNormal, ctProxy:
      begin
        if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
          TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := True;
          TIdSSLIOHandlerSocketBase(IOHandler).URIToCheck := FURI.URI;
        end;
      end;

      ctSSL, ctSSLProxy:
      begin
        // if an IOHandler has not been assigned yet, try to create a default SSL IOHandler object
        //
        // TODO: if an IOHandler has been assigned, but is not an SSL IOHandler,
        // release it and try to create a default SSL IOHandler object?
        //
        if IOHandler = nil then begin
          IOHandler := TIdIOHandler.TryMakeIOHandler(TIdSSLIOHandlerSocketBase, Self);
          if IOHandler = nil then begin
            raise EIdIOHandlerPropInvalid.Create(RSIOHandlerPropInvalid);
          end;
          ManagedIOHandler := True;
          IOHandler.OnStatus := OnStatus; // TODO: assign DoStatus() instead of the handler directly...
        end
        else if not (IOHandler is TIdSSLIOHandlerSocketBase) then begin
          raise EIdIOHandlerPropInvalid.Create(RSIOHandlerPropInvalid);
        end;
        TIdSSLIOHandlerSocketBase(IOHandler).URIToCheck := FURI.URI;
        TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := (ARequest.UseProxy = ctSSLProxy);
      end;
    end;

    Connect;
  except
    on E: EIdSSLProtocolReplyError do begin
      Disconnect;
      raise;
    end;
  end;
end;

procedure TIdCustomHTTP.ConnectToHost(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
var
  LLocalHTTP: TIdHTTPProtocol;
  LUseConnectVerb: Boolean;
  // under ARC, convert a weak reference to a strong reference before working with it
  LCompressor: TIdZLibCompressorBase;
  LOldProxy: TIdHTTPConnectionType;
  LNewDest: string;
begin
  // RLebeau 5/29/2018: before doing anything else, clear the InputBuffer.  If a
  // previous HTTPS request through an SSL/TLS proxy fails due to a user-defined
  // OnVerifyPeer handler returning False, the proxy tunnel is still established,
  // but the underlying socket may be closed, and unread data left behind in the
  // InputBuffer that will cause Connected() below to return True when it should
  // be False instead.  This leads to a situation where TIdHTTP can skip sending
  // a CONNECT request when it creates a new socket connection to the proxy, but
  // send an unencrypted HTTP request to the proxy, which may then get forwarded
  // to the HTTPS server over a previously cached SSL/TLS tunnel...
  
  if Assigned(IOHandler) then begin
    IOHandler.InputBuffer.Clear;
  end;

  LNewDest := URL.Host + ':' + URL.Port;

  LOldProxy := ARequest.FUseProxy;
  ARequest.FUseProxy := SetHostAndPort;

  if ARequest.UseProxy <> LOldProxy then begin
    if Connected then begin
      Disconnect;
    end;
  end
  else if (ARequest.UseProxy = ctSSLProxy) and (not TextIsSame(ARequest.Destination, LNewDest)) then begin
    if Connected then begin
      Disconnect;
    end;
  end;

  ARequest.Destination := LNewDest;

  LUseConnectVerb := False;

  case ARequest.UseProxy of
    ctNormal, ctSSL:
      begin
        if (ProtocolVersion = pv1_0) and (Length(ARequest.Connection) = 0) then
        begin
          ARequest.Connection := 'keep-alive';      {do not localize}
        end;
      end;
    ctSSLProxy:
      begin
        // if already connected to an SSL proxy, DO NOT send another
        // CONNECT request, as it will be sent directly to the target
        // HTTP server and not to the proxy!
        LUseConnectVerb := not Connected;
      end;
    ctProxy:
      begin
        ARequest.URL := FURI.URI;
        if (ProtocolVersion = pv1_0) and (Length(ARequest.Connection) = 0) then
        begin
          // TODO: per RFC 7230:
          // "clients are encouraged not to send the Proxy-Connection header field in any requests."
          ARequest.ProxyConnection := 'keep-alive'; {do not localize}
        end;
        if hoNonSSLProxyUseConnectVerb in FOptions then begin
          // if already connected to a proxy, DO NOT send another CONNECT
          // request, as it will be sent directly to the target HTTP server
          // and not to the proxy!
          LUseConnectVerb := not Connected;
        end;
      end;
  end;

  LCompressor := FCompressor;
  if Assigned(LCompressor) and LCompressor.IsReady then begin
    if IndyPos('deflate', ARequest.AcceptEncoding) = 0 then  {do not localize}
    begin
      if ARequest.AcceptEncoding <> '' then begin {do not localize}
        ARequest.AcceptEncoding := ARequest.AcceptEncoding + ', deflate'; {do not localize}
      end else begin
        ARequest.AcceptEncoding := 'deflate'; {do not localize}
      end;
    end;
    if IndyPos('gzip', ARequest.AcceptEncoding) = 0 then {do not localize}
    begin
      if ARequest.AcceptEncoding <> '' then begin {do not localize}
        ARequest.AcceptEncoding := ARequest.AcceptEncoding + ', gzip'; {do not localize}
      end else begin
        ARequest.AcceptEncoding := 'gzip'; {do not localize}
      end;
    end;
  end else
  begin
    // TODO: if ARequest.AcceptEncoding is asking for deflate/gzip compression,
    // remove it, unless the caller is prepared to decompress the data manually...
  end;
  {$IFDEF USE_OBJECT_ARC}LCompressor := nil;{$ENDIF}

  // RLebeau 1/10/2015: if AcceptEncoding is blank, DON'T set it to 'identity'!
  // Oddly, some faulty servers do not understand 'identity' when explicitly
  // stated. 'identity' is the default behavior when no "Accept-Encoding" header
  // is present, so just let the server fallback to that normally...
  if ARequest.AcceptEncoding <> '' then begin
    if IndyPos('identity', ARequest.AcceptEncoding) = 0 then begin  {do not localize}
      ARequest.AcceptEncoding := ARequest.AcceptEncoding + ', identity'; {do not localize}
    end;
    // TODO: if AcceptEncoding is 'identity', set it to a blank string?
    {
    if TextIsSame(ARequest.AcceptEncoding, 'identity') then begin  {do not localize
      ARequest.AcceptEncoding := '';
    end;
    }
  end;

  if LUseConnectVerb then begin
    LLocalHTTP := CreateProtocol;
    try
      LLocalHTTP.Request.UserAgent := ARequest.UserAgent;
      LLocalHTTP.Request.Host := ARequest.Host;
      LLocalHTTP.Request.Pragma := 'no-cache';                       {do not localize}
      LLocalHTTP.Request.URL := ARequest.Destination;
      LLocalHTTP.Request.Method := Id_HTTPMethodConnect;
      // TODO: per RFC 7230:
      // "clients are encouraged not to send the Proxy-Connection header field in any requests."
      LLocalHTTP.Request.ProxyConnection := 'keep-alive';            {do not localize}
      LLocalHTTP.Request.FUseProxy := ARequest.UseProxy;

      // leaving LLocalHTTP.Response.ContentStream set to nil so response data is discarded without wasting memory
      try
        repeat
          CheckAndConnect(LLocalHTTP.Request, LLocalHTTP.Response);
          LLocalHTTP.BuildAndSendRequest(nil);

          LLocalHTTP.Response.ResponseText := InternalReadLn;
          if Length(LLocalHTTP.Response.ResponseText) = 0 then begin
            // Support for HTTP responses without status line and headers
            LLocalHTTP.Response.ResponseText := 'HTTP/1.0 200 OK'; {do not localize}
            LLocalHTTP.Response.Connection := 'close';             {do not localize}
          end else begin
            LLocalHTTP.RetrieveHeaders(MaxHeaderLines);
            ProcessCookies(LLocalHTTP.Request, LLocalHTTP.Response);
          end;

          if (LLocalHTTP.Response.ResponseCode div 100) = 2 then begin
            // Connection established
            if (ARequest.UseProxy = ctSSLProxy) and (IOHandler is TIdSSLIOHandlerSocketBase) then begin
              TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := False;
            end;
            Break;
          end;

          case LLocalHTTP.ProcessResponse([]) of
            wnAuthRequest:
              begin
                LLocalHTTP.Request.URL := ARequest.Destination;
              end;
            wnReadAndGo:
              begin
                ReadResult(LLocalHTTP.Request, LLocalHTTP.Response);
                FAuthRetries := 0;
                FAuthProxyRetries := 0;
              end;
            wnGoToURL:
              begin
                FAuthRetries := 0;
                FAuthProxyRetries := 0;
              end;
            wnJustExit: 
              begin
                Break;
              end;
            wnDontKnow:
              begin
                raise EIdException.Create(RSHTTPNotAcceptable); // TODO: create a new Exception class for this
              end;
          end;
        until False;
      except
        raise;
        // TODO: Add property that will contain the error messages.
      end;
    finally
      FreeAndNil(LLocalHTTP);
    end;
  end else begin
    CheckAndConnect(ARequest, AResponse);
  end;

  FHTTPProto.BuildAndSendRequest(URL);

  // RLebeau 1/31/2008: in order for TIdWebDAV to post data correctly, don't
  // restrict which HTTP methods can post (except logically for GET and HEAD),
  // especially since TIdCustomHTTP.PrepareRequest() does not differentiate when
  // setting up the 'Content-Length' header ...

  // TODO: when sending an HTTP 1.1 request with an 'Expect: 100-continue' header,
  // do not send the Source data until the server replies with a 100 response code,
  // or until a timeout occurs if the server does not send a 100...
  
  if ARequest.Source <> nil then begin
    IOHandler.Write(ARequest.Source, 0, False);
  end;
end;

procedure TIdCustomHTTP.SetAllowCookies(AValue: Boolean);
begin
  FAllowCookies := AValue;
end;

procedure TIdCustomHTTP.ProcessCookies(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
var
  LCookies: TStringList;
  // under ARC, convert a weak reference to a strong reference before working with it
  LCookieManager: TIdCookieManager;
begin
  if AllowCookies then
  begin
    LCookieManager := FCookieManager;

    if not Assigned(LCookieManager) then begin
      LCookieManager := TIdCookieManager.Create(Self);
      SetCookieManager(LCookieManager);
      FImplicitCookieManager := True;
    end;

    LCookies := TStringList.Create;
    try
      AResponse.RawHeaders.Extract('Set-Cookie', LCookies);  {do not localize}
      AResponse.MetaHTTPEquiv.RawHeaders.Extract('Set-Cookie', LCookies);    {do not localize}
      LCookieManager.AddServerCookies(LCookies, FURI);
    finally
      FreeAndNil(LCookies);
    end;
  end;
end;

// under ARC, all weak references to a freed object get nil'ed automatically
// so this is mostly redundant
procedure TIdCustomHTTP.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if Operation = opRemove then begin
    if (AComponent = FCookieManager) then begin
      FCookieManager := nil;
      FImplicitCookieManager := False;
    end
    {$IFNDEF USE_OBJECT_ARC}
    else if (AComponent = FAuthenticationManager) then begin
      FAuthenticationManager := nil;
    end else if (AComponent = FCompressor) then begin
      FCompressor := nil;
    end
    {$ENDIF}
    ;
  end;
  inherited Notification(AComponent, Operation);
end;

procedure TIdCustomHTTP.SetCookieManager(ACookieManager: TIdCookieManager);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LCookieManager: TIdCookieManager;
begin
  LCookieManager := FCookieManager;

  if LCookieManager <> ACookieManager then
  begin
    // under ARC, all weak references to a freed object get nil'ed automatically

    if Assigned(LCookieManager) then begin
      if FImplicitCookieManager then begin
        FCookieManager := nil;
        FImplicitCookieManager := False;
        IdDisposeAndNil(LCookieManager);
      end else begin
        {$IFNDEF USE_OBJECT_ARC}
        LCookieManager.RemoveFreeNotification(Self);
        {$ENDIF}
      end;
    end;

    FCookieManager := ACookieManager;
    FImplicitCookieManager := False;

    {$IFNDEF USE_OBJECT_ARC}
    if Assigned(ACookieManager) then begin
      ACookieManager.FreeNotification(Self);
    end;
    {$ENDIF}
  end;
end;

function TIdCustomHTTP.DoOnAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean;
var
  i: Integer;
  S: string;
  LAuthCls: TIdAuthenticationClass;
  LAuth: TIdAuthentication;
begin
  Inc(FAuthRetries);

  // TODO: trigger OnSelectAuthorization on every request, or at least if
  // FAuthRetries is 1, or the server has sent a new 'WWW-Authenticate'
  // list that does not include the class currently assigned...
  if not Assigned(ARequest.Authentication) then begin
    // Find wich Authentication method is supported from us.
    LAuthCls := nil;

    for i := 0 to AResponse.WWWAuthenticate.Count - 1 do begin
      S := AResponse.WWWAuthenticate[i];
      LAuthCls := FindAuthClass(Fetch(S));
      if Assigned(LAuthCls) then begin
        Break;
      end;
    end;

    // let the user override us, if desired.
    if Assigned(FOnSelectAuthorization) then begin
      OnSelectAuthorization(Self, LAuthCls, AResponse.WWWAuthenticate);
    end;

    if not Assigned(LAuthCls) then begin
      Result := False;
      Exit;
    end;

    ARequest.Authentication := LAuthCls.Create;
  end;

  {
  this is commented out as it breaks SSPI and NTLM authentication. it is
  normal and expected to get multiple 407 responses during negotiation.

  // Clear password and reset autorization if previous failed
  if (AResponse.FResponseCode = 401) then begin
    ARequest.Password := '';
    ARequest.Authentication.Reset;
  end;
  }

  // S.G. 20/10/2003: Added part about the password. Not testing user name as some
  // S.G. 20/10/2003: web sites do not require user name, only password.
  //
  // RLebeau 11/18/2014: what about SSPI? It does not require an explicit
  // username/password as it can use the identity of the user token associated
  // with the calling thread!

  LAuth := ARequest.Authentication;
  LAuth.Username := ARequest.Username;
  LAuth.Password := ARequest.Password;
  // S.G. 20/10/2003: ToDo: We need to have a marker here to prevent the code to test with the same username/password combo
  // S.G. 20/10/2003: if they are picked up from properties.
  LAuth.Params.Values['Authorization'] := ARequest.Authentication.Authentication; {do not localize}
  LAuth.AuthParams := AResponse.WWWAuthenticate;

  Result := False;

  repeat
    case LAuth.Next of
      wnAskTheProgram:
        begin // Ask the user porgram to supply us with authorization information
          if not Assigned(FOnAuthorization) then
          begin
            Result := False;
            Break;
          end;

          LAuth.UserName := ARequest.Username;
          LAuth.Password := ARequest.Password;

          OnAuthorization(Self, LAuth, Result);
          if not Result then begin
            Break;
          end;

          ARequest.BasicAuthentication := True;
          ARequest.Username := LAuth.UserName;
          ARequest.Password := LAuth.Password;
        end;
      wnDoRequest:
        begin
          Result := True;
          Break;
        end;
      wnFail:
        begin
          Result := False;
          Break;
        end;
    end;
  until False;
end;

function TIdCustomHTTP.DoOnProxyAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean;
var
  i: Integer;
  S: string;
  LAuthCls: TIdAuthenticationClass;
  LAuth: TIdAuthentication;
begin
  Inc(FAuthProxyRetries);

  // TODO: trigger OnSelectProxyAuthorization on every request, or at least if
  // FAuthProxyRetries is 1, or the server has sent a new 'Proxy-Authenticate'
  // list that does not include the class currently assigned...
  if not Assigned(ProxyParams.Authentication) then begin
    // Find which Authentication method is supported from us.
    LAuthCls := nil;

    for i := 0 to AResponse.ProxyAuthenticate.Count-1 do begin
      S := AResponse.ProxyAuthenticate[i];
      LAuthCls := FindAuthClass(Fetch(S));
      if Assigned(LAuthCls) then begin
        Break;
      end;
    end;

    // let the user override us, if desired.
    if Assigned(FOnSelectProxyAuthorization) then begin
      OnSelectProxyAuthorization(Self, LAuthCls, AResponse.ProxyAuthenticate);
    end;

    if not Assigned(LAuthCls) then begin
      Result := False;
      Exit;
    end;

    ProxyParams.Authentication := LAuthCls.Create;
  end;

  {
  this is commented out as it breaks SSPI and NTLM authentication. it is
  normal and expected to get multiple 407 responses during negotiation.

  // Clear password and reset authorization if previous failed
  if (AResponse.FResponseCode = 407) then begin
    ProxyParams.ProxyPassword := '';
    ProxyParams.Authentication.Reset;
  end;
  }

  // RLebeau 11/18/2014: Added part about the password. Not testing user name
  // as some proxies do not require user name, only password.
  //
  // RLebeau 11/18/2014: what about SSPI? It does not require an explicit
  // username/password as it can use the identity of the user token associated
  // with the calling thread!

  LAuth := ProxyParams.Authentication;
  LAuth.Username := ProxyParams.ProxyUsername;
  LAuth.Password := ProxyParams.ProxyPassword;
  // TODO: do we need to set this, like DoOnAuthorization does?
  //LAuth.Params.Values['Authorization'] := ProxyParams.Authentication; {do not localize}
  LAuth.AuthParams := AResponse.ProxyAuthenticate;

  Result := False;

  repeat
    case LAuth.Next of
      wnAskTheProgram: // Ask the user porgram to supply us with authorization information
        begin
          if not Assigned(OnProxyAuthorization) then begin
            Result := False;
            Break;
          end;

          LAuth.Username := ProxyParams.ProxyUsername;
          LAuth.Password := ProxyParams.ProxyPassword;

          OnProxyAuthorization(Self, LAuth, Result);
          if not Result then begin
            Break;
          end;

          // TODO: do we need to set this, like DoOnAuthorization does?
          //ProxyParams.BasicAuthentication := True;
          ProxyParams.ProxyUsername := LAuth.Username;
          ProxyParams.ProxyPassword := LAuth.Password;
        end;
      wnDoRequest:
        begin
          Result := True;
          Break;
        end;
      wnFail:
        begin
          Result := False;
          Break;
        end;
    end;
  until False;
end;

function TIdCustomHTTP.GetResponseCode: Integer;
begin
  Result := Response.ResponseCode;
end;

function TIdCustomHTTP.GetResponseText: string;
begin
  Result := Response.ResponseText;
end;

function TIdCustomHTTP.GetResponse: TIdHTTPResponse;
begin
  Result := FHTTPProto.Response;
end;

function TIdCustomHTTP.GetRequest: TIdHTTPRequest;
begin
  Result := FHTTPProto.Request;
end;

function TIdCustomHTTP.GetMetaHTTPEquiv: TIdMetaHTTPEquiv;
begin
  Result := Response.MetaHTTPEquiv;
end;

procedure TIdCustomHTTP.DoOnDisconnected;
var
  // under ARC, convert weak references to strong references before working with them
  LAuthManager: TIdAuthenticationManager;
  LAuth: TIdAuthentication;
begin
  // TODO: in order to handle the case where authentications are used when
  // keep-alives are in effect, move this logic somewhere more appropriate,
  // like at the end of DoRequest()...

  inherited DoOnDisconnected;

  LAuth := Request.Authentication;
  if Assigned(LAuth) and (LAuth.CurrentStep = LAuth.Steps) then
  begin
    LAuthManager := AuthenticationManager;
    if Assigned(LAuthManager) then begin
      LAuthManager.AddAuthentication(LAuth, URL);
    end;
    {$IFNDEF USE_OBJECT_ARC}
    LAuth.Free;
    {$ENDIF}
    Request.Authentication := nil;
  end;

  LAuth := ProxyParams.Authentication;
  if Assigned(LAuth) and (LAuth.CurrentStep = LAuth.Steps) then begin
    LAuth.Reset;
  end;
end;

procedure TIdCustomHTTP.SetAuthenticationManager(Value: TIdAuthenticationManager);
begin
  {$IFDEF USE_OBJECT_ARC}
  // under ARC, all weak references to a freed object get nil'ed automatically
  FAuthenticationManager := Value;
  {$ELSE}
  if FAuthenticationManager <> Value then begin
    if Assigned(FAuthenticationManager) then begin
      FAuthenticationManager.RemoveFreeNotification(self);
    end;
    FAuthenticationManager := Value;
    if Assigned(FAuthenticationManager) then begin
      FAuthenticationManager.FreeNotification(Self);
    end;
  end;
  {$ENDIF}
end;

{
procedure TIdCustomHTTP.SetHost(const Value: string);
begin
  inherited SetHost(Value);
  URL.Host := Value;
end;

procedure TIdCustomHTTP.SetPort(const Value: integer);
begin
  inherited SetPort(Value);
  URL.Port := IntToStr(Value);
end;
}
procedure TIdCustomHTTP.SetRequest(Value: TIdHTTPRequest);
begin
  FHTTPProto.Request.Assign(Value);
end;

procedure TIdCustomHTTP.SetProxyParams(AValue: TIdProxyConnectionInfo);
begin
  FProxyParameters.Assign(AValue);
end;

procedure TIdCustomHTTP.Post(AURL: string; ASource: TIdMultiPartFormDataStream;
  AResponseContent: TStream);
begin
  Assert(ASource<>nil);
  Request.ContentType := ASource.RequestContentType;
  // TODO: Request.CharSet := ASource.RequestCharSet;
  Post(AURL, TStream(ASource), AResponseContent);
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TIdMultiPartFormDataStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
): string;
begin
  Assert(ASource<>nil);
  Request.ContentType := ASource.RequestContentType;
  // TODO: Request.CharSet := ASource.RequestCharSet;
  Result := Post(AURL, TStream(ASource){$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
end;

{ TIdHTTPResponse }

constructor TIdHTTPResponse.Create(AHTTP: TIdCustomHTTP);
begin
  inherited Create(AHTTP);
  FHTTP := AHTTP;
  FResponseCode := -1;
  FMetaHTTPEquiv := TIdMetaHTTPEquiv.Create(AHTTP);
end;

destructor TIdHTTPResponse.Destroy;
begin
  FreeAndNil(FMetaHTTPEquiv);
  inherited Destroy;
end;

procedure TIdHTTPResponse.Clear;
begin
  inherited Clear;
  ResponseText := '';
  FMetaHTTPEquiv.Clear;
end;

procedure TIdHTTPResponse.ProcessMetaHTTPEquiv;
var
  StdValues: TStringList;
  I: Integer;
  Name: String;
begin
  FMetaHTTPEquiv.ProcessMetaHTTPEquiv(ContentStream);
  if FMetaHTTPEquiv.RawHeaders.Count > 0 then begin
    // TODO: optimize this
    StdValues := TStringList.Create;
    try
      FMetaHTTPEquiv.RawHeaders.ConvertToStdValues(StdValues);
      for I := 0 to StdValues.Count-1 do begin
        Name := StdValues.Names[I];
        if Name <> '' then begin
          RawHeaders.Values[Name] := IndyValueFromIndex(StdValues, I);
        end;
      end;
    finally
      StdValues.Free;
    end;
    ProcessHeaders;
  end;
  if FMetaHTTPEquiv.CharSet <> '' then begin
    FCharSet := FMetaHTTPEquiv.CharSet;
  end;
end;

function TIdHTTPResponse.GetKeepAlive: Boolean;
begin
  if FHTTP.Connected then begin
    FHTTP.IOHandler.CheckForDisconnect(False);
  end;

  // has the connection already been closed?
  FKeepAlive := FHTTP.Connected;

  if FKeepAlive then
  begin
    // did the client request the connection to be closed?
    FKeepAlive := not TextIsSame(Trim(FHTTP.Request.Connection), 'CLOSE');   {do not localize}
    if FKeepAlive and (FHTTP.Request.UseProxy in [ctProxy, ctSSLProxy]) then begin
      FKeepAlive := not TextIsSame(Trim(FHTTP.Request.ProxyConnection), 'CLOSE');   {do not localize}
    end;
  end;

  if FKeepAlive then
  begin
    // did the server/proxy say the connection will be closed?
    case FHTTP.ProtocolVersion of // TODO: use ResponseVersion instead?
      pv1_1:
        { By default we assume that keep-alive is used and will close
          the connection only if there is "close" }
        begin
          FKeepAlive := not TextIsSame(Trim(Connection), 'CLOSE'); {do not localize}
          if FKeepAlive and (FHTTP.Request.UseProxy in [ctProxy, ctSSLProxy]) then begin
            FKeepAlive := not TextIsSame(Trim(ProxyConnection), 'CLOSE'); {do not localize}
          end;
        end;
      pv1_0:
        { By default we assume that keep-alive is not used and will keep
          the connection only if there is "keep-alive" }
        begin
          FKeepAlive := TextIsSame(Trim(Connection), 'KEEP-ALIVE') {do not localize}
            { or ((ResponseVersion = pv1_1) and (Trim(Connection) = '')) }
            ;
          if FKeepAlive and (FHTTP.Request.UseProxy in [ctProxy, ctSSLProxy]) then begin
            FKeepAlive := TextIsSame(Trim(ProxyConnection), 'KEEP-ALIVE') {do not localize}
              { or ((ResponseVersion = pv1_1) and (Trim(ProxyConnection) = '')) }
              ;
          end;
        end;
    end;
  end;

  Result := FKeepAlive;
end;

function TIdHTTPResponse.GetResponseCode: Integer;
var
  S, Tmp: string;
begin
  if FResponseCode = -1 then
  begin
    S := FResponseText;
    Fetch(S);
    S := Trim(S);
    // RLebeau: IIS supports status codes with decimals in them, but it is not supposed to
    // transmit them to clients, which is a violation of RFC 2616. But have seen it happen,
    // so check for it...
    Tmp := Fetch(S, ' ', False); {do not localize}
    S := Fetch(Tmp, '.', False); {do not localize}
    FResponseCode := IndyStrToInt(S, -1);
  end;
  Result := FResponseCode;
end;

procedure TIdHTTPResponse.SetResponseText(const AValue: String);
var
  S: String;
  i: TIdHTTPProtocolVersion;
begin
  FResponseText := AValue;
  FResponseCode := -1; // re-parse the next time it is accessed
  FResponseVersion := pv1_0; // default until determined otherwise...
  S := Copy(FResponseText, 6, 3);
  for i := Low(TIdHTTPProtocolVersion) to High(TIdHTTPProtocolVersion) do begin
    if TextIsSame(ProtocolVersionString[i], S) then begin
      FResponseVersion := i;
      Exit;
    end;
  end;
end;

{ TIdHTTPRequest }

constructor TIdHTTPRequest.Create(AHTTP: TIdCustomHTTP);
begin
  inherited Create(AHTTP);
  FHTTP := AHTTP;
  FUseProxy := ctNormal;
  FIPVersion := ID_DEFAULT_IP_VERSION;
end;

{ TIdHTTPProtocol }

constructor TIdHTTPProtocol.Create(AConnection: TIdCustomHTTP);
begin
  inherited Create;
  FHTTP := AConnection;
  // Create the headers
  FRequest := TIdHTTPRequest.Create(FHTTP);
  FResponse := TIdHTTPResponse.Create(FHTTP);
end;

destructor TIdHTTPProtocol.Destroy;
begin
  FreeAndNil(FRequest);
  FreeAndNil(FResponse);
  inherited Destroy;
end;

procedure TIdHTTPProtocol.BuildAndSendRequest(AURI: TIdURI);
var
  i: Integer;
  LBufferingStarted: Boolean;
begin
  Response.Clear;

  // needed for Digest authentication, but maybe others as well...
  if Assigned(Request.Authentication) then begin
    // TODO: include entity body for Digest "auth-int" qop...
    Request.Authentication.SetRequest(Request.Method, Request.URL);
  end;

  // TODO: disable header folding for HTTP 1.0 requests
  Request.SetHeaders;
  FHTTP.ProxyParams.SetHeaders(Request.RawHeaders);
  if Assigned(AURI) then begin
    FHTTP.SetCookies(AURI, Request);
  end;

  // This is a workaround for some HTTP servers which do not implement
  // the HTTP protocol properly
  LBufferingStarted := not FHTTP.IOHandler.WriteBufferingActive;
  if LBufferingStarted then begin
    FHTTP.IOHandler.WriteBufferOpen;
  end;
  try
    FHTTP.IOHandler.WriteLn(Request.Method + ' ' + Request.URL + ' HTTP/' + ProtocolVersionString[FHTTP.ProtocolVersion]); {do not localize}
    // write the headers
    for i := 0 to Request.RawHeaders.Count - 1 do begin
      if Length(Request.RawHeaders.Strings[i]) > 0 then begin
        FHTTP.IOHandler.WriteLn(Request.RawHeaders.Strings[i]);
      end;
    end;
    FHTTP.IOHandler.WriteLn;
    if LBufferingStarted then begin
      FHTTP.IOHandler.WriteBufferClose;
    end;
  except
    if LBufferingStarted then begin
      FHTTP.IOHandler.WriteBufferCancel;
    end;
    raise;
  end;
end;

procedure TIdHTTPProtocol.RetrieveHeaders(AMaxHeaderCount: integer);
var
  s: string;
  LHeaderCount: Integer;
begin
  // Set the response headers
  // Don't use Capture.
  // S.G. 6/4/2004: Added AmaxHeaderCount parameter to prevent the "header bombing" of the server
  s := FHTTP.InternalReadLn;
  try
    LHeaderCount := 0;
    while (s <> '') and ( (AMaxHeaderCount > 0) or (LHeaderCount < AMaxHeaderCount) ) do
    begin
      Response.RawHeaders.Add(S);
      s := FHTTP.InternalReadLn;
      Inc(LHeaderCount);
    end;
  except
    on E: Exception do begin
      FHTTP.Disconnect;
      if not (E is EIdConnClosedGracefully) then begin
        raise;
      end;
    end;
  end;
  Response.ProcessHeaders;
end;

function TIdHTTPProtocol.ProcessResponse(AIgnoreReplies: array of Int16): TIdHTTPWhatsNext;
var
  LResponseCode, LResponseDigit: Integer;

  procedure CheckException;
  var
    i: Integer;
    LTempStream: TMemoryStream;
    LOrigStream: TStream;
    LRaiseException: Boolean;
    LDiscardContent: Boolean;
  begin
    LRaiseException := True;
    LDiscardContent := True;
    
    if hoNoProtocolErrorException in FHTTP.HTTPOptions then begin
      LRaiseException := False;
      LDiscardContent := not (hoWantProtocolErrorContent in FHTTP.HTTPOptions);
    end
    else if High(AIgnoreReplies) > -1 then begin
      for i := Low(AIgnoreReplies) to High(AIgnoreReplies) do begin
        if LResponseCode = AIgnoreReplies[i] then begin
          LRaiseException := False;
          LDiscardContent := not (hoWantProtocolErrorContent in FHTTP.HTTPOptions);
          Break;
        end;
      end;
    end;

    if LRaiseException then begin
      LTempStream := TMemoryStream.Create;
    end else begin
      LTempStream := nil;
    end;
    try
      if LRaiseException or LDiscardContent then begin
        LOrigStream := Response.ContentStream;
        Response.ContentStream := LTempStream;
      end else begin
        LOrigStream := nil;
      end;
      try
        try
          FHTTP.ReadResult(Request, Response);
        except
          on E: Exception do begin
            FHTTP.Disconnect;
            if not (E is EIdConnClosedGracefully) then begin
              raise;
            end;
          end;
        end;
        if LRaiseException then begin
          LTempStream.Position := 0;
          raise EIdHTTPProtocolException.CreateError(LResponseCode, Response.ResponseText,
            ReadStringAsCharset(LTempStream, Response.CharSet));
        end;
      finally
        if LRaiseException or LDiscardContent then begin
          Response.ContentStream := LOrigStream;
        end;
      end;
    finally
      if LRaiseException then begin
        LTempStream.Free;
      end;
    end;
  end;

  procedure DiscardContent;
  var
    LOrigStream: TStream;
  begin
    LOrigStream := Response.ContentStream;
    Response.ContentStream := nil;
    try
      try
        FHTTP.ReadResult(Request, Response);
      except
        on E: Exception do begin
          FHTTP.Disconnect;
          if not (E is EIdConnClosedGracefully) then begin
            raise;
          end;
        end;
      end;
    finally
      Response.ContentStream := LOrigStream;
    end;
  end;

  function HeadersCanContinue: Boolean;
  begin
    Result := True;
    if Assigned(FHTTP.OnHeadersAvailable) then begin
      FHTTP.OnHeadersAvailable(FHTTP, Response.RawHeaders, Result);
    end;
  end;

var
  LLocation: string;
  LMethod: TIdHTTPMethod;
  LNeedAuth: Boolean;
  //LTemp: Integer;
begin

  // provide the user with the headers and let the user decide
  // whether the response processing should continue...
  if not HeadersCanContinue then begin
    // TODO: provide the user an option whether to force DoRequest() to disconnect the connection or not
    Response.KeepAlive := False;
    Response.Connection := 'close'; {do not localize}
    Result := wnJustExit;
    Exit;
  end;

  // Cache this as ResponseCode calls GetResponseCode which parses it out
  LResponseCode := Response.ResponseCode;
  LResponseDigit := LResponseCode div 100;
  LNeedAuth := False;

  // Handle Redirects
  // RLebeau: All 3xx replies other than 304 are redirects. Reply 201 has a
  // Location header but is NOT a redirect!

  // RLebeau 4/21/2011: Amazon S3 includes a Location header in its 200 reply
  // to some PUT requests.  Not sure if this is a bug or intentional, but we
  // should NOT perform a redirect for any replies other than 3xx. Amazon S3
  // does NOT include a Location header in its 301 reply, though!  This is
  // intentional, per Amazon's documentation, as a way for developers to
  // detect when URLs are addressed incorrectly...

  if (LResponseDigit = 3) and (LResponseCode <> 304) then
  begin
    if Response.Location = '' then begin
      CheckException;
      Result := wnJustExit;
      Exit;
    end;

    Inc(FHTTP.FRedirectCount);

    // LLocation := TIdURI.URLDecode(Response.Location);
    LLocation := Response.Location;
    LMethod := Request.Method;

    // fire the event
    if not FHTTP.DoOnRedirect(LLocation, LMethod, FHTTP.FRedirectCount) then begin
      CheckException;
      Result := wnJustExit;
      Exit;
    end;

    if (FHTTP.FHandleRedirects) and (FHTTP.FRedirectCount < FHTTP.FRedirectMax) then begin
      Result := wnGoToURL;
      Request.URL := LLocation;

      // GDG 21/11/2003. If it's a 303, we should do a get this time

      // RLebeau 7/15/2004 - do a GET on 302 as well, as mentioned in RFC 2616

      // RLebeau 1/11/2008 - turns out both situations are WRONG! RFCs 2068 and
      // 2616 specifically state that changing the method to GET in response
      // to 302 and 303 is errorneous.  Indy 9 did it right by reusing the
      // original method and source again and only changing the URL, so lets
      // revert back to that same behavior!

      // RLebeau 12/28/2012 - one more time. RFCs 2068 and 2616 actually say that
      // changing the method in response to 302 is erroneous, but changing the
      // method to GET in response to 303 is intentional and why 303 was introduced
      // in the first place. Erroneous clients treat 302 as 303, though.  Now
      // encountering servers that actually expect this 303 behavior, so we have
      // to enable it again! Adding an optional HTTPOption flag so clients can
      // enable the erroneous 302 behavior if they really need it.

      if ((LResponseCode = 302) and (hoTreat302Like303 in FHTTP.HTTPOptions)) or
          (LResponseCode = 303) then
      begin
        Request.Source := nil;
        Request.Method := Id_HTTPMethodGet;
        // TODO: if the previous request was a POST with an 'application/x-www-webform-urlencoded'
        // body, move the body data into the URL query string this time...
      end else begin
        Request.Method := LMethod;
      end;
      Request.MethodOverride := '';
    end else begin
      Result := wnJustExit;
      Response.Location := LLocation;
    end;

    if FHTTP.Connected then begin
      // This is a workaround for buggy HTTP 1.1 servers which
      // does not return any body with 302 response code
      DiscardContent; // may wait a few seconds for any kind of content
    end;
  end else begin
    //Ciaran, 30th Nov 2004: I commented out the following code.  When a https server
    //sends a disconnect immediately after sending the requested page in an SSL
    //session (which they sometimes do to indicate a "session" is finished), the code
    //below causes a "Connection closed gracefully" exception BUT the returned page
    //is lost (IOHandler.Request is empty).  If the code below is re-enabled by
    //someone for whatever reason, they MUST test for this case.
    // GREGOR Workaround
    // if we get an error we disconnect if we use SSLIOHandler
    //if Assigned(FHTTP.IOHandler) then
    //begin
    //  Response.KeepAlive := not (FHTTP.Connected and (FHTTP.IOHandler is TIdSSLIOHandlerSocketBase) and Response.KeepAlive);
    //end;

    // RLebeau 2/15/2006: RFC 1945 states the following:
    //
    // For response messages, whether or not an entity body is included with
    // a message is dependent on both the request method and the response
    // code. All responses to the HEAD request method must not include a
    // body, even though the presence of entity header fields may lead one
    // to believe they do. All 1xx (informational), 204 (no content), and
    // 304 (not modified) responses must not include a body. All other
    // responses must include an entity body or a Content-Length header
    // field defined with a value of zero (0).

    if LResponseDigit <> 2 then begin
      case LResponseCode of
        101:
          begin
            Response.KeepAlive := True;
            Result := wnJustExit;
            Exit;
          end;
        401:
          begin // HTTP Server authorization required
            if (FHTTP.AuthRetries >= FHTTP.MaxAuthRetries) or
               (not FHTTP.DoOnAuthorization(Request, Response)) then begin
              if Assigned(Request.Authentication) then begin
                Request.Authentication.Reset;
              end;
              CheckException;
              Result := wnJustExit;
              Exit;
            end else begin
              LNeedAuth := hoInProcessAuth in FHTTP.HTTPOptions;
            end;
          end;
        407:
          begin // Proxy Server authorization requered
            if (FHTTP.AuthProxyRetries >= FHTTP.MaxAuthRetries) or
               (not FHTTP.DoOnProxyAuthorization(Request, Response)) then
            begin
              if Assigned(FHTTP.ProxyParams.Authentication) then begin
                FHTTP.ProxyParams.Authentication.Reset;
              end;
              CheckException;
              Result := wnJustExit;
              Exit;
            end else begin
              LNeedAuth := hoInProcessAuth in FHTTP.HTTPOptions;
            end;
          end;
        else begin
          CheckException;
          Result := wnJustExit;
          Exit;
        end;
      end;
    end;

    if LNeedAuth then begin
      // discard the content of Error message
      DiscardContent;
      Result := wnAuthRequest;
    end else
    begin
      // RLebeau 6/30/2006: DO NOT READ IF THE REQUEST IS HEAD!!!
      // The server is supposed to send a 'Content-Length' header
      // without sending the actual data...
      if TextIsSame(Request.Method, Id_HTTPMethodHead) or
         TextIsSame(Request.MethodOverride, Id_HTTPMethodHead) or
         (LResponseCode = 204) then
      begin
        // Have noticed one case where a non-conforming server did send an
        // entity body in response to a HEAD request.  If requested, ignore
        // anything the server may send by accident
        DiscardContent;
      end else begin
        FHTTP.ReadResult(Request, Response);
      end;
      Result := wnJustExit;
    end;
  end;
end;

function TIdCustomHTTP.CreateProtocol: TIdHTTPProtocol;
begin
  Result := TIdHTTPProtocol.Create(Self);
end;

procedure TIdCustomHTTP.InitComponent;
begin
  inherited;
  FURI := TIdURI.Create('');

  FAuthRetries := 0;
  FAuthProxyRetries := 0;
  AllowCookies := True;
  FImplicitCookieManager := False;
  FOptions := [hoForceEncodeParams];

  FRedirectMax := Id_TIdHTTP_RedirectMax;
  FHandleRedirects := Id_TIdHTTP_HandleRedirects;
  //
  FProtocolVersion := Id_TIdHTTP_ProtocolVersion;

  FHTTPProto := CreateProtocol;
  FProxyParameters := TIdProxyConnectionInfo.Create;
  FProxyParameters.Clear;

  FMaxAuthRetries := Id_TIdHTTP_MaxAuthRetries;
  FMaxHeaderLines := Id_TIdHTTP_MaxHeaderLines;
end;

function TIdCustomHTTP.InternalReadLn: String;
begin
  // TODO: add ReadLnTimeoutAction property to TIdIOHandler...
  Result := IOHandler.ReadLn;
  if IOHandler.ReadLnTimedout then begin
    raise EIdReadTimeout.Create(RSReadTimeout);
  end;
end;

function TIdCustomHTTP.Get(AURL: string; AIgnoreReplies: array of Int16
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    Get(AURL, LStream, AIgnoreReplies);
    LStream.Position := 0;
    Result := ReadStringAsCharset(LStream, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdCustomHTTP.Get(AURL: string; AResponseContent: TStream;
  AIgnoreReplies: array of Int16);
begin
  DoRequest(Id_HTTPMethodGet, AURL, nil, AResponseContent, AIgnoreReplies);
end;

procedure TIdCustomHTTP.DoRequest(const AMethod: TIdHTTPMethod;
  AURL: string; ASource, AResponseContent: TStream;
  AIgnoreReplies: array of Int16);
var
  LResponseLocation: TIdStreamSize;
begin
  //reset any counters
  FRedirectCount := 0;
  FAuthRetries := 0;
  FAuthProxyRetries := 0;

  if Assigned(AResponseContent) then begin
    LResponseLocation := AResponseContent.Position;
  end else begin
    LResponseLocation := 0; // Just to avoid the warning message
  end;

  Request.URL := AURL;
  Request.Method := AMethod;
  Request.Source := ASource;
  Response.ContentStream := AResponseContent;

  try
    repeat
      PrepareRequest(Request);
      if IOHandler is TIdSSLIOHandlerSocketBase then begin
        TIdSSLIOHandlerSocketBase(IOHandler).URIToCheck := FURI.URI;
      end;
      ConnectToHost(Request, Response);

      // Workaround for servers which respond with 100 Continue on GET and HEAD
      // This workaround is just for temporary use until we have final HTTP 1.1
      // realisation. HTTP 1.1 is ongoing because of all the buggy and conflicting servers.
      //
      // This is also necessary as servers are allowed to send any number of
      // 1xx informational responses before sending the final response.
      //
      // Except in the case of 101 SWITCHING PROTOCOLS, which is a final response.
      // The protocol on the line is then switched to the requested protocol, per
      // the response's 'Upgrade' header, following the 101 response, so we need to
      // stop and exit immediately if 101 is received, and let the caller handle
      // the new protocol as needed.
      repeat
        Response.ResponseText := InternalReadLn;
        FHTTPProto.RetrieveHeaders(MaxHeaderLines);
        ProcessCookies(Request, Response);
        if ((Response.ResponseCode div 100) <> 1) or (Response.ResponseCode = 101) then begin
          Break;
        end;
        Response.Clear;
      until False;

      case FHTTPProto.ProcessResponse(AIgnoreReplies) of
        wnAuthRequest:
          begin
            Request.URL := AURL;
          end;
        wnReadAndGo:
          begin
            ReadResult(Request, Response);
            if Assigned(AResponseContent) then begin
              AResponseContent.Position := LResponseLocation;
              AResponseContent.Size := LResponseLocation;
            end;
            FAuthRetries := 0;
            FAuthProxyRetries := 0;
          end;
        wnGoToURL:
          begin
            if Assigned(AResponseContent) then begin
              AResponseContent.Position := LResponseLocation;
              AResponseContent.Size := LResponseLocation;
            end;
            FAuthRetries := 0;
            FAuthProxyRetries := 0;
          end;
        wnJustExit:
          begin
            Break;
          end;
        wnDontKnow:
          begin
            raise EIdException.Create(RSHTTPNotAcceptable); // TODO: create a new Exception class for this
          end;
      end;
    until False;
  finally
    if not (
      Response.KeepAlive or
      ((hoNoReadMultipartMIME in FOptions) and IsHeaderMediaType(Response.ContentType, 'multipart')) or   {do not localize}
      ((hoNoReadChunked in FOptions) and (IndyPos('chunked', LowerCase(Response.TransferEncoding)) > 0))  {do not localize}
    ) then
    begin
      Disconnect;
    end;
  end;
end;

procedure TIdCustomHTTP.Patch(AURL: string; ASource, AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodPatch, AURL, ASource, AResponseContent, []);
end;

function TIdCustomHTTP.Patch(AURL: string; ASource: TStream
  {$IFDEF STRING_IS_ANSI}; ADestEncoding: IIdTextEncoding = nil{$ENDIF}
  ): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Patch(AURL, ASource, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, Response.Charset{$IFDEF STRING_IS_ANSI}, ADestEncoding{$ENDIF});
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

end.

