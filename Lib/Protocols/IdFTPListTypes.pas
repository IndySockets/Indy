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
  Rev 1.6    3/23/2005 4:52:28 AM  JPMugaas
  Expansion with MLSD and WIN32.ea fact in MLSD directories as described by:

  http://www.raidenftpd.com/kb/kb000000049.htm

  This returns Win32 file attributes including some that Borland does not
  support.

  Rev 1.5    12/8/2004 8:35:18 AM  JPMugaas
  Minor class restructure to support Unisys ClearPath.

  Rev 1.4    11/29/2004 2:45:30 AM  JPMugaas
  Support for DOS attributes (Read-Only, Archive, System, and Hidden) for use
  by the Distinct32, OS/2, and Chameleon FTP list parsers.

  Rev 1.3    10/26/2004 9:27:34 PM  JPMugaas
  Updated references.

  Rev 1.2    6/27/2004 1:45:36 AM  JPMugaas
  Can now optionally support LastAccessTime like Smartftp's FTP Server could.
  I also made the MLST listing object and parser support this as well.

  Rev 1.1    6/4/2004 2:11:00 PM  JPMugaas
  Added an indexed read-only Facts property to the MLST List Item so you can
  get information that we didn't parse elsewhere.  MLST is extremely flexible.

  Rev 1.0    4/20/2004 2:43:20 AM  JPMugaas
  Abstract FTPList objects for reuse.
}

unit IdFTPListTypes;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdFTPList;

