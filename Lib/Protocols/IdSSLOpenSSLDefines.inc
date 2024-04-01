{ Three ways to link to the OpenSSL library are supported:

  1. Dynamic linking at run time using calls to LoadLibrary and GetProcAddress.
     This is the default and allows Indy to find the OpenSSL libraries and adjust
     itself to suit the version found. Versions 1.0.2 to 3.x are currently supported.

  2. Static loading of a shared library (.dll or .so). When your program is loaded
     the loader searches for the shared library and links it to your program. Indy
     can only support the 3.x OpenSSL libraries in this mode.

  3. Statically linked to a static library at link time. Your program executable
     includes the OpenSSL libraries which then do not have to be separately
     installed on the target system. Supported only for the 3.x OpenSSL Libraries
     and for the Free Pascal Compiler (FPC). Delphi does not support this link option.

  Link Option 2 is selected if your program or the IndyOpenSSL package is compiled with
  the OPENSSL_USE_SHARED_LIBRARY defined symbol. It is also selected if
  IdCompilierDefines.inc sets the STATICLOAD_OPENSSL defined symbol (e.g. for IOS).

  Link Option 3 is selected if your program or the IndyOpenSSL package is compiled with
  the OPENSSL_USE_STATIC_LIBRARY defined symbol.

 }
{$IFDEF STATICLOAD_OPENSSL}
{$DEFINE USE_EXTERNAL_LIBRARY}
{$UNDEF OPENSSL_USE_STATIC_LIBRARY}
{$ENDIF}
{$IFDEF OPENSSL_USE_SHARED_LIBRARY}
{$DEFINE USE_EXTERNAL_LIBRARY}
{$ENDIF}
{$IFDEF OPENSSL_USE_STATIC_LIBRARY}
{$IFNDEF FPC}
{$message Error:OPENSSL_USE_STATIC_LIBRARY may only be used when compiling with the Free Pascal Compiler}
{$ELSE}
{$DEFINE USE_EXTERNAL_LIBRARY}
{$LINKLIB ssl.a}
{$LINKLIB crypto.a}
{$ENDIF}
{$ENDIF}


