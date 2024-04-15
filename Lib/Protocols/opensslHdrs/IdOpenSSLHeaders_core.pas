  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_core.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_core.h2pas
     and this file regenerated. IdOpenSSLHeaders_core.h2pas is distributed with the full Indy
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
unit IdOpenSSLHeaders_core;

interface

uses
  IdCTypes,
  IdGlobal
  {$IFDEF VCL_XE3_OR_ABOVE},System.Types{$ELSE},Types{$ENDIF};


{
  Automatically converted by H2Pas 1.0.0 from core.h
  The following command line parameters were used:
    core.h
}

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

  {
   * Copyright 2019-2023 The OpenSSL Project Authors. All Rights Reserved.
   *
   * Licensed under the Apache License 2.0 (the "License").  You may not use
   * this file except in compliance with the License.  You can obtain a copy
   * in the file LICENSE in the source distribution or at
   * https://www.openssl.org/source/license.html
    }
  {-
   * Base types
   * ----------
   *
   * These are the types that the OpenSSL core and providers have in common
   * to communicate data between them.
    }
  { Opaque handles to be used with core upcall functions from providers  }


    type
      ossl_core_handle_st = record end;
      OSSL_CORE_HANDLE = ossl_core_handle_st;
      POSSL_CORE_HANDLE = ^OSSL_CORE_HANDLE;
      openssl_core_ctx_st = record end;
      OPENSSL_CORE_CTX = openssl_core_ctx_st;
      POPENSSL_CORE_CTX = ^OPENSSL_CORE_CTX;
      ossl_core_bio_st = record end;
      OSSL_CORE_BIO = ossl_core_bio_st;
      POSSL_CORE_BIO = ^OSSL_CORE_BIO;
    {
     * Dispatch table element.  function_id numbers and the functions are defined
     * in core_dispatch.h, see macros with 'OSSL_CORE_MAKE_FUNC' in their names.
     *
     * An array of these is always terminated by function_id == 0
      }
      ossl_dispatch_st = record
          function_id : TIdC_LONG;
          _function: procedure;cdecl;
        end;

     OSSL_DISPATCH = ossl_dispatch_st;
     POSSL_DISPATCH = ^OSSL_DISPATCH;

    {
     * Other items, essentially an int<->pointer map element.
     *
     * We make this type distinct from OSSL_DISPATCH to ensure that dispatch
     * tables remain tables with function pointers only.
     *
     * This is used whenever we need to pass things like a table of error reason
     * codes <-> reason string maps, ...
     *
     * Usage determines which field works as key if any, rather than field order.
     *
     * An array of these is always terminated by id == 0 && ptr == NULL
      }
      ossl_item_st = record
          id : dword;
          ptr : pointer;
        end;

    {
     * Type to tie together algorithm names, property definition string and
     * the algorithm implementation in the form of a dispatch table.
     *
     * An array of these is always terminated by algorithm_names == NULL
      }
      ossl_algorithm_st = record
          algorithm_names : PIdAnsiChar;
          property_definition : PIdAnsiChar;
          implementation_ : ^OSSL_DISPATCH;
          algorithm_description : PIdAnsiChar;
        end;

      OSSL_ALGORITHM = ossl_algorithm_st;

    {
     * Type to pass object data in a uniform way, without exposing the object
     * structure.
     *
     * An array of these is always terminated by key == NULL
      }
    { the name of the parameter  }
    { declare what kind of content is in buffer  }
    { value being passed in or out  }
    { data size  }
    { returned content size  }
      ossl_param_st = record
          key : PIdAnsiChar;
          data_type : dword;
          data : pointer;
          data_size : TIdC_SSIZET;
          return_size : TIdC_SSIZET;
        end;

      OSSL_PARAM = ossl_param_st;

    { Currently supported OSSL_PARAM data types  }
    {
     * OSSL_PARAM_INTEGER and OSSL_PARAM_UNSIGNED_INTEGER
     * are arbitrary length and therefore require an arbitrarily sized buffer,
     * since they may be used to pass numbers larger than what is natively
     * available.
     *
     * The number must be buffered in native form, i.e. MSB first on B_ENDIAN
     * systems and LSB first on L_ENDIAN systems.  This means that arbitrary
     * native integers can be stored in the buffer, just make sure that the
     * buffer size is correct and the buffer itself is properly aligned (for
     * example by having the buffer field point at a C integer).
      }

    const
      OSSL_PARAM_INTEGER = 1;
      OSSL_PARAM_UNSIGNED_INTEGER = 2;
    {-
     * OSSL_PARAM_REAL
     * is a C binary floating point values in native form and alignment.
      }
      OSSL_PARAM_REAL = 3;
    {-
     * OSSL_PARAM_UTF8_STRING
     * is a printable string.  It is expected to be printed as it is.
      }
      OSSL_PARAM_UTF8_STRING = 4;
    {-
     * OSSL_PARAM_OCTET_STRING
     * is a string of bytes with no further specification.  It is expected to be
     * printed as a hexdump.
      }
      OSSL_PARAM_OCTET_STRING = 5;
    {-
     * OSSL_PARAM_UTF8_PTR
     * is a pointer to a printable string.  It is expected to be printed as it is.
     *
     * The difference between this and OSSL_PARAM_UTF8_STRING is that only pointers
     * are manipulated for this type.
     *
     * This is more relevant for parameter requests, where the responding
     * function doesn't need to copy the data to the provided buffer, but
     * sets the provided buffer to point at the actual data instead.
     *
     * WARNING!  Using these is FRAGILE, as it assumes that the actual
     * data and its location are constant.
     *
     * EXTRA WARNING!  If you are not completely sure you most likely want
     * to use the OSSL_PARAM_UTF8_STRING type.
      }
      OSSL_PARAM_UTF8_PTR = 6;
    {-
     * OSSL_PARAM_OCTET_PTR
     * is a pointer to a string of bytes with no further specification.  It is
     * expected to be printed as a hexdump.
     *
     * The difference between this and OSSL_PARAM_OCTET_STRING is that only pointers
     * are manipulated for this type.
     *
     * This is more relevant for parameter requests, where the responding
     * function doesn't need to copy the data to the provided buffer, but
     * sets the provided buffer to point at the actual data instead.
     *
     * WARNING!  Using these is FRAGILE, as it assumes that the actual
     * data and its location are constant.
     *
     * EXTRA WARNING!  If you are not completely sure you most likely want
     * to use the OSSL_PARAM_OCTET_STRING type.
      }
      OSSL_PARAM_OCTET_PTR = 7;
    {
     * Typedef for the thread stop handling callback. Used both internally and by
     * providers.
     *
     * Providers may register for notifications about threads stopping by
     * registering a callback to hear about such events. Providers register the
     * callback using the OSSL_FUNC_CORE_THREAD_START function in the |in| dispatch
     * table passed to OSSL_provider_init(). The arg passed back to a provider will
     * be the provider side context object.
      }

    type

      OSSL_thread_stop_handler_fn = procedure (arg:pointer);cdecl;
    {-
     * Provider entry point
     * --------------------
     *
     * This function is expected to be present in any dynamically loadable
     * provider module.  By definition, if this function doesn't exist in a
     * module, that module is not an OpenSSL provider module.
      }
    {-
     * |handle|     pointer to opaque type OSSL_CORE_HANDLE.  This can be used
     *              together with some functions passed via |in| to query data.
     * |in|         is the array of functions that the Core passes to the provider.
     * |out|        will be the array of base functions that the provider passes
     *              back to the Core.
     * |provctx|    a provider side context object, optionally created if the
     *              provider needs it.  This value is passed to other provider
     *              functions, notably other context constructors.
      }