type
  { For FTP servers using OS/2 and other MS-DOS-like file systems that report file attributes }
  TIdDOSAttributes = class(TPersistent)
  protected
    FFileAttributes: UInt32;
    function GetRead_Only: Boolean;
    procedure SetRead_Only(const AValue: Boolean);
    function GetHidden: Boolean;
    procedure SetHidden(const AValue: Boolean);
    function GetSystem: Boolean;
    procedure SetSystem(const AValue: Boolean);
    function GetArchive: Boolean;
    procedure SetArchive(const AValue: Boolean);
    function GetDirectory: Boolean;
    procedure SetDirectory(const AValue: Boolean);
    function GetNormal: Boolean;
    procedure SetNormal(const AValue: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    function GetAsString: String; virtual;
    function AddAttribute(const AString : String) : Boolean;
  published
    property FileAttributes : UInt32 read FFileAttributes write FFileAttributes;
    property AsString : String read GetAsString;
    // can't be ReadOnly because that's a reserved word
    property Read_Only : Boolean read GetRead_Only write SetRead_Only;
    property Archive : Boolean read GetArchive write SetArchive;
    property System : Boolean read GetSystem write SetSystem;
    property Directory : Boolean read GetDirectory write SetDirectory;
    property Hidden : Boolean read GetHidden write SetHidden;
    property Normal : Boolean read GetNormal write SetNormal;
  end;

  { Win32 Extended Attributes as in WIN32_FIND_DATA data structure in the Windows API.
    Analagous to the System.IO.FileAttributes enumeration in .Net }
  TIdWin32ea = class(TIdDOSAttributes)
  protected
    function GetDevice: Boolean;
    procedure SetDevice(const AValue: Boolean);
    function GetTemporary: Boolean;
    procedure SetTemporary(const AValue: Boolean);
    function GetSparseFile: Boolean;
    procedure SetSparseFile(const AValue: Boolean);
    // this is also called a junction and it works like a Unix Symbolic link to a dir
    function GetReparsePoint: Boolean;
    procedure SetReparsePoint(const AValue: Boolean);
    function GetCompressed: Boolean;
    procedure SetCompressed(const AValue: Boolean);
    function GetOffline: Boolean;
    procedure SetOffline(const AValue: Boolean);
    function GetNotContextIndexed: Boolean;
    procedure SetNotContextIndexed(const AValue: Boolean);
    function GetEncrypted: Boolean;
    procedure SetEncrypted(const AValue: Boolean);
  public
    function GetAsString: String; override;
  published
    property Device : Boolean read GetDevice write SetDevice;
    property Temporary : Boolean read GetTemporary write SetTemporary;
    property SparseFile : Boolean read GetSparseFile write SetSparseFile;
    property ReparsePoint : Boolean read GetReparsePoint write SetReparsePoint;
    property Compressed : Boolean read GetCompressed write SetCompressed;
    property Offline : Boolean read GetOffline write SetOffline;
    property NotContextIndexed : Boolean read GetNotContextIndexed write SetNotContextIndexed;
    property Encrypted : Boolean read GetEncrypted write SetEncrypted;
  end;

  //For NLST and Cisco IOS
  TIdMinimalFTPListItem = class(TIdFTPListItem)
  public
    constructor Create(AOwner: TCollection); override;
  end;

  //This is for some mainframe items which are based on records
  TIdRecFTPListItem = class(TIdFTPListItem)
  protected
    //These are for VM/CMS which uses a record type of file system
    FRecLength : Integer;
    FRecFormat : String;
    FNumberRecs : Integer;
    property RecLength : Integer read FRecLength write FRecLength;
    property RecFormat : String read FRecFormat write FRecFormat;
    property NumberRecs : Integer read FNumberRecs write FNumberRecs;
  end;

  { listing formats that include Creation timestamp information }
  TIdCreationDateFTPListItem = class(TIdFTPListItem)
  protected
    FCreationDate: TDateTime;
  public
    constructor Create(AOwner: TCollection); override;
    property CreationDate: TDateTime read FCreationDate write FCreationDate;

  end;

  // for MLST, MLSD listing outputs
  TIdMLSTFTPListItem = class(TIdCreationDateFTPListItem)
  protected
    FAttributesAvail : Boolean;
    FAttributes :  TIdWin32ea;
    FCreationDateGMT : TDateTime;
    FLastAccessDate: TDateTime;
    FLastAccessDateGMT : TDateTime;
    FLinkedItemName : String;
    //Unique ID for an item to prevent yourself from downloading something twice
    FUniqueID : String;
    //MLIST things
    FMLISTPermissions : String;
    function GetFact(const AName : String) : String;
  public
    constructor Create(AOwner: TCollection); override;
    destructor Destroy; override;
    //Creation time values are for MLSD data output and can be returned by the
    //the MLSD parser in some cases
    property ModifiedDateGMT;
    property CreationDateGMT : TDateTime read FCreationDateGMT write FCreationDateGMT;

    property LastAccessDate: TDateTime read FLastAccessDate write FLastAccessDate;
    property LastAccessDateGMT : TDateTime read FLastAccessDateGMT write FLastAccessDateGMT;

    //Valid only with EPLF and MLST
    property UniqueID : string read FUniqueID write FUniqueID;
    //MLIST Permissions
    property MLISTPermissions : string read FMLISTPermissions write FMLISTPermissions;
    property Facts[const Name: string] : string read GetFact;
    property AttributesAvail : Boolean read FAttributesAvail write FAttributesAvail;
    property Attributes :  TIdWin32ea read FAttributes;
    property LinkedItemName : String read FLinkedItemName write FLinkedItemName;
  end;

  //for some parsers that output an owner sometimes
  TIdOwnerFTPListItem = class(TIdFTPListItem)
  protected
    FOwnerName : String;
  public
    property OwnerName : String read FOwnerName write FOwnerName;
  end;

  { This class type is used by Novell Netware, Novell Print Services for
    Unix with DOS namespace, and HellSoft FTPD for Novell Netware }
  TIdNovellBaseFTPListItem = class(TIdOwnerFTPListItem)
  protected
    FNovellPermissions : String;
  public
    property NovellPermissions : string read FNovellPermissions write FNovellPermissions;
  end;

  //Bull GCOS 8 uses this and Unix will use a descendent
  TIdUnixPermFTPListItem = class(TIdOwnerFTPListItem)
  protected
    FUnixGroupPermissions: string;
    FUnixOwnerPermissions: string;
    FUnixOtherPermissions: string;
  public
    property UnixOwnerPermissions: string read FUnixOwnerPermissions write FUnixOwnerPermissions;
    property UnixGroupPermissions: string read FUnixGroupPermissions write FUnixGroupPermissions;
    property UnixOtherPermissions: string read FUnixOtherPermissions write FUnixOtherPermissions;
  end;

  // Unix and Novell Netware Print Services for Unix with NFS namespace need to use this
  TIdUnixBaseFTPListItem = class(TIdUnixPermFTPListItem)
  protected
    FLinkCount: Integer;
    FGroupName: string;
    FLinkedItemName : string;
  public
    property LinkCount: Integer read FLinkCount write FLinkCount;
    property GroupName: string read FGroupName write FGroupName;
    property LinkedItemName : string read FLinkedItemName write FLinkedItemName;
  end;

  TIdDOSBaseFTPListItem = class(TIdFTPListItem)
  protected
    FAttributes : TIdDOSAttributes;
    procedure SetAttributes(AAttributes : TIdDOSAttributes);
  public
    constructor Create(AOwner: TCollection); override;
    destructor Destroy; override;
    property Attributes : TIdDOSAttributes read FAttributes write SetAttributes;
  end;

{These are needed for interpretting Win32.ea in some MLSD output}
const
  IdFILE_ATTRIBUTE_READONLY             = $00000001;
  IdFILE_ATTRIBUTE_HIDDEN               = $00000002;
  IdFILE_ATTRIBUTE_SYSTEM               = $00000004;
  IdFILE_ATTRIBUTE_DIRECTORY            = $00000010;
  IdFILE_ATTRIBUTE_ARCHIVE              = $00000020;
  IdFILE_ATTRIBUTE_DEVICE               = $00000040;
  IdFILE_ATTRIBUTE_NORMAL               = $00000080;
  IdFILE_ATTRIBUTE_TEMPORARY            = $00000100;
  IdFILE_ATTRIBUTE_SPARSE_FILE          = $00000200;
  IdFILE_ATTRIBUTE_REPARSE_POINT        = $00000400;
  IdFILE_ATTRIBUTE_COMPRESSED           = $00000800;
  IdFILE_ATTRIBUTE_OFFLINE              = $00001000;
  IdFILE_ATTRIBUTE_NOT_CONTENT_INDEXED  = $00002000;
  IdFILE_ATTRIBUTE_ENCRYPTED            = $00004000;

implementation

uses
  IdException,
  IdFTPCommon, SysUtils;

{ TIdMinimalFTPListItem }

constructor TIdMinimalFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FSizeAvail := False;
  FModifiedAvail := False;
end;

{ TIdMLSTFTPListItem }

constructor TIdMLSTFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FAttributesAvail := False;
  FAttributes :=  TIdWin32ea.Create;
end;

destructor TIdMLSTFTPListItem.Destroy;
begin
  FreeAndNil(FAttributes);
  inherited Destroy;
end;

function TIdMLSTFTPListItem.GetFact(const AName: String): String;
var
  LFacts : TStrings;
begin
  LFacts := TStringList.Create;
  try
    ParseFacts(Data, LFacts);
    Result := LFacts.Values[AName];
  finally
    FreeAndNil(LFacts);
  end;
end;

{ TIdDOSBaseFTPListItem }

constructor TIdDOSBaseFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FAttributes := TIdDOSAttributes.Create;
end;

destructor TIdDOSBaseFTPListItem.Destroy;
begin
  FreeAndNil(FAttributes);
  inherited Destroy;
end;

procedure TIdDOSBaseFTPListItem.SetAttributes(
  AAttributes: TIdDOSAttributes);
begin
  FAttributes.Assign(AAttributes);
end;

{ TIdDOSAttributes }

function TIdDOSAttributes.AddAttribute(const AString: String): Boolean;
var
  i : Integer;
  S: String;
begin
  S := UpperCase(AString);
  for i := 1 to Length(S) do begin
    case CharPosInSet(S, i, 'RASHW-D') of
      //R
      1 : Read_Only := True;
      //A
      2 : Archive := True;
      //S
      3 : System := True;
      //H
      4 : Hidden := True;
      //W - W was added only for Distinct32's FTP server which reports 'w' if you
      //write instead of a r for read-only
      5 : Read_Only := False;
      6,7 : ;//for the "-" and "d" that Distinct32 may give
    else
      begin
        Result := False; //failure
        Exit;
      end;
    end;
  end;
  Result := True;
end;

procedure TIdDOSAttributes.Assign(Source: TPersistent);
begin
  if Source is TIdDOSAttributes then begin
    FFileAttributes := (Source as TIdDOSAttributes).FFileAttributes;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIdDOSAttributes.GetAsString: String;
//This is just a handy thing for some programs to try
//to output attribute bits similarly to the DOS
//ATTRIB command
//
//which is like this:
//
//     R     C:\File
//A  SH      C:\File
{$IFDEF STRING_IS_IMMUTABLE}
var
  LSB: TIdStringBuilder;
{$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create('      ');
  {$ELSE}
  Result := '      ';
  {$ENDIF}
  if Archive then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[0]{$ELSE}Result[1]{$ENDIF} := 'A'; {do not localize}
  end;
  if System then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[3]{$ELSE}Result[4]{$ENDIF} := 'S'; {do not localize}
  end;
  if Hidden then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[4]{$ELSE}Result[5]{$ENDIF} := 'H'; {do not localize}
  end;
  if Read_Only then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[5]{$ELSE}Result[6]{$ENDIF} := 'R'; {do not localize}
  end;
  {$IFDEF STRING_IS_IMMUTABLE}
  Result := LSB.ToString;
  {$ENDIF}
end;

function TIdDOSAttributes.GetRead_Only: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_READONLY) > 0;
end;

function TIdDOSAttributes.GetHidden: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_HIDDEN) > 0;
end;

