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
    function RecvEnc(var ABuffer: TIdBytes): Integer; override;
    function SendEnc(const ABuffer: TIdBytes; const AOffset, ALength: Integer): Integer; override;
    procedure SetPassThrough(const AValue: Boolean); override;
    procedure SetOnValidateCertificate(const Value: CertificateValidationCallback);
    procedure SetOptions(const Value: TIdTlsClientOptions);
  public
    procedure Open; override;
    procedure Close; override;
    procedure CheckForDisconnect(ARaiseExceptionIfDisconnected: Boolean = True;
     AIgnoreBuffer: Boolean = False); override;
    procedure StartSSL; override;
    function Clone : TIdSSLIOHandlerSocketBase; override;
    function Connected: Boolean; override;
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

function TIdIOHandlerTls.RecvEnc(var VBuffer: TIdBytes): Integer;
begin
  if FActiveStream <> nil then begin
    Result := FActiveStream.Read(VBuffer, 0, Length(VBuffer));
  end else begin
    Result := 0;
  end;
end;

procedure TIdIOHandlerTls.CheckForDisconnect(ARaiseExceptionIfDisconnected: Boolean = True;
  AIgnoreBuffer: Boolean = False);
begin
  inherited;
  try
    if FActiveStream = nil then
    begin
      if AIgnoreBuffer or (FInputBuffer.Size = 0) then begin
        CloseGracefully;
      end;
    end
    else if (not FActiveStream.CanRead) or (not FActiveStream.CanWrite) then
    begin
      if AIgnoreBuffer or (FInputBuffer.Size = 0) then begin
        CloseGracefully;
      end;
    end;
  except
    on E: Exception do begin
      CloseGracefully;
    end;
  end;
  if ARaiseExceptionIfDisconnected and ClosedGracefully then begin
    RaiseConnClosedGracefully;
  end;
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

function TIdIOHandlerTls.SendEnc(const ABuffer: TIdBytes; const AOffset, ALength: Integer): Integer;
begin
  if FActiveStream <> nil then
  begin
    FActiveStream.Write(ABuffer, AOffset, ALength);
    FActiveStream.Flush;
    Result := ALength;
  end else begin
    Result := 0;
  end;
end;

procedure TIdIOHandlerTls.SetPassThrough(const AValue: Boolean);
var
  TempBuff: array[0..0] of byte;
begin
  if PassThrough <> AValue then
  begin
    inherited;
    if FCarrierStream = nil then begin
      Exit;
    end;
    if AValue then
    begin
      FActiveStream := FSocketStream;
      if FTlsStream <> nil then
      begin
        FTlsStream.Close;
        FTlsStream := nil;
      end;
    end else
    begin
      FTlsStream := SslClientStream.Create(FCarrierStream, URIToCheck, True, FOptions.Protocol, FOptions.CertificateCollection);
      FTlsStream.ServerCertValidationDelegate := FOnValidateCertificate;
      GC.SuppressFinalize(FTlsStream);
      FActiveStream := FTlsStream;
      //FTlsStream.Read(TempBuff, 0, 0);
    end;
  end;
end;

end.
