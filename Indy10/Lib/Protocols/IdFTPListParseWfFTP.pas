{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  110399: IdFTPListParseWfFTP.pas 
{
{   Rev 1.1    10/26/2004 11:21:16 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.0    10/21/2004 10:27:32 PM  JPMugaas
{ BayNetworks WfFTP FTP Server.  WfFTP is a FTP interface for Bay Network's
{ Wellfleet router.
}
unit IdFTPListParseWfFTP;

interface
uses
  Classes,
  IdFTPList, IdFTPListParseBase, IdFTPListTypes, IdTStrings;

{
WfFTP is a FTP interface for BayNetwork's Wellfleet Routers.

Based on:

Configuration Guide
Contivity Secure IP Services Gateway

CG040301
from Nortell Networks
Dated March 2004

Notation, the dir format is like this:

===

 Volume - drive 1:
 Directory of 1:

File Name            Size    Date     Day       Time
------------------------------------------------------
startup.cfg          2116  03/06/03  Thur.    07:38:50
configPppChap        2996  03/12/03  Wed.     16:43:58 
bgpOspf.log         32428  03/20/03  Thur.    13:08:26 
an.exe            7112672  03/20/03  Thur.    13:18:09
bcc.help           492551  03/20/03  Thur.    13:21:43 
debug.al            12319  03/20/03  Thur.    13:22:46
install.bat        236499  03/20/03  Thur.    13:22:54
ti.cfg                132  03/20/03  Thur.    13:23:09
log2.log            32428  03/20/03  Thur.    14:31:46
configFrRip           386  07/18/03  Fri.     12:02:25
config               1720  07/25/03  Fri.     08:52:00
hosts                  17  09/04/03  Thur.    15:56:51

 33554432 bytes - Total size
 25627726 bytes - Available free space
 17672120 bytes - Contiguous free space
226 ASCII Transfer Complete.
===
===

 Volume - drive 2:
 Directory of 2:

File Name             Size    Date     Day      Time
------------------------------------------------------
config.isp           45016  08/22/97  Fri.    17:05:51
startup.cfg           7472  08/24/97  Sun.    23:31:31
asnboot.exe         237212  08/24/97  Sun.    23:31:41
asndiag.exe         259268  08/24/97  Sun.    23:32:28
debug.al             12372  08/24/97  Sun.    23:33:17
ti_asn.cfg             504  08/24/97  Sun.    23:33:31
install.bat         189114  08/24/97  Sun.    23:33:41
config               50140  04/20/98  Mon.    22:08:01

 4194304 bytes - Total size
 3375190 bytes - Available free space
 3239088 bytes - Contiguous free space


====

From: http://www.insecure.org/sploits/bay-networks.baynets.html
}
type
  TIdWfFTPFTPListItem = class(TIdOwnerFTPListItem)
  protected
  end;
  TIdFTPLPWfFTP = class(TIdFTPListBaseHeader)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function IsHeader(const AData: String): Boolean;  override;
    class function IsFooter(const AData : String): Boolean; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
  end;

const WFFTP = 'WfFTP';

implementation
uses IdFTPCommon, IdGlobal, IdSys;

{ TIdFTPLPWfFTP }

class function TIdFTPLPWfFTP.GetIdent: String;
begin
  Result := WFFTP;
end;

class function TIdFTPLPWfFTP.IsFooter(const AData: String): Boolean;
var s : TIdStrings;
begin
  Result := (IndyPos('bytes - Total size',AData)>1) or
    (IndyPos('bytes - Contiguous free space',AData)>1) or
    (IndyPos('bytes - Available free space',AData)>1);
  if Result = False then
  begin
    s := TIdStringList.Create;
    try
      SplitColumns(AData,s);
      if s.Count = 6 then
      begin
        Result := (s[0] = 'File') and (s[1]='Name') and
          (s[2]='Size') and (s[3]='Date') and
          (s[4]='Day') and (s[5]='Time');
      end;
    finally
      Sys.FreeAndNil(s);
    end;
  end;
end;

class function TIdFTPLPWfFTP.IsHeader(const AData: String): Boolean;
begin                         //  1234567890123456
  Result :=   (Copy(AData,1,16)= ' Volume - drive ');  {Do not translate}
  if not Result then
  begin                        // 12345678901234
    Result := (Copy(AData,1,14)= ' Directory of ');  {Do not translate}
  end;
end;

class function TIdFTPLPWfFTP.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdWfFTPFTPListItem.Create(AOwner);
end;

class function TIdFTPLPWfFTP.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var LLine : String;
begin
  Result := True;
  //we'll assume that this is flat - not unusual in some routers
  AItem.ItemType := ditFile;
///config               50140  04/20/98  Mon.    22:08:01
  LLine := AItem.Data;
  //file name
  AItem.FileName := Fetch(LLine);
  //size
  LLine := Sys.TrimLeft(LLine);
  AItem.Size := Sys.StrToInt64(Fetch(LLine),0);
  // date
  LLine := Sys.TrimLeft(LLine);
  AItem.ModifiedDate := DateMMDDYY(Fetch(LLine));
  //day of week - discard
  LLine := Sys.TrimLeft(LLine);
  Fetch(LLine);
  LLine := Sys.TrimLeft(LLine);
  //time
  AItem.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(Fetch(LLine));
end;

initialization
  RegisterFTPListParser(TIdFTPLPWfFTP);
finalization
  UnRegisterFTPListParser(TIdFTPLPWfFTP);
end.
