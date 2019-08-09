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
  Rev 1.4    2/4/2004 2:47:38 AM  JPMugaas
  MOved SysUtils down to the implemenation uses clause.

  Rev 1.3    24/01/2004 21:45:36  CCostelloe
  InitCOmponent -> InitComponent (removes a warning)

  Rev 1.2    1/21/2004 3:11:26 PM  JPMugaas
  InitComponent

  Rev 1.1    22/12/2003 00:44:34  CCostelloe
  .NET fixes

  Rev 1.0    11/13/2002 07:56:28 AM  JPMugaas

  2001-FEB-27 IC:
    First version, most of the needed MailBox features are implemented,
                  next version should include a MailBox list structure that will hold
                  an entire account mail box structure with the updated information.

  2001-MAY-05 IC:
}

unit IdMailBox;

{
  IdMailBox (Created for use with the IdIMAP4 unit)
  By Idan Cohen i_cohen@yahoo.com
}

interface
{$i IdCompilerDefines.inc}

uses
  {$IFNDEF HAS_UInt32}
  IdGlobal,
  {$ENDIF}
  IdBaseComponent,
  IdMessage,
  IdException,
  IdMessageCollection;

type
  TIdMailBoxState = ( msReadWrite, msReadOnly );

  TIdMailBoxAttributes = ( maNoinferiors, maNoselect, maMarked, maUnmarked );

  TIdMailBoxAttributesSet = set of TIdMailBoxAttributes;

  TUInt32Array = array of UInt32;

  TIdMailBox = class(TIdBaseComponent)
  protected
    FAttributes: TIdMailBoxAttributes;
    FChangeableFlags: TIdMessageFlagsSet;
    FFirstUnseenMsg: UInt32;
    FFlags: TIdMessageFlagsSet;
    FName: String;
    FMessageList: TIdMessageCollection;
    FRecentMsgs: Integer;
    FState: TIdMailBoxState;
    FTotalMsgs: Integer;
    FUIDNext: String;
    FUIDValidity: String;
    FUnseenMsgs: Integer;

    procedure SetMessageList(const Value: TIdMessageCollection);
    procedure InitComponent; override;
  public
    DeletedMsgs: TUInt32Array;
    SearchResult: TUInt32Array;
    property Attributes: TIdMailBoxAttributes read FAttributes write FAttributes;
    property ChangeableFlags: TIdMessageFlagsSet read FChangeableFlags write FChangeableFlags;
    property FirstUnseenMsg: UInt32 read FFirstUnseenMsg write FFirstUnseenMsg;
    property Flags: TIdMessageFlagsSet read FFlags write FFlags;
    property Name: String read FName write FName;
    property MessageList: TIdMessageCollection read FMessageList write SetMessageList;
    property RecentMsgs: Integer read FRecentMsgs write FRecentMsgs;
    property State: TIdMailBoxState read FState write FState;
    property TotalMsgs: Integer read FTotalMsgs write FTotalMsgs;
    property UIDNext: String read FUIDNext write FUIDNext;
    property UIDValidity: String read FUIDValidity write FUIDValidity;
    property UnseenMsgs: Integer read FUnseenMsgs write FUnseenMsgs;
    procedure Clear; virtual;
    destructor Destroy; override;
  published
  end;

const
  MailBoxAttributes : array [maNoinferiors..maUnmarked] of String =
  ( '\Noinferiors', //It is not possible for any child levels of    {Do not Localize}
                   //hierarchy to exist under this name; no child levels
                   //exist now and none can be created in the future.
   '\Noselect',    //It is not possible to use this name as a selectable    {Do not Localize}
                   //mailbox.
   '\Marked',      //The mailbox has been marked "interesting" by the    {Do not Localize}
                   //server; the mailbox probably contains messages that
                   //have been added since the last time the mailbox was
                   //selected.
   '\Unmarked' );  //The mailbox does not contain any additional    {Do not Localize}
                   //messages since the last time the mailbox was
                   //selected.

implementation

uses
  SysUtils;
  
{ TIdMailBox }

procedure TIdMailBox.Clear;
begin
  FTotalMsgs := 0;
  FRecentMsgs := 0;
  FUnseenMsgs := 0;
  FFirstUnseenMsg := 0;
  FUIDValidity := '';    {Do not Localize}
  FUIDNext := '';    {Do not Localize}
  FName := '';    {Do not Localize}
  FState := msReadOnly;
  FAttributes := maNoselect;
  SetLength(DeletedMsgs, 0);
  SetLength(SearchResult, 0);
  FFlags := [];
  FChangeableFlags := [];
  MessageList.Clear;
end;

procedure TIdMailBox.InitComponent;
begin
  inherited InitComponent;
  FMessageList := TIdMessageCollection.Create;
  Clear;
end;

destructor TIdMailBox.Destroy;
begin
  FreeAndNil(FMessageList);
  inherited Destroy;
end;

procedure TIdMailBox.SetMessageList(const Value: TIdMessageCollection);
begin
  FMessageList.Assign(Value);
end;

end.
