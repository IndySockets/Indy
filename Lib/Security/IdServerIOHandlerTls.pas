{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.0    27-03-05 10:04:20  MterWoord
  Second import, first time the filenames weren't prefixed with Id

  Rev 1.0    27-03-05 09:08:54  MterWoord
  Created
}

unit IdServerIOHandlerTls;

interface

uses
  IdSSL, IdTlsServerOptions, Mono.Security.Protocol.Tls, IdCarrierStream,
  IdSocketStream, System.IO, System.Security.Cryptography, IdGlobal, IdYarn,
  System.Security.Cryptography.X509Certificates, Mono.Security.Authenticode,
  IdIOHandler, IdSocketHandle, IdThread;

type
  TIdServerIOHandlerTls = class(TIdServerIOHandlerSSLBase)
  protected
    FOptions: TIdTlsServerOptions;
    function NewServerSideIOHandlerTls: TIdSSLIOHandlerSocketBase;
    procedure InitComponent; override;
  public
    function MakeFTPSvrPasv: TIdSSLIOHandlerSocketBase; override;
    function MakeFTPSvrPort: TIdSSLIOHandlerSocketBase; override;
    function MakeClientIOHandler(AYarn: TIdYarn) : TIdIOHandler; override;
    function MakeClientIOHandler: TIdSSLIOHandlerSocketBase; override;
    function Accept(ASocket: TIdSocketHandle; AListenerThread: TIdThread; AYarn: TIdYarn): TIdIOHandler; override;
  published
    property Options: TIdTlsServerOptions read FOptions write FOptions;
  end;


implementation

type
  TIdServerSideIOHandlerTls = class(TIdSSLIOHandlerSocketBase)
  protected
    FOptions: TIdTlsServerOptions;
    FTlsServerStream: SslServerStream;
    FTlsClientStream: SslClientStream;
    FCarrierStream: TIdCarrierStream;
    FSocketStream: TIdSocketStream;
    FActiveStream: Stream;
    FPassThrough: Boolean;
    function PrivateKeySelection(certificate: X509Certificate; TargetHost: string): AsymmetricAlgorithm;
    function ReadFromSource(ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer; ARaiseExceptionOnTimeOut: Boolean): Integer; override;
    procedure SetPassThrough(const AValue: Boolean); override;
  public
    procedure CheckForDataOnSource(ATimeOut: Integer); override;
    procedure StartSSL; override;
    procedure AfterAccept; override;
    procedure CheckForDisconnect(ARaiseExceptionIfDisconnected: Boolean; AIgnoreBuffer: Boolean); override;
    function Clone: TIdSSLIOHandlerSocketBase; override;
    procedure WriteDirect(var ABuffer: TIdBytes); override;
    procedure Close; override;
  published
    property Options: TIdTlsServerOptions read FOptions write FOptions;
  end;

{ TServerSideIOHandlerTls }

function TIdServerSideIOHandlerTls.Clone: TIdSSLIOHandlerSocketBase;
var
  TempResult : TIdServerSideIOHandlerTls;
begin
  TempResult := TIdServerSideIOHandlerTls.Create;
  TempResult.Options.ClientNeedsCertificate := Options.ClientNeedsCertificate;
  TempResult.Options.PrivateKey := Options.PrivateKey;
  TempResult.Options.Protocol := Options.Protocol;
  TempResult.Options.PublicCertificate := Options.PublicCertificate;
  TempResult.IsPeer := IsPeer;
  TempResult.PassThrough := PassThrough;
  Result := TempResult;
end;

procedure TIdServerSideIOHandlerTls.StartSSL;
begin
  inherited;
  PassThrough := False;
end;

function TIdServerSideIOHandlerTls.PrivateKeySelection(
  certificate: X509Certificate; TargetHost: string): AsymmetricAlgorithm;
begin
  Result := FOptions.PrivateKey.RSA;
end;

