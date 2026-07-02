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
  Rev 1.7    10/26/2004 9:46:36 PM  JPMugaas
  Updated refs.

  Rev 1.6    6/8/2004 12:42:22 PM  JPMugaas
  Fixed an Invalid Type Cast problem.

  Rev 1.5    4/19/2004 5:05:36 PM  JPMugaas
  Class rework Kudzu wanted.

  Rev 1.4    2004.02.03 5:45:24 PM  czhower
  Name changes

    Rev 1.3    10/19/2003 3:36:02 PM  DSiders
  Added localization comments.

  Rev 1.2    4/7/2003 04:03:58 PM  JPMugaas
  User can now descover what output a parser may give.

  Rev 1.1    2/19/2003 05:53:20 PM  JPMugaas
  Minor restructures to remove duplicate code and save some work with some
  formats.  The Unix parser had a bug that caused it to give a False positive
  for Xercom MicroRTOS.

  Rev 1.0    2/19/2003 06:04:36 AM  JPMugaas
  IBM MVS parser has been ported to new design.
}

unit IdFTPListParseMVS;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes;

{
This should work with IBM MVS, OS/390, and z/OS.

Note that in z/OS, there is no need for a parser for the HFS (hierarchical file
system) because the server would present a Unix-like list for that file system.
}

type
  TIdJESJobStatus = (IdJESNotApplicable, IdJESReceived, IdJESHold, IdJESRunning, IdJESOuptutAvailable);

  TIdMVSFTPListItem = class(TIdRecFTPListItem)
  protected
    FBlockSize : Integer;
    FMigrated : Boolean;
    FVolume : String;
    FUnit : String;
    FOrg : String; //data set organization
    FMVSNumberExtents: Integer;
    FMVSNumberTracks: Integer;
  public
    constructor Create(AOwner: TCollection); override;
    property Migrated : Boolean read FMigrated write FMigrated;
    property BlockSize : Integer read FBlockSize write FBlockSize;
    property RecLength;
    property RecFormat;
    property NumberRecs;
    property Volume : String read FVolume write FVolume;
    //can't be unit because that's a reserved word
    property Units : String read FUnit write FUnit;
    property Org : String read FOrg write FOrg; //data set organization
    property NumberExtents: Integer read FMVSNumberExtents write FMVSNumberExtents;
    property NumberTracks: Integer read FMVSNumberTracks write FMVSNumberTracks;
  end;

  TIdMVSJESFTPListItem = class(TIdOwnerFTPListItem)
  protected
    FMVSJobStatus : TIdJESJobStatus;
    FMVSJobSpoolFiles : Integer;
  public
    constructor Create(AOwner: TCollection); override;
    property JobStatus : TIdJESJobStatus read FMVSJobStatus write FMVSJobStatus;
    property JobSpoolFiles : Integer read FMVSJobSpoolFiles write FMVSJobSpoolFiles;
  end;

  TIdMVSJESIntF2FTPListItem = class(TIdOwnerFTPListItem)
  protected
    FJobStatus : TIdJESJobStatus;
    FJobSpoolFiles : Integer;
    FDetails : TStrings;
    procedure SetDetails(AValue : TStrings);
  public
    constructor Create(AOwner: TCollection); override;
    destructor Destroy; override;
    property Details : TStrings read FDetails write SetDetails;
    property JobStatus : TIdJESJobStatus read FJobStatus write FJobStatus;
    property JobSpoolFiles : Integer read FJobSpoolFiles write FJobSpoolFiles;
  end;

  TIdFTPLPMVS = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

  TIdFTPLPMVSPartitionedDataSet = class(TIdFTPListBaseHeader)
  protected
    class function IsHeader(const AData: String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

  //Jes queues
  TIdFTPLPMVSJESInterface1 = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsMVS_JESNoJobsMsg(const AData: String): Boolean; virtual;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String = ''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TStrings; const ASysDescript : String = ''; const ADetails : Boolean = True): Boolean; override;
    class function ParseListing(AListing : TStrings; ADir : TIdFTPListItems) : Boolean; override;
  end;

  TIdFTPLPMVSJESInterface2 = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems) : TIdFTPListItem; override;
    class function IsMVS_JESIntF2Header(const AData: String): Boolean;
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
    {$HPPEMIT '#pragma link "IdFTPListParseMVS"'}
  {$ENDIF}

implementation

uses
  IdException,
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings, SysUtils;

