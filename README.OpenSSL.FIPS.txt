README OpenSSL FIPS Support

The Indy unit IdFIPS provides a common interface to FIPS approved hashing 
routines, such as SHA256. When OpenSSL is included in your project, OPENSSL 
provides an implementation of the FIPS interface. This implementation is 
provided in the IdSSLOpenSSLFIPS unit. This unit should be automatically 
included in your project if you have also included the IdSSLOpenSSL unit. 
Before using OpenSSL provided FIPS routines and if you are using the default 
dynamic library interface to OpenSSL, you must call the 
IdSSLOpenSSL.LoadOpenSSLLibrary function in order to load the OpenSSL library.

OpenSSL configuration for FIPS Support

The FIPS module is not necessarily automatically loaded into OpenSSL. In order 
to use FIPS support, you must ensure that the following configuration is in 
place.

1. OpenSSL has been compiled with FIPS enabled.

2. The OPENSSLDIR contains the configuration file openssl.cnf.

You can check this by running openssl version -d from the commandline. If 
OPENSSLDIR is set incorrectly, the the OPENSSL_CONF environment variable can be 
set to the location of the configuration file (full pathname to openssl.cnf 
advised).

3. Ensure that the following lines are present and uncommented

openssl_conf = openssl_init

.include /usr/local/ssl/fipsmodule.cnf

[openssl_init]
providers = provider_sect

[provider_sect]
fips = fips_sect
base = base_sect

[base_sect]
activate = 1

4. The file fipsmodule.cnf is present in the OPENSSLDIR. 
Note you may need to set the OPENSSL_CONF_INCLUDE to point to the directory 
containing fipsmodule.cnf.

5. From your program and before using any FIPS hashes, you call 
IdFIPS.SetFIPSMode(true) to enable FIPS Mode.

6, AFTER you have enabled FIPS mode, you can call IdFIPS.GetFIPSMode to check 
if the FIPS module is loaded. The function returns "true" if the module is 
loaded.
