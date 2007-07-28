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

uses
  Classes,
  IdHTTP;

const
  Id_HTTPMethodPropFind = 'PROPFIND';
  Id_HTTPMethodPropPatch = 'PROPPATCH';
  Id_HTTPMethodOrderPatch = 'ORDERPATCH';
  Id_HTTPMethodSearch = 'SEARCH';
  Id_HTTPMethodMove = 'MOVE';
  Id_HTTPMethodCopy = 'COPY';
  Id_HTTPMethodCheckIn = 'CHECKIN';
  Id_HTTPMethodCheckOut = 'CHECKOUT';
  Id_HTTPMethodUnCheckOut = 'UNCHECKOUT';
  Id_HTTPMethodLock = 'LOCK';
  Id_HTTPMethodUnLock = 'UNLOCK';
  Id_HTTPMethodReport = 'REPORT';
  Id_HTTPMethodVersion = 'VERSION-CONTROL';
  Id_HTTPMethodLabel = 'LABEL';

const
  //casing is according to rfc
  cTimeoutInfinite='Infinite';
  cDepthInfinity='infinity';

type

  TIdWebDAV = class(TIdHTTP)
  public
    procedure DAVCheckIn(const AURL,AComment:string);
    procedure DAVCheckOut(const AURL:string;const XMLQuery: TStream;const AComment:string);
    procedure DAVCopy(const AURL, DURL: string;const AResponseContent:TStream;const AOverWrite:boolean=true;const ADepth:string=cDepthInfinity);
    procedure DAVDelete(const AURL: string;const ALockToken:string);
    procedure DAVLabel(const AURL: string;const XMLQuery:TStream);
    procedure DAVLock(const AURL: string;const XMLQuery, AResponseContent: TStream;const LockToken, Tags:string;const TimeOut:string=cTimeoutInfinite;const MustExist:Boolean=False;const Depth:string='0');
    procedure DAVMove(const AURL, DURL: string;const AResponseContent:TStream;const overwrite:boolean=true;const Depth:string=cDepthInfinity);
    procedure DAVOrderPatch(const AURL: string;const XMLQuery: TStream);
    procedure DAVPropFind(const AURL: string;const XMLQuery, AResponseContent: TStream;const Depth:string='0';const RangeFrom:integer=-1;const RangeTo:Integer=-1); //finds properties
    procedure DAVPropPatch(const AURL: string;const XMLQuery, AResponseContent: TStream;const Depth:string='0'); //patches properties
    procedure DAVPut(const AURL: string; const ASource: TStream;const LockToken:String);
    procedure DAVReport(const AURL: string;const XMLQuery, AResponseContent:TStream);
    procedure DAVSearch(const AURL: string;const rangeFrom, rangeTo:integer;const XMLQuery, AResponseContent: TStream;const Depth:string='0'); //performs a search
    procedure DAVUnCheckOut(const AURL:String);
    procedure DAVUnLock(const AURL: string;const LockToken:string);
    procedure DAVVersionControl(const AURL: string);
  end;

implementation
uses SysUtils;
{todo place somewhere else?
procedure Register;
begin
  RegisterComponents('Indy Clients', [TIdWebDAV]);
end;
}

procedure TIdWebDAV.DAVProppatch(const AURL:string;const XMLQuery,AResponseContent:TStream;const Depth:string);
begin
  request.CustomHeaders.Add('Depth '+request.CustomHeaders.NameValueSeparator+' '+depth);
  DoRequest(Id_HTTPMethodPropPatch, AURL, XMLQuery, AResponseContent,[]);
  request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
end;

procedure TIdWebDAV.DAVPropfind(const AURL: string;const XMLQuery, AResponseContent:TStream;const Depth:string;
  const RangeFrom:Integer;const RangeTo:Integer);
begin
  if rangeTo>-1 then
    request.CustomHeaders.Add('Range'+request.CustomHeaders.NameValueSeparator+' Rows='+intToStr(rangeFrom)+'-'+IntToStr(rangeTo));
  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+depth);
  try
    DoRequest(Id_HTTPMethodPropfind, AURL, XMLQuery, AResponseContent,[]);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
    if rangeTo>-1 then
      request.CustomHeaders.Delete(request.customHeaders.indexOfName('Range'));
  end;
