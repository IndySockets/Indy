{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11655: IdLogStream.pas
{
{   Rev 1.5    2004.05.20 12:34:32 PM  czhower
{ Removed more non .NET compatible stream read and writes
}
{
{   Rev 1.4    2004.01.20 10:03:30 PM  czhower
{ InitComponent
}
{
{   Rev 1.3    2003.10.17 6:15:56 PM  czhower
{ Upgrades
}
{
{   Rev 1.2    2003.10.17 4:28:54 PM  czhower
{ Changed stream names to be consistent with IOHandlerStream
}
{
{   Rev 1.1    2003.10.14 1:27:12 PM  czhower
{ Uupdates + Intercept support
}
{
{   Rev 1.0    11/13/2002 07:56:18 AM  JPMugaas
}
unit IdLogStream;

interface

uses
  Classes,
  IdLogBase, IdStreamVCL;

type
  TIdLogStream = class(TIdLogBase)
  protected
    FFreeStreams: Boolean;
    FReceiveStream: TIdStreamVCL;
    FSendStream: TIdStreamVCL;
    //
    procedure InitComponent; override;
    procedure LogStatus(AText: string); override;
    procedure LogReceivedData(AText: string; AData: string); override;
    procedure LogSentData(AText: string; AData: string); override;
  public
    procedure Disconnect; override;
    //
    property FreeStreams: Boolean read FFreeStreams write FFreeStreams;
    property ReceiveStream: TIdStreamVCL read FReceiveStream write FReceiveStream;
    property SendStream: TIdStreamVCL read FSendStream write FSendStream;
  end;

implementation
 uses IdSys;
// TODO: This was orginally for VCL. For .Net what do we do? Convert back to
// 7 bit? Log all? Logging all seems to be a disaster.
// Text seems to be best, users are expecting text in this class. But
// this write stream will dump unicode out in .net.....
// So just convert it again back to 7 bit? How is proper to write
// 7 bit to file? Use AnsiString?

{ TIdLogStream }

procedure TIdLogStream.Disconnect;
begin
  inherited;
  if FreeStreams then begin
    Sys.FreeAndNil(FReceiveStream);
    Sys.FreeAndNil(FSendStream);
  end;
end;

procedure TIdLogStream.InitComponent;
begin
  inherited;
  FFreeStreams := True;
end;

procedure TIdLogStream.LogReceivedData(AText, AData: string);
begin
  if FReceiveStream <> nil then begin
    FReceiveStream.Write(AData);
  end;
end;

procedure TIdLogStream.LogSentData(AText, AData: string);
begin
  if FSendStream <> nil then begin
    FSendStream.Write(AData);
  end;
end;

procedure TIdLogStream.LogStatus(AText: string);
begin
  // We just leave this empty because the AText is not part of the stream and we
  // do not want to raise an abstract method exception.
end;

end.