function TIdServerSideIOHandlerTls.ReadFromSource(
  ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer;
  ARaiseExceptionOnTimeOut: Boolean): Integer;
var
  TempBuff: array of byte;
  TotalBytesRead: Integer;
  StartTime: Cardinal;
  BytesRead: Integer;
  TempBytes: array of byte;
begin
  Result := 0;
  if FInputBuffer = nil then
    Exit;
  if FActiveStream <> nil then
  begin
    SetLength(TempBuff, 512);
    TotalBytesRead := 0;
    StartTime := Ticks;
    repeat
      BytesRead := FActiveStream.Read(TempBuff, 0, 512);
      if BytesRead <> 0 then
      begin
        TempBytes := ToBytes(TempBuff, BytesRead);
        FInputBuffer.Write(TempBytes);
        TotalBytesRead := TotalBytesRead + BytesRead;
      end;
      if BytesRead <> 512 then
      begin
        Result := TotalBytesRead;
        Exit;
      end;
      IndySleep(2);
    until (   (Abs(GetTickDiff(StartTime, Ticks)) > ATimeOut)
           and (not ((ATimeOut = IdTimeoutDefault) or (ATimeOut = IdTimeoutInfinite)))
           );
    Result := TotalBytesRead;
  end;
end;

procedure TIdServerSideIOHandlerTls.CheckForDisconnect(
  ARaiseExceptionIfDisconnected, AIgnoreBuffer: Boolean);
begin
  try
    if FActiveStream = nil then
    begin
      if AIgnoreBuffer then
      begin
        CloseGracefully;
      end
      else
      begin
        if FInputBuffer.Size = 0 then
        begin
          CloseGracefully;
        end;
      end;
    end
    else
    begin
      if (    (not FActiveStream.CanRead)
          or  (not FActiveStream.CanWrite)
          ) then
      begin
        if AIgnoreBuffer then
        begin
          CloseGracefully;
        end
        else
        begin
          if FInputBuffer.Size = 0 then
          begin
            CloseGracefully;
          end;
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      CloseGracefully;
    end;
  end;
  if (    (ARaiseExceptionIfDisconnected)
      and (ClosedGracefully)
      ) then
    RaiseConnClosedGracefully;
end;

procedure TIdServerSideIOHandlerTls.CheckForDataOnSource(ATimeOut: Integer);
begin
  if Connected then
  begin
    ReadFromSource(false, ATimeOut, false);
  end;
end;

procedure TIdServerSideIOHandlerTls.AfterAccept;
begin
  inherited;
  FSocketStream := TIdSocketStream.Create(Binding.Handle);
  FCarrierStream := TIdCarrierStream.Create(FSocketStream);
  FTlsServerStream := SslServerStream.Create(FCarrierStream, FOptions.PublicCertificate, FOptions.ClientNeedsCertificate, true, FOptions.Protocol);
  GC.SuppressFinalize(FSocketStream);
  GC.SuppressFinalize(FCarrierStream);
  GC.SuppressFinalize(FTlsServerStream);
  FActiveStream := FCarrierStream;
  FTlsServerStream.PrivateKeyCertSelectionDelegate := PrivateKeySelection;
  IsPeer := true;
  PassThrough := true;
end;

procedure TIdServerSideIOHandlerTls.Close;
begin
  if not PassThrough then
  begin
    if IsPeer then
    begin
      if FTlsServerStream <> nil then
      begin
        FTlsServerStream.Close;
        FTlsServerStream := nil;
      end;
    end
    else
    begin
      if FTlsClientStream <> nil then
      begin
        FTlsClientStream.Close;
        FTlsClientStream := nil;
      end;
    end;
  end;
  if FCarrierStream <> nil then
  begin
    FCarrierStream.Close;
    FCarrierStream := nil;
  end;
  if FSocketStream <> nil then
  begin
    FSocketStream.Close;
    FSocketStream := nil;
  end;
  inherited;
end;

