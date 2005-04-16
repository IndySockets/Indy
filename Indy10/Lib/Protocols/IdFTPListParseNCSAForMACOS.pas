{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  112270: IdFTPListParseNCSAForMACOS.pas 
{
{   Rev 1.0    11/28/2004 9:20:22 PM  JPMugaas
{ Preliminary support for NCSA Telnet's FTP Server for MacIntosh.
}
unit IdFTPListParseNCSAForMACOS;

interface
uses classes, IdFTPList, IdFTPListParseBase,IdFTPListTypes, IdTStrings;
{
NCSA Telnet for MacIntosh's FTP Server only lists the filenames followed by a /
if they are directories instead of files.

About the only way I can see to detect this server type is to use the greeting banner:

"Macintosh Resident FTP server, ready"  or maybe, the SYST reply "MACOS NCSA".

Unlike many system types, spaces are permitted in filenames.

This also may work on an old Intercon TCP/Connect for MacIntosh.  I only found that
by looking at some source-code in LibWWW which has some contributions from Dartmouth College.

The code is at:

http://dev.w3.org/cvsweb/libwww/Library/src/HTFTP.c?rev=1.109&content-type=text/x-cvsweb-markup

http://dev.w3.org/cvsweb/libwww/Library/src/HTFTPDir.c?rev=2.18&content-type=text/x-cvsweb-markup

and

http://web.mit.edu/afs/dev.mit.edu/project/andydev/src/andrew-8.0/WWW/Library/Implementation/HTFTP.c
}
type
  TIdNCSAforMACOSFTPListItem = class(TIdMinimalFTPListItem);
  TIdFTPLPNCSAforMACOS = class(TIdFTPLPNList)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

implementation
uses IdGlobal;

{ TIdFTPLPNCSAforMACOS }

class function TIdFTPLPNCSAforMACOS.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
begin
  Result := (ASysDescript  = 'MAC NCSA') or
  // From Google: http://groups.google.com/groups?q=MAC-OS+TCP/Connect&hl=en&lr=&selm=881%40lts.UUCP&rnum=4
  //Intercon's MAC-OS reports "MAC-OS TCP/Connect for the Macintosh Version x.x"
  //but LibWWW
  //http://dev.w3.org/cvsweb/libwww/Library/src/HTFTP.c?rev=1.109&content-type=text/x-cvsweb-markup
  //"MAC-OS TCP/ConnectII"      
    (Copy(ASysDescript,1,18)=' MAC-OS TCP/Connect');
end;

class function TIdFTPLPNCSAforMACOS.GetIdent: String;
begin
  Result := 'NCSA for MACOS'; {do not localize}
end;

class function TIdFTPLPNCSAforMACOS.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdNCSAforMACOSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPNCSAforMACOS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
begin
  Result := True;
  try
    if IdGlobal.CharIsInSet(AItem.Data,Length(AItem.Data),['/','\']) then
    begin
      AItem.ItemType := ditDirectory;
      AItem.FileName := Copy(AItem.Data,1,Length(AItem.Data)-1);
    end
    else
    begin
      AItem.ItemType := ditFile;
      AItem.FileName := AItem.Data;
    end;
  except
    Result := False;
  end;
end;

initialization
  RegisterFTPListParser(TIdFTPLPNCSAforMACOS);
finalization
  UnRegisterFTPListParser(TIdFTPLPNCSAforMACOS);
end.
