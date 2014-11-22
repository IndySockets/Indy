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
  Rev 1.8    2/8/05 6:02:10 PM  RLebeau
  Try that again...

  Rev 1.7    2/8/05 6:00:02 PM  RLebeau
  Updated SaveToFile() to call SaveToStream()

  Rev 1.6    6/16/2004 2:10:48 PM  EHill
  Added SaveToStream method for TIdAttachment

  Rev 1.5    2004.03.03 10:30:46 AM  czhower
  Removed warning.

  Rev 1.4    2/24/04 1:23:58 PM  RLebeau
  Bug fix for SaveToFile() using the wrong Size

  Rev 1.3    2004.02.03 5:44:50 PM  czhower
  Name changes

  Rev 1.2    10/17/03 12:07:28 PM  RLebeau
  Updated Assign() to copy all available header values rather than select ones.

  Rev 1.1    10/16/2003 10:55:24 PM  DSiders
  Added localization comments.

  Rev 1.0    11/14/2002 02:12:36 PM  JPMugaas
}

unit IdAttachment;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdMessageParts,
  IdBaseComponent;

type
  TIdAttachment = class(TIdMessagePart)
  public
    // here the methods you have to override...

    // for open handling
    // works like this:
    //  1) you create an attachment - and do whatever it takes to put data in it
    //  2) you send the message
    //  3) this will be called - first OpenLoadStream, to get a stream
    //  4) when the message is fully encoded, CloseLoadStream is called
    //     to close the stream. The Attachment implementation decides what to do
    function OpenLoadStream: TStream; virtual; abstract;
    procedure CloseLoadStream; virtual; abstract;

    // for save handling
    // works like this:
    //  1) new attachment is created
    //  2) PrepareTempStream is called
    //  3) stuff is loaded
    //  4) FinishTempStream is called of the newly created attachment
    function  PrepareTempStream: TStream; virtual; abstract;
    procedure FinishTempStream; virtual; abstract;

    procedure LoadFromFile(const FileName: String); virtual;
    procedure LoadFromStream(AStream: TStream); virtual;
    procedure SaveToFile(const FileName: String); virtual;
    procedure SaveToStream(AStream: TStream); virtual;
    
    class function PartType: TIdMessagePartType; override;
  end;

  TIdAttachmentClass = class of TIdAttachment;

implementation

uses
  IdGlobal, IdGlobalProtocols, IdCoderHeader,
  SysUtils;

{ TIdAttachment }

class function TIdAttachment.PartType: TIdMessagePartType;
begin
  Result := mptAttachment;
end;

procedure TIdAttachment.LoadFromFile(const FileName: String);
var
  LStrm: TIdReadFileExclusiveStream;
begin
  LStrm := TIdReadFileExclusiveStream.Create(FileName); try
    LoadFromStream(LStrm);
  finally
    FreeAndNil(LStrm);
  end;
end;

procedure TIdAttachment.LoadFromStream(AStream: TStream);
var
  LStrm: TStream;
begin
  LStrm := PrepareTempStream;
  try
    // TODO: use AStream.Size-AStream.Position instead of 0, and don't call
    // CopyFrom() if (AStream.Size-AStream.Position) is <= 0.  Passing 0 to
    // CopyFrom() tells it to seek AStream to Position=0 and then copy the
    // entire stream, which is fine for the stream provided by LoadFromFile(),
    // but may not always be desirable for user-provided streams...
    LStrm.CopyFrom(AStream, 0);
  finally
    FinishTempStream;
  end;
end;

procedure TIdAttachment.SaveToFile(const FileName: String);
var
  LStrm: TIdFileCreateStream;
begin
  LStrm := TIdFileCreateStream.Create(FileName); try
    SaveToStream(LStrm);
  finally
    FreeAndNil(LStrm);
  end;
end;

procedure TIdAttachment.SaveToStream(AStream: TStream);
var
  LStrm: TStream;
begin
  LStrm := OpenLoadStream;
  try
    AStream.CopyFrom(LStrm, 0);
  finally
    CloseLoadStream;
  end;
end;

end.