procedure TIdServerSideIOHandlerTls.WriteDirect(var ABuffer: TIdBytes);
begin
  if Intercept <> nil then
    Intercept.Send(ABuffer);

  if FActiveStream <> nil then
  begin
    FActiveStream.Write(ABuffer, 0, Length(ABuffer));
    FActiveStream.Flush;
  end
  else
    raise Exception.Create('No active stream!');
end;

procedure TIdServerSideIOHandlerTls.SetPassThrough(const AValue: Boolean);
var
  TempBuff: array[0..0] of byte;
begin
  inherited;
  if AValue then
  begin
    if FActiveStream <> nil then
    begin
      FActiveStream.Close;
      FActiveStream := nil;
    end;
    FActiveStream := FSocketStream;
    if IsPeer then
    begin
      if FTlsServerStream <> nil then
      begin
        FTlsServerStream.Close;
        FTlsServerStream := nil;
      end;
      FTlsServerStream := SslServerStream.Create(FCarrierStream, FOptions.PublicCertificate, FOptions.ClientNeedsCertificate, true, FOptions.Protocol);
      GC.SuppressFinalize(FTlsServerStream);
      FTlsServerStream.PrivateKeyCertSelectionDelegate := PrivateKeySelection;
    end
    else
    begin
      if FTlsClientStream <> nil then
      begin
        FTlsClientStream.Close;
        FTlsClientStream := nil;
      end;
      FTlsClientStream := SslClientStream.Create(FCarrierStream, Destination, true, FOptions.Protocol);
      GC.SuppressFinalize(FTlsClientStream);
    end;
  end
  else
  begin
    if IsPeer then
    begin
      FActiveStream := FTlsServerStream;
    end
    else
    begin
      FActiveStream := FTlsClientStream;
    end;
    FActiveStream.Read(TempBuff, 0, 0);
  end;
end;

{ TServerIOHandlerTls }

procedure TIdServerIOHandlerTls.InitComponent;
begin
  inherited;
  FOptions := TIdTlsServerOptions.Create;
end;

function TIdServerIOHandlerTls.NewServerSideIOHandlerTls: TIdSSLIOHandlerSocketBase;
var
  TempResult: TIdServerSideIOHandlerTls;
begin
  TempResult := TIdServerSideIOHandlerTls.Create;
  TempResult.Options := FOptions;
  Result := TempResult;
end;

function TIdServerIOHandlerTls.MakeClientIOHandler: TIdSSLIOHandlerSocketBase;
begin
  Result := NewServerSideIOHandlerTls;
end;

function TIdServerIOHandlerTls.MakeClientIOHandler(AYarn: TIdYarn): TIdIOHandler;
begin
  Result := NewServerSideIOHandlerTls;
end;

function TIdServerIOHandlerTls.MakeFTPSvrPort: TIdSSLIOHandlerSocketBase;
begin
  Result := NewServerSideIOHandlerTls;
end;

function TIdServerIOHandlerTls.Accept(ASocket: TIdSocketHandle;
  AListenerThread: TIdThread; AYarn: TIdYarn): TIdIOHandler;
var
  LIOHandler: TIdServerSideIOHandlerTls;
begin
  LIOHandler := TIdServerSideIOHandlerTls.Create;
  LIOHandler.Options := FOptions;
  LIOHandler.Open;
  while not AListenerThread.Stopped do
  begin
    try
      if ASocket.Select(250) then
      begin
        if LIOHandler.Binding.Accept(ASocket.Handle) then
        begin
          LIOHandler.AfterAccept;
          Result := LIOHandler;
          Exit;
        end
        else
        begin
          LIOHandler.Close;
          Result := nil;
          Exit;
        end;
      end;
    finally
      if AListenerThread.Stopped then
      begin
        LIOHandler.Close;
      end;
    end;
  end;
  Result := nil;
end;

function TIdServerIOHandlerTls.MakeFTPSvrPasv: TIdSSLIOHandlerSocketBase;
begin
  Result := NewServerSideIOHandlerTls;
end;

end.
