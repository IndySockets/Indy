README.OPENSSL

Indy uses the OpenSSL library as the provider of the Transport Level Security 
(TLS) Protocol (RFC 8446). TLS supports secure stream mode communication with 
data encryption and peer entity authentication. An X.509 PKI may be used to 
support authentication. Secure Datagram communication using DTLS (RFC 9147) is 
not currently supported by the Indy components. The predecessor of the TLS was 
the Secure Socket Layer (SSL) - hence the naming. However, use of the SSL 
protocol is deprecated due to security concerns.

The OpenSSL library is available with most Linux distributions and can also be 
installed under Windows.

Indy components, such as TIdHttp and TIdHTTPServer are able to use TLS 
protected communications when their IOHandler property is set to an instance of 
TIdSSLIOHandlerSocketOpenSSL (Client) or TidServerIOHandlerSSLOpenSSL (Server). 
The SSLOptions property of either IO handler may then be used to select 
protocol options.

All versions of OpenSSL are supported from 1.0.2 through to 3.2. Indy may work 
with earlier versions but this is not guaranteed. In order to avoid an 
exception when using an earlier version, Indy must be compiled with the 
OPENSSL_NO_MIN_VERSION defined symbol.

Three link models are supported for use of the OpenSSL library:

    1. Dynamic loading (default). Under this model, the OpenSSL library is 
       loaded on demand at run time. The Indy OpenSSL modules then adjust to the 
       version of the OpenSSL library loaded. A range of well known library names (for 
       the OpenSSL libraries) is supported and each is checked in turn when searching 
       for the OpenSSL shared library, starting with the most recent version of 
       OpenSSL. Versions 1.0.2 to 3.x are currently supported.

    2. Static Loading of a shared library. Under this model, the OpenSSL 
       library (.dll or .so) is loaded when a program using Indy and OpenSSL is loaded 
       with all library entry points pre-determined. This link model is only available 
       with version 3.2 onwards of OpenSSL and effectively forces use of the most recent 
       versions of OpenSSL and with a specific library name (e.g. libssl.so.3 and 
       libcrypto.so.3 for the Linux version).

    3. Statically linked static library. Under this model, an OpenSSL code 
       library is statically linked into the using program. This significantly 
       increases program size, but ensures that a given version of OpenSSL is always 
       used and that OpenSSL does not have to be otherwise installed on the target 
       system. It also guards against an attacker replacing an OpenSSL shared library 
       (.dll or .so) with a malicious version. This model is supported for both 
       Windows and Linux but currently only available with the Free Pascal Compiler 
       (FPC)  and a static code library compiled using gcc (file extension “.a”).

Link Option 2 is selected if your program or the IndyOpenSSL package is compiled with
the OPENSSL_USE_SHARED_LIBRARY defined symbol. It is also selected if
IdCompilierDefines.inc sets the STATICLOAD_OPENSSL defined symbol (e.g. for IOS).

Link Option 3 is selected if your program or the IndyOpenSSL package is compiled with
the OPENSSL_USE_STATIC_LIBRARY defined symbol.

TLS Version Considerations

The TLS protocol has evolved from the Netscape Secure Sockets Layer (SSL) 
protocol and through several protocol versions. The most recent version should 
always be used if possible. If the OpenSSL 1.0.2 library is used then TLS 1.2 
is the best that can be negotiated. All later versions support TLS 1.3 and will 
use it if possible. Earlier versions of TLS and SSL (version 3) continue to be 
supported but are deprecated for use.

In earlier versions of Indy, the SSLOptions.Mode property could be used to 
force a given version of the SSL/TLS protocol. With later versions of OpenSSL 
(1.1.1 onwards), this property is  ignored, with the most recent TLS version 
always used.

In earlier versions, the SSLOptions.SSLVersions property could be used to limit 
negotiation to a list of acceptable versions. In this version, it is used to 
determine the minimum version acceptable only. All later versions in the list 
are ignored. Both changes are consequential on changes to the OpenSSL library.

Data Encryption

The SSLOptions.CipherList property may be used to specify the algorithms 
(cipher suites) used for data encryption. This may be left empty to use the 
OpenSSL default.

