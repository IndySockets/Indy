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
  Rev 1.13    2/5/2005 12:33:46 PM  JPMugaas
  A bug was causing a false positive for TOPS20 for a Windows NT directory
  listing only containing one folder.

  Rev 1.12    2/3/2005 11:26:50 PM  JPMugaas
  Fix for DotNET problem.

  Rev 1.11    12/8/2004 8:35:18 AM  JPMugaas
  Minor class restructure to support Unisys ClearPath.

  Rev 1.10    11/30/2004 12:14:46 PM  JPMugaas
  Compiler error in DotNET.

  Rev 1.9    11/26/2004 3:14:14 PM  JPMugaas
  TOPS20 parser was causing a false positive with a WindowsNT machine.  The fix
  is detect a space in a file listing (that should not happen with one form of
  the TOPS20 listing).

  Rev 1.8    11/22/2004 7:43:46 PM  JPMugaas
  Changed LocalFile property for directories to drop the .DIRECTORY extension
  and build number.  You don't use those with a CD command.

  Rev 1.7    11/20/2004 2:39:02 PM  JPMugaas
  Now works at twenex.org.  That system is odd because it doesn't support the
  SYST command so you have to parse the directory.

  Rev 1.6    10/26/2004 9:55:58 PM  JPMugaas
  Updated refs.

  Rev 1.5    6/5/2004 7:48:56 PM  JPMugaas
  In TOPS32, a FTP dir listing will often not contain dates or times.  It's
  usually just the name.

  Rev 1.4    4/19/2004 5:05:44 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.3    2004.02.03 5:45:26 PM  czhower
  Name changes

  Rev 1.2    10/19/2003 3:36:22 PM  DSiders
  Added localization comments.

  Rev 1.1    4/7/2003 04:04:18 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.0    2/19/2003 05:49:58 PM  JPMugaas
  Parsers ported from old framework.
}

unit IdFTPListParseTOPS20;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdTOPS20FTPListItem = class(TIdCreationDateFTPListItem);

  TIdFTPLPTOPS20 = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
  end;

const
  TOPS20_VOLPATH_SEP = ':<'; {do not localize}
  TOPS20_DIRFILE_SEP = '>';  {do not localize}

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseTOPS20"'}
  {$ENDIF}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, SysUtils;


{ TIdFTPLPTOPS20 }

class function TIdFTPLPTOPS20.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  s : String;
  LParts : TStrings;
  i : Integer;
begin
  s := ASysDescript;
  s := Fetch(s);
  Result := (s = 'TOPS20'); {do not localize}
  if not Result then
  begin
    //one server doesn't give a SYST reply at all
    //<ACC>LOGIN.CMD.1;P777700;A,1,15-Aug-2003 09:42:12,15-Aug-2003 09:42:12,16-Nov-1858 16:00:00
    if AListing.Count >0 then
    begin
      LParts := TStringList.Create;
      try
        SplitDelimitedString(AListing[0], LParts, False, ','); {do not localize}
        if LParts.Count > 0 then
        begin
          if PatternsInStr(';', LParts[0]) = 2 then {do not localize}
          begin
            if LParts.Count > 3 then
            begin
              s := LParts[2];

              Result := IsDDMonthYY(Fetch(s), '-'); {do not localize}
              if Result then begin
                Result := IsHHMMSS(s, ':'); {do not localize}
              end;
              s := LParts[3];

              Result := IsDDMonthYY(Fetch(s), '-'); {do not localize}
              if Result then begin
                Result := IsHHMMSS(s, ':'); {do not localize}
              end;
            end;
          end;
          {
          maybe pattern like this:
          TOPS20:<ACCT>
          LOGIN.CMD.1
          MSGS.TXT.1
          }
          s := AListing[0];
          if IndyPos(TOPS20_VOLPATH_SEP, s) >0 then
          begin
            if IndyPos(TOPS20_VOLPATH_SEP, s) < IndyPos(TOPS20_DIRFILE_SEP, s) then
            begin
              Result := True;
              for i := 1 to AListing.Count-1 do
              begin
                LParts.Clear;
                Result := IndyPos(' ', AListing[i]) = 0; {do not localize}
                if Result then
                begin
                  SplitDelimitedString(AListing[i], LParts, False, '.'); {do not localize}
                  if LParts.Count = 3 then begin
                    Result := IsNumeric(LParts[2]);
                  end;
                end;
                if not Result then begin
                  Break;
                end;
              end;
            end;
          end;
        end;
      finally
        FreeAndNil(LParts);
      end;
    end;
  end;
end;

class function TIdFTPLPTOPS20.GetIdent: String;
begin
  Result := 'TOPS20'; {do not localize}
end;

class function TIdFTPLPTOPS20.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdTOPS20FTPListItem.Create(AOwner);
end;

class function TIdFTPLPTOPS20.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf : String;
  LI : TIdTOPS20FTPListItem;

