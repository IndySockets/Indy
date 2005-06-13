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
{   Rev 1.9    2/23/2005 6:34:28 PM  JPMugaas
{ New property for displaying permissions ina GUI column.  Note that this
{ should not be used like a CHMOD because permissions are different on
{ different platforms - you have been warned.
}
{
{   Rev 1.8    10/26/2004 9:51:14 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.7    4/19/2004 5:05:58 PM  JPMugaas
{ Class rework Kudzu wanted.
}
{
{   Rev 1.6    2004.02.03 5:45:34 PM  czhower
{ Name changes
}
{
{   Rev 1.5    1/22/2004 4:58:24 PM  SPerry
{ fixed set problems
}
{
{   Rev 1.4    1/22/2004 7:20:46 AM  JPMugaas
{ System.Delete changed to IdDelete so the code can work in NET.
}
{
    Rev 1.3    10/19/2003 3:36:10 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.2    6/27/2003 02:07:40 PM  JPMugaas
{ Should now compile now that IsNumeric was moved to IdCoreGlobal.
}
{
{   Rev 1.1    4/7/2003 04:04:12 PM  JPMugaas
{ User can now descover what output a parser may give.
}
{
{   Rev 1.0    2/19/2003 10:13:42 PM  JPMugaas
{ Moved parsers to their own classes.
}
unit IdFTPListParseNovellNetwarePSU;

interface

uses IdFTPList, IdFTPListParseBase, IdFTPListTypes, IdObjs;

type
  TIdNovellPSU_DOSFTPListItem = class(TIdNovellBaseFTPListItem);
  TIdFTPLPNetwarePSUDos = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;
  TIdNovellPSU_NFSFTPListItem = class(TIdUnixBaseFTPListItem);
  TIdFTPLPNetwarePSUNFS = class(TIdFTPListBase)
  protected
    class function MakeNewItem(AOwner : TIdFTPListItems)  : TIdFTPListItem; override;
    class function ParseLine(const AItem : TIdFTPListItem; const APath : String=''): Boolean; override;
  public
    class function GetIdent : String; override;
    class function CheckListing(AListing : TIdStrings; const ASysDescript : String =''; const ADetails : Boolean = True): boolean; override;
  end;

const
  NOVELLNETWAREPSU = 'Novell Netware Print Services for Unix:  '; {do not localize}

implementation

uses
  IdGlobal, IdFTPCommon, IdGlobalProtocols, IdStrings,
  IdSys;

{ TIdFTPLPNetwarePSUDos }

class function TIdFTPLPNetwarePSUDos.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;

var LPerms : String;
  LData : String;
begin
  Result := True;
  if AListing.Count >0 then
  begin
    LData := AListing[0];
    Result := LData <> '';
    if Result then
    begin
      Result := (CharIsInSet(LData, 1, 'dD-')); {do not localize}
      if Result then
      begin
        //we have to be careful to distinguish between Hellsoft and
        //NetWare Print Services for UNIX, FTP File Transfer Service
        LPerms := ExtractNovellPerms(Copy(LData,1,12));
        Result := (Length(LPerms)=8) and IsValidNovellPermissionStr(LPerms);
        Result := Result and IsNovelPSPattern(LData);
      end;
    end;
  end;
end;

class function TIdFTPLPNetwarePSUDos.GetIdent: String;
begin
  Result := NOVELLNETWAREPSU + 'DOS Namespace'; {do not localize}
end;

class function TIdFTPLPNetwarePSUDos.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdNovellPSU_DOSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPNetwarePSUDos.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var LBuf : String;
   LModifiedDate : String;
   LModifiedTime : String;
   LI : TIdNovellPSU_DOSFTPListItem;
//-[RWCEAFMS] server1          3166     Sept 14, 99 2:30 pm vol$log.err
begin
  LI := AItem as TIdNovellPSU_DOSFTPListItem;
  LBuf := LI.Data;
  //item type
  if (Sys.UpperCase(Copy(LBuf,1,1))='D') then
  begin
    LI.ItemType := ditDirectory;
  end
  else
  begin
    LI.ItemType := ditFile;
  end;
  IdDelete(LBuf,1,1);
  LBuf := Sys.TrimLeft(LBuf);
  //Permissions
  LI.NovellPermissions := ExtractNovellPerms(Fetch(LBuf));
  LI.PermissionDisplay := '['+LI.NovellPermissions+']';
  LBuf := Sys.TrimLeft(LBuf);
  //Owner
  LI.OwnerName := Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  //size
  LI.Size := Sys.StrToInt64(Fetch(LBuf),0);
  LBuf := Sys.TrimLeft(LBuf);
  //month
  //we have to make sure that the month is 3 chars.  The list might return Sept instead of Sep
  LModifiedDate := Copy(Fetch(LBuf),1,3);
  LBuf := Sys.TrimLeft(LBuf);
  //day
  LModifiedDate := LModifiedDate + ' '+Fetch(LBuf);
  LModifiedDate := Fetch(LModifiedDate,',');
  LBuf := Sys.TrimLeft(LBuf);
  //year
  LModifiedDate := LModifiedDate + ' '+Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  LI.ModifiedDate := DateStrMonthDDYY(LModifiedDate,' ');
  //time
  LModifiedTime := Fetch(LBuf);
  LBuf := Sys.TrimLeft(LBuf);
  //am/pm
  LModifiedTime := LModifiedTime+Fetch(LBuf);
  LI.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LModifiedTime);
  //name
  LI.FileName := LBuf;
  Result := True;
end;

{ TIdFTPLPNetwarePSUNFS }

class function TIdFTPLPNetwarePSUNFS.CheckListing(AListing: TIdStrings;
  const ASysDescript: String; const ADetails: Boolean): boolean;
  var s : TIdStrings;
      lbuf : string;
begin
  Result := False;
  if AListing.Count > 0 then
  {
  1234567890
  -rw------ - 2 root wheel   512  Oct 14, 99 8:45 pm deleted.sav
  -rw------ - 1 bill support 1285 Oct 14, 99 9:55 pm 123456789.123456

  or

  -rw------ 1 root wheel   512  Oct 14  99 8:45 pm deleted.sav
  -rw------ 1 bill support 1285 Oct 14  99 9:55 pm 123456789.123456

  }
  begin
    lbuf := AListing[0];
    //remove the extra space that sometimes appears in older versions to "flatten"
    //out the listing
    if Copy(lbuf,10,1)=' ' then
    begin
      IdDelete(lbuf,10,1);
    end;

    Result := IsValidUnixPerms(lbuf,True);
    if Result then
    begin
      s := TIdStringList.Create;
      try
        SplitColumns(lbuf,s);
        Result := (s.Count >9) and
          ((Sys.UpperCase(s[9])='AM') or (Sys.UpperCase(s[9])='PM')); {do not localize}
        if Result then
        begin
          lbuf := s[6];
          lbuf := Fetch(lbuf,',');
          Result := IsNumeric(lbuf);
          if Result then
          begin
            Result := (StrToMonth(s[5])>0 );
          end;
        end;
      finally
        Sys.FreeAndNil(s);
      end;
    end;
  end;
end;

class function TIdFTPLPNetwarePSUNFS.GetIdent: String;
begin
  Result := NOVELLNETWAREPSU + 'NFS Namespace'; {do not localize}
end;


class function TIdFTPLPNetwarePSUNFS.MakeNewItem(
  AOwner: TIdFTPListItems): TIdFTPListItem;
begin
  Result := TIdNovellPSU_NFSFTPListItem.Create(AOwner);
end;

class function TIdFTPLPNetwarePSUNFS.ParseLine(const AItem: TIdFTPListItem;
  const APath: String): Boolean;
var
  LBuf,LBuf2 : String;
  LI : TIdNovellPSU_NFSFTPListItem;
begin

{

  -rw------ - 2 root wheel   512  Oct 14, 99 8:45 pm deleted.sav
  -rw------ - 1 bill support 1285 Oct 14, 99 9:55 pm 123456789.123456

  or

  -rw------- 1 root wheel   512  Oct 14,  99 8:45 pm deleted.sav
  -rw------- 1 root wheel   3166 Oct 14,  99 8:45 pm vol$log.err
  -rw------- 1 bill support 1285 Oct 14,  99 9:55 pm 123456789.123456
  drw------- 2 mary support 512  Oct 14,  99 7:33 pm locktst
  drwxr-xr-x 1 root wheel   512  Oct 14,  99 4:33 pm brief

Based on:
http://www.novell.com/documentation/lg/nw42/unixpenu/data/tut0i3h5.html#cnovdocsdocenglishnw42unixpenudatahpyvrshhhtml
http://www.novell.com/documentation/lg/nw5/usprint/unixpenu/data/tut0i3h5.html#dnovdocsdocenglishnw5usprintunixpenudatahpyvrshhhtm
http://www.novell.com/documentation/lg/nfs24/docui/index.html#../nfs24enu/data/hpyvrshh.html

}

      {
      0 - type of item and Permissions
      1 - # of links
      2 - Owner
      3 - Group
      4 - size
      5 - month
      6 - day
      7 - year
      8 - time
      9 - am/pm
      10 - name
      }
  LI := AItem as TIdNovellPSU_NFSFTPListItem;
  LBuf := LI.Data;
  LBuf2 := Fetch(LBuf);
  if (IsNumeric(Fetch(LBuf,' ',False))=False) then
  begin
    LBuf2 := LBuf2+Fetch(LBuf);
  end;
  if (Sys.UpperCase(Copy(LBuf2, 1, 1))='-') then
  begin
    LI.ItemType := ditFile;
  end
  else
  begin
    LI.ItemType := ditDirectory;
  end;
  LI.UnixOwnerPermissions := Copy(LBuf2, 2, 3);
  LI.UnixGroupPermissions := Copy(LBuf2, 5, 3);
  LI.UnixOtherPermissions := Copy(LBuf2, 8, 3);
  LI.PermissionDisplay := LBuf2;
  //number of links
  LI.LinkCount := Sys.StrToInt(Fetch(LBuf),0);
  //Owner
  LBuf := Sys.TrimLeft(LBuf);
  LI.OwnerName := Fetch(LBuf);
  //Group
  LBuf := Sys.TrimLeft(LBuf);
  LI.GroupName := Fetch(LBuf);
  //Size
   LBuf := Sys.TrimLeft(LBuf);
  AItem.Size := Sys.StrToInt64(Fetch(LBuf),0);
  //Date - month
  LBuf := Sys.TrimLeft(LBuf);
  LBuf2 := Sys.UpperCase(Fetch(LBuf))+' ';
  //Date - day
  LBuf := Sys.TrimLeft(LBuf);
  LBuf2 := Sys.TrimRight(LBuf2) + ' '+ Fetch(LBuf);
  LBuf2 := Fetch(LBuf2,',');
  //Year - year
  LBuf := Sys.TrimLeft(LBuf);
  LBuf2 := Fetch(LBuf)+' '+LBuf2;
  //Process Day
  LI.ModifiedDate :=  DateYYStrMonthDD(LBuf2,' ');
  //time
  LBuf := Sys.TrimLeft(LBuf);
  LBuf2 := Fetch(LBuf);
  //make sure AM/pm are processed
  LBuf2 := LBuf2 + Fetch(LBuf);
  LI.ModifiedDate := AItem.ModifiedDate + TimeHHMMSS(LBuf2);
  // File name
  if (IndyPos(UNIX_LINKTO_SYM,LBuf)>0) then
  begin
    LI.FileName := Fetch(LBuf,UNIX_LINKTO_SYM);
    LI.LinkedItemName := LBuf;
  end
  else
  begin
    if (IndyPos(UNIX_LINKTO_SYM,LBuf)>0) then
    begin
      LI.FileName := Fetch(LBuf,UNIX_LINKTO_SYM);
      LI.LinkedItemName := LBuf;
    end
    else
    begin
      LI.FileName := LBuf;
    end;
  end;
  //Novell Netware is case sensitive I think.
  LI.LocalFileName := AItem.FileName;
  Result := True;
end;

initialization
  RegisterFTPListParser(TIdFTPLPNetwarePSUDos);
  RegisterFTPListParser(TIdFTPLPNetwarePSUNFS);
finalization
  UnRegisterFTPListParser(TIdFTPLPNetwarePSUDos);
  UnRegisterFTPListParser(TIdFTPLPNetwarePSUNFS);
end.
