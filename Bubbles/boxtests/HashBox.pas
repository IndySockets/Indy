{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11253: HashBox.pas 
{
{   Rev 1.0    11/12/2002 09:18:10 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit HashBox;

interface

uses
  IndyBox,
  IdHash, IdHashCRC, IdHashElf, IdHashMessageDigest;

const
  MaxMemToLoad = 16777216; // 16MB

type
  THashBox = class(TIndyBox)
  public
    procedure Test; override;
  end;

implementation

uses
  Classes,
  IdGlobal,
  SysUtils;

{ THashBox }

procedure THashBox.Test;
const
  CHashTests = 6;
var
  FHash16 : TIdHash16;
  FHash32 : TIdHash32;
  FHashMD2 : TIdHash128;
  FHashMD4 : TIdHash128;
  FHashMD5 : TIdHash128;
  FHashElf : TidHashElf;
  
  finddata: TSearchRec;
  FS : TFileStream;
  MS : TMemoryStream;
  TS : TStream;
  TestData : TStringList;
  i : Integer;
  H16 : Word;
  H32 : LongWord;
  H128 : T4x4LongWordRecord;

  function ToHex : String;
  var
    T128 : T128BitRecord;
    i : Integer;
  begin
    result := '';
    Move(H128, T128, 16);
    for i := 0 to 15 do
    begin
      result := result + IntToHex(T128[i], 2);
    end;
  end;

begin
  FHash16 := TIdHashCRC16.Create;
  FHash32 := TIdHashCRC32.Create;
  FHashMD2 := TIdHashMessageDigest2.Create;
  FHashMD4 := TIdHashMessageDigest4.Create;
  FHashMD5 := TIdHashMessageDigest5.Create;
  FHashElf := TIdHashElf.Create;
  TestData := TStringList.Create;
  i:= 0;
  try
    if FindFirst(GetDataDir + '*.ini', faAnyFile - faDirectory, finddata) = 0 then begin
      repeat
          inc(i);
          Status('Test ' + IntToStr(i) + ': ' + finddata.Name);

          TestData.LoadFromFile(GetDataDir + finddata.Name);
          if TestData.Count < CHashTests then
          begin
            raise Exception.Create('Insufficient test results in .ini for tests');
          end;

          // Change the extension to .dat
          FS := TFileStream.Create(GetDataDir+ChangeFileExt(finddata.Name, '.dat'), fmOpenRead or fmShareDenyNone);
          TS := FS;
          MS := TMemoryStream.Create;
          if FS.Size <= MaxMemToLoad then
          begin
            MS.LoadFromStream(FS);
            TS := MS;
          end;

          try
            // CRC-16
            H16 := FHash16.HashValue(TS);
            Status('HashCRC16, expected: ' + TestData[0] + ', got: '
              + IntToHex(H16, 4));
            Check(AnsiSameText(IntToHex(H16, 4), TestData[0]), 'Failed on HashCRC16.');

            // CRC-32
            TS.Seek(0, soFromBeginning);
            H32 := FHash32.HashValue(TS);
            Status('HashCRC32, expected: ' + TestData[1] + ', got: '
              + IntToHex(H32, 8));
            Check(AnsiSameText(IntToHex(H32, 8), TestData[1]), 'Failed on HashCRC32.');

            // MD2
            TS.Seek(0, soFromBeginning);
            H128 := FHashMD2.HashValue(TS);
            Status('HashMD2, expected: ' + TestData[2] + ', got: '
              + ToHex);
            Check(AnsiSameText(ToHex, TestData[2]), 'Failed on HashMD2.');

            // MD4
            TS.Seek(0, soFromBeginning);
            H128 := FHashMD4.HashValue(TS);
            Status('HashMD4, expected: ' + TestData[3] + ', got: '
              + ToHex);
            Check(AnsiSameText(ToHex,  TestData[3]), 'Failed on HashMD4.');

            // MD5
            TS.Seek(0, soFromBeginning);
            H128 := FHashMD5.HashValue(TS);
            Status('HashMD5, expected: ' + TestData[4] + ', got: '
              + ToHex);
            Check(AnsiSameText(ToHex,  TestData[4]), 'Failed on HashMD5.');

            // Elf
            TS.Seek(0, soFromBeginning);
            H32 := FHashElf.HashValue(TS);
            Status('HashElf, expected: ' + TestData[5] + ', got: '
              + IntToHex(H32, 8));
            Check(AnsiSameText(IntToHex(H32, 8),  TestData[5]), 'Failed on HashElf.');
          finally
            FreeAndNil(FS);
            FreeAndNil(MS);
          end;

      until FindNext(finddata) <> 0;
      FindClose(finddata);
    end;
  finally
    FreeAndNil(TestData);
    FreeAndNil(FHash16);
    FreeAndNil(FHash32);
    FreeAndNil(FHashMD2);
    FreeAndNil(FHashMD4);
    FreeAndNil(FHashMD5);
    FreeAndNil(FHashElf);
  end;
end;

initialization
  TIndyBox.RegisterBox(THashBox, 'Hash', 'Misc');
end.
