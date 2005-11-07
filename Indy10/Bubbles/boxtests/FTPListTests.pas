{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  22776: FTPListTests.pas 
{
{   Rev 1.6    10/3/2003 05:47:54 PM  JPMugaas
{ OS/2 tests.
}
{
{   Rev 1.5    9/28/2003 03:38:54 PM  JPMugaas
{ Fixed a bad test case.
}
{
{   Rev 1.4    9/28/2003 03:03:22 AM  JPMugaas
{ Added tests for nonstandard Unix dates.
}
{
{   Rev 1.3    9/27/2003 10:44:58 PM  JPMugaas
{ Added a test for MS-DOS formats.
}
{
{   Rev 1.2    9/3/2003 07:36:16 PM  JPMugaas
{ More parsing test cases.
}
{
{   Rev 1.1    9/3/2003 04:01:14 AM  JPMugaas
{ Added some preliminary tests.
}
{
{   Rev 1.0    9/2/2003 02:27:46 AM  JPMugaas
{ Skeliton for new FTP list test.  The test is in development now.
}
unit FTPListTests;

interface

uses
  SysUtils, Classes, BXBubble, BXCategory;

type
  TFTPTestItem = class(TObject)
  protected
    FTestItem : String;
    FFoundParser : String;
    FExpectedParser : String;
    //note that the Unix servers can normally only report either a year
    //or a time.  This can cause ambiguity because the year is interpretted
    //according to the current or previous year if the date has passed or arrived.  But
    //because we can't know the local time zone, there can be a 24 hour window
    //of time.  E.g.  Sept 8 10:00am 2003 can be interpretted as either Sept 8 10:00am 2003 or
    //Sept 8, 2002 if in the window of Sept 7 10:00am or Sept 9 10:00am.
    //Otherwise, a date such as Sept 8: 10:00am can be interpretted differently at different
    //times of the year (when the window period has passed - 2002 or before the window 2003.
    FEvaluateTime : Boolean;
    FEvaluateYear : Boolean;
    //Note that with the BSD -T switch, a time can be returned with seconds

    FFoundYear, FFoundMonth, FFoundDay, FFoundHour, FFoundMin, FFoundSec : Word;
    FExpectedYear, FExpectedMonth, FExpectedDay, FExpectedHour, FExpectedMin, FExpectedSec : Word;

    FFoundOwner : String;
    FExpectedOwner : String;
    FFoundGroup : String;
    FExpectedGroup : String;
    FFoundFileName : String;
    FExpectedFileName : String;
    FFoundFileSize : Integer;
    FExpectedFileSize : Integer;
  public
    procedure Clear;
    property TestItem : String read FTestItem write FTestItem;
    property FoundParser : String read FFoundParser write FFoundParser;
    property ExpectedParser : String read FExpectedParser write FExpectedParser;
    property EvaluateTime : Boolean read FEvaluateTime write FEvaluateTime;
    property EvaluateYear : Boolean read FEvaluateYear write FEvaluateYear;
    //Note that with the BSD -T switch, a time can be returned with seconds
    property FoundYear : Word read FFoundYear write FFoundYear;
    property FoundMonth : Word read FFoundMonth write FFoundMonth;
    property FoundDay : Word read FFoundDay write FFoundDay;
    property FoundHour : Word read FFoundHour write FFoundHour;
    property FoundMin : Word read FFoundMin write FFoundMin;
    property FoundSec : Word read FFoundSec write FFoundSec;
    property ExpectedYear : Word read FExpectedYear write FExpectedYear;
    property ExpectedMonth : Word read FExpectedMonth write FExpectedMonth;
    property ExpectedDay : Word read FExpectedDay write FExpectedDay;
    property ExpectedHour : Word read FExpectedHour write FExpectedHour;
    property ExpectedMin : Word read FExpectedMin write FExpectedMin;
    property ExpectedSec : Word read FExpectedSec write FExpectedSec;
    property FoundOwner : String read FFoundOwner write FFoundOwner;
    property ExpectedOwner : String read FExpectedOwner write FExpectedOwner;
    property FoundGroup : String read FFoundGroup write FFoundGroup;
    property ExpectedGroup : String read FExpectedGroup write FExpectedGroup;
    property FoundFileName : String read FFoundFileName write FFoundFileName;
    property ExpectedFileName : String read FExpectedFileName write FExpectedFileName;
    property FoundFileSize : Integer read FFoundFileSize write FFoundFileSize;
    property ExpectedFileSize : Integer read FExpectedFileSize write FExpectedFileSize;
  end;
  TdmFTPListTest = class(TDataModule)
    bxUnixLSandSimilar: TBXBubble;
    bxWin32IISForms: TBXBubble;
    bxSterlingComTests: TBXBubble;
    bxOS2Test: TBXBubble;
    procedure bxUnixLSandSimilarTest(Sender: TBXBubble);
    procedure bxWin32IISFormsTest(Sender: TBXBubble);
    procedure bxSterlingComTestsTest(Sender: TBXBubble);
    procedure bxOS2TestTest(Sender: TBXBubble);
  private
    { Private declarations }
  protected
     procedure ReportItem(AItem : TFTPTestItem);
     //this is for MS-DOS (Win32 style Dir lists where there's no
     //owner or group and where the time and date are supplied
     procedure TestItem(
       ATestItem,
       AExpectedParser,
       AExpectedFileName : String;
       AExpectedFileSize : Integer;
       AExpectedYear,
       AExpectedMonth,
       AExpectedDay,
       AExpectedHour,
       AExpectedMin,
       AExpectedSec : Word); overload;
     //for FreeBSD -T /bin/ls variation and Novell Netware Print Services for Unix (NFS Namespace)
    procedure TestItem(
      ATestItem,
      AExpectedParser,
      AExpectedOwner,
      AExpectedGroup,
      AExpectedFileName : String;
      AExpectedFileSize : Integer;
      AExpectedYear,
      AExpectedMonth,
      AExpectedDay,
      AExpectedHour,
      AExpectedMin,
      AExpectedSec : Word); overload;
    //for /bin/ls with a date within 6 monthes
    procedure TestItem(
      ATestItem,
      AExpectedParser,
      AExpectedOwner,
      AExpectedGroup,
      AExpectedFileName : String;
      AExpectedFileSize : Integer;
      AExpectedMonth,
      AExpectedDay,
      AExpectedHour,
      AExpectedMin,
      AExpectedSec : Word); overload;
    //for /bin/ls with a date greater than 6 monthes
    procedure TestItem(
      ATestItem,
      AExpectedParser,
      AExpectedOwner,
      AExpectedGroup,
      AExpectedFileName : String;
      AExpectedFileSize : Integer;
      AExpectedYear,
      AExpectedMonth,
      AExpectedDay  : Word); overload;
  public
    { Public declarations }
  end;

var
  dmFTPListTest: TdmFTPListTest;

implementation
uses IdCoreGlobal, IdAllFTPListParsers, IdFTPList, IdFTPListParseNovellNetwarePSU,
   IdFTPListParseUnix,
    IdFTPListParseBase, IdFTPListParseWindowsNT, IdFTPListParseStercomUnixEnt,
    IdFTPListParseStercomOS390Exp, IdFTPListParseOS2;
    
{$R *.dfm}

procedure TdmFTPListTest.bxUnixLSandSimilarTest(Sender: TBXBubble);
begin
//drwxrwxrwx   1 user     group           0 Mar  3 04:49:59 2003 upload
//FreeBSD /bin/ls -T format
   TestItem('drwxrwxrwx   1 user     group           0 Mar  3 04:49:59 2003 upload',
     UNIX,
     'user',
     'group',
     'upload',
     0,
     2003,
     3,
     3,
     4,
     49,
     59
     );
  //-rw------- 1 root wheel   512  Oct 14,  99 8:45 pm deleted.sav
  //Novell Netware Print Services for Unix FTP Deamon

  TestItem('-rw------- 1 root wheel   512  Oct 14,  99 8:45 pm deleted.sav',
    NOVELLNETWAREPSU + 'NFS Namespace',
    'root',
    'wheel',
    'deleted.sav',
    512,
    1999,
    10,
    14,
    20,
    45,
    0);
 //Normal Unix item with time
 TestItem('drwxrwxrwx  1  owner group         0 Sep 23 21:58 drdos',
   UNIX,
   'owner',
   'group',
   'drdos',
   0,
   9,
   23,
   21,
   58,
   0);

   //drwxr-xr-x   4 ftpuser  ftpusers       512 Jul 23  2001 about
   //Normal Unix item with year
   TestItem('drwxr-xr-x   4 ftpuser  ftpusers       512 Jul 23  2001 about',
     UNIX,
     'ftpuser',
     'ftpusers',
     'about',
     512,
     2001,
     7,
     23);

   // -rw------- 1 strauss staff DK adams  39  Feb  18  11:23 file2
   // Unitree with Time
   TestItem('-rw------- 1 strauss staff DK adams  39  Feb  18  11:23 file2',
     UNITREE,
     'strauss',
     'staff',
     'file2',
     39,
     2,
     18,
     11,
     23,
     0);
   //Unitree with Date
   TestItem('drwxr-xr-x 2 se2nl g664    DK common  8192 Dec 29  1993 encytemp (Empty)',
     UNITREE,
     'se2nl',
     'g664',
     'encytemp (Empty)',
     8192,
     1993,
     12,
     29);
   TestItem('drwxr-xr-x   2 root     110          4096 Sep 27  2000 oracle',
     UNIX,
     'root',
     '110',
     'oracle',
     4096,
     2000,
     9,
     27);
   TestItem('-r--r--r--   1 0        1            351 Aug  8  2000 Welcome',
     UNIX,
     '0',
     '1',
     'Welcome',
     351,
     2000,
     8,
     8);
   //-go switches
   TestItem('-r--r--r--   1     351 Aug  8  2000 Welcome',
     UNIX,
     '',
     '',
     'Welcome',
     351,
     2000,
     8,
     8 );
   //-g switch
   TestItem('-r--r--r--   1 1            351 Aug  8  2000 Welcome',
     UNIX,
     '',
     '1',
     'Welcome',
     351,
     2000,
     8,
     8);
   TestItem('-r--r--r--   1 0            351 Aug  8  2000 Welcome',
     UNIX,
     '',
     '0',  //really the owner but for coding, it's the group because
                 //you can't desinguish a group and owner with one value and on
                 //a server, you can't make an API call.
     'Welcome',
     351,
     2000,
     8,
     8);
   //-i switch
   TestItem('     33025 -r--r--r--   1 root     other        351 Aug  8  2000 Welcome',
     UNIX,
     'root',
     'other',
     'Welcome',
     351,
     2000,
     8,
     8);
   //-s switch
   TestItem('  16 -r--r--r--   1 root     other        351 Aug  8  2000 Welcome',
     UNIX,
     'root',
     'other',
     'Welcome',
     351,
     2000,
     8,
     8);
   //-is switches
   TestItem('     33025   16 -r--r--r--   1 root     other        351 Aug  8  2000 Welcome',
     UNIX,
     'root',
     'other',
     'Welcome',
     351,
     2000,
     8,
     8);
   TestItem('1008201 33 -rw-r--r--  1 204  wheel  32871 Mar  4 16:45:27 1999 nl-ftp',
     UNIX,
     '204',
     'wheel',
     'nl-ftp',
     32871,
     1999,
     3,
     4,
     16,
     45,
     27);
   //char devices
   TestItem('crw-rw-rw-   1 0        1         11, 42 Aug  8  2000 tcp',
     UNIX,
     '0',
     '1',
     'tcp',
     0,
     2000,
     8,
     8);
   TestItem('crw-rw-rw-   1 0        1        105,  1 Aug  8  2000 ticotsord',
     UNIX,
     '0',
     '1',
     'ticotsord',
     0,
     2000,
     8,
     8);
   // a /bin/ls form with a ACL.
   TestItem('drwx------+   7 Administ mkpasswd    86016 Feb  9 18:04 bin',
     UNIX,
     'Administ',
     'mkpasswd',
     'bin',
     86016,
     2,
     9,
     18,
     4,
     0);
 //Note that this is problematic and I doubt we can ever fix for this one without
 //introducing other problems.
 { TestItem('-rw-r--r--   1 J. Peter Mugaas None       862979 Apr  8  2002 kftp.exe',
     UNIX,
     'J. Peter Mugaas',
     'None',
     'kftp.exe',
     862979,
     2002,
     4,
     8);  }
  //taken from remarks in the FileZilla GNU Source-code - note that non of that
  //code is used at all
  //		/* Some listings with uncommon date/time format: */
	//	"-rw-r--r--   1 root     other        531 09-26 2000 README2",
   TestItem('-rw-r--r--   1 root     other        531 09-26 2000 README2',
     UNIX,
     'root',
     'other',
     'README2',
     531,
     2000,
     9,
     26);
	//	"-rw-r--r--   1 root     other        531 09-26 13:45 README3",
    TestItem('-rw-r--r--   1 root     other        531 09-26 13:45 README3',
     UNIX,
     'root',
     'other',
     'README3',
     531,
     9,
     26,
     13,
     45,
     0);
	//	"-rw-r--r--   1 root     other        531 2005-06-07 21:22 README4
   TestItem('-rw-r--r--   1 root     other        531 2005-06-07 21:22 README4',
     UNIX,
     'root',
     'other',
     'README4',
     2005,
     6,
     7,
     21,
     22,
     0);
  TestItem('----------   1 owner    group         1803128 Jul 10 10:18 ls-lR.Z',
     UNIX,
     'owner',
     'group',
     'ls-lR.Z',
     1803128,
     7,
     10,
     10,
     18,
     0);
  TestItem('d---------   1 owner    group               0 May  9 19:45 Softlib',
    UNIX,
    'owner',
    'group',
    'Softlib',
    0,
    5,
    9,
    19,
    45,
    0);
  // CONNECT:Enterprise for UNIX login ok,
  TestItem('-r--r--r--   1 connect      3444   910368 Sep 24 16:36 c3957010.zip.001',
    UNIX,
    'connect',
    '3444',
    'c3957010.zip.001',
    910368,
    9,
    24,
    16,
    36,
    0);
  TestItem('-r--r--r--   1 connect      2755  6669222 Sep 26 08:11 3963338.fix.000',
    UNIX,
    'connect',
    '2755',
    '3963338.fix.000',
    6669222,
    9,
    26,
    8,
    11,
    0);
  TestItem('-r--r--r--   1 connect      3188  6669222 Sep 26 13:12 c3963338.zip',
    UNIX,
    'connect',
    '3188',
    'c3963338.zip',
    6669222,
    9,
    26,
    13,
    12,
    0);
end;

procedure TdmFTPListTest.ReportItem(AItem: TFTPTestItem);
var LStatus : String;
begin
  bxUnixLSandSimilar.Status('Item: ');
  bxUnixLSandSimilar.Status(AItem.TestItem);
  //filename
  LStatus :=
    'Obtained File name: '+ AItem.FoundFileName + EOL +'Expected name:      '+AItem.ExpectedFileName ;
  bxUnixLSandSimilar.Status(LStatus);
  bxUnixLSandSimilar.Check(AItem.FoundFileName=AItem.ExpectedFileName, LSTatus);
  //parserID
  LStatus := 'Obtained Parser ID: '+ AItem.FoundParser +EOL+
    'Expected Parser ID: '+ AItem.ExpectedParser;
  bxUnixLSandSimilar.Status(LStatus);
  bxUnixLSandSimilar.Check(AItem.FoundFileName=AItem.ExpectedFileName,LStatus);

    //Owner
  LStatus := 'Obtained Owner: '+ AItem.FoundOwner +EOL+'Expected Owner: '+ AItem.ExpectedOwner;
  bxUnixLSandSimilar.Status(LStatus);
  bxUnixLSandSimilar.Check(AItem.FoundOwner =AItem.ExpectedOwner, LStatus );

  //Group
  LStatus :='Obtained Group: '+ AItem.FoundGroup +EOL+'Expected Group: '+ AItem.ExpectedGroup;
  bxUnixLSandSimilar.Status(LStatus);
  bxUnixLSandSimilar.Check(AItem.FoundGroup =AItem.ExpectedGroup,LStatus );
  //Date
  // Year - note that this may skipped in some cases as explained above
  if AItem.FEvaluateYear then
  begin
    LStatus := 'Obtained Year: '+ IntToStr(AItem.FFoundYear ) +EOL+'Expected Year: '+ IntToStr(AItem.ExpectedYear );
    bxUnixLSandSimilar.Status(LStatus);
    bxUnixLSandSimilar.Check(AItem.FoundYear =AItem.ExpectedYear,LStatus );
  end;
  //month
  LStatus := 'Obtained Month: '+ IntToStr(AItem.FoundMonth) +EOL+'Expected Month: '+ IntToStr(AItem.ExpectedMonth);
  bxUnixLSandSimilar.Status(LStatus);
  bxUnixLSandSimilar.Check(AItem.FoundMonth =AItem.ExpectedMonth,LStatus );
  //day
  LStatus :='Obtained Day: '+ IntToStr(AItem.FoundDay) +EOL+'Expected Day: '+ IntToStr(AItem.ExpectedDay);
  bxUnixLSandSimilar.Status(LStatus);
  bxUnixLSandSimilar.Check(AItem.FoundDay =AItem.ExpectedDay,LStatus );
  //time
  if AItem.EvaluateTime then
  begin
    //Hour
    LStatus := 'Obtained Hour: '+ IntToStr(AItem.FoundHour) +EOL+'Expected Hour: '+ IntToStr(AItem.ExpectedHour);
    bxUnixLSandSimilar.Status(LStatus);
    bxUnixLSandSimilar.Check(AItem.FoundHour =AItem.ExpectedHour, LStatus );
    //Minute
    LStatus := 'Obtained Minute: '+ IntToStr(AItem.FoundMin) +EOL+'Expected Minute: '+ IntToStr(AItem.ExpectedMin);
    bxUnixLSandSimilar.Status(LStatus);
    bxUnixLSandSimilar.Check(AItem.FoundMin =AItem.ExpectedMin, LStatus);
    //Sec
    LStatus := 'Obtained Second: '+ IntToStr(AItem.FoundSec) +EOL+'Expected Second: '+ IntToStr(AItem.ExpectedSec);
    bxUnixLSandSimilar.Status(LStatus);
    bxUnixLSandSimilar.Check(AItem.FoundSec =AItem.ExpectedSec, LStatus );

  end;
  //Size

  LStatus := 'Obtained Size: '+ IntToStr(AItem.FoundFileSize ) +EOL+'Expected Size: '+ IntToStr(AItem.ExpectedFileSize ) ;
  bxUnixLSandSimilar.Status(LStatus);
  bxUnixLSandSimilar.Check(AItem.FoundSec =AItem.ExpectedSec, LStatus );
end;

{ TFTPTestItem }

procedure TFTPTestItem.Clear;
begin
    FTestItem := '';
    FFoundParser := '';
    FExpectedParser := '';
    //note that the Unix servers can normally only report either a year
    //or a time.  This can cause ambiguity because the year is interpretted
    //according to the current or previous year if the date has passed or arrived.  But
    //because we can't know the local time zone, there can be a 24 hour window
    //of time.  E.g.  Sept 8 10:00am 2003 can be interpretted as either Sept 8 10:00am 2003 or
    //Sept 8, 2002 if in the window of Sept 7 10:00am or Sept 9 10:00am.
    //Otherwise, a date such as Sept 8: 10:00am can be interpretted differently at different
    //times of the year (when the window period has passed - 2002 or before the window 2003.
    FEvaluateTime := True;
    FEvaluateYear := True;
    //Note that with the BSD -T switch, a time can be returned with seconds

    FFoundYear := 0;
    FExpectedYear := 0;
    FFoundMonth := 0;
    FFoundDay := 0;
    FFoundHour := 0;
    FFoundMin := 0;
    FFoundSec := 0;
    FExpectedMonth := 0;
    FExpectedDay := 0;
    FExpectedHour := 0;
    FExpectedMin  := 0;
    FExpectedSec := 0;

    FFoundOwner := '';
    FExpectedOwner := '';
    FFoundGroup := '';
    FExpectedGroup := '';
    FFoundFileName := '';
    FExpectedFileName := '';

    FFoundFileSize := 0;
    FExpectedFileSize := 0;

end;

procedure TdmFTPListTest.TestItem(ATestItem, AExpectedParser,
  AExpectedFileName: String; AExpectedFileSize: Integer; AExpectedYear,
  AExpectedMonth, AExpectedDay, AExpectedHour, AExpectedMin,
  AExpectedSec: Word);
begin
  TestItem(ATestItem,AExpectedParser,'','',AExpectedFileName,AExpectedFileSize,AExpectedYear,AExpectedMonth,AExpectedDay,AExpectedHour,AExpectedMin,AExpectedSec);
end;

procedure TdmFTPListTest.TestItem(ATestItem, AExpectedParser,
  AExpectedOwner, AExpectedGroup, AExpectedFileName: String;
  AExpectedFileSize: Integer; AExpectedYear, AExpectedMonth, AExpectedDay,
  AExpectedHour, AExpectedMin, AExpectedSec: Word);
var LT : TFTPTestItem;
  LDir : TStrings;
  LDirItems : TIdFTPListItems;
  LFormat : String;
  LFTPDir : TFTPTestItem;
  LI : TIdFTPListItem;
  LDummy : Word;
begin
  LT := TFTPTestItem.Create;
  try
    LDir := TStringList.Create;
    LDirItems := TIdFTPListItems.Create;
    LDir.Add(ATestItem);
    LFTPDir := TFTPTestItem.Create;
    LFTPDir.TestItem := ATestItem;
    CheckListParse(LDir,LDirItems,LFormat);
    LFTPDir.EvaluateYear := True;
    LFTPDir.EvaluateTime := True;
    LFTPDir.FoundParser := LFormat;
    LFTPDir.ExpectedParser := AExpectedParser;
    if LDirItems.Count <> 1 then
    begin
      raise Exception.Create('Only 1 item from the parser is expected');
    end
    else
    begin
      LI := LDirItems[0];
    end;
    DecodeDate( LI.ModifiedDate,LFTPDir.FFoundYear,LFTPDir.FFoundMonth,LFTPDir.FFoundDay);
    DecodeTime( LI.ModifiedDate,LFTPDir.FFoundHour,LFTPDir.FFoundMin,LFTPDir.FFoundSec,LDummy);
    LFTPDir.FoundOwner := LI.OwnerName;
    LFTPDir.FoundGroup := LI.GroupName;
    LFTPDir.FoundFileName := LI.FileName;
    LFTPDir.FoundFileSize := LI.Size;
    LFTPDir.ExpectedYear := AExpectedYear;
    LFTPDir.ExpectedMonth := AExpectedMonth;
    LFTPDir.ExpectedDay := AExpectedDay;
    LFTPDir.ExpectedHour := AExpectedHour;
    LFTPDir.ExpectedMin := AExpectedMin;
    LFTPDir.ExpectedSec := AExpectedSec;
    LFTPDir.ExpectedOwner := AExpectedOwner;
    LFTPDir.ExpectedGroup := AExpectedGroup;
    LFTPDir.ExpectedFileName := AExpectedFileName;
    LFTPDir.ExpectedFileSize := AExpectedFileSize;
    ReportItem(LFTPDir);
  finally
    FreeAndNil(LFTPDir);
    FreeAndNil(LDirItems);
    FreeAndNil(LDir);
    FreeAndNil(LT);
  end;
end;

procedure TdmFTPListTest.TestItem(ATestItem, AExpectedParser,
  AExpectedOwner, AExpectedGroup, AExpectedFileName: String;
  AExpectedFileSize: Integer; AExpectedMonth, AExpectedDay, AExpectedHour,
  AExpectedMin, AExpectedSec: Word);
var LT : TFTPTestItem;
  LDir : TStrings;
  LDirItems : TIdFTPListItems;
  LFormat : String;
  LFTPDir : TFTPTestItem;
  LI : TIdFTPListItem;
  LDummy : Word;
begin
  LT := TFTPTestItem.Create;
  try
    LDir := TStringList.Create;
    LDirItems := TIdFTPListItems.Create;
    LDir.Add(ATestItem);
    LFTPDir := TFTPTestItem.Create;
    LFTPDir.TestItem := ATestItem;
    CheckListParse(LDir,LDirItems,LFormat);
    LFTPDir.EvaluateYear := False;
    LFTPDir.EvaluateTime := True;
    LFTPDir.FoundParser := LFormat;
    LFTPDir.ExpectedParser := AExpectedParser;
    if LDirItems.Count <> 1 then
    begin
      raise Exception.Create('Only 1 item from the parser is expected');
    end
    else
    begin
      LI := LDirItems[0];
    end;
    DecodeDate( LI.ModifiedDate,LFTPDir.FFoundYear,LFTPDir.FFoundMonth,LFTPDir.FFoundDay);
    DecodeTime( LI.ModifiedDate,LFTPDir.FFoundHour,LFTPDir.FFoundMin,LFTPDir.FFoundSec,LDummy);
    LFTPDir.FoundOwner := LI.OwnerName;
    LFTPDir.FoundGroup := LI.GroupName;
    LFTPDir.FoundFileName := LI.FileName;
    LFTPDir.FoundFileSize := LI.Size;
    LFTPDir.ExpectedMonth := AExpectedMonth;
    LFTPDir.ExpectedDay := AExpectedDay;
    LFTPDir.ExpectedHour := AExpectedHour;
    LFTPDir.ExpectedMin := AExpectedMin;
    LFTPDir.ExpectedSec := AExpectedSec;
    LFTPDir.ExpectedOwner := AExpectedOwner;
    LFTPDir.ExpectedGroup := AExpectedGroup;
    LFTPDir.ExpectedFileName := AExpectedFileName;
    LFTPDir.ExpectedFileSize := AExpectedFileSize;
    ReportItem(LFTPDir);
  finally
    FreeAndNil(LFTPDir);
    FreeAndNil(LDirItems);
    FreeAndNil(LDir);
    FreeAndNil(LT);
  end;

end;

procedure TdmFTPListTest.TestItem(ATestItem, AExpectedParser,
  AExpectedOwner, AExpectedGroup, AExpectedFileName: String;
  AExpectedFileSize: Integer; AExpectedYear, AExpectedMonth, AExpectedDay : Word);
var LT : TFTPTestItem;
  LDir : TStrings;
  LDirItems : TIdFTPListItems;
  LFormat : String;
  LFTPDir : TFTPTestItem;
  LI : TIdFTPListItem;
  LDummy : Word;
begin
  LT := TFTPTestItem.Create;
  try
    LDir := TStringList.Create;
    LDirItems := TIdFTPListItems.Create;
    LDir.Add(ATestItem);
    LFTPDir := TFTPTestItem.Create;
    LFTPDir.TestItem := ATestItem;
    CheckListParse(LDir,LDirItems,LFormat);
    LFTPDir.EvaluateYear := True;
    LFTPDir.EvaluateTime := False;
    LFTPDir.FoundParser := LFormat;
    LFTPDir.ExpectedParser := AExpectedParser;
    if LDirItems.Count <> 1 then
    begin
      raise Exception.Create('Only 1 item from the parser is expected');
    end
    else
    begin
      LI := LDirItems[0];
    end;
    DecodeDate( LI.ModifiedDate,LFTPDir.FFoundYear,LFTPDir.FFoundMonth,LFTPDir.FFoundDay);
    DecodeTime( LI.ModifiedDate,LFTPDir.FFoundHour,LFTPDir.FFoundMin,LFTPDir.FFoundSec,LDummy);
    LFTPDir.FoundOwner := LI.OwnerName;
    LFTPDir.FoundGroup := LI.GroupName;
    LFTPDir.FoundFileName := LI.FileName;
    LFTPDir.FoundFileSize := LI.Size;
    LFTPDir.ExpectedYear := AExpectedYear;
    LFTPDir.ExpectedMonth := AExpectedMonth;
    LFTPDir.ExpectedDay := AExpectedDay;
    LFTPDir.ExpectedOwner := AExpectedOwner;
    LFTPDir.ExpectedGroup := AExpectedGroup;
    LFTPDir.ExpectedFileName := AExpectedFileName;
    LFTPDir.ExpectedFileSize := AExpectedFileSize;
    ReportItem(LFTPDir);
  finally
    FreeAndNil(LFTPDir);
    FreeAndNil(LDirItems);
    FreeAndNil(LDir);
    FreeAndNil(LT);
  end;

end;

procedure TdmFTPListTest.bxWin32IISFormsTest(Sender: TBXBubble);
begin
{Note that these were taken from comments in the FileZilla source-code.

Note that no GNU source-code from that program was used in source-code.
}
  //04-27-00  09:09PM       <DIR>          DOS dir 1
  TestItem(
       '04-27-00  09:09PM       <DIR>          DOS dir 1',
       WINNTID,
       'DOS dir 1',
       0,
       2000,
       4,
       27,
       21,
       9,
       0);
  //04-14-00  03:47PM                  589 DOS file 1
//     procedure TestItem(
//       ATestItem,
//       AExpectedParser,
//       AExpectedFileName : String;
//       AExpectedFileSize : Integer;
//       AExpectedYear,
//       AExpectedMonth,
//       AExpectedDay,
//       AExpectedHour,
//       AExpectedMin,
//       AExpectedSec : Word); overload;
//Microsoft IIS using Unix format
     TestItem(
       '04-14-00  03:47PM                  589 DOS file 1',
       WINNTID,
       'DOS file 1',
       589,
       2000,
       4,
       14,
       15,
       47,
       0);
  //2002-09-02  18:48       <DIR>          DOS dir 2
     TestItem(
       '2002-09-02  18:48       <DIR>          DOS dir 2',
       WINNTID,
       'DOS dir 2',
       0,
       2002,
       9,
       2,
       18,
       48,
       0);
  //2002-09-02  19:06                9,730 DOS file 2
     TestItem(
       '2002-09-02  19:06                9,730 DOS file 2',
       WINNTID,
       'DOS file 2',
       9730,
       2002,
       9,
       2,
       19,
       6,
       0);

end;

procedure TdmFTPListTest.bxSterlingComTestsTest(Sender: TBXBubble);
begin
     TestItem(
       '-C--E-----FTP B QUA1I1      18128       41 Aug 12 13:56 QUADTEST',
       STIRCOMUNIX,
       'QUA1I1',
       '',
       'QUADTEST',
       41,
       8,
       12,
       13,
       56,
       0);
     TestItem(
       '-C--E-----FTP A QUA1I1      18128       41 Aug 12 13:56 QUADTEST2',
       STIRCOMUNIX,
       'QUA1I1',
       '',
       'QUADTEST2',
       41,
       8,
       12,
       13,
       56,
       0);
   TestItem(
       '-ARTE-----TCP A cbeodm   22159   629629 Aug 06 05:47 PSEUDOFILENAME',
       STIRCOMUNIX,
       'cbeodm',
       '',
       'PSEUDOFILENAME',
       629629,
       8,
       6,
       5,
       47,
       0);
   TestItem(
     'solution 00003444 00910368 <c3957010.zip.001>     030924-1636  A R       TCP BIN',
      STIRCOMUNIXNS,
      'solution',
      '',
      'c3957010.zip.001',
      00910368,
      2003,
      9,
      24,
      16,
      36,
      0);
   TestItem('solution 00003048 00007341 <POST1202.P1182069.R>+ 030926-0832  A RT      TCP ASC',
      STIRCOMUNIXNS,
      'solution',
      '',
      'POST1202.P1182069.R',  //filename was truncated by the dir format
      00007341,
      2003,
      9,
      26,
      8,
      32,
      0);
  {
From:
"Connect:Enterprise® UNIX Remote User’s Guide Version 2.1 " Copyright
1999, 2002, 2003 Sterling Commerce, Inc.
==
-C--E-----FTP A steve      2      41 Sep 02 13:47 test.c
-SR--M------- A steve      1     369 Sep 02 13:47 <<ACTIVITY LOG>>
Total number of batches listed: 2
==
  }
   TestItem('-C--E-----FTP A steve      2      41 Sep 02 13:47 test.c',
      STIRCOMUNIX,
      'steve',
      '',
      'test.c',
      41,
      9,
      2,
      13,
      47,
      0);
   TestItem('-SR--M------- A steve      1     369 Sep 02 13:47 <<ACTIVITY LOG>>',
      STIRCOMUNIX,
      'steve',
      '',
      '<<ACTIVITY LOG>>',
      369,
      9,
      2,
      13,
      47,
      0);
   {The proper parser is incapable of returning a date}
   TestItem('d   -   -   -  -  -  -  - steve',
      STIRCOMUNIXROOT,
      '',
      '',
      'steve',
      0,
      12,
      30,
      0,
      0,
      0);
    {Sterling Commerce Express for OS/390 tests}
    TestItem('-D 2 T VB  00244 18000 FTPGDG!PSR$TST.GDG.TSTGDG0(+01)',
      STIRCOMEXPOS390,
      '',
      '',
      'FTPGDG!PSR$TST.GDG.TSTGDG0(+01)',
      0,
      12,
      30,
      0,
      0,
      0);
    TestItem('-D 2 * VB  00244 27800 FTPV!PSR$TST.A.VVV.&REQNUMB',
      STIRCOMEXPOS390,
      '',
      '',
      'FTPV!PSR$TST.A.VVV.&REQNUMB',
      0,
      12,
      30,
      0,
      0,
      0);
    TestItem('-F 1 R -   -     -     FTPVAL1!PSR$TST.A.VVV',
      STIRCOMEXPOS390,
      '',
      '',
      'FTPVAL1!PSR$TST.A.VVV',
      0,
      12,
      30,
      0,
      0,
      0);
end;

procedure TdmFTPListTest.bxOS2TestTest(Sender: TBXBubble);
{     From: Jakarta Apache project's test suite.

        "     0           DIR   12-30-97   12:32  jbrekke",
        "     0           DIR   11-25-97   09:42  junk",
        "     0           DIR   05-12-97   16:44  LANGUAGE", 
        "     0           DIR   05-19-97   12:56  local", 
        "     0           DIR   05-12-97   16:52  Maintenance Desktop", 
        "     0           DIR   05-13-97   10:49  MPTN", 
        "587823    RSA    DIR   01-08-97   13:58  OS2KRNL", 
        " 33280      A          02-09-97   13:49  OS2LDR", 
        "     0           DIR   11-28-97   09:42  PC", 
        "149473      A          11-17-98   16:07  POPUPLOG.OS2", 
        "     0           DIR   05-12-97   16:44  PSFONTS"
}
begin
{note that some of servers are probably NOT Y2K complient}
  TestItem(
       '     0           DIR   12-30-97   12:32  jbrekke',
       OS2PARSER,
       'jbrekke',
       0,
       1997,
       12,
       30,
       12,
       32,
       0);
  TestItem(
    '             73098      A          04-06-97   15:15  ds0.internic.net1996052434624.txt',
      OS2PARSER,
      'ds0.internic.net1996052434624.txt',
      73098,
      1997,
      4,
      6,
      15,
      15,
      0);
{
  taken from the FileZilla source-code comments
 "     0           DIR   05-12-97   16:44  PSFONTS"
 "36611      A    04-23-103   10:57  OS2 test1.file"
 " 1123      A    07-14-99   12:37  OS2 test2.file"
 "    0 DIR       02-11-103   16:15  OS2 test1.dir"
 " 1123 DIR  A    10-05-100   23:38  OS2 test2.dir"
}
  TestItem(
    '     0           DIR   05-12-97   16:44  PSFONTS',
      OS2PARSER,
      'PSFONTS',
      0,
      1997,
      5,
      12,
      16,
      44,
      0);
  TestItem(
    '36611      A    04-23-103   10:57  OS2 test1.file',
      OS2PARSER,
      'OS2 test1.file',
      36611,
      2003,
      4,
      23,
      10,
      57,
      0);
  TestItem(
    ' 1123      A    07-14-99   12:37  OS2 test2.file',
    OS2PARSER,
    'OS2 test2.file',
    1123,
    1999,
    7,
    14,
    12,
    37,
    0);
  TestItem(
    '    0 DIR       02-11-103   16:15  OS2 test1.dir',
    OS2PARSER,
    'OS2 test1.dir',
    0,
    2003,
    2,
    11,
    16,
    15,
    0);
  TestItem(
    ' 1123 DIR  A    10-05-100   23:38  OS2 test2.dir',
    OS2PARSER,
    'OS2 test2.dir',
    1123,
    2000,
    10,
    5,
    23,
    38,
    0);
end;

end.
