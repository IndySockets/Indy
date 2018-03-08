{
 * Simple WebSocket client for Delphi
 * http://www.websocket.org/echo.html
 * Author: Lucas Rubian Schatz
 * Copyright 2018, Indy Working Group.
 *
 * Date: 22/02/2018

 TODO: implement methods for sending and receiving binary data, and support for bigger than 65536 bytes support
}
{
Sample code:
//var lSWC:TIdSimpleWebSocketClient;
...
begin
  lSWC := TIdSimpleWebSocketClient.Create(self);
  lSWC.onDataEvent           := self.lSWC1DataEvent;  //TSWSCDataEvent
  lSWC.AutoCreateHandler := false; //you can set this as true in the majority of Websockets with ssl
  if not lSWC.AutoCreateHandler then
  begin
    if lSWC.IOHandler=nil then
      lSWC.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(lSWC);
    (lSWC.IOHandler as TIdSSLIOHandlerSocketOpenSSL).SSLOptions.Mode := TIdSSLMode.sslmClient;
    (lSWC.IOHandler as TIdSSLIOHandlerSocketOpenSSL).SSLOptions.SSLVersions := [TIdSSLVersion.sslvTLSv1, TIdSSLVersion.sslvTLSv1_1, TIdSSLVersion.sslvTLSv1_2];
  end;
  lSWC.Connect('wss://echo.websocket.org');
  lSWC.writeText('!!It worked!!');
end;

}

unit IdWebSocketSimpleClient;

interface

uses Classes, System.SysUtils, IdSSLOpenSSL, IdTCPClient, IdGlobal, IdCoderMIME,
     IdHash, IdHashSHA, math, System.threading, DateUtils, System.SyncObjs, IdURI;
Type
  TSWSCDataEvent = procedure(Sender: TObject; const Text: string) of object;
  TSWSCErrorEvent = procedure(Sender: TObject; exception:Exception;const Text: string; var forceDisconnect) of object;

  TIdSimpleWebSocketClient = class(TIdTCPClient)
  private
    ExpectedSec_WebSocket_Accept: string;
    FHeartBeatInterval: Cardinal;
    FAutoCreateHandler: Boolean;
    FURL: String;
    function generateWebSocketKey():String;
  protected
    lInternalLock:TCriticalSection;
    //get if a particular bit is 1
    function Get_a_Bit(const aValue: Cardinal; const Bit: Byte): Boolean;
    //set a particular bit as 1
    function Set_a_Bit(const aValue: Cardinal; const Bit: Byte): Cardinal;

    function readFromSocket:boolean;virtual;
    function encodeFrame(pMsg:String; pPong:Boolean=false):TIdBytes;
    function encodePong:TidBytes;
    function verifyHeader(pHeader:TStrings):boolean;
    procedure startHeartBeat;

  published
  public
    onDataEvent:TSWSCDataEvent;
    onConnectionDataEvent:TSWSCDataEvent;
    onPing:TNotifyEvent;
    onError:TSWSCErrorEvent;
    onHeartBeatTimer:TNotifyEvent;
    function Connected: Boolean; overload;
    procedure Close;
    property URL: String read FURL write FURL;
    property HeartBeatInterval: Cardinal read FHeartBeatInterval write FHeartBeatInterval;
    property AutoCreateHandler: Boolean read FAutoCreateHandler write FAutoCreateHandler;
    procedure writeText(pMsg:String);
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure Connect(pURL:String);overload;

end;

implementation

{ TIdSimpleWebSocketClient }

procedure TIdSimpleWebSocketClient.Close;
begin
  self.lInternalLock.Enter;
  try
    if self.Connected then
    begin
      self.IOHandler.InputBuffer.Clear;
      self.IOHandler.CloseGracefully;
      self.Disconnect;
      if assigned(self.OnDisconnected) then
        self.OnDisconnected(self);
    end;
  finally
    self.lInternalLock.Leave;
  end
end;

function TIdSimpleWebSocketClient.generateWebSocketKey():String;
var rand:TidBytes;
  I: Integer;