{ TIdFTPLPMVS }

class function TIdFTPLPMVS.GetIdent: String;
begin
  Result := 'MVS';  {do not localize}
end;

class function TIdFTPLPMVS.IsHeader(const AData: String): Boolean;
//Volume Unit    Referred Ext Used Recfm Lrecl BlkSz Dsorg Dsname
//Volume Unit    Referred Ext Used Recfm Lrecl BlkSz Dsorg Dsname
//Volume Unit       Date  Ext Used Recfm Lrecl BlkSz Dsorg Dsname
var
  lvolp, lunp, lrefp, lextp, lusedp,
  lrecp, lBlkSz, lDsorg, lDsnp : Integer;
begin
  {Note that this one is a little more difficult because I could not find
  a MVS machine that accepts anonymous FTP.  So I have to do the best I can
  with some old posts where people had posted dir structures they got from FTP.}
  lvolp := IndyPos('Volume', AData);    {Do not translate}
  lunp := IndyPos('Unit', AData);       {Do not translate}
  lrefp := IndyPos('Referred', AData);  {Do not translate}
  if lrefp = 0 then begin
    lrefp := IndyPos('Date', AData);    {Do not translate}
  end;
  lextp := IndyPos('Ext', AData);       {Do not translate}
  lusedp := IndyPos('Used', AData);     {Do not translate}
  lrecp := IndyPos('Lrecl', AData);     {Do not translate}
  lBlkSz := IndyPos('BlkSz', AData);    {Do not translate}
  lDsorg := IndyPos('Dsorg', AData);    {Do not translate}
  lDsnp := IndyPos('Dsname', AData);    {Do not translate}
  Result := (lvolp <> 0) and (lunp > lvolp) and
            (lrefp > lunp) and (lextp > lrefp) and
            (lusedp > lextp) and (lrecp > lusedp) and
            (lBlkSz > lrecp) and (lDsorg > lBlkSz) and
            (lDsnp > lDsorg);
end;

class function TIdFTPLPMVS.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result :=  TIdMVSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPMVS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
{Much of this is based on a thread at:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&selm=DLspv2.G2w%40epsilon.com&rnum=2

and

http://www.snee.com/bob/opsys/part6mvs.pdf

Note:  Thread concerning MVS Data Set Size
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=jcmorris.767551300%40mwunix&rnum=15&prev=/groups%3Fq%3DMVS%2BRecfm%2BV%26start%3D10%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26selm%3Djcmorris.767551300%2540mwunix%26rnum%3D15
http://groups.google.com/groups?q=MVS+Recfm+V&start=10&hl=en&lr=&ie=UTF-8&oe=utf-8&selm=jcmorris.767551300%40mwunix&rnum=15

http://www.isc.ucsb.edu/tsg/ftp-to-mvs.html
http://www.lsu.edu/ocs/tsc/os390doc/mvsftp.html
}

  function IsMVSMigrated(const AData : String) : Boolean;
  begin
    Result := TextStartsWith(AData, 'Migrated') or TextStartsWith(AData, 'MIGRAT');  {do not localize}
  end;

  function IsPseudoDir(const AData : String) : Boolean;
  begin
    //In newer implementations, a directory mode is available, see if
    //item is a Pseudo-directory
    Result := TextStartsWith(AData, 'Pseudo Directory');  {do not localize}
  end;

  function CanGetAttributes(const AData : String) : Boolean;
  begin
    Result := (not IsMVSMigrated(AData)) and (not IsPseudoDir(AData)) and
      (not TextStartsWith(AData, 'Error'));  {do not localize}
  end;

var
  i : Integer;
  s : TStrings;
  LI : TIdMVSFTPListItem;
