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
  Rev 1.2    2004.10.26 2:19:58 PM  czhower
  Resolved alias conflict.

  Rev 1.1    14/07/2004 21:37:26  CCostelloe
  Changed Get/SetMessage to Get/SetIdMessage to avoid conflict under C++ with
  Windows' GetMessage

  Rev 1.0    11/13/2002 07:57:28 AM  JPMugaas

  2000-APR-14 Peter Mee: Converted to Indy.

  2001-MAY-03 Idan Cohen: Added Create and Destroy of TIdMessage.
}

unit IdMessageCollection;

{
  TIdMessageCollection: Contains a collection of IdMessages.
  Originally by Peter Mee.
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdMessage;

type
  TIdMessageItems = class of TIdMessageItem;

  TIdMessageItem = class(TCollectionItem)
  protected
    FAttempt: Integer;
    FMsg: TIdMessage;
    FQueued: Boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    //
    property Attempt: Integer read FAttempt write FAttempt;
    property Msg: TIdMessage read FMsg;
    property Queued: Boolean read FQueued write FQueued;
  end;

  TIdMessageCollection = class(TCollection)
  private
    function GetIdMessage(index: Integer): TIdMessage;
    procedure SetIdMessage(index: Integer; const Value: TIdMessage);
  public
    constructor Create; reintroduce;
    function Add: TIdMessageItem;
    property Messages[index: Integer]: TIdMessage read GetIdMessage write SetIdMessage; Default;
  end;

implementation

uses
  IdGlobal, SysUtils;

{ TIdMessageItem }

constructor TIdMessageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FMsg := TIdMessage.Create(nil);
end;

destructor TIdMessageItem.Destroy;
begin
  FreeAndNil(FMsg);
  inherited Destroy;
end;

{ TIdMessageCollection }

constructor TIdMessageCollection.Create;
begin
  inherited Create(TIdMessageItem);
end;

function TIdMessageCollection.Add;
begin
  Result := TIdMessageItem(inherited Add);
end;

function TIdMessageCollection.GetIdMessage(index: Integer): TIdMessage;
begin
  Result := TIdMessageItem(Items[index]).Msg;
end;

procedure TIdMessageCollection.SetIdMessage(index: Integer; const Value: TIdMessage);
begin
  //I think it should be freed before the new value is assigned or else the
  //pointer will be lost.

  // RLebeau 6/3/2010: this is taking ownership of the input TIdMessage
  // pointer!  We should probably be calling Assign() instead, and let
  // the caller manage its TIdMessage object separately.  Or else make
  // the Messages[] property read-only instead...

  TIdMessageItem(Items[index]).FMsg.Free;
  TIdMessageItem(Items[index]).FMsg := Value;
end;

end.
