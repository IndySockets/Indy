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
  Rev 1.5    10/26/2004 9:36:26 PM  JPMugaas
  Updated ref.

  Rev 1.4    4/19/2004 5:05:28 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:22 PM  czhower
  Name changes

  Rev 1.2    10/19/2003 2:08:48 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:03:02 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 04:18:10 AM  JPMugaas
  More things restructured for the new list framework.
}

unit IdFTPListParseAS400;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdAS400FTPListItem = class(TIdOwnerFTPListItem);
  TIdFTPLPAS400 = class(TIdFTPLineOwnedList)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseAS400"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon,  IdGlobalProtocols, SysUtils;

const
  DIR_TYPES : array [0..3] of string = ('*DIR','*DDIR','*LIB','*FLR');

{ TIdFTPLPAS400 }

class function TIdFTPLPAS400.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
var
  s : TStrings;
begin
  Result := False;
  if AListing.Count > 0 then begin
    s := TStringList.Create;
    try
      SplitDelimitedString(AListing[0], s, True);
      if s.Count > 4 then begin
        Result := CharEquals(s[4], 1, '*') or (s[4]='DIR');  {Do not localize}
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPAS400.GetIdent: String;
begin
  Result := 'AS400';  {do not localize}
end;

class function TIdFTPLPAS400.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdAS400FTPListItem.Create(AOwner);
end;

class function TIdFTPLPAS400.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuffer : String;
  LDate : String;
  LTime : String;
  LObjType : String;
  LI : TIdOwnerFTPListItem;
