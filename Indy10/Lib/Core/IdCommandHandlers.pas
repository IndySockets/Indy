{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  21522: IdCommandHandlers.pas
{
{   Rev 1.36    2/1/05 12:37:48 AM  RLebeau
{ Removed IdCommandHandlersEnabledDefault variable, no longer used.
}
{
{   Rev 1.35    1/3/05 4:43:20 PM  RLebeau
{ Changed use of AnsiSameText() to use TextIsSame() instead
}
{
{   Rev 1.34    12/17/04 12:54:04 PM  RLebeau
{ Updated TIdCommandHandler.Check() to not match misspelled commands when a
{ CmdDelimiter is specified.
}
{
{   Rev 1.33    12/10/04 1:48:04 PM  RLebeau
{ Bug fix for TIdCommandHandler.DoCommand()
}
{
{   Rev 1.32    10/26/2004 8:42:58 PM  JPMugaas
{ Should be more portable with new references to TIdStrings and TIdStringList.
}
{
{   Rev 1.31    6/17/2004 2:19:50 AM  JPMugaas
{ Problem with unparsed parameters.  The initial deliniator between the command
{ and reply was being added to Unparsed Params leading some strange results and
{ command failures.
}
{
{   Rev 1.30    6/6/2004 11:44:34 AM  JPMugaas
{ Removed a temporary workaround for a Telnet Sequences issue in the
{ TIdFTPServer.  That workaround is no longer needed as we fixed the issue
{ another way.
}
{
{   Rev 1.29    5/16/04 5:20:22 PM  RLebeau
{ Removed local variable from TIdCommandHandler constructor, no longer used
}
{
{   Rev 1.28    2004.03.03 3:19:52 PM  czhower
{ sorted
}
{
{   Rev 1.27    3/3/2004 4:59:40 AM  JPMugaas
{ Updated for new properties.
}
{
{   Rev 1.26    3/2/2004 8:10:36 AM  JPMugaas
{ HelpHide renamed to HelpVisable.
}
{
{   Rev 1.25    3/2/2004 6:37:36 AM  JPMugaas
{ Updated with properties for more comprehensive help systems.
}
{
{   Rev 1.24    2004.03.01 7:13:40 PM  czhower
{ Comaptibilty fix.
}
{
{   Rev 1.23    2004.03.01 5:12:26 PM  czhower
{ -Bug fix for shutdown of servers when connections still existed (AV)
{ -Implicit HELP support in CMDserver
{ -Several command handler bugs
{ -Additional command handler functionality.
}
{
{   Rev 1.22    2004.02.29 9:49:06 PM  czhower
{ Bug fix, and now responses are also write buffered.
}
{
{   Rev 1.21    2004.02.03 4:17:10 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.20    1/29/04 10:00:40 PM  RLebeau
{ Added setter methods to various TIdReply properties
}
{
{   Rev 1.19    2003.12.31 7:31:58 PM  czhower
{ AnsiSameText --> TextIsSame
}
{
    Rev 1.18    10/19/2003 11:36:52 AM  DSiders
  Added localization comments where setting response codes.
}
{
{   Rev 1.17    2003.10.18 9:33:26 PM  czhower
{ Boatload of bug fixes to command handlers.
}
{
{   Rev 1.16    2003.10.18 8:07:12 PM  czhower
{ Fixed bug with defaults.
}
{
{   Rev 1.15    2003.10.18 8:03:58 PM  czhower
{ Defaults for codes
}
{
{   Rev 1.14    10/5/2003 03:06:18 AM  JPMugaas
{ Should compile.
}
{
    Rev 1.13    8/9/2003 3:52:44 PM  BGooijen
  TIdCommandHandlers can now create any TIdCommandHandler descendant. this
  makes it possible to override TIdCommandHandler.check and check for the
  command a different way ( binary commands, protocols where the string doesn't
  start with the command )
}
{
{   Rev 1.12    8/2/2003 2:22:54 PM  SPerry
{ Fixed OnCommandHandlersException problem
}
{
{   Rev 1.11    8/2/2003 1:43:08 PM  SPerry
{ Modifications to get command handlers to work
}
{
{   Rev 1.9    7/30/2003 10:18:30 PM  SPerry
{ Fixed AV when creating commandhandler (again) -- for some reason the bug
{ fixed in Rev. 1.7 was still there.
}
{
{   Rev 1.8    7/30/2003 8:31:58 PM  SPerry
{ Fixed AV with LFReplyClass.
}
{
    Rev 1.4    7/9/2003 10:55:26 PM  BGooijen
  Restored all features
}
{
{   Rev 1.3    7/9/2003 04:36:10 PM  JPMugaas
{ You now can override the TIdReply with your own type.  This should illiminate
{ some warnings about some serious issues.  TIdReply is ONLY a base class with
{ virtual methods.
}
{
{   Rev 1.2    7/9/2003 01:43:22 PM  JPMugaas
{ Should now compile.
}
{
{   Rev 1.1    7/9/2003 2:56:44 PM  SPerry
{ Added OnException event
}
{
{
{   Rev 1.0    7/6/2003 4:47:38 PM  SPerry
{ Units that use Command handlers
}
{
	Original author: Chad Z. Hower
	Separate Unit  : Sergio Perry
}
unit IdCommandHandlers;

interface

uses
  IdBaseComponent, IdComponent, IdReply, IdGlobal,
  IdContext, IdReplyRFC, IdSys, IdObjs;

const
  IdEnabledDefault = True;
  // DO NOT change this default (ParseParams). Many servers rely on this
  IdParseParamsDefault = True;
  IdHelpVisibleDef = True;
type
  TIdCommandHandlers = class;
  TIdCommandHandler = class;
  TIdCommand = class;

  { Events }
  TIdCommandEvent = procedure(ASender: TIdCommand) of object;
  TIdAfterCommandHandlerEvent = procedure(ASender: TIdCommandHandlers;
    AContext: TIdContext) of object;
  TIdBeforeCommandHandlerEvent = procedure(ASender: TIdCommandHandlers;
    var AData: string; AContext: TIdContext) of object;
  TIdCommandHandlersExceptionEvent = procedure(ACommand: String; AContext: TIdContext) of object;

  { TIdCommandHandler }
  TIdCommandHandler = class(TIdCollectionItem)
  protected
    FCmdDelimiter: Char;
    FCommand: string;
    FData: TObject;
    FDescription: TIdStrings;
    FDisconnect: boolean;
    FEnabled: boolean;
    FExceptionReply: TIdReply;
    FHelpSuperScript : String;  //may be something like * or + which should appear in help
    FHelpVisible : Boolean;
    FName: string;
    FNormalReply: TIdReply;
    FOnCommand: TIdCommandEvent;
    FParamDelimiter: Char;
    FParseParams: Boolean;
    FReplyClass : TIdReplyClass;
    FResponse: TIdStrings;
    FTag: integer;
    //
    function GetDisplayName: string; override;
    procedure SetDescription(AValue: TIdStrings);
    procedure SetExceptionReply(AValue: TIdReply);
    procedure SetNormalReply(AValue: TIdReply);
    procedure SetResponse(AValue: TIdStrings);
  public
    function Check(AData: string; AContext: TIdContext): boolean; virtual;
    procedure DoCommand(AData: string; AContext: TIdContext; AUnparsedParams: string); virtual;
    constructor Create(
      ACollection: TIdCollection
      ); override;
    destructor Destroy; override;
//    function GetNamePath: string; override;
    function NameIs(ACommand: string): Boolean;
    //
    property Data: TObject read FData write FData;
  published
    property CmdDelimiter: Char read FCmdDelimiter write FCmdDelimiter;
    property Command: string read FCommand write FCommand;
    property Description: TIdStrings read FDescription write SetDescription;
    property Disconnect: boolean read FDisconnect write FDisconnect;
    property Enabled: boolean read FEnabled write FEnabled default IdEnabledDefault;
    property ExceptionReply: TIdReply read FExceptionReply write SetExceptionReply;
    property Name: string read FName write FName;
    property NormalReply: TIdReply read FNormalReply write SetNormalReply;
    property ParamDelimiter: Char read FParamDelimiter write FParamDelimiter;
    property ParseParams: Boolean read FParseParams write FParseParams default IdParseParamsDefault;
    property Response: TIdStrings read FResponse write SetResponse;
    property Tag: Integer read FTag write FTag;
    //
    property HelpSuperScript : String read FHelpSuperScript write FHelpSuperScript;  //may be something like * or + which should appear in help
    property HelpVisible : Boolean read FHelpVisible write FHelpVisible default IdHelpVisibleDef;

    property OnCommand: TIdCommandEvent read FOnCommand write FOnCommand;
  end;

  TIdCommandHandlerClass = class of TIdCommandHandler;

  { TIdCommandHandlers }
  TIdCommandHandlers = class(TIdOwnedCollection)
  protected
    FBase: TIdComponent;
    FExceptionReply: TIdReply;
    FOnAfterCommandHandler: TIdAfterCommandHandlerEvent;
    FOnBeforeCommandHandler: TIdBeforeCommandHandlerEvent;
    FOnCommandHandlersException: TIdCommandHandlersExceptionEvent;
    FReplyClass: TIdReplyClass;
    FReplyTexts: TIdReplies;
    //
    procedure DoAfterCommandHandler(AContext: TIdContext);
    procedure DoBeforeCommandHandler(AContext: TIdContext; var VLine: string);
    procedure DoOnCommandHandlersException(ACommand: String; AContext: TIdContext);
    function GetItem(AIndex: Integer): TIdCommandHandler;
    // This is used instead of the OwnedBy property directly calling GetOwner because
    // D5 dies with internal errors and crashes
//    function GetOwnedBy: TIdPersistent;
    procedure SetItem(AIndex: Integer; const AValue: TIdCommandHandler);
  public
    function Add: TIdCommandHandler;
    constructor Create(
      ABase: TIdComponent;
      AReplyClass: TIdReplyClass;
      AReplyTexts: TIdReplies;
      AExceptionReply: TIdReply = nil;
      ACommandHandlerClass: TIdCommandHandlerClass = nil
      ); reintroduce;
    function HandleCommand(
      AContext: TIdContext;
      var VCommand: string
      ): Boolean;
      virtual;
    //
    property Base: TIdComponent read FBase;
    property Items[AIndex: Integer]: TIdCommandHandler read GetItem write SetItem;
    // OwnedBy is used so as not to conflict with Owner in D6
 //   property OwnedBy: TIdPersistent read GetOwnedBy;
    property ReplyClass : TIdReplyClass read FReplyClass;
    //
    property OnAfterCommandHandler: TIdAfterCommandHandlerEvent read FOnAfterCommandHandler
     write FOnAfterCommandHandler;
    // Occurs in the context of the peer thread
    property OnBeforeCommandHandler: TIdBeforeCommandHandlerEvent read FOnBeforeCommandHandler
     write FOnBeforeCommandHandler;
    property OnCommandHandlersException: TIdCommandHandlersExceptionEvent read FOnCommandHandlersException
      write FOnCommandHandlersException;
    property ReplyTexts: TIdReplies read FReplyTexts;
  end;

  { TIdCommand }
  TIdCommand = class(TIdBaseObject)
  protected
    FCommandHandler: TIdCommandHandler;
    FDisconnect: Boolean;
    FParams: TIdStrings;
    FPerformReply: Boolean;
    FRawLine: string;
    FReply: TIdReply;
    FResponse: TIdStrings;
    FContext: TIdContext;
    FUnparsedParams: string;
    //
    procedure DoCommand; virtual;
    procedure SetReply(AValue: TIdReply);
    procedure SetResponse(AValue: TIdStrings);
  public
    constructor Create(AOwner: TIdCommandHandler); virtual;
    destructor Destroy; override;
    procedure SendReply;
    //
    property CommandHandler: TIdCommandHandler read FCommandHandler;
    property Disconnect: Boolean read FDisconnect write FDisconnect;
    property PerformReply: Boolean read FPerformReply write FPerformReply;
    property Params: TIdStrings read FParams;
    property RawLine: string read FRawLine;
    property Reply: TIdReply read FReply write SetReply;
    property Response: TIdStrings read FResponse write SetResponse;
    property Context: TIdContext read FContext;
    property UnparsedParams: string read FUnparsedParams;
  end;//TIdCommand

implementation
{ TIdCommandHandlers }

constructor TIdCommandHandlers.Create(
  ABase: TIdComponent;
  AReplyClass: TIdReplyClass;
  AReplyTexts: TIdReplies;
  AExceptionReply: TIdReply = nil;
  ACommandHandlerClass: TIdCommandHandlerClass = nil
  );
begin
  if ACommandHandlerClass = nil then begin
    inherited Create(ABase, TIdCommandHandler);
  end else begin
    inherited Create(ABase, ACommandHandlerClass);
  end;
  FBase := ABase;
  FExceptionReply := AExceptionReply;
  FReplyClass := AReplyClass;
  FReplyTexts := AReplyTexts;
end;

function TIdCommandHandlers.Add: TIdCommandHandler;
begin
  Result := TIdCommandHandler(inherited Add);
end;

function TIdCommandHandlers.HandleCommand(
  AContext: TIdContext;
  var VCommand: string
  ): Boolean;
var
  i, j: Integer;
begin
  j := Count - 1;
  Result := False;
  DoBeforeCommandHandler(AContext, VCommand); try
    i := 0;
    while i <= j do begin
      if Items[i].Enabled then begin
        Result := Items[i].Check(VCommand, AContext);
        if Result then begin
          Break;
        end;
      end;
      Inc(i);
    end;
  finally DoAfterCommandHandler(AContext); end;
end;

procedure TIdCommandHandlers.DoAfterCommandHandler(AContext: TIdContext);
begin
  if Assigned(OnAfterCommandHandler) then begin
    OnAfterCommandHandler(Self, AContext);
  end;
end;

procedure TIdCommandHandlers.DoBeforeCommandHandler(AContext: TIdContext;
  var VLine: string);
begin
  if Assigned(OnBeforeCommandHandler) then begin
    OnBeforeCommandHandler(Self, VLine, AContext);
  end;
end;

procedure TIdCommandHandlers.DoOnCommandHandlersException(ACommand: String;
  AContext: TIdContext);
begin
  if Assigned(FOnCommandHandlersException) then begin
    OnCommandHandlersException(ACommand, AContext);
  end;
end;

function TIdCommandHandlers.GetItem(AIndex: Integer): TIdCommandHandler;
begin
  Result := TIdCommandHandler(inherited Items[AIndex]);
end;

{
function TIdCommandHandlers.GetOwnedBy: TIdPersistent;
begin
  Result := GetOwner;
end;
 }

procedure TIdCommandHandlers.SetItem(AIndex: Integer; const AValue: TIdCommandHandler);
begin
  inherited SetItem(AIndex, AValue);
end;

{ TIdCommandHandler }

procedure TIdCommandHandler.DoCommand(
  AData: string;
  AContext: TIdContext;
  AUnparsedParams: string
  );
var
  LCommand: TIdCommand;
begin
  LCommand := TIdCommand.Create(Self);
  with LCommand do try
    FRawLine := AData;
    FContext := AContext;
    FUnparsedParams := AUnparsedParams;
    Params.Clear;

    if ParseParams then begin
      if Self.FParamDelimiter = #32 then begin
        SplitColumnsNoTrim(AUnparsedParams, Params, #32);
      end else begin
        SplitColumns(AUnparsedParams, Params, Self.FParamDelimiter);
      end;
    end;

    PerformReply := True;

    try
      //if code<>'' before DoCommand, then it breaks exception handling
      Assert(Reply.Code='');
      DoCommand;

      if Reply.Code = '' then
        begin
        Reply.Assign(Self.NormalReply);
        end;
      // UpdateText here in case user wants to add to it. SendReply also gets it in case
      // a different reply is sent (ie exception, etc), or the user changes the code in the event
      Reply.UpdateText;

      Response.Assign(Self.Response);

    except
      on E: Exception do begin
        if PerformReply then begin
          // Try from command handler first
          if Reply.Code = '' then begin
            Reply.Assign(Self.ExceptionReply);
          end;
          // If still no go, from server
          // Can be nil though. Typically only servers pass it in
          if (Reply.Code = '') and (TIdCommandHandlers(Collection).FExceptionReply <> nil) then begin
            Reply.Assign(TIdCommandHandlers(Collection).FExceptionReply);
          end;
          if Reply.Code <> '' then begin
            Reply.Text.Add(E.Message);
            SendReply;
          end else begin
            raise;
          end;
        end else begin
          raise;
        end;
      end else begin
        raise;
      end;
    end;

    if PerformReply then begin
      SendReply;
    end;

    if Response.Count > 0 then begin
      AContext.Connection.WriteRFCStrings(Response);
    end else if Self.Response.Count > 0 then begin
      AContext.Connection.WriteRFCStrings(Self.Response);
    end;
  finally
    try
      if Disconnect then begin
        AContext.Connection.Disconnect;
      end;
    finally Free; end;
  end;
end;

function TIdCommandHandler.Check(AData: string; AContext: TIdContext): boolean;
// AData is not preparsed and is completely left up to the command handler. This will allow for
// future expansion such as wild cards etc, and allow the logic to properly remain in each of the
// command handler implementations. In the future there may be a base type and multiple descendants
var
  LUnparsedParams: string;
begin
  LUnparsedParams := '';
  Result := TextIsSame(AData, Command); // Command by itself

  if not Result then begin
    if CmdDelimiter <> #0 then begin
      Result := TextIsSame(Copy(AData, 1, Length(Command) + 1), Command + CmdDelimiter);
      LUnparsedParams := Copy(AData, Length(Command) + 2, MaxInt);
    end else begin
      // Dont strip any part of the params out.. - just remove the command purely on length and
      // no delim
      Result := TextIsSame(Copy(AData, 1, Length(Command)), Command);
      LUnparsedParams := Copy(AData, Length(Command) + 1, MaxInt);
    end;
  end;

  if Result then begin
    DoCommand(AData, AContext, LUnparsedParams);
  end;
end;

constructor TIdCommandHandler.Create(
  ACollection: TIdCollection
  );
begin
  inherited Create(ACollection);

  FReplyClass := TIdCommandHandlers(ACollection).ReplyClass;
  if FReplyClass = nil then begin
    FReplyClass := TIdReplyRFC;
  end;

  FCmdDelimiter := #32;
  FEnabled := IdEnabledDefault;
  FName := ClassName + Sys.IntToStr(ID);
  FParamDelimiter := #32;
  FParseParams := IdParseParamsDefault;
  FResponse := TIdStringList.Create;
  FDescription := TIdStringList.Create;

  FNormalReply := FReplyClass.Create(nil, TIdCommandHandlers(ACollection).ReplyTexts);
  if FNormalReply is TIdReplyRFC then begin
    FNormalReply.Code := '200'; {do not localize}
  end;
  FHelpVisible := IdHelpVisibleDef;
  // Dont initialize, pulls from CmdTCPServer for defaults
  FExceptionReply := FReplyClass.Create(nil, TIdCommandHandlers(ACollection).ReplyTexts);
end;

destructor TIdCommandHandler.Destroy;
begin
  Sys.FreeAndNil(FResponse);
  Sys.FreeAndNil(FNormalReply);
  Sys.FreeAndNil(FDescription);
  Sys.FreeAndNil(FExceptionReply);
  inherited Destroy;
end;

function TIdCommandHandler.GetDisplayName: string;
begin
  if Command = '' then begin
    Result := Name;
  end else begin
    Result := Command;
  end;
end;

{
function TIdCommandHandler.GetNamePath: string;
begin
  if Collection <> nil then begin
    // OwnedBy is used because D4/D5 dont expose Owner on TOwnedCollection but D6 does
    Result := TIdCommandHandlers(Collection).OwnedBy.GetNamePath + '.' + Name;
  end else begin
    Result := inherited GetNamePath;
  end;
end;
}
function TIdCommandHandler.NameIs(ACommand: string): Boolean;
begin
  Result := TextIsSame(ACommand, FName);
end;

procedure TIdCommandHandler.SetExceptionReply(AValue: TIdReply);
begin
  FExceptionReply.Assign(AValue);
end;

procedure TIdCommandHandler.SetNormalReply(AValue: TIdReply);
begin
  FNormalReply.Assign(AValue);
end;

procedure TIdCommandHandler.SetResponse(AValue: TIdStrings);
begin
  FResponse.Assign(AValue);
end;

procedure TIdCommandHandler.SetDescription(AValue: TIdStrings);
begin
  FDescription.Assign(AValue);
end;

{ TIdCommand }

constructor TIdCommand.Create(AOwner: TIdCommandHandler);
begin
  inherited Create;
  FParams := TIdStringList.Create;
  FReply := AOwner.FReplyClass.Create(nil, TIdCommandHandlers(AOwner.Collection).ReplyTexts);
  FResponse := TIdStringList.Create;
  FCommandHandler := AOwner;
  FDisconnect := AOwner.Disconnect;
end;

destructor TIdCommand.Destroy;
begin
  Sys.FreeAndNil(FReply);
  Sys.FreeAndNil(FResponse);
  Sys.FreeAndNil(FParams);
  inherited Destroy;
end;

procedure TIdCommand.DoCommand;
begin
  if Assigned(CommandHandler.OnCommand) then begin
    CommandHandler.OnCommand(Self);
  end;
end;

procedure TIdCommand.SendReply;
begin
  PerformReply := False;
  Reply.UpdateText;
  Context.Connection.IOHandler.Write(Reply.FormattedReply);
end;

procedure TIdCommand.SetReply(AValue: TIdReply);
begin
  FReply.Assign(AValue);
end;

procedure TIdCommand.SetResponse(AValue: TIdStrings);
begin
  FResponse.Assign(AValue);
end;

end.