begin
  SetLength(rand, 16);
  for I := low(rand) to High(rand) do
    rand[i] := byte(random(255));

  result := TIdEncoderMIME.EncodeBytes(rand);  //generates a random Base64String
  self.ExpectedSec_WebSocket_Accept := Result + '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'; //fixed string, see: https://tools.ietf.org/html/rfc6455#section-1.3

  with TIdHashSHA1.Create do
  try

    ExpectedSec_WebSocket_Accept := TIdEncoderMIME.EncodeBytes(HashString( self.ExpectedSec_WebSocket_Accept ));
  finally
    Free;
  end;
end;

function TIdSimpleWebSocketClient.Connected: Boolean;
begin
  result := false;  //for some reason, if its not connected raises an error after connection lost!
  try
    result := inherited;
  except
  end
end;

procedure TIdSimpleWebSocketClient.Connect(pURL: String);
var  URI      : TIdURI;
     lSecure  : Boolean;
begin
  try
    URI           := TIdURI.Create(pURL);
    self.URL      := pURL;
    self.Host     := URI.Host;
    URI.Protocol  := ReplaceOnlyFirst(URI.Protocol.ToLower, 'ws', 'http'); //replaces wss to https too, as apparently indy does not support ws(s) yet

    if URI.Path='' then
      URI.Path := '/';
    lSecure := uri.Protocol='https';

    if URI.Port.IsEmpty then
    begin
      if lSecure then
        self.Port := 443
      else
        self.Port := 80;
    end
    else
      self.Port := StrToInt(URI.Port);


    if lSecure and (self.IOHandler=nil) then
    begin
      if self.AutoCreateHandler then  //for simple life
      begin
        self.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(self);
        (self.IOHandler as TIdSSLIOHandlerSocketOpenSSL).SSLOptions.Mode := TIdSSLMode.sslmClient;
        //(self.IOHandler as TIdSSLIOHandlerSocketOpenSSL).SSLOptions.SSLVersions := [TIdSSLVersion.sslvTLSv1, TIdSSLVersion.sslvTLSv1_1, TIdSSLVersion.sslvTLSv1_2]; //depending on your server, change this at your code;
      end
      else
        raise Exception.Create('Please, inform a TIdSSLIOHandlerSocketOpenSSL descendant');
    end;

    if self.Connected then
      raise Exception.Create('Already connected, verify');


    inherited Connect;

    self.Socket.WriteLn(format('GET %s HTTP/1.1', [URI.Path]));
    self.Socket.WriteLn(format('Host: %s', [URI.Host]));
    self.Socket.WriteLn('User-Agent: Delphi WebSocket Simple Client');
//    self.Socket.WriteLn('Accept-Encoding: gzip, deflate');
    self.Socket.WriteLn('Connection: Upgrade');
    self.Socket.WriteLn('Upgrade: WebSocket');
    self.Socket.WriteLn('Sec-WebSocket-Version: 13');
    self.Socket.WriteLn('Sec-WebSocket-Protocol: chat');
    self.Socket.WriteLn(format('Sec-WebSocket-Key: %s', [generateWebSocketKey()]));
    self.Socket.WriteLn('');

    readFromSocket;
    startHeartBeat;
  finally
    URI.Free;
  end;
end;

constructor TIdSimpleWebSocketClient.Create(AOwner: TComponent);
begin
  inherited;
  lInternalLock := TCriticalSection.Create;
  Randomize;
  self.AutoCreateHandler := false;
  self.HeartBeatInterval := 30000;
end;

destructor TIdSimpleWebSocketClient.Destroy;
begin
  lInternalLock.Free;
  if self.AutoCreateHandler and Assigned(self.IOHandler) then
    self.IOHandler.Free;
  inherited;
end;

function TIdSimpleWebSocketClient.encodeFrame(pMsg:String; pPong:Boolean): TIdBytes;
var FIN, MASK: Cardinal;
    MaskingKey:array[0..3] of cardinal;
    EXTENDED_PAYLOAD_LEN:array[0..3] of Cardinal;
    buffer:Tidbytes;
    I: Integer;
    xor1, xor2:char ;
    ExtendedPayloadLength:Integer;
