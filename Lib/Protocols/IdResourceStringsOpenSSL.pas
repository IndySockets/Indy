unit IdResourceStringsOpenSSL;

interface

resourcestring
  {IdOpenSSL}
  RSOSSFailedToLoad = 'Failed to load %s.';
  RSOSSFailedToLoad_WithErrCode = 'Failed to load %s (error #%d).';
  RSOSSMissingExport_WithErrCode = '%s (error #%d)';
  RSOSSUnsupportedVersion = 'Unsupported SSL Library version: %.8x.';
  RSOSSUnsupportedLibrary = 'Unsupported SSL Library: %s.';
  RSOSSLModeNotSet = 'Mode has not been set.';
  RSOSSLCouldNotLoadSSLLibrary = 'Could not load SSL library.';
  RSOSSLStatusString = 'SSL status: "%s"';
  RSOSSLConnectionDropped = 'SSL connection has dropped.';
  RSOSSLCertificateLookup = 'SSL certificate request error.';
  RSOSSLInternal = 'SSL library internal error.';
  //callback where strings
  RSOSSLAlert =  '%s Alert';
  RSOSSLReadAlert =  '%s Read Alert';
  RSOSSLWriteAlert =  '%s Write Alert';
  RSOSSLAcceptLoop = 'Accept Loop';
  RSOSSLAcceptError = 'Accept Error';
  RSOSSLAcceptFailed = 'Accept Failed';
  RSOSSLAcceptExit =  'Accept Exit';
  RSOSSLConnectLoop =  'Connect Loop';
  RSOSSLConnectError = 'Connect Error';
  RSOSSLConnectFailed = 'Connect Failed';
  RSOSSLConnectExit =  'Connect Exit';
  RSOSSLHandshakeStart = 'Handshake Start';
  RSOSSLHandshakeDone =  'Handshake Done';

implementation

end.