function TIdDOSAttributes.GetSystem: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_SYSTEM) > 0;
end;

function TIdDOSAttributes.GetDirectory: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_DIRECTORY) > 0;
end;

function TIdDOSAttributes.GetArchive: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_ARCHIVE) > 0;
end;

function TIdDOSAttributes.GetNormal: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_NORMAL) > 0;
end;

procedure TIdDOSAttributes.SetRead_Only(const AValue: Boolean);
begin
  if AValue then begin
     FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_READONLY;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_READONLY);
  end;
end;

procedure TIdDOSAttributes.SetHidden(const AValue: Boolean);
begin
  if AValue then begin
     FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_HIDDEN;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_HIDDEN);
  end;
end;

procedure TIdDOSAttributes.SetSystem(const AValue: Boolean);
begin
  if AValue then begin
     FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_SYSTEM;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_SYSTEM);
  end;
end;

procedure TIdDOSAttributes.SetDirectory(const AValue: Boolean);
begin
  if AValue then begin
     FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_DIRECTORY;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_DIRECTORY);
  end;
end;

procedure TIdDOSAttributes.SetArchive(const AValue: Boolean);
begin
  if AValue then begin
     FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_ARCHIVE;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_ARCHIVE);
  end;
end;

procedure TIdDOSAttributes.SetNormal(const AValue: Boolean);
begin
  if AValue then begin
     FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_NORMAL;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_NORMAL);
  end;
