{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11239: DNSResolver.pas 
{
    Rev 1.1    5/19/2003 10:29:24 AM  BGooijen
  Compiles now
}
{
{   Rev 1.0    11/12/2002 09:15:42 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit DNSResolver;

interface

uses
  IndyBox,
  IdDNSResolver;

const
  DefaultHost = 'a.root-servers.net';

type
  TDNSResolverBasic = class(TIndyBox)
  protected
    FA : String;
    FSOA : String;
    procedure Query(AQuery : TQueryType);
  end;

  TDNSARecord = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

  TDNSMXRecord = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

  TDNSNameRecord = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

  TDNSNSRecord = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

  TDNSTXTRecord = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

  TDNSPTRRecord = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

  TDNSRareRecords = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

  TDNSSOARecord = class(TDNSResolverBasic)
  public
    procedure Test; override;
  end;

implementation

uses
  IdCoreGlobal,
  IdGlobal,
  SysUtils;

{ TDNSREsolverProc }

procedure TDNSResolverBasic.Query(AQuery : TQueryType);
var
  DNS : TIdDNSResolver;
  Host : String;
  Query : String;

  procedure Output;
  var
    i : Integer;
    A : TARecord;
    MX : TMXRecord;
    NS : TNSRecord;
    SOA : TSOARecord;
  begin
    for i := 0 to DNS.QueryResult.Count - 1 do
    begin
      Status('Name: ' + DNS.QueryResult.Items[i].Name
        + CR + LF + 'TTL: ' + IntToStr(DNS.QueryResult.Items[i].TTL));
      if DNS.QueryResult.Items[i].InheritsFrom(TARecord) then
      begin
        A := TARecord(DNS.QueryResult.Items[i]);
        Status('A: ' + A.IPAddress);
        FA := A.IPAddress;
      end else if DNS.QueryResult.Items[i].InheritsFrom(TNSRecord) then
      begin
        NS := TNSRecord(DNS.QueryResult.Items[i]);
        Status('NS: ' + NS.HostName);
      end else if DNS.QueryResult.Items[i].InheritsFrom(TSOARecord) then
      begin
        SOA := TSOARecord(DNS.QueryResult.Items[i]);
        FSOA := SOA.Primary;
        Status('SOA: ' + CR + LF + TAB + 'Primary: ' + SOA.Primary
         + CR + LF + TAB + 'Responsible person: ' + SOA.ResponsiblePerson
         + CR + LF + TAB + 'Serial: ' + IntToStr(SOA.Serial)
         + CR + LF + TAB + 'Refresh: ' + IntTOStr(SOA.Refresh)
         + CR + LF + TAB + 'Retry: ' + IntTOStr(SOA.Retry)
         + CR + LF + TAB + 'Expire: ' + IntTOStr(SOA.Expire)
         + CR + LF + TAB + 'MinTTL: ' + IntTOStr(SOA.MinimumTTL)
         );
      end else if DNS.QueryResult.Items[i].InheritsFrom(TMXRecord) then
      begin
        MX := TMXRecord(DNS.QueryResult.Items[i]);
        Status('MX: ' + TAB + 'Preference: ' + IntToStr(MX.Preference)
          + TAB + ' Server: ' + MX.ExchangeServer);
      end else
      begin
        Status('Record type not catered for in test: '
          + DNS.QueryResult.Items[i].DisplayName);
      end;
    end;
  end;
  
begin
  DNS := TIdDNSResolver.Create(Nil);
  try
    Host := Trim(GlobalParamValue('DNS Server'));
    if Length(Host) = 0 then
    begin
      Host := DefaultHost;      
    end;
    DNS.Host := Host;
    Query := Trim(GlobalParamValue('DNS Domain'));
    if (Length(Query) = 0)
    or (Query = 'Unspecified') then
    begin
      Query := 'nevrona.com';
    end;

    DNS.QueryType := AQuery;
    if AQuery = [qtPTR] then
    begin
      Status('Altering PTR to check: ' + FA + ' from ' + FSOA);
      DNS.Host := FSOA;
      DNS.Resolve(FA);
    end else
    begin
      DNS.Resolve(Query);
    end;
    Output;

  finally
    FreeAndNil(DNS);
  end;
end;

{ TDNSARecord }

procedure TDNSARecord.Test;
begin
  Status('Getting A record');
  Query([qtA]);
end;

{ TDNSMXRecord }

procedure TDNSMXRecord.Test;
begin
  Status('Getting MX record');
  Query([qtMX]);
end;

{ TDNSRareRecords }

procedure TDNSRareRecords.Test;
begin
  Status('Getting MD record');
  Query([qtMD]);
  Status('Getting MF record');
  Query([qtMF]);
  Status('Getting MB record');
  Query([qtMB]);
  Status('Getting MG record');
  Query([qtMG]);
  Status('Getting MR record');
  Query([qtMR]);
  Status('Getting Null record');
  Query([qtNull]);
  Status('Getting WKS record');
  Query([qtWKS]);
  Status('Getting HINFO record');
  Query([qtHINFO]);
  Status('Getting MINFO record');
  Query([qtMINFO]);
  Status('Getting STAR record');
  Query([qtSTAR]);
  Status('Getting all records');
  Query([qtA, qtNS, qtMD, qtMF, qtName, qtSOA, qtMB, qtMG,
    qtMR, qtNull, qtWKS, qtPTR, qtHINFO, qtMINFO, qtMX, qtTXT, qtSTAR]);
end;

{ TDNSNSRecord }

procedure TDNSNSRecord.Test;
begin
  Status('Getting NS record');
  Query([qtNS]);
end;

{ TDNSNameRecord }

procedure TDNSNameRecord.Test;
begin
  Status('Getting Name record');
  Query([qtName]);
end;

{ TDNSSOARecord }

procedure TDNSSOARecord.Test;
begin
  Status('Getting SOA record');
  Query([qtSOA]);
end;

{ TDNSPTRRecord }

procedure TDNSPTRRecord.Test;
begin
  Status('Getting A record for PTR test');
  Query([qtA]);
  Status('Getting SOA record for PTR test');
  Query([qtSOA]);
  Status('Getting PTR record');
  Query([qtPTR]);
end;

{ TDNSTXTRecord }

procedure TDNSTXTRecord.Test;
begin
  Status('Getting TXT record');
  Query([qtTXT]);
end;

initialization
  TIndyBox.RegisterBox(TDNSARecord, 'A Record', 'Clients - DNS');
  TIndyBox.RegisterBox(TDNSMXRecord, 'MX Record', 'Clients - DNS');
  TIndyBox.RegisterBox(TDNSNameRecord, 'Name Record', 'Clients - DNS');
  TIndyBox.RegisterBox(TDNSNSRecord, 'NS Record', 'Clients - DNS');
  TIndyBox.RegisterBox(TDNSRareRecords, 'Rare Records', 'Clients - DNS');
  TIndyBox.RegisterBox(TDNSPTRRecord, 'PTR Record', 'Clients - DNS');
  TIndyBox.RegisterBox(TDNSSOARecord, 'SOA Record', 'Clients - DNS');
  TIndyBox.RegisterBox(TDNSTXTRecord, 'TXT Record', 'Clients - DNS');
end.
