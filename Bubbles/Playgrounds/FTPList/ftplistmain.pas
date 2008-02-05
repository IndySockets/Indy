{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13708: ftplistmain.pas 
{
{   Rev 1.12    2/17/2003 11:14:46 PM  JPMugaas
{ Updated for new system determination type.  For Cisco IOS and TOPS20, we have
{ to cheat by providing a system descriptor.
}
{
{   Rev 1.11    1/26/2003 02:33:54 AM  JPMugaas
{ Reworked for some property changes and for additional MVS properties.
}
{
{   Rev 1.10    1/25/2003 07:32:44 PM  JPMugaas
{ Expanded for MUSIC support.
}
{
{   Rev 1.9    1/24/2003 01:51:34 AM  JPMugaas
}
{
{   Rev 1.8    1/4/2003 03:35:30 PM  JPMugaas
{ MVS JES interface 1 and 2 specific properties.
}
{
{   Rev 1.7    1/4/2003 03:26:22 PM  JPMugaas
{ MVS JES queue properties now displayed for JES interface 1.
}
{
{   Rev 1.6    1/4/2003 01:31:46 PM  JPMugaas
{ Updated for new parser restructure and additions.
}
{
{   Rev 1.5    12/29/2002 10:24:08 PM  JPMugaas
{ Updated for some new properties.  Widened the columns output for the box test
{ to accomodate a longer feildname.
}
{
{   Rev 1.4    12/11/2002 03:38:46 PM  JPMugaas
{ Added LocalFileName test.
}
{
{   Rev 1.3    12/11/2002 03:24:36 AM  JPMugaas
{ Reworked the parsing code to be more consistant with the special dir case
{ indicating NextLine.
}
{
{   Rev 1.2    12/10/2002 10:13:28 AM  JPMugaas
{ Logging TMemo bottom anchor fixed.
}
{
{   Rev 1.1    12/9/2002 06:53:56 PM  JPMugaas
{ Added support for new dir type.  Set the anchors for the log TMemo.  It was
{ just a small thing that was driving me nuts.
}
{
{   Rev 1.0    11/13/2002 04:01:12 PM  JPMugaas
}
unit ftplistmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    mmoTestLog: TMemo;
    btnTest: TButton;
    edtFileName: TEdit;
    lblFileName: TLabel;
    bbtnBrowse: TButton;
    odlgTestList: TOpenDialog;
    edtOutputFileName: TEdit;
    lblOutputFileName: TLabel;
    btnOBrowse: TButton;
    sdlgOutput: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure bbtnBrowseClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnOBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses IdFTPList;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  odlgTestList.InitialDir := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.bbtnBrowseClick(Sender: TObject);
begin
  odlgTestList.FileName := edtFileName.Text;
  if odlgTestList.Execute then
  begin
    edtFileName.Text := odlgTestList.FileName;
  end;
end;

procedure TForm1.btnTestClick(Sender: TObject);
var s, d : TStrings;
    i : Integer;
   LDirectoryListing : TIdFTPListItems;
begin
  mmoTestLog.Lines.Clear;
  LDirectoryListing := TIdFTPListItems.Create;
  try
    s := TStringList.Create;
    d := TStringList.Create;
    try
      s.LoadFromFile(edtFileName.Text );
          // Parse directory listing
      for i := s.Count -1 downto 0 do
      begin
        if (s[i]<>'') and (s[i][1] = '#') then
        begin
          s.Delete(i);
        end;
      end;
         //we do things this way because some servers will return blank lines
         //or something such as TOTAL x which we can not use for determining the format
        LDirectoryListing.ListFormat := flfNextLine;
        for i := 0 to s.Count -1 do
        begin
          if Pos('TOPS20',ExtractFileName(edtFileName.Text))=1 then
          begin
            LDirectoryListing.ListFormat := LDirectoryListing.CheckListFormat(s[i],TRUE,'TOPS20');
          end
          else
          begin
            if Pos('Cisco-',ExtractFileName(edtFileName.Text))=1 then
            begin
              LDirectoryListing.ListFormat := LDirectoryListing.CheckListFormat(s[i],TRUE,'Cisco IOS ');
            end
            else
            begin
              LDirectoryListing.ListFormat := LDirectoryListing.CheckListFormat(s[i],TRUE);
            end;
          end;
          if LDirectoryListing.ListFormat <> flfNextLine then
          begin
            Break;
          end;
        end;
        LDirectoryListing.LoadList(s);
        d.Assign(s);
        d.Add('==============================');
        for i := 0 to LDirectoryListing.Count -1 do
        begin
          d.Add('File Name:              '+LDirectoryListing[i].FileName);
          d.Add('Local File Name:        '+LDirectoryListing[i].LocalFileName);
          d.Add('File Owner:             '+LDirectoryListing[i].OwnerName);
          case LDirectoryListing.ListFormat of
             flfNovelNetware,
             flfNovelNetwarePSU_DOS,
             flfHellSoft :
               d.Add('Insider Premissions:    '+ LDirectoryListing[i].NovellPermissions );
             flfUnix : ;
             flfVMS :
             begin
               d.Add('System Protections:     '+LDirectoryListing[i].VMSSystemPermissions);
               d.Add('Owner Protections:      '+LDirectoryListing[i].VMSOwnerPermissions);
               d.Add('Group Protections:      '+LDirectoryListing[i].VMSGroupPermissions);
               d.Add('World Protections:      '+LDirectoryListing[i].VMSWorldPermissions );
             end;
             flfVMCMS, flfMusic,flfMVS :
             begin
               d.Add('Volume:                 '+LDirectoryListing[i].MVSVolume);
               d.Add('Unit:                   '+LDirectoryListing[i].MVSUnit);
               d.Add('Record Length:          '+IntToStr(LDirectoryListing[i].RecLength ));
               d.Add('Number of Records:      '+IntToStr(LDirectoryListing[i].NumberRecs ));
               if LDirectoryListing.ListFormat = flfMVS then
               begin
                 d.Add('Record Format:          '+LDirectoryListing[i].RecFormat);
                 d.Add('Number of Extents:      '+IntToStr(LDirectoryListing[i].MVSNumberExtents ));
                 d.Add('Number of Tracks:       '+IntToStr(LDirectoryListing[i].MVSNumberTracks ));
               end;
               d.Add('Number of Blocks:       '+IntToStr(LDirectoryListing[i].NumberBlocks ));
               d.Add('Block Size:             '+IntToStr(LDirectoryListing[i].BlockSize ));
               if LDirectoryListing[i].MVSDSOrg <> '' then
               begin
                 d.Add('Data Set Organization:  '+LDirectoryListing[i].MVSDSOrg);
               end;
             end;
             flfMVS_JES, flfMVS_JESIntf2 :
             begin
               case LDirectoryListing[i].MVSJobStatus of
                 IdJESReceived : d.Add('Job Status:             Received');
                 IdJESHold : d.Add('Job Status:             Hold');
                 IdJESRunning : d.Add('Job Status:             Running');
                 IdJESOuptutAvailable :
                 begin
                   d.Add('Job Status:             Output Available');
                   d.Add('Spool Files:            '+ IntToStr( LDirectoryListing[i].MVSJobSpoolFiles ));
                 end;
               end;
             end;
          end;
          if LDirectoryListing.ListFormat in [flfVMS, flfUnix] then
          begin
            d.Add('File Group:             '+LDirectoryListing[i].GroupName);
          end;
          d.Add('File Size:              '+IntToStr(LDirectoryListing[i].Size ));
          case LDirectoryListing[i].ItemType of
           ditDirectory    : d.Add('File Type:              Directory');
           ditFile         : d.Add('File Type:              File');
           ditSymbolicLink : d.Add('File Type:              Symbolic Link');
           ditSymbolicLinkDir : d.Add('File Type:              Symbolic Link to Dir');
          end;
          if LDirectoryListing[i].ModifiedDate <> 0 then
          begin
            d.Add('Last Modified Date:     '+DateTimeToStr( LDirectoryListing[i].ModifiedDate ));
          end;
          if LDirectoryListing[i].ModifiedDateGMT <> 0 then
          begin
            d.Add('Last Modified Date GMT: '+DateTimeToStr( LDirectoryListing[i].ModifiedDateGMT ));
          end;
          d.Add('Item Count:             '+IntToStr(LDirectoryListing[i].ItemCount ));
          d.Add('');
        end;

        if edtOutputFileName.Text = '' then
        begin
          mmoTestLog.Lines.Assign(d);
        end
        else
        begin
          d.SaveToFile(edtOutputFileName.Text);
        end;
    finally
      FreeAndNil(s);
      FreeAndNil(d);
    end;
  finally
    FreeAndNil( LDirectoryListing );
  end;
end;

procedure TForm1.btnOBrowseClick(Sender: TObject);
begin
  sdlgOutput.FileName := edtOutputFileName.Text;
  if odlgTestList.Execute then
  begin
    edtOutputFileName.Text := sdlgOutput.FileName;
  end;
end;

end.
