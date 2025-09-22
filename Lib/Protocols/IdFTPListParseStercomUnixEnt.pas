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
  Rev 1.4    10/26/2004 9:55:58 PM  JPMugaas
  Updated refs.

  Rev 1.3    7/31/2004 6:55:06 AM  JPMugaas
  New properties.

  Rev 1.2    4/19/2004 5:06:12 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.1    10/19/2003 3:36:20 PM  DSiders
  Added localization comments.

  Rev 1.0    10/1/2003 12:55:22 AM  JPMugaas
  New FTP list parsers.
}

unit IdFTPListParseStercomUnixEnt;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdSterCommEntUxFTPListItem = class(TIdOwnerFTPListItem)
  protected
    FFlagsProt : String;
    FProtIndicator : String;
  public
    property FlagsProt : String read FFlagsProt write FFlagsProt;
    property ProtIndicator : String read FProtIndicator write FProtIndicator;
  end;

  TIdFTPLPSterComEntBase = class(TIdFTPListBaseHeader)
  protected
    class function IsFooter(const AData : String): Boolean; override;
  end;

  TIdFTPLPSterCommEntUx = class(TIdFTPLPSterComEntBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdSterCommEntUxNSFTPListItem = class(TIdOwnerFTPListItem);

  TIdFTPLPSterCommEntUxNS = class(TIdFTPLPSterComEntBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class procedure StripPlus(var VString : String);
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

  TIdSterCommEntUxRootFTPListItem = class(TIdMinimalFTPListItem);

  TIdFTPLPSterCommEntUxRoot = class(TIdFTPLPSterComEntBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

const
  STIRCOMUNIX = 'CONNECT:Enterprise for UNIX'; {do not localize}
  STIRCOMUNIXNS = STIRCOMUNIX + '$$'; {do not localize}  //dir with $$ parameter
  STIRCOMUNIXROOT = STIRCOMUNIX + ' ROOT';  {do not localize} //root dir for mailboxes

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseStercomUnixEnt"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols,
  SysUtils;

{ TIdFTPLPSterCommEntUx }

class function TIdFTPLPSterCommEntUx.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LBuf : String;

  function IsSterPrefix(const AStr : String) : Boolean;
  begin
    Result := False;
    if Length(AStr) = 13 then
    begin
      if IsValidSterCommFlags(Copy(AStr, 1, 10)) then begin
        Result := IsValidSterCommProt(Copy(AStr, 11, 3));
      end;
    end;
  end;

begin
{
Expect a pattern such as this:

These are from the  The Jakarta Project test cases CVS code.  Only
the string constants from a test case are used.
-C--E-----FTP B QUA1I1      18128       41 Aug 12 13:56 QUADTEST
-C--E-----FTP A QUA1I1      18128       41 Aug 12 13:56 QUADTEST2

From:

http://www.mail-archive.com/commons-user@jakarta.apache.org/msg03809.html
Person noted this was from a "CONNECT:Enterprise for UNIX 1.3.01 Secure FTP"

The first few letters (ARTE, AR) are flags associated with each file.
The two sets of numbers represent batch IDs and file sizes.

-ARTE-----TCP A cbeodm   22159   629629 Aug 06 05:47 PSEUDOFILENAME
-ARTE-----TCP A cbeodm    4915  1031030 Aug 06 09:12 PSEUDOFILENAME
-ARTE-----TCP A cbeodm   16941   321321 Aug 06 12:41 PSEUDOFILENAME
-ARTE-----TCP A cbeodm    7872  3010007 Aug 07 02:31 PSEUDOFILENAME
-ARTE-----TCP A cbeodm    2737   564564 Aug 07 05:54 PSEUDOFILENAME
-ARTE-----TCP A cbeodm   14879   991991 Aug 07 08:57 PSEUDOFILENAME
-ARTE-----TCP A cbeodm    5183   332332 Aug 07 12:37 PSEUDOFILENAME
-AR-------TCP A cbeodm    5252  2767765 Aug 08 01:49 PSEUDOFILENAME
-AR-------TCP A cbeodm   15502   537537 Aug 08 05:44 PSEUDOFILENAME
-AR-------TCP A cbeodm   13444  1428427 Aug 08 09:01 PSEUDOFILENAME

-SR--M------- A steve      1     369 Sep 02 13:47 <<ACTIVITY LOG>>
}
  Result := False;
  if AListing.Count > 0 then
  begin
    LBuf := AListing[0];
    Result := IsSterPrefix(Fetch(LBuf));
    if Result then begin
      Result := IsValidSterCommProt(Fetch(LBuf));
    end;
  end;
end;

class function TIdFTPLPSterCommEntUx.GetIdent: String;
begin
  Result := STIRCOMUNIX;
end;

class function TIdFTPLPSterCommEntUx.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdSterCommEntUxFTPListItem.Create(AOwner);
end;

class function TIdFTPLPSterCommEntUx.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf, LTmp : String;
  wYear, wMonth, wDay, wHour, wMin, wSec : Word;
  LI : TIdSterCommEntUxFTPListItem;
begin
  LI := AItem as TIdSterCommEntUxFTPListItem;
  DecodeDate(Now, wYear, wMonth, wDay);
  wHour := 0;
  wMin := 0;
  wSec := 0;
  LBuf := AItem.Data;
  //flags and protocol
  LBuf := TrimLeft(LBuf);
  LI.FlagsProt := Fetch(LBuf);
  //protocol indicator
  LBuf := TrimLeft(LBuf);
  LI.ProtIndicator := Fetch(LBuf);
  // owner
  LI.OwnerName := Fetch(LBuf);
  //file size
  repeat
    LBuf := TrimLeft(LBuf);
    LTmp := Fetch(LBuf);
    if LBuf <> '' then
    begin
      if IsNumeric(LBuf[1]) then begin
        //we found the month
        Break;
      end;
      LI.Size := IndyStrToInt(LTmp, 0);
    end;
  until False;
  //month
  wMonth := StrToMonth(LTmp);
  //day
  LBuf := TrimLeft(LBuf);
  LTmp := Fetch(LBuf);
  wDay := IndyStrToInt(LTmp, wDay);
  //year or time
  LBuf := TrimLeft(LBuf);
  LTmp := Fetch(LBuf);
  if IndyPos(':', LTmp) > 0 then {do not localize}
  begin
    //year is missing - just get the time
    wYear := AddMissingYear(wDay, wMonth);
    wHour := IndyStrToInt(Fetch(LTmp, ':'), 0); {do not localize}
    wMin := IndyStrToInt(Fetch(LTmp, ':'), 0);  {do not localize}
  end else
  begin
    wYear := IndyStrToInt(LTmp, wYear);
  end;
  LI.FileName := LBuf;
  LI.ModifiedDate := EncodeDate(wYear, wMonth, wDay);
  LI.ModifiedDate := LI.ModifiedDate + EncodeTime(wHour, wMin, wSec, 0);
  Result := True;
end;

{ TIdFTPLPSterCommEntUxNS }

class function TIdFTPLPSterCommEntUxNS.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LBuf, LBuf2 : String;
{
The list format is this:

solution 00003444 00910368 <c3957010.zip.001>     030924-1636  A R       TCP BIN
solution 00000439 02688275 <C3959009.zip>         030925-0940  A RT      TCP BIN
solution 00003603 00124000 <POST1202.P1182069.L>+ 030925-1548  A RT      TCP BIN
solution 00003604 00265440 <POST1202.P1182069.O>+ 030925-1548  A RT      TCP BIN
solution 00003605 00030960 <POST1202.P1182069.S>+ 030925-1548  A RT      TCP BIN
solution 00003606 00007341 <POST1202.P1182069.R>+ 030925-1548  A RT      TCP ASC
solution 00002755 06669222 <3963338.fix.000>      030926-0811  A R       TCP BIN
solution 00003048 00007341 <POST1202.P1182069.R>+ 030926-0832  A RT      TCP ASC
solution 00002137 00427516 <c3957010.zip.002>     030926-1001  A RT      TCP BIN
solution 00002372 00007612 <C3964415.zip>         030926-1038  A RT      TCP BIN
solution 00003043 06669222 <3963338.fix.001>      030926-1236  A RT      TCP BIN
solution 00001079 57267791 <c3958462.zip>         030926-1301  A RT      TCP BIN
solution 00003188 06669222 <c3963338.zip>         030926-1312  A R       TCP BIN
solution 00002172 120072022 <c3967287.zi>          030929-1059  A RT      TCP BIN
Total Number of batches listed: 14
}
   function IsValidDate(const ADate : String) : Boolean;
   var
     LLBuf, LDate : String;
     LDay, LMonth, LHour, LMin : Word;
   begin
     LLBuf := ADate;
     LDate := Fetch(LLBuf, '-'); {do not localize}
     LMonth := IndyStrToInt(Copy(LDate, 3, 2), 0);
     Result := (LMonth > 0) and (LMonth < 13);
     if not Result then begin
       Exit;
     end;
     LDay := IndyStrToInt(Copy(LDate, 5, 2), 0);
     Result := (LDay > 0) and (LDay < 32);
     if not Result then begin
       Exit;
     end;
     LHour := IndyStrToInt(Copy(LLBuf, 1, 2), 0);
     Result := (LHour > 0) and (LHour < 25);
     if not Result then begin
       Exit;
     end;
     LMin := IndyStrToInt(Copy(LLBuf, 3, 2), 0);
     Result := (LMin < 60);
   end;

begin
  Result := False;
  if AListing.Count > 0 then
  begin
    if IsFooter(AListing[0]) then
    begin
      Result := True;
      Exit;
    end;
    if IndyPos('>', AListing[0]) > 0 then {do not localize}
    begin
      LBuf := AListing[0];
      Fetch(LBuf, '>'); {do not localize}
      StripPlus(LBuf);
      LBuf := TrimLeft(LBuf);
      if IsValidDate(Fetch(LBuf)) then
      begin
        LBuf2 := RightStr(LBuf, 7);
        if IsValidSterCommProt(Copy(LBuf2, 1, 3)) then
        begin
          if IsValidSterCommData(Copy(LBuf2, 5, 3)) then
          begin
            LBuf := Copy(LBuf, 1, Length(LBuf)-7);
            Result := IsValidSterCommFlags(LBuf);
          end;
        end;
      end;
    end;
  end;
end;

class function TIdFTPLPSterCommEntUxNS.GetIdent: String;
begin
  Result := STIRCOMUNIXNS;
end;

class function TIdFTPLPSterCommEntUxNS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdSterCommEntUxNSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPSterCommEntUxNS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf : String;
  LYear, LMonth, LDay : Word;
  LHour, LMin : Word;
  LI : TIdSterCommEntUxNSFTPListItem;
begin
  {
  The format is like this:

  ACME    00000020 00000152 <test batch>       990926-1431 CD   FTP ASC
  ACME    00000019 00000152 <test batch>       990926-1435 CD   FTP ASC
  ACME    00000014 00000606 <cmuadded locally> 990929-1306 A R TCP BIN
  ACME    00000013 00000606 <orders>           990929-1308 A R TCP EBC
  ACME    00000004 00000606 <orders>           990929-1309 A R TCP ASC
  Total Number of batches listed: 5

  Note that this was taken from:
  "Connect:Enterprise® UNIX Remote User’s Guide Version 2.1 " Copyright
  1999, 2002, 2003 Sterling Commerce, Inc.
  }
  LI := AItem as TIdSterCommEntUxNSFTPListItem;
  // owner
  LBuf := AItem.Data;
  LI.OwnerName := Fetch(LBuf);
  //8 digit batch - skip
  LBuf := TrimLeft(LBuf);
  Fetch(LBuf);
  //size
  LBuf := TrimLeft(LBuf);
  LI.Size := IndyStrToInt64(Fetch(LBuf), 0);
  //filename
  Fetch(LBuf, '<'); {do not localize}
  LI.FileName := Fetch(LBuf, '>'); {do not localize}
  StripPlus(LBuf);
  //date
  LBuf := TrimLeft(LBuf);
  //since we aren't going to do anything else after the date,
  //we should process as a string;
  //Date format:  990926-1431
  LBuf := Copy(LBuf, 1, 11);
  LYear := IndyStrToInt(Copy(LBuf, 1, 2), 0);
  LYear := Y2Year(LYear);
  LMonth := IndyStrToInt(Copy(LBuf, 3, 2), 0);
  LDay := IndyStrToInt(Copy(LBuf, 5, 2), 0);
  //  got the date
  StripPlus(LBuf);
  Fetch(LBuf, '-'); {do not localize}
  LI.ModifiedDate := EncodeDate(LYear, LMonth, LDay);
  LHour := IndyStrToInt(Copy(LBuf, 1, 2), 0);
  LMin := IndyStrToInt(Copy(LBuf, 3, 2), 0);
  LI.ModifiedDate := LI.ModifiedDate + EncodeTime(LHour, LMin, 0, 0);
  Result := True;
end;

class procedure TIdFTPLPSterCommEntUxNS.StripPlus(var VString: String);
begin
  if TextStartsWith(VString, '+') then begin {do not localize}
    IdDelete(VString, 1, 1);
  end;
end;

{ TIdFTPLPSterCommEntUxRoot }

class function TIdFTPLPSterCommEntUxRoot.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  LBuf : String;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    if IsFooter(AListing[0]) then begin
      Result := True;
      Exit;
    end;
    //The line may be something like this:
    //d   -   -   -  -  -  -  - steve
    //123456789012345678901234567890
    //         1         2         3
    //do not check for the "-" in case its something we don't know
    //about.  Checking for "d" should be okay as a mailbox listed here
    //is probably like a dir
    LBuf := AListing[0];
    if (Length(LBuf) >= 26) and
       (LBuf[1] = 'd') and             {do not localize}
       (Copy(LBuf, 2, 3)  = '   ') and {do not localize}
       (LBuf[5] <> ' ') and            {do not localize}
       (Copy(LBuf, 6, 3)  = '   ') and {do not localize}
       (LBuf[9] <> ' ') and            {do not localize}
       (Copy(LBuf, 10, 3) = '   ') and {do not localize}
       (LBuf[13] <> ' ') and           {do not localize}
       (Copy(LBuf, 14, 2) = '  ') and  {do not localize}
       (LBuf[16] <> ' ') and           {do not localize}
       (Copy(LBuf, 17, 2) = '  ') and  {do not localize}
       (LBuf[19] <> ' ') and           {do not localize}
       (Copy(LBuf, 20, 2) = '  ') and  {do not localize}
       (LBuf[22] <> ' ') and           {do not localize}
       (Copy(LBuf, 23, 2) = '  ') and  {do not localize}
       (LBuf[25] <> ' ') and           {do not localize}
       (LBuf[26] = ' ') then           {do not localize}
    begin
      Result := True;
    end;
  end;
end;

class function TIdFTPLPSterCommEntUxRoot.GetIdent: String;
begin
  Result := STIRCOMUNIXROOT;
end;

class function TIdFTPLPSterCommEntUxRoot.IsFooter(const AData: String): Boolean;
begin
  Result := TextStartsWith(AData, 'Total number of Mailboxes = '); {do not localize}
end;

class function TIdFTPLPSterCommEntUxRoot.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdSterCommEntUxRootFTPListItem.Create(AOwner);
end;

class function TIdFTPLPSterCommEntUxRoot.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
begin
  AItem.FileName := Copy(AItem.Data, 27, MaxInt);
  //mailboxes are just subdirs
  AItem.ItemType := ditDirectory;
  Result := True;
end;

{ TIdFTPLPSterComEntBase }

class function TIdFTPLPSterComEntBase.IsFooter(const AData: String): Boolean;
var
  LData : String;
begin
  LData := UpperCase(AData);
  Result := (IndyPos('TOTAL NUMBER OF ', LData) > 0) and  {do not localize}
            (IndyPos(' BATCH', LData) > 0) and            {do not localize}
	    (IndyPos('LISTED:', LData) > 0);              {do not localize}
end;

initialization
  RegisterFTPListParser(TIdFTPLPSterCommEntUx);
  RegisterFTPListParser(TIdFTPLPSterCommEntUxNS);
  RegisterFTPListParser(TIdFTPLPSterCommEntUxRoot);
finalization
  UnRegisterFTPListParser(TIdFTPLPSterCommEntUx);
  UnRegisterFTPListParser(TIdFTPLPSterCommEntUxNS);
  UnRegisterFTPListParser(TIdFTPLPSterCommEntUxRoot);

end.