type
      OSSL_provider_init_fn = function (const handle: POSSL_CORE_HANDLE;
                                    const in_: POSSL_DISPATCH;
                                    var out_: POSSL_DISPATCH;
                                    var provctx: pointer): TIdC_INT cdecl;


    OSSL_provider_init = OSSL_provider_init_fn;

    {
     * Generic callback function signature.
     *
     * The expectation is that any provider function that wants to offer
     * a callback / hook can do so by taking an argument with this type,
     * as well as a pointer to caller-specific data.  When calling the
     * callback, the provider function can populate an OSSL_PARAM array
     * with data of its choice and pass that in the callback call, along
     * with the caller data argument.
     *
     * libcrypto may use the OSSL_PARAM array to create arguments for an
     * application callback it knows about.
      }
    OSSL_CALLBACK = function(params: array of OSSL_PARAM; arg: pointer): TIdC_INT cdecl;

    OSSL_INOUT_CALLBACK = function(in_params: array of OSSL_PARAM;
                                  out_params: array of OSSL_PARAM; arg: pointer): TIdC_INT cdecl;

    {
     * Passphrase callback function signature
     *
     * This is similar to the generic callback function above, but adds a
     * result parameter.
      }
    OSSL_PASSPHRASE_CALLBACK = function(pass: PIdAnsiChar; pass_size: TIdC_SSIZET;
                                       pass_len: PIdC_SSIZET;
                                       params: array of OSSL_PARAM; arg: pointer): TIdC_INT cdecl;


implementation


end.
