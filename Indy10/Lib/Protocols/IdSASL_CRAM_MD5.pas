{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  18903: IdSASL_CRAM_MD5.pas
{
{   Rev 1.9    2004.02.07 5:03:08 PM  czhower
{ .net fixes.
}
{
{   Rev 1.8    2004.02.03 5:45:42 PM  czhower
{ Name changes
}
{
{   Rev 1.7    30/1/2004 4:48:52 PM  SGrobety
{ Fix problem in win32 version. Now works in both world
}
{
{   Rev 1.6    1/30/2004 11:57:42 AM  BGooijen
{ Compiles in D7
}
{
{   Rev 1.5    29/1/2004 6:08:58 PM  SGrobety
{ Now with extra crunchy DotNet compatibility!
}
{
{   Rev 1.4    1/21/2004 3:31:18 PM  JPMugaas
{ InitComponent
}
{
    Rev 1.3    10/19/2003 5:57:14 PM  DSiders
  Added localization comments.
}
{
    Rev 1.2    5/15/2003 10:24:04 PM  BGooijen
  Added IdGlobal to uses for pbyte on D5
}
{
{   Rev 1.1    11/5/2003 10:58:54 AM  SGrobety
{ Indy implementation of the CRAM-MD5 authentication protocol
}
{
{   Rev 1.0    10/5/2003 10:00:00 AM  SGrobety
{ Indy implementation of the CRAM-MD5 authentication protocol
}
unit IdSASL_CRAM_MD5;

// S.G. 9/5/2003: First implementation of the CRAM-MD5 authentication algorythm
// S.G. 9/5/2003: Refs: RFC 1321 (MD5)
// S.G. 9/5/2003:       RFC 2195 (IMAP/POP3 AUTHorize Extension for Simple Challenge/Response)
// S.G. 9/5/2003:       IETF draft draft-ietf-ipsec-hmac-md5-txt.00
{$I IdCompilerDefines.inc}

interface

uses
  Classes, IdSASL,
  IdSASLUserPass, IdCoderMIME;

type


  TIdSASLCRAMMD5 = class(TIdSASLUserPass)
  public
    class function BuildKeydMD5Auth(const Password, Challenge: string): string;
    class function ServiceName: TIdSASLServiceName; override;

    function StartAuthenticate(const AChallenge:string) : String; override;
    function ContinueAuthenticate(const ALastResponse: String): String;
      override;
  end;

implementation

uses
  IdGlobal, IdGlobalProtocols, IdHashMessageDigest, IdHash, SysUtils, idBuffer;

{ TIdSASLCRAMMD5 }

class function TIdSASLCRAMMD5.BuildKeydMD5Auth(const Password,  Challenge: string): string;
var
  AKey, ASecret,
  WorkBuffer, opad, ipad: TMemoryStream;
  Ahasher: TIdHashMessageDigest5;
  Buffer: T4x4LongWordRecord;
  // Hashes a stream and place the result in another stream
  procedure _HashStream(Src, Dest: TMemoryStream; SrcSize: Integer);
  begin
    Src.position := 0;
    Buffer := Ahasher.HashValue(Src);
    Dest.Size := 0;
    WriteTIdBytesToStream(Dest,ToBytes(Buffer[0]));
    WriteTIdBytesToStream(Dest,ToBytes(Buffer[1]));
    WriteTIdBytesToStream(Dest,ToBytes(Buffer[2]));
    WriteTIdBytesToStream(Dest,ToBytes(Buffer[3]));
    Dest.Position := 0;
    // Dest.Seek(0, soFromBeginning);
  end;
  // Takes an input stream (Pad) and XOR the beginning with another "key" stream
  procedure _XORStringPad(Key, Pad: TMemoryStream);
  var
    I: Integer;
//    Selector: Integer;
  begin
    //APadSelector := 0;//Pad.Memory;
    //AKeySelector := 0;//Key.Memory;
    for I := 0 to Key.Size - 1 do    // Iterate
    begin
      TIdBytes(Pad.Memory)[i] := TIdBytes(Key.Memory)[i] XOR TIdBytes(Pad.Memory)[i]
{      APadSelector^ := Byte(APadSelector^) XOR Byte(AKeySelector^);
      inc(APadSelector);
      inc(AKeySelector);}
    end;    // for
  end;
  // Creates the necessary streams for the function
  procedure _IniStreams;
  begin
    AKey := TMemoryStream.Create;
    ASecret := TMemoryStream.Create;
    WorkBuffer := TMemoryStream.Create;
    opad := TMemoryStream.Create;
    ipad := TMemoryStream.Create;
  end;
  // Release allocated streams
  procedure _ReleaseStreams;
  begin
    if assigned(AKey) then
      FreeAndNil(AKey);
    if assigned(ASecret) then
      FreeAndNil(ASecret);
    if assigned(WorkBuffer) then
      FreeAndNil(WorkBuffer);
    if assigned(opad) then
      FreeAndNil(opad);
    if assigned(ipad) then
      FreeAndNil(ipad);
  end;
  // Zero out a memory zone
  procedure IdZeroMemory(Dest: TIdbytes; Length: Integer);
  begin
    CopyTIdBytes(ToBytes(StringOfChar(#0, Length)), 0, Dest, 0, Length);
  end;
begin
  Ahasher := TIdHashMessageDigest5.Create;
  try
    _IniStreams;
    try
      // Copy the key and secret data into the buffers.
      // The key MUST be <=64 byte long and padded with zeros to 64 bytes
      // In POP3/IMAP4, the "key" is actually the user's password
      // Ideally, the key is exactly 16 bytes long. Shorter keys makes the
      // system less secure while longuer key do not really add to security
      AKey.Size := 64;
      IdZeroMemory(AKey.Memory, AKey.Size);
      if Length(Password) > 64 then
      begin
        // Key is longuer than 64 bytes
        // Use the MD5 summ of key instead
        Buffer := Ahasher.HashValue(Password);
        WriteTIdBytesToStream(AKey,ToBytes(Buffer[0]));
        WriteTIdBytesToStream(AKey,ToBytes(Buffer[1]));
        WriteTIdBytesToStream(AKey,ToBytes(Buffer[2]));
        WriteTIdBytesToStream(AKey,ToBytes(Buffer[3]));
      end
      else
        WriteStringToStream(AKey,Password);

      // The secret can be as long as one wishes
      // In POP3/IMAP4 AUTH, it is the challenge sent by the server
      WriteStringToStream(ASecret,Challenge);

      // Initialize the inner pad
      WriteStringToStream(ipad,StringOfChar(#$36, 64));
      // XOR the inner pad and the string
      _XORStringPad(AKey, ipad);
      // Add the key at the end of the pad
      ipad.Position := 64; //Seek(0, soFromEnd);
      ASecret.Position := 0;
      WriteMemoryStreamToStream(Asecret, ipad, ASecret.Size);

      // Compute the MD5 hash of the result
      _HashStream(ipad, WorkBuffer, ipad.Size);

      // Initialize the outer pad
      WriteStringToStream(opad,StringOfChar(#$5c, 64));


      // XOR the outer pad with the key
      _XORStringPad(AKey, opad);

      // Add the result of the inner calculation to the end of the outer pad
      opad.Position := opad.Size;
      WriteMemoryStreamToStream(WorkBuffer, opad, WorkBuffer.Size);
//      opad.WriteBuffer(WorkBuffer.memory^, WorkBuffer.Size);
      opad.Position := 0;
      // Compute the hash of the hashed inner padded string and the outter padded string
      WorkBuffer.Size := 0;

      _HashStream(opad, WorkBuffer, opad.Size);
      opad.Position := 0;
      result := LowerCase(Ahasher.AsHex(Ahasher.HashValue(opad)));

      // S.G. 10/5/2003: ToDo: zero the memory so that sensitve info do not stay in memory
    finally
      _ReleaseStreams;
    end;
  finally
    Ahasher.Free;
  end;
end;

function TIdSASLCRAMMD5.ContinueAuthenticate(
  const ALastResponse: String): String;
begin

end;

class function TIdSASLCRAMMD5.ServiceName: TIdSASLServiceName;
begin
  result := 'CRAM-MD5'; {do not localize}
end;

function TIdSASLCRAMMD5.StartAuthenticate(
  const AChallenge: string): String;
var
  Digest: String;
begin
  if Length(AChallenge) > 0 then
  begin
    Digest := GetUsername + ' ' + BuildKeydMD5Auth(GetPassword, AChallenge);
    result := Digest;
  end
  else
    result := '';
end;

end.