end;

procedure TIdWebDAV.DAVORDERPATCH(const AURL: string;const XMLQuery : TStream);
begin
  DoRequest(Id_HTTPMethodOrderPatch, AURL, XMLQuery, Nil, []);
end;

procedure TIdWebDAV.DAVSearch(const AURL: string;const rangeFrom, rangeTo:integer;const XMLQuery, AResponseContent: TStream;const Depth:string);
begin
  if rangeTo>-1 then
  begin
    request.CustomHeaders.Add('Range'+request.CustomHeaders.NameValueSeparator+' Rows='+IntToStr(rangeFrom)+'-'+IntToStr(rangeTo));
  end;
  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+depth);
  try
    DoRequest(Id_HTTPMethodSearch, AURL, XMLQuery, AResponseContent, []);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
    if rangeTo>-1 then
      request.CustomHeaders.Delete(request.customHeaders.indexOfName('Range'));
  end;
end;

procedure TIdWebDAV.DAVMove(const AURL, DURL: string;const AResponseContent:TStream;const overwrite:boolean;const Depth:string);
var
 foverwrite:string;
begin
  if not overwrite then
    begin
      foverwrite:='F';
      request.CustomHeaders.Add('Overwrite'+request.CustomHeaders.NameValueSeparator+' '+foverwrite);
    end;
  request.CustomHeaders.Add('Destination'+request.CustomHeaders.NameValueSeparator+' '+DURL);

  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+depth);
  try
    DoRequest(Id_HTTPMethodMove, AURL, Nil, AResponseContent, []);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Destination'));
    if not overwrite then
      request.CustomHeaders.Delete(request.customHeaders.indexOfName('Overwrite'));
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
  end;
end;

procedure TIdWebDAV.DAVCopy(const AURL, DURL: string;const AResponseContent:TStream;const AOverWrite:Boolean;const ADepth:string);
var
 foverwrite:string;
begin
  if AOverWrite then
    foverwrite:='T'
  else
    foverwrite:='f';
  request.CustomHeaders.Add('Destination'+request.CustomHeaders.NameValueSeparator+' '+DURL);
  request.CustomHeaders.Add('Overwrite'+request.CustomHeaders.NameValueSeparator+' '+foverwrite);
  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+aDepth);
  try
    DoRequest(Id_HTTPMethodCopy, AURL, Nil, AResponseContent, []);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Destination'));
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Overwrite'));
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
  end;
end;

procedure TIdWebDAV.DAVCheckIn(const AURL,AComment:string);
var
  xml:TMemoryStream;
  s:string;
begin
  DoRequest(Id_HTTPMethodCheckIn, AURL, Nil, Nil, []);
  if AComment<>'' then
    begin
      xml:=TMemoryStream.create;
      try
        s:=('<?xml version="1.0" encoding="utf-8" ?><propertyupdate xmlns:D="DAV:"><set><prop>'
         +'<comment>'+AComment+'</comment></set></set></propertyupdate>');
        xml.write(s[1], length(s));
        DoRequest(Id_HTTPMethodPropPatch, AURL, xml, Nil, []);
      finally
        xml.free;
      end;
    end;
end;

procedure TIdWebDAV.DAVCheckOut(const AURL:String;const XMLQuery: TStream;const AComment:String);
var
  xml:TMemoryStream;
  s:string;
begin
  DoRequest(Id_HTTPMethodCheckOut, AURL, XMLQuery, nil, []);
  if AComment<>'' then
    begin
      xml:=TMemoryStream.create;
      try
        s:=('<?xml version="1.0" encoding="utf-8" ?><propertyupdate xmlns:D="DAV:"><set><prop>'
         +'<comment>'+AComment+'</comment></set></set></propertyupdate>');
        xml.write(s[1], length(s));
        DoRequest(Id_HTTPMethodPropPatch, AURL, xml, Nil, []);
      finally
        xml.free;
      end;
    end;
end;