end;

{ TIdCreationDateFTPListItem }

constructor TIdCreationDateFTPListItem.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  SizeAvail := False;
  ModifiedAvail := False;
end;

{ TIdWin32ea }

function TIdWin32ea.GetDevice: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_DEVICE) > 0;
end;

function TIdWin32ea.GetTemporary: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_TEMPORARY) > 0;
end;

function TIdWin32ea.GetSparseFile: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_SPARSE_FILE) > 0;
end;

function TIdWin32ea.GetReparsePoint: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_REPARSE_POINT) > 0;
end;

function TIdWin32ea.GetCompressed: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_COMPRESSED) > 0;
end;

function TIdWin32ea.GetOffline: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_OFFLINE) > 0;
end;

function TIdWin32ea.GetNotContextIndexed: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_NOT_CONTENT_INDEXED) > 0;
end;

function TIdWin32ea.GetEncrypted: Boolean;
begin
  Result := (FFileAttributes and IdFILE_ATTRIBUTE_ENCRYPTED) > 0;
end;

procedure TIdWin32ea.SetDevice(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_DEVICE;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_DEVICE);
  end;
end;

procedure TIdWin32ea.SetTemporary(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_TEMPORARY;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_TEMPORARY);
  end;
end;

procedure TIdWin32ea.SetSparseFile(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_SPARSE_FILE;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_SPARSE_FILE);
  end;
