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
  IdMultipartFormData, IdGlobal, IdBaseComponent;

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
  //(hmHead, hmGet, hmPost, hmOptions, hmTrace, hmPut, hmDelete, hmConnect);

type
  TIdHTTPWhatsNext = (wnGoToURL, wnJustExit, wnDontKnow, wnReadAndGo, wnAuthRequest);
  TIdHTTPConnectionType = (ctNormal, ctSSL, ctProxy, ctSSLProxy);

  // Protocol options
  TIdHTTPOption = (hoInProcessAuth, hoKeepOrigProtocol, hoForceEncodeParams, hoNonSSLProxyUseConnectVerb, hoNoParseMetaHTTPEquiv);
  TIdHTTPOptions = set of TIdHTTPOption;

  // Must be documented
  TIdHTTPProtocolVersion = (pv1_0, pv1_1);

  TIdHTTPOnRedirectEvent = procedure(Sender: TObject; var dest: string; var NumRedirect: Integer; var Handled: boolean; var VMethod: TIdHTTPMethod) of object;
  TIdHTTPOnHeadersAvailable = procedure(Sender: TObject; AHeaders: TIdHeaderList; var VContinue: Boolean) of object;
  TIdOnSelectAuthorization = procedure(Sender: TObject; var AuthenticationClass: TIdAuthenticationClass; AuthInfo: TIdHeaderList) of object;
  TIdOnAuthorization = procedure(Sender: TObject; Authentication: TIdAuthentication; var Handled: Boolean) of object;
  // TIdProxyOnAuthorization = procedure(Sender: TObject; Authentication: TIdAuthentication; var Handled: boolean) of object;

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
    FHTTP: TIdCustomHTTP;
    FResponseCode: Integer;
    FResponseText: string;
    FKeepAlive: Boolean;
    FContentStream: TStream;
    FResponseVersion: TIdHTTPProtocolVersion;
    //
    function GetKeepAlive: Boolean;
    function GetResponseCode: Integer;
  public
    constructor Create(AHTTP: TIdCustomHTTP); reintroduce; virtual;
    property KeepAlive: Boolean read GetKeepAlive write FKeepAlive;
    property ResponseText: string read FResponseText write FResponseText;
    property ResponseCode: Integer read GetResponseCode write FResponseCode;
    property ResponseVersion: TIdHTTPProtocolVersion read FResponseVersion write FResponseVersion;
    property ContentStream: TStream read FContentStream write FContentStream;
  end;

  TIdHTTPRequest = class(TIdRequestHeaderInfo)
  protected
    FHTTP: TIdCustomHTTP;
    FURL: string;
    FMethod: TIdHTTPMethod;
    FSourceStream: TStream;
    FUseProxy: TIdHTTPConnectionType;
    FIPVersion: TIdIPVersion;
  public
    constructor Create(AHTTP: TIdCustomHTTP); reintroduce; virtual;
    property URL: string read FURL write FURL;
    property Method: TIdHTTPMethod read FMethod write FMethod;
    property Source: TStream read FSourceStream write FSourceStream;
    property UseProxy: TIdHTTPConnectionType read FUseProxy;
    property IPVersion: TIdIPversion read FIPVersion write FIPVersion;
  end;

  TIdHTTPProtocol = class(TObject)
  protected
    FHTTP: TIdCustomHTTP;
    FResponseCode: Integer;
    FRequest: TIdHTTPRequest;
    FResponse: TIdHTTPResponse;
  public
    constructor Create(AConnection: TIdCustomHTTP);
    destructor Destroy; override;
    function ProcessResponse(AIgnoreReplies: array of SmallInt): TIdHTTPWhatsNext;
    procedure BuildAndSendRequest(AURI: TIdURI);
    procedure RetrieveHeaders(AMaxHeaderCount: integer);
    //
    property ResponseCode: Integer read FResponseCode;
    property Request: TIdHTTPRequest read FRequest;
    property Response: TIdHTTPResponse read FResponse;
  end;

  TIdCustomHTTP = class(TIdTCPClientCustom)
  protected
    {Retries counter for WWW authorization}
    FAuthRetries: Integer;
    {Retries counter for proxy authorization}
    FAuthProxyRetries: Integer;
    FCookieManager: TIdCookieManager;
    FCompressor : TIdZLibCompressorBase;
    FFreeCookieManager: Boolean;
    {Max retries for authorization}
    FMaxAuthRetries: Integer;
    FMaxHeaderLines: integer;
    FAllowCookies: Boolean;
    FAuthenticationManager: TIdAuthenticationManager;
    FProtocolVersion: TIdHTTPProtocolVersion;

    {this is an internal counter for redirects}
    FRedirectCount: Integer;
    FRedirectMax: Integer;
    FHandleRedirects: Boolean;
    FOptions: TIdHTTPOptions;
    FURI: TIdURI;
    FHTTPProto: TIdHTTPProtocol;
    FMetaHTTPEquiv :  TIdMetaHTTPEquiv;
    FProxyParameters: TIdProxyConnectionInfo;
    //
    FOnHeadersAvailable: TIdHTTPOnHeadersAvailable;
    FOnRedirect: TIdHTTPOnRedirectEvent;
    FOnSelectAuthorization: TIdOnSelectAuthorization;
    FOnSelectProxyAuthorization: TIdOnSelectAuthorization;
    FOnAuthorization: TIdOnAuthorization;
    FOnProxyAuthorization: TIdOnAuthorization;
    //
{
    procedure SetHost(const Value: string); override;
    procedure SetPort(const Value: integer); override;
}
    procedure DoRequest(const AMethod: TIdHTTPMethod; AURL: string;
      ASource, AResponseContent: TStream; AIgnoreReplies: array of SmallInt); virtual;
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
    procedure ReadResult(AResponse: TIdHTTPResponse; AUnexpectedContentTimeout: Integer = IdTimeoutDefault);
    procedure PrepareRequest(ARequest: TIdHTTPRequest);
    procedure ConnectToHost(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
    function GetResponseHeaders: TIdHTTPResponse;
    function GetRequestHeaders: TIdHTTPRequest;
    procedure SetRequestHeaders(Value: TIdHTTPRequest);

    function SetRequestParams(ASource: TStrings): string;

    procedure CheckAndConnect(AResponse: TIdHTTPResponse);
    procedure DoOnDisconnected; override;

    //misc internal stuff
    function ResponseCharset : String;
  public
    destructor Destroy; override;

    procedure Delete(AURL: string);

    procedure Options(AURL: string); overload;
    procedure Get(AURL: string; AResponseContent: TStream); overload;
    procedure Get(AURL: string; AResponseContent: TStream; AIgnoreReplies: array of SmallInt);
     overload;
    function Get(AURL: string): string; overload;
    function Get(AURL: string; AIgnoreReplies: array of SmallInt): string; overload;
    procedure Trace(AURL: string; AResponseContent: TStream); overload;
    function Trace(AURL: string): string; overload;
    procedure Head(AURL: string);

    function Post(AURL: string; const ASourceFile: String): string; overload;
    function Post(AURL: string; ASource: TStrings): string; overload;
    function Post(AURL: string; ASource: TStream): string; overload;
    function Post(AURL: string; ASource: TIdMultiPartFormDataStream): string; overload;

    procedure Post(AURL: string; const ASourceFile: String; AResponseContent: TStream); overload;
    procedure Post(AURL: string; ASource: TStrings; AResponseContent: TStream); overload;
    procedure Post(AURL: string; ASource, AResponseContent: TStream); overload;
    procedure Post(AURL: string; ASource: TIdMultiPartFormDataStream; AResponseContent: TStream); overload;

    function Put(AURL: string; ASource: TStream): string; overload;
    procedure Put(AURL: string; ASource, AResponseContent: TStream); overload;

    {This is an object that can compress and decompress HTTP Deflate encoding}
    property Compressor : TIdZLibCompressorBase read FCompressor write FCompressor;

    {This is the response code number such as 404 for File not Found}
    property ResponseCode: Integer read GetResponseCode;
    {This is the text of the message such as "404 File Not Found here Sorry"}
    property ResponseText: string read GetResponseText;
    property Response: TIdHTTPResponse read GetResponseHeaders;
    property MetaHTTPEquiv :  TIdMetaHTTPEquiv read FMetaHTTPEquiv;
    { This is the last processed URL }
    property URL: TIdURI read FURI;
    // number of retry attempts for Authentication
    property AuthRetries: Integer read FAuthRetries;
    property AuthProxyRetries: Integer read FAuthProxyRetries;
    // maximum number of Authentication retries permitted
    property MaxAuthRetries: Integer read FMaxAuthRetries write FMaxAuthRetries default Id_TIdHTTP_MaxAuthRetries;
    property AllowCookies: Boolean read FAllowCookies write SetAllowCookies;
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
    property ProxyParams: TIdProxyConnectionInfo read FProxyParameters write FProxyParameters;
    property Request: TIdHTTPRequest read GetRequestHeaders write SetRequestHeaders;
    property HTTPOptions: TIdHTTPOptions read FOptions write FOptions;
    //
    property OnHeadersAvailable: TIdHTTPOnHeadersAvailable read FOnHeadersAvailable write FOnHeadersAvailable;
    // Fired when a rediretion is requested.
    property OnRedirect: TIdHTTPOnRedirectEvent read FOnRedirect write FOnRedirect;
    property OnSelectAuthorization: TIdOnSelectAuthorization read FOnSelectAuthorization write FOnSelectAuthorization;
    property OnSelectProxyAuthorization: TIdOnSelectAuthorization read FOnSelectProxyAuthorization write FOnSelectProxyAuthorization;
    property OnAuthorization: TIdOnAuthorization read FOnAuthorization write FOnAuthorization;
    property OnProxyAuthorization: TIdOnAuthorization read FOnProxyAuthorization write FOnProxyAuthorization;
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
  Result := IsHeaderMediaType(AInfo.ContentType, 'text/html'); {do not localize}
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
  FreeAndNil(FMetaHTTPEquiv);
  inherited Destroy;
end;

procedure TIdCustomHTTP.Delete(AURL: string);
begin
  DoRequest(Id_HTTPMethodDelete, AURL, nil, nil, []);
end;

procedure TIdCustomHTTP.Options(AURL: string);
begin
  DoRequest(Id_HTTPMethodOptions, AURL, nil, nil, []);
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
    if Connected then begin
      Disconnect;
    end;
    if not (hoKeepOrigProtocol in FOptions) then begin
      FProtocolVersion := pv1_0;
    end;
    DoRequest(Id_HTTPMethodPost, AURL, ASource, AResponseContent, []);
  finally
    FProtocolVersion := OldProtocol;
  end;
end;

function TIdCustomHTTP.SetRequestParams(ASource: TStrings): string;
var
  i: Integer;
  LPos: integer;
  LStr: string;
  LTemp: TStringList;

  function EncodeParam(const S: String): String;
  begin
    Result := TIdURI.ParamsEncode(StringReplace(S, ' ', '+', [rfReplaceAll])); {do not localize}
  end;
  
  function EncodeLineBreaks(AStrings: TStrings): String;
  begin
    if AStrings.Count > 1 then begin
      // break trailing CR&LF
      Result := StringReplace(Trim(AStrings.Text), sLineBreak, '&', [rfReplaceAll]); {do not localize}
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
          LPos := IndyPos('=', LStr); {do not localize}
          if LPos > 0 then begin
            LTemp[i] := EncodeParam(LTemp.Names[i]) +
                        '=' + {do not localize}
                        EncodeParam(
                          {$IFDEF HAS_TStrings_ValueFromIndex}
                          LTemp.ValueFromIndex[i]
                          {$ELSE}
                          Copy(LStr, LPos+1, MaxInt)
                          {$ENDIF}
                        );
          end else begin
            LTemp[i] := EncodeParam(LStr);
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

function TIdCustomHTTP.Post(AURL: string; const ASourceFile: String): string;
var
  LSource: TIdReadFileExclusiveStream;
begin
  LSource := TIdReadFileExclusiveStream.Create(ASourceFile);
  try
    Result := Post(AURL, LSource);
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

procedure TIdCustomHTTP.Post(AURL: string; ASource: TStrings; AResponseContent: TStream);
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
      WriteStringToStream(LParams, SetRequestParams(ASource));
      LParams.Position := 0;
      Post(AURL, LParams, AResponseContent);
    finally
      FreeAndNil(LParams);
    end;
  end else begin
    Post(AURL, TStream(nil), AResponseContent);
  end;
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TStrings): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Post(AURL, ASource, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, ResponseCharset);
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TStream): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Post(AURL, ASource, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, ResponseCharset);
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

