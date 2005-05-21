{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11858: IdFTPBaseFileSystem.pas 
{
{   Rev 1.8    8/24/2003 06:49:54 PM  JPMugaas
{ API Change in the FileSystem component so that a thread is passed instead of
{ some data from the thread.  This should also make the API's easier to manage
{ than before and provide more flexibility for developers writing their own
{ file system components.
}
{
{   Rev 1.7    3/10/2003 05:09:10 PM  JPMugaas
{ MLST now works as expected with the file system.  Note that the MLST means
{ simply to give information about an item instead of its contents.
{ GetRealFileName in IdFTPFileSystem now can accept the wildcard *.
{ When doing dirs in EPLF, only information about a directory is retruned if it
{ is specified.
}
{
{   Rev 1.6    3/6/2003 10:59:58 AM  JPMugaas
{ Now handles the MFMT command and the MFCT (Modified Date fact) command.
}
{
{   Rev 1.5    3/6/2003 08:26:20 AM  JPMugaas
{ Bug fixes.
{ 
{ FTP COMB command can now work in the FTPFileSystem component.
}
{
{   Rev 1.4    3/5/2003 03:28:06 PM  JPMugaas
{ MD5, MMD5, and XCRC are now supported in the Virtual File System.
}
{
{   Rev 1.3    3/2/2003 04:54:26 PM  JPMugaas
{ Now does recursive dir lists with the Virtual File System layer as well as
{ honors other switches.
}
{
{   Rev 1.2    3/2/2003 02:20:24 PM  JPMugaas
{ Updated FTP File system.  It now raises exceptions for errors plus load and
{ save have been implemented.  I also implemented RMDIR.
}
{
{   Rev 1.1    3/2/2003 02:20:12 AM  JPMugaas
{ Updated with some enw functionality.
}
{
{   Rev 1.0    11/13/2002 08:28:28 AM  JPMugaas
{ Initial import from FTP VC.
}
{*****************************************************************************}
{*                              IdFTPBaseFileSystem.pas                      *}
{*****************************************************************************}

{*===========================================================================*}
{* DESCRIPTION                                                               *}
{*****************************************************************************}
{* PROJECT    : Indy 10                                                      *}
{* AUTHOR     : Bas Gooijen                                                  *}
{* MAINTAINER : Bas Gooijen                                                  *}
{*...........................................................................*}
{* DESCRIPTION                                                               *}
{*                                                                           *}
{* Abstract base class for TIdFTPFileSystem                                  *}
{*                                                                           *}
{*...........................................................................*}
{* HISTORY                                                                   *}
{*     DATE    VERSION  AUTHOR      REASONS                                  *}
{*                                                                           *}
{* 01/10/2002    1.0   Bas Gooijen  Initial start                            *}
{*****************************************************************************}

unit IdFTPBaseFileSystem;

interface

uses
  Classes,
  IdBaseComponent,
  IdException,
  IdFTPList,
  IdFTPListOutput,
  IdFTPServerContextBase,
  IdSys;

type
  TIdFTPBaseFileSystem = class(TIdBaseComponent)
  protected
    procedure ErrPermissionDenied;
    procedure ErrCantRemoveDir;
    procedure ErrFileNotFound;
    procedure ErrNotAFile;
    procedure ErrNotADir;
  public
    procedure ChangeDir(AContext : TIdFTPServerContextBase; var VDirectory: string); virtual; abstract;
    procedure GetFileSize(AContext : TIdFTPServerContextBase; const AFilename: string; var VFileSize: Int64); virtual; abstract;
    procedure GetFileDate(AContext : TIdFTPServerContextBase; const AFilename: string; var VFileDate: TIdDateTime); virtual; abstract;
    procedure ListDirectory(AContext : TIdFTPServerContextBase; const APath: string; ADirectoryListing: TIdFTPListOutput; const ACmd, ASwitches : String); virtual; abstract;
    procedure RenameFile(AContext : TIdFTPServerContextBase; const ARenameToFile: string); virtual; abstract;
    procedure DeleteFile(AContext : TIdFTPServerContextBase; const APathName: string); virtual; abstract;
    procedure RetrieveFile(AContext : TIdFTPServerContextBase; const AFileName: string; var VStream: TStream); virtual; abstract;
    procedure StoreFile(AContext : TIdFTPServerContextBase; const AFileName: string; AAppend: Boolean; var VStream: TStream); virtual; abstract;
    procedure MakeDirectory(AContext : TIdFTPServerContextBase; var VDirectory: string); virtual; abstract;
    procedure RemoveDirectory(AContext : TIdFTPServerContextBase; var VDirectory: string); virtual; abstract;
    procedure SetModifiedFileDate(AContext : TIdFTPServerContextBase; const AFileName: String; var VDateTime: TIdDateTime); virtual; abstract;
    procedure GetCRCCalcStream(AContext : TIdFTPServerContextBase; const AFileName: string; var VStream : TStream); virtual; abstract;
    procedure CombineFiles(AContext : TIdFTPServerContextBase;
      const ATargetFileName: string; AParts: TStrings); virtual; abstract;

  end;
  EIdFileSystemException = class(EIdException);
  EIdFileSystemPermissionDenied = class(EIdFileSystemException);
  EIdFileSystemFileNotFound = class(EIdFileSystemException);
  EIdFileSystemNotAFile = class(EIdFileSystemException);
  EIdFileSystemNotADir = class(EIdFileSystemException);
  EIdFileSystemCannotRemoveDir = class(EIdFileSystemException);

resourceString
  RSFTPFSysErrMsg = 'Permission Denied';
implementation

{ TIdFTPBaseFileSystem }

procedure TIdFTPBaseFileSystem.ErrCantRemoveDir;
begin
  raise  EIdFileSystemCannotRemoveDir.Create(RSFTPFSysErrMsg);
end;

procedure TIdFTPBaseFileSystem.ErrFileNotFound;
begin
  raise EIdFileSystemFileNotFound.Create(RSFTPFSysErrMsg);
end;

procedure TIdFTPBaseFileSystem.ErrNotADir;
begin
  raise EIdFileSystemNotADir.Create(RSFTPFSysErrMsg);
end;

procedure TIdFTPBaseFileSystem.ErrNotAFile;
begin
  raise EIdFileSystemNotAFile.Create(RSFTPFSysErrMsg);
end;

procedure TIdFTPBaseFileSystem.ErrPermissionDenied;
begin
  raise EIdFileSystemPermissionDenied.Create(RSFTPFSysErrMsg);
end;

end.

 
