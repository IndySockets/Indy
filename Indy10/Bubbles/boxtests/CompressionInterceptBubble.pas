{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  21055: CompressionInterceptBubble.pas }
{
    Rev 1.0    6/26/2003 1:10:06 PM  BGooijen
  Initial checkin
}
unit CompressionInterceptBubble;

interface

uses
  SysUtils, Classes, BXBubble, Forms;

type
  TdmodCompressionInterceptBubble = class(TDataModule)
    bublCompressionIntercept: TBXBubble;
    procedure bublCompressionInterceptTest(Sender: TBXBubble);
  private
  protected
  public
  end;

var
  dmodCompressionInterceptBubble: TdmodCompressionInterceptBubble;

implementation
{$R *.dfm}

uses
  IdCompressionIntercept;

function CompareStreams(StreamA,StreamB:TStream):boolean;
var
  LBufferA,
  LBufferB: array[0..1023] of char;
  LSize:integer;
begin
  result:=StreamA.size=StreamB.size;
  while result and (StreamA.Position<StreamA.Size) do begin
    LSize:=StreamA.Read(LBufferA,sizeof(LBufferA));
    StreamB.Read(LBufferB,sizeof(LBufferB));
    result:=CompareMem(@LBufferA,@LBufferB,LSize);
  end;
end;


procedure TdmodCompressionInterceptBubble.bublCompressionInterceptTest(
  Sender: TBXBubble);
var
  LCompressor:TIdCompressionIntercept;
  LDecompressor:TIdCompressionIntercept;
  LCompressedStream:TMemoryStream;
  LDecompressedStream:TMemoryStream;
begin
  LCompressor:=TIdCompressionIntercept.Create(nil);
  try
    LDecompressor:=TIdCompressionIntercept.Create(nil);
    try
      LCompressor.CompressionLevel := 9;
      LDecompressor.CompressionLevel := 9;
      LCompressedStream:=TMemoryStream.Create;
      LDecompressedStream:=TMemoryStream.Create;
      try
        LDecompressedStream.LoadFromFile(paramstr(0));
        LCompressedStream.CopyFrom(LDecompressedStream,0);
        LCompressedStream.Position:=0;
        LDecompressedStream.Position:=0;
        LCompressor.Send(LCompressedStream);
        LCompressedStream.Position:=0;
        LDecompressor.Receive(LCompressedStream);
        LCompressedStream.Position:=0;
        Sender.Check( LCompressedStream.size=LDecompressedStream.size, 'Sizes do not match');
        Sender.Check( CompareStreams(LCompressedStream,LDecompressedStream), 'Stream data does not match');
      finally
        FreeAndNil(LCompressedStream);
        FreeAndNil(LDecompressedStream);
      end;
    finally
      FreeAndNil(LDecompressor);
    end;
  finally
    FreeAndNil(LCompressor);
  end;
end;

end.