procedure TIdCustomHTTP.Put(AURL: string; ASource, AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodPut, AURL, ASource, AResponseContent, []);
end;

function TIdCustomHTTP.Put(AURL: string; ASource: TStream): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Put(AURL, ASource, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, ResponseCharset);
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LResponse);
  end;
end;

function TIdCustomHTTP.Get(AURL: string): string;
begin
  Result := Get(AURL, []);
end;

function TIdCustomHTTP.Trace(AURL: string): string;
var
  LResponse: TMemoryStream;
begin
  LResponse := TMemoryStream.Create;
  try
    Trace(AURL, LResponse);
    LResponse.Position := 0;
    Result := ReadStringAsCharset(LResponse, ResponseCharset);
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
begin
  if Assigned(FCookieManager) then
  begin
    // Send secure cookies only if we have Secured connection
    FCookieManager.GenerateClientCookies(
      AURL,
      TextIsSame(AURL.Protocol, 'HTTPS'), {do not localize}
      ARequest.RawHeaders);
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
      if Assigned(IOHandler) then begin
        if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
          TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := True;
        end else begin
          raise EIdIOHandlerPropInvalid.Create(RSIOHandlerPropInvalid);
        end;
      end;
      Result := ctSSLProxy;
    end else begin
      if Assigned(IOHandler) then begin
        if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
          TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := True;
        end;
      end;
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
    LPort := IndyStrToInt(URL.Port, 80);
    if (not TextIsSame(FHost, LHost)) or (LPort <> FPort) then begin
      if Connected then begin
        Disconnect;
      end;
    end;
    if TextIsSame(URL.Protocol, 'HTTPS') then begin  {do not localize}
      // Just check can we do SSL
      if not (IOHandler is TIdSSLIOHandlerSocketBase) then begin
        raise EIdIOHandlerPropInvalid.Create(RSIOHandlerPropInvalid);
      end;
      TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := False;
      Result := ctSSL;
    end else begin
      if IOHandler is TIdSSLIOHandlerSocketBase then begin
        TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := True;
      end;
      Result := ctNormal;
    end;
  end;
  Host := LHost;
  Port := LPort;