begin
  //NOTE:  File Size is not supported at all
  //because the file size is calculated with something like this:
  //      BlkSz * Blks/Trk * Trks
  //but you can not get MVS DEVINFO macro so you do not have enough information
  //to work with.
  AItem.ModifiedAvail := False;
  AItem.SizeAvail := False;
  LI := AItem as TIdMVSFTPListItem;
  if IsMVSMigrated(AItem.Data) then begin
    LI.Migrated := True;
  end;
  if IsPseudoDir(AItem.Data) then begin
    LI.ItemType :=  ditDirectory;
  end;
  if CanGetAttributes(AItem.Data) then
  begin
    s := TStringList.Create;
    try
      SplitDelimitedString(AItem.Data, s, True);
      if s.Count > 0 then begin
        LI.Volume := s[0];
      end;
      if s.Count > 1 then begin
        LI.Units := s[1];
      end;
      if s.Count > 2 then
      begin
        //Sometimes, the Referred Column will contain a date.
        //e.g. **NONE**
        //Documented in: Communications Server for z/OS V1R2 TCP/IP Implementation Guide Volume 2: UNIX Applications
        //URL: http://www.redbooks.ibm.com/pubs/pdfs/redbooks/sg245228.pdf
        if IsNumeric(s[2], 1, 1) then
        begin
          // If the number of extents is greater than 99 it can run into the date column:
          // SM6009 3380   2010/03/09123 2415  U    18432 18432  PO  LOADLIB 
          if Length(s[2]) > 10 then begin
            s.Insert(3, Copy(S[2], 11, MaxInt));
            s[2] := Copy(S[2], 1, 10);
          end;
          LI.ModifiedDate := MVSDate(s[2]);
          LI.ModifiedAvail := True;
        end;
      end;
      if s.Count > 3 then begin
        LI.NumberExtents := IndyStrToInt(s[3], 0);
      end;
      if s.Count >4 then begin
        LI.NumberTracks := IndyStrToInt(s[4], 0);
      end;
      if s.Count > 5 then begin
        LI.RecFormat := s[5];
      end;
      if s.Count >6 then begin
        LI.RecLength := IndyStrToInt(s[6], 0);
      end;
      if s.Count > 7 then begin
        LI.BlockSize := IndyStrToInt(s[7], 0);
      end;
      if s.Count > 8 then
      begin
        LI.Org := s[8];
        // TODO: use PosInStrArray() instead?
        if (LI.Org = 'PO') or (LI.Org = 'PO-E') then begin {do not localize}
          LI.ItemType :=  ditDirectory;
        end else begin
          LI.ItemType :=  ditFile;
        end;
      end;
    finally
      FreeAndNil(s);
    end;
  end;
  //Note that spaces are illegal in MVS file names (Data set names)
  //http://www.snee.com/bob/opsys/part6mvs.pdf
  //but for filenames enclosed in '', we should tolerate spaces.
  if (AItem.Data <> '') and (TextEndsWith(AItem.Data, '''')) then
  begin
    i := IndyPos('''', AItem.Data)+1;
    AItem.FileName := Copy(AItem.Data, i, Length(AItem.Data)-i-1);
  end else
  begin
    i := RPos(' ', AItem.Data)+1;
    AItem.FileName := Copy(AItem.Data, i, MaxInt);
  end;
  Result := True;
end;

{ TIdFTPLPMVSPartitionedDataSet }

class function TIdFTPLPMVSPartitionedDataSet.GetIdent: String;
begin
  Result := 'MVS:  Partitioned Data Set'; {do not localize}
end;

class function TIdFTPLPMVSPartitionedDataSet.IsHeader( const AData: String): Boolean;
var
  LPName, LPSize : Integer;
begin
  //Name     VV.MM  Created     Changed     Size  Init   Mod   Id
  //
  //or
  //
  //Name      Size   TTR   Alias-of AC --------- Attributes --------- Amode Rmode
  //if there are loaded moduals
  LPName := IndyPos('Name', AData); {do not localize}
  LPSize := IndyPos('Size', AData); {do not localize}
  Result := (LPName > 0) and (LPSize > LPName);
end;

class function TIdFTPLPMVSPartitionedDataSet.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  s : TStrings;
//MVS Particianed data sets must be treated differently than
//the regular MVS catalog.

//NOTE:  File Size is not supported at all.  Size is usually size in records, not bytes
//  This is based on stuff at:
// http://publibz.boulder.ibm.com:80/cgi-bin/bookmgr_OS390/BOOKS/F1AA2032/1.5.15?SHELF=&DT=20001127174124
// and
// http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&selm=DLspv2.G2w%40epsilon.com&rnum=2

//From Google: http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&threadm=4e7k0p%24t1v%40blackice.winternet.com&rnum=6&prev=/groups%3Fq%3DMVS%2BPartitioned%2Bdata%2Bset%2Bdirectory%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3DUTF-8%26selm%3D4e7k0p%2524t1v%2540blackice.winternet.com%26rnum%3D6

{
From: Ralph Goers (rgoer@rgoer.candle.com)
Subject: Re: FTP -- VM, MVS, VMS Questions 

 	
View this article only	
Newsgroups: comp.os.os2.networking.tcp-ip
Date: 1996/01/27 
	

In message <4e7k0p$t1v@blackice.winternet.com> - frickson@gibbon.com (John C. F
rickson) writes:
:>
:>MVS directory lines look like this:
:>
:>Volume Unit  Referred Ext Used Recfm Lrecl BlkSz Dsorg Dsname
:>OVH025 3380   12/29/95  1   60  FB      80 23200  PO  MICSFILE.CLIST
:>USS018 3380   12/18/95  1   15  VB     259  8000  PS  NFS.DOC
:>Migrated                                              OAQPS.INTERIM.CNTYIM.V1.DATA.D052093
:>AIR030 3380   12/13/95  1   18  FB      80  3600  PS  OAQPS.INTERIM.PLNTNAME.DATA
:>
:>1) Ext is number of extents? Yes.
:>2) Used is number of tracks? Yes
:>3) Is the volume name important or can I ignore it?
It is important only if it is MIGRAT or migrated. This indicates that the 
dataset has not been accessed recently and has been migrated to an HSM 
volume (DASD or tape).
:>4) Is there any way to calculate filesizes?  I think I would have to know
:>   the capacity of the device (i.e. BlkSz * Blks/Trk * Trks)
I'm not sure this would do you any good. Just because you know how many bytes 
are in a track doesn't mean that each track is full. In the case of an FB 
file you can figure out how many blocks will fit in a track.  This may not be 
true of V type files.
:>5) Dsorg -- PO seems to equate to partioned data set.  Is that always true?
:>   Are any values other than PO and PS possible?
Yes - you can also have VS files (VSAM) - however I have no idea why anyone 
would try to FTP one.
:>6) What is "Migrated"?  Moved to tape?  Is the file still available for
:>   download, or should I simply ignore these lines?
If you reference the file it will automatically be brought back to a DASD 
volume.
:>7) After loggin in, the server reports the current directory as "PA2",
:>   but in response to a "PWD" command, it says "PUBLIC.". ??? Not sure about this. Usually, it defaults to "USERID.".
:>8) Is the "CD" command useful for anything other than getting into
:>   partitioned data sets?
Sure. If you have a bunch of sequential datasets starting with A.B then 
cd'ing to that and then doing MGET * should download all the sequential files.
PDSes should not be downloaded but should be treated as a subdirectory.
:>9) After CD'ing into a PDS, a directory looks like this:
:>    Name     VV.MM  Created     Changed     Size  Init   Mod   Id
:>   $README   01.10 89/04/19 94/12/15 18:55    90     1     0 EWZ
:>   What are the Size, Init, Mod and ID fields?
:>   Is VV.MM version information?
:>
Size is the number of records in the file. init is the number of lines that 
were in the file when statistics were first set and mod is the number of 
lines modified since then. VV.MM is a version and modification level. These 
SPF statistics can be reset by going into edit on the member and typing STATS 
OFF, SAVE, STATS ON, SAVE. They can also be reset via option 3.5 - Member 
statistics panel.  Some programs also modify them for their own use.

