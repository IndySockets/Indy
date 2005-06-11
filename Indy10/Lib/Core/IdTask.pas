{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  28547: IdTask.pas 
{
{   Rev 1.2    2003.11.04 3:49:00 PM  czhower
{ Update to sync TC
}
{
{   Rev 1.1    2003.10.21 12:19:02 AM  czhower
{ TIdTask support and fiber bug fixes.
}
unit IdTask;

interface

uses
  IdSys,
  IdYarn;

type
  TIdTask = class(TObject)
  protected
    FData: TObject;
    FYarn: TIdYarn;
    //
    procedure AfterRun; virtual;
    procedure BeforeRun; virtual;
    function Run: Boolean; virtual; abstract;
  public
    constructor Create(
      AYarn: TIdYarn
      ); reintroduce; virtual;
    destructor Destroy;
      override;
    // The Do's are separate so we can add events later if necessary without
    // needing the inherited calls to perform them, as well as allowing
    // us to keep the real runs as protected
    procedure DoAfterRun;
    procedure DoBeforeRun;
    function DoRun: Boolean;
    //
    property Data: TObject read FData write FData;
    property Yarn: TIdYarn read FYarn;
  end;

implementation
uses IdGlobal;

{ TIdTask }

procedure TIdTask.AfterRun;
begin
end;

procedure TIdTask.BeforeRun;
begin
end;

constructor TIdTask.Create(
  AYarn: TIdYarn
  );
begin
  inherited Create;
  FYarn := AYarn;
end;

destructor TIdTask.Destroy;
begin
  // Dont free the yarn, that is the responsibilty of the thread / fiber.
  // .Yarn here is just a reference, not an ownership
  Sys.FreeAndNil(FData);
  inherited Destroy;
end;

procedure TIdTask.DoAfterRun;
begin
  AfterRun;
end;

procedure TIdTask.DoBeforeRun;
begin
  BeforeRun;
end;

function TIdTask.DoRun: Boolean;
begin
  Result := Run;
end;

end.
