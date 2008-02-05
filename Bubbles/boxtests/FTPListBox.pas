{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11249: FTPListBox.pas 
{
{   Rev 1.0    11/12/2002 09:17:44 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit FTPListBox;
{.$define WriteFiles} // define this to create te reference files.
// only do this if you are sure this ftp-lists work correct.
interface

uses
  IndyBox;

type
  TFTPListBox = class( TIndyBox )
  public
    function TestFile( const FileName: string ) : boolean;
    procedure TestSystem( const system: string ) ;
    procedure Test; override;
  end;

implementation

uses
  IdFTPList, Classes,
  SysUtils;

{ TFTPListBox }

function MyDateTimeToStr(const d:tdatetime):string;
{this is a nice one}
begin
  if (d-trunc(d))*(60*60*24)>=1 then
    DateTimeToString( Result,'M-d-yyyy h:mm:ss',d)
  else
    DateTimeToString( Result,'M-d-yyyy',d)
end;

function TFTPListBox.TestFile( const FileName: string ) : boolean;
var
  s: TStrings;
  i: Integer;
  LDirectoryListing: TIdFTPListItems;
  Expected: TStrings;
  ExpectedPos: integer;

  function Test( const str: string ) : boolean;
  begin
{$ifndef WriteFiles}
    result := Expected.strings[ExpectedPos] = str;
    inc( ExpectedPos ) ;
{$else}
    Expected.add(str);
    result:=true;
{$endif}
  end;

begin
  result := true;
  LDirectoryListing := TIdFTPListItems.Create;
  try
    s := TStringList.Create;
    Expected := TStringList.Create;
    ExpectedPos := 0;
{$ifndef WriteFiles}
    Expected.LoadFromfile( filename + '.expected' ) ;
{$endif}
    try
      s.LoadFromFile( Filename ) ;

      for i := s.Count -1 downto 0 do
      begin
        if (s[i]<>'') and (s[i][1] = '#') then
        begin
          s.Delete(i);
        end;
      end;

      // Parse directory listing
      if s.Count > 0 then
      begin
        //we have to skip blank lines because VMS returns those
        //throwing off the Indy code.
        for i := 0 to s.Count - 1 do
        begin
          if ( s[i] <> '' ) and ( Pos( 'TOTAL', UpperCase( s[i] ) ) <> 1 ) then
          begin
            LDirectoryListing.ListFormat := LDirectoryListing.CheckListFormat( s[i], TRUE ) ; //APR: TRUE for IndyCheck, else always Unknown
            Break;
          end;
        end;
        LDirectoryListing.LoadList( s ) ;
      end;

      for i := 0 to LDirectoryListing.Count - 1 do
      begin
        result := result and test( LDirectoryListing[i].FileName ) ;
        result := result and test( LDirectoryListing[i].OwnerName ) ;
        result := result and test( IntToStr( LDirectoryListing[i].Size ) ) ;
        case LDirectoryListing[i].ItemType of
          ditDirectory: result := result and test( 'Directory' ) ;
          ditFile: result := result and test( 'File' ) ;
          ditSymbolicLink: result := result and test( 'Symbolic Link' ) ;
        end;
        result := result and test( IntToStr( LDirectoryListing[i].RecLength ) ) ;
        result := result and test( IntToStr( LDirectoryListing[i].NumberRecs ) ) ;
//        result := result and test( FormatDateTime('M-d-yyyy h:mm:ss',LDirectoryListing[i].ModifiedDate));
        result := result and test( MyDateTimeToStr( LDirectoryListing[i].ModifiedDate ) ) ;
        test( '' ) ;
      end;

    finally
      FreeAndNil( s ) ;
{$ifdef WriteFiles}
      Expected.savetofile(filename+'.expected');
{$endif}
      FreeAndNil( Expected ) ;
    end;
  finally
    FreeAndNil( LDirectoryListing ) ;
  end;
end;

procedure TFTPListBox.TestSystem( const system: string ) ;
var
  f: TSearchRec; a: integer;
begin
  Status( 'Testing ' + system ) ;
  a := FindFirst( GetDataDir + system + '-*.txt', faAnyFile - faDirectory, f ) ;
  while a = 0 do
  begin
    check( TestFile( GetDataDir + f.name ) , f.name + ' goes wrong' ) ;
    a := FindNext( f ) ;
  end;
  findclose( f )
end;

procedure TFTPListBox.Test;
begin
  TestSystem( 'MS-Dos' ) ;
  TestSystem( 'Novel-Netware' ) ;
  TestSystem( 'Unix' ) ;
  TestSystem( 'VM' ) ;
  TestSystem( 'VMS' ) ;
  TestSystem( 'MVS' ) ;
  TestSystem( 'MVS_PDS' ) ;
  TestSystem( 'Mac-NetPresenz' ) ;
end;

initialization
  TIndyBox.RegisterBox( TFTPListBox, 'FTP Lists', 'Misc' ) ;
end.

