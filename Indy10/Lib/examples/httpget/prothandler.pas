unit prothandler;
interface
{$mode delphi}{$H+}
uses
{$IFDEF UNIX}
  {$define usezlib}
  {$define useopenssl}
{$ENDIF}
{$IFDEF WIN32}
  {$define usezlib}
  {$define useopenssl}
{$ENDIF}
  Classes, SysUtils, IdURI;
type
  TProtHandler = class(TObject)
  protected
    FLogData : TStrings;
    FVerbose : Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function CanHandleURL(AURL : TIdURI) : Boolean; virtual; abstract;
    procedure GetFile(AURL : TIdURI); virtual; abstract;
    property LogData : TStrings read FLogData;
    property Verbose : Boolean read FVerbose write FVerbose;
  end;

implementation

constructor TProtHandler.Create;
begin
  inherited Create;
  FLogData := TStringList.Create;
end;

destructor TProtHandler.Destroy;
begin
  FreeAndNil(FLogData);
end;

end.
