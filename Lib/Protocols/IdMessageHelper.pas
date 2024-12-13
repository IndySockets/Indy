unit IdMessageHelper;

{$I IdCompilerDefines.inc}

interface

uses
  Classes, IdMessage;

// TODO: move this to IdCompilerDefines.inc
{$IFDEF DCC}
  // class helpers were first introduced in D2005, but were buggy and not
  // officially supported until D2006...
  {$IFDEF VCL_2006_OR_ABOVE}
    {$DEFINE HAS_CLASS_HELPER}
  {$ENDIF}
{$ENDIF}
{$IFDEF FPC}
  {$IFDEF FPC_2_6_0_OR_ABOVE}
    {$DEFINE HAS_CLASS_HELPER}
  {$ENDIF}
{$ENDIF}

{$IFDEF HAS_CLASS_HELPER}
type
  TIdMessageHelper = class helper for TIdMessage
  public
    procedure LoadFromFile(const AFileName: string; const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean); overload;
    procedure LoadFromStream(AStream: TStream; const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean); overload;
    procedure SaveToFile(const AFileName: string; const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean); overload;
    procedure SaveToStream(AStream: TStream; const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean); overload;
  end;
{$ENDIF}

procedure TIdMessageHelper_LoadFromFile(AMsg: TIdMessage; const AFileName: string; const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean); {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdMessageHelper.LoadFromFile()'{$ENDIF};{$ENDIF}{$ENDIF}
procedure TIdMessageHelper_LoadFromStream(AMsg: TIdMessage; AStream: TStream; const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean); {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdMessageHelper.LoadFromStream()'{$ENDIF};{$ENDIF}{$ENDIF}
procedure TIdMessageHelper_SaveToFile(AMsg: TIdMessage; const AFileName: string; const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean); {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdMessageHelper.SaveToFile()'{$ENDIF};{$ENDIF}{$ENDIF}
procedure TIdMessageHelper_SaveToStream(AMsg: TIdMessage; AStream: TStream; const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean); {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdMessageHelper.SaveToStream()'{$ENDIF};{$ENDIF}{$ENDIF}

implementation

uses
  IdGlobal, IdMessageClient, SysUtils, IdResourceStringsProtocols;

{ TIdMessageClientHelper }

procedure Internal_TIdMessageClientHelper_ProcessMessage(AClient: TIdMessageClient;
  AMsg: TIdMessage; AStream: TStream; AHeaderOnly: Boolean;
  AUsesDotTransparency: Boolean);
var
  LIOHandler: TIdIOHandlerStreamMsg;
begin
  if AUsesDotTransparency then begin
    AClient.ProcessMessage(AMsg, AStream, AHeaderOnly);
  end else
  begin
    LIOHandler := TIdIOHandlerStreamMsg.Create(nil, AStream);
    try
      LIOHandler.FreeStreams := False;
      LIOHandler.EscapeLines := True; // <-- this is the key!
      AClient.IOHandler := LIOHandler;
      try
        LIOHandler.Open;
        AClient.ProcessMessage(AMsg, AHeaderOnly);
      finally
        AClient.IOHandler := nil;
      end;
    finally
      LIOHandler.Free;
    end;
  end;
end;

{ TIdMessageHelper }
  
procedure Internal_TIdMessageHelper_LoadFromStream(AMsg: TIdMessage; AStream: TStream;
  const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean);
var
  LMsgClient: TIdMessageClient;
begin
  if AUsesDotTransparency then begin
    AMsg.LoadFromStream(AStream, AHeadersOnly);
  end else
  begin
    // clear message properties, headers before loading
    AMsg.Clear;
    LMsgClient := TIdMessageClient.Create;
    try
      Internal_TIdMessageClientHelper_ProcessMessage(LMsgClient, AMsg, AStream, AHeadersOnly, False);
    finally
      LMsgClient.Free;
    end;
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdMessageHelper_LoadFromStream(AMsg: TIdMessage; AStream: TStream;
  const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean);
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Internal_TIdMessageHelper_LoadFromStream(AMsg, AStream, AHeadersOnly, AUsesDotTransparency);
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdMessageHelper.LoadFromStream(AStream: TStream; const AHeadersOnly: Boolean;
  const AUsesDotTransparency: Boolean);
begin
  Internal_TIdMessageHelper_LoadFromStream(Self, AStream, AHeadersOnly, AUsesDotTransparency);
end;
{$ENDIF}

procedure Internal_TIdMessageHelper_LoadFromFile(AMsg: TIdMessage; const AFileName: string;
  const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean);
var
  LStream: TIdReadFileExclusiveStream;
begin
  if AUsesDotTransparency then begin
    AMsg.LoadFromFile(AFileName, AHeadersOnly);
  end else
  begin
    try
      LStream := TIdReadFileExclusiveStream.Create(AFilename);
    except
      LStream := nil; // keep the compiler happy
      IndyRaiseOuterException(EIdMessageCannotLoad.CreateFmt(RSIdMessageCannotLoad, [AFilename]));
    end;
    try
      Internal_TIdMessageHelper_LoadFromStream(AMsg, LStream, AHeadersOnly, False);
    finally
      LStream.Free;
    end;
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdMessageHelper_LoadFromFile(AMsg: TIdMessage; const AFileName: string;
  const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean);
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Internal_TIdMessageHelper_LoadFromFile(AMsg, AFileName, AHeadersOnly, AUsesDotTransparency);
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdMessageHelper.LoadFromFile(const AFileName: string; const AHeadersOnly: Boolean; const AUsesDotTransparency: Boolean);
begin
  Internal_TIdMessageHelper_LoadFromFile(Self, AFileName, AHeadersOnly, AUsesDotTransparency);
end;
{$ENDIF}

procedure Internal_TIdMessageHelper_SaveToStream(AMsg: TIdMessage; AStream: TStream;
  const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean);
var
  LMsgClient: TIdMessageClient;
  LIOHandler: TIdIOHandlerStreamMsg;
begin
  if AUseDotTransparency then begin
    AMsg.SaveToStream(AStream, AHeadersOnly);
  end else
  begin
    LMsgClient := TIdMessageClient.Create(nil);
    try
      LIOHandler := TIdIOHandlerStreamMsg.Create(nil, nil, AStream);
      try
        LIOHandler.FreeStreams := False;
        LIOHandler.UnescapeLines := True; // <-- this is the key!
        LMsgClient.IOHandler := LIOHandler;
        try
          LMsgClient.SendMsg(AMsg, AHeadersOnly);
          {
          // add the end of message marker when body is included
          if not AHeadersOnly then begin
            LIOHandler.WriteLn('.');  {do not localize
          end;
          }
        finally
          LMsgClient.IOHandler := nil;
        end;
      finally
        LIOHandler.Free;
      end;
    finally
      LMsgClient.Free;
    end;
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdMessageHelper_SaveToStream(AMsg: TIdMessage; AStream: TStream;
  const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean);
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Internal_TIdMessageHelper_SaveToStream(AMsg, AStream, AHeadersOnly, AUseDotTransparency);
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdMessageHelper.SaveToStream(AStream: TStream; const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean);
begin
  Internal_TIdMessageHelper_SaveToStream(Self, AStream, AHeadersOnly, AUseDotTransparency);
end;
{$ENDIF}

type
  TIdMessageAccess = class(TIdMessage)
  end;

procedure Internal_TIdMessageHelper_SaveToFile(AMsg: TIdMessage; const AFileName: string;
  const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean);
var
  LStream : TFileStream;
  LMsgAccess: TIdMessageAccess;
begin
  if AUseDotTransparency then begin
    AMsg.SaveToFile(AFileName, AHeadersOnly);
  end else
  begin
    LStream := TIdFileCreateStream.Create(AFileName);
    try
      {$I IdObjectChecksOff.inc}
      LMsgAccess := TIdMessageAccess(AMsg);
      {$I IdObjectChecksOn.inc}

      LMsgAccess.FSavingToFile := True;
      try
        Internal_TIdMessageHelper_SaveToStream(AMsg, LStream, AHeadersOnly, False);
      finally
        LMsgAccess.FSavingToFile := False;
      end;
    finally
      LStream.Free;
    end;
  end;
end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdMessageHelper_SaveToFile(AMsg: TIdMessage; const AFileName: string;
  const AHeadersOnly: Boolean; const AUseDotTransparency: Boolean);
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  Internal_TIdMessageHelper_SaveToFile(AMsg, AFileName, AHeadersOnly, AUseDotTransparency);
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdMessageHelper.SaveToFile(const AFileName: string; const AHeadersOnly: Boolean;
  const AUseDotTransparency: Boolean);
begin
  Internal_TIdMessageHelper_SaveToFile(Self, AFileName, AHeadersOnly, AUseDotTransparency);
end;
{$ENDIF}

end.