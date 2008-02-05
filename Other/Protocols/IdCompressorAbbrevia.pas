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

unit IdCompressorAbbrevia;

//uses the opensource Abbrevia component set to implement compression
//eg for http gzip decoding
//see http://sourceforge.net/projects/tpabbrevia/

interface

uses
  AbGzTyp,
  AbUtils,
  IdZLibCompressorBase,
  IdObjs,
  IdSys;

type

  //currently just implements gzip decompression.
  TIdCompressorAbbrevia = class(TIdZLibCompressorBase)
  public
    procedure DecompressGZipStream(AInStream, AOutStream : TIdStream); override;
  end;

implementation

procedure TIdCompressorAbbrevia.DecompressGZipStream(AInStream, AOutStream : TIdStream);
var
  aGz:TAbGzipStreamHelper;
  aType:TAbArchiveType;
begin
  //no inherited;

  aType:=VerifyGZip(AInStream);
  Assert(aType=atGzip);

  aGz:=TAbGzipStreamHelper.Create(AInStream);
  try
  aGz.ExtractItemData(AOutStream);
  finally
  Sys.FreeAndNil(aGz);
  end;
end;

end.