Entering the command “openssl cipherlist” at the command line will return 
the current OpenSSL default, as a list of colon separated ciphersuites, and 
illustrates the format used to identify each ciphersuite.

Peer Entity Authentication

The SSLOptions.VerifyMode property (a set of values) is used to determine 
whether peer entity authentication is used and then how it is used. The default 
setting is the empty set implying that no peer entity authentication is 
performed. The property is independently set at either end of the connection 
and controls only the local behaviour and not that of the remote system.

The SSLOptions.VerifyMode property values sslvrfPeer, sslvrfFailIfNoPeerCert, 
sslvrfClientOnce, respectively correspond to the OpenSSL library “flags” 
SSL_VERIFY_PEER, SSL_VERIFY_FAIL_IF_NO_PEER_CERT, and SSL_VERIFY_CLIENT_ONCE. 
See https://www.openssl.org/docs/man3.2/man3/SSL_set_verify.html.

The SSLOptions.VerifyDepth should be sent to a sufficiently large integer to 
ensure that the remote peer's full certificate change can be verified. if 
unsure then a VerifyDepth of 100 should be more than sufficient.

TLS Clients should normally be set to sslvrfPeer in order to validate the 
server. Server's should normally leave this property empty unless client 
authentication is required. If client authentication is required  then the 
property should then be set to [ sslvrfPeer, sslvrfFailIfNoPeerCert] which 
ensures that the server both requests a client certificate and aborts the 
connection if an invalid or no certificate was returned.

X.509 based Authentication

X.509 defines a trust model based on public key encryption. Each user generates 
a public/private key pair with the properties that only the public key can be 
used to decrypt data encrypted using the private key and vice versa. 
Authentication is performed by encrypting part of the remote response with the 
private key. The public key is widely distributed and anyone can decrypt such a 
message provided they know the public key corresponding to the private key used 
to encrypt the data. Provided that the private key is kept private and known 
only to its owner, following successful decryption using the public key, it can 
be asserted that the data was received from the owner of the key pair and has 
not been modified en route. The source of the data is thereby authenticated.

The problem is that how can the receiver be sure that the public key used for 
authentication is the sender's public key. This is where the X.509 certificate 
comes in. It is an “identity document” digitally signed by a trusted 3rd 
party. The certificate includes the sender's name and other identifying 
information and the sender's public key. The certificate is signed by trusted 
3rd party using its own private key to encrypt a digital hash of the 
certificate. As long as the authenticator has access to the trusted 3rd party's 
public key, it can authenticate any certificate signed by that 3rd party and 
get a verified copy of the sender's public key.

Trusted 3rd parties (known as Certification Authorities (CAs)) distribute their 
public keys as “self-signed” certificates which are distributed by a secure 
route.

A Public Key Infrastructure (PKI) is the name given to the policies, 
authentication algorithms and certificate generation procedures used to support 
X.509 based authentication. Both public PKIs and private PKIs (limited in scope 
to a small set of users) are possible. A given PKI can have one or more CAs. 
Typically, a public PKI has many CAs, while a private PKI has only a single CA. 

Key to the security of a PKI and hence its usefulness is how the CA 
certificates are distributed securely to the users of the PKI. The CA 
certificates are often called trusted root certificates.

