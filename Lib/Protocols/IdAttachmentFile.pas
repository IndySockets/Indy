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
  Rev 1.4    28.09.2004 21:04:44  Andreas Hausladen
  Delphi 5 does not have a Owner property in TCollection

  Rev 1.3    24.08.2004 18:01:42  Andreas Hausladen
  Added AttachmentBlocked property to TIdAttachmentFile.

  Rev 1.2    2004.02.03 5:44:50 PM  czhower
  Name changes

  Rev 1.1    5/9/2003 10:27:20 AM  BGooijen
  Attachment is now opened in fmShareDenyWrite mode

  Rev 1.0    11/14/2002 02:12:42 PM  JPMugaas
}

unit IdAttachmentFile;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAttachment,
  IdMessageParts;

type
  TIdAttachmentFile = class(TIdAttachment)
  protected
    FTempFileStream: TFileStream;
    FStoredPathName: String;
    FFileIsTempFile: Boolean;
    FAttachmentBlocked: Boolean;
  public
    constructor Create(Collection: TIdMessageParts; const AFileName: String = ''); reintroduce;
    destructor Destroy; override;

    function OpenLoadStream: TStream; override;
    procedure CloseLoadStream; override;
    function PrepareTempStream: TStream; override;
    procedure FinishTempStream; override;

    procedure SaveToFile(const FileName: String); override;

    property FileIsTempFile: Boolean read FFileIsTempFile write FFileIsTempFile;
    property StoredPathName: String read FStoredPathName write FStoredPathName;
    property AttachmentBlocked: Boolean read FAttachmentBlocked;
  end;

implementation

uses
  {$IFDEF USE_VCL_POSIX}
  Posix.Unistd,
  {$ENDIF}
  {$IFDEF KYLIXCOMPAT}
  Libc,
  {$ENDIF}
  //facilitate inlining only.
  {$IFDEF USE_INLINE}
    {$IFDEF WINDOWS}
  Windows,
    {$ENDIF}
    {$IFDEF DOTNET}
  System.IO,
    {$ENDIF}
  {$ENDIF}
  IdGlobal, IdGlobalProtocols, IdException, IdResourceStringsProtocols,
  IdMessage, SysUtils;

{ TIdAttachmentFile }

procedure TIdAttachmentFile.CloseLoadStream;
begin
  FreeAndNil(FTempFileStream);
end;

constructor TIdAttachmentFile.Create(Collection: TIdMessageParts; const AFileName: String = '');
begin
  inherited Create(Collection);
  FFilename := ExtractFileName(AFilename);
  FTempFileStream := nil;
  FStoredPathName := AFileName;
  FFileIsTempFile := False;
  if FFilename <> '' then begin
    ContentType := GetMimeTypeFromFile(FFilename);
  end;
end;

destructor TIdAttachmentFile.Destroy;
begin
  if FileIsTempFile then begin
    SysUtils.DeleteFile(StoredPathName);
  end;
  inherited Destroy;
end;

procedure TIdAttachmentFile.FinishTempStream;
var
  LMsg: TIdMessage;
begin
  FreeAndNil(FTempFileStream);
  // An on access virus scanner meight delete/block the temporary file.
  FAttachmentBlocked := not FileExists(StoredPathName);
  if FAttachmentBlocked then begin
    LMsg := TIdMessage(OwnerMessage);
    if Assigned(LMsg) and (not LMsg.ExceptionOnBlockedAttachments) then begin
      Exit;
    end;
    raise EIdMessageCannotLoad.CreateFmt(RSTIdMessageErrorAttachmentBlocked, [StoredPathName]);
  end;
end;

function TIdAttachmentFile.OpenLoadStream: TStream;
begin
  FTempFileStream := TIdReadFileExclusiveStream.Create(StoredPathName);
  Result := FTempFileStream;
end;

function TIdAttachmentFile.PrepareTempStream: TStream;
var
  LMsg: TIdMessage;
begin
  LMsg := TIdMessage(OwnerMessage);
  if Assigned(LMsg) then begin
    FStoredPathName := MakeTempFilename(LMsg.AttachmentTempDirectory);
  end else begin
    FStoredPathName := MakeTempFilename;
  end;
  FTempFileStream := TIdFileCreateStream.Create(FStoredPathName);
  FFileIsTempFile := True;
  Result := FTempFileStream;
end;

procedure TIdAttachmentFile.SaveToFile(const FileName: String);
begin
  if not CopyFileTo(StoredPathname, FileName) then begin
    raise EIdException.Create(RSTIdMessageErrorSavingAttachment); // TODO: create a new Exception class for this
  end;
end;

initialization
//  MtW: Shouldn't be neccessary??
//  RegisterClass(TIdAttachmentFile);

end.
