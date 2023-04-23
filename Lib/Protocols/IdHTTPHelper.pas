unit IdHTTPHelper;

{$I IdCompilerDefines.inc}

interface

uses
  Classes, IdHTTP;

{$IFDEF HAS_CLASS_HELPER}
type
  TIdHTTPHelper = class helper for TIdHTTP
  public
    procedure CustomRequest(const AMethod: TIdHTTPMethod; AURL: string;
      ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16);
  end;
{$ENDIF}

procedure TIdHTTPHelper_CustomRequest(AHTTP: TIdHTTP; const AMethod: TIdHTTPMethod;
  AURL: string; ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16); {$IFDEF HAS_CLASS_HELPER}{$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use TIdHTTPHelper.CustomRequest()'{$ENDIF};{$ENDIF}{$ENDIF}

implementation

{ TIdHTTPHelper }
  
type
  TIdHTTPAccess = class(TIdHTTP)
  end;

{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOff.inc}{$ENDIF}
procedure TIdHTTPHelper_CustomRequest(AHTTP: TIdHTTP; const AMethod: TIdHTTPMethod; AURL: string;
  ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16);
{$IFDEF HAS_CLASS_HELPER}{$I IdDeprecatedImplBugOn.inc}{$ENDIF}
begin
  TIdHTTPAccess(AHTTP).DoRequest(AMethod, AURL, ASource, AResponseContent, AIgnoreReplies);
end;

{$IFDEF HAS_CLASS_HELPER}
procedure TIdHTTPHelper.CustomRequest(const AMethod: TIdHTTPMethod; AURL: string;
  ASource, AResponseContent: TStream; AIgnoreReplies: array of Int16);
begin
  DoRequest(AMethod, AURL, ASource, AResponseContent, AIgnoreReplies);
end;
{$ENDIF}

end.