OpenSSL is not distributed with a set of trusted X.509 root certificates and 
must be configured with the location of the CA certificates used by the PKI in 
effect. For a public PKI these are the CA certificates of recognised 
Certification Authorities (e.g. Let's Encrypt).

Use of OpenSSL with a Public PKI - Linux

Most Linux distributions are distributed with a set of trusted root 
certificates and the distro provider is responsible for keeping this list 
up-to-date. A properly installed and configured OpenSSL installation will be 
(soft) linked to a directory containing the current set of trusted root 
certificates: the “/certs” directory in the installed OPENSSLDIR is usually 
a softlink to the actual location.

For example, under most Debian derived distributions (e.g. Ubuntu) the set of 
trusted root certificates may be found in /etc/ssl/certs. The command 
“openssl version -d” when entered at the command line will returned the 
installed OPENSSLDIR (typically /usr/lib/ssl for Debian derived distributions). 
The directory /usr/lib/ssl/certs must then be a softlink to /etc/ssl/certs in 
order for OpenSSL to find the trusted root certificates, and this softlink is 
usually automatically added when OpenSSL is installed.

OpenSSL thus automatically knows where to find the current set of trusted root 
certificates.

If the SSLOptions.UseSystemRootCertificateStore is set to true (default) then 
the current set of trusted root certificates is automatically used. If set to 
false then SSLOptions.VerifyDirs must be set to the location of the current set 
of trusted root certificates. If the trusted root certificates are not 
available then X.509 based authentication of a remote system is not possible.

Use with a Public PKI - Windows

Windows also comes with a current set of trusted root certificates. However, 
while the concept of an installed OPENSSLDIR also exists under Windows, it is 
not possible to link its “\certs” folder to the Windows trusted root 
certificates in the same manner as done for Linux. They are only present here 
if maintained by someone else.

The Windows trusted root certificates can be accessed using the Windows crypto 
API. If the SSLOptions.UseSystemRootCertificateStore is set to true (default) 
then the Windows Crypto API is used by Indy to copy the Windows trusted root 
certificates into OpenSSL's local (RAM based) X.509 certificate store. They may 
then be used for peer entity authentication. 

If SSLOptions.UseSystemRootCertificateStore is set to false then 
SSLOptions.VerifyDirs must be set to the path to the current set of trusted 
root certificates. If the trusted root certificates are not available then 
X.509 based authentication of a remote system is not possible.

If Indy is compiled with the OPENSSL_DONT_USE_WINDOWS_CERT_STORE defined symbol 
then the behaviour is as for Linux. That is if  
SSLOptions.UseSystemRootCertificateStore is set to true then OpenSSL will 
expect to find a set of trusted root certificates in the “\certs” folder of 
the local OPENSSLDIR. 

Use with a Private PKI - Linux and Windows

The means by which the CA root certificate(s) for the private PKI are 
distributed is local to the PKI and cannot readily be generalised. A directory 
on the local system should be created to hold these certificates.

SSLOptions.UseSystemRootCertificateStore must be set to false, and  
SSLOptions.VerifyDirs set to the path to this directory.

Server Configuration

A TLS Server must be configured with its own X.509 certificate and private key. 
It may also be configure with the self-signed certificate of the CA that signed 
its certificate.

The SSLOptions.CertFile property is set to the path to the server's certificate.
The SSLOptions.KeyFile property is set to the path to the file containing the 
server's private key.
The SSLOptionsRootCertFile property is set to the path to the file containing 
the CA's self-signed certificate.

The private key file is often itself encrypted in order to keep it secure. In 
this case the Server's SSL IOHandler event handler “OnGetPassword” must be 
provided. This is callback used to provide the password.

Client Configuration

In most cases, the client authenticates the server while the server is not 
required to authenticate the Client. A common example is when accessing a 
secure (https) website. In this case, the Client need not be configured other 
than with an appropriate VerifyMode and access to the set of trusted root 
certificates.

In the cases where a Server is required to authenticate a Client, the Client 
must also be configure with its own certificate and private key. As Above, the 
SSLOptions.CertFile and SSLOptions.KeyFile properties are used for this purpose 
and an “OnGetPassword” event handler used to provide any password required 
to decrypt the private key.

Client certificates and keys are often distributed using a PKCS#12 format 
package (.p12 file). In this case, both of the above properties are set to the 
same .p12 file. An “OnGetPassword” event handler is also required if the 
package is password protected.

Https Server - special considerations

A common use of the Indy OpenSSL package is in support of the TidHttpServer 
component. This can be configure with multiple comms ports each used for either 
open (http) communication or secure (https) communication. The Server needs to 
known which ports are used for which purpose (commonly port 80 is for http and 
port 443 is for https).

The TidHttpServer's OnQuerySSLPort event handler is used to tell it whether or 
not an incoming connection of a given communications port is used to TLS or 
open communication. In order to use TidHttpServer for secure (https) 
communication, this event handler must be provided.