end;

procedure TIdCustomHTTP.ReadResult(AResponse: TIdHTTPResponse;
  AUnexpectedContentTimeout: Integer = IdTimeoutDefault);
var
  LS: TStream;
  LOrigStream : TStream;
  Size: Integer;
  LParseHTML : Boolean;
  LCreateTmpContent : Boolean;
  LDecMeth : Integer;
  //0 - no compression was used or we can't support that feature
  //1 - deflate
  //2 - gzip
  LTrailHeader: String;

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

begin
  LDecMeth := 0;

  LParseHTML := IsContentTypeHtml(AResponse) and Assigned(AResponse.ContentStream) and not (hoNoParseMetaHTTPEquiv in FOptions);
  LCreateTmpContent := LParseHTML and not (AResponse.ContentStream is TCustomMemoryStream);

  LOrigStream := Response.ContentStream;
  if LCreateTmpContent then begin
    Response.ContentStream := TMemoryStream.Create;
  end;

  try
    // we need to determine what type of decompression may need to be used
    // before we read from the IOHandler.  If there is compression, then we
    // use a local stream to download the compressed data and decompress it.
    // If no compression is used, ContentStream will be used directly

    if Assigned(AResponse.ContentStream) then begin
      if Assigned(Compressor) and Compressor.IsReady then begin
         case PosInStrArray(AResponse.ContentEncoding, ['deflate', 'gzip'], False) of  {do not localize}
           0: LDecMeth := 1;
           1: LDecMeth := 2;
         end;
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
        DoStatus(hsStatusText, [RSHTTPChunkStarted]);
        BeginWork(wmRead);
        try
          Size := ChunkSize;
          while Size <> 0 do begin
            if Assigned(LS) then begin
              IOHandler.ReadStream(LS, Size);
            end else begin
              IOHandler.Discard(Size);
            end;
            InternalReadLn; // CRLF at end of chunk data
            Size := ChunkSize;
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
      end
      else if AResponse.ContentLength > 0 then begin// If chunked then this is also 0
        // RLebeau 6/30/2006: DO NOT READ IF THE REQUEST IS HEAD!!!
        // The server is supposed to send a 'Content-Length' header
        // without sending the actual data...
        try
          if AUnexpectedContentTimeout > 0 then begin
            if IOHandler.InputBufferIsEmpty then begin
              IOHandler.CheckForDataOnSource(AUnexpectedContentTimeout);
            end;
            if not IOHandler.InputBufferIsEmpty then begin
              if Assigned(LS) then begin
                IOHandler.ReadStream(LS, AResponse.ContentLength);
              end else begin
                IOHandler.Discard(AResponse.ContentLength);
              end;
            end;
          end else begin
            if Assigned(LS) then begin
              IOHandler.ReadStream(LS, AResponse.ContentLength);
            end else begin
              IOHandler.Discard(AResponse.ContentLength);
            end;
          end;
        except
          on E: EIdConnClosedGracefully do
        end;
      end
      else if not AResponse.HasContentLength then begin
      // RLebeau 2/15/2006: only read if an entity body is actually expected
        if AUnexpectedContentTimeout > 0 then begin
          if IOHandler.InputBufferIsEmpty then begin
            IOHandler.CheckForDataOnSource(AUnexpectedContentTimeout);
          end;
          if not IOHandler.InputBufferIsEmpty then begin
            if Assigned(LS) then begin
              IOHandler.ReadStream(LS, -1, True);
            end else begin
              IOHandler.DiscardAll;
            end;
          end;
        end else begin
          if Assigned(LS) then begin
            IOHandler.ReadStream(LS, -1, True);
          end else begin
            IOHandler.DiscardAll;
          end;
        end;
      end;
      if LDecMeth > 0 then begin
        LS.Position := 0;
        case LDecMeth of
          1 :  Compressor.DecompressDeflateStream(LS, AResponse.ContentStream);
          2 :  Compressor.DecompressGZipStream(LS, AResponse.ContentStream);
        end;
      end;
    finally
      if LDecMeth > 0 then begin
        FreeAndNil(LS);
      end;
    end;
    if LParseHTML then begin
      FMetaHTTPEquiv.ProcessMetaHTTPEquiv(Response.ContentStream);
    end;
  finally
    if LCreateTmpContent then
    begin
      try
        LOrigStream.CopyFrom(Response.ContentStream, 0);
      finally
        Response.ContentStream.Free;
        Response.ContentStream := LOrigStream;
      end;
    end;
  end;
