unit IdHTTPDAV;

interface

uses
  Classes, IdHTTP, IdGlobal;

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

type

  TIdHTTPDAV = class(TIdHTTP)
  public
    procedure DAVCheckIn(AURL:String; checkInComment:string);
    procedure DAVCheckOut(AURL:String; XMLQuery: TStream; checkOutComment:String);
    procedure DAVCopy(AURL, DURL: string; AResponseContent:TStream; overwrite:boolean=true; Depth:string='infinity');
    procedure DAVDelete(AURL: string; LockToken:String);
    procedure DAVLabel(AURL: string; XMLQuery:TStream);
    procedure DAVLock(AURL: string; XMLQuery, AResponseContent: TStream; LockToken, Tags:string; TimeOut:string='Infinite'; MustExist:Boolean=False; Depth:string='0');
    procedure DAVMove(AURL, DURL: string; AResponseContent:TStream; overwrite:boolean=true; Depth:string='infinity');
    procedure DAVOrderPatch(AURL: string; XMLQuery: TStream);
    procedure DAVPropFind(AURL: string; XMLQuery, AResponseContent: TStream; Depth:string='0';RangeFrom:integer=-1; RangeTo:Integer=-1); //finds properties
    procedure DAVPropPatch(AURL: string; XMLQuery, AResponseContent: TStream; Depth:string='0'); //patches properties
    procedure DAVPut(AURL: string; const ASource: TStream; LockToken:String);
    procedure DAVReport(AURL: string; XMLQuery, AResponseContent:TStream);
    procedure DAVSearch(AURL: string; rangeFrom, rangeTo:integer; XMLQuery, AResponseContent: TStream; Depth:string='0'); //performs a search
    procedure DAVUnCheckOut(AURL:String);
    procedure DAVUnLock(AURL: string; LockToken:string);
    procedure DAVVersionControl(AURL: string);
  end;

implementation

{todo place somewhere else?
procedure Register;
begin
  RegisterComponents('Indy Clients', [TIdWebDAV]);
end;
}

procedure TIdHTTPDAV.DAVProppatch(AURL: string; XMLQuery, AResponseContent: TStream; Depth:string='0');
begin
  request.CustomHeaders.Add('Depth '+request.CustomHeaders.NameValueSeparator+' '+depth);
  DoRequest(Id_HTTPMethodPropPatch, AURL, XMLQuery, AResponseContent,[]);
  request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
end;

procedure TIdHTTPDAV.DAVPropfind(AURL: string; XMLQuery, AResponseContent: TStream; Depth:string='0';
  RangeFrom:integer=-1; RangeTo:Integer=-1);
begin
  if rangeTo>-1 then
    request.CustomHeaders.Add('Range'+request.CustomHeaders.NameValueSeparator+' Rows='+sys.intToStr(rangeFrom)+'-'+Sys.IntToStr(rangeTo));
  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+depth);
  try
    DoRequest(Id_HTTPMethodPropfind, AURL, XMLQuery, AResponseContent,[]);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
    if rangeTo>-1 then
      request.CustomHeaders.Delete(request.customHeaders.indexOfName('Range'));
  end;
end;

procedure TIdHTTPDAV.DAVORDERPATCH(AURL: string; XMLQuery : TStream);
begin
  DoRequest(Id_HTTPMethodOrderPatch, AURL, XMLQuery, Nil, []);
end;

procedure TIdHTTPDAV.DAVSearch(AURL: string; rangeFrom, rangeTo:integer; XMLQuery, AResponseContent: TStream; Depth:string='0');
begin
  if rangeTo>-1 then
    request.CustomHeaders.Add('Range'+request.CustomHeaders.NameValueSeparator+' Rows='+Sys.IntToStr(rangeFrom)+'-'+Sys.IntToStr(rangeTo));
  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+depth);
  try
    DoRequest(Id_HTTPMethodSearch, AURL, XMLQuery, AResponseContent, []);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
    if rangeTo>-1 then
      request.CustomHeaders.Delete(request.customHeaders.indexOfName('Range'));
  end;
end;


procedure TIdHTTPDAV.DAVMove(AURL, DURL: string; AResponseContent:TStream; overwrite:boolean=true; Depth:string='infinity');
  var foverwrite:string;
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

procedure TIdHTTPDAV.DAVCopy(AURL, DURL: string; AResponseContent:TStream; overwrite:boolean=true; Depth:string='infinity');
  var foverwrite:string;
