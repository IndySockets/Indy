{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17442: IdServerInterceptLogFile.pas }
{
{   Rev 1.5    7/23/04 6:53:28 PM  RLebeau
{ TFileStream access right tweak for Init()
}
{
{   Rev 1.4    07/07/2004 17:41:38  ANeillans
{ Added IdGlobal to uses, was not compiling cleanly due to missing function
{ WriteStringToStream.
}
{
{   Rev 1.3    6/29/04 1:20:14 PM  RLebeau
{ Updated DoLogWriteString() to call WriteStringToStream() instead
}
{
    Rev 1.2    10/19/2003 5:57:22 PM  DSiders
  Added localization comments.
}
{
{   Rev 1.1    2003.10.17 8:20:42 PM  czhower
{ Removed const
}
{
    Rev 1.0    3/22/2003 10:59:22 PM  BGooijen
  Initial check in.
  ServerIntercept to ease debugging, data/status are logged to a file
}
unit IdServerInterceptLogFile;

interface

uses
  IdServerInterceptLogBase,
  IdGlobal,
  IdObjs;

type
  TIdServerInterceptLogFile = class(TIdServerInterceptLogBase)
  protected
    FFileStream: TIdFileStream;
    FFilename:string;
  public
    procedure Init; override;
    destructor Destroy;override;
    procedure DoLogWriteString(AText: string);override;
  published
    property Filename:string read FFilename write FFilename;
  end;

implementation

uses
  IdSys, IdBaseComponent;

{ TIdServerInterceptLogFile }

destructor TIdServerInterceptLogFile.Destroy;
begin
  Sys.FreeAndNil(FFileStream);
  inherited;
end;

procedure TIdServerInterceptLogFile.Init;
begin
  inherited Init;
  if not IsDesignTime then begin
    if FFilename = '' then begin
      FFilename := Sys.ChangeFileExt(ParamStr(0), '.log'); {do not localize}  //BGO: TODO: Do we keep this, or maybe raise an exception?
    end;
    FFileStream := TAppendFileStream.Create(FFileName);
  end;
end;

procedure TIdServerInterceptLogFile.DoLogWriteString(AText: string);
begin
  WriteStringToStream(FFileStream, AText);
end;

end.

