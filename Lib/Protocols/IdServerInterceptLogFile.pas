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
  Rev 1.5    7/23/04 6:53:28 PM  RLebeau
  TFileStream access right tweak for Init()

  Rev 1.4    07/07/2004 17:41:38  ANeillans
  Added IdGlobal to uses, was not compiling cleanly due to missing function
  WriteStringToStream.

  Rev 1.3    6/29/04 1:20:14 PM  RLebeau
  Updated DoLogWriteString() to call WriteStringToStream() instead

    Rev 1.2    10/19/2003 5:57:22 PM  DSiders
  Added localization comments.

  Rev 1.1    2003.10.17 8:20:42 PM  czhower
  Removed const

    Rev 1.0    3/22/2003 10:59:22 PM  BGooijen
  Initial check in.
  ServerIntercept to ease debugging, data/status are logged to a file
}

unit IdServerInterceptLogFile;

interface
{$i IdCompilerDefines.inc}

uses
  IdServerInterceptLogBase,
  IdGlobal,
  Classes;

type
  TIdServerInterceptLogFile = class(TIdServerInterceptLogBase)
  protected
    FFileStream: TFileStream;
    FFilename:string;
  public
    procedure Init; override;
    destructor Destroy; override;
    procedure DoLogWriteString(const AText: string); override;
  published
    property Filename: string read FFilename write FFilename;
  end;

implementation

uses
  IdBaseComponent, SysUtils;

{ TIdServerInterceptLogFile }

destructor TIdServerInterceptLogFile.Destroy;
begin
  FreeAndNil(FFileStream);
  inherited Destroy;
end;

procedure TIdServerInterceptLogFile.Init;
begin
  inherited Init;
  if not IsDesignTime then begin
    if FFilename = '' then begin
      FFilename := ChangeFileExt(ParamStr(0), '.log'); {do not localize}  //BGO: TODO: Do we keep this, or maybe raise an exception?
    end;
    FFileStream := TIdAppendFileStream.Create(Filename);
  end;
end;

procedure TIdServerInterceptLogFile.DoLogWriteString(const AText: string);
var
  LEnc: IIdTextEncoding;
begin
  LEnc := IndyTextEncoding_8Bit;
  WriteStringToStream(FFileStream, AText, LEnc{$IFDEF STRING_IS_ANSI}, LEnc{$ENDIF});
end;

end.