begin
  if overwrite then
    foverwrite:='T'
  else
    foverwrite:='f';
  request.CustomHeaders.Add('Destination'+request.CustomHeaders.NameValueSeparator+' '+DURL);
  request.CustomHeaders.Add('Overwrite'+request.CustomHeaders.NameValueSeparator+' '+foverwrite);
  request.CustomHeaders.Add('Depth'+request.CustomHeaders.NameValueSeparator+' '+depth);
  try
    DoRequest(Id_HTTPMethodCopy, AURL, Nil, AResponseContent, []);
  finally
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Destination'));
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Overwrite'));
    request.CustomHeaders.Delete(request.customHeaders.indexOfName('Depth'));
  end;
end;

procedure TIdHTTPDAV.DAVCheckIn(AURL:string; checkInComment:string);
  var xml:TMemoryStream;
  s:string;
begin
  DoRequest(Id_HTTPMethodCheckIn, AURL, Nil, Nil, []);
  if checkInComment<>'' then
    begin
      xml:=TMemoryStream.create;
      try
        s:=('<?xml version="1.0" encoding="utf-8" ?><propertyupdate xmlns:D="DAV:"><set><prop>'
         +'<comment>'+checkInComment+'</comment></set></set></propertyupdate>');
        xml.write(s[1], length(s));
        DoRequest(Id_HTTPMethodPropPatch, AURL, xml, Nil, []);
      finally
        xml.free;
      end;
    end;
end;

procedure TIdHTTPDAV.DAVCheckOut(AURL:String; XMLQuery: TStream; checkOutComment:String);
  var xml:TMemoryStream;
  s:string;
begin
  DoRequest(Id_HTTPMethodCheckOut, AURL, XMLQuery, nil, []);
  if checkOutComment<>'' then
    begin
      xml:=TMemoryStream.create;
      try
        s:=('<?xml version="1.0" encoding="utf-8" ?><propertyupdate xmlns:D="DAV:"><set><prop>'
         +'<comment>'+checkOutComment+'</comment></set></set></propertyupdate>');
        xml.write(s[1], length(s));
        DoRequest(Id_HTTPMethodPropPatch, AURL, xml, Nil, []);
      finally
        xml.free;
      end;
    end;
end;

procedure TIdHTTPDAV.DAVUnCheckOut(AURL:string);
begin
  DoRequest(Id_HTTPMethodUnCheckOut, AURL, Nil, Nil, []);
end;

procedure TIdHTTPDAV.DAVLock(AURL: string; XMLQuery, AResponseContent: TStream; LockToken, Tags:string;
 TimeOut:string='Infinite'; MustExist:Boolean=False; Depth:string='0');
 var index:integer;
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

procedure TIdHTTPDAV.DAVUnLock(AURL: string; LockToken:string);
begin
  request.CustomHeaders.Add('Lock-Token'+request.CustomHeaders.NameValueSeparator+' <'+LockToken+'>');
  DoRequest(Id_HTTPMethodUnLock, AURL, Nil, Nil, []);
  request.CustomHeaders.Delete(request.customHeaders.indexOfName('Lock-Token'));
end;

procedure TIdHTTPDAV.DAVReport(AURL: string; XMLQuery, AResponseContent:TStream);
begin
  DoRequest(Id_HTTPMethodReport, AURL, XMLQuery, AResponseContent, []);
end;

procedure TIdHTTPDAV.DAVVersionControl(AURL: string);
begin
  DoRequest(Id_HTTPMethodVersion, AURL, Nil, Nil, []);
end;

procedure TIdHTTPDAV.DAVLabel(AURL: string; XMLQuery:TStream);
begin
  DoRequest(Id_HTTPMethodLabel, AURL, XMLQuery, Nil, []);
end;

procedure TIdHTTPDAV.DAVPut(AURL: string; const ASource: TStream; LockToken:String);
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

procedure TIdHTTPDAV.DAVDelete(AURL: string; LockToken:String);
begin
  if lockToken<>'' then
    Request.CustomHeaders.Add('If'+request.CustomHeaders.NameValueSeparator+' (<'+LockToken+'>)');
  try
    DoRequest(Id_HTTPMethodDelete, AURL, Nil, nil, []);
  finally
    if lockToken<>'' then
      Request.CustomHeaders.Delete(request.customHeaders.indexOfName('If'));
  end;
end;

end.