end;

type
  XmlEncoding = (xmlUCS4BE, xmlUCS4BEOdd, xmlUCS4LE, xmlUCS4LEOdd,
                 xmlUTF16BE, xmlUTF16LE, xmlUTF8, xmlEBCDIC, xmlUnknown
                 );

  XmlBomInfo = record
    Charset: String;
    BOMLen: Integer;
    BOM: LongWord;
    BOMMask: LongWord;
  end;

  XmlNonBomInfo = record
    CharLen: Integer;
    FirstChar: LongWord;
    LastChar: LongWord;
    CharMask: LongWord;
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
  XmlDec: String;
  I: Integer;
  Enc: XmlEncoding;
  Signature: LongWord;

  function BufferToLongWord: LongWord;
  begin
    Result := (LongWord(Buffer[0]) shl 24) or
              (LongWord(Buffer[1]) shl 16) or
              (LongWord(Buffer[2]) shl 8) or
              LongWord(Buffer[3]);
  end;

begin
  Result := '';

  StreamPos := AStream.Position;
  try
    AStream.Position := 0;

    SetLength(Buffer, 4);
    FillBytes(Buffer, 4, $00);

    InBuf := ReadTIdBytesFromStream(AStream, Buffer, 4);
    if InBuf < 3 then begin
      Exit;
    end;

    Signature := BufferToLongWord;

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
          Signature := BufferToLongWord;
          if (Signature and XmlNonBOMs[Enc].CharMask) = XmlNonBOMs[Enc].LastChar then
          begin
            CurPos := AStream.Position;
            AStream.Position := 0;
            case Enc of
              xmlUCS4BE, xmlUCS4LE, xmlUCS4BEOdd, xmlUCS4LEOdd: begin
                // TODO: implement a UCS-4 TIdTextEncoding class...
                SetLength(XmlDec, CurPos div XmlNonBOMs[Enc].CharLen);
                for I := 1 to Length(XmlDec) do begin
                  ReadTIdBytesFromStream(AStream, Buffer, XmlNonBOMs[Enc].CharLen);
                  XmlDec[I] := Char(Buffer[XmlUCS4AsciiIndex[Enc]]);
                end;
              end;
              xmlUTF16BE: begin
                XmlDec := ReadStringFromStream(AStream, CurPos, TIdTextEncoding.BigEndianUnicode);
              end;
              xmlUTF16LE: begin
                XmlDec := ReadStringFromStream(AStream, CurPos, TIdTextEncoding.Unicode);
              end;
              xmlUTF8: begin
                XmlDec := ReadStringFromStream(AStream, CurPos, Indy8BitEncoding);
              end;
              xmlEBCDIC: begin
                // TODO: implement an EBCDIC TIdTextEncoding class...
                XmlDec := ReadStringFromStream(AStream, CurPos, Indy8BitEncoding);
                for I := 1 to Length(XmlDec) do begin
                  XmlDec[I] := XmlEBCDICTable[Byte(XmlDec[I])];
                end;
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

    XmlDec := TrimLeft(Copy(XmlDec, I+8, Length(XmlDec)));
    if not CharEquals(XmlDec, 1, '=') then begin {do not localize}
      Exit;
    end;

    XmlDec := TrimLeft(Copy(XmlDec, 2, Length(XmlDec)));
    if XmlDec = '' then begin
      Exit;
    end;

    if XmlDec[1] = #27 then begin
      XmlDec := Copy(XmlDec, 2, Length(XmlDec));
      Result := Fetch(XmlDec, #27);
    end
    else if XmlDec[1] = '"' then begin
      XmlDec := Copy(XmlDec, 2, Length(XmlDec));
      Result := Fetch(XmlDec, '"');
    end;
  finally
    AStream.Position := StreamPos;
  end;
end;

function TIdCustomHTTP.ResponseCharset: String;
begin
  if IsContentTypeAppXml(Response) then begin
    // the media type is not a 'text/...' based XML type, so ignore the
    // charset from the headers, if present, and parse the XML itself...
    Result := DetectXmlCharset(Response.ContentStream);
  end
  else begin
    Result := Response.CharSet;
    if Result = '' then begin
      Result := MetaHTTPEquiv.CharSet;
    end;
  end;
end;

procedure TIdCustomHTTP.PrepareRequest(ARequest: TIdHTTPRequest);
var
  LURI: TIdURI;
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

    // The URL part is not URL encoded at this place
    ARequest.URL := URL.GetPathAndParams;

    if TextIsSame(ARequest.Method, Id_HTTPMethodOptions) or
      TextIsSame(ARequest.MethodOverride, Id_HTTPMethodOptions) then
    begin
      if TextIsSame(LURI.Document, '*') then begin     {do not localize}
        ARequest.URL := LURI.Document;
      end;
    end;

    ARequest.IPVersion := LURI.IPVersion;
    FURI.IPVersion := ARequest.IPVersion;

    // Check for valid HTTP request methods
    if (PosInStrArray(ARequest.Method, [Id_HTTPMethodTrace, Id_HTTPMethodPut, Id_HTTPMethodOptions, Id_HTTPMethodDelete], False) > -1) or
      (PosInStrArray(ARequest.MethodOverride, [Id_HTTPMethodTrace, Id_HTTPMethodPut, Id_HTTPMethodOptions, Id_HTTPMethodDelete], False) > -1) then
    begin
      if ProtocolVersion <> pv1_1 then  begin
        raise EIdException.Create(RSHTTPMethodRequiresVersion);
      end;
    end;

    if Assigned(ARequest.Source) then begin
      ARequest.ContentLength := ARequest.Source.Size;
    end else begin
      ARequest.ContentLength := -1;
    end;

    if (TextIsSame(FURI.Protocol, 'http') and (FURI.Port = IntToStr(IdPORT_HTTP))) or  {do not localize}
      (TextIsSame(FURI.Protocol, 'https') and (FURI.Port = IntToStr(IdPORT_https))) then  {do not localize}
    begin
      ARequest.Host := FURI.Host;
    end else begin
      ARequest.Host := FURI.Host + ':' + FURI.Port;    {do not localize}
    end;
  finally
    FreeAndNil(LURI);  // Free URI Object
  end;
end;

procedure TIdCustomHTTP.CheckAndConnect(AResponse: TIdHTTPResponse);
begin
  Assert(AResponse<>nil);

  if not AResponse.KeepAlive then begin
    Disconnect;
  end;

  if Assigned(IOHandler) then begin
    IOHandler.InputBuffer.Clear;
  end;

  CheckForGracefulDisconnect(False);

  if not Connected then try
    IPVersion := FURI.IPVersion;
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
begin
  ARequest.FUseProxy := SetHostAndPort;

  if ARequest.UseProxy = ctProxy then
  begin
    ARequest.URL := FURI.URI;
  end;

  LUseConnectVerb := False;

  case ARequest.UseProxy of
    ctNormal:
      begin
        if (ProtocolVersion = pv1_0) and (Length(ARequest.Connection) = 0) then
        begin
          ARequest.Connection := 'keep-alive';      {do not localize}
        end;
      end;
    ctSSL, ctSSLProxy:
      begin
        ARequest.Connection := '';
        LUseConnectVerb := (ARequest.UseProxy = ctSSLProxy);
      end;
    ctProxy:
      begin
        if (ProtocolVersion = pv1_0) and (Length(ARequest.Connection) = 0) then
        begin
          ARequest.ProxyConnection := 'keep-alive'; {do not localize}
        end;
        LUseConnectVerb := hoNonSSLProxyUseConnectVerb in FOptions;
      end;
  end;

  if Assigned(FCompressor) and FCompressor.IsReady then begin
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
  end;

  if IndyPos('identity', ARequest.AcceptEncoding) = 0 then begin  {do not localize}
    if ARequest.AcceptEncoding <> '' then begin
      ARequest.AcceptEncoding := ARequest.AcceptEncoding + ', identity'; {do not localize}
    end else begin
      ARequest.AcceptEncoding := 'identity'; {do not localize}
    end;
  end;

  if LUseConnectVerb then begin
    LLocalHTTP := TIdHTTPProtocol.Create(Self);
    try
      with LLocalHTTP do begin
        Request.UserAgent := ARequest.UserAgent;
        Request.Host := ARequest.Host;
        Request.Pragma := 'no-cache';                       {do not localize}
        Request.URL := URL.Host + ':' + URL.Port;
        Request.Method := Id_HTTPMethodConnect;
        Request.ProxyConnection := 'keep-alive';            {do not localize}

        // TODO: change this to nil so data is discarded without wasting memory?
        Response.ContentStream := TMemoryStream.Create;
        try
          try
            repeat
              CheckAndConnect(Response);
              BuildAndSendRequest(nil);

              Response.ResponseText := InternalReadLn;
              if Length(Response.ResponseText) = 0 then begin
                // Support for HTTP responses without status line and headers
                Response.ResponseText := 'HTTP/1.0 200 OK'; {do not localize}
                Response.Connection := 'close';             {do not localize}
              end else begin
                RetrieveHeaders(MaxHeaderLines);
                ProcessCookies(Request, Response);
              end;

              if Response.ResponseCode = 200 then begin
                // Connection established
                if (ARequest.UseProxy = ctSSLProxy) and (IOHandler is TIdSSLIOHandlerSocketBase) then begin
                  TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := False;
                end;
                Break;
              end else begin
                ProcessResponse([]);
              end;
            until False;
          except
            raise;
            // TODO: Add property that will contain the error messages.
          end;
        finally
          LLocalHTTP.Response.ContentStream.Free;
        end;
      end;
    finally
      FreeAndNil(LLocalHTTP);
    end;
  end else begin
    CheckAndConnect(AResponse);
  end;

  FHTTPProto.BuildAndSendRequest(URL);

  // RLebeau 1/31/2008: in order for TIdWebDAV to post data correctly, don't
  // restrict which HTTP methods can post (except logically for GET and HEAD),
  // especially since TIdCustomHTTP.PrepareRequest() does not differentiate when
  // setting up the 'Content-Length' header ...
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
  Temp, Cookies, Cookies2: TStringList;
  i: Integer;
  S, Cur: String;

  // RLebeau: a single Set-Cookie header can have more than 1 cookie in it...
  procedure ReadCookies(AHeaders: TIdHeaderList; const AHeader: String; ACookies: TStrings);
  var
    j: Integer;
  begin
    Temp.Clear;
    AHeaders.Extract(AHeader, Temp);
    for j := 0 to Temp.Count-1 do begin
      S := Temp[j];
      while ExtractNextCookie(S, Cur, True) do begin
        ACookies.Add(Cur);
      end;
    end;
  end;

begin
  Temp := nil;
  Cookies := nil;
  Cookies2 := nil;
  try
    if (not Assigned(FCookieManager)) and AllowCookies then begin
      CookieManager := TIdCookieManager.Create(Self);
      FFreeCookieManager := True;
    end;

    if Assigned(FCookieManager) then begin
      Temp := TStringList.Create;
      Cookies := TStringList.Create;
      Cookies2 := TStringList.Create;

      ReadCookies(AResponse.RawHeaders, 'Set-Cookie', Cookies);  {do not localize}
      ReadCookies(AResponse.RawHeaders, 'Set-Cookie2', Cookies2);  {do not localize}

      ReadCookies(FMetaHTTPEquiv.RawHeaders, 'Set-Cookie', Cookies);    {do not localize}
      ReadCookies(FMetaHTTPEquiv.RawHeaders, 'Set-Cookie2', Cookies2);  {do not localize}

      for i := 0 to Cookies.Count - 1 do begin
        CookieManager.AddServerCookie(Cookies[i], FURI);
      end;

      for i := 0 to Cookies2.Count - 1 do begin
        CookieManager.AddServerCookie2(Cookies2[i], FURI);
      end;
    end;
  finally
    FreeAndNil(Temp);
    FreeAndNil(Cookies);
    FreeAndNil(Cookies2);
  end;
end;

procedure TIdCustomHTTP.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then begin
    if (AComponent = FCookieManager) then begin
      FCookieManager := nil;
    end else if (AComponent = FAuthenticationManager) then begin
      FAuthenticationManager := nil;
    end else if (AComponent = FCompressor) then begin
      FCompressor := nil;
    end;
  end;
end;

procedure TIdCustomHTTP.SetCookieManager(ACookieManager: TIdCookieManager);
begin
  if FCookieManager <> ACookieManager then begin
    if Assigned(FCookieManager) then begin
      if FFreeCookieManager then begin
        FreeAndNil(FCookieManager);
      end else begin
        FCookieManager.RemoveFreeNotification(Self);
      end;
    end;

    FCookieManager := ACookieManager;
    FFreeCookieManager := False;

    if Assigned(FCookieManager) then begin
      FCookieManager.FreeNotification(Self);
    end;
  end;
end;

function TIdCustomHTTP.DoOnAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean;
var
  i: Integer;
  S: string;
  Auth: TIdAuthenticationClass;
begin
  Inc(FAuthRetries);
  if not Assigned(ARequest.Authentication) then begin
    // Find wich Authentication method is supported from us.
    Auth := nil;

    for i := 0 to AResponse.WWWAuthenticate.Count - 1 do begin
      S := AResponse.WWWAuthenticate[i];
      Auth := FindAuthClass(Fetch(S));
      if Assigned(Auth) then begin
        Break;
      end;
    end;

    // let the user override us, if desired.
    if Assigned(FOnSelectAuthorization) then begin
      OnSelectAuthorization(Self, Auth, AResponse.WWWAuthenticate);
    end;

    if not Assigned(Auth) then begin
      Result := False;
      Exit;
    end;

    ARequest.Authentication := Auth.Create;
  end;

  // Clear password and reset autorization if previous failed
  {if (AResponse.FResponseCode = 401) then begin
    ARequest.Password := '';
    ARequest.Authentication.Reset;
  end;}
  // S.G. 20/10/2003: Added part about the password. Not testing user name as some
  // S.G. 20/10/2003: web sites do not require user name, only password.
  Result := Assigned(FOnAuthorization) or (Trim(ARequest.Password) <> '');

  if not Result then begin
    Exit;
  end;
  
  with ARequest.Authentication do begin
    Username := ARequest.Username;
    Password := ARequest.Password;
    // S.G. 20/10/2003: ToDo: We need to have a marker here to prevent the code to test with the same username/password combo
    // S.G. 20/10/2003: if they are picked up from properties.
    Params.Values['Authorization'] := ARequest.Authentication.Authentication; {do not localize}
    AuthParams := AResponse.WWWAuthenticate;
  end;

  Result := False;

  repeat
    case ARequest.Authentication.Next of
      wnAskTheProgram:
        begin // Ask the user porgram to supply us with authorization information
          if Assigned(FOnAuthorization) then
          begin
            ARequest.Authentication.UserName := ARequest.Username;
            ARequest.Authentication.Password := ARequest.Password;

            OnAuthorization(Self, ARequest.Authentication, Result);

            if Result then begin
              ARequest.BasicAuthentication := True;
              ARequest.Username := ARequest.Authentication.UserName;
              ARequest.Password := ARequest.Authentication.Password;
            end else begin
              Break;
            end;
          end;
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
  Auth: TIdAuthenticationClass;
begin
  Inc(FAuthProxyRetries);
  if not Assigned(ProxyParams.Authentication) then begin
    // Find which Authentication method is supported from us.
    Auth := nil;

    for i := 0 to AResponse.ProxyAuthenticate.Count-1 do begin
      S := AResponse.ProxyAuthenticate[i];
      Auth := FindAuthClass(Fetch(S));
      if Assigned(Auth) then begin
        Break;
      end;
    end;

    // let the user override us, if desired.
    if Assigned(FOnSelectProxyAuthorization) then begin
      OnSelectProxyAuthorization(self, Auth, AResponse.ProxyAuthenticate);
    end;

    if not Assigned(Auth) then begin
      Result := False;
      Exit;
    end;

    ProxyParams.Authentication := Auth.Create;
  end;

  // RLebeau: should we be looking for a Password as well, like the OnAuthorization handling does?
  Result := Assigned(OnProxyAuthorization) {or (Trim(ARequest.Password) <> '')};

  {
  this is commented out as it breaks SSPI proxy authentication.
  it is normal and expected to get 407 responses during the negotiation.

  // Clear password and reset authorization if previous failed
  if (AResponse.FResponseCode = 407) then begin
    ProxyParams.ProxyPassword := '';
    ProxyParams.Authentication.Reset;
  end;
  }

  if not Result then begin
    Exit;
  end;

  with ProxyParams.Authentication do begin
    Username := ProxyParams.ProxyUsername;
    Password := ProxyParams.ProxyPassword;
    AuthParams := AResponse.ProxyAuthenticate;
  end;

  Result := False;

  repeat
    case ProxyParams.Authentication.Next of
      wnAskTheProgram: // Ask the user porgram to supply us with authorization information
        begin
          if Assigned(OnProxyAuthorization) then begin
            ProxyParams.Authentication.Username := ProxyParams.ProxyUsername;
            ProxyParams.Authentication.Password := ProxyParams.ProxyPassword;

            OnProxyAuthorization(Self, ProxyParams.Authentication, Result);
            if not Result then begin
              Break;
            end;

            ProxyParams.ProxyUsername := ProxyParams.Authentication.Username;
            ProxyParams.ProxyPassword := ProxyParams.Authentication.Password;
          end;
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
  Result := Response.FResponseText;
end;

function TIdCustomHTTP.GetResponseHeaders: TIdHTTPResponse;
begin
  Result := FHTTPProto.Response;
end;

function TIdCustomHTTP.GetRequestHeaders: TIdHTTPRequest;
begin
  Result := FHTTPProto.Request;
end;

procedure TIdCustomHTTP.DoOnDisconnected;
begin
  inherited DoOnDisconnected;

  if Assigned(Request.Authentication) and
    (Request.Authentication.CurrentStep = Request.Authentication.Steps) then begin
    if Assigned(AuthenticationManager) then begin
      AuthenticationManager.AddAuthentication(Request.Authentication, URL);
    end;
    Request.Authentication.Free;
    Request.Authentication := nil;
  end;

  if Assigned(ProxyParams.Authentication) and
    (ProxyParams.Authentication.CurrentStep = ProxyParams.Authentication.Steps) then begin
    ProxyParams.Authentication.Reset;
  end;
end;

procedure TIdCustomHTTP.SetAuthenticationManager(Value: TIdAuthenticationManager);
begin
  if FAuthenticationManager <> Value then begin
    if Assigned(FAuthenticationManager) then begin
      FAuthenticationManager.RemoveFreeNotification(self);
    end;
    FAuthenticationManager := Value;
    if Assigned(FAuthenticationManager) then begin
      FAuthenticationManager.FreeNotification(Self);
    end;
  end;
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
procedure TIdCustomHTTP.SetRequestHeaders(Value: TIdHTTPRequest);
begin
  FHTTPProto.Request.Assign(Value);
end;

procedure TIdCustomHTTP.Post(AURL: string; ASource: TIdMultiPartFormDataStream;
  AResponseContent: TStream);
begin
  Assert(ASource<>nil);
  Request.ContentType := ASource.RequestContentType;
  // TODO: Request.CharSet := ASource.RequestCharSet;
  Post(AURL, TStream(ASource), AResponseContent);
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TIdMultiPartFormDataStream): string;
begin
  Assert(ASource<>nil);
  Request.ContentType := ASource.RequestContentType;
  // TODO: Request.CharSet := ASource.RequestCharSet;
  Result := Post(AURL, TStream(ASource));