You should count on these statistics even being present.  They are created 
only by SPF. Other programs use the same area in the directory entry for 
their own purposes. When you link a load module, for example, information 
about it is stored there.  When you FTP files up to MVS FTP will not create 
statistics for PDS members. 

Hope this is helpful.

Ralph
}
begin
  AItem.ModifiedAvail := False;
  AItem.SizeAvail := False;
  s := TStringList.Create;
  try
    SplitDelimitedString(AItem.Data, s, True);
    if s.Count > 0 then
    begin
      AItem.FileName := s[0];
      //in some particianed data sets, dates are missing.
      if (s.Count > 7) and (s[3] <> '') and IsNumeric(s[3], 1, 1) and (IndyPos('/', s[3]) > 0) then
      begin
        AItem.ModifiedDate := MVSDate(s[3]);
        {    Name     VV.MM  Created     Changed     Size  Init   Mod   Id}
        { $README   01.10 89/04/19 94/12/15 18:55    90     1     0 EWZ }
        if s.Count > 4 then
        begin
          AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(s[4]);
          AItem.ModifiedAvail := True;
        end;
      end;
    end;
  finally
    FreeAndNil(s);
  end;
  Result := True;
end;

{ TIdFTPLPMVSJESInterface1 }

class function TIdFTPLPMVSJESInterface1.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
var
  s : TStrings;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    s := TStringList.Create;
    try
      SplitDelimitedString(AListing[0], s, True);
      Result := (s.Count > 2) and (PosInStrArray(Trim(s[2]), MVS_JES_Status) > -1);
      if Result and (s.Count > 3) then begin
        Result := IsNumeric(s[3]) or CharEquals(s[3], 1, '-');
      end;
      if not Result then begin
        Result := IsMVS_JESNoJobsMsg(AListing[0]);
      end;
    finally
      FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPMVSJESInterface1.GetIdent: String;
