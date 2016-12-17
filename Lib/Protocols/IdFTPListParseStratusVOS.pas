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
  Rev 1.1    2/23/2005 6:34:26 PM  JPMugaas
  New property for displaying permissions ina GUI column.  Note that this
  should not be used like a CHMOD because permissions are different on
  different platforms - you have been warned.

  Rev 1.0    11/24/2004 12:17:00 PM  JPMugaas
  New parser for Stratus VOS.  This will work with:
}

unit IdFTPListParseStratusVOS;

{
  FTP server (FTP 1.0 for Stratus STCP)
  FTP server (OS TCP/IP)
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

type
  TIdStratusVOSFTPListItem = class(TIdFTPListItem)
  protected
    FAccess : String;
    FNumberBlocks : Integer;
    FBlockSize : Integer;
    FFileFormat : String;
    FLinkedItemName : string;
  public
    property Access : String read FAccess write FAccess;
    property NumberBlocks : Integer read FNumberBlocks write FNumberBlocks;
    property BlockSize : Integer read FBlockSize write FBlockSize;
    property FileFormat : String read FFileFormat write FFileFormat;
    //This results will look odd for symbolic links
    //Don't panic!!!
    //
    //Stratus VOS has an unusual path syntax such as:
    //
    //%phx_cac#m2_user>Stratus>Charles_Spitzer>junque>_edit.vterm1.1
    //
    //where the > is a path separator
    property LinkedItemName : string read FLinkedItemName write FLinkedItemName;
  end;

  TIdFTPLPStratusVOS = class(TIdFTPListBase)
  protected
    class function IsValidFileEntry(const ALine : String) : Boolean;
    class function IsValidDirEntry(const ALine : String): Boolean;
    class function IsFilesHeader(const ALine : String): Boolean;
    class function IsDirsHeader(const ALine : String): Boolean;
    class function IsLinksHeader(const ALine : String): Boolean;
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function ParseDirEntry(const AItem: TIdFTPListItem): Boolean;
    class function ParseFileEntry(const AItem : TIdFTPListItem): Boolean;
    class function ParseLinkEntry(const AItem : TIdFTPListItem): Boolean;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
    class function ParseListing(AListing : TStrings; ADir : TIdFTPListItems) : Boolean; override;
  end;

  // RLebeau 2/14/09: this forces C++Builder to link to this unit so
  // RegisterFTPListParser can be called correctly at program startup...

  {$IFDEF HAS_DIRECTIVE_HPPEMIT_LINKUNIT}
    {$HPPEMIT LINKUNIT}
  {$ELSE}
    {$HPPEMIT '#pragma link "IdFTPListParseStratusVOS"'}
  {$ENDIF}

implementation

    {
From:   Manual Name: VOS Reference Manual

Part Number: R002

Revision Number: 01

Printing Date: April 1990

Stratus Computer, Inc.


Path Names

The most important function of the directory hierarchy is to provide
a way to uniquely but conveniently name any object in the I/O
system. Any user on any processing module or system that can
communicate with the module containing the object can then refer to
the object.

The unique name of an object is derived from the object's unique
path in the I/O system. The unique name is called the path name of
the object. A path name is constructed from the name of the object,
the names of the directories in the path leading to the object, and
the name of the system containing the root parent directory.

The path name of a file or directory is a combination of the
following names:

1. the name of the system containing the object preceded by a
percent sign (%).
2. the name of the disk containing the object preceded by a number
sign (#)
3. the names of the directories in the path of the object, in order, each preceded by the greater-than sign (>)

4. the name of the object preceded by the greater-than sign (>).

The symbol > is used to separate directories and files in the path
name. Its use is similar to the use of / or \ in other operating
systems.

For example, suppose you have a system named %s containing a disk
named #d01. (The module containing the disk is %s#m1.) The following
is an example of a full path name for the file named this_week.

%s#d01>Administration>Jones>reports>this_week


The file is immediately contained in the directory reports, which is
subordinate to the directory Jones. The home directory Jones is a
subdirectory of the group directory Administration which is a
subdirectory of the disk #d01.
Relative Path Names

The path names defined so far are full path names. The full path
name of an object is unique because the path of an object is unique.
The operating system can also interpret relative path names. A
relative path name is a combination of object names and pecial
symbols, like a full path name, that identifies an object in the
directory hierarchy. A relative path name of the object generally
does not contain all the directory names that are in the full path
name. When you use a relative path name, the operating system
determines the missing information about the object's location rom
the location of the current directory.

If the operating system reads a string that it expects to be a path
name and the leading character is not a percent sign, it interprets
the string as a relative path name.

The single character < can be used to refer to the parent directory
of the current directory. For example, the command
change_current_dir < moves you up one directory in the directory
hierarchy. A single period (.) also refers to the current directory
and two periods (..) refers to the parent directory. Thus,
change_current_dir .. is the same as the change_current_dir <.
    }

uses
  IdFTPCommon, IdGlobal, IdGlobalProtocols, SysUtils;

{ TIdFTPLPStratusVOS }

class function TIdFTPLPStratusVOS.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  i : Integer;
  LMode : TIdDirItemType;
begin
  Result := False;
  LMode := ditFile;
  for i := 0 to AListing.Count - 1 do
  begin
    if AListing[i] <> '' then
    begin
      if IsFilesHeader(AListing[i]) then begin
        LMode := ditFile;
      end
      else if IsDirsHeader(AListing[i]) then begin
        LMode := ditDirectory;
      end
      else if IsLinksHeader(AListing[i]) then begin
        LMode := ditSymbolicLink;
      end else
      begin
        case LMode of
          ditFile :
            begin
              if not IsValidFileEntry(AListing[i]) then begin
                Exit;
              end;
            end;
          ditDirectory :
            begin
              if not IsValidDirEntry(AListing[i]) then begin
                Exit;
              end;
            end;
        end;
      end;
    end;
  end;
  Result := True;
end;

class function TIdFTPLPStratusVOS.GetIdent: String;
begin
  Result := 'Stratus VOS'; {do not localize}
end;

class function TIdFTPLPStratusVOS.IsDirsHeader(const ALine: String): Boolean;
begin
  { Dirs: 0 }
  Result := TextStartsWith(ALine, 'Dirs: '); {do not localize}
end;

class function TIdFTPLPStratusVOS.IsFilesHeader(const ALine: String): Boolean;
begin
  { Files: 4 Blocks: 609 }
  Result := TextStartsWith(ALine, 'Files: ') and (IndyPos('Blocks: ', ALine) > 8); {do not localize}
end;

class function TIdFTPLPStratusVOS.IsLinksHeader(const ALine: String): Boolean;
begin
  { Links: 0 }
  Result := TextStartsWith(ALine, 'Links: '); {do not localize}
end;

class function TIdFTPLPStratusVOS.IsValidDirEntry(const ALine: String): Boolean;
var
  s, s2 : String;
begin
  Result := False;
  s := ALine;
  //a listing may start of with one space
  //permissions
  if TextStartsWith(s, ' ') then begin {do not localize}
    IdDelete(s, 1, 1);
  end;
  if Length(Fetch(s)) <> 1 then begin
    Exit;
  end;
  s := TrimLeft(s);
  //block count
  if not IsNumeric(Fetch(s)) then begin
    Exit;
  end;
  s := TrimLeft(s);
  s2 := Fetch(s);
  //date
  if not IsYYYYMMDD(s2) then begin
    Exit;
  end;
  s := TrimLeft(s);
  s2 := Fetch(s);
  //time
  Result := IsHHMMSS(s2, ':'); {do not localize}
end;

class function TIdFTPLPStratusVOS.IsValidFileEntry(const ALine: String): Boolean;
var
  s, s2 : String;
begin
  Result := False;
  s := ALine;
  //a listing may start of with one space
  if TextStartsWith(s, ' ') then begin {do not localize}
    IdDelete(s, 1, 1);
  end;
  if Length(Fetch(s)) <> 1 then begin
    Exit;
  end;
  s := TrimLeft(s);
  if not IsNumeric(Fetch(s)) then begin
    Exit;
  end;
  s := TrimLeft(s);
  s2 := Fetch(s);
  if not IsNumeric(s2, 2) then
  begin
    s := TrimLeft(s);
    s2 := Fetch(s);
  end;
  if not IsYYYYMMDD(s2) then begin
    Exit;
  end;
  s := TrimLeft(s);
  s2 := Fetch(s);
  Result := IsHHMMSS(s2, ':'); {do not localize}
end;

class function TIdFTPLPStratusVOS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdStratusVOSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPStratusVOS.ParseDirEntry(const AItem: TIdFTPListItem): Boolean;
var
  LV : TIdStratusVOSFTPListItem;
  LBuf, LPart : String;
begin
//w    158 stm       90-05-19 11:53:44  acctng.cobol
{
Files
Access    Access   Description
Right      Code
--------------------------------
undefined    u     Denies the user all access to the file. This code
                   occurs only if the effective access list for the
                   file does not contain any entry applicable to the
                   given user name.

nul          n     Denies the user all access to the file.

execute      e     Allows the user to execute a program module or
                   command macro, but not to read, modify, or delete
                   it.

read         r     Allows the user to read the file (or to execute
                   it, if it is executable), but not to modify or
                   delete it.

write        w     Gives the user full access to the contents of
                   the file. (However, to delete or write to the
                   file, the user must have modify access to the
                   directory in which the file is contained.)


Directory
Access    Access   Description
Right      Code
--------------------------------
undefined    u     Denies the user all access to the directory.
                   This code occurs only if the effective access
                   list for the directory does not contain any
                   entry applicable to the given user name.

nul          n     Denies the user all access to the directory.

status       s     Allows the user to list the contents of the
                   directory and to see other status information,
                   but not to change any of the contents.

modify       m     Gives the user full access to the contents of
                   the directory.
                   }
   Result := False;
   LV := AItem as TIdStratusVOSFTPListItem;
   LBuf := AItem.Data;
   if TextStartsWith(LBuf, ' ') then begin {do not localize}
     IdDelete(LBuf, 1, 1);
   end;
   LV.FAccess := Fetch(LBuf);
   if Length(LV.FAccess) <> 1 then
   begin
     //invalid
     LV.FAccess := '';
     Exit;
   end;
   LBuf := TrimLeft(LBuf);
   //block count
   LPart := Fetch(LBuf);
   if not IsNumeric(LPart) then begin
     Exit;
   end;
   LV.NumberBlocks := IndyStrToInt(LPart, 0);
   //size
   LV.Size := (LV.NumberBlocks * 4096);
   LV.SizeAvail := True;
   //Note that will NOT be accurate but it's the best you can do.
   //date
   LBuf := TrimLeft(LBuf);
   LPart := Fetch(LBuf);
   if not IsYYYYMMDD(LPart) then begin
     Exit;
   end;
   LV.ModifiedDate := DateYYMMDD(LPart);
   //time
   LBuf := TrimLeft(LBuf);
   LPart := Fetch(LBuf);
   if not IsHHMMSS(LPart, ':') then begin {do not localize}
     Exit;
   end;
   LV.ModifiedDate := LV.ModifiedDate + TimeHHMMSS(LPart);
   LBuf := TrimLeft(LBuf);
   LV.FileName := LBuf;
   Result := True;
end;

class function TIdFTPLPStratusVOS.ParseFileEntry(const AItem: TIdFTPListItem): Boolean;
var
  LV : TIdStratusVOSFTPListItem;
  LBuf, LPart : String;
begin
//w    158 stm       90-05-19 11:53:44  acctng.cobol
{
Files
Access    Access   Description
Right      Code
--------------------------------
undefined    u     Denies the user all access to the file. This code
                   occurs only if the effective access list for the
                   file does not contain any entry applicable to the
                   given user name.

nul          n     Denies the user all access to the file.

execute      e     Allows the user to execute a program module or
                   command macro, but not to read, modify, or delete
                   it.

read         r     Allows the user to read the file (or to execute
                   it, if it is executable), but not to modify or
                   delete it.

write        w     Gives the user full access to the contents of
                   the file. (However, to delete or write to the
                   file, the user must have modify access to the
                   directory in which the file is contained.)


Directory
Access    Access   Description
Right      Code
--------------------------------
undefined    u     Denies the user all access to the directory.
                   This code occurs only if the effective access
                   list for the directory does not contain any
                   entry applicable to the given user name.

nul          n     Denies the user all access to the directory.

status       s     Allows the user to list the contents of the
                   directory and to see other status information,
                   but not to change any of the contents.

modify       m     Gives the user full access to the contents of
                   the directory.
                   }
  Result := False;
  LV := AItem as TIdStratusVOSFTPListItem;
  LBuf := AItem.Data;
  if TextStartsWith(LBuf, ' ') then begin {do not localize}
    IdDelete(LBuf, 1, 1);
  end;
  LV.FAccess := Fetch(LBuf);
  LV.PermissionDisplay := LV.Access;
  if Length(LV.FAccess) <> 1 then
  begin
    //invalid
    LV.FAccess := '';
    Exit;
  end;
  LBuf := TrimLeft(LBuf);
  //block count
  LPart := Fetch(LBuf);
  if not IsNumeric(LPart) then begin
    Exit;
  end;
  LV.NumberBlocks := IndyStrToInt(LPart, 0);
  //file format
  LBuf := TrimLeft(LBuf);
  LV.FileFormat := Fetch(LBuf);
  {
Charlie Spitzer, stratus customer service, made this note in an E-Mail to me:

not all files can be directly calculated in size. there are different file
types, each of which has a different file calculation. for example, in the
above list, stm means stream, and is directly equal to a unix file. however,
seq stands for sequential, and there is a 4 byte overhead per record, and no
way to determine the number of records from ftp. there are other file types
which you can see, rel (relative) being one of them, and the overhead is 2
bytes per record, but each record doesn't have to be the same size, and
again there is no way to determine the # of records.

READ THIS!!!

In a further correspondance, Charlie Spitzer did note this:

a block count is the number of 4096 byte blocks allocated to the file. it
contains data blocks + index blocks, if any. there is no way to get a record
count, and if the file is sparse (not all records of the file are written,
since it's possible to write a record not at the beginning of a file), the
block count may be wildly inaccurate.
  }
  LV.Size := LV.NumberBlocks;

  {
John M. Cassidy, CISSP, euroConex  noted in a private E-Mail that the blocksize
is 4096 bytes.

This will NOT be exact.  That's one reason why I don't use file sizes right from
a directory listing when writing FTP programs.
  }
  LV.Size := LV.NumberBlocks * 4096;

{
Otto Newman noted this, Stratus Technologies noted this:

Transmit sizes are shown in terms of bytes which are blocks * 4096.
}
  LV.SizeAvail := True;
  //date
  LBuf := TrimLeft(LBuf);
  LPart := Fetch(LBuf);
  if not IsYYYYMMDD(LPart) then begin
    Exit;
  end;
  LV.ModifiedDate := DateYYMMDD(LPart);
  //time
  LBuf := TrimLeft(LBuf);
  LPart := Fetch(LBuf);
  if not IsHHMMSS(LPart, ':') then begin {do not localize}
    Exit;
  end;
  LV.ModifiedDate := LV.ModifiedDate + TimeHHMMSS(LPart);
  {           From:

  Manual Name: VOS Reference Manual 

Part Number: R002

Revision Number: 01

Printing Date: April 1990

Stratus Computer, Inc.

55 Fairbanks Blvd.

Marlboro, Massachusetts 01752

© 1990 by Stratus Computer, Inc. All rights reserved.

A name is an ASCII character string that contains no more than 32 characters. The characters must be chosen from the following set of 81 characters:
the upper-case letters 
the lower-case letters 
the decimal digits 
the ASCII national use characters
//@ [ \ ] ^ ` { | close-bracket ~
" $ + , - . / : _
  }
  LBuf := TrimLeft(LBuf);
  LV.FileName := LBuf;
  Result := True;
  //item type can't be determined here, that has to be done in the main parsing procedure
end;

class function TIdFTPLPStratusVOS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
begin
  Result := False;
  case AItem.ItemType of
    DitFile         : Result := ParseFileEntry(AItem);
    DitDirectory    : Result := ParseDirEntry(AItem);
    ditSymbolicLink : Result := ParseLinkEntry(AItem);
  end;
end;

class function TIdFTPLPStratusVOS.ParseLinkEntry(const AItem: TIdFTPListItem): Boolean;
var
  LV : TIdStratusVOSFTPListItem;
  LBuf, LPart : String;
begin
  //04-07-13 21:15:43  backholding_logs ->  %descc#m2_d01>l3s>db>lti>in>cp_exception
  Result := False;
  LV := AItem as TIdStratusVOSFTPListItem;
  LBuf := AItem.Data;
  //date
  LPart := Fetch(LBuf);
  if not IsYYYYMMDD(LPart) then begin
    Exit;
  end;
  LV.ModifiedDate := DateYYMMDD(LPart);
  //time
  LBuf := TrimLeft(LBuf);

  LPart := Fetch(LBuf);
  if not IsHHMMSS(LPart, ':') then begin {do not localize}
    Exit;
  end;
  LV.ModifiedDate := LV.ModifiedDate + TimeHHMMSS(LPart);
  //name
  LBuf := TrimLeft(LBuf);
  LV.FileName := TrimRight(Fetch(LBuf, '->')); {do not localize}
  //link to
  LBuf := TrimLeft(LBuf);
  LV.LinkedItemName := Trim(LBuf);
  //size
  LV.SizeAvail := False;
  Result := True;
end;

class function TIdFTPLPStratusVOS.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems): Boolean;
var
  LDit : TIdDirItemType; //for tracking state
  LItem : TIdFTPListItem;
  i : Integer;
  LIsContinuedLine : Boolean;
  LLine, LPart, LBuf : String;
begin
  Result := False;
  LDit := ditFile;
  LIsContinuedLine := False;
  for i := 0 to AListing.Count -1 do
  begin
    LBuf := AListing[i];
    if LBuf <> '' then
    begin
      if IsFilesHeader(LBuf) then begin
        LDit := ditFile;
      end
      else if IsDirsHeader(LBuf) then begin
        LDit := ditDirectory;
      end
      else if IsLinksHeader(LBuf) then begin
        LDit := ditSymbolicLink;
      end
      else if LDit <> ditSymbolicLink then
      begin
        LItem := MakeNewItem(ADir);
        LItem.ItemType := LDit;
        LItem.Data := LBuf;
        if not ParseLine(LItem) then begin
          FreeAndNil(LItem);
          Exit;
        end;
      end
      else if not LIsContinuedLine then
      begin
        LLine := TrimRight(LBuf);
        if TextEndsWith(LLine, '->') then begin {do not localize}
          LIsContinuedLine := True;
        end else
        begin
          LItem := MakeNewItem(ADir);
          LItem.ItemType := LDit;
          LItem.Data := LLine;
          if not ParseLine(LItem) then begin
            FreeAndNil(LItem);
            Exit;
          end;
        end;
      end else
      begin
        LPart := LBuf;
        if TextStartsWith(LPart, '+') then begin
          IdDelete(LPart, 1, 1);
        end;
        LLine := LLine + LPart;
        LIsContinuedLine := False;
        if i < (AListing.Count-2) then
        begin
          if TextStartsWith(AListing[i+1], '+') then begin
            LIsContinuedLine := True;
          end else
          begin
            LItem := MakeNewItem(ADir);
            LItem.ItemType := LDit;
            LItem.Data := LLine;
            if not ParseLine(LItem) then begin
              FreeAndNil(LItem);
              Exit;
            end;
          end;
        end else
        begin
          LItem := MakeNewItem(ADir);
          LItem.ItemType := LDit;
          LItem.Data := LLine;
          if not ParseLine(LItem) then begin
            FreeAndNil(LItem);
            Exit;
          end;
        end;
      end;
    end;
  end;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPStratusVOS);
finalization
  UnRegisterFTPListParser(TIdFTPLPStratusVOS);

end.
