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

unit IdWebDAV;

//implements http://www.faqs.org/rfcs/rfc2518.html

{
general cleanup possibilities:
todo change embedded strings to consts
todo change depth param from infinity to -1? also string>integer?
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdHTTP;

const
  Id_HTTPMethodPropFind = 'PROPFIND';  {do not localize}
  Id_HTTPMethodPropPatch = 'PROPPATCH';  {do not localize}
  Id_HTTPMethodOrderPatch = 'ORDERPATCH';  {do not localize}
  Id_HTTPMethodSearch = 'SEARCH';  {do not localize}
  Id_HTTPMethodMKCol = 'MKCOL';  {do not localize}
  Id_HTTPMethodMove = 'MOVE';  {do not localize}
  Id_HTTPMethodCopy = 'COPY';  {do not localize}
  Id_HTTPMethodCheckIn = 'CHECKIN';  {do not localize}
  Id_HTTPMethodCheckOut = 'CHECKOUT';  {do not localize}
  Id_HTTPMethodUnCheckOut = 'UNCHECKOUT';  {do not localize}
  Id_HTTPMethodLock = 'LOCK';  {do not localize}
  Id_HTTPMethodUnLock = 'UNLOCK';  {do not localize}
  Id_HTTPMethodReport = 'REPORT';  {do not localize}
  Id_HTTPMethodVersion = 'VERSION-CONTROL';  {do not localize}
  Id_HTTPMethodLabel = 'LABEL';  {do not localize}
  Id_HTTPMethodMakeCol = 'MKCOL';  {Do not localize}

const
  //casing is according to rfc
  cTimeoutInfinite = 'Infinite';  {do not localize}
  cDepthInfinity = 'infinity';  {do not localize}

type

  TIdWebDAV = class(TIdHTTP)
  public
    procedure DAVCheckIn(const AURL, AComment: string);
    procedure DAVCheckOut(const AURL: string; const AXMLQuery: TStream; const AComment: string);
    procedure DAVCopy(const AURL, DURL: string; const AResponseContent: TStream; const AOverWrite: boolean = True; const ADepth: string = cDepthInfinity);
    procedure DAVDelete(const AURL: string; const ALockToken: string);
    procedure DAVLabel(const AURL: string; const AXMLQuery: TStream);
    procedure DAVLock(const AURL: string; const AXMLQuery, AResponseContent: TStream; const ALockToken, ATags: string; const ATimeOut: string = cTimeoutInfinite; const AMustExist: Boolean = False; const ADepth: string = '0');  {do not localize}
    procedure DAVMove(const AURL, DURL: string; const AResponseContent: TStream; const AOverWrite: Boolean = True; const ADepth: string = cDepthInfinity);
    procedure DAVOrderPatch(const AURL: string; const AXMLQuery: TStream);
    procedure DAVPropFind(const AURL: string; const AXMLQuery, AResponseContent: TStream; const ADepth: string = '0'; const ARangeFrom: Integer = -1; const ARangeTo: Integer = -1);  {do not localize}
    procedure DAVPropPatch(const AURL: string; const AXMLQuery, AResponseContent: TStream; const ADepth: string = '0');  {do not localize}
    procedure DAVPut(const AURL: string; const ASource: TStream; const ALockToken: String);
    procedure DAVReport(const AURL: string; const AXMLQuery, AResponseContent: TStream);
    procedure DAVSearch(const AURL: string; const ARangeFrom, ARangeTo: Integer; const AXMLQuery, AResponseContent: TStream; const ADepth: string = '0');  {do not localize}
    procedure DAVUnCheckOut(const AURL: String);
    procedure DAVUnLock(const AURL: string; const ALockToken: string);
    procedure DAVVersionControl(const AURL: string);
    procedure DAVMakeCollection(const AURL: string);
  end;

implementation

uses
  IdGlobal, SysUtils;

procedure TIdWebDAV.DAVPropPatch(const AURL: string; const AXMLQuery, AResponseContent: TStream;
  const ADepth: string);
begin
  Request.CustomHeaders.Values['Depth'] := ADepth;  {do not localize}
  try
    DoRequest(Id_HTTPMethodPropPatch, AURL, AXMLQuery, AResponseContent, []);
  finally
    Request.CustomHeaders.Values['Depth'] := '';  {do not localize}
  end;
end;

procedure TIdWebDAV.DAVPropFind(const AURL: string; const AXMLQuery, AResponseContent: TStream;
  const ADepth: string; const ARangeFrom: Integer; const ARangeTo: Integer);
begin
  if ARangeTo > -1 then begin
    Request.CustomHeaders.Values['Range'] := 'Rows=' + IntToStr(ARangeFrom) + '-' + IntToStr(ARangeTo);  {do not localize}
  end else begin
    Request.CustomHeaders.Values['Range'] := '';  {do not localize}
  end;
  Request.CustomHeaders.Values['Depth'] := ADepth;  {do not localize}
  try
    DoRequest(Id_HTTPMethodPropfind, AURL, AXMLQuery, AResponseContent, []);
  finally
    Request.CustomHeaders.Values['Depth'] := '';  {do not localize}
    if ARangeTo > -1 then begin
      Request.CustomHeaders.Values['Range'] := '';  {do not localize}
    end;
  end;
end;

procedure TIdWebDAV.DAVOrderPatch(const AURL: string; const AXMLQuery: TStream);
begin
  DoRequest(Id_HTTPMethodOrderPatch, AURL, AXMLQuery, nil, []);
end;

procedure TIdWebDAV.DAVSearch(const AURL: string; const ARangeFrom, ARangeTo: Integer;
  const AXMLQuery, AResponseContent: TStream; const ADepth: string);
begin
  if ARangeTo > -1 then begin
    Request.CustomHeaders.Values['Range'] := 'Rows=' + IntToStr(ARangeFrom) + '-' + IntToStr(ARangeTo);  {do not localize}
  end else begin
    Request.CustomHeaders.Values['Range'] := '';  {do not localize}
  end;
  Request.CustomHeaders.Values['Depth'] := ADepth;  {do not localize}
  try
    DoRequest(Id_HTTPMethodSearch, AURL, AXMLQuery, AResponseContent, []);
  finally
    Request.CustomHeaders.Values['Depth'] := '';  {do not localize}
    if ARangeTo > -1 then begin
      Request.CustomHeaders.Values['Range'] := '';  {do not localize}
    end;
  end;
end;

procedure TIdWebDAV.DAVMove(const AURL, DURL: string; const AResponseContent: TStream;
  const AOverWrite: Boolean; const ADepth: string);
begin
  if not AOverWrite then begin
    Request.CustomHeaders.Values['Overwrite'] := 'F';  {do not localize}
  end else begin
    Request.CustomHeaders.Values['Overwrite'] := '';  {do not localize}
  end;
  Request.CustomHeaders.Values['Destination'] := DURL;  {do not localize}
  Request.CustomHeaders.Values['Depth'] := ADepth;  {do not localize}
  try
    DoRequest(Id_HTTPMethodMove, AURL, nil, AResponseContent, []);
  finally
    Request.CustomHeaders.Values['Destination'] := '';  {do not localize}
    if not AOverWrite then begin
      Request.CustomHeaders.Values['Overwrite'];  {do not localize}
    end;
    Request.CustomHeaders.Values['Depth'] := '';  {do not localize}
  end;
end;

procedure TIdWebDAV.DAVCopy(const AURL, DURL: string; const AResponseContent: TStream;
  const AOverWrite: Boolean; const ADepth: string);
begin
  Request.CustomHeaders.Values['Destination'] := DURL;  {do not localize}
  Request.CustomHeaders.Values['Overwrite'] := iif(AOverWrite, 'T', 'F');  {do not localize}
  Request.CustomHeaders.Values['Depth'] := ADepth;  {do not localize}
  try
    DoRequest(Id_HTTPMethodCopy, AURL, nil, AResponseContent, []);
  finally
    Request.CustomHeaders.Values['Destination'] := '';  {do not localize}
    Request.CustomHeaders.Values['Overwrite'] := '';  {do not localize}
    Request.CustomHeaders.Values['Depth'] := '';  {do not localize}
  end;
end;

procedure TIdWebDAV.DAVCheckIn(const AURL, AComment: string);
var
  LXML: TMemoryStream;
  s: string;
begin
  DoRequest(Id_HTTPMethodCheckIn, AURL, nil, nil, []);
  if AComment <> '' then
  begin
    s := '<?xml version="1.0" encoding="utf-8" ?>' +  {do not localize}
         '<propertyupdate xmlns:D="DAV:"><set><prop>' +  {do not localize}
         '<comment>' + AComment + '</comment></prop></set></propertyupdate>';  {do not localize}
    LXML := TMemoryStream.Create;
    try
      WriteStringToStream(LXML, s, IndyTextEncoding_UTF8);
      LXML.Position := 0;
      DoRequest(Id_HTTPMethodPropPatch, AURL, LXML, nil, []);
    finally
      LXML.Free;
    end;
  end;
end;

procedure TIdWebDAV.DAVCheckOut(const AURL: String; const AXMLQuery: TStream; const AComment: String);
var
  LXML: TMemoryStream;
  s: string;
begin
  DoRequest(Id_HTTPMethodCheckOut, AURL, AXMLQuery, nil, []);
  if AComment <> '' then
  begin
    s := '<?xml version="1.0" encoding="utf-8" ?>' +   {do not localize}
         '<propertyupdate xmlns:D="DAV:"><set><prop>' +  {do not localize}
         '<comment>' + AComment + '</comment></prop></set></propertyupdate>';  {do not localize}
    LXML := TMemoryStream.Create;
    try
      WriteStringToStream(LXML, s, IndyTextEncoding_UTF8);
      LXML.Position := 0;
      DoRequest(Id_HTTPMethodPropPatch, AURL, LXML, nil, []);
    finally
      LXML.Free;
    end;
  end;
end;

procedure TIdWebDAV.DAVUnCheckOut(const AURL: string);
begin
  DoRequest(Id_HTTPMethodUnCheckOut, AURL, nil, nil, []);
end;

procedure TIdWebDAV.DAVLock(const AURL: string; const AXMLQuery, AResponseContent: TStream;
  const ALockToken, ATags: string; const ATimeOut: string; const AMustExist: Boolean;
  const ADepth: string);
begin
  //NOTE - do not specify a LockToken and Tags value.  If both exist then only
  //LockToken will be used.  If you wish to use LockToken together with other
  //tags then concatenate and send via Tags value.
  //Also note that specifying the lock token in a lock request facilitates
  //a lock refresh
  Request.CustomHeaders.Values['Timeout'] := ATimeOut;  {do not localize}
  if AMustExist then
  begin
    Request.CustomHeaders.Values['If-Match'] := '*';  {do not localize}
    Request.CustomHeaders.Values['If-None-Match'] := '';  {do not localize}
  end else
  begin
    Request.CustomHeaders.Values['If-Match'] := '';  {do not localize}
    Request.CustomHeaders.Values['If-None-Match'] := '*';  {do not localize}
  end;
  Request.CustomHeaders.Values['Depth'] := ADepth;  {do not localize}
  if ALockToken <> '' then begin
    Request.CustomHeaders.Values['If'] := '(<'+ALockToken+'>)';  {do not localize}
  end
  else if ATags <> '' then begin
    Request.CustomHeaders.Values['If'] := '('+ATags+')';  {do not localize}
  end else begin
    Request.CustomHeaders.Values['If'] := '';  {do not localize}
  end;
  try
    DoRequest(Id_HTTPMethodLock, AURL, AXMLQuery, AResponseContent, []);
  finally
    Request.CustomHeaders.Values['Timeout'] := '';  {do not localize}
    Request.CustomHeaders.Values['If-Match'] := '';  {do not localize}
    Request.CustomHeaders.Values['If-None-Match'] := '';  {do not localize}
    Request.CustomHeaders.Values['Depth'] := '';  {do not localize}
    Request.CustomHeaders.Values['If'] := '';  {do not localize}
  end;
end;

procedure TIdWebDAV.DAVUnLock(const AURL: string; const ALockToken: string);
begin
  Request.CustomHeaders.Values['Lock-Token'] := '<'+ALockToken+'>';  {do not localize}
  try
    DoRequest(Id_HTTPMethodUnLock, AURL, nil, nil, []);
  finally
    Request.CustomHeaders.Values['Lock-Token'] := '';  {do not localize}
  end;
end;

procedure TIdWebDAV.DAVReport(const AURL: string; const AXMLQuery, AResponseContent: TStream);
begin
  DoRequest(Id_HTTPMethodReport, AURL, AXMLQuery, AResponseContent, []);
end;

procedure TIdWebDAV.DAVVersionControl(const AURL: string);
begin
  DoRequest(Id_HTTPMethodVersion, AURL, nil, nil, []);
end;

procedure TIdWebDAV.DAVLabel(const AURL: string; const AXMLQuery: TStream);
begin
  DoRequest(Id_HTTPMethodLabel, AURL, AXMLQuery, nil, []);
end;

procedure TIdWebDAV.DAVPut(const AURL: string; const ASource: TStream; const ALockToken: String);
begin
  if ALockToken <> '' then begin
    Request.CustomHeaders.Values['If'] := '(<'+ALockToken+'>)';  {do not localize}
  end else begin
    Request.CustomHeaders.Values['If'] := '';  {do not localize}
  end;
  try
    inherited Put(AURL, ASource, TStream(nil));
  finally
    if ALockToken <> '' then begin
      Request.CustomHeaders.Values['If'] := '';  {do not localize}
    end;
  end;
end;

procedure TIdWebDAV.DAVDelete(const AURL: string; const ALockToken: string);
begin
  if ALockToken <> '' then begin
    Request.CustomHeaders.Values['If'] := '(<'+ALockToken+'>)';  {do not localize}
  end else begin
    Request.CustomHeaders.Values['If'] := '';  {do not localize}
  end;
  try
    inherited Delete(AURL);
  finally
    if ALockToken <> '' then begin
      Request.CustomHeaders.Values['If'] := '';  {do not localize}
    end;
  end;
end;

procedure TIdWebDAV.DAVMakeCollection(const AURL: string);
begin
  DoRequest(Id_HTTPMethodMakeCol, AURL, nil, nil, []);
end;

end.
