{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  23944: IdMessageCoderQuotedPrintable.pas 
{
{   Rev 1.6    2004.05.20 1:39:26 PM  czhower
{ Last of the IdStream updates
}
{
{   Rev 1.5    2004.05.20 11:37:24 AM  czhower
{ IdStreamVCL
}
{
{   Rev 1.4    2004.05.20 11:13:16 AM  czhower
{ More IdStream conversions
}
{
{   Rev 1.3    10/05/2004 23:59:26  CCostelloe
{ Bug fix
}
{
{   Rev 1.2    2004.02.03 5:45:50 PM  czhower
{ Name changes
}
{
{   Rev 1.1    1/31/2004 3:12:52 AM  JPMugaas
{ Removed dependancy on Math unit.  It isn't needed and is problematic in some
{ versions of Dlephi which don't include it.
}
{
{   Rev 1.0    26/09/2003 01:08:16  CCostelloe
{ Initial version
}
unit IdMessageCoderQuotedPrintable;

interface

//Written by C Costelloe, 23rd September 2003

uses
  Classes,
  IdMessageCoder,
  IdMessage,
  IdStream,
  IdStreamVCL,
  IdStreamRandomAccess,
  IdSys;

  {Note: Decoding handled by IdMessageDecoderMIME}

type
  TIdMessageEncoderQuotedPrintable = class(TIdMessageEncoder)
  public
    procedure Encode(ASrc: TIdStreamRandomAccess; ADest: TIdStream); override;
  end;

  TIdMessageEncoderInfoQuotedPrintable = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
  end;

implementation

uses
  IdCoder, IdCoderMIME, IdGlobal, IdException, IdGlobalProtocols, IdResourceStrings, IdCoderQuotedPrintable,
  IdCoderHeader;

{ TIdMessageEncoderInfoQuotedPrintable }

constructor TIdMessageEncoderInfoQuotedPrintable.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderQuotedPrintable;
end;

{ TIdMessageEncoderQuotedPrintable }

procedure TIdMessageEncoderQuotedPrintable.Encode(ASrc: TIdStreamRandomAccess; ADest: TIdStream);
var
  LEncoder: TIdEncoderQuotedPrintable;
begin
  LEncoder := TIdEncoderQuotedPrintable.Create(nil); try
    ADest.Write(LEncoder.Encode(ASrc, ASrc.Size));
  finally Sys.FreeAndNil(LEncoder); end;
end;

initialization
  TIdMessageEncoderList.RegisterEncoder('QP', TIdMessageEncoderInfoQuotedPrintable.Create);    {Do not Localize}

end.
