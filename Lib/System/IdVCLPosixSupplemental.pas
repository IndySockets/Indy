unit IdVCLPosixSupplemental;

interface
{$I IdCompilerDefines.inc}

uses
{$IFDEF DARWIN} 
  CoreFoundation,
  CoreServices,
{$ENDIF}
  IdCTypes;

//tcp.hh
type
{Supplemental stuff from netinet/tcp.h}
  {$EXTERNALSYM tcp_seq}
  tcp_seq = TIdC_UINT32;
  {$EXTERNALSYM tcp_cc}
  tcp_cc  = TIdC_UINT32;		//* connection count per rfc1644 */
  {$EXTERNALSYM tcp6_seq}
  tcp6_seq = tcp_seq;	//* for KAME src sync over BSD*'s */' +


{stuff that may be needed for various socket functions.  Much of this may be
platform specific.  Defined in netinet/tcp.h}
const
  {$IFDEF BSD}
  //for BSD-based operating systems such as FreeBSD and Mac OS X
  {$EXTERNALSYM TCP_MAXSEG}
	TCP_MAXSEG              = $02;    //* set maximum segment size */
  {$EXTERNALSYM TCP_NOPUSH}
  TCP_NOPUSH              = $04 platform;   //* don't push last block of write */
  {$EXTERNALSYM TCP_NOOPT}
  TCP_NOOPT               = $08;    //* don't use TCP options */
  {$ENDIF}

  {$IFDEF FREEBSD}
  //specific to FreeBSD
  {$EXTERNALSYM TCP_MD5SIG}
  TCP_MD5SIG              = $10 platform;    //* use MD5 digests (RFC2385) */
  {$EXTERNALSYM TCP_INFO}
  TCP_INFO                = $20 platform;  //* retrieve tcp_info structure */
  {$EXTERNALSYM TCP_CONGESTION}
  TCP_CONGESTION          = $40 platform;   //* get/set congestion control algorithm */
  {$ENDIF}

  {$IFDEF DARWIN}
  //specific to Mac OS X
  {$EXTERNALSYM TCP_KEEPALIVE}
  TCP_KEEPALIVE           = $10 platform;    //* idle time used when SO_KEEPALIVE is enabled */
  {$EXTERNALSYM TCP_CONNECTIONTIMEOUT}
  TCP_CONNECTIONTIMEOUT   = $20 platform;    //* connection timeout */

  {$EXTERNALSYM TCPOPT_EOL}
  TCPOPT_EOL	=	0 platform;
  {$EXTERNALSYM TCPOPT_NOP}
  TCPOPT_NOP	=	1 platform;
  {$EXTERNALSYM TCPOPT_MAXSEG}
  TCPOPT_MAXSEG	 = 2 platform;
  {$EXTERNALSYM TCPOLEN_MAXSEG}
  TCPOLEN_MAXSEG	 = 4 platform;
  {$EXTERNALSYM TCPOPT_WINDOW}
  TCPOPT_WINDOW	 = 3 platform;
  {$EXTERNALSYM TCPOLEN_WINDOW}
  TCPOLEN_WINDOW = 3 platform;
  {$EXTERNALSYM TCPOPT_SACK_PERMITTED}
  TCPOPT_SACK_PERMITTED	= 4 platform;		//* Experimental */
  {$EXTERNALSYM TCPOLEN_SACK_PERMITTED}
  TCPOLEN_SACK_PERMITTED = 2 platform;
  {$EXTERNALSYM TCPOPT_SACK}
  TCPOPT_SACK	  = 5 platform;		//* Experimental */
  {$EXTERNALSYM TCPOLEN_SACK}
  TCPOLEN_SACK  =	8 platform;		//* len of sack block */
  {$EXTERNALSYM TCPOPT_TIMESTAMP}
  TCPOPT_TIMESTAMP = 8 platform;
  {$EXTERNALSYM TCPOLEN_TIMESTAMP}
  TCPOLEN_TIMESTAMP = 10 platform;
  {$EXTERNALSYM TCPOLEN_TSTAMP_APPA}
  TCPOLEN_TSTAMP_APPA	=	(TCPOLEN_TIMESTAMP+2) platform; //* appendix A */
  {$EXTERNALSYM TCPOPT_TSTAMP_HDR}
  TCPOPT_TSTAMP_HDR	=
    ((TCPOPT_NOP shl 24) or
    (TCPOPT_NOP shl 16) or
    (TCPOPT_TIMESTAMP shl 8) or
    (TCPOLEN_TIMESTAMP)) platform;
  {$EXTERNALSYM MAX_TCPOPTLEN}
  MAX_TCPOPTLEN	 =	40 platform;	//* Absolute maximum TCP options len */
  {$EXTERNALSYM TCPOPT_CC}
  TCPOPT_CC	 =	11 platform;		//* CC options: RFC-1644 */
  {$EXTERNALSYM TCPOPT_CCNEW}
  TCPOPT_CCNEW = 12 platform;
  {$EXTERNALSYM TCPOPT_CCECHO}
  TCPOPT_CCECHO	=	13 platform;
  {$EXTERNALSYM TCPOLEN_CC}
  TCPOLEN_CC		=	6 platform;
  {$EXTERNALSYM TCPOLEN_CC_APPA}
  TCPOLEN_CC_APPA	=	(TCPOLEN_CC+2);

  {$EXTERNALSYM TCPOPT_CC_HDR}
 function TCPOPT_CC_HDR(const ccopt : Integer)	: Integer; inline;

const
  {$EXTERNALSYM TCPOPT_SIGNATURE}
	TCPOPT_SIGNATURE	 =	19 platform;	//* Keyed MD5: RFC 2385 */
  {$EXTERNALSYM TCPOLEN_SIGNATURE}
  TCPOLEN_SIGNATURE	 = 18 platform;

//* Option definitions */
  {$EXTERNALSYM TCPOPT_SACK_PERMIT_HDR}
  TCPOPT_SACK_PERMIT_HDR	=
    ((TCPOPT_NOP shl 24) or
     (TCPOPT_NOP shl 16) or
     (TCPOPT_SACK_PERMITTED shl 8) or
      TCPOLEN_SACK_PERMITTED) platform;
  {$EXTERNALSYM TCPOPT_SACK_HDR}
  TCPOPT_SACK_HDR = ((TCPOPT_NOP shl 24) or (TCPOPT_NOP shl 16) or (TCPOPT_SACK shl 8)) platform;
//* Miscellaneous constants */
  {$EXTERNALSYM MAX_SACK_BLKS}
  MAX_SACK_BLKS	= 6 platform; //* Max # SACK blocks stored at sender side */
  {$EXTERNALSYM TCP_MAX_SACK}
  TCP_MAX_SACK	= 3 platform;	//* MAX # SACKs sent in any segment */


// /*
// * Default maximum segment size for TCP.
// * With an IP MTU of 576, this is 536,
// * but 512 is probably more convenient.
// * This should be defined as MIN(512, IP_MSS - sizeof (struct tcpiphdr)).
// */
  {$EXTERNALSYM TCP_MSS}
  TCP_MSS	= 512 platform;

// /*
// * TCP_MINMSS is defined to be 216 which is fine for the smallest
// * link MTU (256 bytes, SLIP interface) in the Internet.
// * However it is very unlikely to come across such low MTU interfaces
// * these days (anno dato 2004).
// * Probably it can be set to 512 without ill effects. But we play safe.
// * See tcp_subr.c tcp_minmss SYSCTL declaration for more comments.
// * Setting this to "0" disables the minmss check.
// */
  {$EXTERNALSYM TCP_MINMSS}
  TCP_MINMSS = 216 platform;

// /*
// * TCP_MINMSSOVERLOAD is defined to be 1000 which should cover any type
// * of interactive TCP session.
// * See tcp_subr.c tcp_minmssoverload SYSCTL declaration and tcp_input.c
// * for more comments.
// * Setting this to "0" disables the minmssoverload check.
// */
  {$EXTERNALSYM TCP_MINMSSOVERLOAD}
  TCP_MINMSSOVERLOAD = 1000 platform;
// *
// * Default maximum segment size for TCP6.
// * With an IP6 MSS of 1280, this is 1220,
// * but 1024 is probably more convenient. (xxx kazu in doubt)
// * This should be defined as MIN(1024, IP6_MSS - sizeof (struct tcpip6hdr))
// */
  {$EXTERNALSYM TCP6_MSS}
  TCP6_MSS = 1024 platform;
  {$EXTERNALSYM TCP_MAXWIN}
  TCP_MAXWIN =	65535 platform;	//* largest value for (unscaled) window */
  {$EXTERNALSYM TTCP_CLIENT_SND_WND}
  TTCP_CLIENT_SND_WND	= 4096 platform;	//* dflt send window for T/TCP client */
  {$EXTERNALSYM TCP_MAX_WINSHIFT}
  TCP_MAX_WINSHIFT =	14 platform;	//* maximum window shift */
  {$EXTERNALSYM TCP_MAXBURST}
  TCP_MAXBURST	 =	4 platform;	//* maximum segments in a burst */
  {$EXTERNALSYM TCP_MAXHLEN}
  TCP_MAXHLEN    = ($f shl 2) platform;	//* max length of header in bytes */
  {$ENDIF}

  {$IFDEF LINUX}
  //specific to Linux
  {$EXTERNALSYM TCP_MAXSEG}
  TCP_MAXSEG             = 2;       //* Limit MSS */
  {$EXTERNALSYM TCP_CORK}
  TCP_CORK               = 3 platform;   //* Never send partially complete segments */
  {$EXTERNALSYM TCP_KEEPIDLE}
  TCP_KEEPIDLE           = 4 platform    //* Start keeplives after this period */
  {$EXTERNALSYM TCP_KEEPINTVL}
  TCP_KEEPINTVL          = 5 platform;   //* Interval between keepalives */
  {$EXTERNALSYM TCP_KEEPCNT}
  TCP_KEEPCNT            = 6 platform;   //* Number of keepalives before death */
  {$EXTERNALSYM TCP_SYNCNT}
  TCP_SYNCNT             = 7 platform;   //* Number of SYN retransmits */
  {$EXTERNALSYM TCP_LINGER2}
  TCP_LINGER2             = 8 platform;   //* Life time of orphaned FIN-WAIT-2 state */
  {$EXTERNALSYM TCP_DEFER_ACCEPT}
  TCP_DEFER_ACCEPT       = 9 platform;      //* Wake up listener only when data arrive */
  {$EXTERNALSYM TCP_WINDOW_CLAMP}
  TCP_WINDOW_CLAMP       = 10 platform;     //* Bound advertised window */
  {$EXTERNALSYM TCP_WINDOW_CLAMP}
  TCP_INFO               = 11 platform;      //* Information about this connection. */
  {$EXTERNALSYM TCP_QUICKACK}
  TCP_QUICKACK           = 12 platform;     //* Block/reenable quick acks */
  {$EXTERNALSYM TCP_CONGESTION}
  TCP_CONGESTION         = 13 platform;     //* Congestion control algorithm */
  {$EXTERNALSYM TCP_MD5SIG}
  TCP_MD5SIG             = 14 platform;     //* TCP MD5 Signature (RFC2385) */
  {$EXTERNALSYM TCP_COOKIE_TRANSACTIONS}
  TCP_COOKIE_TRANSACTIONS = 15 platform;     //* TCP Cookie Transactions */
  {$EXTERNALSYM TCP_THIN_LINEAR_TIMEOUTS}
  TCP_THIN_LINEAR_TIMEOUTS = 16 platform;     //* Use linear timeouts for thin streams*/
  {$EXTERNALSYM TCP_THIN_DUPACK}
  TCP_THIN_DUPACK        = 17 platform;      //* Fast retrans. after 1 dupack */

  {$EXTERNALSYM TCPI_OPT_TIMESTAMPS}
  TCPI_OPT_TIMESTAMPS	= 1;
  {$EXTERNALSYM TCPI_OPT_SACK}
  TCPI_OPT_SACK	 = 2;
  {$EXTERNALSYM TCPI_OPT_WSCALE}
  TCPI_OPT_WSCALE	= 4;
  {$EXTERNALSYM TCPI_OPT_ECN}
  TCPI_OPT_ECN	  = 8;
  {$ENDIF}
//udp.h

  {$IFDEF DARWIN}
  {$EXTERNALSYM UDP_NOCKSUM}
  UDP_NOCKSUM            = $01;    //* don't checksum outbound payloads */
  {$ENDIF}

  {$IFDEF DARWIN}
///Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/CarbonCore.framework/Versions/A/Headers/MacErrors.h

//enum {
  {$EXTERNALSYM paramErr}
  paramErr                      = -50;  //*error in user parameter list*/
  {$EXTERNALSYM noHardwareErr}
  noHardwareErr                 = -200; //*Sound Manager Error Returns*/
  {$EXTERNALSYM notEnoughHardwareErr}
  notEnoughHardwareErr          = -201; //*Sound Manager Error Returns*/
  {$EXTERNALSYM userCanceledErr}
  userCanceledErr               = -128;
  {$EXTERNALSYM qErr}
  qErr                          = -1;   //*queue element not found during deletion*/
  {$EXTERNALSYM vTypErr}
  vTypErr                       = -2;   //*invalid queue element*/
  {$EXTERNALSYM corErr}
  corErr                        = -3;   //*core routine number out of range*/
  {$EXTERNALSYM unimpErr}
  unimpErr                      = -4;   //*unimplemented core routine*/
  {$EXTERNALSYM SlpTypeErr}
  SlpTypeErr                    = -5;   //*invalid queue element*/
  {$EXTERNALSYM seNoDB}
  seNoDB                        = -8;   //*no debugger installed to handle debugger command*/
  {$EXTERNALSYM controlErr}
  controlErr                    = -17;  //*I/O System Errors*/
  {$EXTERNALSYM statusErr}
  statusErr                     = -18;  //*I/O System Errors*/
  {$EXTERNALSYM readErr}
  readErr                       = -19;  //*I/O System Errors*/
  {$EXTERNALSYM writErr}
  writErr                       = -20;  //*I/O System Errors*/
  {$EXTERNALSYM badUnitErr}
  badUnitErr                    = -21;  //*I/O System Errors*/
  {$EXTERNALSYM unitEmptyErr}
  unitEmptyErr                  = -22;  //*I/O System Errors*/
  {$EXTERNALSYM openErr}
  openErr                       = -23;  //*I/O System Errors*/
  {$EXTERNALSYM closErr}
  closErr                       = -24;  //*I/O System Errors*/
  {$EXTERNALSYM dRemovErr}
  dRemovErr                     = -25;  //*tried to remove an open driver*/
  {$EXTERNALSYM dInstErr}
  dInstErr                      = -26;  //*DrvrInstall couldn't find driver in resources*/
//};

//enum {
  {$EXTERNALSYM abortErr}
  abortErr                      = -27;  //*IO call aborted by KillIO*/
  {$EXTERNALSYM iIOAbortErr}
  iIOAbortErr                   = -27;  //*IO abort error (Printing Manager)*/
  {$EXTERNALSYM notOpenErr}
  notOpenErr                    = -28;  //*Couldn't rd/wr/ctl/sts cause driver not opened*/
  {$EXTERNALSYM unitTblFullErr}
  unitTblFullErr                = -29;  //*unit table has no more entries*/
  {$EXTERNALSYM dceExtErr}
  dceExtErr                     = -30;  //*dce extension error*/
  {$EXTERNALSYM slotNumErr}
  slotNumErr                    = -360; //*invalid slot # error*/
  {$EXTERNALSYM gcrOnMFMErr}
  gcrOnMFMErr                   = -400; //*gcr format on high density media error*/
  {$EXTERNALSYM dirFulErr}
  dirFulErr                     = -33;  //*Directory full*/
  {$EXTERNALSYM dskFulErr}
  dskFulErr                     = -34;  //*disk full*/
  {$EXTERNALSYM nsvErr}
  nsvErr                        = -35;  //*no such volume*/
  {$EXTERNALSYM ioErr}
  ioErr                         = -36;  //*I/O error (bummers)*/
  {$EXTERNALSYM bdNamErr}
  bdNamErr                      = -37;  //* bad file name passed to routine; there may be no bad names in the final system!*/
  {$EXTERNALSYM fnOpnErr}
  fnOpnErr                      = -38;  //*File not open*/
  {$EXTERNALSYM eofErr}
  eofErr                        = -39;  //*End of file*/
  {$EXTERNALSYM posErr}
  posErr                        = -40;  //*tried to position to before start of file (r/w)*/
  {$EXTERNALSYM mFulErr}
  mFulErr                       = -41;  //*memory full (open) or file won't fit (load)*/
  {$EXTERNALSYM tmfoErr}
  tmfoErr                       = -42;  //*too many files open*/
  {$EXTERNALSYM fnfErr}
  fnfErr                        = -43;  //*File not found*/
  {$EXTERNALSYM wPrErr}
  wPrErr                        = -44;  //*diskette is write protected.*/
  {$EXTERNALSYM fLckdErr}
  fLckdErr                      = -45;  //*file is locked*/
//};

//enum {
  {$EXTERNALSYM vLckdErr}
  vLckdErr                      = -46;  //*volume is locked*/
  {$EXTERNALSYM fBsyErr}
  fBsyErr                       = -47;  //*File is busy (delete)*/
  {$EXTERNALSYM dupFNErr}
  dupFNErr                      = -48;  //*duplicate filename (rename)*/
  {$EXTERNALSYM opWrErr}
  opWrErr                       = -49;  //*file already open with with write permission*/
  {$EXTERNALSYM rfNumErr}
  rfNumErr                      = -51;  //*refnum error*/
  {$EXTERNALSYM gfpErr}
  gfpErr                        = -52;  //*get file position error*/
  {$EXTERNALSYM volOffLinErr}
  volOffLinErr                  = -53;  //*volume not on line error (was Ejected)*/
  {$EXTERNALSYM permErr}
  permErr                       = -54;  //*permissions error (on file open)*/
  {$EXTERNALSYM volOnLinErr}
  volOnLinErr                   = -55;  //*drive volume already on-line at MountVol*/
  {$EXTERNALSYM nsDrvErr}
  nsDrvErr                      = -56;  //*no such drive (tried to mount a bad drive num)*/
  {$EXTERNALSYM noMacDskErr}
  noMacDskErr                   = -57;  //*not a mac diskette (sig bytes are wrong)*/
  {$EXTERNALSYM extFSErr}
  extFSErr                      = -58;  //*volume in question belongs to an external fs*/
  {$EXTERNALSYM fsRnErr}
  fsRnErr                       = -59;  //*file system internal error:during rename the old entry was deleted but could not be restored.*/
  {$EXTERNALSYM badMDBErr}
  badMDBErr                     = -60;  //*bad master directory block*/
  {$EXTERNALSYM wrPermErr}
  wrPermErr                     = -61;  //*write permissions error*/
  {$EXTERNALSYM dirNFErr}
  dirNFErr                      = -120; //*Directory not found*/
  {$EXTERNALSYM tmwdoErr}
  tmwdoErr                      = -121; //*No free WDCB available*/
  {$EXTERNALSYM badMovErr}
  badMovErr                     = -122; //*Move into offspring error*/
  {$EXTERNALSYM wrgVolTypErr}
  wrgVolTypErr                  = -123; //*Wrong volume type error [operation not supported for MFS]*/
  {$EXTERNALSYM volGoneErr}
  volGoneErr                    = -124; //*Server volume has been disconnected.*/
//};

//enum {
  {$EXTERNALSYM fidNotFound}
  fidNotFound                   = -1300; //*no file thread exists.*/
  {$EXTERNALSYM fidExists}
  fidExists                     = -1301; //*file id already exists*/
  {$EXTERNALSYM notAFileErr}
  notAFileErr                   = -1302; //*directory specified*/
  {$EXTERNALSYM diffVolErr}
  diffVolErr                    = -1303; //*files on different volumes*/
  {$EXTERNALSYM catChangedErr}
  catChangedErr                 = -1304; //*the catalog has been modified*/
  {$EXTERNALSYM desktopDamagedErr}
  desktopDamagedErr             = -1305; //*desktop database files are corrupted*/
  {$EXTERNALSYM sameFileErr}
  sameFileErr                   = -1306; //*can't exchange a file with itself*/
  {$EXTERNALSYM badFidErr}
  badFidErr                     = -1307; //*file id is dangling or doesn't match with the file number*/
  {$EXTERNALSYM notARemountErr}
  notARemountErr                = -1308; //*when _Mount allows only remounts and doesn't get one*/
  {$EXTERNALSYM fileBoundsErr}
  fileBoundsErr                 = -1309; //*file's EOF, offset, mark or size is too big*/
  {$EXTERNALSYM fsDataTooBigErr}
  fsDataTooBigErr               = -1310; //*file or volume is too big for system*/
  {$EXTERNALSYM volVMBusyErr}
  volVMBusyErr                  = -1311; //*can't eject because volume is in use by VM*/
  {$EXTERNALSYM badFCBErr}
  badFCBErr                     = -1327; //*FCBRecPtr is not valid*/
  {$EXTERNALSYM errFSUnknownCall}
  errFSUnknownCall              = -1400; //* selector is not recognized by this filesystem */
  {$EXTERNALSYM errFSBadFSRef}
  errFSBadFSRef                 = -1401; //* FSRef parameter is bad */
  {$EXTERNALSYM errFSBadForkName}
  errFSBadForkName              = -1402; //* Fork name parameter is bad */
  {$EXTERNALSYM errFSBadBuffer}
  errFSBadBuffer                = -1403; //* A buffer parameter was bad */
  {$EXTERNALSYM errFSBadForkRef}
  errFSBadForkRef               = -1404; //* A ForkRefNum parameter was bad */
  {$EXTERNALSYM errFSBadInfoBitmap}
  errFSBadInfoBitmap            = -1405; //* A CatalogInfoBitmap or VolumeInfoBitmap has reserved or invalid bits set */
  {$EXTERNALSYM errFSMissingCatInfo}
  errFSMissingCatInfo           = -1406; //* A CatalogInfo parameter was NULL */
  {$EXTERNALSYM errFSNotAFolder}
  errFSNotAFolder               = -1407; //* Expected a folder, got a file */
  {$EXTERNALSYM errFSForkNotFound}
  errFSForkNotFound             = -1409; //* Named fork does not exist */
  {$EXTERNALSYM errFSNameTooLong}
  errFSNameTooLong              = -1410; //* File/fork name is too long to create/rename */
  {$EXTERNALSYM errFSMissingName}
  errFSMissingName              = -1411; //* A Unicode name parameter was NULL or nameLength parameter was zero */
  {$EXTERNALSYM errFSBadPosMode}
  errFSBadPosMode               = -1412; //* Newline bits set in positionMode */
  {$EXTERNALSYM errFSBadAllocFlags}
  errFSBadAllocFlags            = -1413; //* Invalid bits set in allocationFlags */
  {$EXTERNALSYM errFSNoMoreItems}
  errFSNoMoreItems              = -1417; //* Iteration ran out of items to return */
  {$EXTERNALSYM errFSBadItemCount}
  errFSBadItemCount             = -1418; //* maximumItems was zero */
  {$EXTERNALSYM errFSBadSearchParams}
  errFSBadSearchParams          = -1419; //* Something wrong with CatalogSearch searchParams */
  {$EXTERNALSYM errFSRefsDifferent}
  errFSRefsDifferent            = -1420; //* FSCompareFSRefs; refs are for different objects */
  {$EXTERNALSYM errFSForkExists}
  errFSForkExists               = -1421; //* Named fork already exists. */
  {$EXTERNALSYM errFSBadIteratorFlags}
  errFSBadIteratorFlags         = -1422; //* Flags passed to FSOpenIterator are bad */
  {$EXTERNALSYM errFSIteratorNotFound}
  errFSIteratorNotFound         = -1423; //* Passed FSIterator is not an open iterator */
  {$EXTERNALSYM errFSIteratorNotSupported}
  errFSIteratorNotSupported     = -1424; //* The iterator's flags or container are not supported by this call */
  {$EXTERNALSYM errFSQuotaExceeded}
  errFSQuotaExceeded            = -1425; //* The user's quota of disk blocks has been exhausted. */
  {$EXTERNALSYM errFSOperationNotSupported}
  errFSOperationNotSupported    = -1426; //* The attempted operation is not supported */
  {$EXTERNALSYM errFSAttributeNotFound}
  errFSAttributeNotFound        = -1427; //* The requested attribute does not exist */
  {$EXTERNALSYM errFSPropertyNotValid}
  errFSPropertyNotValid         = -1428; //* The requested property is not valid (has not been set yet) */
  {$EXTERNALSYM errFSNotEnoughSpaceForOperation}
  errFSNotEnoughSpaceForOperation = -1429; //* There is not enough disk space to perform the requested operation */
  {$EXTERNALSYM envNotPresent}
  envNotPresent                 = -5500; //*returned by glue.*/
  {$EXTERNALSYM envBadVers}
  envBadVers                    = -5501; //*Version non-positive*/
  {$EXTERNALSYM envVersTooBig}
  envVersTooBig                 = -5502; //*Version bigger than call can handle*/
  {$EXTERNALSYM fontDecError}
  fontDecError                  = -64;  //*error during font declaration*/
  {$EXTERNALSYM fontNotDeclared}
  fontNotDeclared               = -65;  //*font not declared*/
  {$EXTERNALSYM fontSubErr}
  fontSubErr                    = -66;  //*font substitution occurred*/
  {$EXTERNALSYM fontNotOutlineErr}
  fontNotOutlineErr             = -32615; //*bitmap font passed to routine that does outlines only*/
  {$EXTERNALSYM firstDskErr}
  firstDskErr                   = -84;  //*I/O System Errors*/
  {$EXTERNALSYM lastDskErr}
  lastDskErr                    = -64;  //*I/O System Errors*/
  {$EXTERNALSYM noDriveErr}
  noDriveErr                    = -64;  //*drive not installed*/
  {$EXTERNALSYM offLinErr}
  offLinErr                     = -65;  //*r/w requested for an off-line drive*/
  {$EXTERNALSYM noNybErr}
  noNybErr                      = -66;  //*couldn't find 5 nybbles in 200 tries*/
//};

//enum {
  {$EXTERNALSYM noAdrMkErr}
  noAdrMkErr                    = -67;  //*couldn't find valid addr mark*/
  {$EXTERNALSYM dataVerErr}
  dataVerErr                    = -68;  //*read verify compare failed*/
  {$EXTERNALSYM badCksmErr}
  badCksmErr                    = -69;  //*addr mark checksum didn't check*/
  {$EXTERNALSYM badBtSlpErr}
  badBtSlpErr                   = -70;  //*bad addr mark bit slip nibbles*/
  {$EXTERNALSYM noDtaMkErr}
  noDtaMkErr                    = -71;  //*couldn't find a data mark header*/
  {$EXTERNALSYM badDCksum}
  badDCksum                     = -72;  //*bad data mark checksum*/
  {$EXTERNALSYM badDBtSlp}
  badDBtSlp                     = -73;  //*bad data mark bit slip nibbles*/
  {$EXTERNALSYM wrUnderrun}
  wrUnderrun                    = -74;  //*write underrun occurred*/
  {$EXTERNALSYM cantStepErr}
  cantStepErr                   = -75;  //*step handshake failed*/
  {$EXTERNALSYM tk0BadErr}
  tk0BadErr                     = -76;  //*track 0 detect doesn't change*/
  {$EXTERNALSYM initIWMErr}
  initIWMErr                    = -77;  //*unable to initialize IWM*/
  {$EXTERNALSYM twoSideErr}
  twoSideErr                    = -78;  //*tried to read 2nd side on a 1-sided drive*/
  {$EXTERNALSYM spdAdjErr}
  spdAdjErr                     = -79;  //*unable to correctly adjust disk speed*/
  {$EXTERNALSYM seekErr}
  seekErr                       = -80;  //*track number wrong on address mark*/
  {$EXTERNALSYM sectNFErr}
  sectNFErr                     = -81;  //*sector number never found on a track*/
  {$EXTERNALSYM fmt1Err}
  fmt1Err                       = -82;  //*can't find sector 0 after track format*/
  {$EXTERNALSYM fmt2Err}
  fmt2Err                       = -83;  //*can't get enough sync*/
  {$EXTERNALSYM verErr}
  verErr                        = -84;  //*track failed to verify*/
  {$EXTERNALSYM clkRdErr}
  clkRdErr                      = -85;  //*unable to read same clock value twice*/
  {$EXTERNALSYM clkWrErr}
  clkWrErr                      = -86;  //*time written did not verify*/
  {$EXTERNALSYM prWrErr}
  prWrErr                       = -87;  //*parameter ram written didn't read-verify*/
  {$EXTERNALSYM prInitErr}
  prInitErr                     = -88;  //*InitUtil found the parameter ram uninitialized*/
  {$EXTERNALSYM rcvrErr}
  rcvrErr                       = -89;  //*SCC receiver error (framing; parity; OR)*/
  {$EXTERNALSYM breakRecd}
  breakRecd                     = -90;  //*Break received (SCC)*/
//};

//enum {
                                        //*Scrap Manager errors*/
  {$EXTERNALSYM noScrapErr}
  noScrapErr                    = -100; //*No scrap exists error*/
  {$EXTERNALSYM noTypeErr}
  noTypeErr                     = -102; //*No object of that type in scrap*/
//};

//enum {
                                        //* ENET error codes */
  {$EXTERNALSYM eLenErr}
  eLenErr                       = -92;  //*Length error ddpLenErr*/
  {$EXTERNALSYM eMultiErr}
  eMultiErr                     = -91;  //*Multicast address error ddpSktErr*/
//};

//enum {
  {$EXTERNALSYM ddpSktErr}
  ddpSktErr                     = -91;  //*error in soket number*/
  {$EXTERNALSYM ddpLenErr}
  ddpLenErr                     = -92;  //*data length too big*/
  {$EXTERNALSYM noBridgeErr}
  noBridgeErr                   = -93;  //*no network bridge for non-local send*/
  {$EXTERNALSYM lapProtErr}
  lapProtErr                    = -94;  //*error in attaching/detaching protocol*/
  {$EXTERNALSYM excessCollsns}
  excessCollsns                 = -95;  //*excessive collisions on write*/
  {$EXTERNALSYM portNotPwr}
  portNotPwr                    = -96;  //*serial port not currently powered*/
  {$EXTERNALSYM portInUse}
  portInUse                     = -97;  //*driver Open error code (port is in use)*/
  {$EXTERNALSYM portNotCf}
  portNotCf                     = -98;  //*driver Open error code (parameter RAM not configured for this connection)*/
//};

//enum {
                                        //* Memory Manager errors*/
  {$EXTERNALSYM memROZWarn}
  memROZWarn                    = -99;  //*soft error in ROZ*/
  {$EXTERNALSYM memROZError}
  memROZError                   = -99;  //*hard error in ROZ*/
  {$EXTERNALSYM memROZErr}
  memROZErr                     = -99;  //*hard error in ROZ*/
  {$EXTERNALSYM memFullErr}
  memFullErr                    = -108; //*Not enough room in heap zone*/
  {$EXTERNALSYM nilHandleErr}
  nilHandleErr                  = -109; //*Master Pointer was NIL in HandleZone or other*/
  {$EXTERNALSYM memWZErr}
  memWZErr                      = -111; //*WhichZone failed (applied to free block)*/
  {$EXTERNALSYM memPurErr}
  memPurErr                     = -112; //*trying to purge a locked or non-purgeable block*/
  {$EXTERNALSYM memAdrErr}
  memAdrErr                     = -110; //*address was odd; or out of range*/
  {$EXTERNALSYM memAZErr}
  memAZErr                      = -113; //*Address in zone check failed*/
  {$EXTERNALSYM memPCErr}
  memPCErr                      = -114; //*Pointer Check failed*/
  {$EXTERNALSYM memBCErr}
  memBCErr                      = -115; //*Block Check failed*/
  {$EXTERNALSYM memSCErr}
  memSCErr                      = -116; //*Size Check failed*/
  {$EXTERNALSYM memLockedErr}
  memLockedErr                  = -117; //*trying to move a locked block (MoveHHi)*/
//};

//enum {
                                        //* Printing Errors */
  {$EXTERNALSYM iMemFullErr}
  iMemFullErr                   = -108;
  {$EXTERNALSYM iIOAbort}
  iIOAbort                      = -27;
//};


//enum {
  {$EXTERNALSYM resourceInMemory}
  resourceInMemory              = -188; //*Resource already in memory*/
  {$EXTERNALSYM writingPastEnd}
  writingPastEnd                = -189; //*Writing past end of file*/
  {$EXTERNALSYM inputOutOfBounds}
  inputOutOfBounds              = -190; //*Offset of Count out of bounds*/
  {$EXTERNALSYM resNotFound}
  resNotFound                   = -192; //*Resource not found*/
  {$EXTERNALSYM resFNotFound}
  resFNotFound                  = -193; //*Resource file not found*/
  {$EXTERNALSYM addResFailed}
  addResFailed                  = -194; //*AddResource failed*/
  {$EXTERNALSYM addRefFailed}
  addRefFailed                  = -195; //*AddReference failed*/
  {$EXTERNALSYM rmvResFailed}
  rmvResFailed                  = -196; //*RmveResource failed*/
  {$EXTERNALSYM rmvRefFailed}
  rmvRefFailed                  = -197; //*RmveReference failed*/
  {$EXTERNALSYM resAttrErr}
  resAttrErr                    = -198; //*attribute inconsistent with operation*/
  {$EXTERNALSYM mapReadErr}
  mapReadErr                    = -199; //*map inconsistent with operation*/
  {$EXTERNALSYM CantDecompress}
  CantDecompress                = -186; //*resource bent ("the bends") - can't decompress a compressed resource*/
  {$EXTERNALSYM badExtResource}
  badExtResource                = -185; //*extended resource has a bad format.*/
  {$EXTERNALSYM noMemForPictPlaybackErr}
  noMemForPictPlaybackErr       = -145;
  {$EXTERNALSYM rgnOverflowErr}
  rgnOverflowErr                = -147;
  {$EXTERNALSYM rgnTooBigError}
  rgnTooBigError                = -147;
  {$EXTERNALSYM pixMapTooDeepErr}
  pixMapTooDeepErr              = -148;
  {$EXTERNALSYM insufficientStackErr}
  insufficientStackErr          = -149;
  {$EXTERNALSYM nsStackErr}
  nsStackErr                    = -149;
//};

//enum {
  {$EXTERNALSYM evtNotEnb}
  evtNotEnb                     = 1;     //*event not enabled at PostEvent*/
//};

//* OffScreen QuickDraw Errors */
//enum {
  {$EXTERNALSYM cMatchErr}
  cMatchErr                     = -150; //*Color2Index failed to find an index*/
  {$EXTERNALSYM cTempMemErr}
  cTempMemErr                   = -151; //*failed to allocate memory for temporary structures*/
  {$EXTERNALSYM cNoMemErr}
  cNoMemErr                     = -152; //*failed to allocate memory for structure*/
  {$EXTERNALSYM cRangeErr}
  cRangeErr                     = -153; //*range error on colorTable request*/
  {$EXTERNALSYM cProtectErr}
  cProtectErr                   = -154; //*colorTable entry protection violation*/
  {$EXTERNALSYM cDevErr}
  cDevErr                       = -155; //*invalid type of graphics device*/
  {$EXTERNALSYM cResErr}
  cResErr                       = -156; //*invalid resolution for MakeITable*/
  {$EXTERNALSYM cDepthErr}
  cDepthErr                     = -157; //*invalid pixel depth */
  {$EXTERNALSYM rgnTooBigErr}
  rgnTooBigErr                  = -500; //* should have never been added! (cf. rgnTooBigError = 147) */
  {$EXTERNALSYM updPixMemErr}
  updPixMemErr                  = -125; //*insufficient memory to update a pixmap*/
  {$EXTERNALSYM pictInfoVersionErr}
  pictInfoVersionErr            = -11000; //*wrong version of the PictInfo structure*/
  {$EXTERNALSYM pictInfoIDErr}
  pictInfoIDErr                 = -11001; //*the internal consistancy check for the PictInfoID is wrong*/
  {$EXTERNALSYM pictInfoVerbErr}
  pictInfoVerbErr               = -11002; //*the passed verb was invalid*/
  {$EXTERNALSYM cantLoadPickMethodErr}
  cantLoadPickMethodErr         = -11003; //*unable to load the custom pick proc*/
  {$EXTERNALSYM colorsRequestedErr}
  colorsRequestedErr            = -11004; //*the number of colors requested was illegal*/
  {$EXTERNALSYM pictureDataErr}
  pictureDataErr                = -11005; //*the picture data was invalid*/
//};

//* ColorSync Result codes */
//enum {
                                        //* General Errors */
  {$EXTERNALSYM cmProfileError}
  cmProfileError                = -170;
  {$EXTERNALSYM cmMethodError}
  cmMethodError                 = -171;
  {$EXTERNALSYM cmMethodNotFound}
  cmMethodNotFound              = -175; //* CMM not present */
  {$EXTERNALSYM cmProfileNotFound}
  cmProfileNotFound             = -176; //* Responder error */
  {$EXTERNALSYM cmProfilesIdentical}
  cmProfilesIdentical           = -177; //* Profiles the same */
  {$EXTERNALSYM cmCantConcatenateError}
  cmCantConcatenateError        = -178; //* Profile can't be concatenated */
  {$EXTERNALSYM cmCantXYZ}
  cmCantXYZ                     = -179; //* CMM cant handle XYZ space */
  {$EXTERNALSYM cmCantDeleteProfile}
  cmCantDeleteProfile           = -180; //* Responder error */
  {$EXTERNALSYM cmUnsupportedDataType}
  cmUnsupportedDataType         = -181; //* Responder error */
  {$EXTERNALSYM cmNoCurrentProfile}
  cmNoCurrentProfile            = -182;  //* Responder error */
//};


//enum {
                                        //*Sound Manager errors*/
  {$EXTERNALSYM noHardware}
  noHardware                    = noHardwareErr; //*obsolete spelling*/
  {$EXTERNALSYM notEnoughHardware}
  notEnoughHardware             = notEnoughHardwareErr; //*obsolete spelling*/
  {$EXTERNALSYM queueFull}
  queueFull                     = -203; //*Sound Manager Error Returns*/
  {$EXTERNALSYM resProblem}
  resProblem                    = -204; //*Sound Manager Error Returns*/
  {$EXTERNALSYM badChannel}
  badChannel                    = -205; //*Sound Manager Error Returns*/
  {$EXTERNALSYM badFormat}
  badFormat                     = -206; //*Sound Manager Error Returns*/
  {$EXTERNALSYM notEnoughBufferSpace}
  notEnoughBufferSpace          = -207; //*could not allocate enough memory*/
  {$EXTERNALSYM badFileFormat}
  badFileFormat                 = -208; //*was not type AIFF or was of bad format,corrupt*/
  {$EXTERNALSYM channelBusy}
  channelBusy                   = -209; //*the Channel is being used for a PFD already*/
  {$EXTERNALSYM buffersTooSmall}
  buffersTooSmall               = -210; //*can not operate in the memory allowed*/
  {$EXTERNALSYM channelNotBusy}
  channelNotBusy                = -211;
  {$EXTERNALSYM noMoreRealTime}
  noMoreRealTime                = -212; //*not enough CPU cycles left to add another task*/
  {$EXTERNALSYM siVBRCompressionNotSupported}
  siVBRCompressionNotSupported  = -213; //*vbr audio compression not supported for this operation*/
  {$EXTERNALSYM siNoSoundInHardware}
  siNoSoundInHardware           = -220; //*no Sound Input hardware*/
  {$EXTERNALSYM siBadSoundInDevice}
  siBadSoundInDevice            = -221; //*invalid index passed to SoundInGetIndexedDevice*/
  {$EXTERNALSYM siNoBufferSpecified}
  siNoBufferSpecified           = -222; //*returned by synchronous SPBRecord if nil buffer passed*/
  {$EXTERNALSYM siInvalidCompression}
  siInvalidCompression          = -223; //*invalid compression type*/
  {$EXTERNALSYM siHardDriveTooSlow}
  siHardDriveTooSlow            = -224; //*hard drive too slow to record to disk*/
  {$EXTERNALSYM siInvalidSampleRate}
  siInvalidSampleRate           = -225; //*invalid sample rate*/
  {$EXTERNALSYM siInvalidSampleSize}
  siInvalidSampleSize           = -226; //*invalid sample size*/
  {$EXTERNALSYM siDeviceBusyErr}
  siDeviceBusyErr               = -227; //*input device already in use*/
  {$EXTERNALSYM siBadDeviceName}
  siBadDeviceName               = -228; //*input device could not be opened*/
  {$EXTERNALSYM siBadRefNum}
  siBadRefNum                   = -229; //*invalid input device reference number*/
  {$EXTERNALSYM siInputDeviceErr}
  siInputDeviceErr              = -230; //*input device hardware failure*/
  {$EXTERNALSYM siUnknownInfoType}
  siUnknownInfoType             = -231; //*invalid info type selector (returned by driver)*/
  {$EXTERNALSYM siUnknownQuality}
  siUnknownQuality              = -232; //*invalid quality selector (returned by driver)*/
//};

///*Speech Manager errors*/
//enum {
  {$EXTERNALSYM noSynthFound}
  noSynthFound                  = -240;
  {$EXTERNALSYM synthOpenFailed}
  synthOpenFailed               = -241;
  {$EXTERNALSYM synthNotReady}
  synthNotReady                 = -242;
  {$EXTERNALSYM bufTooSmall}
  bufTooSmall                   = -243;
  {$EXTERNALSYM voiceNotFound}
  voiceNotFound                 = -244;
  {$EXTERNALSYM incompatibleVoice}
  incompatibleVoice             = -245;
  {$EXTERNALSYM badDictFormat}
  badDictFormat                 = -246;
  {$EXTERNALSYM badInputText}
  badInputText                  = -247;
//};

//* Midi Manager Errors: */
//enum {
  {$EXTERNALSYM midiNoClientErr}
  midiNoClientErr               = -250; //*no client with that ID found*/
  {$EXTERNALSYM midiNoPortErr}
  midiNoPortErr                 = -251; //*no port with that ID found*/
  {$EXTERNALSYM midiTooManyPortsErr}
  midiTooManyPortsErr           = -252; //*too many ports already installed in the system*/
  {$EXTERNALSYM midiTooManyConsErr}
  midiTooManyConsErr            = -253; //*too many connections made*/
  {$EXTERNALSYM midiVConnectErr}
  midiVConnectErr               = -254; //*pending virtual connection created*/
  {$EXTERNALSYM midiVConnectMade}
  midiVConnectMade              = -255; //*pending virtual connection resolved*/
  {$EXTERNALSYM midiVConnectRmvd}
  midiVConnectRmvd              = -256; //*pending virtual connection removed*/
  {$EXTERNALSYM midiNoConErr}
  midiNoConErr                  = -257; //*no connection exists between specified ports*/
  {$EXTERNALSYM midiWriteErr}
  midiWriteErr                  = -258; //*MIDIWritePacket couldn't write to all connected ports*/
  {$EXTERNALSYM midiNameLenErr}
  midiNameLenErr                = -259; //*name supplied is longer than 31 characters*/
  {$EXTERNALSYM midiDupIDErr}
  midiDupIDErr                  = -260; //*duplicate client ID*/
  {$EXTERNALSYM midiInvalidCmdErr}
  midiInvalidCmdErr             = -261; //*command not supported for port type*/
//};


//enum {
  {$EXTERNALSYM nmTypErr}
  nmTypErr                      = -299; //*Notification Manager:wrong queue type*/
//};


//enum {
  {$EXTERNALSYM siInitSDTblErr}
  siInitSDTblErr                = 1;    //*slot int dispatch table could not be initialized.*/
  {$EXTERNALSYM siInitVBLQsErr}
  siInitVBLQsErr                = 2;    //*VBLqueues for all slots could not be initialized.*/
  {$EXTERNALSYM siInitSPTblErr}
  siInitSPTblErr                = 3;    //*slot priority table could not be initialized.*/
  {$EXTERNALSYM sdmJTInitErr}
  sdmJTInitErr                  = 10;   //*SDM Jump Table could not be initialized.*/
  {$EXTERNALSYM sdmInitErr}
  sdmInitErr                    = 11;   //*SDM could not be initialized.*/
  {$EXTERNALSYM sdmSRTInitErr}
  sdmSRTInitErr                 = 12;   //*Slot Resource Table could not be initialized.*/
  {$EXTERNALSYM sdmPRAMInitErr}
  sdmPRAMInitErr                = 13;   //*Slot PRAM could not be initialized.*/
  {$EXTERNALSYM sdmPriInitErr}
  sdmPriInitErr                 = 14;   //*Cards could not be initialized.*/
//};

//enum {
  {$EXTERNALSYM smSDMInitErr}
  smSDMInitErr                  = -290; //*Error; SDM could not be initialized.*/
  {$EXTERNALSYM smSRTInitErr}
  smSRTInitErr                  = -291; //*Error; Slot Resource Table could not be initialized.*/
  {$EXTERNALSYM smPRAMInitErr}
  smPRAMInitErr                 = -292; //*Error; Slot Resource Table could not be initialized.*/
  {$EXTERNALSYM smPriInitErr}
  smPriInitErr                  = -293; //*Error; Cards could not be initialized.*/
  {$EXTERNALSYM smEmptySlot}
  smEmptySlot                   = -300; //*No card in slot*/
  {$EXTERNALSYM smCRCFail}
  smCRCFail                     = -301; //*CRC check failed for declaration data*/
  {$EXTERNALSYM smFormatErr}
  smFormatErr                   = -302; //*FHeader Format is not Apple's*/
  {$EXTERNALSYM smRevisionErr}
  smRevisionErr                 = -303; //*Wrong revison level*/
  {$EXTERNALSYM smNoDir}
  smNoDir                       = -304; //*Directory offset is Nil*/
  {$EXTERNALSYM smDisabledSlot}
  smDisabledSlot                = -305; //*This slot is disabled (-305 use to be smLWTstBad)*/
  {$EXTERNALSYM smNosInfoArray}
  smNosInfoArray                = -306; //*No sInfoArray. Memory Mgr error.*/
//};


//enum {
  {$EXTERNALSYM smResrvErr}
  smResrvErr                    = -307; //*Fatal reserved error. Resreved field <> 0.*/
  {$EXTERNALSYM smUnExBusErr}
  smUnExBusErr                  = -308; //*Unexpected BusError*/
  {$EXTERNALSYM smBLFieldBad}
  smBLFieldBad                  = -309; //*ByteLanes field was bad.*/
  {$EXTERNALSYM smFHBlockRdErr}
  smFHBlockRdErr                = -310; //*Error occurred during _sGetFHeader.*/
  {$EXTERNALSYM smFHBlkDispErr}
  smFHBlkDispErr                = -311; //*Error occurred during _sDisposePtr (Dispose of FHeader block).*/
  {$EXTERNALSYM smDisposePErr}
  smDisposePErr                 = -312; //*_DisposePointer error*/
  {$EXTERNALSYM smNoBoardSRsrc}
  smNoBoardSRsrc                = -313; //*No Board sResource.*/
  {$EXTERNALSYM smGetPRErr}
  smGetPRErr                    = -314; //*Error occurred during _sGetPRAMRec (See SIMStatus).*/
  {$EXTERNALSYM smNoBoardId}
  smNoBoardId                   = -315; //*No Board Id.*/
  {$EXTERNALSYM smInitStatVErr}
  smInitStatVErr                = -316; //*The InitStatusV field was negative after primary or secondary init.*/
  {$EXTERNALSYM smInitTblVErr}
  smInitTblVErr                 = -317; //*An error occurred while trying to initialize the Slot Resource Table.*/
  {$EXTERNALSYM smNoJmpTbl}
  smNoJmpTbl                    = -318; //*SDM jump table could not be created.*/
  {$EXTERNALSYM smReservedSlot}
  smReservedSlot                = -318; //*slot is reserved, VM should not use this address space.*/
  {$EXTERNALSYM smBadBoardId}
  smBadBoardId                  = -319; //*BoardId was wrong; re-init the PRAM record.*/
  {$EXTERNALSYM smBusErrTO}
  smBusErrTO                    = -320; //*BusError time out.*/
                                        //* These errors are logged in the  vendor status field of the sInfo record. */
  {$EXTERNALSYM svTempDisable}
  svTempDisable                 = -32768; //*Temporarily disable card but run primary init.*/
  {$EXTERNALSYM svDisabled}
  svDisabled                    = -32640; //*Reserve range -32640 to -32768 for Apple temp disables.*/
  {$EXTERNALSYM smBadRefId}
  smBadRefId                    = -330; //*Reference Id not found in List*/
  {$EXTERNALSYM smBadsList}
  smBadsList                    = -331; //*Bad sList: Id1 < Id2 < Id3 ...format is not followed.*/
  {$EXTERNALSYM smReservedErr}
  smReservedErr                 = -332; //*Reserved field not zero*/
  {$EXTERNALSYM smCodeRevErr}
  smCodeRevErr                  = -333;  //*Code revision is wrong*/
//};

//enum {
  {$EXTERNALSYM smCPUErr}
  smCPUErr                      = -334; //*Code revision is wrong*/
  {$EXTERNALSYM smsPointerNil}
  smsPointerNil                 = -335; //*LPointer is nil From sOffsetData. If this error occurs; check sInfo rec for more information.*/
  {$EXTERNALSYM smNilsBlockErr}
  smNilsBlockErr                = -336; //*Nil sBlock error (Don't allocate and try to use a nil sBlock)*/
  {$EXTERNALSYM smSlotOOBErr}
  smSlotOOBErr                  = -337; //*Slot out of bounds error*/
  {$EXTERNALSYM smSelOOBErr}
  smSelOOBErr                   = -338; //*Selector out of bounds error*/
  {$EXTERNALSYM smNewPErr}
  smNewPErr                     = -339; //*_NewPtr error*/
  {$EXTERNALSYM smBlkMoveErr}
  smBlkMoveErr                  = -340; //*_BlockMove error*/
  {$EXTERNALSYM smCkStatusErr}
  smCkStatusErr                 = -341; //*Status of slot = fail.*/
  {$EXTERNALSYM smGetDrvrNamErr}
  smGetDrvrNamErr               = -342; //*Error occurred during _sGetDrvrName.*/
  {$EXTERNALSYM smDisDrvrNamErr}
  smDisDrvrNamErr               = -343; //*Error occurred during _sDisDrvrName.*/
  {$EXTERNALSYM smNoMoresRsrcs}
  smNoMoresRsrcs                = -344; //*No more sResources*/
  {$EXTERNALSYM smsGetDrvrErr}
  smsGetDrvrErr                 = -345; //*Error occurred during _sGetDriver.*/
  {$EXTERNALSYM smBadsPtrErr}
  smBadsPtrErr                  = -346; //*Bad pointer was passed to sCalcsPointer*/
  {$EXTERNALSYM smByteLanesErr}
  smByteLanesErr                = -347; //*NumByteLanes was determined to be zero.*/
  {$EXTERNALSYM smOffsetErr}
  smOffsetErr                   = -348; //*Offset was too big (temporary error*/
  {$EXTERNALSYM smNoGoodOpens}
  smNoGoodOpens                 = -349; //*No opens were successfull in the loop.*/
  {$EXTERNALSYM smSRTOvrFlErr}
  smSRTOvrFlErr                 = -350; //*SRT over flow.*/
  {$EXTERNALSYM smRecNotFnd}
  smRecNotFnd                   = -351; //*Record not found in the SRT.*/
//};


//enum {
                                        //*Dictionary Manager errors*/
  {$EXTERNALSYM notBTree}
  notBTree                      = -410; //*The file is not a dictionary.*/
  {$EXTERNALSYM btNoSpace}
  btNoSpace                     = -413; //*Can't allocate disk space.*/
  {$EXTERNALSYM btDupRecErr}
  btDupRecErr                   = -414; //*Record already exists.*/
  {$EXTERNALSYM btRecNotFnd}
  btRecNotFnd                   = -415; //*Record cannot be found.*/
  {$EXTERNALSYM btKeyLenErr}
  btKeyLenErr                   = -416; //*Maximum key length is too long or equal to zero.*/
  {$EXTERNALSYM btKeyAttrErr}
  btKeyAttrErr                  = -417; //*There is no such a key attribute.*/
  {$EXTERNALSYM unknownInsertModeErr}
  unknownInsertModeErr          = -20000; //*There is no such an insert mode.*/
  {$EXTERNALSYM recordDataTooBigErr}
  recordDataTooBigErr           = -20001; //*The record data is bigger than buffer size (1024 bytes).*/
  {$EXTERNALSYM invalidIndexErr}
  invalidIndexErr               = -20002; //*The recordIndex parameter is not valid.*/
//};


{*
 * Error codes from FSM functions
 *}
//enum {
  {$EXTERNALSYM fsmFFSNotFoundErr}
  fsmFFSNotFoundErr             = -431; //* Foreign File system does not exist - new Pack2 could return this error too */
  {$EXTERNALSYM fsmBusyFFSErr}
  fsmBusyFFSErr                 = -432; //* File system is busy, cannot be removed */
  {$EXTERNALSYM fsmBadFFSNameErr}
  fsmBadFFSNameErr              = -433; //* Name length not 1 <= length <= 31 */
  {$EXTERNALSYM fsmBadFSDLenErr}
  fsmBadFSDLenErr               = -434; //* FSD size incompatible with current FSM vers */
  {$EXTERNALSYM fsmDuplicateFSIDErr}
  fsmDuplicateFSIDErr           = -435; //* FSID already exists on InstallFS */
  {$EXTERNALSYM fsmBadFSDVersionErr}
  fsmBadFSDVersionErr           = -436; //* FSM version incompatible with FSD */
  {$EXTERNALSYM fsmNoAlternateStackErr}
  fsmNoAlternateStackErr        = -437; //* no alternate stack for HFS CI */
  {$EXTERNALSYM fsmUnknownFSMMessageErr}
  fsmUnknownFSMMessageErr       = -438; //* unknown message passed to FSM */
//};


//enum {
                                        //* Edition Mgr errors*/
  {$EXTERNALSYM editionMgrInitErr}
  editionMgrInitErr             = -450; //*edition manager not inited by this app*/
  {$EXTERNALSYM badSectionErr}
  badSectionErr                 = -451; //*not a valid SectionRecord*/
  {$EXTERNALSYM notRegisteredSectionErr}
  notRegisteredSectionErr       = -452; //*not a registered SectionRecord*/
  {$EXTERNALSYM badEditionFileErr}
  badEditionFileErr             = -453; //*edition file is corrupt*/
  {$EXTERNALSYM badSubPartErr}
  badSubPartErr                 = -454; //*can not use sub parts in this release*/
  {$EXTERNALSYM multiplePublisherWrn}
  multiplePublisherWrn          = -460; //*A Publisher is already registered for that container*/
  {$EXTERNALSYM containerNotFoundWrn}
  containerNotFoundWrn          = -461; //*could not find editionContainer at this time*/
  {$EXTERNALSYM containerAlreadyOpenWrn}
  containerAlreadyOpenWrn       = -462; //*container already opened by this section*/
  {$EXTERNALSYM notThePublisherWrn}
  notThePublisherWrn            = -463; //*not the first registered publisher for that container*/
//};

//enum {
  {$EXTERNALSYM teScrapSizeErr}
  teScrapSizeErr                = -501; //*scrap item too big for text edit record*/
  {$EXTERNALSYM hwParamErr}
  hwParamErr                    = -502; //*bad selector for _HWPriv*/
  {$EXTERNALSYM driverHardwareGoneErr}
  driverHardwareGoneErr         = -503; //*disk driver's hardware was disconnected*/
//};

//enum {
                                        //*Process Manager errors*/
  {$EXTERNALSYM procNotFound}
  procNotFound                  = -600; //*no eligible process with specified descriptor*/
  {$EXTERNALSYM memFragErr}
  memFragErr                    = -601; //*not enough room to launch app w/special requirements*/
  {$EXTERNALSYM appModeErr}
  appModeErr                    = -602; //*memory mode is 32-bit, but app not 32-bit clean*/
  {$EXTERNALSYM protocolErr}
  protocolErr                   = -603; //*app made module calls in improper order*/
  {$EXTERNALSYM hardwareConfigErr}
  hardwareConfigErr             = -604; //*hardware configuration not correct for call*/
  {$EXTERNALSYM appMemFullErr}
  appMemFullErr                 = -605; //*application SIZE not big enough for launch*/
  {$EXTERNALSYM appIsDaemon}
  appIsDaemon                   = -606; //*app is BG-only, and launch flags disallow this*/
  {$EXTERNALSYM bufferIsSmall}
  bufferIsSmall                 = -607; //*error returns from Post and Accept */
  {$EXTERNALSYM noOutstandingHLE}
  noOutstandingHLE              = -608;
  {$EXTERNALSYM connectionInvalid}
  connectionInvalid             = -609;
  {$EXTERNALSYM noUserInteractionAllowed}
  noUserInteractionAllowed      = -610; //* no user interaction allowed */
//};

//enum {
                                        //* More Process Manager errors */
  {$EXTERNALSYM wrongApplicationPlatform}
  wrongApplicationPlatform      = -875; //* The application could not launch because the required platform is not available    */
  {$EXTERNALSYM appVersionTooOld}
  appVersionTooOld              = -876; //* The application's creator and version are incompatible with the current version of Mac OS. */
  {$EXTERNALSYM notAppropriateForClassic}
  notAppropriateForClassic      = -877; //* This application won't or shouldn't run on Classic (Problem 2481058). */
//};

//* Thread Manager Error Codes */
//enum {
  {$EXTERNALSYM threadTooManyReqsErr}
  threadTooManyReqsErr          = -617;
  {$EXTERNALSYM threadNotFoundErr}
  threadNotFoundErr             = -618;
  {$EXTERNALSYM threadProtocolErr}
  threadProtocolErr             = -619;
//};

//enum {
  {$EXTERNALSYM threadBadAppContextErr}
  threadBadAppContextErr        = -616;
//};

//*MemoryDispatch errors*/
//enum {
  {$EXTERNALSYM notEnoughMemoryErr}
  notEnoughMemoryErr            = -620; //*insufficient physical memory*/
  {$EXTERNALSYM notHeldErr}
  notHeldErr                    = -621; //*specified range of memory is not held*/
  {$EXTERNALSYM cannotMakeContiguousErr}
  cannotMakeContiguousErr       = -622; //*cannot make specified range contiguous*/
  {$EXTERNALSYM notLockedErr}
  notLockedErr                  = -623; //*specified range of memory is not locked*/
  {$EXTERNALSYM interruptsMaskedErr}
  interruptsMaskedErr           = -624; //*don’t call with interrupts masked*/
  {$EXTERNALSYM cannotDeferErr}
  cannotDeferErr                = -625; //*unable to defer additional functions*/
  {$EXTERNALSYM noMMUErr}
  noMMUErr                      = -626; //*no MMU present*/
//};

//* Internal VM error codes returned in pVMGLobals (b78) if VM doesn't load */
//enum {
  {$EXTERNALSYM vmMorePhysicalThanVirtualErr}
  vmMorePhysicalThanVirtualErr  = -628; //*VM could not start because there was more physical memory than virtual memory (bad setting in VM config resource)*/
  {$EXTERNALSYM vmKernelMMUInitErr}
  vmKernelMMUInitErr            = -629; //*VM could not start because VM_MMUInit kernel call failed*/
  {$EXTERNALSYM vmOffErr}
  vmOffErr                      = -630; //*VM was configured off, or command key was held down at boot*/
  {$EXTERNALSYM vmMemLckdErr}
  vmMemLckdErr                  = -631; //*VM could not start because of a lock table conflict (only on non-SuperMario ROMs)*/
  {$EXTERNALSYM vmBadDriver}
  vmBadDriver                   = -632; //*VM could not start because the driver was incompatible*/
  {$EXTERNALSYM vmNoVectorErr}
  vmNoVectorErr                 = -633; //*VM could not start because the vector code could not load*/
//};

///* FileMapping errors */
//enum {
  {$EXTERNALSYM vmInvalidBackingFileIDErr}
  vmInvalidBackingFileIDErr     = -640; //* invalid BackingFileID */
  {$EXTERNALSYM vmMappingPrivilegesErr}
  vmMappingPrivilegesErr        = -641; //* requested MappingPrivileges cannot be obtained */
  {$EXTERNALSYM vmBusyBackingFileErr}
  vmBusyBackingFileErr          = -642; //* open views found on BackingFile */
  {$EXTERNALSYM vmNoMoreBackingFilesErr}
  vmNoMoreBackingFilesErr       = -643; //* no more BackingFiles were found */
  {$EXTERNALSYM vmInvalidFileViewIDErr}
  vmInvalidFileViewIDErr        = -644; //*invalid FileViewID */
  {$EXTERNALSYM vmFileViewAccessErr}
  vmFileViewAccessErr           = -645; //* requested FileViewAccess cannot be obtained */
  {$EXTERNALSYM vmNoMoreFileViewsErr}
  vmNoMoreFileViewsErr          = -646; //* no more FileViews were found */
  {$EXTERNALSYM vmAddressNotInFileViewErr}
  vmAddressNotInFileViewErr     = -647; //* address is not in a FileView */
  {$EXTERNALSYM vmInvalidOwningProcessErr}
  vmInvalidOwningProcessErr     = -648; //* current process does not own the BackingFileID or FileViewID */
//};

//* Database access error codes */
//enum {
  {$EXTERNALSYM rcDBNull}
  rcDBNull                      = -800;
  {$EXTERNALSYM rcDBValue}
  rcDBValue                     = -801;
  {$EXTERNALSYM rcDBError}
  rcDBError                     = -802;
  {$EXTERNALSYM rcDBBadType}
  rcDBBadType                   = -803;
  {$EXTERNALSYM rcDBBreak}
  rcDBBreak                     = -804;
  {$EXTERNALSYM rcDBExec}
  rcDBExec                      = -805;
  {$EXTERNALSYM rcDBBadSessID}
  rcDBBadSessID                 = -806;
  {$EXTERNALSYM rcDBBadSessNum}
  rcDBBadSessNum                = -807; //* bad session number for DBGetConnInfo */
  {$EXTERNALSYM rcDBBadDDEV}
  rcDBBadDDEV                   = -808; //* bad ddev specified on DBInit */
  {$EXTERNALSYM rcDBAsyncNotSupp}
  rcDBAsyncNotSupp              = -809; //* ddev does not support async calls */
  {$EXTERNALSYM rcDBBadAsyncPB}
  rcDBBadAsyncPB                = -810; //* tried to kill a bad pb */
  {$EXTERNALSYM rcDBNoHandler}
  rcDBNoHandler                 = -811; //* no app handler for specified data type */
  {$EXTERNALSYM rcDBWrongVersion}
  rcDBWrongVersion              = -812; //* incompatible versions */
  {$EXTERNALSYM rcDBPackNotInited}
  rcDBPackNotInited             = -813; //* attempt to call other routine before InitDBPack */
//};


//*Help Mgr error range: -850 to -874*/
//enum {
  {$EXTERNALSYM hmHelpDisabled}
  hmHelpDisabled                = -850; //* Show Balloons mode was off, call to routine ignored */
  {$EXTERNALSYM hmBalloonAborted}
  hmBalloonAborted              = -853; //* Returned if mouse was moving or mouse wasn't in window port rect */
  {$EXTERNALSYM hmSameAsLastBalloon}
  hmSameAsLastBalloon           = -854; //* Returned from HMShowMenuBalloon if menu & item is same as last time */
  {$EXTERNALSYM hmHelpManagerNotInited}
  hmHelpManagerNotInited        = -855; //* Returned from HMGetHelpMenuHandle if help menu not setup */
  {$EXTERNALSYM hmSkippedBalloon}
  hmSkippedBalloon              = -857; //* Returned from calls if helpmsg specified a skip balloon */
  {$EXTERNALSYM hmWrongVersion}
  hmWrongVersion                = -858; //* Returned if help mgr resource was the wrong version */
  {$EXTERNALSYM hmUnknownHelpType}
  hmUnknownHelpType             = -859; //* Returned if help msg record contained a bad type */
  {$EXTERNALSYM hmOperationUnsupported}
  hmOperationUnsupported        = -861; //* Returned from HMShowBalloon call if bad method passed to routine */
  {$EXTERNALSYM hmNoBalloonUp}
  hmNoBalloonUp                 = -862; //* Returned from HMRemoveBalloon if no balloon was visible when call was made */
  {$EXTERNALSYM hmCloseViewActive}
  hmCloseViewActive             = -863; //* Returned from HMRemoveBalloon if CloseView was active */
//};



//enum {
                                        //*PPC errors*/
  {$EXTERNALSYM notInitErr}
  notInitErr                    = -900; //*PPCToolBox not initialized*/
  {$EXTERNALSYM nameTypeErr}
  nameTypeErr                   = -902; //*Invalid or inappropriate locationKindSelector in locationName*/
  {$EXTERNALSYM noPortErr}
  noPortErr                     = -903; //*Unable to open port or bad portRefNum.  If you're calling */
                                        //* AESend, this is because your application does not have */
                                        //* the isHighLevelEventAware bit set in your SIZE resource. */
  {$EXTERNALSYM noGlobalsErr}
  noGlobalsErr                  = -904; //*The system is hosed, better re-boot*/
  {$EXTERNALSYM localOnlyErr}
  localOnlyErr                  = -905; //*Network activity is currently disabled*/
  {$EXTERNALSYM destPortErr}
  destPortErr                   = -906; //*Port does not exist at destination*/
  {$EXTERNALSYM sessTableErr}
  sessTableErr                  = -907; //*Out of session tables, try again later*/
  {$EXTERNALSYM noSessionErr}
  noSessionErr                  = -908; //*Invalid session reference number*/
  {$EXTERNALSYM badReqErr}
  badReqErr                     = -909; //*bad parameter or invalid state for operation*/
  {$EXTERNALSYM portNameExistsErr}
  portNameExistsErr             = -910; //*port is already open (perhaps in another app)*/
  {$EXTERNALSYM noUserNameErr}
  noUserNameErr                 = -911; //*user name unknown on destination machine*/
  {$EXTERNALSYM userRejectErr}
  userRejectErr                 = -912; //*Destination rejected the session request*/
  {$EXTERNALSYM noMachineNameErr}
  noMachineNameErr              = -913; //*user hasn't named his Macintosh in the Network Setup Control Panel*/
  {$EXTERNALSYM noToolboxNameErr}
  noToolboxNameErr              = -914; //*A system resource is missing, not too likely*/
  {$EXTERNALSYM noResponseErr}
  noResponseErr                 = -915; //*unable to contact destination*/
  {$EXTERNALSYM portClosedErr}
  portClosedErr                 = -916; //*port was closed*/
  {$EXTERNALSYM sessClosedErr}
  sessClosedErr                 = -917; //*session was closed*/
  {$EXTERNALSYM badPortNameErr}
  badPortNameErr                = -919; //*PPCPortRec malformed*/
  {$EXTERNALSYM noDefaultUserErr}
  noDefaultUserErr              = -922; //*user hasn't typed in owners name in Network Setup Control Pannel*/
  {$EXTERNALSYM notLoggedInErr}
  notLoggedInErr                = -923; //*The default userRefNum does not yet exist*/
  {$EXTERNALSYM noUserRefErr}
  noUserRefErr                  = -924; //*unable to create a new userRefNum*/
  {$EXTERNALSYM networkErr}
  networkErr                    = -925; //*An error has occurred in the network, not too likely*/
  {$EXTERNALSYM noInformErr}
  noInformErr                   = -926; //*PPCStart failed because destination did not have inform pending*/
  {$EXTERNALSYM authFailErr}
  authFailErr                   = -927; //*unable to authenticate user at destination*/
  {$EXTERNALSYM noUserRecErr}
  noUserRecErr                  = -928; //*Invalid user reference number*/
  {$EXTERNALSYM badServiceMethodErr}
  badServiceMethodErr           = -930; //*illegal service type, or not supported*/
  {$EXTERNALSYM badLocNameErr}
  badLocNameErr                 = -931; //*location name malformed*/
  {$EXTERNALSYM guestNotAllowedErr}
  guestNotAllowedErr            = -932;  //*destination port requires authentication*/
//};

//* Font Mgr errors*/
//enum {
  {$EXTERNALSYM kFMIterationCompleted}
  kFMIterationCompleted         = -980;
  {$EXTERNALSYM kFMInvalidFontFamilyErr}
  kFMInvalidFontFamilyErr       = -981;
  {$EXTERNALSYM kFMInvalidFontErr}
  kFMInvalidFontErr             = -982;
  {$EXTERNALSYM kFMIterationScopeModifiedErr}
  kFMIterationScopeModifiedErr  = -983;
  {$EXTERNALSYM kFMFontTableAccessErr}
  kFMFontTableAccessErr         = -984;
  {$EXTERNALSYM kFMFontContainerAccessErr}
  kFMFontContainerAccessErr     = -985;
//};

//enum {
  {$EXTERNALSYM noMaskFoundErr}
  noMaskFoundErr                = -1000; //*Icon Utilties Error*/
//};

//enum {
  {$EXTERNALSYM nbpBuffOvr}
  nbpBuffOvr                    = -1024; //*Buffer overflow in LookupName*/
  {$EXTERNALSYM nbpNoConfirm}
  nbpNoConfirm                  = -1025;
  {$EXTERNALSYM nbpConfDiff}
  nbpConfDiff                   = -1026; //*Name confirmed at different socket*/
  {$EXTERNALSYM nbpDuplicate}
  nbpDuplicate                  = -1027; //*Duplicate name exists already*/
  {$EXTERNALSYM nbpNotFound}
  nbpNotFound                   = -1028; //*Name not found on remove*/
  {$EXTERNALSYM nbpNISErr}
  nbpNISErr                     = -1029; //*Error trying to open the NIS*/
//};

//enum {
  {$EXTERNALSYM aspBadVersNum}
  aspBadVersNum                 = -1066; //*Server cannot support this ASP version*/
  {$EXTERNALSYM aspBufTooSmall}
  aspBufTooSmall                = -1067; //*Buffer too small*/
  {$EXTERNALSYM aspNoMoreSess}
  aspNoMoreSess                 = -1068; //*No more sessions on server*/
  {$EXTERNALSYM aspNoServers}
  aspNoServers                  = -1069; //*No servers at that address*/
  {$EXTERNALSYM aspParamErr}
  aspParamErr                   = -1070; //*Parameter error*/
  {$EXTERNALSYM aspServerBusy}
  aspServerBusy                 = -1071; //*Server cannot open another session*/
  {$EXTERNALSYM aspSessClosed}
  aspSessClosed                 = -1072; //*Session closed*/
  {$EXTERNALSYM aspSizeErr}
  aspSizeErr                    = -1073; //*Command block too big*/
  {$EXTERNALSYM aspTooMany}
  aspTooMany                    = -1074; //*Too many clients (server error)*/
  {$EXTERNALSYM aspNoAck}
  aspNoAck                      = -1075; //*No ack on attention request (server err)*/
//};

//enum {
  {$EXTERNALSYM reqFailed}
  reqFailed                     = -1096;
  {$EXTERNALSYM tooManyReqs}
  tooManyReqs                   = -1097;
  {$EXTERNALSYM tooManySkts}
  tooManySkts                   = -1098;
  {$EXTERNALSYM badATPSkt}
  badATPSkt                     = -1099;
  {$EXTERNALSYM badBuffNum}
  badBuffNum                    = -1100;
  {$EXTERNALSYM noRelErr}
  noRelErr                      = -1101;
  {$EXTERNALSYM cbNotFound}
  cbNotFound                    = -1102;
  {$EXTERNALSYM noSendResp}
  noSendResp                    = -1103;
  {$EXTERNALSYM noDataArea}
  noDataArea                    = -1104;
  {$EXTERNALSYM reqAborted}
  reqAborted                    = -1105;
//};

//* ADSP Error Codes */
//enum {
                                        //* driver control ioResults */
  {$EXTERNALSYM errRefNum}
  errRefNum                     = -1280; //* bad connection refNum */
  {$EXTERNALSYM errAborted}
  errAborted                    = -1279; //* control call was aborted */
  {$EXTERNALSYM errState}
  errState                      = -1278; //* bad connection state for this operation */
  {$EXTERNALSYM errOpening}
  errOpening                    = -1277; //* open connection request failed */
  {$EXTERNALSYM errAttention}
  errAttention                  = -1276; //* attention message too long */
  {$EXTERNALSYM errFwdReset}
  errFwdReset                   = -1275; //* read terminated by forward reset */
  {$EXTERNALSYM errDSPQueueSize}
  errDSPQueueSize               = -1274; //* DSP Read/Write Queue Too small */
  {$EXTERNALSYM errOpenDenied}
  errOpenDenied                 = -1273; //* open connection request was denied */
//};


{*--------------------------------------------------------------
        Apple event manager error messages
--------------------------------------------------------------*}

//enum {
  {$EXTERNALSYM errAECoercionFail}
  errAECoercionFail             = -1700; //* bad parameter data or unable to coerce the data supplied */
  {$EXTERNALSYM errAEDescNotFound}
  errAEDescNotFound             = -1701;
  {$EXTERNALSYM errAECorruptData}
  errAECorruptData              = -1702;
  {$EXTERNALSYM errAEWrongDataType}
  errAEWrongDataType            = -1703;
  {$EXTERNALSYM errAENotAEDesc}
  errAENotAEDesc                = -1704;
  {$EXTERNALSYM errAEBadListItem}
  errAEBadListItem              = -1705; //* the specified list item does not exist */
  {$EXTERNALSYM errAENewerVersion}
  errAENewerVersion             = -1706; //* need newer version of the AppleEvent manager */
  {$EXTERNALSYM errAENotAppleEvent}
  errAENotAppleEvent            = -1707; //* the event is not in AppleEvent format */
  {$EXTERNALSYM errAEEventNotHandled}
  errAEEventNotHandled          = -1708; //* the AppleEvent was not handled by any handler */
  {$EXTERNALSYM errAEReplyNotValid}
  errAEReplyNotValid            = -1709; //* AEResetTimer was passed an invalid reply parameter */
  {$EXTERNALSYM errAEUnknownSendMode}
  errAEUnknownSendMode          = -1710; //* mode wasn't NoReply, WaitReply, or QueueReply or Interaction level is unknown */
  {$EXTERNALSYM errAEWaitCanceled}
  errAEWaitCanceled             = -1711; //* in AESend, the user cancelled out of wait loop for reply or receipt */
  {$EXTERNALSYM errAETimeout}
  errAETimeout                  = -1712; //* the AppleEvent timed out */
  {$EXTERNALSYM errAENoUserInteraction}
  errAENoUserInteraction        = -1713; //* no user interaction is allowed */
  {$EXTERNALSYM errAENotASpecialFunction}
  errAENotASpecialFunction      = -1714; //* there is no special function for/with this keyword */
  {$EXTERNALSYM errAEParamMissed}
  errAEParamMissed              = -1715; //* a required parameter was not accessed */
  {$EXTERNALSYM errAEUnknownAddressType}
  errAEUnknownAddressType       = -1716; //* the target address type is not known */
  {$EXTERNALSYM errAEHandlerNotFound}
  errAEHandlerNotFound          = -1717; //* no handler in the dispatch tables fits the parameters to AEGetEventHandler or AEGetCoercionHandler */
  {$EXTERNALSYM errAEReplyNotArrived}
  errAEReplyNotArrived          = -1718; //* the contents of the reply you are accessing have not arrived yet */
  {$EXTERNALSYM errAEIllegalIndex}
  errAEIllegalIndex             = -1719; //* index is out of range in a put operation */
  {$EXTERNALSYM errAEImpossibleRange}
  errAEImpossibleRange          = -1720; //* A range like 3rd to 2nd, or 1st to all. */
  {$EXTERNALSYM errAEWrongNumberArgs}
  errAEWrongNumberArgs          = -1721; //* Logical op kAENOT used with other than 1 term */
  {$EXTERNALSYM errAEAccessorNotFound}
  errAEAccessorNotFound         = -1723; //* Accessor proc matching wantClass and containerType or wildcards not found */
  {$EXTERNALSYM errAENoSuchLogical}
  errAENoSuchLogical            = -1725; //* Something other than AND, OR, or NOT */
  {$EXTERNALSYM errAEBadTestKey}
  errAEBadTestKey               = -1726; //* Test is neither typeLogicalDescriptor nor typeCompDescriptor */
  {$EXTERNALSYM errAENotAnObjSpec}
  errAENotAnObjSpec             = -1727; //* Param to AEResolve not of type 'obj ' */
  {$EXTERNALSYM errAENoSuchObject}
  errAENoSuchObject             = -1728; //* e.g.,: specifier asked for the 3rd, but there are only 2. Basically, this indicates a run-time resolution error. */
  {$EXTERNALSYM errAENegativeCount}
  errAENegativeCount            = -1729; //* CountProc returned negative value */
  {$EXTERNALSYM errAEEmptyListContainer}
  errAEEmptyListContainer       = -1730; //* Attempt to pass empty list as container to accessor */
  {$EXTERNALSYM errAEUnknownObjectType}
  errAEUnknownObjectType        = -1731; //* available only in version 1.0.1 or greater */
  {$EXTERNALSYM errAERecordingIsAlreadyOn}
  errAERecordingIsAlreadyOn     = -1732; //* available only in version 1.0.1 or greater */
  {$EXTERNALSYM errAEReceiveTerminate}
  errAEReceiveTerminate         = -1733; //* break out of all levels of AEReceive to the topmost (1.1 or greater) */
  {$EXTERNALSYM errAEReceiveEscapeCurrent}
  errAEReceiveEscapeCurrent     = -1734; //* break out of only lowest level of AEReceive (1.1 or greater) */
  {$EXTERNALSYM errAEEventFiltered}
  errAEEventFiltered            = -1735; //* event has been filtered, and should not be propogated (1.1 or greater) */
  {$EXTERNALSYM errAEDuplicateHandler}
  errAEDuplicateHandler         = -1736; //* attempt to install handler in table for identical class and id (1.1 or greater) */
  {$EXTERNALSYM errAEStreamBadNesting}
  errAEStreamBadNesting         = -1737; //* nesting violation while streaming */
  {$EXTERNALSYM errAEStreamAlreadyConverted}
  errAEStreamAlreadyConverted   = -1738; //* attempt to convert a stream that has already been converted */
  {$EXTERNALSYM errAEDescIsNull}
  errAEDescIsNull               = -1739; //* attempting to perform an invalid operation on a null descriptor */
  {$EXTERNALSYM errAEBuildSyntaxError}
  errAEBuildSyntaxError         = -1740; //* AEBuildDesc and friends detected a syntax error */
  {$EXTERNALSYM errAEBufferTooSmall}
  errAEBufferTooSmall           = -1741; //* buffer for AEFlattenDesc too small */
//};

//enum {
  {$EXTERNALSYM errOSASystemError}
  errOSASystemError             = -1750;
  {$EXTERNALSYM errOSAInvalidID}
  errOSAInvalidID               = -1751;
  {$EXTERNALSYM errOSABadStorageType}
  errOSABadStorageType          = -1752;
  {$EXTERNALSYM errOSAScriptError}
  errOSAScriptError             = -1753;
  {$EXTERNALSYM errOSABadSelector}
  errOSABadSelector             = -1754;
  {$EXTERNALSYM errOSASourceNotAvailable}
  errOSASourceNotAvailable      = -1756;
  {$EXTERNALSYM errOSANoSuchDialect}
  errOSANoSuchDialect           = -1757;
  {$EXTERNALSYM errOSADataFormatObsolete}
  errOSADataFormatObsolete      = -1758;
  {$EXTERNALSYM errOSADataFormatTooNew}
  errOSADataFormatTooNew        = -1759;
  {$EXTERNALSYM errOSACorruptData}
  errOSACorruptData             = errAECorruptData;
  {$EXTERNALSYM errOSARecordingIsAlreadyOn}
  errOSARecordingIsAlreadyOn    = errAERecordingIsAlreadyOn;
  {$EXTERNALSYM errOSAComponentMismatch}
  errOSAComponentMismatch       = -1761; //* Parameters are from 2 different components */
  {$EXTERNALSYM errOSACantOpenComponent}
  errOSACantOpenComponent       = -1762; //* Can't connect to scripting system with that ID */
//};



//* AppleEvent error definitions */
//enum {
  {$EXTERNALSYM errOffsetInvalid}
  errOffsetInvalid              = -1800;
  {$EXTERNALSYM errOffsetIsOutsideOfView}
  errOffsetIsOutsideOfView      = -1801;
  {$EXTERNALSYM errTopOfDocument}
  errTopOfDocument              = -1810;
  {$EXTERNALSYM errTopOfBody}
  errTopOfBody                  = -1811;
  {$EXTERNALSYM errEndOfDocument}
  errEndOfDocument              = -1812;
  {$EXTERNALSYM errEndOfBody}
  errEndOfBody                  = -1813;
//};


//enum {
                                        //* Drag Manager error codes */
  {$EXTERNALSYM badDragRefErr}
  badDragRefErr                 = -1850; //* unknown drag reference */
  {$EXTERNALSYM badDragItemErr}
  badDragItemErr                = -1851; //* unknown drag item reference */
  {$EXTERNALSYM badDragFlavorErr}
  badDragFlavorErr              = -1852; //* unknown flavor type */
  {$EXTERNALSYM duplicateFlavorErr}
  duplicateFlavorErr            = -1853; //* flavor type already exists */
  {$EXTERNALSYM cantGetFlavorErr}
  cantGetFlavorErr              = -1854; //* error while trying to get flavor data */
  {$EXTERNALSYM duplicateHandlerErr}
  duplicateHandlerErr           = -1855; //* handler already exists */
  {$EXTERNALSYM handlerNotFoundErr}
  handlerNotFoundErr            = -1856; //* handler not found */
  {$EXTERNALSYM dragNotAcceptedErr}
  dragNotAcceptedErr            = -1857; //* drag was not accepted by receiver */
  {$EXTERNALSYM unsupportedForPlatformErr}
  unsupportedForPlatformErr     = -1858; //* call is for PowerPC only */
  {$EXTERNALSYM noSuitableDisplaysErr}
  noSuitableDisplaysErr         = -1859; //* no displays support translucency */
  {$EXTERNALSYM badImageRgnErr}
  badImageRgnErr                = -1860; //* bad translucent image region */
  {$EXTERNALSYM badImageErr}
  badImageErr                   = -1861; //* bad translucent image PixMap */
  {$EXTERNALSYM nonDragOriginatorErr}
  nonDragOriginatorErr          = -1862; //* illegal attempt at originator only data */
//};


//*QuickTime errors*/
//enum {
  {$EXTERNALSYM couldNotResolveDataRef}
  couldNotResolveDataRef        = -2000;
  {$EXTERNALSYM badImageDescription}
  badImageDescription           = -2001;
  {$EXTERNALSYM badPublicMovieAtom}
  badPublicMovieAtom            = -2002;
  {$EXTERNALSYM cantFindHandler}
  cantFindHandler               = -2003;
  {$EXTERNALSYM cantOpenHandler}
  cantOpenHandler               = -2004;
  {$EXTERNALSYM badComponentType}
  badComponentType              = -2005;
  {$EXTERNALSYM noMediaHandler}
  noMediaHandler                = -2006;
  {$EXTERNALSYM noDataHandler}
  noDataHandler                 = -2007;
  {$EXTERNALSYM invalidMedia}
  invalidMedia                  = -2008;
  {$EXTERNALSYM invalidTrack}
  invalidTrack                  = -2009;
  {$EXTERNALSYM invalidMovie}
  invalidMovie                  = -2010;
  {$EXTERNALSYM invalidSampleTable}
  invalidSampleTable            = -2011;
  {$EXTERNALSYM invalidDataRef}
  invalidDataRef                = -2012;
  {$EXTERNALSYM invalidHandler}
  invalidHandler                = -2013;
  {$EXTERNALSYM invalidDuration}
  invalidDuration               = -2014;
  {$EXTERNALSYM invalidTime}
  invalidTime                   = -2015;
  {$EXTERNALSYM cantPutPublicMovieAtom}
  cantPutPublicMovieAtom        = -2016;
  {$EXTERNALSYM badEditList}
  badEditList                   = -2017;
  {$EXTERNALSYM mediaTypesDontMatch}
  mediaTypesDontMatch           = -2018;
  {$EXTERNALSYM progressProcAborted}
  progressProcAborted           = -2019;
  {$EXTERNALSYM movieToolboxUninitialized}
  movieToolboxUninitialized     = -2020;
  {$EXTERNALSYM noRecordOfApp}
  noRecordOfApp                 = movieToolboxUninitialized; //* replica */
  {$EXTERNALSYM wfFileNotFound}
  wfFileNotFound                = -2021;
  {$EXTERNALSYM cantCreateSingleForkFile}
  cantCreateSingleForkFile      = -2022; //* happens when file already exists */
  {$EXTERNALSYM invalidEditState}
  invalidEditState              = -2023;
  {$EXTERNALSYM nonMatchingEditState}
  nonMatchingEditState          = -2024;
  {$EXTERNALSYM staleEditState}
  staleEditState                = -2025;
  {$EXTERNALSYM userDataItemNotFound}
  userDataItemNotFound          = -2026;
  {$EXTERNALSYM maxSizeToGrowTooSmall}
  maxSizeToGrowTooSmall         = -2027;
  {$EXTERNALSYM badTrackIndex}
  badTrackIndex                 = -2028;
  {$EXTERNALSYM trackIDNotFound}
  trackIDNotFound               = -2029;
  {$EXTERNALSYM trackNotInMovie}
  trackNotInMovie               = -2030;
  {$EXTERNALSYM timeNotInTrack}
  timeNotInTrack                = -2031;
  {$EXTERNALSYM timeNotInMedia}
  timeNotInMedia                = -2032;
  {$EXTERNALSYM badEditIndex}
  badEditIndex                  = -2033;
  {$EXTERNALSYM internalQuickTimeError}
  internalQuickTimeError        = -2034;
  {$EXTERNALSYM cantEnableTrack}
  cantEnableTrack               = -2035;
  {$EXTERNALSYM invalidRect}
  invalidRect                   = -2036;
  {$EXTERNALSYM invalidSampleNum}
  invalidSampleNum              = -2037;
  {$EXTERNALSYM invalidChunkNum}
  invalidChunkNum               = -2038;
  {$EXTERNALSYM invalidSampleDescIndex}
  invalidSampleDescIndex        = -2039;
  {$EXTERNALSYM invalidChunkCache}
  invalidChunkCache             = -2040;
  {$EXTERNALSYM invalidSampleDescription}
  invalidSampleDescription      = -2041;
  {$EXTERNALSYM dataNotOpenForRead}
  dataNotOpenForRead            = -2042;
  {$EXTERNALSYM dataNotOpenForWrite}
  dataNotOpenForWrite           = -2043;
  {$EXTERNALSYM dataAlreadyOpenForWrite}
  dataAlreadyOpenForWrite       = -2044;
  {$EXTERNALSYM dataAlreadyClosed}
  dataAlreadyClosed             = -2045;
  {$EXTERNALSYM endOfDataReached}
  endOfDataReached              = -2046;
  {$EXTERNALSYM dataNoDataRef}
  dataNoDataRef                 = -2047;
  {$EXTERNALSYM noMovieFound}
  noMovieFound                  = -2048;
  {$EXTERNALSYM invalidDataRefContainer}
  invalidDataRefContainer       = -2049;
  {$EXTERNALSYM badDataRefIndex}
  badDataRefIndex               = -2050;
  {$EXTERNALSYM noDefaultDataRef}
  noDefaultDataRef              = -2051;
  {$EXTERNALSYM couldNotUseAnExistingSample}
  couldNotUseAnExistingSample   = -2052;
  {$EXTERNALSYM featureUnsupported}
  featureUnsupported            = -2053;
  {$EXTERNALSYM noVideoTrackInMovieErr}
  noVideoTrackInMovieErr        = -2054; //* QT for Windows error */
  {$EXTERNALSYM noSoundTrackInMovieErr}
  noSoundTrackInMovieErr        = -2055; //* QT for Windows error */
  {$EXTERNALSYM soundSupportNotAvailableErr}
  soundSupportNotAvailableErr   = -2056; //* QT for Windows error */
  {$EXTERNALSYM unsupportedAuxiliaryImportData}
  unsupportedAuxiliaryImportData = -2057;
  {$EXTERNALSYM auxiliaryExportDataUnavailable}
  auxiliaryExportDataUnavailable = -2058;
  {$EXTERNALSYM samplesAlreadyInMediaErr}
  samplesAlreadyInMediaErr      = -2059;
  {$EXTERNALSYM noSourceTreeFoundErr}
  noSourceTreeFoundErr          = -2060;
  {$EXTERNALSYM sourceNotFoundErr}
  sourceNotFoundErr             = -2061;
  {$EXTERNALSYM movieTextNotFoundErr}
  movieTextNotFoundErr          = -2062;
  {$EXTERNALSYM missingRequiredParameterErr}
  missingRequiredParameterErr   = -2063;
  {$EXTERNALSYM invalidSpriteWorldPropertyErr}
  invalidSpriteWorldPropertyErr = -2064;
  {$EXTERNALSYM invalidSpritePropertyErr}
  invalidSpritePropertyErr      = -2065;
  {$EXTERNALSYM gWorldsNotSameDepthAndSizeErr}
  gWorldsNotSameDepthAndSizeErr = -2066;
  {$EXTERNALSYM invalidSpriteIndexErr}
  invalidSpriteIndexErr         = -2067;
  {$EXTERNALSYM invalidImageIndexErr}
  invalidImageIndexErr          = -2068;
  {$EXTERNALSYM invalidSpriteIDErr}
  invalidSpriteIDErr            = -2069;
//};

//enum {
  {$EXTERNALSYM internalComponentErr}
  internalComponentErr          = -2070;
  {$EXTERNALSYM notImplementedMusicOSErr}
  notImplementedMusicOSErr      = -2071;
  {$EXTERNALSYM cantSendToSynthesizerOSErr}
  cantSendToSynthesizerOSErr    = -2072;
  {$EXTERNALSYM cantReceiveFromSynthesizerOSErr}
  cantReceiveFromSynthesizerOSErr = -2073;
  {$EXTERNALSYM illegalVoiceAllocationOSErr}
  illegalVoiceAllocationOSErr   = -2074;
  {$EXTERNALSYM illegalPartOSErr}
  illegalPartOSErr              = -2075;
  {$EXTERNALSYM illegalChannelOSErr}
  illegalChannelOSErr           = -2076;
  {$EXTERNALSYM illegalKnobOSErr}
  illegalKnobOSErr              = -2077;
  {$EXTERNALSYM illegalKnobValueOSErr}
  illegalKnobValueOSErr         = -2078;
  {$EXTERNALSYM illegalInstrumentOSErr}
  illegalInstrumentOSErr        = -2079;
  {$EXTERNALSYM illegalControllerOSErr}
  illegalControllerOSErr        = -2080;
  {$EXTERNALSYM midiManagerAbsentOSErr}
  midiManagerAbsentOSErr        = -2081;
  {$EXTERNALSYM synthesizerNotRespondingOSErr}
  synthesizerNotRespondingOSErr = -2082;
  {$EXTERNALSYM synthesizerOSErr}
  synthesizerOSErr              = -2083;
  {$EXTERNALSYM illegalNoteChannelOSErr}
  illegalNoteChannelOSErr       = -2084;
  {$EXTERNALSYM noteChannelNotAllocatedOSErr}
  noteChannelNotAllocatedOSErr  = -2085;
  {$EXTERNALSYM tunePlayerFullOSErr}
  tunePlayerFullOSErr           = -2086;
  {$EXTERNALSYM tuneParseOSErr}
  tuneParseOSErr                = -2087;
  {$EXTERNALSYM noExportProcAvailableErr}
  noExportProcAvailableErr      = -2089;
  {$EXTERNALSYM videoOutputInUseErr}
  videoOutputInUseErr           = -2090;
//};

//enum {
  {$EXTERNALSYM componentDllLoadErr}
  componentDllLoadErr           = -2091; //* Windows specific errors (when component is loading)*/
  {$EXTERNALSYM componentDllEntryNotFoundErr}
  componentDllEntryNotFoundErr  = -2092; //* Windows specific errors (when component is loading)*/
  {$EXTERNALSYM qtmlDllLoadErr}
  qtmlDllLoadErr                = -2093; //* Windows specific errors (when qtml is loading)*/
  {$EXTERNALSYM qtmlDllEntryNotFoundErr}
  qtmlDllEntryNotFoundErr       = -2094; //* Windows specific errors (when qtml is loading)*/
  {$EXTERNALSYM qtmlUninitialized}
  qtmlUninitialized             = -2095;
  {$EXTERNALSYM unsupportedOSErr}
  unsupportedOSErr              = -2096;
  {$EXTERNALSYM unsupportedProcessorErr}
  unsupportedProcessorErr       = -2097;
  {$EXTERNALSYM componentNotThreadSafeErr}
  componentNotThreadSafeErr     = -2098; //* component is not thread-safe*/
//};

//enum {
  {$EXTERNALSYM cannotFindAtomErr}
  cannotFindAtomErr             = -2101;
  {$EXTERNALSYM notLeafAtomErr}
  notLeafAtomErr                = -2102;
  {$EXTERNALSYM atomsNotOfSameTypeErr}
  atomsNotOfSameTypeErr         = -2103;
  {$EXTERNALSYM atomIndexInvalidErr}
  atomIndexInvalidErr           = -2104;
  {$EXTERNALSYM duplicateAtomTypeAndIDErr}
  duplicateAtomTypeAndIDErr     = -2105;
  {$EXTERNALSYM invalidAtomErr}
  invalidAtomErr                = -2106;
  {$EXTERNALSYM invalidAtomContainerErr}
  invalidAtomContainerErr       = -2107;
  {$EXTERNALSYM invalidAtomTypeErr}
  invalidAtomTypeErr            = -2108;
  {$EXTERNALSYM cannotBeLeafAtomErr}
  cannotBeLeafAtomErr           = -2109;
  {$EXTERNALSYM pathTooLongErr}
  pathTooLongErr                = -2110;
  {$EXTERNALSYM emptyPathErr}
  emptyPathErr                  = -2111;
  {$EXTERNALSYM noPathMappingErr}
  noPathMappingErr              = -2112;
  {$EXTERNALSYM pathNotVerifiedErr}
  pathNotVerifiedErr            = -2113;
  {$EXTERNALSYM unknownFormatErr}
  unknownFormatErr              = -2114;
  {$EXTERNALSYM wackBadFileErr}
  wackBadFileErr                = -2115;
  {$EXTERNALSYM wackForkNotFoundErr}
  wackForkNotFoundErr           = -2116;
  {$EXTERNALSYM wackBadMetaDataErr}
  wackBadMetaDataErr            = -2117;
  {$EXTERNALSYM qfcbNotFoundErr}
  qfcbNotFoundErr               = -2118;
  {$EXTERNALSYM qfcbNotCreatedErr}
  qfcbNotCreatedErr             = -2119;
  {$EXTERNALSYM AAPNotCreatedErr}
  AAPNotCreatedErr              = -2120;
  {$EXTERNALSYM AAPNotFoundErr}
  AAPNotFoundErr                = -2121;
  {$EXTERNALSYM ASDBadHeaderErr}
  ASDBadHeaderErr               = -2122;
  {$EXTERNALSYM ASDBadForkErr}
  ASDBadForkErr                 = -2123;
  {$EXTERNALSYM ASDEntryNotFoundErr}
  ASDEntryNotFoundErr           = -2124;
  {$EXTERNALSYM fileOffsetTooBigErr}
  fileOffsetTooBigErr           = -2125;
  {$EXTERNALSYM notAllowedToSaveMovieErr}
  notAllowedToSaveMovieErr      = -2126;
  {$EXTERNALSYM qtNetworkAlreadyAllocatedErr}
  qtNetworkAlreadyAllocatedErr  = -2127;
  {$EXTERNALSYM urlDataHHTTPProtocolErr}
  urlDataHHTTPProtocolErr       = -2129;
  {$EXTERNALSYM urlDataHHTTPNoNetDriverErr}
  urlDataHHTTPNoNetDriverErr    = -2130;
  {$EXTERNALSYM urlDataHHTTPURLErr}
  urlDataHHTTPURLErr            = -2131;
  {$EXTERNALSYM urlDataHHTTPRedirectErr}
  urlDataHHTTPRedirectErr       = -2132;
  {$EXTERNALSYM urlDataHFTPProtocolErr}
  urlDataHFTPProtocolErr        = -2133;
  {$EXTERNALSYM urlDataHFTPShutdownErr}
  urlDataHFTPShutdownErr        = -2134;
  {$EXTERNALSYM urlDataHFTPBadUserErr}
  urlDataHFTPBadUserErr         = -2135;
  {$EXTERNALSYM urlDataHFTPBadPasswordErr}
  urlDataHFTPBadPasswordErr     = -2136;
  {$EXTERNALSYM urlDataHFTPServerErr}
  urlDataHFTPServerErr          = -2137;
  {$EXTERNALSYM urlDataHFTPDataConnectionErr}
  urlDataHFTPDataConnectionErr  = -2138;
  {$EXTERNALSYM urlDataHFTPNoDirectoryErr}
  urlDataHFTPNoDirectoryErr     = -2139;
  {$EXTERNALSYM urlDataHFTPQuotaErr}
  urlDataHFTPQuotaErr           = -2140;
  {$EXTERNALSYM urlDataHFTPPermissionsErr}
  urlDataHFTPPermissionsErr     = -2141;
  {$EXTERNALSYM urlDataHFTPFilenameErr}
  urlDataHFTPFilenameErr        = -2142;
  {$EXTERNALSYM urlDataHFTPNoNetDriverErr}
  urlDataHFTPNoNetDriverErr     = -2143;
  {$EXTERNALSYM urlDataHFTPBadNameListErr}
  urlDataHFTPBadNameListErr     = -2144;
  {$EXTERNALSYM urlDataHFTPNeedPasswordErr}
  urlDataHFTPNeedPasswordErr    = -2145;
  {$EXTERNALSYM urlDataHFTPNoPasswordErr}
  urlDataHFTPNoPasswordErr      = -2146;
  {$EXTERNALSYM urlDataHFTPServerDisconnectedErr}
  urlDataHFTPServerDisconnectedErr = -2147;
  {$EXTERNALSYM urlDataHFTPURLErr}
  urlDataHFTPURLErr             = -2148;
  {$EXTERNALSYM notEnoughDataErr}
  notEnoughDataErr              = -2149;
  {$EXTERNALSYM qtActionNotHandledErr}
  qtActionNotHandledErr         = -2157;
  {$EXTERNALSYM qtXMLParseErr}
  qtXMLParseErr                 = -2158;
  {$EXTERNALSYM qtXMLApplicationErr}
  qtXMLApplicationErr           = -2159;
//};


//enum {
  {$EXTERNALSYM digiUnimpErr}
  digiUnimpErr                  = -2201; //* feature unimplemented */
  {$EXTERNALSYM qtParamErr}
  qtParamErr                    = -2202; //* bad input parameter (out of range, etc) */
  {$EXTERNALSYM matrixErr}
  matrixErr                     = -2203; //* bad matrix, digitizer did nothing */
  {$EXTERNALSYM notExactMatrixErr}
  notExactMatrixErr             = -2204; //* warning of bad matrix, digitizer did its best */
  {$EXTERNALSYM noMoreKeyColorsErr}
  noMoreKeyColorsErr            = -2205; //* all key indexes in use */
  {$EXTERNALSYM notExactSizeErr}
  notExactSizeErr               = -2206; //* Can’t do exact size requested */
  {$EXTERNALSYM badDepthErr}
  badDepthErr                   = -2207; //* Can’t digitize into this depth */
  {$EXTERNALSYM noDMAErr}
  noDMAErr                      = -2208; //* Can’t do DMA digitizing (i.e. can't go to requested dest */
  {$EXTERNALSYM badCallOrderErr}
  badCallOrderErr               = -2209; //* Usually due to a status call being called prior to being setup first */
//};


//*  Kernel Error Codes  */
//enum {
  {$EXTERNALSYM kernelIncompleteErr}
  kernelIncompleteErr           = -2401;
  {$EXTERNALSYM kernelCanceledErr}
  kernelCanceledErr             = -2402;
  {$EXTERNALSYM kernelOptionsErr}
  kernelOptionsErr              = -2403;
  {$EXTERNALSYM kernelPrivilegeErr}
  kernelPrivilegeErr            = -2404;
  {$EXTERNALSYM kernelUnsupportedErr}
  kernelUnsupportedErr          = -2405;
  {$EXTERNALSYM kernelObjectExistsErr}
  kernelObjectExistsErr         = -2406;
  {$EXTERNALSYM kernelWritePermissionErr}
  kernelWritePermissionErr      = -2407;
  {$EXTERNALSYM kernelReadPermissionErr}
  kernelReadPermissionErr       = -2408;
  {$EXTERNALSYM kernelExecutePermissionErr}
  kernelExecutePermissionErr    = -2409;
  {$EXTERNALSYM kernelDeletePermissionErr}
  kernelDeletePermissionErr     = -2410;
  {$EXTERNALSYM kernelExecutionLevelErr}
  kernelExecutionLevelErr       = -2411;
  {$EXTERNALSYM kernelAttributeErr}
  kernelAttributeErr            = -2412;
  {$EXTERNALSYM kernelAsyncSendLimitErr}
  kernelAsyncSendLimitErr       = -2413;
  {$EXTERNALSYM kernelAsyncReceiveLimitErr}
  kernelAsyncReceiveLimitErr    = -2414;
  {$EXTERNALSYM kernelTimeoutErr}
  kernelTimeoutErr              = -2415;
  {$EXTERNALSYM kernelInUseErr}
  kernelInUseErr                = -2416;
  {$EXTERNALSYM kernelTerminatedErr}
  kernelTerminatedErr           = -2417;
  {$EXTERNALSYM kernelExceptionErr}
  kernelExceptionErr            = -2418;
  {$EXTERNALSYM kernelIDErr}
  kernelIDErr                   = -2419;
  {$EXTERNALSYM kernelAlreadyFreeErr}
  kernelAlreadyFreeErr          = -2421;
  {$EXTERNALSYM kernelReturnValueErr}
  kernelReturnValueErr          = -2422;
  {$EXTERNALSYM kernelUnrecoverableErr}
  kernelUnrecoverableErr        = -2499;
//};



//enum {
                                        //* Text Services Mgr error codes */
  {$EXTERNALSYM tsmComponentNoErr}
  tsmComponentNoErr             = 0;    //* component result = no error */
  {$EXTERNALSYM tsmUnsupScriptLanguageErr}
  tsmUnsupScriptLanguageErr     = -2500;
  {$EXTERNALSYM tsmInputMethodNotFoundErr}
  tsmInputMethodNotFoundErr     = -2501;
  {$EXTERNALSYM tsmNotAnAppErr}
  tsmNotAnAppErr                = -2502; //* not an application error */
  {$EXTERNALSYM tsmAlreadyRegisteredErr}
  tsmAlreadyRegisteredErr       = -2503; //* want to register again error */
  {$EXTERNALSYM tsmNeverRegisteredErr}
  tsmNeverRegisteredErr         = -2504; //* app never registered error (not TSM aware) */
  {$EXTERNALSYM tsmInvalidDocIDErr}
  tsmInvalidDocIDErr            = -2505; //* invalid TSM documentation id */
  {$EXTERNALSYM tsmTSMDocBusyErr}
  tsmTSMDocBusyErr              = -2506; //* document is still active */
  {$EXTERNALSYM tsmDocNotActiveErr}
  tsmDocNotActiveErr            = -2507; //* document is NOT active */
  {$EXTERNALSYM tsmNoOpenTSErr}
  tsmNoOpenTSErr                = -2508; //* no open text service */
  {$EXTERNALSYM tsmCantOpenComponentErr}
  tsmCantOpenComponentErr       = -2509; //* can’t open the component */
  {$EXTERNALSYM tsmTextServiceNotFoundErr}
  tsmTextServiceNotFoundErr     = -2510; //* no text service found */
  {$EXTERNALSYM tsmDocumentOpenErr}
  tsmDocumentOpenErr            = -2511; //* there are open documents */
  {$EXTERNALSYM tsmUseInputWindowErr}
  tsmUseInputWindowErr          = -2512; //* not TSM aware because we are using input window */
  {$EXTERNALSYM tsmTSHasNoMenuErr}
  tsmTSHasNoMenuErr             = -2513; //* the text service has no menu */
  {$EXTERNALSYM tsmTSNotOpenErr}
  tsmTSNotOpenErr               = -2514; //* text service is not open */
  {$EXTERNALSYM tsmComponentAlreadyOpenErr}
  tsmComponentAlreadyOpenErr    = -2515; //* text service already opened for the document */
  {$EXTERNALSYM tsmInputMethodIsOldErr}
  tsmInputMethodIsOldErr        = -2516; //* returned by GetDefaultInputMethod */
  {$EXTERNALSYM tsmScriptHasNoIMErr}
  tsmScriptHasNoIMErr           = -2517; //* script has no imput method or is using old IM */
  {$EXTERNALSYM tsmUnsupportedTypeErr}
  tsmUnsupportedTypeErr         = -2518; //* unSupported interface type error */
  {$EXTERNALSYM tsmUnknownErr}
  tsmUnknownErr                 = -2519; //* any other errors */
  {$EXTERNALSYM tsmInvalidContext}
  tsmInvalidContext             = -2520; //* Invalid TSMContext specified in call */
  {$EXTERNALSYM tsmNoHandler}
  tsmNoHandler                  = -2521; //* No Callback Handler exists for callback */
  {$EXTERNALSYM tsmNoMoreTokens}
  tsmNoMoreTokens               = -2522; //* No more tokens are available for the source text */
  {$EXTERNALSYM tsmNoStem}
  tsmNoStem                     = -2523; //* No stem exists for the token */
  {$EXTERNALSYM tsmDefaultIsNotInputMethodErr}
  tsmDefaultIsNotInputMethodErr = -2524; //* Current Input source is KCHR or uchr, not Input Method  (GetDefaultInputMethod) */
  {$EXTERNALSYM tsmDocPropertyNotFoundErr}
  tsmDocPropertyNotFoundErr     = -2528; //* Requested TSM Document property not found */
  {$EXTERNALSYM tsmDocPropertyBufferTooSmallErr}
  tsmDocPropertyBufferTooSmallErr = -2529; //* Buffer passed in for property value is too small */
  {$EXTERNALSYM tsmCantChangeForcedClassStateErr}
  tsmCantChangeForcedClassStateErr = -2530; //* Enabled state of a TextService class has been forced and cannot be changed */
  {$EXTERNALSYM tsmComponentPropertyUnsupportedErr}
  tsmComponentPropertyUnsupportedErr = -2531; //* Component property unsupported (or failed to be set) */
  {$EXTERNALSYM tsmComponentPropertyNotFoundErr}
  tsmComponentPropertyNotFoundErr = -2532; //* Component property not found */
  {$EXTERNALSYM tsmInputModeChangeFailedErr}
  tsmInputModeChangeFailedErr   = -2533; //* Input Mode not changed */
//};


//enum {
                                        //* Mixed Mode error codes */
  {$EXTERNALSYM mmInternalError}
  mmInternalError               = -2526;
//};

//* NameRegistry error codes */
//enum {
  {$EXTERNALSYM nrLockedErr}
  nrLockedErr                   = -2536;
  {$EXTERNALSYM nrNotEnoughMemoryErr}
  nrNotEnoughMemoryErr          = -2537;
  {$EXTERNALSYM nrInvalidNodeErr}
  nrInvalidNodeErr              = -2538;
  {$EXTERNALSYM nrNotFoundErr}
  nrNotFoundErr                 = -2539;
  {$EXTERNALSYM nrNotCreatedErr}
  nrNotCreatedErr               = -2540;
  {$EXTERNALSYM nrNameErr}
  nrNameErr                     = -2541;
  {$EXTERNALSYM nrNotSlotDeviceErr}
  nrNotSlotDeviceErr            = -2542;
  {$EXTERNALSYM nrDataTruncatedErr}
  nrDataTruncatedErr            = -2543;
  {$EXTERNALSYM nrPowerErr}
  nrPowerErr                    = -2544;
  {$EXTERNALSYM nrPowerSwitchAbortErr}
  nrPowerSwitchAbortErr         = -2545;
  {$EXTERNALSYM nrTypeMismatchErr}
  nrTypeMismatchErr             = -2546;
  {$EXTERNALSYM nrNotModifiedErr}
  nrNotModifiedErr              = -2547;
  {$EXTERNALSYM nrOverrunErr}
  nrOverrunErr                  = -2548;
  {$EXTERNALSYM nrResultCodeBase}
  nrResultCodeBase              = -2549;
  {$EXTERNALSYM nrPathNotFound}
  nrPathNotFound                = -2550; //* a path component lookup failed */
  {$EXTERNALSYM nrPathBufferTooSmall}
  nrPathBufferTooSmall          = -2551; //* buffer for path is too small */
  {$EXTERNALSYM nrInvalidEntryIterationOp}
  nrInvalidEntryIterationOp     = -2552; //* invalid entry iteration operation */
  {$EXTERNALSYM nrPropertyAlreadyExists}
  nrPropertyAlreadyExists       = -2553; //* property already exists */
  {$EXTERNALSYM nrIterationDone}
  nrIterationDone               = -2554; //* iteration operation is done */
  {$EXTERNALSYM nrExitedIteratorScope}
  nrExitedIteratorScope         = -2555; //* outer scope of iterator was exited */
  {$EXTERNALSYM nrTransactionAborted}
  nrTransactionAborted          = -2556; //* transaction was aborted */
  {$EXTERNALSYM nrCallNotSupported}
  nrCallNotSupported            = -2557; //* This call is not available or supported on this machine */
//};

//* Icon Services error codes */
//enum {
  {$EXTERNALSYM invalidIconRefErr}
  invalidIconRefErr             = -2580; //* The icon ref is not valid */
  {$EXTERNALSYM noSuchIconErr}
  noSuchIconErr                 = -2581; //* The requested icon could not be found */
  {$EXTERNALSYM noIconDataAvailableErr}
  noIconDataAvailableErr        = -2582; //* The necessary icon data is not available */
//};


{*
    Dynamic AppleScript errors:

    These errors result from data-dependent conditions and are typically
    signaled at runtime.
*}
//enum {
  {$EXTERNALSYM errOSACantCoerce}
  errOSACantCoerce              = errAECoercionFail; //* Signaled when a value can't be coerced to the desired type. */
  {$EXTERNALSYM errOSACantAccess}
  errOSACantAccess              = errAENoSuchObject; //* Signaled when an object is not found in a container*/
  {$EXTERNALSYM errOSACantAssign}
  errOSACantAssign              = -10006; //* Signaled when an object cannot be set in a container.*/
  {$EXTERNALSYM errOSAGeneralError}
  errOSAGeneralError            = -2700; //* Signaled by user scripts or applications when no actual error code is to be returned.*/
  {$EXTERNALSYM errOSADivideByZero}
  errOSADivideByZero            = -2701; //* Signaled when there is an attempt to divide by zero*/
  {$EXTERNALSYM errOSANumericOverflow}
  errOSANumericOverflow         = -2702; //* Signaled when integer or real value is too large to be represented*/
  {$EXTERNALSYM errOSACantLaunch}
  errOSACantLaunch              = -2703; //* Signaled when application can't be launched or when it is remote and program linking is not enabled*/
  {$EXTERNALSYM errOSAAppNotHighLevelEventAware}
  errOSAAppNotHighLevelEventAware = -2704; //* Signaled when an application can't respond to AppleEvents*/
  {$EXTERNALSYM errOSACorruptTerminology}
  errOSACorruptTerminology      = -2705; //* Signaled when an application's terminology resource is not readable*/
  {$EXTERNALSYM errOSAStackOverflow}
  errOSAStackOverflow           = -2706; //* Signaled when the runtime stack overflows*/
  {$EXTERNALSYM errOSAInternalTableOverflow}
  errOSAInternalTableOverflow   = -2707; //* Signaled when a runtime internal data structure overflows*/
  {$EXTERNALSYM errOSADataBlockTooLarge}
  errOSADataBlockTooLarge       = -2708; //* Signaled when an intrinsic limitation is exceeded for the size of a value or data structure.*/
  {$EXTERNALSYM errOSACantGetTerminology}
  errOSACantGetTerminology      = -2709;
  {$EXTERNALSYM errOSACantCreate}
  errOSACantCreate              = -2710;
//};

{*
    Component-specific dynamic script errors:

    The range -2720 thru -2739 is reserved for component-specific runtime errors.
    (Note that error codes from different scripting components in this range will
    overlap.)
*}
{*
    Static AppleScript errors:

    These errors comprise what are commonly thought of as parse and compile-
    time errors.  However, in a dynamic system (e.g. AppleScript) any or all
    of these may also occur at runtime.
*}
//enum {
  {$EXTERNALSYM errOSATypeError}
  errOSATypeError               = errAEWrongDataType;
  {$EXTERNALSYM OSAMessageNotUnderstood}
  OSAMessageNotUnderstood       = errAEEventNotHandled; //* Signaled when a message was sent to an object that didn't handle it*/
  {$EXTERNALSYM OSAUndefinedHandler}
  OSAUndefinedHandler           = errAEHandlerNotFound; //* Signaled when a function to be returned doesn't exist. */
  {$EXTERNALSYM OSAIllegalAccess}
  OSAIllegalAccess              = errAEAccessorNotFound; //* Signaled when a container can never have the requested object*/
  {$EXTERNALSYM OSAIllegalIndex}
  OSAIllegalIndex               = errAEIllegalIndex; //* Signaled when index was out of range. Specialization of errOSACantAccess*/
  {$EXTERNALSYM OSAIllegalRange}
  OSAIllegalRange               = errAEImpossibleRange; //* Signaled when a range is screwy. Specialization of errOSACantAccess*/
  {$EXTERNALSYM OSAIllegalAssign}
  OSAIllegalAssign              = -10003; //* Signaled when an object can never be set in a container*/
  {$EXTERNALSYM OSASyntaxError}
  OSASyntaxError                = -2740; //* Signaled when a syntax error occurs. (e.g. "Syntax error" or "<this> can't go after <that>")*/
  {$EXTERNALSYM OSASyntaxTypeError}
  OSASyntaxTypeError            = -2741; //* Signaled when another form of syntax was expected. (e.g. "expected a <type> but found <this>")*/
  {$EXTERNALSYM OSATokenTooLong}
  OSATokenTooLong               = -2742; //* Signaled when a name or number is too long to be parsed*/
  {$EXTERNALSYM OSAMissingParameter}
  OSAMissingParameter           = errAEDescNotFound; //* Signaled when a parameter is missing for a function invocation*/
  {$EXTERNALSYM OSAParameterMismatch}
  OSAParameterMismatch          = errAEWrongNumberArgs; //* Signaled when function is called with the wrong number of parameters, or a parameter pattern cannot be matched*/
  {$EXTERNALSYM OSADuplicateParameter}
  OSADuplicateParameter         = -2750; //* Signaled when a formal parameter, local variable, or instance variable is specified more than once*/
  {$EXTERNALSYM OSADuplicateProperty}
  OSADuplicateProperty          = -2751; //* Signaled when a formal parameter, local variable, or instance variable is specified more than once.*/
  {$EXTERNALSYM OSADuplicateHandler}
  OSADuplicateHandler           = -2752; //* Signaled when more than one handler is defined with the same name in a scope where the language doesn't allow it*/
  {$EXTERNALSYM OSAUndefinedVariable}
  OSAUndefinedVariable          = -2753; //* Signaled when a variable is accessed that has no value*/
  {$EXTERNALSYM OSAInconsistentDeclarations}
  OSAInconsistentDeclarations   = -2754; //* Signaled when a variable is declared inconsistently in the same scope, such as both local and global*/
  {$EXTERNALSYM OSAControlFlowError}
  OSAControlFlowError           = -2755; //* Signaled when illegal control flow occurs in an application (no catcher for throw, non-lexical loop exit, etc.)*/
//};

{*
    Component-specific AppleScript static errors:

    The range -2760 thru -2779 is reserved for component-specific parsing and
    compile-time errors. (Note that error codes from different scripting
    components in this range will overlap.)
*}
{*
    Dialect-specific AppleScript errors:

    The range -2780 thru -2799 is reserved for dialect specific error codes for
    scripting components that support dialects. (Note that error codes from
    different scripting components in this range will overlap, as well as error
    codes from different dialects in the same scripting component.)
*}

//**************************************************************************
//    Apple Script Error Codes
//**************************************************************************/
//* Runtime errors: */
//enum {
  {$EXTERNALSYM errASCantConsiderAndIgnore}
  errASCantConsiderAndIgnore    = -2720;
  {$EXTERNALSYM errASCantCompareMoreThan32k}
  errASCantCompareMoreThan32k   = -2721; //* Parser/Compiler errors: */
  {$EXTERNALSYM errASTerminologyNestingTooDeep}
  errASTerminologyNestingTooDeep = -2760;
  {$EXTERNALSYM errASIllegalFormalParameter}
  errASIllegalFormalParameter   = -2761;
  {$EXTERNALSYM errASParameterNotForEvent}
  errASParameterNotForEvent     = -2762;
  {$EXTERNALSYM errASNoResultReturned}
  errASNoResultReturned         = -2763; //*    The range -2780 thru -2799 is reserved for dialect specific error codes. (Error codes from different dialects may overlap.) */
  {$EXTERNALSYM errASInconsistentNames}
  errASInconsistentNames        = -2780; //*    English errors: */
//};


//* The preferred spelling for Code Fragment Manager errors:*/
//enum {
  {$EXTERNALSYM cfragFirstErrCode}
  cfragFirstErrCode             = -2800; //* The first value in the range of CFM errors.*/
  {$EXTERNALSYM cfragContextIDErr}
  cfragContextIDErr             = -2800; //* The context ID was not valid.*/
  {$EXTERNALSYM cfragConnectionIDErr}
  cfragConnectionIDErr          = -2801; //* The connection ID was not valid.*/
  {$EXTERNALSYM cfragNoSymbolErr}
  cfragNoSymbolErr              = -2802; //* The specified symbol was not found.*/
  {$EXTERNALSYM cfragNoSectionErr}
  cfragNoSectionErr             = -2803; //* The specified section was not found.*/
  {$EXTERNALSYM cfragNoLibraryErr}
  cfragNoLibraryErr             = -2804; //* The named library was not found.*/
  {$EXTERNALSYM cfragDupRegistrationErr}
  cfragDupRegistrationErr       = -2805; //* The registration name was already in use.*/
  {$EXTERNALSYM cfragFragmentFormatErr}
  cfragFragmentFormatErr        = -2806; //* A fragment's container format is unknown.*/
  {$EXTERNALSYM cfragUnresolvedErr}
  cfragUnresolvedErr            = -2807; //* A fragment had "hard" unresolved imports.*/
  {$EXTERNALSYM cfragNoPositionErr}
  cfragNoPositionErr            = -2808; //* The registration insertion point was not found.*/
  {$EXTERNALSYM cfragNoPrivateMemErr}
  cfragNoPrivateMemErr          = -2809; //* Out of memory for internal bookkeeping.*/
  {$EXTERNALSYM cfragNoClientMemErr}
  cfragNoClientMemErr           = -2810; //* Out of memory for fragment mapping or section instances.*/
  {$EXTERNALSYM cfragNoIDsErr}
  cfragNoIDsErr                 = -2811; //* No more CFM IDs for contexts, connections, etc.*/
  {$EXTERNALSYM cfragInitOrderErr}
  cfragInitOrderErr             = -2812; //* */
  {$EXTERNALSYM cfragImportTooOldErr}
  cfragImportTooOldErr          = -2813; //* An import library was too old for a client.*/
  {$EXTERNALSYM cfragImportTooNewErr}
  cfragImportTooNewErr          = -2814; //* An import library was too new for a client.*/
  {$EXTERNALSYM cfragInitLoopErr}
  cfragInitLoopErr              = -2815; //* Circularity in required initialization order.*/
  {$EXTERNALSYM cfragInitAtBootErr}
  cfragInitAtBootErr            = -2816; //* A boot library has an initialization function.  (System 7 only)*/
  {$EXTERNALSYM cfragLibConnErr}
  cfragLibConnErr               = -2817; //* */
  {$EXTERNALSYM cfragCFMStartupErr}
  cfragCFMStartupErr            = -2818; //* Internal error during CFM initialization.*/
  {$EXTERNALSYM cfragCFMInternalErr}
  cfragCFMInternalErr           = -2819; //* An internal inconstistancy has been detected.*/
  {$EXTERNALSYM cfragFragmentCorruptErr}
  cfragFragmentCorruptErr       = -2820; //* A fragment's container was corrupt (known format).*/
  {$EXTERNALSYM cfragInitFunctionErr}
  cfragInitFunctionErr          = -2821; //* A fragment's initialization routine returned an error.*/
  {$EXTERNALSYM cfragNoApplicationErr}
  cfragNoApplicationErr         = -2822; //* No application member found in the cfrg resource.*/
  {$EXTERNALSYM cfragArchitectureErr}
  cfragArchitectureErr          = -2823; //* A fragment has an unacceptable architecture.*/
  {$EXTERNALSYM cfragFragmentUsageErr}
  cfragFragmentUsageErr         = -2824; //* A semantic error in usage of the fragment.*/
  {$EXTERNALSYM cfragFileSizeErr}
  cfragFileSizeErr              = -2825; //* A file was too large to be mapped.*/
  {$EXTERNALSYM cfragNotClosureErr}
  cfragNotClosureErr            = -2826; //* The closure ID was actually a connection ID.*/
  {$EXTERNALSYM cfragNoRegistrationErr}
  cfragNoRegistrationErr        = -2827; //* The registration name was not found.*/
  {$EXTERNALSYM cfragContainerIDErr}
  cfragContainerIDErr           = -2828; //* The fragment container ID was not valid.*/
  {$EXTERNALSYM cfragClosureIDErr}
  cfragClosureIDErr             = -2829; //* The closure ID was not valid.*/
  {$EXTERNALSYM cfragAbortClosureErr}
  cfragAbortClosureErr          = -2830; //* Used by notification handlers to abort a closure.*/
  {$EXTERNALSYM cfragOutputLengthErr}
  cfragOutputLengthErr          = -2831; //* An output parameter is too small to hold the value.*/
  {$EXTERNALSYM cfragMapFileErr}
  cfragMapFileErr               = -2851; //* A file could not be mapped.*/
  {$EXTERNALSYM cfragExecFileRefErr}
  cfragExecFileRefErr           = -2854; //* Bundle does not have valid executable file.*/
  {$EXTERNALSYM cfragStdFolderErr}
  cfragStdFolderErr             = -2855; //* Could not find standard CFM folder.*/
  {$EXTERNALSYM cfragRsrcForkErr}
  cfragRsrcForkErr              = -2856; //* Resource fork could not be opened.*/
  {$EXTERNALSYM cfragCFragRsrcErr}
  cfragCFragRsrcErr             = -2857; //* 'cfrg' resource could not be loaded.*/
  {$EXTERNALSYM cfragLastErrCode}
  cfragLastErrCode              = -2899; //* The last value in the range of CFM errors.*/
//};

//enum {
                                        //* Reserved values for internal "warnings".*/
  {$EXTERNALSYM cfragFirstReservedCode}
  cfragFirstReservedCode        = -2897;
  {$EXTERNALSYM cfragReservedCode_3}
  cfragReservedCode_3           = -2897;
  {$EXTERNALSYM cfragReservedCode_2}
  cfragReservedCode_2           = -2898;
  {$EXTERNALSYM cfragReservedCode_1}
  cfragReservedCode_1           = -2899;
//};

//#if OLDROUTINENAMES
//* The old spelling for Code Fragment Manager errors, kept for compatibility:*/
//enum {
  {$EXTERNALSYM fragContextNotFound}
  fragContextNotFound           = cfragContextIDErr;
  {$EXTERNALSYM fragConnectionIDNotFound}
  fragConnectionIDNotFound      = cfragConnectionIDErr;
  {$EXTERNALSYM fragSymbolNotFound}
  fragSymbolNotFound            = cfragNoSymbolErr;
  {$EXTERNALSYM fragSectionNotFound}
  fragSectionNotFound           = cfragNoSectionErr;
  {$EXTERNALSYM fragLibNotFound}
  fragLibNotFound               = cfragNoLibraryErr;
  {$EXTERNALSYM fragDupRegLibName}
  fragDupRegLibName             = cfragDupRegistrationErr;
  {$EXTERNALSYM fragFormatUnknown}
  fragFormatUnknown             = cfragFragmentFormatErr;
  {$EXTERNALSYM fragHadUnresolveds}
  fragHadUnresolveds            = cfragUnresolvedErr;
  {$EXTERNALSYM fragNoMem}
  fragNoMem                     = cfragNoPrivateMemErr;
  {$EXTERNALSYM fragNoAddrSpace}
  fragNoAddrSpace               = cfragNoClientMemErr;
  {$EXTERNALSYM fragNoContextIDs}
  fragNoContextIDs              = cfragNoIDsErr;
  {$EXTERNALSYM fragObjectInitSeqErr}
  fragObjectInitSeqErr          = cfragInitOrderErr;
  {$EXTERNALSYM fragImportTooOld}
  fragImportTooOld              = cfragImportTooOldErr;
  {$EXTERNALSYM fragImportTooNew}
  fragImportTooNew              = cfragImportTooNewErr;
  {$EXTERNALSYM fragInitLoop}
  fragInitLoop                  = cfragInitLoopErr;
  {$EXTERNALSYM fragInitRtnUsageErr}
  fragInitRtnUsageErr           = cfragInitAtBootErr;
  {$EXTERNALSYM fragLibConnErr}
  fragLibConnErr                = cfragLibConnErr;
  {$EXTERNALSYM fragMgrInitErr}
  fragMgrInitErr                = cfragCFMStartupErr;
  {$EXTERNALSYM fragConstErr}
  fragConstErr                  = cfragCFMInternalErr;
  {$EXTERNALSYM fragCorruptErr}
  fragCorruptErr                = cfragFragmentCorruptErr;
  {$EXTERNALSYM fragUserInitProcErr}
  fragUserInitProcErr           = cfragInitFunctionErr;
  {$EXTERNALSYM fragAppNotFound}
  fragAppNotFound               = cfragNoApplicationErr;
  {$EXTERNALSYM fragArchError}
  fragArchError                 = cfragArchitectureErr;
  {$EXTERNALSYM fragInvalidFragmentUsage}
  fragInvalidFragmentUsage      = cfragFragmentUsageErr;
  {$EXTERNALSYM fragLastErrCode}
  fragLastErrCode               = cfragLastErrCode;
//};

//#endif  /* OLDROUTINENAMES */

//*Component Manager & component errors*/
//enum {
  {$EXTERNALSYM invalidComponentID}
  invalidComponentID            = -3000;
  {$EXTERNALSYM validInstancesExist}
  validInstancesExist           = -3001;
  {$EXTERNALSYM componentNotCaptured}
  componentNotCaptured          = -3002;
  {$EXTERNALSYM componentDontRegister}
  componentDontRegister         = -3003;
  {$EXTERNALSYM unresolvedComponentDLLErr}
  unresolvedComponentDLLErr     = -3004;
  {$EXTERNALSYM retryComponentRegistrationErr}
  retryComponentRegistrationErr = -3005;
//};

//*Translation manager & Translation components*/
//enum {
  {$EXTERNALSYM invalidTranslationPathErr}
  invalidTranslationPathErr     = -3025; //*Source type to destination type not a valid path*/
  {$EXTERNALSYM couldNotParseSourceFileErr}
  couldNotParseSourceFileErr    = -3026; //*Source document does not contain source type*/
  {$EXTERNALSYM noTranslationPathErr}
  noTranslationPathErr          = -3030;
  {$EXTERNALSYM badTranslationSpecErr}
  badTranslationSpecErr         = -3031;
  {$EXTERNALSYM noPrefAppErr}
  noPrefAppErr                  = -3032;
//};

//enum {
  {$EXTERNALSYM buf2SmallErr}
  buf2SmallErr                  = -3101;
  {$EXTERNALSYM noMPPErr}
  noMPPErr                      = -3102;
  {$EXTERNALSYM ckSumErr}
  ckSumErr                      = -3103;
  {$EXTERNALSYM extractErr}
  extractErr                    = -3104;
  {$EXTERNALSYM readQErr}
  readQErr                      = -3105;
  {$EXTERNALSYM atpLenErr}
  atpLenErr                     = -3106;
  {$EXTERNALSYM atpBadRsp}
  atpBadRsp                     = -3107;
  {$EXTERNALSYM recNotFnd}
  recNotFnd                     = -3108;
  {$EXTERNALSYM sktClosedErr}
  sktClosedErr                  = -3109;
//};


//* OpenTransport errors*/
//enum {
  {$EXTERNALSYM kOTNoError}
  kOTNoError                    = 0;    //* No Error occurred                    */
  {$EXTERNALSYM kOTOutOfMemoryErr}
  kOTOutOfMemoryErr             = -3211; //* OT ran out of memory, may be a temporary      */
  {$EXTERNALSYM kOTNotFoundErr}
  kOTNotFoundErr                = -3201; //* OT generic not found error               */
  {$EXTERNALSYM kOTDuplicateFoundErr}
  kOTDuplicateFoundErr          = -3216; //* OT generic duplicate found error             */
  {$EXTERNALSYM kOTBadAddressErr}
  kOTBadAddressErr              = -3150; //* XTI2OSStatus(TBADADDR) A Bad address was specified          */
  {$EXTERNALSYM kOTBadOptionErr}
  kOTBadOptionErr               = -3151; //* XTI2OSStatus(TBADOPT) A Bad option was specified             */
  {$EXTERNALSYM kOTAccessErr}
  kOTAccessErr                  = -3152; //* XTI2OSStatus(TACCES) Missing access permission           */
  {$EXTERNALSYM kOTBadReferenceErr}
  kOTBadReferenceErr            = -3153; //* XTI2OSStatus(TBADF) Bad provider reference               */
  {$EXTERNALSYM kOTNoAddressErr}
  kOTNoAddressErr               = -3154; //* XTI2OSStatus(TNOADDR) No address was specified           */
  {$EXTERNALSYM kOTOutStateErr}
  kOTOutStateErr                = -3155; //* XTI2OSStatus(TOUTSTATE) Call issued in wrong state           */
  {$EXTERNALSYM kOTBadSequenceErr}
  kOTBadSequenceErr             = -3156; //* XTI2OSStatus(TBADSEQ) Sequence specified does not exist         */
  {$EXTERNALSYM kOTSysErrorErr}
  kOTSysErrorErr                = -3157; //* XTI2OSStatus(TSYSERR) A system error occurred            */
  {$EXTERNALSYM kOTLookErr}
  kOTLookErr                    = -3158; //* XTI2OSStatus(TLOOK) An event occurred - call Look()         */
  {$EXTERNALSYM kOTBadDataErr}
  kOTBadDataErr                 = -3159; //* XTI2OSStatus(TBADDATA) An illegal amount of data was specified */
  {$EXTERNALSYM kOTBufferOverflowErr}
  kOTBufferOverflowErr          = -3160; //* XTI2OSStatus(TBUFOVFLW) Passed buffer not big enough          */
  {$EXTERNALSYM kOTFlowErr}
  kOTFlowErr                    = -3161; //* XTI2OSStatus(TFLOW) Provider is flow-controlled          */
  {$EXTERNALSYM kOTNoDataErr}
  kOTNoDataErr                  = -3162; //* XTI2OSStatus(TNODATA) No data available for reading          */
  {$EXTERNALSYM kOTNoDisconnectErr}
  kOTNoDisconnectErr            = -3163; //* XTI2OSStatus(TNODIS) No disconnect indication available         */
  {$EXTERNALSYM kOTNoUDErrErr}
  kOTNoUDErrErr                 = -3164; //* XTI2OSStatus(TNOUDERR) No Unit Data Error indication available */
  {$EXTERNALSYM kOTBadFlagErr}
  kOTBadFlagErr                 = -3165; //* XTI2OSStatus(TBADFLAG) A Bad flag value was supplied          */
  {$EXTERNALSYM kOTNoReleaseErr}
  kOTNoReleaseErr               = -3166; //* XTI2OSStatus(TNOREL) No orderly release indication available   */
  {$EXTERNALSYM kOTNotSupportedErr}
  kOTNotSupportedErr            = -3167; //* XTI2OSStatus(TNOTSUPPORT) Command is not supported           */
  {$EXTERNALSYM kOTStateChangeErr}
  kOTStateChangeErr             = -3168; //* XTI2OSStatus(TSTATECHNG) State is changing - try again later     */
  {$EXTERNALSYM kOTNoStructureTypeErr}
  kOTNoStructureTypeErr         = -3169; //* XTI2OSStatus(TNOSTRUCTYPE) Bad structure type requested for OTAlloc    */
  {$EXTERNALSYM kOTBadNameErr}
  kOTBadNameErr                 = -3170; //* XTI2OSStatus(TBADNAME) A bad endpoint name was supplied         */
  {$EXTERNALSYM kOTBadQLenErr}
  kOTBadQLenErr                 = -3171; //* XTI2OSStatus(TBADQLEN) A Bind to an in-use addr with qlen > 0   */
  {$EXTERNALSYM kOTAddressBusyErr}
  kOTAddressBusyErr             = -3172; //* XTI2OSStatus(TADDRBUSY) Address requested is already in use       */
  {$EXTERNALSYM kOTIndOutErr}
  kOTIndOutErr                  = -3173; //* XTI2OSStatus(TINDOUT) Accept failed because of pending listen  */
  {$EXTERNALSYM kOTProviderMismatchErr}
  kOTProviderMismatchErr        = -3174; //* XTI2OSStatus(TPROVMISMATCH) Tried to accept on incompatible endpoint   */
  {$EXTERNALSYM kOTResQLenErr}
  kOTResQLenErr                 = -3175; //* XTI2OSStatus(TRESQLEN)                            */
  {$EXTERNALSYM kOTResAddressErr}
  kOTResAddressErr              = -3176; //* XTI2OSStatus(TRESADDR)                            */
  {$EXTERNALSYM kOTQFullErr}
  kOTQFullErr                   = -3177; //* XTI2OSStatus(TQFULL)                          */
  {$EXTERNALSYM kOTProtocolErr}
  kOTProtocolErr                = -3178; //* XTI2OSStatus(TPROTO) An unspecified provider error occurred       */
  {$EXTERNALSYM kOTBadSyncErr}
  kOTBadSyncErr                 = -3179; //* XTI2OSStatus(TBADSYNC) A synchronous call at interrupt time       */
  {$EXTERNALSYM kOTCanceledErr}
  kOTCanceledErr                = -3180; //* XTI2OSStatus(TCANCELED) The command was cancelled            */
  {$EXTERNALSYM kEPERMErr}
  kEPERMErr                     = -3200; //* Permission denied            */
  {$EXTERNALSYM kENOENTErr}
  kENOENTErr                    = -3201; //* No such file or directory       */
  {$EXTERNALSYM kENORSRCErr}
  kENORSRCErr                   = -3202; //* No such resource               */
  {$EXTERNALSYM kEINTRErr}
  kEINTRErr                     = -3203; //* Interrupted system service        */
  {$EXTERNALSYM kEIOErr}
  kEIOErr                       = -3204; //* I/O error                 */
  {$EXTERNALSYM kENXIOErr}
  kENXIOErr                     = -3205; //* No such device or address       */
  {$EXTERNALSYM kEBADFErr}
  kEBADFErr                     = -3208; //* Bad file number                 */
  {$EXTERNALSYM kEAGAINErr}
  kEAGAINErr                    = -3210; //* Try operation again later       */
  {$EXTERNALSYM kENOMEMErr}
  kENOMEMErr                    = -3211; //* Not enough space               */
  {$EXTERNALSYM kEACCESErr}
  kEACCESErr                    = -3212; //* Permission denied            */
  {$EXTERNALSYM kEFAULTErr}
  kEFAULTErr                    = -3213; //* Bad address                   */
  {$EXTERNALSYM kEBUSYErr}
  kEBUSYErr                     = -3215; //* Device or resource busy          */
  {$EXTERNALSYM kEEXISTErr}
  kEEXISTErr                    = -3216; //* File exists                   */
  {$EXTERNALSYM kENODEVErr}
  kENODEVErr                    = -3218; //* No such device               */
  {$EXTERNALSYM kEINVALErr}
  kEINVALErr                    = -3221; //* Invalid argument               */
  {$EXTERNALSYM kENOTTYErr}
  kENOTTYErr                    = -3224; //* Not a character device          */
  {$EXTERNALSYM kEPIPEErr}
  kEPIPEErr                     = -3231; //* Broken pipe                   */
  {$EXTERNALSYM kERANGEErr}
  kERANGEErr                    = -3233; //* Message size too large for STREAM  */
  {$EXTERNALSYM kEWOULDBLOCKErr}
  kEWOULDBLOCKErr               = -3234; //* Call would block, so was aborted     */
  {$EXTERNALSYM kEDEADLKErr}
  kEDEADLKErr                   = -3234; //* or a deadlock would occur       */
  {$EXTERNALSYM kEALREADYErr}
  kEALREADYErr                  = -3236; //*                          */
  {$EXTERNALSYM kENOTSOCKErr}
  kENOTSOCKErr                  = -3237; //* Socket operation on non-socket     */
  {$EXTERNALSYM kEDESTADDRREQErr}
  kEDESTADDRREQErr              = -3238; //* Destination address required      */
  {$EXTERNALSYM kEMSGSIZEErr}
  kEMSGSIZEErr                  = -3239; //* Message too long               */
  {$EXTERNALSYM kEPROTOTYPEErr}
  kEPROTOTYPEErr                = -3240; //* Protocol wrong type for socket     */
  {$EXTERNALSYM kENOPROTOOPTErr}
  kENOPROTOOPTErr               = -3241; //* Protocol not available          */
  {$EXTERNALSYM kEPROTONOSUPPORTErr}
  kEPROTONOSUPPORTErr           = -3242; //* Protocol not supported          */
  {$EXTERNALSYM kESOCKTNOSUPPORTErr}
  kESOCKTNOSUPPORTErr           = -3243; //* Socket type not supported       */
  {$EXTERNALSYM kEOPNOTSUPPErr}
  kEOPNOTSUPPErr                = -3244; //* Operation not supported on socket  */
  {$EXTERNALSYM kEADDRINUSEErr}
  kEADDRINUSEErr                = -3247; //* Address already in use          */
  {$EXTERNALSYM kEADDRNOTAVAILErr}
  kEADDRNOTAVAILErr             = -3248; //* Can't assign requested address     */
  {$EXTERNALSYM kENETDOWNErr}
  kENETDOWNErr                  = -3249; //* Network is down                 */
  {$EXTERNALSYM kENETUNREACHErr}
  kENETUNREACHErr               = -3250; //* Network is unreachable          */
  {$EXTERNALSYM kENETRESETErr}
  kENETRESETErr                 = -3251; //* Network dropped connection on reset    */
  {$EXTERNALSYM kECONNABORTEDErr}
  kECONNABORTEDErr              = -3252; //* Software caused connection abort     */
  {$EXTERNALSYM kECONNRESETErr}
  kECONNRESETErr                = -3253; //* Connection reset by peer          */
  {$EXTERNALSYM kENOBUFSErr}
  kENOBUFSErr                   = -3254; //* No buffer space available       */
  {$EXTERNALSYM kEISCONNErr}
  kEISCONNErr                   = -3255; //* Socket is already connected         */
  {$EXTERNALSYM kENOTCONNErr}
  kENOTCONNErr                  = -3256; //* Socket is not connected          */
  {$EXTERNALSYM kESHUTDOWNErr}
  kESHUTDOWNErr                 = -3257; //* Can't send after socket shutdown     */
  {$EXTERNALSYM kETOOMANYREFSErr}
  kETOOMANYREFSErr              = -3258; //* Too many references: can't splice  */
  {$EXTERNALSYM kETIMEDOUTErr}
  kETIMEDOUTErr                 = -3259; //* Connection timed out             */
  {$EXTERNALSYM kECONNREFUSEDErr}
  kECONNREFUSEDErr              = -3260; //* Connection refused           */
  {$EXTERNALSYM kEHOSTDOWNErr}
  kEHOSTDOWNErr                 = -3263; //* Host is down                */
  {$EXTERNALSYM kEHOSTUNREACHErr}
  kEHOSTUNREACHErr              = -3264; //* No route to host               */
  {$EXTERNALSYM kEPROTOErr}
  kEPROTOErr                    = -3269; //* ••• fill out missing codes •••     */
  {$EXTERNALSYM kETIMEErr}
  kETIMEErr                     = -3270; //*                          */
  {$EXTERNALSYM kENOSRErr}
  kENOSRErr                     = -3271; //*                          */
  {$EXTERNALSYM kEBADMSGErr}
  kEBADMSGErr                   = -3272; //*                          */
  {$EXTERNALSYM kECANCELErr}
  kECANCELErr                   = -3273; //*                          */
  {$EXTERNALSYM kENOSTRErr}
  kENOSTRErr                    = -3274; //*                          */
  {$EXTERNALSYM kENODATAErr}
  kENODATAErr                   = -3275; //*                          */
  {$EXTERNALSYM kEINPROGRESSErr}
  kEINPROGRESSErr               = -3276; //*                          */
  {$EXTERNALSYM kESRCHErr}
  kESRCHErr                     = -3277; //*                          */
  {$EXTERNALSYM kENOMSGErr}
  kENOMSGErr                    = -3278; //*                          */
  {$EXTERNALSYM kOTClientNotInittedErr}
  kOTClientNotInittedErr        = -3279; //*                          */
  {$EXTERNALSYM kOTPortHasDiedErr}
  kOTPortHasDiedErr             = -3280; //*                          */
  {$EXTERNALSYM kOTPortWasEjectedErr}
  kOTPortWasEjectedErr          = -3281; //*                          */
  {$EXTERNALSYM kOTBadConfigurationErr}
  kOTBadConfigurationErr        = -3282; //*                          */
  {$EXTERNALSYM kOTConfigurationChangedErr}
  kOTConfigurationChangedErr    = -3283; //*                          */
  {$EXTERNALSYM kOTUserRequestedErr}
  kOTUserRequestedErr           = -3284; //*                          */
  {$EXTERNALSYM kOTPortLostConnection}
  kOTPortLostConnection         = -3285; //*                          */
//};


//* Additional Quickdraw errors in the assigned range -3950 .. -3999*/
//enum {
  {$EXTERNALSYM kQDNoPalette}
  kQDNoPalette                  = -3950; //* PaletteHandle is NULL*/
  {$EXTERNALSYM kQDNoColorHWCursorSupport}
  kQDNoColorHWCursorSupport     = -3951; //* CGSSystemSupportsColorHardwareCursors() returned false*/
  {$EXTERNALSYM kQDCursorAlreadyRegistered}
  kQDCursorAlreadyRegistered    = -3952; //* can be returned from QDRegisterNamedPixMapCursor()*/
  {$EXTERNALSYM kQDCursorNotRegistered}
  kQDCursorNotRegistered        = -3953; //* can be returned from QDSetNamedPixMapCursor()*/
  {$EXTERNALSYM kQDCorruptPICTDataErr}
  kQDCorruptPICTDataErr         = -3954;
//};



//* Color Picker errors*/
//enum {
  {$EXTERNALSYM firstPickerError}
  firstPickerError              = -4000;
  {$EXTERNALSYM invalidPickerType}
  invalidPickerType             = firstPickerError;
  {$EXTERNALSYM requiredFlagsDontMatch}
  requiredFlagsDontMatch        = -4001;
  {$EXTERNALSYM pickerResourceError}
  pickerResourceError           = -4002;
  {$EXTERNALSYM cantLoadPicker}
  cantLoadPicker                = -4003;
  {$EXTERNALSYM cantCreatePickerWindow}
  cantCreatePickerWindow        = -4004;
  {$EXTERNALSYM cantLoadPackage}
  cantLoadPackage               = -4005;
  {$EXTERNALSYM pickerCantLive}
  pickerCantLive                = -4006;
  {$EXTERNALSYM colorSyncNotInstalled}
  colorSyncNotInstalled         = -4007;
  {$EXTERNALSYM badProfileError}
  badProfileError               = -4008;
  {$EXTERNALSYM noHelpForItem}
  noHelpForItem                 = -4009;
//};



//* NSL error codes*/
//enum {
  {$EXTERNALSYM kNSL68kContextNotSupported}
  kNSL68kContextNotSupported    = -4170; //* no 68k allowed*/
  {$EXTERNALSYM kNSLSchedulerError}
  kNSLSchedulerError            = -4171; //* A custom thread routine encountered an error*/
  {$EXTERNALSYM kNSLBadURLSyntax}
  kNSLBadURLSyntax              = -4172; //* URL contains illegal characters*/
  {$EXTERNALSYM kNSLNoCarbonLib}
  kNSLNoCarbonLib               = -4173;
  {$EXTERNALSYM kNSLUILibraryNotAvailable}
  kNSLUILibraryNotAvailable     = -4174; //* The NSL UI Library needs to be in the Extensions Folder*/
  {$EXTERNALSYM kNSLNotImplementedYet}
  kNSLNotImplementedYet         = -4175;
  {$EXTERNALSYM kNSLErrNullPtrError}
  kNSLErrNullPtrError           = -4176;
  {$EXTERNALSYM kNSLSomePluginsFailedToLoad}
  kNSLSomePluginsFailedToLoad   = -4177; //* (one or more plugins failed to load, but at least one did load; this error isn't fatal)*/
  {$EXTERNALSYM kNSLNullNeighborhoodPtr}
  kNSLNullNeighborhoodPtr       = -4178; //* (client passed a null neighborhood ptr)*/
  {$EXTERNALSYM kNSLNoPluginsForSearch}
  kNSLNoPluginsForSearch        = -4179; //* (no plugins will respond to search request; bad protocol(s)?)*/
  {$EXTERNALSYM kNSLSearchAlreadyInProgress}
  kNSLSearchAlreadyInProgress   = -4180; //* (you can only have one ongoing search per clientRef)*/
  {$EXTERNALSYM kNSLNoPluginsFound}
  kNSLNoPluginsFound            = -4181; //* (manager didn't find any valid plugins to load)*/
  {$EXTERNALSYM kNSLPluginLoadFailed}
  kNSLPluginLoadFailed          = -4182; //* (manager unable to load one of the plugins)*/
  {$EXTERNALSYM kNSLBadProtocolTypeErr}
  kNSLBadProtocolTypeErr        = -4183; //* (client is trying to add a null protocol type)*/
  {$EXTERNALSYM kNSLNullListPtr}
  kNSLNullListPtr               = -4184; //* (client is trying to add items to a nil list)*/
  {$EXTERNALSYM kNSLBadClientInfoPtr}
  kNSLBadClientInfoPtr          = -4185; //* (nil ClientAsyncInfoPtr; no reference available)*/
  {$EXTERNALSYM kNSLCannotContinueLookup}
  kNSLCannotContinueLookup      = -4186; //* (Can't continue lookup; error or bad state)*/
  {$EXTERNALSYM kNSLBufferTooSmallForData}
  kNSLBufferTooSmallForData     = -4187; //* (Client buffer too small for data from plugin)*/
  {$EXTERNALSYM kNSLNoContextAvailable}
  kNSLNoContextAvailable        = -4188; //* (ContinueLookup function ptr invalid)*/
  {$EXTERNALSYM kNSLRequestBufferAlreadyInList}
  kNSLRequestBufferAlreadyInList = -4189;
  {$EXTERNALSYM kNSLInvalidPluginSpec}
  kNSLInvalidPluginSpec         = -4190;
  {$EXTERNALSYM kNSLNoSupportForService}
  kNSLNoSupportForService       = -4191;
  {$EXTERNALSYM kNSLBadNetConnection}
  kNSLBadNetConnection          = -4192;
  {$EXTERNALSYM kNSLBadDataTypeErr}
  kNSLBadDataTypeErr            = -4193;
  {$EXTERNALSYM kNSLBadServiceTypeErr}
  kNSLBadServiceTypeErr         = -4194;
  {$EXTERNALSYM kNSLBadReferenceErr}
  kNSLBadReferenceErr           = -4195;
  {$EXTERNALSYM kNSLNoElementsInList}
  kNSLNoElementsInList          = -4196;
  {$EXTERNALSYM kNSLInsufficientOTVer}
  kNSLInsufficientOTVer         = -4197;
  {$EXTERNALSYM kNSLInsufficientSysVer}
  kNSLInsufficientSysVer        = -4198;
  {$EXTERNALSYM kNSLNotInitialized}
  kNSLNotInitialized            = -4199;
  {$EXTERNALSYM kNSLInitializationFailed}
  kNSLInitializationFailed      = -4200; //* UNABLE TO INITIALIZE THE MANAGER!!!!! DO NOT CONTINUE!!!!*/
//};



//* desktop printing error codes*/
//enum {
  {$EXTERNALSYM kDTPHoldJobErr}
  kDTPHoldJobErr                = -4200;
  {$EXTERNALSYM kDTPStopQueueErr}
  kDTPStopQueueErr              = -4201;
  {$EXTERNALSYM kDTPTryAgainErr}
  kDTPTryAgainErr               = -4202;
  {$EXTERNALSYM kDTPAbortJobErr}
  kDTPAbortJobErr               = 128;
//};


//* ColorSync Result codes */
//enum {
                                        //* Profile Access Errors */
  {$EXTERNALSYM cmElementTagNotFound}
  cmElementTagNotFound          = -4200;
  {$EXTERNALSYM cmIndexRangeErr}
  cmIndexRangeErr               = -4201; //* Tag index out of range */
  {$EXTERNALSYM cmCantDeleteElement}
  cmCantDeleteElement           = -4202;
  {$EXTERNALSYM cmFatalProfileErr}
  cmFatalProfileErr             = -4203;
  {$EXTERNALSYM cmInvalidProfile}
  cmInvalidProfile              = -4204; //* A Profile must contain a 'cs1 ' tag to be valid */
  {$EXTERNALSYM cmInvalidProfileLocation}
  cmInvalidProfileLocation      = -4205; //* Operation not supported for this profile location */
  {$EXTERNALSYM cmCantCopyModifiedV1Profile}
  cmCantCopyModifiedV1Profile   = -4215; //* Illegal to copy version 1 profiles that have been modified */
                                        //* Profile Search Errors */
  {$EXTERNALSYM cmInvalidSearch}
  cmInvalidSearch               = -4206; //* Bad Search Handle */
  {$EXTERNALSYM cmSearchError}
  cmSearchError                 = -4207;
  {$EXTERNALSYM cmErrIncompatibleProfile}
  cmErrIncompatibleProfile      = -4208; //* Other ColorSync Errors */
  {$EXTERNALSYM cmInvalidColorSpace}
  cmInvalidColorSpace           = -4209; //* Profile colorspace does not match bitmap type */
  {$EXTERNALSYM cmInvalidSrcMap}
  cmInvalidSrcMap               = -4210; //* Source pix/bit map was invalid */
  {$EXTERNALSYM cmInvalidDstMap}
  cmInvalidDstMap               = -4211; //* Destination pix/bit map was invalid */
  {$EXTERNALSYM cmNoGDevicesError}
  cmNoGDevicesError             = -4212; //* Begin/End Matching -- no gdevices available */
  {$EXTERNALSYM cmInvalidProfileComment}
  cmInvalidProfileComment       = -4213; //* Bad Profile comment during drawpicture */
  {$EXTERNALSYM cmRangeOverFlow}
  cmRangeOverFlow               = -4214; //* Color conversion warning that some output color values over/underflowed and were clipped */
  {$EXTERNALSYM cmNamedColorNotFound}
  cmNamedColorNotFound          = -4216; //* NamedColor not found */
  {$EXTERNALSYM cmCantGamutCheckError}
  cmCantGamutCheckError         = -4217; //* Gammut checking not supported by this ColorWorld */
//};

//* new Folder Manager error codes */
//enum {
  {$EXTERNALSYM badFolderDescErr}
  badFolderDescErr              = -4270;
  {$EXTERNALSYM duplicateFolderDescErr}
  duplicateFolderDescErr        = -4271;
  {$EXTERNALSYM noMoreFolderDescErr}
  noMoreFolderDescErr           = -4272;
  {$EXTERNALSYM invalidFolderTypeErr}
  invalidFolderTypeErr          = -4273;
  {$EXTERNALSYM duplicateRoutingErr}
  duplicateRoutingErr           = -4274;
  {$EXTERNALSYM routingNotFoundErr}
  routingNotFoundErr            = -4275;
  {$EXTERNALSYM badRoutingSizeErr}
  badRoutingSizeErr             = -4276;
//};


//* Core Foundation errors*/
//enum {
  {$EXTERNALSYM coreFoundationUnknownErr}
  coreFoundationUnknownErr      = -4960;
//};

//* CoreEndian error codes.  These can be returned by Flippers. */
//enum {
  {$EXTERNALSYM errCoreEndianDataTooShortForFormat}
  errCoreEndianDataTooShortForFormat = -4940;
  {$EXTERNALSYM errCoreEndianDataTooLongForFormat}
  errCoreEndianDataTooLongForFormat = -4941;
  {$EXTERNALSYM errCoreEndianDataDoesNotMatchFormat}
  errCoreEndianDataDoesNotMatchFormat = -4942;
//};


//* ScrapMgr error codes (CarbonLib 1.0 and later)*/
//enum {
  {$EXTERNALSYM internalScrapErr}
  internalScrapErr              = -4988;
  {$EXTERNALSYM duplicateScrapFlavorErr}
  duplicateScrapFlavorErr       = -4989;
  {$EXTERNALSYM badScrapRefErr}
  badScrapRefErr                = -4990;
  {$EXTERNALSYM processStateIncorrectErr}
  processStateIncorrectErr      = -4991;
  {$EXTERNALSYM scrapPromiseNotKeptErr}
  scrapPromiseNotKeptErr        = -4992;
  {$EXTERNALSYM noScrapPromiseKeeperErr}
  noScrapPromiseKeeperErr       = -4993;
  {$EXTERNALSYM nilScrapFlavorDataErr}
  nilScrapFlavorDataErr         = -4994;
  {$EXTERNALSYM scrapFlavorFlagsMismatchErr}
  scrapFlavorFlagsMismatchErr   = -4995;
  {$EXTERNALSYM scrapFlavorSizeMismatchErr}
  scrapFlavorSizeMismatchErr    = -4996;
  {$EXTERNALSYM illegalScrapFlavorFlagsErr}
  illegalScrapFlavorFlagsErr    = -4997;
  {$EXTERNALSYM illegalScrapFlavorTypeErr}
  illegalScrapFlavorTypeErr     = -4998;
  {$EXTERNALSYM illegalScrapFlavorSizeErr}
  illegalScrapFlavorSizeErr     = -4999;
  {$EXTERNALSYM scrapFlavorNotFoundErr}
  scrapFlavorNotFoundErr        = -102; //* == noTypeErr*/
  {$EXTERNALSYM needClearScrapErr}
  needClearScrapErr             = -100;  //* == noScrapErr*/
//};


//enum {
                                        //*  AFP Protocol Errors */
  {$EXTERNALSYM afpAccessDenied}
  afpAccessDenied               = -5000; //* Insufficient access privileges for operation */
  {$EXTERNALSYM afpAuthContinue}
  afpAuthContinue               = -5001; //* Further information required to complete AFPLogin call */
  {$EXTERNALSYM afpBadUAM}
  afpBadUAM                     = -5002; //* Unknown user authentication method specified */
  {$EXTERNALSYM afpBadVersNum}
  afpBadVersNum                 = -5003; //* Unknown AFP protocol version number specified */
  {$EXTERNALSYM afpBitmapErr}
  afpBitmapErr                  = -5004; //* Bitmap contained bits undefined for call */
  {$EXTERNALSYM afpCantMove}
  afpCantMove                   = -5005; //* Move destination is offspring of source, or root was specified */
  {$EXTERNALSYM afpDenyConflict}
  afpDenyConflict               = -5006; //* Specified open/deny modes conflict with current open modes */
  {$EXTERNALSYM afpDirNotEmpty}
  afpDirNotEmpty                = -5007; //* Cannot delete non-empty directory */
  {$EXTERNALSYM afpDiskFull}
  afpDiskFull                   = -5008; //* Insufficient free space on volume for operation */
  {$EXTERNALSYM afpEofError}
  afpEofError                   = -5009; //* Read beyond logical end-of-file */
  {$EXTERNALSYM afpFileBusy}
  afpFileBusy                   = -5010; //* Cannot delete an open file */
  {$EXTERNALSYM afpFlatVol}
  afpFlatVol                    = -5011; //* Cannot create directory on specified volume */
  {$EXTERNALSYM afpItemNotFound}
  afpItemNotFound               = -5012; //* Unknown UserName/UserID or missing comment/APPL entry */
  {$EXTERNALSYM afpLockErr}
  afpLockErr                    = -5013; //* Some or all of requested range is locked by another user */
  {$EXTERNALSYM afpMiscErr}
  afpMiscErr                    = -5014; //* Unexpected error encountered during execution */
  {$EXTERNALSYM afpNoMoreLocks}
  afpNoMoreLocks                = -5015; //* Maximum lock limit reached */
  {$EXTERNALSYM afpNoServer}
  afpNoServer                   = -5016; //* Server not responding */
  {$EXTERNALSYM afpObjectExists}
  afpObjectExists               = -5017; //* Specified destination file or directory already exists */
  {$EXTERNALSYM afpObjectNotFound}
  afpObjectNotFound             = -5018; //* Specified file or directory does not exist */
  {$EXTERNALSYM afpParmErr}
  afpParmErr                    = -5019; //* A specified parameter was out of allowable range */
  {$EXTERNALSYM afpRangeNotLocked}
  afpRangeNotLocked             = -5020; //* Tried to unlock range that was not locked by user */
  {$EXTERNALSYM afpRangeOverlap}
  afpRangeOverlap               = -5021; //* Some or all of range already locked by same user */
  {$EXTERNALSYM afpSessClosed}
  afpSessClosed                 = -5022; //* Session closed*/
  {$EXTERNALSYM afpUserNotAuth}
  afpUserNotAuth                = -5023; //* No AFPLogin call has successfully been made for this session */
  {$EXTERNALSYM afpCallNotSupported}
  afpCallNotSupported           = -5024; //* Unsupported AFP call was made */
  {$EXTERNALSYM afpObjectTypeErr}
  afpObjectTypeErr              = -5025; //* File/Directory specified where Directory/File expected */
  {$EXTERNALSYM afpTooManyFilesOpen}
  afpTooManyFilesOpen           = -5026; //* Maximum open file count reached */
  {$EXTERNALSYM afpServerGoingDown}
  afpServerGoingDown            = -5027; //* Server is shutting down */
  {$EXTERNALSYM afpCantRename}
  afpCantRename                 = -5028; //* AFPRename cannot rename volume */
  {$EXTERNALSYM afpDirNotFound}
  afpDirNotFound                = -5029; //* Unknown directory specified */
  {$EXTERNALSYM afpIconTypeError}
  afpIconTypeError              = -5030; //* Icon size specified different from existing icon size */
  {$EXTERNALSYM afpVolLocked}
  afpVolLocked                  = -5031; //* Volume is Read-Only */
  {$EXTERNALSYM afpObjectLocked}
  afpObjectLocked               = -5032; //* Object is M/R/D/W inhibited*/
  {$EXTERNALSYM afpContainsSharedErr}
  afpContainsSharedErr          = -5033; //* the folder being shared contains a shared folder*/
  {$EXTERNALSYM afpIDNotFound}
  afpIDNotFound                 = -5034;
  {$EXTERNALSYM afpIDExists}
  afpIDExists                   = -5035;
  {$EXTERNALSYM afpDiffVolErr}
  afpDiffVolErr                 = -5036;
  {$EXTERNALSYM afpCatalogChanged}
  afpCatalogChanged             = -5037;
  {$EXTERNALSYM afpSameObjectErr}
  afpSameObjectErr              = -5038;
  {$EXTERNALSYM afpBadIDErr}
  afpBadIDErr                   = -5039;
  {$EXTERNALSYM afpPwdSameErr}
  afpPwdSameErr                 = -5040; //* Someone tried to change their password to the same password on a mantadory password change */
  {$EXTERNALSYM afpPwdTooShortErr}
  afpPwdTooShortErr             = -5041; //* The password being set is too short: there is a minimum length that must be met or exceeded */
  {$EXTERNALSYM afpPwdExpiredErr}
  afpPwdExpiredErr              = -5042; //* The password being used is too old: this requires the user to change the password before log-in can continue */
  {$EXTERNALSYM afpInsideSharedErr}
  afpInsideSharedErr            = -5043; //* The folder being shared is inside a shared folder OR the folder contains a shared folder and is being moved into a shared folder */
                                        //* OR the folder contains a shared folder and is being moved into the descendent of a shared folder.*/
  {$EXTERNALSYM afpInsideTrashErr}
  afpInsideTrashErr             = -5044; //* The folder being shared is inside the trash folder OR the shared folder is being moved into the trash folder */
                                        //* OR the folder is being moved to the trash and it contains a shared folder */
  {$EXTERNALSYM afpPwdNeedsChangeErr}
  afpPwdNeedsChangeErr          = -5045; //* The password needs to be changed*/
  {$EXTERNALSYM afpPwdPolicyErr}
  afpPwdPolicyErr               = -5046; //* Password does not conform to servers password policy */
  {$EXTERNALSYM afpAlreadyLoggedInErr}
  afpAlreadyLoggedInErr         = -5047; //* User has been authenticated but is already logged in from another machine (and that's not allowed on this server) */
  {$EXTERNALSYM afpCallNotAllowed}
  afpCallNotAllowed             = -5048; //* The server knows what you wanted to do, but won't let you do it just now */
//};

//enum {
                                        //*  AppleShare Client Errors */
  {$EXTERNALSYM afpBadDirIDType}
  afpBadDirIDType               = -5060;
  {$EXTERNALSYM afpCantMountMoreSrvre}
  afpCantMountMoreSrvre         = -5061; //* The Maximum number of server connections has been reached */
  {$EXTERNALSYM afpAlreadyMounted}
  afpAlreadyMounted             = -5062; //* The volume is already mounted */
  {$EXTERNALSYM afpSameNodeErr}
  afpSameNodeErr                = -5063; //* An Attempt was made to connect to a file server running on the same machine */
//};



//*Text Engines, TSystemTextEngines, HIEditText error coded*/

//* NumberFormatting error codes*/
//enum {
  {$EXTERNALSYM numberFormattingNotANumberErr}
  numberFormattingNotANumberErr = -5200;
  {$EXTERNALSYM numberFormattingOverflowInDestinationErr}
  numberFormattingOverflowInDestinationErr = -5201;
  {$EXTERNALSYM numberFormattingBadNumberFormattingObjectErr}
  numberFormattingBadNumberFormattingObjectErr = -5202;
  {$EXTERNALSYM numberFormattingSpuriousCharErr}
  numberFormattingSpuriousCharErr = -5203;
  {$EXTERNALSYM numberFormattingLiteralMissingErr}
  numberFormattingLiteralMissingErr = -5204;
  {$EXTERNALSYM numberFormattingDelimiterMissingErr}
  numberFormattingDelimiterMissingErr = -5205;
  {$EXTERNALSYM numberFormattingEmptyFormatErr}
  numberFormattingEmptyFormatErr = -5206;
  {$EXTERNALSYM numberFormattingBadFormatErr}
  numberFormattingBadFormatErr  = -5207;
  {$EXTERNALSYM numberFormattingBadOptionsErr}
  numberFormattingBadOptionsErr = -5208;
  {$EXTERNALSYM numberFormattingBadTokenErr}
  numberFormattingBadTokenErr   = -5209;
  {$EXTERNALSYM numberFormattingUnOrderedCurrencyRangeErr}
  numberFormattingUnOrderedCurrencyRangeErr = -5210;
  {$EXTERNALSYM numberFormattingBadCurrencyPositionErr}
  numberFormattingBadCurrencyPositionErr = -5211;
  {$EXTERNALSYM numberFormattingNotADigitErr}
  numberFormattingNotADigitErr  = -5212; //* deprecated misspelled versions:*/
  {$EXTERNALSYM numberFormattingUnOrdredCurrencyRangeErr}
  numberFormattingUnOrdredCurrencyRangeErr = -5210;
  {$EXTERNALSYM numberFortmattingNotADigitErr}
  numberFortmattingNotADigitErr = -5212;
//};

//* TextParser error codes*/
//enum {
  {$EXTERNALSYM textParserBadParamErr}
  textParserBadParamErr         = -5220;
  {$EXTERNALSYM textParserObjectNotFoundErr}
  textParserObjectNotFoundErr   = -5221;
  {$EXTERNALSYM textParserBadTokenValueErr}
  textParserBadTokenValueErr    = -5222;
  {$EXTERNALSYM textParserBadParserObjectErr}
  textParserBadParserObjectErr  = -5223;
  {$EXTERNALSYM textParserParamErr}
  textParserParamErr            = -5224;
  {$EXTERNALSYM textParserNoMoreTextErr}
  textParserNoMoreTextErr       = -5225;
  {$EXTERNALSYM textParserBadTextLanguageErr}
  textParserBadTextLanguageErr  = -5226;
  {$EXTERNALSYM textParserBadTextEncodingErr}
  textParserBadTextEncodingErr  = -5227;
  {$EXTERNALSYM textParserNoSuchTokenFoundErr}
  textParserNoSuchTokenFoundErr = -5228;
  {$EXTERNALSYM textParserNoMoreTokensErr}
  textParserNoMoreTokensErr     = -5229;
//};

//enum {
  {$EXTERNALSYM errUnknownAttributeTag}
  errUnknownAttributeTag        = -5240;
  {$EXTERNALSYM errMarginWilllNotFit}
  errMarginWilllNotFit          = -5241;
  {$EXTERNALSYM errNotInImagingMode}
  errNotInImagingMode           = -5242;
  {$EXTERNALSYM errAlreadyInImagingMode}
  errAlreadyInImagingMode       = -5243;
  {$EXTERNALSYM errEngineNotFound}
  errEngineNotFound             = -5244;
  {$EXTERNALSYM errIteratorReachedEnd}
  errIteratorReachedEnd         = -5245;
  {$EXTERNALSYM errInvalidRange}
  errInvalidRange               = -5246;
  {$EXTERNALSYM errOffsetNotOnElementBounday}
  errOffsetNotOnElementBounday  = -5247;
  {$EXTERNALSYM errNoHiliteText}
  errNoHiliteText               = -5248;
  {$EXTERNALSYM errEmptyScrap}
  errEmptyScrap                 = -5249;
  {$EXTERNALSYM errReadOnlyText}
  errReadOnlyText               = -5250;
  {$EXTERNALSYM errUnknownElement}
  errUnknownElement             = -5251;
  {$EXTERNALSYM errNonContiuousAttribute}
  errNonContiuousAttribute      = -5252;
  {$EXTERNALSYM errCannotUndo}
  errCannotUndo                 = -5253;
//};


//* HTMLRendering OSStaus codes*/
//enum {
  {$EXTERNALSYM hrHTMLRenderingLibNotInstalledErr}
  hrHTMLRenderingLibNotInstalledErr = -5360;
  {$EXTERNALSYM hrMiscellaneousExceptionErr}
  hrMiscellaneousExceptionErr   = -5361;
  {$EXTERNALSYM hrUnableToResizeHandleErr}
  hrUnableToResizeHandleErr     = -5362;
  {$EXTERNALSYM hrURLNotHandledErr}
  hrURLNotHandledErr            = -5363;
//};


//* IAExtractor result codes */
//enum {
  {$EXTERNALSYM errIANoErr}
  errIANoErr                    = 0;
  {$EXTERNALSYM errIAUnknownErr}
  errIAUnknownErr               = -5380;
  {$EXTERNALSYM errIAAllocationErr}
  errIAAllocationErr            = -5381;
  {$EXTERNALSYM errIAParamErr}
  errIAParamErr                 = -5382;
  {$EXTERNALSYM errIANoMoreItems}
  errIANoMoreItems              = -5383;
  {$EXTERNALSYM errIABufferTooSmall}
  errIABufferTooSmall           = -5384;
  {$EXTERNALSYM errIACanceled}
  errIACanceled                 = -5385;
  {$EXTERNALSYM errIAInvalidDocument}
  errIAInvalidDocument          = -5386;
  {$EXTERNALSYM errIATextExtractionErr}
  errIATextExtractionErr        = -5387;
  {$EXTERNALSYM errIAEndOfTextRun}
  errIAEndOfTextRun             = -5388;
//};


//* QuickTime Streaming Errors */
//enum {
  {$EXTERNALSYM qtsBadSelectorErr}
  qtsBadSelectorErr             = -5400;
  {$EXTERNALSYM qtsBadStateErr}
  qtsBadStateErr                = -5401;
  {$EXTERNALSYM qtsBadDataErr}
  qtsBadDataErr                 = -5402; //* something is wrong with the data */
  {$EXTERNALSYM qtsUnsupportedDataTypeErr}
  qtsUnsupportedDataTypeErr     = -5403;
  {$EXTERNALSYM qtsUnsupportedRateErr}
  qtsUnsupportedRateErr         = -5404;
  {$EXTERNALSYM qtsUnsupportedFeatureErr}
  qtsUnsupportedFeatureErr      = -5405;
  {$EXTERNALSYM qtsTooMuchDataErr}
  qtsTooMuchDataErr             = -5406;
  {$EXTERNALSYM qtsUnknownValueErr}
  qtsUnknownValueErr            = -5407;
  {$EXTERNALSYM qtsTimeoutErr}
  qtsTimeoutErr                 = -5408;
  {$EXTERNALSYM qtsConnectionFailedErr}
  qtsConnectionFailedErr        = -5420;
  {$EXTERNALSYM qtsAddressBusyErr}
  qtsAddressBusyErr             = -5421;
//};


//enum {
                                        //*Gestalt error codes*/
  {$EXTERNALSYM gestaltUnknownErr}
  gestaltUnknownErr             = -5550; //*value returned if Gestalt doesn't know the answer*/
  {$EXTERNALSYM gestaltUndefSelectorErr}
  gestaltUndefSelectorErr       = -5551; //*undefined selector was passed to Gestalt*/
  {$EXTERNALSYM gestaltDupSelectorErr}
  gestaltDupSelectorErr         = -5552; //*tried to add an entry that already existed*/
  {$EXTERNALSYM gestaltLocationErr}
  gestaltLocationErr            = -5553; //*gestalt function ptr wasn't in sysheap*/
//};


//* Menu Manager error codes*/
//enum {
  {$EXTERNALSYM menuPropertyInvalidErr}
  menuPropertyInvalidErr        = -5603; //* invalid property creator */
  {$EXTERNALSYM menuPropertyInvalid}
  menuPropertyInvalid           = menuPropertyInvalidErr; //* "menuPropertyInvalid" is deprecated */
  {$EXTERNALSYM menuPropertyNotFoundErr}
  menuPropertyNotFoundErr       = -5604; //* specified property wasn't found */
  {$EXTERNALSYM menuNotFoundErr}
  menuNotFoundErr               = -5620; //* specified menu or menu ID wasn't found */
  {$EXTERNALSYM menuUsesSystemDefErr}
  menuUsesSystemDefErr          = -5621; //* GetMenuDefinition failed because the menu uses the system MDEF */
  {$EXTERNALSYM menuItemNotFoundErr}
  menuItemNotFoundErr           = -5622; //* specified menu item wasn't found*/
  {$EXTERNALSYM menuInvalidErr}
  menuInvalidErr                = -5623; //* menu is invalid*/
//};


//* Window Manager error codes*/
//enum {
  {$EXTERNALSYM errInvalidWindowPtr}
  errInvalidWindowPtr           = -5600; //* tried to pass a bad WindowRef argument*/
  {$EXTERNALSYM errInvalidWindowRef}
  errInvalidWindowRef           = -5600; //* tried to pass a bad WindowRef argument*/
  {$EXTERNALSYM errUnsupportedWindowAttributesForClass}
  errUnsupportedWindowAttributesForClass = -5601; //* tried to create a window with WindowAttributes not supported by the WindowClass*/
  {$EXTERNALSYM errWindowDoesNotHaveProxy}
  errWindowDoesNotHaveProxy     = -5602; //* tried to do something requiring a proxy to a window which doesn’t have a proxy*/
  {$EXTERNALSYM errInvalidWindowProperty}
  errInvalidWindowProperty      = -5603; //* tried to access a property tag with private creator*/
  {$EXTERNALSYM errWindowPropertyNotFound}
  errWindowPropertyNotFound     = -5604; //* tried to get a nonexistent property*/
  {$EXTERNALSYM errUnrecognizedWindowClass}
  errUnrecognizedWindowClass    = -5605; //* tried to create a window with a bad WindowClass*/
  {$EXTERNALSYM errCorruptWindowDescription}
  errCorruptWindowDescription   = -5606; //* tried to load a corrupt window description (size or version fields incorrect)*/
  {$EXTERNALSYM errUserWantsToDragWindow}
  errUserWantsToDragWindow      = -5607; //* if returned from TrackWindowProxyDrag, you should call DragWindow on the window*/
  {$EXTERNALSYM errWindowsAlreadyInitialized}
  errWindowsAlreadyInitialized  = -5608; //* tried to call InitFloatingWindows twice, or called InitWindows and then floating windows*/
  {$EXTERNALSYM errFloatingWindowsNotInitialized}
  errFloatingWindowsNotInitialized = -5609; //* called HideFloatingWindows or ShowFloatingWindows without calling InitFloatingWindows*/
  {$EXTERNALSYM errWindowNotFound}
  errWindowNotFound             = -5610; //* returned from FindWindowOfClass*/
  {$EXTERNALSYM errWindowDoesNotFitOnscreen}
  errWindowDoesNotFitOnscreen   = -5611; //* ConstrainWindowToScreen could not make the window fit onscreen*/
  {$EXTERNALSYM windowAttributeImmutableErr}
  windowAttributeImmutableErr   = -5612; //* tried to change attributes which can't be changed*/
  {$EXTERNALSYM windowAttributesConflictErr}
  windowAttributesConflictErr   = -5613; //* passed some attributes that are mutually exclusive*/
  {$EXTERNALSYM windowManagerInternalErr}
  windowManagerInternalErr      = -5614; //* something really weird happened inside the window manager*/
  {$EXTERNALSYM windowWrongStateErr}
  windowWrongStateErr           = -5615; //* window is not in a state that is valid for the current action*/
  {$EXTERNALSYM windowGroupInvalidErr}
  windowGroupInvalidErr         = -5616; //* WindowGroup is invalid*/
  {$EXTERNALSYM windowAppModalStateAlreadyExistsErr}
  windowAppModalStateAlreadyExistsErr = -5617; //* we're already running this window modally*/
  {$EXTERNALSYM windowNoAppModalStateErr}
  windowNoAppModalStateErr      = -5618; //* there's no app modal state for the window*/
  {$EXTERNALSYM errWindowDoesntSupportFocus}
  errWindowDoesntSupportFocus   = -30583;
  {$EXTERNALSYM errWindowRegionCodeInvalid}
  errWindowRegionCodeInvalid    = -30593;
//};


//* Dialog Mgr error codes*/
//enum {
  {$EXTERNALSYM dialogNoTimeoutErr}
  dialogNoTimeoutErr            = -5640;
//};


//* NavigationLib error codes*/
//enum {
  {$EXTERNALSYM kNavWrongDialogStateErr}
  kNavWrongDialogStateErr       = -5694;
  {$EXTERNALSYM kNavWrongDialogClassErr}
  kNavWrongDialogClassErr       = -5695;
  {$EXTERNALSYM kNavInvalidSystemConfigErr}
  kNavInvalidSystemConfigErr    = -5696;
  {$EXTERNALSYM kNavCustomControlMessageFailedErr}
  kNavCustomControlMessageFailedErr = -5697;
  {$EXTERNALSYM kNavInvalidCustomControlMessageErr}
  kNavInvalidCustomControlMessageErr = -5698;
  {$EXTERNALSYM kNavMissingKindStringErr}
  kNavMissingKindStringErr      = -5699;
//};


//* Collection Manager errors */
//enum {
  {$EXTERNALSYM collectionItemLockedErr}
  collectionItemLockedErr       = -5750;
  {$EXTERNALSYM collectionItemNotFoundErr}
  collectionItemNotFoundErr     = -5751;
  {$EXTERNALSYM collectionIndexRangeErr}
  collectionIndexRangeErr       = -5752;
  {$EXTERNALSYM collectionVersionErr}
  collectionVersionErr          = -5753;
//};


//* QuickTime Streaming Server Errors */
//enum {
  {$EXTERNALSYM kQTSSUnknownErr}
  kQTSSUnknownErr               = -6150;
//};


//enum {
                                        //* Display Manager error codes (-6220...-6269)*/
  {$EXTERNALSYM kDMGenErr}
  kDMGenErr                     = -6220; //*Unexpected Error*/
                                        //* Mirroring-Specific Errors */
  {$EXTERNALSYM kDMMirroringOnAlready}
  kDMMirroringOnAlready         = -6221; //*Returned by all calls that need mirroring to be off to do their thing.*/
  {$EXTERNALSYM kDMWrongNumberOfDisplays}
  kDMWrongNumberOfDisplays      = -6222; //*Can only handle 2 displays for now.*/
  {$EXTERNALSYM kDMMirroringBlocked}
  kDMMirroringBlocked           = -6223; //*DMBlockMirroring() has been called.*/
  {$EXTERNALSYM kDMCantBlock}
  kDMCantBlock                  = -6224; //*Mirroring is already on, can’t Block now (call DMUnMirror() first).*/
  {$EXTERNALSYM kDMMirroringNotOn}
  kDMMirroringNotOn             = -6225; //*Returned by all calls that need mirroring to be on to do their thing.*/
                                        //* Other Display Manager Errors */
  {$EXTERNALSYM kSysSWTooOld}
  kSysSWTooOld                  = -6226; //*Missing critical pieces of System Software.*/
  {$EXTERNALSYM kDMSWNotInitializedErr}
  kDMSWNotInitializedErr        = -6227; //*Required software not initialized (eg windowmanager or display mgr).*/
  {$EXTERNALSYM kDMDriverNotDisplayMgrAwareErr}
  kDMDriverNotDisplayMgrAwareErr = -6228; //*Video Driver does not support display manager.*/
  {$EXTERNALSYM kDMDisplayNotFoundErr}
  kDMDisplayNotFoundErr         = -6229; //*Could not find item (will someday remove).*/
  {$EXTERNALSYM kDMNotFoundErr}
  kDMNotFoundErr                = -6229; //*Could not find item.*/
  {$EXTERNALSYM kDMDisplayAlreadyInstalledErr}
  kDMDisplayAlreadyInstalledErr = -6230; //*Attempt to add an already installed display.*/
  {$EXTERNALSYM kDMMainDisplayCannotMoveErr}
  kDMMainDisplayCannotMoveErr   = -6231; //*Trying to move main display (or a display mirrored to it) */
  {$EXTERNALSYM kDMNoDeviceTableclothErr}
  kDMNoDeviceTableclothErr      = -6231; //*obsolete*/
  {$EXTERNALSYM kDMFoundErr}
  kDMFoundErr                   = -6232; //*Did not proceed because we found an item*/
//};


{*
    Language Analysis error codes
*}
//enum {
  {$EXTERNALSYM laTooSmallBufferErr}
  laTooSmallBufferErr           = -6984; //* output buffer is too small to store any result */
  {$EXTERNALSYM laEnvironmentBusyErr}
  laEnvironmentBusyErr          = -6985; //* specified environment is used */
  {$EXTERNALSYM laEnvironmentNotFoundErr}
  laEnvironmentNotFoundErr      = -6986; //* can't fint the specified environment */
  {$EXTERNALSYM laEnvironmentExistErr}
  laEnvironmentExistErr         = -6987; //* same name environment is already exists */
  {$EXTERNALSYM laInvalidPathErr}
  laInvalidPathErr              = -6988; //* path is not correct */
  {$EXTERNALSYM laNoMoreMorphemeErr}
  laNoMoreMorphemeErr           = -6989; //* nothing to read*/
  {$EXTERNALSYM laFailAnalysisErr}
  laFailAnalysisErr             = -6990; //* analysis failed*/
  {$EXTERNALSYM laTextOverFlowErr}
  laTextOverFlowErr             = -6991; //* text is too long*/
  {$EXTERNALSYM laDictionaryNotOpenedErr}
  laDictionaryNotOpenedErr      = -6992; //* the dictionary is not opened*/
  {$EXTERNALSYM laDictionaryUnknownErr}
  laDictionaryUnknownErr        = -6993; //* can't use this dictionary with this environment*/
  {$EXTERNALSYM laDictionaryTooManyErr}
  laDictionaryTooManyErr        = -6994; //* too many dictionaries*/
  {$EXTERNALSYM laPropertyValueErr}
  laPropertyValueErr            = -6995; //* Invalid property value*/
  {$EXTERNALSYM laPropertyUnknownErr}
  laPropertyUnknownErr          = -6996; //* the property is unknown to this environment*/
  {$EXTERNALSYM laPropertyIsReadOnlyErr}
  laPropertyIsReadOnlyErr       = -6997; //* the property is read only*/
  {$EXTERNALSYM laPropertyNotFoundErr}
  laPropertyNotFoundErr         = -6998; //* can't find the property*/
  {$EXTERNALSYM laPropertyErr}
  laPropertyErr                 = -6999; //* Error in properties*/
  {$EXTERNALSYM laEngineNotFoundErr}
  laEngineNotFoundErr           = -7000; //* can't find the engine*/
//};


//enum {
  {$EXTERNALSYM kUSBNoErr}
  kUSBNoErr                     = 0;
  {$EXTERNALSYM kUSBNoTran}
  kUSBNoTran                    = 0;
  {$EXTERNALSYM kUSBNoDelay}
  kUSBNoDelay                   = 0;
  {$EXTERNALSYM kUSBPending}
  kUSBPending                   = 1;
//};

{*

   USB Hardware Errors
   Note pipe stalls are communication
   errors. The affected pipe can not
   be used until USBClearPipeStallByReference
   is used.
   kUSBEndpointStallErr is returned in
   response to a stall handshake
   from a device. The device has to be
   cleared before a USBClearPipeStallByReference
   can be used.
*}
//enum {
  {$EXTERNALSYM kUSBNotSent2Err}
  kUSBNotSent2Err               = -6901; //*  Transaction not sent */
  {$EXTERNALSYM kUSBNotSent1Err}
  kUSBNotSent1Err               = -6902; //*  Transaction not sent */
  {$EXTERNALSYM kUSBBufUnderRunErr}
  kUSBBufUnderRunErr            = -6903; //*  Host hardware failure on data out, PCI busy? */
  {$EXTERNALSYM kUSBBufOvrRunErr}
  kUSBBufOvrRunErr              = -6904; //*  Host hardware failure on data in, PCI busy? */
  {$EXTERNALSYM kUSBRes2Err}
  kUSBRes2Err                   = -6905;
  {$EXTERNALSYM kUSBRes1Err}
  kUSBRes1Err                   = -6906;
  {$EXTERNALSYM kUSBUnderRunErr}
  kUSBUnderRunErr               = -6907; //*  Less data than buffer */
  {$EXTERNALSYM kUSBOverRunErr}
  kUSBOverRunErr                = -6908; //*  Packet too large or more data than buffer */
  {$EXTERNALSYM kUSBWrongPIDErr}
  kUSBWrongPIDErr               = -6909; //*  Pipe stall, Bad or wrong PID */
  {$EXTERNALSYM kUSBPIDCheckErr}
  kUSBPIDCheckErr               = -6910; //*  Pipe stall, PID CRC error */
  {$EXTERNALSYM kUSBNotRespondingErr}
  kUSBNotRespondingErr          = -6911; //*  Pipe stall, No device, device hung */
  {$EXTERNALSYM kUSBEndpointStallErr}
  kUSBEndpointStallErr          = -6912; //*  Device didn't understand */
  {$EXTERNALSYM kUSBDataToggleErr}
  kUSBDataToggleErr             = -6913; //*  Pipe stall, Bad data toggle */
  {$EXTERNALSYM kUSBBitstufErr}
  kUSBBitstufErr                = -6914; //*  Pipe stall, bitstuffing */
  {$EXTERNALSYM kUSBCRCErr}
  kUSBCRCErr                    = -6915; //*  Pipe stall, bad CRC */
  {$EXTERNALSYM kUSBLinkErr}
  kUSBLinkErr                   = -6916;
//};


{*

   USB Manager Errors
*}
//enum {
  {$EXTERNALSYM kUSBQueueFull}
  kUSBQueueFull                 = -6948; //* Internal queue maxxed  */
  {$EXTERNALSYM kUSBNotHandled}
  kUSBNotHandled                = -6987; //* Notification was not handled   (same as NotFound)*/
  {$EXTERNALSYM kUSBUnknownNotification}
  kUSBUnknownNotification       = -6949; //* Notification type not defined  */
  {$EXTERNALSYM kUSBBadDispatchTable}
  kUSBBadDispatchTable          = -6950; //* Improper driver dispatch table     */
//};


{*
   USB internal errors are in range -6960 to -6951
   please do not use this range

*}
//enum {
  {$EXTERNALSYM kUSBInternalReserved10}
  kUSBInternalReserved10        = -6951;
  {$EXTERNALSYM kUSBInternalReserved9}
  kUSBInternalReserved9         = -6952;
  {$EXTERNALSYM kUSBInternalReserved8}
  kUSBInternalReserved8         = -6953;
  {$EXTERNALSYM kUSBInternalReserved7}
  kUSBInternalReserved7         = -6954;
  {$EXTERNALSYM kUSBInternalReserved6}
  kUSBInternalReserved6         = -6955;
  {$EXTERNALSYM kUSBInternalReserved5}
  kUSBInternalReserved5         = -6956;
  {$EXTERNALSYM kUSBInternalReserved4}
  kUSBInternalReserved4         = -6957;
  {$EXTERNALSYM kUSBInternalReserved3}
  kUSBInternalReserved3         = -6958;
  {$EXTERNALSYM kUSBInternalReserved2}
  kUSBInternalReserved2         = -6959;
  {$EXTERNALSYM kUSBInternalReserved1}
  kUSBInternalReserved1         = -6960; //* reserved*/
//};

//* USB Services Errors */
//enum {
  {$EXTERNALSYM kUSBPortDisabled}
  kUSBPortDisabled              = -6969; //* The port you are attached to is disabled, use USBDeviceReset.*/
  {$EXTERNALSYM kUSBQueueAborted}
  kUSBQueueAborted              = -6970; //* Pipe zero stall cleared.*/
  {$EXTERNALSYM kUSBTimedOut}
  kUSBTimedOut                  = -6971; //* Transaction timed out. */
  {$EXTERNALSYM kUSBDeviceDisconnected}
  kUSBDeviceDisconnected        = -6972; //* Disconnected during suspend or reset */
  {$EXTERNALSYM kUSBDeviceNotSuspended}
  kUSBDeviceNotSuspended        = -6973; //* device is not suspended for resume */
  {$EXTERNALSYM kUSBDeviceSuspended}
  kUSBDeviceSuspended           = -6974; //* Device is suspended */
  {$EXTERNALSYM kUSBInvalidBuffer}
  kUSBInvalidBuffer             = -6975; //* bad buffer, usually nil */
  {$EXTERNALSYM kUSBDevicePowerProblem}
  kUSBDevicePowerProblem        = -6976; //*  Device has a power problem */
  {$EXTERNALSYM kUSBDeviceBusy}
  kUSBDeviceBusy                = -6977; //*  Device is already being configured */
  {$EXTERNALSYM kUSBUnknownInterfaceErr}
  kUSBUnknownInterfaceErr       = -6978; //*  Interface ref not recognised */
  {$EXTERNALSYM kUSBPipeStalledError}
  kUSBPipeStalledError          = -6979; //*  Pipe has stalled, error needs to be cleared */
  {$EXTERNALSYM kUSBPipeIdleError}
  kUSBPipeIdleError             = -6980; //*  Pipe is Idle, it will not accept transactions */
  {$EXTERNALSYM kUSBNoBandwidthError}
  kUSBNoBandwidthError          = -6981; //*  Not enough bandwidth available */
  {$EXTERNALSYM kUSBAbortedError}
  kUSBAbortedError              = -6982; //*  Pipe aborted */
  {$EXTERNALSYM kUSBFlagsError}
  kUSBFlagsError                = -6983; //*  Unused flags not zeroed */
  {$EXTERNALSYM kUSBCompletionError}
  kUSBCompletionError           = -6984; //*  no completion routine specified */
  {$EXTERNALSYM kUSBPBLengthError}
  kUSBPBLengthError             = -6985; //*  pbLength too small */
  {$EXTERNALSYM kUSBPBVersionError}
  kUSBPBVersionError            = -6986; //*  Wrong pbVersion */
  {$EXTERNALSYM kUSBNotFound}
  kUSBNotFound                  = -6987; //*  Not found */
  {$EXTERNALSYM kUSBOutOfMemoryErr}
  kUSBOutOfMemoryErr            = -6988; //*  Out of memory */
  {$EXTERNALSYM kUSBDeviceErr}
  kUSBDeviceErr                 = -6989; //*  Device error */
  {$EXTERNALSYM kUSBNoDeviceErr}
  kUSBNoDeviceErr               = -6990; //*  No device*/
  {$EXTERNALSYM kUSBAlreadyOpenErr}
  kUSBAlreadyOpenErr            = -6991; //*  Already open */
  {$EXTERNALSYM kUSBTooManyTransactionsErr}
  kUSBTooManyTransactionsErr    = -6992; //*  Too many transactions */
  {$EXTERNALSYM kUSBUnknownRequestErr}
  kUSBUnknownRequestErr         = -6993; //*  Unknown request */
  {$EXTERNALSYM kUSBRqErr}
  kUSBRqErr                     = -6994; //*  Request error */
  {$EXTERNALSYM kUSBIncorrectTypeErr}
  kUSBIncorrectTypeErr          = -6995; //*  Incorrect type */
  {$EXTERNALSYM kUSBTooManyPipesErr}
  kUSBTooManyPipesErr           = -6996; //*  Too many pipes */
  {$EXTERNALSYM kUSBUnknownPipeErr}
  kUSBUnknownPipeErr            = -6997; //*  Pipe ref not recognised */
  {$EXTERNALSYM kUSBUnknownDeviceErr}
  kUSBUnknownDeviceErr          = -6998; //*  device ref not recognised */
  {$EXTERNALSYM kUSBInternalErr}
  kUSBInternalErr               = -6999; //* Internal error */
//};


{*
    DictionaryMgr error codes
*}
//enum {
  {$EXTERNALSYM dcmParamErr}
  dcmParamErr                   = -7100; //* bad parameter*/
  {$EXTERNALSYM dcmNotDictionaryErr}
  dcmNotDictionaryErr           = -7101; //* not dictionary*/
  {$EXTERNALSYM dcmBadDictionaryErr}
  dcmBadDictionaryErr           = -7102; //* invalid dictionary*/
  {$EXTERNALSYM dcmPermissionErr}
  dcmPermissionErr              = -7103; //* invalid permission*/
  {$EXTERNALSYM dcmDictionaryNotOpenErr}
  dcmDictionaryNotOpenErr       = -7104; //* dictionary not opened*/
  {$EXTERNALSYM dcmDictionaryBusyErr}
  dcmDictionaryBusyErr          = -7105; //* dictionary is busy*/
  {$EXTERNALSYM dcmBlockFullErr}
  dcmBlockFullErr               = -7107; //* dictionary block full*/
  {$EXTERNALSYM dcmNoRecordErr}
  dcmNoRecordErr                = -7108; //* no such record*/
  {$EXTERNALSYM dcmDupRecordErr}
  dcmDupRecordErr               = -7109; //* same record already exist*/
  {$EXTERNALSYM dcmNecessaryFieldErr}
  dcmNecessaryFieldErr          = -7110; //* lack required/identify field*/
  {$EXTERNALSYM dcmBadFieldInfoErr}
  dcmBadFieldInfoErr            = -7111; //* incomplete information*/
  {$EXTERNALSYM dcmBadFieldTypeErr}
  dcmBadFieldTypeErr            = -7112; //* no such field type supported*/
  {$EXTERNALSYM dcmNoFieldErr}
  dcmNoFieldErr                 = -7113; //* no such field exist*/
  {$EXTERNALSYM dcmBadKeyErr}
  dcmBadKeyErr                  = -7115; //* bad key information*/
  {$EXTERNALSYM dcmTooManyKeyErr}
  dcmTooManyKeyErr              = -7116; //* too many key field*/
  {$EXTERNALSYM dcmBadDataSizeErr}
  dcmBadDataSizeErr             = -7117; //* too big data size*/
  {$EXTERNALSYM dcmBadFindMethodErr}
  dcmBadFindMethodErr           = -7118; //* no such find method supported*/
  {$EXTERNALSYM dcmBadPropertyErr}
  dcmBadPropertyErr             = -7119; //* no such property exist*/
  {$EXTERNALSYM dcmProtectedErr}
  dcmProtectedErr               = -7121; //* need keyword to use dictionary*/
  {$EXTERNALSYM dcmNoAccessMethodErr}
  dcmNoAccessMethodErr          = -7122; //* no such AccessMethod*/
  {$EXTERNALSYM dcmBadFeatureErr}
  dcmBadFeatureErr              = -7124; //* invalid AccessMethod feature*/
  {$EXTERNALSYM dcmIterationCompleteErr}
  dcmIterationCompleteErr       = -7126; //* no more item in iterator*/
  {$EXTERNALSYM dcmBufferOverflowErr}
  dcmBufferOverflowErr          = -7127; //* data is larger than buffer size*/
//};


//* Apple Remote Access error codes*/
//enum {
  {$EXTERNALSYM kRAInvalidParameter}
  kRAInvalidParameter           = -7100;
  {$EXTERNALSYM kRAInvalidPort}
  kRAInvalidPort                = -7101;
  {$EXTERNALSYM kRAStartupFailed}
  kRAStartupFailed              = -7102;
  {$EXTERNALSYM kRAPortSetupFailed}
  kRAPortSetupFailed            = -7103;
  {$EXTERNALSYM kRAOutOfMemory}
  kRAOutOfMemory                = -7104;
  {$EXTERNALSYM kRANotSupported}
  kRANotSupported               = -7105;
  {$EXTERNALSYM kRAMissingResources}
  kRAMissingResources           = -7106;
  {$EXTERNALSYM kRAIncompatiblePrefs}
  kRAIncompatiblePrefs          = -7107;
  {$EXTERNALSYM kRANotConnected}
  kRANotConnected               = -7108;
  {$EXTERNALSYM kRAConnectionCanceled}
  kRAConnectionCanceled         = -7109;
  {$EXTERNALSYM kRAUnknownUser}
  kRAUnknownUser                = -7110;
  {$EXTERNALSYM kRAInvalidPassword}
  kRAInvalidPassword            = -7111;
  {$EXTERNALSYM kRAInternalError}
  kRAInternalError              = -7112;
  {$EXTERNALSYM kRAInstallationDamaged}
  kRAInstallationDamaged        = -7113;
  {$EXTERNALSYM kRAPortBusy}
  kRAPortBusy                   = -7114;
  {$EXTERNALSYM kRAUnknownPortState}
  kRAUnknownPortState           = -7115;
  {$EXTERNALSYM kRAInvalidPortState}
  kRAInvalidPortState           = -7116;
  {$EXTERNALSYM kRAInvalidSerialProtocol}
  kRAInvalidSerialProtocol      = -7117;
  {$EXTERNALSYM kRAUserLoginDisabled}
  kRAUserLoginDisabled          = -7118;
  {$EXTERNALSYM kRAUserPwdChangeRequired}
  kRAUserPwdChangeRequired      = -7119;
  {$EXTERNALSYM kRAUserPwdEntryRequired}
  kRAUserPwdEntryRequired       = -7120;
  {$EXTERNALSYM kRAUserInteractionRequired}
  kRAUserInteractionRequired    = -7121;
  {$EXTERNALSYM kRAInitOpenTransportFailed}
  kRAInitOpenTransportFailed    = -7122;
  {$EXTERNALSYM kRARemoteAccessNotReady}
  kRARemoteAccessNotReady       = -7123;
  {$EXTERNALSYM kRATCPIPInactive}
  kRATCPIPInactive              = -7124; //* TCP/IP inactive, cannot be loaded*/
  {$EXTERNALSYM kRATCPIPNotConfigured}
  kRATCPIPNotConfigured         = -7125; //* TCP/IP not configured, could be loaded*/
  {$EXTERNALSYM kRANotPrimaryInterface}
  kRANotPrimaryInterface        = -7126; //* when IPCP is not primary TCP/IP intf.*/
  {$EXTERNALSYM kRAConfigurationDBInitErr}
  kRAConfigurationDBInitErr     = -7127;
  {$EXTERNALSYM kRAPPPProtocolRejected}
  kRAPPPProtocolRejected        = -7128;
  {$EXTERNALSYM kRAPPPAuthenticationFailed}
  kRAPPPAuthenticationFailed    = -7129;
  {$EXTERNALSYM kRAPPPNegotiationFailed}
  kRAPPPNegotiationFailed       = -7130;
  {$EXTERNALSYM kRAPPPUserDisconnected}
  kRAPPPUserDisconnected        = -7131;
  {$EXTERNALSYM kRAPPPPeerDisconnected}
  kRAPPPPeerDisconnected        = -7132;
  {$EXTERNALSYM kRAPeerNotResponding}
  kRAPeerNotResponding          = -7133;
  {$EXTERNALSYM kRAATalkInactive}
  kRAATalkInactive              = -7134;
  {$EXTERNALSYM kRAExtAuthenticationFailed}
  kRAExtAuthenticationFailed    = -7135;
  {$EXTERNALSYM kRANCPRejectedbyPeer}
  kRANCPRejectedbyPeer          = -7136;
  {$EXTERNALSYM kRADuplicateIPAddr}
  kRADuplicateIPAddr            = -7137;
  {$EXTERNALSYM kRACallBackFailed}
  kRACallBackFailed             = -7138;
  {$EXTERNALSYM kRANotEnabled}
  kRANotEnabled                 = -7139;
//};






//* ATSUI Error Codes - Range 1 of 2*/


//enum {
  {$EXTERNALSYM kATSUInvalidTextLayoutErr}
  kATSUInvalidTextLayoutErr     = -8790; //*    An attempt was made to use a ATSUTextLayout */
                                        //*    which hadn't been initialized or is otherwise */
                                        //*    in an invalid state. */
  {$EXTERNALSYM kATSUInvalidStyleErr}
  kATSUInvalidStyleErr          = -8791; //*    An attempt was made to use a ATSUStyle which  */
                                        //*    hadn't been properly allocated or is otherwise  */
                                        //*    in an invalid state.  */
  {$EXTERNALSYM kATSUInvalidTextRangeErr}
  kATSUInvalidTextRangeErr      = -8792; //*    An attempt was made to extract information   */
                                        //*    from or perform an operation on a ATSUTextLayout */
                                        //*    for a range of text not covered by the ATSUTextLayout.  */
  {$EXTERNALSYM kATSUFontsMatched}
  kATSUFontsMatched             = -8793; //*    This is not an error code but is returned by    */
                                        //*    ATSUMatchFontsToText() when changes need to    */
                                        //*    be made to the fonts associated with the text.  */
  {$EXTERNALSYM kATSUFontsNotMatched}
  kATSUFontsNotMatched          = -8794; //*    This value is returned by ATSUMatchFontsToText()    */
                                        //*    when the text contains Unicode characters which    */
                                        //*    cannot be represented by any installed font.  */
  {$EXTERNALSYM kATSUNoCorrespondingFontErr}
  kATSUNoCorrespondingFontErr   = -8795; //*    This value is retrned by font ID conversion */
                                        //*    routines ATSUFONDtoFontID() and ATSUFontIDtoFOND() */
                                        //*    to indicate that the input font ID is valid but */
                                        //*    there is no conversion possible.  For example, */
                                        //*    data-fork fonts can only be used with ATSUI not */
                                        //*    the FontManager, and so converting an ATSUIFontID */
                                        //*    for such a font will fail.   */
  {$EXTERNALSYM kATSUInvalidFontErr}
  kATSUInvalidFontErr           = -8796; //*    Used when an attempt was made to use an invalid font ID.*/
  {$EXTERNALSYM kATSUInvalidAttributeValueErr}
  kATSUInvalidAttributeValueErr = -8797; //*    Used when an attempt was made to use an attribute with */
                                        //*    a bad or undefined value.  */
  {$EXTERNALSYM kATSUInvalidAttributeSizeErr}
  kATSUInvalidAttributeSizeErr  = -8798; //*    Used when an attempt was made to use an attribute with a */
                                        //*    bad size.  */
  {$EXTERNALSYM kATSUInvalidAttributeTagErr}
  kATSUInvalidAttributeTagErr   = -8799; //*    Used when an attempt was made to use a tag value that*/
                                        //*    was not appropriate for the function call it was used.  */
  {$EXTERNALSYM kATSUInvalidCacheErr}
  kATSUInvalidCacheErr          = -8800; //*    Used when an attempt was made to read in style data */
                                        //*    from an invalid cache.  Either the format of the */
                                        //*    cached data doesn't match that used by Apple Type */
                                        //*    Services for Unicode™ Imaging, or the cached data */
                                        //*    is corrupt.  */
  {$EXTERNALSYM kATSUNotSetErr}
  kATSUNotSetErr                = -8801; //*    Used when the client attempts to retrieve an attribute, */
                                        //*    font feature, or font variation from a style when it */
                                        //*    hadn't been set.  In such a case, the default value will*/
                                        //*    be returned for the attribute's value.*/
  {$EXTERNALSYM kATSUNoStyleRunsAssignedErr}
  kATSUNoStyleRunsAssignedErr   = -8802; //*    Used when an attempt was made to measure, highlight or draw*/
                                        //*    a ATSUTextLayout object that has no styleRuns associated with it.*/
  {$EXTERNALSYM kATSUQuickDrawTextErr}
  kATSUQuickDrawTextErr         = -8803; //*    Used when QuickDraw Text encounters an error rendering or measuring*/
                                        //*    a line of ATSUI text.*/
  {$EXTERNALSYM kATSULowLevelErr}
  kATSULowLevelErr              = -8804; //*    Used when an error was encountered within the low level ATS */
                                        //*    mechanism performing an operation requested by ATSUI.*/
  {$EXTERNALSYM kATSUNoFontCmapAvailableErr}
  kATSUNoFontCmapAvailableErr   = -8805; //*    Used when no CMAP table can be accessed or synthesized for the */
                                        //*    font passed into a SetAttributes Font call.*/
  {$EXTERNALSYM kATSUNoFontScalerAvailableErr}
  kATSUNoFontScalerAvailableErr = -8806; //*    Used when no font scaler is available for the font passed*/
                                        //*    into a SetAttributes Font call.*/
  {$EXTERNALSYM kATSUCoordinateOverflowErr}
  kATSUCoordinateOverflowErr    = -8807; //*    Used to indicate the coordinates provided to an ATSUI routine caused*/
                                        //*    a coordinate overflow (i.e. > 32K).*/
  {$EXTERNALSYM kATSULineBreakInWord}
  kATSULineBreakInWord          = -8808; //*    This is not an error code but is returned by ATSUBreakLine to */
                                        //*    indicate that the returned offset is within a word since there was*/
                                        //*    only less than one word that could fit the requested width.*/
  {$EXTERNALSYM kATSUBusyObjectErr}
  kATSUBusyObjectErr            = -8809; //*    An ATSUI object is being used by another thread */
//};

{*
   kATSUInvalidFontFallbacksErr, which had formerly occupied -8810 has been relocated to error code -8900. See
   below in this range for additional error codes.
*}


//* Error & status codes for general text and text encoding conversion*/

//enum {
                                        //* general text errors*/
  {$EXTERNALSYM kTextUnsupportedEncodingErr}
  kTextUnsupportedEncodingErr   = -8738; //* specified encoding not supported for this operation*/
  {$EXTERNALSYM kTextMalformedInputErr}
  kTextMalformedInputErr        = -8739; //* in DBCS, for example, high byte followed by invalid low byte*/
  {$EXTERNALSYM kTextUndefinedElementErr}
  kTextUndefinedElementErr      = -8740; //* text conversion errors*/
  {$EXTERNALSYM kTECMissingTableErr}
  kTECMissingTableErr           = -8745;
  {$EXTERNALSYM kTECTableChecksumErr}
  kTECTableChecksumErr          = -8746;
  {$EXTERNALSYM kTECTableFormatErr}
  kTECTableFormatErr            = -8747;
  {$EXTERNALSYM kTECCorruptConverterErr}
  kTECCorruptConverterErr       = -8748; //* invalid converter object reference*/
  {$EXTERNALSYM kTECNoConversionPathErr}
  kTECNoConversionPathErr       = -8749;
  {$EXTERNALSYM kTECBufferBelowMinimumSizeErr}
  kTECBufferBelowMinimumSizeErr = -8750; //* output buffer too small to allow processing of first input text element*/
  {$EXTERNALSYM kTECArrayFullErr}
  kTECArrayFullErr              = -8751; //* supplied name buffer or TextRun, TextEncoding, or UnicodeMapping array is too small*/
  {$EXTERNALSYM kTECBadTextRunErr}
  kTECBadTextRunErr             = -8752;
  {$EXTERNALSYM kTECPartialCharErr}
  kTECPartialCharErr            = -8753; //* input buffer ends in the middle of a multibyte character, conversion stopped*/
  {$EXTERNALSYM kTECUnmappableElementErr}
  kTECUnmappableElementErr      = -8754;
  {$EXTERNALSYM kTECIncompleteElementErr}
  kTECIncompleteElementErr      = -8755; //* text element may be incomplete or is too long for internal buffers*/
  {$EXTERNALSYM kTECDirectionErr}
  kTECDirectionErr              = -8756; //* direction stack overflow, etc.*/
  {$EXTERNALSYM kTECGlobalsUnavailableErr}
  kTECGlobalsUnavailableErr     = -8770; //* globals have already been deallocated (premature TERM)*/
  {$EXTERNALSYM kTECItemUnavailableErr}
  kTECItemUnavailableErr        = -8771; //* item (e.g. name) not available for specified region (& encoding if relevant)*/
                                        //* text conversion status codes*/
  {$EXTERNALSYM kTECUsedFallbacksStatus}
  kTECUsedFallbacksStatus       = -8783;
  {$EXTERNALSYM kTECNeedFlushStatus}
  kTECNeedFlushStatus           = -8784;
  {$EXTERNALSYM kTECOutputBufferFullStatus}
  kTECOutputBufferFullStatus    = -8785; //* output buffer has no room for conversion of next input text element (partial conversion)*/
                                        //* deprecated error & status codes for low-level converter*/
  {$EXTERNALSYM unicodeChecksumErr}
  unicodeChecksumErr            = -8769;
  {$EXTERNALSYM unicodeNoTableErr}
  unicodeNoTableErr             = -8768;
  {$EXTERNALSYM unicodeVariantErr}
  unicodeVariantErr             = -8767;
  {$EXTERNALSYM unicodeFallbacksErr}
  unicodeFallbacksErr           = -8766;
  {$EXTERNALSYM unicodePartConvertErr}
  unicodePartConvertErr         = -8765;
  {$EXTERNALSYM unicodeBufErr}
  unicodeBufErr                 = -8764;
  {$EXTERNALSYM unicodeCharErr}
  unicodeCharErr                = -8763;
  {$EXTERNALSYM unicodeElementErr}
  unicodeElementErr             = -8762;
  {$EXTERNALSYM unicodeNotFoundErr}
  unicodeNotFoundErr            = -8761;
  {$EXTERNALSYM unicodeTableFormatErr}
  unicodeTableFormatErr         = -8760;
  {$EXTERNALSYM unicodeDirectionErr}
  unicodeDirectionErr           = -8759;
  {$EXTERNALSYM unicodeContextualErr}
  unicodeContextualErr          = -8758;
  {$EXTERNALSYM unicodeTextEncodingDataErr}
  unicodeTextEncodingDataErr    = -8757;
//};


//* UTCUtils Status Codes */
//enum {
  {$EXTERNALSYM kUTCUnderflowErr}
  kUTCUnderflowErr              = -8850;
  {$EXTERNALSYM kUTCOverflowErr}
  kUTCOverflowErr               = -8851;
  {$EXTERNALSYM kIllegalClockValueErr}
  kIllegalClockValueErr         = -8852;
//};


//* ATSUI Error Codes - Range 2 of 2*/


//enum {
  {$EXTERNALSYM kATSUInvalidFontFallbacksErr}
  kATSUInvalidFontFallbacksErr  = -8900; //*    An attempt was made to use a ATSUFontFallbacks which hadn't */
                                        //*    been initialized or is otherwise in an invalid state. */
  {$EXTERNALSYM kATSUUnsupportedStreamFormatErr}
  kATSUUnsupportedStreamFormatErr = -8901; //*    An attempt was made to use a ATSUFlattenedDataStreamFormat*/
                                        //*    which is invalid is not compatible with this version of ATSUI.*/
  {$EXTERNALSYM kATSUBadStreamErr}
  kATSUBadStreamErr             = -8902; //*    An attempt was made to use a stream which is incorrectly*/
                                        //*    structured, contains bad or out of range values or is*/
                                        //*    missing required information.*/
  {$EXTERNALSYM kATSUOutputBufferTooSmallErr}
  kATSUOutputBufferTooSmallErr  = -8903; //*    An attempt was made to use an output buffer which was too small*/
                                        //*    for the requested operation.*/
  {$EXTERNALSYM kATSUInvalidCallInsideCallbackErr}
  kATSUInvalidCallInsideCallbackErr = -8904; //*    A call was made within the context of a callback that could*/
                                        //*    potetially cause an infinite recursion*/
  {$EXTERNALSYM kATSUNoFontNameErr}
  kATSUNoFontNameErr            = -8905; //*    This error is returned when either ATSUFindFontName() or ATSUGetIndFontName() */
                                        //*    function cannot find a corresponding font name given the input parameters*/
  {$EXTERNALSYM kATSULastErr}
  kATSULastErr                  = -8959; //*    The last ATSUI error code.*/
//};


//* QuickTime errors (Image Compression Manager) */
//enum {
  {$EXTERNALSYM codecErr}
  codecErr                      = -8960;
  {$EXTERNALSYM noCodecErr}
  noCodecErr                    = -8961;
  {$EXTERNALSYM codecUnimpErr}
  codecUnimpErr                 = -8962;
  {$EXTERNALSYM codecSizeErr}
  codecSizeErr                  = -8963;
  {$EXTERNALSYM codecScreenBufErr}
  codecScreenBufErr             = -8964;
  {$EXTERNALSYM codecImageBufErr}
  codecImageBufErr              = -8965;
  {$EXTERNALSYM codecSpoolErr}
  codecSpoolErr                 = -8966;
  {$EXTERNALSYM codecAbortErr}
  codecAbortErr                 = -8967;
  {$EXTERNALSYM codecWouldOffscreenErr}
  codecWouldOffscreenErr        = -8968;
  {$EXTERNALSYM codecBadDataErr}
  codecBadDataErr               = -8969;
  {$EXTERNALSYM codecDataVersErr}
  codecDataVersErr              = -8970;
  {$EXTERNALSYM codecExtensionNotFoundErr}
  codecExtensionNotFoundErr     = -8971;
  {$EXTERNALSYM scTypeNotFoundErr}
  scTypeNotFoundErr             = codecExtensionNotFoundErr;
  {$EXTERNALSYM codecConditionErr}
  codecConditionErr             = -8972;
  {$EXTERNALSYM codecOpenErr}
  codecOpenErr                  = -8973;
  {$EXTERNALSYM codecCantWhenErr}
  codecCantWhenErr              = -8974;
  {$EXTERNALSYM codecCantQueueErr}
  codecCantQueueErr             = -8975;
  {$EXTERNALSYM codecNothingToBlitErr}
  codecNothingToBlitErr         = -8976;
  {$EXTERNALSYM codecNoMemoryPleaseWaitErr}
  codecNoMemoryPleaseWaitErr    = -8977;
  {$EXTERNALSYM codecDisabledErr}
  codecDisabledErr              = -8978; //* codec disabled itself -- pass codecFlagReenable to reset*/
  {$EXTERNALSYM codecNeedToFlushChainErr}
  codecNeedToFlushChainErr      = -8979;
  {$EXTERNALSYM lockPortBitsBadSurfaceErr}
  lockPortBitsBadSurfaceErr     = -8980;
  {$EXTERNALSYM lockPortBitsWindowMovedErr}
  lockPortBitsWindowMovedErr    = -8981;
  {$EXTERNALSYM lockPortBitsWindowResizedErr}
  lockPortBitsWindowResizedErr  = -8982;
  {$EXTERNALSYM lockPortBitsWindowClippedErr}
  lockPortBitsWindowClippedErr  = -8983;
  {$EXTERNALSYM lockPortBitsBadPortErr}
  lockPortBitsBadPortErr        = -8984;
  {$EXTERNALSYM lockPortBitsSurfaceLostErr}
  lockPortBitsSurfaceLostErr    = -8985;
  {$EXTERNALSYM codecParameterDialogConfirm}
  codecParameterDialogConfirm   = -8986;
  {$EXTERNALSYM codecNeedAccessKeyErr}
  codecNeedAccessKeyErr         = -8987; //* codec needs password in order to decompress*/
  {$EXTERNALSYM codecOffscreenFailedErr}
  codecOffscreenFailedErr       = -8988;
  {$EXTERNALSYM codecDroppedFrameErr}
  codecDroppedFrameErr          = -8989; //* returned from ImageCodecDrawBand */
  {$EXTERNALSYM directXObjectAlreadyExists}
  directXObjectAlreadyExists    = -8990;
  {$EXTERNALSYM lockPortBitsWrongGDeviceErr}
  lockPortBitsWrongGDeviceErr   = -8991;
  {$EXTERNALSYM codecOffscreenFailedPleaseRetryErr}
  codecOffscreenFailedPleaseRetryErr = -8992;
  {$EXTERNALSYM badCodecCharacterizationErr}
  badCodecCharacterizationErr   = -8993;
  {$EXTERNALSYM noThumbnailFoundErr}
  noThumbnailFoundErr           = -8994;
//};


//* PCCard error codes */
//enum {
  {$EXTERNALSYM kBadAdapterErr}
  kBadAdapterErr                = -9050; //* invalid adapter number*/
  {$EXTERNALSYM kBadAttributeErr}
  kBadAttributeErr              = -9051; //* specified attributes field value is invalid*/
  {$EXTERNALSYM kBadBaseErr}
  kBadBaseErr                   = -9052; //* specified base system memory address is invalid*/
  {$EXTERNALSYM kBadEDCErr}
  kBadEDCErr                    = -9053; //* specified EDC generator specified is invalid*/
  {$EXTERNALSYM kBadIRQErr}
  kBadIRQErr                    = -9054; //* specified IRQ level is invalid*/
  {$EXTERNALSYM kBadOffsetErr}
  kBadOffsetErr                 = -9055; //* specified PC card memory array offset is invalid*/
  {$EXTERNALSYM kBadPageErr}
  kBadPageErr                   = -9056; //* specified page is invalid*/
  {$EXTERNALSYM kBadSizeErr}
  kBadSizeErr                   = -9057; //* specified size is invalid*/
  {$EXTERNALSYM kBadSocketErr}
  kBadSocketErr                 = -9058; //* specified logical or physical socket number is invalid*/
  {$EXTERNALSYM kBadTypeErr}
  kBadTypeErr                   = -9059; //* specified window or interface type is invalid*/
  {$EXTERNALSYM kBadVccErr}
  kBadVccErr                    = -9060; //* specified Vcc power level index is invalid*/
  {$EXTERNALSYM kBadVppErr}
  kBadVppErr                    = -9061; //* specified Vpp1 or Vpp2 power level index is invalid*/
  {$EXTERNALSYM kBadWindowErr}
  kBadWindowErr                 = -9062; //* specified window is invalid*/
  {$EXTERNALSYM kBadArgLengthErr}
  kBadArgLengthErr              = -9063; //* ArgLength argument is invalid*/
  {$EXTERNALSYM kBadArgsErr}
  kBadArgsErr                   = -9064; //* values in argument packet are invalid*/
  {$EXTERNALSYM kBadHandleErr}
  kBadHandleErr                 = -9065; //* clientHandle is invalid*/
  {$EXTERNALSYM kBadCISErr}
  kBadCISErr                    = -9066; //* CIS on card is invalid*/
  {$EXTERNALSYM kBadSpeedErr}
  kBadSpeedErr                  = -9067; //* specified speed is unavailable*/
  {$EXTERNALSYM kReadFailureErr}
  kReadFailureErr               = -9068; //* unable to complete read request*/
  {$EXTERNALSYM kWriteFailureErr}
  kWriteFailureErr              = -9069; //* unable to complete write request*/
  {$EXTERNALSYM kGeneralFailureErr}
  kGeneralFailureErr            = -9070; //* an undefined error has occurred*/
  {$EXTERNALSYM kNoCardErr}
  kNoCardErr                    = -9071; //* no PC card in the socket*/
  {$EXTERNALSYM kUnsupportedFunctionErr}
  kUnsupportedFunctionErr       = -9072; //* function is not supported by this implementation*/
  {$EXTERNALSYM kUnsupportedModeErr}
  kUnsupportedModeErr           = -9073; //* mode is not supported*/
  {$EXTERNALSYM kBusyErr}
  kBusyErr                      = -9074; //* unable to process request at this time - try later*/
  {$EXTERNALSYM kWriteProtectedErr}
  kWriteProtectedErr            = -9075; //* media is write-protected*/
  {$EXTERNALSYM kConfigurationLockedErr}
  kConfigurationLockedErr       = -9076; //* a configuration has already been locked*/
  {$EXTERNALSYM kInUseErr}
  kInUseErr                     = -9077; //* requested resource is being used by a client*/
  {$EXTERNALSYM kNoMoreItemsErr}
  kNoMoreItemsErr               = -9078; //* there are no more of the requested item*/
  {$EXTERNALSYM kOutOfResourceErr}
  kOutOfResourceErr             = -9079; //* Card Services has exhausted the resource*/
  {$EXTERNALSYM kNoCardSevicesSocketsErr}
  kNoCardSevicesSocketsErr      = -9080;
  {$EXTERNALSYM kInvalidRegEntryErr}
  kInvalidRegEntryErr           = -9081;
  {$EXTERNALSYM kBadLinkErr}
  kBadLinkErr                   = -9082;
  {$EXTERNALSYM kBadDeviceErr}
  kBadDeviceErr                 = -9083;
  {$EXTERNALSYM k16BitCardErr}
  k16BitCardErr                 = -9084;
  {$EXTERNALSYM kCardBusCardErr}
  kCardBusCardErr               = -9085;
  {$EXTERNALSYM kPassCallToChainErr}
  kPassCallToChainErr           = -9086;
  {$EXTERNALSYM kCantConfigureCardErr}
  kCantConfigureCardErr         = -9087;
  {$EXTERNALSYM kPostCardEventErr}
  kPostCardEventErr             = -9088; //* _PCCSLPostCardEvent failed and dropped an event */
  {$EXTERNALSYM kInvalidDeviceNumber}
  kInvalidDeviceNumber          = -9089;
  {$EXTERNALSYM kUnsupportedVsErr}
  kUnsupportedVsErr             = -9090; //* Unsupported Voltage Sense */
  {$EXTERNALSYM kInvalidCSClientErr}
  kInvalidCSClientErr           = -9091; //* Card Services ClientID is not registered */
  {$EXTERNALSYM kBadTupleDataErr}
  kBadTupleDataErr              = -9092; //* Data in tuple is invalid */
  {$EXTERNALSYM kBadCustomIFIDErr}
  kBadCustomIFIDErr             = -9093; //* Custom interface ID is invalid */
  {$EXTERNALSYM kNoIOWindowRequestedErr}
  kNoIOWindowRequestedErr       = -9094; //* Request I/O window before calling configuration */
  {$EXTERNALSYM kNoMoreTimerClientsErr}
  kNoMoreTimerClientsErr        = -9095; //* All timer callbacks are in use */
  {$EXTERNALSYM kNoMoreInterruptSlotsErr}
  kNoMoreInterruptSlotsErr      = -9096; //* All internal Interrupt slots are in use */
  {$EXTERNALSYM kNoClientTableErr}
  kNoClientTableErr             = -9097; //* The client table has not be initialized yet */
  {$EXTERNALSYM kUnsupportedCardErr}
  kUnsupportedCardErr           = -9098; //* Card not supported by generic enabler*/
  {$EXTERNALSYM kNoCardEnablersFoundErr}
  kNoCardEnablersFoundErr       = -9099; //* No Enablers were found*/
  {$EXTERNALSYM kNoEnablerForCardErr}
  kNoEnablerForCardErr          = -9100; //* No Enablers were found that can support the card*/
  {$EXTERNALSYM kNoCompatibleNameErr}
  kNoCompatibleNameErr          = -9101; //* There is no compatible driver name for this device*/
  {$EXTERNALSYM kClientRequestDenied}
  kClientRequestDenied          = -9102; //* CS Clients should return this code inorder to */
                                        //*   deny a request-type CS Event                */
  {$EXTERNALSYM kNotReadyErr}
  kNotReadyErr                  = -9103; //* PC Card failed to go ready */
  {$EXTERNALSYM kTooManyIOWindowsErr}
  kTooManyIOWindowsErr          = -9104; //* device requested more than one I/O window */
  {$EXTERNALSYM kAlreadySavedStateErr}
  kAlreadySavedStateErr         = -9105; //* The state has been saved on previous call */
  {$EXTERNALSYM kAttemptDupCardEntryErr}
  kAttemptDupCardEntryErr       = -9106; //* The Enabler was asked to create a duplicate card entry */
  {$EXTERNALSYM kCardPowerOffErr}
  kCardPowerOffErr              = -9107; //* Power to the card has been turned off */
  {$EXTERNALSYM kNotZVCapableErr}
  kNotZVCapableErr              = -9108; //* This socket does not support Zoomed Video */
  {$EXTERNALSYM kNoCardBusCISErr}
  kNoCardBusCISErr              = -9109; //* No valid CIS exists for this CardBus card */
//};


//enum {
  {$EXTERNALSYM noDeviceForChannel}
  noDeviceForChannel            = -9400;
  {$EXTERNALSYM grabTimeComplete}
  grabTimeComplete              = -9401;
  {$EXTERNALSYM cantDoThatInCurrentMode}
  cantDoThatInCurrentMode       = -9402;
  {$EXTERNALSYM notEnoughMemoryToGrab}
  notEnoughMemoryToGrab         = -9403;
  {$EXTERNALSYM notEnoughDiskSpaceToGrab}
  notEnoughDiskSpaceToGrab      = -9404;
  {$EXTERNALSYM couldntGetRequiredComponent}
  couldntGetRequiredComponent   = -9405;
  {$EXTERNALSYM badSGChannel}
  badSGChannel                  = -9406;
  {$EXTERNALSYM seqGrabInfoNotAvailable}
  seqGrabInfoNotAvailable       = -9407;
  {$EXTERNALSYM deviceCantMeetRequest}
  deviceCantMeetRequest         = -9408;
  {$EXTERNALSYM badControllerHeight}
  badControllerHeight           = -9994;
  {$EXTERNALSYM editingNotAllowed}
  editingNotAllowed             = -9995;
  {$EXTERNALSYM controllerBoundsNotExact}
  controllerBoundsNotExact      = -9996;
  {$EXTERNALSYM cannotSetWidthOfAttachedController}
  cannotSetWidthOfAttachedController = -9997;
  {$EXTERNALSYM controllerHasFixedHeight}
  controllerHasFixedHeight      = -9998;
  {$EXTERNALSYM cannotMoveAttachedController}
  cannotMoveAttachedController  = -9999;
//};

//* AERegistry Errors */
//enum {
  {$EXTERNALSYM errAEBadKeyForm}
  errAEBadKeyForm               = -10002;
  {$EXTERNALSYM errAECantHandleClass}
  errAECantHandleClass          = -10010;
  {$EXTERNALSYM errAECantSupplyType}
  errAECantSupplyType           = -10009;
  {$EXTERNALSYM errAECantUndo}
  errAECantUndo                 = -10015;
  {$EXTERNALSYM errAEEventFailed}
  errAEEventFailed              = -10000;
  {$EXTERNALSYM errAEIndexTooLarge}
  errAEIndexTooLarge            = -10007;
  {$EXTERNALSYM errAEInTransaction}
  errAEInTransaction            = -10011;
  {$EXTERNALSYM errAELocalOnly}
  errAELocalOnly                = -10016;
  {$EXTERNALSYM errAENoSuchTransaction}
  errAENoSuchTransaction        = -10012;
  {$EXTERNALSYM errAENotAnElement}
  errAENotAnElement             = -10008;
  {$EXTERNALSYM errAENotASingleObject}
  errAENotASingleObject         = -10014;
  {$EXTERNALSYM errAENotModifiable}
  errAENotModifiable            = -10003;
  {$EXTERNALSYM errAENoUserSelection}
  errAENoUserSelection          = -10013;
  {$EXTERNALSYM errAEPrivilegeError}
  errAEPrivilegeError           = -10004;
  {$EXTERNALSYM errAEReadDenied}
  errAEReadDenied               = -10005;
  {$EXTERNALSYM errAETypeError}
  errAETypeError                = -10001;
  {$EXTERNALSYM errAEWriteDenied}
  errAEWriteDenied              = -10006;
  {$EXTERNALSYM errAENotAnEnumMember}
  errAENotAnEnumMember          = -10023; //* enumerated value in SetData is not allowed for this property */
  {$EXTERNALSYM errAECantPutThatThere}
  errAECantPutThatThere         = -10024; //* in make new, duplicate, etc. class can't be an element of container */
  {$EXTERNALSYM errAEPropertiesClash}
  errAEPropertiesClash          = -10025; //* illegal combination of properties settings for Set Data, make new, or duplicate */
//};

//* TELErr */
//enum {
  {$EXTERNALSYM telGenericError}
  telGenericError               = -1;
  {$EXTERNALSYM telNoErr}
  telNoErr                      = 0;
  {$EXTERNALSYM telNoTools}
  telNoTools                    = 8;    //* no telephone tools found in extension folder */
  {$EXTERNALSYM telBadTermErr}
  telBadTermErr                 = -10001; //* invalid TELHandle or handle not found*/
  {$EXTERNALSYM telBadDNErr}
  telBadDNErr                   = -10002; //* TELDNHandle not found or invalid */
  {$EXTERNALSYM telBadCAErr}
  telBadCAErr                   = -10003; //* TELCAHandle not found or invalid */
  {$EXTERNALSYM telBadHandErr}
  telBadHandErr                 = -10004; //* bad handle specified */
  {$EXTERNALSYM telBadProcErr}
  telBadProcErr                 = -10005; //* bad msgProc specified */
  {$EXTERNALSYM telCAUnavail}
  telCAUnavail                  = -10006; //* a CA is not available */
  {$EXTERNALSYM telNoMemErr}
  telNoMemErr                   = -10007; //* no memory to allocate handle */
  {$EXTERNALSYM telNoOpenErr}
  telNoOpenErr                  = -10008; //* unable to open terminal */
  {$EXTERNALSYM telBadHTypeErr}
  telBadHTypeErr                = -10010; //* bad hook type specified */
  {$EXTERNALSYM telHTypeNotSupp}
  telHTypeNotSupp               = -10011; //* hook type not supported by this tool */
  {$EXTERNALSYM telBadLevelErr}
  telBadLevelErr                = -10012; //* bad volume level setting */
  {$EXTERNALSYM telBadVTypeErr}
  telBadVTypeErr                = -10013; //* bad volume type error */
  {$EXTERNALSYM telVTypeNotSupp}
  telVTypeNotSupp               = -10014; //* volume type not supported by this tool*/
  {$EXTERNALSYM telBadAPattErr}
  telBadAPattErr                = -10015; //* bad alerting pattern specified */
  {$EXTERNALSYM telAPattNotSupp}
  telAPattNotSupp               = -10016; //* alerting pattern not supported by tool*/
  {$EXTERNALSYM telBadIndex}
  telBadIndex                   = -10017; //* bad index specified */
  {$EXTERNALSYM telIndexNotSupp}
  telIndexNotSupp               = -10018; //* index not supported by this tool */
  {$EXTERNALSYM telBadStateErr}
  telBadStateErr                = -10019; //* bad device state specified */
  {$EXTERNALSYM telStateNotSupp}
  telStateNotSupp               = -10020; //* device state not supported by tool */
  {$EXTERNALSYM telBadIntExt}
  telBadIntExt                  = -10021; //* bad internal external error */
  {$EXTERNALSYM telIntExtNotSupp}
  telIntExtNotSupp              = -10022; //* internal external type not supported by this tool */
  {$EXTERNALSYM telBadDNDType}
  telBadDNDType                 = -10023; //* bad DND type specified */
  {$EXTERNALSYM telDNDTypeNotSupp}
  telDNDTypeNotSupp             = -10024; //* DND type is not supported by this tool */
  {$EXTERNALSYM telFeatNotSub}
  telFeatNotSub                 = -10030; //* feature not subscribed */
  {$EXTERNALSYM telFeatNotAvail}
  telFeatNotAvail               = -10031; //* feature subscribed but not available */
  {$EXTERNALSYM telFeatActive}
  telFeatActive                 = -10032; //* feature already active */
  {$EXTERNALSYM telFeatNotSupp}
  telFeatNotSupp                = -10033; //* feature program call not supported by this tool */
  {$EXTERNALSYM telConfLimitErr}
  telConfLimitErr               = -10040; //* limit specified is too high for this configuration */
  {$EXTERNALSYM telConfNoLimit}
  telConfNoLimit                = -10041; //* no limit was specified but required*/
  {$EXTERNALSYM telConfErr}
  telConfErr                    = -10042; //* conference was not prepared */
  {$EXTERNALSYM telConfRej}
  telConfRej                    = -10043; //* conference request was rejected */
  {$EXTERNALSYM telTransferErr}
  telTransferErr                = -10044; //* transfer not prepared */
  {$EXTERNALSYM telTransferRej}
  telTransferRej                = -10045; //* transfer request rejected */
  {$EXTERNALSYM telCBErr}
  telCBErr                      = -10046; //* call back feature not set previously */
  {$EXTERNALSYM telConfLimitExceeded}
  telConfLimitExceeded          = -10047; //* attempt to exceed switch conference limits */
  {$EXTERNALSYM telBadDNType}
  telBadDNType                  = -10050; //* DN type invalid */
  {$EXTERNALSYM telBadPageID}
  telBadPageID                  = -10051; //* bad page ID specified*/
  {$EXTERNALSYM telBadIntercomID}
  telBadIntercomID              = -10052; //* bad intercom ID specified */
  {$EXTERNALSYM telBadFeatureID}
  telBadFeatureID               = -10053; //* bad feature ID specified */
  {$EXTERNALSYM telBadFwdType}
  telBadFwdType                 = -10054; //* bad fwdType specified */
  {$EXTERNALSYM telBadPickupGroupID}
  telBadPickupGroupID           = -10055; //* bad pickup group ID specified */
  {$EXTERNALSYM telBadParkID}
  telBadParkID                  = -10056; //* bad park id specified */
  {$EXTERNALSYM telBadSelect}
  telBadSelect                  = -10057; //* unable to select or deselect DN */
  {$EXTERNALSYM telBadBearerType}
  telBadBearerType              = -10058; //* bad bearerType specified */
  {$EXTERNALSYM telBadRate}
  telBadRate                    = -10059; //* bad rate specified */
  {$EXTERNALSYM telDNTypeNotSupp}
  telDNTypeNotSupp              = -10060; //* DN type not supported by tool */
  {$EXTERNALSYM telFwdTypeNotSupp}
  telFwdTypeNotSupp             = -10061; //* forward type not supported by tool */
  {$EXTERNALSYM telBadDisplayMode}
  telBadDisplayMode             = -10062; //* bad display mode specified */
  {$EXTERNALSYM telDisplayModeNotSupp}
  telDisplayModeNotSupp         = -10063; //* display mode not supported by tool */
  {$EXTERNALSYM telNoCallbackRef}
  telNoCallbackRef              = -10064; //* no call back reference was specified, but is required */
  {$EXTERNALSYM telAlreadyOpen}
  telAlreadyOpen                = -10070; //* terminal already open */
  {$EXTERNALSYM telStillNeeded}
  telStillNeeded                = -10071; //* terminal driver still needed by someone else */
  {$EXTERNALSYM telTermNotOpen}
  telTermNotOpen                = -10072; //* terminal not opened via TELOpenTerm */
  {$EXTERNALSYM telCANotAcceptable}
  telCANotAcceptable            = -10080; //* CA not "acceptable" */
  {$EXTERNALSYM telCANotRejectable}
  telCANotRejectable            = -10081; //* CA not "rejectable" */
  {$EXTERNALSYM telCANotDeflectable}
  telCANotDeflectable           = -10082; //* CA not "deflectable" */
  {$EXTERNALSYM telPBErr}
  telPBErr                      = -10090; //* parameter block error, bad format */
  {$EXTERNALSYM telBadFunction}
  telBadFunction                = -10091; //* bad msgCode specified */
                                        //*    telNoTools        = -10101,        unable to find any telephone tools */
  {$EXTERNALSYM telNoSuchTool}
  telNoSuchTool                 = -10102; //* unable to find tool with name specified */
  {$EXTERNALSYM telUnknownErr}
  telUnknownErr                 = -10103; //* unable to set config */
  {$EXTERNALSYM telNoCommFolder}
  telNoCommFolder               = -10106; //* Communications/Extensions ƒ not found */
  {$EXTERNALSYM telInitFailed}
  telInitFailed                 = -10107; //* initialization failed */
  {$EXTERNALSYM telBadCodeResource}
  telBadCodeResource            = -10108; //* code resource not found */
  {$EXTERNALSYM telDeviceNotFound}
  telDeviceNotFound             = -10109; //* device not found */
  {$EXTERNALSYM telBadProcID}
  telBadProcID                  = -10110; //* invalid procID */
  {$EXTERNALSYM telValidateFailed}
  telValidateFailed             = -10111; //* telValidate failed */
  {$EXTERNALSYM telAutoAnsNotOn}
  telAutoAnsNotOn               = -10112; //* autoAnswer in not turned on */
  {$EXTERNALSYM telDetAlreadyOn}
  telDetAlreadyOn               = -10113; //* detection is already turned on */
  {$EXTERNALSYM telBadSWErr}
  telBadSWErr                   = -10114; //* Software not installed properly */
  {$EXTERNALSYM telBadSampleRate}
  telBadSampleRate              = -10115; //* incompatible sample rate */
  {$EXTERNALSYM telNotEnoughdspBW}
  telNotEnoughdspBW             = -10116; //* not enough real-time for allocation */
//};

//enum {
  {$EXTERNALSYM errTaskNotFound}
  errTaskNotFound               = -10780; //* no task with that task id exists */
//};


//* Video driver Errorrs -10930 to -10959 */
//* Defined in video.h. */

//enum {
                                        //*Power Manager Errors*/
  {$EXTERNALSYM pmBusyErr}
  pmBusyErr                     = -13000; //*Power Mgr never ready to start handshake*/
  {$EXTERNALSYM pmReplyTOErr}
  pmReplyTOErr                  = -13001; //*Timed out waiting for reply*/
  {$EXTERNALSYM pmSendStartErr}
  pmSendStartErr                = -13002; //*during send, pmgr did not start hs*/
  {$EXTERNALSYM pmSendEndErr}
  pmSendEndErr                  = -13003; //*during send, pmgr did not finish hs*/
  {$EXTERNALSYM pmRecvStartErr}
  pmRecvStartErr                = -13004; //*during receive, pmgr did not start hs*/
  {$EXTERNALSYM pmRecvEndErr}
  pmRecvEndErr                  = -13005; //*during receive, pmgr did not finish hs configured for this connection*/
//};

//*Power Manager 2.0 Errors*/
//enum {
  {$EXTERNALSYM kPowerHandlerExistsForDeviceErr}
  kPowerHandlerExistsForDeviceErr = -13006;
  {$EXTERNALSYM kPowerHandlerNotFoundForDeviceErr}
  kPowerHandlerNotFoundForDeviceErr = -13007;
  {$EXTERNALSYM kPowerHandlerNotFoundForProcErr}
  kPowerHandlerNotFoundForProcErr = -13008;
  {$EXTERNALSYM kPowerMgtMessageNotHandled}
  kPowerMgtMessageNotHandled    = -13009;
  {$EXTERNALSYM kPowerMgtRequestDenied}
  kPowerMgtRequestDenied        = -13010;
  {$EXTERNALSYM kCantReportProcessorTemperatureErr}
  kCantReportProcessorTemperatureErr = -13013;
  {$EXTERNALSYM kProcessorTempRoutineRequiresMPLib2}
  kProcessorTempRoutineRequiresMPLib2 = -13014;
  {$EXTERNALSYM kNoSuchPowerSource}
  kNoSuchPowerSource            = -13020;
  {$EXTERNALSYM kBridgeSoftwareRunningCantSleep}
  kBridgeSoftwareRunningCantSleep = -13038;
//};


//* Debugging library errors */
//enum {
  {$EXTERNALSYM debuggingExecutionContextErr}
  debuggingExecutionContextErr  = -13880; //* routine cannot be called at this time */
  {$EXTERNALSYM debuggingDuplicateSignatureErr}
  debuggingDuplicateSignatureErr = -13881; //* componentSignature already registered */
  {$EXTERNALSYM debuggingDuplicateOptionErr}
  debuggingDuplicateOptionErr   = -13882; //* optionSelectorNum already registered */
  {$EXTERNALSYM debuggingInvalidSignatureErr}
  debuggingInvalidSignatureErr  = -13883; //* componentSignature not registered */
  {$EXTERNALSYM debuggingInvalidOptionErr}
  debuggingInvalidOptionErr     = -13884; //* optionSelectorNum is not registered */
  {$EXTERNALSYM debuggingInvalidNameErr}
  debuggingInvalidNameErr       = -13885; //* componentName or optionName is invalid (NULL) */
  {$EXTERNALSYM debuggingNoCallbackErr}
  debuggingNoCallbackErr        = -13886; //* debugging component has no callback */
  {$EXTERNALSYM debuggingNoMatchErr}
  debuggingNoMatchErr           = -13887; //* debugging component or option not found at this index */
//};


//* HID device driver error codes */
//enum {
  {$EXTERNALSYM kHIDVersionIncompatibleErr}
  kHIDVersionIncompatibleErr    = -13909;
  {$EXTERNALSYM kHIDDeviceNotReady}
  kHIDDeviceNotReady            = -13910; //* The device is still initializing, try again later*/
//};


//* HID error codes */
//enum {
  {$EXTERNALSYM kHIDSuccess}
  kHIDSuccess                   = 0;
  {$EXTERNALSYM kHIDInvalidRangePageErr}
  kHIDInvalidRangePageErr       = -13923;
  {$EXTERNALSYM kHIDReportIDZeroErr}
  kHIDReportIDZeroErr           = -13924;
  {$EXTERNALSYM kHIDReportCountZeroErr}
  kHIDReportCountZeroErr        = -13925;
  {$EXTERNALSYM kHIDReportSizeZeroErr}
  kHIDReportSizeZeroErr         = -13926;
  {$EXTERNALSYM kHIDUnmatchedDesignatorRangeErr}
  kHIDUnmatchedDesignatorRangeErr = -13927;
  {$EXTERNALSYM kHIDUnmatchedStringRangeErr}
  kHIDUnmatchedStringRangeErr   = -13928;
  {$EXTERNALSYM kHIDInvertedUsageRangeErr}
  kHIDInvertedUsageRangeErr     = -13929;
  {$EXTERNALSYM kHIDUnmatchedUsageRangeErr}
  kHIDUnmatchedUsageRangeErr    = -13930;
  {$EXTERNALSYM kHIDInvertedPhysicalRangeErr}
  kHIDInvertedPhysicalRangeErr  = -13931;
  {$EXTERNALSYM kHIDInvertedLogicalRangeErr}
  kHIDInvertedLogicalRangeErr   = -13932;
  {$EXTERNALSYM kHIDBadLogicalMaximumErr}
  kHIDBadLogicalMaximumErr      = -13933;
  {$EXTERNALSYM kHIDBadLogicalMinimumErr}
  kHIDBadLogicalMinimumErr      = -13934;
  {$EXTERNALSYM kHIDUsagePageZeroErr}
  kHIDUsagePageZeroErr          = -13935;
  {$EXTERNALSYM kHIDEndOfDescriptorErr}
  kHIDEndOfDescriptorErr        = -13936;
  {$EXTERNALSYM kHIDNotEnoughMemoryErr}
  kHIDNotEnoughMemoryErr        = -13937;
  {$EXTERNALSYM kHIDBadParameterErr}
  kHIDBadParameterErr           = -13938;
  {$EXTERNALSYM kHIDNullPointerErr}
  kHIDNullPointerErr            = -13939;
  {$EXTERNALSYM kHIDInvalidReportLengthErr}
  kHIDInvalidReportLengthErr    = -13940;
  {$EXTERNALSYM kHIDInvalidReportTypeErr}
  kHIDInvalidReportTypeErr      = -13941;
  {$EXTERNALSYM kHIDBadLogPhysValuesErr}
  kHIDBadLogPhysValuesErr       = -13942;
  {$EXTERNALSYM kHIDIncompatibleReportErr}
  kHIDIncompatibleReportErr     = -13943;
  {$EXTERNALSYM kHIDInvalidPreparsedDataErr}
  kHIDInvalidPreparsedDataErr   = -13944;
  {$EXTERNALSYM kHIDNotValueArrayErr}
  kHIDNotValueArrayErr          = -13945;
  {$EXTERNALSYM kHIDUsageNotFoundErr}
  kHIDUsageNotFoundErr          = -13946;
  {$EXTERNALSYM kHIDValueOutOfRangeErr}
  kHIDValueOutOfRangeErr        = -13947;
  {$EXTERNALSYM kHIDBufferTooSmallErr}
  kHIDBufferTooSmallErr         = -13948;
  {$EXTERNALSYM kHIDNullStateErr}
  kHIDNullStateErr              = -13949;
  {$EXTERNALSYM kHIDBaseError}
  kHIDBaseError                 = -13950;
//};


//* the OT modem module may return the following error codes:*/
//enum {
  {$EXTERNALSYM kModemOutOfMemory}
  kModemOutOfMemory             = -14000;
  {$EXTERNALSYM kModemPreferencesMissing}
  kModemPreferencesMissing      = -14001;
  {$EXTERNALSYM kModemScriptMissing}
  kModemScriptMissing           = -14002;
//};



//* Multilingual Text Engine (MLTE) error codes */
//enum {
  {$EXTERNALSYM kTXNEndIterationErr}
  kTXNEndIterationErr           = -22000; //* Function was not able to iterate through the data contained by a text object*/
  {$EXTERNALSYM kTXNCannotAddFrameErr}
  kTXNCannotAddFrameErr         = -22001; //* Multiple frames are not currently supported in MLTE*/
  {$EXTERNALSYM kTXNInvalidFrameIDErr}
  kTXNInvalidFrameIDErr         = -22002; //* The frame ID is invalid*/
  {$EXTERNALSYM kTXNIllegalToCrossDataBoundariesErr}
  kTXNIllegalToCrossDataBoundariesErr = -22003; //* Offsets specify a range that crosses a data type boundary*/
  {$EXTERNALSYM kTXNUserCanceledOperationErr}
  kTXNUserCanceledOperationErr  = -22004; //* A user canceled an operation before your application completed processing it*/
  {$EXTERNALSYM kTXNBadDefaultFileTypeWarning}
  kTXNBadDefaultFileTypeWarning = -22005; //* The text file is not in the format you specified*/
  {$EXTERNALSYM kTXNCannotSetAutoIndentErr}
  kTXNCannotSetAutoIndentErr    = -22006; //* Auto indentation is not available when word wrapping is enabled*/
  {$EXTERNALSYM kTXNRunIndexOutofBoundsErr}
  kTXNRunIndexOutofBoundsErr    = -22007; //* An index you supplied to a function is out of bounds*/
  {$EXTERNALSYM kTXNNoMatchErr}
  kTXNNoMatchErr                = -22008; //* Returned by TXNFind when a match is not found*/
  {$EXTERNALSYM kTXNAttributeTagInvalidForRunErr}
  kTXNAttributeTagInvalidForRunErr = -22009; //* Tag for a specific run is not valid (the tag's dataValue is set to this)*/
  {$EXTERNALSYM kTXNSomeOrAllTagsInvalidForRunErr}
  kTXNSomeOrAllTagsInvalidForRunErr = -22010; //* At least one of the tags given is invalid*/
  {$EXTERNALSYM kTXNInvalidRunIndex}
  kTXNInvalidRunIndex           = -22011; //* Index is out of range for that run*/
  {$EXTERNALSYM kTXNAlreadyInitializedErr}
  kTXNAlreadyInitializedErr     = -22012; //* You already called the TXNInitTextension function*/
  {$EXTERNALSYM kTXNCannotTurnTSMOffWhenUsingUnicodeErr}
  kTXNCannotTurnTSMOffWhenUsingUnicodeErr = -22013; //* Your application tried to turn off the Text Services Manager when using Unicode*/
  {$EXTERNALSYM kTXNCopyNotAllowedInEchoModeErr}
  kTXNCopyNotAllowedInEchoModeErr = -22014; //* Your application tried to copy text that was in echo mode*/
  {$EXTERNALSYM kTXNDataTypeNotAllowedErr}
  kTXNDataTypeNotAllowedErr     = -22015; //* Your application specified a data type that MLTE does not allow*/
  {$EXTERNALSYM kTXNATSUIIsNotInstalledErr}
  kTXNATSUIIsNotInstalledErr    = -22016; //* Indicates that ATSUI is not installed on the system*/
  {$EXTERNALSYM kTXNOutsideOfLineErr}
  kTXNOutsideOfLineErr          = -22017; //* Indicates a value that is beyond the length of the line*/
  {$EXTERNALSYM kTXNOutsideOfFrameErr}
  kTXNOutsideOfFrameErr         = -22018; //* Indicates a value that is outside of the text object's frame*/
//};




//*Possible errors from the PrinterStatus bottleneck*/
//enum {
  {$EXTERNALSYM printerStatusOpCodeNotSupportedErr}
  printerStatusOpCodeNotSupportedErr = -25280;
//};


//* Keychain Manager error codes */
//enum {
  {$EXTERNALSYM errKCNotAvailable}
  errKCNotAvailable             = -25291;
  {$EXTERNALSYM errKCReadOnly}
  errKCReadOnly                 = -25292;
  {$EXTERNALSYM errKCAuthFailed}
  errKCAuthFailed               = -25293;
  {$EXTERNALSYM errKCNoSuchKeychain}
  errKCNoSuchKeychain           = -25294;
  {$EXTERNALSYM errKCInvalidKeychain}
  errKCInvalidKeychain          = -25295;
  {$EXTERNALSYM errKCDuplicateKeychain}
  errKCDuplicateKeychain        = -25296;
  {$EXTERNALSYM errKCDuplicateCallback}
  errKCDuplicateCallback        = -25297;
  {$EXTERNALSYM errKCInvalidCallback}
  errKCInvalidCallback          = -25298;
  {$EXTERNALSYM errKCDuplicateItem}
  errKCDuplicateItem            = -25299;
  {$EXTERNALSYM errKCItemNotFound}
  errKCItemNotFound             = -25300;
  {$EXTERNALSYM errKCBufferTooSmall}
  errKCBufferTooSmall           = -25301;
  {$EXTERNALSYM errKCDataTooLarge}
  errKCDataTooLarge             = -25302;
  {$EXTERNALSYM errKCNoSuchAttr}
  errKCNoSuchAttr               = -25303;
  {$EXTERNALSYM errKCInvalidItemRef}
  errKCInvalidItemRef           = -25304;
  {$EXTERNALSYM errKCInvalidSearchRef}
  errKCInvalidSearchRef         = -25305;
  {$EXTERNALSYM errKCNoSuchClass}
  errKCNoSuchClass              = -25306;
  {$EXTERNALSYM errKCNoDefaultKeychain}
  errKCNoDefaultKeychain        = -25307;
  {$EXTERNALSYM errKCInteractionNotAllowed}
  errKCInteractionNotAllowed    = -25308;
  {$EXTERNALSYM errKCReadOnlyAttr}
  errKCReadOnlyAttr             = -25309;
  {$EXTERNALSYM errKCWrongKCVersion}
  errKCWrongKCVersion           = -25310;
  {$EXTERNALSYM errKCKeySizeNotAllowed}
  errKCKeySizeNotAllowed        = -25311;
  {$EXTERNALSYM errKCNoStorageModule}
  errKCNoStorageModule          = -25312;
  {$EXTERNALSYM errKCNoCertificateModule}
  errKCNoCertificateModule      = -25313;
  {$EXTERNALSYM errKCNoPolicyModule}
  errKCNoPolicyModule           = -25314;
  {$EXTERNALSYM errKCInteractionRequired}
  errKCInteractionRequired      = -25315;
  {$EXTERNALSYM errKCDataNotAvailable}
  errKCDataNotAvailable         = -25316;
  {$EXTERNALSYM errKCDataNotModifiable}
  errKCDataNotModifiable        = -25317;
  {$EXTERNALSYM errKCCreateChainFailed}
  errKCCreateChainFailed        = -25318;
//};


//* UnicodeUtilities error & status codes*/
//enum {
  {$EXTERNALSYM kUCOutputBufferTooSmall}
  kUCOutputBufferTooSmall       = -25340; //* Output buffer too small for Unicode string result*/
  {$EXTERNALSYM kUCTextBreakLocatorMissingType}
  kUCTextBreakLocatorMissingType = -25341; //* Unicode text break error*/
//};

//enum {
  {$EXTERNALSYM kUCTSNoKeysAddedToObjectErr}
  kUCTSNoKeysAddedToObjectErr   = -25342;
  {$EXTERNALSYM kUCTSSearchListErr}
  kUCTSSearchListErr            = -25343;
//};

//enum {
  {$EXTERNALSYM kUCTokenizerIterationFinished}
  kUCTokenizerIterationFinished = -25344;
  {$EXTERNALSYM kUCTokenizerUnknownLang}
  kUCTokenizerUnknownLang       = -25345;
  {$EXTERNALSYM kUCTokenNotFound}
  kUCTokenNotFound              = -25346;
//};

//* Multiprocessing API error codes*/
//enum {
  {$EXTERNALSYM kMPIterationEndErr}
  kMPIterationEndErr            = -29275;
  {$EXTERNALSYM kMPPrivilegedErr}
  kMPPrivilegedErr              = -29276;
  {$EXTERNALSYM kMPProcessCreatedErr}
  kMPProcessCreatedErr          = -29288;
  {$EXTERNALSYM kMPProcessTerminatedErr}
  kMPProcessTerminatedErr       = -29289;
  {$EXTERNALSYM kMPTaskCreatedErr}
  kMPTaskCreatedErr             = -29290;
  {$EXTERNALSYM kMPTaskBlockedErr}
  kMPTaskBlockedErr             = -29291;
  {$EXTERNALSYM kMPTaskStoppedErr}
  kMPTaskStoppedErr             = -29292; //* A convention used with MPThrowException.*/
  {$EXTERNALSYM kMPBlueBlockingErr}
  kMPBlueBlockingErr            = -29293;
  {$EXTERNALSYM kMPDeletedErr}
  kMPDeletedErr                 = -29295;
  {$EXTERNALSYM kMPTimeoutErr}
  kMPTimeoutErr                 = -29296;
  {$EXTERNALSYM kMPTaskAbortedErr}
  kMPTaskAbortedErr             = -29297;
  {$EXTERNALSYM kMPInsufficientResourcesErr}
  kMPInsufficientResourcesErr   = -29298;
  {$EXTERNALSYM kMPInvalidIDErr}
  kMPInvalidIDErr               = -29299;
//};

//enum {
  {$EXTERNALSYM kMPNanokernelNeedsMemoryErr}
  kMPNanokernelNeedsMemoryErr   = -29294;
//};

//* StringCompare error codes (in TextUtils range)*/
//enum {
  {$EXTERNALSYM kCollateAttributesNotFoundErr}
  kCollateAttributesNotFoundErr = -29500;
  {$EXTERNALSYM kCollateInvalidOptions}
  kCollateInvalidOptions        = -29501;
  {$EXTERNALSYM kCollateMissingUnicodeTableErr}
  kCollateMissingUnicodeTableErr = -29502;
  {$EXTERNALSYM kCollateUnicodeConvertFailedErr}
  kCollateUnicodeConvertFailedErr = -29503;
  {$EXTERNALSYM kCollatePatternNotFoundErr}
  kCollatePatternNotFoundErr    = -29504;
  {$EXTERNALSYM kCollateInvalidChar}
  kCollateInvalidChar           = -29505;
  {$EXTERNALSYM kCollateBufferTooSmall}
  kCollateBufferTooSmall        = -29506;
  {$EXTERNALSYM kCollateInvalidCollationRef}
  kCollateInvalidCollationRef   = -29507;
//};


//* FontSync OSStatus Codes */
//enum {
  {$EXTERNALSYM kFNSInvalidReferenceErr}
  kFNSInvalidReferenceErr       = -29580; //* ref. was NULL or otherwise bad */
  {$EXTERNALSYM kFNSBadReferenceVersionErr}
  kFNSBadReferenceVersionErr    = -29581; //* ref. version is out of known range */
  {$EXTERNALSYM kFNSInvalidProfileErr}
  kFNSInvalidProfileErr         = -29582; //* profile is NULL or otherwise bad */
  {$EXTERNALSYM kFNSBadProfileVersionErr}
  kFNSBadProfileVersionErr      = -29583; //* profile version is out of known range */
  {$EXTERNALSYM kFNSDuplicateReferenceErr}
  kFNSDuplicateReferenceErr     = -29584; //* the ref. being added is already in the profile */
  {$EXTERNALSYM kFNSMismatchErr}
  kFNSMismatchErr               = -29585; //* reference didn't match or wasn't found in profile */
  {$EXTERNALSYM kFNSInsufficientDataErr}
  kFNSInsufficientDataErr       = -29586; //* insufficient data for the operation */
  {$EXTERNALSYM kFNSBadFlattenedSizeErr}
  kFNSBadFlattenedSizeErr       = -29587; //* flattened size didn't match input or was too small */
  {$EXTERNALSYM kFNSNameNotFoundErr}
  kFNSNameNotFoundErr           = -29589; //* The name with the requested paramters was not found */
//};



//* MacLocales error codes*/
//enum {
  {$EXTERNALSYM kLocalesBufferTooSmallErr}
  kLocalesBufferTooSmallErr     = -30001;
  {$EXTERNALSYM kLocalesTableFormatErr}
  kLocalesTableFormatErr        = -30002;
  {$EXTERNALSYM kLocalesDefaultDisplayStatus}
  kLocalesDefaultDisplayStatus  = -30029; //* Requested display locale unavailable, used default*/
//};


//* Settings Manager (formerly known as Location Manager) Errors */
//enum {
  {$EXTERNALSYM kALMInternalErr}
  kALMInternalErr               = -30049;
  {$EXTERNALSYM kALMGroupNotFoundErr}
  kALMGroupNotFoundErr          = -30048;
  {$EXTERNALSYM kALMNoSuchModuleErr}
  kALMNoSuchModuleErr           = -30047;
  {$EXTERNALSYM kALMModuleCommunicationErr}
  kALMModuleCommunicationErr    = -30046;
  {$EXTERNALSYM kALMDuplicateModuleErr}
  kALMDuplicateModuleErr        = -30045;
  {$EXTERNALSYM kALMInstallationErr}
  kALMInstallationErr           = -30044;
  {$EXTERNALSYM kALMDeferSwitchErr}
  kALMDeferSwitchErr            = -30043;
  {$EXTERNALSYM kALMRebootFlagsLevelErr}
  kALMRebootFlagsLevelErr       = -30042;
//};

//enum {
  {$EXTERNALSYM kALMLocationNotFoundErr}
  kALMLocationNotFoundErr       = kALMGroupNotFoundErr; //* Old name */
//};


//* SoundSprocket Error Codes */
//enum {
  {$EXTERNALSYM kSSpInternalErr}
  kSSpInternalErr               = -30340;
  {$EXTERNALSYM kSSpVersionErr}
  kSSpVersionErr                = -30341;
  {$EXTERNALSYM kSSpCantInstallErr}
  kSSpCantInstallErr            = -30342;
  {$EXTERNALSYM kSSpParallelUpVectorErr}
  kSSpParallelUpVectorErr       = -30343;
  {$EXTERNALSYM kSSpScaleToZeroErr}
  kSSpScaleToZeroErr            = -30344;
//};


//* NetSprocket Error Codes */
//enum {
  {$EXTERNALSYM kNSpInitializationFailedErr}
  kNSpInitializationFailedErr   = -30360;
  {$EXTERNALSYM kNSpAlreadyInitializedErr}
  kNSpAlreadyInitializedErr     = -30361;
  {$EXTERNALSYM kNSpTopologyNotSupportedErr}
  kNSpTopologyNotSupportedErr   = -30362;
  {$EXTERNALSYM kNSpPipeFullErr}
  kNSpPipeFullErr               = -30364;
  {$EXTERNALSYM kNSpHostFailedErr}
  kNSpHostFailedErr             = -30365;
  {$EXTERNALSYM kNSpProtocolNotAvailableErr}
  kNSpProtocolNotAvailableErr   = -30366;
  {$EXTERNALSYM kNSpInvalidGameRefErr}
  kNSpInvalidGameRefErr         = -30367;
  {$EXTERNALSYM kNSpInvalidParameterErr}
  kNSpInvalidParameterErr       = -30369;
  {$EXTERNALSYM kNSpOTNotPresentErr}
  kNSpOTNotPresentErr           = -30370;
  {$EXTERNALSYM kNSpOTVersionTooOldErr}
  kNSpOTVersionTooOldErr        = -30371;
  {$EXTERNALSYM kNSpMemAllocationErr}
  kNSpMemAllocationErr          = -30373;
  {$EXTERNALSYM kNSpAlreadyAdvertisingErr}
  kNSpAlreadyAdvertisingErr     = -30374;
  {$EXTERNALSYM kNSpNotAdvertisingErr}
  kNSpNotAdvertisingErr         = -30376;
  {$EXTERNALSYM kNSpInvalidAddressErr}
  kNSpInvalidAddressErr         = -30377;
  {$EXTERNALSYM kNSpFreeQExhaustedErr}
  kNSpFreeQExhaustedErr         = -30378;
  {$EXTERNALSYM kNSpRemovePlayerFailedErr}
  kNSpRemovePlayerFailedErr     = -30379;
  {$EXTERNALSYM kNSpAddressInUseErr}
  kNSpAddressInUseErr           = -30380;
  {$EXTERNALSYM kNSpFeatureNotImplementedErr}
  kNSpFeatureNotImplementedErr  = -30381;
  {$EXTERNALSYM kNSpNameRequiredErr}
  kNSpNameRequiredErr           = -30382;
  {$EXTERNALSYM kNSpInvalidPlayerIDErr}
  kNSpInvalidPlayerIDErr        = -30383;
  {$EXTERNALSYM kNSpInvalidGroupIDErr}
  kNSpInvalidGroupIDErr         = -30384;
  {$EXTERNALSYM kNSpNoPlayersErr}
  kNSpNoPlayersErr              = -30385;
  {$EXTERNALSYM kNSpNoGroupsErr}
  kNSpNoGroupsErr               = -30386;
  {$EXTERNALSYM kNSpNoHostVolunteersErr}
  kNSpNoHostVolunteersErr       = -30387;
  {$EXTERNALSYM kNSpCreateGroupFailedErr}
  kNSpCreateGroupFailedErr      = -30388;
  {$EXTERNALSYM kNSpAddPlayerFailedErr}
  kNSpAddPlayerFailedErr        = -30389;
  {$EXTERNALSYM kNSpInvalidDefinitionErr}
  kNSpInvalidDefinitionErr      = -30390;
  {$EXTERNALSYM kNSpInvalidProtocolRefErr}
  kNSpInvalidProtocolRefErr     = -30391;
  {$EXTERNALSYM kNSpInvalidProtocolListErr}
  kNSpInvalidProtocolListErr    = -30392;
  {$EXTERNALSYM kNSpTimeoutErr}
  kNSpTimeoutErr                = -30393;
  {$EXTERNALSYM kNSpGameTerminatedErr}
  kNSpGameTerminatedErr         = -30394;
  {$EXTERNALSYM kNSpConnectFailedErr}
  kNSpConnectFailedErr          = -30395;
  {$EXTERNALSYM kNSpSendFailedErr}
  kNSpSendFailedErr             = -30396;
  {$EXTERNALSYM kNSpMessageTooBigErr}
  kNSpMessageTooBigErr          = -30397;
  {$EXTERNALSYM kNSpCantBlockErr}
  kNSpCantBlockErr              = -30398;
  {$EXTERNALSYM kNSpJoinFailedErr}
  kNSpJoinFailedErr             = -30399;
//};


//* InputSprockets error codes */
//enum {
  {$EXTERNALSYM kISpInternalErr}
  kISpInternalErr               = -30420;
  {$EXTERNALSYM kISpSystemListErr}
  kISpSystemListErr             = -30421;
  {$EXTERNALSYM kISpBufferToSmallErr}
  kISpBufferToSmallErr          = -30422;
  {$EXTERNALSYM kISpElementInListErr}
  kISpElementInListErr          = -30423;
  {$EXTERNALSYM kISpElementNotInListErr}
  kISpElementNotInListErr       = -30424;
  {$EXTERNALSYM kISpSystemInactiveErr}
  kISpSystemInactiveErr         = -30425;
  {$EXTERNALSYM kISpDeviceInactiveErr}
  kISpDeviceInactiveErr         = -30426;
  {$EXTERNALSYM kISpSystemActiveErr}
  kISpSystemActiveErr           = -30427;
  {$EXTERNALSYM kISpDeviceActiveErr}
  kISpDeviceActiveErr           = -30428;
  {$EXTERNALSYM kISpListBusyErr}
  kISpListBusyErr               = -30429;
//};

//* DrawSprockets error/warning codes */
//enum {
  {$EXTERNALSYM kDSpNotInitializedErr}
  kDSpNotInitializedErr         = -30440;
  {$EXTERNALSYM kDSpSystemSWTooOldErr}
  kDSpSystemSWTooOldErr         = -30441;
  {$EXTERNALSYM kDSpInvalidContextErr}
  kDSpInvalidContextErr         = -30442;
  {$EXTERNALSYM kDSpInvalidAttributesErr}
  kDSpInvalidAttributesErr      = -30443;
  {$EXTERNALSYM kDSpContextAlreadyReservedErr}
  kDSpContextAlreadyReservedErr = -30444;
  {$EXTERNALSYM kDSpContextNotReservedErr}
  kDSpContextNotReservedErr     = -30445;
  {$EXTERNALSYM kDSpContextNotFoundErr}
  kDSpContextNotFoundErr        = -30446;
  {$EXTERNALSYM kDSpFrameRateNotReadyErr}
  kDSpFrameRateNotReadyErr      = -30447;
  {$EXTERNALSYM kDSpConfirmSwitchWarning}
  kDSpConfirmSwitchWarning      = -30448;
  {$EXTERNALSYM kDSpInternalErr}
  kDSpInternalErr               = -30449;
  {$EXTERNALSYM kDSpStereoContextErr}
  kDSpStereoContextErr          = -30450;
//};


{*
   ***************************************************************************
   Find By Content errors are assigned in the range -30500 to -30539, inclusive.
   ***************************************************************************
*}
//enum {
  {$EXTERNALSYM kFBCvTwinExceptionErr}
  kFBCvTwinExceptionErr         = -30500; //*no telling what it was*/
  {$EXTERNALSYM kFBCnoIndexesFound}
  kFBCnoIndexesFound            = -30501;
  {$EXTERNALSYM kFBCallocFailed}
  kFBCallocFailed               = -30502; //*probably low memory*/
  {$EXTERNALSYM kFBCbadParam}
  kFBCbadParam                  = -30503;
  {$EXTERNALSYM kFBCfileNotIndexed}
  kFBCfileNotIndexed            = -30504;
  {$EXTERNALSYM kFBCbadIndexFile}
  kFBCbadIndexFile              = -30505; //*bad FSSpec, or bad data in file*/
  {$EXTERNALSYM kFBCcompactionFailed}
  kFBCcompactionFailed          = -30506; //*V-Twin exception caught*/
  {$EXTERNALSYM kFBCvalidationFailed}
  kFBCvalidationFailed          = -30507; //*V-Twin exception caught*/
  {$EXTERNALSYM kFBCindexingFailed}
  kFBCindexingFailed            = -30508; //*V-Twin exception caught*/
  {$EXTERNALSYM kFBCcommitFailed}
  kFBCcommitFailed              = -30509; //*V-Twin exception caught*/
  {$EXTERNALSYM kFBCdeletionFailed}
  kFBCdeletionFailed            = -30510; //*V-Twin exception caught*/
  {$EXTERNALSYM kFBCmoveFailed}
  kFBCmoveFailed                = -30511; //*V-Twin exception caught*/
  {$EXTERNALSYM kFBCtokenizationFailed}
  kFBCtokenizationFailed        = -30512; //*couldn't read from document or query*/
  {$EXTERNALSYM kFBCmergingFailed}
  kFBCmergingFailed             = -30513; //*couldn't merge index files*/
  {$EXTERNALSYM kFBCindexCreationFailed}
  kFBCindexCreationFailed       = -30514; //*couldn't create index*/
  {$EXTERNALSYM kFBCaccessorStoreFailed}
  kFBCaccessorStoreFailed       = -30515;
  {$EXTERNALSYM kFBCaddDocFailed}
  kFBCaddDocFailed              = -30516;
  {$EXTERNALSYM kFBCflushFailed}
  kFBCflushFailed               = -30517;
  {$EXTERNALSYM kFBCindexNotFound}
  kFBCindexNotFound             = -30518;
  {$EXTERNALSYM kFBCnoSearchSession}
  kFBCnoSearchSession           = -30519;
  {$EXTERNALSYM kFBCindexingCanceled}
  kFBCindexingCanceled          = -30520;
  {$EXTERNALSYM kFBCaccessCanceled}
  kFBCaccessCanceled            = -30521;
  {$EXTERNALSYM kFBCindexFileDestroyed}
  kFBCindexFileDestroyed        = -30522;
  {$EXTERNALSYM kFBCindexNotAvailable}
  kFBCindexNotAvailable         = -30523;
  {$EXTERNALSYM kFBCsearchFailed}
  kFBCsearchFailed              = -30524;
  {$EXTERNALSYM kFBCsomeFilesNotIndexed}
  kFBCsomeFilesNotIndexed       = -30525;
  {$EXTERNALSYM kFBCillegalSessionChange}
  kFBCillegalSessionChange      = -30526; //*tried to add/remove vols to a session*/
                                        //*that has hits*/
  {$EXTERNALSYM kFBCanalysisNotAvailable}
  kFBCanalysisNotAvailable      = -30527;
  {$EXTERNALSYM kFBCbadIndexFileVersion}
  kFBCbadIndexFileVersion       = -30528;
  {$EXTERNALSYM kFBCsummarizationCanceled}
  kFBCsummarizationCanceled     = -30529;
  {$EXTERNALSYM kFBCindexDiskIOFailed}
  kFBCindexDiskIOFailed         = -30530;
  {$EXTERNALSYM kFBCbadSearchSession}
  kFBCbadSearchSession          = -30531;
  {$EXTERNALSYM kFBCnoSuchHit}
  kFBCnoSuchHit                 = -30532;
//};


//* QuickTime VR Errors */
//enum {
  {$EXTERNALSYM notAQTVRMovieErr}
  notAQTVRMovieErr              = -30540;
  constraintReachedErr          = -30541;
  {$EXTERNALSYM callNotSupportedByNodeErr}
  callNotSupportedByNodeErr     = -30542;
  {$EXTERNALSYM selectorNotSupportedByNodeErr}
  selectorNotSupportedByNodeErr = -30543;
  {$EXTERNALSYM invalidNodeIDErr}
  invalidNodeIDErr              = -30544;
  {$EXTERNALSYM invalidViewStateErr}
  invalidViewStateErr           = -30545;
  {$EXTERNALSYM timeNotInViewErr}
  timeNotInViewErr              = -30546;
  {$EXTERNALSYM propertyNotSupportedByNodeErr}
  propertyNotSupportedByNodeErr = -30547;
  {$EXTERNALSYM settingNotSupportedByNodeErr}
  settingNotSupportedByNodeErr  = -30548;
  {$EXTERNALSYM limitReachedErr}
  limitReachedErr               = -30549;
  {$EXTERNALSYM invalidNodeFormatErr}
  invalidNodeFormatErr          = -30550;
  {$EXTERNALSYM invalidHotSpotIDErr}
  invalidHotSpotIDErr           = -30551;
  {$EXTERNALSYM noMemoryNodeFailedInitialize}
  noMemoryNodeFailedInitialize  = -30552;
  {$EXTERNALSYM streamingNodeNotReadyErr}
  streamingNodeNotReadyErr      = -30553;
  {$EXTERNALSYM qtvrLibraryLoadErr}
  qtvrLibraryLoadErr            = -30554;
  {$EXTERNALSYM qtvrUninitialized}
  qtvrUninitialized             = -30555;
//};


//* Appearance Manager Error Codes */
//enum {
  {$EXTERNALSYM themeInvalidBrushErr}
  themeInvalidBrushErr          = -30560; //* pattern index invalid */
  {$EXTERNALSYM themeProcessRegisteredErr}
  themeProcessRegisteredErr     = -30561;
  {$EXTERNALSYM themeProcessNotRegisteredErr}
  themeProcessNotRegisteredErr  = -30562;
  {$EXTERNALSYM themeBadTextColorErr}
  themeBadTextColorErr          = -30563;
  {$EXTERNALSYM themeHasNoAccentsErr}
  themeHasNoAccentsErr          = -30564;
  {$EXTERNALSYM themeBadCursorIndexErr}
  themeBadCursorIndexErr        = -30565;
  {$EXTERNALSYM themeScriptFontNotFoundErr}
  themeScriptFontNotFoundErr    = -30566; //* theme font requested for uninstalled script system */
  {$EXTERNALSYM themeMonitorDepthNotSupportedErr}
  themeMonitorDepthNotSupportedErr = -30567; //* theme not supported at monitor depth */
  {$EXTERNALSYM themeNoAppropriateBrushErr}
  themeNoAppropriateBrushErr    = -30568; //* theme brush has no corresponding theme text color */
//};



{*
 *  Discussion:
 *    Control Manager Error Codes
 *}
//enum {

  {*
   * Not exclusively a Control Manager error code. In general, this
   * return value means a control, window, or menu definition does not
   * support the message/event that underlies an API call.
   *}
  {$EXTERNALSYM errMessageNotSupported}
  errMessageNotSupported        = -30580;

  {*
   * This is returned from GetControlData and SetControlData if the
   * control doesn't support the tag name and/or part code that is
   * passed in. It can also be returned from other APIs - like
   * SetControlFontStyle - which are wrappers around Get/SetControlData.
   *}
  {$EXTERNALSYM errDataNotSupported}
  errDataNotSupported           = -30581;

  {*
   * The control you passed to a focusing API doesn't support focusing.
   * This error isn't sent on Mac OS X; instead, you're likely to
   * receive errCouldntSetFocus or eventNotHandledErr.
   *}
  {$EXTERNALSYM errControlDoesntSupportFocus}
  errControlDoesntSupportFocus  = -30582;

  {*
   * This is a variant of and serves the same purpose as
   * controlHandleInvalidErr. Various Control Manager APIs will return
   * this error if one of the passed-in controls is NULL or otherwise
   * invalid.
   *}
  {$EXTERNALSYM errUnknownControl}
  errUnknownControl             = -30584;

  {*
   * The focus couldn't be set to a given control or advanced through a
   * hierarchy of controls. This could be because the control doesn't
   * support focusing, the control isn't currently embedded in a
   * window, or there are no focusable controls in the window when you
   * try to advance the focus.
   *}
  {$EXTERNALSYM errCouldntSetFocus}
  errCouldntSetFocus            = -30585;

  {*
   * This is returned by GetRootControl before a root control was
   * created for a given non-compositing window. Alternatively, you
   * called a Control Manager API such as ClearKeyboardFocus or
   * AutoEmbedControl that requires a root control, but there is no
   * root control on the window.
   *}
  {$EXTERNALSYM errNoRootControl}
  errNoRootControl              = -30586;

  {*
   * This is returned by CreateRootControl on the second and successive
   * calls for a given window.
   *}
  {$EXTERNALSYM errRootAlreadyExists}
  errRootAlreadyExists          = -30587;

  {*
   * The ControlPartCode you passed to a Control Manager API is out of
   * range, invalid, or otherwise unsupported.
   *}
  {$EXTERNALSYM errInvalidPartCode}
  errInvalidPartCode            = -30588;

  {*
   * You called CreateRootControl after creating one or more non-root
   * controls in a window, which is illegal; if you want an embedding
   * hierarchy on a given window, you must call CreateRootControl
   * before creating any other controls for a given window. This will
   * never be returned on Mac OS X, because a root control is created
   * automatically if it doesn't already exist the first time any
   * non-root control is created in a window.
   *}
  {$EXTERNALSYM errControlsAlreadyExist}
  errControlsAlreadyExist       = -30589;

  {*
   * You passed a control that doesn't support embedding to a Control
   * Manager API which requires the control to support embedding.
   *}
  {$EXTERNALSYM errControlIsNotEmbedder}
  errControlIsNotEmbedder       = -30590;

  {*
   * You called GetControlData or SetControlData with a buffer whose
   * size does not match the size of the data you are attempting to get
   * or set.
   *}
  {$EXTERNALSYM errDataSizeMismatch}
  errDataSizeMismatch           = -30591;

  {*
   * You called TrackControl, HandleControlClick or a similar mouse
   * tracking API on a control that is invisible or disabled. You
   * cannot track controls that are invisible or disabled.
   *}
  {$EXTERNALSYM errControlHiddenOrDisabled}
  errControlHiddenOrDisabled    = -30592;

  {*
   * You called EmbedControl or a similar API with the same control in
   * the parent and child parameters. You cannot embed a control into
   * itself.
   *}
  {$EXTERNALSYM errCantEmbedIntoSelf}
  errCantEmbedIntoSelf          = -30594;

  {*
   * You called EmbedControl or a similiar API to embed the root
   * control in another control. You cannot embed the root control in
   * any other control.
   *}
  {$EXTERNALSYM errCantEmbedRoot}
  errCantEmbedRoot              = -30595;

  {*
   * You called GetDialogItemAsControl on a dialog item such as a
   * kHelpDialogItem that is not represented by a control.
   *}
  {$EXTERNALSYM errItemNotControl}
  errItemNotControl             = -30596;

  {*
   * You called GetControlData or SetControlData with a buffer that
   * represents a versioned structure, but the version is unsupported
   * by the control definition. This can happen with the Tabs control
   * and the kControlTabInfoTag.
   *}
  {$EXTERNALSYM controlInvalidDataVersionErr}
  controlInvalidDataVersionErr  = -30597;

  {*
   * You called SetControlProperty, GetControlProperty, or a similar
   * API with an illegal property creator OSType.
   *}
  {$EXTERNALSYM controlPropertyInvalid}
  controlPropertyInvalid        = -5603;

  {*
   * You called GetControlProperty or a similar API with a property
   * creator and property tag that does not currently exist on the
   * given control.
   *}
  {$EXTERNALSYM controlPropertyNotFoundErr}
  controlPropertyNotFoundErr    = -5604;

  {*
   * You passed an invalid ControlRef to a Control Manager API.
   *}
  {$EXTERNALSYM controlHandleInvalidErr}
  controlHandleInvalidErr       = -30599;
//};


//* URLAccess Error Codes */
//enum {
  {$EXTERNALSYM kURLInvalidURLReferenceError}
  kURLInvalidURLReferenceError  = -30770;
  {$EXTERNALSYM kURLProgressAlreadyDisplayedError}
  kURLProgressAlreadyDisplayedError = -30771;
  {$EXTERNALSYM kURLDestinationExistsError}
  kURLDestinationExistsError    = -30772;
  {$EXTERNALSYM kURLInvalidURLError}
  kURLInvalidURLError           = -30773;
  {$EXTERNALSYM kURLUnsupportedSchemeError}
  kURLUnsupportedSchemeError    = -30774;
  {$EXTERNALSYM kURLServerBusyError}
  kURLServerBusyError           = -30775;
  {$EXTERNALSYM kURLAuthenticationError}
  kURLAuthenticationError       = -30776;
  {$EXTERNALSYM kURLPropertyNotYetKnownError}
  kURLPropertyNotYetKnownError  = -30777;
  {$EXTERNALSYM kURLUnknownPropertyError}
  kURLUnknownPropertyError      = -30778;
  {$EXTERNALSYM kURLPropertyBufferTooSmallError}
  kURLPropertyBufferTooSmallError = -30779;
  {$EXTERNALSYM kURLUnsettablePropertyError}
  kURLUnsettablePropertyError   = -30780;
  {$EXTERNALSYM kURLInvalidCallError}
  kURLInvalidCallError          = -30781;
  {$EXTERNALSYM kURLFileEmptyError}
  kURLFileEmptyError            = -30783;
  {$EXTERNALSYM kURLExtensionFailureError}
  kURLExtensionFailureError     = -30785;
  {$EXTERNALSYM kURLInvalidConfigurationError}
  kURLInvalidConfigurationError = -30786;
  {$EXTERNALSYM kURLAccessNotAvailableError}
  kURLAccessNotAvailableError   = -30787;
  {$EXTERNALSYM kURL68kNotSupportedError}
  kURL68kNotSupportedError      = -30788;
//};

{*
    Error Codes for C++ Exceptions

        C++ exceptions cannot be thrown across certain boundaries, for example,
        from an event handler back to the main application.  You may use these
        error codes to communicate an exception through an API that only supports
        OSStatus error codes.  Mac OS APIs will never generate these error codes;
        they are reserved for developer convenience only.
*}
//enum {
  {$EXTERNALSYM errCppGeneral}
  errCppGeneral                 = -32000;
  {$EXTERNALSYM errCppbad_alloc}
  errCppbad_alloc               = -32001; //* thrown by new */
  {$EXTERNALSYM errCppbad_cast}
  errCppbad_cast                = -32002; //* thrown by dynamic_cast when fails with a referenced type */
  {$EXTERNALSYM errCppbad_exception}
  errCppbad_exception           = -32003; //* thrown when an exception doesn't match any catch */
  {$EXTERNALSYM errCppbad_typeid}
  errCppbad_typeid              = -32004; //* thrown by typeid */
  {$EXTERNALSYM errCpplogic_error}
  errCpplogic_error             = -32005;
  {$EXTERNALSYM errCppdomain_error}
  errCppdomain_error            = -32006;
  {$EXTERNALSYM errCppinvalid_argument}
  errCppinvalid_argument        = -32007;
  {$EXTERNALSYM errCpplength_error}
  errCpplength_error            = -32008;
  {$EXTERNALSYM errCppout_of_range}
  errCppout_of_range            = -32009;
  {$EXTERNALSYM errCppruntime_error}
  errCppruntime_error           = -32010;
  {$EXTERNALSYM errCppoverflow_error}
  errCppoverflow_error          = -32011;
  {$EXTERNALSYM errCpprange_error}
  errCpprange_error             = -32012;
  {$EXTERNALSYM errCppunderflow_error}
  errCppunderflow_error         = -32013;
  {$EXTERNALSYM errCppios_base_failure}
  errCppios_base_failure        = -32014;
  {$EXTERNALSYM errCppLastSystemDefinedError}
  errCppLastSystemDefinedError  = -32020;
  {$EXTERNALSYM errCppLastUserDefinedError}
  errCppLastUserDefinedError    = -32049; //* -32021 through -32049 are free for developer-defined exceptions*/
//};

//* ComponentError codes*/
//enum {
  {$EXTERNALSYM badComponentInstance}
  badComponentInstance          = TIdC_INT($80008001); //* when cast to an OSErr this is -32767*/
  {$EXTERNALSYM badComponentSelector}
  badComponentSelector          = TIdC_INT($80008002); //* when cast to an OSErr this is -32766*/
//};



//enum {
  {$EXTERNALSYM dsBusError}
  dsBusError                    = 1;    //*bus error*/
  {$EXTERNALSYM dsAddressErr}
  dsAddressErr                  = 2;    //*address error*/
  {$EXTERNALSYM dsIllInstErr}
  dsIllInstErr                  = 3;    //*illegal instruction error*/
  {$EXTERNALSYM dsZeroDivErr}
  dsZeroDivErr                  = 4;    //*zero divide error*/
  {$EXTERNALSYM dsChkErr}
  dsChkErr                      = 5;    //*check trap error*/
  {$EXTERNALSYM dsOvflowErr}
  dsOvflowErr                   = 6;    //*overflow trap error*/
  {$EXTERNALSYM dsPrivErr}
  dsPrivErr                     = 7;    //*privilege violation error*/
  {$EXTERNALSYM dsTraceErr}
  dsTraceErr                    = 8;    //*trace mode error*/
  {$EXTERNALSYM dsLineAErr}
  dsLineAErr                    = 9;    //*line 1010 trap error*/
  {$EXTERNALSYM dsLineFErr}
  dsLineFErr                    = 10;   //*line 1111 trap error*/
  {$EXTERNALSYM dsMiscErr}
  dsMiscErr                     = 11;   //*miscellaneous hardware exception error*/
  {$EXTERNALSYM dsCoreErr}
  dsCoreErr                     = 12;   //*unimplemented core routine error*/
  {$EXTERNALSYM dsIrqErr}
  dsIrqErr                      = 13;   //*uninstalled interrupt error*/
  {$EXTERNALSYM dsIOCoreErr}
  dsIOCoreErr                   = 14;   //*IO Core Error*/
  {$EXTERNALSYM dsLoadErr}
  dsLoadErr                     = 15;   //*Segment Loader Error*/
  {$EXTERNALSYM dsFPErr}
  dsFPErr                       = 16;   //*Floating point error*/
  {$EXTERNALSYM dsNoPackErr}
  dsNoPackErr                   = 17;   //*package 0 not present*/
  {$EXTERNALSYM dsNoPk1}
  dsNoPk1                       = 18;   //*package 1 not present*/
  {$EXTERNALSYM dsNoPk2}
  dsNoPk2                       = 19;   //*package 2 not present*/
//};

//enum {
  {$EXTERNALSYM dsNoPk3}
  dsNoPk3                       = 20;   //*package 3 not present*/
  {$EXTERNALSYM dsNoPk4}
  dsNoPk4                       = 21;   //*package 4 not present*/
  {$EXTERNALSYM dsNoPk5}
  dsNoPk5                       = 22;   //*package 5 not present*/
  {$EXTERNALSYM dsNoPk6}
  dsNoPk6                       = 23;   //*package 6 not present*/
  {$EXTERNALSYM dsNoPk7}
  dsNoPk7                       = 24;   //*package 7 not present*/
  {$EXTERNALSYM dsMemFullErr}
  dsMemFullErr                  = 25;   //*out of memory!*/
  {$EXTERNALSYM dsBadLaunch}
  dsBadLaunch                   = 26;   //*can't launch file*/
  {$EXTERNALSYM dsFSErr}
  dsFSErr                       = 27;   //*file system map has been trashed*/
  {$EXTERNALSYM dsStknHeap}
  dsStknHeap                    = 28;   //*stack has moved into application heap*/
  {$EXTERNALSYM negZcbFreeErr}
  negZcbFreeErr                 = 33;   //*ZcbFree has gone negative*/
  {$EXTERNALSYM dsFinderErr}
  dsFinderErr                   = 41;   //*can't load the Finder error*/
  {$EXTERNALSYM dsBadSlotInt}
  dsBadSlotInt                  = 51;   //*unserviceable slot interrupt*/
  {$EXTERNALSYM dsBadSANEOpcode}
  dsBadSANEOpcode               = 81;   //*bad opcode given to SANE Pack4*/
  {$EXTERNALSYM dsBadPatchHeader}
  dsBadPatchHeader              = 83;   //*SetTrapAddress saw the “come-from” header*/
  {$EXTERNALSYM menuPrgErr}
  menuPrgErr                    = 84;   //*happens when a menu is purged*/
  {$EXTERNALSYM dsMBarNFnd}
  dsMBarNFnd                    = 85;   //*Menu Manager Errors*/
  {$EXTERNALSYM dsHMenuFindErr}
  dsHMenuFindErr                = 86;   //*Menu Manager Errors*/
  {$EXTERNALSYM dsWDEFNotFound}
  dsWDEFNotFound                = 87;   //*could not load WDEF*/
  {$EXTERNALSYM dsCDEFNotFound}
  dsCDEFNotFound                = 88;   //*could not load CDEF*/
  {$EXTERNALSYM dsMDEFNotFound}
  dsMDEFNotFound                = 89;   //*could not load MDEF*/
//};

//enum {
  {$EXTERNALSYM dsNoFPU}
  dsNoFPU                       = 90;   //*an FPU instruction was executed and the machine doesn’t have one*/
  {$EXTERNALSYM dsNoPatch}
  dsNoPatch                     = 98;   //*Can't patch for particular Model Mac*/
  {$EXTERNALSYM dsBadPatch}
  dsBadPatch                    = 99;   //*Can't load patch resource*/
  {$EXTERNALSYM dsParityErr}
  dsParityErr                   = 101;  //*memory parity error*/
  {$EXTERNALSYM dsOldSystem}
  dsOldSystem                   = 102;  //*System is too old for this ROM*/
  {$EXTERNALSYM ds32BitMode}
  ds32BitMode                   = 103;  //*booting in 32-bit on a 24-bit sys*/
  {$EXTERNALSYM dsNeedToWriteBootBlocks}
  dsNeedToWriteBootBlocks       = 104;  //*need to write new boot blocks*/
  {$EXTERNALSYM dsNotEnoughRAMToBoot}
  dsNotEnoughRAMToBoot          = 105;  //*must have at least 1.5MB of RAM to boot 7.0*/
  {$EXTERNALSYM dsBufPtrTooLow}
  dsBufPtrTooLow                = 106;  //*bufPtr moved too far during boot*/
  {$EXTERNALSYM dsVMDeferredFuncTableFull}
  dsVMDeferredFuncTableFull     = 112;  //*VM's DeferUserFn table is full*/
  {$EXTERNALSYM dsVMBadBackingStore}
  dsVMBadBackingStore           = 113;  //*Error occurred while reading or writing the VM backing-store file*/
  {$EXTERNALSYM dsCantHoldSystemHeap}
  dsCantHoldSystemHeap          = 114;  //*Unable to hold the system heap during boot*/
  {$EXTERNALSYM dsSystemRequiresPowerPC}
  dsSystemRequiresPowerPC       = 116;  //*Startup disk requires PowerPC*/
  {$EXTERNALSYM dsGibblyMovedToDisabledFolder}
  dsGibblyMovedToDisabledFolder = 117;  //* For debug builds only, signals that active gibbly was disabled during boot. */
  {$EXTERNALSYM dsUnBootableSystem}
  dsUnBootableSystem            = 118;  //* Active system file will not boot on this system because it was designed only to boot from a CD. */
  {$EXTERNALSYM dsMustUseFCBAccessors}
  dsMustUseFCBAccessors         = 119;  //* FCBSPtr and FSFCBLen are invalid - must use FSM FCB accessor functions */
  {$EXTERNALSYM dsMacOSROMVersionTooOld}
  dsMacOSROMVersionTooOld       = 120;  //* The version of the "Mac OS ROM" file is too old to be used with the installed version of system software */
  {$EXTERNALSYM dsLostConnectionToNetworkDisk}
  dsLostConnectionToNetworkDisk = 121;  //* Lost communication with Netboot server */
  {$EXTERNALSYM dsRAMDiskTooBig}
  dsRAMDiskTooBig               = 122;  //* The RAM disk is too big to boot safely; will be turned off */
  {$EXTERNALSYM dsWriteToSupervisorStackGuardPage}
  dsWriteToSupervisorStackGuardPage = 128; //*the supervisor stack overflowed into its guard page */
  {$EXTERNALSYM dsReinsert}
  dsReinsert                    = 30;   //*request user to reinsert off-line volume*/
  {$EXTERNALSYM shutDownAlert}
  shutDownAlert                 = 42;   //*handled like a shutdown error*/
  {$EXTERNALSYM dsShutDownOrRestart}
  dsShutDownOrRestart           = 20000; //*user choice between ShutDown and Restart*/
  {$EXTERNALSYM dsSwitchOffOrRestart}
  dsSwitchOffOrRestart          = 20001; //*user choice between switching off and Restart*/
  {$EXTERNALSYM dsForcedQuit}
  dsForcedQuit                  = 20002; //*allow the user to ExitToShell, return if Cancel*/
  {$EXTERNALSYM dsRemoveDisk}
  dsRemoveDisk                  = 20003; //*request user to remove disk from manual eject drive*/
  {$EXTERNALSYM dsDirtyDisk}
  dsDirtyDisk                   = 20004; //*request user to return a manually-ejected dirty disk*/
  {$EXTERNALSYM dsShutDownOrResume}
  dsShutDownOrResume            = 20109; //*allow user to return to Finder or ShutDown*/
  {$EXTERNALSYM dsSCSIWarn}
  dsSCSIWarn                    = 20010; //*Portable SCSI adapter warning.*/
  {$EXTERNALSYM dsMBSysError}
  dsMBSysError                  = 29200; //*Media Bay replace warning.*/
  {$EXTERNALSYM dsMBFlpySysError}
  dsMBFlpySysError              = 29201; //*Media Bay, floppy replace warning.*/
  {$EXTERNALSYM dsMBATASysError}
  dsMBATASysError               = 29202; //*Media Bay, ATA replace warning.*/
  {$EXTERNALSYM dsMBATAPISysError}
  dsMBATAPISysError             = 29203; //*Media Bay, ATAPI replace warning...*/
  {$EXTERNALSYM dsMBExternFlpySysError}
  dsMBExternFlpySysError        = 29204; //*Media Bay, external floppy drive reconnect warning*/
  {$EXTERNALSYM dsPCCardATASysError}
  dsPCCardATASysError           = 29205; //*PCCard has been ejected while still in use. */
//};

{*
    System Errors that are used after MacsBug is loaded to put up dialogs since these should not
    cause MacsBug to stop, they must be in the range (30, 42, 16384-32767) negative numbers add
    to an existing dialog without putting up a whole new dialog
*}
//enum {
  {$EXTERNALSYM dsNoExtsMacsBug}
  dsNoExtsMacsBug               = -1;   //*not a SysErr, just a placeholder */
  {$EXTERNALSYM dsNoExtsDisassembler}
  dsNoExtsDisassembler          = -2;   //*not a SysErr, just a placeholder */
  {$EXTERNALSYM dsMacsBugInstalled}
  dsMacsBugInstalled            = -10;  //*say “MacsBug Installed”*/
  {$EXTERNALSYM dsDisassemblerInstalled}
  dsDisassemblerInstalled       = -11;  //*say “Disassembler Installed”*/
  {$EXTERNALSYM dsExtensionsDisabled}
  dsExtensionsDisabled          = -13;  //*say “Extensions Disabled”*/
  {$EXTERNALSYM dsGreeting}
  dsGreeting                    = 40;   //*welcome to Macintosh greeting*/
  {$EXTERNALSYM dsSysErr}
  dsSysErr                      = 32767; //*general system error*/
                                        //*old names here for compatibility’s sake*/
  {$EXTERNALSYM WDEFNFnd}
  WDEFNFnd                      = dsWDEFNotFound;
//};

//enum {
  {$EXTERNALSYM CDEFNFnd}
  CDEFNFnd                      = dsCDEFNotFound;
  {$EXTERNALSYM dsNotThe1}
  dsNotThe1                     = 31;   //*not the disk I wanted*/
  {$EXTERNALSYM dsBadStartupDisk}
  dsBadStartupDisk              = 42;   //*unable to mount boot volume (sad Mac only)*/
  {$EXTERNALSYM dsSystemFileErr}
  dsSystemFileErr               = 43;   //*can’t find System file to open (sad Mac only)*/
  {$EXTERNALSYM dsHD20Installed}
  dsHD20Installed               = -12;  //*say “HD20 Startup”*/
  {$EXTERNALSYM mBarNFnd}
  mBarNFnd                      = -126; //*system error code for MBDF not found*/
  {$EXTERNALSYM fsDSIntErr}
  fsDSIntErr                    = -127; //*non-hardware Internal file system error*/
  {$EXTERNALSYM hMenuFindErr}
  hMenuFindErr                  = -127; //*could not find HMenu's parent in MenuKey (wrong error code - obsolete)*/
  {$EXTERNALSYM userBreak}
  userBreak                     = -490; //*user debugger break*/
  {$EXTERNALSYM strUserBreak}
  strUserBreak                  = -491; //*user debugger break; display string on stack*/
  {$EXTERNALSYM exUserBreak}
  exUserBreak                   = -492;  //*user debugger break; execute debugger commands on stack*/
//};


//enum {
                                        //* DS Errors which are specific to the new runtime model introduced with PowerPC */
  {$EXTERNALSYM dsBadLibrary}
  dsBadLibrary                  = 1010; //* Bad shared library */
  {$EXTERNALSYM dsMixedModeFailure}
  dsMixedModeFailure            = 1011; //* Internal Mixed Mode Failure */
//};


{*
    On Mac OS X, the range from 100,000 to 100,999 has been reserved for returning POSIX errno error values.
    Every POSIX errno value can be converted into a Mac OS X OSStatus value by adding kPOSIXErrorBase to the
    value of errno.  They can't be returned by anything which just returns OSErr since kPOSIXErrorBase is
    larger than the highest OSErr value.
*}
//enum {
  {$EXTERNALSYM kPOSIXErrorBase}
  kPOSIXErrorBase               = 100000;
  {$EXTERNALSYM kPOSIXErrorEPERM}
  kPOSIXErrorEPERM              = 100001; //* Operation not permitted */
  {$EXTERNALSYM kPOSIXErrorENOENT}
  kPOSIXErrorENOENT             = 100002; //* No such file or directory */
  {$EXTERNALSYM kPOSIXErrorESRCH}
  kPOSIXErrorESRCH              = 100003; //* No such process */
  {$EXTERNALSYM kPOSIXErrorEINTR}
  kPOSIXErrorEINTR              = 100004; //* Interrupted system call */
  {$EXTERNALSYM kPOSIXErrorEIO}
  kPOSIXErrorEIO                = 100005; //* Input/output error */
  {$EXTERNALSYM kPOSIXErrorENXIO}
  kPOSIXErrorENXIO              = 100006; //* Device not configured */
  {$EXTERNALSYM kPOSIXErrorE2BIG}
  kPOSIXErrorE2BIG              = 100007; //* Argument list too long */
  {$EXTERNALSYM kPOSIXErrorENOEXEC}
  kPOSIXErrorENOEXEC            = 100008; //* Exec format error */
  {$EXTERNALSYM kPOSIXErrorEBADF}
  kPOSIXErrorEBADF              = 100009; //* Bad file descriptor */
  {$EXTERNALSYM kPOSIXErrorECHILD}
  kPOSIXErrorECHILD             = 100010; //* No child processes */
  {$EXTERNALSYM kPOSIXErrorEDEADLK}
  kPOSIXErrorEDEADLK            = 100011; //* Resource deadlock avoided */
  {$EXTERNALSYM kPOSIXErrorENOMEM}
  kPOSIXErrorENOMEM             = 100012; //* Cannot allocate memory */
  {$EXTERNALSYM kPOSIXErrorEACCES}
  kPOSIXErrorEACCES             = 100013; //* Permission denied */
  {$EXTERNALSYM kPOSIXErrorEFAULT}
  kPOSIXErrorEFAULT             = 100014; //* Bad address */
  {$EXTERNALSYM kPOSIXErrorENOTBLK}
  kPOSIXErrorENOTBLK            = 100015; //* Block device required */
  {$EXTERNALSYM kPOSIXErrorEBUSY}
  kPOSIXErrorEBUSY              = 100016; //* Device busy */
  {$EXTERNALSYM kPOSIXErrorEEXIST}
  kPOSIXErrorEEXIST             = 100017; //* File exists */
  {$EXTERNALSYM kPOSIXErrorEXDEV}
  kPOSIXErrorEXDEV              = 100018; //* Cross-device link */
  {$EXTERNALSYM kPOSIXErrorENODEV}
  kPOSIXErrorENODEV             = 100019; //* Operation not supported by device */
  {$EXTERNALSYM kPOSIXErrorENOTDIR}
  kPOSIXErrorENOTDIR            = 100020; //* Not a directory */
  {$EXTERNALSYM kPOSIXErrorEISDIR}
  kPOSIXErrorEISDIR             = 100021; //* Is a directory */
  {$EXTERNALSYM kPOSIXErrorEINVAL}
  kPOSIXErrorEINVAL             = 100022; //* Invalid argument */
  {$EXTERNALSYM kPOSIXErrorENFILE}
  kPOSIXErrorENFILE             = 100023; //* Too many open files in system */
  {$EXTERNALSYM kPOSIXErrorEMFILE}
  kPOSIXErrorEMFILE             = 100024; //* Too many open files */
  {$EXTERNALSYM kPOSIXErrorENOTTY}
  kPOSIXErrorENOTTY             = 100025; //* Inappropriate ioctl for device */
  {$EXTERNALSYM kPOSIXErrorETXTBSY}
  kPOSIXErrorETXTBSY            = 100026; //* Text file busy */
  {$EXTERNALSYM kPOSIXErrorEFBIG}
  kPOSIXErrorEFBIG              = 100027; //* File too large */
  {$EXTERNALSYM kPOSIXErrorENOSPC}
  kPOSIXErrorENOSPC             = 100028; //* No space left on device */
  {$EXTERNALSYM kPOSIXErrorESPIPE}
  kPOSIXErrorESPIPE             = 100029; //* Illegal seek */
  {$EXTERNALSYM kPOSIXErrorEROFS}
  kPOSIXErrorEROFS              = 100030; //* Read-only file system */
  {$EXTERNALSYM kPOSIXErrorEMLINK}
  kPOSIXErrorEMLINK             = 100031; //* Too many links */
  {$EXTERNALSYM kPOSIXErrorEPIPE}
  kPOSIXErrorEPIPE              = 100032; //* Broken pipe */
  {$EXTERNALSYM kPOSIXErrorEDOM}
  kPOSIXErrorEDOM               = 100033; //* Numerical argument out of domain */
  {$EXTERNALSYM kPOSIXErrorERANGE}
  kPOSIXErrorERANGE             = 100034; //* Result too large */
  {$EXTERNALSYM kPOSIXErrorEAGAIN}
  kPOSIXErrorEAGAIN             = 100035; //* Resource temporarily unavailable */
  {$EXTERNALSYM kPOSIXErrorEINPROGRESS}
  kPOSIXErrorEINPROGRESS        = 100036; //* Operation now in progress */
  {$EXTERNALSYM kPOSIXErrorEALREADY}
  kPOSIXErrorEALREADY           = 100037; //* Operation already in progress */
  {$EXTERNALSYM kPOSIXErrorENOTSOCK}
  kPOSIXErrorENOTSOCK           = 100038; //* Socket operation on non-socket */
  {$EXTERNALSYM kPOSIXErrorEDESTADDRREQ}
  kPOSIXErrorEDESTADDRREQ       = 100039; //* Destination address required */
  {$EXTERNALSYM kPOSIXErrorEMSGSIZE}
  kPOSIXErrorEMSGSIZE           = 100040; //* Message too long */
  {$EXTERNALSYM kPOSIXErrorEPROTOTYPE}
  kPOSIXErrorEPROTOTYPE         = 100041; //* Protocol wrong type for socket */
  {$EXTERNALSYM kPOSIXErrorENOPROTOOPT}
  kPOSIXErrorENOPROTOOPT        = 100042; //* Protocol not available */
  {$EXTERNALSYM kPOSIXErrorEPROTONOSUPPORT}
  kPOSIXErrorEPROTONOSUPPORT    = 100043; //* Protocol not supported */
  {$EXTERNALSYM kPOSIXErrorESOCKTNOSUPPORT}
  kPOSIXErrorESOCKTNOSUPPORT    = 100044; //* Socket type not supported */
  {$EXTERNALSYM kPOSIXErrorENOTSUP}
  kPOSIXErrorENOTSUP            = 100045; //* Operation not supported */
  {$EXTERNALSYM kPOSIXErrorEPFNOSUPPORT}
  kPOSIXErrorEPFNOSUPPORT       = 100046; //* Protocol family not supported */
  {$EXTERNALSYM kPOSIXErrorEAFNOSUPPORT}
  kPOSIXErrorEAFNOSUPPORT       = 100047; //* Address family not supported by protocol family */
  {$EXTERNALSYM kPOSIXErrorEADDRINUSE}
  kPOSIXErrorEADDRINUSE         = 100048; //* Address already in use */
  {$EXTERNALSYM kPOSIXErrorEADDRNOTAVAIL}
  kPOSIXErrorEADDRNOTAVAIL      = 100049; //* Can't assign requested address */
  {$EXTERNALSYM kPOSIXErrorENETDOWN}
  kPOSIXErrorENETDOWN           = 100050; //* Network is down */
  {$EXTERNALSYM kPOSIXErrorENETUNREACH}
  kPOSIXErrorENETUNREACH        = 100051; //* Network is unreachable */
  {$EXTERNALSYM kPOSIXErrorENETRESET}
  kPOSIXErrorENETRESET          = 100052; //* Network dropped connection on reset */
  {$EXTERNALSYM kPOSIXErrorECONNABORTED}
  kPOSIXErrorECONNABORTED       = 100053; //* Software caused connection abort */
  {$EXTERNALSYM kPOSIXErrorECONNRESET}
  kPOSIXErrorECONNRESET         = 100054; //* Connection reset by peer */
  {$EXTERNALSYM kPOSIXErrorENOBUFS}
  kPOSIXErrorENOBUFS            = 100055; //* No buffer space available */
  {$EXTERNALSYM kPOSIXErrorEISCONN}
  kPOSIXErrorEISCONN            = 100056; //* Socket is already connected */
  {$EXTERNALSYM kPOSIXErrorENOTCONN}
  kPOSIXErrorENOTCONN           = 100057; //* Socket is not connected */
  {$EXTERNALSYM kPOSIXErrorESHUTDOWN}
  kPOSIXErrorESHUTDOWN          = 100058; //* Can't send after socket shutdown */
  {$EXTERNALSYM kPOSIXErrorETOOMANYREFS}
  kPOSIXErrorETOOMANYREFS       = 100059; //* Too many references: can't splice */
  {$EXTERNALSYM kPOSIXErrorETIMEDOUT}
  kPOSIXErrorETIMEDOUT          = 100060; //* Operation timed out */
  {$EXTERNALSYM kPOSIXErrorECONNREFUSED}
  kPOSIXErrorECONNREFUSED       = 100061; //* Connection refused */
  {$EXTERNALSYM kPOSIXErrorELOOP}
  kPOSIXErrorELOOP              = 100062; //* Too many levels of symbolic links */
  {$EXTERNALSYM kPOSIXErrorENAMETOOLONG}
  kPOSIXErrorENAMETOOLONG       = 100063; //* File name too long */
  {$EXTERNALSYM kPOSIXErrorEHOSTDOWN}
  kPOSIXErrorEHOSTDOWN          = 100064; //* Host is down */
  {$EXTERNALSYM kPOSIXErrorEHOSTUNREACH}
  kPOSIXErrorEHOSTUNREACH       = 100065; //* No route to host */
  {$EXTERNALSYM kPOSIXErrorENOTEMPTY}
  kPOSIXErrorENOTEMPTY          = 100066; //* Directory not empty */
  {$EXTERNALSYM kPOSIXErrorEPROCLIM}
  kPOSIXErrorEPROCLIM           = 100067; //* Too many processes */
  {$EXTERNALSYM kPOSIXErrorEUSERS}
  kPOSIXErrorEUSERS             = 100068; //* Too many users */
  {$EXTERNALSYM kPOSIXErrorEDQUOT}
  kPOSIXErrorEDQUOT             = 100069; //* Disc quota exceeded */
  {$EXTERNALSYM kPOSIXErrorESTALE}
  kPOSIXErrorESTALE             = 100070; //* Stale NFS file handle */
  {$EXTERNALSYM kPOSIXErrorEREMOTE}
  kPOSIXErrorEREMOTE            = 100071; //* Too many levels of remote in path */
  {$EXTERNALSYM kPOSIXErrorEBADRPC}
  kPOSIXErrorEBADRPC            = 100072; //* RPC struct is bad */
  {$EXTERNALSYM kPOSIXErrorERPCMISMATCH}
  kPOSIXErrorERPCMISMATCH       = 100073; //* RPC version wrong */
  {$EXTERNALSYM kPOSIXErrorEPROGUNAVAIL}
  kPOSIXErrorEPROGUNAVAIL       = 100074; //* RPC prog. not avail */
  {$EXTERNALSYM kPOSIXErrorEPROGMISMATCH}
  kPOSIXErrorEPROGMISMATCH      = 100075; //* Program version wrong */
  {$EXTERNALSYM kPOSIXErrorEPROCUNAVAIL}
  kPOSIXErrorEPROCUNAVAIL       = 100076; //* Bad procedure for program */
  {$EXTERNALSYM kPOSIXErrorENOLCK}
  kPOSIXErrorENOLCK             = 100077; //* No locks available */
  {$EXTERNALSYM kPOSIXErrorENOSYS}
  kPOSIXErrorENOSYS             = 100078; //* Function not implemented */
  {$EXTERNALSYM kPOSIXErrorEFTYPE}
  kPOSIXErrorEFTYPE             = 100079; //* Inappropriate file type or format */
  {$EXTERNALSYM kPOSIXErrorEAUTH}
  kPOSIXErrorEAUTH              = 100080; //* Authentication error */
  {$EXTERNALSYM kPOSIXErrorENEEDAUTH}
  kPOSIXErrorENEEDAUTH          = 100081; //* Need authenticator */
  {$EXTERNALSYM kPOSIXErrorEPWROFF}
  kPOSIXErrorEPWROFF            = 100082; //* Device power is off */
  {$EXTERNALSYM kPOSIXErrorEDEVERR}
  kPOSIXErrorEDEVERR            = 100083; //* Device error, e.g. paper out */
  {$EXTERNALSYM kPOSIXErrorEOVERFLOW}
  kPOSIXErrorEOVERFLOW          = 100084; //* Value too large to be stored in data type */
  {$EXTERNALSYM kPOSIXErrorEBADEXEC}
  kPOSIXErrorEBADEXEC           = 100085; //* Bad executable */
  {$EXTERNALSYM kPOSIXErrorEBADARCH}
  kPOSIXErrorEBADARCH           = 100086; //* Bad CPU type in executable */
  {$EXTERNALSYM kPOSIXErrorESHLIBVERS}
  kPOSIXErrorESHLIBVERS         = 100087; //* Shared library version mismatch */
  {$EXTERNALSYM kPOSIXErrorEBADMACHO}
  kPOSIXErrorEBADMACHO          = 100088; //* Malformed Macho file */
  {$EXTERNALSYM kPOSIXErrorECANCELED}
  kPOSIXErrorECANCELED          = 100089; //* Operation canceled */
  {$EXTERNALSYM kPOSIXErrorEIDRM}
  kPOSIXErrorEIDRM              = 100090; //* Identifier removed */
  {$EXTERNALSYM kPOSIXErrorENOMSG}
  kPOSIXErrorENOMSG             = 100091; //* No message of desired type */
  {$EXTERNALSYM kPOSIXErrorEILSEQ}
  kPOSIXErrorEILSEQ             = 100092; //* Illegal byte sequence */
  {$EXTERNALSYM kPOSIXErrorENOATTR}
  kPOSIXErrorENOATTR            = 100093; //* Attribute not found */
  {$EXTERNALSYM kPOSIXErrorEBADMSG}
  kPOSIXErrorEBADMSG            = 100094; //* Bad message */
  {$EXTERNALSYM kPOSIXErrorEMULTIHOP}
  kPOSIXErrorEMULTIHOP          = 100095; //* Reserved */
  {$EXTERNALSYM kPOSIXErrorENODATA}
  kPOSIXErrorENODATA            = 100096; //* No message available on STREAM */
  {$EXTERNALSYM kPOSIXErrorENOLINK}
  kPOSIXErrorENOLINK            = 100097; //* Reserved */
  {$EXTERNALSYM kPOSIXErrorENOSR}
  kPOSIXErrorENOSR              = 100098; //* No STREAM resources */
  {$EXTERNALSYM kPOSIXErrorENOSTR}
  kPOSIXErrorENOSTR             = 100099; //* Not a STREAM */
  {$EXTERNALSYM kPOSIXErrorEPROTO}
  kPOSIXErrorEPROTO             = 100100; //* Protocol error */
  {$EXTERNALSYM kPOSIXErrorETIME}
  kPOSIXErrorETIME              = 100101; //* STREAM ioctl timeout */
  {$EXTERNALSYM kPOSIXErrorEOPNOTSUPP}
  kPOSIXErrorEOPNOTSUPP         = 100102; //* Operation not supported on socket */
//};

///Developer/SDKs/MacOSX10.6.sdk/System/Library/Frameworks/CoreServices.framework/Frameworks/CarbonCore.framework/Headers/Gestalt.h
//* Environment Selectors */
//enum {
  {$EXTERNALSYM gestaltAddressingModeAttr}
  gestaltAddressingModeAttr     = $61646472; //'addr', /* addressing mode attributes */
  {$EXTERNALSYM gestalt32BitAddressing}
  gestalt32BitAddressing        = 0;    //* using 32-bit addressing mode */
  {$EXTERNALSYM gestalt32BitSysZone}
  gestalt32BitSysZone           = 1;    //* 32-bit compatible system zone */
  {$EXTERNALSYM gestalt32BitCapable}
  gestalt32BitCapable           = 2;     //* Machine is 32-bit capable */
//};

//enum {
  {$EXTERNALSYM gestaltAFPClient}
  gestaltAFPClient              = $61667073; //'afps',
  {$EXTERNALSYM gestaltAFPClientVersionMask}
  gestaltAFPClientVersionMask   = $0000FFFF; //* low word of SInt32 is the */
                                        //* client version 0x0001 -> 0x0007*/
  {$EXTERNALSYM gestaltAFPClient3_5}
  gestaltAFPClient3_5           = $0001;
  {$EXTERNALSYM gestaltAFPClient3_6}
  gestaltAFPClient3_6           = $0002;
  {$EXTERNALSYM gestaltAFPClient3_6_1}
  gestaltAFPClient3_6_1         = $0003;
  {$EXTERNALSYM gestaltAFPClient3_6_2}
  gestaltAFPClient3_6_2         = $0004;
  {$EXTERNALSYM gestaltAFPClient3_6_3}
  gestaltAFPClient3_6_3         = $0005; //* including 3.6.4, 3.6.5*/
  {$EXTERNALSYM gestaltAFPClient3_7}
  gestaltAFPClient3_7           = $0006; //* including 3.7.1*/
  {$EXTERNALSYM gestaltAFPClient3_7_2}
  gestaltAFPClient3_7_2         = $0007; //* including 3.7.3, 3.7.4*/
  {$EXTERNALSYM gestaltAFPClient3_8}
  gestaltAFPClient3_8           = $0008;
  {$EXTERNALSYM gestaltAFPClient3_8_1}
  gestaltAFPClient3_8_1         = $0009; //* including 3.8.2 */
  {$EXTERNALSYM gestaltAFPClient3_8_3}
  gestaltAFPClient3_8_3         = $000A;
  {$EXTERNALSYM gestaltAFPClient3_8_4}
  gestaltAFPClient3_8_4         = $000B; //* including 3.8.5, 3.8.6 */
  {$EXTERNALSYM gestaltAFPClientAttributeMask}
  gestaltAFPClientAttributeMask = TIdC_INT($FFFF0000); //* high word of response is a */
                                        //* set of attribute bits*/
  {$EXTERNALSYM gestaltAFPClientCfgRsrc}
  gestaltAFPClientCfgRsrc       = 16;   //* Client uses config resources*/
  {$EXTERNALSYM gestaltAFPClientSupportsIP}
  gestaltAFPClientSupportsIP    = 29;   //* Client supports AFP over TCP/IP*/
  {$EXTERNALSYM gestaltAFPClientVMUI}
  gestaltAFPClientVMUI          = 30;   //* Client can put up UI from the PBVolMount trap*/
  {$EXTERNALSYM gestaltAFPClientMultiReq}
  gestaltAFPClientMultiReq      = 31;    //* Client supports multiple outstanding requests*/
//};


//enum {
  {$EXTERNALSYM gestaltAliasMgrAttr}
  gestaltAliasMgrAttr           = $616c6973; //'alis', /* Alias Mgr Attributes */
  {$EXTERNALSYM gestaltAliasMgrPresent}
  gestaltAliasMgrPresent        = 0;    //* True if the Alias Mgr is present */
  {$EXTERNALSYM gestaltAliasMgrSupportsRemoteAppletalk}
  gestaltAliasMgrSupportsRemoteAppletalk = 1; //* True if the Alias Mgr knows about Remote Appletalk */
  {$EXTERNALSYM gestaltAliasMgrSupportsAOCEKeychain}
  gestaltAliasMgrSupportsAOCEKeychain = 2; //* True if the Alias Mgr knows about the AOCE Keychain */
  {$EXTERNALSYM gestaltAliasMgrResolveAliasFileWithMountOptions}
  gestaltAliasMgrResolveAliasFileWithMountOptions = 3; //* True if the Alias Mgr implements gestaltAliasMgrResolveAliasFileWithMountOptions() and IsAliasFile() */
  {$EXTERNALSYM gestaltAliasMgrFollowsAliasesWhenResolving}
  gestaltAliasMgrFollowsAliasesWhenResolving = 4;
  {$EXTERNALSYM gestaltAliasMgrSupportsExtendedCalls}
  gestaltAliasMgrSupportsExtendedCalls = 5;
  {$EXTERNALSYM gestaltAliasMgrSupportsFSCalls}
  gestaltAliasMgrSupportsFSCalls = 6;   //* true if Alias Mgr supports HFS+ Calls */
  {$EXTERNALSYM gestaltAliasMgrPrefersPath}
  gestaltAliasMgrPrefersPath    = 7;    //* True if the Alias Mgr prioritizes the path over file id during resolution by default */
  {$EXTERNALSYM gestaltAliasMgrRequiresAccessors}
  gestaltAliasMgrRequiresAccessors = 8;  //* Set if Alias Manager requires accessors for size and usertype */
//};

//* Gestalt selector and values for the Appearance Manager */
//enum {
  {$EXTERNALSYM gestaltAppearanceAttr}
  gestaltAppearanceAttr         = $61707072; //'appr',
  {$EXTERNALSYM gestaltAppearanceExists}
  gestaltAppearanceExists       = 0;
  {$EXTERNALSYM gestaltAppearanceCompatMode}
  gestaltAppearanceCompatMode   = 1;
//};

//* Gestalt selector for determining Appearance Manager version   */
//* If this selector does not exist, but gestaltAppearanceAttr    */
//* does, it indicates that the 1.0 version is installed. This    */
//* gestalt returns a BCD number representing the version of the  */
//* Appearance Manager that is currently running, e.g. 0x0101 for */
//* version 1.0.1.                                                */
//enum {
  {$EXTERNALSYM gestaltAppearanceVersion}
  gestaltAppearanceVersion      = $61707672; //'apvr'
//};

//enum {
  {$EXTERNALSYM gestaltArbitorAttr}
  gestaltArbitorAttr            = $61726220;//'arb ',
  {$EXTERNALSYM gestaltSerialArbitrationExists}
  gestaltSerialArbitrationExists = 0;    //* this bit if the serial port arbitrator exists*/
//};

//enum {
  {$EXTERNALSYM gestaltAppleScriptVersion}
  gestaltAppleScriptVersion     = $61736376; //'ascv' /* AppleScript version*/
//};

//enum {
  {$EXTERNALSYM gestaltAppleScriptAttr}
  gestaltAppleScriptAttr        = $61736372; //'ascr', /* AppleScript attributes*/
  {$EXTERNALSYM gestaltAppleScriptPresent}
  gestaltAppleScriptPresent     = 0;
  {$EXTERNALSYM gestaltAppleScriptPowerPCSupport}
  gestaltAppleScriptPowerPCSupport = 1;
//};

//enum {
  {$EXTERNALSYM gestaltATAAttr}
  gestaltATAAttr                = $61746120; //'ata ', /* ATA is the driver to support IDE hard disks */
  {$EXTERNALSYM gestaltATAPresent}
  gestaltATAPresent             = 0;     //* if set, ATA Manager is present */
//};

//enum {
  {$EXTERNALSYM gestaltATalkVersion}
  gestaltATalkVersion           = $61746b76; //'atkv' /* Detailed AppleTalk version; see comment above for format */
//};

//enum {
  {$EXTERNALSYM gestaltAppleTalkVersion}
  gestaltAppleTalkVersion       = $61746c6b; //'atlk' /* appletalk version */
//};

{*
    FORMAT OF gestaltATalkVersion RESPONSE
    --------------------------------------
    The version is stored in the high three bytes of the response value.  Let us number
    the bytes in the response value from 0 to 3, where 0 is the least-significant byte.

        Byte#:     3 2 1 0
        Value:  0xMMNNRR00

    Byte 3 (MM) contains the major revision number, byte 2 (NN) contains the minor
    revision number, and byte 1 (RR) contains a constant that represents the release
    stage.  Byte 0 always contains 0x00.  The constants for the release stages are:

        development = 0x20
        alpha       = 0x40
        beta        = 0x60
        final       = 0x80
        release     = 0x80

    For example, if you call Gestalt with the 'atkv' selector when AppleTalk version 57
    is loaded, you receive the integer response value 0x39008000.
*}
//enum {
  {$EXTERNALSYM gestaltAUXVersion}
  gestaltAUXVersion             = $612f7578; //'a/ux' /* a/ux version, if present */
//};

//enum {
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxAttr}
  gestaltMacOSCompatibilityBoxAttr = $62626f78; //'bbox',  //* Classic presence and features */
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxPresent}
  gestaltMacOSCompatibilityBoxPresent = 0; //* True if running under the Classic */
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxHasSerial}
  gestaltMacOSCompatibilityBoxHasSerial = 1; //* True if Classic serial support is implemented. */
  {$EXTERNALSYM gestaltMacOSCompatibilityBoxless}
  gestaltMacOSCompatibilityBoxless = 2; //* True if we're Boxless (screen shared with Carbon/Cocoa) */
//};

//enum {
  {$EXTERNALSYM gestaltBusClkSpeed}
  gestaltBusClkSpeed            = $62636c6b; //'bclk' /* main I/O bus clock speed in hertz */
//};

//enum {
  {$EXTERNALSYM gestaltBusClkSpeedMHz}
  gestaltBusClkSpeedMHz         = $62636c6d; //'bclm' /* main I/O bus clock speed in megahertz ( a UInt32 ) */
//};

//enum {
  {$EXTERNALSYM gestaltCloseViewAttr}
  gestaltCloseViewAttr          = $42534461; //'BSDa', /* CloseView attributes */
  {$EXTERNALSYM gestaltCloseViewEnabled}
  gestaltCloseViewEnabled       = 0;    //* Closeview enabled (dynamic bit - returns current state) */
  {$EXTERNALSYM gestaltCloseViewDisplayMgrFriendly}
  gestaltCloseViewDisplayMgrFriendly = 1; //* Closeview compatible with Display Manager (FUTURE) */
//};

//enum {
  {$EXTERNALSYM gestaltCarbonVersion}
  gestaltCarbonVersion          = $63626f6e; //'cbon' /* version of Carbon API present in system */
//};

//enum {
  {$EXTERNALSYM gestaltCFMAttr}
  gestaltCFMAttr                = $63667267; //'cfrg', /* Selector for information about the Code Fragment Manager */
  {$EXTERNALSYM gestaltCFMPresent}
  gestaltCFMPresent             = 0;    //* True if the Code Fragment Manager is present */
  {$EXTERNALSYM gestaltCFMPresentMask}
  gestaltCFMPresentMask         = $0001;
  {$EXTERNALSYM gestaltCFM99Present}
  gestaltCFM99Present           = 2;    //* True if the CFM-99 features are present. */
  {$EXTERNALSYM gestaltCFM99PresentMask}
  gestaltCFM99PresentMask       = $0004;
//};

//enum {
  {$EXTERNALSYM gestaltProcessorCacheLineSize}
  gestaltProcessorCacheLineSize = $6373697a; //'csiz' /* The size, in bytes, of the processor cache line. */
//};

//enum {
  {$EXTERNALSYM gestaltCollectionMgrVersion}
  gestaltCollectionMgrVersion   = $636c746e;  // 'cltn' /* Collection Manager version */
//};

//enum {
  {$EXTERNALSYM gestaltColorMatchingAttr}
  gestaltColorMatchingAttr      = $636d7461; //'cmta', /* ColorSync attributes */
  {$EXTERNALSYM gestaltHighLevelMatching}
  gestaltHighLevelMatching      = 0;
  {$EXTERNALSYM gestaltColorMatchingLibLoaded}
  gestaltColorMatchingLibLoaded = 1;
//};

//enum {
  {$EXTERNALSYM gestaltColorMatchingVersion}
  gestaltColorMatchingVersion   = $636d7463; // 'cmtc',
  {$EXTERNALSYM gestaltColorSync10}
  gestaltColorSync10            = $0100; //* 0x0100 & 0x0110 _Gestalt versions for 1.0-1.0.3 product */
  {$EXTERNALSYM gestaltColorSync11}
  gestaltColorSync11            = $0110; //*   0x0100 == low-level matching only */
  {$EXTERNALSYM gestaltColorSync104}
  gestaltColorSync104           = $0104; //* Real version, by popular demand */
  {$EXTERNALSYM gestaltColorSync105}
  gestaltColorSync105           = $0105;
  {$EXTERNALSYM gestaltColorSync20}
  gestaltColorSync20            = $0200; //* ColorSync 2.0 */
  {$EXTERNALSYM gestaltColorSync21}
  gestaltColorSync21            = $0210;
  {$EXTERNALSYM gestaltColorSync211}
  gestaltColorSync211           = $0211;
  {$EXTERNALSYM gestaltColorSync212}
  gestaltColorSync212           = $0212;
  {$EXTERNALSYM gestaltColorSync213}
  gestaltColorSync213           = $0213;
  {$EXTERNALSYM gestaltColorSync25}
  gestaltColorSync25            = $0250;
  {$EXTERNALSYM gestaltColorSync26}
  gestaltColorSync26            = $0260;
  {$EXTERNALSYM gestaltColorSync261}
  gestaltColorSync261           = $0261;
  {$EXTERNALSYM gestaltColorSync30}
  gestaltColorSync30            = $0300;
//};

//enum {
//  gestaltControlMgrVersion      = 'cmvr' /* NOTE: The first version we return is 3.0.1, on Mac OS X plus update 2*/
  {$EXTERNALSYM gestaltControlMgrVersion}
  gestaltControlMgrVersion      = $636d7672;
//};

//enum {
//  gestaltControlMgrAttr         = 'cntl', /* Control Mgr*/
  {$EXTERNALSYM gestaltControlMgrAttr}
  gestaltControlMgrAttr         = $636e746c;
  {$EXTERNALSYM gestaltControlMgrPresent}
  gestaltControlMgrPresent      = (1 shl 0); //* NOTE: this is a bit mask, whereas all other Gestalt constants of*/
                                        //* this type are bit index values.   Universal Interfaces 3.2 slipped*/
                                        //* out the door with this mistake.*/
  {$EXTERNALSYM gestaltControlMgrPresentBit}
  gestaltControlMgrPresentBit   = 0;    //* bit number*/
  {$EXTERNALSYM gestaltControlMsgPresentMask}
  gestaltControlMsgPresentMask  = (1 shl gestaltControlMgrPresentBit);
//};

//enum {
  {$EXTERNALSYM gestaltConnMgrAttr}
  gestaltConnMgrAttr            = $636f6e6e; //'conn', /* connection mgr attributes    */
  {$EXTERNALSYM gestaltConnMgrPresent}
  gestaltConnMgrPresent         = 0;
  {$EXTERNALSYM gestaltConnMgrCMSearchFix}
  gestaltConnMgrCMSearchFix     = 1;    //* Fix to CMAddSearch?     */
  {$EXTERNALSYM gestaltConnMgrErrorString}
  gestaltConnMgrErrorString     = 2;    //* has CMGetErrorString() */
  {$EXTERNALSYM gestaltConnMgrMultiAsyncIO}
  gestaltConnMgrMultiAsyncIO    = 3;    //* CMNewIOPB, CMDisposeIOPB, CMPBRead, CMPBWrite, CMPBIOKill */
//};

//enum {
  {$EXTERNALSYM gestaltColorPickerVersion}
  gestaltColorPickerVersion     = $63706b72; //'cpkr', /* returns version of ColorPicker */
  {$EXTERNALSYM gestaltColorPicker}
  gestaltColorPicker            = $63706b72; //'cpkr' /* gestaltColorPicker is old name for gestaltColorPickerVersion */
//};

//enum {
  {$EXTERNALSYM gestaltComponentMgr}
  gestaltComponentMgr           = $63706e74; //'cpnt', /* Component Mgr version */
  {$EXTERNALSYM gestaltComponentPlatform}
  gestaltComponentPlatform      = $636f706c; //'copl' /* Component Platform number */
//};

{*
    The gestaltNativeCPUtype ('cput') selector can be used to determine the
    native CPU type for all Macs running System 7.5 or later.

    However, the use of these selectors for pretty much anything is discouraged.
    If you are trying to determine if you can use a particular processor or
    operating system feature, it would be much better to check directly for that
    feature using one of the apis for doing so -- like, sysctl() or sysctlbyname().
    Those apis return information directly from the operating system and kernel.  By
    using those apis you may be able to avoid linking against Frameworks which you
    otherwise don't need, and may lessen the memory and code footprint of your
    applications.

    The gestaltNativeCPUfamily ('cpuf') selector can be used to determine the
    general family the native CPU is in.

    gestaltNativeCPUfamily uses the same results as gestaltNativeCPUtype, but
    will only return certain CPU values.

    IMPORTANT NOTE: gestaltNativeCPUFamily may no longer be updated for any new
                    processor families introduced after the 970.  If there are
                    processor specific features you need to be checking for in
                    your code, use one of the appropriate apis to get for those
                    exact features instead of assuming that all members of a given
                    cpu family exhibit the same behaviour.  The most appropriate api
                    to look at is sysctl() and sysctlbyname(), which return information
                    direct from the kernel about the system.
*}
//enum {
  {$EXTERNALSYM gestaltNativeCPUtype}
  gestaltNativeCPUtype          = $63707574; // 'cput', /* Native CPU type                          */
  {$EXTERNALSYM gestaltNativeCPUfamily}
  gestaltNativeCPUfamily        = $63707566; //'cpuf', /* Native CPU family                      */
  {$EXTERNALSYM gestaltCPU68000}
  gestaltCPU68000               = 0;    //* Various 68k CPUs...    */
  {$EXTERNALSYM gestaltCPU68010}
  gestaltCPU68010               = 1;
  {$EXTERNALSYM gestaltCPU68020}
  gestaltCPU68020               = 2;
  {$EXTERNALSYM gestaltCPU68030}
  gestaltCPU68030               = 3;
  {$EXTERNALSYM gestaltCPU68040}
  gestaltCPU68040               = 4;
  {$EXTERNALSYM gestaltCPU601}
  gestaltCPU601                 = $0101; //* IBM 601                               */
  {$EXTERNALSYM gestaltCPU603}
  gestaltCPU603                 = $0103;
  {$EXTERNALSYM gestaltCPU604}
  gestaltCPU604                 = $0104;
  {$EXTERNALSYM gestaltCPU603e}
  gestaltCPU603e                = $0106;
  {$EXTERNALSYM gestaltCPU603ev}
  gestaltCPU603ev               = $0107;
  {$EXTERNALSYM gestaltCPU750}
  gestaltCPU750                 = $0108; //* Also 740 - "G3" */
  {$EXTERNALSYM gestaltCPU604e}
  gestaltCPU604e                = $0109;
  {$EXTERNALSYM gestaltCPU604ev}
  gestaltCPU604ev               = $010A; //* Mach 5, 250Mhz and up */
  {$EXTERNALSYM gestaltCPUG4}
  gestaltCPUG4                  = $010C; //* Max */
  {$EXTERNALSYM gestaltCPUG47450}
  gestaltCPUG47450              = $0110; //* Vger , Altivec */
//};

//enum {
  {$EXTERNALSYM gestaltCPUApollo}
  gestaltCPUApollo              = $0111; //* Apollo , Altivec, G4 7455 */
  {$EXTERNALSYM gestaltCPUG47447}
  gestaltCPUG47447              = $0112;
  {$EXTERNALSYM gestaltCPU750FX}
  gestaltCPU750FX               = $0120; //* Sahara,G3 like thing */
  {$EXTERNALSYM gestaltCPU970}
  gestaltCPU970                 = $0139; //* G5 */
  {$EXTERNALSYM gestaltCPU970FX}
  gestaltCPU970FX               = $013C; //* another G5 */
  {$EXTERNALSYM gestaltCPU970MP}
  gestaltCPU970MP               = $0144;
//};

//enum {
                                        //* x86 CPUs all start with 'i' in the high nybble */
  {$EXTERNALSYM gestaltCPU486}
  gestaltCPU486                 = $69343836; //'i486',

  {$EXTERNALSYM gestaltCPUPentium}
  gestaltCPUPentium             = $69353836; //'i586',
  {$EXTERNALSYM gestaltCPUPentiumPro}
  gestaltCPUPentiumPro          =  $69357072; //'i5pr',
  {$EXTERNALSYM gestaltCPUPentiumII}
  gestaltCPUPentiumII           = $69356969; //'i5ii',

  {$EXTERNALSYM gestaltCPUX86}
  gestaltCPUX86                 = $69787878; //'ixxx',
  {$EXTERNALSYM gestaltCPUPentium4}
  gestaltCPUPentium4            = $69356976; //'i5iv'
//};

//enum {
  {$EXTERNALSYM gestaltCRMAttr}
  gestaltCRMAttr                = $63726d20; //'crm ', /* comm resource mgr attributes */
  {$EXTERNALSYM gestaltCRMPresent}
  gestaltCRMPresent             = 0;
  {$EXTERNALSYM gestaltCRMPersistentFix}
  gestaltCRMPersistentFix       = 1;    //* fix for persistent tools */
  {$EXTERNALSYM gestaltCRMToolRsrcCalls}
  gestaltCRMToolRsrcCalls       = 2;    //* has CRMGetToolResource/ReleaseToolResource */
//};

//enum {
  {$EXTERNALSYM gestaltControlStripVersion}
  gestaltControlStripVersion    = $63737672; //'csvr' /* Control Strip version (was 'sdvr') */
//};

//enum {
  {$EXTERNALSYM gestaltCountOfCPUs}
  gestaltCountOfCPUs            = $63707573; //'cpus' /* the number of CPUs on the computer, Mac OS X 10.4 and later */
//};

//enum {
  {$EXTERNALSYM gestaltCTBVersion}
  gestaltCTBVersion             = $63746276; //'ctbv' /* CommToolbox version */
//};

//enum {
  {$EXTERNALSYM gestaltDBAccessMgrAttr}
  gestaltDBAccessMgrAttr        = $64626163; // 'dbac', /* Database Access Mgr attributes */
  {$EXTERNALSYM gestaltDBAccessMgrPresent}
  gestaltDBAccessMgrPresent     = 0;     //* True if Database Access Mgr present */
//};

//enum {
  {$EXTERNALSYM gestaltDiskCacheSize}
  gestaltDiskCacheSize          = $6463737a; //'dcsz' /* Size of disk cache's buffers, in bytes */
//};

//enum {
  {$EXTERNALSYM gestaltSDPFindVersion}
  gestaltSDPFindVersion         = $64666e64; // 'dfnd' /* OCE Standard Directory Panel*/
//};

//enum {
  {$EXTERNALSYM gestaltDictionaryMgrAttr}
  gestaltDictionaryMgrAttr      = $64696374; // 'dict', /* Dictionary Manager attributes */
  {$EXTERNALSYM gestaltDictionaryMgrPresent}
  gestaltDictionaryMgrPresent   = 0;     //* Dictionary Manager attributes */
//};

//enum {
  {$EXTERNALSYM gestaltDITLExtAttr}
  gestaltDITLExtAttr            = $6469746c; //'ditl', /* AppenDITL, etc. calls from CTB */
  {$EXTERNALSYM gestaltDITLExtPresent}
  gestaltDITLExtPresent         = 0;    //* True if calls are present */
  {$EXTERNALSYM gestaltDITLExtSupportsIctb}
  gestaltDITLExtSupportsIctb    = 1;     //* True if AppendDITL, ShortenDITL support 'ictb's */
//};

//enum {
  {$EXTERNALSYM gestaltDialogMgrAttr}
  gestaltDialogMgrAttr          = $646c6f67; // 'dlog', /* Dialog Mgr*/
  {$EXTERNALSYM gestaltDialogMgrPresent}
  gestaltDialogMgrPresent       = (1 shl 0); //* NOTE: this is a bit mask, whereas all other Gestalt constants of*/
                                        //* this type are bit index values.   Universal Interfaces 3.2 slipped*/
                                        //* out the door with this mistake.*/
  {$EXTERNALSYM gestaltDialogMgrPresentBit}
  gestaltDialogMgrPresentBit    = 0;    //* bit number*/
  {$EXTERNALSYM gestaltDialogMgrHasAquaAlertBit}
  gestaltDialogMgrHasAquaAlertBit = 2;  //* bit number*/
  {$EXTERNALSYM gestaltDialogMgrPresentMask}
  gestaltDialogMgrPresentMask   = (1 shl gestaltDialogMgrPresentBit);
  {$EXTERNALSYM gestaltDialogMgrHasAquaAlertMask}
  gestaltDialogMgrHasAquaAlertMask = (1 shl gestaltDialogMgrHasAquaAlertBit);
  {$EXTERNALSYM gestaltDialogMsgPresentMask}
  gestaltDialogMsgPresentMask   = gestaltDialogMgrPresentMask; //* compatibility mask*/
//};

//enum {
  {$EXTERNALSYM gestaltDesktopPicturesAttr}
  gestaltDesktopPicturesAttr    = $646b7078; //'dkpx', /* Desktop Pictures attributes */
  {$EXTERNALSYM gestaltDesktopPicturesInstalled}
  gestaltDesktopPicturesInstalled = 0;  //* True if control panel is installed */
  {$EXTERNALSYM gestaltDesktopPicturesDisplayed}
  gestaltDesktopPicturesDisplayed = 1;  //* True if a picture is currently displayed */
//};

//enum {
  {$EXTERNALSYM gestaltDisplayMgrVers}
  gestaltDisplayMgrVers         = $64706c76; //'dplv' /* Display Manager version */
//};

//enum {
  {$EXTERNALSYM gestaltDisplayMgrAttr}
  gestaltDisplayMgrAttr         = $64706c79; //'dply', /* Display Manager attributes */
  {$EXTERNALSYM gestaltDisplayMgrPresent}
  gestaltDisplayMgrPresent      = 0;    //* True if Display Mgr is present */
  {$EXTERNALSYM gestaltDisplayMgrCanSwitchMirrored}
  gestaltDisplayMgrCanSwitchMirrored = 2; //* True if Display Mgr can switch modes on mirrored displays */
  {$EXTERNALSYM gestaltDisplayMgrSetDepthNotifies}
  gestaltDisplayMgrSetDepthNotifies = 3; //* True SetDepth generates displays mgr notification */
  {$EXTERNALSYM gestaltDisplayMgrCanConfirm}
  gestaltDisplayMgrCanConfirm   = 4;    //* True Display Manager supports DMConfirmConfiguration */
  {$EXTERNALSYM gestaltDisplayMgrColorSyncAware}
  gestaltDisplayMgrColorSyncAware = 5;  //* True if Display Manager supports profiles for displays */
  {$EXTERNALSYM gestaltDisplayMgrGeneratesProfiles}
  gestaltDisplayMgrGeneratesProfiles = 6; //* True if Display Manager will automatically generate profiles for displays */
  {$EXTERNALSYM gestaltDisplayMgrSleepNotifies}
  gestaltDisplayMgrSleepNotifies = 7;    //* True if Display Mgr generates "displayWillSleep", "displayDidWake" notifications */
//};

//enum {
  {$EXTERNALSYM gestaltDragMgrAttr}
  gestaltDragMgrAttr            = $64726167; // 'drag', /* Drag Manager attributes */
  {$EXTERNALSYM gestaltDragMgrPresent}
  gestaltDragMgrPresent         = 0;    //* Drag Manager is present */
  {$EXTERNALSYM gestaltDragMgrFloatingWind}
  gestaltDragMgrFloatingWind    = 1;    //* Drag Manager supports floating windows */
  {$EXTERNALSYM gestaltPPCDragLibPresent}
  gestaltPPCDragLibPresent      = 2;    //* Drag Manager PPC DragLib is present */
  {$EXTERNALSYM gestaltDragMgrHasImageSupport}
  gestaltDragMgrHasImageSupport = 3;    //* Drag Manager allows SetDragImage call */
  {$EXTERNALSYM gestaltCanStartDragInFloatWindow}
  gestaltCanStartDragInFloatWindow = 4; //* Drag Manager supports starting a drag in a floating window */
  {$EXTERNALSYM gestaltSetDragImageUpdates}
  gestaltSetDragImageUpdates    = 5;     //* Drag Manager supports drag image updating via SetDragImage */
//};

//enum {
  {$EXTERNALSYM gestaltDrawSprocketVersion}
  gestaltDrawSprocketVersion    = $64737076; // 'dspv' /* Draw Sprocket version (as a NumVersion) */
//};

//enum {
  {$EXTERNALSYM gestaltDigitalSignatureVersion}
  gestaltDigitalSignatureVersion = $64736967; //'dsig' /* returns Digital Signature Toolbox version in low-order word*/
//};

{*
   Desktop Printing Feature Gestalt
   Use this gestalt to check if third-party printer driver support is available
*}
//enum {
  {$EXTERNALSYM gestaltDTPFeatures}
  gestaltDTPFeatures            = $64747066; // 'dtpf',
  {$EXTERNALSYM kDTPThirdPartySupported}
  kDTPThirdPartySupported       = $00000004; //* mask for checking if third-party drivers are supported*/
//};


{*
   Desktop Printer Info Gestalt
   Use this gestalt to get a hold of information for all of the active desktop printers
*}
//enum {
  {$EXTERNALSYM gestaltDTPInfo}
  gestaltDTPInfo                = $64747078; //'dtpx' /* returns GestaltDTPInfoHdle*/
//};

//enum {
  {$EXTERNALSYM gestaltEasyAccessAttr}
  gestaltEasyAccessAttr         = $65617379; // 'easy', /* Easy Access attributes */
  {$EXTERNALSYM gestaltEasyAccessOff}
  gestaltEasyAccessOff          = 0;    //* if Easy Access present, but off (no icon) */
  {$EXTERNALSYM gestaltEasyAccessOn}
  gestaltEasyAccessOn           = 1;    //* if Easy Access "On" */
  {$EXTERNALSYM gestaltEasyAccessSticky}
  gestaltEasyAccessSticky       = 2;    //* if Easy Access "Sticky" */
  {$EXTERNALSYM gestaltEasyAccessLocked}
  gestaltEasyAccessLocked       = 3;    //* if Easy Access "Locked" */
//};

//enum {
  {$EXTERNALSYM gestaltEditionMgrAttr}
  gestaltEditionMgrAttr         = $6564746e; //'edtn', /* Edition Mgr attributes */
  {$EXTERNALSYM gestaltEditionMgrPresent}
  gestaltEditionMgrPresent      = 0;    //* True if Edition Mgr present */
  {$EXTERNALSYM gestaltEditionMgrTranslationAware}
  gestaltEditionMgrTranslationAware = 1; //* True if edition manager is translation manager aware */
//};

//enum {
  {$EXTERNALSYM gestaltAppleEventsAttr}
  gestaltAppleEventsAttr        = $65766e74; //'evnt', /* Apple Events attributes */
  {$EXTERNALSYM gestaltAppleEventsPresent}
  gestaltAppleEventsPresent     = 0;    //* True if Apple Events present */
  {$EXTERNALSYM gestaltScriptingSupport}
  gestaltScriptingSupport       = 1;
  {$EXTERNALSYM gestaltOSLInSystem}
  gestaltOSLInSystem            = 2;    //* OSL is in system so don’t use the one linked in to app */
  {$EXTERNALSYM gestaltSupportsApplicationURL}
  gestaltSupportsApplicationURL = 4;     //* Supports the typeApplicationURL addressing mode */
//};

//enum {
  {$EXTERNALSYM gestaltExtensionTableVersion}
  gestaltExtensionTableVersion  = $6574626c; // 'etbl' /* ExtensionTable version */
//};


//enum {
  {$EXTERNALSYM gestaltFBCIndexingState}
  gestaltFBCIndexingState       = $66626369;// 'fbci', /* Find By Content indexing state*/
  {$EXTERNALSYM gestaltFBCindexingSafe}
  gestaltFBCindexingSafe        = 0;    //* any search will result in synchronous wait*/
  {$EXTERNALSYM gestaltFBCindexingCritical}
  gestaltFBCindexingCritical    = 1;     //* any search will execute immediately*/
//};

//enum {
  {$EXTERNALSYM gestaltFBCVersion}
  gestaltFBCVersion             = $66626376;// 'fbcv', /* Find By Content version*/
  {$EXTERNALSYM gestaltFBCCurrentVersion}
  gestaltFBCCurrentVersion      = $0011; //* First release for OS 8/9*/
  {$EXTERNALSYM gestaltOSXFBCCurrentVersion}
  gestaltOSXFBCCurrentVersion   = $0100; //* First release for OS X*/
//};


//enum {
  {$EXTERNALSYM gestaltFileMappingAttr}
  gestaltFileMappingAttr        = $666c6d70; //'flmp', /* File mapping attributes*/
  {$EXTERNALSYM gestaltFileMappingPresent}
  gestaltFileMappingPresent     = 0;    //* bit is set if file mapping APIs are present*/
  {$EXTERNALSYM gestaltFileMappingMultipleFilesFix}
  gestaltFileMappingMultipleFilesFix = 1; //* bit is set if multiple files per volume can be mapped*/
//};

//enum {
  {$EXTERNALSYM gestaltFloppyAttr}
  gestaltFloppyAttr             = $666c7079; //'flpy', /* Floppy disk drive/driver attributes */
  {$EXTERNALSYM gestaltFloppyIsMFMOnly}
  gestaltFloppyIsMFMOnly        = 0;    //* Floppy driver only supports MFM disk formats */
  {$EXTERNALSYM gestaltFloppyIsManualEject}
  gestaltFloppyIsManualEject    = 1;    //* Floppy drive, driver, and file system are in manual-eject mode */
  {$EXTERNALSYM gestaltFloppyUsesDiskInPlace}
  gestaltFloppyUsesDiskInPlace  = 2;     //* Floppy drive must have special DISK-IN-PLACE output; standard DISK-CHANGED not used */
//};

//enum {
  {$EXTERNALSYM gestaltFinderAttr}
  gestaltFinderAttr             = $666e6472;// 'fndr', //* Finder attributes */
  {$EXTERNALSYM gestaltFinderDropEvent}
  gestaltFinderDropEvent        = 0;    //* Finder recognizes drop event */
  {$EXTERNALSYM gestaltFinderMagicPlacement}
  gestaltFinderMagicPlacement   = 1;    //* Finder supports magic icon placement */
  {$EXTERNALSYM gestaltFinderCallsAEProcess}
  gestaltFinderCallsAEProcess   = 2;    //* Finder calls AEProcessAppleEvent */
  {$EXTERNALSYM gestaltOSLCompliantFinder}
  gestaltOSLCompliantFinder     = 3;    //* Finder is scriptable and recordable */
  {$EXTERNALSYM gestaltFinderSupports4GBVolumes}
  gestaltFinderSupports4GBVolumes = 4;  //* Finder correctly handles 4GB volumes */
  {$EXTERNALSYM gestaltFinderHasClippings}
  gestaltFinderHasClippings     = 6;    //* Finder supports Drag Manager clipping files */
  {$EXTERNALSYM gestaltFinderFullDragManagerSupport}
  gestaltFinderFullDragManagerSupport = 7; //* Finder accepts 'hfs ' flavors properly */
  {$EXTERNALSYM gestaltFinderFloppyRootComments}
  gestaltFinderFloppyRootComments = 8;  //* in MacOS 8 and later, will be set if Finder ever supports comments on Floppy icons */
  {$EXTERNALSYM gestaltFinderLargeAndNotSavedFlavorsOK}
  gestaltFinderLargeAndNotSavedFlavorsOK = 9; //* in MacOS 8 and later, this bit is set if drags with >1024-byte flavors and flavorNotSaved flavors work reliably */
  {$EXTERNALSYM gestaltFinderUsesExtensibleFolderManager}
  gestaltFinderUsesExtensibleFolderManager = 10; //* Finder uses Extensible Folder Manager (for example, for Magic Routing) */
  {$EXTERNALSYM gestaltFinderUnderstandsRedirectedDesktopFolder}
  gestaltFinderUnderstandsRedirectedDesktopFolder = 11; //* Finder deals with startup disk's desktop folder residing on another disk */
//};

//enum {
  {$EXTERNALSYM gestaltFindFolderAttr}
  gestaltFindFolderAttr         = $666f6c64; // 'fold', /* Folder Mgr attributes */
  {$EXTERNALSYM gestaltFindFolderPresent}
  gestaltFindFolderPresent      = 0;    //* True if Folder Mgr present */
  {$EXTERNALSYM gestaltFolderDescSupport}
  gestaltFolderDescSupport      = 1;    //* True if Folder Mgr has FolderDesc calls */
  {$EXTERNALSYM gestaltFolderMgrFollowsAliasesWhenResolving}
  gestaltFolderMgrFollowsAliasesWhenResolving = 2; //* True if Folder Mgr follows folder aliases */
  {$EXTERNALSYM gestaltFolderMgrSupportsExtendedCalls}
  gestaltFolderMgrSupportsExtendedCalls = 3; //* True if Folder Mgr supports the Extended calls */
  {$EXTERNALSYM gestaltFolderMgrSupportsDomains}
  gestaltFolderMgrSupportsDomains = 4;  //* True if Folder Mgr supports domains for the first parameter to FindFolder */
  {$EXTERNALSYM gestaltFolderMgrSupportsFSCalls}
  gestaltFolderMgrSupportsFSCalls = 5;   //* True if FOlder manager supports __FindFolderFSRef & __FindFolderExtendedFSRef */
//};

//enum {
  {$EXTERNALSYM gestaltFindFolderRedirectionAttr}
  gestaltFindFolderRedirectionAttr = $666f6c65; //'fole'
//};


//enum {
  {$EXTERNALSYM gestaltFontMgrAttr}
  gestaltFontMgrAttr            = $666f6e74;//'font', /* Font Mgr attributes */
  {$EXTERNALSYM gestaltOutlineFonts}
  gestaltOutlineFonts           = 0;     //* True if Outline Fonts supported */
//};

//enum {
  {$EXTERNALSYM gestaltFPUType}
  gestaltFPUType                = $66707520; //'fpu ', /* fpu type */
  {$EXTERNALSYM gestaltNoFPU}
  gestaltNoFPU                  = 0;    //* no FPU */
  {$EXTERNALSYM gestalt68881}
  gestalt68881                  = 1;    //* 68881 FPU */
  {$EXTERNALSYM gestalt68882}
  gestalt68882                  = 2;    //* 68882 FPU */
  {$EXTERNALSYM gestalt68040FPU}
  gestalt68040FPU               = 3;    //* 68040 built-in FPU */
//};

//enum {
  {$EXTERNALSYM gestaltFSAttr}
  gestaltFSAttr                 = $66732020; //'fs  ', /* file system attributes */
  {$EXTERNALSYM gestaltFullExtFSDispatching}
  gestaltFullExtFSDispatching   = 0;    //* has really cool new HFSDispatch dispatcher */
  {$EXTERNALSYM gestaltHasFSSpecCalls}
  gestaltHasFSSpecCalls         = 1;    //* has FSSpec calls */
  {$EXTERNALSYM gestaltHasFileSystemManager}
  gestaltHasFileSystemManager   = 2;    //* has a file system manager */
  {$EXTERNALSYM gestaltFSMDoesDynamicLoad}
  gestaltFSMDoesDynamicLoad     = 3;    //* file system manager supports dynamic loading */
  {$EXTERNALSYM gestaltFSSupports4GBVols}
  gestaltFSSupports4GBVols      = 4;    //* file system supports 4 gigabyte volumes */
  {$EXTERNALSYM gestaltFSSupports2TBVols}
  gestaltFSSupports2TBVols      = 5;    //* file system supports 2 terabyte volumes */
  {$EXTERNALSYM gestaltHasExtendedDiskInit}
  gestaltHasExtendedDiskInit    = 6;    //* has extended Disk Initialization calls */
  {$EXTERNALSYM gestaltDTMgrSupportsFSM}
  gestaltDTMgrSupportsFSM       = 7;    //* Desktop Manager support FSM-based foreign file systems */
  {$EXTERNALSYM gestaltFSNoMFSVols}
  gestaltFSNoMFSVols            = 8;    //* file system doesn't supports MFS volumes */
  {$EXTERNALSYM gestaltFSSupportsHFSPlusVols}
  gestaltFSSupportsHFSPlusVols  = 9;    //* file system supports HFS Plus volumes */
  {$EXTERNALSYM gestaltFSIncompatibleDFA82}
  gestaltFSIncompatibleDFA82    = 10;    //* VCB and FCB structures changed; DFA 8.2 is incompatible */
//};

//enum {
  {$EXTERNALSYM gestaltFSSupportsDirectIO}
  gestaltFSSupportsDirectIO     = 11;    //* file system supports DirectIO */
//};

//enum {
  {$EXTERNALSYM gestaltHasHFSPlusAPIs}
  gestaltHasHFSPlusAPIs         = 12;   //* file system supports HFS Plus APIs */
  {$EXTERNALSYM gestaltMustUseFCBAccessors}
  gestaltMustUseFCBAccessors    = 13;   //* FCBSPtr and FSFCBLen are invalid - must use FSM FCB accessor functions*/
  {$EXTERNALSYM gestaltFSUsesPOSIXPathsForConversion}
  gestaltFSUsesPOSIXPathsForConversion = 14; //* The path interchange routines operate on POSIX paths instead of HFS paths */
  {$EXTERNALSYM gestaltFSSupportsExclusiveLocks}
  gestaltFSSupportsExclusiveLocks = 15; //* File system uses POSIX O_EXLOCK for opens */
  {$EXTERNALSYM gestaltFSSupportsHardLinkDetection}
  gestaltFSSupportsHardLinkDetection = 16; //* File system returns if an item is a hard link */
  {$EXTERNALSYM gestaltFSAllowsConcurrentAsyncIO}
  gestaltFSAllowsConcurrentAsyncIO = 17; //* File Manager supports concurrent async reads and writes */
//};

//enum {
  {$EXTERNALSYM gestaltAdminFeaturesFlagsAttr}
  gestaltAdminFeaturesFlagsAttr = $66726564; // 'fred', /* a set of admin flags, mostly useful internally. */
  {$EXTERNALSYM gestaltFinderUsesSpecialOpenFoldersFile}
  gestaltFinderUsesSpecialOpenFoldersFile = 0; //* the Finder uses a special file to store the list of open folders */
//};

//enum {
  {$EXTERNALSYM gestaltFSMVersion}
  gestaltFSMVersion             = $66736d20; //'fsm ' /* returns version of HFS External File Systems Manager (FSM) */
//};

//enum {
  {$EXTERNALSYM gestaltFXfrMgrAttr}
  gestaltFXfrMgrAttr            = $66786672; // 'fxfr', /* file transfer manager attributes */
  {$EXTERNALSYM gestaltFXfrMgrPresent}
  gestaltFXfrMgrPresent         = 0;
  {$EXTERNALSYM gestaltFXfrMgrMultiFile}
  gestaltFXfrMgrMultiFile       = 1;    //* supports FTSend and FTReceive */
  {$EXTERNALSYM gestaltFXfrMgrErrorString}
  gestaltFXfrMgrErrorString     = 2;    //* supports FTGetErrorString */
  {$EXTERNALSYM gestaltFXfrMgrAsync}
  gestaltFXfrMgrAsync           = 3;    //*supports FTSendAsync, FTReceiveAsync, FTCompletionAsync*/
//};

//enum {
  {$EXTERNALSYM gestaltGraphicsAttr}
  gestaltGraphicsAttr           = $67667861; // 'gfxa', /* Quickdraw GX attributes selector */
  {$EXTERNALSYM gestaltGraphicsIsDebugging}
  gestaltGraphicsIsDebugging    = $00000001;
  {$EXTERNALSYM gestaltGraphicsIsLoaded}
  gestaltGraphicsIsLoaded       = $00000002;
  {$EXTERNALSYM gestaltGraphicsIsPowerPC}
  gestaltGraphicsIsPowerPC      = $00000004;
//};

//enum {
  {$EXTERNALSYM gestaltGraphicsVersion}
  gestaltGraphicsVersion        = $67726678; //'grfx', /* Quickdraw GX version selector */
  {$EXTERNALSYM gestaltCurrentGraphicsVersion}
  gestaltCurrentGraphicsVersion = $00010200; //* the version described in this set of headers */
//};

//enum {
  {$EXTERNALSYM gestaltHardwareAttr}
  gestaltHardwareAttr           = $68647772; //'hdwr', /* hardware attributes */
  {$EXTERNALSYM gestaltHasVIA1}
  gestaltHasVIA1                = 0;    //* VIA1 exists */
  {$EXTERNALSYM gestaltHasVIA2}
  gestaltHasVIA2                = 1;    //* VIA2 exists */
  {$EXTERNALSYM gestaltHasASC}
  gestaltHasASC                 = 3;    //* Apple Sound Chip exists */
  {$EXTERNALSYM gestaltHasSCC}
  gestaltHasSCC                 = 4;    //* SCC exists */
  {$EXTERNALSYM gestaltHasSCSI}
  gestaltHasSCSI                = 7;    //* SCSI exists */
  {$EXTERNALSYM gestaltHasSoftPowerOff}
  gestaltHasSoftPowerOff        = 19;   //* Capable of software power off */
  {$EXTERNALSYM gestaltHasSCSI961}
  gestaltHasSCSI961             = 21;   //* 53C96 SCSI controller on internal bus */
  {$EXTERNALSYM gestaltHasSCSI962}
  gestaltHasSCSI962             = 22;   //* 53C96 SCSI controller on external bus */
  {$EXTERNALSYM gestaltHasUniversalROM}
  gestaltHasUniversalROM        = 24;   //* Do we have a Universal ROM? */
  {$EXTERNALSYM gestaltHasEnhancedLtalk}
  gestaltHasEnhancedLtalk       = 30;   //* Do we have Enhanced LocalTalk? */
//};

//enum {
  {$EXTERNALSYM gestaltHelpMgrAttr}
  gestaltHelpMgrAttr            =  $68656c70;//'help', /* Help Mgr Attributes */
  {$EXTERNALSYM gestaltHelpMgrPresent}
  gestaltHelpMgrPresent         = 0;    //* true if help mgr is present */
  {$EXTERNALSYM gestaltHelpMgrExtensions}
  gestaltHelpMgrExtensions      = 1;    //* true if help mgr extensions are installed */
  {$EXTERNALSYM gestaltAppleGuideIsDebug}
  gestaltAppleGuideIsDebug      = 30;
  {$EXTERNALSYM gestaltAppleGuidePresent}
  gestaltAppleGuidePresent      = 31;   //* true if AppleGuide is installed */
//};

//enum {
  {$EXTERNALSYM gestaltHardwareVendorCode}
  gestaltHardwareVendorCode     = $68726164; //'hrad', /* Returns hardware vendor information */
  {$EXTERNALSYM gestaltHardwareVendorApple}
  gestaltHardwareVendorApple    = $4170706c; //'Appl' /* Hardware built by Apple */
//};

//enum {
  {$EXTERNALSYM gestaltCompressionMgr}
  gestaltCompressionMgr         = $69636d70; //'icmp' /* returns version of the Image Compression Manager */
//};

//enum {
  {$EXTERNALSYM gestaltIconUtilitiesAttr}
  gestaltIconUtilitiesAttr      = $69636f6e; //'icon', /* Icon Utilities attributes  (Note: available in System 7.0, despite gestalt) */
  {$EXTERNALSYM gestaltIconUtilitiesPresent}
   gestaltIconUtilitiesPresent   = 0;    //* true if icon utilities are present */
  {$EXTERNALSYM gestaltIconUtilitiesHas48PixelIcons}
  gestaltIconUtilitiesHas48PixelIcons = 1; //* true if 48x48 icons are supported by IconUtilities */
  {$EXTERNALSYM gestaltIconUtilitiesHas32BitIcons}
  gestaltIconUtilitiesHas32BitIcons = 2; //* true if 32-bit deep icons are supported */
  {$EXTERNALSYM gestaltIconUtilitiesHas8BitDeepMasks}
  gestaltIconUtilitiesHas8BitDeepMasks = 3; //* true if 8-bit deep masks are supported */
  {$EXTERNALSYM gestaltIconUtilitiesHasIconServices}
  gestaltIconUtilitiesHasIconServices = 4; //* true if IconServices is present */
//};

//enum {
  {$EXTERNALSYM gestaltInternalDisplay}
  gestaltInternalDisplay        = $69647370; //'idsp' //* slot number of internal display location */
//};

{*
    To obtain information about the connected keyboard(s), one should
    use the ADB Manager API.  See Technical Note OV16 for details.
*}
//enum {
  {$EXTERNALSYM gestaltKeyboardType}
  gestaltKeyboardType           = $6b626420; //'kbd ', /* keyboard type */
  {$EXTERNALSYM gestaltMacKbd}
  gestaltMacKbd                 = 1;
  {$EXTERNALSYM gestaltMacAndPad}
  gestaltMacAndPad              = 2;
  {$EXTERNALSYM gestaltMacPlusKbd}
  gestaltMacPlusKbd             = 3;    //* OBSOLETE: This pre-ADB keyboard is not supported by any Mac OS X hardware and this value now means gestaltUnknownThirdPartyKbd */
  {$EXTERNALSYM gestaltUnknownThirdPartyKbd}
  gestaltUnknownThirdPartyKbd   = 3;    //* Unknown 3rd party keyboard. */
  {$EXTERNALSYM gestaltExtADBKbd}
  gestaltExtADBKbd              = 4;
  {$EXTERNALSYM gestaltStdADBKbd}
  gestaltStdADBKbd              = 5;
  {$EXTERNALSYM gestaltPrtblADBKbd}
  gestaltPrtblADBKbd            = 6;
  {$EXTERNALSYM gestaltPrtblISOKbd}
  gestaltPrtblISOKbd            = 7;
  {$EXTERNALSYM gestaltStdISOADBKbd}
  gestaltStdISOADBKbd           = 8;
  {$EXTERNALSYM gestaltExtISOADBKbd}
  gestaltExtISOADBKbd           = 9;
  {$EXTERNALSYM gestaltADBKbdII}
  gestaltADBKbdII               = 10;
  {$EXTERNALSYM gestaltADBISOKbdII}
  gestaltADBISOKbdII            = 11;
  {$EXTERNALSYM gestaltPwrBookADBKbd}
  gestaltPwrBookADBKbd          = 12;
  {$EXTERNALSYM gestaltPwrBookISOADBKbd}
  gestaltPwrBookISOADBKbd       = 13;
  {$EXTERNALSYM gestaltAppleAdjustKeypad}
  gestaltAppleAdjustKeypad      = 14;
  {$EXTERNALSYM gestaltAppleAdjustADBKbd}
  gestaltAppleAdjustADBKbd      = 15;
  {$EXTERNALSYM gestaltAppleAdjustISOKbd}
  gestaltAppleAdjustISOKbd      = 16;
  {$EXTERNALSYM gestaltJapanAdjustADBKbd}
  gestaltJapanAdjustADBKbd      = 17;   //* Japan Adjustable Keyboard */
  {$EXTERNALSYM gestaltPwrBkExtISOKbd}
  gestaltPwrBkExtISOKbd         = 20;   //* PowerBook Extended International Keyboard with function keys */
  {$EXTERNALSYM gestaltPwrBkExtJISKbd}
  gestaltPwrBkExtJISKbd         = 21;   //* PowerBook Extended Japanese Keyboard with function keys      */
  {$EXTERNALSYM gestaltPwrBkExtADBKbd}
  gestaltPwrBkExtADBKbd         = 24;   //* PowerBook Extended Domestic Keyboard with function keys      */
  {$EXTERNALSYM gestaltPS2Keyboard}
  gestaltPS2Keyboard            = 27;   //* PS2 keyboard */
  {$EXTERNALSYM gestaltPwrBkSubDomKbd}
  gestaltPwrBkSubDomKbd         = 28;   //* PowerBook Subnote Domestic Keyboard with function keys w/  inverted T  */
  {$EXTERNALSYM gestaltPwrBkSubISOKbd}
  gestaltPwrBkSubISOKbd         = 29;   //* PowerBook Subnote International Keyboard with function keys w/  inverted T     */
  {$EXTERNALSYM gestaltPwrBkSubJISKbd}
  gestaltPwrBkSubJISKbd         = 30;   //* PowerBook Subnote Japanese Keyboard with function keys w/ inverted T    */
  {$EXTERNALSYM gestaltPortableUSBANSIKbd}
  gestaltPortableUSBANSIKbd     = 37;   //* Powerbook USB-based internal keyboard, ANSI layout */
  {$EXTERNALSYM gestaltPortableUSBISOKbd}
  gestaltPortableUSBISOKbd      = 38;   //* Powerbook USB-based internal keyboard, ISO layout */
  {$EXTERNALSYM gestaltPortableUSBJISKbd}
  gestaltPortableUSBJISKbd      = 39;   //* Powerbook USB-based internal keyboard, JIS layout */
  {$EXTERNALSYM gestaltThirdPartyANSIKbd}
  gestaltThirdPartyANSIKbd      = 40;   //* Third party keyboard, ANSI layout.  Returned in Mac OS X Tiger and later. */
  {$EXTERNALSYM gestaltThirdPartyISOKbd}
  gestaltThirdPartyISOKbd       = 41;   //* Third party keyboard, ISO layout. Returned in Mac OS X Tiger and later. */
  {$EXTERNALSYM gestaltThirdPartyJISKbd}
  gestaltThirdPartyJISKbd       = 42;   //* Third party keyboard, JIS layout. Returned in Mac OS X Tiger and later. */
  {$EXTERNALSYM gestaltPwrBkEKDomKbd}
  gestaltPwrBkEKDomKbd          = 195;  //* (0xC3) PowerBook Domestic Keyboard with Embedded Keypad, function keys & inverted T    */
  {$EXTERNALSYM gestaltPwrBkEKISOKbd}
  gestaltPwrBkEKISOKbd          = 196;  //* (0xC4) PowerBook International Keyboard with Embedded Keypad, function keys & inverted T   */
  {$EXTERNALSYM gestaltPwrBkEKJISKbd}
  gestaltPwrBkEKJISKbd          = 197;  //* (0xC5) PowerBook Japanese Keyboard with Embedded Keypad, function keys & inverted T      */
  {$EXTERNALSYM gestaltUSBCosmoANSIKbd}
  gestaltUSBCosmoANSIKbd        = 198;  //* (0xC6) original USB Domestic (ANSI) Keyboard */
  {$EXTERNALSYM gestaltUSBCosmoISOKbd}
  gestaltUSBCosmoISOKbd         = 199;  //* (0xC7) original USB International (ISO) Keyboard */
  {$EXTERNALSYM gestaltUSBCosmoJISKbd}
  gestaltUSBCosmoJISKbd         = 200;  //* (0xC8) original USB Japanese (JIS) Keyboard */
  {$EXTERNALSYM gestaltPwrBk99JISKbd}
  gestaltPwrBk99JISKbd          = 201;  //* (0xC9) '99 PowerBook JIS Keyboard with Embedded Keypad, function keys & inverted T               */
  {$EXTERNALSYM gestaltUSBAndyANSIKbd}
  gestaltUSBAndyANSIKbd         = 204;  //* (0xCC) USB Pro Keyboard Domestic (ANSI) Keyboard                                 */
  {$EXTERNALSYM gestaltUSBAndyISOKbd}
  gestaltUSBAndyISOKbd          = 205;  //* (0xCD) USB Pro Keyboard International (ISO) Keyboard                               */
  {$EXTERNALSYM gestaltUSBAndyJISKbd}
  gestaltUSBAndyJISKbd          = 206;  //* (0xCE) USB Pro Keyboard Japanese (JIS) Keyboard                                    */
//};


//enum {
  {$EXTERNALSYM gestaltPortable2001ANSIKbd}
  gestaltPortable2001ANSIKbd    = 202;  //* (0xCA) PowerBook and iBook Domestic (ANSI) Keyboard with 2nd cmd key right & function key moves.     */
  {$EXTERNALSYM gestaltPortable2001ISOKbd}
  gestaltPortable2001ISOKbd     = 203;  //* (0xCB) PowerBook and iBook International (ISO) Keyboard with 2nd cmd key right & function key moves.   */
  {$EXTERNALSYM gestaltPortable2001JISKbd}
  gestaltPortable2001JISKbd     = 207;   //* (0xCF) PowerBook and iBook Japanese (JIS) Keyboard with function key moves.                   */
//};

//enum {
  {$EXTERNALSYM gestaltUSBProF16ANSIKbd}
  gestaltUSBProF16ANSIKbd       = 34;   //* (0x22) USB Pro Keyboard w/ F16 key Domestic (ANSI) Keyboard */
  {$EXTERNALSYM gestaltUSBProF16ISOKbd}
  gestaltUSBProF16ISOKbd        = 35;   //* (0x23) USB Pro Keyboard w/ F16 key International (ISO) Keyboard */
  {$EXTERNALSYM gestaltUSBProF16JISKbd}
  gestaltUSBProF16JISKbd        = 36;   //* (0x24) USB Pro Keyboard w/ F16 key Japanese (JIS) Keyboard */
  {$EXTERNALSYM gestaltProF16ANSIKbd}
  gestaltProF16ANSIKbd          = 31;   //* (0x1F) Pro Keyboard w/F16 key Domestic (ANSI) Keyboard */
  {$EXTERNALSYM gestaltProF16ISOKbd}
  gestaltProF16ISOKbd           = 32;   //* (0x20) Pro Keyboard w/F16 key International (ISO) Keyboard */
  {$EXTERNALSYM gestaltProF16JISKbd}
  gestaltProF16JISKbd           = 33;   //* (0x21) Pro Keyboard w/F16 key Japanese (JIS) Keyboard */
//};

{*
    This gestalt indicates the highest UDF version that the active UDF implementation supports.
    The value should be assembled from a read version (upper word) and a write version (lower word)
*}
//enum {
  {$EXTERNALSYM gestaltUDFSupport}
  gestaltUDFSupport             = $6b756466; //'kudf' /*    Used for communication between UDF implementations*/
//};

//enum {
  {$EXTERNALSYM gestaltLowMemorySize}
  gestaltLowMemorySize          = $6c6d656d; //'lmem' /* size of low memory area */
//};

//enum {
  {$EXTERNALSYM gestaltLogicalRAMSize}
  gestaltLogicalRAMSize         = $6c72616d; //'lram' /* logical ram size */
//};

{
    MACHINE TYPE CONSTANTS NAMING CONVENTION

        All future machine type constant names take the following form:

            gestalt<lineName><modelNumber>

    Line Names

        The following table contains the lines currently produced by Apple and the
        lineName substrings associated with them:

            Line                        lineName
            -------------------------   ------------
            Macintosh LC                "MacLC"
            Macintosh Performa          "Performa"
            Macintosh PowerBook         "PowerBook"
            Macintosh PowerBook Duo     "PowerBookDuo"
            Power Macintosh             "PowerMac"
            Apple Workgroup Server      "AWS"

        The following table contains lineNames for some discontinued lines:

            Line                        lineName
            -------------------------   ------------
            Macintosh Quadra            "MacQuadra" (preferred)
                                        "Quadra" (also used, but not preferred)
            Macintosh Centris           "MacCentris"

    Model Numbers

        The modelNumber is a string representing the specific model of the machine
        within its particular line.  For example, for the Power Macintosh 8100/80,
        the modelNumber is "8100".

        Some Performa & LC model numbers contain variations in the rightmost 1 or 2
        digits to indicate different RAM and Hard Disk configurations.  A single
        machine type is assigned for all variations of a specific model number.  In
        this case, the modelNumber string consists of the constant leftmost part
        of the model number with 0s for the variant digits.  For example, the
        Performa 6115 and Performa 6116 are both return the same machine type
        constant:  gestaltPerforma6100.


    OLD NAMING CONVENTIONS

    The "Underscore Speed" suffix

        In the past, Apple differentiated between machines that had the same model
        number but different speeds.  For example, the Power Macintosh 8100/80 and
        Power Macintosh 8100/100 return different machine type constants.  This is
        why some existing machine type constant names take the form:

            gestalt<lineName><modelNumber>_<speed>

        e.g.

            gestaltPowerMac8100_110
            gestaltPowerMac7100_80
            gestaltPowerMac7100_66

        It is no longer necessary to use the "underscore speed" suffix.  Starting with
        the Power Surge machines (Power Macintosh 7200, 7500, 8500 and 9500), speed is
        no longer used to differentiate between machine types.  This is why a Power
        Macintosh 7200/75 and a Power Macintosh 7200/90 return the same machine type
        constant:  gestaltPowerMac7200.

    The "Screen Type" suffix

        All PowerBook models prior to the PowerBook 190, and all PowerBook Duo models
        before the PowerBook Duo 2300 take the form:

            gestalt<lineName><modelNumber><screenType>

        Where <screenType> is "c" or the empty string.

        e.g.

            gestaltPowerBook100
            gestaltPowerBookDuo280
            gestaltPowerBookDuo280c
            gestaltPowerBook180
            gestaltPowerBook180c

        Starting with the PowerBook 190 series and the PowerBook Duo 2300 series, machine
        types are no longer differentiated based on screen type.  This is why a PowerBook
        5300cs/100 and a PowerBook 5300c/100 both return the same machine type constant:
        gestaltPowerBook5300.

        Macintosh LC 630                gestaltMacLC630
        Macintosh Performa 6200         gestaltPerforma6200
        Macintosh Quadra 700            gestaltQuadra700
        Macintosh PowerBook 5300        gestaltPowerBook5300
        Macintosh PowerBook Duo 2300    gestaltPowerBookDuo2300
        Power Macintosh 8500            gestaltPowerMac8500
*}

//enum {
  {$EXTERNALSYM gestaltMachineType}
  gestaltMachineType            = $6d616368; //'mach', /* machine type */
  {$EXTERNALSYM gestaltClassic}
  gestaltClassic                = 1;
  {$EXTERNALSYM gestaltMacXL}
  gestaltMacXL                  = 2;
  {$EXTERNALSYM gestaltMac512KE}
  gestaltMac512KE               = 3;
  {$EXTERNALSYM gestaltMacPlus}
  gestaltMacPlus                = 4;
  {$EXTERNALSYM gestaltMacSE}
  gestaltMacSE                  = 5;
  {$EXTERNALSYM gestaltMacII}
  gestaltMacII                  = 6;
  {$EXTERNALSYM gestaltMacIIx}
  gestaltMacIIx                 = 7;
  {$EXTERNALSYM gestaltMacIIcx}
  gestaltMacIIcx                = 8;
  {$EXTERNALSYM gestaltMacSE030}
  gestaltMacSE030               = 9;
  {$EXTERNALSYM gestaltPortable}
  gestaltPortable               = 10;
  {$EXTERNALSYM gestaltMacIIci}
  gestaltMacIIci                = 11;
  {$EXTERNALSYM gestaltPowerMac8100_120}
  gestaltPowerMac8100_120       = 12;
  {$EXTERNALSYM gestaltMacIIfx}
  gestaltMacIIfx                = 13;
  {$EXTERNALSYM gestaltMacClassic}
  gestaltMacClassic             = 17;
  {$EXTERNALSYM gestaltMacIIsi}
  gestaltMacIIsi                = 18;
  {$EXTERNALSYM gestaltMacLC}
  gestaltMacLC                  = 19;
  {$EXTERNALSYM gestaltMacQuadra900}
  gestaltMacQuadra900           = 20;
  {$EXTERNALSYM gestaltPowerBook170}
  gestaltPowerBook170           = 21;
  {$EXTERNALSYM gestaltMacQuadra700}
  gestaltMacQuadra700           = 22;
  {$EXTERNALSYM gestaltClassicII}
  gestaltClassicII              = 23;
  {$EXTERNALSYM gestaltPowerBook100}
  gestaltPowerBook100           = 24;
  {$EXTERNALSYM gestaltPowerBook140}
  gestaltPowerBook140           = 25;
  {$EXTERNALSYM gestaltMacQuadra950}
  gestaltMacQuadra950           = 26;
  {$EXTERNALSYM gestaltMacLCIII}
  gestaltMacLCIII               = 27;
  {$EXTERNALSYM gestaltPerforma450}
  gestaltPerforma450            = gestaltMacLCIII;
  {$EXTERNALSYM gestaltPowerBookDuo210}
  gestaltPowerBookDuo210        = 29;
  {$EXTERNALSYM gestaltMacCentris650}
  gestaltMacCentris650          = 30;
  {$EXTERNALSYM gestaltPowerBookDuo230}
  gestaltPowerBookDuo230        = 32;
  {$EXTERNALSYM gestaltPowerBook180}
  gestaltPowerBook180           = 33;
  {$EXTERNALSYM gestaltPowerBook160}
  gestaltPowerBook160           = 34;
  {$EXTERNALSYM gestaltMacQuadra800}
  gestaltMacQuadra800           = 35;
  {$EXTERNALSYM gestaltMacQuadra650}
  gestaltMacQuadra650           = 36;
  {$EXTERNALSYM gestaltMacLCII}
  gestaltMacLCII                = 37;
  {$EXTERNALSYM gestaltPowerBookDuo250}
  gestaltPowerBookDuo250        = 38;
  {$EXTERNALSYM gestaltAWS9150_80}
  gestaltAWS9150_80             = 39;
  {$EXTERNALSYM gestaltPowerMac8100_110}
  gestaltPowerMac8100_110       = 40;
  {$EXTERNALSYM gestaltAWS8150_110}
  gestaltAWS8150_110            = gestaltPowerMac8100_110;
  {$EXTERNALSYM gestaltPowerMac5200}
  gestaltPowerMac5200           = 41;
  {$EXTERNALSYM gestaltPowerMac5260}
  gestaltPowerMac5260           = gestaltPowerMac5200;
  {$EXTERNALSYM gestaltPerforma5300}
  gestaltPerforma5300           = gestaltPowerMac5200;
  {$EXTERNALSYM gestaltPowerMac6200}
  gestaltPowerMac6200           = 42;
  {$EXTERNALSYM gestaltPerforma6300}
  gestaltPerforma6300           = gestaltPowerMac6200;
  {$EXTERNALSYM gestaltMacIIvi}
  gestaltMacIIvi                = 44;
  {$EXTERNALSYM gestaltMacIIvm}
  gestaltMacIIvm                = 45;
  {$EXTERNALSYM gestaltPerforma600}
  gestaltPerforma600            = gestaltMacIIvm;
  {$EXTERNALSYM gestaltPowerMac7100_80}
  gestaltPowerMac7100_80        = 47;
  {$EXTERNALSYM gestaltMacIIvx}
  gestaltMacIIvx                = 48;
  {$EXTERNALSYM gestaltMacColorClassic}
  gestaltMacColorClassic        = 49;
  {$EXTERNALSYM gestaltPerforma250}
  gestaltPerforma250            = gestaltMacColorClassic;
  {$EXTERNALSYM gestaltPowerBook165c}
  gestaltPowerBook165c          = 50;
  {$EXTERNALSYM gestaltMacCentris610}
  gestaltMacCentris610          = 52;
  {$EXTERNALSYM gestaltMacQuadra610}
  gestaltMacQuadra610           = 53;
  {$EXTERNALSYM gestaltPowerBook145}
  gestaltPowerBook145           = 54;
  {$EXTERNALSYM gestaltPowerMac8100_100}
  gestaltPowerMac8100_100       = 55;
  {$EXTERNALSYM gestaltMacLC520}
  gestaltMacLC520               = 56;
  {$EXTERNALSYM gestaltAWS9150_120}
  gestaltAWS9150_120            = 57;
  {$EXTERNALSYM gestaltPowerMac6400}
  gestaltPowerMac6400           = 58;
  {$EXTERNALSYM gestaltPerforma6400}
  gestaltPerforma6400           = gestaltPowerMac6400;
  {$EXTERNALSYM gestaltPerforma6360}
  gestaltPerforma6360           = gestaltPerforma6400;
  {$EXTERNALSYM gestaltMacCentris660AV}
  gestaltMacCentris660AV        = 60;
  {$EXTERNALSYM gestaltMacQuadra660AV}
  gestaltMacQuadra660AV         = gestaltMacCentris660AV;
  {$EXTERNALSYM gestaltPerforma46x}
  gestaltPerforma46x            = 62;
  {$EXTERNALSYM gestaltPowerMac8100_80}
  gestaltPowerMac8100_80        = 65;
  {$EXTERNALSYM gestaltAWS8150_80}
  gestaltAWS8150_80             = gestaltPowerMac8100_80;
  {$EXTERNALSYM gestaltPowerMac9500}
  gestaltPowerMac9500           = 67;
  {$EXTERNALSYM gestaltPowerMac9600}
  gestaltPowerMac9600           = gestaltPowerMac9500;
  {$EXTERNALSYM gestaltPowerMac7500}
  gestaltPowerMac7500           = 68;
  {$EXTERNALSYM gestaltPowerMac7600}
  gestaltPowerMac7600           = gestaltPowerMac7500;
  {$EXTERNALSYM gestaltPowerMac8500}
  gestaltPowerMac8500           = 69;
  {$EXTERNALSYM gestaltPowerMac8600}
  gestaltPowerMac8600           = gestaltPowerMac8500;
  {$EXTERNALSYM gestaltAWS8550}
  gestaltAWS8550                = gestaltPowerMac7500;
  {$EXTERNALSYM gestaltPowerBook180c}
  gestaltPowerBook180c          = 71;
  {$EXTERNALSYM gestaltPowerBook520}
  gestaltPowerBook520           = 72;
  {$EXTERNALSYM gestaltPowerBook520c}
  gestaltPowerBook520c          = gestaltPowerBook520;
  {$EXTERNALSYM gestaltPowerBook540}
  gestaltPowerBook540           = gestaltPowerBook520;
  {$EXTERNALSYM gestaltPowerBook540c}
  gestaltPowerBook540c          = gestaltPowerBook520;
  {$EXTERNALSYM gestaltPowerMac5400}
  gestaltPowerMac5400           = 74;
  {$EXTERNALSYM gestaltPowerMac6100_60}
  gestaltPowerMac6100_60        = 75;
  {$EXTERNALSYM gestaltAWS6150_60}
  gestaltAWS6150_60             = gestaltPowerMac6100_60;
  {$EXTERNALSYM gestaltPowerBookDuo270c}
  gestaltPowerBookDuo270c       = 77;
  {$EXTERNALSYM gestaltMacQuadra840AV}
  gestaltMacQuadra840AV         = 78;
  {$EXTERNALSYM gestaltPerforma550}
  gestaltPerforma550            = 80;
  {$EXTERNALSYM gestaltPowerBook165}
  gestaltPowerBook165           = 84;
  {$EXTERNALSYM gestaltPowerBook190}
  gestaltPowerBook190           = 85;
  {$EXTERNALSYM gestaltMacTV}
  gestaltMacTV                  = 88;
  {$EXTERNALSYM gestaltMacLC475}
  gestaltMacLC475               = 89;
  {$EXTERNALSYM gestaltPerforma47x}
  gestaltPerforma47x            = gestaltMacLC475;
  {$EXTERNALSYM gestaltMacLC575}
  gestaltMacLC575               = 92;
  {$EXTERNALSYM gestaltMacQuadra605}
  gestaltMacQuadra605           = 94;
  {$EXTERNALSYM gestaltMacQuadra630}
  gestaltMacQuadra630           = 98;
  {$EXTERNALSYM gestaltMacLC580}
  gestaltMacLC580               = 99;
  {$EXTERNALSYM gestaltPerforma580}
  gestaltPerforma580            = gestaltMacLC580;
  {$EXTERNALSYM gestaltPowerMac6100_66}
  gestaltPowerMac6100_66        = 100;
  {$EXTERNALSYM gestaltAWS6150_66}
  gestaltAWS6150_66             = gestaltPowerMac6100_66;
  {$EXTERNALSYM gestaltPowerBookDuo280}
  gestaltPowerBookDuo280        = 102;
  {$EXTERNALSYM gestaltPowerBookDuo280c}
  gestaltPowerBookDuo280c       = 103;
  {$EXTERNALSYM gestaltPowerMacLC475}
  gestaltPowerMacLC475          = 104;  //* Mac LC 475 & PPC Processor Upgrade Card*/
  {$EXTERNALSYM gestaltPowerMacPerforma47x}
  gestaltPowerMacPerforma47x    = gestaltPowerMacLC475;
  {$EXTERNALSYM gestaltPowerMacLC575}
  gestaltPowerMacLC575          = 105;  //* Mac LC 575 & PPC Processor Upgrade Card */
  {$EXTERNALSYM gestaltPowerMacPerforma57x}
  gestaltPowerMacPerforma57x    = gestaltPowerMacLC575;
  {$EXTERNALSYM gestaltPowerMacQuadra630}
  gestaltPowerMacQuadra630      = 106;  //* Quadra 630 & PPC Processor Upgrade Card*/
  {$EXTERNALSYM gestaltPowerMacLC630}
  gestaltPowerMacLC630          = gestaltPowerMacQuadra630; //* Mac LC 630 & PPC Processor Upgrade Card*/
  {$EXTERNALSYM gestaltPowerMacPerforma63x}
  gestaltPowerMacPerforma63x    = gestaltPowerMacQuadra630; //* Performa 63x & PPC Processor Upgrade Card*/
  {$EXTERNALSYM gestaltPowerMac7200}
  gestaltPowerMac7200           = 108;
  {$EXTERNALSYM gestaltPowerMac7300}
  gestaltPowerMac7300           = 109;
  {$EXTERNALSYM gestaltPowerMac7100_66}
  gestaltPowerMac7100_66        = 112;
  {$EXTERNALSYM gestaltPowerBook150}
  gestaltPowerBook150           = 115;
  {$EXTERNALSYM gestaltPowerMacQuadra700}
  gestaltPowerMacQuadra700      = 116;  //* Quadra 700 & Power PC Upgrade Card*/
  {$EXTERNALSYM gestaltPowerMacQuadra900}
  gestaltPowerMacQuadra900      = 117;  //* Quadra 900 & Power PC Upgrade Card */
  {$EXTERNALSYM gestaltPowerMacQuadra950}
  gestaltPowerMacQuadra950      = 118;  //* Quadra 950 & Power PC Upgrade Card */
  {$EXTERNALSYM gestaltPowerMacCentris610}
  gestaltPowerMacCentris610     = 119;  //* Centris 610 & Power PC Upgrade Card */
  {$EXTERNALSYM gestaltPowerMacCentris650}
  gestaltPowerMacCentris650     = 120;  //* Centris 650 & Power PC Upgrade Card */
  {$EXTERNALSYM gestaltPowerMacQuadra610}
  gestaltPowerMacQuadra610      = 121;  //* Quadra 610 & Power PC Upgrade Card */
  {$EXTERNALSYM gestaltPowerMacQuadra650}
  gestaltPowerMacQuadra650      = 122;  //* Quadra 650 & Power PC Upgrade Card */
  {$EXTERNALSYM gestaltPowerMacQuadra800}
  gestaltPowerMacQuadra800      = 123;  //* Quadra 800 & Power PC Upgrade Card */
  {$EXTERNALSYM gestaltPowerBookDuo2300}
  gestaltPowerBookDuo2300       = 124;
  {$EXTERNALSYM gestaltPowerBook500PPCUpgrade}
  gestaltPowerBook500PPCUpgrade = 126;
  {$EXTERNALSYM gestaltPowerBook5300}
  gestaltPowerBook5300          = 128;
  {$EXTERNALSYM gestaltPowerBook1400}
  gestaltPowerBook1400          = 310;
  {$EXTERNALSYM gestaltPowerBook3400}
  gestaltPowerBook3400          = 306;
  {$EXTERNALSYM gestaltPowerBook2400}
  gestaltPowerBook2400          = 307;
  {$EXTERNALSYM gestaltPowerBookG3Series}
  gestaltPowerBookG3Series      = 312;
  {$EXTERNALSYM gestaltPowerBookG3}
  gestaltPowerBookG3            = 313;
  {$EXTERNALSYM gestaltPowerBookG3Series2}
  gestaltPowerBookG3Series2     = 314;
  {$EXTERNALSYM gestaltPowerMacNewWorld}
  gestaltPowerMacNewWorld       = 406;  //* All NewWorld architecture Macs (iMac, blue G3, etc.)*/
  {$EXTERNALSYM gestaltPowerMacG3}
  gestaltPowerMacG3             = 510;
  {$EXTERNALSYM gestaltPowerMac5500}
  gestaltPowerMac5500           = 512;
  {$EXTERNALSYM gestalt20thAnniversary}
  gestalt20thAnniversary        = gestaltPowerMac5500;
  {$EXTERNALSYM gestaltPowerMac6500}
  gestaltPowerMac6500           = 513;
  {$EXTERNALSYM gestaltPowerMac4400_160}
  gestaltPowerMac4400_160       = 514;  //* slower machine has different machine ID*/
  {$EXTERNALSYM gestaltPowerMac4400}
  gestaltPowerMac4400           = 515;
  {$EXTERNALSYM gestaltMacOSCompatibility}
  gestaltMacOSCompatibility     = 1206;  //*    Mac OS Compatibility on Mac OS X (Classic)*/
//};


//enum {
  {$EXTERNALSYM gestaltQuadra605}
  gestaltQuadra605              = gestaltMacQuadra605;
  {$EXTERNALSYM gestaltQuadra610}
  gestaltQuadra610              = gestaltMacQuadra610;
  {$EXTERNALSYM gestaltQuadra630}
  gestaltQuadra630              = gestaltMacQuadra630;
  {$EXTERNALSYM gestaltQuadra650}
  gestaltQuadra650              = gestaltMacQuadra650;
  {$EXTERNALSYM gestaltQuadra660AV}
  gestaltQuadra660AV            = gestaltMacQuadra660AV;
  {$EXTERNALSYM gestaltQuadra700}
  gestaltQuadra700              = gestaltMacQuadra700;
  {$EXTERNALSYM gestaltQuadra800}
  gestaltQuadra800              = gestaltMacQuadra800;
  {$EXTERNALSYM gestaltQuadra840AV}
  gestaltQuadra840AV            = gestaltMacQuadra840AV;
  {$EXTERNALSYM gestaltQuadra900}
  gestaltQuadra900              = gestaltMacQuadra900;
  {$EXTERNALSYM gestaltQuadra950}
  gestaltQuadra950              = gestaltMacQuadra950;
//};

//enum {
  {$EXTERNALSYM kMachineNameStrID}
  kMachineNameStrID             = -16395;
//};

//enum {
  {$EXTERNALSYM gestaltSMPMailerVersion}
  gestaltSMPMailerVersion       = $6d616c72; //'malr' /* OCE StandardMail*/
//};

//enum {
  {$EXTERNALSYM gestaltMediaBay}
  gestaltMediaBay               = $6d626568; //'mbeh', /* media bay driver type */
  {$EXTERNALSYM gestaltMBLegacy}
  gestaltMBLegacy               = 0;    //* media bay support in PCCard 2.0 */
  {$EXTERNALSYM gestaltMBSingleBay}
  gestaltMBSingleBay            = 1;    //* single bay media bay driver */
  {$EXTERNALSYM gestaltMBMultipleBays}
  gestaltMBMultipleBays         = 2;     //* multi-bay media bay driver */
//};

//enum {
  {$EXTERNALSYM gestaltMessageMgrVersion}
  gestaltMessageMgrVersion      = $6d657373; //'mess' //* GX Printing Message Manager Gestalt Selector */
//};


//*  Menu Manager Gestalt (Mac OS 8.5 and later)*/
//enum {
  {$EXTERNALSYM gestaltMenuMgrAttr}
  gestaltMenuMgrAttr            = $6d656e75; //'menu', /* If this Gestalt exists, the Mac OS 8.5 Menu Manager is installed */
  {$EXTERNALSYM gestaltMenuMgrPresent}
  gestaltMenuMgrPresent         = (1 shl 0); //* NOTE: this is a bit mask, whereas all other Gestalt constants of this nature */
                                        //* are bit index values. 3.2 interfaces slipped out with this mistake unnoticed. */
                                        //* Sincere apologies for any inconvenience.*/
  {$EXTERNALSYM gestaltMenuMgrPresentBit}
  gestaltMenuMgrPresentBit      = 0;    //* bit number */
  {$EXTERNALSYM gestaltMenuMgrAquaLayoutBit}
  gestaltMenuMgrAquaLayoutBit   = 1;    //* menus have the Aqua 1.0 layout*/
  {$EXTERNALSYM gestaltMenuMgrMultipleItemsWithCommandIDBit}
  gestaltMenuMgrMultipleItemsWithCommandIDBit = 2; //* CountMenuItemsWithCommandID/GetIndMenuItemWithCommandID support multiple items with the same command ID*/
  {$EXTERNALSYM gestaltMenuMgrRetainsIconRefBit}
  gestaltMenuMgrRetainsIconRefBit = 3;  //* SetMenuItemIconHandle, when passed an IconRef, calls AcquireIconRef*/
  {$EXTERNALSYM gestaltMenuMgrSendsMenuBoundsToDefProcBit}
  gestaltMenuMgrSendsMenuBoundsToDefProcBit = 4; //* kMenuSizeMsg and kMenuPopUpMsg have menu bounding rect information*/
  {$EXTERNALSYM gestaltMenuMgrMoreThanFiveMenusDeepBit}
  gestaltMenuMgrMoreThanFiveMenusDeepBit = 5; //* the Menu Manager supports hierarchical menus more than five deep*/
  {$EXTERNALSYM gestaltMenuMgrCGImageMenuTitleBit}
  gestaltMenuMgrCGImageMenuTitleBit = 6; //* SetMenuTitleIcon supports CGImageRefs*/
                                        //* masks for the above bits*/
  {$EXTERNALSYM gestaltMenuMgrPresentMask}
  gestaltMenuMgrPresentMask     = (1 shl gestaltMenuMgrPresentBit);
  {$EXTERNALSYM gestaltMenuMgrAquaLayoutMask}
  gestaltMenuMgrAquaLayoutMask  = (1 shl gestaltMenuMgrAquaLayoutBit);
  {$EXTERNALSYM gestaltMenuMgrMultipleItemsWithCommandIDMask}
  gestaltMenuMgrMultipleItemsWithCommandIDMask = (1 shl gestaltMenuMgrMultipleItemsWithCommandIDBit);
  {$EXTERNALSYM gestaltMenuMgrRetainsIconRefMask}
  gestaltMenuMgrRetainsIconRefMask = (1 shl gestaltMenuMgrRetainsIconRefBit);
  {$EXTERNALSYM gestaltMenuMgrSendsMenuBoundsToDefProcMask}
  gestaltMenuMgrSendsMenuBoundsToDefProcMask = (1 shl gestaltMenuMgrSendsMenuBoundsToDefProcBit);
  {$EXTERNALSYM gestaltMenuMgrMoreThanFiveMenusDeepMask}
  gestaltMenuMgrMoreThanFiveMenusDeepMask = (1 shl gestaltMenuMgrMoreThanFiveMenusDeepBit);
  {$EXTERNALSYM gestaltMenuMgrCGImageMenuTitleMask}
  gestaltMenuMgrCGImageMenuTitleMask = (1 shl gestaltMenuMgrCGImageMenuTitleBit);
//};


//enum {
  {$EXTERNALSYM gestaltMultipleUsersState}
  gestaltMultipleUsersState     = $6d666472; //'mfdr' //* Gestalt selector returns MultiUserGestaltHandle (in Folders.h)*/
//};


//enum {
  {$EXTERNALSYM gestaltMachineIcon}
  gestaltMachineIcon            = $6d69636e; //'micn' /* machine icon */
//};

//enum {
  {$EXTERNALSYM gestaltMiscAttr}
  gestaltMiscAttr               = $6d697363; //'misc', /* miscellaneous attributes */
  {$EXTERNALSYM gestaltScrollingThrottle}
  gestaltScrollingThrottle      = 0;    //* true if scrolling throttle on */
  {$EXTERNALSYM gestaltSquareMenuBar}
  gestaltSquareMenuBar          = 2;    //* true if menu bar is square */
//};


{*
    The name gestaltMixedModeVersion for the 'mixd' selector is semantically incorrect.
    The same selector has been renamed gestaltMixedModeAttr to properly reflect the
    Inside Mac: PowerPC System Software documentation.  The gestaltMixedModeVersion
    symbol has been preserved only for backwards compatibility.

    Developers are forewarned that gestaltMixedModeVersion has a limited lifespan and
    will be removed in a future release of the Interfaces.

    For the first version of Mixed Mode, both meanings of the 'mixd' selector are
    functionally identical.  They both return 0x00000001.  In subsequent versions
    of Mixed Mode, however, the 'mixd' selector will not respond with an increasing
    version number, but rather, with 32 attribute bits with various meanings.
*}
//enum {
  {$EXTERNALSYM gestaltMixedModeVersion}
  gestaltMixedModeVersion       = $6d697864; //'mixd' /* returns version of Mixed Mode */
//};

//enum {
  {$EXTERNALSYM gestaltMixedModeAttr}
  gestaltMixedModeAttr          = $6d697864; //'mixd', /* returns Mixed Mode attributes */
  {$EXTERNALSYM gestaltMixedModePowerPC}
  gestaltMixedModePowerPC       = 0;    //* true if Mixed Mode supports PowerPC ABI calling conventions */
  {$EXTERNALSYM gestaltPowerPCAware}
  gestaltPowerPCAware           = 0;    //* old name for gestaltMixedModePowerPC */
  {$EXTERNALSYM gestaltMixedModeCFM68K}
  gestaltMixedModeCFM68K        = 1;    //* true if Mixed Mode supports CFM-68K calling conventions */
  {$EXTERNALSYM gestaltMixedModeCFM68KHasTrap}
  gestaltMixedModeCFM68KHasTrap = 2;    //* true if CFM-68K Mixed Mode implements _MixedModeDispatch (versions 1.0.1 and prior did not) */
  {$EXTERNALSYM gestaltMixedModeCFM68KHasState}
  gestaltMixedModeCFM68KHasState = 3;    //* true if CFM-68K Mixed Mode exports Save/RestoreMixedModeState */
//};

//enum {
  {$EXTERNALSYM gestaltQuickTimeConferencing}
  gestaltQuickTimeConferencing  = $6d746c6b;// 'mtlk' /* returns QuickTime Conferencing version */
//};

//enum {
  {$EXTERNALSYM gestaltMemoryMapAttr}
  gestaltMemoryMapAttr          = $6d6d6170; //'mmap', /* Memory map type */
  {$EXTERNALSYM gestaltMemoryMapSparse}
  gestaltMemoryMapSparse        = 0;     //* Sparse memory is on */
//};

//enum {
  {$EXTERNALSYM gestaltMMUType}
  gestaltMMUType                = $6d6d7520; // 'mmu ', /* mmu type */
  {$EXTERNALSYM gestaltNoMMU}
  gestaltNoMMU                  = 0;    //* no MMU */
  {$EXTERNALSYM gestaltAMU}
  gestaltAMU                    = 1;    //* address management unit */
  {$EXTERNALSYM gestalt68851}
  gestalt68851                  = 2;    //* 68851 PMMU */
  {$EXTERNALSYM gestalt68030MMU}
  gestalt68030MMU               = 3;    //* 68030 built-in MMU */
  {$EXTERNALSYM gestalt68040MMU}
  gestalt68040MMU               = 4;    //* 68040 built-in MMU */
  {$EXTERNALSYM gestaltEMMU1}
  gestaltEMMU1                  = 5;     //* Emulated MMU type 1  */
//};

//enum {
                                        //*    On Mac OS X, the user visible machine name may something like "PowerMac3,4", which is*/
                                        //*    a unique string for each signifigant Macintosh computer which Apple creates, but is*/
                                        //*    not terribly useful as a user visible string.*/
  {$EXTERNALSYM gestaltUserVisibleMachineName}
  gestaltUserVisibleMachineName = $6d6e616d;//'mnam' /* Coerce response into a StringPtr to get a user visible machine name */
//};

//enum {
  {$EXTERNALSYM gestaltMPCallableAPIsAttr}
  gestaltMPCallableAPIsAttr     = $6d707363; //'mpsc', /* Bitmap of toolbox/OS managers that can be called from MPLibrary MPTasks */
  {$EXTERNALSYM gestaltMPFileManager}
  gestaltMPFileManager          = 0;    //* True if File Manager calls can be made from MPTasks */
  {$EXTERNALSYM gestaltMPDeviceManager}
  gestaltMPDeviceManager        = 1;    //* True if synchronous Device Manager calls can be made from MPTasks */
  {$EXTERNALSYM gestaltMPTrapCalls}
  gestaltMPTrapCalls            = 2;     //* True if most trap-based calls can be made from MPTasks */
//};

//enum {
  {$EXTERNALSYM gestaltStdNBPAttr}
  gestaltStdNBPAttr             = $6e6c7570; //'nlup', /* standard nbp attributes */
  {$EXTERNALSYM gestaltStdNBPPresent}
  gestaltStdNBPPresent          = 0;
  {$EXTERNALSYM gestaltStdNBPSupportsAutoPosition}
  gestaltStdNBPSupportsAutoPosition = 1; //* StandardNBP takes (-1,-1) to mean alert position main screen */
//};

//enum {
  {$EXTERNALSYM gestaltNotificationMgrAttr}
  gestaltNotificationMgrAttr    = $6e6d6772; //'nmgr', /* notification manager attributes */
  {$EXTERNALSYM gestaltNotificationPresent}
  gestaltNotificationPresent    = 0;     //* notification manager exists */
//};

//enum {
  {$EXTERNALSYM gestaltNameRegistryVersion}
  gestaltNameRegistryVersion    = $6e726567; //'nreg' /* NameRegistryLib version number, for System 7.5.2+ usage */
//};

//enum {
  {$EXTERNALSYM gestaltNuBusSlotCount}
  gestaltNuBusSlotCount         = $6e756273; // 'nubs' /* count of logical NuBus slots present */
//};

//enum {
  {$EXTERNALSYM gestaltOCEToolboxVersion}
  gestaltOCEToolboxVersion      = $6f636574; //'ocet', /* OCE Toolbox version */
  {$EXTERNALSYM gestaltOCETB}
  gestaltOCETB                  = $0102; //* OCE Toolbox version 1.02 */
  {$EXTERNALSYM gestaltSFServer}
  gestaltSFServer               = $0100; //* S&F Server version 1.0 */
//};

//enum {
  {$EXTERNALSYM gestaltOCEToolboxAttr}
  gestaltOCEToolboxAttr         = $6f636575; //'oceu', /* OCE Toolbox attributes */
  {$EXTERNALSYM gestaltOCETBPresent}
  gestaltOCETBPresent           = $01; //* OCE toolbox is present, not running */
  {$EXTERNALSYM gestaltOCETBAvailable}
  gestaltOCETBAvailable         = $02; //* OCE toolbox is running and available */
  {$EXTERNALSYM gestaltOCESFServerAvailable}
  gestaltOCESFServerAvailable   = $04; //* S&F Server is running and available */
  {$EXTERNALSYM gestaltOCETBNativeGlueAvailable}
  gestaltOCETBNativeGlueAvailable = $10; //* Native PowerPC Glue routines are availible */
//};

//enum {
  {$EXTERNALSYM gestaltOpenFirmwareInfo}
  gestaltOpenFirmwareInfo       =  $6f706677; //'opfw' /* Open Firmware info */
//};

//enum {
  {$EXTERNALSYM gestaltOSAttr}
  gestaltOSAttr                 = $6f732020;//'os  ', /* o/s attributes */
  {$EXTERNALSYM gestaltSysZoneGrowable}
  gestaltSysZoneGrowable        = 0;    //* system heap is growable */
  {$EXTERNALSYM gestaltLaunchCanReturn}
  gestaltLaunchCanReturn        = 1;    //* can return from launch */
  {$EXTERNALSYM gestaltLaunchFullFileSpec}
  gestaltLaunchFullFileSpec     = 2;    //* can launch from full file spec */
  {$EXTERNALSYM gestaltLaunchControl}
  gestaltLaunchControl          = 3;    //* launch control support available */
  {$EXTERNALSYM gestaltTempMemSupport}
  gestaltTempMemSupport         = 4;    //* temp memory support */
  {$EXTERNALSYM gestaltRealTempMemory}
  gestaltRealTempMemory         = 5;    //* temp memory handles are real */
  {$EXTERNALSYM gestaltTempMemTracked}
  gestaltTempMemTracked         = 6;    //* temporary memory handles are tracked */
  {$EXTERNALSYM gestaltIPCSupport}
  gestaltIPCSupport             = 7;    //* IPC support is present */
  {$EXTERNALSYM gestaltSysDebuggerSupport}
  gestaltSysDebuggerSupport     = 8;    //* system debugger support is present */
  {$EXTERNALSYM gestaltNativeProcessMgrBit}
  gestaltNativeProcessMgrBit    = 19;   //* the process manager itself is native */
  {$EXTERNALSYM gestaltAltivecRegistersSwappedCorrectlyBit}
  gestaltAltivecRegistersSwappedCorrectlyBit = 20; //* Altivec registers are saved correctly on process switches */
//};

//enum {
  {$EXTERNALSYM gestaltOSTable}
  gestaltOSTable                = $6f737474;//'ostt' /*  OS trap table base  */
//};


{*******************************************************************************
*   Gestalt Selectors for Open Transport Network Setup
*
*   Note: possible values for the version "stage" byte are:
*   development = 0x20, alpha = 0x40, beta = 0x60, final & release = 0x80
********************************************************************************}
//enum {
  {$EXTERNALSYM gestaltOpenTptNetworkSetup}
  gestaltOpenTptNetworkSetup    = $6f746366;//'otcf',
  {$EXTERNALSYM gestaltOpenTptNetworkSetupLegacyImport}
  gestaltOpenTptNetworkSetupLegacyImport = 0;
  {$EXTERNALSYM gestaltOpenTptNetworkSetupLegacyExport}
  gestaltOpenTptNetworkSetupLegacyExport = 1;
  {$EXTERNALSYM gestaltOpenTptNetworkSetupSupportsMultihoming}
  gestaltOpenTptNetworkSetupSupportsMultihoming = 2;
//};

//enum {
  {$EXTERNALSYM gestaltOpenTptNetworkSetupVersion}
  gestaltOpenTptNetworkSetupVersion = $6f746376; //'otcv'
//};

{*******************************************************************************
*   Gestalt Selectors for Open Transport-based Remote Access/PPP
*
*   Note: possible values for the version "stage" byte are:
*   development = 0x20, alpha = 0x40, beta = 0x60, final & release = 0x80
********************************************************************************}
//enum {
  {$EXTERNALSYM gestaltOpenTptRemoteAccess}
  gestaltOpenTptRemoteAccess    = $6f747261; //'otra',
  {$EXTERNALSYM gestaltOpenTptRemoteAccessPresent}
  gestaltOpenTptRemoteAccessPresent = 0;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessLoaded}
  gestaltOpenTptRemoteAccessLoaded = 1;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessClientOnly}
  gestaltOpenTptRemoteAccessClientOnly = 2;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessPServer}
  gestaltOpenTptRemoteAccessPServer = 3;
  {$EXTERNALSYM gestaltOpenTptRemoteAccessMPServer}
  gestaltOpenTptRemoteAccessMPServer = 4;
  {$EXTERNALSYM gestaltOpenTptPPPPresent}
  gestaltOpenTptPPPPresent      = 5;
  {$EXTERNALSYM gestaltOpenTptARAPPresent}
  gestaltOpenTptARAPPresent     = 6;
//};

//enum {
  {$EXTERNALSYM gestaltOpenTptRemoteAccessVersion}
  gestaltOpenTptRemoteAccessVersion = $6f747276;// 'otrv'
//};


//* ***** Open Transport Gestalt ******/


//enum {
  {$EXTERNALSYM gestaltOpenTptVersions}
  gestaltOpenTptVersions        = $6f747672; // 'otvr' /* Defined by OT 1.1 and higher, response is NumVersion.*/
//};

//enum {
  {$EXTERNALSYM gestaltOpenTpt}
  gestaltOpenTpt                = $6f74616e; //'otan', /* Defined by all versions, response is defined below.*/
  {$EXTERNALSYM gestaltOpenTptPresentMask}
  gestaltOpenTptPresentMask     = $00000001;
  {$EXTERNALSYM gestaltOpenTptLoadedMask}
  gestaltOpenTptLoadedMask      = $00000002;
  {$EXTERNALSYM gestaltOpenTptAppleTalkPresentMask}
  gestaltOpenTptAppleTalkPresentMask = $00000004;
  {$EXTERNALSYM gestaltOpenTptAppleTalkLoadedMask}
  gestaltOpenTptAppleTalkLoadedMask = $00000008;
  {$EXTERNALSYM gestaltOpenTptTCPPresentMask}
  gestaltOpenTptTCPPresentMask  = $00000010;
  {$EXTERNALSYM gestaltOpenTptTCPLoadedMask}
  gestaltOpenTptTCPLoadedMask   = $00000020;
  {$EXTERNALSYM gestaltOpenTptIPXSPXPresentMask}
  gestaltOpenTptIPXSPXPresentMask = $00000040;
  {$EXTERNALSYM gestaltOpenTptIPXSPXLoadedMask}
  gestaltOpenTptIPXSPXLoadedMask = $00000080;
  {$EXTERNALSYM gestaltOpenTptPresentBit}
  gestaltOpenTptPresentBit      = 0;
  {$EXTERNALSYM gestaltOpenTptLoadedBit}
  gestaltOpenTptLoadedBit       = 1;
  {$EXTERNALSYM gestaltOpenTptAppleTalkPresentBit}
  gestaltOpenTptAppleTalkPresentBit = 2;
  {$EXTERNALSYM gestaltOpenTptAppleTalkLoadedBit}
  gestaltOpenTptAppleTalkLoadedBit = 3;
  {$EXTERNALSYM gestaltOpenTptTCPPresentBit}
  gestaltOpenTptTCPPresentBit   = 4;
  {$EXTERNALSYM gestaltOpenTptTCPLoadedBit}
  gestaltOpenTptTCPLoadedBit    = 5;
  {$EXTERNALSYM gestaltOpenTptIPXSPXPresentBit}
  gestaltOpenTptIPXSPXPresentBit = 6;
  {$EXTERNALSYM gestaltOpenTptIPXSPXLoadedBit}
  gestaltOpenTptIPXSPXLoadedBit = 7;
//};


//enum {
  {$EXTERNALSYM gestaltPCCard}
  gestaltPCCard                 = $70636364; // 'pccd', /*    PC Card attributes*/
  {$EXTERNALSYM gestaltCardServicesPresent}
  gestaltCardServicesPresent    = 0;    //*    PC Card 2.0 (68K) API is present*/
  {$EXTERNALSYM gestaltPCCardFamilyPresent}
  gestaltPCCardFamilyPresent    = 1;    //*    PC Card 3.x (PowerPC) API is present*/
  {$EXTERNALSYM gestaltPCCardHasPowerControl}
  gestaltPCCardHasPowerControl  = 2;    //*    PCCardSetPowerLevel is supported*/
  {$EXTERNALSYM gestaltPCCardSupportsCardBus}
  gestaltPCCardSupportsCardBus  = 3;     //*    CardBus is supported*/
//};

//enum {
  {$EXTERNALSYM gestaltProcClkSpeed}
  gestaltProcClkSpeed           = $70636c6b; //'pclk' /* processor clock speed in hertz (a UInt32) */
//};

//enum {
  {$EXTERNALSYM gestaltProcClkSpeedMHz}
  gestaltProcClkSpeedMHz        = $6d636c6b;// 'mclk' /* processor clock speed in megahertz (a UInt32) */
//};

//enum {
  {$EXTERNALSYM gestaltPCXAttr}
  gestaltPCXAttr                = $70637867; //'pcxg', /* PC Exchange attributes */
  {$EXTERNALSYM gestaltPCXHas8and16BitFAT}
  gestaltPCXHas8and16BitFAT     = 0;    //* PC Exchange supports both 8 and 16 bit FATs */
  {$EXTERNALSYM gestaltPCXHasProDOS}
  gestaltPCXHasProDOS           = 1;    //* PC Exchange supports ProDOS */
  {$EXTERNALSYM gestaltPCXNewUI}
  gestaltPCXNewUI               = 2;
  {$EXTERNALSYM gestaltPCXUseICMapping}
  gestaltPCXUseICMapping        = 3;    //* PC Exchange uses InternetConfig for file mappings */
//};

//enum {
  {$EXTERNALSYM gestaltLogicalPageSize}
  gestaltLogicalPageSize        = $7067737a; // 'pgsz' /* logical page size */
//};

{*    System 7.6 and later.  If gestaltScreenCaptureMain is not implemented,
    PictWhap proceeds with screen capture in the usual way.

    The high word of gestaltScreenCaptureMain is reserved (use 0).

    To disable screen capture to disk, put zero in the low word.  To
    specify a folder for captured pictures, put the vRefNum in the
    low word of gestaltScreenCaptureMain, and put the directory ID in
    gestaltScreenCaptureDir.
*}
//enum {
  {$EXTERNALSYM gestaltScreenCaptureMain}
  gestaltScreenCaptureMain      = $70696331; //'pic1', /* Zero, or vRefNum of disk to hold picture */
  {$EXTERNALSYM gestaltScreenCaptureDir}
  gestaltScreenCaptureDir       = $70696332; //'pic2' /* Directory ID of folder to hold picture */
//};

//enum {
  {$EXTERNALSYM gestaltGXPrintingMgrVersion}
  gestaltGXPrintingMgrVersion   = $706d6772; // 'pmgr' /* QuickDraw GX Printing Manager Version*/
//};

//enum {
  {$EXTERNALSYM gestaltPopupAttr}
  gestaltPopupAttr              = $706f7021;//'pop!', /* popup cdef attributes */
  {$EXTERNALSYM gestaltPopupPresent}
  gestaltPopupPresent           = 0;
//};

//enum {
  {$EXTERNALSYM gestaltPowerMgrAttr}
  gestaltPowerMgrAttr           = $706f7772; //'powr', /* power manager attributes */
  {$EXTERNALSYM gestaltPMgrExists}
  gestaltPMgrExists             = 0;
  {$EXTERNALSYM gestaltPMgrCPUIdle}
  gestaltPMgrCPUIdle            = 1;
  {$EXTERNALSYM gestaltPMgrSCC}
  gestaltPMgrSCC                = 2;
  {$EXTERNALSYM gestaltPMgrSound}
  gestaltPMgrSound              = 3;
  {$EXTERNALSYM gestaltPMgrDispatchExists}
  gestaltPMgrDispatchExists     = 4;
  {$EXTERNALSYM gestaltPMgrSupportsAVPowerStateAtSleepWake}
  gestaltPMgrSupportsAVPowerStateAtSleepWake = 5;
//};

//enum {
  {$EXTERNALSYM gestaltPowerMgrVers}
  gestaltPowerMgrVers           = $70777276; //'pwrv' /* power manager version */
//};

{*
 * PPC will return the combination of following bit fields.
 * e.g. gestaltPPCSupportsRealTime +gestaltPPCSupportsIncoming + gestaltPPCSupportsOutGoing
 * indicates PPC is cuurently is only supports real time delivery
 * and both incoming and outgoing network sessions are allowed.
 * By default local real time delivery is supported as long as PPCInit has been called.*}
//enum {
  {$EXTERNALSYM gestaltPPCToolboxAttr}
  gestaltPPCToolboxAttr         = $70706320;// 'ppc ', /* PPC toolbox attributes */
  {$EXTERNALSYM gestaltPPCToolboxPresent}
  gestaltPPCToolboxPresent      = $0000; //* PPC Toolbox is present  Requires PPCInit to be called */
  {$EXTERNALSYM gestaltPPCSupportsRealTime}
  gestaltPPCSupportsRealTime    = $1000; //* PPC Supports real-time delivery */
  {$EXTERNALSYM gestaltPPCSupportsIncoming}
  gestaltPPCSupportsIncoming    = $0001; //* PPC will allow incoming network requests */
  {$EXTERNALSYM gestaltPPCSupportsOutGoing}
  gestaltPPCSupportsOutGoing    = $0002; //* PPC will allow outgoing network requests */
  {$EXTERNALSYM gestaltPPCSupportsTCP_IP}
  gestaltPPCSupportsTCP_IP      = $0004; //* PPC supports TCP/IP transport  */
  {$EXTERNALSYM gestaltPPCSupportsIncomingAppleTalk}
  gestaltPPCSupportsIncomingAppleTalk = $0010;
  {$EXTERNALSYM gestaltPPCSupportsIncomingTCP_IP}
  gestaltPPCSupportsIncomingTCP_IP = $0020;
  {$EXTERNALSYM gestaltPPCSupportsOutgoingAppleTalk}
  gestaltPPCSupportsOutgoingAppleTalk = $0100;
  {$EXTERNALSYM gestaltPPCSupportsOutgoingTCP_IP}
  gestaltPPCSupportsOutgoingTCP_IP = $0200;
//};

{*
    Programs which need to know information about particular features of the processor should
    migrate to using sysctl() and sysctlbyname() to get this kind of information.  No new
    information will be added to the 'ppcf' selector going forward.
*}
//enum {
  {$EXTERNALSYM gestaltPowerPCProcessorFeatures}
  gestaltPowerPCProcessorFeatures = $70706366;// 'ppcf', //* Optional PowerPC processor features */
  {$EXTERNALSYM gestaltPowerPCHasGraphicsInstructions}
  gestaltPowerPCHasGraphicsInstructions = 0; //* has fres, frsqrte, and fsel instructions */
  {$EXTERNALSYM gestaltPowerPCHasSTFIWXInstruction}
  gestaltPowerPCHasSTFIWXInstruction = 1; //* has stfiwx instruction */
  {$EXTERNALSYM gestaltPowerPCHasSquareRootInstructions}
  gestaltPowerPCHasSquareRootInstructions = 2; //* has fsqrt and fsqrts instructions */
  {$EXTERNALSYM gestaltPowerPCHasDCBAInstruction}
  gestaltPowerPCHasDCBAInstruction = 3; //* has dcba instruction */
  {$EXTERNALSYM gestaltPowerPCHasVectorInstructions}
  gestaltPowerPCHasVectorInstructions = 4; //* has vector instructions */
  {$EXTERNALSYM gestaltPowerPCHasDataStreams}
  gestaltPowerPCHasDataStreams  = 5;    //* has dst, dstt, dstst, dss, and dssall instructions */
  {$EXTERNALSYM gestaltPowerPCHas64BitSupport}
  gestaltPowerPCHas64BitSupport = 6;    //* double word LSU/ALU, etc. */
  {$EXTERNALSYM gestaltPowerPCHasDCBTStreams}
  gestaltPowerPCHasDCBTStreams  = 7;    //* TH field of DCBT recognized */
  {$EXTERNALSYM gestaltPowerPCASArchitecture}
  gestaltPowerPCASArchitecture  = 8;    //* chip uses new 'A/S' architecture */
  {$EXTERNALSYM gestaltPowerPCIgnoresDCBST}
  gestaltPowerPCIgnoresDCBST    = 9;     //* */
//};

//enum {
  {$EXTERNALSYM gestaltProcessorType}
  gestaltProcessorType          = $70726f63; //'proc', /* processor type */
  {$EXTERNALSYM gestalt68000}
  gestalt68000                  = 1;
  {$EXTERNALSYM gestalt68010}
  gestalt68010                  = 2;
  {$EXTERNALSYM gestalt68020}
  gestalt68020                  = 3;
  {$EXTERNALSYM gestalt68030}
  gestalt68030                  = 4;
  {$EXTERNALSYM gestalt68040}
  gestalt68040                  = 5;
//};

//enum {
  {$EXTERNALSYM gestaltSDPPromptVersion}
  gestaltSDPPromptVersion       = $70727076; //'prpv' /* OCE Standard Directory Panel*/
//};

//enum {
  {$EXTERNALSYM gestaltParityAttr}
  gestaltParityAttr             = $70727479; //'prty', /* parity attributes */
  {$EXTERNALSYM gestaltHasParityCapability}
  gestaltHasParityCapability    = 0;    //* has ability to check parity */
  {$EXTERNALSYM gestaltParityEnabled}
  gestaltParityEnabled          = 1;     //* parity checking enabled */
//};

//enum {
  {$EXTERNALSYM gestaltQD3DVersion}
  gestaltQD3DVersion            = $71337620; //'q3v ' /* Quickdraw 3D version in pack BCD*/
//};

//enum {
  {$EXTERNALSYM gestaltQD3DViewer}
  gestaltQD3DViewer             = $71337663; //'q3vc', /* Quickdraw 3D viewer attributes*/
  {$EXTERNALSYM gestaltQD3DViewerPresent}
  gestaltQD3DViewerPresent      = 0;     //* bit 0 set if QD3D Viewer is available*/
//};

//#if OLDROUTINENAMES
//enum {
  {$EXTERNALSYM gestaltQD3DViewerNotPresent}
  gestaltQD3DViewerNotPresent   = (0 shl gestaltQD3DViewerPresent);
  {$EXTERNALSYM gestaltQD3DViewerAvailable}
  gestaltQD3DViewerAvailable    = (1 shl gestaltQD3DViewerPresent);
//};

//#endif  /* OLDROUTINENAMES */

//enum {
  {$EXTERNALSYM gestaltQuickdrawVersion}
  gestaltQuickdrawVersion       = $71642020; //'qd  ', /* quickdraw version */
  {$EXTERNALSYM gestaltOriginalQD}
  gestaltOriginalQD             = $0000; //* original 1-bit QD */
  {$EXTERNALSYM gestalt8BitQD}
  gestalt8BitQD                 = $0100; //* 8-bit color QD */
  {$EXTERNALSYM gestalt32BitQD}
  gestalt32BitQD                = $0200; //* 32-bit color QD */
  {$EXTERNALSYM gestalt32BitQD11}
  gestalt32BitQD11              = $0201; //* 32-bit color QDv1.1 */
  {$EXTERNALSYM gestalt32BitQD12}
  gestalt32BitQD12              = $0220; //* 32-bit color QDv1.2 */
  {$EXTERNALSYM gestalt32BitQD13}
  gestalt32BitQD13              = $0230; //* 32-bit color QDv1.3 */
  {$EXTERNALSYM gestaltAllegroQD}
  gestaltAllegroQD              = $0250; //* Allegro QD OS 8.5 */
  {$EXTERNALSYM gestaltMacOSXQD}
  gestaltMacOSXQD               = $0300; //* 0x310, 0x320 etc. for 10.x.y */
//};

//enum {
  {$EXTERNALSYM gestaltQD3D}
  gestaltQD3D                   = $71643364; //'qd3d', /* Quickdraw 3D attributes*/
  {$EXTERNALSYM gestaltQD3DPresent}
  gestaltQD3DPresent            = 0;     //* bit 0 set if QD3D available*/
//};

//#if OLDROUTINENAMES
//enum {
  {$EXTERNALSYM gestaltQD3DNotPresent}
  gestaltQD3DNotPresent         = (0 shl gestaltQD3DPresent);
  {$EXTERNALSYM gestaltQD3DAvailable}
  gestaltQD3DAvailable          = (1 shl gestaltQD3DPresent);
//};

//#endif  /* OLDROUTINENAMES */

//enum {
  {$EXTERNALSYM gestaltGXVersion}
  gestaltGXVersion              = $71646778; //'qdgx' /* Overall QuickDraw GX Version*/
//};

//enum {
  {$EXTERNALSYM gestaltQuickdrawFeatures}
  gestaltQuickdrawFeatures      = $71647277;//'qdrw', /* quickdraw features */
  {$EXTERNALSYM gestaltHasColor}
  gestaltHasColor               = 0;    //* color quickdraw present */
  {$EXTERNALSYM gestaltHasDeepGWorlds}
  gestaltHasDeepGWorlds         = 1;    //* GWorlds can be deeper than 1-bit */
  {$EXTERNALSYM gestaltHasDirectPixMaps}
  gestaltHasDirectPixMaps       = 2;    //* PixMaps can be direct (16 or 32 bit) */
  {$EXTERNALSYM gestaltHasGrayishTextOr}
  gestaltHasGrayishTextOr       = 3;    //* supports text mode grayishTextOr */
  {$EXTERNALSYM gestaltSupportsMirroring}
  gestaltSupportsMirroring      = 4;    //* Supports video mirroring via the Display Manager. */
  {$EXTERNALSYM gestaltQDHasLongRowBytes}
  gestaltQDHasLongRowBytes      = 5;     //* Long rowBytes supported in GWorlds */
//};

//enum {
  {$EXTERNALSYM gestaltQDTextVersion}
  gestaltQDTextVersion          = $71647478;//'qdtx', /* QuickdrawText version */
  {$EXTERNALSYM gestaltOriginalQDText}
  gestaltOriginalQDText         = $0000; //* up to and including 8.1 */
  {$EXTERNALSYM gestaltAllegroQDText}
  gestaltAllegroQDText          = $0100; //* starting with 8.5 */
  {$EXTERNALSYM gestaltMacOSXQDText}
  gestaltMacOSXQDText           = $0200; //* we are in Mac OS X */
//};

//enum {
  {$EXTERNALSYM gestaltQDTextFeatures}
  gestaltQDTextFeatures         = $71647466; //'qdtf', /* QuickdrawText features */
  {$EXTERNALSYM gestaltWSIISupport}
  gestaltWSIISupport            = 0;    //* bit 0: WSII support included */
  {$EXTERNALSYM gestaltSbitFontSupport}
  gestaltSbitFontSupport        = 1;    //* sbit-only fonts supported */
  {$EXTERNALSYM gestaltAntiAliasedTextAvailable}
  gestaltAntiAliasedTextAvailable = 2;  //* capable of antialiased text */
  {$EXTERNALSYM gestaltOFA2available}
  gestaltOFA2available          = 3;    //* OFA2 available */
  {$EXTERNALSYM gestaltCreatesAliasFontRsrc}
  gestaltCreatesAliasFontRsrc   = 4;    //* "real" datafork font support */
  {$EXTERNALSYM gestaltNativeType1FontSupport}
  gestaltNativeType1FontSupport = 5;    //* we have scaler for Type1 fonts */
  {$EXTERNALSYM gestaltCanUseCGTextRendering}
  gestaltCanUseCGTextRendering  = 6;
//};


//enum {
  {$EXTERNALSYM gestaltQuickTimeConferencingInfo}
  gestaltQuickTimeConferencingInfo = $71746369;//'qtci' /* returns pointer to QuickTime Conferencing information */
//};

//enum {
  {$EXTERNALSYM gestaltQuickTimeVersion}
  gestaltQuickTimeVersion       = $7174696d; //'qtim', /* returns version of QuickTime */
  {$EXTERNALSYM gestaltQuickTime}
  gestaltQuickTime              = $7174696d; //'qtim' /* gestaltQuickTime is old name for gestaltQuickTimeVersion */
//};

//enum {
  {$EXTERNALSYM gestaltQuickTimeFeatures}
  gestaltQuickTimeFeatures      = $71747273;// 'qtrs',
  {$EXTERNALSYM gestaltPPCQuickTimeLibPresent}
  gestaltPPCQuickTimeLibPresent = 0;     //* PowerPC QuickTime glue library is present */
//};

//enum {
  {$EXTERNALSYM gestaltQuickTimeStreamingFeatures}
  gestaltQuickTimeStreamingFeatures = $71747366; // 'qtsf'
//};

//enum {
  {$EXTERNALSYM gestaltQuickTimeStreamingVersion}
  gestaltQuickTimeStreamingVersion = $71747374; // 'qtst'
//};

//enum {
  {$EXTERNALSYM gestaltQuickTimeThreadSafeFeaturesAttr}
  gestaltQuickTimeThreadSafeFeaturesAttr = $71747468;//'qtth', /* Quicktime thread safety attributes */
  {$EXTERNALSYM gestaltQuickTimeThreadSafeICM}
  gestaltQuickTimeThreadSafeICM = 0;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMovieToolbox}
  gestaltQuickTimeThreadSafeMovieToolbox = 1;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMovieImport}
  gestaltQuickTimeThreadSafeMovieImport = 2;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMovieExport}
  gestaltQuickTimeThreadSafeMovieExport = 3;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeGraphicsImport}
  gestaltQuickTimeThreadSafeGraphicsImport = 4;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeGraphicsExport}
  gestaltQuickTimeThreadSafeGraphicsExport = 5;
  {$EXTERNALSYM gestaltQuickTimeThreadSafeMoviePlayback}
  gestaltQuickTimeThreadSafeMoviePlayback = 6;
//};

//enum {
  {$EXTERNALSYM gestaltQTVRMgrAttr}
  gestaltQTVRMgrAttr            = $71747672; //'qtvr', /* QuickTime VR attributes                               */
  {$EXTERNALSYM gestaltQTVRMgrPresent}
   gestaltQTVRMgrPresent         = 0;   //* QTVR API is present                                   */
  {$EXTERNALSYM gestaltQTVRObjMoviesPresent}
  gestaltQTVRObjMoviesPresent   = 1;    //* QTVR runtime knows about object movies                */
  {$EXTERNALSYM gestaltQTVRCylinderPanosPresent}
  gestaltQTVRCylinderPanosPresent = 2;  //* QTVR runtime knows about cylindrical panoramic movies */
  {$EXTERNALSYM gestaltQTVRCubicPanosPresent}
  gestaltQTVRCubicPanosPresent  = 3;     //* QTVR runtime knows about cubic panoramic movies       */
//};

//enum {
  {$EXTERNALSYM gestaltQTVRMgrVers}
  gestaltQTVRMgrVers            = $71747676; //'qtvv' /* QuickTime VR version                                  */
//};

{*
    Because some PowerPC machines now support very large physical memory capacities, including
    some above the maximum value which can held in a 32 bit quantity, there is now a new selector,
    gestaltPhysicalRAMSizeInMegabytes, which returns the size of physical memory scaled
    in megabytes.  It is recommended that code transition to using this new selector if
    it wants to get a useful value for the amount of physical memory on the system.  Code can
    also use the sysctl() and sysctlbyname() BSD calls to get these kinds of values.

    For compatability with code which assumed that the value in returned by the
    gestaltPhysicalRAMSize selector would be a signed quantity of bytes, this selector will
    now return 2 gigabytes-1 ( INT_MAX ) if the system has 2 gigabytes of physical memory or more.
*}
//enum {
  {$EXTERNALSYM gestaltPhysicalRAMSize}
  gestaltPhysicalRAMSize        = $72616d20; //'ram ' /* physical RAM size, in bytes */
//};

//enum {
  {$EXTERNALSYM gestaltPhysicalRAMSizeInMegabytes}
  gestaltPhysicalRAMSizeInMegabytes = $72616d6d; // 'ramm' /* physical RAM size, scaled in megabytes */
//};

//enum {
  {$EXTERNALSYM gestaltRBVAddr}
  gestaltRBVAddr                = $72627620; // 'rbv ' /* RBV base address  */
//};

//enum {
  {$EXTERNALSYM gestaltROMSize}
  gestaltROMSize                = $726f6d20; //'rom ' /* rom size */
//};

//enum {
//  gestaltROMVersion             = 'romv' /* rom version */
  {$EXTERNALSYM gestaltROMVersion}
  gestaltROMVersion             = $726f6d76;
//};

//enum {
  {$EXTERNALSYM gestaltResourceMgrAttr}
  gestaltResourceMgrAttr        = $72737263;// 'rsrc', /* Resource Mgr attributes */
  {$EXTERNALSYM gestaltPartialRsrcs}
  gestaltPartialRsrcs           = 0;    //* True if partial resources exist */
  {$EXTERNALSYM gestaltHasResourceOverrides}
  gestaltHasResourceOverrides   = 1;    //* Appears in the ROM; so put it here. */
//};

//enum {
  {$EXTERNALSYM gestaltResourceMgrBugFixesAttrs}
  gestaltResourceMgrBugFixesAttrs = $726d6267; //'rmbg', /* Resource Mgr bug fixes */
  {$EXTERNALSYM gestaltRMForceSysHeapRolledIn}
  gestaltRMForceSysHeapRolledIn = 0;
  {$EXTERNALSYM gestaltRMFakeAppleMenuItemsRolledIn}
  gestaltRMFakeAppleMenuItemsRolledIn = 1;
  {$EXTERNALSYM gestaltSanityCheckResourceFiles}
  gestaltSanityCheckResourceFiles = 2;  //* Resource manager does sanity checking on resource files before opening them */
  {$EXTERNALSYM gestaltSupportsFSpResourceFileAlreadyOpenBit}
  gestaltSupportsFSpResourceFileAlreadyOpenBit = 3; //* The resource manager supports GetResFileRefNum and FSpGetResFileRefNum and FSpResourceFileAlreadyOpen */
  {$EXTERNALSYM gestaltRMSupportsFSCalls}
  gestaltRMSupportsFSCalls      = 4;    //* The resource manager supports OpenResFileFSRef, CreateResFileFSRef and  ResourceFileAlreadyOpenFSRef */
  {$EXTERNALSYM gestaltRMTypeIndexOrderingReverse}
  gestaltRMTypeIndexOrderingReverse = 8; //* GetIndType() calls return resource types in opposite order to original 68k resource manager */
//};


//enum {
  {$EXTERNALSYM gestaltRealtimeMgrAttr}
  gestaltRealtimeMgrAttr        = $72746d72;//'rtmr', /* Realtime manager attributes         */
  {$EXTERNALSYM gestaltRealtimeMgrPresent}
  gestaltRealtimeMgrPresent       = 0;     //* true if the Realtime manager is present    */
//};


//enum {
  {$EXTERNALSYM gestaltSafeOFAttr}
  gestaltSafeOFAttr             = $73616665;//'safe',
  {$EXTERNALSYM gestaltVMZerosPagesBit}
  gestaltVMZerosPagesBit        = 0;
  {$EXTERNALSYM gestaltInitHeapZerosOutHeapsBit}
  gestaltInitHeapZerosOutHeapsBit = 1;
  {$EXTERNALSYM gestaltNewHandleReturnsZeroedMemoryBit}
  gestaltNewHandleReturnsZeroedMemoryBit = 2;
  {$EXTERNALSYM gestaltNewPtrReturnsZeroedMemoryBit}
  gestaltNewPtrReturnsZeroedMemoryBit = 3;
  {$EXTERNALSYM gestaltFileAllocationZeroedBlocksBit}
  gestaltFileAllocationZeroedBlocksBit = 4;
//};


//enum {
  {$EXTERNALSYM gestaltSCCReadAddr}
  gestaltSCCReadAddr            = $73636372; //'sccr' /* scc read base address  */
//};

//enum {
  {$EXTERNALSYM gestaltSCCWriteAddr}
  gestaltSCCWriteAddr           = $73636377; //'sccw' /* scc read base address  */
//};

//enum {
  {$EXTERNALSYM gestaltScrapMgrAttr}
  gestaltScrapMgrAttr           = $73637261;//'scra', /* Scrap Manager attributes */
  {$EXTERNALSYM gestaltScrapMgrTranslationAware}
  gestaltScrapMgrTranslationAware = 0;   //* True if scrap manager is translation aware */
//};

//enum {
  {$EXTERNALSYM gestaltScriptMgrVersion}
  gestaltScriptMgrVersion       = $73637269;// 'scri' /* Script Manager version number     */
//};

//enum {
  {$EXTERNALSYM gestaltScriptCount}
  gestaltScriptCount            = $73637223;// 'scr#' /* number of active script systems   */
//};

//enum {
  {$EXTERNALSYM gestaltSCSI}
  gestaltSCSI                   = $73637369;//'scsi', /* SCSI Manager attributes */
  {$EXTERNALSYM gestaltAsyncSCSI}
  gestaltAsyncSCSI              = 0;    //* Supports Asynchronous SCSI */
  {$EXTERNALSYM gestaltAsyncSCSIINROM}
  gestaltAsyncSCSIINROM         = 1;    //* Async scsi is in ROM (available for booting) */
  {$EXTERNALSYM gestaltSCSISlotBoot}
  gestaltSCSISlotBoot           = 2;    //* ROM supports Slot-style PRAM for SCSI boots (PDM and later) */
  {$EXTERNALSYM gestaltSCSIPollSIH}
  gestaltSCSIPollSIH            = 3;    //* SCSI Manager will poll for interrupts if Secondary Interrupts are busy. */
//};

//enum {
  {$EXTERNALSYM gestaltControlStripAttr}
  gestaltControlStripAttr       = $73646576;//'sdev', /* Control Strip attributes */
  {$EXTERNALSYM gestaltControlStripExists}
  gestaltControlStripExists     = 0;    //* Control Strip is installed */
  {$EXTERNALSYM gestaltControlStripVersionFixed}
  gestaltControlStripVersionFixed = 1;  //* Control Strip version Gestalt selector was fixed */
  {$EXTERNALSYM gestaltControlStripUserFont}
  gestaltControlStripUserFont   = 2;    //* supports user-selectable font/size */
  {$EXTERNALSYM gestaltControlStripUserHotKey}
  gestaltControlStripUserHotKey = 3;     //* support user-selectable hot key to show/hide the window */
//};

//enum {
  {$EXTERNALSYM gestaltSDPStandardDirectoryVersion}
  gestaltSDPStandardDirectoryVersion = $73647672;//'sdvr' /* OCE Standard Directory Panel*/
//};

//enum {
  {$EXTERNALSYM gestaltSerialAttr}
  gestaltSerialAttr             = $73657220; //'ser ', /* Serial attributes */
  {$EXTERNALSYM gestaltHasGPIaToDCDa}
  gestaltHasGPIaToDCDa          = 0;    //* GPIa connected to DCDa*/
  {$EXTERNALSYM gestaltHasGPIaToRTxCa}
  gestaltHasGPIaToRTxCa         = 1;    //* GPIa connected to RTxCa clock input*/
  {$EXTERNALSYM gestaltHasGPIbToDCDb}
  gestaltHasGPIbToDCDb          = 2;    //* GPIb connected to DCDb */
  {$EXTERNALSYM gestaltHidePortA}
  gestaltHidePortA              = 3;    //* Modem port (A) should be hidden from users */
  {$EXTERNALSYM gestaltHidePortB}
  gestaltHidePortB              = 4;    //* Printer port (B) should be hidden from users */
  {$EXTERNALSYM gestaltPortADisabled}
  gestaltPortADisabled          = 5;    //* Modem port (A) disabled and should not be used by SW */
  {$EXTERNALSYM gestaltPortBDisabled}
  gestaltPortBDisabled          = 6;     //* Printer port (B) disabled and should not be used by SW */
//};

//enum {
  {$EXTERNALSYM gestaltShutdownAttributes}
  gestaltShutdownAttributes     = $73687574; //'shut', /* ShutDown Manager Attributes */
  {$EXTERNALSYM gestaltShutdownHassdOnBootVolUnmount}
  gestaltShutdownHassdOnBootVolUnmount = 0; //* True if ShutDown Manager unmounts boot & VM volume at shutdown time. */
//};

//enum {
  {$EXTERNALSYM gestaltNuBusConnectors}
  gestaltNuBusConnectors        = $736c7463; //'sltc' /* bitmap of NuBus connectors*/
//};

//enum {
  {$EXTERNALSYM gestaltSlotAttr}
  gestaltSlotAttr               = $736c6f74; //'slot', /* slot attributes  */
  {$EXTERNALSYM gestaltSlotMgrExists}
  gestaltSlotMgrExists          = 0;    //* true is slot mgr exists  */
  {$EXTERNALSYM gestaltNuBusPresent}
  gestaltNuBusPresent           = 1;    //* NuBus slots are present  */
  {$EXTERNALSYM gestaltSESlotPresent}
  gestaltSESlotPresent          = 2;    //* SE PDS slot present  */
  {$EXTERNALSYM gestaltSE30SlotPresent}
  gestaltSE30SlotPresent        = 3;    //* SE/30 slot present  */
  {$EXTERNALSYM gestaltPortableSlotPresent}
  gestaltPortableSlotPresent    = 4;    //* Portable’s slot present  */
//};

//enum {
//  gestaltFirstSlotNumber        = 'slt1' /* returns first physical slot */
  {$EXTERNALSYM gestaltFirstSlotNumber}
  gestaltFirstSlotNumber        = $736c7431;
//};

//enum {
  {$EXTERNALSYM gestaltSoundAttr}
  gestaltSoundAttr              = $736e6420; //'snd ', /* sound attributes */
  {$EXTERNALSYM gestaltStereoCapability}
  gestaltStereoCapability       = 0;    //* sound hardware has stereo capability */
  {$EXTERNALSYM gestaltStereoMixing}
  gestaltStereoMixing           = 1;    //* stereo mixing on external speaker */
  {$EXTERNALSYM gestaltSoundIOMgrPresent}
  gestaltSoundIOMgrPresent      = 3;    //* The Sound I/O Manager is present */
  {$EXTERNALSYM gestaltBuiltInSoundInput}
  gestaltBuiltInSoundInput      = 4;    //* built-in Sound Input hardware is present */
  {$EXTERNALSYM gestaltHasSoundInputDevice}
  gestaltHasSoundInputDevice    = 5;    //* Sound Input device available */
  {$EXTERNALSYM gestaltPlayAndRecord}
  gestaltPlayAndRecord          = 6;    //* built-in hardware can play and record simultaneously */
  {$EXTERNALSYM gestalt16BitSoundIO}
  gestalt16BitSoundIO           = 7;    //* sound hardware can play and record 16-bit samples */
  {$EXTERNALSYM gestaltStereoInput}
  gestaltStereoInput            = 8;    //* sound hardware can record stereo */
  {$EXTERNALSYM gestaltLineLevelInput}
  gestaltLineLevelInput         = 9;    //* sound input port requires line level */
                                        //* the following bits are not defined prior to Sound Mgr 3.0 */
  {$EXTERNALSYM gestaltSndPlayDoubleBuffer}
  gestaltSndPlayDoubleBuffer    = 10;   //* SndPlayDoubleBuffer available, set by Sound Mgr 3.0 and later */
  {$EXTERNALSYM gestaltMultiChannels}
  gestaltMultiChannels          = 11;   //* multiple channel support, set by Sound Mgr 3.0 and later */
  {$EXTERNALSYM gestalt16BitAudioSupport}
  gestalt16BitAudioSupport      = 12;    //* 16 bit audio data supported, set by Sound Mgr 3.0 and later */
//};

//enum {
  {$EXTERNALSYM gestaltSplitOSAttr}
  gestaltSplitOSAttr            = $73706f73;// 'spos',
  {$EXTERNALSYM gestaltSplitOSBootDriveIsNetworkVolume}
  gestaltSplitOSBootDriveIsNetworkVolume = 0; //* the boot disk is a network 'disk', from the .LANDisk drive. */
  {$EXTERNALSYM gestaltSplitOSAware}
  gestaltSplitOSAware           = 1;    //* the system includes the code to deal with a split os situation. */
  {$EXTERNALSYM gestaltSplitOSEnablerVolumeIsDifferentFromBootVolume}
  gestaltSplitOSEnablerVolumeIsDifferentFromBootVolume = 2; //* the active enabler is on a different volume than the system file. */
  {$EXTERNALSYM gestaltSplitOSMachineNameSetToNetworkNameTemp}
  gestaltSplitOSMachineNameSetToNetworkNameTemp = 3; //* The machine name was set to the value given us from the BootP server */
  {$EXTERNALSYM gestaltSplitOSMachineNameStartupDiskIsNonPersistent}
  gestaltSplitOSMachineNameStartupDiskIsNonPersistent = 5; //* The startup disk ( vRefNum == -1 ) is non-persistent, meaning changes won't persist across a restart. */
//};

//enum {
  {$EXTERNALSYM gestaltSMPSPSendLetterVersion}
  gestaltSMPSPSendLetterVersion = $7370736c;// 'spsl' /* OCE StandardMail*/
//};

//enum {
  {$EXTERNALSYM gestaltSpeechRecognitionAttr}
  gestaltSpeechRecognitionAttr  = $73727461; //'srta', /* speech recognition attributes */
  {$EXTERNALSYM gestaltDesktopSpeechRecognition}
  gestaltDesktopSpeechRecognition = 1; //* recognition thru the desktop microphone is available */
  {$EXTERNALSYM gestaltTelephoneSpeechRecognition}
  gestaltTelephoneSpeechRecognition = 2; //* recognition thru the telephone is available */
//};

//enum {
  {$EXTERNALSYM gestaltSpeechRecognitionVersion}
  gestaltSpeechRecognitionVersion = $73727462;//'srtb' /* speech recognition version (0x0150 is the first version that fully supports the API) */
//};

//enum {
  {$EXTERNALSYM gestaltSoftwareVendorCode}
  gestaltSoftwareVendorCode     = $73726164; //'srad', /* Returns system software vendor information */
  {$EXTERNALSYM gestaltSoftwareVendorApple}
  gestaltSoftwareVendorApple    = $4170706c; //'Appl', /* System software sold by Apple */
  //  gestaltSoftwareVendorLicensee = 'Lcns' /* System software sold by licensee */
  {$EXTERNALSYM gestaltSoftwareVendorLicensee}
  gestaltSoftwareVendorLicensee   = $4c636e73;
//};
//enum {
  {$EXTERNALSYM gestaltSysArchitecture}
  gestaltSysArchitecture        = $73797361;//'sysa', /* Native System Architecture */
  {$EXTERNALSYM gestalt68k}
  gestalt68k                    = 1;    //* Motorola MC68k architecture */
  {$EXTERNALSYM gestaltPowerPC}
  gestaltPowerPC                = 2;    //* IBM PowerPC architecture */
  {$EXTERNALSYM gestaltIntel}
  gestaltIntel                  = 10;    //* Intel x86 architecture */
//};

//enum {
  {$EXTERNALSYM gestaltSystemUpdateVersion}
  gestaltSystemUpdateVersion    = $73797375; //'sysu' /* System Update version */
//};

//enum {
  {$EXTERNALSYM gestaltSystemVersion}
  gestaltSystemVersion          = $73797376; //'sysv', /* system version*/
  {$EXTERNALSYM gestaltSystemVersionMajor}
  gestaltSystemVersionMajor     = $73797331; //'sys1', /* The major system version number; in 10.4.17 this would be the decimal value 10 */
  {$EXTERNALSYM gestaltSystemVersionMinor}
  gestaltSystemVersionMinor     = $73797332; //'sys2', /* The minor system version number; in 10.4.17 this would be the decimal value 4 */
  {$EXTERNALSYM gestaltSystemVersionBugFix}
  gestaltSystemVersionBugFix    = $73797333; //'sys3' /* The bug fix system version number; in 10.4.17 this would be the decimal value 17 */
  //};

//enum {
  {$EXTERNALSYM gestaltToolboxTable}
  gestaltToolboxTable           =  $74627474; //'tbtt' /*  OS trap table base  */
//};

//enum {
  {$EXTERNALSYM gestaltTextEditVersion}
  gestaltTextEditVersion        = $74652020; //'te  ', /* TextEdit version number */
  {$EXTERNALSYM gestaltTE1}
  gestaltTE1                    = 1;    //* TextEdit in MacIIci ROM */
  {$EXTERNALSYM gestaltTE2}
  gestaltTE2                    = 2;    //* TextEdit with 6.0.4 Script Systems on MacIIci (Script bug fixes for MacIIci) */
  {$EXTERNALSYM gestaltTE3}
  gestaltTE3                    = 3;    //* TextEdit with 6.0.4 Script Systems all but MacIIci */
  {$EXTERNALSYM gestaltTE4}
  gestaltTE4                    = 4;    //* TextEdit in System 7.0 */
  {$EXTERNALSYM gestaltTE5}
  gestaltTE5                    = 5;    //* TextWidthHook available in TextEdit */
//};

//enum {
  {$EXTERNALSYM gestaltTE6}
  gestaltTE6                    = 6;    //* TextEdit with integrated TSMTE and improved UI */
//};

//enum {
  {$EXTERNALSYM gestaltTEAttr}
  gestaltTEAttr                 = $74656174; //'teat'; /* TextEdit attributes */
  {$EXTERNALSYM gestaltTEHasGetHiliteRgn}
  gestaltTEHasGetHiliteRgn      = 0;    //* TextEdit has TEGetHiliteRgn */
  {$EXTERNALSYM gestaltTESupportsInlineInput}
  gestaltTESupportsInlineInput  = 1;    //* TextEdit does Inline Input */
  {$EXTERNALSYM gestaltTESupportsTextObjects}
  gestaltTESupportsTextObjects  = 2;    //* TextEdit does Text Objects */
  {$EXTERNALSYM gestaltTEHasWhiteBackground}
  gestaltTEHasWhiteBackground   = 3;    //* TextEdit supports overriding the TERec's background to white */
//};

//enum {
  {$EXTERNALSYM gestaltTeleMgrAttr}
  gestaltTeleMgrAttr            = $74656c65; //'tele', /* Telephone manager attributes */
  {$EXTERNALSYM gestaltTeleMgrPresent}
  gestaltTeleMgrPresent         = 0;
  {$EXTERNALSYM gestaltTeleMgrPowerPCSupport}
  gestaltTeleMgrPowerPCSupport  = 1;
  {$EXTERNALSYM gestaltTeleMgrSoundStreams}
  gestaltTeleMgrSoundStreams    = 2;
  {$EXTERNALSYM gestaltTeleMgrAutoAnswer}
  gestaltTeleMgrAutoAnswer      = 3;
  {$EXTERNALSYM gestaltTeleMgrIndHandset}
  gestaltTeleMgrIndHandset      = 4;
  {$EXTERNALSYM gestaltTeleMgrSilenceDetect}
  gestaltTeleMgrSilenceDetect   = 5;
  {$EXTERNALSYM gestaltTeleMgrNewTELNewSupport}
  gestaltTeleMgrNewTELNewSupport = 6;
//};

//enum {
  {$EXTERNALSYM gestaltTermMgrAttr}
  gestaltTermMgrAttr            = $7465726d; //'term', /* terminal mgr attributes */
  {$EXTERNALSYM gestaltTermMgrPresent}
  gestaltTermMgrPresent         = 0;
  {$EXTERNALSYM gestaltTermMgrErrorString}
  gestaltTermMgrErrorString     = 2;
//};

//enum {
  {$EXTERNALSYM gestaltThreadMgrAttr}
  gestaltThreadMgrAttr          = $74686473; //'thds', /* Thread Manager attributes */
  {$EXTERNALSYM gestaltThreadMgrPresent}
  gestaltThreadMgrPresent       = 0;    //* bit true if Thread Mgr is present */
  {$EXTERNALSYM gestaltSpecificMatchSupport}
  gestaltSpecificMatchSupport   = 1;    //* bit true if Thread Mgr supports exact match creation option */
  {$EXTERNALSYM gestaltThreadsLibraryPresent}
  gestaltThreadsLibraryPresent  = 2;    //* bit true if Thread Mgr shared library is present */
//};

//enum {
  {$EXTERNALSYM gestaltTimeMgrVersion}
  gestaltTimeMgrVersion         = $746d6772; //'tmgr', /* time mgr version */
  {$EXTERNALSYM gestaltStandardTimeMgr}
  gestaltStandardTimeMgr        = 1;    //* standard time mgr is present */
  {$EXTERNALSYM gestaltRevisedTimeMgr}
  gestaltRevisedTimeMgr         = 2;    //* revised time mgr is present */
  {$EXTERNALSYM gestaltExtendedTimeMgr}
  gestaltExtendedTimeMgr        = 3;    //* extended time mgr is present */
  {$EXTERNALSYM gestaltNativeTimeMgr}
  gestaltNativeTimeMgr          = 4;    //* PowerPC native TimeMgr is present */
//};

//enum {
  {$EXTERNALSYM gestaltTSMTEVersion}
  gestaltTSMTEVersion           = $746d5456; //'tmTV',
  {$EXTERNALSYM gestaltTSMTE1}
  gestaltTSMTE1                 = $0100; //* Original version of TSMTE */
  {$EXTERNALSYM gestaltTSMTE15}
  gestaltTSMTE15                = $0150; //* System 8.0 */
  {$EXTERNALSYM gestaltTSMTE152}
  gestaltTSMTE152               = $0152; //* System 8.2 */
//};

//enum {
  {$EXTERNALSYM gestaltTSMTEAttr}
  gestaltTSMTEAttr              = $746d5445; //'tmTE',
  {$EXTERNALSYM gestaltTSMTEPresent}
  gestaltTSMTEPresent           = 0;
  {$EXTERNALSYM gestaltTSMTE}
  gestaltTSMTE                  = 0;     //* gestaltTSMTE is old name for gestaltTSMTEPresent */
//};

//enum {
  {$EXTERNALSYM gestaltAVLTreeAttr}
  gestaltAVLTreeAttr            = $74726565; //'tree', /* AVLTree utility routines attributes. */
  {$EXTERNALSYM gestaltAVLTreePresentBit}
  gestaltAVLTreePresentBit      = 0;    //* if set, then the AVL Tree routines are available. */
  {$EXTERNALSYM gestaltAVLTreeSupportsHandleBasedTreeBit}
  gestaltAVLTreeSupportsHandleBasedTreeBit = 1; //* if set, then the AVL Tree routines can store tree data in a single handle */
  {$EXTERNALSYM gestaltAVLTreeSupportsTreeLockingBit}
  gestaltAVLTreeSupportsTreeLockingBit = 2; //* if set, the AVLLockTree() and AVLUnlockTree() routines are available. */
//};

//enum {
  {$EXTERNALSYM gestaltALMAttr}
  gestaltALMAttr                = $74726970; //'trip', /* Settings Manager attributes (see also gestaltALMVers) */
  {$EXTERNALSYM gestaltALMPresent}
  gestaltALMPresent             = 0;    //* bit true if ALM is available */
  {$EXTERNALSYM gestaltALMHasSFGroup}
  gestaltALMHasSFGroup          = 1;    //* bit true if Put/Get/Merge Group calls are implmented */
  {$EXTERNALSYM gestaltALMHasCFMSupport}
  gestaltALMHasCFMSupport       = 2;    //* bit true if CFM-based modules are supported */
  {$EXTERNALSYM gestaltALMHasRescanNotifiers}
  gestaltALMHasRescanNotifiers  = 3;    //* bit true if Rescan notifications/events will be sent to clients */
//};

//enum {
  {$EXTERNALSYM gestaltALMHasSFLocation}
  gestaltALMHasSFLocation       = gestaltALMHasSFGroup;
//};

//enum {
  {$EXTERNALSYM gestaltTSMgrVersion}
  gestaltTSMgrVersion           = $74736d76; //'tsmv', /* Text Services Mgr version, if present */
  {$EXTERNALSYM gestaltTSMgr15}
  gestaltTSMgr15                = $0150;
  {$EXTERNALSYM gestaltTSMgr20}
  gestaltTSMgr20                = $0200; //* Version 2.0 as of MacOSX 10.0 */
  {$EXTERNALSYM gestaltTSMgr22}
  gestaltTSMgr22                = $0220; //* Version 2.2 as of MacOSX 10.3 */
  {$EXTERNALSYM gestaltTSMgr23}
  gestaltTSMgr23                = $0230; //* Version 2.3 as of MacOSX 10.4 */
//};

//enum {
  {$EXTERNALSYM gestaltTSMgrAttr}
  gestaltTSMgrAttr              = $74736d61; //'tsma', /* Text Services Mgr attributes, if present */
  {$EXTERNALSYM gestaltTSMDisplayMgrAwareBit}
  gestaltTSMDisplayMgrAwareBit  = 0;    //* TSM knows about display manager */
  {$EXTERNALSYM gestaltTSMdoesTSMTEBit}
  gestaltTSMdoesTSMTEBit        = 1;    //* TSM has integrated TSMTE */
//};

//enum {
  {$EXTERNALSYM gestaltSpeechAttr}
  gestaltSpeechAttr             = $74747363; //'ttsc', /* Speech Manager attributes */
  {$EXTERNALSYM gestaltSpeechMgrPresent}
  gestaltSpeechMgrPresent       = 0;    //* bit set indicates that Speech Manager exists */
  {$EXTERNALSYM gestaltSpeechHasPPCGlue}
  gestaltSpeechHasPPCGlue       = 1;     //* bit set indicates that native PPC glue for Speech Manager API exists */
//};

//enum {
  {$EXTERNALSYM gestaltTVAttr}
  gestaltTVAttr                 = $74762020; //'tv  ', /* TV version */
  {$EXTERNALSYM gestaltHasTVTuner}
  gestaltHasTVTuner             = 0;    //* supports Philips FL1236F video tuner */
  {$EXTERNALSYM gestaltHasSoundFader}
  gestaltHasSoundFader          = 1;    //* supports Philips TEA6330 Sound Fader chip */
  {$EXTERNALSYM gestaltHasHWClosedCaptioning}
  gestaltHasHWClosedCaptioning  = 2;    //* supports Philips SAA5252 Closed Captioning */
  {$EXTERNALSYM gestaltHasIRRemote}
  gestaltHasIRRemote            = 3;    //* supports CyclopsII Infra Red Remote control */
  {$EXTERNALSYM gestaltHasVidDecoderScaler}
  gestaltHasVidDecoderScaler    = 4;    //* supports Philips SAA7194 Video Decoder/Scaler */
  {$EXTERNALSYM gestaltHasStereoDecoder}
  gestaltHasStereoDecoder       = 5;    //* supports Sony SBX1637A-01 stereo decoder */
  {$EXTERNALSYM gestaltHasSerialFader}
  gestaltHasSerialFader         = 6;    //* has fader audio in serial with system audio */
  {$EXTERNALSYM gestaltHasFMTuner}
  gestaltHasFMTuner             = 7;    //* has FM Tuner from donnybrook card */
  {$EXTERNALSYM gestaltHasSystemIRFunction}
  gestaltHasSystemIRFunction    = 8;    //* Infra Red button function is set up by system and not by Video Startup */
  {$EXTERNALSYM gestaltIRDisabled}
  gestaltIRDisabled             = 9;    //* Infra Red remote is not disabled. */
  {$EXTERNALSYM gestaltINeedIRPowerOffConfirm}
  gestaltINeedIRPowerOffConfirm = 10;   //* Need IR power off confirm dialog. */
  {$EXTERNALSYM gestaltHasZoomedVideo}
  gestaltHasZoomedVideo         = 11;   //* Has Zoomed Video PC Card video input. */
//};


//enum {
  {$EXTERNALSYM gestaltATSUVersion}
  gestaltATSUVersion            = $75697376; //'uisv',
  {$EXTERNALSYM gestaltOriginalATSUVersion}
  gestaltOriginalATSUVersion    = (1 shl 16); //* ATSUI version 1.0 */
  {$EXTERNALSYM gestaltATSUUpdate1}
  gestaltATSUUpdate1            = (2 shl 16); //* ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSUUpdate2}
  gestaltATSUUpdate2            = (3 shl 16); //* ATSUI version 1.2 */
  {$EXTERNALSYM gestaltATSUUpdate3}
  gestaltATSUUpdate3            = (4 shl 16); //* ATSUI version 2.0 */
  {$EXTERNALSYM gestaltATSUUpdate4}
  gestaltATSUUpdate4            = (5 shl 16); //* ATSUI version in Mac OS X - SoftwareUpdate 1-4 for Mac OS 10.0.1 - 10.0.4 */
  {$EXTERNALSYM gestaltATSUUpdate5}
  gestaltATSUUpdate5            = (6 shl 16); //* ATSUI version 2.3 in MacOS 10.1 */
  {$EXTERNALSYM gestaltATSUUpdate6}
  gestaltATSUUpdate6            = (7 shl 16); //* ATSUI version 2.4 in MacOS 10.2 */
  {$EXTERNALSYM gestaltATSUUpdate7}
  gestaltATSUUpdate7            = (8 shl 16); //* ATSUI version 2.5 in MacOS 10.3 */
//};

//enum {
  {$EXTERNALSYM gestaltATSUFeatures}
  gestaltATSUFeatures           = $75697366; //'uisf',
  {$EXTERNALSYM gestaltATSUTrackingFeature}
  gestaltATSUTrackingFeature    = $00000001; //* feature introduced in ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSUMemoryFeature}
  gestaltATSUMemoryFeature      = $00000001; //* feature introduced in ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSUFallbacksFeature}
  gestaltATSUFallbacksFeature   = $00000001; //* feature introduced in ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSUGlyphBoundsFeature}
  gestaltATSUGlyphBoundsFeature = $00000001; //* feature introduced in ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSULineControlFeature}
  gestaltATSULineControlFeature = $00000001; //* feature introduced in ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSULayoutCreateAndCopyFeature}
  gestaltATSULayoutCreateAndCopyFeature = $00000001; //* feature introduced in ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSULayoutCacheClearFeature}
  gestaltATSULayoutCacheClearFeature = $00000001; //* feature introduced in ATSUI version 1.1 */
  {$EXTERNALSYM gestaltATSUTextLocatorUsageFeature}
  gestaltATSUTextLocatorUsageFeature = $00000002; //* feature introduced in ATSUI version 1.2 */
  {$EXTERNALSYM gestaltATSULowLevelOrigFeatures}
  gestaltATSULowLevelOrigFeatures = $00000004; //* first low-level features introduced in ATSUI version 2.0 */
  {$EXTERNALSYM gestaltATSUFallbacksObjFeatures}
  gestaltATSUFallbacksObjFeatures = $00000008; //* feature introduced - ATSUFontFallbacks objects introduced in ATSUI version 2.3 */
  {$EXTERNALSYM gestaltATSUIgnoreLeadingFeature}
  gestaltATSUIgnoreLeadingFeature = $00000008; //* feature introduced - kATSLineIgnoreFontLeading LineLayoutOption introduced in ATSUI version 2.3 */
  {$EXTERNALSYM gestaltATSUByCharacterClusterFeature}
  gestaltATSUByCharacterClusterFeature = $00000010; //* ATSUCursorMovementTypes introduced in ATSUI version 2.4 */
  {$EXTERNALSYM gestaltATSUAscentDescentControlsFeature}
  gestaltATSUAscentDescentControlsFeature = $00000010; //* attributes introduced in ATSUI version 2.4 */
  {$EXTERNALSYM gestaltATSUHighlightInactiveTextFeature}
  gestaltATSUHighlightInactiveTextFeature = $00000010; //* feature introduced in ATSUI version 2.4 */
  {$EXTERNALSYM gestaltATSUPositionToCursorFeature}
  gestaltATSUPositionToCursorFeature = $00000010; //* features introduced in ATSUI version 2.4 */
  {$EXTERNALSYM gestaltATSUBatchBreakLinesFeature}
  gestaltATSUBatchBreakLinesFeature = $00000010; //* feature introduced in ATSUI version 2.4 */
  {$EXTERNALSYM gestaltATSUTabSupportFeature}
  gestaltATSUTabSupportFeature  = $00000010; //* features introduced in ATSUI version 2.4 */
  {$EXTERNALSYM gestaltATSUDirectAccess}
  gestaltATSUDirectAccess       = $00000010; //* features introduced in ATSUI version 2.4 */
  {$EXTERNALSYM gestaltATSUDecimalTabFeature}
  gestaltATSUDecimalTabFeature  = $00000020; //* feature introduced in ATSUI version 2.5 */
  {$EXTERNALSYM gestaltATSUBiDiCursorPositionFeature}
  gestaltATSUBiDiCursorPositionFeature = $00000020; //* feature introduced in ATSUI version 2.5 */
  {$EXTERNALSYM gestaltATSUNearestCharLineBreakFeature}
  gestaltATSUNearestCharLineBreakFeature = $00000020; //* feature introduced in ATSUI version 2.5 */
  {$EXTERNALSYM gestaltATSUHighlightColorControlFeature}
  gestaltATSUHighlightColorControlFeature = $00000020; //* feature introduced in ATSUI version 2.5 */
  {$EXTERNALSYM gestaltATSUUnderlineOptionsStyleFeature}
  gestaltATSUUnderlineOptionsStyleFeature = $00000020; //* feature introduced in ATSUI version 2.5 */
  {$EXTERNALSYM gestaltATSUStrikeThroughStyleFeature}
  gestaltATSUStrikeThroughStyleFeature = $00000020; //* feature introduced in ATSUI version 2.5 */
  {$EXTERNALSYM gestaltATSUDropShadowStyleFeature}
  gestaltATSUDropShadowStyleFeature = $00000020; //* feature introduced in ATSUI version 2.5 */
//};

//enum {
  {$EXTERNALSYM gestaltUSBAttr}
  gestaltUSBAttr                = $75736220; // 'usb ', /* USB Attributes */
  {$EXTERNALSYM gestaltUSBPresent}
  gestaltUSBPresent             = 0;    //* USB Support available */
  {$EXTERNALSYM gestaltUSBHasIsoch}
  gestaltUSBHasIsoch            = 1;     //* USB Isochronous features available */
//};

//enum {
  {$EXTERNALSYM gestaltUSBVersion}
  gestaltUSBVersion             = $75736276; //'usbv' /* USB version */
//};

//enum {
  {$EXTERNALSYM gestaltVersion}
  gestaltVersion                = $76657273; //'vers', /* gestalt version */
  {$EXTERNALSYM gestaltValueImplementedVers}
  gestaltValueImplementedVers   = 5;     //* version of gestalt where gestaltValue is implemented. */
//};

//enum {
  {$EXTERNALSYM gestaltVIA1Addr}
  gestaltVIA1Addr               = $76696131; //'via1' /* via 1 base address  */
//};

//enum {
  {$EXTERNALSYM gestaltVIA2Addr}
  gestaltVIA2Addr               = $76696132; //'via2' /* via 2 base address  */
//};

//enum {
  {$EXTERNALSYM gestaltVMAttr}
  gestaltVMAttr                 = $766d2020; //'vm  ', /* virtual memory attributes */
  {$EXTERNALSYM gestaltVMPresent}
  gestaltVMPresent              = 0;    //* true if virtual memory is present */
  {$EXTERNALSYM gestaltVMHasLockMemoryForOutput}
  gestaltVMHasLockMemoryForOutput = 1;  //* true if LockMemoryForOutput is available */
  {$EXTERNALSYM gestaltVMFilemappingOn}
  gestaltVMFilemappingOn        = 3;    //* true if filemapping is available */
  {$EXTERNALSYM gestaltVMHasPagingControl}
  gestaltVMHasPagingControl     = 4;    //* true if MakeMemoryResident, MakeMemoryNonResident, FlushMemory, and ReleaseMemoryData are available */
//};

//enum {
  {$EXTERNALSYM gestaltVMInfoType}
  gestaltVMInfoType             = $766d696e; // 'vmin', /* Indicates how the Finder should display information about VM in */
                                        //* the Finder about box. */
  {$EXTERNALSYM gestaltVMInfoSizeStorageType}
  gestaltVMInfoSizeStorageType  = 0;    //* Display VM on/off, backing store size and name */
  {$EXTERNALSYM gestaltVMInfoSizeType}
  gestaltVMInfoSizeType         = 1;    //* Display whether VM is on or off and the size of the backing store */
  {$EXTERNALSYM gestaltVMInfoSimpleType}
  gestaltVMInfoSimpleType       = 2;    //* Display whether VM is on or off */
  {$EXTERNALSYM gestaltVMInfoNoneType}
  gestaltVMInfoNoneType         = 3;    //* Display no VM information */
//};

//enum {
  {$EXTERNALSYM gestaltVMBackingStoreFileRefNum}
  gestaltVMBackingStoreFileRefNum = $766d6273; //'vmbs'; //* file refNum of virtual memory's main backing store file (returned in low word of result) */
//};



//enum {
  {$EXTERNALSYM gestaltALMVers}
  gestaltALMVers                = $77616c6b; //'walk' /* Settings Manager version (see also gestaltALMAttr) */
//};

//enum {
  {$EXTERNALSYM gestaltWindowMgrAttr}
  gestaltWindowMgrAttr          = $77696e64; //'wind', /* If this Gestalt exists, the Mac OS 8.5 Window Manager is installed*/
  {$EXTERNALSYM gestaltWindowMgrPresent}
  gestaltWindowMgrPresent       = (1 shl 0); //* NOTE: this is a bit mask, whereas all other Gestalt constants of*/
                                        //* this type are bit index values.   Universal Interfaces 3.2 slipped*/
                                        //* out the door with this mistake.*/
  {$EXTERNALSYM gestaltWindowMgrPresentBit}
  gestaltWindowMgrPresentBit    = 0;    //* bit number*/
  {$EXTERNALSYM gestaltExtendedWindowAttributes}
  gestaltExtendedWindowAttributes = 1;  //* Has ChangeWindowAttributes; GetWindowAttributes works for all windows*/
  {$EXTERNALSYM gestaltExtendedWindowAttributesBit}
  gestaltExtendedWindowAttributesBit = 1; //* Has ChangeWindowAttributes; GetWindowAttributes works for all windows*/
  {$EXTERNALSYM gestaltHasFloatingWindows}
  gestaltHasFloatingWindows     = 2;    //* Floating window APIs work*/
  {$EXTERNALSYM gestaltHasFloatingWindowsBit}
  gestaltHasFloatingWindowsBit  = 2;    //* Floating window APIs work*/
  {$EXTERNALSYM gestaltHasWindowBuffering}
  gestaltHasWindowBuffering     = 3;    //* This system has buffering available*/
  {$EXTERNALSYM gestaltHasWindowBufferingBit}
  gestaltHasWindowBufferingBit  = 3;    //* This system has buffering available*/
  {$EXTERNALSYM gestaltWindowLiveResizeBit}
  gestaltWindowLiveResizeBit    = 4;    //* live resizing of windows is available*/
  {$EXTERNALSYM gestaltWindowMinimizeToDockBit}
  gestaltWindowMinimizeToDockBit = 5;   //* windows minimize to the dock and do not windowshade (Mac OS X)*/
  {$EXTERNALSYM gestaltHasWindowShadowsBit}
  gestaltHasWindowShadowsBit    = 6;    //* windows have shadows*/
  {$EXTERNALSYM gestaltSheetsAreWindowModalBit}
  gestaltSheetsAreWindowModalBit = 7;   //* sheet windows are modal only to their parent window*/
  {$EXTERNALSYM gestaltFrontWindowMayBeHiddenBit}
  gestaltFrontWindowMayBeHiddenBit = 8; //* FrontWindow and related APIs will return the front window even when the app is hidden*/
                                        //* masks for the above bits*/
  {$EXTERNALSYM gestaltWindowMgrPresentMask}
  gestaltWindowMgrPresentMask   = (1 shl gestaltWindowMgrPresentBit);
  {$EXTERNALSYM gestaltExtendedWindowAttributesMask}
  gestaltExtendedWindowAttributesMask = (1 shl gestaltExtendedWindowAttributesBit);
  {$EXTERNALSYM gestaltHasFloatingWindowsMask}
  gestaltHasFloatingWindowsMask = (1 shl gestaltHasFloatingWindowsBit);
  {$EXTERNALSYM gestaltHasWindowBufferingMask}
  gestaltHasWindowBufferingMask = (1 shl gestaltHasWindowBufferingBit);
  {$EXTERNALSYM gestaltWindowLiveResizeMask}
  gestaltWindowLiveResizeMask   = (1 shl gestaltWindowLiveResizeBit);
  {$EXTERNALSYM gestaltWindowMinimizeToDockMask}
  gestaltWindowMinimizeToDockMask = (1 shl gestaltWindowMinimizeToDockBit);
  {$EXTERNALSYM gestaltHasWindowShadowsMask}
  gestaltHasWindowShadowsMask   = (1 shl gestaltHasWindowShadowsBit);
  {$EXTERNALSYM gestaltSheetsAreWindowModalMask}
  gestaltSheetsAreWindowModalMask = (1 shl gestaltSheetsAreWindowModalBit);
  {$EXTERNALSYM gestaltFrontWindowMayBeHiddenMask}
  gestaltFrontWindowMayBeHiddenMask = (1 shl gestaltFrontWindowMayBeHiddenBit);
//};

//enum {
  {$EXTERNALSYM gestaltHasSingleWindowModeBit}
  gestaltHasSingleWindowModeBit = 8;    //* This system supports single window mode*/
  {$EXTERNALSYM gestaltHasSingleWindowModeMask}
  gestaltHasSingleWindowModeMask = (1 shl gestaltHasSingleWindowModeBit);
//};


{* gestaltX86Features is a convenience for 'cpuid' instruction.  Note
   that even though the processor may support a specific feature, the
   OS may not support all of these features.  These bitfields
   correspond directly to the bits returned by cpuid *}
//enum {
  {$EXTERNALSYM gestaltX86Features}
  gestaltX86Features            = $78383666; //'x86f',
  {$EXTERNALSYM gestaltX86HasFPU}
  gestaltX86HasFPU              = 0;    //* has an FPU that supports the 387 instructions*/
  {$EXTERNALSYM gestaltX86HasVME}
  gestaltX86HasVME              = 1;    //* supports Virtual-8086 Mode Extensions*/
  {$EXTERNALSYM gestaltX86HasDE}
  gestaltX86HasDE               = 2;    //* supports I/O breakpoints (Debug Extensions)*/
  {$EXTERNALSYM gestaltX86HasPSE}
  gestaltX86HasPSE              = 3;    //* supports 4-Mbyte pages (Page Size Extension)*/
  {$EXTERNALSYM gestaltX86HasTSC}
  gestaltX86HasTSC              = 4;    //* supports RTDSC instruction (Time Stamp Counter)*/
  {$EXTERNALSYM gestaltX86HasMSR}
  gestaltX86HasMSR              = 5;    //* supports Model Specific Registers*/
  {$EXTERNALSYM gestaltX86HasPAE}
  gestaltX86HasPAE              = 6;    //* supports physical addresses > 32 bits (Physical Address Extension)*/
  {$EXTERNALSYM gestaltX86HasMCE}
  gestaltX86HasMCE              = 7;    //* supports Machine Check Exception*/
  {$EXTERNALSYM gestaltX86HasCX8}
  gestaltX86HasCX8              = 8;    //* supports CMPXCHG8 instructions (Compare Exchange 8 bytes)*/
  {$EXTERNALSYM gestaltX86HasAPIC}
  gestaltX86HasAPIC             = 9;    //* contains local APIC*/
  {$EXTERNALSYM gestaltX86HasSEP}
  gestaltX86HasSEP              = 11;   //* supports fast system call (SysEnter Present)*/
  {$EXTERNALSYM gestaltX86HasMTRR}
  gestaltX86HasMTRR             = 12;   //* supports Memory Type Range Registers*/
  {$EXTERNALSYM gestaltX86HasPGE}
  gestaltX86HasPGE              = 13;   //* supports Page Global Enable*/
  {$EXTERNALSYM gestaltX86HasMCA}
  gestaltX86HasMCA              = 14;   //* supports Machine Check Architecture*/
  {$EXTERNALSYM gestaltX86HasCMOV}
  gestaltX86HasCMOV             = 15;   //* supports CMOVcc instruction (Conditional Move).*/
                                        //* If FPU bit is also set, supports FCMOVcc and FCOMI, too*/
  {$EXTERNALSYM gestaltX86HasPAT}
  gestaltX86HasPAT              = 16;   //* supports Page Attribute Table*/
  {$EXTERNALSYM gestaltX86HasPSE36}
  gestaltX86HasPSE36            = 17;   //* supports 36-bit Page Size Extension*/
  {$EXTERNALSYM gestaltX86HasPSN}
  gestaltX86HasPSN              = 18;   //* Processor Serial Number*/
  {$EXTERNALSYM gestaltX86HasCLFSH}
  gestaltX86HasCLFSH            = 19;   //* CLFLUSH Instruction supported*/
  {$EXTERNALSYM gestaltX86Serviced20}
  gestaltX86Serviced20          = 20;   //* do not count on this bit value*/
  {$EXTERNALSYM gestaltX86HasDS}
  gestaltX86HasDS               = 21;   //* Debug Store*/
  {$EXTERNALSYM gestaltX86ResACPI}
  gestaltX86ResACPI             = 22;   //* Thermal Monitor, SW-controlled clock*/
  {$EXTERNALSYM gestaltX86HasMMX}
  gestaltX86HasMMX              = 23;   //* supports MMX instructions*/
  {$EXTERNALSYM gestaltX86HasFXSR}
  gestaltX86HasFXSR             = 24;   //* Supports FXSAVE and FXRSTOR instructions (fast FP save/restore)*/
  {$EXTERNALSYM gestaltX86HasSSE}
  gestaltX86HasSSE              = 25;   //* Streaming SIMD extensions*/
  {$EXTERNALSYM gestaltX86HasSSE2}
  gestaltX86HasSSE2             = 26;   //* Streaming SIMD extensions 2*/
  {$EXTERNALSYM gestaltX86HasSS}
  gestaltX86HasSS               = 27;   //* Self-Snoop*/
  {$EXTERNALSYM gestaltX86HasHTT}
  gestaltX86HasHTT              = 28;   //* Hyper-Threading Technology*/
  {$EXTERNALSYM gestaltX86HasTM}
  gestaltX86HasTM               = 29;   //* Thermal Monitor*/
//};

{* 'cpuid' now returns a 64 bit value, and the following
    gestalt selector and field definitions apply
    to the extended form of this instruction *}
//enum {
  {$EXTERNALSYM gestaltX86AdditionalFeatures}
  gestaltX86AdditionalFeatures  = $78383661; //'x86a',
  {$EXTERNALSYM gestaltX86HasSSE3}
  gestaltX86HasSSE3             = 0;    //* Prescott New Inst.*/
  {$EXTERNALSYM gestaltX86HasMONITOR}
  gestaltX86HasMONITOR          = 3;    //* Monitor/mwait*/
  {$EXTERNALSYM gestaltX86HasDSCPL}
  gestaltX86HasDSCPL            = 4;    //* Debug Store CPL*/
  {$EXTERNALSYM gestaltX86HasVMX}
  gestaltX86HasVMX              = 5;    //* VMX*/
  {$EXTERNALSYM gestaltX86HasSMX}
  gestaltX86HasSMX              = 6;    //* SMX*/
  {$EXTERNALSYM gestaltX86HasEST}
  gestaltX86HasEST              = 7;    //* Enhanced SpeedsTep (GV3)*/
  {$EXTERNALSYM gestaltX86HasTM2}
  gestaltX86HasTM2              = 8;    //* Thermal Monitor 2*/
  {$EXTERNALSYM gestaltX86HasSupplementalSSE3}
  gestaltX86HasSupplementalSSE3 = 9;    //* Supplemental SSE3 instructions*/
  {$EXTERNALSYM gestaltX86HasCID}
  gestaltX86HasCID              = 10;   //* L1 Context ID*/
  {$EXTERNALSYM gestaltX86HasCX16}
  gestaltX86HasCX16             = 13;   //* CmpXchg16b instruction*/
  {$EXTERNALSYM gestaltX86HasxTPR}
  gestaltX86HasxTPR             = 14;    //* Send Task PRiority msgs*/
//};

//enum {
  {$EXTERNALSYM gestaltTranslationAttr}
  gestaltTranslationAttr        = $786c6174; //'xlat', /* Translation Manager attributes */
  {$EXTERNALSYM gestaltTranslationMgrExists}
  gestaltTranslationMgrExists   = 0;    //* True if translation manager exists */
  {$EXTERNALSYM gestaltTranslationMgrHintOrder}
  gestaltTranslationMgrHintOrder = 1;   //* True if hint order reversal in effect */
  {$EXTERNALSYM gestaltTranslationPPCAvail}
  gestaltTranslationPPCAvail    = 2;
  {$EXTERNALSYM gestaltTranslationGetPathAPIAvail}
  gestaltTranslationGetPathAPIAvail = 3;
//};

//enum {
  {$EXTERNALSYM gestaltExtToolboxTable}
  gestaltExtToolboxTable        = $78747474; //'xttt' /* Extended Toolbox trap table base */
//};

//enum {
  {$EXTERNALSYM gestaltUSBPrinterSharingVersion}
  gestaltUSBPrinterSharingVersion = $7a616b20; //'zak ', /* USB Printer Sharing Version*/
  {$EXTERNALSYM gestaltUSBPrinterSharingVersionMask}
  gestaltUSBPrinterSharingVersionMask = $0000FFFF; //* mask for bits in version*/
  {$EXTERNALSYM gestaltUSBPrinterSharingAttr}
  gestaltUSBPrinterSharingAttr  =  $7a616b20; //'zak ', /* USB Printer Sharing Attributes*/
  {$EXTERNALSYM gestaltUSBPrinterSharingAttrMask}
  gestaltUSBPrinterSharingAttrMask = TIdC_INT($FFFF0000); //*  mask for attribute bits*/
  {$EXTERNALSYM gestaltUSBPrinterSharingAttrRunning}
  gestaltUSBPrinterSharingAttrRunning = TIdC_INT($80000000); //* printer sharing is running*/
  {$EXTERNALSYM gestaltUSBPrinterSharingAttrBooted}
  gestaltUSBPrinterSharingAttrBooted = $40000000; //* printer sharing was installed at boot time*/
//};

//*WorldScript settings;*/
//enum {
  {$EXTERNALSYM gestaltWorldScriptIIVersion}
  gestaltWorldScriptIIVersion   = $646f7562; //'doub',
  {$EXTERNALSYM gestaltWorldScriptIIAttr}
  gestaltWorldScriptIIAttr      = $77736174; //'wsat',
  {$EXTERNALSYM gestaltWSIICanPrintWithoutPrGeneralBit}
  gestaltWSIICanPrintWithoutPrGeneralBit = 0; //* bit 0 is on if WS II knows about PrinterStatus callback */
//};

type
//may very depeanding on CPU architecture.
{$EXTERNALSYM SelectorFunctionProcPtr}
  SelectorFunctionProcPtr = function (selector : OSType; var response : SInt32 ): OSErr cdecl;
{$EXTERNALSYM SelectorFunctionUPP}
  SelectorFunctionUPP = SelectorFunctionProcPtr;
  
//MacErrors.h
{*
 *  SysError()
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *}
{$EXTERNALSYM SysError}
procedure SysError(errorCode : TIdC_SHORT) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
//gestalt.h
{*
 *  Gestalt()
 *  
 *  Summary:
 *    Gestalt returns information about the operating environment.
 *  
 *  Discussion:
 *    The Gestalt function places the information requested by the
 *    selector parameter in the variable parameter response . Note that
 *    Gestalt returns the response from all selectors in an SInt32,
 *    which occupies 4 bytes. When not all 4 bytes are needed, the
 *    significant information appears in the low-order byte or bytes.
 *    Although the response parameter is declared as a variable
 *    parameter, you cannot use it to pass information to Gestalt or to
 *    a Gestalt selector function. Gestalt interprets the response
 *    parameter as an address at which it is to place the result
 *    returned by the selector function specified by the selector
 *    parameter. Gestalt ignores any information already at that
 *    address.
 *    
 *    The Apple-defined selector codes fall into two categories:
 *    environmental selectors, which supply specific environmental
 *    information you can use to control the behavior of your
 *    application, and informational selectors, which supply
 *    information you can't use to determine what hardware or software
 *    features are available. You can use one of the selector codes
 *    defined by Apple (listed in the "Constants" section beginning on
 *    page 1-14 ) or a selector code defined by a third-party
 *    product.
 *    
 *    The meaning of the value that Gestalt returns in the response
 *    parameter depends on the selector code with which it was called.
 *    For example, if you call Gestalt using the gestaltTimeMgrVersion
 *    selector, it returns a version code in the response parameter. In
 *    this case, a returned value of 3 indicates that the extended Time
 *    Manager is available.
 *    
 *    In most cases, the last few characters in the selector's symbolic
 *    name form a suffix that indicates what type of value you can
 *    expect Gestalt to place in the response parameter. For example,
 *    if the suffix in a Gestalt selector is Size , then Gestalt
 *    returns a size in the response parameter.
 *    
 *    Attr:  A range of 32 bits, the meanings of which are defined by a
 *    list of constants. Bit 0 is the least significant bit of the
 *    SInt32.
 *    Count: A number indicating how many of the indicated type of item
 *    exist.
 *    Size: A size, usually in bytes.
 *    Table: The base address of a table.
 *    Type: An index to a list of feature descriptions.
 *    Version: A version number, which can be either a constant with a
 *    defined meaning or an actual version number, usually stored as
 *    four hexadecimal digits in the low-order word of the return
 *    value. Implied decimal points may separate digits. The value
 *    $0701, for example, returned in response to the
 *    gestaltSystemVersion selector, represents system software version
 *    7.0.1.
 *    
 *    Selectors that have the suffix Attr deserve special attention.
 *    They cause Gestalt to return a bit field that your application
 *    must interpret to determine whether a desired feature is present.
 *    For example, the application-defined sample function
 *    MyGetSoundAttr , defined in Listing 1-2 on page 1-6 , returns a
 *    LongInt that contains the Sound Manager attributes field
 *    retrieved from Gestalt . To determine whether a particular
 *    feature is available, you need to look at the designated bit.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *  
 *  Parameters:
 *    
 *    selector:
 *      The selector to return information for
 *    
 *    response:
 *      On exit, the requested information whose format depends on the
 *      selector specified.
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *}
{$EXTERNALSYM Gestalt}
function Gestalt(selector : OSType; var response : SInt32 ) : OSErr {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl; 
{$IFNDEF CPU64}
{*
 *  ReplaceGestalt()   *** DEPRECATED ***
 *  
 *  Deprecated:
 *    Use NewGestaltValue instead wherever possible.
 *  
 *  Summary:
 *    Replaces the gestalt function associated with a selector.
 *  
 *  Discussion:
 *    The ReplaceGestalt function replaces the selector function
 *    associated with an existing selector code.
 *    
 *    So that your function can call the function previously associated
 *    with the selector, ReplaceGestalt places the address of the old
 *    selector function in the oldGestaltFunction parameter. If
 *    ReplaceGestalt returns an error of any type, then the value of
 *    oldGestaltFunction is undefined.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *  
 *  Parameters:
 *    
 *    selector:
 *      the selector to replace
 *    
 *    gestaltFunction:
 *      a UPP for the new selector function
 *    
 *    oldGestaltFunction:
 *      on exit, a pointer to the UPP of the previously associated with
 *      the specified selector
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.3
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *}
{$EXTERNALSYM ReplaceGestalt}
function ReplaceGestalt(selector : OSType; 
  gestaltFunction : SelectorFunctionUPP; 
  oldGestaltFunction : SelectorFunctionUPP) : OSErr
   {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3}; cdecl;
{*
 *  NewGestalt()   *** DEPRECATED ***
 *  
 *  Deprecated:
 *    Use NewGestaltValue instead wherever possible.
 *  
 *  Summary:
 *    Adds a selector code to those already recognized by Gestalt.
 *  
 *  Discussion:
 *    The NewGestalt function registers a specified selector code with
 *    the Gestalt Manager so that when the Gestalt function is called
 *    with that selector code, the specified selector function is
 *    executed. Before calling NewGestalt, you must define a selector
 *    function callback. See SelectorFunctionProcPtr for a description
 *    of how to define your selector function.
 *    
 *    Registering with the Gestalt Manager is a way for software such
 *    as system extensions to make their presence known to potential
 *    users of their services.
 *    
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *     
 *    A Gestalt selector registered with NewGestalt() can not be
 *    deleted.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *  
 *  Parameters:
 *    
 *    selector:
 *      the selector to create
 *    
 *    gestaltFunction:
 *      a UPP for the new selector function, which Gestalt executes
 *      when it receives the new selector code. See
 *      SelectorFunctionProcPtr for more information on the callback
 *      you need to provide.
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework [32-bit only] but deprecated in 10.3
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *}
{$EXTERNALSYM NewGestalt}
function NewGestalt(selector : OSType; 
  gestaltFunction : SelectorFunctionUPP) : OSErr 
  {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3}; cdecl;
{$ENDIF}
{*
 *  NewGestaltValue()
 *  
 *  Summary:
 *    Adds a selector code to those already recognized by Gestalt.
 *  
 *  Discussion:
 *    The NewGestalt function registers a specified selector code with
 *    the Gestalt Manager so that when the Gestalt function is called
 *    with that selector code, the specified selector function is
 *    executed. Before calling NewGestalt, you must define a selector
 *    function callback. See SelectorFunctionProcPtr for a description
 *    of how to define your selector function.
 *    
 *    Registering with the Gestalt Manager is a way for software such
 *    as system extensions to make their presence known to potential
 *    users of their services.
 *    
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *  
 *  Parameters:
 *    
 *    selector:
 *      the selector to create
 *    
 *    newValue:
 *      the value to return for the new selector code.
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *}
{$EXTERNALSYM NewGestaltValue}
function NewGestaltValue(selector : OSType; const newValue : SInt32) : OSErr  {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{*
 *  ReplaceGestaltValue()
 *  
 *  Summary:
 *    Replaces the value that the function Gestalt returns for a
 *    specified selector code with the value provided to the function.
 *  
 *  Discussion:
 *    You use the function ReplaceGestaltValue to replace an existing
 *    value. You should not call this function to introduce a value
 *    that doesn't already exist; instead call the function
 *    NewGestaltValue.
 *    
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *  
 *  Parameters:
 *    
 *    selector:
 *      the selector to create
 *    
 *    replacementValue:
 *      the new value to return for the new selector code.
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *}
{$EXTERNALSYM ReplaceGestaltValue}
function ReplaceGestaltValue(selector : OSType; const replacementValue : SInt32 ) : OSErr {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{*
 *  SetGestaltValue()
 *  
 *  Summary:
 *    Sets the value the function Gestalt will return for a specified
 *    selector code, installing the selector if it was not already
 *    installed.
 *  
 *  Discussion:
 *    You use SetGestaltValue to establish a value for a selector,
 *    without regard to whether the selector was already installed.
 *     
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them. You cannot use this
 *    function to make information available to another process.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *  
 *  Parameters:
 *    
 *    selector:
 *      the selector to create
 *    
 *    newValue:
 *      the new value to return for the new selector code.
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *}
{$EXTERNALSYM SetGestaltValue}
function SetGestaltValue(selector : OSType; const newValue : SInt32) : OSErr  {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{*
 *  DeleteGestaltValue()
 *  
 *  Summary:
 *    Deletes a Gestalt selector code so that it is no longer
 *    recognized by Gestalt.
 *  
 *  Discussion:
 *    After calling this function, subsequent query or replacement
 *    calls for the selector code will fail as if the selector had
 *    never been installed 
 *    
 *    In Mac OS X, the selector and replacement value are on a
 *    per-context basis. That means they are available only to the
 *    application or other code that installs them.
 *  
 *  Mac OS X threading:
 *    Thread safe since version 10.3
 *  
 *  Parameters:
 *    
 *    selector:
 *      the selector to delete
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *}
{$EXTERNALSYM DeleteGestaltValue}
function DeleteGestaltValue(selector : OSType) : OSErr  {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;

{*
 *  NewSelectorFunctionUPP()
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 *}
{$EXTERNALSYM NewSelectorFunctionUPP}
function NewSelectorFunctionUPP(userRoutine : SelectorFunctionProcPtr) : SelectorFunctionUPP {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{*
 *  DisposeSelectorFunctionUPP()
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 *}
{$EXTERNALSYM DisposeSelectorFunctionUPP}
procedure DisposeSelectorFunctionUPP(userUPP : SelectorFunctionUPP) {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
{*
 *  InvokeSelectorFunctionUPP()
 *  
 *  Availability:
 *    Mac OS X:         in version 10.0 and later in CoreServices.framework
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Non-Carbon CFM:   available as macro/inline
 *}
{$EXTERNALSYM InvokeSelectorFunctionUPP}
function InvokeSelectorFunctionUPP(selector : OSType; var response : SInt32; userUPP : SelectorFunctionUPP) : OSErr {AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER}; cdecl;
 {$ENDIF}

  {$IFDEF LINUX}
  //* UDP socket options */
  {$EXTERNALSYM UDP_CORK}
  UDP_CORK	= 1;	//* Never send partially complete segments */
  {$EXTERNALSYM UDP_ENCAP}
  UDP_ENCAP	= 100;	//* Set the socket to accept encapsulated packets */

//* UDP encapsulation types */
  {$EXTERNALSYM UDP_ENCAP_ESPINUDP_NON_IKE}
  UDP_ENCAP_ESPINUDP_NON_IKE =	1; //* draft-ietf-ipsec-nat-t-ike-00/01 */
    {$EXTERNALSYM UDP_ENCAP_ESPINUDP}
  UDP_ENCAP_ESPINUDP	= 2; //* draft-ietf-ipsec-udp-encaps-06 */
  {$ENDIF}

implementation
  {$IFDEF DARWIN}

{$DEFINE USE_CARBONCORELIB}
{/$DEFINE USE_CORESERVICESLIB}
{$IFDEF USE_CARBONCORELIB}
  {$UNDEF USE_CORESERVICESLIB}
{$ENDIF}

function  TCPOPT_CC_HDR(const ccopt : Integer) : Integer; inline;
begin
    Result := (TCPOPT_NOP shl 24) or
      (TCPOPT_NOP shl 16) or
      (ccopt shl 8) or
      TCPOLEN_CC;
end;

procedure SysError; external {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
{$IFDEF USE_CARBONCORELIB}CarbonCoreLib{$ENDIF}  name '_SysError';
function Gestalt; external   {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
{$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_Gestalt';
    {$IFNDEF CPU64}
function ReplaceGestalt; external {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
{$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_ReplaceGestalt';
function NewGestalt; external {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
{$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_NewGestalt';
    {$ENDIF}
function NewGestaltValue; external {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
  {$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_NewGestaltValue';
function ReplaceGestaltValue; external {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
  {$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_ReplaceGestaltValue';
function SetGestaltValue; external {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
  {$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_SetGestaltValue';
function DeleteGestaltValue; external  {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
  {$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_DeleteGestaltValue';
function NewSelectorFunctionUPP; external  {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
  {$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_NewSelectorFunctionUPP';
procedure DisposeSelectorFunctionUPP; external  {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
  {$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF}  name '_DisposeSelectorFunctionUPP';
function InvokeSelectorFunctionUPP; external {$IFDEF USE_CORESERVICESLIB}CoreServices{$ENDIF}
  {$IFDEF USE_CARBONCORELIB}CarbonCoreLib {$ENDIF} name '_InvokeSelectorFunctionUPP';
   
{$ENDIF}

end.
