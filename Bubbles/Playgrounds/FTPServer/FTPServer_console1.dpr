
{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  15243: FTPServer_console1.dpr 
{
{   Rev 1.20    7/3/2004 3:15:50 AM  JPMugaas
{ Checked in so everyone else can work on stuff while I'm away.
}
{
    Rev 1.19    3/15/2003 12:34:36 AM  BGooijen
  Updated for new API
}
{
{   Rev 1.18    2/22/2003 04:56:36 AM  JPMugaas
{ Updated for new API.
}
{
{   Rev 1.16    2/14/2003 12:10:46 PM  JPMugaas
{ Fixed a potential security flaw where a CDUP could move up to a real
{ directory where the server was not intended to access.  This occured with
{ MS-DOS emulation.
}
{
{   Rev 1.15    2/9/2003 02:59:54 PM  JPMugaas
{ Enabled both implicit and explicit TLS support
}
{
{   Rev 1.14    2/8/2003 10:39:38 AM  JPMugaas
{ Now fakes an inode value with Unix style and the -i switch.
{ Recursive dirs no longer permitted with the standard "myuser" account to
{ demonstrate policy with that.
}
{
{   Rev 1.13    2/8/2003 04:52:20 AM  JPMugaas
{ FTP Server dir routines now always provide the . and .. sybmols even for
{ non-recursive dir listings.  This is now selectively omitted with the
{ IdFTPList.ExportList function in an appropriate manner depending upon the
{ ListFormat property and if the "-A" switch is present in Unix.
}
{
{   Rev 1.12    2/5/2003 08:47:12 AM  JPMugaas
{ Modified to support some Unix switches when in emulating Unix.  More should
{ be supported as more is added.
{ The .. and . are now in the dir list only in Unix mode and only if the -A
{ switch was not passed.
}
{
{   Rev 1.11    2/4/2003 05:35:00 PM  JPMugaas
{ Adjusted for new parameters.  The FTP Server now also can do a recursive
{ listing.
}
{
{   Rev 1.10    2/3/2003 11:10:06 AM  JPMugaas
{ Started port to Linux.  Note that it still does not yet work.  I also added
{ code for setting a "block count" so we can get a nice "total x" line for ls
{ -l emulation.
}
{
{   Rev 1.9    1/31/2003 01:20:04 PM  JPMugaas
{ Now properly compiles.
}
{
{   Rev 1.8    1/31/2003 06:39:58 AM  JPMugaas
{ Now only uses an arbitrary base directory instead of a specific drive when
{ refering to directories.  This should prevent unintended read-write access to
{ a system or potential trouble (such as uploading a trojan horse).
{ Added an "administrative" account with the weakest security settings to
{ demonstrate selective security privilleges.
{ Disable STAT for normal users so that they can't use it to "fingerprint" a
{ system.  Stat is still enabled on administrative account.
{ No longer identifies itself as the Indy Demo in the SYST command.  We changed
{ the behavior of the SYST command and it's best to make the SYST description
{ as generic as possible anyway.
}
{
{   Rev 1.7    1/30/2003 02:49:40 AM  JPMugaas
{ Updated exception handling fixes.
}
{
{   Rev 1.6    1/28/2003 04:08:54 PM  JPMugaas
{ Updated test program for exceptions.
}
{
{   Rev 1.5    1/27/2003 05:06:30 AM  JPMugaas
{ Added a Status information event.
}
{
{   Rev 1.4    1/27/2003 02:23:54 AM  JPMugaas
{ Removed old commented code for an "XCRC" command since it now supported
{ differently (according to how IdFTP and CuteFTP Pro use it).
{ Commented out some code permissions and ownership since those can now use
{ coded defaults in the TIdFTPListItem object if none are provided.
}
{
{   Rev 1.2    1/25/2003 01:56:38 AM  JPMugaas
{ Refinements for checksum commands.  Checksum commands will now fail for dirs
{ instead of the connection being closed.
}
{
    Rev 1.1    1/23/2003 7:37:14 PM  BGooijen
  fixed IdFTPServer1GetFileSize when the specified file doesn't exists,
  flashfxp uses this to check if the file already exists on the server.
}
{
{   Rev 1.0    1/21/2003 12:25:12 PM  JPMugaas
{ Server Test for IdFTPServer and core.
}
program FTPServer_console;
(*
Sample of the usage of the TIdFtpServer component.
Also shows how to use Indy in console apps

Created by: Bas Gooijen (bas_gooijen@yahoo.com)

Disclaimer:
  Use it at your own risk, it could contain bugs.

Copyright:
  Freeware for all use
*)

{$APPTYPE console}

{.$DEFINE LOGGING}

{
Note that the logging code can not work in a console application because the main
thread does not run with a standard windows handle.  Oh, well.
}
{.$DEFINE USESSL}
uses
  Classes,
  {$IFDEF LOGGING}
  IdSync,
  {$ENDIF}
  {$IFDEF WIN32}
  windows,
  {$ENDIF}
  {$IFDEF LINUX}
  libc,
  {$ENDIF}
  sysutils,
  {$IFDEF WIN32}
  IdCompressorZLibEx,
  {$ENDIF}
  IdContext,
  IdExplicitTLSClientServerBase,
  IdFileSystemWin32,
  IdFTPCommon,
  IdFTPList,
  IdFTPListOutput,
  IdFTPServer,
  IdFTPServerContextBase,
  IdGlobal,
  IdGlobalProtocols,
  IdSSLOpenSSL,
  idtcpserver,
  IdSocketHandle,
  IdHashCRC,
  IdIOHandlerSocket,
  IdReply,
  IdReplyRFC,
  IdReplyFTP,
  IdStack;

//for resolving the peer's IP address into a name

type
  TFTPServer = class
  private
    { Private declarations }
    {$IFDEF WIN32}
    FCompressor : TIdCompressorZLibEx;
    {$ENDIF}
    FIdFTPServer: tIdFTPServer;
    {$IFDEF USESSL}
   FIdExplicit : TIdServerIOHandlerSSLOpenSSL;
   FIdImplicit : TIdServerIOHandlerSSLOpenSSL;
   FIdFTPSvrImplicit : TIdFTPServer;
   procedure FIdSSLPassGetPassword(var Password: String);
    {$ENDIF}
    {$IFDEF LOGGING}
    procedure FIdFTPServerOnBeforeCmd(ASender: TIdTCPServer; const AData: string;
    AContext: TIdContext);
    {$ENDIF}
    function FixUpBanner(const ABanner : String; AThread: TIdFTPServerContext) : String;
    procedure FIdFTPServerOnGreeting(ASender: TIdFTPServerContext; AGreeting : TIdReply);
    procedure FIdFTPServerOnQuit(ASender: TIdFTPServerContext; AGreeting : TIdReply);
    procedure FIdFTPServerOnLoginSuccessfulBanner(ASender: TIdFTPServerContext; AGreeting : TIdReply);
    procedure FIdFTPServerOnLoginFailureBanner(ASender: TIdFTPServerContext; AGreeting : TIdReply);
    procedure FIdFTPServerUserLogin( ASender: TIdFTPServerContext; const AUsername, APassword: string; var AAuthenticated: Boolean );
    procedure FIdFTPServerListDirectory(ASender: TIdFTPServerContext; const APath: string;
      ADirectoryListing: TIdFTPListOutput; const ACmd : String; const ASwitches : String);
    procedure FIdFTPServerRenameFile( ASender: TIdFTPServerContext; const ARenameFromFile, ARenameToFile: string ) ;
    procedure FIdFTPServerRetrieveFile( ASender: TIdFTPServerContext; const AFilename: string; var VStream: TStream );
    procedure FIdFTPServerStoreFile( ASender: TIdFTPServerContext; const AFilename: string; AAppend: Boolean; var VStream: TStream );
    procedure FIdFTPServerRemoveDirectory( ASender: TIdFTPServerContext; var VDirectory: string ) ;
    procedure FIdFTPServerMakeDirectory( ASender: TIdFTPServerContext; var VDirectory: string ) ;
    procedure FIdFTPServerGetFileSize( ASender: TIdFTPServerContext; const AFilename: string; var VFileSize: Int64 );
    procedure FIdFTPServerSetFileDate(ASender: TIdFTPServerContext; const AFileName : String; var AFileTime : TDateTime);
    procedure FIdFTPServerDeleteFile( ASender: TIdFTPServerContext; const APathname: string ) ;
    procedure FIdFTPServerChangeDirectory( ASender: TIdFTPServerContext; var VDirectory: string ) ;
  //  procedure FIdFTPServerCommandXCRC( ASender: TIdCommand ) ;
    procedure FIdFTPServerDisConnect( AThread: TIdContext ) ;
    procedure FIdFTPServerCombine(ASender: TIdFTPServerContext; const ATargetFileName: string; AParts : TStrings) ;
    procedure FIdFTPServerCRC(ASender: TIdFTPServerContext; const AFileName : String; var AIOStream : TStream);
    procedure FIdFTPServerStat(ASender: TIdFTPServerContext; AStatusInfo : TStrings);
    function PathSep : String;
  protected
    procedure RecurseFilesList(const APath, AHomeDir : String; ADir : TIdFTPListOutput);
    function UndoTranslatePath(const APathName, HomeDir : String) : String;
    function TransLatePath( const APathname, homeDir: string ) : string;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

type EPermissionDenied = class(Exception)
      Constructor CreateMsg;
     end;

{$I IdCompilerDefines.inc}

{$IFDEF LOGGING}
 TLogMsgSync = class(TIdSync)
  protected
    FMsgLog : String;
    //
    procedure DoSynchronize; override;
  public
    class procedure LogMsg(AContext : TIdContext;const APeerIP : String; const AData : String);
  end;
{$ENDIF}
function MakePathStr(const APath : String): String;
begin
  {$IFDEF VCL6ORABOVE}
  Result := SysUtils.IncludeTrailingPathDelimiter(APath);
  {$ELSE}
  Result := IncludeTrailingBackSlash(APath);
  {$ENDIF}
end;

{$IFDEF USESSL}
function GetSSLCertPath : String;
begin
  Result := MakePathStr(ExtractFilePath(ParamStr(0))+'cert');
end;
{$ENDIF}

function GetBasePath : String;
begin
  Result := MakePathStr(ExtractFilePath(ParamStr(0))+'home');
end;

{$IFNDEF VCL6ORABOVE}
{$IFDEF WIN32}
//This is necessary for D4 and D5 because adding FileCtrl will trigger the
//VCL library being linked in which adds unneeded bloat.
//Obtained from:

// http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=3addbfb1.249423802%40forums.borland.com&rnum=8&prev=/groups%3Fq%3DDirectoryExists%2BDelphi%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26selm%3D3addbfb1.249423802%2540forums.borland.com%26rnum%3D8
function DirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;
{$ENDIF}
{$ENDIF}

procedure MakeSureRealBasePathExists;
begin
  if (FileExists(GetBasePath)=False) and (DirectoryExists(GetBasePath)=False) then
  begin
    MkDir(GetBasePath);
  end;
end;

function HashStr(const AString : String): Cardinal;
var
  value: Cardinal;
  IdHashCRC32: TIdHashCRC32;
begin
  IdHashCRC32 := TIdHashCRC32.create;
  try
    Result := IdHashCRC32.HashValue(AString);
  finally
    IdHashCRC32.free;
  end;
end;

procedure AddlistItem( aDirectoryListing: TIdFTPListOutput; Filename: string; ItemType: TIdDirItemType; size: int64; AModTime, ACreateTime, AAccessTime : tdatetime ) ;
  var
    listitem: TIdFTPListOutputItem;

    function CalcBlocks(const ASize : Integer): Integer;
    begin
    //we give an estimated block count so we can export a total
    //line in the list to simulate /bin/ls -l.
    //Note that the total line is the number of blocks the files use.
    //In Linux, the block size for list is 1024 while in FreeBSD, it is 512
    //In addition, for each directory whose contents are displayed, the
    // total number of 512-byte blocks used by the files in the directory is
    // displayed on a line by itself immediately before the information for the
    // files in the directory.
    //URL:  http://www.freebsd.org/cgi/man.cgi?query=ls&apropos=0&sektion=0&manpath=FreeBSD+4.7-RELEASE&format=html
    //and for linux, consulted info ls page and verified myself using the ls -ls command.
      Result := ASize div 512;
      if (ASize mod 512) > 0 then
      begin
        Inc(Result);
      end;
    end;

begin
    listitem := aDirectoryListing.Add;
    listitem.ItemType := ItemType;
    if listitem.ItemType = ditDirectory then
    begin
      listitem.NumberBlocks := 1;
    end
    else
    begin
      listitem.NumberBlocks := CalcBlocks(Size);
    end;
    listitem.FileName := Filename;
    if aDirectoryListing.DirFormat = doUnix then
    begin
    //CygWin simply hashes the complete filename and then returns the hash value as the inode
    //On Linux, you get the inode value from the "stat" function
      listitem.Inode := HashStr(FileName);
    end;
    listitem.Size := size;
    listitem.ModifiedDateGMT := AModTime;
    listitem.CreationDateGMT := ACreateTime;
    listitem.LastAccessDateGMT := AAccessTime;
    if listitem.ItemType = ditDirectory then
    begin
    //  listitem.MLISTPermissions := 'cdeflmp';
      listitem.MLISTPermissions := 'el';
    end
    else
    begin
  //    listitem.MLISTPermissions := 'adfrw';
      listitem.MLISTPermissions := 'r';
    end;
end;

function RemoveTrailingPathDel(const AData : String) : String;
begin
    Result := AData;
    if Result <> '' then
    begin
      if (Result[Length(Result)] = '/') or (Result[Length(Result)] = '\') then
      begin
        System.Delete(Result,Length(Result),1);
      end;
    end;
end;

{$IFDEF USESSL}
procedure TFTPServer.FIdSSLPassGetPassword(var Password: String);
begin
   Password := 'aaaa';
end;
{$ENDIF}

procedure TFTPServer.RecurseFilesList(const APath, AHomeDir : String; ADir : TIdFTPListOutput);

  procedure AddFolder(APath, AHomeDir: string);
  var F: TExtSrchRec;
    LDir : String;

  const
    findTypes=faArchive+faHidden+faReadOnly+faAnyFile+faDirectory;
  begin

    LDir:= MakePathStr(APath);
    if ExFindFirst(TransLatePath(LDir+'*.*',AHomeDir), findTypes, F)=0 then
    try
      repeat
        if (F.attr and faDirectory=faDirectory) then
        begin
          AddListItem(ADir,LDir+f.Name,ditDirectory,0, f.ModifiedTimeGMT, f.AccessedTimeGMT, f.AccessedTimeGMT);
          if (F.Name<>'.') and (F.Name<>'..') then
          begin
            AddFolder(LDir+F.Name,AHomeDir);
          end;
        end
        else
        begin
          AddListItem(ADir,LDir+f.Name,ditFile, f.size,  f.ModifiedTimeGMT, f.AccessedTimeGMT, f.AccessedTimeGMT);
        end;
      until ExFindNext(F)<>0;
    finally
     ExFindClose(F)
    end;
  end;

begin
  AddFolder(APath,AHomeDir);
end;

constructor TFTPServer.Create;
begin
  //we create a base dir if none exists so that the server will only use something
  //relative to that base directory instead of relative to a particular drive
  //Using something relative to a drive can have too many undesirable consequences
  //such as someone imbedding a trojan or getting access to something they shouldn't
  //have access to.
  MakeSureRealBasePathExists;
  FIdFTPServer := tIdFTPServer.create( nil ) ;
  FIdFTPServer.MLSDFacts := [mlsdPerms, mlsdUnixModes, mlsdFileCreationTime,mlsdFileLastAccessTime];
  {$IFDEF WIN32}
  FCompressor := TIdCompressorZLibEx.Create(nil);
  FIdFTPServer.Compressor :=  FCompressor;
  {$ENDIF}
  {$IFDEF LOGGING}
  FIdFTPServer.OnBeforeCommandHandler := FIdFTPServerOnBeforeCmd;
  {$ENDIF}
  {$IFDEF WIN32}
  FIdFTPServer.DefaultPort := 21;
  FIdFTPServer.DefaultDataPort := 20;
  {$ENDIF}
  {$IFDEF LINUX}
  //note that we use a different port because the standard FTP ports
  //are in the reserved range and only root can use those.
  FIdFTPServer.DefaultPort := 2100;
  FIdFTPServer.DefaultDataPort := 2000;
  {$ENDIF}
  {$IFDEF USESSL}
  FIdExplicit := TIdServerIOHandlerSSLOpenSSL.Create(nil);
  FIdExplicit.SSLOptions.RootCertFile := GetSSLCertPath + 'CAcert.crt';
  FIdExplicit.SSLOptions.CertFile := GetSSLCertPath + 'WSScert.pem';
  FIdExplicit.SSLOptions.KeyFile := GetSSLCertPath + 'WSSkey.pem';
  FIdExplicit.OnGetPassword := FIdSSLPassGetPassword;
  FIdExplicit.SSLOptions.Method :=sslvSSLv23 ;
  FIdExplicit.SSLOptions.Mode:= sslmUnassigned;
  FIdFTPServer.IOHandler := FIdExplicit;
  FIdFTPServer.UseTLS := utUseExplicitTLS;

  FIdImplicit := TIdServerIOHandlerSSLOpenSSL.Create(nil);
  FIdImplicit.SSLOptions.RootCertFile := GetSSLCertPath + 'CAcert.crt';
  FIdImplicit.SSLOptions.CertFile := GetSSLCertPath + 'WSScert.pem';
  FIdImplicit.SSLOptions.KeyFile := GetSSLCertPath + 'WSSkey.pem';
  FIdImplicit.OnGetPassword := FIdSSLPassGetPassword;
  FIdImplicit.SSLOptions.Method :=sslvSSLv23 ;
  FIdImplicit.SSLOptions.Mode:= sslmUnassigned;
    {$IFDEF WIN32}
  FIdImplicit.Compressor :=  FCompressor;
    {$ENDIF}
  {$ENDIF}
  FIdFTPServer.AllowAnonymousLogin := False;
  FIdFTPServer.OnGreeting := FIdFTPServerOnGreeting;
  FIdFTPServer.OnQuitBanner := FIdFTPServerOnQuit;
  FIdFTPServer.OnLoginSuccessBanner := FIdFTPServerOnLoginSuccessfulBanner;
  FIdFTPServer.OnLoginFailureBanner := FIdFTPServerOnLoginFailureBanner;
  FIdFTPServer.DirFormat := ftpdfUnix;
  FIdFTPServer.OnChangeDirectory := FIdFTPServerChangeDirectory;
  FIdFTPServer.OnChangeDirectory := FIdFTPServerChangeDirectory;
  FIdFTPServer.OnGetFileSize := FIdFTPServerGetFileSize;
  FIdFTPServer.OnListDirectory := FIdFTPServerListDirectory;
  FIdFTPServer.OnUserLogin := FIdFTPServerUserLogin;
  FIdFTPServer.OnRenameFile := FIdFTPServerRenameFile;
  FIdFTPServer.OnDeleteFile := FIdFTPServerDeleteFile;
  FIdFTPServer.OnRetrieveFile := FIdFTPServerRetrieveFile;
  FIdFTPServer.OnStoreFile := FIdFTPServerStoreFile;
  FIdFTPServer.OnMakeDirectory := FIdFTPServerMakeDirectory;
  FIdFTPServer.OnRemoveDirectory := FIdFTPServerRemoveDirectory;
  FIdFTPServer.Greeting.NumericCode := 220;
  FIdFTPServer.OnDisconnect := FIdFTPServerDisConnect;
  FIdFTPServer.OnSetModifiedTime := FIdFTPServerSetFileDate;
  FIdFTPServer.OnCombineFiles := FIdFTPServerCombine;
  FIdFTPServer.OnCRCFile := FIdFTPServerCRC;
  FIdFTPServer.OnStat := FIdFTPServerStat;
  //It is probably a good idea to disable this for some users
  //because the STAT command could be used to help "fingerprint" the system
  FIdFTPServer.FTPSecurityOptions.DisableSTATCommand := True;
  FIdFTPServer.FTPSecurityOptions.DisableSYSTCommand := True;

  {$IFDEF USESSL}
  FIdFTPSvrImplicit := TIdFTPServer.Create(nil);
  FIdFTPSvrImplicit.IOHandler := FIdImplicit;
  FIdFTPSvrImplicit.UseTLS := utUseImplicitTLS;

  FIdFTPSvrImplicit.AllowAnonymousLogin := False;
  FIdFTPSvrImplicit.OnGreeting := FIdFTPServerOnGreeting;
  FIdFTPSvrImplicit.OnQuitBanner := FIdFTPServerOnQuit;
  FIdFTPSvrImplicit.OnLoginSuccessBanner := FIdFTPServerOnLoginSuccessfulBanner;
  FIdFTPSvrImplicit.OnLoginFailureBanner := FIdFTPServerOnLoginFailureBanner;
  FIdFTPSvrImplicit.DirFormat := FIdFTPServer.DirFormat;
  FIdFTPSvrImplicit.OnChangeDirectory := FIdFTPServerChangeDirectory;
  FIdFTPSvrImplicit.OnChangeDirectory := FIdFTPServerChangeDirectory;
  FIdFTPSvrImplicit.OnGetFileSize := FIdFTPServerGetFileSize;
  FIdFTPSvrImplicit.OnListDirectory := FIdFTPServerListDirectory;
  FIdFTPSvrImplicit.OnUserLogin := FIdFTPServerUserLogin;
  FIdFTPSvrImplicit.OnRenameFile := FIdFTPServerRenameFile;
  FIdFTPSvrImplicit.OnDeleteFile := FIdFTPServerDeleteFile;
  FIdFTPSvrImplicit.OnRetrieveFile := FIdFTPServerRetrieveFile;
  FIdFTPSvrImplicit.OnStoreFile := FIdFTPServerStoreFile;
  FIdFTPSvrImplicit.OnMakeDirectory := FIdFTPServerMakeDirectory;
  FIdFTPSvrImplicit.OnRemoveDirectory := FIdFTPServerRemoveDirectory;
  FIdFTPSvrImplicit.Greeting.NumericCode := 220;
  FIdFTPSvrImplicit.OnDisconnect := FIdFTPServerDisConnect;
  FIdFTPSvrImplicit.OnSetModifiedTime := FIdFTPServerSetFileDate;
  FIdFTPSvrImplicit.OnCombineFiles := FIdFTPServerCombine;
  FIdFTPSvrImplicit.OnCRCFile := FIdFTPServerCRC;
  FIdFTPSvrImplicit.OnStat := FIdFTPServerStat;
  //It is probably a good idea to disable this for some users
  //because the STAT command could be used to help "fingerprint" the system
  FIdFTPSvrImplicit.FTPSecurityOptions.DisableSTATCommand := True;
  FIdFTPSvrImplicit.FTPSecurityOptions.DisableSYSTCommand := True;
    {$IFDEF LINUX}
  //note that we use a different port because the standard FTP ports
  //are in the reserved range and only root can use those.
  FIdFTPSvrImplicit.DefaultPort := 9100;
  FIdFTPSvrImplicit.DefaultDataPort := 9000;
    {$ENDIF}
  {$ENDIF}
  
  FIdFTPServer.Active := true;
  {$IFDEF USESSL}
  FIdFTPSvrImplicit.Active := True;
  {$ENDIF}
end;

function IsFileName( const AFileName : String): Boolean;
var LFRec : TSearchRec;
begin
  Result := False;
  if SysUtils.FindFirst(AFileName,faAnyFile,LFRec) = 0 then
  begin
    if LFRec.Attr and faDirectory	= 0	 then
    begin
      Result := True;
    end;
    SysUtils.FindClose(LFRec);
  end;
end;



function CalculateCRC( const path: string ) : string;
var
  f: tfilestream;
  value: Cardinal;
  IdHashCRC32: TIdHashCRC32;
begin
  IdHashCRC32 := nil;
  f := nil;
  try
    IdHashCRC32 := TIdHashCRC32.create;
    f := TFileStream.create( path, fmOpenRead or fmShareDenyWrite ) ;
    value := IdHashCRC32.HashValue( f ) ;
    result := inttohex( value, 8 ) ;
  finally
    f.free;
    IdHashCRC32.free;
  end;
end;

destructor TFTPServer.Destroy;
begin
  FIdFTPServer.free;
  {$IFDEF USESSL}
  FreeAndNil( FIdExplicit );
  
  FreeAndNil(FIdFTPSvrImplicit);
  FreeAndNil(FIdFTPSvrImplicit);
  {$ENDIF}
  {$IFDEF WIN32}
  FreeAndNil(FCompressor );
  {$ENDIF}
  inherited destroy;
end;

function StartsWith( const str, substr: string ) : boolean;
begin
  result := copy( str, 1, length( substr ) ) = substr;
end;

function BackSlashToSlash( const str: string ) : string;
var
  a: Cardinal;
begin
  result := str;
  for a := 1 to length( result ) do
    if result[a] = '\' then
      result[a] := '/';
end;

function SlashToBackSlash( const str: string ) : string;
var
  a: Cardinal;
begin
  result := str;
  for a := 1 to length( result ) do
    if result[a] = '/' then
      result[a] := '\';
end;

{$IFDEF LOGGING}
procedure TFTPServer.FIdFTPServerOnBeforeCmd(ASender: TIdTCPServer; const AData: string;
    AContext: TIdContext);
begin
  TLogMsgSync.LogMsg(AContext,TIdIOHandlerSocket(AContext.Connection.IOHandler).Binding.PeerIP,AData);
end;
{$ENDIF}

function TFTPServer.UndoTranslatePath(const APathName, HomeDir : String) : String;
begin
  Result := APathName;
  if Pos(SlashToBackSlash( homeDir ),APathName) = 0 then
  begin
    System.Delete(Result,1,Length(SlashToBackSlash( homeDir )));
  end;
end;

function TFTPServer.TransLatePath( const APathname, homeDir: string ) : string;
var
  tmppath: string;
begin
  try
  result := SlashToBackSlash( homeDir ) ;
  tmppath := SlashToBackSlash( APathname ) ;
  if homedir = '/' then
  begin
    result := tmppath;
    Result := GetBasePath+Result;
    exit;
  end;

  if length( APathname ) = 0 then
    exit;
  if result[length( result ) ] = '\' then
    result := copy( result, 1, length( result ) - 1 ) ;
  if tmppath[1] <> '\' then
    result := result + '\';
  result := result + tmppath;
  finally
    while (Copy(Result,1,2)='\\') or (Copy(Result,1,2)='//') do
    begin
      System.Delete(Result,1,1);
    end;
  end;
  Result := GetBasePath+Result;
end;

function GetSizeOfFile( const APathname: string ) : int64;
begin
  result := FileSizeByName( APathname ) ;
end;

function GetNewDirectory( old, action: string ) : string;
var
  a: integer;
  LAct : String;
begin
  LAct := IndyGetFilePath(Action);
  //if just a dot, do nothing
//  if (action = './') or (action = '.\') then
  if LAct='.' then
  begin
    Result := Old;
    Exit;
  end;
//  if (action = '../') or (action = '..\') then
  if (LAct='..') then
  begin
    if (old = '/') or (old='\') then
    begin
      result := old;
      exit;
    end;
    a := length( old ) - 1;
    while ( old[a] <> '\' ) and ( old[a] <> '/' ) do
      dec( a ) ;
    result := copy( old, 1, a ) ;
    exit;
  end;
  if ( action[1] = '/' ) or ( action[1] = '\' ) then
    result := action
  else
    result := old + action;
end;

procedure TFTPServer.FIdFTPServerUserLogin( ASender: TIdFTPServerContext;
  const AUsername, APassword: string; var AAuthenticated: Boolean ) ;
begin
  AAuthenticated := ( AUsername = 'myuser' ) and ( APassword = 'mypass' ) ;
  if not AAuthenticated then
  begin
    AAuthenticated := ( AUsername = 'admin' ) and ( APassword = 'myadminpass' ) ;
    if AAuthenticated then
    begin
    //for an administrative account, you might want the weakest security settings
    //while for anonymous FTP, you probably want something fairly strong
      ASender.UserSecurity.RequirePASVFromSameIP := False;
      ASender.UserSecurity.RequirePORTFromSameIP := False;
      ASender.UserSecurity.NoReservedRangePORT := False;
      ASender.UserSecurity.BlockAllPORTTransfers := False;
      ASender.UserSecurity.DisableSYSTCommand := False;
      ASender.UserSecurity.DisableSTATCommand := False;
    end;
  end;
  if not AAuthenticated then
    exit;
  if FIdFTPServer.DirFormat <> ftpdfDOS then
  begin
    ASender.UserSecurity.DisableSYSTCommand := False;
    ASender.HomeDir := '/';
    asender.currentdir := '/';
  end
  else
  begin
    ASender.HomeDir := '\';
    asender.currentdir := '\';
  end;
end;

procedure TFTPServer.FIdFTPServerListDirectory( ASender: TIdFTPServerContext; const APath: string; ADirectoryListing: TIdFTPListOutput; const ACmd : String; const ASwitches : String);
var
  f: TExtSrchRec;
  a: integer;

    function DeletRSwitch(const AString : String):String;
    var i : Integer;
    begin
      Result := '';
      for i := 1 to Length(AString) do
      begin
        if AString[i]<>'R' then
        begin
          Result := Result + AString[i];
        end;
      end;
    end;

begin
  if ASender.Username = 'myuser' then
  begin
  //It's probably best to prevent normal users from doing recursive dirs
  //because that can eat up more bandwidth and CPU cycles than a nromal DIR
  //list would.  It's probably best only for mirroring software using a designated
  //account and for administrators of the system.
    ADirectoryListing.Switches := DeletRSwitch(ASwitches);
  end
  else
  begin
    ADirectoryListing.Switches := ASwitches;
  end;
//  ADirectoryListing.DirectoryName := apath;
//  if FileExists(TranslatePath(APath,ASender.HomeDir))=False then
//  begin
//    raise EPermissionDenied.CreateMsg;
//  end;
  //in MLST, we are asking for information about a particular item, not
  //asking for the complete contents of the item
  if (ACmd = 'MLST') then
  begin
    if RemoveTrailingPathDel (TransLatePath( apath, ASender.HomeDir )) = '' then
    begin
      AddlistItem( ADirectoryListing, '/', ditDirectory, 0, 0, 0,0);
      exit;
    end
    else
    begin
      a := ExFindFirst( RemoveTrailingPathDel (TransLatePath( apath, ASender.HomeDir )) , faAnyFile, f ) ;
    end;
  end
  else
  begin
    a := ExFindFirst( TransLatePath( apath, ASender.HomeDir ) + '*.*', faAnyFile, f ) ;
  end;
  if (FIdFTPServer.DirFormat <> ftpdfEPLF) and (Pos('R',ASwitches)>0) then
  begin
    ExFindClose( f ) ;
    RecurseFilesList(RemoveTrailingPathDel (apath), ASender.HomeDir,ADirectoryListing);
    Exit;
  end;
  while ( a = 0 ) do
  begin
    if (ADirectoryListing.DirFormat = doEPLF ) and ((f.Name = '.') or (f.Name = '..')) then
    begin
      AddlistItem( ADirectoryListing, ASender.HomeDir, ditDirectory, f.size, 0,0,0 );
    end
    else
    begin
        if ( f.Attr and faDirectory > 0 ) then
        begin
        //procedure AddlistItem( aDirectoryListing: TIdFTPListOutput; Filename: string; ItemType: TIdDirItemType; size: int64; AModTime, ACreateTime, AAccessTime : tdatetime ) ;
          AddlistItem( ADirectoryListing, f.Name, ditDirectory, f.size, f.ModifiedTimeGMT, f.CreateTimeGMT, f.AccessedTimeGMT);
        end
        else
        begin
          AddlistItem( ADirectoryListing, f.Name, ditFile, f.size,  f.ModifiedTimeGMT, f.CreateTimeGMT, f.AccessedTimeGMT);
        end;
    end;
    a := ExFindNext( f ) ;
  end;
  ExFindClose( f ) ;
end;

procedure TFTPServer.FIdFTPServerRenameFile( ASender: TIdFTPServerContext;
  const ARenameFromFile, ARenameToFile: string ) ;
begin
  {$IFDEF WIN32}
  if not MoveFile( pchar( TransLatePath( ARenameFromFile, ASender.HomeDir ) ) , pchar( TransLatePath( ARenameToFile, ASender.HomeDir ) ) ) then
  begin
    RaiseLastWin32Error;
  end;
  {$ELSE}
  {$ENDIF}
end;

procedure TFTPServer.FIdFTPServerRetrieveFile( ASender: TIdFTPServerContext;
  const AFilename: string; var VStream: TStream ) ;
begin
  VStream := TFileStream.create( translatepath( AFilename, ASender.HomeDir ) , fmopenread or fmShareDenyWrite ) ;
end;

procedure TFTPServer.FIdFTPServerStoreFile( ASender: TIdFTPServerContext;
  const AFilename: string; AAppend: Boolean; var VStream: TStream ) ;
begin
  if FileExists( translatepath( AFilename, ASender.HomeDir ) ) and AAppend then
  begin
    VStream := TFileStream.create( translatepath( AFilename, ASender.HomeDir ) , fmOpenWrite or fmShareExclusive ) ;
    VStream.Seek( 0, soFromEnd ) ;
  end
  else
    VStream := TFileStream.create( translatepath( AFilename, ASender.HomeDir ) , fmCreate or fmShareExclusive ) ;
end;

procedure TFTPServer.FIdFTPServerRemoveDirectory( ASender: TIdFTPServerContext;
  var VDirectory: string ) ;
begin
  RmDir( TransLatePath( VDirectory, ASender.HomeDir ) ) ;
end;

procedure TFTPServer.FIdFTPServerMakeDirectory( ASender: TIdFTPServerContext;
  var VDirectory: string ) ;
begin
  MkDir( TransLatePath( VDirectory, ASender.HomeDir ) ) ;
end;

procedure TFTPServer.FIdFTPServerGetFileSize( ASender: TIdFTPServerContext;
  const AFilename: string; var VFileSize: Int64 ) ;
begin
  try
    VFileSize := GetSizeOfFile( TransLatePath( AFilename, ASender.HomeDir ) ) ;
  except
    VFileSize := -1;
  end;
end;

procedure TFTPServer.FIdFTPServerDeleteFile( ASender: TIdFTPServerContext;
  const APathname: string ) ;
begin
  if DeleteFile( pchar( TransLatePath( ASender.CurrentDir + '/' + APathname, ASender.HomeDir ) ) )=False then
  begin
    raise EPermissionDenied.CreateMsg;
  end;
end;

procedure TFTPServer.FIdFTPServerChangeDirectory( ASender: TIdFTPServerContext;
  var VDirectory: string ) ;
begin
  if DirectoryExists(TransLatePath(VDirectory, ASender.HomeDir)) then
  begin
    VDirectory := GetNewDirectory( ASender.CurrentDir, VDirectory ) ;
  end
  else
  begin
    raise EPermissionDenied.CreateMsg;
  end;
end;

procedure TFTPServer.FIdFTPServerDisConnect( AThread: TIdContext ) ;
begin
  //  nothing much here
end;

procedure TFTPServer.FIdFTPServerCombine(ASender: TIdFTPServerContext;
  const ATargetFileName: string; AParts: TStrings);
var i : Integer;
  LSource, LDest : TStream;
begin
  if FileExists(TransLatePath( ASender.CurrentDir + '/' + ATargetFileName, ASender.HomeDir )) then
  begin
    LDest := TFileStream.Create(TransLatePath( ASender.CurrentDir + '/' + ATargetFileName, ASender.HomeDir )  ,fmOpenReadWrite or fmShareExclusive);
    LDest.Seek(0,soFromEnd);
  end
  else
  begin
    LDest := TFileStream.Create(TransLatePath( ASender.CurrentDir + '/' + ATargetFileName, ASender.HomeDir )  ,fmCreate);
  end;
  try
    for i := 0 to AParts.Count -1 do
    begin
      LSource := TFileStream.Create( TransLatePath( ASender.CurrentDir + '/' + AParts[i], ASender.HomeDir ) ,
        fmopenread or fmShareDenyWrite);
      LDest.CopyFrom(LSource,0);
      FreeAndNil(LSource);
    end;
    //Do this separately in case there was a failure to find a source file part
    for i := 0 to AParts.Count-1 do
    begin
      FIdFTPServerDeleteFile(ASender,AParts[i]);
    end;
  finally
    FreeAndNil(LSource);
    FreeAndNil(LDest);
  end;
end;

procedure TFTPServer.FIdFTPServerCRC(ASender: TIdFTPServerContext; const AFileName: String; var AIOStream: TStream);
var LFileName : String;
begin
  LFileName := TransLatePath( ASender.CurrentDir + '/' + AFileName, ASender.HomeDir);
  AIOStream := TFileStream.create( LFileName, fmopenread or fmShareDenyWrite ) ;
end;

function DayPeriodGreeting : String;
var LHour, LMin, LSec, LMSec : Word;
  //Note that we do not use Night for a greeting.
  //"Good Night" is used as a farewell, not a greeting
begin
  DecodeTime(Time,LHour, LMin,LSec,LMSec);
  if LHour < 12 then
  begin
    Result := 'Morning';
  end
  else
  begin
    if LHour < 18 then
    begin
      Result := 'Afternoon';
    end
    else
    begin
      Result := 'Evening';
    end;
  end;
end;

function DayPeriodFairwell : String;
var LHour, LMin, LSec, LMSec : Word;
  //Note that we do not use Night for a greeting.
  //"Good Night" is used as a farewell, not a greeting
begin
  DecodeTime(Time,LHour, LMin,LSec,LMSec);
  if LHour < 19 then
  begin
    Result := 'Day';
  end
  else
  begin
    Result := 'Night';
  end;
end;

procedure TFTPServer.FIdFTPServerStat(ASender: TIdFTPServerContext; AStatusInfo : TStrings);
var Line : String;
begin
  AStatusInfo.Add('Connected to '+ GStack.HostByAddress(TIdIOHandlerSocket(ASender.Connection.IOHandler).Binding.PeerIP) );
  Line := 'Logged in as ';
  if (ASender.UserType = utAnonymousUser) then
  begin
    Line := Line + ASender.Password;
  end
  else
  begin
    Line := Line + ASender.Username;
  end;
  AStatusInfo.Add(Line);
  Line := 'TYPE: ';
  case ASender.DataType of
    ftASCII  : Line := Line + 'ASCII';
    ftBinary : Line := Line + 'BINARY';
  end;
  Line := Line + ', FORM: Nonprint; STRUcture: ';
  case ASender.DataStruct of
    dsFile   : Line := Line + 'File';
    dsRecord : Line := Line + 'Record';
    dsPage   : Line := Line + 'Page';
  end;
//  Line := Line + '; transfer MODE: ';
//  case ASender.DataMode of
//    dmBlock      : Line := Line + 'BLOCK';
//    dmCompressed : Line := Line + 'COMPRESSED';
//    dmStream     : Line := Line + 'STREAM';
//  end;
  AStatusInfo.Add(Line);
  if Assigned(ASender.DataChannel) then
  begin
    AStatusInfo.Add('Data Connection Active');
  end
  else
  begin
    AStatusInfo.Add('No Data Connection');
  end;
end;

function TFTPServer.FixUpBanner(const ABanner : String; AThread: TIdFTPServerContext) : String;
var LPeerHostName : String;
    LMyHostName : String;
begin
  LPeerHostName := GStack.HostByAddress(TIdIOHandlerSocket(AThread.Connection.IOHandler).Binding.PeerIP);
  LMyHostName :=  GStack.HostByAddress(TIdIOHandlerSocket(AThread.Connection.IOHandler).Binding.IP);
  Result := StringReplace(ABanner,'%DAYGREETINGWORD%',DayPeriodGreeting,[rfReplaceAll]);
  Result := StringReplace(Result,'%DAYFAREWELLWORD%',DayPeriodFairwell,[rfReplaceAll]);
  Result := StringReplace(Result,'%PEERNAME%',LPeerHostName,[rfReplaceAll]);
  Result := StringReplace(Result,'%MYNAME%',LMyHostName,[rfReplaceAll]);
  Result := StringReplace(Result,'%USERNAME%',AThread.Username,[rfReplaceAll]);
end;

procedure TFTPServer.FIdFTPServerOnGreeting(ASender: TIdFTPServerContext; AGreeting : TIdReply);
begin
  AGreeting.Text.Clear;
  AGreeting.Text.Add('Good %DAYGREETINGWORD%, user at %PEERNAME%.');
  AGreeting.Text.Add('');
  AGreeting.Text.Add('Welcome to the Internet Direct (Indy) demo running on %MYNAME%.');
  AGreeting.Text.Add('');
  AGreeting.Text.Add('Server at %MYNAME% ready.');
  AGreeting.Text.Text := FixUpBanner(AGreeting.Text.Text,ASender);
{  AGreeting.NumericCode := 421;
  AGreeting.Text.Clear;
  AGreeting.Text.Add('FTP Service has been disabled to prevent system abuse');
  AGreeting.Text.Add('');
  AGreeting.Text.Add('You may now only use our web site at http://www.oursite.com');
  AGreeting.Text.Add('to download our great software.');
  AGreeting.Text.Add('');
  AGreeting.Text.Add('Have a nice day.'); }
end;

procedure TFTPServer.FIdFTPServerOnQuit(ASender: TIdFTPServerContext; AGreeting : TIdReply);
begin
  if ASender.Authenticated then
  begin
    AGreeting.Text.Clear;
    AGreeting.Text.Add('Good %DAYFAREWELLWORD%, %USERNAME%!!!');
    AGreeting.Text.Text := FixUpBanner(AGreeting.Text.Text,ASender);
  end;
end;

procedure TFTPServer.FIdFTPServerOnLoginSuccessfulBanner(ASender: TIdFTPServerContext; AGreeting : TIdReply);
begin
  AGreeting.Text.Clear;
  AGreeting.Text.Add('User %USERNAME% logged in.');
  AGreeting.Text.Text := FixUpBanner(AGreeting.Text.Text,ASender);
end;

procedure TFTPServer.FIdFTPServerOnLoginFailureBanner(ASender: TIdFTPServerContext; AGreeting : TIdReply);
begin
  AGreeting.Text.Clear;
  AGreeting.Text.Add('Login failed.');
  AGreeting.Text.Add('Visit from %PEERNAME% has been logged.');
  AGreeting.Text.Add('');
  AGreeting.Text.Add('Good %DAYFAREWELLWORD%!!!');

  AGreeting.Text.Text := FixUpBanner(AGreeting.Text.Text,ASender);
end;

procedure TFTPServer.FIdFTPServerSetFileDate(ASender: TIdFTPServerContext; const AFileName : String; var AFileTime : TDateTime);
begin
  if GMTSetFileModifyDate(AFileName,AFileTime)<>0 then
  begin
    //in case we failed to set the date
    AFileTime := GMTGetFileModifyDate(AFileName);
  end;
end;


{ EPermissionDenied }

constructor EPermissionDenied.CreateMsg;
begin
  inherited Create('Permission Denied');
end;

function TFTPServer.PathSep: String;
begin
  if FIdFTPServer.DirFormat = ftpdfUnix then
  begin
    Result := PATH_FILENAME_SEP_DOS;
  end
  else
  begin
    Result := PATH_FILENAME_SEP_UNIX;
  end;
end;

{$IFDEF LOGGING}
{ TLogMsgSync }

procedure TLogMsgSync.DoSynchronize;
begin
  WriteLn(FMsgLog);
end;

class procedure TLogMsgSync.LogMsg(AContext : TIdContext; const APeerIP, AData: String);
begin
  with Create do begin
    FMsgLog := APeerIP + ':  '+AData;
    Synchronize;
   // Notify;
  end;
end;
{$ENDIF}
begin
  with TFTPServer.Create do
  try
    writeln( 'Running, press [enter] to terminate' ) ;
    readln;
  finally
    free;
  end;
end.



