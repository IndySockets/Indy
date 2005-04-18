{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  28102: IdInterceptSimLog.pas
{
{   Rev 1.6    7/23/04 6:40:08 PM  RLebeau
{ Added extra exception handling to Connect()
}
{
{   Rev 1.5    2004.05.20 11:39:10 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.4    2004.02.03 4:17:18 PM  czhower
{ For unit name changes.
}
{
    Rev 1.3    10/19/2003 11:38:26 AM  DSiders
  Added localization comments.
}
{
{   Rev 1.2    2003.10.18 1:56:46 PM  czhower
{ Now uses ASCII instead of binary format.
}
{
{   Rev 1.1    2003.10.17 6:16:20 PM  czhower
{ Functional complete.
}
unit IdInterceptSimLog;

{
This file uses string outputs instead of binary so that the results can be
viewed and modified with notepad if necessary.

Most times a Send/Receive includes a writeln, but may not always. We write out
an additional EOL to guarantee separation in notepad.

It also auto detects when an EOL can be used instead.

TODO: Can also change it to detect several EOLs and non binary and use :Lines:x
}

interface

uses
  Classes,
  IdGlobal, IdIntercept, IdStreamVCL;

type
  TIdInterceptSimLog = class(TIdConnectionIntercept)
  protected
    FFilename: string;
    FStream: TIdStreamVCL;
    //
    procedure SetFilename(AValue: string);
    procedure WriteRecord(
      ATag: string;
      ABuffer: TIdBytes
      );
  public
    procedure Connect(AConnection: TComponent); override;
    procedure Disconnect; override;
    procedure Receive(var ABuffer: TIdBytes); override;
    procedure Send(var ABuffer: TIdBytes); override;
  published
    property Filename: string read FFilename write SetFilename;
  end;

implementation

uses
  IdException, IdResourceStringsCore;

{ TIdInterceptSimLog }

procedure TIdInterceptSimLog.Connect(AConnection: TComponent);
var
  LStream: TStream;
begin
  inherited;
  // Warning! This will overwrite any existing file. It makes no sense
  // to concatenate sim logs.
  LStream := TFileStream.Create(Filename, fmCreate);
  try
    FStream := TIdStreamVCL.Create(LStream, True);
  except
    SysUtil.FreeAndNil(LStream);
    raise;
  end;
end;

procedure TIdInterceptSimLog.Disconnect;
begin
  SysUtil.FreeAndNil(FStream);
  inherited;
end;

procedure TIdInterceptSimLog.Receive(var ABuffer: TIdBytes);
begin
  inherited;
  WriteRecord('Recv', ABuffer); {do not localize}
end;

procedure TIdInterceptSimLog.Send(var ABuffer: TIdBytes);
begin
  inherited;
  WriteRecord('Send', ABuffer); {do not localize}
end;

procedure TIdInterceptSimLog.SetFilename(AValue: string);
begin
  EIdException.IfAssigned(FStream, RSLogFileAlreadyOpen);
  FFilename := AValue;
end;

procedure TIdInterceptSimLog.WriteRecord(
  ATag: string;
  ABuffer: TIdBytes
  );
var
  i: Integer;
  LUseEOL: Boolean;
begin
  LUseEOL := False;
  if Length(ABuffer) > 1 then begin
    if (ABuffer[Length(ABuffer) - 2] = 13)
     and (ABuffer[Length(ABuffer) - 1] = 10) then begin
      LUseEOL := True;
      for i := 0 to Length(ABuffer) - 3 do begin
        // If any binary, CR or LF
        if (ABuffer[i] < 32) or (ABuffer[i] > 127) then begin
          LUseEOL := False;
          Break;
        end;
      end;
    end;
  end;
  with FStream do begin
    if LUseEOL then begin
      WriteLn(ATag + ':EOL'); {do not localize}
    end else begin
      WriteLn(ATag + ':Bytes:' + SysUtil.IntToStr(Length(ABuffer)));  {do not localize}
    end;
    Write(ABuffer);
    WriteLn;
  end;
end;

end.
