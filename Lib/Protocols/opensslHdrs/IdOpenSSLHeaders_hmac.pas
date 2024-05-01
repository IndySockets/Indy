  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_hmac.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_hmac.h2pas
     and this file regenerated. IdOpenSSLHeaders_hmac.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_hmac;

interface

// Headers for OpenSSL 1.1.1
// hmac.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_evp;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM HMAC_size} {introduced 1.1.0}
  {$EXTERNALSYM HMAC_CTX_new} {introduced 1.1.0}
  {$EXTERNALSYM HMAC_CTX_reset} {introduced 1.1.0}
  {$EXTERNALSYM HMAC_CTX_free} {introduced 1.1.0}
  {$EXTERNALSYM HMAC_Init_ex}
  {$EXTERNALSYM HMAC_Update}
  {$EXTERNALSYM HMAC_Final}
  {$EXTERNALSYM HMAC}
  {$EXTERNALSYM HMAC_CTX_copy}
  {$EXTERNALSYM HMAC_CTX_set_flags}
  {$EXTERNALSYM HMAC_CTX_get_md} {introduced 1.1.0}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM HMAC_CTX_init} {removed 1.1.0}
  {$EXTERNALSYM HMAC_CTX_cleanup} {removed 1.1.0}
  HMAC_CTX_init: procedure (ctx : PHMAC_CTX); cdecl = nil; {removed 1.1.0}
  HMAC_size: function (const e: PHMAC_CTX): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  HMAC_CTX_new: function : PHMAC_CTX; cdecl = nil; {introduced 1.1.0}
  HMAC_CTX_reset: function (ctx: PHMAC_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  HMAC_CTX_cleanup: procedure (ctx : PHMAC_CTX); cdecl = nil; {removed 1.1.0}
  HMAC_CTX_free: procedure (ctx: PHMAC_CTX); cdecl = nil; {introduced 1.1.0}

  HMAC_Init_ex: function (ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT; cdecl = nil;
  HMAC_Update: function (ctx: PHMAC_CTX; const data: PByte; len: TIdC_SIZET): TIdC_INT; cdecl = nil;
  HMAC_Final: function (ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT; cdecl = nil;
  HMAC: function (const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: TIdC_SIZET; md: PByte; md_len: PIdC_INT): PByte; cdecl = nil;
  HMAC_CTX_copy: function (dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT; cdecl = nil;

  HMAC_CTX_set_flags: procedure (ctx: PHMAC_CTX; flags: TIdC_ULONG); cdecl = nil;
  HMAC_CTX_get_md: function (const ctx: PHMAC_CTX): PEVP_MD; cdecl = nil; {introduced 1.1.0}

{$ELSE}
  function HMAC_size(const e: PHMAC_CTX): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function HMAC_CTX_new: PHMAC_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function HMAC_CTX_reset(ctx: PHMAC_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure HMAC_CTX_free(ctx: PHMAC_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function HMAC_Init_ex(ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_Update(ctx: PHMAC_CTX; const data: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_Final(ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC(const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: TIdC_SIZET; md: PByte; md_len: PIdC_INT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_CTX_copy(dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  procedure HMAC_CTX_set_flags(ctx: PHMAC_CTX; flags: TIdC_ULONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function HMAC_CTX_get_md(const ctx: PHMAC_CTX): PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

{$ENDIF}

implementation

  uses
    classes, 
    IdSSLOpenSSLExceptionHandlers, 
    IdResourceStringsOpenSSL
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    ,IdSSLOpenSSLLoader
  {$ENDIF};
  
const
  HMAC_size_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  HMAC_CTX_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  HMAC_CTX_reset_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  HMAC_CTX_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  HMAC_CTX_get_md_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  HMAC_CTX_init_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  HMAC_CTX_cleanup_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);



{$IFNDEF USE_EXTERNAL_LIBRARY}



{forward_compatibility}
function  FC_HMAC_CTX_new: PHMAC_CTX; cdecl;
begin
  Result := AllocMem(SizeOf(HMAC_CTX));
  HMAC_CTX_init(Result);
end;

procedure  FC_HMAC_CTX_free(ctx: PHMAC_CTX); cdecl;
begin
  HMAC_CTX_cleanup(ctx);
  FreeMem(ctx,SizeOf(HMAC_CTX));
end;

(*
typedef struct hmac_ctx_st {
    const EVP_MD *md;
    EVP_MD_CTX md_ctx;
    EVP_MD_CTX i_ctx;
    EVP_MD_CTX o_ctx;
    unsigned int key_length;
    unsigned char key[HMAC_MAX_MD_CBLOCK];
} HMAC_CTX;
*)

const
  HMAC_MAX_MD_CBLOCK = 128; {largest known is SHA512}

type
 PHMAC_CTX = ^HMAC_CTX;
 HMAC_CTX = record
   md: EVP_MD;
   md_ctx: EVP_MD_CTX;
   i_ctx: EVP_MD_CTX;
   o_ctx: EVP_MD_CTX;
   key_length: TIdC_UINT;
   key: array [0..HMAC_MAX_MD_CBLOCK] of char;
 end;


function  FC_HMAC_size(const e: PHMAC_CTX): TIdC_SIZET; cdecl; 
begin
  Result := EVP_MD_size(e^.md);
end;

{/forward_compatibility}
{$WARN  NO_RETVAL OFF}
procedure  ERR_HMAC_CTX_init(ctx : PHMAC_CTX); 
begin
  EIdAPIFunctionNotPresent.RaiseException('HMAC_CTX_init');
end;


function  ERR_HMAC_size(const e: PHMAC_CTX): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('HMAC_size');
end;


function  ERR_HMAC_CTX_new: PHMAC_CTX; 
begin
  EIdAPIFunctionNotPresent.RaiseException('HMAC_CTX_new');
end;


function  ERR_HMAC_CTX_reset(ctx: PHMAC_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('HMAC_CTX_reset');
end;


procedure  ERR_HMAC_CTX_cleanup(ctx : PHMAC_CTX); 
begin
  EIdAPIFunctionNotPresent.RaiseException('HMAC_CTX_cleanup');
end;


procedure  ERR_HMAC_CTX_free(ctx: PHMAC_CTX); 
begin
  EIdAPIFunctionNotPresent.RaiseException('HMAC_CTX_free');
end;


function  ERR_HMAC_CTX_get_md(const ctx: PHMAC_CTX): PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('HMAC_CTX_get_md');
end;


{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  HMAC_Init_ex := LoadFunction('HMAC_Init_ex',AFailed);
  HMAC_Update := LoadFunction('HMAC_Update',AFailed);
  HMAC_Final := LoadFunction('HMAC_Final',AFailed);
  HMAC := LoadFunction('HMAC',AFailed);
  HMAC_CTX_copy := LoadFunction('HMAC_CTX_copy',AFailed);
  HMAC_CTX_set_flags := LoadFunction('HMAC_CTX_set_flags',AFailed);
  HMAC_CTX_init := LoadFunction('HMAC_CTX_init',nil); {removed 1.1.0}
  HMAC_size := LoadFunction('HMAC_size',nil); {introduced 1.1.0}
  HMAC_CTX_new := LoadFunction('HMAC_CTX_new',nil); {introduced 1.1.0}
  HMAC_CTX_reset := LoadFunction('HMAC_CTX_reset',nil); {introduced 1.1.0}
  HMAC_CTX_cleanup := LoadFunction('HMAC_CTX_cleanup',nil); {removed 1.1.0}
  HMAC_CTX_free := LoadFunction('HMAC_CTX_free',nil); {introduced 1.1.0}
  HMAC_CTX_get_md := LoadFunction('HMAC_CTX_get_md',nil); {introduced 1.1.0}
  if not assigned(HMAC_CTX_init) then 
  begin
    {$if declared(HMAC_CTX_init_introduced)}
    if LibVersion < HMAC_CTX_init_introduced then
      {$if declared(FC_HMAC_CTX_init)}
      HMAC_CTX_init := @FC_HMAC_CTX_init
      {$else}
      HMAC_CTX_init := @ERR_HMAC_CTX_init
      {$ifend}
    else
    {$ifend}
   {$if declared(HMAC_CTX_init_removed)}
   if HMAC_CTX_init_removed <= LibVersion then
     {$if declared(_HMAC_CTX_init)}
     HMAC_CTX_init := @_HMAC_CTX_init
     {$else}
       {$IF declared(ERR_HMAC_CTX_init)}
       HMAC_CTX_init := @ERR_HMAC_CTX_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(HMAC_CTX_init) and Assigned(AFailed) then 
     AFailed.Add('HMAC_CTX_init');
  end;


  if not assigned(HMAC_size) then 
  begin
    {$if declared(HMAC_size_introduced)}
    if LibVersion < HMAC_size_introduced then
      {$if declared(FC_HMAC_size)}
      HMAC_size := @FC_HMAC_size
      {$else}
      HMAC_size := @ERR_HMAC_size
      {$ifend}
    else
    {$ifend}
   {$if declared(HMAC_size_removed)}
   if HMAC_size_removed <= LibVersion then
     {$if declared(_HMAC_size)}
     HMAC_size := @_HMAC_size
     {$else}
       {$IF declared(ERR_HMAC_size)}
       HMAC_size := @ERR_HMAC_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(HMAC_size) and Assigned(AFailed) then 
     AFailed.Add('HMAC_size');
  end;


  if not assigned(HMAC_CTX_new) then 
  begin
    {$if declared(HMAC_CTX_new_introduced)}
    if LibVersion < HMAC_CTX_new_introduced then
      {$if declared(FC_HMAC_CTX_new)}
      HMAC_CTX_new := @FC_HMAC_CTX_new
      {$else}
      HMAC_CTX_new := @ERR_HMAC_CTX_new
      {$ifend}
    else
    {$ifend}
   {$if declared(HMAC_CTX_new_removed)}
   if HMAC_CTX_new_removed <= LibVersion then
     {$if declared(_HMAC_CTX_new)}
     HMAC_CTX_new := @_HMAC_CTX_new
     {$else}
       {$IF declared(ERR_HMAC_CTX_new)}
       HMAC_CTX_new := @ERR_HMAC_CTX_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(HMAC_CTX_new) and Assigned(AFailed) then 
     AFailed.Add('HMAC_CTX_new');
  end;


  if not assigned(HMAC_CTX_reset) then 
  begin
    {$if declared(HMAC_CTX_reset_introduced)}
    if LibVersion < HMAC_CTX_reset_introduced then
      {$if declared(FC_HMAC_CTX_reset)}
      HMAC_CTX_reset := @FC_HMAC_CTX_reset
      {$else}
      HMAC_CTX_reset := @ERR_HMAC_CTX_reset
      {$ifend}
    else
    {$ifend}
   {$if declared(HMAC_CTX_reset_removed)}
   if HMAC_CTX_reset_removed <= LibVersion then
     {$if declared(_HMAC_CTX_reset)}
     HMAC_CTX_reset := @_HMAC_CTX_reset
     {$else}
       {$IF declared(ERR_HMAC_CTX_reset)}
       HMAC_CTX_reset := @ERR_HMAC_CTX_reset
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(HMAC_CTX_reset) and Assigned(AFailed) then 
     AFailed.Add('HMAC_CTX_reset');
  end;


  if not assigned(HMAC_CTX_cleanup) then 
  begin
    {$if declared(HMAC_CTX_cleanup_introduced)}
    if LibVersion < HMAC_CTX_cleanup_introduced then
      {$if declared(FC_HMAC_CTX_cleanup)}
      HMAC_CTX_cleanup := @FC_HMAC_CTX_cleanup
      {$else}
      HMAC_CTX_cleanup := @ERR_HMAC_CTX_cleanup
      {$ifend}
    else
    {$ifend}
   {$if declared(HMAC_CTX_cleanup_removed)}
   if HMAC_CTX_cleanup_removed <= LibVersion then
     {$if declared(_HMAC_CTX_cleanup)}
     HMAC_CTX_cleanup := @_HMAC_CTX_cleanup
     {$else}
       {$IF declared(ERR_HMAC_CTX_cleanup)}
       HMAC_CTX_cleanup := @ERR_HMAC_CTX_cleanup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(HMAC_CTX_cleanup) and Assigned(AFailed) then 
     AFailed.Add('HMAC_CTX_cleanup');
  end;


  if not assigned(HMAC_CTX_free) then 
  begin
    {$if declared(HMAC_CTX_free_introduced)}
    if LibVersion < HMAC_CTX_free_introduced then
      {$if declared(FC_HMAC_CTX_free)}
      HMAC_CTX_free := @FC_HMAC_CTX_free
      {$else}
      HMAC_CTX_free := @ERR_HMAC_CTX_free
      {$ifend}
    else
    {$ifend}
   {$if declared(HMAC_CTX_free_removed)}
   if HMAC_CTX_free_removed <= LibVersion then
     {$if declared(_HMAC_CTX_free)}
     HMAC_CTX_free := @_HMAC_CTX_free
     {$else}
       {$IF declared(ERR_HMAC_CTX_free)}
       HMAC_CTX_free := @ERR_HMAC_CTX_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(HMAC_CTX_free) and Assigned(AFailed) then 
     AFailed.Add('HMAC_CTX_free');
  end;


  if not assigned(HMAC_CTX_get_md) then 
  begin
    {$if declared(HMAC_CTX_get_md_introduced)}
    if LibVersion < HMAC_CTX_get_md_introduced then
      {$if declared(FC_HMAC_CTX_get_md)}
      HMAC_CTX_get_md := @FC_HMAC_CTX_get_md
      {$else}
      HMAC_CTX_get_md := @ERR_HMAC_CTX_get_md
      {$ifend}
    else
    {$ifend}
   {$if declared(HMAC_CTX_get_md_removed)}
   if HMAC_CTX_get_md_removed <= LibVersion then
     {$if declared(_HMAC_CTX_get_md)}
     HMAC_CTX_get_md := @_HMAC_CTX_get_md
     {$else}
       {$IF declared(ERR_HMAC_CTX_get_md)}
       HMAC_CTX_get_md := @ERR_HMAC_CTX_get_md
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(HMAC_CTX_get_md) and Assigned(AFailed) then 
     AFailed.Add('HMAC_CTX_get_md');
  end;


end;

procedure Unload;
begin
  HMAC_CTX_init := nil; {removed 1.1.0}
  HMAC_size := nil; {introduced 1.1.0}
  HMAC_CTX_new := nil; {introduced 1.1.0}
  HMAC_CTX_reset := nil; {introduced 1.1.0}
  HMAC_CTX_cleanup := nil; {removed 1.1.0}
  HMAC_CTX_free := nil; {introduced 1.1.0}
  HMAC_Init_ex := nil;
  HMAC_Update := nil;
  HMAC_Final := nil;
  HMAC := nil;
  HMAC_CTX_copy := nil;
  HMAC_CTX_set_flags := nil;
  HMAC_CTX_get_md := nil; {introduced 1.1.0}
end;
{$ELSE}
{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
