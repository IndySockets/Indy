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
  Rev 1.3    10/26/2004 9:55:58 PM  JPMugaas
  Updated refs.

  Rev 1.2    4/19/2004 5:06:10 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.1    10/19/2003 3:36:18 PM  DSiders
  Added localization comments.

  Rev 1.0    10/1/2003 12:55:20 AM  JPMugaas
  New FTP list parsers.
}

unit IdFTPListParseStercomOS390Exp;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase;

type
  TIdSterCommExpOS390FTPListItem = class(TIdFTPListItem)
  protected
    FRecFormat : String;
    FRecLength : Integer;
    FBlockSize : Integer;
  public
    property RecFormat : String read FRecFormat write FRecFormat;
    property RecLength : Integer read FRecLength write FRecLength;
    property BlockSize : Integer read FBlockSize write FBlockSize;
  end;

  TIdFTPLPSterCommExpOS390 = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

const
  STIRCOMEXPOS390 = 'Connect:Express for OS/390'; {do not localize}

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseStercomOS390Exp"'}
  {$ENDIF}

implementation

uses
  IdException,
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;

{
  "Connect:Express OS/390 FTP Guide Version 4.1" Copyright
  © 2002, 2003 Sterling Commerce, Inc.

  125 LIST Command accepted.
  -D 2 T VB  00244 18000 FTPGDG!PSR$TST.GDG.TSTGDG0(+01)
  -D 2 * VB  00244 27800 FTPV!PSR$TST.A.VVV.&REQNUMB
  -F 1 R -   -     -     FTPVAL1!PSR$TST.A.VVV
  250 list completed successfully.

 The LIST of symbolic files from Connect:Express Files directory available for
  User FTP1 is sent. A number of File attributes are showed. Default profile FTPV
  is part of the list. The Following attributes are sent:
  - Dynamic or Fixed Allocation
  - Allocation rule: 2 = to be created, 1 = pre-allocated, 0=to be created or replaced
  - Direction Transmission, Reception, * = both
  - File record format (Variable, Fixed, Blocked..)
  - Record length
  - Block size
}

{ TIdFTPLPSterCommExpOS390 }

class function TIdFTPLPSterCommExpOS390.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LBuf : String;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    if not IdFTPCommon.IsTotalLine(AListing[0]) then
    begin
      LBuf := AListing[0];
      if Length(LBuf) >= 3 then
      begin
        if CharIsInSet(LBuf, 2, 'DF') and (LBuf[3] = ' ') then {do not localize}
        begin
          Result := True;
          Exit;
        end;
      end;
      if Length(LBuf) >= 5 then
      begin
        if CharIsInSet(LBuf, 4, '012') and (LBuf[5] = ' ') then  {do not localize}
        begin
          Result := True;
          Exit;
        end;
      end;
    end;
  end;
end;

class function TIdFTPLPSterCommExpOS390.GetIdent: String;
begin
  Result := STIRCOMEXPOS390;
end;

class function TIdFTPLPSterCommExpOS390.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdSterCommExpOS390FTPListItem.Create(AOwner);
end;

class function TIdFTPLPSterCommExpOS390.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  s : TStrings;
  LI : TIdSterCommExpOS390FTPListItem;
begin
  LI := AItem as TIdSterCommExpOS390FTPListItem;
  s := TStringList.Create;
  try
    SplitDelimitedString(AItem.Data, s, True);
    if s.Count > 3 then
    begin
      if s[3] <> '-' then begin {do not localize}
        LI.RecFormat := s[3];
      end;
    end;
    if s.Count > 4 then begin
      LI.RecLength := IndyStrToInt64(s[4], 0);
    end;
    if s.Count > 5 then begin
      LI.BlockSize := IndyStrToInt64(s[5], 0);
    end;
    if s.Count > 6 then begin
      LI.FileName := s[6];
    end;
  finally
    FreeAndNil(s);
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPSterCommExpOS390);
finalization
  UnRegisterFTPListParser(TIdFTPLPSterCommExpOS390);

end.