begin
  FIN:=0;
  FIN := Set_a_bit(FIN,7);
  if pPong then
  begin
    FIN := Set_a_bit(FIN,3);//Ping= 10001001
    FIN := Set_a_bit(FIN,1);//Pong= 10001010
  end
  else
    FIN := Set_a_bit(FIN,0);

  MASK  := set_a_bit(0,7);

  ExtendedPayloadLength:= 0;
  if pMsg.Length<=125 then
    MASK := MASK+pMsg.Length
  else
  if pMsg.Length<intPower(2,16) then
  begin
    MASK := MASK+126;
    ExtendedPayloadLength := 2;
    //https://stackoverflow.com/questions/13634240/delphi-xe3-integer-to-array-of-bytes
    //converts an integer to two bytes array
    EXTENDED_PAYLOAD_LEN[1] := byte(pmsg.Length);
    EXTENDED_PAYLOAD_LEN[0] := byte(pmsg.Length shr 8);
  end
  else
  begin
    mask := mask+127;
    ExtendedPayloadLength := 4;
    EXTENDED_PAYLOAD_LEN[3] := byte(pmsg.Length);
    EXTENDED_PAYLOAD_LEN[2] := byte(pmsg.Length shr 8);
    EXTENDED_PAYLOAD_LEN[1] := byte(pmsg.Length shr 16);
    EXTENDED_PAYLOAD_LEN[0] := byte(pmsg.Length shr 32);
  end;
  MaskingKey[0] := random(255);
  MaskingKey[1] := random(255);
  MaskingKey[2] := random(255);
  MaskingKey[3] := random(255);

  SetLength(buffer, 1+1+ExtendedPayloadLength+4+pMsg.Length);
  buffer[0] := FIN;
  buffer[1] := MASK;
  for I := 0 to ExtendedPayloadLength-1 do
    buffer[1+1+i] := EXTENDED_PAYLOAD_LEN[i];
  //payload mask:
  for I := 0 to 3 do
    buffer[1+1+ExtendedPayloadLength+i] := MaskingKey[i];
  for I := 0 to pMsg.Length-1 do
  begin
    {$IF DEFINED(iOS) or DEFINED(ANDROID)}
    xor1 := pMsg[i];
    {$ELSE}
    xor1 := pMsg[i+1];
    {$ENDIF}
    xor2 :=  chr(MaskingKey[((i) mod 4)]);
    xor2 := chr(ord(xor1) xor ord(xor2));
    buffer[1+1+ExtendedPayloadLength+4+i] := ord(xor2);
  end;
  result := buffer;
end;

function TIdSimpleWebSocketClient.encodePong: TidBytes;
begin
  result := encodeFrame('', true);
end;

function TIdSimpleWebSocketClient.Get_a_Bit(const aValue: Cardinal;
  const Bit: Byte): Boolean;
begin
  Result := (aValue and (1 shl Bit)) <> 0;
end;

function TIdSimpleWebSocketClient.readFromSocket:Boolean;
var
  s: string;
  b:Byte;
  T: ITask;
  posicao:Integer;
  size,sizemsg:Integer;
  pingByte:Byte;
  masked:boolean;
  upgraded:Boolean;
  forceDisconnect:Boolean;
  lHeader:TStringlist;
