{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  18012: MakeCanonicalIPv6AddressBox.pas }
{
{   Rev 1.4    2003.07.11 4:07:44 PM  czhower
{ Removed deprecated BXBoxster reference.
}
{
{   Rev 1.3    6/24/2003 01:13:46 PM  JPMugaas
{ Updates for minor API change.
}
{
{   Rev 1.2    2003.04.13 9:36:14 PM  czhower
}
{
    Rev 1.1    4/12/2003 11:24:28 PM  BGooijen
}
unit MakeCanonicalIPv6AddressBox;

interface

{$I IdCompilerDefines.inc}

uses
  SysUtils, Classes, BXBubble, Forms;

type
  TdmodMakeCanonicalIPv6Address = class(TDataModule)
    MakeCanonicalIPv6Address: TBXBubble;
    procedure MakeCanonicalIPv6AddressTest(Sender: TBXBubble);
  private
  public
  end;

var
  dmodMakeCanonicalIPv6Address: TdmodMakeCanonicalIPv6Address;

implementation
{$R *.dfm}

uses
  IdCoreGlobal;

procedure TdmodMakeCanonicalIPv6Address.MakeCanonicalIPv6AddressTest(Sender: TBXBubble);
var
  i:integer;
  LTest:string;
  LResult:string;
  LTestResult:string;
begin
  with MakeCanonicalIPv6Address do begin
    with TStringList.Create do try
      LoadFromFile(DataDir + 'MakeCanonicalIPv6Address.dat');
      for i := 0 to (Count div 2) - 1 do begin
        LTest:=Strings[i*2];
        Status('Testing "'+LTest+'"');
        LResult:=Strings[i*2+1];
        LTestResult:=IdCoreGlobal.MakeCanonicalIPv6Address(LTest);
        Check(LResult=LTestResult,'MakeCanonicalIPv6Address failed on "'+LTest+'", expected "'+LResult+'", got "'+LTestResult+'"');
      end;
    finally Free; end;
  end;
end;

end.
