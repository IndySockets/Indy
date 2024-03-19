README OPENSSL TESTS

The test/openssl directory contains two test programs used to demonstrate correct operation of, respectively, an OpenSSL Client and an OpenSSL Server. The first also tests use of a public PKI, while the second tests use of a private PKI.

Variants of the test programs are available for both Delphi and FPC.

TEST 1: openssl-client

The test program is a console mode application and uses TIdHttp to provide the test application and performs a simple “GET” operation to return an print a remote text file. The remote text file is located at:

https://www.mwasoftware.co.uk/openssltest.txt

and contains a single line of text: “Success!”

The program starts by reporting the OpenSSL library version string.

The test program then “gets” the text file twice, The first time uses https without peer (the remote server) authentication. The second time requires authentication. In both cases, the TLS protocol version used is reported and the cipher suite in use.

When authentication is performed, the remote side certificate and certificate chain is reported, For each validated certificate, the subject and issuer are reported.

The test program has the following command line options:

[fpc|delphi]_openssl_client [-h] [-n] [-l <cacerts dir>] [-L] [OpenSSL lib dir]

-h	Prints out the programs purpose and command line syntax, and exits.

-n	Windows Only: By default the program prompts the user to press return before continuing. When the program is run from the IDE, this is to stop the terminal window being closed once the test is complete. If '-n' is present then the program runs to completion without prompting the user.

-l <cacerts dir>	Linux only. This sets the SSLOptions.VerifyDirs to <cacerts dir>. It is used when OpenSSL has not been installed and linked to the default root certificate directory e.g. when testing a recently compiled version of OpenSSL.

-L	Linux Only. This searches through well known locations to find the system default root certificate directory. When found,  SSLOptions.VerifyDirs is to this location.

"OpenSSL lib dir".	When a directory path is present on the command line, it is assumed to be the path to the OpenSSL lib directory. The OpenSSL shared libraries are loaded from this location. If not present, then the system default installation of OpenSSL is used.

TEST 2: openssl-server

The test program is a console mode application and uses TIdHttp and TIdHttpServer (in a separate thread) to provide the test application; the client performs a simple GET operation on the server. In this case, the server returns: The received Get Command, the remote node's (client's) IP Address, and the text “Success!”, each on successive lines.

The program starts by reporting the OpenSSL library version string.

The test program then “gets” the text file twice, The first time uses https with peer (the remote server) authentication. The second time requires both client and server authentication. 

When authentication is performed, the remote side certificate and certificate chain is reported, For each validated certificate, the subject and issuer are reported.

The test program has the following command line options:

[fpc|delphi]_openssl_server [-h] [-n] [OpenSSL lib Dir]

-h	Prints out the programs purpose and command line syntax, and exits.

-n	Windows Only: By default the program prompts the user to press return before continuing. When the program is run from the IDE, this is to stop the terminal window being closed once the test is complete. If '-n' is present then the program runs to completion without prompting the user.

"OpenSSL lib dir".	When a directory path is present on the command line, it is assumed to be the path to the OpenSSL lib directory. The OpenSSL shared libraries are loaded from this location. If not present, then the system default installation of OpenSSL is used.

Note: the private PKI used by Test 2 is contained in the cacerts and certs sub-directories. It can be regenerated using the “createpki.sh” shell script - there should be no need to do this when running the test program. The provided certificates should be sufficient.
