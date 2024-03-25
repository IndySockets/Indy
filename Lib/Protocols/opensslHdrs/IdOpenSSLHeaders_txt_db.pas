  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_txt_db.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_txt_db.h2pas
     and this file regenerated. IdOpenSSLHeaders_txt_db.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 
{$IFNDEF USE_OPENSSL}
  { error Should not compile if USE_OPENSSL is not defined!!!}
{$ENDIF}
{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{                                                                              }
{******************************************************************************}

unit IdOpenSSLHeaders_txt_db;

interface

// Headers for OpenSSL 1.1.1
// txt_db.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  DB_ERROR_OK = 0;
  DB_ERROR_MALLOC = 1;
  DB_ERROR_INDEX_CLASH = 2;
  DB_ERROR_INDEX_OUT_OF_RANGE = 3;
  DB_ERROR_NO_INDEX = 4;
  DB_ERROR_INSERT_INDEX_CLASH = 5;
  DB_ERROR_WRONG_NUM_FIELDS = 6;

type
  OPENSSL_STRING = type Pointer;
  POPENSSL_STRING = ^OPENSSL_STRING;
// DEFINE_SPECIAL_STACK_OF(OPENSSL_PSTRING, OPENSSL_STRING)

  qual_func =  function (v1: POPENSSL_STRING): TIdC_INT;
  txt_db_st = record
    num_fields: TIdC_INT;
    data: Pointer; // STACK_OF(OPENSSL_PSTRING) *
    index: Pointer; // LHASH_OF(OPENSSL_STRING) **
    qual: qual_func;
    error: TIdC_LONG;
    arg1: TIdC_LONG;
    arg2: TIdC_LONG;
    arg_row: POPENSSL_STRING;
  end;
  TXT_DB = txt_db_st;
  PTXT_DB = ^TXT_DB;

  TXT_DB_create_index_qual = function(v1: POPENSSL_STRING): TIdC_INT;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM TXT_DB_read}
  {$EXTERNALSYM TXT_DB_write}
  {$EXTERNALSYM TXT_DB_free}
  {$EXTERNALSYM TXT_DB_get_by_index}
  {$EXTERNALSYM TXT_DB_insert}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  TXT_DB_read: function (in_: PBIO; num: TIdC_INT): PTXT_DB; cdecl = nil;
  TXT_DB_write: function (out_: PBIO; db: PTXT_DB): TIdC_LONG; cdecl = nil;
  //function TXT_DB_create_index(db: PTXT_DB; field: TIdC_INT; qual: TXT_DB_create_index_qual; hash: OPENSSL_LH_HashFunc; cmp: OPENSSL_LH_COMPFUNC): TIdC_INT;
  TXT_DB_free: procedure (db: PTXT_DB); cdecl = nil;
  TXT_DB_get_by_index: function (db: PTXT_DB; idx: TIdC_INT; value: POPENSSL_STRING): POPENSSL_STRING; cdecl = nil;
  TXT_DB_insert: function (db: PTXT_DB; value: POPENSSL_STRING): TIdC_INT; cdecl = nil;

{$ELSE}
  function TXT_DB_read(in_: PBIO; num: TIdC_INT): PTXT_DB cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function TXT_DB_write(out_: PBIO; db: PTXT_DB): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  //function TXT_DB_create_index(db: PTXT_DB; field: TIdC_INT; qual: TXT_DB_create_index_qual; hash: OPENSSL_LH_HashFunc; cmp: OPENSSL_LH_COMPFUNC): TIdC_INT;
  procedure TXT_DB_free(db: PTXT_DB) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function TXT_DB_get_by_index(db: PTXT_DB; idx: TIdC_INT; value: POPENSSL_STRING): POPENSSL_STRING cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};
  function TXT_DB_insert(db: PTXT_DB; value: POPENSSL_STRING): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}{$IFDEF OPENSSL_USE_DELAYED_LOADING} delayed{$ENDIF};

{$ENDIF}

implementation

  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {$ENDIF};
  

{$IFNDEF USE_EXTERNAL_LIBRARY}

{$WARN  NO_RETVAL OFF}
{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  TXT_DB_read := LoadFunction('TXT_DB_read',AFailed);
  TXT_DB_write := LoadFunction('TXT_DB_write',AFailed);
  TXT_DB_free := LoadFunction('TXT_DB_free',AFailed);
  TXT_DB_get_by_index := LoadFunction('TXT_DB_get_by_index',AFailed);
  TXT_DB_insert := LoadFunction('TXT_DB_insert',AFailed);
end;

procedure Unload;
begin
  TXT_DB_read := nil;
  TXT_DB_write := nil;
  TXT_DB_free := nil;
  TXT_DB_get_by_index := nil;
  TXT_DB_insert := nil;
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