end;

procedure TIdWin32ea.SetReparsePoint(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_NORMAL;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_NORMAL);
  end;
end;

procedure TIdWin32ea.SetCompressed(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_NORMAL;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_NORMAL);
  end;
end;

procedure TIdWin32ea.SetOffline(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_OFFLINE;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_OFFLINE);
  end;
end;

procedure TIdWin32ea.SetNotContextIndexed(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_NOT_CONTENT_INDEXED;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_NOT_CONTENT_INDEXED);
  end;
end;

procedure TIdWin32ea.SetEncrypted(const AValue: Boolean);
begin
  if AValue then begin
    FFileAttributes := FFileAttributes or IdFILE_ATTRIBUTE_ENCRYPTED;
  end else begin
    FFileAttributes := FFileAttributes and (not IdFILE_ATTRIBUTE_ENCRYPTED);
  end;
end;

function TIdWin32ea.GetAsString: String;
//we'll do this similarly to 4NT
//which renders the bits like this order:
//RHSADENTJPCOI
{$IFDEF STRING_IS_IMMUTABLE}
var
  LSB: TIdStringBuilder;
{$ENDIF}
begin
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create('             ');
  {$ELSE}
  Result := '             ';
  {$ENDIF}
  if Read_Only then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[0]{$ELSE}Result[1]{$ENDIF} := 'R'; {do not localize}
  end;
  if Hidden then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[1]{$ELSE}Result[2]{$ENDIF} := 'H'; {do not localize}
  end;
  if System then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[2]{$ELSE}Result[3]{$ENDIF} := 'S'; {do not localize}
  end;
  if Archive then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[3]{$ELSE}Result[4]{$ENDIF} := 'A'; {do not localize}
  end;
  if Directory then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[4]{$ELSE}Result[5]{$ENDIF} := 'D'; {do not localize}
  end;
  if Encrypted then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[5]{$ELSE}Result[6]{$ENDIF} := 'E'; {do not localize}
  end;
  if Normal then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[6]{$ELSE}Result[7]{$ENDIF} := 'N'; {do not localize}
  end;
  if Temporary then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[7]{$ELSE}Result[8]{$ENDIF} := 'T'; {do not localize}
  end;
  if ReparsePoint then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[8]{$ELSE}Result[9]{$ENDIF} := 'J'; {do not localize}
  end;
  if SparseFile then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[9]{$ELSE}Result[10]{$ENDIF} := 'P'; {do not localize}
  end;
  if Compressed then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[10]{$ELSE}Result[11]{$ENDIF} := 'C'; {do not localize}
  end;
  if Offline then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[11]{$ELSE}Result[12]{$ENDIF} := 'O'; {do not localize}
  end;
  if NotContextIndexed then begin
    {$IFDEF STRING_IS_IMMUTABLE}LSB[12]{$ELSE}Result[13]{$ENDIF} := 'I'; {do not localize}
  end;
  {$IFDEF STRING_IS_IMMUTABLE}
  Result := LSB.ToString;
  {$ENDIF}
end;

end.
