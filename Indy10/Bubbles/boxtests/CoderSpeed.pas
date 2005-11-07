{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  20212: CoderSpeed.pas 
{
{   Rev 1.4    2003.06.24 9:00:50 PM  czhower
{ Updated to match Bubelen event signature change.
}
{
{   Rev 1.3    2003.06.14 11:09:58 PM  czhower
{ Changed category to Coders
}
{
{   Rev 1.2    2003.06.13 4:57:28 PM  czhower
{ Added UUE
}
{
{   Rev 1.1    2003.06.13 2:26:00 PM  czhower
{ update
}
{
{   Rev 1.0    2003.06.13 1:27:44 PM  czhower
{ Initial check in
}
unit CoderSpeed;

interface

uses
  IdCoder, SysUtils, Classes, BXBubble;

type
  TdmCoderSpeed = class(TDataModule)
    bublMime: TBXBubble;
    bublUUE: TBXBubble;
    procedure bublMimeTest(Sender: TBXBubble);
    procedure bublUUETest(Sender: TBXBubble);
  private
  protected
    procedure TestDecode(ADecodeClass: TIdDecoderClass; const ATestString: string);
  public
  end;

var
  dmCoderSpeed: TdmCoderSpeed;

implementation
{$R *.dfm}

uses
  IdCoderMime, IdCoderUUE;

const
  DecodeLines = 100 * 1000;

type
  TDummyStream = class(TStream)
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

procedure TdmCoderSpeed.bublMimeTest(Sender: TBXBubble);
begin
  TestDecode(TIdDecoderMime
   , 'W0Nsb3NlZCBGaWxlc10NCkZpbGVfMD1Tb3VyY2VNb2R1bGUs'
   + 'J0M6XERPQ1VNRX4xXEFETUlOSX4x');
end;

{ TDummyStream }

function TDummyStream.Read(var Buffer; Count: Integer): Longint;
begin
  Result := 0;
end;

function TDummyStream.Write(const Buffer; Count: Integer): Longint;
begin
  Result := Count;
end;

procedure TdmCoderSpeed.TestDecode(ADecodeClass: TIdDecoderClass;
  const ATestString: string);
var
  i: Integer;
  LDestStream: TDummyStream;
begin
  with ADecodeClass.Create(nil) do try
    // Dummy stream so our measurements are not hindered by output speed
    LDestStream := TDummyStream.Create; try
      DecodeBegin(LDestStream);
      for i := 1 to DecodeLines do begin
        Decode(ATestString);
      end;
      DecodeEnd;
    finally FreeAndNil(LDestStream); end;
  finally Free; end;
end;

procedure TdmCoderSpeed.bublUUETest(Sender: TBXBubble);
begin
  TestDecode(TIdDecoderUUE
   // Note the embedded ' below
   , 'M;B!O<F1E<B!T:&%T(''1H92!R96-O<F0@;V8@=&AI<R!I;F1I=FED=6%L(&UA')
end;

end.
