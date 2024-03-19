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
{   (c) 1993-2024, the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

unit IdSSLOpenSSLLoader;

{$IFDEF MSWINDOWS}
{$DEFINE WINDOWS}
{$ENDIF}

{$i IdCompilerDefines.inc}
{$i IdSSLOpenSSLDefines.inc}

interface

uses
  Classes, IdGlobal, IdCTypes;

type
  { IOpenSSLLoader }

  IOpenSSLLoader = interface
    ['{BBB0F670-CC26-42BC-A9E0-33647361941A}']

    function GetOpenSSLPath: string;
    function GetSSLLibVersions: string;
    procedure SetOpenSSLPath(const Value: string);
    function GetFailedToLoad: TStringList;

    function Load: Boolean;
    procedure SetSSLLibVersions(AValue: string);
    procedure Unload;

    property SSLLibVersions: string read GetSSLLibVersions write SetSSLLibVersions;
    property OpenSSLPath: string read GetOpenSSLPath write SetOpenSSLPath;
    property FailedToLoad: TStringList read GetFailedToLoad;
  end;

  TOpenSSLLoadProc = procedure(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);
  TOpenSSLUnloadProc = procedure;

function GetOpenSSLLoader: IOpenSSLLoader;


procedure Register_SSLLoader(LoadProc: TOpenSSLLoadProc; module_name: string);
procedure Register_SSLUnloader(UnloadProc: TOpenSSLUnloadProc);

implementation

uses
  IdSSLOpenSSLExceptionHandlers,
  IdResourceStringsOpenSSL

{$IFNDEF USE_EXTERNAL_LIBRARY}
  {$IFDEF WINDOWS},Windows{$ENDIF}
  {$IFDEF FPC},dynlibs{$ENDIF}

  ,IdSSLOpenSSLConsts,
  IdThreadSafe,
  SysUtils
{$ENDIF}
  ;

{$if not declared(NilHandle)}
const
  NilHandle = 0;
{$ifend}

var
  GOpenSSLLoader: IOpenSSLLoader = nil;
  GLibCryptoLoadList: TList = nil;
  GLibSSLLoadList: TList = nil;
  GUnLoadList: TList = nil;

function GetOpenSSLLoader: IOpenSSLLoader;
begin
  Result := GOpenSSLLoader;
end;

procedure Register_SSLLoader(LoadProc: TOpenSSLLoadProc; module_name: string);
begin
  if GLibCryptoLoadList = nil then
    GLibCryptoLoadList := TList.Create;
  if GLibSSLLoadList = nil then
     GLibSSLLoadList := TList.Create;

  if module_name = 'LibCrypto' then
    GLibCryptoLoadList.Add(@LoadProc)
  else
  if module_name = 'LibSSL' then
    GLibSSLLoadList.Add(@LoadProc)
  else
    raise EIdOpenSSLError.CreateFmt(ROSUnrecognisedLibName,[module_name]);
end;

procedure Register_SSLUnloader(UnloadProc: TOpenSSLUnloadProc);
begin
  if GUnLoadList = nil then
    GUnLoadList := TList.Create;
  GUnLoadList.Add(@UnloadProc);
end;

{$IFNDEF USE_EXTERNAL_LIBRARY}
type

  { TOpenSSLLoader }

  TOpenSSLLoader = class(TInterfacedObject, IOpenSSLLoader)
  private
    FLibCrypto: TIdLibHandle;
    FLibSSL: TIdLibHandle;
    FOpenSSLPath: string;
    FFailed: TStringList;
    FSSLLibVersions: string;
    FLibraryLoaded: TIdThreadSafeBoolean;
    FFailedToLoad: boolean;
    function FindLibrary(LibName, LibVersions: string): TIdLibHandle;
    function GetSSLLibVersions: string;
    procedure SetSSLLibVersions(AValue: string);
    function GetOpenSSLPath: string;
    procedure SetOpenSSLPath(const Value: string);
    function GetFailedToLoad: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    function Load: Boolean;
    procedure Unload;

    property OpenSSLPath: string read GetOpenSSLPath write SetOpenSSLPath;
    property FailedToLoad: TStringList read GetFailedToLoad;
  end;

{ TOpenSSLLoader }

constructor TOpenSSLLoader.Create;
begin
  inherited;
  FFailed := TStringList.Create();
  FLibraryLoaded := TIdThreadSafeBoolean.Create;
  FSSLLibVersions := DefaultLibVersions;
  OpenSSLPath := GetEnvironmentVariable(OpenSSLLibraryPath)
end;

destructor TOpenSSLLoader.Destroy;
begin
  if FLibraryLoaded <> nil then
    FLibraryLoaded.Free;
  if FFailed <> nil then
    FFailed.Free;
  inherited;
end;

function TOpenSSLLoader.FindLibrary(LibName, LibVersions: string): TIdLibHandle;

  function DoLoadLibrary(FullLibName: string): TIdLibHandle;
  begin
    Result := SafeLoadLibrary(FullLibName, {$IFDEF WINDOWS}SEM_FAILCRITICALERRORS {$ELSE} 0 {$ENDIF});
  end;

var LibVersionsList: TStringList;
  i: integer;
begin
  Result := NilHandle;
  if LibVersions = '' then
    Result := DoLoadLibrary(OpenSSLPath + LibName)
  else
  begin
    LibVersionsList := TStringList.Create;
    try
      LibVersionsList.Delimiter := DirListDelimiter;
      LibVersionsList.StrictDelimiter := true;
      LibVersionsList.DelimitedText := LibVersions; {Split list on delimiter}
      for i := 0 to LibVersionsList.Count - 1 do
      begin
        Result := DoLoadLibrary(OpenSSLPath + LibName + LibVersionsList[i]);
        if Result <> NilHandle then
          break;
      end;
    finally
      LibVersionsList.Free;
    end;
  end;
end;


function TOpenSSLLoader.Load: Boolean;
type
  TOpenSSL_version_num = function: TIdC_ULONG; cdecl;

var i: integer;
    OpenSSL_version_num: TOpenSSL_version_num;
    SSLVersionNo: TIdC_ULONG;
    LegacyDLLsLoaded: boolean;

  {$IFDEF WINDOWS}
  procedure ProcessFailedList;
  var AllowedList: TStringList;
      i,j: integer;
  begin
    AllowedList := TStringList.Create;
    try
      AllowedList.Delimiter := ',';
      AllowedList.StrictDelimiter := true;
      AllowedList.DelimitedText := LegacyAllowFailed;
      for i := 0 to AllowedList.Count - 1 do
      begin
        j := FFailed.IndexOf(AllowedList[i]);
        if j <> -1 then
          FFailed.Delete(j);
      end;
    finally
      AllowedList.Free;
    end;
  end;
  {$ENDIF}

begin                                  //FI:C101
  Result := not FFailedToLoad;
  LegacyDLLsLoaded := false;
  if not Result then
    Exit;
  FLibraryLoaded.Lock();
  try
    if not FLibraryLoaded.Value then
    begin
      FLibCrypto := FindLibrary(CLibCryptoBase + LibSuffix,FSSLLibVersions);
      FLibSSL := FindLibrary(CLibSSLBase + LibSuffix,FSSLLibVersions);
      Result := not (FLibCrypto = IdNilHandle) and not (FLibSSL = IdNilHandle);
      {$IFDEF WINDOWS}
      if not Result then
      begin
        {try the legacy dll names}
        FLibCrypto := FindLibrary(LegacyLibCrypto,'');
        FLibSSL := FindLibrary(LegacyLibssl,'');
        Result := not (FLibCrypto = IdNilHandle) and not (FLibSSL = IdNilHandle);
        LegacyDLLsLoaded := Result;
      end;
      {$ENDIF}
      if not Result then
        Exit;

      {Load Version number}
      OpenSSL_version_num := LoadLibFunction(FLibCrypto, 'OpenSSL_version_num');
      if not assigned(OpenSSL_version_num) then
          OpenSSL_version_num := LoadLibFunction(FLibCrypto, 'SSLeay');
      if not assigned(OpenSSL_version_num) then
        raise EIdOpenSSLError.Create(ROSSLCantGetSSLVersionNo);

      SSLVersionNo := OpenSSL_version_num();
      if SSLVersionNo < min_supported_ssl_version then
        raise EIdOpenSSLError.CreateFmt(RSOSSUnsupportedVersion,[SSLVersionNo]);

      SSLVersionNo := SSLVersionNo shr 12;


      for i := 0 to GLibCryptoLoadList.Count - 1 do
        TOpenSSLLoadProc(GLibCryptoLoadList[i])(FLibCrypto,SSLVersionNo,FFailed);

      for i := 0 to GLibSSLLoadList.Count - 1 do
         TOpenSSLLoadProc(GLibSSLLoadList[i])(FLibSSL,SSLVersionNo,FFailed);

      {$IFNDEF OPENSSL_IGNORE_MISSING_FUNCTIONS}
      {$IFDEF WINDOWS}
      if LegacyDLLsLoaded and (FFailed.Count > 0) then
        ProcessFailedList;
      {$ENDIF}
      FFailedToLoad :=  FFailed.Count > 0;
      Result := not FFailedToLoad;

      {$IFDEF DEBUG}
      if not Result then
      begin
        writeln;
        writeln(RSOSSLProcLoadErrorHdr);
        for i := 0 to FFailed.Count - 1 do
          writeln(FFailed[i]);
      end;
      {$ENDIF}
      {$ENDIF}
    end;
    FLibraryLoaded.Value := true;
  finally
    FLibraryLoaded.Unlock();
  end;
end;

function TOpenSSLLoader.GetSSLLibVersions: string;
begin
  Result := FSSLLibVersions;
end;

procedure TOpenSSLLoader.SetSSLLibVersions(AValue: string);
begin
  FSSLLibVersions := AValue;
end;

function TOpenSSLLoader.GetOpenSSLPath: string;
begin
  Result := FOpenSSLPath
end;

procedure TOpenSSLLoader.SetOpenSSLPath(const Value: string);
begin
  if Value = '' then
    FOpenSSLPath := ''
  else
    FOpenSSLPath := IncludeTrailingPathDelimiter(Value);
end;

function TOpenSSLLoader.GetFailedToLoad: TStringList;
begin
  Result := FFailed;
end;

procedure TOpenSSLLoader.Unload;
var i: integer;
begin                            //FI:C101
  FLibraryLoaded.Lock();
  try
    if FLibraryLoaded.Value  then
    begin
      for i := 0 to GUnLoadList.Count - 1 do
         TOpenSSLUnloadProc(GUnLoadList[i]);

      FFailed.Clear();

      if FLibSSL <> NilHandle then
        FreeLibrary(FLibSSL);
      if FLibCrypto <> NilHandle then
        FreeLibrary(FLibCrypto);
      FLibSSL := NilHandle;
      FLibCrypto := NilHandle;
    end;
    FFailedToLoad := false;
    FLibraryLoaded.Value := false;
  finally
    FLibraryLoaded.Unlock();
  end;
end;

{$ENDIF}

initialization
{$IFNDEF USE_EXTERNAL_LIBRARY}
  GOpenSSLLoader := TOpenSSLLoader.Create();
{$ENDIF}

finalization
  if GLibCryptoLoadList <> nil then GLibCryptoLoadList.Free;
  if GLibSSLLoadList <> nil then GLibSSLLoadList.Free;
  if GUnLoadList <> nil then GUnLoadList.Free;
end.