{
Notes from the FTP Server greeting at toad.xkl.com

230- Welcome!  You are logged in to a Tops-20 system, probably not familiar
230- to you.  We therefore offer this short note on directory and file naming
230- conventions:
230-
230- A file name consists of 2 required parts, and several optional parts, of
230- which 3 are important to you as an FTP user.  These 5 parts together are
230-
230- device:<directory>filename.filetype.generation
230-
230- where the punctuation is required.  The DEVICE:, <DIRECTORY>, and GENERATION
230- fields are optional, defaulting to current device and directory and latest
230- generation of the file.  File names are NOT in general case-sensitive.
230-
230- <DIRECTORY> may have subparts, separated by dots.  All the following are
230- syntactically valid directory specifications (though they may not exist on
230- this particular system):
230-
230- <FOO>  or  <FOO.BAR>  or  <FOO.BAR.QUUX>  or  <SRC.7.MONITOR.BUILD>
230-
230- GENERATION is numeric; it may take the special values 0 (latest generation),
230- -1 (new, next higher generation), -2 (oldest generation), and -3 (wildcard
230- for all generations), as well as specific numeric generations.
230-
230- DEVICE: usually represents the name of a file system.
230-
230- Wildcards are specified as * (match 0 or more characters) and % (match 1
230- single character).  To obtain all the command files in a directory, you
230- would ask for the retrieval of
230-
230- *.CMD.*
230-
230- To obtain the latest version of all the files with a 1-character FILETYPE,
230- you would request
230-
230- *.%.0
}
  function StripBuild(const AFileName : String): String;
  var
    LPos : Integer;
  begin
    LPos := RPos('.', AFileName, -1); {do not localize}
    if LPos = 0 then begin
      Result := AFileName;
    end else begin
      Result := Copy(AFileName, 1, LPos-1);
    end;
  end;

begin
  LI := AItem as TIdTOPS20FTPListItem;
  LBuf := AItem.Data;
  if (IndyPos(TOPS20_VOLPATH_SEP, LBuf) > 0) and (IndyPos(TOPS20_DIRFILE_SEP, LBuf) = Length(LBuf)) then
  begin
    //Tape and subdir should work for CD
    //Note this is probably something like a "CD ." on other systems.
    //From what I saw at one server, they had to give a list including
    //subdirectories because the server never returned those.
    AItem.FileName := LBuf;
    //You can tree this like a directory.  It contains the device so it might
    //look weird.
    AItem.ItemType := ditDirectory;
    //strip off device in and path suffix >
    Fetch(LBuf, TOPS20_VOLPATH_SEP);
    LBuf := Fetch(LBuf, TOPS20_DIRFILE_SEP);
    AItem.LocalFileName := LowerCase(Fetch(LBuf, '.'));
    AItem.SizeAvail := False;
    AItem.ModifiedAvail := False;
    Result := True;
    Exit;
  end;
  if TextStartsWith(LBuf, '<') then {do not localize}
  begin
    //we may be dealing with a data format such as this:
    //
    //<ANONYMOUS>INSTALL.MEM.1;P775252;A,210,10-Apr-1990 13:17:41,10-Apr-1990 13:18:26,11-Jan-2003 11:34:26
    AItem.FileName := Fetch(LBuf, ';'); {do not localize}
    //P775252;
    Fetch(LBuf, ';'); {do not localize}
    //A,
    Fetch(LBuf, ','); {do not localize}
    //210,
    Fetch(LBuf, ','); {do not localize}
    //Creation Date - date - I think
    LI.CreationDate := DateDDStrMonthYY(Fetch(LBuf));
    //creation date - time
    LI.CreationDate := LI.CreationDate + TimeHHMMSS(Trim(Fetch(LBuf, ','))); {do not localize}
    //Last modified - date
    AItem.ModifiedDate := DateDDStrMonthYY(Fetch(LBuf));
    //Last modified - time
    AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(Trim(LBuf));
    //strip off path information and build no for file
    LBuf := LowerCase(AItem.FileName);
    Fetch(LBuf, TOPS20_DIRFILE_SEP);
    if IndyPos('.DIRECTORY.', LBuf) > 0 then {do not localize}
    begin
      AItem.ItemType := ditDirectory;
      AItem.LocalFileName := Fetch(LBuf, '.'); {do not localize}
    end else begin
      AItem.LocalFileName := StripBuild(LBuf);
    end;
  end else
  begin
    //That's right - it only returned the file name, no dates, no size, nothing else
    AItem.FileName := LBuf;
    AItem.LocalFileName := LowerCase(StripBuild(LBuf));
    AItem.ModifiedAvail := False;
    AItem.SizeAvail := False;
    if IndyPos('.DIRECTORY.', LBuf) > 0 then begin {do not localize}
      AItem.ItemType := ditDirectory;
    end;
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPTOPS20);
finalization
  UnRegisterFTPListParser(TIdFTPLPTOPS20);

end.