end;

{ TIdHTTPResponse }

constructor TIdHTTPResponse.Create(AHTTP: TIdCustomHTTP);
begin
  inherited Create(AHTTP);
  FHTTP := AHTTP;
end;

function TIdHTTPResponse.GetKeepAlive: Boolean;
var
  S: string;
  i: TIdHTTPProtocolVersion;
begin
  S := Copy(FResponseText, 6, 3);

  for i := Low(TIdHTTPProtocolVersion) to High(TIdHTTPProtocolVersion) do begin
    if TextIsSame(ProtocolVersionString[i], S) then begin
      ResponseVersion := i;
      Break;
    end;
  end;

  if FHTTP.Connected then begin
    FHTTP.IOHandler.CheckForDisconnect(False);
  end;
  FKeepAlive := FHTTP.Connected;

  if FKeepAlive then
    case FHTTP.ProtocolVersion of
      pv1_1:
        { By default we assume that keep-alive is by default and will close
          the connection only there is "close" }
        begin
          FKeepAlive :=
            not (TextIsSame(Trim(Connection), 'CLOSE') or   {do not localize}
            TextIsSame(Trim(ProxyConnection), 'CLOSE'));    {do not localize}
        end;
      pv1_0:
        { By default we assume that keep-alive is not by default and will keep
          the connection only if there is "keep-alive" }
        begin
          FKeepAlive := TextIsSame(Trim(Connection), 'KEEP-ALIVE') or  {do not localize}
            TextIsSame(Trim(ProxyConnection), 'KEEP-ALIVE')            {do not localize}
            { or ((ResponseVersion = pv1_1) and
              (Length(Trime(Connection)) = 0) and
              (Length(Trime(ProxyConnection)) = 0)) };
        end;
    end;
  Result := FKeepAlive;