begin
  Result := 'MVS:  JES Queue Interface 1';  {do not localize}
end;

class function TIdFTPLPMVSJESInterface1.IsMVS_JESNoJobsMsg(const AData: String): Boolean;
begin
  Result := (AData = 'No jobs found on JES queue'); {do not localize}
end;

class function TIdFTPLPMVSJESInterface1.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdMVSJESFTPListItem.Create(AOwner);
end;

class function TIdFTPLPMVSJESInterface1.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf : String;
  LI : TIdMVSJESFTPListItem;
begin
  {
  ALFREDCA  JOB03192  OUTPUT    3 Spool Files
  ALFREDCA  JOB03193  OUTPUT    0 Spool Files
  ALFREDCA  JOB03194  INPUT
  12345678901234567890123456789012345678901234567890
           1         2         3         4         5
  #From: IBM Communications Server for OS/390 V2R10 TCP/IP Implementation Guide Volume 2: UNIX Applications
  #Obtained at: http://www.redbooks.ibm.com/pubs/pdfs/redbooks/sg245228.pdf
  }
  AItem.ModifiedAvail := False;
  AItem.SizeAvail := False;
  LI := AItem as TIdMVSJESFTPListItem;
  //owner
  LBuf := AItem.Data;
  LI.OwnerName := Fetch(LBuf);
  LBuf := TrimLeft(LBuf);
  //filename
  LI.FileName := Fetch(LBuf);
  LBuf := TrimLeft(LBuf);
  case PosInStrArray(Fetch(LBuf), MVS_JES_Status) of
    0 : LI.JobStatus := IdJESReceived;        // 'INPUT'  job received but not run yet
    1 : LI.JobStatus := IdJESHold;            // 'HELD'   job is in hold status
    2 : LI.JobStatus := IdJESRunning;         // 'ACTIVE' job is running
    3 : LI.JobStatus := IdJESOuptutAvailable; // 'OUTPUT' job has finished and has output available
  end;
  //spool file output if available
  LBuf := TrimLeft(LBuf);
  LI.JobSpoolFiles := IndyStrToInt(Fetch(LBuf), 0);
  Result := True;
end;

class function TIdFTPLPMVSJESInterface1.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems): Boolean;
var
  LItem : TIdFTPListItem;
  i : Integer;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    if not IsMVS_JESNoJobsMsg(Alisting[0]) then
    begin
      for i := 0 to AListing.Count -1 do
      begin
        LItem := MakeNewItem(ADir);
        LItem.Data := AListing[i];
        ParseLine(LItem);
      end;
    end else
    begin
      Result := True;
    end;
  end;
end;

{ TIdFTPLPMVSJESInterface2 }

class function TIdFTPLPMVSJESInterface2.CheckListing(AListing: TStrings;
  const ASysDescript: String; const ADetails: Boolean): Boolean;
begin
  Result := False;
  if AListing.Count > 0 then begin
    Result := IsMVS_JESIntF2Header(AListing[0]);
  end;
end;

class function TIdFTPLPMVSJESInterface2.GetIdent: String;
begin
  Result := 'MVS:  JES Queue Interface 2';  {do not localize}
end;

class function TIdFTPLPMVSJESInterface2.IsMVS_JESIntF2Header(const AData: String): Boolean;
begin
  Result := (AData = 'JOBNAME  JOBID    OWNER    STATUS CLASS');  {do not localize}
end;