begin
  s := '';
  posicao  := 0;
  size := 0;
  masked := false;
  upgraded  := false;
  pingByte := Set_a_Bit(0,7); //1000100//PingByte
  pingByte := Set_a_Bit(pingByte,3);
  pingByte := Set_a_Bit(pingByte,0);
  lHeader := TStringList.Create;
  result := false;
  try
    while Connected and not upgraded do //First, we guarantee that this is an valid Websocket
    begin
      b := self.Socket.ReadByte;

      s := s+chr(b);
      if (not upgraded and (b=ord(#13))) then
      begin
        if s=#10#13 then
        begin

          //verifies header
          if not verifyHeader(lHeader) then
          begin
              raise Exception.Create('URL is not from an valid websocket server, not a valid response header found');
          end;

          upgraded := true;
          s := '';
          posicao := 0;
          sizeMsg := 0;
        end
        else
        begin
          if assigned(onConnectionDataEvent) then
            onConnectionDataEvent(self, s);

          lHeader.Add(s.Trim);
          s := '';
        end;
      end;
    end;
  except
  on e:Exception do
  begin
    forceDisconnect := true;
    if assigned(self.onError) then
      self.onError(self, e, e.Message, forceDisconnect);
    if forceDisconnect then
      self.Close;
    exit;
  end;
  end;


  if Connected then
    T := TTask.Run(
      procedure
      begin

        try
          while Connected do
          begin

            b := self.Socket.ReadByte;


            if upgraded and (posicao=0) and Get_a_Bit(b, 7) then //FIN
            begin
              if b=pingByte then
              begin
                b := self.Socket.ReadByte;
                self.Socket.WriteDirect(encodePong);
                if assigned(onPing) then
                  onPing(self);

              end
              else
                inc(posicao);
            end
            else if upgraded and (posicao=1) then
            begin
              masked  := Get_a_Bit(b, 7);
              size    := b;
              if masked then
                size    := b-set_a_bit(0,7);
              sizeMsg := 0;
              if size=0 then
                posicao := 0
              else
              if size=126 then // get size from 2 next bytes
              begin
                b := self.Socket.ReadByte;
                size := Round(b*intpower(2,8));
                b := self.Socket.ReadByte;
                size := size+Round(b*intpower(2,0));
              end
              else if size=127 then
                raise Exception.Create('Size block bigger than supported by this framework, fix is welcome');

              inc(posicao);
            end
            else
            begin
              if upgraded then
              begin
                inc(sizeMsg);
                if sizemsg=size then
                  posicao:=0;
              end;

              s := s+chr(b);
              if (upgraded and (sizemsg=size)) then
              begin
                posicao := 0;
                sizeMsg := 0;
                if upgraded and assigned(onDataEvent) then
                  onDataEvent(self, s);

                s := '';

              end;
            end;
          end;
        except
        on e:Exception do
        begin
          forceDisconnect := true;
          if assigned(self.onError) then
            self.onError(self, e, e.Message, forceDisconnect);
          if forceDisconnect then
            self.Close;
        end;
        end;
      end);

  if not Connected or not upgraded then
    raise Exception.Create('Websocket not connected or timeout');
end;

procedure TIdSimpleWebSocketClient.startHeartBeat;
var TimeUltimaNotif:TDateTime;
    forceDisconnect:Boolean;
begin
  TThread.CreateAnonymousThread(procedure begin
    TimeUltimaNotif := Now;
    try
      while (self.Connected) and (self.HeartBeatInterval>0) do
      begin
        //HeartBeat:
        if (MilliSecondsBetween(TimeUltimaNotif, Now) >= Floor(self.HeartBeatInterval)) then
        begin
          if assigned(self.onHeartBeatTimer) then
            self.onHeartBeatTimer(self);
          TimeUltimaNotif := Now;
        end;
          TThread.Sleep(500);
      end;
    except
    on e:Exception do
    begin
      forceDisconnect := true;
      if assigned(self.onError) then
        self.onError(self, e, e.Message, forceDisconnect);
      if forceDisconnect then
        self.Close;
    end;
    end;

  end).Start;
end;

function TIdSimpleWebSocketClient.verifyHeader(pHeader: TStrings): boolean;
begin
  pHeader.NameValueSeparator := ':';
  result := false;
  if (pHeader.Values['Connection'].Trim.ToLower='upgrade') and (pHeader.Values['Upgrade'].Trim.ToLower='websocket') then
  begin
    if pHeader.Values['Sec-WebSocket-Accept'].Trim=self.ExpectedSec_WebSocket_Accept then
      result := true
    else
      raise Exception.Create('Unexpected return key on Sec-WebSocket-Accept in handshake');

  end;
end;

function TIdSimpleWebSocketClient.Set_a_Bit(const aValue: Cardinal;
  const Bit: Byte): Cardinal;
begin
  Result := aValue or (1 shl Bit);
end;

procedure TIdSimpleWebSocketClient.writeText(pMsg: String);
begin
  try
    lInternalLock.Enter;
    self.Socket.Write(encodeFrame(pMSG));
  finally
    lInternalLock.Leave;
  end;
end;

end.