end;

function TIdHTTPResponse.GetResponseCode: Integer;
var
  S: string;
begin
  S := FResponseText;
  Fetch(S);
  S := Trim(S);
  FResponseCode := IndyStrToInt(Fetch(S, ' ', False), -1);
  Result := FResponseCode;
end;

{ TIdHTTPRequest }

constructor TIdHTTPRequest.Create(AHTTP: TIdCustomHTTP);
begin
  inherited Create(AHTTP);
  FHTTP := AHTTP;
  FUseProxy := ctNormal;
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
    FHTTP.IOHandler.WriteLn('');     {do not localize}
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
  // Clear headers
  // Don't use Capture.
  // S.G. 6/4/2004: Added AmaxHeaderCount parameter to prevent the "header bombing" of the server
  Response.RawHeaders.Clear;
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
    on E: EIdConnClosedGracefully do begin
      FHTTP.Disconnect;
    end else begin
      raise;
    end;
  end;
  Response.ProcessHeaders;
end;

function TIdHTTPProtocol.ProcessResponse(AIgnoreReplies: array of SmallInt): TIdHTTPWhatsNext;

  procedure CheckException(AResponseCode: Integer; ALIgnoreReplies: array of Smallint;
    AUnexpectedContentTimeout: Integer = IdTimeoutDefault);
  var
    i: Integer;
    LTempResponse: TMemoryStream;
    LTempStream: TStream;
  begin
    LTempResponse := TMemoryStream.Create;
    try
      LTempStream := Response.ContentStream;
      Response.ContentStream := LTempResponse;
      try
        FHTTP.ReadResult(Response, AUnexpectedContentTimeout);
        if High(ALIgnoreReplies) > -1 then begin
          for i := Low(ALIgnoreReplies) to High(ALIgnoreReplies) do begin
            if AResponseCode = ALIgnoreReplies[i] then begin
              Exit;
            end;
          end;
        end;
        LTempResponse.Position := 0;
        raise EIdHTTPProtocolException.CreateError(AResponseCode, FHTTP.ResponseText,
          ReadStringAsCharset(LTempResponse, FHTTP.ResponseCharSet));
      finally
        Response.ContentStream := LTempStream;
      end;
    finally
      FreeAndNil(LTempResponse);
    end;
  end;

  procedure DiscardContent(AUnexpectedContentTimeout: Integer = IdTimeoutDefault);
  var
    LOrigStream: TStream;
  begin
    LOrigStream := Response.ContentStream;
    Response.ContentStream := nil;
    try
      FHTTP.ReadResult(Response, AUnexpectedContentTimeout);
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
  LResponseCode, LResponseDigit: Integer;
  //LTemp: Integer;
