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
  Rev 1.1    11/29/2004 11:26:00 PM  JPMugaas
  This should now support SuperTCP 7.1 running under Windows 2000.  That does
  support long filenames by the dir entry ending with one space followed by the
  long-file name.
  ShortFileName was added to the listitem class for completeness.

  Rev 1.0    11/29/2004 2:44:16 AM  JPMugaas
  New FTP list parsers for some legacy FTP servers.
}

unit IdFTPListParseSuperTCP;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

type
  TIdSuperTCPFTPListItem = class(TIdFTPListItem)
  protected
    FShortFileName : String;
  public
    property ShortFileName : String read FShortFileName write FShortFileName;
  end;

  TIdFTPLPSuperTCP = class(TIdFTPListBase)
  protected
    class function IsValidWin32FileName(const AFileName : String): Boolean;
    class function IsValidMSDOSFileName(const AFileName : String): Boolean;
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseSuperTCP"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;

{ TIdFTPLPSuperTCP }

class function TIdFTPLPSuperTCP.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  i : Integer;
  LBuf, LBuf2 : String;
begin
  {
  Maybe like this:

  CMT             <DIR>           11-21-94        10:17
  DESIGN1.DOC          11264      05-11-95        14:20

  or this:

  CMT             <DIR>           11/21/94        10:17
  DESIGN1.DOC          11264      05/11/95        14:20

  or this with SuperTCP 7.1 running under Windows 2000:

  .            <DIR>     11-29-2004  22:04 .
  ..           <DIR>     11-29-2004  22:04 ..
  wrar341.exe  1164112   11-22-2004  15:34 wrar341.exe
  test         <DIR>     11-29-2004  22:14 test
  TESTDI~1     <DIR>     11-29-2004  22:16 Test Dir
  TEST~1       <DIR>     11-29-2004  22:52  Test
  }
  Result := False;
  for i := 0 to AListing.Count-1 do
  begin
    LBuf := AListing[i];
    //filename and extension - we assume an 8.3 filename type because
    //Windows 3.1 only supports that.
    Result := IsValidMSDOSFileName(Fetch(LBuf));
    if not Result then begin
      Exit;
    end;
    LBuf := TrimLeft(LBuf);
    //<DIR> or file size
    LBuf2 := Fetch(LBuf);
    Result := (LBuf2 = '<DIR>') or IsNumeric(LBuf2);   {Do not localize}
    if not Result then begin
      Exit;
    end;
    //date
    LBuf := TrimLeft(LBuf);
    LBuf2 := Fetch(LBuf);
    Result := IsMMDDYY(LBuf2, '/') or IsMMDDYY(LBuf2, '-'); {Do not localize}
    if Result then
    begin
      //time
      LBuf := TrimLeft(LBuf);
      LBuf2 := Fetch(LBuf);
      Result := IsHHMMSS(LBuf2, ':'); {Do not localize}
    end;
    if Result then
    begin
      //long filename in Win32
      //if nothing, a Windows 3.1 server probably
      if LBuf <> '' then begin
        Result := IsValidWin32FileName(LBuf);
      end;
    end;
    if not Result then begin
      Break;
    end;
  end;
end;

class function TIdFTPLPSuperTCP.GetIdent: String;
begin
   Result := 'SuperTCP'; {Do not localize}
end;

class function TIdFTPLPSuperTCP.IsValidMSDOSFileName(const AFileName: String): Boolean;
const
  VALID_DOS_CHARS =
	'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrtstuvwxyz0123456789_$~!#%&-{}()@'''+Char(180); {Do not localize}
var
  LFileName, LExt : String;
  i : Integer;
begin
  Result := False;
  if (AFileName = CUR_DIR) or (AFileName = PARENT_DIR) then
  begin
    Result := True;
    Exit;
  end;
  LExt := AFileName;
  LFileName := Fetch(LExt, '.'); {Do not localize}
  if (Length(LFileName) > 0) and (Length(LFileName) < 9) then
  begin
    for i := 1 to Length(LFileName) do
    begin
	  if IndyPos(LFileName[i], VALID_DOS_CHARS) = 0 then begin
        Exit;
      end;
    end;
    for i := 1 to Length(LExt) do
    begin
      if IndyPos(LExt[i], VALID_DOS_CHARS) = 0 then begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