procedure TIdWebDAV.DAVUnCheckOut(const AURL:string);
begin
  DoRequest(Id_HTTPMethodUnCheckOut, AURL, Nil, Nil, []);
end;

procedure TIdWebDAV.DAVLock(
 const AURL: string;
 const XMLQuery, AResponseContent: TStream;
 const LockToken, Tags:string;
 const TimeOut:string;
 const MustExist:Boolean;
 const Depth:string);
var
 index:integer;
begin
  //NOTE - do not specify a LockToken and Tags value.  If both exist then only LockToken will be used.  If you wish to use LockToken
  //together with other tags then concatenate and send via Tags value
  //Also note that specifying the lock token in a lock request facilitates a lock refresh
  request.CustomHeaders.Add('Timeout'+request.CustomHeaders.NameValueSeparator+' '+TimeOut);
  if mustExist then
    request.CustomHeaders.Add('If-Match'+request.CustomHeaders.NameValueSeparator+' *')
  else
    request.CustomHeaders.Add('If-None-Match'+request.CustomHeaders.NameValueSeparator+' *');
  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+depth);
  if LockToken<>'' then
    request.CustomHeaders.Add('If'+request.CustomHeaders.NameValueSeparator+' (<'+LockToken+'>)')
  else
    if Tags<>'' then
      request.CustomHeaders.Add('If'+request.CustomHeaders.NameValueSeparator+' ('+Tags+')');
  try
    DoRequest(Id_HTTPMethodLock, AURL, XMLQuery, AResponseContent, []);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Timeout'));
    index:=request.customHeaders.indexOfName('If-Match');
    if index<>-1 then
      request.CustomHeaders.Delete(index);
    index:=request.customHeaders.indexOfName('If-None-Match');
    if index<>-1 then
      request.CustomHeaders.Delete(index);
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
    index:=request.customHeaders.indexOfName('If');
    if index<>-1 then
      request.CustomHeaders.Delete(index);
  end;
end;

procedure TIdWebDAV.DAVUnLock(const AURL: string;const LockToken:string);
begin
  request.CustomHeaders.Add('Lock-Token'+request.CustomHeaders.NameValueSeparator+' <'+LockToken+'>');
  DoRequest(Id_HTTPMethodUnLock, AURL, Nil, Nil, []);
  request.CustomHeaders.Delete(request.customHeaders.indexOfName('Lock-Token'));
end;

procedure TIdWebDAV.DAVReport(const AURL: string;const XMLQuery, AResponseContent:TStream);
begin
  DoRequest(Id_HTTPMethodReport, AURL, XMLQuery, AResponseContent, []);
end;

procedure TIdWebDAV.DAVVersionControl(const AURL: string);
begin
  DoRequest(Id_HTTPMethodVersion, AURL, Nil, Nil, []);
end;

procedure TIdWebDAV.DAVLabel(const AURL: string;const XMLQuery:TStream);
begin
  DoRequest(Id_HTTPMethodLabel, AURL, XMLQuery, Nil, []);
end;

procedure TIdWebDAV.DAVPut(const AURL: string; const ASource: TStream;const LockToken:String);
begin
  if lockToken<>'' then
    Request.CustomHeaders.Add('If'+request.CustomHeaders.NameValueSeparator+' (<'+LockToken+'>)');
  try
    //possible conflicts with baseclass PUT?
    DoRequest(Id_HTTPMethodPut, AURL, ASource, Nil, []);
  finally
    if lockToken<>'' then
      Request.CustomHeaders.Delete(request.customHeaders.indexOfName('If'));
  end;
end;

procedure TIdWebDAV.DAVDelete(const AURL:string;const ALockToken:string);
begin
  if ALockToken<>'' then
    Request.CustomHeaders.Add('If'+request.CustomHeaders.NameValueSeparator+' (<'+ALockToken+'>)');
  try
    DoRequest(Id_HTTPMethodDelete, AURL, Nil, nil, []);
  finally
    if ALockToken<>'' then
      Request.CustomHeaders.Delete(request.customHeaders.indexOfName('If'));
  end;
end;

end.
