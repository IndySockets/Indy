{
  $Project$
  $Workfile$
  $Revision$
  $DateUTC$
  $Id$

  This file is part of the Indy (Internet Direct) project, and is offered
  under the dual-licensing agreement described on the Indy website.
  (http://www.indyproject.org/)

  Copyright:
   (c) 1993-2005, Chad Z. Hower and the Indy Pit Crew. All rights reserved.
}
{
  $Log$
}
{
  Rev 1.146    3/23/2005 5:16:56 AM  JPMugaas
  Should compile.

  Rev 1.145    3/14/05 11:28:50 AM  RLebeau
  Bug fix for CommandSIZE() not checking the FTPFileSystem property.

  Updated to reflect changes in TIdReply.NumericCode handling.

  Rev 1.144    3/5/2005 3:33:58 PM  JPMugaas
  Fix for some compiler warnings having to do with TStream.Read being platform
  specific.  This was fixed by changing the Compressor API to use TIdStreamVCL
  instead of TStream.  I also made appropriate adjustments to other units for
  this.

  Rev 1.143    11/22/2004 8:29:20 PM  JPMugaas
  Fix for a compiler warning.

  Rev 1.142    11/22/2004 7:49:36 PM  JPMugaas
  You now can access help before you are logged in.   This is done to conform
  to RFC 959.

  Rev 1.141    2004.10.27 9:17:48 AM  czhower
  For TIdStrings

  Rev 1.140    10/26/2004 9:40:42 PM  JPMugaas
  Updated ref.

    Rev 1.139    9/15/2004 5:01:00 PM  DSiders
  Added localization comments.

  Rev 1.138    2004.08.13 11:03:22  czhower
  Removed unused var.

  Rev 1.137    7/29/2004 1:33:10 AM  JPMugaas
  Reordered AUTH command values for a new property under development.  This
  should make things more logical.

    Rev 1.136    7/18/2004 3:00:42 PM  DSiders
  Added localization comments.

  Rev 1.135    7/15/2004 1:33:00 AM  JPMugaas
  Bug fix for error 105.   I fixed this by changing data channel command
  processing.  If the command is not ABOR or STAT, the command is put into a
  FIFO queue.  After the data channel operation is completed, the commands from
  the FIFO queue are processed.    I have tested FlashFXP 3.0 RC4 and it does
  worki as expected.  The behavior is also the same as what NcFTPD does with a
  NOOP being sent during a data transfer.

  This may also help with FTP command pipelining as proposed by:
  http://cr.yp.to/ftp/pipelining.html

  Note that we can not use the regular command handler framework for  data
  channel commands because STAT and ABOR need to be handled IMMEDIATELY.

  Rev 1.134    7/13/04 9:08:10 PM  RLebeau
  Renamed OnPASV event to OnPASVBeforeBind and added new OnPASVReply event

  Rev 1.133    7/13/04 8:13:56 PM  RLebeau
  Various changed for DefaultDataPort handling

  Rev 1.132    7/13/2004 3:34:12 AM  JPMugaas
  CCC command and a few other minor modifications to comply with
  http://www.ietf.org/internet-drafts/draft-murray-auth-ftp-ssl-14.txt .

  I also fixed a few minor bugs in the help and a problem with some error
  replies sending an extra 200 after a 5xxx code messing up some clients.

  I also expanded the Security options to selectively disable CCC per user.
  Some administrators may want to do this for security reasons.

  Rev 1.131    7/12/2004 11:46:44 PM  JPMugaas
  Improvement in OPTS MODE Z handling.  It will give an error if there's only
  one param.  Params must be in pairs.  If no valid parameters are present, we
  give an error.

  Rev 1.130    07/07/2004 17:34:38  ANeillans
  Corrected compile bug.
  Line 6026,
            if PosInStrArray(IntToStr(LNoVal),STATES,False)>-1 then
  Function expected a string, not an integer.

    Rev 1.129    7/6/2004 4:52:16 PM  DSiders
  Corrected spelling of Challenge in properties, methods, types.

  Rev 1.128    6/29/2004 4:09:04 PM  JPMugaas
  OPTS MODE Z now supported as per draft-preston-ftpext-deflate-02.txt.  This
  should keep FTP Voyager 11 happy.

  Rev 1.127    6/28/2004 7:23:20 PM  JPMugaas
  Bugfix.  An invalid site command would cause no reply to be given.  Now a
  syntax is given in such cases.

  Rev 1.126    6/27/2004 1:45:30 AM  JPMugaas
  Can now optionally support LastAccessTime like Smartftp's FTP Server could.
  I also made the MLST listing object and parser support this as well.

  Rev 1.125    6/17/2004 3:56:28 PM  JPMugaas
  Fix for AV that happens after data channel operation.

  Rev 1.124    6/16/2004 2:29:32 PM  JPMugaas
  Removed direct access to a FConnection.  We now use the Connection property
  in the TIdContext.

  Rev 1.123    6/12/2004 9:05:52 AM  JPMugaas
  Telnet control sequences should now work during a data transfer.
  Removed HandleTelnetSequences.  It was part of a crude workaround which had
  never works and the matter was fixed in another way.
  OnCustomDir should now work if the DirStyle is custom.

    Rev 1.122    6/11/2004 9:35:12 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.121    2004.05.20 11:37:26 AM  czhower
  IdStreamVCL

  Rev 1.120    5/16/04 5:30:26 PM  RLebeau
  Added setter methods to the ReplyUnknownSITECommand and SITECommands
  properties

  Added GetRepliesClass() overrides

  Rev 1.119    5/1/2004 1:52:20 PM  JPMugaas
  Updated for PeekBytes API change.

  Rev 1.118    4/8/2004 12:19:08 PM  JPMugaas
  Should work with new code.

  Rev 1.117    3/3/2004 6:34:46 PM  JPMugaas
  Improved help system.
  Some manditory (RFC 1123 were rutning syntax errors instead of not
  implemented.
  Add some mention of some other RFC 2228 commands for completness.  Not that
  there are not supported or implemented.

  Rev 1.116    3/3/2004 6:02:14 AM  JPMugaas
  Command descriptions.

  Rev 1.115    3/2/2004 8:13:28 AM  JPMugaas
  Fixup for minor API change.

  Rev 1.113    3/1/2004 12:41:40 PM  JPMugaas
  Should compile with new code.

  Rev 1.112    2/29/2004 6:02:38 PM  JPMugaas
  Improved bug fix for problem with Telnet sequences not being handled properly
  in the FTP server.  Litteral CR and LF are now handled properly (according to
  the Telnet Specification).

  Rev 1.111    2/25/2004 3:27:04 PM  JPMugaas
  STAT -l now works like a LIST command except that it returns output on the
  control channel.  This is for consistancy with microsoft FTP Service,
  RaidenFTPD, and a few other servers.  FlashFXP can take advantage of this
  feature as well to gain some efficiency.  Note that I do not do not advocate
  doing this on the FTP client because some servers will act differently than
  you would assume.  I may see about possible options for using STAT -l but I
  can NOT promise anything.

  Rev 1.110    2/17/2004 6:37:28 PM  JPMugaas
  OnPASV event added for people needing to change the IP address or port value
  in commands such as PASV.  This should only be done if you have a compelling
  reason to do it.

  Note that the IP address parameter can NOT work with EPSV and SPSV because
  only the port number is returned.  The IP address is presumed to be the same
  one that the host is connecting to.

  Rev 1.109    2/17/2004 12:26:06 PM  JPMugaas
  The client now supports MODE Z (deflate) uploads and downloads as specified
  by http://www.ietf.org/internet-drafts/draft-preston-ftpext-deflate-00.txt

  Rev 1.108    2/15/2004 12:11:04 AM  JPMugaas
  SPSV support.  SPSV is an old propoal to help FTP support IPv6.  This was
  mentioned at:  http://cr.yp.to/ftp/retr.html and is supported by PureFTPD.

  Rev 1.107    2/14/2004 10:00:40 PM  JPMugaas
  Both upload and download should now work in MODE Z.  Dir already worked
  properly.

  Rev 1.106    2/12/2004 11:34:38 PM  JPMugaas
  FTP Deflate preliminary support.  Work still needs to be done for upload and
  downloading.

  Rev 1.105    2004.02.08 3:08:10 PM  czhower
  .Net fix.

  Rev 1.104    2004.02.07 5:03:10 PM  czhower
  .net fixes.

  Rev 1.103    2004.02.03 5:45:54 PM  czhower
  Name changes

  Rev 1.102    1/29/2004 3:15:52 PM  JPMugaas
  Fix for P@SW in InitCommandHandlers used "PASV" isntead of "P@SW".  Fixed.

  Rev 1.101    1/22/2004 8:29:06 AM  JPMugaas
  Removed Ansi*.

  Rev 1.100    1/21/2004 2:34:38 PM  JPMugaas
  Fixed SITE ZONE reply.
  InitComponent

  Rev 1.99    1/19/2004 4:37:02 AM  JPMugaas
  MinutesFromGMT was moved to IdFTPCommon because the client now uses it.

  Rev 1.98    1/18/2004 9:19:08 AM  JPMugaas
  P@SW now supported.

  This is necessary as some routers that replace a PASV with a P@SW
  as part of a misguided attempt to add a feature.
  A router would do a replacement so a client would think that
  PASV wasn't supported and then the client would do a PORT command
  instead.  That doesn't happen so this just caused the client not to work.

  See:  http://www.gbnetwork.co.uk/smcftpd/

  Rev 1.97    1/17/2004 7:40:08 PM  JPMugaas
  MLSD added to FEAT list for consistancy with other FTP servers.
  Fixed bug that would cause FXP transfers to fail when receiving a PASV.

  Rev 1.96    1/16/2004 12:25:06 AM  JPMugaas
  Fixes for MTDM set modified time.

  Rev 1.94    1/15/2004 2:36:50 AM  JPMugaas
  XMD5 command support.
  SITE ZONE command added for FTP Voyager.
  Minor adjustment in AUTH line in the FEAT response to indicate that we
  support the AUTH TLS, AUTH TLS-C, AUTH SSL, and AUTH TLS-P explicit TLS
  commands.

  Rev 1.93    1/14/2004 4:11:30 PM  JPMugaas
  CPSV support added.  This is like PASV but indicates that we use ssl_connect
  instead of ssl_accept.  CPSV is used in FlashFXP for secure site-to-site file
  transfers.

  Rev 1.92    1/14/2004 12:24:06 PM  JPMugaas
  SSCN Support for secure Site to Site Transfers using SSL.

  SSCN is defined at:

  http://www.raidenftpd.com/kb/kb000000037.htm

  Rev 1.91    1/13/2004 6:30:38 AM  JPMugaas
  Numerous bug fixes.
  Now supports XCWD (a predicessor to CWD).
  Command Reply for unknown command works again.
  Started putting some formatting into common routines.
  CuteFTP goes bonkers with a "215 " reply to SYST command.  Now indicate that
  SYST isn't implemented instead of giving that "215 ".  Note that a
  "CustomSystID" should be provided when DirFormat is ftpdfCustom.
  If DirFormat is ftpdfCustom and OnListDirectory is provided; MLST, MLSD, and
  OPTS MLSD will be DISABLED.  OnListDirectory is used in the custom format for
  structed standardized output with the MLSD and MLST commands.
  A not implemented is now given for some commands.

  Rev 1.90    1/5/2004 11:53:00 PM  JPMugaas
  Some messages moved to resource strings.  Minor tweeks.  EIdException no
  longer raised.

  Rev 1.88    1/4/2004 3:51:32 PM  JPMugaas
  Fixed a CWD bug.  The parameter was being ignored.

  Rev 1.87    1/3/2004 8:05:18 PM  JPMugaas
  Bug fix:  Sometimes, replies will appear twice due to the way functionality
  was enherited.

  Rev 1.86    1/3/2004 5:37:56 PM  JPMugaas
  Changes from Bas:

  added function GetReplyClass, this function returns the class of reply this
  server class uses, this is because in dotnet there can be no code before the
  inherited in the constructor ( that is used mow to determine the reply class )
   
  changed System.Delete to IdDelete (in coreglobal) because System.Delete is
  not in dotnet
   
  SplitLines is not enabled in dotnet yet, so i made it a todo, make sure to
  enable it and remove the todo if you check it in 
   

  Rev 1.85    1/2/2004 1:02:08 AM  JPMugaas
  Made comment about why the SYST descriptor is determined the way it is.

  Rev 1.84    1/2/2004 12:55:32 AM  JPMugaas
  Now compiles.  Removed the EmulateSystem property.  Replaced one part with
  the DirFormat property.

  Rev 1.83    1/1/2004 10:55:10 PM  JPMugaas
  Remy Lebeau found a bug with path processing in the FTP server.  I was
  passing an emptry Result string instead of APath in FTPNormalize.

  Rev 1.77    10/11/2003 10:17:28 AM  JPMugaas
  Checked in a more recent version which  should be worked on instead.

  Rev 1.75    9/19/2003 12:50:18 PM  JPMugaas
  Started attempt to get the server to compile.

  Rev 1.74    9/18/2003 10:20:06 AM  JPMugaas
  Updated for new API.

  Rev 1.73    8/24/2003 06:50:02 PM  JPMugaas
  API Change in the FileSystem component so that a thread is passed instead of
  some data from the thread.  This should also make the API's easier to manage
  than before and provide more flexibility for developers writing their own
  file system components.

  Rev 1.72    7/13/2003 7:56:00 PM  SPerry
  fixed problem with commandhandlers

  Rev 1.69    6/17/2003 09:30:20 PM  JPMugaas
  Fixed an AV with the ALLO command if no parameters were passed.  Stated in
  HELP command that we don't support some old FTP E-Mail commands from RFC 765
  which have not been in use for many years.  We now give a reply saying those
  aren't implemented to be consistant with some Unix FTP deamons.

  Rev 1.68    6/17/2003 03:16:36 PM  JPMugaas
  I redid the help and site help implementations so that they list commands.
  It did mean loosing the FHelpText TIdStrings property but this should be more
  consistant with common practices.

  Rev 1.67    6/17/2003 09:07:40 AM  JPMugaas
  Improved SITE HELP handling.

  Rev 1.65    5/26/2003 12:22:50 PM  JPMugaas

  Rev 1.64    5/25/2003 03:54:28 AM  JPMugaas

    Rev 1.63    5/21/2003 3:59:32 PM  BGooijen
  removed with in InitializeCommandHandlers, and changed exception replies

  Rev 1.62    5/21/2003 09:29:40 AM  JPMugaas

  Rev 1.61    5/19/2003 08:11:44 PM  JPMugaas
  Now should compile properly with new code in Core.

  Rev 1.60    4/10/2003 02:54:14 PM  JPMugaas
  Improvement for FTP STOU command.  Unique filename now uses
  IdGlobal.GetUniqueFileName instead of Rand.  I also fixed GetUniqueFileName
  so that it can accept an empty path specification.

    Rev 1.59    3/30/2003 12:18:38 AM  BGooijen
  bug fix + ssl one data channel fixed

    Rev 1.58    3/24/2003 11:08:42 PM  BGooijen
  'transfer'-commands now block, until the transfer is done/aborted.
  this made it possible to send the reply after the transfer in the
  control-thread

  Rev 1.57    3/16/2003 06:11:18 PM  JPMugaas
  Server now derrives from a TLS framework.

  Rev 1.56    3/14/2003 11:33:46 PM  JPMugaas

    Rev 1.55    3/14/2003 10:44:38 PM  BGooijen
  Removed warnings, changed StartSSL to PassThrough:=false;

    Rev 1.54    3/14/2003 10:00:24 PM  BGooijen
  Removed TIdServerIOHandlerSSLBase.PeerPassthrough, the ssl is now enabled in
  the server-protocol-files

  Rev 1.53    3/13/2003 05:21:18 PM  JPMugaas
  Bas's bug fix.  There was a wrong typecast.

    Rev 1.52    3/13/2003 8:57:30 PM  BGooijen
  changed TIdSSLIOHandlerSocketBase to TIdIOHandlerSocket in
  TIdDataChannelContext.SetupDataChannel

  Rev 1.51    3/13/2003 09:49:06 AM  JPMugaas
  Now uses an abstract SSL base class instead of OpenSSL so 3rd-party vendors
  can plug-in their products.

  Rev 1.50    3/13/2003 06:11:54 AM  JPMugaas
  Updated with Bas's change.

  Rev 1.49    3/10/2003 09:12:46 PM  JPMugaas
  Most command handlers now use Do methods for consistancy with other Indy code.

  Rev 1.48    3/10/2003 05:09:22 PM  JPMugaas
  MLST now works as expected with the file system.  Note that the MLST means
  simply to give information about an item instead of its contents.
  GetRealFileName in IdFTPFileSystem now can accept the wildcard *.
  When doing dirs in EPLF, only information about a directory is retruned if it
  is specified.

  Rev 1.47    3/9/2003 02:11:34 PM  JPMugaas
  Removed server support for MODE B and MODE C.  It turns out that we do not
  support those modes properly.  We only implemented Stream mode.  We now
  simply return a 504 for modes we don't support instead of a 200 okay.  This
  was throwing off Opera 7.02.

  Rev 1.46    3/6/2003 11:00:12 AM  JPMugaas
  Now handles the MFMT command and the MFCT (Modified Date fact) command.

  Rev 1.45    3/6/2003 08:26:28 AM  JPMugaas
  Bug fixes.

  FTP COMB command can now work in the FTPFileSystem component.

  Rev 1.44    3/5/2003 03:28:16 PM  JPMugaas
  MD5, MMD5, and XCRC are now supported in the Virtual File System.

  Rev 1.43    3/5/2003 11:46:38 AM  JPMugaas
  Rename now works in Virtual FileSystem.

  Rev 1.42    3/2/2003 04:54:34 PM  JPMugaas
  Now does recursive dir lists with the Virtual File System layer as well as
  honors other switches.

  Rev 1.41    3/2/2003 02:18:32 PM  JPMugaas
  Bug fix for where a reply was not returned when using a file system component.

  Rev 1.40    3/2/2003 02:23:38 AM  JPMugaas
  fix for problem with pathes in the virtual file system.

  Rev 1.39    2/24/2003 08:50:44 PM  JPMugaas

  Rev 1.38    2/24/2003 07:56:22 PM  JPMugaas
  Now uses /bin/ls strings.

  Rev 1.37    2/24/2003 07:21:10 AM  JPMugaas
  FTP Server now strips out any -R switches when emulating EPLF servers.
  Recursive lists aren't supported with EPLF.

  Rev 1.36    2/21/2003 06:54:10 PM  JPMugaas
  The FTP list processing has been restructured so that Directory output is not
  done by IdFTPList.  This now also uses the IdFTPListParserBase for parsing so
  that the code is more scalable.

  Rev 1.35    2/15/2003 10:29:42 AM  JPMugaas
  Added support for some Unix specific facts with MLSD and MLST.

  Rev 1.34    2/14/2003 05:42:08 PM  JPMugaas
  Moved everything from IdFTPUtils to IdFTPCommon at Kudzu's suggestion.

  Rev 1.33    2/14/2003 11:57:48 AM  JPMugaas
  Updated for new API.  Made sure that there were no calls to a function we
  removed.

  Rev 1.32    2/14/2003 10:45:18 AM  JPMugaas
  Updated for minor API change.

  Rev 1.30    2/13/2003 01:28:08 AM  JPMugaas
  MLSD and MLST should now work better.

  Rev 1.29    2/12/2003 12:30:56 PM  JPMugaas
  Now honors parameters with the NLIST command.

    Rev 1.28    2/5/2003 10:30:04 PM  BGooijen
  Re-enabled ssl-support

  Rev 1.27    2/4/2003 05:31:40 PM  JPMugaas
  Added ASwitches parameter to the ListEvent so we can pass parameters such as
  "-R" in addition to the standard path.

  Rev 1.26    2/3/2003 11:01:50 AM  JPMugaas
  Moved list export to IdFTPList.

  Rev 1.25    1/31/2003 01:59:18 PM  JPMugaas
  Security options are now reenabled.

  Rev 1.24    1/31/2003 01:19:00 PM  JPMugaas
  Now passes the ControlConnection context instead of the ControlConnection
  object itself.

  Rev 1.23    1/31/2003 06:34:52 AM  JPMugaas
  Now SYST command works as expected.

  Rev 1.22    1/31/2003 04:23:24 AM  JPMugaas
  FTP Server security options can be set for individual users and the server
  will now use the Context's security options.  THis should permit more
  flexibility in security.

  Rev 1.21    1/30/2003 03:31:06 AM  JPMugaas
  Now should also properly handle exceptions in the MLSx commands.

  Rev 1.20    1/30/2003 02:55:26 AM  JPMugaas
  Now properly handles exceptions in the ListEvent for the STAT and LIST
  commands.

  Rev 1.19    1/29/2003 01:17:18 AM  JPMugaas
  Exception handling should mostly work as it should.  There's still a problem
  with the list.

  Rev 1.18    1/28/2003 02:27:26 AM  JPMugaas
  Improved exception handling in several events to try to be more consistant.
  Now can optionally hide the exception message when giving an error reply to
  the user.  This should prevent some inadvertant information about a computer
  going to a troublemaker.

  Rev 1.17    1/27/2003 05:03:16 AM  JPMugaas
  Now a developer can provide status information to a user with the STAT
  command if they want.  We format the reply in a standard manner for them.
  They just provide the information.

  Rev 1.16    1/27/2003 02:13:30 AM  JPMugaas
  Added more security options as suggested by:
  http://www.sans.org/rr/infowar/fingerprint.php to help slow down an attack.
  You can optionally disable both SYST and the STAT commands.  Trouble makers
  can use those to help determine server type and then use known flaws to
  compromise it.  Note that these do not completely prevent attacks and should
  not lull administrators into a false sense of security.

  Rev 1.15    1/27/2003 12:32:08 AM  JPMugaas
  Now can optionally return the identifier for the real operating system.  By
  default, this property is false for security reasons.

  Rev 1.14    1/26/2003 11:59:16 PM  JPMugaas
  SystemDescriptor behavior change as well as SYST command change.
  SystemDescriptor no longer needs an OS type as the first word.  That is now
  handled by the SYST commandhandler to better comply with RFC 959.

  Rev 1.13    1/25/2003 02:00:58 AM  JPMugaas
  MMD5 (for multiple MD5 checksums) is now supported.
  Refined MD5 command support slgihtly.

  This is based on:
  http://www.ietf.org/internet-drafts/draft-twine-ftpmd5-00.txt

    Rev 1.12    1/24/2003 6:07:24 PM  BGooijen
  Changed TIdDataChannelThread to TIdDataChannelContext

    Rev 1.11    1/23/2003 9:06:26 PM  BGooijen
  changed the CommandAbor

    Rev 1.10    1/23/2003 10:39:38 AM  BGooijen
  TIdDataChannelContext.FServer was never assigned

    Rev 1.9    1/20/2003 1:15:40 PM  BGooijen
  Changed to TIdTCPServer / TIdCmdTCPServer classes

  Rev 1.8    1/17/2003 06:21:02 PM  JPMugaas
  Now works with new design.

  Rev 1.7    1/17/2003 05:28:42 PM  JPMugaas

  Rev 1.6    1-9-2003 14:45:30  BGooijen
  Added ABOR command with telnet escape characters
  Fixed hanging of ABOR command
  STOR and STOU now use REST-position
  ABOR now returns 226 instead of 200

  Rev 1.5    1-9-2003 14:35:52  BGooijen
  changed TIdFTPServerContext(ASender.Context.Thread) to
  TIdFTPServerContext(ASender.Context) on some places

  Rev 1.4    1/9/2003 06:08:10 AM  JPMugaas
  Updated to be based on IdContext.

  Rev 1.3    1-1-2003 20:13:06  BGooijen
  Changed to support the new TIdContext class

  Rev 1.2    12-15-2002 21:15:46  BGooijen
  IFDEF-ed all SSL code, the IFDEF-s are removed as soon as the SSL works again.

  Rev 1.1    11/14/2002 02:55:58 PM  JPMugaas
  FEAT and MLST now completely use the RFC Reply objects instead of
  Connection.WriteLn.  The Connection.WriteLn was a workaround for a deficit in
  the original RFC Reply object.  The workaround is no longer needed.
}

unit IdFTPServer;

{
 Original Author: Sergio Perry
 Date: 04/21/2001
 Fixes and modifications: Doychin Bondzhev
 Date: 08/10/2001
 Further Extensive changes by Chad Z. Hower (Kudzu)
 EPSV/EPRT support for IPv6 by Johannes Berg

  TODO:
    both EPSV and EPRT only allow data connections that have the same
       protocol as the control connection, because the ftp server could be
       used in a network only supporting one of them

TODO:
    Change events to use DoXXXX
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers, IdCommandHandlers, IdGlobal, IdContext, IdException,
  IdExplicitTLSClientServerBase, IdFTPBaseFileSystem, IdFTPCommon,
  IdBaseComponent, IdFTPList, IdFTPListOutput, IdFTPServerContextBase,
  IdReply, IdReplyFTP, IdReplyRFC, IdScheduler, IdServerIOHandler,
  IdTCPConnection, IdCmdTCPServer,  IdTCPServer, IdThread, IdUserAccounts,
  IdYarn, IdZLibCompressorBase, SysUtils;

type
  TIdFTPDirFormat = (ftpdfDOS, ftpdfUnix, ftpdfEPLF, ftpdfCustom, ftpdfOSDependent);
  TIdFTPPathProcessing = (ftppDOS, ftppUnix, ftpOSDependent, ftppCustom);
  TIdFTPOperation = (ftpRetr, ftpStor);

  TIdMLSDAttr = (mlsdUniqueID,
    mlsdPerms,
    mlsdUnixModes,
    mlsdUnixOwner,
    mlsdUnixGroup,
    mlsdFileCreationTime,
    mlsdFileLastAccessTime,
    mlsdWin32Attributes,
    mlsdWin32DriveType,
    mlstWin32DriveLabel);

  TIdMLSDAttrs = set of TIdMLSDAttr;

const
  DEF_DIRFORMAT = ftpdfUnix; //ftpdfOSDependent;
  Id_DEF_AllowAnon  = False;
  Id_DEF_PassStrictCheck = True;
  DEF_FTP_IMPLICIT_FTP = False;

  DEF_FTP_HIDE_INVALID_USER = True;
  DEF_FTP_PASSWORDATTEMPTS = 3;
  DEF_FTP_INVALIDPASS_DELAY = 3000;  //3 seconds
  DEF_FTP_PASV_SAME_IP = True;
  DEF_FTP_PORT_SAME_IP = True;
  DEF_FTP_NO_RESERVED_PORTS = True;
  DEF_FTP_BLOCK_ALL_PORTS = False;
  DEF_FTP_DISABLE_SYST = False;
  DEF_FTP_DISABLE_STAT = False;
  DEF_FTP_PERMIT_CCC = False;
  DEF_FTP_REPORT_EX_MSG = False;
  DEF_PASV_BOUND_MIN = 0;
  DEF_PASV_BOUND_MAX = 0;
  DEF_PATHPROCESSING = ftpOSDependent;

  {Do not change these as it could break some clients}
  SYST_ID_UNIX = 'UNIX Type: L8';  {Do not translate}
  SYST_ID_NT = 'Windows_NT';   {Do not translate}

const AAlwaysValidOpts : array [0..2] of string =
  ('SIZE', 'TYPE', 'MODIFY'); {Do not translate}

type
  TIdFTPServerContext = class;
  //The final parameter could've been one item but I decided against that
  //because occaisionally, you might have a situation where you need to specify
  //the "type" fact to be several different things.
  //
  //http://www.ietf.org/internet-drafts/draft-ietf-ftpext-mlst-16.txt
  TIdOnMLST = procedure(ASender : TIdFTPServerContext; const APath: TIdFTPFileName;
    ADirectoryListing: TIdFTPListOutput) of object;
  //data port binding events
  TOnDataPortBind = procedure(ASender : TIdFTPServerContext) of object;
  //note that the CHMOD value is now a VAR because we also want to support a "MFF UNIX.mode="
  //to do the same thing as a chmod.  MFF is to "Modify a file fact".
  TOnSetATTRIB = procedure(ASender: TIdFTPServerContext; var VAttr : UInt32; const AFileName : TIdFTPFileName; var VAUth : Boolean) of object;
  //Note that VAuth : Boolean is used because you may want to deny permission for
  //users to change their Unix permissions or UMASK - which is done in anonymous FTP
  TOnSiteUMASK = procedure(ASender: TIdFTPServerContext; var VUMASK : Integer; var VAUth : Boolean) of object;
  //note that the CHMOD value is now a VAR because we also want to support a "MFF UNIX.mode="
  //to do the same thing as a chmod.  MFF is to "Modify a file fact".
  TOnSiteCHMOD = procedure(ASender: TIdFTPServerContext; var APermissions : Integer; const AFileName : TIdFTPFileName; var VAUth : Boolean) of object;
  //chown as an option can specify group
  TOnSiteCHOWN = procedure(ASender: TIdFTPServerContext; var AOwner, AGroup : String; const AFileName : TIdFTPFileName; var VAUth : Boolean) of object;

  TOnSiteCHGRP = procedure(ASender: TIdFTPServerContext; var AGroup : String; const AFileName : TIdFTPFileName; var VAUth : Boolean) of object;

  TOnCustomPathProcess = procedure(ASender: TIdFTPServerContext; var VPath : TIdFTPFileName) of object;
  //
  TOnFTPUserLoginEvent = procedure(ASender: TIdFTPServerContext; const AUsername, APassword: string;
    var AAuthenticated: Boolean) of object;
  TOnFTPUserAccountEvent = procedure(ASender : TIdFTPServerContext; const AUsername, APassword,AAcount: string; var AAuthenticated: Boolean) of object;

  TOnAfterUserLoginEvent = procedure(ASender: TIdFTPServerContext) of object;

  TOnDirectoryEvent = procedure(ASender: TIdFTPServerContext; var VDirectory: TIdFTPFileName) of object;
  TOnGetFileSizeEvent = procedure(ASender: TIdFTPServerContext; const AFilename: TIdFTPFileName;
    var VFileSize: Int64) of object;
  TOnGetFileDateEvent = procedure(ASender: TIdFTPServerContext; const AFilename: TIdFTPFileName;
    var VFileDate: TDateTime) of object;
    //note we have to use a switches parameter because LIST in practice can have both a path and some
    //some switches such as -R for recursive.
  TOnListDirectoryEvent = procedure(ASender: TIdFTPServerContext; const APath: TIdFTPFileName;
    ADirectoryListing: TIdFTPListOutput; const ACmd : String; const ASwitches : String) of object;
  TOnCustomListDirectoryEvent = procedure(ASender: TIdFTPServerContext; const APath: TIdFTPFileName;
    ADirectoryListing: TStrings; const ACmd : String; const ASwitches : String) of object;
  TOnFileEvent = procedure(ASender: TIdFTPServerContext; const APathName: TIdFTPFileName) of object;
  TOnCheckFileEvent = procedure(ASender: TIdFTPServerContext; const APathName: TIdFTPFileName; var VExist : Boolean) of object;
  TOnRenameFileEvent = procedure(ASender: TIdFTPServerContext; const ARenameFromFile, ARenameToFile: TIdFTPFileName) of object;
  TOnRetrieveFileEvent = procedure(ASender: TIdFTPServerContext; const AFileName: TIdFTPFileName;
    var VStream: TStream) of object;
  TOnStoreFileEvent = procedure(ASender: TIdFTPServerContext; const AFileName: TIdFTPFileName;
    AAppend: Boolean; var VStream: TStream) of object;
  TOnCombineFiles = procedure(ASender: TIdFTPServerContext; const ATargetFileName: TIdFTPFileName;
    AParts : TStrings) of object;
  TOnCheckSumFile = procedure(ASender: TIdFTPServerContext; const AFileName : TIdFTPFileName; var VStream : TStream) of object;
  TOnCacheChecksum = procedure(ASender: TIdFTPServerContext; const AFileName : TIdFTPFileName; var VCheckSum : String) of object;
  TOnVerifyChecksum = procedure(ASender: TIdFTPServerContext; const AFileName : TIdFTPFileName; const ACheckSum : String) of object;
  TOnSetFileDateEvent = procedure(ASender: TIdFTPServerContext; const AFileName : TIdFTPFileName; var AFileTime : TDateTime) of object;
  TOnHostCheck = procedure(ASender:TIdFTPServerContext; const AHost : String; var VAccepted : Boolean) of object;
  //This is just to be efficient with the SITE UTIME command and for setting the windows.lastaccesstime fact
  TOnSiteUTIME = procedure(ASender: TIdFTPServerContext; const AFileName : TIdFTPFileName;
    var VLastAccessTime, VLastModTime, VCreateDate : TDateTime;
    var VAUth : Boolean) of object;

  EIdFTPServerException = class(EIdException);
  EIdFTPServerNoOnListDirectory = class(EIdFTPServerException);
  EIdFTPImplicitTLSRequiresSSL = class(EIdFTPServerException);
  EIdFTPBoundPortMaxGreater = class(EIdFTPServerException);
  EIdFTPBoundPortMinLess = class(EIdFTPServerException);
  EIdFTPCannotBeNegative = class(EIdFTPServerException);

  //we don't parse CLNT parameters as they might be freeform for all we know
  TIdOnClientID = procedure(ASender: TIdFTPServerContext; const AID : String) of object;
  TIdOnFTPStatEvent = procedure(ASender: TIdFTPServerContext; AStatusInfo : TStrings) of object;
  TIdOnBanner = procedure(ASender: TIdFTPServerContext; AGreeting : TIdReply) of object;
  //This is for EPSV and PASV support - do not change the values unless you
  //have an extremely compelling reason to do so.  This even is ONLY for those compelling case.
  TIdOnPASV = procedure(ASender: TIdFTPServerContext; var VIP : String;
    var VPort : TIdPort; const AIPVer : TIdIPVersion) of object;
  TIdOnPASVRange = procedure(ASender: TIdFTPServerContext; var VIP : String;
    var VPortMin, VPortMax : TIdPort; const AIPVer : TIdIPVersion) of object;
  TIdOnDirSizeInfo = procedure(ASender : TIdFTPServerContext;
    const APathName : TIdFTPFileName;
    var VIsAFile : Boolean; var VSpace : Int64) of object;

  TIdFTPServer = class;

  TIdFTPSecurityOptions = class(TPersistent)
  protected
    // RFC 2577 Recommends these
    // Note that the current code already hides user ID's by
    // only authenticating after the password
    FPasswordAttempts : UInt32;
    FInvalidPassDelay : UInt32;
    // http://cr.yp.to/ftp/security.html Recommends these
    FRequirePASVFromSameIP : Boolean;
    FRequirePORTFromSameIP : Boolean;
    FNoReservedRangePORT : Boolean;
    FBlockAllPORTTransfers : Boolean;
    FDisableSYSTCommand : Boolean;
    FDisableSTATCommand : Boolean;
    FPermitCCC : Boolean;
  public
    constructor Create; virtual;
    procedure Assign(Source: TPersistent); override;
  published
    //limit login attempts - some hackers will try guessing passwords from a dictionary
    property PasswordAttempts : UInt32 read FPasswordAttempts write FPasswordAttempts
      default DEF_FTP_PASSWORDATTEMPTS;
    //should slow-down a password guessing attack - note those dictionaries
    property InvalidPassDelay : UInt32 read FInvalidPassDelay write FInvalidPassDelay
      default DEF_FTP_INVALIDPASS_DELAY;
    //client IP Address is the only one that we will accept a PASV
    //transfer from
    //http://cr.yp.to/ftp/security.html
    property RequirePASVFromSameIP : Boolean read FRequirePASVFromSameIP write FRequirePASVFromSameIP
      default DEF_FTP_PASV_SAME_IP;
    //Accept port transfers from the same IP address as the client -
    //should prevent bounce attacks
    property RequirePORTFromSameIP : Boolean read FRequirePORTFromSameIP write FRequirePORTFromSameIP
      default DEF_FTP_PORT_SAME_IP;
    //Do not accept port requests to ports in the reserved range.  That is dangerous on some systems
    property NoReservedRangePORT : Boolean read FNoReservedRangePORT write FNoReservedRangePORT
      default DEF_FTP_NO_RESERVED_PORTS;
    //Do not accept any PORT transfers at all.  This is a little extreme but reduces troubles further.
    //This will break the the Win32 console clients and a number of other programs.
    property BlockAllPORTTransfers : Boolean read FBlockAllPORTTransfers write FBlockAllPORTTransfers
      default DEF_FTP_BLOCK_ALL_PORTS;
    //Disable SYST command.  SYST usually gives the system description.
    //Disabling it may make it harder for a trouble maker to know about your computer
    //but will not be a complete security solution.  See http://www.sans.org/rr/infowar/fingerprint.php for details
    //On the other hand, disabling it will break RFC 959 complience and may break some FTP programs.
    property DisableSYSTCommand : Boolean read FDisableSYSTCommand write FDisableSYSTCommand
      default DEF_FTP_DISABLE_SYST;
    //Disable STAT command.  STAT gives freeform information about the connection status.
    // http://www.sans.org/rr/infowar/fingerprint.php advises administrators to disable this
    //because servers tend to give distinct patterns of information and some trouble makers
    //can figure out what type of server you are running simply with this.
    property DisableSTATCommand : Boolean read FDisableSTATCommand write FDisableSTATCommand
      default DEF_FTP_DISABLE_STAT;
    //Permit CCC (Clear Command Connection) in TLS FTP
    property PermitCCC : Boolean read FPermitCCC write FPermitCCC default DEF_FTP_PERMIT_CCC;
  end;

  TIdDataChannel = class(TObject)
  protected
    FNegotiateTLS : Boolean;
    FControlContext: TIdFTPServerContext;
    FDataChannel: TIdTCPConnection;
    FErrorReply: TIdReplyRFC;
    FFtpOperation: TIdFTPOperation;
    FOKReply: TIdReplyRFC;
    FReply: TIdReplyRFC;

    FServer : TIdFTPServer;
    FRequirePASVFromSameIP : Boolean;
    FStopped : Boolean;
    FData : TObject;
    procedure SetErrorReply(const AValue: TIdReplyRFC);
    procedure SetOKReply(const AValue: TIdReplyRFC);
    function GetPeerIP: String;
    function GetPeerPort: TIdPort;
    function GetLocalIP: String;
    function GetLocalPort: TIdPort;
  public
    constructor Create(APASV: Boolean; AControlContext: TIdFTPServerContext; const ARequirePASVFromSameIP : Boolean; AServer : TIdFTPServer); reintroduce;
    destructor Destroy; override;
    procedure InitOperation(const AConnectMode : Boolean = False);
    property PeerIP : String read GetPeerIP;
    property PeerPort : TIdPort read GetPeerPort;
    property LocalIP : String read GetLocalIP;
    property LocalPort : TIdPort read GetLocalPort;
    property Stopped : Boolean read FStopped write FStopped;
    property Data : TObject read FData write FData;
    property Server : TIdFTPServer read FServer;
    property OKReply: TIdReplyRFC read FOKReply write SetOKReply;
    property ErrorReply: TIdReplyRFC read FErrorReply write SetErrorReply;
  end;

  TIdFTPServerContext = class(TIdFTPServerContextBase)
  protected
    FXAUTKey : UInt32;
    FRESTPos: Integer;
    FDataChannel : TIdDataChannel;
    FAuthMechanism : String;
    FCCC : Boolean; //flag for CCC issuance
    FDataType: TIdFTPTransferType;
    FDataMode : TIdFTPTransferMode;
    FDataPort: TIdPort;
    FDataProtBufSize : UInt32;
    FDataStruct: TIdFTPDataStructure;

    FPasswordAttempts : UInt32;
    FPASV: Boolean;

    FEPSVAll: Boolean;
    FDataPortDenied : Boolean;
    FDataProtection : TIdFTPDataPortSecurity;
    FDataPBSZCalled : Boolean;
    FMLSOpts : TIdFTPFactOutputs;

    FSSCNOn : Boolean;
    FServer : TIdFTPServer;
    FUserSecurity : TIdFTPSecurityOptions;
    FUMask : Integer; //for SITE UMASK command
    //only used for Windows NT imitation
    FMSDOSMode : Boolean; //False - off imitate Unix, //True - On imitate DOS
    //This is a queued request to quite.
    //if it's issued during a data transfer, we treat it as quit
    //only after the request is completed.
    FQuitReply : String;
    //ZLib settings
    FZLibCompressionLevel : Integer; //7
    FZLibWindowBits : Integer; //-15
    FZLibMemLevel : Integer; //8
    FZLibStratagy : Integer; //0 - default
    //
    procedure ResetZLibSettings;
    procedure PortOnAfterBind(ASender : TObject);
    procedure PortOnBeforeBind(ASender : TObject);
    procedure SetUserSecurity(const Value: TIdFTPSecurityOptions);
    procedure CreateDataChannel(APASV: Boolean = False);
    function  IsAuthenticated(ASender: TIdCommand): Boolean;
    procedure ReInitialize; override;

  public
    constructor Create(AConnection: TIdTCPConnection; AYarn: TIdYarn; AList: TIdContextThreadList = nil); override;
    destructor Destroy; override;
    procedure KillDataChannel;

    property DataChannel : TIdDataChannel read FDataChannel;
    property Server : TIdFTPServer read FServer write FServer;

    property UserSecurity : TIdFTPSecurityOptions read FUserSecurity write SetUserSecurity;
    //
    //This is for tracking what AUTH mechanism was specified and that
    //we support.  This may not matter as much now, but it could later on
    //RFC 2228
    property AuthMechanism : String read FAuthMechanism write FAuthMechanism;
    property DataType: TIdFTPTransferType read FDataType write FDataType;
    property DataMode : TIdFTPTransferMode read FDataMode write FDataMode;
    property DataPort: TIdPort read FDataPort;
    //We do not use this much for now but if more AUTH mechanisms are added,
    //we may need this property
    property DataProtBufSize : UInt32 read FDataProtBufSize write FDataProtBufSize;
    property DataPBSZCalled : Boolean read FDataPBSZCalled write FDataPBSZCalled;
    property DataStruct: TIdFTPDataStructure read FDataStruct write FDataStruct;
    //currently, only <C>lear and <P>rivate are used.  This could change
    //later on
    property DataProtection : TIdFTPDataPortSecurity read FDataProtection write FDataProtection;
    property PasswordAttempts : UInt32 read FPasswordAttempts write FPasswordAttempts;
    property PASV: Boolean read FPASV write FPASV;
    property RESTPos: Integer read FRESTPos write FRESTPos;
    property MLSOpts : TIdFTPFactOutputs read FMLSOpts write FMLSOpts;
    //SSCN secure FTPX - http://www.raidenftpd.com/kb/kb000000037.htm
    property SSCNOn : Boolean read FSSCNOn write FSSCNOn;
    //SITE DIRSTYLE flag - true for MSDOS, false for Unix
    property MSDOSMode : Boolean read FMSDOSMode write FMSDOSMode;
    //SITE UMASK settings
    property UMask : Integer read FUMask write FUMask;
    //ZLib settings
    property ZLibCompressionLevel : Integer read FZLibCompressionLevel write FZLibCompressionLevel; //7
    property ZLibWindowBits : Integer read FZLibWindowBits write FZLibWindowBits; //-15
    property ZLibMemLevel : Integer read FZLibMemLevel write FZLibMemLevel; //8
    property ZLibStratagy : Integer read FZLibStratagy write FZLibStratagy; //0 - default
  end;

  TIdOnGetCustomListFormat = procedure(ASender: TIdFTPServer; AItem: TIdFTPListItem;
    var VText: string) of object;

  TIdOnQuerySSLPort = procedure(APort: TIdPort; var VUseSSL: Boolean) of object;

  { FTP Server }
  TIdFTPServer = class(TIdExplicitTLSServer)
  protected
    FSupportXAUTH: Boolean;
    FDirFormat : TIdFTPDirFormat;
    FPathProcessing : TIdFTPPathProcessing;
    FOnClientID : TIdOnClientID;
    FDataChannelCommands: TIdCommandHandlers;
    FSITECommands: TIdCommandHandlers;
    FOPTSCommands: TIdCommandHandlers;
    FMLSDFacts : TIdMLSDAttrs;
    FAnonymousAccounts: TStrings;
    FAllowAnonymousLogin: Boolean;
    FAnonymousPassStrictCheck: Boolean;
//    FEmulateSystem: TIdFTPSystems;
    FPASVBoundPortMin : TIdPort;
    FPASVBoundPortMax : TIdPort;
    FSystemType: string;
    FDefaultDataPort : TIdPort;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FUserAccounts: TIdCustomUserManager;
    FOnUserAccount : TOnFTPUserAccountEvent;
    FOnAfterUserLogin: TOnAfterUserLoginEvent;
    FOnUserLogin: TOnFTPUserLoginEvent;
    FOnChangeDirectory: TOnDirectoryEvent;
    FOnGetFileSize: TOnGetFileSizeEvent;
    FOnGetFileDate:TOnGetFileDateEvent;
    FOnListDirectory: TOnListDirectoryEvent;
    FOnCustomListDirectory : TOnCustomListDirectoryEvent;
    FOnRenameFile: TOnRenameFileEvent;
    FOnDeleteFile: TOnFileEvent;
    FOnRetrieveFile: TOnRetrieveFileEvent;
    FOnStoreFile: TOnStoreFileEvent;
    FOnMakeDirectory: TOnDirectoryEvent;
    FOnRemoveDirectory: TOnDirectoryEvent;
    FOnStat : TIdOnFTPStatEvent;
    FFTPSecurityOptions : TIdFTPSecurityOptions;
    FOnCRCFile : TOnCheckSumFile;
    FOnCombineFiles : TOnCombineFiles;
    FOnSetModifiedTime : TOnSetFileDateEvent;
    FOnFileExistCheck : TOnCheckFileEvent;  //for MDTM variation to set the file time
    FOnSetCreationTime : TOnSetFileDateEvent;
    FOnMD5Cache : TOnCacheChecksum;
    FOnMD5Verify : TOnVerifyChecksum;
    FOnGreeting : TIdOnBanner;
    FOnLoginSuccessBanner : TIdOnBanner;
    FOnLoginFailureBanner : TIdOnBanner;
    FOnQuitBanner : TIdOnBanner;
    FOnSetATTRIB : TOnSetATTRIB;
    FOnSiteUMASK : TOnSiteUMASK;
    FOnSiteCHMOD : TOnSiteCHMOD;
    FOnSiteCHOWN : TOnSiteCHOWN;
    FOnSiteCHGRP : TOnSiteCHGRP;
    FOnAvailDiskSpace : TIdOnDirSizeInfo;
    FOnCompleteDirSize :  TIdOnDirSizeInfo;
    FOnRemoveDirectoryAll: TOnDirectoryEvent;
    FOnCustomPathProcess : TOnCustomPathProcess;

    FOnDataPortBeforeBind : TOnDataPortBind;
    FOnDataPortAfterBind : TOnDataPortBind;
    FOnPASVBeforeBind : TIdOnPASVRange;
    FOnPASVReply : TIdOnPASV;
    {$IFDEF USE_OBJECT_ARC}[Weak]{$ENDIF} FFTPFileSystem: TIdFTPBaseFileSystem;
    FEndOfHelpLine : String;
    FCustomSystID : String;
    FReplyUnknownSITECommand : TIdReply;
    FCompressor : TIdZLibCompressorBase;
    FOnMLST : TIdOnMLST;
    FOnSiteUTIME : TOnSiteUTIME;
    FOnHostCheck : TOnHostCheck;
    FOnQuerySSLPort: TIdOnQuerySSLPort;

    procedure SetOnUserAccount(AValue : TOnFTPUserAccountEvent);
    procedure AuthenticateUser(ASender: TIdCommand);
    function SupportTaDirSwitches(AContext : TIdFTPServerContext) : Boolean;
    function IgnoreLastPathDelim(const APath : String) : String;
    procedure DoOnPASVBeforeBind(ASender : TIdFTPServerContext; var VIP : String;
      var VPortMin, VPortMax : TIdPort; const AIPVersion : TIdIPVersion);
    procedure DoOnPASVReply(ASender : TIdFTPServerContext; var VIP : String;
      var VPort : TIdPort; const AIPVersion : TIdIPVersion);
    function InternalPASV(ASender: TIdCommand; var VIP : String;
      var VPort: TIdPort; var VIPVersion : TIdIPVersion): Boolean;
    function DoSysType(ASender : TIdFTPServerContext) : String;
    function DoProcessPath(ASender : TIdFTPServerContext; const APath: TIdFTPFileName): TIdFTPFileName;

    function FTPNormalizePath(const APath: String) : String;
    function MLSFEATLine(const AFactMask : TIdMLSDAttrs; const AFacts : TIdFTPFactOutputs) : String;

    function HelpText(Cmds : TStrings) : String;
    function IsValidPermNumbers(const APermNos : String) : Boolean;
    procedure SetRFCReplyFormat(AReply : TIdReply);
    function CDUPDir(AContext : TIdFTPServerContext) : String;
    procedure DisconUser(ASender: TIdCommand);
    //command reply common code
    procedure CmdNotImplemented(ASender : TIdCommand);
    procedure CmdFileActionAborted(ASender : TIdCommand);
    procedure CmdSyntaxError(AContext: TIdContext; ALine: string; const AReply : TIdReply = nil); overload;
    procedure CmdSyntaxError(ASender : TIdCommand); overload;
    procedure CmdInvalidParams(ASender: TIdCommand);
    procedure CmdInvalidParamNum(ASender:TIdCommand);
    //The http://www.potaroo.net/ietf/idref/draft-twine-ftpmd5/
    //draft didn't specify 550 as an error.  It said use 504.
    procedure CmdTwineFileActionAborted(ASender : TIdCommand);
    //success reply codes can vary amoung commands
    procedure CmdCommandSuccessful(ASender: TIdCommand; const AReplyCode : Integer = 250);
    //Command replies
    procedure CommandQUIT(ASender:TIdCommand);
    procedure CommandUSER(ASender: TIdCommand);
    procedure CommandPASS(ASender: TIdCommand);
    procedure CommandACCT(ASender: TIdCommand);
    procedure CommandXAUT(ASender : TIdCommand);
    procedure CommandCWD(ASender: TIdCommand);
    procedure CommandCDUP(ASender: TIdCommand);
    procedure CommandREIN(ASender: TIdCommand);
    procedure CommandPORT(ASender: TIdCommand);
    procedure CommandPASV(ASender: TIdCommand);
    procedure CommandTYPE(ASender: TIdCommand);
    procedure CommandSTRU(ASender: TIdCommand);
    procedure CommandMODE(ASender: TIdCommand);
    procedure CommandRETR(ASender: TIdCommand);
    procedure CommandSSAP(ASender: TIdCommand);
    procedure CommandALLO(ASender: TIdCommand);
    procedure CommandREST(ASender: TIdCommand);
    procedure CommandRNFR(ASender: TIdCommand);
    procedure CommandRNTO(ASender: TIdCommand);
    procedure CommandABOR(ASender: TIdCommand);
    //AVBL from  Streamlined FTP Command Extensions
   //      draft-peterson-streamlined-ftp-command-extensions-01.txt
    procedure CommandAVBL(ASender: TIdCommand);
    procedure CommandDELE(ASender: TIdCommand);

     //DSIZ from  Streamlined FTP Command Extensions
   //      draft-peterson-streamlined-ftp-command-extensions-01.txt
    procedure CommandDSIZ(ASender : TIdCommand);
    procedure CommandRMDA(ASender : TIdCommand);

    procedure CommandRMD(ASender: TIdCommand);
    procedure CommandMKD(ASender: TIdCommand);
    procedure CommandPWD(ASender: TIdCommand);
    procedure CommandLIST(ASender: TIdCommand);
    procedure CommandSYST(ASender: TIdCommand);
    procedure CommandSTAT(ASender: TIdCommand);
    procedure CommandSIZE(ASender: TIdCommand);
    procedure CommandFEAT(ASender: TIdCommand);
    procedure CommandOPTS(ASender: TIdCommand);
    procedure CommandAUTH(ASender: TIdCommand);
    procedure CommandCCC(ASender: TIdCommand);
    // rfc 2428:
    procedure CommandEPSV(ASender: TIdCommand);
    procedure CommandEPRT(ASender: TIdCommand);
    //
    procedure CommandMDTM(ASender: TIdCommand);
    procedure CommandMFF(ASender: TIdCommand);
    //
    procedure CommandMD5(ASender: TIdCommand);
    procedure CommandMMD5(ASender: TIdCommand);
    //
    procedure CommandPROT(ASender: TIdCommand);
    procedure CommandPBSZ(ASender: TIdCommand);

    procedure CommandMFMT(ASender: TIdCommand);
    procedure CommandMFCT(ASender: TIdCommand);

    procedure CommandMLSD(ASender: TIdCommand);
    procedure CommandMLST(ASender: TIdCommand);

    procedure CommandCheckSum(ASender: TIdCommand);
    procedure CommandCOMB(ASender: TIdCommand);

    procedure CommandCLNT(ASender: TIdCommand);
    //SSCN Secure FTPX - http://www.raidenftpd.com/kb/kb000000037.htm
    procedure CommandSSCN(ASender: TIdCommand);
    //Informal - like PASV accept SSL is in client mode - used by FlashXP
    procedure CommandCPSV(ASender: TIdCommand);
    //Informal - like PASV except that only the port is communicated.
    //
    procedure CommandSPSV(ASender: TIdCommand);

    procedure CommandHOST(ASender : TIdCommand);
    procedure CommandSecRFC(ASender : TIdCommand); //stub for some commands in 2228
    procedure CommandSITE(ASender: TIdCommand);
    procedure CommandSiteHELP(ASender : TIdCommand);
    //site commands - Unix
    procedure CommandSiteUMASK(ASender : TIdCommand);
    procedure CommandSiteCHMOD(ASender : TIdCommand);
    //SITE CHOWN - supported by some Unix servers
    procedure CommandSiteCHOWN(ASender : TIdCommand);
    //SITE CHGRP - supported by some Unix servers
    procedure CommandSiteCHGRP(ASender : TIdCommand);
    //site commans - MS IIS
    procedure CommandSiteDIRSTYLE(ASender : TIdCommand);
    //used by FTP Voyager
    procedure CommandSiteZONE(ASender : TIdCommand);
    //supported by RaidenFTP - http://www.raidenftpd.com/kb/kb000000049.htm
    procedure CommandSiteATTRIB(ASender : TIdCommand);
    //McFTP client uses this to set the time stamps for a file.
    procedure CommandSiteUTIME(ASender : TIdCommand);
    // end site commands

    procedure CommandOptsMLST(ASender : TIdCommand);
    procedure CommandOptsMODEZ(ASender : TIdCommand);
    procedure CommandOptsUTF8(ASender: TIdCommand);
    procedure CommandHELP(ASender: TIdCommand);
    //
    procedure DoOnRenameFile(ASender: TIdFTPServerContext; const ARenameFromFile, ARenameToFile: string);
    procedure DoOnDeleteFile(ASender: TIdFTPServerContext; const APathName: string);
    procedure DoOnChangeDirectory(AContext: TIdFTPServerContext; var VDirectory: TIdFTPFileName);
    procedure DoOnMakeDirectory(AContext: TIdFTPServerContext; var VDirectory: TIdFTPFileName);
    procedure DoOnRemoveDirectory(AContext: TIdFTPServerContext; var VDirectory: TIdFTPFileName);
    procedure DoOnGetFileSize(ASender: TIdFTPServerContext; const AFilename: string; var VFileSize: Int64);
    procedure DoOnGetFileDate(ASender: TIdFTPServerContext; const AFilename: string; var VFileDate: TDateTime);
    procedure DoOnSetModifiedTime(AContext: TIdFTPServerContext; const AFileName : String; var VDateTime: TDateTime); overload;
    procedure DoOnSetModifiedTime(AContext: TIdFTPServerContext; const AFileName : String; var VDateTimeStr : String); overload;
    procedure DoOnFileExistCheck(AContext: TIdFTPServerContext; const AFileName : String; var VExist : Boolean);
    procedure DoOnSetModifiedTimeGMT(AContext: TIdFTPServerContext; const AFileName : String; var VDateTime: TDateTime);
    procedure DoOnSetCreationTime(AContext: TIdFTPServerContext; const AFileName : String; var VDateTime: TDateTime); overload;
    procedure DoOnSetCreationTime(AContext: TIdFTPServerContext; const AFileName : String; var VDateTimeStr : String); overload;
    procedure DoOnSetCreationTimeGMT(AContext: TIdFTPServerContext; const AFileName : String; var VDateTime: TDateTime);
    procedure DoOnCRCFile(ASender: TIdFTPServerContext; const AFileName : String; var VStream : TStream);
    procedure DoOnMD5Verify(ASender: TIdFTPServerContext; const AFileName : String; const ACheckSum : String);
    procedure DoOnMD5Cache(ASender: TIdFTPServerContext; const AFileName : String; var VCheckSum : String);
    procedure DoOnCombineFiles(ASender: TIdFTPServerContext; const ATargetFileName: string; AParts : TStrings);
    procedure DoOnSetATTRIB(ASender: TIdFTPServerContext; var VAttr : UInt32; const AFileName : String; var VAUth : Boolean);
    procedure DoOnSiteUMASK(ASender: TIdFTPServerContext; var VUMASK : Integer; var VAUth : Boolean);
    procedure DoOnSiteCHMOD(ASender: TIdFTPServerContext; var APermissions : Integer; const AFileName : String; var VAUth : Boolean);
    procedure DoOnSiteCHOWN(ASender: TIdFTPServerContext; var AOwner, AGroup : String; const AFileName : String; var VAUth : Boolean);
    procedure DoOnSiteCHGRP(ASender: TIdFTPServerContext; var AGroup : String; const AFileName : String; var VAUth : Boolean);
    procedure SetUseTLS(AValue: TIdUseTLS); override;
    procedure SetSupportXAUTH(AValue : Boolean);
    procedure InitializeCommandHandlers; override;
    procedure ListDirectory(ASender: TIdFTPServerContext; ADirectory: string;
      ADirContents: TStrings; ADetails: Boolean; const ACmd : String = 'LIST';
      const ASwitches : String = ''); {do not localize}
    {$IFNDEF USE_OBJECT_ARC}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$ENDIF}
    procedure SetAnonymousAccounts(const AValue: TStrings);
    procedure SetUserAccounts(const AValue: TIdCustomUserManager);
    procedure SetFTPSecurityOptions(const AValue: TIdFTPSecurityOptions);
    procedure SetPASVBoundPortMax(const AValue: TIdPort);
    procedure SetPASVBoundPortMin(const AValue: TIdPort);
    procedure SetReplyUnknownSITECommand(AValue: TIdReply);
    procedure SetSITECommands(AValue: TIdCommandHandlers);
    procedure ThreadException(AThread: TIdThread; AException: Exception);
    procedure SetFTPFileSystem(const AValue: TIdFTPBaseFileSystem);
    function  GetMD5Checksum(ASender : TIdFTPServerContext; const AFileName : String) : String;
    //overrides from TIdTCPServer
    procedure DoConnect(AContext:TIdContext); override;
    procedure DoDisconnect(AContext:TIdContext); override;
    procedure ContextCreated(AContext:TIdContext); override;

    procedure DoOnDataPortBeforeBind(ASender : TIdFTPServerContext); virtual;
    procedure DoDataChannelOperation(ASender: TIdCommand; const AConnectMode : Boolean = False);virtual;
    procedure DoOnDataPortAfterBind(ASender : TIdFTPServerContext); virtual;
    procedure DoOnCustomListDirectory(ASender: TIdFTPServerContext; const APath: string;
      ADirectoryListing: TStrings; const ACmd : String; const ASwitches : String);

    function DoQuerySSLPort(APort: TIdPort): Boolean; virtual;

    function GetReplyClass: TIdReplyClass; override;
    function GetRepliesClass: TIdRepliesClass; override;
    procedure InitComponent; override;
    procedure DoReplyUnknownCommand(AContext: TIdContext; ALine: string); override;
    // overriden so we can close active transfers during a shutdown
    procedure DoTerminateContext(AContext: TIdContext); override;
    //overriden so we can handle telnet sequences
    function ReadCommandLine(AContext: TIdContext): string; override;
  public
    destructor Destroy; override;
    property SupportXAUTH : Boolean read FSupportXAUTH write SetSupportXAUTH;
  published
    {This is an object that can compress and decompress HTTP Deflate encoding}
    property Compressor : TIdZLibCompressorBase read FCompressor write FCompressor;
    property CustomSystID : String read FCustomSystID write FCustomSystID;
    property DirFormat : TIdFTPDirFormat read FDirFormat write FDirFormat default DEF_DIRFORMAT;
    property PathProcessing : TIdFTPPathProcessing read FPathProcessing write FPathProcessing default DEF_PATHPROCESSING;
    property UseTLS;
    property DefaultPort default IDPORT_FTP;
    property AllowAnonymousLogin: Boolean read FAllowAnonymousLogin write FAllowAnonymousLogin default Id_DEF_AllowAnon;
    property AnonymousAccounts: TStrings read FAnonymousAccounts write SetAnonymousAccounts;
    property AnonymousPassStrictCheck: Boolean read FAnonymousPassStrictCheck
     write FAnonymousPassStrictCheck default Id_DEF_PassStrictCheck;
    property DefaultDataPort : TIdPort read FDefaultDataPort write FDefaultDataPort default IdPORT_FTP_DATA;
    property FTPFileSystem:TIdFTPBaseFileSystem read FFTPFileSystem write SetFTPFileSystem;
    property FTPSecurityOptions : TIdFTPSecurityOptions read FFTPSecurityOptions write SetFTPSecurityOptions;
    property EndOfHelpLine : String read FEndOfHelpLine write FEndOfHelpLine;
    property PASVBoundPortMin : TIdPort read FPASVBoundPortMin write SetPASVBoundPortMin default DEF_PASV_BOUND_MIN;
    property PASVBoundPortMax : TIdPort read FPASVBoundPortMax write SetPASVBoundPortMax default DEF_PASV_BOUND_MAX;
    property UserAccounts: TIdCustomUserManager read FUserAccounts write SetUserAccounts;
    property SystemType: string read FSystemType write FSystemType;
    property OnGreeting : TIdOnBanner read FOnGreeting write FOnGreeting;
    property OnLoginSuccessBanner : TIdOnBanner read FOnLoginSuccessBanner write FOnLoginSuccessBanner;
    property OnLoginFailureBanner : TIdOnBanner read FOnLoginFailureBanner write FOnLoginFailureBanner;
    //for retreiving MD5 Checksums from a cache
    property OnMD5Cache : TOnCacheChecksum read FOnMD5Cache write FOnMD5Cache;
    property OnMD5Verify : TOnVerifyChecksum read FOnMD5Verify write FOnMD5Verify;
    property OnQuitBanner : TIdOnBanner read FOnQuitBanner write FOnQuitBanner;
    property OnCustomListDirectory : TOnCustomListDirectoryEvent read FOnCustomListDirectory write FOnCustomListDirectory;
    property OnCustomPathProcess : TOnCustomPathProcess read FOnCustomPathProcess write FOnCustomPathProcess;
    property OnAfterUserLogin: TOnAfterUserLoginEvent read FOnAfterUserLogin  write FOnAfterUserLogin;
    property OnChangeDirectory: TOnDirectoryEvent read FOnChangeDirectory write FOnChangeDirectory;
    property OnGetFileSize: TOnGetFileSizeEvent read FOnGetFileSize write FOnGetFileSize;
    property OnGetFileDate: TOnGetFileDateEvent read FOnGetFileDate write FOnGetFileDate;
    property OnUserLogin: TOnFTPUserLoginEvent read FOnUserLogin write FOnUserLogin;
    property OnUserAccount : TOnFTPUserAccountEvent read FOnUserAccount write SetOnUserAccount;
    property OnListDirectory: TOnListDirectoryEvent read FOnListDirectory write FOnListDirectory;
    property OnDataPortBeforeBind : TOnDataPortBind read FOnDataPortBeforeBind write FOnDataPortBeforeBind;
    property OnDataPortAfterBind : TOnDataPortBind read FOnDataPortAfterBind write FOnDataPortAfterBind;
    property OnRenameFile: TOnRenameFileEvent read FOnRenameFile write FOnRenameFile;
    property OnDeleteFile: TOnFileEvent read FOnDeleteFile write FOnDeleteFile;
    property OnRetrieveFile: TOnRetrieveFileEvent read FOnRetrieveFile write FOnRetrieveFile;
    property OnStoreFile: TOnStoreFileEvent read FOnStoreFile write FOnStoreFile;
    property OnMakeDirectory: TOnDirectoryEvent read FOnMakeDirectory write FOnMakeDirectory;
    property OnRemoveDirectory: TOnDirectoryEvent read FOnRemoveDirectory write FOnRemoveDirectory;
    property OnStat : TIdOnFTPStatEvent read FOnStat write FOnStat;
    property OnCombineFiles : TOnCombineFiles read FOnCombineFiles write FOnCombineFiles;
    property OnCRCFile : TOnCheckSumFile read FOnCRCFile write FOnCRCFile;
    property OnSetCreationTime : TOnSetFileDateEvent read FOnSetCreationTime write FOnSetCreationTime;
    property OnSetModifiedTime : TOnSetFileDateEvent read FOnSetModifiedTime write FOnSetModifiedTime;
    property OnFileExistCheck : TOnCheckFileEvent read FOnFileExistCheck write FOnFileExistCheck;
    property OnHostCheck : TOnHostCheck read FOnHostCheck write FOnHostCheck;
    property OnSetATTRIB : TOnSetATTRIB read FOnSetATTRIB write FOnSetATTRIB;
    property OnSiteUMASK : TOnSiteUMASK read FOnSiteUMASK write FOnSiteUMASK;
    property OnSiteCHMOD : TOnSiteCHMOD read FOnSiteCHMOD write FOnSiteCHMOD;
    property OnSiteCHOWN : TOnSiteCHOWN read FOnSiteCHOWN write FOnSiteCHOWN;
    property OnSiteCHGRP : TOnSiteCHGRP read FOnSiteCHGRP write FOnSiteCHGRP;
    {
    READ THIS!!!

    Do not change values in the OnPASV event unless you have a compelling reason to do so.

    In SPSV, the PORT is the only thing that can work because that's all which is
    given as a reply.  The server IP is the same one that the client connects to.

    In EPSV, the PORT is the only thing that can work because that's all which is
    given as a reply.  The server IP is the same one that the client connects to.

    }
    property OnPASVBeforeBind : TIdOnPASVRange read FOnPASVBeforeBind write FOnPASVBeforeBind;
    property OnPASVReply : TIdOnPASV read FOnPASVReply write FOnPASVReply;
    property OnMLST : TIdOnMLST read FOnMLST write FOnMLST;
    property OnSiteUTIME : TOnSiteUTIME read FOnSiteUTIME write FOnSiteUTIME;
    property OnAvailDiskSpace : TIdOnDirSizeInfo read FOnAvailDiskSpace write FOnAvailDiskSpace;
    property OnCompleteDirSize :  TIdOnDirSizeInfo read FOnCompleteDirSize write FOnCompleteDirSize;

    property SITECommands: TIdCommandHandlers read FSITECommands write SetSITECommands;
    property MLSDFacts : TIdMLSDAttrs read  FMLSDFacts write FMLSDFacts;
    property OnClientID : TIdOnClientID read FOnClientID write FOnClientID;
    property ReplyUnknownSITCommand: TIdReply read FReplyUnknownSITECommand write SetReplyUnknownSITECommand;

    property OnQuerySSLPort: TIdOnQuerySSLPort read FOnQuerySSLPort write FOnQuerySSLPort;
  end;

  {This is used internally for some Telnet sequence parsing}
type
  TIdFTPTelnetState = (tsData, tsCheckCR, tsIAC, tsWill, tsDo, tsWont, tsDont,
    tsNegotiate, tsNegotiateData, tsNegotiateIAC, tsInterrupt, tsInterruptIAC);

implementation

uses
  {$IFDEF DOTNET}
    {$IFDEF USE_INLINE}
  System.Threading,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF USE_VCL_POSIX}
  Posix.SysSelect,
  Posix.SysTime,
  {$ENDIF}
  IdFIPS,
  IdHash, IdHashCRC, IdHashMessageDigest, IdHashSHA, IdIOHandlerSocket,
  IdResourceStringsProtocols, IdGlobalProtocols, IdSimpleServer, IdSSL,
  IdIOHandlerStack, IdSocketHandle, IdStrings, IdTCPClient, IdEMailAddress,
  IdStack, IdFTPListTypes, IdStream;

const
  //THese commands need some special treatment in the Indy 10 FTP Server help system
  //as they will not always work
  HELP_SPEC_CMDS : array [0..25] of string =
    ('SIZE','MDTM',                                                 {do not localize}
     'AUTH','PBSZ','PROT','CCC','MIC','CONF','ENC', 'SSCN','CPSV',  {do not localize}
     'MFMT','MFF',
     'MD5','MMD5','XCRC','XMD5','XSHA1','XSHA256','XSHA512',               {do not localize}
     'COMB','AVBL','DSIZ','RMDA','HOST','XAUT');                          {do not localize}

  //These commands must always be present even if not implemented
  //alt help topics and superscripts should be used sometimes.
  //These are mandated by RFC 1123
  HELP_ALT_MD_CMD : array [0..17] of string =
    ('RETR',         {do not localize}
     'STOR','STOU',  {do not localize}
     'APPE',         {do not localize}
     'RNFR', 'RNTO', {do not localize}
     'DELE',         {do not localize}
     'LIST','NLST',  {do not localize}
     'CWD','XCWD',   {do not localize}
     'CDUP','XCUP',  {do not localize}
     'RMD','XRMD',   {do not localize}
     'MKD', 'XMKD',  {do not localize}
     'SYST');        {do not localize}

  HELP_ALT_MD_TP  : array [0..17] of string =
    ('RETR        (retrieve); unimplemented.',                    {do not localize}
     'STOR        (store); unimplemented.',                       {do not localize}
     'STOU        (store unique); unimplemented.',                {do not localize}
     'APPE        (append); unimplemented.',                      {do not localize}
     'RNFR        (rename from); unimplemented.',                 {do not localize}
     'RNTO        (rename to); unimplemented.',                   {do not localize}
     'DELE        (delete); unimplemented.',                      {do not localize}
     'LIST        (list); unimplemented.',                        {do not localize}
     'NLIST       (name-list); unimplemented.',                   {do not localize}
     'CWD         (change working directory); unimplemented.',    {do not localize}
     'XCWD        (change working directory); unimplemented.',    {do not localize}
     'CDUP        (change to parent directory); unimplemented.',  {do not localize}
     'XCDUP       (change to parent directory); unimplemented.',  {do not localize}
     'RMD         (remove Directory); unimplemented.',            {do not localize}
     'XRMD        (remove Directory); unimplemented.',            {do not localize}
     'MKD         (make Directory); unimplemented.',              {do not localize}
     'XMKD        (make Directory); unimplemented.',              {do not localize}
     'SYST        (system); unimplemented.'                       {do not localize}
     );

  //SSCN, OPTS MODE Z EXTRA, and OPTS UTF8 states
  OnOffStates : array [0..1] of string =
    ('ON', {do not localize}
     'OFF' {do not localize}
     );

const
  //%s = host
  //%n = xauth key
    XAUTHBANNER = '%s X2 WS_FTP Server Compatible(%d)';
    ACCT_HELP_DISABLED =  'ACCT        (specify account); unimplemented.'; {do not localize}
    ACCT_HELP_ENABLED   = 'Syntax: ACCT <SP> <account-information> <CRLF>';

const
  NLSTEncType: array[Boolean] of IdTextEncodingType = (encASCII, encUTF8);

function CalculateCheckSum(AHashClass: TIdHashClass; AStrm: TStream; ABeginPos, AEndPos: TIdStreamSize): String;
  {$IFDEF USE_INLINE} inline; {$ENDIF}
var
  LHash: TIdHash;
begin
  LHash := AHashClass.Create;
  try
    Result := LHash.HashStreamAsHex(AStrm, ABeginPos, AEndPos-ABeginPos);
  finally
    LHash.Free;
  end;
end;

procedure XAutGreeting(AContext: TIdContext; AGreeting : TIdReply; const AHostName : String);
  {$IFDEF USE_INLINE} inline; {$ENDIF}
var
  s : String;
begin
//for XAUT to work with WS-FTP Pro, you need a banner mentioning "WS_FTP Server"
//and that banner can only be one line in length.
  s := IndyFormat(XAUTHBANNER,
       [ GStack.HostName,  (AContext as TIdFTPServerContext).FXAUTKey]) + ' '+AGreeting.Text.Text;
  s := Fetch(s,CR);
  s := Fetch(s,LF);
  AGreeting.Text.Text := s;

end;

{ TIdFTPServer }

constructor TIdFTPServerContext.Create(AConnection: TIdTCPConnection; AYarn: TIdYarn;
  AList: TIdContextThreadList = nil);
begin
  inherited Create(AConnection, AYarn, AList);
  FUserSecurity := TIdFTPSecurityOptions.Create;
  //we don't initialize FCCC flag here because that shouldn't be cleared with implicit SSL
  FCCC := False;
  FDataMode := dmStream;
  FMLSOpts := [ItemType, Modify, Size];
  //no write permissions for group and others
  FUMask := 22;
  ResetZLibSettings;
  ReInitialize;
end;

procedure TIdFTPServerContext.SetUserSecurity(const Value: TIdFTPSecurityOptions);
begin
  FUserSecurity.Assign( Value);
end;

destructor TIdFTPServerContext.Destroy;
begin
  KillDataChannel;
  FreeAndNil(FUserSecurity);
  inherited Destroy;
end;

procedure TIdFTPServerContext.CreateDataChannel(APASV: Boolean = False);
begin
  KillDataChannel; //let the old one terminate
  FDataChannel := TIdDataChannel.Create(APASV, Self, UserSecurity.RequirePASVFromSameIP, Server);
end;

procedure TIdFTPServerContext.KillDataChannel;
begin
  if Assigned(FDataChannel) then begin
    if not FDataChannel.Stopped then begin
      FDataChannel.Stopped := True;
      FDataChannel.FDataChannel.Disconnect(False);
    end;
    FreeAndNil(FDataChannel);
  end;
end;

procedure TIdFTPServerContext.ReInitialize;
begin
  inherited;
  FDataType := ftASCII;
 // FDataMode := dmStream;
  FDataPort := 0;
  FDataStruct := dsFile;
  FPASV := False;
  FEPSVAll := False;
  FDataProtection := ftpdpsClear;
  DataPBSZCalled := False;
  FDataProtBufSize := 0;
end;

function TIdFTPServerContext.IsAuthenticated(ASender: TIdCommand): Boolean;
begin
  Result := FAuthenticated;
  if not Result then begin
    ASender.Reply.SetReply(530, RSFTPUserNotLoggedIn);
  end;
end;

{ TIdFTPServer }

procedure TIdFTPServer.InitComponent;
begin
  inherited InitComponent;
  HelpReply.Code := ''; //we will handle the help ourselves
  FDataChannelCommands := TIdCommandHandlers.Create(Self, FReplyClass, ReplyTexts, ExceptionReply);
  FSITECommands := TIdCommandHandlers.Create(Self, FReplyClass, ReplyTexts, ExceptionReply);
  FOPTSCommands := TIdCommandHandlers.Create(Self, FReplyClass, ReplyTexts, ExceptionReply);
  //inherited from TLS classes
  FRegularProtPort := IdPORT_FTP;
  FImplicitTLSProtPort := IdPORT_ftps;
  FExplicitTLSProtPort := IdPORT_FTP;
  //
  FAnonymousAccounts :=  TStringList.Create;
  // By default these user names will be treated as anonymous.
  FAnonymousAccounts.Add('anonymous'); { do not localize }
  FAnonymousAccounts.Add('ftp'); { do not localize }
  FAnonymousAccounts.Add('guest'); { do not localize }
  FAllowAnonymousLogin := Id_DEF_AllowAnon;
  FAnonymousPassStrictCheck := Id_DEF_PassStrictCheck;
  DefaultPort := IDPORT_FTP;
  DefaultDataPort := IdPORT_FTP_DATA;
//  FEmulateSystem := Id_DEF_SystemType;
  Greeting.SetReply(220, RSFTPDefaultGreeting);

  FContextClass := TIdFTPServerContext;
  ReplyUnknownCommand.SetReply(500, 'Unknown Command'); {do not localize}

  FReplyUnknownSITECommand := FReplyClass.Create(nil);
  FReplyUnknownSITECommand.SetReply(500, 'Invalid SITE command.'); {do not localize}

  FFTPSecurityOptions := TIdFTPSecurityOptions.Create;
  FPASVBoundPortMin := DEF_PASV_BOUND_MIN;
  FPASVBoundPortMax := DEF_PASV_BOUND_MAX;
  FPathProcessing := DEF_PATHPROCESSING;
  FDirFormat := DEF_DIRFORMAT;
end;

function TIdFTPServer.GetReplyClass: TIdReplyClass;
begin
  Result := TIdReplyFTP;
end;

function TIdFTPServer.GetRepliesClass: TIdRepliesClass;
begin
  Result := TIdRepliesFTP;
end;

procedure TIdFTPServer.CommandHELP(ASender: TIdCommand);
var
  s : String;
  LCmds : TStringList;
  i : Integer;
  LExp : String;

  function ShouldShowCommand(const ACommand : String) : Boolean;
  begin
    Result := False;
    case PosInStrArray(ACommand, HELP_SPEC_CMDS, False) of
       -1 :
         Result := True;
        0 : //'SIZE'
          if Assigned(FOnGetFileSize) then begin
            Result := True;
          end;
        1 :// 'MDTM',
          if Assigned(FOnGetFileDate) or Assigned(FTPFileSystem) then begin
            Result := True;
          end;
        2 : // 'AUTH'
          if (FUseTLS in ExplicitTLSVals) then begin
            Result := True;
          end;
        3,4,5,6,7,8,9,10 : //'PBSZ','PROT', 'CCC','MIC','CONF','ENC','SSCN','CPSV',
          if (FUseTLS <> utNoTLSSupport) then begin
            Result := True;
          end;
        11,12 : // 'MFMT','MFF',
          if Assigned(FOnSetModifiedTime) or Assigned(FTPFileSystem) then begin
            Result := True;
          end;
        13,14, 15,16 : //'MD5','MMD5','XCRC','XMD5',
        begin
          Result := False;
          if not GetFIPSMode then begin
            if Assigned(FOnCRCFile) or Assigned(FTPFileSystem) then begin
              Result := True;
            end;
          end;
        end;

        17 : // 'XSHA1',
          if Assigned(FOnCRCFile) or Assigned(FTPFileSystem) then begin
            Result := True;
          end;
        18 : //'XSHA256'
          if (Assigned(FOnCRCFile) or Assigned(FTPFileSystem))
            and TIdHashSHA256.IsAvailable then begin
            Result := True;
          end;
        19 : //'XSHA512'
          if (Assigned(FOnCRCFile) or Assigned(FTPFileSystem)) and
            TIdHashSHA512.IsAvailable then begin
            Result := True;
          end;
        20 : //  'COMB');
          if Assigned(OnCombineFiles) or Assigned(FTPFileSystem) then begin
            Result := True;
          end;
        21 : //  AVBL
          if Assigned(FOnAvailDiskSpace) then begin
            Result := True;
          end;
        22 : //  DSIZ
          if Assigned(FOnCompleteDirSize) then begin
            Result := True;
          end;
        23 : // RMDA
          if Assigned(FOnRemoveDirectoryAll) then begin
            Result := True;
          end;
        24 : // HOST
          if Assigned( FOnHostCheck ) then begin
            Result := True;
          end;
        25 : // XAUT
         if (not GetFIPSMode) and Self.FSupportXAUTH then begin
           Result := True;
         end;
    end;
  end;

  function IsNotImplemented(const ACommand : String; var VHelp : String) : Boolean;
  var
    idx : Integer;
  begin
    Result := False; //presume that the command is implemented
    idx := PosInStrArray(ACommand, HELP_ALT_MD_CMD, False);
    if idx = -1 then begin
      Exit;
    end;
    case idx of
      0 : // 'RETR'
        begin
          if (not Assigned(FOnRetrieveFile)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      1,2,3 : //'STOR','STOU', 'APPE',
        begin
          if (not Assigned(FOnStoreFile)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      4,5 : // 'RNFR', 'RNTO',
        begin
          if (not Assigned(FOnRenameFile)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      6 : //  'DELE',
        begin
          if (not Assigned(FOnDeleteFile)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      7,8 :// 'LIST','NLST',
        begin
          if (not Assigned(FOnListDirectory)) or
           ((FDirFormat = ftpdfCustom) and (not Assigned(OnCustomListDirectory))) then begin
            Result := True;
          end;
        end;
      9, 10,   //'CWD','XCWD',
      11, 12 : // 'CDUP','XCUP',
        begin
          if (not Assigned(FOnChangeDirectory)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      13, 14 : //'RMD','XRMD',
        begin
          if (not Assigned(FOnRemoveDirectory)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      15,16 : //'MKD', 'XMKD',
        begin
          if (not Assigned(FOnMakeDirectory)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      17 :// 'SYST',
        begin
          if (not Assigned(FOnMakeDirectory)) and (not Assigned(FFTPFileSystem)) then begin
            Result := True;
          end;
        end;
      end;
      if Result then begin
        LExp := HELP_ALT_MD_TP[idx];
      end;
    end;

begin
  if ASender.Params.Count > 0 then begin
    for i := 0 to CommandHandlers.Count-1 do begin
      if TextIsSame(ASender.Params[0], CommandHandlers.Items[i].Command) then begin
        if CommandHandlers.Items[i].HelpVisible and ShouldShowCommand(ASender.Params[0]) then begin
          if IsNotImplemented(CommandHandlers.Items[i].Command, LExp) then begin
            ASender.Reply.SetReply(214, LExp);
          end else begin
            ASender.Reply.SetReply(214, CommandHandlers.Items[i].Description.Text);
          end;
        end else begin
          ASender.Reply.SetReply(502, IndyFormat(RSFTPCmdHelpNotKnown, [UpperCase(ASender.Params[0])]));
        end;
        Exit;
      end;
    end;
    ASender.Reply.SetReply(502, IndyFormat(RSFTPCmdHelpNotKnown, [UpperCase(ASender.Params[0])]));
  end else begin
    s := RSFTPHelpBegining + EOL;
    LCmds := TStringList.Create;
    try
      //
      for i := 0 to CommandHandlers.Count -1 do begin
        if CommandHandlers.Items[i].HelpVisible and ShouldShowCommand(CommandHandlers.Items[i].Command) then begin
          if IsNotImplemented(CommandHandlers.Items[i].Command, LExp) then begin
            LCmds.Add(CommandHandlers.Items[i].Command + '*'); {do not localize}
          end else begin
            LCmds.Add(CommandHandlers.Items[i].Command + CommandHandlers.Items[i].HelpSuperScript);
          end;
        end;
      end;
      LCmds.Sort;
      s := s + HelpText(LCmds) + FEndOfHelpLine;
      if FEndOfHelpLine = '' then begin
        s := s + EOL;  //prevent ugliness if last row out of alignment with the rest
      end;
      ASender.Reply.SetReply(214, s);
    finally
      FreeAndNil(LCmds);
    end;
  end;
end;

procedure TIdFTPServer.CommandHOST(ASender: TIdCommand);
var LTmp : String;
  LValid : Boolean;
  LContext : TIdFTPServerContext;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if Assigned(OnHostCheck) then begin
    if LContext.Username <> '' then begin
      ASender.Reply.SetReply(530,  RSFTPNotAfterAuthentication );
      Exit;
    end;
    if (ASender.Params.Count > 0)  then begin
      LTmp := ASender.Params[0];
      if Copy(LTmp,1,1)='[' then begin
        Delete(LTmp,1,1);
      end;
      LTmp := Fetch(LTmp,']');
      LValid := False;
      FOnHostCheck(LContext,LTmp,LValid);
      if LValid then begin
        LContext.Host := LTmp;
        if Assigned(OnGreeting) then begin
          OnGreeting(LContext,ASender.Reply);
        end;
        if ASender.Reply.NumericCode = 421 then begin
          ASender.Disconnect := True;
        end else begin
          if not GetFIPSMode then begin
          //setting the reply code number directly causes the text to be cleared
            if FSupportXAUTH and (ASender.Reply.NumericCode = 220) then begin
              XAutGreeting(LContext,ASender.Reply, LTmp);
            end;
          end;
          ASender.Reply.SetReply(220,ASender.Reply.Text.Text);
        end;
        ASender.SendReply;
      end else begin
        ASender.Reply.SetReply(530,RSFTPHostNotFound);
      end;
    end;
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.InitializeCommandHandlers;
var
  LCmd : TIdCommandHandler;
begin
  inherited InitializeCommandHandlers;

  //ACCESS CONTROL COMMANDS
  //USER <SP> <username> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'USER';    {Do not Localize}
  LCmd.OnCommand := CommandUSER;
  LCmd.Description.Text := 'Syntax: USER <sp> username'; {do not localize}

  //PASS <SP> <password> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'PASS';    {Do not Localize}
  LCmd.OnCommand := CommandPASS;
  LCmd.Description.Text := 'Syntax: PASS <sp> password'; {do not localize}

  //ACCT <SP> <account-information> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'ACCT';    {Do not Localize}
 // LCMd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['ACCT'])); {do not localize}
  LCmd.OnCommand := CommandACCT;
  if Assigned(Self.FOnUserAccount) then begin
    LCmd.HelpSuperScript := ''; //not supported
    LCmd.Description.Text := ACCT_HELP_ENABLED;
  end else begin
    LCmd.HelpSuperScript := '*'; //not supported
    LCmd.Description.Text := ACCT_HELP_DISABLED;
  end;
//  'ACCT        (specify account); unimplemented.'; {do not localize}

  {
  LCmd.NormalReply.SetReply(502, Format(RSFTPCmdNotImplemented, ['ACCT']));    {Do not Localize}

  //CWD  <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'CWD';    {Do not Localize}
  LCmd.OnCommand := CommandCWD;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: CWD [ <sp> directory-name ]'; {do not localize}

  //CDUP <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'CDUP';    {Do not Localize}
  LCmd.OnCommand := CommandCDUP;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: CDUP (change to parent directory)'; {do not localize}

  //SMNT <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'SMNT';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, RSFTPFileActionCompleted);//250 for success
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'SMNT        (structure mount); unimplemented.'; {do not localize}

  //QUIT <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'QUIT';    {Do not Localize}
  LCmd.OnCommand := CommandQUIT;
  LCmd.Disconnect := True;
  LCmd.NormalReply.SetReply(221, RSFTPQuitGoodby);    {Do not Localize}
  LCmd.Description.Text := 'Syntax: QUIT (terminate service)'; {do not localize}

  //REIN <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'REIN';    {Do not Localize}
  LCmd.OnCommand := CommandREIN;
  LCmd.Description.Text := 'Syntax: REIN (reinitialize server state)'; {do not localize}

  //PORT <SP> <host-port> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'PORT';    {Do not Localize}
  LCmd.OnCommand := CommandPORT;
  LCmd.Description.Text := 'Syntax: PORT <sp> b0, b1, b2, b3, b4'; {do not localize}

  //PASV <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'PASV';    {Do not Localize}
  LCmd.OnCommand := CommandPASV;
  LCmd.Description.Text := 'Syntax: PASV (set server in passive mode)'; {do not localize}

  //P@SW <CRLF>
  //This is for some routers that replace a PASV with a P@SW
  //as part of a misguided attempt to add a feature.
  //A router would do a replacement so a client would think that
  //PASV wasn't supported and then the client would do a PORT command
  //instead.  That doesn't happen so this just caused the client not to work.
  //See:  http://www.gbnetwork.co.uk/smcftpd/
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'P@SW';    {Do not Localize}
  LCmd.OnCommand := CommandPASV;
  LCmd.HelpVisible := False; //this is just a workaround

  //TYPE <SP> <type-code> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'TYPE';    {Do not Localize}
  LCmd.OnCommand := CommandTYPE;
  LCmd.Description.Text := 'Syntax: TYPE <sp> [ A | E | I | L ]'; {do not localize}

  //STRU <SP> <structure-code> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'STRU';    {Do not Localize}
  LCmd.OnCommand := CommandSTRU;
  LCmd.Description.Text := 'Syntax: STRU (specify file structure)'; {do not localize}

  //MODE <SP> <mode-code> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MODE';    {Do not Localize}
  LCmd.OnCommand := CommandMODE;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: MODE (specify transfer mode)'; {do not localize}

  //FTP SERVICE COMMANDS
  //RETR <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'RETR';    {Do not Localize}
  LCmd.OnCommand := CommandRETR;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: RETR <sp> file-name'; {do not localize}

  //STOR <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'STOR';    {Do not Localize}
  LCmd.OnCommand := CommandSSAP;
  LCmd.ExceptionReply.NumericCode := 551;
  LCmd.Description.Text := 'Syntax: STOR <sp> file-name'; {do not localize}

  //STOU <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'STOU';    {Do not Localize}
  LCmd.OnCommand := CommandSSAP;
  LCmd.ExceptionReply.NumericCode := 551;
  LCmd.Description.Text := 'Syntax: STOU <sp> file-name'; {do not localize}

  //APPE <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'APPE';    {Do not Localize}
  LCmd.OnCommand := CommandSSAP;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: APPE <sp> file-name'; {do not localize}

  //ALLO <SP> <decimal-integer>
  //    [<SP> R <SP> <decimal-integer>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'ALLO';    {Do not Localize}
  LCmd.OnCommand := CommandALLO;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: ALLO allocate storage (vacuously)'; {do not localize}

  //REST <SP> <marker> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'REST';    {Do not Localize}
  LCmd.OnCommand := CommandREST;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: REST (restart command)'; {do not localize}

  //RNFR <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'RNFR';    {Do not Localize}
  LCmd.OnCommand := CommandRNFR;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: RNFR <sp> file-name'; {do not localize}

  //RNTO <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'RNTO';    {Do not Localize}
  LCmd.OnCommand := CommandRNTO;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: RNTO <sp> file-name'; {do not localize}

  //ABOR <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'ABOR';    {Do not Localize}
  LCmd.OnCommand := CommandABOR;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: ABOR (abort operation)'; {do not localize}

  //DELE <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'DELE';    {Do not Localize}
  LCmd.OnCommand := CommandDELE;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: DELE <sp> file-name'; {do not localize}

//  'SMNT        (structure mount); unimplemented.';

  //RMD  <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'RMD';    {Do not Localize}
  LCmd.OnCommand := CommandRMD;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: RMD <sp> path-name'; {do not localize}

  //MKD  <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MKD';    {Do not Localize}
  LCmd.OnCommand := CommandMKD;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: MKD <sp> path-name'; {do not localize}

  //PWD  <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'PWD';    {Do not Localize}
  LCmd.OnCommand := CommandPWD;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: PWD (return current directory)'; {do not localize}

  //LIST [<SP> <pathname>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'LIST';    {Do not Localize}
  LCmd.OnCommand := CommandLIST;
  LCmd.ExceptionReply.NumericCode := 450;
  LCmd.Description.Text := 'Syntax: LIST [ <sp> path-name ]'; {do not localize}

  //NLST [<SP> <pathname>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'NLST';    {Do not Localize}
  LCmd.OnCommand := CommandLIST;
  LCmd.ExceptionReply.NumericCode := 450;
  LCmd.Description.Text := 'Syntax: NLST [ <sp> path-name ]'; {do not localize}

  //SITE <SP> <string> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'SITE';    {Do not Localize}
  LCmd.OnCommand := CommandSITE;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: SITE (site-specific commands)';

  //SYST <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'SYST';    {Do not Localize}
  LCmd.OnCommand := CommandSYST;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: SYST (get type of operating system)'; {do not localize}

  //STAT [<SP> <pathname>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'STAT';    {Do not Localize}
  LCmd.OnCommand := CommandSTAT;
  LCmd.ExceptionReply.NumericCode := 450;
  LCmd.Description.Text := 'Syntax: CWD [ <sp> directory-name ]'; {do not localize}

  //NOOP <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'NOOP';    {Do not Localize}
  LCmd.NormalReply.SetReply(200, IndyFormat(RSFTPCmdSuccessful, ['NOOP']));    {Do not Localize}
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: NOOP'; {do not localize}

  //RFC 775
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XMKD';    {Do not Localize}
  LCmd.OnCommand := CommandMKD;
  LCmd.ExceptionReply.NumericCode := 551; //use the ones in parathensies
  LCmd.Description.Text := 'Syntax: XMKD <sp> path-name'; {do not localize}

  //XCWD  <SP> <pathname> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XCWD';    {Do not Localize}
  LCmd.OnCommand := CommandCWD;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: XCWD [ <sp> directory-name ]'; {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XRMD';    {Do not Localize}
  LCmd.OnCommand := CommandRMD;
  LCmd.ExceptionReply.NumericCode := 551; //use the ones in parathensies
  LCmd.Description.Text := 'Syntax: XRMD <sp> path-name'; {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XPWD';    {Do not Localize}
  LCmd.OnCommand := CommandPWD;
  LCmd.ExceptionReply.NumericCode := 502;
  LCmd.Description.Text := 'Syntax: PWD (return current directory)'; {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XCUP';    {Do not Localize}
  LCmd.OnCommand := CommandCDUP;
  LCmd.ExceptionReply.NumericCode := 551; //use the ones in parathensies
  LCmd.Description.Text := 'Syntax: XCUP (change to parent directory)'; {do not localize}

  //RFC 2389
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'FEAT';    {Do not Localize}
  LCmd.OnCommand := CommandFEAT;
  SetRFCReplyFormat(LCmd.NormalReply);
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: FEAT (returns feature list)'; {do not localize}

  //RFC 2389
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'OPTS';    {Do not Localize}
  LCmd.OnCommand := CommandOPTS;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: OPTS <sp> command [<sp> options]'; {do not localize}

  //SIZE [<FILE>] CRLF
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'SIZE';    {Do not Localize}
  LCmd.OnCommand := CommandSIZE;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: SIZE <sp> path-name'; {do not localize}

  //EPSV [protocol] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'EPSV';    {Do not Localize}
  LCmd.OnCommand := CommandEPSV;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: EPSV (returns port |||port|)'; {do not localize}

  //EPRT [address/port string] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'EPRT';    {Do not Localize}
  LCmd.OnCommand := CommandEPRT;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: EPRT <sp> |proto|addr|port|'; {do not localize}

  //MDTM [<FILE>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MDTM';    {Do not Localize}
  LCmd.OnCommand := CommandMDTM;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: MDTM <sp> path-name'; {do not localize}

  //RFC 2228
  //AUTH [Mechanism] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'AUTH';   {Do not translate}
  LCmd.OnCommand := CommandAUTH;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: AUTH <sp> mechanism-name'; {do not localize}

  //PBSZ [Protection Buffer Size] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'PBSZ';   {Do not translate}
  LCmd.OnCommand := CommandPBSZ;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: PBSZ <sp> protection buffer size'; {do not localize}

  //PROT Protection Type <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'PROT';   {Do not translate}
  LCmd.OnCommand := CommandPROT;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: PROT <sp> protection code'; {do not localize}

  //CCC Clear Command Channel
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'CCC';   {Do not translate}
  LCmd.OnCommand := CommandCCC;
  LCmd.Description.Text :=  'Syntax: CCC (clear command channel)'; {do not localize}

  //MIC Integrity Protected Command
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MIC';   {Do not translate}
  LCmd.OnCommand := CommandSecRFC;
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MIC         (integrity protected command); unimplemented.'; {do not localize}

  //CONF Confidentiality protected command
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'CONF';   {Do not translate}
  LCmd.OnCommand := CommandSecRFC;
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'CONF        (confidentiality protected command); unimplemented.'; {do not localize}

  //ENC Privacy Protected command
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'ENC';   {Do not translate}
  LCmd.OnCommand := CommandSecRFC;
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'ENC         (privacy protected command); unimplemented.'; {do not localize}

  //These are from IETF Draft "Extensions to FTP"
  //MLSD [Pathname] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MLSD';   {Do not translate}
  LCmd.OnCommand := CommandMLSD;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: MLSD [ <sp> path-name ]'; {do not localize}

  //MLST [Pathname] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MLST';   {Do not translate}
  LCmd.OnCommand := CommandMLST;
  SetRFCReplyFormat(LCmd.NormalReply);
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: MLST [ <sp> path-name ]'; {do not localize}

  //Defined in http://www.trevezel.com/downloads/draft-somers-ftp-mfxx-00.html
  //Modify File Modification Time
  //MFMT [ATime] [Path-name]<CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MFMT';   {Do not translate}
  LCmd.OnCommand := CommandMFMT;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: MFMT [ATime] [Path-name]<CRLF>'; {do not localize}

  //Defined in http://www.trevezel.com/downloads/draft-somers-ftp-mfxx-00.html
  //Modify File Creation Time
  //MFMT [ATime] [Pathname]<CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MFCT';   {Do not translate}
  LCmd.OnCommand := CommandMFCT;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: MFCT [ATime] [Path-name]'; {do not localize}

  //params are the same format as the MLS output
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MFF';   {Do not translate}
  LCmd.OnCommand := CommandMFF;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: MFF [ mff-facts ] SP path-name'; {do not localize}

  //From http://www.ietf.org/internet-drafts/draft-twine-ftpmd5-00.txt
  //MD5 [Pathname]
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MD5';   {Do not translate}
  LCmd.OnCommand := CommandMD5;
  LCmd.ExceptionReply.NumericCode := 504;
  LCmd.Description.Text := 'Syntax: MD5 [Pathname]'; {do not localize}

  //MMD5 [Filepath1], [Filepath2] [...]
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MMD5';   {Do not translate}
  LCmd.OnCommand := CommandMMD5;
  LCmd.ExceptionReply.NumericCode := 504;
  LCmd.Description.Text := 'Syntax: MMD5 [Filepath1], [Filepath2] [...]'; {do not localize}

  //These two commands are not in RFC's or drafts
  // but are documented in:
  // GlobalSCAPE Secure FTP Server User’s Guide
  //XCRC "[filename]" [start] [finish]
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XCRC';   {Do not translate}
  LCmd.OnCommand := CommandCheckSum;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: XCRC "[file-name]" [start] [finish]'; {do not localize}

  //COMB "[filename]" [start] [finish]
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'COMB';   {Do not translate}
  LCmd.OnCommand := CommandCOMB;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: COMB "[file-name]" [start] [finish]'; {do not localize}

  //informal but we might want to support this anyway
  //SSCN  - specified by:
  //http://www.raidenftpd.com/kb/kb000000037.htm
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'SSCN';  {Do not translate}
  LCmd.OnCommand := CommandSSCN;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.NormalReply.NumericCode := 200;
  LCmd.Description.Text := 'Syntax: SSCN [ON|OFF]'; {do not localize}

  //CPSV <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'CPSV';    {Do not Localize}
  LCmd.OnCommand := CommandCPSV;
  LCmd.Description.Text := 'Syntax: CPSV (set server in passive mode with SSL Connect)'; {do not localize}

  //Seen in RaidenFTPD documentation
  //XCRC "[filename]" [start] [finish]
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XMD5';   {Do not translate}
  LCmd.OnCommand := CommandCheckSum;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: XMD5 "[filename]" [start] [finish]'; {do not localize}

 //Seen in RaidenFTPD documentation
  //XCRC "[filename]" [start] [finish]
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XSHA1';   {Do not translate}
  LCmd.OnCommand := CommandCheckSum;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: XSHA1 "[filename]" [start] [finish]'; {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XSHA256';   {Do not translate}
  LCmd.OnCommand := CommandCheckSum;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'Syntax: XSHA256 "[filename]" [start] [finish]'; {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XSHA512';   {Do not translate}
  LCmd.OnCommand := CommandCheckSum;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.HelpVisible := True;
  LCmd.Description.Text := 'Syntax: XSHA512 "[filename]" [start] [finish]'; {do not localize}

//commands from
//      draft-peterson-streamlined-ftp-command-extensions-01.txt
//http://tools.ietf.org/html/draft-peterson-streamlined-ftp-command-extensions-01#section-2.4
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'AVBL';  {Do not localize}
  LCmd.OnCommand := CommandAVBL;
   LCmd.ExceptionReply.NumericCode := 500;
   LCmd.Description.Text := 'Syntax: AVBL [<sp> dirpath] (returns the number of '+
     'bytes available for uploading in the directory or current working directory)';

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'DSIZ';  {Do not localize}
  LCmd.OnCommand := CommandDSIZ;
  LCmd.ExceptionReply.NumericCode := 500;
  LCmd.Description.Text := 'DSIZ [<sp> dirpath] (returns the number of bytes '+
     'in the directory or current working directory, including sub directories)';

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'RMDA';
  LCmd.OnCommand := CommandRMDA;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.Description.Text := 'RMDA <sp> pathname (deletes (removes) the '+
     'specified directory and it s contents)';

  //informal but we might want to support this anyway
  //CLNT
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'CLNT'; {do not localize}
  LCmd.OnCommand := CommandCLNT;
  LCmd.ExceptionReply.NumericCode := 550;
  LCmd.NormalReply.SetReply(200, RSFTPClntNoted);  {Do not Localize}
  LCmd.Description.Text := 'Syntax: CLNT<space><clientname>'; {do not localize}

  //Informal - an old proposed solution to IPv6 support in FTP.
  //Mentioned at:  http://cr.yp.to/ftp/retr.html
  //and supported by PureFTPD.
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'SPSV'; {do not localize}
  LCmd.OnCommand := CommandSPSV;
  LCmd.Description.Text := 'Syntax: SPSV (set server in passive mode)'; {do not localize}

  LCmd := CommandHandlers.Add;
  LCmd.Command := 'HOST';  {Do not localize}
  LCmd.OnCommand := CommandHOST;
  LCmd.ExceptionReply.NumericCode := 504;
  LCmd.Description.Text := 'Syntax: HOST <sp> domain (select a domain prior to logging in)';  {Do not localize}

  //Note that these commands are mentioned in old RFC's
  //and we will not support them at all.  The commands
  //were there because FTP was a predisessor of SMTP
  //These are from RFC 765
    //MLFL [<SP> <ident>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MLFL';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['MLFL']));    {Do not Localize}
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MLFL        (mail file); unimplemented.'; {do not localize}

  //MAIL [<SP> <ident>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MAIL';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['MAIL']));    {Do not Localize}
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MAIL        (mail to user); unimplemented.'; {do not localize}

  //         MSND [<SP> <ident>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MSND';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['MSND']));    {Do not Localize}
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MSND        (mail send to terminal); unimplemented.'; {do not localize}

  //         MSOM [<SP> <ident>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MSOM';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['MSOM']));    {Do not Localize}
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MSOM        (mail send to terminal or mailbox); unimplemented.'; {do not localize}

  //         MSAM [<SP> <ident>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MSAM';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['MSAM']));    {Do not Localize}
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MSAM        (mail send to terminal and mailbox); unimplemented.'; {do not localize}

  //         MRSQ [<SP> <scheme>] <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MRSQ';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['MRSQ']));    {Do not Localize}
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MRSQ        (mail recipient scheme question); unimplemented.'; {do not localize}

  //         MRCP <SP> <ident> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'MRCP';    {Do not Localize}
  LCmd.NormalReply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['MRCP']));    {Do not Localize}
  LCmd.HelpSuperScript := '*';
  LCmd.Description.Text := 'MRCP        (mail recipient); unimplemented.'; {do not localize}
 //
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'HELP';     {Do not Localize}
  LCmd.OnCommand := COmmandHELP;
  LCmd.NormalReply.NumericCode := 214;
  LCmd.Description.Text := 'Syntax: HELP [ <sp> <string> ]'; {do not localize}

//We use a separate command handler collection for some things which are
//valid durring the data connection.
  //ABOR <CRLF>
  LCmd := FDataChannelCommands.Add;
  LCmd.Command := 'ABOR';    {Do not Localize}
  LCmd.OnCommand := CommandABOR;
  LCmd.ExceptionReply.NumericCode := 550;

  //STAT [<SP> <pathname>] <CRLF>
  LCmd := FDataChannelCommands.Add;
  LCmd.Command := 'STAT';    {Do not Localize}
  LCmd.OnCommand := CommandSTAT;
  LCmd.ExceptionReply.NumericCode := 450;

//This is for SITE commands to make it easy for the user to add their own site commands
//as they wish
  //These are Unix site commands
  LCmd := FSITECommands.Add;
  LCmd.Command := 'HELP'; {Do not localize}
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.OnCommand := CommandSiteHELP;
  LCmd.Description.Text := 'Syntax: SITE HELP [ <sp> <string> ]'; {do not localize}

  //SITE ATTRIB<SP>Attribs<SP>FileName<CRLF>
  LCmd := FSITECommands.Add;
  LCmd.Command := 'ATTRIB';    {Do not Localize}
  LCmd.OnCommand := CommandSiteATTRIB;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: SITE ATTRIB<SP>Attribs<SP>Filename'; {do not localize}

  //SITE UMASK<SP>[mask]
  LCmd := FSITECommands.Add;
  LCmd.Command := 'UMASK';    {Do not Localize}
  LCmd.OnCommand := CommandSiteUMASK;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: SITE UMASK'; {do not localize}
  //SITE CHMOD<SP>Permission numbers<SP>Filename<CRLF>
  LCmd := FSITECommands.Add;
  LCmd.Command := 'CHMOD';   {Do not Localize}
  LCmd.OnCommand := CommandSiteCHMOD;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: SITE CHMOD<SP>Permission numbers<SP>Filename'; {do not localize}

  //additional Unix server commands that aren't supported but should be supported, IMAO
  //SITE CHOWN<SP>Owner[:Group]<SP>Filename<CRLF>
  LCmd := FSITECommands.Add;
  LCmd.Command := 'CHOWN';   {Do not Localize}
  LCmd.OnCommand := CommandSiteCHOWN;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: SITE CHOWN<SP>Owner[:Group]<SP>Filename<CRLF>'; {do not localize}

  //SITE CHGRP<SP>Group<SP>Filename<CRLF>
  LCmd := FSITECommands.Add;
  LCmd.Command := 'CHGRP';   {Do not Localize}
  LCmd.OnCommand := CommandSiteCHGRP;
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.Description.Text := 'Syntax: SITE CHGRP<SP>Group<SP>Filename<CRLF>'; {do not localize}

  //Microsoft IIS SITE commands
  //SITE DIRSTYLE
  LCmd := FSITECommands.Add;
  LCmd.Command := 'DIRSTYLE';   {Do not Localize}
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.OnCommand := CommandSiteDIRSTYLE;
  LCmd.Description.Text := 'Syntax: SITE DIRSTYLE (toggle directory format)'; {do not localize}

  //SITE ZONE
  LCmd := FSITECommands.Add;
  LCmd.Command := 'ZONE'; {Do not localize}
  LCmd.ExceptionReply.NumericCode := 530;
  LCmd.OnCommand := CommandSiteZONE;
  LCmd.Description.Text := 'Syntax: SITE ZONE (returns the server offset from GMT)'; {do not localize}

  //SITE UTIME
  LCmd := FSITECommands.Add;
  LCmd.Command := 'UTIME'; {Do not localize}
  LCmd.NormalReply.NumericCode := 200;
  LCmd.NormalReply.Text.Text :=  'Date/time changed okay.';
  LCmd.ExceptionReply.NumericCode := 530;
  LCmd.OnCommand := CommandSiteUTIME;
  LCmd.Description.Text := 
  'Syntax:  SITE UTIME <file> <access-time> <modification-time> <creation time>'+CR+LF+ {do not localize}
  '         Each timestamp must be in the format YYYYMMDDhhmmss';          {do not localize}

  //OPTS MLST
  LCmd := FOPTSCommands.Add;
  LCmd.Command := 'MLST';  {Do not localize}
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.OnCommand := CommandOptsMLST;

  //OPTS MODE Z
  LCmd := FOPTSCommands.Add;
  LCmd.Command := 'MODE Z'; {Do not localize}
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.OnCommand := CommandOptsMODEZ;

  // OPTS UTF-8 <NLST>
  LCmd := FOPTSCommands.Add;
  LCmd.Command := 'UTF-8'; {Do not localize}
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.NormalReply.NumericCode := 200;
  LCmd.OnCommand := CommandOptsUTF8;

  // OPTS UTF8 <ON|OFF>
  LCmd := FOPTSCommands.Add;
  LCmd.Command := 'UTF8'; {Do not localize}
  LCmd.ExceptionReply.NumericCode := 501;
  LCmd.NormalReply.NumericCode := 200;
  LCmd.OnCommand := CommandOptsUTF8;

  //XAUT <SP> <xor encrypted data> <CRLF>
  LCmd := CommandHandlers.Add;
  LCmd.Command := 'XAUT';    {Do not Localize}
  LCmd.OnCommand := CommandXAUT;
  LCmd.Description.Text := 'Syntax: XAUT <sp> 2 <sp> <encrypted username and password>'; {do not localize}
end;

procedure TIdFTPServer.ContextCreated(AContext: TIdContext);
var
  LContext : TIdFTPServerContext;
begin
  LContext := (AContext as TIdFTPServerContext);
  LContext.Server := Self;
  //from Before run method
  LContext.FDataPort := 0;
  LContext.FPasswordAttempts := 0;
  LContext.FDataPortDenied := False;
  LContext.FUserSecurity.Assign(FTPSecurityOptions);
  if (DirFormat = ftpdfOSDependent) and (GOSType = otWindows) then begin
    LContext.MSDOSMode := True;
  end;
  //
  if mlsdUnixModes in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts + [UnixMODE];
  end;
  if mlsdUnixOwner in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts + [UnixOwner];
  end;
  if mlsdUnixGroup in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts + [UnixGroup];
  end;
  if mlsdFileCreationTime in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts + [CreateTime];
  end;
  if mlsdPerms in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts + [Perm];
  end;
  if mlsdUniqueID in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts +  [Unique];
  end;
  if mlsdFileLastAccessTime in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts +  [LastAccessTime];
  end;
  if mlsdWin32Attributes in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts + [WinAttribs];
  end;
  if mlsdWin32DriveType in FMLSDFacts then begin
     LContext.MLSOpts := LContext.MLSOpts + [WinDriveType];
  end;
  if mlstWin32DriveLabel in FMLSDFacts then begin
    LContext.MLSOpts := LContext.MLSOpts + [WinDriveLabel];
  end;
  //MS-DOS mode on for MS-DOS
  if FDirFormat = ftpdfDOS then begin
    LContext.FMSDOSMode := True;
  end;
end;

destructor TIdFTPServer.Destroy;
begin
  FreeAndNil(FAnonymousAccounts);
  FreeAndNil(FFTPSecurityOptions);
  FreeAndNil(FOPTSCommands);
  FreeAndNil(FDataChannelCommands);
  FreeAndNil(FSITECommands);
  FreeAndNil(FReplyUnknownSITECommand);
  inherited Destroy;
end;

procedure TIdFTPServer.ListDirectory(ASender: TIdFTPServerContext; ADirectory: string;
  ADirContents: TStrings; ADetails: Boolean; const ACmd : String = 'LIST';
  const ASwitches : String = ''); {do not localize}
var
  LDirectoryList: TIdFTPListOutput;
  LPathSep: string;
  LIsMLST: Boolean;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFilesystem;
begin
  LIsMLST := PosInStrArray(ACmd, ['MLSD', 'MLST']) <> -1; {do not localize}
  if (FDirFormat = ftpdfCustom) and (not LIsMLST) then begin
    DoOnCustomListDirectory(ASender, ADirectory, ADirContents, ACmd, ASwitches);
    Exit;
  end;
  LFileSystem := FFTPFileSystem;
  if Assigned(FOnListDirectory) or Assigned(LFileSystem) then begin
    LDirectoryList := TIdFTPListOutput.Create;
    try
      case FDirFormat of
      ftpdfEPLF :
        LDirectoryList.DirFormat := doEPLF;
      ftpdfDOS  :
        if ASender.FMSDOSMode then begin
          LDirectoryList.DirFormat := DoWin32;
        end else begin
          LDirectoryList.DirFormat := DoUnix;
        end;
      ftpdfOSDependent :
        if (GOSType = otWindows) and (ASender.FMSDOSMode) then begin
          LDirectoryList.DirFormat := DoWin32;
        end else begin
          LDirectoryList.DirFormat := DoUnix;
        end;
      else
        LDirectoryList.DirFormat := DoUnix;
      end;
      //someone might be using the STAT -l to get a dir without a data channel
      if IndyPos('l', ASwitches) > 0 then begin
        LDirectoryList.Switches := LDirectoryList.Switches + 'l';
      end;
      //we do things this way because the 'a' and 'T' swithces only make sense
      //when listing Unix dirs.
      if SupportTaDirSwitches(ASender) then begin
        if IndyPos('a', ASwitches) > 0 then begin
          LDirectoryList.Switches := LDirectoryList.Switches + 'a';
        end;
        if IndyPos('T', ASwitches) > 0 then begin
          LDirectoryList.Switches := LDirectoryList.Switches + 'T';
        end;
      end;
      LDirectoryList.ExportTotalLine := True;
      LPathSep := '/';    {Do not Localize}
      if not TextEndsWith(ADirectory, LPathSep) then begin
        ADirectory := ADirectory + LPathSep;
      end;
      if Assigned(LFileSystem) then begin
        LFileSystem.ListDirectory(ASender, ADirectory, LDirectoryList, ACmd, ASwitches);
      end else begin
        FOnListDirectory(ASender, ADirectory, LDirectoryList, ACmd, ASwitches); // Event
      end;
      if LIsMLST then begin    {Do not translate}
        LDirectoryList.MLISTOutputDir(ADirContents, ASender.MLSOpts);
      end
      else if ADetails then begin
        LDirectoryList.LISTOutputDir(ADirContents);
      end else begin
        LDirectoryList.NLISTOutputDir(ADirContents);
      end;
    finally
      FreeAndNil(LDirectoryList);
    end;
  end else begin
    raise EIdFTPServerNoOnListDirectory.Create(RSFTPNoOnDirEvent);    {Do not Localize}
  end;
end;

procedure TIdFTPServer.SetUserAccounts(const AValue: TIdCustomUserManager);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LUserAccounts: TIdCustomUserManager;
begin
  LUserAccounts := FUserAccounts;

  if LUserAccounts <> AValue then begin
    // under ARC, all weak references to a freed object get nil'ed automatically

    {$IFNDEF USE_OBJECT_ARC}
    if Assigned(LUserAccounts) then begin
      LUserAccounts.RemoveFreeNotification(Self);
    end;
    {$ENDIF}

    FUserAccounts := AValue;

    if Assigned(AValue) then begin
      {$IFNDEF USE_OBJECT_ARC}
      AValue.FreeNotification(Self);
      {$ENDIF}
      FOnUserAccount := nil;
      //XAUT can not work with an account manager that sends
      //a challange because that command is a USER/PASS rolled into
      //one command.
      if AValue.SendsChallange then begin
        FSupportXAUTH := False;
      end;
    end;
  end;
end;

procedure TIdFTPServer.SetFTPFileSystem(const AValue: TIdFTPBaseFileSystem);
begin
  {$IFDEF USE_OBJECT_ARC}
  // under ARC, all weak references to a freed object get nil'ed automatically
  FFTPFileSystem := AValue;
  {$ELSE}
  if FFTPFileSystem <> AValue then begin
    if Assigned(FFTPFileSystem) then begin
      FFTPFileSystem.RemoveFreeNotification(Self);
    end;
    FFTPFileSystem := AValue;
    if Assigned(AValue) then begin
      AValue.FreeNotification(Self);
    end;
  end;
  {$ENDIF}
end;

procedure TIdFTPServer.SetReplyUnknownSITECommand(AValue: TIdReply);
begin
  FReplyUnknownSITECommand.Assign(AValue);
end;

procedure TIdFTPServer.SetSITECommands(AValue: TIdCommandHandlers);
begin
  FSITECommands.Assign(AValue);
end;

// under ARC, all weak references to a freed object get nil'ed automatically
{$IFNDEF USE_OBJECT_ARC}
procedure TIdFTPServer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if Operation = opRemove then begin
    if AComponent = FUserAccounts then begin
      FUserAccounts := nil;
    end
    else if AComponent = FFTPFileSystem then begin
      FFTPFileSystem := nil;
    end;
  end;
  inherited Notification(AComponent, Operation);
end;
{$ENDIF}

procedure TIdFTPServer.SetAnonymousAccounts(const AValue: TStrings);
begin
  if Assigned(AValue) then begin
    FAnonymousAccounts.Assign(AValue);
  end;
end;

procedure TIdFTPServer.SetSupportXAUTH(AValue : Boolean);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LUserAccounts: TIdCustomUserManager;
begin
  if FSupportXAUTH <> AValue then begin
    LUserAccounts := FUserAccounts;
    if Assigned(LUserAccounts) then begin
      if LUserAccounts.SendsChallange then begin
        Exit;
      end;
    end;
    FSupportXAUTH := AValue;
  end;
end;

procedure TIdFTPServer.ThreadException(AThread: TIdThread; AException: Exception);
begin
  //we do not want to show an exception in a dialog-box
end;

//Command Replies/Handling
procedure TIdFTPServer.CommandUSER(ASender: TIdCommand);
var
  LSafe: Boolean;
  LChallenge: String;
  LContext: TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LUserAccounts: TIdCustomUserManager;
begin
  LChallenge := '';
  LContext := ASender.Context as TIdFTPServerContext;
  if (FUseTLS = utUseRequireTLS) and (LContext.AuthMechanism <> 'TLS') then begin {do not localize}
    DisconUser(ASender);
    Exit;
  end;
  LContext.Authenticated := False;
  if (FAnonymousAccounts.IndexOf(LowerCase(ASender.UnparsedParams)) >= 0) and AllowAnonymousLogin then  begin
    LContext.UserType := utAnonymousUser;
    LContext.Username := ASender.UnparsedParams;
    ASender.Reply.SetReply(331, RSFTPAnonymousUserOkay);
  end else begin
    LContext.UserType := utNormalUser;
    if Length(ASender.UnparsedParams) > 0 then begin
      LContext.Username := ASender.UnparsedParams;
      LUserAccounts := FUserAccounts;
      if Assigned(LUserAccounts) then begin
        LChallenge := LUserAccounts.ChallengeUser(LSafe, LContext.Username);
        {$IFDEF USE_OBJECT_ARC}LUserAccounts := nil;{$ENDIF}
        if not LSafe then begin
          //we do this to prevent a potential race attack
          DisconUser(ASender);
          Exit;
        end;
      end;
      if LChallenge = '' then begin
        ASender.Reply.SetReply(331, RSFTPUserOkay);
      end else begin
        ASender.Reply.SetReply(331, LChallenge);
      end;
    end else begin
      ASender.Reply.SetReply(332, RSFTPNeedAccountForLogin);
    end;
  end;
end;

procedure TIdFTPServer.AuthenticateUser(ASender: TIdCommand);
var
  LValidated: Boolean;
  LContext: TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LUserAccounts: TIdCustomUserManager;
begin
  LContext:= ASender.Context as TIdFTPServerContext;
  try
    LContext.FAuthenticated := False;
    case LContext.FUserType of
      utAnonymousUser:
      begin
        LValidated := Length(LContext.Password ) > 0;
        if FAnonymousPassStrictCheck and LValidated then begin
          LValidated := False;
          if FindFirstOf('@.', LContext.Password) > 0 then begin    {Do not Localize}
            LValidated := True;
          end;
        end;
        if LValidated then begin
          LContext.FAuthenticated := True;
          ASender.Reply.SetReply(230, RSFTPAnonymousUserLogged);
          if Assigned(OnLoginSuccessBanner) then begin
            OnLoginSuccessBanner(LContext, ASender.Reply);
            ASender.Reply.SetReply(230, ASender.Reply.Text.Text);
          end;
          LContext.FPasswordAttempts := 0;
        end else begin
          LContext.FUserType := utNone;
          LContext.FAuthenticated := False;
          LContext.FPassword := '';    {Do not Localize}
          Inc(LContext.FPasswordAttempts);
          if LContext.UserSecurity.InvalidPassDelay > 0 then begin
            //Delay our error response to slow down a dictionary attack
            IndySleep(FFTPSecurityOptions.InvalidPassDelay);
          end;
          if (LContext.UserSecurity.PasswordAttempts > 0) and
            (LContext.FPasswordAttempts >= LContext.UserSecurity.PasswordAttempts) then begin
            DisconUser(ASender);
            Exit;
          end;
          ASender.Reply.SetReply(530, RSFTPUserNotLoggedIn);
        end;
      end;
      utNormalUser:
      begin
        LUserAccounts := FUserAccounts;
        if Assigned(LUserAccounts) then begin
          LContext.FAuthenticated := LUserAccounts.AuthenticateUser(LContext.FUsername, ASender.UnparsedParams);
          {$IFDEF USE_OBJECT_ARC}LUserAccounts := nil;{$ENDIF}
          if LContext.FAuthenticated then begin
            LContext.FPasswordAttempts := 0;
            ASender.Reply.SetReply(230, RSFTPUserLogged);
          end else begin
            LContext.FPassword := '';    {Do not Localize}
            Inc(LContext.FPasswordAttempts);
            if LContext.UserSecurity.InvalidPassDelay > 0 then begin
              //Delay our error response to slow down a dictionary attack
              IndySleep(LContext.UserSecurity.InvalidPassDelay);
            end;
            if (LContext.UserSecurity.PasswordAttempts > 0) and
              (LContext.FPasswordAttempts >= LContext.UserSecurity.PasswordAttempts) then
            begin
              //Max login attempts exceeded, close the connection
              DisconUser(ASender);
              Exit;
            end;
            ASender.Reply.SetReply(530, RSFTPUserNotLoggedIn);
          end;
        end
        else if Assigned(FOnUserLogin) then begin
          LValidated := False;
          FOnUserLogin(LContext, LContext.FUsername, LContext.Password, LValidated);
          LContext.FAuthenticated := LValidated;
          if LValidated then begin
            if (LContext.AccountNeeded = True) and Assigned(FOnUserAccount) then begin
              LContext.FAuthenticated := False;
              ASender.Reply.SetReply(332,'Need account for login.');
              Exit;
            end else begin
              LContext.FAuthenticated := LValidated;
              ASender.Reply.SetReply(230, RSFTPUserLogged);
              if Assigned(OnLoginSuccessBanner) then begin
                OnLoginSuccessBanner(LContext, ASender.Reply);
                ASender.Reply.SetReply(230, ASender.Reply.Text.Text);
              end;
              LContext.FPasswordAttempts := 0;
            end;
          end else begin
            LContext.FPassword := '';    {Do not Localize}
            Inc(LContext.FPasswordAttempts);
            if (LContext.UserSecurity.PasswordAttempts > 0) and
              (LContext.FPasswordAttempts >= LContext.UserSecurity.PasswordAttempts) then begin
              //Max login attempts exceeded, close the connection
              DisconUser(ASender);
              Exit;
            end;
            ASender.Reply.SetReply(530, RSFTPUserNotLoggedIn);
          end;
        end else begin
          //APR 020423
          ASender.Reply.SetReply(530, RSFTPUserNotLoggedIn); // user manager not found
        end;
      end;
    else
      ASender.Reply.SetReply(503, RSFTPNeedLoginWithUser);
    end;//case
  except
    on E : Exception do begin
      ASender.Reply.SetReply(503, E.Message);
    end;
  end;
  //After login
  if LContext.FAuthenticated and Assigned(FOnAfterUserLogin) then begin
    FOnAfterUserLogin(LContext);
  end;
end;

procedure TIdFTPServer.CommandPASS(ASender: TIdCommand);
var
  LContext: TIdFTPServerContext;
begin
  LContext:= ASender.Context as TIdFTPServerContext;
  if (FUseTLS = utUseRequireTLS) and (LContext.AuthMechanism <> 'TLS') then begin {do not localize}
    DisconUser(ASender);
    Exit;
  end;
  LContext.FAuthenticated := False;
  LContext.FPassword := ASender.UnparsedParams;
  AuthenticateUser(ASender);
end;

procedure TIdFTPServer.CommandXAUT(ASender : TIdCommand);
var
  LContext : TIdFTPServerContext;
  s : String;
  LPos : Integer;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if (FUseTLS = utUseRequireTLS) and (LContext.AuthMechanism <> 'TLS') then begin {do not localize}
    DisconUser(ASender);
    Exit;
  end;
  LContext := ASender.Context as TIdFTPServerContext;
  s := ASender.UnparsedParams;
  s := IdFTPCommon.ExtractAutInfoFromXAUT(s, LContext.FXAUTKey );
  LPos := RPos(':',s);
  if LPos > 1 then  begin
    LContext.Username := Copy(s,1,LPos - 1);
    s := Copy(s,LPos + 1,$FF);
    //for some reason, WS-FTP Pro likes to add the string "^vta4r2" to
    //the authentication information if you aren't using anonymous login.
    //I'm not sure what the significance of "^vta4r2" really is.
    //                 1234567
    if TextEndsWith(s,'^vta4r2') then begin
      LContext.Password  := Copy(s,1,Length(s)-7);
    end;
  end else begin
    LContext.Username := s;
    LContext.Password := '';
  end;
  LContext.Authenticated := False;
  if (FAnonymousAccounts.IndexOf(LowerCase(ASender.UnparsedParams)) >= 0) and AllowAnonymousLogin then  begin
    LContext.UserType := utAnonymousUser;
  end else begin
    LContext.UserType := utNormalUser;
  end;
  AuthenticateUser(ASender);
end;

procedure TIdFTPServer.CommandACCT(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  LValidated : Boolean;
begin
  LValidated := False;
  if Assigned(FOnUserAccount) then begin
    LContext := ASender.Context as TIdFTPServerContext;
    LContext.Account := ASender.UnparsedParams;
    FOnUserAccount(LContext,LContext.Username, LContext.Password, LContext.Account, LValidated);
    LContext.Authenticated := LValidated;
    if LValidated then begin
       LContext.AccountNeeded := False;
       ASender.Reply.SetReply(230, RSFTPUserLogged);
       if Assigned(OnLoginSuccessBanner) then begin
         OnLoginSuccessBanner(LContext, ASender.Reply);
         ASender.Reply.SetReply(230, ASender.Reply.Text.Text);
         LContext.PasswordAttempts := 0;
       end;
    end else begin
       LContext.FPassword := '';    {Do not Localize}
       Inc(LContext.FPasswordAttempts);
       if (LContext.UserSecurity.PasswordAttempts > 0) and
         (LContext.FPasswordAttempts >= LContext.UserSecurity.PasswordAttempts) then begin
              //Max login attempts exceeded, close the connection
         DisconUser(ASender);
         Exit;
       end;
       ASender.Reply.SetReply(530, RSFTPUserNotLoggedIn);
    end;
  end else begin
    ASender.Reply.SetReply(502, IndyFormat(RSFTPCmdNotImplemented, ['ACCT'])); {do not localize}
  end;
end;

procedure TIdFTPServer.CommandCWD(ASender: TIdCommand);
var
  s: TIdFTPFileName;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFilesystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  s := ASender.UnparsedParams;
  if LContext.IsAuthenticated(ASender) then begin
    s := IgnoreLastPathDelim(s);
    LFileSystem := FFTPFileSystem;
    if Assigned(OnChangeDirectory) or Assigned(LFileSystem) then begin
      if  s = '..' then begin {do not localize}
        s := CDUPDir(LContext);
      end
      else if s = '.' then begin {do not localize}
        s := LContext.CurrentDir;
      end else begin
        s := DoProcessPath(LContext, s);
      end;
      s := RemoveDuplicatePathSyms(s);
      DoOnChangeDirectory(LContext, s);
      LContext.CurrentDir := s;
      CmdCommandSuccessful(ASender);
    end else begin
      CmdNotImplemented(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandCDUP(ASender: TIdCommand);
var
  s: TIdFTPFileName;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    s := CDUPDir(LContext);
    s := DoProcessPath(LContext, s);
    LFileSystem := FFTPFileSystem;
    if Assigned(FOnChangeDirectory) or Assigned(LFileSystem) then begin
      DoOnChangeDirectory(LContext, s);
      LContext.FCurrentDir := s;
      ASender.Reply.SetReply(250, IndyFormat(RSFTPCurrentDirectoryIs, [LContext.FCurrentDir]));
    end else begin
      CmdNotImplemented(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandREIN(ASender: TIdCommand);
var
  LIO : TIdSSLIOHandlerSocketBase;
  LContext :  TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    LContext.ReInitialize;
    LContext.Connection.IOHandler.DefStringEncoding := IndyTextEncoding_8Bit;
    ASender.Reply.SetReply(220, RSFTPServiceOpen);
    if (FUseTLS in ExplicitTLSVals) then begin
      LIO := ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase;
      if not LIO.PassThrough then begin
        LIO.PassThrough := True;
      end;
      LContext.FCCC := False;
    end;
  end;
end;

procedure TIdFTPServer.CommandPORT(ASender: TIdCommand);
var
  LLo, LHi : Integer;
  LPort: TIdPort;
  LParm, LIP : string;
  LContext : TIdFTPServerContext;
  LDataChannel: TIdTCPClient;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if LContext.FEPSVAll then begin
      ASender.Reply.SetReply(501, IndyFormat(RSFTPNotAllowedAfterEPSVAll, [ASender.CommandHandler.Command]));
      Exit;
    end;
    if LContext.UserSecurity.BlockAllPORTTransfers then
    begin
      LContext.FDataPort := 0;
      LContext.FDataPortDenied := True;
      ASender.Reply.SetReply(502, RSFTPPORTDisabled);
      Exit;
    end;
    LContext.FPASV := False;
    LParm := ASender.UnparsedParams;
    LIP := '';    {Do not Localize}
    { h1 }
    LIP := LIP + Fetch(LParm, ',') + '.';    {Do not Localize}
    { h2 }
    LIP := LIP + Fetch(LParm, ',') + '.';    {Do not Localize}
    { h3 }
    LIP := LIP + Fetch(LParm, ',') + '.';    {Do not Localize}
    { h4 }
    LIP := LIP + Fetch(LParm, ',');          {Do not Localize}
    { p1 }
    LLo := IndyStrToInt(Fetch(LParm, ','));    {Do not Localize}
    { p2 }
    LHi := IndyStrToInt(LParm);
    LPort := TIdPort((LLo * 256) + LHi);
    if LContext.UserSecurity.NoReservedRangePORT and
      ((LPort > 0) and (LPort <= 1024)) then begin
      LContext.FDataPort := 0;
      LContext.FDataPortDenied := True;
      ASender.Reply.SetReply(504, RSFTPPORTRange);
      Exit;
    end;
    {//BGO}
    if LContext.UserSecurity.FRequirePORTFromSameIP and
      (LIP <> LContext.Binding.PeerIP) then begin
      LContext.FDataPort := 0;
      LContext.FDataPortDenied := True;
      ASender.Reply.SetReply(504, RSFTPSameIPAddress);
      Exit;
    end;
    {//BGO}
    LContext.CreateDataChannel(False);
    LDataChannel := TIdTCPClient(LContext.FDataChannel.FDataChannel);
    LDataChannel.Host := LIP;
    LDataChannel.Port := LPort;
    LDataChannel.IPVersion := Id_IPv4;
    LContext.FDataPort := LPort;
    LContext.FDataPortDenied := False;
    CmdCommandSuccessful(ASender, 200);
  end;
end;

procedure TIdFTPServer.CommandPASV(ASender: TIdCommand);
var
  LParam: string;
  LBPort: Word;
  LIPVersion : TIdIPVersion;
begin
  //InternalPASV does all of the checking
  if InternalPASV(ASender, LParam, LBPort, LIPVersion) then begin
    DoOnPASVReply(TIdFTPServerContext(ASender.Context), LParam, LBPort, LIPVersion);
    LParam := ReplaceAll(LParam, '.', ',');    {Do not Localize}
    LParam := LParam + ',' + IntToStr(LBPort div 256) + ',' + IntToStr(LBPort mod 256);    {Do not Localize}
    ASender.Reply.SetReply(227, IndyFormat(RSFTPPassiveMode, [LParam]));
  end;
end;

procedure TIdFTPServer.CommandTYPE(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  s: string;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    s := ASender.UnparsedParams;
    s := UpperCase(Fetch(s));
    if Length(s) = 1 then begin
      //Default data type is ASCII
      case s[1] of
        'A': LContext.FDataType := ftASCII;    {Do not Localize}
        'I': LContext.FDataType := ftBinary;   {Do not Localize}
        else Exit;
      end;
      ASender.Reply.SetReply(200, IndyFormat(RSFTPTYPEChanged, [s]));
    end;
  end;
end;

procedure TIdFTPServer.CommandSTRU(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  s: String;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    s := ASender.UnparsedParams;
    s := UpperCase(Fetch(s));
    if Length(s) = 1 then begin
      //Default structure is file
      case s[1] of
        'F': LContext.FDataStruct := dsFile;    {Do not Localize}
        'R': LContext.FDataStruct := dsRecord;  {Do not Localize}
        'P': LContext.FDataStruct := dsPage;    {Do not Localize}
        else Exit;
      end;
      ASender.Reply.SetReply(200, IndyFormat(RSFTPSTRUChanged, [s]));
    end;
  end;
end;

procedure TIdFTPServer.CommandMODE(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  s: String;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if LContext.IsAuthenticated(ASender) then begin
    s := ASender.UnparsedParams;
    s := UpperCase(Fetch(s));
    if Length(s) = 1 then begin
      //Default data mode is stream
      case s[1] of
        'S' : //stream mode
        begin
          LContext.DataMode := dmStream;
          ASender.Reply.SetReply(200, IndyFormat(RSFTPMODEChanged, [s]));
          Exit;
        end;
        'Z' : //deflate
        begin
          if Assigned(FCompressor) then begin
            LContext.DataMode := dmDeflate;
            ASender.Reply.SetReply(200, IndyFormat(RSFTPMODEChanged, [s]));
            Exit;
          end;
        end;
      end;
      ASender.Reply.SetReply(504, RSFTPMODENotSupported);
    end;
  end;
end;

procedure TIdFTPServer.CommandRETR(ASender: TIdCommand);
var
  s: string;
  LStream: TStream;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if (not Assigned(LContext.FDataChannel)) or LContext.FDataPortDenied then begin
      ASender.Reply.SetReply(425, RSFTPCantOpenData);
      Exit;
    end;
    //TODO: Fix reference to /
    s := DoProcessPath(LContext, ASender.UnparsedParams);
    LFileSystem := FFTPFileSystem;
    if Assigned(FOnRetrieveFile) or Assigned(LFileSystem) then begin
      LStream := nil;
      try
        //some file stream creations can fail with an exception so
        //we need to handle this gracefully.
        if Assigned(LFileSystem) then begin
          LFileSystem.RetrieveFile(LContext, s, LStream)
        end else begin
          FOnRetrieveFile(LContext, s, LStream);
        end;
      except
        on E : Exception do begin
          LContext.KillDataChannel;
          ASender.Reply.SetReply(550, E.Message);
          Exit;
        end;
      end;
      if Assigned(LStream) then begin
        try
          LStream.Position := LContext.FRESTPos;
          LContext.FRESTPos := 0;
          //it should be safe to assume that the FDataChannel object exists because
          //we checked it earlier
          LContext.FDataChannel.FFtpOperation := ftpRetr;
          LContext.FDataChannel.FData := LStream;
          LContext.FDataChannel.OKReply.SetReply(226, RSFTPDataConnClosed);
          LContext.FDataChannel.ErrorReply.SetReply(426, RSFTPDataConnClosedAbnormally);
          ASender.Reply.SetReply(150, RSFTPDataConnToOpen);
          ASender.SendReply;
          DoDataChannelOperation(ASender, LContext.SSCNOn);
        finally
          LStream.Free;
        end;
      end else begin
        //make sure the data connection is closed
        LContext.KillDataChannel;
        CmdFileActionAborted(ASender);
      end;
    end else begin
      //make sure the data connection is closed
      LContext.KillDataChannel;
      CmdNotImplemented(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandSSAP(ASender: TIdCommand);
var
  LStream: TStream;
  LTmp1: string;
  LAppend: Boolean;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if (not Assigned(LContext.FDataChannel)) or LContext.FDataPortDenied then begin
      ASender.Reply.SetReply(425, RSFTPCantOpenData);
      Exit;
    end;
    if TextIsSame(ASender.CommandHandler.Command, 'STOU') then begin   {Do not Localize}
      LTmp1 := GetUniqueFileName('', 'Temp', ''); {Do not localize}
      //This is a standardized format
      ASender.Reply.SetReply(150, IndyFormat('FILE: %s', [LTmp1]));  {Do not translate}
    end else begin
      LTmp1 := ASender.UnparsedParams;
      ASender.Reply.SetReply(150, RSFTPDataConnToOpen);
    end;
    LTmp1 := DoProcessPath(LContext, LTmp1);
    LAppend := TextIsSame(ASender.CommandHandler.Command, 'APPE');    {Do not Localize}

    LFileSystem := FFTPFileSystem;
    if Assigned(FOnStoreFile) or Assigned(LFileSystem) then begin
      LStream := nil;
      try
        if Assigned(LFileSystem) then begin
          LFileSystem.StoreFile(LContext, LTmp1, LAppend, LStream);
          {$IFDEF USE_OBJECT_ARC}LFileSystem := nil;{$ENDIF}
        end else begin
          FOnStoreFile(LContext, LTmp1, LAppend, LStream);
        end;
      except
        on E : Exception do
        begin
          ASender.Reply.SetReply(550, E.Message);
          LContext.KillDataChannel;
          Exit;
        end;
      end;
      if Assigned(LStream) then  begin
        try
          //Issued previously by ALLO cmd
          if LContext.ALLOSize > 0 then begin
            LStream.Size := LContext.FALLOSize;
          end;
          if LAppend then begin
            TIdStreamHelper.Seek(LStream, 0, soEnd);
          end else begin
            LStream.Position := LContext.FRESTPos;
            LContext.FRESTPos := 0;
          end;
          { Data transfer }
          //it should be safe to assume that the FDataChannel object exists because
          //we checked it earlier
          LContext.FDataChannel.FFtpOperation := ftpStor;
          LContext.FDataChannel.Data := LStream;
          LContext.FDataChannel.OKReply.SetReply(226, RSFTPDataConnClosed);
          LContext.FDataChannel.ErrorReply.SetReply(426, RSFTPDataConnClosedAbnormally);
          ASender.SendReply;
          DoDataChannelOperation(ASender, LContext.SSCNOn);
        finally
          LStream.Free;
        end;
      end else begin
        //make sure the data connection is closed
        LContext.KillDataChannel;
        CmdFileActionAborted(ASender);
      end;
    end else begin
      //make sure the data connection is closed
      LContext.KillDataChannel;
      CmdNotImplemented(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandALLO(ASender: TIdCommand);
var
  LContext: TIdFTPServerContext;
  LALLOSize, s: string;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if LContext.IsAuthenticated(ASender) then begin
    LALLOSize := '';
    if Length(ASender.UnparsedParams) > 0 then begin
      if TextStartsWith(ASender.UnparsedParams, 'R ') then begin {Do not localize}
        LALLOSize := TrimLeft(Copy(s, 3, MaxInt));
      end else begin
        LALLOSize := TrimLeft(ASender.UnparsedParams);
      end;
      LALLOSize := Fetch(LALLOSize);
    end;
    if LALLOSize <> '' then begin
      LContext.FALLOSize := IndyStrToInt(LALLOSize, 0);
      CmdCommandSuccessful(ASender, 200);
    end else begin
      ASender.Reply.SetReply(504, RSFTPInvalidForParam);
    end;
  end;
end;

procedure TIdFTPServer.CommandREST(ASender: TIdCommand);
var
  LContext: TIdFTPServerContext;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if LContext.IsAuthenticated(ASender) then begin
    LContext.FRESTPos := IndyStrToInt(ASender.UnparsedParams, 0);
    ASender.Reply.SetReply(350, RSFTPFileActionPending);
  end;
end;

procedure TIdFTPServer.CommandRNFR(ASender: TIdCommand);
var
  LContext: TIdFTPServerContext;
  s: string;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if LContext.IsAuthenticated(ASender) then begin
    s := ASender.UnparsedParams;
    if Assigned(FOnRenameFile) or Assigned(FTPFileSystem) then begin
      ASender.Reply.SetReply(350, RSFTPFileActionPending);
      LContext.FRNFR := DoProcessPath(TIdFTPServerContext(LContext), s);
    end else begin
      CmdNotImplemented(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandRNTO(ASender: TIdCommand);
var
  s: string;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    s := ASender.UnparsedParams;
    LFileSystem := FFTPFileSystem;
    if Assigned(LFileSystem) or Assigned(FOnRenameFile) then begin
      DoOnRenameFile(LContext, LContext.FRNFR, DoProcessPath(LContext, s));
      ASender.Reply.NumericCode := 250;
    end else begin
      CmdNotImplemented(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandABOR(ASender: TIdCommand);
var
  LContext: TIdFTPServerContext;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(LContext.FDataChannel) then begin
      if not LContext.FDataChannel.Stopped then begin
        LContext.FDataChannel.OkReply.SetReply(426, RSFTPDataConnClosedAbnormally);
        LContext.FDataChannel.ErrorReply.SetReply(426, RSFTPDataConnClosedAbnormally);
        LContext.KillDataChannel;
        ASender.Reply.SetReply(226, RSFTPDataConnClosed);
        Exit;
      end;
    end;
    CmdCommandSuccessful(ASender, 226);
  end;
end;

procedure TIdFTPServer.CommandDELE(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
(*
DELE <SP> <pathname> <CRLF>
  250 Requested file action okay, completed.
  450 Requested file action not taken. - File is busy
  550 Requested action not taken. - File unavailable, no access permitted, etc
  500 Syntax error, command unrecognized.
  501 Syntax error in parameters or arguments.
  502 Command not implemented.
  421 Service not available, closing control connection. - During server shutdown, etc
  530 Not logged in.
*)
//TODO: Need to set replies when not authenticated and set NormalReply to 250
// do for all procs, list valid replies in comments. Or maybe default is 550
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    LFileSystem := FTPFileSystem;
    if Assigned(FOnDeleteFile) or Assigned(LFileSystem) then begin
      DoOnDeleteFile(LContext, DoProcessPath(LContext, ASender.UnparsedParams));
      ASender.Reply.SetReply(250, RSFTPFileActionCompleted);
    end else begin
      CmdNotImplemented(ASender);
    end;
  end else begin
    ASender.Reply.SetReply(550, RSFTPFileActionNotTaken);
  end;
end;

procedure TIdFTPServer.CommandRMD(ASender: TIdCommand);
var
  s: TIdFTPFileName;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    S := IgnoreLastPathDelim(S);
    s := DoProcessPath(LContext, ASender.UnparsedParams);
    LFileSystem := FFTPFileSystem;
    if Assigned(LFileSystem) or Assigned(FOnRemoveDirectory) then begin
      DoOnRemoveDirectory(LContext, s);
      ASender.Reply.SetReply(250, RSFTPFileActionCompleted);
    end else begin
      CmdNotImplemented(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandMKD(ASender: TIdCommand);
var
  S: TIdFTPFileName;
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    S := IgnoreLastPathDelim(S);
    S := DoProcessPath(LContext, ASender.UnparsedParams);
    DoOnMakeDirectory(LContext, s);
    ASender.Reply.SetReply(257, RSFTPFileActionCompleted);
  end;
end;

procedure TIdFTPServer.CommandPWD(ASender: TIdCommand);
var
  LContext: TIdFTPServerContext;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if LContext.IsAuthenticated(ASender) then begin
    ASender.Reply.SetReply(257, IndyFormat(RSFTPCurrentDirectoryIs, [LContext.FCurrentDir]));
  end;
end;

procedure TIdFTPServer.CommandLIST(ASender: TIdCommand);
var
  LStream: TStringList;
  LSendData : Boolean;
  LPath, LSwitches : String;
  LContext : TIdFTPServerContext;

  function DeletRSwitch(const AString : String): String;
  var
    i : Integer;
  begin
    Result := '';
    for i := 1 to Length(AString) do begin
      if AString[i] <> 'R' then begin
        Result := Result + AString[i];
      end;
    end;
  end;

begin
  LSendData := False;
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if (not Assigned(LContext.FDataChannel)) or LContext.FDataPortDenied then begin
      ASender.Reply.SetReply(425, RSFTPCantOpenData);
      Exit;
    end;
    if (not Assigned(FOnListDirectory)) and
     ((FDirFormat = ftpdfCustom) and (not Assigned(FOnCustomListDirectory))) then begin
      LContext.KillDataChannel;
      CmdNotImplemented(ASender);
      Exit;
    end;
    LStream := TStringList.Create;
    try
      LSwitches := '';
      LPath := ASender.UnparsedParams;
      if TextStartsWith(LPath, '-') then begin {Do not Localize}
        LSwitches := Fetch(LPath);
      end;
      //we can't support recursive lists with EPLF
      if DirFormat = ftpdfEPLF then begin
        LSwitches := DeletRSwitch(LSwitches);
      end;
      ListDirectory(LContext, DoProcessPath(LContext, LPath), LStream,
        TextIsSame(ASender.CommandHandler.Command, 'LIST'), ASender.CommandHandler.Command,
        LSwitches);
      LSendData := True;
    finally
      try
        if LSendData then begin
          //it should be safe to assume that the FDataChannel object exists because
          //we checked it earlier
          LContext.FDataChannel.Data := LStream;
          LContext.FDataChannel.FFtpOperation := ftpRetr;
          LContext.FDataChannel.OKReply.SetReply(226, RSFTPDataConnClosed);
          LContext.FDataChannel.ErrorReply.SetReply(426, RSFTPDataConnClosedAbnormally);
          if FDirFormat = ftpdfEPLF then begin
            ASender.Reply.SetReply(125, RSFTPDataConnToOpen);
            LContext.FDataChannel.OKReply.SetReply(226, RSFTPDataConnClosed);
          end
          else if TextIsSame(ASender.CommandHandler.Command, 'LIST') or (LSwitches <> '') then begin {do not localize}
            ASender.Reply.SetReply(125, RSFTPDataConnList);
          end else begin
            ASender.Reply.SetReply(125, RSFTPDataConnNList);
          end;
          ASender.SendReply;
          DoDataChannelOperation(ASender);
        end else begin
          LContext.KillDataChannel;
          ASender.Reply.SetReply(426, RSFTPDataConnClosedAbnormally);
        end;
      finally
        LStream.Free;
      end;
    end;
  end;
end;

procedure TIdFTPServer.DoDataChannelOperation(ASender: TIdCommand; const AConnectMode : Boolean = False);
const
  DEF_BLOCKSIZE = 10*10240;
  {CH DEF_CHECKCMD_WAIT = 1; }
var
  LContext : TIdFTPServerContext;
  LCmdQueue : TStringList;
  LLine : String;
  LStrm : TStream;

  procedure CheckControlConnection(AContext : TIdFTPServerContext; ACmdQueue : TStrings);
  var
    LLocalLine : String;
  begin
    // TODO: rewrite this to wait on both control and data sockets at the same
    // time and read a command only if the control socket is actually readable...
    LLocalLine := ReadCommandLine(AContext);
    if LLocalLine <> '' then begin
      if not FDataChannelCommands.HandleCommand(AContext, LLocalLine) then begin
        ACmdQueue.Add(LLocalLine);
      end;
    end;
  end;

  procedure ReadFromStream(AContext : TIdFTPServerContext; ACmdQueue : TStrings; ADestStream : TStream);
  var
    LM : TStream;
  begin
    if AContext.DataMode = dmDeflate then begin
      LM := TMemoryStream.Create;
    end else begin
      LM := ADestStream;
    end;
    try
      repeat
        AContext.FDataChannel.FDataChannel.IOHandler.CheckForDisconnect(False);
        AContext.FDataChannel.FDataChannel.IOHandler.ReadStream(LM, DEF_BLOCKSIZE, True);
        CheckControlConnection(AContext, ACmdQueue);
      until not AContext.FDataChannel.FDataChannel.IOHandler.Connected;
      if AContext.DataMode = dmDeflate then begin
        LM.Position := 0;
        FCompressor.DecompressFTPDeflate(LM, ADestStream, AContext.ZLibWindowBits);
      end;
    finally
      if AContext.DataMode = dmDeflate then begin
        FreeAndNil(LM);
      end;
    end;
  end;

  procedure WriteToStream(AContext : TIdFTPServerContext; ACmdQueue : TStrings;
    ASrcStream : TStream; const AIgnoreCompression : Boolean = False);
  var
    LBufSize : TIdStreamSize;
    LOutStream : TStream;
  begin
    if AContext.DataMode = dmDeflate then begin
      LOutStream := TMemoryStream.Create;
    end else begin
      LOutStream := ASrcStream;
    end;
    try
      if AContext.DataMode = dmDeflate then begin
        FCompressor.CompressFTPDeflate(ASrcStream, LOutStream,
          AContext.ZLibCompressionLevel, AContext.ZLibWindowBits,
          AContext.ZLibMemLevel, AContext.ZLibStratagy);
        LOutStream.Position := 0;
      end;
      repeat
        LBufSize := LOutStream.Size - LOutStream.Position;
        if LBufSize > DEF_BLOCKSIZE then begin
           LBufSize := DEF_BLOCKSIZE;
        end;
        if LBufSize > 0 then begin
          AContext.FDataChannel.FDataChannel.IOHandler.Write(LOutStream, LBufSize, False);
          if LOutStream.Position < LOutStream.Size then begin
            CheckControlConnection(AContext, ACmdQueue);
          end;
        end;
      until (LBufSize = 0) or (not AContext.FDataChannel.FDataChannel.IOHandler.Connected);
    finally
      if AContext.DataMode = dmDeflate then begin
        FreeAndNil(LOutStream);
      end;
    end;
  end;

  procedure WriteStrings(AContext : TIdFTPServerContext; ACmdQueue : TStrings; ASrcStrings : TStrings);
  var
    i : Integer;
    LM : TStream;
    LEncoding: IIdTextEncoding;
  begin
    //for loops will execute at least once triggering an out of range error.
    //write nothing if AStrings is empty.
    if ASrcStrings.Count < 1 then begin
      Exit;
    end;
    {
    IMPORTANT!!!

    If LIST data is sent as 8bit, you have a FTP list that is unparsable by
    some FTP clients.  If UTF8 OPTS OFF, you should send the data as 7bit
    for the LIST and NLST commands.  That way, unprintable charactors are
    returned as ?.  While the file name is not valid, at least, there some
    thing that looks better than binary junk.
    }
    case PosInStrArray(ASender.CommandHandler.Command, ['LIST', 'NLST', 'MLSD'], False) of {do not localize}
      0, 1: begin
        LEncoding := IndyTextEncoding(NLSTEncType[AContext.NLSTUtf8]);
      end;
      2: begin
        LEncoding := IndyTextEncoding_UTF8;
      end;
      else begin
        LEncoding := IndyTextEncoding_8Bit;
      end;
    end;

    if AContext.DataMode = dmDeflate then begin
      LM := TMemoryStream.Create;
      try
        for i := 0 to ASrcStrings.Count-1 do begin
          WriteStringToStream(LM, ASrcStrings[i] + EOL, LEncoding);
        end;
        LM.Position := 0;
        WriteToStream(AContext, ACmdQueue, LM, True);
      finally
        FreeAndNil(LM);
      end;
      Exit;
    end;
    for i := 0 to ASrcStrings.Count-1 do begin
      if AContext.FDataChannel.FDataChannel.IOHandler.Connected then begin
        AContext.FDataChannel.FDataChannel.IOHandler.WriteLn(ASrcStrings[i], LEncoding);
        if ((i mod 10) = 0) and (i <> (ASrcStrings.Count-1)) then begin
          if AContext.FDataChannel.FDataChannel.IOHandler.Connected then begin
            CheckControlConnection(AContext, ACmdQueue);
          end else begin
            Break;
          end;
        end;
      end else begin
        Break;
      end;
    end;
  end;

begin
  if not Assigned(ASender) then begin
    Exit;
  end;
  if not Assigned(ASender.Context) then begin
    Exit;
  end;
  LContext := ASender.Context as TIdFTPServerContext;
  if not Assigned(LContext.FDataChannel) then begin
    Exit;
  end;
  try
    LCmdQueue := TStringList.Create;
    try
      LContext.FDataChannel.InitOperation(AConnectMode);
      try
        try
          try
            if LContext.FDataChannel.Data is TStream then begin
              LStrm := TStream(LContext.FDataChannel.Data);
              case LContext.FDataChannel.FFtpOperation of
                ftpRetr:
                  WriteToStream(LContext, LCmdQueue, LStrm);
                ftpStor:
                  ReadFromStream(LContext, LCmdQueue, LStrm);
              end;
            end else begin
              case LContext.FDataChannel.FFtpOperation of
                ftpRetr:
                  if Assigned(LContext.FDataChannel.Data) then begin
                    WriteStrings(LContext, LCmdQueue, LContext.FDataChannel.Data as TStrings);
                  end;
                ftpStor:
                  if Assigned(LContext.FDataChannel.Data) then begin
                    LStrm := TMemoryStream.Create;
                    try
                      ReadFromStream(LContext, LCmdQueue, LStrm);
                      //TODO;
                     // SplitLines(TMemoryStream(LStrm).Memory, LMemStream.Size, LContext.FDataChannel.FData as TStrings);
                    finally
                      LStrm.Free;
                    end;
                  end;//ftpStor
              end;//case
            end;
          finally
            if Assigned(LContext.FDataChannel.FDataChannel) then begin
              LContext.FDataChannel.FDataChannel.Disconnect(False);
            end;
          end;
          LContext.FDataChannel.FReply.Assign(LContext.FDataChannel.FOKReply); //226
        except
          on E: Exception do begin
            if not (E is EIdSilentException) then begin
              LContext.FDataChannel.FReply.Assign(LContext.FDataChannel.FErrorReply); //426
            end;
          end;
        end;
      finally
        ASender.Reply.Assign(LContext.FDataChannel.FReply);
        ASender.SendReply;
        //now we have to handle the FIFO queue we had made
        while LCmdQueue.Count > 0 do begin
          LLine := LCmdQueue[0];
          if not FCommandHandlers.HandleCommand(ASender.Context, LLine) then begin
            DoReplyUnknownCommand(ASender.Context, LLine);
          end;
          if Assigned(ASender.Context.Connection) then begin
            if not ASender.Context.Connection.Connected then begin
              Break;
            end;
          end else begin
            Break;
          end;
          LCmdQueue.Delete(0);
        end;
      end;
    finally
      FreeAndNil(LCmdQueue);
    end;
  finally
    FreeAndNil(LContext.FDataChannel);
  end;
end;

procedure TIdFTPServer.CommandSYST(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.UserSecurity.DisableSYSTCommand then begin
    CmdNotImplemented(ASender);
    Exit;
  end;
  //this should keep CuteFTP Pro 3.0 from stopping there's no custom ID and
  //the Dir format is custonm.
  if (FDirFormat = ftpdfCustom) and (Trim(FCustomSystID) = '') then begin
    CmdNotImplemented(ASender);
    Exit;
  end;
  if LContext.IsAuthenticated(ASender) then begin
    ASender.Reply.SetReply(215, DoSysType(LContext));
  end;
end;

procedure TIdFTPServer.CommandSTAT(ASender: TIdCommand);
var
  LStream: TStringList;
  LActAsList: boolean;
  LSwitches, LPath : String;
  i : Integer;
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  LActAsList := (ASender.Params.Count > 0);
  if not LActAsList then begin
    if LContext.UserSecurity.DisableSTATCommand then begin
      if ASender.UnparsedParams = '' then begin
        CmdNotImplemented(ASender);
        Exit;
      end;
    end;
  end;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(LContext.DataChannel) then begin
      if not LContext.DataChannel.Stopped then begin
        LActAsList := False;
      end;
    end;
    if not LActAsList then begin
      ASender.Reply.NumericCode := 211;
      ASender.Reply.Text.Clear;
      if Assigned(FOnStat) then begin
        LStream := TStringList.Create;
        try
          SetRFCReplyFormat(ASender.Reply);
          FOnStat(LContext, LStream);
          for i := 0 to LStream.Count - 1 do begin
            ASender.Reply.Text.Add('    ' + TrimLeft(LStream[i])); {Do not Localize}
          end;
        finally
          FreeAndNil(LStream);
        end;
      end;
      ASender.Reply.Text.Insert(0,RSFTPCmdStartOfStat);
      ASender.Reply.Text.Add(RSFTPCmdEndOfStat);
    end else begin //else act as LIST command without a data channel
      LStream := TStringList.Create;
      try
        LSwitches := '';
        LPath := ASender.UnparsedParams;
        if TextStartsWith(LPath, '-') then begin
          LSwitches := Fetch(LPath);
        end;
        ListDirectory(LContext, DoProcessPath(LContext, LPath), LStream, True, LSwitches);
        //we use IOHandler.WriteLn here because we need better control over what
        //we send than what Reply.SendReply offers.  This is important as the dir
        //is written using WriteStrings and I found that with Reply.SetReply, a stat
        //reply could throw off a FTP client.
        LContext.Connection.IOHandler.WriteLn(IndyFormat('213-%s', [RSFTPDataConnToOpen])); {Do not Localize}
        LContext.Connection.IOHandler.Write(LStream, False, IndyTextEncoding(NLSTEncType[LContext.NLSTUtf8]));
        ASender.PerformReply := True;
        ASender.Reply.SetReply(213, RSFTPCmdEndOfStat);
      finally
        FreeAndNil(LStream);
      end;
    end;
  end;
end;

procedure TIdFTPServer.CommandFEAT(ASender: TIdCommand);
const
  MFFPREFIX = 'MFF '; {Do not Localize}
var
  LTmp : String;
  LContext: TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  LFileSystem := FTPFileSystem;
  ASender.Reply.Clear;
  SetRFCReplyFormat(ASender.Reply);
  ASender.Reply.NumericCode := 211;
  ASender.Reply.Text.Add(RSFTPCmdExtsSupportedStart); {Do not translate}
  //AUTH
  if IOHandler is TIdServerIOHandlerSSLBase then begin
    if (FUseTLS <> utUseImplicitTLS) then begin
      ASender.Reply.Text.Add('AUTH TLS;AUTH TLS-C;SSL;TLS-P;'); {Do not translate}
    end;
  end;
  //AVBL
  if Assigned(FOnAvailDiskSpace) then begin
    ASender.Reply.Text.Add('AVBL');
  end;
  //CCC
  if (FUseTLS <> utNoTLSSupport) then begin
    ASender.Reply.Text.Add('CCC'); {Do not translate}
  end;
  //CLNT
  if Assigned(FOnClientID) then begin
    ASender.Reply.Text.Add('CLNT');  {Do not translate}
  end;
  //COMB
  if Assigned(FOnCombineFiles) or Assigned(LFileSystem) then begin
    ASender.Reply.Text.Add('COMB target;source_list'); {Do not translate}
  end;
  //CPSV
  //CPSV is not supported in IPv6 - same problem as PASV
  if (UseTLS <> utNoTLSSupport) and (LContext.Binding.IPVersion = Id_IPv4) then begin
    ASender.Reply.Text.Add('CPSV');   {Do not translate}
  end;
  //DSIZ
  if Assigned(OnCompleteDirSize) then begin
    ASender.Reply.Text.Add('DSIZ'); {Do not localize}
  end;
  //EPRT
  ASender.Reply.Text.Add('EPRT');    {Do not translate}
  //EPSV
  ASender.Reply.Text.Add('EPSV');    {Do not translate}
  //Host
  if Assigned(FOnHostCheck) then  begin
    ASender.Reply.Text.Add('HOST domain');  {Do not localize}
  end;
  //
  //This is not proper but FTP Voyager uses it to determine if the -T parameter
  //will work.
  if Assigned(FOnListDirectory) then begin
    //we do things this way because the 'a' and 'T' swithces only make sense
    //when listing Unix dirs.
    LTmp := 'LIST -l';    {Do not translate}
    if SupportTaDirSwitches(LContext) then begin
      LTmp := LTmp + 'aT';  {Do not translate}
    end;
    ASender.Reply.Text.Add(LTmp); {do not localize}
  end;
  //MDTM
  if Assigned(FOnGetFileDate) or Assigned(LFileSystem) then begin
    ASender.Reply.Text.Add('MDTM');  {Do not translate}
    //MDTM YYYYMMDDHHMMSS filename
    if Assigned(FOnSetModifiedTime) then begin
   //   ASender.Reply.Text.Add('MDTM YYYYMMDDHHMMSS[+-TZ];filename');
   //Indicate that we wish to use FTP Voyager's old MDTM variation for seting time.
   //time is returned as local (relative to server's timezone.  We do this for compatibility
      ASender.Reply.Text.Add('MDTM YYYYMMDDHHMMSS filename');  {Do not translate}
    end;
  end;
  //MFCT
  if Assigned(FOnSetCreationTime) then begin
    ASender.Reply.Text.Add('MFCT');  {Do not Localize}
    //TODO:  The logic for the MMF entry may need to change if we
    //support modifying more facts
  end;
  //MFF
  LTmp := MFFPREFIX;  {Do not localize}
  if Assigned(FOnSetCreationTime) and (mlsdFileLastAccessTime in FMLSDFacts) then begin
    LTmp := LTmp + 'Create;'; {Do not Localize}
  end;
  if Assigned(FOnSetModifiedTime) or Assigned(LFileSystem) then begin
    LTmp := LTmp + 'Modify;';  {Do not Localize}
  end;
  if Assigned(FOnSiteCHMOD) then begin
    LTmp := LTmp + 'Unix.mode;';
  end;
  if Assigned(FOnSiteCHOWN) then begin
    LTmp := LTmp + 'Unix.owner;';
  end;
  if Assigned(FOnSiteCHGRP)  then begin
    LTmp := LTmp + 'Unix.group;';
  end;
  if Assigned(FOnSiteUTIME) and (mlsdFileLastAccessTime in FMLSDFacts) then begin
    LTmp := LTmp + 'Windows.lastaccesstime;';
  end;
  if Assigned(FOnSetATTRIB) then begin
    LTmp := LTmp + 'Win32.ea;';
  end;
  if LTmp <> MFFPREFIX then begin
    ASender.Reply.Text.Add(LTmp);
  end;
  //MFMT
  if Assigned(FOnSetModifiedTime) or Assigned(LFileSystem) then begin
    ASender.Reply.Text.Add('MFMT');  {Do not Localize}
  end;
  //MLST
  if Assigned(FOnListDirectory) then begin
    ASender.Reply.Text.Add('MLSD');  {Do not translate}
    ASender.Reply.Text.Add(MLSFEATLine(FMLSDFacts, LContext.MLSOpts));   {Do not translate}
  end;
  //MODE Z
  if Assigned(FCompressor) then begin
    ASender.Reply.Text.Add('MODE Z'); {do not localize}
  end;
  //OPTS
  LTmp := 'OPTS ';
  if Assigned(FOnListDirectory) then begin
    LTmp := LTmp + 'MLST;';
  end;
  if Assigned(FCompressor) then begin
    LTmp := LTmp + 'MODE;';
  end;
  LTmp := LTmp + 'UTF8';
  ASender.Reply.Text.Add(LTmp);
  //PBSZ
  if (FUseTLS <> utNoTLSSupport) then begin
    ASender.Reply.Text.Add('PBSZ');   {Do not translate}
  end;
  //PROT
  if (FUseTLS <> utNoTLSSupport) then begin
    ASender.Reply.Text.Add('PROT');    {Do not translate}
  end;
  //REST STREAM
  ASender.Reply.Text.Add('REST STREAM');  {Do not translate}
  //RMDA
  if Assigned(FOnRemoveDirectoryAll) then begin
    ASender.Reply.Text.Add('RMDA directoryname');  {Do not localize}
  end;
  //SITE ZONE
  //Listing a SITE command in feature negotiation is unusual and
  //may be a little off-spec.  FTP Voyager scans this looking for
  //SITE ZONE and if it's present, it will use the SITE ZONE
  //to help it convert the time to the user's local time zone.
  //The only other way that FTP Voyager would know is if the initial
  //FTP greeting banner started with "Serv-U FTP-Server v2.5f" which
  //is more problematic because Serve-U is a trademark and we would then
  //then be stuck with a situation where everyone has to use it down the road.
  //This would amount to the same mess we had with "Mozilla" in the HTTP
  //User-Agent header field.
  //also list other supported site commands;
  LTmp := 'SITE ZONE';
  if Assigned(FOnSetATTRIB) then begin
    LTmp := LTmp + ';ATTRIB';
  end;
  if Assigned(FOnSiteUMASK) then begin
    LTmp := LTmp + 'UMASK';
  end;
  if Assigned(FOnSiteCHMOD) then begin
    LTmp := LTmp + ';CHMOD';
  end;
  if (FDirFormat = ftpdfDOS) or
    ((FDirFormat = ftpdfOSDependent) and (GOSType = otWindows)) then begin
    LTmp := LTmp + ';DIRSTYLE';
  end;
  if Assigned(OnSiteUTIME) or Assigned(OnSetModifiedTime) then begin
    LTmp := LTmp + ';UTIME';
  end;
  if Assigned(OnSiteCHOWN) then begin
    LTmp := LTmp + ';CHOWN';
  end;
  if Assigned(OnSiteCHGRP) then begin
    LTmp := LTmp + ';CHGRP';
  end;
  ASender.Reply.Text.Add(LTmp); {do not localize}
  //SIZE
  if Assigned(FOnGetFileSize) or Assigned(LFileSystem) then begin
    ASender.Reply.Text.Add('SIZE'); {do not localize}
  end;
  //SPSV
  ASender.Reply.Text.Add('SPSV'); {do not localize}
  //SSCN
  if UseTLS <> utNoTLSSupport then begin
    ASender.Reply.Text.Add('SSCN'); {do not localize}
  end;
  //STAT -l
  //Some servers such as Microsoft FTP Service, RaidenFTPD, and a few others,
  //treat a STAT -l as a LIST command, only it's sent on the control connection.
  //Some versions of Flash FXP can also use this as an option to improve efficiency.
  if Assigned(FOnListDirectory) then begin
      //we do things this way because the 'a' and 'T' swithces only make sense
    //when listing Unix dirs.
    LTmp := 'STAT -l';   {Do not translate}
    if SupportTaDirSwitches(LContext) then begin
      LTmp := LTmp + 'aT';   {Do not translate}
    end;
    ASender.Reply.Text.Add(LTmp); {do not localize}
  end;
  //TVFS
  if FPathProcessing <> ftppCustom then begin
    //TVFS should not be indicated for custom parsing because
    //we don't know what a person will do.
    ASender.Reply.Text.Add('TVFS'); {Do not localize}
  end;
  // UTF-8
  // RFC 2640 says that "Servers MUST support the UTF-8 feature in response to the FEAT command [RFC2389]."
  // TODO: finish actually implementing UTF-8 support
  ASender.Reply.Text.Add('UTF8'); {Do not localize}
  //XCRC
  if Assigned(FOnCRCFile) or Assigned(LFileSystem) then begin
    if not GetFIPSMode then begin
      ASender.Reply.Text.Add('XCRC "filename" SP EP');//filename;start;end');  {Do not Localize}
      ASender.Reply.Text.Add('XMD5 "filename" SP EP');//filename;start;end');  {Do not Localize}
    end;
    ASender.Reply.Text.Add('XSHA1 "filename" SP EP');//filename;start;end');  {Do not Localize}

    if TIdHashSHA256.IsAvailable then begin
      ASender.Reply.Text.Add('XSHA256 "filename" SP EP'); //file;start/end
    end;
    if TIdHashSHA512.IsAvailable then begin
      ASender.Reply.Text.Add('XSHA512 "filename" SP EP'); //file;start/end
    end;
  end;
  //I'm doing things this way with complience level to match the current
  //version of NcFTPD
  LTmp := 'RFC 959 2389 ';
  if LContext.UserSecurity.FInvalidPassDelay <> 0 then begin
    LTmp := LTmp + '2577 ';
  end;
  LTmp := LTmp + '3659 '; {Do not Localize}
  if IOHandler is TIdServerIOHandlerSSLBase then begin
    if (FUseTLS <> utUseImplicitTLS) then begin
      LTmp := LTmp + '4217 ';  {Do not localize}
    end;
  end;
  ASender.Reply.Text.Add(Trim(LTmp)); {Do not Localize}
  ASender.Reply.Text.Add(RSFTPCmdExtsSupportedEnd);
end;

procedure TIdFTPServer.CommandOPTS(ASender: TIdCommand);
var
  LCmd : String;
begin
  LCmd := ASender.UnparsedParams;
  ASender.Reply.Clear;
  if TextIsSame(Fetch(LCmd, ' ', False), 'MLST') then begin {do not localize}
    //just in case the user doesn't create a ListDirectory event.
    if not Assigned(FOnListDirectory) then begin
      ASender.Reply.SetReply(501, RSFTPOptNotRecog);
      Exit;
    end;
  end;
  if not FOPTSCommands.HandleCommand(ASender.Context, LCmd) then begin
    ASender.Reply.SetReply(501, RSFTPOptNotRecog);
  end else begin
    //we don't want an extra 200 reply.
    ASender.PerformReply := False;
  end;
end;

procedure TIdFTPServer.CommandSIZE(ASender: TIdCommand);
var
  s: string;
  LSize: Int64;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    LFileSystem := FFTPFileSystem;
    if Assigned(FOnGetFileSize) or Assigned(LFileSystem) then begin
      LSize := -1;
      s := DoProcessPath(LContext, ASender.UnparsedParams);
      DoOnGetFileSize(LContext, s, LSize);
      if LSize > -1 then begin
        ASender.Reply.SetReply(213, IntToStr(LSize));
      end else begin
        CmdFileActionAborted(ASender);
      end;
    end else begin
      CmdSyntaxError(ASender);
    end;
  end;
end;

procedure TIdFTPServer.DoOnChangeDirectory(AContext: TIdFTPServerContext; var VDirectory: TIdFTPFileName);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FFTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.ChangeDir(AContext, VDirectory);
  end else if Assigned(FOnChangeDirectory) then begin
    FOnChangeDirectory(AContext, VDirectory);
  end;
end;

procedure TIdFTPServer.DoOnRemoveDirectory(AContext: TIdFTPServerContext; var VDirectory: TIdFTPFileName);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FFTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.RemoveDirectory(AContext, VDirectory);
  end else if Assigned(FOnRemoveDirectory) then begin
    FOnRemoveDirectory(AContext, VDirectory);
  end;
end;

procedure TIdFTPServer.DoOnMakeDirectory(AContext: TIdFTPServerContext; var VDirectory: TIdFTPFileName);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FFTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.MakeDirectory(AContext, VDirectory);
  end else if Assigned(FOnMakeDirectory) then begin
    FOnMakeDirectory(AContext, VDirectory);
  end;
end;

procedure TIdFTPServer.CommandEPRT(ASender: TIdCommand);
var
  LParm, LIP: string;
  LDelim: char;
  LReqIPVersion: TIdIPVersion;
  LContext : TIdFTPServerContext;
  LDataChannel: TIdTCPClient;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    LContext.FPASV := False;
    LParm := ASender.UnparsedParams;
    if Length(LParm) = 0 then begin
      LContext.FDataPortDenied := True;
      CmdInvalidParamNum(ASender);
      Exit;
    end;
    if FFTPSecurityOptions.BlockAllPORTTransfers then begin
      LContext.FDataPortDenied := True;
      ASender.Reply.SetReply(502, RSFTPPORTDisabled);
      Exit;
    end;
    LDelim := LParm[1];
    Fetch(LParm, LDelim);
    case IndyStrToInt(Fetch(LParm, LDelim), -1) of
      1: begin
        if not GStack.SupportsIPv4 then begin
          LContext.FDataPort := 0;
          LContext.FDataPortDenied := True;
          ASender.Reply.SetReply(522, IndyFormat(RSFTPNetProtNotSup, ['2'])); {Do not translate}
          Exit;
        end;
        LReqIPVersion := Id_IPv4;
      end;
      2: begin
        if not GStack.SupportsIPv6 then begin
          LContext.FDataPort := 0;
          LContext.FDataPortDenied := True;
          ASender.Reply.SetReply(522, IndyFormat(RSFTPNetProtNotSup, ['1'])); {Do not translate}
          Exit;
        end;
        LReqIPVersion := Id_IPv6;
      end;
    else
      begin
        LParm := '';
        if GStack.SupportsIPv4 then begin
          LParm := '1'; {Do not translate}
        end;
        if GStack.SupportsIPv6 then begin
          if LParm <> '' then begin
            LParm := LParm + ','; {Do not translate}
          end;
          LParm := LParm + '2'; {Do not translate}
        end;
        LContext.FDataPort := 0;
        LContext.FDataPortDenied := True;
        ASender.Reply.SetReply(522, IndyFormat(RSFTPNetProtNotSup, [LParm])); {Do not translate}
        Exit;
      end;
    end;
    LIP := Fetch(LParm, LDelim);
    if Length(LIP) = 0 then begin
      LContext.FDataPort := 0;
      LContext.FDataPortDenied := True;
      ASender.Reply.SetReply(500, RSFTPInvalidIP);
      Exit;
    end;
    LContext.FDataPort := TIdPort(IndyStrToInt(Fetch(LParm, LDelim), 0));
    if LContext.FDataPort = 0 then begin
      LContext.FDataPortDenied := True;
      ASender.Reply.SetReply(500, RSFTPInvalidPort);
      Exit;
    end;
    if FFTPSecurityOptions.NoReservedRangePORT and
      ((LContext.FDataPort > 0) and (LContext.FDataPort <= 1024)) then begin
      LContext.FDataPort := 0;
      LContext.FDataPortDenied := True;
      ASender.Reply.SetReply(504, RSFTPPORTRange);
      Exit;
    end;
    if FFTPSecurityOptions.FRequirePORTFromSameIP then begin
      case LReqIPVersion of
        Id_IPv4: LIP := MakeCanonicalIPv4Address(LIP);
        Id_IPv6: LIP := MakeCanonicalIPv6Address(LIP);
      end;
      if LIP <> LContext.Binding.PeerIP then begin
        LContext.FDataPort := 0;
        LContext.FDataPortDenied := True;
        ASender.Reply.SetReply(504, RSFTPSameIPAddress);
        Exit;
      end;
    end;
    LContext.CreateDataChannel(False);
    LDataChannel := TIdTCPClient(LContext.FDataChannel.FDataChannel);
    LDataChannel.Host := LIP;
    LDataChannel.Port := LContext.FDataPort;
    LDataChannel.IPVersion := LReqIPVersion;
    LContext.FDataPortDenied := False;
    CmdCommandSuccessful(ASender, 200);
  end;
end;

procedure TIdFTPServer.CommandEPSV(ASender: TIdCommand);
var
  LParam: string;
  LBPortMin, LBPortMax: Word;
  LIP : String;
  LIPVersion: TIdIPVersion;
  LReqIPVersion: TIdIPVersion;
  LContext : TIdFTPServerContext;
  LDataChannel: TIdSimpleServer;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    LIPVersion := LContext.Binding.IPVersion;
    LReqIPVersion := LIPVersion;
    LParam := ASender.UnparsedParams;
    if Length(LParam) > 0 then begin
      case IndyStrToInt(LParam, -1) of
        1: begin
          if not GStack.SupportsIPv4 then begin
            ASender.Reply.SetReply(522, IndyFormat(RSFTPNetProtNotSup, ['2'])); {do not localize}
            Exit;
          end;
          LReqIPVersion := Id_IPv4;
        end;
        2: begin
          if not GStack.SupportsIPv6 then begin
             ASender.Reply.SetReply(522, IndyFormat(RSFTPNetProtNotSup, ['1'])); {do not localize}
             Exit;
          end;
          LReqIPVersion := Id_IPv6;
        end;
      else
        begin
          if TextIsSame(LParam, 'ALL') then begin { do not localize }
            LContext.FEPSVAll := True;
            ASender.Reply.SetReply(200, RSFTPEPSVAllEntered);
          end else begin
            LIP := '';
            if GStack.SupportsIPv4 then begin
              LIP := '1'; {do not localize}
            end;
            if GStack.SupportsIPv6 then begin
              if LIP <> '' then begin
                LIP := LIP + ','; {do not localize}
              end;
              LIP := LIP + '2'; {do not localize}
            end;
            ASender.Reply.SetReply(522, IndyFormat(RSFTPNetProtNotSup, [LIP])); {do not localize}
          end;
          Exit;
        end;
      end;
    end;
    if LReqIPVersion = LIPVersion then begin
      LIP := LContext.Binding.IP;
    end;
    if (FPASVBoundPortMin <> 0) and (FPASVBoundPortMax <> 0) then begin
      LBPortMin := FPASVBoundPortMin;
      LBPortMax := FPASVBoundPortMax;
    end else begin
      LBPortMin := FDefaultDataPort;
      LBPortMax := LBPortMin;
    end;
    DoOnPASVBeforeBind(LContext, LIP, LBPortMin, LBPortMax, LReqIPVersion);

    LContext.CreateDataChannel(True);
    LDataChannel := TIdSimpleServer(LContext.FDataChannel.FDataChannel);
    LDataChannel.BoundIP := LIP;
    if LBPortMin = LBPortMax then begin
      LDataChannel.BoundPort := LBPortMin;
      LDataChannel.BoundPortMin := 0;
      LDataChannel.BoundPortMax := 0;
    end else begin
      LDataChannel.BoundPort := 0;
      LDataChannel.BoundPortMin := LBPortMin;
      LDataChannel.BoundPortMax := LBPortMax;
    end;
    LDataChannel.IPVersion := LReqIPVersion;
    LDataChannel.BeginListen;
    LIP := LDataChannel.Binding.IP;
    LBPortMin := LDataChannel.Binding.Port;

    //Note that only one Port can work with EPSV
    DoOnPASVReply(LContext, LIP, LBPortMin, LReqIPVersion);
    LParam := '|||' + IntToStr(LBPortMin) + '|'; {Do not localize}
    ASender.Reply.SetReply(229, IndyFormat(RSFTPEnteringEPSV, [LParam]));
    ASender.SendReply;
    LContext.FPASV := True;
  end;
end;

procedure TIdFTPServer.CommandMDTM(ASender: TIdCommand);
var
  s: string;
  LDate: TDateTime;
  LContext : TIdFTPServerContext;
  LSDate : String;
  LExists : Boolean;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
{
I know that this code and design are a mess.

There are actually two forms of MDTM and they mean different things.

The formal spec indicates that anything after the space in MDTM <filename>
is the filename.

FTP Voyager and some other clients abuse the MDTM command by using it to specify
a timestamp for the "Modified Time" on a file.  The format is like this:

 MDTM YYYYMMDDHHMMSS filename

 Thus, there's an ambiguity.

 Does MDTM 20031229152022 ESBAdDemo.exe  mean
   1) Set the date time on ESBAdDemo.exe to 12/29/2003 3:20:22 PM

   or

   2) Get the time for a file named 20031229152022 ESBAdDemo.exe

 To resolve this ambiguity, we check specifically for a valid date, and then see
  if a file, 20031229152022 ESBAdDemo.exe really does exist.  If not, we interpret
  MDTM as a set date command.  Otherwise, we will traat it as a request for the timestamp
  of a file, 20031229152022 ESBAdDemo.exe.

  Note also that the time is sometimes given as either relative to the local server
  or an offset is provided.

  Note from:
  http://www.ftpvoyager.com/releasenotes.asp
  ====
  Added support for RFC change and the MDTM. MDTM requires sending the server
  GMT (UTC) instead of a "fixed" date and time. FTP Voyager supports this with
  Serv-U automatically by checking the Serv-U version number and by checking the
  response to the FEAT command for MDTM. Servers returning "MDTM" or
  "MDTM YYYYMMDDHHMMSS[+-TZ] filename" will use the old method. Servers
  returning "MDTM YYYYMMDDHHMMSS" only will use the new method where the date a
  and time is GMT (UTC).
  ===
  We will use the old form for compatiability with some older FTP Voyager clients
  and because a few servers support the old form as well.  I do this even though,
  this is really inconsistant with what MDTM returns for a query request.  I might
  consider some type of support for the new form but I do not feel that such
  things are just abuse of the MDTM command.  That's why I prefer a separate command for
  modifying file modification dates (MFMT).
}
begin
  LFileSystem := FFTPFileSystem;
  if Assigned(FOnGetFileDate) or Assigned(LFileSystem) then
  begin
    LContext := ASender.Context as TIdFTPServerContext;
    if LContext.IsAuthenticated(ASender) then begin
      s := ASender.UnparsedParams;
      LSDate := Fetch(s);
      if IsMDTMDate(LSDate) then begin
        s := DoProcessPath(LContext, ASender.UnparsedParams );
        DoOnFileExistCheck(LContext, s, LExists);
        if not LExists then begin
          s := ASender.UnparsedParams;
          Fetch(s);
          s := DoProcessPath(LContext, s);
          LDate := FTPMDTMToGMTDateTime(LSDate);
          DoOnSetModifiedTime(LContext, s, LDate);
        //  Self.DoOnSetModifiedTime(LF,s, LSDate);
          ASender.Reply.SetReply(253, 'Date/time changed okay.'); {do not localize}
          Exit;
        end;
      end;

      s := DoProcessPath(LContext, ASender.UnparsedParams);
      LDate := 0;
      DoOnGetFileDate(LContext, s, LDate);
      if LDate > 0 then begin
        ASender.Reply.SetReply(213, FTPGMTDateTimeToMLS(LDate));
      end else begin
        CmdFileActionAborted(ASender);
      end;
    end;
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.SetFTPSecurityOptions(const AValue: TIdFTPSecurityOptions);
begin
  FFTPSecurityOptions.Assign(AValue);
end;

procedure TIdFTPServer.SetOnUserAccount(AValue: TOnFTPUserAccountEvent);
var
  LCmd : TIdCommandHandler;
  i : Integer;
begin
  if FUserAccounts = nil then begin
    FOnUserAccount := AValue;
    for i := 0 to CommandHandlers.Count - 1 do begin
      LCmd := CommandHandlers.Items[i];
      if LCmd.Command = 'ACCT' then begin
        if Assigned(AValue) then begin
          LCmd.HelpSuperScript := '';
          LCmd.Description.Text := ACCT_HELP_ENABLED;
        end else begin
          LCmd.HelpSuperScript := '*';
          LCmd.Description.Text := ACCT_HELP_DISABLED;
        end;
      end;
    end;
  end;
end;

procedure TIdFTPServer.CommandAUTH(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if (PosInStrArray(ASender.UnparsedParams, TLS_AUTH_NAMES) > -1) and
     (ASender.Context.Connection.IOHandler is TIdSSLIOHandlerSocketBase) and
     (FUseTLS in ExplicitTLSVals) then
  begin
    ASender.Reply.SetReply(234,RSFTPAuthSSL);
    ASender.SendReply;
    (ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := False;
    {
    This is from:

    http://www.ford-hutchinson.com/~fh-1-pfh/ftps-ext.html#bad

    and we implement things this way for historical reasons so
    we don't break older and newer clients.
    }
    case PosInStrArray(ASender.UnparsedParams, TLS_AUTH_NAMES) of
      0,2 : LContext.DataProtection := ftpdpsClear; //AUTH TLS, AUTH TLS-C
      1,3 : LContext.DataProtection := ftpdpsPrivate; //AUTH SSL, AUTH TLS-P
    end;
    LContext.AuthMechanism := 'TLS';  {Do not localize}
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.CommandAVBL(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  LIsFile : Boolean;
  LSize : Int64;
  LPath : String;
begin
  LIsFile := True;
  LSize := 0;
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(FOnAvailDiskSpace) then begin
      LPath := DoProcessPath(LContext, ASender.UnparsedParams);
      FOnAvailDiskSpace(LContext, LPath, LIsFile, LSize);
      if LIsFile then begin
        ASender.Reply.SetReply(550, IndyFormat(RSFTPIsAFile,[LPath]));
      end else begin
         ASender.Reply.SetReply(213, IntToStr(LSize));
      end;
    end else begin
      CmdNotImplemented(ASender);
    end;
  end else begin
    ASender.Reply.SetReply(550, RSFTPFileActionNotTaken);
  end;
end;

   //FOnCompleteDirSize
procedure TIdFTPServer.CommandDSIZ(ASender : TIdCommand);
var
  LContext : TIdFTPServerContext;
  LIsFile : Boolean;
  LSize : Int64;
  LPath : String;
begin
  LIsFile := True;
  LSize := 0;
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(FOnCompleteDirSize) then begin
      LPath := DoProcessPath(LContext, ASender.UnparsedParams);
      FOnCompleteDirSize(LContext, LPath, LIsFile, LSize);
      if LIsFile then begin
        ASender.Reply.SetReply(550, IndyFormat(RSFTPIsAFile,[LPath]));
      end else begin
        ASender.Reply.SetReply(213, IntToStr(LSize));
      end;
    end else begin
      CmdNotImplemented(ASender);
    end;
  end else begin
    ASender.Reply.SetReply(550, RSFTPFileActionNotTaken);
  end;
end;

procedure TIdFTPServer.CommandRMDA(ASender : TIdCommand);
var
  LContext : TIdFTPServerContext;
  LPath : TIdFTPFileName;
begin
  //FOnRemoveDirectoryAll: TOnDirectoryEvent;
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(FOnRemoveDirectoryAll) then begin
      LPath := DoProcessPath(LContext, ASender.UnparsedParams);
      FOnRemoveDirectoryAll(LContext, LPath);
      ASender.Reply.SetReply(250, RSFTPFileActionCompleted);
    end else begin
      CmdNotImplemented(ASender);
    end;
  end else begin
    ASender.Reply.SetReply(550, RSFTPFileActionNotTaken);
  end;
end;

procedure TIdFTPServer.CommandCCC(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if FUseTLS <> utNoTLSSupport then begin
    //Not sure if it's proper to require authentication before a CCC
    //but it is a good idea anyway because you definately want to
    //prevent eavesdropping
    if LContext.IsAuthenticated(ASender) then begin
      if LContext.FUserSecurity.PermitCCC then begin
        ASender.Reply.SetReply(200, RSFTPClearCommandConnection);
        ASender.SendReply;
        (ASender.Context.Connection.IOHandler as TIdSSLIOHandlerSocketBase).PassThrough := True;
        LContext.FCCC := True;
      end else begin
        ASender.Reply.SetReply(534, RSFTPClearCommandNotPermitted);
      end;
    end;
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.CommandPBSZ(ASender: TIdCommand);
{Note that this may have to be expanded and reworked for other AUTH mechanisms}
var
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if IOHandler is TIdServerIOHandlerSSLBase then begin
    if ASender.UnparsedParams = '' then begin
      CmdInvalidParamNum(ASender);
      Exit;
    end;
    if (LContext.AuthMechanism = '') and (FUseTLS <> utUseImplicitTLS) then begin
      ASender.Reply.SetReply(503, RSFTPPBSZAuthDataRequired);
      Exit;
    end;
    if LContext.FCCC then begin
      ASender.Reply.SetReply(503, RSFTPPBSZNotAfterCCC);
      Exit;
    end;
    if (LContext.AuthMechanism = 'TLS') or (FUseTLS = utUseImplicitTLS) then begin  {Do not localize}
      ASender.Reply.SetReply(200,RSFTPDataProtBuffer0);
      LContext.DataPBSZCalled := True;
    end
    else if IsNumeric(ASender.UnparsedParams) then begin
      ASender.Reply.SetReply(200,'PBSZ=0'); {Do not translate}
      LContext.DataPBSZCalled := True;
    end else begin
      CmdInvalidParams(ASender);
    end;
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.CommandPROT(ASender: TIdCommand);
const
  LValidParams : array [0..3] of string = ('C','S','E','P'); {Do not translate}
{Note that this may have to be expanded and reworked for other AUTH mechanisms}
var
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if IOHandler is TIdServerIOHandlerSSLBase then begin
    if LContext.FCCC then  begin
      ASender.Reply.SetReply(503, RSFTPPBSZNotAfterCCC);
      Exit;
    end;
    if not LContext.DataPBSZCalled then begin
      ASender.Reply.SetReply(503, RSFTPPROTProtBufRequired);
      Exit;
    end;
    case PosInStrArray(ASender.UnparsedParams, LValidParams) of
      0 : begin
            LContext.FDataProtection := ftpdpsClear;
            ASender.Reply.SetReply(200, RSFTPProtTypeClear);
          end;
      1, 2 : ASender.Reply.SetReply(536, RSFTPInvalidProtTypeForMechanism);
      3 : begin
            LContext.FDataProtection := ftpdpsPrivate;
            ASender.Reply.SetReply(200, RSFTPProtTypePrivate);
          end;
    else
      ASender.Reply.SetReply(504,  RSFTPInvalidForParam);
    end;
  end else begin
    CmdNotImplemented(ASender);
  end;
end;

procedure TIdFTPServer.CommandCOMB(ASender: TIdCommand);
var
  LFileParts : TStringList;
  LBuf : String;
  LTargetFileName : String;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  LFileSystem := FTPFileSystem;
  if Assigned(FOnCombineFiles) or Assigned(LFileSystem) then begin
    if LContext.IsAuthenticated(ASender) then begin
      if ASender.UnparsedParams = '' then begin
        CmdInvalidParamNum(ASender);
        Exit;
      end;
      if Pos('"', ASender.UnparsedParams) > 0 then begin
        LBuf := ASender.UnparsedParams;
        Fetch(LBuf,'"');
        LTargetFileName := Fetch(LBuf, '"');
        LTargetFileName := DoProcessPath(LContext, LTargetFileName);
        LBuf := Trim(LBuf);
        LFileParts := TStringList.Create;
        try
          while LBuf <> '' do begin
            Fetch(LBuf,'"');
            LFileParts.Add(DoProcessPath(LContext, Fetch(LBuf,'"')));
          end;
          DoOnCombineFiles(LContext, LTargetFileName, LFileParts);
          ASender.Reply.SetReply(250, RSFTPFileOpSuccess);
        finally
          FreeAndNil(LFileParts);
        end;
      end else begin
        CmdInvalidParams(ASender);
      end;
    end;
  end else begin
    CmdNotImplemented(ASender);
  end;
end;

procedure TIdFTPServer.DoConnect(AContext: TIdContext);
var
  LGreeting : TIdReplyRFC;
begin
  AContext.Connection.IOHandler.DefStringEncoding := IndyTextEncoding_8Bit;

  // RLebeau 2/2/2021: let the user decide whether to enable SSL in their
  // own event handler.  Indy should not be making any assumptions about
  // whether to implicitally force SSL on any given connection.  This
  // prevents a single server from handling both SSL and non-SSL connections
  // together.  The whole point of the PassThrough property is to allow
  // per-connection SSL handling.
  //
  // TODO: move this new logic into TIdCustomTCPServer directly somehow

  if AContext.Connection.IOHandler is TIdSSLIOHandlerSocketBase then begin
    if FUseTLS = utUseImplicitTLS then begin
      TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).PassThrough := 
        not DoQuerySSLPort(AContext.Binding.Port);
    end;
  end;

  (AContext as TIdFTPServerContext).FXAUTKey := MakeXAUTKey;
  if Assigned(OnGreeting) then begin
    LGreeting := TIdReplyRFC.Create(nil);
    try
      LGreeting.Assign(Greeting);
      OnGreeting(TIdFTPServerContext(AContext), LGreeting);
      ReplyTexts.UpdateText(LGreeting);
      if (not GetFIPSMode) and FSupportXAUTH and (LGreeting.NumericCode = 220) then begin
        (AContext as TIdFTPServerContext).FXAUTKey := IdFTPCommon.MakeXAUTKey;
        XAutGreeting(AContext,LGreeting, GStack.HostName);
      end;
      AContext.Connection.IOHandler.Write(LGreeting.FormattedReply);
      if Assigned(OnConnect) then begin
        OnConnect(AContext);
      end;
      if LGreeting.NumericCode = 421 then begin
        AContext.Connection.Disconnect(False);
      end;
    finally
      FreeAndNil(LGreeting);
    end;
  end else begin
    if (not GetFIPSMode) and FSupportXAUTH and (Greeting.NumericCode = 220)  then begin
      LGreeting := TIdReplyRFC.Create(nil);
      try
        LGreeting.Assign(Greeting);
        XAutGreeting(AContext,LGreeting, GStack.HostName);
        AContext.Connection.IOHandler.Write(LGreeting.FormattedReply);
        if Assigned(OnConnect) then begin
          OnConnect(AContext);
        end;
        if LGreeting.NumericCode = 421 then begin
          AContext.Connection.Disconnect(False);
        end;
      finally
        FreeAndNil(LGreeting);
      end;
    end else begin
      inherited DoConnect(AContext);
    end;
  end;
end;

function TIdFTPServer.DoQuerySSLPort(APort: TIdPort): Boolean;
begin
  // check for the default FTPS port, but let the user override that if desired...
  Result := (APort = IdPORT_ftps);
  if Assigned(FOnQuerySSLPort) then begin
    FOnQuerySSLPort(APort, Result);
  end;
end;

procedure TIdFTPServer.CommandQUIT(ASender: TIdCommand);
begin
  if Assigned(FOnQuitBanner) then begin
    FOnQuitBanner(TIdFTPServerContext(ASender.Context), ASender.Reply);
    ASender.Disconnect := True;
  end else begin
    ASender.Reply.Assign(ASender.CommandHandler.NormalReply);
  end;
  ASender.Reply.SetReply(221, ASender.Reply.Text.Text);
end;

procedure TIdFTPServer.CommandMLSD(ASender: TIdCommand);
var
  LStream: TStringList;
  LSendData : Boolean;
  LContext : TIdFTPServerContext;
begin
  if not Assigned(OnListDirectory) then begin
    CmdSyntaxError(ASender);
    Exit;
  end;
  LContext := ASender.Context as TIdFTPServerContext;
  LSendData := False;
  if LContext.IsAuthenticated(ASender) then begin
    if (not Assigned(LContext.FDataChannel)) or LContext.FDataPortDenied then begin
      ASender.Reply.SetReply(425, RSFTPCantOpenData);
      Exit;
    end;
    LStream := TStringList.Create;
    try
      ListDirectory(LContext, DoProcessPath(LContext, ASender.UnparsedParams),
        LStream, TextIsSame(ASender.CommandHandler.Command, 'LIST'), 'MLSD'); {Do not translate}
      LSendData := True;
    finally
      try
        if LSendData then begin
          //it should be safe to assume that the FDataChannel object exists because
          //we checked it earlier
          LContext.FDataChannel.Data := LStream;
          LContext.FDataChannel.OKReply.SetReply(226, RSFTPDataConnClosed);
          LContext.FDataChannel.ErrorReply.SetReply(426, RSFTPDataConnClosedAbnormally);
          LContext.FDataChannel.FFtpOperation := ftpRetr;
          ASender.Reply.SetReply(125, RSFTPDataConnToOpen);
          ASender.SendReply;
          DoDataChannelOperation(ASender);
        end else begin
          LContext.KillDataChannel;
          ASender.Reply.SetReply(426, RSFTPDataConnClosedAbnormally);
        end;
      finally
        LStream.Free;
      end;
    end;
  end;
end;

procedure TIdFTPServer.CommandMLST(ASender: TIdCommand);
var
  LStream : TStringList;
  i : Integer;
  LContext : TIdFTPServerContext;
  LPath : String;
  LDir : TIdFTPListOutput;
begin
  if Assigned(OnListDirectory) or Assigned(FOnMLST) then begin
    LContext := ASender.Context as TIdFTPServerContext;
    if LContext.IsAuthenticated(ASender) then begin
      LStream := TStringList.Create;
      try
        LPath := DoProcessPath(LContext, ASender.UnparsedParams);
        if Assigned(FOnMLST) then begin
          LDir := TIdFTPListOutput.Create;
          try
            FOnMLST(LContext, LPath, LDir);
            LDir.MLISTOutputDir(LStream, LContext.MLSOpts);
          finally
            FreeAndNil(LDir);
          end;
        end else begin
          //this part is kept just for backwards compatibility
          ListDirectory(LContext, LPath, LStream, True, 'MLST');  {Do not translate}
        end;
        ASender.Reply.Clear;
        SetRFCReplyFormat(ASender.Reply);
        ASender.Reply.NumericCode := 250;
        ASender.Reply.Text.Add('Begin'); {do not localize}
        for i := 0 to LStream.Count -1 do begin
          ASender.Reply.Text.Add(' ' + LStream[i]);
        end;
        ASender.Reply.Text.Add('End'); {do not localize}
        ASender.SendReply;
      finally
        FreeAndNil(LStream);
      end;
    end;
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.DoOnSetModifiedTime(AContext: TIdFTPServerContext; const AFileName : String; var VDateTime: TDateTime);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.SetModifiedFileDate(AContext, AFileName, VDateTime);
  end else if Assigned(FOnSetModifiedTime) then begin
    FOnSetModifiedTime(AContext, AFileName, VDateTime);
  end;
end;

procedure TIdFTPServer.DoOnSetModifiedTime(AContext: TIdFTPServerContext; const AFileName : String; var VDateTimeStr : String);
var
  LTime : TDateTime;
begin
  LTime := FTPMLSToGMTDateTime(VDateTimeStr);
  DoOnSetModifiedTime(AContext, AFileName, LTime);
  VDateTimeStr := FTPGMTDateTimeToMLS(LTime);
end;

procedure TIdFTPServer.DoOnSetCreationTime(AContext: TIdFTPServerContext; const AFileName : String; var VDateTime: TDateTime);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    //LFileSystem.SetCreationFileDate(AContext,AFileName,VDateTime);
  end else if Assigned(FOnSetCreationTime) then begin
    FOnSetCreationTime(AContext, AFileName, VDateTime);
  end;
end;

procedure TIdFTPServer.DoOnSetCreationTimeGMT(AContext: TIdFTPServerContext;
  const AFileName: String; var VDateTime: TDateTime);
begin
  if Assigned(FOnSetCreationTime) then begin
    FOnSetCreationTime(AContext, AFileName, VDateTime);
  end;
end;

procedure TIdFTPServer.DoOnSetModifiedTimeGMT(AContext: TIdFTPServerContext;
  const AFileName: String; var VDateTime: TDateTime);
begin
  if Assigned(FOnSetModifiedTime) then begin
    FOnSetModifiedTime(AContext, AFileName, VDateTime);
  end;
end;

procedure TIdFTPServer.DoOnSetCreationTime(AContext: TIdFTPServerContext;
  const AFileName : String; var VDateTimeStr : String);
var
  LTime : TDateTime;
begin
  LTime := FTPMLSToLocalDateTime(VDateTimeStr);
  DoOnSetCreationTime(AContext, AFileName, LTime);
  VDateTimeStr := FTPLocalDateTimeToMLS(LTime);
end;

procedure TIdFTPServer.CommandMFMT(ASender: TIdCommand);
var
  LTimeStr, LFileName : String;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    LFilesystem := FTPFileSystem;
    if Assigned(FOnSetModifiedTime) or Assigned(LFileSystem) then begin
      LFileName := ASender.UnparsedParams;
      LTimeStr := Fetch(LFileName);
      LFileName := DoProcessPath(LContext, LFileName);
      DoOnSetModifiedTime(LContext, LFileName, LTimeStr);
      ASender.Reply.SetReply(213, IndyFormat('Modify=%s %s', [LTimeStr, LFileName])); {Do not translate}
    end else begin
      CmdSyntaxError(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandMFCT(ASender: TIdCommand);
var
  LTimeStr, LFileName : String;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if LContext.IsAuthenticated(ASender) then begin
    LFileSystem := FTPFileSystem;
    if Assigned(FOnSetCreationTime) or Assigned(LFileSystem) then begin
      LFileName := ASender.UnparsedParams;
      LTimeStr := Fetch(LFileName);
      LFileName := DoProcessPath(LContext, LFileName);
      DoOnSetCreationTime(LContext, LFileName, LTimeStr);
      ASender.Reply.SetReply(213, IndyFormat('CreateTime=%s %s', [LTimeStr, LFileName])); {Do not translate}
    end else begin
      CmdSyntaxError(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandMFF(ASender: TIdCommand);
var
  LFacts : TStringList;
  LFileName : String;
  LValue : String;
  s : String;
  LContext : TIdFTPServerContext;
  LAttrib : UInt32;
  LAuth : Boolean;
  LDummyDate1, LDummyDate2 : TDateTime;
  LDate : TDateTime;
  LCHMOD : Integer;
  LDummy : String;
begin
  LAuth := True;
  LDummy := ''; //empty value for passing a var in case we need to do that
  LContext := TIdFTPServerContext(ASender.Context);
  //this may need to change if we make more facts to modify
  if not Assigned(FOnSetModifiedTime) and not Assigned(FOnSetCreationTime) then begin
    CmdSyntaxError(ASender);
    Exit;
  end;
  s := '';
  if ASender.UnparsedParams = '' then begin
    CmdInvalidParamNum(ASender);
    Exit;
  end;
  if LContext.IsAuthenticated(ASender) then begin
    LFacts := TStringList.Create;
    try
      LFileName := ParseFacts(ASender.UnparsedParams, LFacts);
      LFileName := DoProcessPath(LContext, LFileName);
      if LFacts.Values['Modify'] <> '' then begin {Do not translate}
        if Assigned(FOnSetModifiedTime) then begin
          LValue := LFacts.Values['Modify'];  {Do not translate}
          DoOnSetModifiedTime(LContext, LFileName, LValue);
          s := s + IndyFormat('Modify=%s;', [LValue]); {Do not translate}
        end;
      end;
      if LFacts.Values['Create'] <> '' then begin   {Do not translate}
         if Assigned(FOnSetCreationTime) then begin
           LValue := LFacts.Values['Create'];   {Do not translate}
           DoOnSetCreationTime(LContext, LFileName, LValue);
           s := s + IndyFormat('Create=%s;', [LValue]);  {Do not translate}
         end;
      end;
      if LFacts.Values['Win32.ea'] <> '' then begin
        if Assigned(FOnSetATTRIB) then begin
          LValue := LFacts.Values['Win32.ea'];  {Do not localize}
          LAttrib := IndyStrToInt(LValue);
          DoOnSetAttrib(LContext, LAttrib, LFileName, LAuth);
          LValue := '0x' + IntToHex(LAttrib, 8);
          s := s + IndyFormat('Win32.ea=%s;', [LValue]);  {Do not translate}
        end;
      end;
      if LFacts.Values['Unix.mode'] <> '' then begin
        LValue := LFacts.Values['Unix.mode'];  {Do not localize}
        if Assigned(FOnSiteCHMOD) then begin
          If IsValidPermNumbers(LValue) then begin
            LCHMOD := IndyStrToInt(LValue);
            DoOnSiteCHMOD(LContext, LCHMOD, LFileName, LAuth);
            LValue := IndyFormat('%.4d', [LCHMOD]);
            s := s + IndyFormat('Unix.mode=%s;', [LValue]);  {Do not translate}
          end;
        end;
      end;
      if LFacts.Values['Unix.owner'] <> '' then begin {Do not localize}
        LValue := LFacts.Values['Unix.owner'];   {Do not localize}
        if Assigned(FOnSiteCHOWN) then begin
          DoOnSiteCHOWN(LContext, LValue, LDummy, LFileName, LAuth);
          s := s + IndyFormat('Unix.owner=%s;', [LValue]); {Do not localize}
        end;
      end;
      if LFacts.Values['Unix.group'] <> '' then begin {Do not localize}
        LValue := LFacts.Values['Unix.group'];   {Do not localize}
        if Assigned(FOnSiteCHGRP) then begin
          DoOnSiteCHGRP(LContext, LValue, LFileName, LAuth);
          s := s + IndyFormat('Unix.group=%s;', [LValue]);  {Do not localize}
        end;
      end;
      if LFacts.Values['Windows.lastaccesstime'] <> '' then begin
        LValue := LFacts.Values['Windows.lastaccesstime'];
        if Assigned(FOnSiteUTIME) and (mlsdFileLastAccessTime in FMLSDFacts) then begin
          LDate := FTPMLSToGMTDateTime(LValue);
          LDummyDate1 := 0;
          LDummyDate2 := 0;
          FOnSiteUTIME(LContext, LFileName, LDate, LDummyDate1, LDummyDate2, LAuth);
          LValue := FTPGMTDateTimeToMLS(LDate);
          s := s + IndyFormat('Windows.lastaccesstime=%s;', [LValue]);
        end;
      end;
      if s <> '' then begin
        ASender.Reply.SetReply(213, s + ' ' + LFileName);
      end else begin
        ASender.Reply.SetReply(504, IndyFormat(RSFTPParamError, ['MFF']));  {Do not translate}
      end;
    finally
      FreeAndNil(LFacts);
    end;
  end;
end;

function TIdFTPServer.GetMD5Checksum(ASender : TIdFTPServerContext; const AFileName : String ) : String;
var
  LCalcStream : TStream;
begin
  Result := '';
  DoOnMD5Cache(ASender, AFileName, Result);
  if Result = '' then begin
    LCalcStream := nil;
    DoOnCRCFile(ASender, AFileName, LCalcStream);
    if Assigned(LCalcStream) then try
      LCalcStream.Position := 0;
      Result := CalculateCheckSum(TIdHashMessageDigest5, LCalcStream, 0, LCalcStream.Size);
      DoOnMD5Verify(ASender, AFileName, Result);
    finally
      FreeAndNil(LCalcStream);
    end;
  end;
end;

procedure TIdFTPServer.CommandMMD5(ASender: TIdCommand);
var
  LChecksum : String;
  LRes : String;
  LFiles : TStringList;
  LError : Boolean;
  i : Integer;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if GetFIPSMode then begin
    CmdSyntaxError(ASender);
    Exit;
  end;
  LError := False;
  LChecksum := '';
  LRes := '';
  if LContext.IsAuthenticated(ASender) then begin
    LFileSystem := FTPFileSystem;
    if Assigned(FOnCRCFile) or Assigned(FOnMD5Cache) or Assigned(LFileSystem) then begin
      LFiles := TStringList.Create;
      try
        ParseQuotedArgs(ASender.UnparsedParams, LFiles);
        for i := 0 to LFiles.Count -1 do begin
          LChecksum := GetMD5Checksum(LContext, DoProcessPath(LContext, UnquotedStr(LFiles[i])));
          if LChecksum = '' then begin
            LError := True;
            Break;
          end;
          LRes := LRes + ',' + LFiles[i] + ' '+ LChecksum;
        end;
        IdDelete(LRes,1,1);
      finally
        FreeAndNil(LFiles);
      end;
      if LError then begin
        //The http://www.potaroo.net/ietf/idref/draft-twine-ftpmd5/
        //draft didn't specify 550 as an error.
        CmdTwineFileActionAborted(ASender);
      end else begin
        ASender.Reply.SetReply(252, LRes);
      end;
    end else begin
      CmdSyntaxError(ASender);
    end;
  end;
end;

procedure TIdFTPServer.CommandMD5(ASender: TIdCommand);
var
  LChecksum : String;
  LContext : TIdFTPServerContext;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := TIdFTPServerContext(ASender.Context);
  if GetFIPSMode then begin
    CmdSyntaxError(ASender);
    Exit;
  end;
  LChecksum := '';
  if LContext.IsAuthenticated(ASender) then begin
    LFileSystem := FTPFileSystem;
    if Assigned(FOnCRCFile) or Assigned(LFileSystem) then begin
      LChecksum := GetMD5Checksum(LContext, DoProcessPath(LContext, ASender.UnparsedParams));
      if LChecksum = '' then begin
        CmdTwineFileActionAborted(ASender);
      end else begin
        ASender.Reply.SetReply(251, LChecksum);
      end;
    end else begin
      CmdSyntaxError(ASender);
    end;
  end;
end;

procedure TIdFTPServer.DoOnMD5Verify(ASender: TIdFTPServerContext;
  const AFileName, ACheckSum: String);
begin
  if Assigned(OnMD5Verify) then begin
    OnMD5Verify(ASender, AFileName, AChecksum);
  end;
end;

procedure TIdFTPServer.DoOnMD5Cache(ASender: TIdFTPServerContext;
  const AFileName: String; var VCheckSum: String);
begin
  if Assigned(OnMD5Cache) then begin
    OnMD5Cache(ASender, AFileName, VCheckSum);
  end;
end;

procedure TIdFTPServer.DoDisconnect(AContext: TIdContext);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LUserAccounts: TIdCustomUserManager;
begin
  LUserAccounts := FUserAccounts;
  if Assigned(LUserAccounts) then begin
    LUserAccounts.UserDisconnected(TIdFTPServerContext(AContext).UserName);
    {$IFDEF USE_OBJECT_ARC}LUserAccounts := nil;{$ENDIF}
  end;
  inherited DoDisconnect(AContext);
end;

procedure TIdFTPServer.DoOnCRCFile(ASender: TIdFTPServerContext;
  const AFileName: String; var VStream: TStream);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.GetCRCCalcStream(ASender, AFileName, VStream);
  end else if Assigned(FOnCRCFile) then begin
    FOnCRCFile(ASender, AFileName, VStream);
  end;
end;

procedure TIdFTPServer.DoOnCombineFiles(ASender: TIdFTPServerContext;
  const ATargetFileName: string; AParts: TStrings);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.CombineFiles(ASender, ATargetFileName, AParts);
  end else if Assigned(FOnCombineFiles) then begin
    FOnCombineFiles(ASender, ATargetFileName, AParts);
  end;
end;

procedure TIdFTPServer.DoOnRenameFile(ASender: TIdFTPServerContext;
  const ARenameFromFile, ARenameToFile: string);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.RenameFile(ASender, ARenameToFile);
  end else if Assigned(FOnRenameFile) then begin
    FOnRenameFile(ASender, ARenameFromFile, ARenameToFile);
  end;
end;

procedure TIdFTPServer.DoOnGetFileDate(ASender: TIdFTPServerContext;
  const AFilename: string; var VFileDate: TDateTime);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.GetFileDate(ASender, AFileName, VFileDate);
    VFileDate := LocalTimeToUTCTime(VFileDate);
  end else if Assigned(FOnGetFileDate) then begin
    FOnGetFileDate(ASender, AFileName, VFileDate);
  end;
end;

procedure TIdFTPServer.DoOnGetFileSize(ASender: TIdFTPServerContext;
  const AFilename: string; var VFileSize: Int64);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.GetFileSize(ASender, AFileName, VFileSize);
  end else if Assigned(FOnGetFileSize) then begin
    FOnGetFileSize(ASender, AFileName, VFileSize);
  end;
end;

procedure TIdFTPServer.DoOnDeleteFile(ASender: TIdFTPServerContext;
  const APathName: string);
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LFileSystem := FTPFileSystem;
  if Assigned(LFileSystem) then begin
    LFileSystem.DeleteFile(ASender, APathName);
  end else if Assigned(FOnDeleteFile) then begin
    FOnDeleteFile(ASender, APathName);
  end;
end;

procedure TIdFTPServer.SetUseTLS(AValue: TIdUseTLS);
begin
  inherited SetUseTLS(AValue);
  if AValue = utUseImplicitTLS then
  begin
    if DefaultDataPort = IdPORT_FTP_DATA then begin
      DefaultDataPort := IdPORT_ftps_data;
    end;
  end
  else if DefaultDataPort = IdPORT_ftps_data then begin
    DefaultDataPort := IdPORT_FTP_DATA;
  end;
end;

procedure TIdFTPServer.DisconUser(ASender: TIdCommand);
begin
  ASender.Disconnect := True;
  ASender.Reply.SetReply(421, RSFTPClosingConnection);
  if Assigned(OnLoginFailureBanner) then begin
    OnLoginFailureBanner(TIdFTPServerContext(ASender.Context), ASender.Reply);
    ASender.Reply.SetReply(421, ASender.Reply.Text.Text);
  end;
end;

procedure TIdFTPServer.SetRFCReplyFormat(AReply: TIdReply);
begin
  if AReply is TIdReplyFTP then begin
    TIdReplyFTP(AReply).ReplyFormat := rfIndentMidLines;
  end;
end;

procedure TIdFTPServer.CommandSiteATTRIB(ASender : TIdCommand);
var
  LContext : TIdFTPServerContext;
  LFileName,
  LAttrs : String;
  LAttrVal : UInt32;
  LPermitted : Boolean;

  function ValidAttribStr(const AAttrib : String) : Boolean;
  var i : Integer;
  begin
    Result := TextStartsWith(AAttrib, '+');
    if Result then begin
      Result := Length(AAttrib)>1;
      if result then begin
        if AAttrib = '+N' then begin
          Exit;
        end;
        for i := 2 to Length(AAttrib) do begin
          if not CharIsInSet(AAttrib,i,'RASH') then begin
            Result := False;
            break;
          end;
        end;
      end;
    end;
  end;

begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(OnSetAttrib) then begin
      LFileName := ASender.UnparsedParams;
      LAttrs := Fetch(LFileName);
      LPermitted := True;
      LAttrs := UpperCase(LAttrs);
      if TextStartsWith(LAttrs, '+') then begin
        if ValidAttribStr(LAttrs) then begin
          LAttrVal := 0;
          ASender.Reply.Clear;
          ASender.Reply.SetReply(220,'');
          if IndyPos('R', LATTRS) > 0 then begin
            LAttrVal := LAttrVal or IdFILE_ATTRIBUTE_READONLY;
            ASender.Reply.Text.Add(RSFTPSiteATTRIBMsg+' : +FILE_ATTRIBUTE_READONLY'); {Do not localize}
          end;
          if IndyPos('A', LATTRS) > 0 then begin
            LAttrVal := LAttrVal or IdFILE_ATTRIBUTE_ARCHIVE;
            ASender.Reply.Text.Add(RSFTPSiteATTRIBMsg+' : +FILE_ATTRIBUTE_ARCHIVE'); {Do not localize}
          end;
          if IndyPos('S', LATTRS) > 0 then begin
            LAttrVal := LAttrVal or IdFILE_ATTRIBUTE_SYSTEM;
            ASender.Reply.Text.Add(RSFTPSiteATTRIBMsg+' : +FILE_ATTRIBUTE_SYSTEM'); {Do not localize}
          end;
          if IndyPos('H', LATTRS) > 0 then begin
            LAttrVal := LAttrVal or IdFILE_ATTRIBUTE_HIDDEN;
            ASender.Reply.Text.Add(RSFTPSiteATTRIBMsg+' : +FILE_ATTRIBUTE_HIDDEN'); {Do not localize}
          end;
          if IndyPos('N', LATTRS) > 0 then begin
            LAttrVal := LAttrVal or IdFILE_ATTRIBUTE_NORMAL;
            ASender.Reply.Text.Add(RSFTPSiteATTRIBMsg+' : +FILE_ATTRIBUTE_NORMAL'); {Do not localize}
          end;
          ASender.Reply.Text.Add(RSFTPSiteATTRIBMsg + IndyFormat(RSFTPSiteATTRIBDone, [IntToStr(Length(LAttrs)-1)]));
          LFileName := DoProcessPath(LContext, LFileName);
          DoOnSetATTRIB(LContext, LAttrVal, LFileName, LPermitted);
        end else begin
          ASender.Reply.SetReply(550,RSFTPSiteATTRIBInvalid);
          Exit;
        end;
        if not LPermitted then begin
          ASender.Reply.SetReply(553, RSFTPPermissionDenied);
        end;
      end else begin
        ASender.Reply.SetReply(550,RSFTPSiteATTRIBInvalid);
        Exit;
      end;
    end else begin
      ASender.Reply.Assign(FReplyUnknownSITECommand);
    end;
  end;
end;

procedure TIdFTPServer.CommandSiteUTIME(ASender: TIdCommand);

  procedure TryNewFTPSyntax(AContext: TIdFTPServerContext; ALSender: TIdCommand);
  var
    LgMTime : TDateTime;
    LgPermitted : Boolean;
    LFileName : String;
    LDummy1, LDummy2 : TDateTime;
  begin
    //this is for gFTP Syntax
    //such as: "SITE UTIME 20050815041129 /.bashrc"
    LgPermitted := True;
    if ALSender.Params.Count = 0 then begin
      CmdSyntaxError(ALSender);
      Exit;
    end;
    if IsValidTimeStamp(ALSender.Params[0]) then begin
      LFileName := ALSender.UnparsedParams;
      //This is local Time
      LgMTime := UTCTimeToLocalTime(FTPMLSToGMTDateTime(Fetch(LFileName)));
      LFileName := DoProcessPath(AContext, LFileName);
      if Assigned(FOnSiteUTIME) then
      begin
        //indicate that both creation time and last access time should not be set
        LDummy1 := 0;
        LDummy2 := 0;
        FOnSiteUTIME(AContext, LFileName, LDummy1, LgMTime, LDummy2, LgPermitted);
      end
      else if Assigned(FOnSetModifiedTime) then  begin
        FOnSetModifiedTime(AContext, LFileName, LgMTime);
      end;
      if LgPermitted then begin
        ALSender.Reply.SetReply(200, RSFTPCHMODSuccessful);
      end else begin
        ALSender.Reply.SetReply(553, RSFTPPermissionDenied);
      end;
    end else
    begin
      CmdSyntaxError(ALSender);
    end;
  end;

var
  LContext : TIdFTPServerContext;
  LPermitted : Boolean;
  LFileName : String;
  LIdx : Integer;
  LDateCount : Integer;
  LAccessTime, LModTime, LCreateTime : TDateTime;
  i : Integer;
begin
{
This is used by NcFTP like this:

SITE UTIME test.txt 20050731224504 20050731041205 20050731035940 UTC

where the first date is the "Last Access Time"
the second date is the "Last Modified Time"
and the final date is the "Creation File Time"

I think the third parameter is optional.

The final parameter is "UTC"

gFTP does something different.  It does something like:

SITE UTIME 20050815041129 /.bashrc

where the timestamp is probably in based on the local time.
}
  LPermitted := True;
  LAccessTime := 0;
  LModTime := 0;
  LCreateTime := 0;
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then
  begin
    if Assigned(OnSiteUTIME) or Assigned(OnSetModifiedTime) or Assigned(OnSetCreationTime) then begin
      LDateCount := 0;
      LIdx := ASender.Params.Count - 1;
      if ASender.Params.Count > 2 then begin
        LPermitted := True;
        if TextIsSame(ASender.Params[LIdx], 'UTC') then begin
          //figure out how many dates we have and where the end of the filename is
          Dec(LIdx);
          Inc(LDateCount);
          if IsValidTimeStamp(ASender.Params[LIdx]) then begin
            Dec(LIdx);
            Inc(LDateCount);
            if IsValidTimeStamp(ASender.Params[LIdx]) then begin
              Dec(LIdx);
              Inc(LDateCount);
            end;
          end else begin
            TryNewFTPSyntax(LContext, ASender);
            Exit;
          end;
          //now extract the date
          LAccessTime := FTPMLSToGMTDateTime(ASender.Params[LIdx]);
          if LDateCount > 1 then begin
            LModTime := FTPMLSToGMTDateTime(ASender.Params[LIdx+1]);
          end;
          if LDateCount > 2 then begin
             LCreateTime := FTPMLSToGMTDateTime(ASender.Params[LIdx+2]);
          end;
          //extract filename including any spaces
          LFileName := '';
          for i := 0 to LIdx-1 do begin
            LFileName := LFileName + ' ' + ASender.Params[i];
          end;
          IdDelete(LFileName,1,1);
          LFileName := DoProcessPath(LContext,LFileName);
          //now do it
          if Assigned(FOnSiteUTIME) then begin
            FOnSiteUTIME(LContext, LFileName, LAccessTime, LModTime, LCreateTime, LPermitted);
          end else begin
            if (LModTime <> 0) and Assigned(FOnSetModifiedTime) then begin
              FOnSetModifiedTime(LContext, LFileName, LModTime);
            end;
            if (LCreateTime <> 0) and Assigned(FOnSetCreationTime) then begin
              FOnSetCreationTime(LContext, LFileName, LCreateTime);
            end;
          end;
          if LPermitted then begin
            ASender.Reply.SetReply(200, RSFTPCHMODSuccessful);
          end else begin
            ASender.Reply.SetReply(553, RSFTPPermissionDenied);
          end;
          Exit;
        end;
      end;
    end;

    TryNewFTPSyntax(LContext, ASender);
    // CmdNotImplemented(ASender);
  end;
end;

procedure TIdFTPServer.DoOnSiteCHGRP(ASender: TIdFTPServerContext;
  var AGroup: String; const AFileName: String; var VAUth: Boolean);
begin
  if Assigned(FOnSiteCHGRP) then begin
    FOnSiteCHGRP(ASender, AGroup, AFileName, VAuth);
  end;
end;

procedure TIdFTPServer.DoOnSiteCHOWN(ASender: TIdFTPServerContext; var AOwner,
  AGroup: String; const AFileName: String; var VAUth: Boolean);
begin
  if Assigned(FOnSiteCHOWN) then begin
    OnSiteCHOWN(ASender, AOwner, AGroup, AFileName, VAuth);
  end;
end;

procedure TIdFTPServer.CommandSiteCHOWN(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  LPermitted : Boolean;
  LFileName : String;
  LOwner, LGroup : string;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(OnSiteCHOWN) then begin
      LPermitted := True;
      LFileName := ASender.UnparsedParams;
      LGroup := Fetch(LFileName);
      LOwner := Fetch(LGroup,':');
      DoOnSiteCHOWN(LContext, LOwner, LGroup, DoProcessPath(LContext, LFileName), LPermitted);
      if LPermitted then begin
        ASender.Reply.SetReply(220, IndyFormat(RSFTPCmdSuccessful, [ASender.RawLine]));
      end else begin
        ASender.Reply.SetReply(553, RSFTPPermissionDenied);
      end;
    end;
  end;
end;

procedure TIdFTPServer.CommandSiteCHGRP(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  LPermitted : Boolean;
  LFileName : String;
  LGroup : String;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(FOnSiteCHGRP) then begin
      LPermitted := True;
      LFileName := ASender.UnparsedParams;
      LGroup := Fetch(LFileName);
      DoOnSiteCHGRP(LContext, LGroup, DoProcessPath(LContext, LFileName), LPermitted);
      if LPermitted then begin
        ASender.Reply.SetReply(200, IndyFormat(RSFTPCmdSuccessful, [ASender.RawLine]));
      end else begin
        ASender.Reply.SetReply(553, RSFTPPermissionDenied);
      end;
    end;
  end;
end;

procedure TIdFTPServer.CommandSiteCHMOD(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  LPermitted : Boolean;
  LFileName : String;
  LPerms : String;
  LPermNo : Integer;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    LFileSystem := FTPFileSystem;
    if Assigned(OnSiteCHMOD ) or Assigned(LFileSystem) then begin
      LFileName := ASender.UnparsedParams;
      LPerms := Fetch(LFileName);
      If IsValidPermNumbers(LPerms) then begin
        LPermitted := True;
        LPermNo := IndyStrToInt(LPerms, 0);
        DoOnSiteCHMOD(LContext, LPermNo, DoProcessPath(LContext, LFileName), LPermitted);
        if LPermitted then begin
          ASender.Reply.SetReply(220, RSFTPCHMODSuccessful);
        end else begin
          ASender.Reply.SetReply(553, RSFTPPermissionDenied);
        end;
      end else begin
        CmdNotImplemented(ASender);
      end;
    end else begin
      ASender.Reply.Assign(FReplyUnknownSITECommand);
    end;
  end;
end;

procedure TIdFTPServer.CommandSiteUMASK(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  LNewMask : Integer;
  LPermitted : Boolean;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if Assigned(FOnSiteUMASK) then begin
      if ASender.Params.Count > 0 then begin
        If IsValidPermNumbers(ASender.Params[0]) then begin
          LPermitted := True;
          LNewMask := IndyStrToInt(ASender.Params[0], 0);
          DoOnSiteUMASK(LContext, LNewMask, LPermitted);
          if LPermitted then begin
            ASender.Reply.SetReply(200, IndyFormat(RSFTPUMaskSet, [LNewMask, LContext.FUMask]));
            LContext.FUMask := LNewMask;
          end else begin
            ASender.Reply.SetReply(553, RSFTPPermissionDenied);
          end;
        end else begin
          CmdNotImplemented(ASender);
        end;
      end else begin
        ASender.Reply.SetReply(200, IndyFormat(RSFTPUMaskIs, [LContext.FUMask]));
      end;
    end else begin
      CmdNotImplemented(ASender);
    end;
  end;
end;

function TIdFTPServer.IsValidPermNumbers(const APermNos: String): Boolean;
const
  PERMDIGITS = '01234567';
var
  i: Integer;
begin
  Result := False;
  for i := 1 to Length(APermNos) do begin
    if not CharIsInSet(APermNos, i, PERMDIGITS) then begin
      Exit;
    end;
  end;
  Result := True;
end;

procedure TIdFTPServer.DoOnSiteUMASK(ASender: TIdFTPServerContext;
  var VUMASK: Integer; var VAUth: Boolean);
begin
  if Assigned(FOnSiteUMASK) then begin
    FOnSiteUMASK(ASender,VUMASK,VAUth);
  end;
end;

procedure TIdFTPServer.DoOnSetATTRIB(ASender: TIdFTPServerContext; var VAttr : UInt32; const AFileName : String; var VAUth : Boolean);
begin
  if Assigned( FOnSetATTRIB) then begin
    FOnSetATTRIB(ASender, VAttr, AFileName, VAUth);
  end;
end;

procedure TIdFTPServer.DoOnSiteCHMOD(ASender: TIdFTPServerContext;
  var APermissions: Integer; const AFileName: String; var VAUth: Boolean);
begin
  if Assigned(FOnSiteCHMOD) then begin
    FOnSiteCHMOD(ASender,APermissions,AFileName,VAUth);
  end;
end;

procedure TIdFTPServer.CommandSiteDIRSTYLE(ASender: TIdCommand);
//FMSDOSMode
var
  LContext : TIdFTPServerContext;
//SITE DIRSTYLE is only for MS-DOS formatted directory lists so
//a program can flip to Unix directory list format.  This is
//for compatability purposes, ONLY.
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if (FDirFormat = ftpdfDOS) or
    ((FDirFormat = ftpdfOSDependent) and (GOSType = otWindows)) then begin
    if LContext.IsAuthenticated(ASender) then begin
      if ASender.Params.Count = 0 then begin
        LContext.FMSDOSMode := not LContext.FMSDOSMode;
        if LContext.FMSDOSMode then begin
          ASender.Reply.SetReply(200, IndyFormat(RSFTPDirStyle, [RSFTPOn]));
        end else begin
          ASender.Reply.SetReply(200, IndyFormat(RSFTPDirStyle, [RSFTPOff]));
        end;
      end;
    end;
  end else begin
    ASender.Reply.Assign(FReplyUnknownSITECommand);
  end;
end;

procedure TIdFTPServer.CommandSiteHELP(ASender: TIdCommand);
var
  s : String;
  LCmds : TStringList;
  LContext : TIdFTPServerContext;
begin
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    s := RSFTPSITECmdsSupported+EOL;
    LCmds := TStringList.Create;
    try
      if Assigned(OnSetAttrib) then begin
        LCmds.Add('ATTRIB'); {Do not translate}
      end;
      if Assigned(OnSiteCHMOD) then begin
         LCmds.Add('CHMOD'); {Do not translate}
      end;
      if (FDirFormat = ftpdfDOS) or
        ((FDirFormat = ftpdfOSDependent) and (GOSType = otWindows)) then begin
        LCmds.Add('DIRSTYLE'); {Do not translate}
      end;
      if Assigned(OnSiteUMASK) then begin
        LCmds.Add('UMASK'); {Do not translate}
      end;
      LCmds.Add('ZONE');  {Do not translate}
      s := s + HelpText(LCmds) + FEndOfHelpLine;
      ASender.Reply.SetReply(214, s);
    finally
      FreeAndNil(LCmds);
    end;
  end;
end;

function TIdFTPServer.HelpText(Cmds: TStrings): String;
var
  LRows : Integer;
  LMod : Integer;
  i : Integer;
begin
  Result := '';
  if Cmds.Count =0 then begin
    Exit;
  end;
  LRows := Cmds.Count div 6;
  LMod := Cmds.Count mod 6;
  if Cmds.Count < 6 then begin
    Result := '    ';
    for i := 0 to Cmds.Count -1 do begin
      Result := Result + IndyFormat('%-10s', [Cmds[i]]);
    end;
    Result := Result + CR;
  end else begin
    for i := 0 to (LRows -1) do begin
      if (i <= LMod-1) and (LMod<>0) then begin
        Result := Result + IndyFormat('    %-10s%-10s%-10s%-10s%-10s%-10s%-10s',   {Do not translate}
          [ Cmds[i],Cmds[i+LRows],Cmds[(LRows*2)+i],
          Cmds[(LRows*3)+i],Cmds[(LRows*4)+i],Cmds[(LRows*5)+i],
          Cmds[(LRows*6)+i]])+CR;
      end else begin
        Result := Result + IndyFormat('    %-10s%-10s%-10s%-10s%-10s%-10s',  {Do not translate}
          [ Cmds[i],Cmds[i+LRows],Cmds[(LRows*2)+i],
          Cmds[(LRows*3)+i],Cmds[(LRows*4)+i],Cmds[(LRows*5)+i]])+CR;
      end;
    end;
  end;
end;

procedure TIdFTPServer.CommandSITE(ASender: TIdCommand);
var
  LCmd : String;
begin
  LCmd := ASender.UnparsedParams;
  ASender.Reply.Clear;
  ASender.PerformReply := False;
  if not FSITECommands.HandleCommand(ASender.Context, LCmd) then begin
     ASender.Reply.NumericCode := 500;
     CmdSyntaxError(ASender.Context, ASender.CommandHandler.Command + ' ' + LCmd, ASender.Reply);
     ASender.PerformReply := False;
  end;
end;

function TIdFTPServer.MLSFEATLine(const AFactMask: TIdMLSDAttrs;
  const AFacts: TIdFTPFactOutputs): String;
begin
  Result := 'MLST size'; {Do not translate}
  //the * indicates if the option is selected for MLST
  if Size in AFacts then begin {Do not translate}
    Result := Result + '*;';
  end else begin
    Result := Result + ';'
  end;
  Result := Result + 'Type'; {Do not translate}
  if ItemType in AFacts then begin {Do not translate}
    Result := Result + '*;';  {Do not translate}
  end else begin
    Result := Result + ';';
  end;
  if mlsdPerms in FMLSDFacts then begin
    Result := Result + 'Perm'; {Do not translate}
    if Perm in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  if mlsdFileCreationTime in FMLSDFacts then begin
    Result := Result + 'Create';  {Do not translate}
    if CreateTime in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  Result := Result + 'Modify';  {Do not translate}
  if Modify in AFacts then begin
    Result := Result + '*;';
  end else begin
    Result := Result + ';';
  end;
  if mlsdUnixModes in FMLSDFacts then begin
    Result := Result + 'UNIX.mode';  {Do not translate}
    if UnixMODE in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  if mlsdUnixOwner in FMLSDFacts then
  begin
    Result := Result + 'UNIX.owner'; {Do not translate}
    if UnixOwner in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  if mlsdUnixGroup in FMLSDFacts then begin
    Result := Result + 'UNIX.group';  {Do not translate}
    if UnixGroup in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  if mlsdUniqueID in FMLSDFacts then begin
    Result := Result + 'Unique'; {Do not translate}
    if Unique in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  if mlsdFileLastAccessTime in FMLSDFacts then begin
    Result := Result + 'Windows.lastaccesstime';  {Do not translate}
    if CreateTime in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  if mlsdWin32Attributes in FMLSDFacts then begin
    Result := Result + 'Win32.ea';  {Do not translate}
    if WinAttribs in AFacts then begin {Do not translate}
      Result := Result + '*;';  {Do not translate}
    end else begin
      Result := Result + ';';
    end;
  end;
  if  mlsdWin32DriveType in FMLSDFacts then begin
    Result := Result + 'Win32.dt';
    if WinDriveType in AFacts then begin
      Result := Result + '*;';  {Do not localize}
    end else begin
      Result := Result + ';';  {Do not localize}
    end;
  end;
  if  mlstWin32DriveLabel in FMLSDFacts then begin
    Result := Result + 'Win32.dl';
    if WinDriveLabel in AFacts then begin
      Result := Result + '*;';  {Do not localize}
    end else begin
      Result := Result + ';';  {Do not localize}
    end;
  end;
  if Length(Result)>0 then begin
    IdDelete(Result,Length(Result),1);
  end;
end;

procedure TIdFTPServer.CommandCLNT(ASender: TIdCommand);
begin
  if Assigned(FOnClientID) then begin
    FOnClientID(ASender.Context as TIdFTPServerContext, ASender.UnparsedParams);
  end;
end;

procedure TIdFTPServer.SetPASVBoundPortMax(const AValue: TIdPort);
begin
  if FPASVBoundPortMin <> 0 then begin
    if AValue <= FPASVBoundPortMin then begin
      raise EIdFTPBoundPortMaxGreater.Create(RSFTPPASVBoundPortMaxMustBeGreater);
    end;
  end;
  FPASVBoundPortMax := AValue;
end;

procedure TIdFTPServer.SetPASVBoundPortMin(const AValue: TIdPort);
begin
  if FPASVBoundPortMax <> 0 then begin
    if FPASVBoundPortMax <= AValue then begin
      raise EIdFTPBoundPortMinLess.Create(RSFTPPASVBoundPortMinMustBeLess);
    end;
  end;
  FPASVBoundPortMin := AValue;
end;

procedure TIdFTPServer.DoOnDataPortAfterBind(ASender: TIdFTPServerContext);
begin
  if Assigned(FOnDataPortAfterBind) then begin
    FOnDataPortAfterBind(ASender);
  end;
end;

procedure TIdFTPServer.DoOnDataPortBeforeBind(ASender: TIdFTPServerContext);
begin
  if Assigned(FOnDataPortBeforeBind) then begin
    FOnDataPortBeforeBind(ASender);
  end;
end;

function TIdFTPServer.FTPNormalizePath(const APath: String): String;
{
Microsoft IIS accepts both a "/" and a "\" as path/file name separators.
We have to flatten this out so that our FTP server can behave like Microsoft IIS.

In Unix, a "\" is a valid filename character so we don't anything there.

This WILL cause a "\" to be treated differently in Unix and Win32.  I submit that
this is really desirable as both file systems are like apples and oranges.
}
begin
  case FPathProcessing of
    ftppDOS : Result := ReplaceAll(APath, '\', '/');
    ftpOSDependent :
      begin
        if GOSType = otWindows then begin
          Result := ReplaceAll(APath, '\', '/');
        end else begin
          Result := APath;
        end;
      end;
    else
      Result := APath;
  end;
end;

function TIdFTPServer.DoProcessPath(ASender: TIdFTPServerContext; const APath: TIdFTPFileName): TIdFTPFileName;
begin
  if FPathProcessing <> ftppCustom then begin
    Result := FTPNormalizePath(APath);
    Result := ProcessPath(ASender.CurrentDir, Result);    {Do not Localize}
  end else begin
    Result := APath;
    if Assigned(FOnCustomPathProcess) then begin
      FOnCustomPathProcess(ASender, Result);
    end;
  end;
end;

function TIdFTPServer.CDUPDir(AContext : TIdFTPServerContext) : String;
const
  LCDUP_DOS = '..\';
  CDUP_UNIX = '../';
begin
  case FPathProcessing of
    ftppDOS : Result := LCDUP_DOS;
    ftpOSDependent :
      if GOSType = otWindows then begin
        Result := LCDUP_DOS;
      end else begin
        Result := CDUP_UNIX;
      end;
    ftppCustom : Result := DoProcessPath(AContext, '..');
    else
      Result := CDUP_UNIX;
  end;
end;

function TIdFTPServer.DoSysType(ASender: TIdFTPServerContext): String;
begin
//We tie the SYST descriptor to the directory style for compatability
//reasons.  Some FTP clients use the SYST descriptor to determine what
//type of FTP directory list parsing to do.  I think TurboPower IPros does this.
//Note that I personally do not find this to be sound as a general rule.
  case FDirFormat of
    ftpdfOSDependent :
    begin
      if GOSType = otWindows then begin
        Result := SYST_ID_NT;
      end else begin
        Result := SYST_ID_UNIX;
      end;
    end;
    ftpdfUnix, ftpdfEPLF : Result := SYST_ID_UNIX;
    ftpdfDOS : Result := SYST_ID_NT;
    ftpdfCustom : Result := FCustomSystID;
  end;
end;

procedure TIdFTPServer.DoOnCustomListDirectory(
  ASender: TIdFTPServerContext; const APath: string;
  ADirectoryListing: TStrings; const ACmd, ASwitches: String);
begin
  if Assigned(OnCustomListDirectory) then begin
    OnCustomListDirectory(ASender,APath,ADirectoryListing,ACmd,ASwitches);
  end;
end;

procedure TIdFTPServer.CmdNotImplemented(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(550, IndyFormat(RSFTPCmdNotImplemented, [ASender.CommandHandler.Command ]));
end;

procedure TIdFTPServer.CmdFileActionAborted(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(550, RSFTPFileActionAborted);
end;

//This is for where the client didn't provide a valid number of parameters for a command
procedure TIdFTPServer.CmdInvalidParamNum(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(501, IndyFormat(RSFTPInvalidNumberArgs, [ASender.CommandHandler.Command]));
end;

//This is for other command syntax issues.
procedure TIdFTPServer.CmdInvalidParams(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(501, IndyFormat(RSFTPParamError, [ASender.CommandHandler.Command]));
end;

procedure TIdFTPServer.CmdTwineFileActionAborted(ASender: TIdCommand);
begin
  ASender.Reply.SetReply(504, RSFTPFileActionAborted);
end;

procedure TIdFTPServer.CmdCommandSuccessful(ASender: TIdCOmmand; const AReplyCode : Integer = 250);
begin
  ASender.Reply.SetReply(AReplyCode, IndyFormat(RSFTPCmdSuccessful, [ASender.CommandHandler.Command]));
end;

procedure TIdFTPServer.CommandSSCN(ASender: TIdCommand);
const
  REPLY_SSCN_ON = 'SSCN:CLIENT METHOD';                 {do not localize}
  REPLY_SSCN_OFF = 'SSCN:SERVER METHOD';                {do not localize}
var
  LContext : TIdFTPServerContext;
begin
  if UseTLS = utNoTLSSupport then begin
    CmdNotImplemented(ASender);
    Exit;
  end;
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if ASender.Params.Count = 0 then begin
      //check state
      if LContext.SSCNOn then begin
        ASender.Reply.SetReply(200, REPLY_SSCN_ON);
      end else begin
        ASender.Reply.SetReply(200, REPLY_SSCN_OFF);
      end;
    end else begin
      //set state
      case PosInStrArray(ASender.Params[0], OnOffStates, False) of
        0 : //'ON'
        begin
          LContext.SSCNOn := True;
          ASender.Reply.SetReply(200, REPLY_SSCN_ON);
        end;
        1 : //'OFF'
        begin
          LContext.SSCNOn := False;
          ASender.Reply.SetReply(200, REPLY_SSCN_OFF);
        end;
      else
        ASender.Reply.SetReply(504,  RSFTPInvalidForParam);
      end;
    end;
  end;
end;

procedure TIdFTPServer.CommandCPSV(ASender: TIdCommand);
var
  LContext : TIdFTPServerContext;
  LIO : TIdSSLIOHandlerSocketBase;
begin
  //CPSV must be used with SSL and can only be used with IPv4
  if (UseTLS = utNoTLSSupport) or
    (ASender.Context.Binding.IPVersion <> Id_IPv4) then begin
    CmdSyntaxError(ASender);
    Exit;
  end;
  CommandPASV(ASender);
  LContext := TIdFTPServerContext(ASender.Context);
  LIO := LContext.DataChannel.FDataChannel.IOHandler as TIdSSLIOHandlerSocketBase;
   //tell IOHandler to use ssl_Conntect
  LIO.IsPeer := False;
end;

procedure TIdFTPServer.CommandSiteZONE(ASender: TIdCommand);
var
  LMin : Integer;
  LFmt: string;
begin
  LMin := MinutesFromGMT;
  //plus must always be displayed for positive numbers
  if LMin < 0 then begin
    LFmt := 'UTC%d'; {do not localize}
  end else begin
    LFmt := 'UTC+%d'; {do not localize}
  end;
  ASender.Reply.SetReply(210, IndyFormat(LFmt, [LMin]));
end;

procedure TIdFTPServer.CommandCheckSum(ASender: TIdCommand);
const
  HashTypes: array[0..4] of TIdHashClass = (TIdHashCRC32, TIdHashMessageDigest5, TIdHashSHA1, TIdHashSHA256, TIdHashSHA512);
var
  LCalcStream : TStream;
  LFileName, LCheckSum, LBuf : String;
  LBeginPos, LEndPos : TIdStreamSize;
  LContext : TIdFTPServerContext;
  LHashIdx: Integer;
  // under ARC, convert a weak reference to a strong reference before working with it
  LFileSystem: TIdFTPBaseFileSystem;
begin
  if GetFIPSMode and
    (PosInStrArray(ASender.CommandHandler.Command, ['XCRC', 'XMD5']) > -1) then begin
    CmdSyntaxError(ASender);
    Exit;
  end;
  LFileSystem := FTPFileSystem;
  if Assigned(FOnCRCFile) or Assigned(LFileSystem) then begin
    LContext := TIdFTPServerContext(ASender.Context);
    if LContext.IsAuthenticated(ASender) then begin
      LBuf := ASender.UnparsedParams;
      if Pos('"', LBuf) > 0 then begin {do not localize}
        Fetch(LBuf, '"'); {do not localize}
        LFileName := Fetch(LBuf, '"'); {do not localize}
      end else begin
        LFileName := Fetch(LBuf);
      end;
      if LFileName = '' then begin
        CmdInvalidParamNum(ASender);
        Exit;
      end;
      LBuf := Trim(LBuf);
      if LBuf <> '' then begin
        LBeginPos := IndyStrToStreamSize(Fetch(LBuf), -1);
        if LBeginPos < 0 then begin
          CmdInvalidParams(ASender);
          Exit;
        end;
        LBuf := Trim(LBuf);
        if LBuf <> '' then begin
          LEndPos := IndyStrToStreamSize(Fetch(LBuf), -1);
          if LEndPos < 0 then begin
            CmdInvalidParams(ASender);
            Exit;
          end;
        end else begin
          LEndPos := -1;
        end;
      end else begin
        LBeginPos := 0;
        LEndPos := -1;
      end;
      LCalcStream := nil;
      LFileName := DoProcessPath(LContext, LFileName);
      DoOnCRCFile(LContext, LFileName, LCalcStream);
      if Assigned(LCalcStream) then begin
        if LEndPos = -1 then begin
          LEndPos := LCalcStream.Size;
        end;
        try
          LCalcStream.Position := 0;
          LHashIdx := PosInStrArray(ASender.CommandHandler.Command, ['XCRC', 'XMD5', 'XSHA1','XSHA256','XSHA512'], False); {do not localize}
          LCheckSum := CalculateCheckSum(HashTypes[LHashIdx], LCalcStream, LBeginPos, LEndPos);
          ASender.Reply.SetReply(250, LCheckSum);
        finally
          FreeAndNil(LCalcStream);
        end;
      end else begin
        CmdFileActionAborted(ASender);
      end;
    end;
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.DoOnFileExistCheck(AContext: TIdFTPServerContext;
  const AFileName: String; var VExist: Boolean);
begin
  if Assigned(FOnFileExistCheck) then begin
    FOnFileExistCheck(AContext, AFileName, VExist);
  end;
end;

procedure TIdFTPServer.CommandSPSV(ASender: TIdCommand);
var
  LIP : String;
  LBPort : Word;
  LIPVer : TIdIPVersion;
begin
  //just to keep the compiler happy
  LBPort := 0;
  if InternalPASV(ASender, LIP, LBPort, LIPVer) then begin
    ASender.Reply.SetReply(227, IntToStr(LBPort));
  end;
end;

function TIdFTPServer.InternalPASV(ASender: TIdCommand; var VIP : String;
  var VPort: TIdPort; var VIPVersion : TIdIPVersion): Boolean;
var
  LContext : TIdFTPServerContext;
  LBPortMin, LBPortMax: TIdPort;
  LDataChannel: TIdSimpleServer;
begin
  Result := False;
  LContext := ASender.Context as TIdFTPServerContext;
  if LContext.IsAuthenticated(ASender) then begin
    if LContext.FEPSVAll then begin
      ASender.Reply.SetReply(501, IndyFormat(RSFTPNotAllowedAfterEPSVAll, [ASender.CommandHandler.Command]));
      Exit;
    end;

    VIP := LContext.Binding.IP;
    VIPVersion := LContext.Binding.IPVersion;

    if (FPASVBoundPortMin <> 0) and (FPASVBoundPortMax <> 0) then begin
      LBPortMin := FPASVBoundPortMin;
      LBPortMax := FPASVBoundPortMax;
    end else begin
      LBPortMin := FDefaultDataPort;
      LBPortMax := LBPortMin;
    end;
    DoOnPASVBeforeBind(LContext, VIP, LBPortMin, LBPortMax, VIPVersion);

    LContext.CreateDataChannel(True);
    LDataChannel := TIdSimpleServer(LContext.FDataChannel.FDataChannel);
    LDataChannel.BoundIP := VIP;
    if LBPortMin = LBPortMax then begin
      LDataChannel.BoundPort := LBPortMin;
      LDataChannel.BoundPortMin := 0;
      LDataChannel.BoundPortMax := 0;
    end else begin
      LDataChannel.BoundPort := 0;
      LDataChannel.BoundPortMin := LBPortMin;
      LDataChannel.BoundPortMax := LBPortMax;
    end;
    LDataChannel.IPVersion := VIPVersion;
    LDataChannel.BeginListen;
    VIP := LDataChannel.Binding.IP;
    VPort := LDataChannel.Binding.Port;

    LContext.FPASV := True;
    LContext.FDataPortDenied := False;
    Result := True;
  end;
end;

procedure TIdFTPServer.DoOnPASVBeforeBind(ASender: TIdFTPServerContext;
  var VIP: String; var VPortMin, VPortMax: TIdPort; const AIPVersion: TIdIPVersion);
begin
  if Assigned(FOnPASVBeforeBind) then begin
    FOnPASVBeforeBind(ASender, VIP, VPortMin, VPortMax, AIPVersion);
  end;
end;

procedure TIdFTPServer.DoOnPASVReply(ASender: TIdFTPServerContext;
  var VIP: String; var VPort: TIdPort; const AIPVersion: TIdIPVersion);
begin
  if Assigned(FOnPASVReply) then begin
    FOnPASVReply(ASender, VIP, VPort, AIPVersion);
  end;
end;

function TIdFTPServer.ReadCommandLine(AContext: TIdContext): string;
var
  i : Integer;
  State: TIdFTPTelnetState;
  lb : Byte;
  LContext: TIdFTPServerContext;
  { Receive the line in 8-bit initially so that .NET can then
    decode any UTF-8 data into a Unicode string afterwards if
    needed }
  LLine: TIdBytes;
  LReply: TIdBytes;
  Finished: Boolean;
begin
  Result := '';
  LContext := AContext as TIdFTPServerContext;
  //we do it this way in case there's no data.  We don't want to stop
  //a data channel operation if that's the case.
  AContext.Connection.IOHandler.CheckForDataOnSource(1);
  if AContext.Connection.IOHandler.InputBufferIsEmpty then begin
    Exit;
  end;
  //
  SetLength(LLine, 0);
  SetLength(LReply, 0);
  Finished := False;

  State := tsData;
  repeat
    lb := AContext.Connection.IOHandler.ReadByte;
    case State of
      tsData:
      begin
        case lb of
          $FF: //is a command
          begin
            State := tsIAC;
          end;
          $0D: //wait for the next character to see what to do
          begin
            State := tsCheckCR;
          end;
        else
          AppendByte(LLine, lb);
        end;
      end;

      tsCheckCR:
      begin
        case lb of
          $0: // preserve CR
          begin
            AppendByte(LLine, $0D);
            State := tsData;
          end;
          $0A:
          begin
            State := tsData;
            Finished := True;
          end;
          $FF: //unexpected IAC, just in case
          begin
            AppendByte(LLine, $0D);
            State := tsIAC;
          end;
        else
          ExpandBytes(LLine, Length(LLine), 2);
          LLine[Length(LLine)-2] := $0D;
          LLine[Length(LLine)-1] := lb;
          State := tsData;
        end;
      end;

      tsIAC:
      begin
        case lb of
          $F1, //no-operation - do nothing
          $F3: //break - do nothing for now
          begin
            State := tsData;
          end;
          $F4: //interrupt process - clear result and wait for data mark
          begin
            SetLength(LLine, 0);
            State := tsInterrupt;
          end;
          $F5: //abort output
          begin
            // note - the DM needs to be sent as OOB "Urgent" data

            SetLength(LReply, 4);

            // TELNET_IP
            LReply[0] := $FF;
            LReply[1] := $F4;

            // TELNET_DM
            LReply[2] := $FF;
            LReply[3] := $F2;

            AContext.Connection.IOHandler.Write(LReply);
            SetLength(LReply, 0);

            State := tsData;
          end;
          $F6: //are you there - do nothing for now
          begin
            State := tsData;
          end;
          $F7: //erase character
          begin
            i := Length(LLine);
            if i > 0 then begin
              SetLength(LLine, i-1);
            end;
            State := tsData;
          end;
          $F8 : //erase line
          begin
            SetLength(LLine, 0);
            State := tsData;
          end;
          $F9 : //go ahead - do nothing for now
          begin
            State := tsData;
          end;
          $FA : //begin sub-negotiation
          begin
            State := tsNegotiate;
          end;
          $FB : //I will use
          begin
            State := tsWill;
          end;
          $FC : //you won't use
          begin
            State := tsWont;
          end;
          $FD : //please, you use option
          begin
            State := tsDo;
          end;
          $FE : //please, you stop option
          begin
            State := tsDont;
          end;
          $FF : //data $FF
          begin
            AppendByte(LLine, $FF);
            State := tsData;
          end;
        else
          // unknown command, ignore
          State := tsData;
        end;
      end;

      tsWill:
      begin
        SetLength(LReply, 3);

        // TELNET_WONT
        LReply[0] := $FF;
        LReply[1] := $FC;
        LReply[2] := lb;

        AContext.Connection.IOHandler.Write(LReply);
        SetLength(LReply, 0);

        State := tsData;
      end;

      tsDo:
      begin
        SetLength(LReply, 3);

        // TELNET_DONT
        LReply[0] := $FF;
        LReply[1] := $FE;
        LReply[2] := lb;

        AContext.Connection.IOHandler.Write(LReply);
        SetLength(LReply, 0);

        State := tsData;
      end;

      tsWont,
      tsDont:
      begin
        State := tsData;
      end;

      tsNegotiate:
      begin
        State := tsNegotiateData;
      end;

      tsNegotiateData:
      begin
        case lb of
          $FF: //is a command?
          begin
            State := tsNegotiateIAC;
          end;
        end;
      end;

      tsNegotiateIAC:
      begin
        case lb of
          $F0: //end sub-negotiation
          begin
            State := tsData;
          end;
        else
          State := tsNegotiateData;
        end;
      end;

      tsInterrupt:
      begin
        case lb of
          $FF: //is a command?
          begin
            State := tsInterruptIAC;
          end;
        end;
      end;

      tsInterruptIAC:
      begin
        case lb of
          $F2: //data mark
          begin
            State := tsData;
          end;
        end;
      end;

    else
      State := tsData;
    end;

  until Finished or (not AContext.Connection.IOHandler.Connected);

  //The last char was #13, we have to make sure that we remove a trailing
  //#10 if it exists so that it doesn't appear in the next line.
  if (lb = $0D) and (State = tsData) then
  begin
    i := AContext.Connection.IOHandler.InputBuffer.Size;
    if i > 0 then begin
      lb := AContext.Connection.IOHandler.InputBuffer.PeekByte(i - 1);
      if lb = $0A then begin
        AContext.Connection.IOHandler.ReadByte;
      end;
    end;
  end;

  Result := BytesToString(LLine, 0, MaxInt, LContext.Connection.IOHandler.DefStringEncoding);
end;

procedure TIdFTPServer.DoReplyUnknownCommand(AContext: TIdContext; ALine: string);
begin
  CmdSyntaxError(AContext, ALine);
end;

procedure TIdFTPServer.DoTerminateContext(AContext: TIdContext);
begin
  try
    TIdFTPServerContext(AContext).KillDataChannel;
  finally
    inherited DoTerminateContext(AContext);
  end;
end;

procedure TIdFTPServer.CmdSyntaxError(AContext: TIdContext; ALine: string; const AReply : TIdReply = nil);
var
  LTmp : String;
  LReply : TIdReply;
begin
  //First make the first word upper-case
  LTmp := UpCaseFirstWord(ALine);
  try
    if Assigned(AReply) then begin
      LReply := AReply;
    end else begin
      LReply := FReplyClass.CreateWithReplyTexts(nil, ReplyTexts);
      LReply.Assign(ReplyUnknownCommand);
    end;
    LReply.Text.Clear;
    LReply.Text.Add(IndyFormat(RSFTPCmdNotRecognized, [LTmp]));
    AContext.Connection.IOHandler.Write(LReply.FormattedReply);
  finally
    if not Assigned(AReply) then begin
      FreeAndNil(LReply);
    end;
  end;
end;

procedure TIdFTPServer.CmdSyntaxError(ASender: TIdCommand);
begin
  CmdSyntaxError(ASender.Context, ASender.RawLine, FReplyUnknownCommand );
  ASender.PerformReply := False;
end;

procedure TIdFTPServer.CommandSecRFC(ASender: TIdCommand);
//stub for RFC 2228 commands that we don't implement as
//part of the SSL framework.
begin
  if IOHandler is TIdServerIOHandlerSSLBase then begin
    CmdNotImplemented(ASender);
  end else begin
    CmdSyntaxError(ASender);
  end;
end;

procedure TIdFTPServer.CommandOptsMLST(ASender: TIdCommand);
const
  LVALIDOPTS : array [0..12] of string =
  ('type', 'size', 'modify',
    'UNIX.mode', 'UNIX.owner', 'UNIX.group',
    'unique', 'perm', 'create',
    'windows.lastaccesstime','win32.ea','win32.dt','win32.dl'); {Do not localize}
var
  s: string;
  LContext : TIdFTPServerContext;

  function ParseMLSParms(ASvr : TIdFTPServer; const AParms : String) : TIdFTPFactOutputs;
  var
    Ls : String;
  begin
    Result := [];
    Ls := UpperCase(AParms);
    while Ls <> '' do begin
      case PosInStrArray(Fetch(Ls,';'), LVALIDOPTS, False) of
        0 : Result := Result + [ItemType]; //type
        1 : Result := Result + [Size]; //size
        2 : Result := Result + [Modify]; //modify
        3 : if mlsdUnixModes in ASvr.FMLSDFacts then begin
              Result := Result + [UnixMODE]; //UnixMode
            end;
        4 : if mlsdUnixOwner in ASvr.FMLSDFacts then begin
              Result := Result + [UnixOwner]; //UNIX.owner
            end;
        5 : if mlsdUnixGroup in ASvr.FMLSDFacts then begin
              Result := Result + [UnixGroup]; //UNIX.group
            end;
        6 : if mlsdUniqueID in ASvr.FMLSDFacts then begin //Unique
              Result := Result + [Unique];
            end;
        7 : if mlsdPerms in ASvr.FMLSDFacts then begin  //perm
              Result := Result + [Perm];
            end;
        8 : if mlsdFileCreationTime in ASvr.FMLSDFacts then begin
              Result := Result + [CreateTime];
            end;
        9 : if mlsdFileLastAccessTime in ASvr.FMLSDFacts then begin
              Result := Result + [LastAccessTime];
            end;
        10 : if mlsdWin32Attributes in ASvr.FMLSDFacts then begin
              Result := Result + [WinAttribs];
            end;
        11 : if mlsdWin32DriveType in ASvr.MLSDFacts then begin
               Result := Result + [WinDriveType];
             end;
        12 : if  mlstWin32DriveLabel in ASvr.MLSDFacts then begin
               Result := Result + [WinDriveLabel];
             end;
      end;
    end;
  end;

  function SetToOptsStr(AFacts : TIdFTPFactOutputs) : String;
  begin
    Result := '';
    if Size in AFacts then begin {Do not translate}
      Result := Result + 'size;';  {Do not localize}
    end;
    if ItemType in AFacts then begin {Do not translate}
      Result := Result + 'type;';  {Do not translate}
    end;
    if Perm in AFacts then begin {Do not translate}
      Result := Result + 'perm;';  {Do not translate}
    end;
    if CreateTime in AFacts then begin {Do not translate}
      Result := Result + 'create;';  {Do not translate}
    end;
    if Modify in AFacts then begin
      Result := Result + 'modify;';  {Do not translate}
    end;
    if UnixMODE in AFacts then begin {Do not translate}
      Result := Result + 'UNIX.mode;';  {Do not translate}
    end;
    if UnixOwner in AFacts then begin{Do not translate}
      Result := Result + 'UNIX.owner;';  {Do not translate}
    end;
    if UnixGroup in AFacts then begin {Do not translate}
      Result := Result + 'UNIX.group;';  {Do not translate}
    end;
    if Unique in AFacts then begin {Do not translate}
      Result := Result + 'unique;';  {Do not translate}
    end;
    if LastAccessTime in AFacts then begin
      Result := Result + 'windows.lastaccesstime;';  {Do not translate}
    end;
    if IdFTPListOutput.WinAttribs in AFacts then begin
      Result := Result + 'win32.ea;'; {Do not translate}
    end;
    if IdFTPListOutput.WinDriveType in AFacts then begin
      Result := Result + 'Win32.dt;';  {Do not localize}
    end;
    if IdFTPListOutput.WinDriveLabel in AFacts then begin
      Result := Result + 'Win32.dl;';  {Do not localize}
    end;
  end;

begin
  LContext := ASender.Context as TIdFTPServerContext;
  s := ASender.UnparsedParams;
  if IndyPos(' ', s) = 0 then begin
    LContext.MLSOpts := ParseMLSParms(Self, Trim(s));
    //the string is standardized format
    ASender.Reply.SetReply(200, Trim(IndyFormat('MLST OPTS %s', [SetToOptsStr(LContext.MLSOpts)]))); {Do not Localize}
  end else begin
    ASender.Reply.SetReply(501, IndyFormat(RSFTPInvalidOps, ['MLST'])); {Do not Localize}
  end;
end;

procedure TIdFTPServer.CommandOptsMODEZ(ASender: TIdCommand);
const
  OPT_NAMES : Array[0..4] of String =
    ('ENGINE','LEVEL','METHOD','BLOCKSIZE','EXTRA'); {do not localize}
var
  s: string;
  LOptName, LOptVal : String;
  LContext : TIdFTPServerContext;
  LFirstPar : Boolean;
  LError : Boolean;
  LNoVal : Integer;
  LReset : Boolean;

  procedure ReportSettings(ACxt : TIdFTPServerContext; AReply : TIdReply);
  begin
    AReply.NumericCode := 200;
    AReply.Text.Clear;
    AReply.Text.Add('MODE Z ENGINE set to ZLIB.');  {do not localize}
    AReply.Text.Add('MODE Z LEVEL set to ' + IntToStr(ACxt.FZLibCompressionLevel) + '.'); {do not localize}
    AReply.Text.Add('MODE Z METHOD set to ' + IntToStr(DEF_ZLIB_METHOD) + '.'); {do not localize}
  end;

  procedure SyntaxError(AReply : TIdCommand);
  var
    LOpts : String;
  begin
    //drop the OPTS part of the command for display
    LOpts := ASender.RawLine;
    Fetch(LOpts);
    LOpts := TrimLeft(LOpts);
    ASender.Reply.SetReply(501, IndyFormat(RSFTPInvalidOps, [LOpts]));
  end;

begin
  LFirstPar := True;
  LReset := True;
  LError := True;
  LContext := ASender.Context as TIdFTPServerContext;
  s := Trim(ASender.UnparsedParams);
  if s = '' then begin
    LContext.ResetZLibSettings;
    ReportSettings(LContext, ASender.Reply);
  end;
  repeat
    LOptName := Fetch(s);
    if s = '' then begin
      if LFirstPar then begin
        SyntaxError(ASender);
        Exit;
      end;
    end;
    LOptVal := Fetch(s);
    if Trim(s) <> '' then begin
      //if there's more, than we see if there's a valid option.
      LFirstPar := False;
    end;
    if LFirstPar and (PosInStrArray(LOptName, OPT_NAMES, False) = -1) then begin
      SyntaxError(ASender);
      Exit;
    end;
    LFirstPar := False;
    case PosInStrArray(LOptName, OPT_NAMES, False) of
      0 : //'ENGINE'  - we only support ZLIB
          begin
            LError := False;
          end;
      1 : begin  //,'LEVEL', - implemented
            LNoVal := IndyStrToInt(LOptVal, -1);
            if (LNoVal > -1) and (LNoVal < 8) then begin
              LContext.FZLibCompressionLevel := LNoVal;
              LReset := False;
              LError := False;
            end;
          end;
      2 : begin //'METHOD', - not implemented - jst do syntax check
            LNoVal := IndyStrToInt(LOptVal, -1);
            if LNoVal <> -1 then begin
              LError := False;
            end;
          end;
      3 : begin  ///'BLOCKSIZE',   -not implemented - just do syntax check
            LNoVal := IndyStrToInt(LOptVal, -1);
            if LNoVal <> -1 then begin
              LError := False;
            end;
          end;
      4 : begin  //'EXTRA') - not implemented - just do syntax check
            if PosInStrArray(LOptVal, OnOffStates, False) > -1 then begin
              LError := False;
            end;
          end;
    end;
  until (s = '');

  if LError then begin
    SyntaxError(ASender);
    Exit;
  end;
  if LReset then begin
    LContext.ResetZLibSettings;
  end;
  ReportSettings(LContext, ASender.Reply);
end;

procedure TIdFTPServer.CommandOptsUTF8(ASender: TIdCommand);
var
  s: String;
  LContext: TIdFTPServerContext;

  procedure SyntaxError(AReply : TIdCommand);
  var
    LOpts : String;
  begin
    //drop the OPTS part of the command for display
    LOpts := ASender.RawLine;
    Fetch(LOpts);
    LOpts := TrimLeft(LOpts);
    ASender.Reply.SetReply(501, IndyFormat(RSFTPInvalidOps, [LOpts]));
  end;

begin
  LContext := ASender.Context as TIdFTPServerContext;
  s := Trim(ASender.UnparsedParams);

  if TextIsSame(ASender.CommandHandler.Command, 'UTF-8') then begin
    // OPTS UTF-8 <NLST>
    // http://www.ietf.org/proceedings/02nov/I-D/draft-ietf-ftpext-utf-8-option-00.txt
    if s = '' then begin
      LContext.NLSTUtf8 := False; // disable UTF-8 over data connection
    end
    else if TextIsSame(s, 'NLST') then begin
      LContext.NLSTUtf8 := True; // enable UTF-8 over data connection
    end else begin
      SyntaxError(ASender);
      Exit;
    end;
    // enable UTF-8 over control connection
    LContext.Connection.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
  end else begin
    // OPTS UTF8 <ON|OFF>
    // non-standard Microsoft IE implementation!!!!
    case PosInStrArray(s, OnOffStates, False) of
      0: begin // 'ON'
           LContext.NLSTUtf8 := True;
           LContext.Connection.IOHandler.DefStringEncoding := IndyTextEncoding_UTF8;
         end;
      1: begin // 'OFF'
           LContext.NLSTUtf8 := False;
           LContext.Connection.IOHandler.DefStringEncoding := IndyTextEncoding_8Bit;
         end;
      else
        begin
          SyntaxError(ASender);
          Exit;
       end;
    end;
  end;
  ASender.Reply.NumericCode := 200;
end;

function TIdFTPServer.IgnoreLastPathDelim(const APath: String): String;
//This internal function is needed because path processing is different in Windows
//than in Linux.  The path separators on a FTP server on either system will be different.
//
//On Windows machines, both '/' and '\'
//
//On a Linux machine, a FTP server would probably only use '/' because '\' is a valid
//filename char.
var
  i : Integer;
  LPathProcessing : TIdFTPPathProcessing;
begin
  Result := APath;
  i := Length(Result);
  if FPathProcessing <> ftpOSDependent then begin
     LPathProcessing :=  FPathProcessing;
  end else begin
    case GOSType of
      otUnix :
      begin
        LPathProcessing :=  ftppUnix;
      end;
      otUnknown :
      begin
        LPathProcessing := ftppCustom;
      end
    else
      LPathProcessing := ftppDOS;
    end;
  end;
  case LPathProcessing of
    ftppDOS :
    begin
      if Result <>'' then begin
        if CharIsInSet(Result, i, '/\') then begin
          IdDelete(Result, i, 1);
        end;
      end;
    end;
    ftppUnix :
    begin
      if Result <>'' then begin
        if TextEndsWith(Result, '/') then begin
          IdDelete(Result, i, 1);
        end;
      end;
    end;
    ftppCustom :
    begin
      Exit;
    end;
  end;
  //Done so that something like "cd /" or "cd \" will go to
  //the main directory
  if Result = '' then begin
    Result := '/';
  end;
end;

function TIdFTPServer.SupportTaDirSwitches(AContext : TIdFTPServerContext): Boolean;
begin
  Result := True;
  case FDirFormat of
    ftpdfCustom, ftpdfEPLF:
      Result := False;
    ftpdfDOS:
      Result := not AContext.FMSDOSMode;
    ftpdfOSDependent:
      if (GOSType = otWindows) or (GOSType = otDotNET) then begin
        Result := not AContext.FMSDOSMode;
      end;
  end;
end;

{ TIdFTPSecurityOptions }

procedure TIdFTPSecurityOptions.Assign(Source: TPersistent);
var
  LSrc : TIdFTPSecurityOptions;
begin
  if Source is TIdFTPSecurityOptions then begin
    LSrc := Source as TIdFTPSecurityOptions;

    BlockAllPORTTransfers := LSrc.BlockAllPORTTransfers;
    DisableSTATCommand := LSrc.DisableSTATCommand;
    DisableSYSTCommand := LSrc.DisableSYSTCommand;
    PasswordAttempts := LSrc.PasswordAttempts;
    InvalidPassDelay := LSrc.InvalidPassDelay;
    NoReservedRangePORT := LSrc.NoReservedRangePORT;
    RequirePASVFromSameIP := LSrc.RequirePASVFromSameIP;
    RequirePORTFromSameIP := LSrc.RequirePORTFromSameIP;
    PermitCCC := LSrc.PermitCCC;
  end else begin
    inherited Assign(Source);
  end;
end;

constructor TIdFTPSecurityOptions.Create;
begin
  inherited Create;
    //limit login attempts - some hackers will try guessing passwords from a dictionary
  PasswordAttempts := DEF_FTP_PASSWORDATTEMPTS;
    //should slow-down a password guessing attack - note those dictionaries
  InvalidPassDelay := DEF_FTP_INVALIDPASS_DELAY;
    //client IP Address is the only one that we will accept a PASV
    //transfer from
    //http://cr.yp.to/ftp/security.html
   RequirePASVFromSameIP := DEF_FTP_PASV_SAME_IP;
    //Accept port transfers from the same IP address as the client -
    //should prevent bounce attacks
    RequirePORTFromSameIP := DEF_FTP_PORT_SAME_IP;
    //Do not accept port requests to ports in the reserved range.  That is dangerous on some systems
    NoReservedRangePORT := DEF_FTP_NO_RESERVED_PORTS;
    //Do not accept any PORT transfers at all.  This is a little extreme but reduces troubles further.
    //This will break the the Win32 console clients and a number of other programs.
    BlockAllPORTTransfers := DEF_FTP_BLOCK_ALL_PORTS;
    //Disable SYST command.  SYST usually gives the system description.
    //Disabling it may make it harder for a trouble maker to know about your computer
    //but will not be a complete security solution.  See http://www.sans.org/rr/infowar/fingerprint.php for details
    //On the other hand, disabling it will break RFC 959 complience and may break some FTP programs.
    DisableSYSTCommand := DEF_FTP_DISABLE_SYST;
    //Disable STAT command.  STAT gives freeform information about the connection status.
    // http://www.sans.org/rr/infowar/fingerprint.php advises administrators to disable this
    //because servers tend to give distinct patterns of information and some trouble makers
    //can figure out what type of server you are running simply with this.
    DisableSTATCommand := DEF_FTP_DISABLE_STAT;
    //Permit CCC command when using TLS with FTP to clear the control connection.
    //That may be helpful for someone behind a NAT where an IP address can NOT be altered by the NAT
    //when using SSL.  On the other hand, some administrators may NOT permit this for security reasons.
    //That's a debate I'll leave up to the programmer in hopes that they will pass it to the user.
    PermitCCC := DEF_FTP_PERMIT_CCC;
end;

{ TIdDataChannel }

constructor TIdDataChannel.Create(APASV: Boolean; AControlContext: TIdFTPServerContext;
  const ARequirePASVFromSameIP: Boolean; AServer: TIdFTPServer);
var
  LIO: TIdIOHandlerSocket;
  LDataChannelSvr: TIdSimpleServer;
  LDataChannelCli: TIdTCPClient;
begin
  inherited Create;
  FNegotiateTLS := False;
  FOKReply := TIdReplyRFC.Create(nil);
  FErrorReply := TIdReplyRFC.Create(nil);
  FReply := TIdReplyRFC.Create(nil);
  FRequirePASVFromSameIP := ARequirePASVFromSameIP;
  FControlContext := AControlContext;
  FServer := AServer;

  // RLebeau: do not set both BoundPortMin/Max and BoundPort at the same time.
  // If they are all non-zero, BoundPort will take priority in TIdSocketHandle.
  // The DefaultDataPort property should not be assigned to zero in order to
  // support Active-mode transfers, but doing so will cause BoundPortMin/Max
  // to be ignored for Passive-mode transfers.  So assign them in an either-or
  // manner.

  if APASV then begin
    FDataChannel := TIdSimpleServer.Create(nil);
    LDataChannelSvr := TIdSimpleServer(FDataChannel);
    LDataChannelSvr.BoundIP := FControlContext.Binding.IP;
    if (AServer.PASVBoundPortMin <> 0) and (AServer.PASVBoundPortMax <> 0) then begin
      LDataChannelSvr.BoundPortMin := AServer.PASVBoundPortMin;
      LDataChannelSvr.BoundPortMax := AServer.PASVBoundPortMax;
    end else begin
      LDataChannelSvr.BoundPort := AServer.DefaultDataPort;
    end;
    LDataChannelSvr.IPVersion := FControlContext.Binding.IPVersion;
    LDataChannelSvr.OnBeforeBind := AControlContext.PortOnBeforeBind;
    LDataChannelSvr.OnAfterBind := AControlContext.PortOnAfterBind;
  end else begin
    FDataChannel := TIdTCPClient.Create(nil);
    //the TCPClient for the dataport must be bound to a default port
    LDataChannelCli := TIdTCPClient(FDataChannel);
    LDataChannelCli.BoundIP := FControlContext.Binding.IP;
    LDataChannelCli.BoundPort := AServer.DefaultDataPort;
    LDataChannelCli.IPVersion := FControlContext.Binding.IPVersion;
  end;

  if AControlContext.Server.IOHandler is TIdServerIOHandlerSSLBase then begin
    if APASV then begin
      LIO := TIdServerIOHandlerSSLBase(AServer.IOHandler).MakeFTPSvrPasv;
    end else begin
      LIO := TIdServerIOHandlerSSLBase(AServer.IOHandler).MakeFTPSvrPort;
    end;
    TIdSSLIOHandlerSocketBase(LIO).PassThrough := True;
    // always uses a ssl iohandler, but passthrough is true...
  end else begin
    LIO := FServer.IOHandler.MakeClientIOHandler(nil) as TIdIOHandlerSocket;
  end;

  {$IFDEF USE_OBJECT_ARC}
  // under ARC, the TIdTCPConnection.IOHandler property is a weak reference.
  // MakeFTPSvrPasv(), MakeFTPSvrPort(), and MakeClientIOHandler() return an
  // IOHandler with no Owner assigned, so lets make the TIdTCPConnection become
  // the Owner in order to keep the IOHandler alive when this method exits.
  //
  // TODO: should we assign Ownership unconditionally on all platforms?
  //
  // TODO: add an AOwner parameter to MakeFTPSvrPasv(), MakeFTPSvrPort() and
  // MakeClientIOHandler
  //
  FDataChannel.InsertComponent(LIO);
  {$ENDIF}
  FDataChannel.IOHandler := LIO;
  FDataChannel.ManagedIOHandler := True;

  LIO.OnBeforeBind := AControlContext.PortOnBeforeBind;
  LIO.OnAfterBind := AControlContext.PortOnAfterBind;

  if LIO is TIdSSLIOHandlerSocketBase then begin
    case AControlContext.DataProtection of
      ftpdpsClear: begin
        TIdSSLIOHandlerSocketBase(LIO).PassThrough := True;
      end;
      ftpdpsPrivate: begin
        FNegotiateTLS := True;
      end;
    end;
  end;
end;

destructor TIdDataChannel.Destroy;
begin
  FreeAndNil(FOKReply);
  FreeAndNil(FErrorReply);
  FreeAndNil(FReply);
  if Assigned(FDataChannel) then begin
    FDataChannel.IOHandler := nil;
  end;
  FreeAndNil(FDataChannel);
  inherited Destroy;
end;

function GetBinding(AConnection: TIdTCPConnection): TIdSocketHandle;
var
  // under ARC, convert a weak reference to a strong reference before working with it
  LSocket: TIdIOHandlerSocket;
begin
  Result := nil;
  if Assigned(AConnection) then begin
    LSocket := AConnection.Socket;
    if Assigned(LSocket) then begin
      Result := LSocket.Binding;
    end;
  end;
end;

function TIdDataChannel.GetPeerIP: String;
var
  LBinding: TIdSocketHandle;
begin
  LBinding := GetBinding(FDataChannel);
  if Assigned(LBinding) then begin
    Result := LBinding.PeerIP;
  end else begin
    Result := '';
  end;
end;

function TIdDataChannel.GetPeerPort: TIdPort;
var
  LBinding: TIdSocketHandle;
begin
  LBinding := GetBinding(FDataChannel);
  if Assigned(LBinding) then begin
    Result := LBinding.PeerPort;
  end else begin
    Result := 0;
  end;
end;

function TIdDataChannel.GetLocalIP: String;
var
  LBinding: TIdSocketHandle;
begin
  LBinding := GetBinding(FDataChannel);
  if Assigned(LBinding) then begin
    Result := LBinding.IP;
  end else begin
    Result := '';
  end;
end;

function TIdDataChannel.GetLocalPort: TIdPort;
var
  LBinding: TIdSocketHandle;
begin
  LBinding := GetBinding(FDataChannel);
  if Assigned(LBinding) then begin
    Result := LBinding.Port;
  end else begin
    Result := 0;
  end;
end;

procedure TIdDataChannel.InitOperation(const AConnectMode : Boolean = False);
var
  LIO : TIdSSLIOHandlerSocketBase;
begin
  try
    if FDataChannel is TIdSimpleServer then begin
      TIdSimpleServer(FDataChannel).Listen;
      if FRequirePASVFromSameIP then begin
        {//BGO}
        if FControlContext.Binding.PeerIP <> TIdSimpleServer(FDataChannel).Binding.PeerIP then begin
          TIdFTPServerContext(FControlContext).FDataPortDenied := True;
          ErrorReply.SetReply(504, RSFTPSameIPAddress);
          FControlContext.Connection.IOHandler.Write(ErrorReply.FormattedReply);
          TIdSimpleServer(FDataChannel).Disconnect(False);
          Exit;
        end;
      end;
        {//BGO}
      if FNegotiateTLS then begin
        LIO := FDataChannel.IOHandler as TIdSSLIOHandlerSocketBase;
        if AConnectMode then begin
          LIO.IsPeer := False;
        end;
        LIO.PassThrough := False;
      end;
    end
    else if FDataChannel is TIdTCPClient then begin
      TIdTCPClient(FDataChannel).Connect;
      if FNegotiateTLS then begin
        LIO := FDataChannel.IOHandler as TIdSSLIOHandlerSocketBase;
        if AConnectMode then begin
          LIO.IsPeer := False;
        end;
        LIO.PassThrough := False;
      end;
    end;
  except
    FControlContext.Connection.IOHandler.Write(FErrorReply.FormattedReply); //426
    raise;
  end;
end;

procedure TIdDataChannel.SetErrorReply(const AValue: TIdReplyRFC);
begin
  FErrorReply.Assign(AValue);
end;

procedure TIdDataChannel.SetOKReply(const AValue: TIdReplyRFC);
begin
  FOKReply.Assign(AValue);
end;

procedure TIdFTPServerContext.PortOnAfterBind(ASender: TObject);
begin
  FServer.DoOnDataPortAfterBind(Self);
end;

procedure TIdFTPServerContext.PortOnBeforeBind(ASender: TObject);
begin
  FServer.DoOnDataPortBeforeBind(Self);
end;

procedure TIdFTPServerContext.ResetZLibSettings;
begin
  //Settings specified by
  // http://www.ietf.org/internet-drafts/draft-preston-ftpext-deflate-00.txt
  FZLibCompressionLevel :=  DEF_ZLIB_COMP_LEVEL;
  FZLibWindowBits := DEF_ZLIB_WINDOW_BITS; //-15 - no extra headers
  FZLibMemLevel := DEF_ZLIB_MEM_LEVEL;
  FZLibStratagy := DEF_ZLIB_STRATAGY; // - default
end;

end.