begin
  try
{  From:
http://groups.google.com/groups?q=AS400+LISTFMT+%3D+0&hl=en&lr=&ie=UTF-8&oe=utf-8&selm=9onmpt%24dhe%2402%241%40news.t-online.com&rnum=1

  ftp> dir qtemp/timestamp
  200 PORT subcommand request successful.
  125 List started.
  drwx---rwx 1 QPGMR 0 20480 Sep 24 18:16 TIMESTAMP
  -rwx---rwx 1 QPGMR 0     0 Sep 24 18:16 TIMESTAMP.TIMESTAMP
  250 List completed.
  FTP: 140 Bytes empfangen in 0.06Sekunden 2.33KB/s

  or

  ftp> dir qtemp/timestamp
  200 PORT subcommand request successful.
  125 List started.

         1         2         3         4         5
  123456789012345678901234567890123456789012345678901234567890
  QPGMR 20480 24.09.01 18:16:20 *FILE QTEMP/TIMESTAMP
  QPGMR                         *MEM  QTEMP/TIMESTAMP.TIMESTAMP
  250 List completed.
  FTP: 146 Bytes empfangen in 0.00Sekunden 146000.00KB/s

It depends qether the SITE param LISTFMT is set to "1" (1st example, *nix-
like) or "0" (2nd example, OS/400-like). I have choosen the 2nd format (I
think it's easier to parse). To get it, submit "QUOTE SITE LISTFMT 0" just
before submitting the DIR command.

From IBM Manual at:
http://publib.boulder.ibm.com/iseries/v5r2/ic2924/index.htm

Here is the original iSeries style format for the LIST subcommand
(when LISTFMT=0):

owner size date time type name
A blank space separates each field.

This is a description of each field:

owner
The 10 character string that represents the user profile which owns the subject.
This string is left justified, and includes blanks. This field is blank for
anonymous FTP sessions.

size
The 10 character number that represents the size of the object. This number is
right justified, and it includes blanks. This field is blank when an object has
no size associated with it.

date
The 8 character modification date in the format that is defined for the server
job. It uses date separators that are defined for the server job. This
modification date is left justified, and it includes blanks.

time
The 8 character modification time that uses the time separator, which the
server job defines.

type
The 10 character OS/400 object type.

name
The variable length name of the object that follows a CRLF (carriage return,
line feed pair). This name may include blanks.

Here is an example of the original iSeries style format:

         1         2         3         4         5
123456789012345678901234567890123456789012345678901234567890
BAILEYSE     5263360 06/11/97 12:27:39 *FILE     BPTFSAVF

Note on name format from (
http://groups.google.com/groups?q=AS400+FTP+LIST+format&hl=
en&lr=&ie=UTF-8&oe=utf-8&selm=3264740F.B52%40mother.com&rnum=4):

Starting in v3r1 you can access the shared folders area or libraries with FTP by using the
"NAMEFMT 1" command. For example:

SYST
215  OS/400 is the remote operating system. The TCP/IP version is "V3R1M0".
SITE NAMEFMT 1
250  Now using naming format "1".
LIST /QDLS

/QDLS/ARM          0 11/09/95 07:19:30 DIR
/QDLS/ARM-VOL1     0 06/23/95 16:39:43 DIR
/QDLS/ARMM         0 08/04/95 14:32:03 DIR

or

SYST
215  OS/400 is the remote operating system. The TCP/IP version is "V3R1M0".
SITE NAMEFMT 1
250  Now using naming format "1".
LIST /QSYS.LIB

QSYS      3584  11/15/95 16:15:33 *FILE    /QSYS.LIB/QSYS.LIB/QPRTRPYL.PRTF
QSYS      18432 11/15/95 16:15:33 *FILE      /QSYS.LIB/QSYS.LIB/QPRTSBSD.PRTF
QSYS      5632  11/15/95 16:15:33 *FILE      /QSYS.LIB/QSYS.LIB/QPRTSPLF.PRTF
QSYS      8704  11/15/95 16:15:33 *FILE      /QSYS.LIB/QSYS.LIB/QPRTSPLQ.PRTF

}
{Notes from   Angus Robertson, Magenta Systems Ltd,

MORE TYPES OF SHIT ON THE AS/400 FILE SYSTEM

 Object types that are commonly used or that you are likely to see on
 this display include the following:
AUTL        Authorization list
BLKSF       Block special file
CFGL        Configuration list
CLS         Class
CMD         Command
CTLD        Controller description
DDIR        Distributed directory
DEVD        Device description
DIR         Directory
DOC         Document
DSTMF       Distributed stream file
FILE        Database file or device file
FLR         Folder
JOBD        Job description
JOBQ        Job queue
LIB         Library
LIND        Line description
MSGQ        Message queue
OUTQ        Output queue
PGM         Program
SBSD        Subsystem description
SOMOBJ      System Object Model object
STMF        Stream file
SYMLNK      Symbolic link
USRPRF      User profile
}
  LI := AItem as TIdOwnerFTPListItem;
  LI.ModifiedAvail := False;
  LI.SizeAvail := False;
  
  LBuffer := AItem.Data;
  LI.OwnerName := Fetch(LBuffer);

  LBuffer := TrimLeft(LBuffer);
  //we have to make sure that the size feild really exists or the
  //the parser is thrown off
  if (LBuffer <> '') and (IsNumeric(LBuffer[1])) then begin
    LI.Size := IndyStrToInt64(FetchLength(LBuffer,9),0);
    LI.SizeAvail := True;
    LBuffer := TrimLeft(LBuffer);
  end;
  //Sometimes the date and time feilds will not present
  if (LBuffer <> '') and (IsNumeric(LBuffer[1])) then begin
    LDate := Trim(StrPart(LBuffer, 8));
    if (LBuffer <> '') and (LBuffer[1] <> ' ') then begin
      LDate := LDate + Fetch(LBuffer);
    end;
    if LDate <> '' then begin
      LI.ModifiedDate := AS400Date(LDate);
       LI.ModifiedAvail := True;
    end;
    LTime := Trim(StrPart(LBuffer, 8));
    if (LBuffer <> '') and (LBuffer[1] <> ' ') then begin
      LTime := LTime + Fetch(LBuffer);
    end;
    if LTime <> '' then begin
      LI.ModifiedDate :=  LI.ModifiedDate + TimeHHMMSS(LTime);
    end;
  end;
  //most of this data is manditory so things are less sensitive to positions
  LBuffer := Trim(LBuffer);
  LObjType := FetchLength(LBuffer,11);
  //A file object is something like a file but it can contain members - treat as dir.
  //  Odd, I know.
  //There are also several types of file objects
  //note that I'm not completely sure about this so it's commented out.  JPM

//  if TextStartsWith(LObjType, '*FILE') then begin {do not localize}
//    LI.ItemType := ditDirectory;
//  end;
  if IdGlobal.PosInStrArray(LObjType,DIR_TYPES)>-1 then begin {do not localize}
    LI.ItemType := ditDirectory;
    if TextEndsWith(LBuffer,'/') then begin
      LBuffer := Fetch(LBuffer,'/');
    end;
  end;
  LI.FileName := TrimLeft(LBuffer);
  if LI.FileName = '' then begin
    LI.FileName := LI.OwnerName;
    LI.OwnerName := '';
  end;

  LI.LocalFileName := LowerCase(StripPath(AItem.FileName, '/'));
  Result := True;
  except
    Result := False;
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPAS400);
finalization
  UnRegisterFTPListParser(TIdFTPLPAS400);
end.