class function TIdFTPLPSuperTCP.IsValidWin32FileName(const AFileName: String): Boolean;
//from: http://linux-ntfs.sourceforge.net/ntfs/concepts/filename_namespace.html
const
  WIN32_INVALID_CHARS = '"*/:<>?\|' + #0; {Do not localize}
  WIN32_INVALID_LAST  = ' .';  //not permitted as the last character in Win32 {Do not localize}
var
  i : Integer;
begin
  Result := False;
  if (AFileName = CUR_DIR) or (AFileName = PARENT_DIR) then
  begin
    Result := True;
    Exit;
  end;
  if Length(AFileName) > 0 then
  begin
    if IndyPos(AFileName[Length(AFileName)], WIN32_INVALID_LAST) > 0 then begin
      Exit;
    end;
    for i := 1 to Length(AFileName) do
    begin
      if IndyPos(AFileName[i], WIN32_INVALID_CHARS) > 0 then begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

class function TIdFTPLPSuperTCP.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdSuperTCPFTPListItem.Create(AOwner);
end;

class function TIdFTPLPSuperTCP.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LI : TIdSuperTCPFTPListItem;
  LBuf, LBuf2 : String;
begin
  {
  with SuperTCP 7.1 running under Windows 2000:

  .            <DIR>     11-29-2004  22:04 .
  ..           <DIR>     11-29-2004  22:04 ..
  wrar341.exe  1164112   11-22-2004  15:34 wrar341.exe
  test         <DIR>     11-29-2004  22:14 test
  TESTDI~1     <DIR>     11-29-2004  22:16 Test Dir
  TEST~1       <DIR>     11-29-2004  22:52  Test
  }
  LI := AItem as TIdSuperTCPFTPListItem;
  LBuf := AItem.Data;
  //short filename and extension - we assume an 8.3 filename
  //type because Windows 3.1 only supports that and under Win32,
  //a short-filename is returned here.  That's with my testing.
  LBuf2 :=  Fetch(LBuf);
  LI.FileName := LBuf2;
  LI.ShortFileName := LBuf2;
  LBuf := TrimLeft(LBuf);
  //<DIR> or file size
  LBuf2 := Fetch(LBuf);
  if LBuf2 = '<DIR>' then   {Do not localize}
  begin
    LI.ItemType := ditDirectory;
    LI.SizeAvail := False;
  end else
  begin
    LI.ItemType := ditFile;
    Result := IsNumeric(LBuf2);
    if not Result then begin
      Exit;
    end;
    LI.Size := IndyStrToInt64(LBuf2, 0);
  end;
  //date
  LBuf := TrimLeft(LBuf);
  LBuf2 := Fetch(LBuf);
  if IsMMDDYY(LBuf2, '/') or IsMMDDYY(LBuf2, '-') then begin {Do not localize}
    LI.ModifiedDate := DateMMDDYY(LBuf2);
  end else
  begin
    Result := False;
    Exit;
  end;
  //time
  LBuf := TrimLeft(LBuf);
  LBuf2 := Fetch(LBuf);
  Result := IsHHMMSS(LBuf2, ':'); {do not localize}
  if Result then begin
    LI.ModifiedDate := LI.ModifiedDate + TimeHHMMSS(LBuf2);
  end;
  // long filename
  //We do not use TrimLeft here because a space can start a filename in Windows
  //2000  and the entry would be like this:
  //
  //TESTDI~1     <DIR>     11-29-2004  22:16 Test Dir
  //TEST~1       <DIR>     11-29-2004  22:52  Test
  //
  if LBuf <> '' then begin
    LI.FileName := LBuf;
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPSuperTCP);
finalization
  UnRegisterFTPListParser(TIdFTPLPSuperTCP);

end.
