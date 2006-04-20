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
  Rev 1.0    27-03-05 10:04:18  MterWoord
  Second import, first time the filenames weren't prefixed with Id

  Rev 1.0    27-03-05 09:08:50  MterWoord
  Created
}

unit IdIOHandlerTls;

interface

uses
  System.Collections, System.ComponentModel, System.IO, System.Net.Sockets,
  System.Security.Cryptography.X509Certificates, Mono.Security.Protocol.Tls,
  IdSSL, IdCarrierStream, IdSocketStream, IdGlobal, IdTlsClientOptions;

{$AUTOBOX ON}
{$HINTS OFF}
{$WARNINGS OFF}

type
  TArrayOfInteger = array of Int32;
  TIdIOHandlerTls = class(TIdSSLIOHandlerSocketBase)
  protected
    FOptions: TIdTlsClientOptions;
    FTlsStream: SslClientStream;
    FCarrierStream: TIdCarrierStream;
    FSocketStream: TIdSocketStream;
    FActiveStream: Stream;
    FOnValidateCertificate: CertificateValidationCallback;
    procedure InitComponent; override;
    function ReadFromSource(ARaiseExceptionIfDisconnected: Boolean; ATimeout: Integer; ARaiseExceptionOnTimeOut: Boolean) : Integer; override;
    procedure SetPassThrough(const AValue: Boolean); override;
    procedure SetOnValidateCertificate(const Value: CertificateValidationCallback);
    procedure SetOptions(const Value: TIdTlsClientOptions);
  public
    procedure CheckForDataOnSource(ATimeOut: Integer); override;
    procedure Open; override;
    procedure Close; override;
    procedure CheckForDisconnect(ARaiseExceptionIfDisconnected: Boolean; AIgnoreBuffer: Boolean); override;
    procedure StartSSL; override;
    function Clone : TIdSSLIOHandlerSocketBase; override;
    function Connected: Boolean; override;
    procedure WriteDirect(var ABuffer: TIdBytes); override;
  published
    property Options: TIdTlsClientOptions read FOptions write SetOptions;
    property OnValidateCertificate: CertificateValidationCallback read FOnValidateCertificate write SetOnValidateCertificate;
  end;

implementation

uses IdIOHandler;

{ TIOHandlerTls }

procedure TIdIOHandlerTls.SetOnValidateCertificate(
  const Value: CertificateValidationCallback);
begin
  FOnValidateCertificate := Value;

  if FTlsStream <> nil then
  begin
    FTlsStream.ServerCertValidationDelegate := Value;
  end;
end;

procedure TIdIOHandlerTls.SetOptions(const Value: TIdTlsClientOptions);
begin
  FOptions := Value;
end;

function TIdIOHandlerTls.Connected: Boolean;
begin
  Result :=  (    (Binding <> nil)
              and (Binding.Handle <> nil)
              and (Binding.Handle.Connected)
              and (FSocketStream <> nil)
              and (FCarrierStream <> nil)
              and ((FTlsStream <> nil) or PassThrough)
              );
end;

function TIdIOHandlerTls.Clone: TIdSSLIOHandlerSocketBase;
var
  TempResult: TIdIOHandlerTls;
begin
  TempResult := TIdIOHandlerTls.Create;
  TempResult.Options.CertificateCollection.AddRange(Options.CertificateCollection);
  TempResult.Options.Protocol := Options.Protocol;
  Result := TempResult;
end;

procedure TIdIOHandlerTls.InitComponent;
begin
  inherited;
	FOptions := TIdTlsClientOptions.Create;
end;

procedure TIdIOHandlerTls.StartSSL;
begin
  inherited;
  PassThrough := False;
end;

procedure TIdIOHandlerTls.Open;
begin
  inherited;
  FSocketStream := TIdSocketStream.Create(Binding.Handle);
  FCarrierStream := TIdCarrierStream.Create(FSocketStream);
  FActiveStream := FCarrierStream;
  GC.SuppressFinalize(FSocketStream);
  GC.SuppressFinalize(FCarrierStream);
  GC.SuppressFinalize(Binding.Handle);
  if not PassThrough then
  begin
    PassThrough := True;
    PassThrough := False;
  end;