class function TIdFTPLPMVSJESInterface2.MakeNewItem(AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdMVSJESIntF2FTPListItem.Create(AOwner);
end;

class function TIdFTPLPMVSJESInterface2.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf, LNo : String;
  LPos, LPos2 : Integer;
  LI : TIdMVSJESIntF2FTPListItem;
begin
  {
  JOBNAME  JOBID    OWNER    STATUS CLASS
  BPXAS    STC02133 ++++++++ OUTPUT STC      RC=000 2 spool
  BPXAS    STC00916 ++++++++ OUTPUT STC      RC=000 2 spool
  BPXAS    STC02132 ++++++++ ACTIVE STC
  BPXAS    STC02131 ++++++++ ACTIVE STC
  123456789012345678901234567890123456789012345678901234567890
           1         2         3         4         5         6
  }
  LI := AItem as TIdMVSJESIntF2FTPListItem;
  LI.ModifiedAvail := False;
  LI.SizeAvail := False;
  LI.FileName := Trim(Copy(AItem.Data, 10, 8));
  LI.OwnerName := Trim(Copy(AItem.Data, 19, 7));
  if IsLineStr(LI.OwnerName) then begin
    LI.OwnerName := '';
  end;
  case PosInStrArray(Trim(Copy(AItem.Data, 28, 7)), MVS_JES_Status) of
    0 : LI.JobStatus := IdJESReceived;          // 'INPUT'   job received but not run yet
    1 : LI.JobStatus := IdJESHold;              // 'HELD'    job is in hold status
    2 : LI.JobStatus := IdJESRunning;           // 'ACTIVE'  job is running
    3 : LI.JobStatus := IdJESOuptutAvailable;   // 'OUTPUT'  job has finished and has output available
  end;
  LBuf := Trim(Copy(AItem.Data, 35, MaxInt));
  LPos := IndyPos(' spool', LBuf); {do not localize}
  if LPos = 0 then
  begin
    Result := False;
    Exit;
  end;
  LNo := '';
  for LPos2 := LPos-1 downto 1 do
  begin
    if LBuf[LPos2] = ' ' then begin
      Break;
    end;
    LNo := LBuf[LPos2] + LNo;
  end;
  LI.JobSpoolFiles := IndyStrToInt(LNo, 0);
  Result := True;
end;

class function TIdFTPLPMVSJESInterface2.ParseListing(AListing: TStrings;
  ADir: TIdFTPListItems): Boolean;
var
  LItem : TIdFTPListItem;
  i : Integer;
  LStartLine : Integer;
  LDetailFlag : Boolean;
  LI : TIdMVSJESIntF2FTPListItem;
begin
  Result := False;
  if AListing.Count > 0 then
  begin
    if IsMVS_JESIntf2Header(AListing[0]) then begin
      LStartLine := 1;
    end else begin
      LStartLine := 0;
    end;
    LDetailFlag := False;
    for i := LStartLine to AListing.Count-1 do
    begin
      if LDetailFlag then
      begin
        if ADir.Count > 0 then
        begin
          LI := ADir.Items[ADir.Count-1] as TIdMVSJESIntF2FTPListItem;
          LI.Details.Add(AListing[i]);
        end;
      end
      else if AListing[i] = '--------' then begin
        LDetailFlag := True;
      end else
      begin
        LItem := MakeNewItem(ADir);
        LItem.Data := AListing[i];
        ParseLine(LItem);
      end;
    end;
    Result := True;
  end;
end;

{ TIdMVSFTPListItem }

constructor TIdMVSFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FSizeAvail := False;  //we can't get the file size from a MVS system
end;

{ TIdMVSJESIntFFTPListItem }

constructor TIdMVSJESIntF2FTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FDetails := TStringList.Create;
end;

destructor TIdMVSJESIntF2FTPListItem.Destroy;
begin
  FreeAndNil(FDetails);
  inherited Destroy;
end;

procedure TIdMVSJESIntF2FTPListItem.SetDetails(AValue: TStrings);
begin
  FDetails.Assign(AValue);
end;

{ TIdMVSJESFTPListItem }

constructor TIdMVSJESFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  JobStatus := IdJESNotApplicable;
end;

initialization
  RegisterFTPListParser(TIdFTPLPMVS);
  RegisterFTPListParser(TIdFTPLPMVSPartitionedDataSet);
  RegisterFTPListParser(TIdFTPLPMVSJESInterface1);
  RegisterFTPListParser(TIdFTPLPMVSJESInterface2);
finalization
  UnRegisterFTPListParser(TIdFTPLPMVS);
  UnRegisterFTPListParser(TIdFTPLPMVSPartitionedDataSet);
  UnRegisterFTPListParser(TIdFTPLPMVSJESInterface1);
  UnRegisterFTPListParser(TIdFTPLPMVSJESInterface2);

end.