begin

  // provide the user with the headers and let the user decide
  // whether the response processing should continue...
  if not HeadersCanContinue then begin
    Response.KeepAlive := False; // force DoRequest() to disconnect the connection
    Result := wnJustExit;
    Exit;
  end;

  // Cache this as ResponseCode calls GetResponseCode which parses it out
  LResponseCode := Response.ResponseCode;
  LResponseDigit := LResponseCode div 100;
  LNeedAuth := False;

  // Handle Redirects
  // RLebeau: All 3xx replies other than 304 are redirects.  Reply 201 has a Location header but is NOT a redirect!
  if ((LResponseDigit = 3) and (LResponseCode <> 304))
    or ((Response.Location <> '') and (LResponseCode <> 201)) then begin
    Inc(FHTTP.FRedirectCount);

    // LLocation := TIdURI.URLDecode(Response.Location);
    LLocation := Response.Location;
    LMethod := Request.Method;

    // fire the event
    if not FHTTP.DoOnRedirect(LLocation, LMethod, FHTTP.FRedirectCount) then begin
      CheckException(LResponseCode, AIgnoreReplies);
      Result := wnJustExit;
      Exit;
    end;

    if (FHTTP.FHandleRedirects) and (FHTTP.FRedirectCount < FHTTP.FRedirectMax) then begin
      Result := wnGoToURL;
      Request.URL := LLocation;
      // GDG 21/11/2003. If it's a 303, we should do a get this time
      // RLebeau 7/15/2004 - do a GET on 302 as well, as mentioned in RFC 2616
      // RLebeau 1/11/2008 - turns out both situations are WRONG! RFCs 2068 an
      // 2616 specifically state that changing the method to GET in response
      // to 302 and 303 is errorneous.  Indy 9 did it right by reusing the
      // original method and source again and only changing the URL, so lets
      // revert back to that same behavior!
      {
      if (LResponseCode = 302) or (LResponseCode = 303) then begin
        Request.Source := nil;
        Request.Method := Id_HTTPMethodGet;
      end else begin
        Request.Method := LMethod;
      end;
      }
      Request.Method := LMethod;
      Request.MethodOverride := '';
    end else begin
      Result := wnJustExit;
      Response.Location := LLocation;
    end;

    if FHTTP.Connected then begin
      // This is a workaround for buggy HTTP 1.1 servers which
      // does not return any body with 302 response code
      DiscardContent(5000); // Lets wait for any kind of content
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
        401:
          begin // HTTP Server authorization required
            if (FHTTP.AuthRetries >= FHTTP.MaxAuthRetries) or
               (not FHTTP.DoOnAuthorization(Request, Response)) then begin
              if Assigned(Request.Authentication) then begin
                Request.Authentication.Reset;
              end;
              CheckException(LResponseCode, AIgnoreReplies);
              Result := wnJustExit;
              Exit;
            end else begin
              LNeedAuth := hoInProcessAuth in FHTTP.HTTPOptions;
            end;
          end;
        407:
          begin // Proxy Server authorization requered
            if (FHTTP.AuthProxyRetries >= FHTTP.MaxAuthRetries) or
               (not FHTTP.DoOnProxyAuthorization(Request, Response)) then begin
              if Assigned(FHTTP.ProxyParams.Authentication) then begin
                FHTTP.ProxyParams.Authentication.Reset;
              end;
              CheckException(LResponseCode, AIgnoreReplies);
              Result := wnJustExit;
              Exit;
            end else begin
              LNeedAuth := hoInProcessAuth in FHTTP.HTTPOptions;
            end;
          end;
        else begin
          if (LResponseDigit = 1) or (LResponseCode = 304) then begin
            CheckException(LResponseCode, AIgnoreReplies, 100);
          end else begin
            CheckException(LResponseCode, AIgnoreReplies);
          end;
          Result := wnJustExit;
          Exit;
        end;
      end;
    end;

    if LNeedAuth then begin
      // Read the content of Error message in temporary stream
      DiscardContent;
      Result := wnAuthRequest;
    end else begin
      if TextIsSame(Request.Method, Id_HTTPMethodHead) or
        TextIsSame(Request.MethodOverride, Id_HTTPMethodHead) or
        (LResponseCode = 204) then
      begin
        // Have noticed one case where a non-conforming server did send an
        // entity body in response to a HEAD request, so just ignore anything
        // the server may send by accident
        DiscardContent(100); // Lets wait for any kind of content
      end else begin
        FHTTP.ReadResult(Response);
      end;
      Result := wnJustExit;
    end;
  end;
