unit IdTransactedFileStream;

interface

{$I IdCompilerDefines.inc}

{
Original author: Grahame Grieve

His notes are:

If you want transactional file handling, with commit and rollback,
then this is the unit for you. It provides transactional safety on
Vista, win7, and windows server 2008, and just falls through to
normal file handling on earlier versions of windows.

There's a couple of issues with the wrapper classes TKernelTransaction
and TIdTransactedFileStream:
- you can specify how you want file reading to work with a transactional
 isolation. I don't surface this.

 - you can elevate the transactions to coordinate with DTC. They don't
  do this (for instance, you could put your file handling in the same
 transaction as an SQLServer transaction). I haven't done this - but if
  you do this, I'd love a copy ;-)

you use it like this:

procedure StringToFile(const AStr, AFilename: String);
var
 oFileStream: TIdTransactedFileStream;
 oTransaction : TKernelTransaction;
begin
 oTransaction := TIdKernelTransaction.Create('Save Content to file '+aFilename, false);
 Try
   Try
     oFileStream := TIdTransactedFileStream.Create(AFilename, fmCreate);
     try
       if AStr <> '' then
         WriteStringToStream(LFileStream, AStr, IndyTextEncoding_8Bit);
     finally
       LFileStream.Free;
     end;
     oTransaction.Commit;
   Except
     oTransaction.Rollback;
     raise;
   End;
 Finally
   oTransaction.Free;
 End;
end;

anyway - maybe useful in temporary file handling with file and email? I've
been burnt with temporary files and server crashes before.

}
uses
  {$IF DEFINED(WIN32) OR DEFINED(WIN64)}
  Windows,
  Consts,
  {$IFEND}
  Classes, SysUtils, IdGlobal;

{$IF DEFINED(WIN32) OR DEFINED(WIN64)}
const
  TRANSACTION_DO_NOT_PROMOTE = 1;

  TXFS_MINIVERSION_COMMITTED_VIEW : Word = $0000;  //  The view of the file as of its last commit.
  TXFS_MINIVERSION_DIRTY_VIEW : Word  = $FFFE;   // The view of the file as it is being modified by the transaction.
  TXFS_MINIVERSION_DEFAULT_VIEW : Word  = $FFFF; // Either the committed or dirty view of the file, depending on the context.
                                         // A transaction that is modifying the file gets the dirty view, while a transaction
                                         // that is not modifying the file gets the committed view.

// remember to close the transaction handle. Use the CloseTransaction function here to avoid problems if the transactions are not available
type
  TktmCreateTransaction = function (lpSecurityAttributes: PSecurityAttributes;
    pUow : Pointer;
    CreateOptions, IsolationLevel, IsolationFlags, Timeout : DWORD;
    Description : PWideChar) : THandle; stdcall;
  TktmCreateFileTransacted = function (lpFileName: PChar;
     dwDesiredAccess, dwShareMode: DWORD;
     lpSecurityAttributes: PSecurityAttributes;
     dwCreationDisposition, dwFlagsAndAttributes: DWORD;
     hTemplateFile: THandle;
     hTransaction : THandle;
     MiniVersion : Word;
     pExtendedParameter : Pointer): THandle; stdcall;
  TktmCommitTransaction = function (hTransaction : THandle) : Boolean; stdcall;
  TktmRollbackTransaction = function (hTransaction : THandle) :
      Boolean; stdcall;
  TktmCloseTransaction = function (hTransaction : THandle) : Boolean; stdcall;

var
  CreateTransaction : TktmCreateTransaction;
  CreateFileTransacted : TktmCreateFileTransacted;
  CommitTransaction : TktmCommitTransaction;
  RollbackTransaction : TktmRollbackTransaction;
  CloseTransaction : TktmCloseTransaction;

{$IFEND}

function IsTransactionsWorking : Boolean;

