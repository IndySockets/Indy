{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11265: IdReadLineStream.pas 
{
    Rev 1.1    4/4/2003 7:54:50 PM  BGooijen
  compiles again
}
{
{   Rev 1.0    11/12/2002 09:19:04 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit IdReadLineStream;

interface
uses Classes;


const
  LBUFMAXSIZE = 2048;

type
  TIdWriteLineStream = class (TStream)
  // IMPORTANT!!!!!!!!
  // NO data members may exist in this class
  // This class is used to "hackcast" a TStream to add functionality
  public
    procedure Write(const AData: string); reintroduce;
    procedure WriteLn(const AData: string = '');    {Do not Localize}
  end;

  TIdReadLineStream = class (TStream)
  protected
    {
This stream type really should be created only for data that has already been completely
loaded into the Source stream.  The reason is that Writes will throw this off due to
the persistant internal buffering used.  It might not be worth fixing. The buffering is
important as it prevents us from making repeated reads for the same data which does
happen with the TIdStream typecast hack.

To explain, take this data:

Line One<EOL>
Line Two<EOL>

Line Two EOL has to be read twice because the regular stream does not know where the EOL was
so it had to load that text twice (once for the first ReadLn and the other for the second ReadLn.
}
    FSourceStream : TStream;
    FBuffer : Array [0..LBUFMAXSIZE] of char;
    FBufSize : Integer;
    FBufferOffset : Integer;
    FStreamSize : Integer;
  public
    constructor Create(ASourceStream : TStream);
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function FindEOL(var ACrEncountered: Boolean): String;
    function ReadLn : String;
  //  procedure WriteStr(const AData: string); overload;
  //  procedure WriteLn(const AData: string = '');
    property SourceStream : TStream read FSourceStream;
  end;

implementation
uses IdCoreGlobal, IdGlobal, SysUtils, IdTCPStream;

{ TIdReadLineStream }

constructor TIdReadLineStream.Create(ASourceStream: TStream);
begin
  inherited Create;
  FSourceStream := ASourceStream;
  FBufSize := 0;
  FBufferOffset := 0;
  FStreamSize := FSourceStream.Size;
end;

function TIdReadLineStream.Read(var Buffer; Count: Integer): Longint;
begin
  if (Count > 0) then
  begin
    Result := FSourceStream.Read(Buffer,Count);
  end
  else
  begin
    Result := 0;
  end;
end;

function TIdReadLineStream.ReadLn: String;
var
  LCrEncountered : Boolean;
  LBytesToRead : Integer; //stream size - Position
  LStreamPos : Integer;
begin
  Result := '';
  if InheritsFrom(TIdTCPStream) then begin
    Result := TIdTCPStream(Self).Connection.iohandler.ReadLn;
  end
  else
  begin
    LCrEncountered := False;
    while (LCrEncountered = False) do
    begin
      Result := Result + FindEOL(LCrEncountered);
      LStreamPos := FSourceStream.Position;
      LBytesToRead := FStreamSize - LStreamPos;
      if LBytesToRead > 0 then
      begin
        if (FBufferOffset = FBufSize) then
        begin
          FBufSize := Min(LBytesToRead,LBUFMAXSIZE);
          FBufferOffset := 0;
          FSourceStream.ReadBuffer(FBuffer[0], FBufSize);
        end;
      end
      else
      begin
        Exit;
      end;
    end;
  end;
end;

{procedure TIdReadLineStream.WriteStr(const AData: string);
begin
  if Length(AData) > 0 then begin
    FSourceStream.WriteBuffer(AData[1], Length(AData));
  end;
end;   }

function TIdReadLineStream.Write(const Buffer; Count: Integer): Longint;
begin
{  if (Count > 0) then
  begin
    Result := FSourceStream.Write(Buffer,Count);
    FStreamSize := FStreamSize + Result;
  end
  else
  begin
    Result := 0;
  end;    }

  Result := 0;
end;

{procedure TIdReadLineStream.WriteLn(const AData: string);
begin
  WriteStr(AData + EOL);
end; }

function TIdReadLineStream.FindEOL(
  var ACrEncountered: Boolean): String;
var i : Integer;
    LStringSize : Integer;
    LOldOffset : Integer;
begin
  Result := '';
  i := FBufferOffset;
  LOldOffset := i;
  LStringSize := (FBufSize - FBufferOffset);
  while i <= FBufSize do
  begin
    case FBuffer[i] of
      CR : begin
             LStringSize := i - FBufferOffset;
             FBufferOffset := i;
             Inc(FBufferOffset);
             if (i < FBufSize) and (FBuffer[i+1]=LF) then
             begin
               Inc(FBufferOffset);
             end;
             ACrEncountered := True;
             Break;
           end;
      LF : begin
             LStringSize := i - FBufferOffset;
             FBufferOffset := i;
             Inc(FBufferOffset);
             ACrEncountered := True;
             Break;
           end;
         end;
         Inc(i);
    end;
    if ACrEncountered then
    begin
    //  Dec(LStringSize);
      SetLength(Result,LStringSize);
      Move(FBuffer[LOldOffset],Result[1],LStringSize);
    end
    else
    begin
      FBufferOffset := FBufSize;
      SetLength(Result,LStringSize);
      Move(FBuffer[LOldOffset],Result[1],LStringSize);
    end;
end;

function TIdReadLineStream.Seek(Offset: Integer; Origin: Word): Longint;
begin
//  Result := FSourceStream.Seek(Offset, Origin );
  Result := -1;
end;

{ TIdWriteLineStream }

procedure TIdWriteLineStream.Write(const AData: string);
begin
  if Length(AData) > 0 then begin
    WriteBuffer(AData[1], Length(AData));
  end;
end;

procedure TIdWriteLineStream.WriteLn(const AData: string);
begin
  Write(AData + EOL);
end;

end.