end;

procedure TIdCustomHTTP.InitComponent;
begin
  inherited;
  FURI := TIdURI.Create('');

  FAuthRetries := 0;
  FAuthProxyRetries := 0;
  AllowCookies := true;
  FFreeCookieManager := False;
  FOptions := [hoForceEncodeParams];

  FRedirectMax := Id_TIdHTTP_RedirectMax;
  FHandleRedirects := Id_TIdHTTP_HandleRedirects;
  //
  FProtocolVersion := Id_TIdHTTP_ProtocolVersion;

  FHTTPProto := TIdHTTPProtocol.Create(Self);
  FProxyParameters := TIdProxyConnectionInfo.Create;
  FProxyParameters.Clear;

  FMetaHTTPEquiv :=  TIdMetaHTTPEquiv.Create(Self);

  FMaxAuthRetries := Id_TIdHTTP_MaxAuthRetries;
  FMaxHeaderLines := Id_TIdHTTP_MaxHeaderLines;
end;

function TIdCustomHTTP.InternalReadLn: String;
begin
  Result := IOHandler.ReadLn;
  if IOHandler.ReadLnTimedout then begin
    raise EIdReadTimeout.Create(RSReadTimeout);
  end;
end;

function TIdCustomHTTP.Get(AURL: string; AIgnoreReplies: array of SmallInt): string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    Get(AURL, LStream, AIgnoreReplies);
    LStream.Position := 0;
    Result := ReadStringAsCharset(LStream, ResponseCharset);
    // TODO: if the data is XML, add/update the declared encoding to 'UTF-16LE'...
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdCustomHTTP.Get(AURL: string; AResponseContent: TStream;
  AIgnoreReplies: array of SmallInt);
begin
  DoRequest(Id_HTTPMethodGet, AURL, nil, AResponseContent, AIgnoreReplies);
end;

procedure TIdCustomHTTP.DoRequest(const AMethod: TIdHTTPMethod;
  AURL: string; ASource, AResponseContent: TStream;
  AIgnoreReplies: array of SmallInt);
var
  LResponseLocation: Integer;
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

      // Workaround for servers wich respond with 100 Continue on GET and HEAD
      // This workaround is just for temporary use until we have final HTTP 1.1
      // realisation. HTTP 1.1 is ongoing because of all the buggy and conflicting servers.
      repeat
        Response.ResponseText := InternalReadLn;
        FHTTPProto.RetrieveHeaders(MaxHeaderLines);
        ProcessCookies(Request, Response);
      until Response.ResponseCode <> 100;

      case FHTTPProto.ProcessResponse(AIgnoreReplies) of
        wnAuthRequest:
          begin
            Request.URL := AURL;
          end;
        wnReadAndGo:
          begin
            ReadResult(Response);
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
            raise EIdException.Create(RSHTTPNotAcceptable);
          end;
      end;
    until False;
  finally
    if not Response.KeepAlive then begin
      Disconnect;
    end;
  end;
end;

end.

