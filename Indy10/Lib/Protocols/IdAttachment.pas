{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13728: IdAttachment.pas
{
{   Rev 1.8    2/8/05 6:02:10 PM  RLebeau
{ Try that again...
}
{
{   Rev 1.7    2/8/05 6:00:02 PM  RLebeau
{ Updated SaveToFile() to call SaveToStream()
}
{
{   Rev 1.6    6/16/2004 2:10:48 PM  EHill
{ Added SaveToStream method for TIdAttachment
}
{
{   Rev 1.5    2004.03.03 10:30:46 AM  czhower
{ Removed warning.
}
{
{   Rev 1.4    2/24/04 1:23:58 PM  RLebeau
{ Bug fix for SaveToFile() using the wrong Size
}
{
{   Rev 1.3    2004.02.03 5:44:50 PM  czhower
{ Name changes
}
{
{   Rev 1.2    10/17/03 12:07:28 PM  RLebeau
{ Updated Assign() to copy all available header values rather than select ones.
}
{
    Rev 1.1    10/16/2003 10:55:24 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.0    11/14/2002 02:12:36 PM  JPMugaas
}
unit IdAttachment;

interface

uses
  IdMessageParts,
  IdBaseComponent,
  IdSys,
  IdObjs;

type
  TIdAttachment = class(TIdMessagePart)
  protected
    FFileName: String;

    function  GetContentDisposition: string; virtual;
    function  GetContentType: String; override;
    function  GetContentTypeName: String; virtual;
    procedure SetContentDisposition(const Value: string); virtual;
    procedure SetContentType(const Value: String); override;
  public
    // here the methods you have to override...

    // for open handling
    // works like this:
    //  1) you create an attachment - and do whatever it takes to put data in it
    //  2) you send the message
    //  3) this will be called - first OpenLoadStream, to get a stream
    //  4) when the message is fully encoded, CloseLoadStream is called
    //     to close the stream. The Attachment implementation decides what to do
    function OpenLoadStream: TIdStream2; virtual; abstract;
    procedure CloseLoadStream; virtual; abstract;

    // for save handling
    // works like this:
    //  1) new attachment is created
    //  2) PrepareTempStream is called
    //  3) stuff is loaded
    //  4) FinishTempStream is called of the newly created attachment
    function  PrepareTempStream: TIdStream2; virtual; abstract;
    procedure FinishTempStream; virtual; abstract;
    procedure SaveToFile(const FileName: String); virtual;
    procedure SaveToStream(const Stream: TIdStream2); virtual;

    procedure Assign(Source: TIdPersistent); override;


    property  FileName: String read FFileName write FFileName;
    property  ContentDisposition: string read GetContentDisposition write SetContentDisposition;
    property  ContentTypeName: String read GetContentTypeName;
    class function PartType: TIdMessagePartType; override;
  end;

  TIdAttachmentClass = class of TIdAttachment;

implementation

uses
  IdGlobal, IdGlobalProtocols;

const
  SContentDisposition = 'Content-Disposition';  {do not localize}

{ TIdAttachment }

procedure TIdAttachment.Assign(Source: TIdPersistent);
var
  mp: TIdAttachment;
begin
  if not (Source is Self.ClassType) then begin
    inherited;
  end else begin
    mp := TIdAttachment(Source);
    {
    ContentTransfer := mp.ContentTransfer;
    ContentType := mp.ContentType;
    ContentID := mp.ContentID;
    ContentDisposition := mp.ContentDisposition;
    }

    // RLebeau 10/17/2003
    Headers.Assign(mp.Headers);

    ExtraHeaders.Assign(mp.ExtraHeaders);
    FileName := mp.FileName;
  end;
end;

function TIdAttachment.GetContentDisposition: string;
begin
  Result := Headers.Values[SContentDisposition]; {do not localize}
  Result := Fetch(Result,';');
end;

function TIdAttachment.GetContentType: String;
Begin
  Result := inherited GetContentType;
  Result := Fetch(Result,';');
End;//

function TIdAttachment.GetContentTypeName: String;
Begin
  Result := ExtractHeaderSubItem(inherited GetContentType, 'NAME='); {do not localize}
End;//

class function TIdAttachment.PartType: TIdMessagePartType;
begin
  Result := mptAttachment;
end;

procedure TIdAttachment.SaveToFile(const FileName: String);
var
  fs: TIdFileStream;
begin
  fs := TIdFileStream.Create(FileName, fmCreate); try
    SaveToStream(fs);
  finally
    Sys.FreeAndNil(fs);
  end;
end;

procedure TIdAttachment.SaveToStream(const Stream: TIdStream2);
var
  os: TIdStream2;
begin
  os := OpenLoadStream;
  try
    Stream.CopyFrom(os, 0);
  finally
    CloseLoadStream;
  end;
end;

procedure TIdAttachment.SetContentDisposition(const Value: string);
begin
  Headers.Values[SContentDisposition] := Value;
end;


procedure TIdAttachment.SetContentType(const Value: String);
begin
  inherited; // TODO: what is here? must we add 'name='?
end;

end.

