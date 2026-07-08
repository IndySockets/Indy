unit IdResourceStringsSSPI;

interface

resourcestring
  //SSPI Authentication
  {
  Note: CompleteToken is an API function Name:
  }
  RSHTTPSSPISuccess = 'Successfull API call';
  RSHTTPSSPINotEnoughMem = 'Not enough memory is available to complete this request';
  RSHTTPSSPIInvalidHandle = 'The handle specified is invalid';
  RSHTTPSSPIFuncNotSupported = 'The function requested is not supported';
  RSHTTPSSPIUnknownTarget = 'The specified target is unknown or unreachable';
  RSHTTPSSPIInternalError = 'The Local Security Authority cannot be contacted';
  RSHTTPSSPISecPackageNotFound = 'The requested security package does not exist';
  RSHTTPSSPINotOwner = 'The caller is not the owner of the desired credentials';
  RSHTTPSSPIPackageCannotBeInstalled = 'The security package failed to initialize, and cannot be installed';
  RSHTTPSSPIInvalidToken = 'The token supplied to the function is invalid';
  RSHTTPSSPICannotPack = 'The security package is not able to marshall the logon buffer, so the logon attempt has failed';
  RSHTTPSSPIQOPNotSupported = 'The per-message Quality of Protection is not supported by the security package';
  RSHTTPSSPINoImpersonation = 'The security context does not allow impersonation of the client';
  RSHTTPSSPILoginDenied = 'The logon attempt failed';
  RSHTTPSSPIUnknownCredentials = 'The credentials supplied to the package were not recognized';
  RSHTTPSSPINoCredentials = 'No credentials are available in the security package';
  RSHTTPSSPIMessageAltered = 'The message or signature supplied for verification has been altered';
  RSHTTPSSPIOutOfSequence = 'The message supplied for verification is out of sequence';
  RSHTTPSSPINoAuthAuthority = 'No authority could be contacted for authentication.';
  RSHTTPSSPIContinueNeeded = 'The function completed successfully, but must be called again to complete the context';
  RSHTTPSSPICompleteNeeded = 'The function completed successfully, but CompleteToken must be called';
  RSHTTPSSPICompleteContinueNeeded =  'The function completed successfully, but both CompleteToken and this function must be called to complete the context';
  RSHTTPSSPILocalLogin = 'The logon was completed, but no network authority was available. The logon was made using locally known information';
  RSHTTPSSPIBadPackageID = 'The requested security package does not exist';
  RSHTTPSSPIContextExpired = 'The context has expired and can no longer be used.';
  RSHTTPSSPIIncompleteMessage = 'The supplied message is incomplete.  The signature was not verified.';
  RSHTTPSSPIIncompleteCredentialNotInit =  'The credentials supplied were not complete, and could not be verified. The context could not be initialized.';
  RSHTTPSSPIBufferTooSmall = 'The buffers supplied to a function was too small.';
  RSHTTPSSPIIncompleteCredentialsInit = 'The credentials supplied were not complete, and could not be verified. Additional information can be returned from the context.';
  RSHTTPSSPIRengotiate = 'The context data must be renegotiated with the peer.';
  RSHTTPSSPIWrongPrincipal = 'The target principal name is incorrect.';
  RSHTTPSSPINoLSACode = 'There is no LSA mode context associated with this context.';
  RSHTTPSSPITimeScew = 'The clocks on the client and server machines are skewed.';
  RSHTTPSSPIUntrustedRoot = 'The certificate chain was issued by an untrusted authority.';
  RSHTTPSSPIIllegalMessage = 'The message received was unexpected or badly formatted.';
  RSHTTPSSPICertUnknown = 'An unknown error occurred while processing the certificate.';
  RSHTTPSSPICertExpired = 'The received certificate has expired.';
  RSHTTPSSPIEncryptionFailure = 'The specified data could not be encrypted.';
  RSHTTPSSPIDecryptionFailure = 'The specified data could not be decrypted.';
  RSHTTPSSPIAlgorithmMismatch = 'The client and server cannot communicate, because they do not possess a common algorithm.';
  RSHTTPSSPISecurityQOSFailure = 'The security context could not be established due to a failure in the requested quality of service (e.g. mutual authentication or delegation).';
  RSHTTPSSPISecCtxWasDelBeforeUpdated = 'A security context was deleted before the context was completed. This is considered a logon failure.';
  RSHTTPSSPIClientNoTGTReply = 'The client is trying to negotiate a context and the server requires user-to-user but didn''t send a TGT reply.';
  RSHTTPSSPILocalNoIPAddr = 'Unable to accomplish the requested task because the local machine does not have any IP addresses.';
  RSHTTPSSPIWrongCredHandle = 'The supplied credential handle does not match the credential associated with the security context.';
  RSHTTPSSPICryptoSysInvalid = 'The crypto system or checksum function is invalid because a required function is unavailable.';
  RSHTTPSSPIMaxTicketRef = 'The number of maximum ticket referrals has been exceeded.';
  RSHTTPSSPIMustBeKDC = 'The local machine must be a Kerberos KDC (domain controller) and it is not.';
  RSHTTPSSPIStrongCryptoNotSupported = 'The other end of the security negotiation is requires strong crypto but it is not supported on the local machine.';
  RSHTTPSSPIKDCReplyTooManyPrincipals = 'The KDC reply contained more than one principal name.';
  RSHTTPSSPINoPAData = 'Expected to find PA data for a hint of what etype to use, but it was not found.';
  RSHTTPSSPIPKInitNameMismatch = 'The client certificate does not contain a valid UPN, or does not match the client name in the logon request. Please contact your administrator.';
  RSHTTPSSPISmartcardLogonReq = 'Smartcard logon is required and was not used.';
  RSHTTPSSPISysShutdownInProg = 'A system shutdown is in progress.';
  RSHTTPSSPIKDCInvalidRequest = 'An invalid request was sent to the KDC.';
  RSHTTPSSPIKDCUnableToRefer = 'The KDC was unable to generate a referral for the service requested.';
  RSHTTPSSPIKDCETypeUnknown = 'The encryption type requested is not supported by the KDC.';
  RSHTTPSSPIUnsupPreauth = 'An unsupported preauthentication mechanism was presented to the Kerberos package.';
  RSHTTPSSPIDeligationReq = 'The requested operation cannot be completed. The computer must be trusted for delegation and the current user account must be configured to allow delegation.';
  RSHTTPSSPIBadBindings = 'Client''s supplied SSPI channel bindings were incorrect.';
  RSHTTPSSPIMultipleAccounts = 'The received certificate was mapped to multiple accounts.';
  RSHTTPSSPINoKerbKey = 'SEC_E_NO_KERB_KEY';
  RSHTTPSSPICertWrongUsage = 'The certificate is not valid for the requested usage.';
  RSHTTPSSPIDowngradeDetected = 'The system detected a possible attempt to compromise security. Please ensure that you can contact the server that authenticated you.';
  RSHTTPSSPISmartcardCertRevoked = 'The smartcard certificate used for authentication has been revoked. Please contact your system administrator. There may be additional information in the event log.';
  RSHTTPSSPIIssuingCAUntrusted = 'An untrusted certificate authority was detected While processing the smartcard certificate used for authentication. Please contact your system administrator.';
  RSHTTPSSPIRevocationOffline = 'The revocation status of the smartcard certificate used for authentication could not be determined. Please contact your system administrator.';
  RSHTTPSSPIPKInitClientFailure = 'The smartcard certificate used for authentication was not trusted. Please contact your system administrator.';
  RSHTTPSSPISmartcardExpired = 'The smartcard certificate used for authentication has expired. Please contact your system administrator.';
  RSHTTPSSPINoS4UProtSupport = 'The Kerberos subsystem encountered an error. A service for user protocol request was made against a domain controller which does not support service for user.';
  RSHTTPSSPICrossRealmDeligationFailure = 'An attempt was made by this server to make a Kerberos constrained delegation request for a target outside of the server''s realm. This is not supported, and indicates a misconfiguration on this server''s allowed'+
    ' to delegate to list. Please contact your administrator.';
  RSHTTPSSPIRevocationOfflineKDC = 'The revocation status of the domain controller certificate used for smartcard authentication could not be determined. There is additional information in the system event log. Please contact your system administrator.';
  RSHTTPSSPICAUntrustedKDC = 'An untrusted certificate authority was detected while processing the domain controller certificate used for authentication. There is additional information in the system event log. Please contact your system administrator.';
  RSHTTPSSPIKDCCertExpired = 'The domain controller certificate used for smartcard logon has expired. Please contact your system administrator with the contents of your system event log.';
  RSHTTPSSPIKDCCertRevoked = 'The domain controller certificate used for smartcard logon has been revoked. Please contact your system administrator with the contents of your system event log.';
  RSHTTPSSPISignatureNeeded = 'A signature operation must be performed before the user can authenticate.';
  RSHTTPSSPIInvalidParameter = 'One or more of the parameters passed to the function was invalid.';
  RSHTTPSSPIDeligationPolicy = 'Client policy does not allow credential delegation to target server.';
  RSHTTPSSPIPolicyNTLMOnly = 'Client policy does not allow credential delegation to target server with NLTM only authentication.';
  RSHTTPSSPINoRenegotiation = 'The recipient rejected the renegotiation request.';
  RSHTTPSSPINoContext = 'The required security context does not exist.';
  RSHTTPSSPIPKU2UCertFailure = 'The PKU2U protocol encountered an error while attempting to utilize the associated certificates.';
  RSHTTPSSPIMutualAuthFailed = 'The identity of the server computer could not be verified.';
  RSHTTPSSPIUnknwonError = 'Unknown error';
  {
  Note to translators - the parameters for the next message are below:

  Failed Function Name
  Error Number
  Error Number
  Error Message by Number
  }

  RSHTTPSSPIErrorMsg = 'SSPI %s returns error #%d(0x%x): %s';

  RSHTTPSSPIInterfaceInitFailed = 'SSPI interface has failed to initialise properly';
  RSHTTPSSPINoPkgInfoSpecified = 'No PSecPkgInfo specified';
  RSHTTPSSPINoCredentialHandle = 'No credential handle acquired';
  RSHTTPSSPICanNotChangeCredentials = 'Can not change credentials after handle aquired. Use Release first';
  RSHTTPSSPIUnknwonCredentialUse = 'Unknown credentials use';
  RSHTTPSSPIDoAuquireCredentialHandle = 'Do AcquireCredentialsHandle first';
  RSHTTPSSPICompleteTokenNotSupported = 'CompleteAuthToken is not supported';

implementation

end.