end;

function TIdIOHandlerTls.ReadFromSource(ARaiseExceptionIfDisconnected: Boolean;
  ATimeout: Integer; ARaiseExceptionOnTimeOut: Boolean): Integer;
var
  TempBuff: TIdBytes;
  TotalBytesRead: Integer;
  StartTime: UInt32;
  BytesRead: Integer;
  TempBytes: TIdBytes;
begin
  if FInputBuffer = nil then
  begin
    Result := 0;
    Exit;
  end;
  if FActiveStream <> nil then
  begin
    SetLength(TempBuff, RecvBufferSize);
    TotalBytesRead := 0;
    StartTime := Ticks;
    repeat
      BytesRead := FActiveStream.Read(TempBuff, 0, RecvBufferSize);
      if BytesRead <> 0 then
      begin
        SetLength(TempBytes, BytesRead);
        &Array.Copy(TempBuff, TempBytes, BytesRead);
        FInputBuffer.Write(TempBytes);
        Inc(TotalBytesRead, BytesRead);
      end;
      if BytesRead <> RecvBufferSize then
      begin
        Result := TotalBytesRead;
        Exit;
      end;
      Sleep(2);
    until (   (Abs(GetTickDiff(StartTime, Ticks)) > ATimeOut)
           and (not ((ATimeOut = IdTimeoutDefault) or (ATimeOut = IdTimeoutInfinite)))
           );
  	Result := TotalBytesRead;
  end
  else
    Result := 0;
end;

procedure TIdIOHandlerTls.CheckForDisconnect(ARaiseExceptionIfDisconnected,
  AIgnoreBuffer: Boolean);
begin
  inherited;
  try
    if FActiveStream = nil then
    begin
      if AIgnoreBuffer then
        CloseGracefully
      else
        if FInputBuffer.Size = 0 then
          CloseGracefully;
    end
    else
      if (    (not FActiveStream.CanRead)
          or  (not FActiveStream.CanWrite)
          ) then
      begin
        if AIgnoreBuffer then
          CloseGracefully
        else
          if FInputBuffer.Size = 0 then
            CloseGracefully;
      end;
  except
    on E: Exception do
      CloseGracefully;
  end;
  if ARaiseExceptionIfDisconnected and ClosedGracefully then
    RaiseConnClosedGracefully;
end;

procedure TIdIOHandlerTls.CheckForDataOnSource(ATimeOut: Integer);
begin
  if Connected then
    ReadFromSource(false, ATimeout, false);
end;

procedure TIdIOHandlerTls.Close;
begin
  if not PassThrough then
  begin
    FTlsStream.Close;
    FTlsStream := nil;
  end;
  FCarrierStream.Close;
  FCarrierStream := nil;
  FSocketStream.Close;
  FSocketStream := nil;
  inherited;
end;

procedure TIdIOHandlerTls.WriteDirect(var ABuffer: TIdBytes);
begin
  if Intercept <> nil then
  begin
    Intercept.Send(ABuffer);
  end;

  if FActiveStream <> nil then
  begin
    FActiveStream.Write(ABuffer, 0, Length(ABuffer));
    FActiveStream.Flush;
  end
  else
    Console.WriteLine('TIdIOHandler.WriteDirect: FActiveStream = Nil!');
end;

procedure TIdIOHandlerTls.SetPassThrough(const AValue: Boolean);
var
  TempBuff: array[0..0] of byte;
begin
  if PassThrough <> AValue then
  begin
    inherited;
    if FCarrierStream = nil then
      Exit;

    if AValue then
    begin
      FActiveStream := FSocketStream;
      if FTlsStream <> nil then
      begin
        FTlsStream.Close;
        FTlsStream := nil;
      end;
    end
    else
    begin
      FTlsStream := SslClientStream.Create(FCarrierStream, URIToCheck, true, FOptions.Protocol, FOptions.CertificateCollection);
      FTlsStream.ServerCertValidationDelegate := FOnValidateCertificate;
      GC.SuppressFinalize(FTlsStream);
      FActiveStream := FTlsStream;
//      FTlsStream.Read(TempBuff, 0, 0);
    end;
  end;
end;

end.
