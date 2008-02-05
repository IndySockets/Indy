{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11267: IdStreamTest.pas 
{
{   Rev 1.0    11/12/2002 09:19:20 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit IdStreamTest;

interface
uses IndyBox, classes;

type
  TIdStreamTest = class(TIndyBox)
    procedure MakeFile(const AFileName, AEOL : String);
    procedure MakeFiles(APath : String);
    procedure TestStrings(const AStrings: String; ARes : TStrings);
    procedure TestStr(const AString : String);
    procedure FileReadTimeTest(const AFileName : String);
    procedure FileReadReliabilityTest(const AFileName : String);
    procedure FileTests;
    procedure Test; override;
  end;

const
  FileNumLines = 10000; //10,000 lines for a speed test - INSANE!!!
  FileTextLine = 'test';

implementation
uses IdCoreGlobal, IdGlobal, IdStream, IdReadLineStream, SysUtils;

const FNameEOL = 'CRLF.txt';
      FNameLFCR = 'LFCR.txt';
      FNameLF = 'LF.txt';
      FNameCR = 'CR.txt';

const
      Line1 = 'Test';
      Line2 = 'Test Two';
      Line3 = 'Test Three';

      EmtrpyString : String = '';
      RegularString : String = Line1+EOL+Line2+EOL+Line3+EOL;
      LFCRString : String = Line1+LF+CR+Line2+LF+CR+Line3+LF+CR;
      CRString : String = Line1+CR+Line2+CR+Line3+CR;
      LFString : String = Line1+LF+Line2+LF+Line3+LF;
      CRLFString : String = Line1+LF+Line2+CR+Line3+LF;
{ TIdStreamTest }

procedure TIdStreamTest.FileReadReliabilityTest(const AFileName: String);
var m : TMemoryStream;
    sp : TIdReadLineStream;
    s : String;
//    StartTime : Cardinal;
    LineCount : Cardinal;
const MaxLines =  FileNumLines + 1;
begin
{  m := TMemoryStream.Create;
  try
    m.LoadFromFile( AFileName );
    m.Position := 0;
    LineCount := 0;
    repeat
      s := TIdStream(m).ReadLn;
      Check(s=FileTextLine,Format('%s does not match %s - Line %d',[s,FileTextLine,LineCount]));
      inc(LineCount);
    until LineCount =  MaxLines;
    Dec(LineCount);//correct for empty line returned at end
    Status(Format('TIdStream typecast- FileName: %s - %d millaseconds for %d line(s)',[AFileName,StartTime,LineCount]));
  finally                            
    FreeAndNil(m);
  end;
}
  m := TMemoryStream.Create;

  try
    m.LoadFromFile( AFileName );
    m.Position := 0;
    LineCount := 0;
    sp := TIdReadLineStream.Create(m);
    repeat
      s := sp.ReadLn;
      inc(LineCount);
    until LineCount =  MaxLines;
  //  Dec(LineCount);//correct for empty line returned at end
  finally
    FreeAndNil(m);
    FreeAndNil(sp);
  end;
end;

procedure TIdStreamTest.FileReadTimeTest(const AFileName : String);
var m : TMemoryStream;
    sp : TIdReadLineStream;
    s : String;
    StartTime : Cardinal;
    LineCount : Cardinal;
const MaxLines =  FileNumLines + 1;
begin
  m := TMemoryStream.Create;
  try
    m.LoadFromFile( AFileName );
    m.Position := 0;
    LineCount := 0;
    StartTime := GetTickCount;
    repeat
      s := TIdStream(m).ReadLn;
      inc(LineCount);
    until LineCount =  MaxLines;
    StartTime := GetTickCount - StartTime;
    Dec(LineCount);//correct for empty line returned at end
    Status(Format('TIdStream typecast- FileName: %s - %d millaseconds for %d line(s)',[AFileName,StartTime,LineCount]));
  finally                            
    FreeAndNil(m);
  end;

  m := TMemoryStream.Create;

  try
    m.LoadFromFile( AFileName );
    m.Position := 0;
    LineCount := 0;
    sp := TIdReadLineStream.Create(m);
    StartTime := GetTickCount;
    repeat
      s := sp.ReadLn;
      inc(LineCount);
    until LineCount =  MaxLines;
    StartTime := GetTickCount - StartTime;
    Dec(LineCount);//correct for empty line returned at end
    Status(Format('TIdReadLineStream - FileName: %s - %d millaseconds for %d line(s)',[AFileName,StartTime,LineCount]));
  finally
    FreeAndNil(m);
    FreeAndNil(sp);
  end;
end;

procedure TIdStreamTest.FileTests;
var
  LPath : String;
begin
  LPath := IncludeTrailingSlash(GetTempDir);
  MakeFiles(LPath);
end;

procedure TIdStreamTest.MakeFile(const AFileName, AEOL: String);
var i : Cardinal;
    f : Text;
begin
  AssignFile(f,AFileName);
  Rewrite(f);
  try
    for i := 1 to FileNumLines do
    begin
      Write(f,FileTextLine+AEOL);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TIdStreamTest.MakeFiles(APath : String);
begin
  MakeFile(APath+FNameEOL,EOL);
  MakeFile(APath+FNameLFCR,LF+CR);
  MakeFile(APath+FNameLF,LF);
  MakeFile(APath+FNameCR,CR);

  FileReadTimeTest(APath+FNameEOL);
  FileReadReliabilityTest(APath+FNameEOL);
  FileReadTimeTest(APath+FNameLFCR);
  FileReadReliabilityTest(APath+FNameLFCR);
  FileReadTimeTest(APath+FNameLF);
  FileReadReliabilityTest(APath+FNameLF);
  FileReadTimeTest(APath+FNameCR);
  FileReadReliabilityTest(APath+FNameCR);

  DeleteFile(APath+FNameEOL);
  DeleteFile(APath+FNameLFCR);
  DeleteFile(APath+FNameLF);
  DeleteFile(APath+FNameCR);
end;

procedure TIdStreamTest.Test;
var st : TStrings;
begin
  inherited;
  // emtpy string test

  Status('Emtpy string');
  TestStr(EmtrpyString);
  st := TStringList.Create;
  try
    st.Add(Line1);
    st.Add(Line2);
    st.Add(Line3);
  //  Status('Lines with CRLF endings');
 //   TestStrings(RegularString,st);

    Status('Lines with CR endings');
    TestStrings(CRString,st);
    Status('Lines with LF endings');
    TestStrings(LFString,st);
    Status('Lines with CR or LF endings');
    TestStrings(CRLFString,st);
    st.Text := StringReplace(st.Text,EOL,EOL+EOL,[rfReplaceAll]);
    Status('Lines with LFCR line-ending');
    TestStrings(LFCRString,st);

  finally
    FreeAndNil(st);
  end;
  FileTests;
end;

procedure TIdStreamTest.TestStr(const AString : String);
var M : TStream;
    s : String;
begin
  m := TMemoryStream.Create;
  try
    if AString<>'' then
    begin
      m.Write(AString[1],Length(AString));
    end;
    m.Position := 0;
    s :=  TIdStream(m).ReadLn;
    Check((s = AString),Format('%s does not match %s',[s, AString]));
  finally
    FreeAndNil(m);
  end;
end;

procedure TIdStreamTest.TestStrings(const AStrings: String; ARes : TStrings);
var M : TStream;
    s : String;
    i : Integer;
    sp : TIdReadLineStream;
begin
  sp := nil;
  m := TMemoryStream.Create;
  try
    if AStrings<>'' then
    begin
      m.Write(AStrings[1],Length(AStrings));
    end;
    m.Position := 0;
    for i := 0 to ARes.Count-1 do
    begin
      s :=  TIdStream(m).ReadLn;
      Check((s = ARes[i]),Format('%s does not match %s',[s, ARes[i] ]));
    end;
  finally
    FreeAndNil(m);
  end;
   m := TMemoryStream.Create;

  try
    if AStrings<>'' then
    begin
      m.Write(AStrings[1],Length(AStrings));
    end;
    m.Position := 0;
    sp := TIdReadLineStream.Create(m);
    for i := 0 to ARes.Count-1 do
    begin
      s :=  sp.ReadLn;
      Check((s = ARes[i]),Format('%s does not match %s',[s, ARes[i] ]));
    end;
  finally
    FreeAndNil(m);
    FreeAndNil(sp);
  end;
end;

initialization
  TIndyBox.RegisterBox(TIdStreamTest, 'IdStream Test', 'Misc');
end.
