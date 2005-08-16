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
{   Rev 1.65    3/5/2005 3:33:52 PM  JPMugaas
{ Fix for some compiler warnings having to do with TStream.Read being platform
{ specific.  This was fixed by changing the Compressor API to use TIdStreamVCL
{ instead of TStream.  I also made appropriate adjustments to other units for
{ this. 
}
{
    Rev 1.64    2/13/2005 3:09:20 PM  DSiders
  Modified TIdCustomHTTP.PrepareRequest to free the local URI instance if an
  exception occurs in the method. (try...finally)
}
{
{   Rev 1.63    2/11/05 11:29:34 AM  RLebeau
{ Removed compiler warning
}
{
{   Rev 1.62    2/9/05 2:12:08 AM  RLebeau
{ Fixes for Compiler errors
}
{
{   Rev 1.61    2/8/05 6:43:42 PM  RLebeau
{ Added OnHeaderAvailable event
}
{
{   Rev 1.60    1/11/05 1:25:08 AM  RLebeau
{ More changes to SetHostAndPort()
}
{
{   Rev 1.59    1/6/05 2:28:52 PM  RLebeau
{ Fix for SetHostAndPort() not using its local variables properly
}
{
{   Rev 1.58    06/01/2005 22:23:04  CCostelloe
{ Bug fix (typo, gizp instead of gzip)
}
{
{   Rev 1.57    05/12/2004 23:10:58  CCostelloe
{ Recoded fix to suit Delphi < 7
}
{
{   Rev 1.56    30/11/2004 23:46:12  CCostelloe
{ Bug fix for SSL connections giving a "Connection closed gracefully" exception
{ and requested page not getting returned (IOHandler.Response is empty)
}
{
{   Rev 1.55    25/11/2004 21:28:06  CCostelloe
{ Bug fix for POSTing fields that have the same name
}
{
{   Rev 1.54    10/26/2004 10:13:24 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.53    7/16/04 1:19:20 AM  RLebeau
{ Fix for compiler error
}
{
{   Rev 1.52    7/15/04 8:19:30 PM  RLebeau
{ Updated TIdHTTPProtocol.ProcessResponse() to treat 302 redirects like 303.
{
{ Updated TIdHTTPProtocol.BuildAndSendRequest() to use a try...except block
}
{
    Rev 1.51    6/17/2004 8:30:04 AM  DSiders
  TIdCustomHTTP modified:
  - Fixed error in AuthRetries property reading wrong member var.
  - Added AuthProxyRetries and MaxAuthRetries properties to public interface.

  TIdHTTP modified to publish AuthRetries, AuthProxyRetries, and MaxAuthRetries.

  TIdHTTPProtocol.ProcessResponse modified to use public properties
  AuthRetries, AuthProxyRetries, and MaxAutrhRetries.
}
{
{   Rev 1.50    2004.05.20 11:36:46 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.49    4/28/04 1:45:26 PM  RLebeau
{ Updated TIdCustomHTTP.SetRequestParams() to strip off the trailing CRLF
{ before encoding rather than afterwards
}
{
{   Rev 1.48    2004.04.07 11:18:08 PM  czhower
{ Bug and naming fix.
}
{
{   Rev 1.47    7/4/2004 6:00:02 PM  SGrobety
{ Reformatted to match project guidelines
}
{
{   Rev 1.46    7/4/2004 4:58:24 PM  SGrobety
{ Reformatted to match project guidelines
}
{
{   Rev 1.45    6/4/2004 5:16:40 PM  SGrobety
{ Added AMaxHeaderCount: integer parameter to TIdHTTPProtocol.RetrieveHeaders
{ and MaxHeaderLines property to TIdCustomHTTP (default to 255)
}
{
{   Rev 1.44    2004.03.06 10:39:52 PM  czhower
{ Removed duplicate code
}
{
{   Rev 1.43    2004.03.06 8:56:30 PM  czhower
{ -Change to disconnect
{ -Addition of DisconnectNotifyPeer
{ -WriteHeader now write bufers
}
{
{   Rev 1.42    3/3/2004 5:58:00 AM  JPMugaas
{ Some IFDEF excluses were removed because the functionality is now in DotNET.
}
{
{   Rev 1.41    2004.02.23 9:33:12 PM  czhower
{ Now can optionally ignore response codes for exceptions.
}
{
{   Rev 1.40    2/15/2004 6:34:02 AM  JPMugaas
{ Fix for where I broke the HTTP client with a parameter change in the GZip
{ decompress method.
}
{
{   Rev 1.39    2004.02.03 5:43:44 PM  czhower
{ Name changes
}
{
{   Rev 1.38    2004.02.03 2:12:10 PM  czhower
{ $I path change
}
{
{   Rev 1.37    2004.01.27 11:41:18 PM  czhower
{ Removed const arguments
}
{
{   Rev 1.35    24/01/2004 19:22:34  CCostelloe
{ Cleaned up warnings
}
{
{   Rev 1.34    2004.01.22 5:29:02 PM  czhower
{ TextIsSame
}
{
{   Rev 1.33    2004.01.21 1:04:50 PM  czhower
{ InitComponenet
}
{
{   Rev 1.32    1/2/2004 11:41:48 AM  BGooijen
{ Enabled IPv6 support
}
{
{   Rev 1.31    22/11/2003 12:04:28 AM  GGrieve
{ Add support for HTTP status code 303
}
{
{   Rev 1.30    10/25/2003 06:51:58 AM  JPMugaas
{ Updated for new API changes and tried to restore some functionality.
}
{
{   Rev 1.29    2003.10.24 10:43:08 AM  czhower
{ TIdSTream to dos
}
{
{   Rev 1.28    24/10/2003 10:58:40 AM  SGrobety
{ Made authentication work even if no OnAnthenticate envent handler present
}
{
{   Rev 1.27    10/18/2003 1:53:10 PM  BGooijen
{ Added include
}
{
    Rev 1.26    10/17/2003 12:08:48 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.25    2003.10.14 1:27:52 PM  czhower
{ DotNet
}
{
{   Rev 1.24    10/7/2003 11:33:54 PM  GGrieve
{ Get works under DotNet
}
{
{   Rev 1.23    10/7/2003 10:07:04 PM  GGrieve
{ Get HTTP compiling for DotNet
}
{
{   Rev 1.22    10/4/2003 9:15:58 PM  GGrieve
{ fix to compile
}
{
{   Rev 1.21    9/26/2003 01:41:48 PM  JPMugaas
{ Fix for problem wihere "identity" was being added more than once to the
{ accepted encoding contents.
}
{
{   Rev 1.20    9/14/2003 07:54:20 PM  JPMugaas
{ Published the Compressor property.
}
{
{   Rev 1.19    7/30/2003 05:34:22 AM  JPMugaas
{ Fix for bug where decompression was not done if the Content Length was
{ specified.  I found that at http://www.news.com.
{ Added Identity to the content encoding to be consistant with Opera.  Identity
{ is the default Accept-Encoding (RFC 2616).
}
{
    Rev 1.18    7/13/2003 10:57:28 PM  BGooijen
  Fixed GZip and Deflate decoding
}
{
{   Rev 1.17    7/13/2003 11:29:06 AM  JPMugaas
{ Made sure some GZIP decompression stub code is in IdHTTP.
}
{
{   Rev 1.15    10.7.2003 ã. 21:03:02  DBondzhev
{ Fixed NTML proxy authorization
}
{
{   Rev 1.14    6/19/2003 02:36:56 PM  JPMugaas
{ Removed a connected check and it seems to work better that way.
}
{
{   Rev 1.13    6/5/2003 04:53:54 AM  JPMugaas
{ Reworkings and minor changes for new Reply exception framework.
}
{
{   Rev 1.12    4/30/2003 01:47:24 PM  JPMugaas
{ Added TODO concerning a ConnectTimeout.
}
{
    Rev 1.11    4/2/2003 3:18:30 PM  BGooijen
  fixed av when retrieving an url when no iohandler was assigned
}
{
    Rev 1.10    3/26/2003 5:13:40 PM  BGooijen
  TIdSSLIOHandlerSocketBase.URIToCheck is now set
}
{
{   Rev 1.9    3/13/2003 11:05:26 AM  JPMugaas
{ Now should work with 3rd party vendor SSL IOHandlers.
}
{
    Rev 1.8    3/11/2003 10:14:52 PM  BGooijen
  Undid the stripping of the CR
}
{
    Rev 1.7    2/27/2003 2:04:26 PM  BGooijen
  If any call to iohandler.readln returns a CR at the end, it is removed now.
}
{
    Rev 1.6    2/26/2003 11:50:08 AM  BGooijen
  things were messed up in TIdHTTPProtocol.RetrieveHeaders, because the call to
  readln doesn't strip the CR at the end (terminator=LF), therefore the end of
  the header was not found.
}
{
    Rev 1.5    2/26/2003 11:42:46 AM  BGooijen
  changed ReadLn (IOerror 6) to IOHandler.ReadLn
}
{
    Rev 1.4    2/4/2003 6:30:44 PM  BGooijen
  Re-enabled SSL-support
}
{
{   Rev 1.3    1/17/2003 04:14:42 PM  JPMugaas
{ Fixed warnings.
}
{
{   Rev 1.2    12/7/2002 05:32:16 PM  JPMugaas
{ Now compiles with destination removed.
}
{
{   Rev 1.1    12/6/2002 05:29:52 PM  JPMugaas
{ Now decend from TIdTCPClientCustom instead of TIdTCPClient.
}
{
{   Rev 1.0    11/13/2002 07:54:12 AM  JPMugaas
}

unit IdHTTP;

{TODO:  Figure out what to do with ConnectTimeout.  Ideally, that should be in the core
and is not the same as a read Timeout.}

{
  Implementation of the HTTP protcol as specified in RFC 2616, 2109, 2965.
  (See NOTE below for details of what is exactly implemented)

  Author: Hadi Hariri (hadi@urusoft.com)
  Copyright: (c) Chad Z. Hower and The Winshoes Working Group.

NOTE:
  Initially only GET and POST will be supported. As time goes on more will
  be added. For other developers, please add the date and what you have done
  below.

Initials: Hadi Hariri - HH

Details of implementation
-------------------------
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

interface

{$I IdCompilerDefines.inc}

uses
  IdException, IdExceptionCore, IdAssignedNumbers, IdHeaderList, IdHTTPHeaderInfo, IdReplyRFC,
  IdSSL, IdZLibCompressorBase,
  IdTCPClient, IdURI, IdCookie, IdCookieManager, IdAuthentication, IdAuthenticationManager,
  IdMultipartFormData, IdGlobal, IdSys, IdObjs, IdBaseComponent;

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
  TIdHTTPOption = (hoInProcessAuth, hoKeepOrigProtocol, hoForceEncodeParams);
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
    FContentStream: TIdStream;
    FResponseVersion: TIdHTTPProtocolVersion;
    //
    function GetKeepAlive: Boolean;
    function GetResponseCode: Integer;
  public
    constructor Create(AParent: TIdCustomHTTP); reintroduce; virtual;
    property KeepAlive: Boolean read GetKeepAlive write FKeepAlive;
    property ResponseText: string read FResponseText write FResponseText;
    property ResponseCode: Integer read GetResponseCode write FResponseCode;
    property ResponseVersion: TIdHTTPProtocolVersion read FResponseVersion write FResponseVersion;
    property ContentStream: TIdStream read FContentStream write FContentStream;
  end;

  TIdHTTPRequest = class(TIdRequestHeaderInfo)
  protected
    FHTTP: TIdCustomHTTP;
    FURL: string;
    FMethod: TIdHTTPMethod;
    FSourceStream: TIdStream;
    FUseProxy: TIdHTTPConnectionType;
    FIPVersion: TIdIPVersion;
  public
    constructor Create(AHTTP: TIdCustomHTTP); reintroduce; virtual;
    property URL: string read FURL write FURL;
    property Method: TIdHTTPMethod read FMethod write FMethod;
    property Source: TIdStream read FSourceStream write FSourceStream;
    property UseProxy: TIdHTTPConnectionType read FUseProxy;
    property IPVersion: TIdIPversion read FIPVersion write FIPVersion;
  end;

  TIdHTTPProtocol = class(TObject)
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
    FFreeOnDestroy: Boolean;
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
      ASource, AResponseContent: TIdStream; AIgnoreReplies: array of SmallInt); virtual;
    procedure InitComponent; override;
    procedure SetAuthenticationManager(Value: TIdAuthenticationManager);
    procedure SetCookieManager(ACookieManager: TIdCookieManager);
    procedure SetAllowCookies(AValue: Boolean);
    function GetResponseCode: Integer;
    function GetResponseText: string;
    function DoOnAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean; virtual;
    function DoOnProxyAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean; virtual;
    function DoOnRedirect(var Location: string; var VMethod: TIdHTTPMethod; RedirectCount: integer): boolean; virtual;
    procedure Notification(AComponent: TIdNativeComponent; Operation: TIdOperation); override;
    procedure ProcessCookies(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
    function SetHostAndPort: TIdHTTPConnectionType;
    procedure SetCookies(AURL: TIdURI; ARequest: TIdHTTPRequest);
    procedure ReadResult(AResponse: TIdHTTPResponse);
    procedure PrepareRequest(ARequest: TIdHTTPRequest);
    procedure ConnectToHost(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
    function GetResponseHeaders: TIdHTTPResponse;
    function GetRequestHeaders: TIdHTTPRequest;
    procedure SetRequestHeaders(Value: TIdHTTPRequest);

    procedure EncodeRequestParams(AStrings: TIdStrings);
    function SetRequestParams(AStrings: TIdStrings): string;

    procedure CheckAndConnect(AResponse: TIdHTTPResponse);
    procedure DoOnDisconnected; override;
  public
    destructor Destroy; override;
    procedure Options(AURL: string); overload;
    procedure Get(AURL: string; AResponseContent: TIdStream); overload;
    procedure Get(AURL: string; AResponseContent: TIdStream; AIgnoreReplies: array of SmallInt);
     overload;
    function Get(AURL: string): string; overload;
    function Get(AURL: string; AIgnoreReplies: array of SmallInt): string; overload;
    procedure Trace(AURL: string; AResponseContent: TIdStream); overload;
    function Trace(AURL: string): string; overload;
    procedure Head(AURL: string);

    function Post(AURL: string; ASource: TIdStrings): string; overload;
    function Post(AURL: string; ASource: TIdStream): string; overload;
    function Post(AURL: string; ASource: TIdMultiPartFormDataStream): string; overload;
    procedure Post(AURL: string; ASource: TIdMultiPartFormDataStream; AResponseContent: TIdStream); overload;
    procedure Post(AURL: string; ASource: TIdStrings; AResponseContent: TIdStream); overload;

    {Post data provided by a stream, this is for submitting data to a server}
    procedure Post(AURL: string; ASource, AResponseContent: TIdStream); overload;

    function Put(AURL: string; ASource: TIdStream): string; overload;
    procedure Put(AURL: string; ASource, AResponseContent: TIdStream); overload;

    {This is an object that can compress and decompress HTTP Deflate encoding}
    property Compressor : TIdZLibCompressorBase read FCompressor write FCompressor;

    {This is the response code number such as 404 for File not Found}
    property ResponseCode: Integer read GetResponseCode;
    {This is the text of the message such as "404 File Not Found here Sorry"}
    property ResponseText: string read GetResponseText;
    property Response: TIdHTTPResponse read GetResponseHeaders;
    { This is the last processed URL }
    property URL: TIdURI read FURI;
    // number of retry attempts that were made for Authentication
    property AuthRetries: Integer read FAuthRetries;
    property AuthProxyRetries: Integer read FAuthProxyRetries;
    // maximum number of Authentication retries permitted
    property MaxAuthRetries: Integer read FMaxAuthRetries write FMaxAuthRetries default Id_TIdHTTP_MaxAuthRetries;
    property AllowCookies: Boolean read FAllowCookies write SetAllowCookies;
    {Do we handle redirect requests or simply raise an exception and let the
     developer deal with it}
    property HandleRedirects: Boolean read FHandleRedirects write FHandleRedirects default Id_TIdHTTP_HandleRedirects;
    //how many redirects were made in the last request
    property RedirectCount:Integer read FRedirectCount;
    {This is the maximum number of redirects we wish to handle, we limit this
     to prevent stack overflow due to recursion.  Recursion is safe ONLY if
     prevented for continuing to infinity}
    property RedirectMaximum: Integer read FRedirectMax write FRedirectMax default Id_TIdHTTP_RedirectMax;
    property ProtocolVersion: TIdHTTPProtocolVersion read FProtocolVersion write FProtocolVersion default Id_TIdHTTP_ProtocolVersion;
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
  IdComponent, IdCoderMIME, IdTCPConnection, IdResourceStringsProtocols,
  IdGlobalProtocols, IdIOHandler,IdIOHandlerSocket;

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

destructor TIdCustomHTTP.Destroy;
begin
  Sys.FreeAndNil(FHTTPProto);
  Sys.FreeAndNil(FURI);
  Sys.FreeAndNil(FProxyParameters);
  inherited Destroy;
end;

procedure TIdCustomHTTP.Options(AURL: string);
begin
  DoRequest(Id_HTTPMethodOptions, AURL, nil, nil, []);
end;

procedure TIdCustomHTTP.Get(AURL: string; AResponseContent: TIdStream);
begin
  Assert(AResponseContent<>nil);

  Get(AURL, AResponseContent, []);
end;

procedure TIdCustomHTTP.Trace(AURL: string; AResponseContent: TIdStream);
begin
  Assert(AResponseContent<>nil);

  DoRequest(Id_HTTPMethodTrace, AURL, nil, AResponseContent, []);
end;

procedure TIdCustomHTTP.Head(AURL: string);
begin
  DoRequest(Id_HTTPMethodHead, AURL, nil, nil, []);
end;

procedure TIdCustomHTTP.Post(AURL: string; ASource, AResponseContent: TIdStream);
var
  OldProtocol: TIdHTTPProtocolVersion;
begin
  Assert(ASource<>nil);
  Assert(AResponseContent<>nil);

  // PLEASE READ CAREFULLY

  // Currently when issuing a POST, IdHTTP will automatically set the protocol
  // to version 1.0 independently of the value it had initially. This is because
  // there are some servers that don't respect the RFC to the full extent. In
  // particular, they don't respect sending/not sending the Expect: 100-Continue
  // header. Until we find an optimum solution that does NOT break the RFC, we
  // will restrict POSTS to version 1.0.
  if Connected then
  begin
    Disconnect;
  end;
  OldProtocol := FProtocolVersion;
  // If hoKeepOrigProtocol is SET, is possible to assume that the developer
  // is sure in operations of the server
  if not (hoKeepOrigProtocol in FOptions) then
    FProtocolVersion := pv1_0;
  DoRequest(Id_HTTPMethodPost, AURL, ASource, AResponseContent, []);
  FProtocolVersion := OldProtocol;
end;

procedure TIdCustomHTTP.EncodeRequestParams(AStrings: TIdStrings);
var
  i: Integer;
  LPos: integer;
  LStr: string;
begin
  Assert(AStrings<>nil);

  for i := 0 to AStrings.Count - 1 do begin
    //AStrings[i] := AStrings.Names[i] + AStrings.NameValueSeparator + TIdURI.ParamsEncode(AStrings.ValueFromIndex[i]);
    LStr := AStrings[i];
    LPos := IndyPos('=', LStr);
    if LPos > 0 then begin
      AStrings[i] := Copy(LStr, 1, LPos-1) + '=' + TIdURI.ParamsEncode(Copy(LStr, LPos+1, MAXINT));
    end;
  end;
end;

function TIdCustomHTTP.SetRequestParams(AStrings: TIdStrings): string;
begin
  if Assigned(AStrings) then begin
    if hoForceEncodeParams in FOptions then begin
      EncodeRequestParams(AStrings);
    end;
    if AStrings.Count > 1 then begin
      // break trailing CR&LF
      Result := Sys.StringReplace(Sys.Trim(AStrings.Text), sLineBreak, '&');
    end else begin
      Result := Sys.Trim(AStrings.Text);
    end;
  end else begin
    Result := '';
  end;
end;

procedure TIdCustomHTTP.Post(AURL: string; ASource: TIdStrings; AResponseContent: TIdStream);
var
  LParams: TIdStream;
begin
  Assert(ASource<>nil);
  Assert(AResponseContent<>nil);

  // Usual posting request have default ContentType is application/x-www-form-urlencoded
  if (Request.ContentType = '') or (TextIsSame(Request.ContentType, 'text/html')) then {do not localize}
    Request.ContentType := 'application/x-www-form-urlencoded'; {do not localize}

  LParams := TIdStringStream.Create(SetRequestParams(ASource));
  try
    Post(AURL, LParams, AResponseContent);
  finally
    Sys.FreeAndNil(LParams);
  end;
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TIdStrings): string;
var
  LResponse: TIdStringStream;
begin
  Assert(ASource<>nil);

  LResponse := TIdStringStream.Create('');
  try
    Post(AURL, ASource, LResponse);
  finally
    result := LResponse.DataString;
    Sys.FreeAndNil(LResponse);
  end;
end;

function TIdCustomHTTP.Post(AURL: string; ASource: TIdStream): string;
var
  LResponse: TIdStringStream;
begin
  Assert(ASource<>nil);

  LResponse := TIdStringStream.Create('');
  try
    Post(AURL, ASource, LResponse);
  finally
    result := LResponse.DataString;
    Sys.FreeAndNil(LResponse);
  end;
end;

procedure TIdCustomHTTP.Put(AURL: string; ASource, AResponseContent: TIdStream);
begin
  Assert(ASource<>nil);
  Assert(AResponseContent<>nil);

  DoRequest(Id_HTTPMethodPut, AURL, ASource, AResponseContent, []);
end;

function TIdCustomHTTP.Put(AURL: string; ASource: TIdStream): string;
var
  LResponse: TIdStringStream;
begin
  Assert(ASource<>nil);

  LResponse := TIdStringStream.Create('');   {do not localize}
  try
    Put(AURL, ASource, LResponse);
  finally
    result := LResponse.DataString;
    Sys.FreeAndNil(LResponse);
  end;
end;

function TIdCustomHTTP.Get(AURL: string): string;
begin
  Result := Get(AURL, []);
end;

function TIdCustomHTTP.Trace(AURL: string): string;
var
  Stream: TIdStringStream;
begin
  Stream := TIdStringStream.Create('');  {do not localize}
  try
    Trace(AURL, Stream);
    Result := Stream.DataString;
  finally
    Sys.FreeAndNil(Stream);
  end;
end;

function TIdCustomHTTP.DoOnRedirect(var Location: string; var VMethod: TIdHTTPMethod; RedirectCount: integer): boolean;
begin
  Result := HandleRedirects;
  if Assigned(FOnRedirect) then begin
    FOnRedirect(Self, Location, RedirectCount, Result, VMethod);
  end;
end;

procedure TIdCustomHTTP.SetCookies(AURL: TIdURI; ARequest: TIdHTTPRequest);
var
  S: string;
begin
  if Assigned(FCookieManager) then begin
    // Send secure cookies only if we have Secured connection
    S := FCookieManager.GenerateCookieList(AURL, (IOHandler is TIdSSLIOHandlerSocketBase));
    if Length(S) > 0 then begin
      ARequest.RawHeaders.Values['Cookie'] := S;  {do not localize}
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
    LPort := Sys.StrToInt(URL.Port, 80);
    if (not TextIsSame(FHost, LHost)) or (LPort <> FPort) then begin
      if Connected then begin
        Disconnect;
      end;
    end;
    if TextIsSame(URL.Protocol, 'HTTPS') then begin  {do not localize}
      // Just check can we do SSL
      if (not Assigned(IOHandler)) or (not (IOHandler is TIdSSLIOHandlerSocketBase)) then begin
        raise EIdIOHandlerPropInvalid.Create(RSIOHandlerPropInvalid);
      end;
      TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := False;
      Result := ctSSL;
    end else begin
      if Assigned(IOHandler) then begin
        if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
          TIdSSLIOHandlerSocketBase(IOHandler).PassThrough := True;
        end;
      end;
      Result := ctNormal;
    end;
  end;
  Host := LHost;
  Port := LPort;
end;

procedure TIdCustomHTTP.ReadResult(AResponse: TIdHTTPResponse);
var LS : TIdStream;
  LDecMeth : Integer;
  //0 - no compression was used or we can't support that feature
  //1 - deflate
  //2 - gzip

  function ChunkSize: integer;
  var
    j: Integer;
    s: string;
  begin
    s := IOHandler.ReadLn;
    j := IndyPos(' ', s);
    if j > 0 then
    begin
      s := Copy(s, 1, j - 1);
    end;
    Result := Sys.StrToInt('$' + s, 0);      {do not localize}
  end;

var
  Size: Integer;
begin
  LDecMeth := 0;
  //we need to determine what type of decompression may need to used
  //before we read from the IOHandler.  If there is compression,
  //then we use the LM stream to hold the compressed data that was downloaded
  //and decompress it.  If no compression is used, LS will equal ContentStream
  if Assigned(Compressor) then
  begin
     if (Response.ContentEncoding = 'deflate') then   {do not localize}
     begin
       LDecMeth := 1;
     end;
     if (Response.ContentEncoding = 'gzip') then   {do not localize}
     begin
       LDecMeth := 2;
     end;
  end;

  if Assigned(AResponse.ContentStream) then // Only for Get and Post
  begin
    if LDecMeth > 0 then
    begin
      LS :=  TIdMemoryStream.Create;
    end
    else
    begin
      LS := AResponse.ContentStream;
    end;
    try
      if AResponse.ContentLength > 0 then // If chunked then this is also 0
      begin
        try
          IOHandler.ReadStream(LS, AResponse.ContentLength);
        except
          on E: EIdConnClosedGracefully do
        end;
      end
      else
      begin
        if IndyPos('chunked', AResponse.RawHeaders.Values['Transfer-Encoding']) > 0 then {do not localize}
        begin // Chunked
          DoStatus(hsStatusText, [RSHTTPChunkStarted]);
          Size := ChunkSize;
          while Size > 0 do
          begin
            IOHandler.ReadStream(LS, Size);
            IOHandler.ReadLn; // blank line
            Size := ChunkSize;
          end;
          IOHandler.ReadLn; // blank line
        end else begin
          if not AResponse.HasContentLength then
          begin
            IOHandler.ReadStream(LS, -1, True);
          end;
        end;
      end;
      if LDecMeth > 0 then
      begin
        LS.Position := 0;
      end;
      case LDecMeth of
        1 :  Compressor.DecompressDeflateStream(LS,AResponse.ContentStream);
        2 :  Compressor.DecompressGZipStream(LS,AResponse.ContentStream);
      end;
    finally
      if LDecMeth > 0 then
      begin
        Sys.FreeAndNil(LS);
      end;
    end;
  end;
end;

function IsStringInArray(const aStr:string;const aArray:array of string):boolean;
var
 i:integer;
begin
  Result:=False;
  for i:=Low(aArray) to High(aArray) do
  begin
  if aStr=aArray[i] then
   begin
   Result:=True;
   Break;
   end;
  end;
end;

procedure TIdCustomHTTP.PrepareRequest(ARequest: TIdHTTPRequest);
var
  LURI: TIdURI;
begin
  LURI := TIdURI.Create(ARequest.URL);

  try
    if Length(LURI.Username) > 0 then
    begin
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
    else begin
      if TextIsSame(LURI.Protocol, 'http') then begin     {do not localize}
        FURI.Port := Sys.IntToStr(IdPORT_HTTP);
      end else begin
        if TextIsSame(LURI.Protocol, 'https') then begin  {do not localize}
          FURI.Port := Sys.IntToStr(IdPORT_SSL);
        end else begin
          if Length(FURI.Port) > 0 then begin
          {  FURI.Port:=FURI.Port; } // do nothing, as the port is already filled in.
          end else begin
            raise EIdUnknownProtocol.Create(RSHTTPUnknownProtocol);
          end;
        end;
      end;
    end;

    // The URL part is not URL encoded at this place
    ARequest.URL := URL.Path + URL.Document + URL.Params;

    if ARequest.Method = Id_HTTPMethodOptions then
    begin
      if TextIsSame(LURI.Document, '*') then      {do not localize}
      begin
        ARequest.URL := LURI.Document;
      end;
    end;

    ARequest.IPVersion := LURI.IPVersion;
    FURI.IPVersion := ARequest.IPVersion;

    // Check for valid HTTP request methods
    if IsStringInArray(ARequest.Method,[Id_HTTPMethodTrace, Id_HTTPMethodPut, Id_HTTPMethodOptions, Id_HTTPMethodDelete]) then
    begin
      if ProtocolVersion <> pv1_1 then
      begin
        raise EIdException.Create(RSHTTPMethodRequiresVersion);
      end;
    end;

    //IsStringInArray(ARequest.Method , [Id_HTTPMethodPost, Id_HTTPMethodPut]) then begin
    if Assigned(ARequest.Source) then begin
      ARequest.ContentLength := ARequest.Source.Size;
    end else begin
      ARequest.ContentLength := -1;
    end;

    if FURI.Port <> Sys.IntToStr(IdPORT_HTTP) then begin
      ARequest.Host := FURI.Host + ':' + FURI.Port;    {do not localize}
    end else begin
      ARequest.Host := FURI.Host;
    end;
  finally
    Sys.FreeAndNil(LURI);  // Free URI Object
  end;
end;

procedure TIdCustomHTTP.CheckAndConnect(AResponse: TIdHTTPResponse);
begin
  Assert(AResponse<>nil);

  if not AResponse.KeepAlive then begin
    Disconnect;
  end;

  CheckForGracefulDisconnect(false);

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
begin
  ARequest.FUseProxy := SetHostAndPort;

  if ARequest.UseProxy = ctProxy then
  begin
    ARequest.URL := FURI.URI;
  end;

  case ARequest.UseProxy of
    ctNormal:
      if (ProtocolVersion = pv1_0) and (Length(ARequest.Connection) = 0) then
        ARequest.Connection := 'keep-alive';      {do not localize}
    ctSSL, ctSSLProxy: ARequest.Connection := '';
    ctProxy:
      if (ProtocolVersion = pv1_0) and (Length(ARequest.Connection) = 0) then
      begin
        ARequest.ProxyConnection := 'keep-alive'; {do not localize}
      end;
  end;

  if Assigned(FCompressor) then begin
    if (IndyPos('deflate',Request.AcceptEncoding)=0) and  {do not localize}
      (IndyPos('gzip',Request.AcceptEncoding)=0) then     {do not localize}
    begin
      Request.AcceptEncoding := 'deflate, gzip, ';        {do not localize}
    end;
  end;
  if IndyPos('identity', Request.AcceptEncoding) = 0 then begin  {do not localize}
    //why is this done? should also be done 'safer' eg possibly adding a comma before
    Request.AcceptEncoding := Request.AcceptEncoding + 'identity'; {do not localize}
  end;
  if ARequest.UseProxy = ctSSLProxy then begin
    LLocalHTTP := TIdHTTPProtocol.Create(Self);

    with LLocalHTTP do begin
      Request.UserAgent := ARequest.UserAgent;
      Request.Host := ARequest.Host;
      Request.ContentLength := ARequest.ContentLength;
      Request.Pragma := 'no-cache';                       {do not localize}
      Request.URL := URL.Host + ':' + URL.Port;
      Request.Method := Id_HTTPMethodConnect;
      Request.ProxyConnection := 'keep-alive';            {do not localize}

      Response.ContentStream := TIdMemoryStream.Create;
      try
        try
          repeat
            CheckAndConnect(Response);
            BuildAndSendRequest(nil);

            Response.ResponseText := IOHandler.ReadLn;
            if Length(Response.ResponseText) = 0 then begin
              // Support for HTTP responses without status line and headers
              Response.ResponseText := 'HTTP/1.0 200 OK'; {do not localize}
              Response.Connection := 'close';             {do not localize}
            end else begin
              RetrieveHeaders(MaxHeaderLines);
              ProcessCookies(LLocalHTTP.Request, LLocalHTTP.Response);
            end;

            if Response.ResponseCode = 200 then
            begin
              // Connection established
              if (IOHandler is TIdSSLIOHandlerSocketBase) then begin
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
        Sys.FreeAndNil(LLocalHTTP);
      end;
    end;
  end else begin
    CheckAndConnect(AResponse);
  end;

  FHTTPProto.BuildAndSendRequest(URL);

  if IsStringInArray(ARequest.Method , [Id_HTTPMethodPost, Id_HTTPMethodPut]) then
  begin
    IOHandler.Write(ARequest.Source, 0, false);
  end;
end;

procedure TIdCustomHTTP.SetAllowCookies(AValue: Boolean);
begin
  FAllowCookies := AValue;
end;

procedure TIdCustomHTTP.ProcessCookies(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse);
var
  Cookies, Cookies2: TIdStringList;
  i: Integer;
begin
  Cookies := nil;
  Cookies2 := nil;
  try
    if not Assigned(FCookieManager) and AllowCookies then
    begin
      CookieManager := TIdCookieManager.Create(Self);
      FFreeOnDestroy := true;
    end;

    if Assigned(FCookieManager) then
    begin
      Cookies := TIdStringList.Create;
      Cookies2 := TIdStringList.Create;

      AResponse.RawHeaders.Extract('Set-cookie', Cookies);    {do not localize}
      AResponse.RawHeaders.Extract('Set-cookie2', Cookies2);  {do not localize}

      for i := 0 to Cookies.Count - 1 do
        CookieManager.AddCookie(Cookies[i], FURI.Host);

      for i := 0 to Cookies2.Count - 1 do
        CookieManager.AddCookie2(Cookies2[i], FURI.Host);
    end;
  finally
    Sys.FreeAndNil(Cookies);
    Sys.FreeAndNil(Cookies2);
  end;
end;

procedure TIdCustomHTTP.Notification(AComponent: TIdNativeComponent; Operation: TIdOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
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
  if Assigned(FCookieManager) then
  begin
    if FFreeOnDestroy then begin
      Sys.FreeAndNil(FCookieManager);
    end;
  end;

  FCookieManager := ACookieManager;
  FFreeOnDestroy := false;

  if Assigned(FCookieManager) then
  begin
    FCookieManager.FreeNotification(Self);
  end;
end;

function TIdCustomHTTP.DoOnAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean;
var
  i: Integer;
  S: string;
  Auth: TIdAuthenticationClass;
begin
  Inc(FAuthRetries);
  if not Assigned(ARequest.Authentication) then
  begin
    // Find wich Authentication method is supported from us.
    for i := 0 to AResponse.WWWAuthenticate.Count - 1 do
    begin
      S := AResponse.WWWAuthenticate[i];
      Auth := FindAuthClass(Fetch(S));
      if Auth <> nil then
        break;
    end;

    if Auth = nil then begin
      result := false;
      exit;
    end;

    if Assigned(FOnSelectAuthorization) then
    begin
      OnSelectAuthorization(self, Auth, AResponse.WWWAuthenticate);
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
  result := Assigned(FOnAuthorization) or (Sys.Trim(ARequest.Password) <> '');

  if Result then
  begin
    with ARequest.Authentication do
    begin
      Username := ARequest.Username;
      Password := ARequest.Password;
      // S.G. 20/10/2003: ToDo: We need to have a marker here to prevent the code to test with the same username/password combo
      // S.G. 20/10/2003: if they are picked up from properties.
      Params.Values['Authorization'] := ARequest.Authentication.Authentication; {do not localize}
      AuthParams := AResponse.WWWAuthenticate;
    end;

    result := false;

    repeat
      case ARequest.Authentication.Next of
        wnAskTheProgram:
          begin // Ask the user porgram to supply us with authorization information
            if Assigned(FOnAuthorization) then
            begin
              ARequest.Authentication.UserName := ARequest.Username;
              ARequest.Authentication.Password := ARequest.Password;

              OnAuthorization(self, ARequest.Authentication, result);

              if result then begin
                ARequest.BasicAuthentication := true;
                ARequest.Username := ARequest.Authentication.UserName;
                ARequest.Password := ARequest.Authentication.Password;
              end
              else begin
                break;
              end;
            end;
          end;
        wnDoRequest:
          begin
            result := true;
            break;
          end;
        wnFail:
          begin
            result := False;
            Break;
          end;
      end;
    until false;
  end;
end;

function TIdCustomHTTP.DoOnProxyAuthorization(ARequest: TIdHTTPRequest; AResponse: TIdHTTPResponse): Boolean;
var
  i: Integer;
  S: string;
  Auth: TIdAuthenticationClass;
begin
  Inc(FAuthProxyRetries);
  if not Assigned(ProxyParams.Authentication) then
  begin
    // Find which Authentication method is supported from us.
    i := 0;
    while i < AResponse.ProxyAuthenticate.Count do
    begin
      S := AResponse.ProxyAuthenticate[i];
      try
        Auth := FindAuthClass(Fetch(S));
        break;
      except
      end;
      inc(i);
    end;

    if i = AResponse.ProxyAuthenticate.Count then
    begin
      result := false;
      exit;
    end;

    if Assigned(FOnSelectProxyAuthorization) then
    begin
      OnSelectProxyAuthorization(self, Auth, AResponse.ProxyAuthenticate);
    end;

    if Assigned(Auth) then begin
      ProxyParams.Authentication := Auth.Create;
    end;
  end;

  result := Assigned(ProxyParams.Authentication) and  Assigned(OnProxyAuthorization);

  {
  this is commented out as it breaks SSPI proxy authentication.
  it is normal and expected to get 407 responses during the negotiation.

  // Clear password and reset authorization if previous failed
  if (AResponse.FResponseCode = 407) then begin
    ProxyParams.ProxyPassword := '';
    ProxyParams.Authentication.Reset;
  end;
  }

  if Result then
  begin
    with ProxyParams.Authentication do
    begin
      Username := ProxyParams.ProxyUsername;
      Password := ProxyParams.ProxyPassword;

      AuthParams := AResponse.ProxyAuthenticate;
    end;

    result := false;

    repeat
      case ProxyParams.Authentication.Next of
        wnAskTheProgram: // Ask the user porgram to supply us with authorization information
          begin
            if Assigned(OnProxyAuthorization) then
            begin
              ProxyParams.Authentication.Username := ProxyParams.ProxyUsername;
              ProxyParams.Authentication.Password := ProxyParams.ProxyPassword;

              OnProxyAuthorization(self, ProxyParams.Authentication, result);

              if result then begin
                ProxyParams.ProxyUsername := ProxyParams.Authentication.Username;
                ProxyParams.ProxyPassword := ProxyParams.Authentication.Password;
              end
              else begin
                break;
              end;
            end;
          end;
        wnDoRequest:
          begin
            result := true;
            break;
          end;
        wnFail:
          begin
            result := False;
            Break;
          end;
      end;
    until false;
  end;
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
  FAuthenticationManager := Value;
  if Assigned(FAuthenticationManager) then
  begin
    FAuthenticationManager.FreeNotification(self);
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
procedure TIdCustomHTTP.SetRequestHEaders(Value: TIdHTTPRequest);
begin
  FHTTPProto.Request.Assign(Value);
end;

procedure TIdCustomHTTP.Post(AURL: string;
  ASource: TIdMultiPartFormDataStream; AResponseContent: TIdStream);
begin
  Assert(ASource<>nil);
  Assert(AResponseContent<>nil);

  Request.ContentType := ASource.RequestContentType;
  Post(AURL, TIdStream(ASource), AResponseContent);
end;

function TIdCustomHTTP.Post(AURL: string;
  ASource: TIdMultiPartFormDataStream): string;
begin
  Assert(ASource<>nil);

  Request.ContentType := ASource.RequestContentType;
  result := Post(AURL, TIdStream(ASource));
end;

{ TIdHTTPResponse }

constructor TIdHTTPResponse.Create(AParent: TIdCustomHTTP);
begin
  inherited Create;

  FHTTP := AParent;
end;

function TIdHTTPResponse.GetKeepAlive: Boolean;
var
  S: string;
  i: TIdHTTPProtocolVersion;
begin
  S := Copy(FResponseText, 6, 3);

  for i := Low(TIdHTtpProtocolVersion) to High(TIdHTtpProtocolVersion) do
    if TextIsSame(ProtocolVersionString[i], S) then
    begin
      ResponseVersion := i;
      break;
    end;

  if FHTTP.Connected then begin
    FHTTP.IOHandler.CheckForDisconnect(false);
  end;
  FKeepAlive := FHTTP.Connected;

  if FKeepAlive then
    case FHTTP.ProtocolVersion of
      pv1_1:
        { By default we assume that keep-alive is by default and will close
          the connection only there is "close" }
        begin
          FKeepAlive :=
            not (TextIsSame(Sys.Trim(Connection), 'CLOSE') or   {do not localize}
            TextIsSame(Sys.Trim(ProxyConnection), 'CLOSE'));    {do not localize}
        end;
      pv1_0:
        { By default we assume that keep-alive is not by default and will keep
          the connection only if there is "keep-alive" }
        begin
          FKeepAlive := TextIsSame(Sys.Trim(Connection), 'KEEP-ALIVE') or  {do not localize}
            TextIsSame(Sys.Trim(ProxyConnection), 'KEEP-ALIVE')            {do not localize}
            { or ((ResponseVersion = pv1_1) and
              (Length(Sys.Trime(Connection)) = 0) and
              (Length(Sys.Trime(ProxyConnection)) = 0)) };
        end;
    end;
  result := FKeepAlive;
end;

function TIdHTTPResponse.GetResponseCode: Integer;
var
  S: string;
begin
  S := FResponseText;
  Fetch(S);
  S := Sys.Trim(S);
  FResponseCode := Sys.StrToInt(Fetch(S, ' ', False), -1);
  Result := FResponseCode;
end;

{ TIdHTTPRequest }

constructor TIdHTTPRequest.Create(AHTTP: TIdCustomHTTP);
begin
  inherited Create;

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
  Sys.FreeAndNil(FRequest);
  Sys.FreeAndNil(FResponse);

  inherited Destroy;
end;

procedure TIdHTTPProtocol.BuildAndSendRequest(AURI: TIdURI);
var
  i: Integer;
begin
  Request.SetHeaders;
  FHTTP.ProxyParams.SetHeaders(Request.RawHeaders);
  if Assigned(AURI) then
  begin
    FHTTP.SetCookies(AURI, Request);
  end;
  // This is a workaround for some HTTP servers which do not implement
  // the HTTP protocol properly
  FHTTP.IOHandler.WriteBufferOpen;
  try
    FHTTP.IOHandler.WriteLn(Request.Method+' ' + Request.URL + ' HTTP/' + ProtocolVersionString[FHTTP.ProtocolVersion]); {do not localize}
    // write the headers
    for i := 0 to Request.RawHeaders.Count - 1 do
      if Length(Request.RawHeaders.Strings[i]) > 0 then
        FHTTP.IOHandler.WriteLn(Request.RawHeaders.Strings[i]);
    FHTTP.IOHandler.WriteLn('');     {do not localize}
    FHTTP.IOHandler.WriteBufferClose;
  except
    FHTTP.IOHandler.WriteBufferCancel;
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
  s := FHTTP.IOHandler.ReadLn;
  try
    LHeaderCount := 0;
    while (s <> '') and ( (AMaxHeaderCount > 0) or (LHeaderCount < AMaxHeaderCount) ) do
    begin
      Response.RawHeaders.Add(S);
      s := FHTTP.IOHandler.ReadLn;
      inc(LHeaderCount);
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

  procedure CheckException(AIgnoreReplies: array of SmallInt);
  var
    i: Integer;
    LResponseCode: Integer;
    LRespStream: TIdStringStream;
    LTempStream: TIdStream;
  begin
    //Kudzu: Why should we override the user? User can set ReadTimeout. Respect theirs.
    //FHTTP.IOHandler.ReadTimeout := 2000; // Lets wait 2 seconds for any kind of content
    LRespStream := TIdStringStream.Create('');
    LTempStream := Response.ContentStream;
    Response.ContentStream := LRespStream;
    try
      FHTTP.ReadResult(Response);
      // Cache this as ResponseCode calls GetResponseCode which parses it out
      LResponseCode := Response.ResponseCode;
      if High(AIgnoreReplies) > -1 then begin
        for i := Low(AIgnoreReplies) to High(AIgnoreReplies) do begin
          if LResponseCode = AIgnoreReplies[i] then begin
            Exit;
          end;
        end;
      end;
      raise EIdHTTPProtocolException.CreateError(LResponseCode, FHTTP.ResponseText, LRespStream.DataString);
    finally
      Response.ContentStream := LTempStream;
      Sys.FreeAndNil(LRespStream);
    end;
  end;

  procedure ReadContent;
  var
    LTempResponse: TIdStringStream;
    LTempStream: TIdStream;
  begin
    LTempResponse := TIdStringStream.Create('');
    LTempStream := Response.ContentStream;
    Response.ContentStream := LTempResponse;
    try
      FHTTP.ReadResult(Response);
    finally
      Sys.FreeAndNil(LTempResponse);
      Response.ContentStream := LTempStream;
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
  LResponseDigit: Integer;
  LTemp: Integer;
begin

  // provide the user with the headers and let the user decide
  // whether the response processing should continue...
  if not HeadersCanContinue then begin
    Response.KeepAlive := False; // force DoRequest() to disconnect the connection
    Result := wnJustExit;
    Exit;
  end;

  LNeedAuth := False;
  LResponseDigit := Response.ResponseCode div 100;
  // Handle Redirects
  if ((LResponseDigit = 3) and (Response.ResponseCode <> 304)) or (Response.Location <> '') then
  begin
    Inc(FHTTP.FRedirectCount);
    // LLocation := TIdURI.URLDecode(Response.Location);
    LLocation := Response.Location;

    if (FHTTP.FHandleRedirects) and (FHTTP.FRedirectCount < FHTTP.FRedirectMax) then begin
      LMethod := Request.Method;
      if FHTTP.DoOnRedirect(LLocation, LMethod, FHTTP.FRedirectCount) then begin
        Result := wnGoToURL;
        Request.URL := LLocation;
        // GDG 21/11/2003. If it's a 303, we should do a get this time
        // RLebeau 7/15/2004 - do a GET on 302 as well, as mentioned in RFC 2616
        if (Response.ResponseCode = 302) or (Response.ResponseCode = 303) then begin
          Request.Source := nil;
          Request.Method := Id_HTTPMethodGet;
        end else begin
          Request.Method := LMethod;
        end;
      end else begin
        CheckException(AIgnoreReplies);
        Result := wnJustExit;
        Exit;
      end;
    // Just fire the event
    end else begin
      LMethod := Request.Method;
      result := wnJustExit;
      // If not Handled
      if not FHTTP.DoOnRedirect(LLocation, LMethod, FHTTP.FRedirectCount) then begin
        CheckException(AIgnoreReplies);
        Result := wnJustExit;
        Exit;
      end else begin
        Response.Location := LLocation;
      end;
    end;

    if FHTTP.Connected then begin
      // This is a workaround for buggy HTTP 1.1 servers which
      // does not return any body with 302 response code
      //
      // Kudzu: Does this need to be duplicated elsewhere? If so it needs to be put in a reuable
      // proc. I removed it in other places as it was somtimes trashing user values and also
      // had no comments.
      LTemp := FHTTP.IOHandler.ReadTimeout; try
        FHTTP.IOHandler.ReadTimeout := 4000; // Lets wait 4 seconds for any kind of content
        try
          ReadContent;
        except end;
      finally FHTTP.IOHandler.ReadTimeout := LTemp; end;
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

    if LResponseDigit <> 2 then begin
      case Response.ResponseCode of
        401:
          begin // HTTP Server authorization required
            if (FHTTP.AuthRetries >= FHTTP.MaxAuthRetries) or
               (not FHTTP.DoOnAuthorization(Request, Response)) then
            begin
              if Assigned(Request.Authentication) then begin
                Request.Authentication.Reset;
              end;
              CheckException(AIgnoreReplies);
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
              CheckException(AIgnoreReplies);
              Result := wnJustExit;
              Exit;
            end else begin
              LNeedAuth := hoInProcessAuth in FHTTP.HTTPOptions;
            end;
          end;
        else begin
          CheckException(AIgnoreReplies);
          Result := wnJustExit;
          Exit;
        end;
      end;
    end;

    if LNeedAuth then begin
      // Read the content of Error message in temporary stream
      ReadContent;
      Result := wnAuthRequest
    end else if (Response.ResponseCode <> 204) then begin
      FHTTP.ReadResult(Response);
      Result := wnJustExit;
    end else begin
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
  FFreeOnDestroy := false;
  FOptions := [hoForceEncodeParams];

  FRedirectMax := Id_TIdHTTP_RedirectMax;
  FHandleRedirects := Id_TIdHTTP_HandleRedirects;
  //
  FProtocolVersion := Id_TIdHTTP_ProtocolVersion;

  FHTTPProto := TIdHTTPProtocol.Create(Self);
  FProxyParameters := TIdProxyConnectionInfo.Create;
  FProxyParameters.Clear;

  FMaxAuthRetries := Id_TIdHTTP_MaxAuthRetries;
  FMaxHeaderLines := Id_TIdHTTP_MaxHeaderLines;
end;

function TIdCustomHTTP.Get(
  AURL: string;
  AIgnoreReplies: array of SmallInt
  ): string;
var
  LStream: TIdMemoryStream;
begin
  LStream := TIdMemoryStream.Create;
  try
    Get(AURL, LStream, AIgnoreReplies);
    LStream.Position := 0;
    // This is here instead of a TStringSream for .net conversions?
    Result := ReadStringFromStream(LStream);
  finally
    Sys.FreeAndNil(LStream);
  end;
end;

procedure TIdCustomHTTP.Get(AURL: string; AResponseContent: TIdStream;
  AIgnoreReplies: array of SmallInt);
begin
  Assert(AResponseContent<>nil);

  DoRequest(Id_HTTPMethodGet, AURL, nil, AResponseContent, AIgnoreReplies);
end;

procedure TIdCustomHTTP.DoRequest(const AMethod: TIdHTTPMethod;
  AURL: string; ASource, AResponseContent: TIdStream;
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
        Response.ResponseText := IOHandler.ReadLn;
        FHTTPProto.RetrieveHeaders(MaxHeaderLines);
        ProcessCookies(Request, Response);
      until Response.ResponseCode <> 100;

      case FHTTPProto.ProcessResponse(AIgnoreReplies) of
        wnAuthRequest: begin
            Request.URL := AURL;
          end;
        wnReadAndGo: begin
            ReadResult(Response);
            if Assigned(AResponseContent) then begin
              AResponseContent.Position := LResponseLocation;
              AResponseContent.Size := LResponseLocation;
            end;
            FAuthRetries := 0;
            FAuthProxyRetries := 0;
          end;
        wnGoToURL: begin
            if Assigned(AResponseContent) then begin
              AResponseContent.Position := LResponseLocation;
              AResponseContent.Size := LResponseLocation;
            end;
            FAuthRetries := 0;
            FAuthProxyRetries := 0;
          end;
        wnJustExit: Break;
        wnDontKnow: raise EIdException.Create(RSHTTPNotAcceptable);
      end;
    until False;
  finally
    if not Response.KeepAlive then begin
      Disconnect;
    end;
  end;
end;

end.