type
  TIdKernelTransaction = class (TObject)
  protected
    FHandle : THandle;
  public
    constructor Create(Const sDescription : String; bCanPromote : Boolean = false);
    destructor Destroy; override;

    function IsTransactional : Boolean;
    procedure Commit;
    procedure RollBack;
  end;

  TIdTransactedFileStream = class(THandleStream)
  {$IF NOT (DEFINED(WIN32) OR DEFINED(WIN64))}
  protected
    FFileStream : TFileStream;
  {$IFEND}
  public
    constructor Create(const FileName: string; Mode: Word; oTransaction : TIdKernelTransaction);
    destructor Destroy; override;
  end;

implementation

uses
  RTLConsts;

{$IF DEFINED(WIN32) OR DEFINED(WIN64)}

var
  GHandleKtm : HModule;
  GHandleKernel : HModule;

function DummyCreateTransaction(lpSecurityAttributes: PSecurityAttributes;
  pUow : Pointer; CreateOptions, IsolationLevel,
  IsolationFlags, Timeout : DWORD;
  Description : PWideChar) : THandle; stdcall;
begin
  Result := 1;
end;

function DummyCreateFileTransacted(lpFileName: PChar;
  dwDesiredAccess, dwShareMode: DWORD;
  lpSecurityAttributes: PSecurityAttributes;
  dwCreationDisposition, dwFlagsAndAttributes: DWORD;
  hTemplateFile: THandle;
  hTransaction : THandle;
  MiniVersion : Word;
  pExtendedParameter : Pointer): THandle; stdcall;
begin
  Result := CreateFile(lpFilename, dwDesiredAccess, dwShareMode,
    lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes,
    hTemplateFile);
end;

function DummyCommitTransaction(hTransaction : THandle) : Boolean; stdcall;
begin
  assert(hTransaction = 1);
  Result := True;
end;

function DummyRollbackTransaction(hTransaction : THandle) : Boolean; stdcall;
begin
  assert(hTransaction = 1);
  Result := True;
end;

function DummyCloseTransaction(hTransaction : THandle) : Boolean; stdcall;
begin
  assert(hTransaction = 1);
  Result := True;
end;

procedure LoadDll;
begin
  GHandleKtm := LoadLibrary('ktmw32.dll');
  if GHandleKtm <> 0 Then begin
    GHandleKernel := GetModuleHandle('Kernel32.dll'); //LoadLibrary('kernel32.dll');
    @CreateTransaction := LoadLibFunction(GHandleKtm, 'CreateTransaction');
    @CommitTransaction := LoadLibFunction(GHandleKtm, 'CommitTransaction');
    @RollbackTransaction := LoadLibFunction(GHandleKtm, 'RollbackTransaction');
    @CloseTransaction := LoadLibFunction(GHandleKernel, 'CloseHandle');
    @CreateFileTransacted := LoadLibFunction(GHandleKernel, {$IFDEF UNICODE}'CreateFileTransactedW'{$ELSE}'CreateFileTransactedA'{$ENDIF});
  end else begin
    @CreateTransaction := @DummyCreateTransaction;
    @CommitTransaction := @DummyCommitTransaction;
    @RollbackTransaction := @DummyRollbackTransaction;
    @CloseTransaction := @DummyCloseTransaction;
    @CreateFileTransacted := @DummyCreateFileTransacted;
  end;
end;

procedure UnloadDll;
begin
  if GHandleKtm <> 0 then begin
    FreeLibrary(GHandleKtm);
    GHandleKtm := 0;
    //FreeLibrary(GHandleKernel);
    //GHandleKernel := 0;
  end
end;

function IsTransactionsWorking : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := GHandleKtm <> 0;
end;

{$ELSE}

function IsTransactionsWorking : Boolean;
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  Result := False;
end;

{$IFEND}

{ TIdKernelTransaction }

constructor TIdKernelTransaction.Create(const sDescription: String; bCanPromote : Boolean);
{$IF DEFINED(WIN32) OR DEFINED(WIN64)}
var
  Opts: DWORD;
{$IFEND}
begin
  inherited Create;
  {$IF DEFINED(WIN32) OR DEFINED(WIN64)}
  if bCanPromote then begin
    Opts := 0;
  end else begin
    Opts := TRANSACTION_DO_NOT_PROMOTE;
  end;
  FHandle := CreateTransaction(nil, nil, Opts, 0, 0, 0,
    {$IFDEF STRING_UNICODE_MISMATCH}
    PIdPlatformChar(TIdPlatformString(sDescription))
    {$ELSE}
    PChar(sDescription)
    {$ENDIF}
  );
  {$IFEND}
