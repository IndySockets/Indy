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
  Rev 1.5    10/26/2004 10:03:24 PM  JPMugaas
  Updated refs.

  Rev 1.4    4/19/2004 5:05:40 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:26 PM  czhower
  Name changes

  Rev 1.2    10/19/2003 3:48:22 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:04:42 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 05:49:46 PM  JPMugaas
  Parsers ported from old framework.
}

unit IdFTPListParseXecomMicroRTOS;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdFTPList, IdFTPListParseBase;

type
   TIdXecomMicroRTOSTPListItem = class(TIdFTPListItem)
   protected
     FMemStart: UInt32;
     FMemEnd: UInt32;
   public
     constructor Create(AOwner: TCollection); override;
     property MemStart: UInt32 read FMemStart write FMemStart;
     property MemEnd: UInt32 read FMemEnd write FMemEnd;
   end;

  TIdFTPLPXecomMicroRTOS = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean;  override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseXecomMicroRTOS"'}
  {$ENDIF}

implementation

uses
  IdFTPCommon, IdGlobalProtocols, IdStrings,
  SysUtils;

{ TIdFTPLPXecomMicroRTOS }

class function TIdFTPLPXecomMicroRTOS.GetIdent: String;
begin
  Result := 'Xercom Micro RTOS';  {do not localize}
end;

class function TIdFTPLPXecomMicroRTOS.IsFooter(const AData: String): Boolean;
var
  s : TStrings;
begin
  Result := False;
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    if s.Count = 7 then
    begin
      Result := (s[0] = '**') and      {do not localize}
                (s[1] = 'Total') and   {do not localize}
                IsNumeric(s[2]) and
                (s[3] = 'files,') and  {do not localize}
                IsNumeric(s[4]) and
                (s[5] = 'bytes') and   {do not localize}
                (s[6] = '**');         {do not localize}
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPXecomMicroRTOS.IsHeader(const AData: String): Boolean;
var
  s : TStrings;
begin
  Result := False;
  s := TStringList.Create;
  try
    SplitDelimitedString(AData, s, True);
    if s.Count = 5 then
    begin
      Result := (s[0] = 'Start') and    {do not localize}
                (s[1] = 'End') and      {do not localize}
                (s[2] = 'length') and   {do not localize}
                (s[3] = 'File') and     {do not localize}
                (s[4] = 'name');        {do not localize}
    end;
  finally
    FreeAndNil(s);
  end;
end;

class function TIdFTPLPXecomMicroRTOS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdXecomMicroRTOSTPListItem.Create(AOwner);
end;

class function TIdFTPLPXecomMicroRTOS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf : String;
  LI : TIdXecomMicroRTOSTPListItem;
begin
  LI := AItem as TIdXecomMicroRTOSTPListItem;
  LBuf := TrimLeft(AItem.Data);
  //start memory offset
  LBuf := TrimLeft(LBuf);
  LI.MemStart := IndyStrToInt('$'+Fetch(LBuf), 0);
  //end memory offset
  LBuf := TrimLeft(LBuf);
  LI.MemEnd := IndyStrToInt('$'+Fetch(LBuf),0);
  //file size
  LBuf := TrimLeft(LBuf);
  LI.Size := IndyStrToInt64(Fetch(LBuf), 0);
  //File name
  LI.FileName := TrimLeft(LBuf);
  //note that the date is not provided and I do not think there are
  //dirs in this real-time operating system.
  Result := True;
end;

{ TIdXecomMicroRTOSTPListItem }

constructor TIdXecomMicroRTOSTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  ModifiedAvail := False;
end;

initialization
  RegisterFTPListParser(TIdFTPLPXecomMicroRTOS);
finalization
  UnRegisterFTPListParser(TIdFTPLPXecomMicroRTOS);

end.
