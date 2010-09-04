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
{
  Rev 1.6    2004.05.20 1:39:26 PM  czhower
  Last of the IdStream updates

  Rev 1.5    2004.05.20 11:37:24 AM  czhower
  IdStreamVCL

  Rev 1.4    2004.05.20 11:13:16 AM  czhower
  More IdStream conversions

  Rev 1.3    10/05/2004 23:59:26  CCostelloe
  Bug fix

  Rev 1.2    2004.02.03 5:45:50 PM  czhower
  Name changes

  Rev 1.1    1/31/2004 3:12:52 AM  JPMugaas
  Removed dependancy on Math unit.  It isn't needed and is problematic in some
  versions of Dlephi which don't include it.

  Rev 1.0    26/09/2003 01:08:16  CCostelloe
  Initial version
}

unit IdMessageCoderQuotedPrintable;

interface

{$i IdCompilerDefines.inc}

// Written by C Costelloe, 23rd September 2003

uses
  Classes,
  IdMessageCoder,
  IdMessage,
  IdGlobal;

{ Note: Decoding handled by IdMessageDecoderMIME }

type
  TIdMessageEncoderQuotedPrintable = class(TIdMessageEncoder)
  public
    procedure Encode(ASrc: TStream; ADest: TStream); override;
  end;

  TIdMessageEncoderInfoQuotedPrintable = class(TIdMessageEncoderInfo)
  public
    constructor Create; override;
  end;

implementation

uses
  IdCoder, IdCoderMIME, IdException, IdGlobalProtocols, IdResourceStrings, IdCoderQuotedPrintable,
  IdCoderHeader, SysUtils;

{ TIdMessageEncoderInfoQuotedPrintable }

constructor TIdMessageEncoderInfoQuotedPrintable.Create;
begin
  inherited;
  FMessageEncoderClass := TIdMessageEncoderQuotedPrintable;
end;

{ TIdMessageEncoderQuotedPrintable }

procedure TIdMessageEncoderQuotedPrintable.Encode(ASrc: TStream; ADest: TStream);
var
  LEncoder: TIdEncoderQuotedPrintable;
begin
  LEncoder := TIdEncoderQuotedPrintable.Create(nil); try
    LEncoder.Encode(ASrc, ADest);
  finally FreeAndNil(LEncoder); end;
end;

initialization
  TIdMessageEncoderList.RegisterEncoder('QP', TIdMessageEncoderInfoQuotedPrintable.Create);    {Do not Localize}

end.