end;

destructor TIdKernelTransaction.Destroy;
begin
  {$IF DEFINED(WIN32) OR DEFINED(WIN64)}
  if FHandle <> INVALID_HANDLE_VALUE then begin
    CloseTransaction(FHandle);
  end;
  {$IFEND}
  inherited Destroy;
end;

procedure TIdKernelTransaction.Commit;
begin
  {$IF DEFINED(WIN32) OR DEFINED(WIN64)}
  if not CommitTransaction(FHandle) then begin
    IndyRaiseLastError;
  end;
  {$IFEND}
end;

function TIdKernelTransaction.IsTransactional: Boolean;
begin
  Result := IsTransactionsWorking;
end;

procedure TIdKernelTransaction.RollBack;
begin
  {$IF DEFINED(WIN32) OR DEFINED(WIN64)}
  if not RollbackTransaction(FHandle) then begin
    IndyRaiseLastError;
  end;
  {$IFEND}
end;

{$IF DEFINED(WIN32) OR DEFINED(WIN64)}

function FileCreateTransacted(const FileName: string; hTransaction : THandle): THandle;
begin
  Result := THandle(CreateFileTransacted(
    {$IFDEF STRING_UNICODE_MISMATCH}
    PIdPlatformChar(TIdPlatformString(FileName))
    {$ELSE}PChar(FileName){$ENDIF},
    GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0, hTransaction, 0, nil));
  if Result = INVALID_HANDLE_VALUE Then begin
    IndyRaiseLastError;
  end;
end;

function FileOpenTransacted(const FileName: string; Mode: LongWord; hTransaction: THandle): THandle;
const
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := THandle(CreateFileTransacted(
    {$IFDEF STRING_UNICODE_MISMATCH}
    PIdPlatformChar(TIdPlatformString(FileName))
    {$ELSE}
    PChar(FileName)
    {$ENDIF},
    AccessMode[Mode and 3], ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL, 0, hTransaction, TXFS_MINIVERSION_DEFAULT_VIEW, nil));
end;

{$IFEND}

{ TIdTransactedFileStream }

{$IF DEFINED(WIN32) OR DEFINED(WIN64)}
constructor TIdTransactedFileStream.Create(const FileName: string; Mode: Word; oTransaction: TIdKernelTransaction);
var
  LHandle : THandle;
begin
  if Mode = fmCreate then begin
    LHandle := FileCreateTransacted(FileName, oTransaction.FHandle);
    if LHandle = INVALID_HANDLE_VALUE then begin
      raise EFCreateError.CreateResFmt(@SFCreateError, [FileName]);
    end;
  end else begin
    LHandle := FileOpenTransacted(FileName, Mode, oTransaction.FHandle);
    if LHandle = INVALID_HANDLE_VALUE then begin
      raise EFOpenError.CreateResFmt(@SFOpenError, [FileName]);
    end;
  end;
  inherited Create(LHandle);
end;
{$ELSE}
constructor TIdTransactedFileStream.Create(const FileName: string; Mode: Word; oTransaction: TIdKernelTransaction);
begin
  FFileStream := FFileStream.Create(FileName, Mode);
  inherited Create(LStream.Handle);
end;
{$IFEND}

destructor TIdTransactedFileStream.Destroy;
begin
  {$IF DEFINED(WIN32) OR DEFINED(WIN64)}
  if Handle <> INVALID_HANDLE_VALUE then begin
    FileClose(Handle);
  end;
  {$ELSE}
  //we have to dereference our copy of the THandle so we don't free it twice.
  FHandle := INVALID_HANDLE_VALUE;
  FFileStream.Free;
  {$IFEND}
  inherited Destroy;
end;

{$IF DEFINED(WIN32) OR DEFINED(WIN64)}
initialization
  LoadDLL;
finalization
  UnloadDLL;
{$IFEND}

end.