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
  Rev 1.4    2004.02.03 5:45:42 PM  czhower
  Name changes

  Rev 1.3    24/01/2004 23:16:26  CCostelloe
  Removed short-circuits

  Rev 1.2    24/01/2004 19:28:28  CCostelloe
  Cleaned up warnings

  Rev 1.1    5/2/2003 01:16:00 PM  JPMugaas
  Microware OS/9 and MPE/iX support.

  Rev 1.0    4/21/2003 05:32:08 PM  JPMugaas
  Filename converstion rourintes.  Todo:  Somehow, figure out what to do about
  pathes and add more platform support.
}

unit IdOSFileName;

interface

{$i IdCompilerDefines.inc}

uses
  IdBaseComponent, IdFTPCommon;

function FileNameUnixToVMS(const AUnixFileName : String) : String;
function FileNameVMSToUnix(const AVMSFileName : String) : String;
function FileNameMSDOSToUnix(const AMSDOSFileName : String) : String;
function FileNameUnixToMSDOS(const AUnixFileName : String):String;
function FileNameUnixToWin32(const AUnixFileName : String):String;
function FileNameWin32ToUnix(const AWin32FileName : String): String;
function FileNameUnixToVMCMS(const AUnixFileName : String): String;
function FileNameVMCMSToUnix(const AVMCMSFileName : String): String;
function FileNameUnixToMUSICSP(const AUnixFileName : String) : String;
function FileNameMUSICSPToUnix(const AMUSICSPFileName : String) : String;
function FileNameUnixToMVS(const AUnixFileName : String; const AUserID : String;
 const AUseAnotherID : Boolean=False) : String;
function FileNameMVSToUnix(const AMVSFileName : String) : String;
function FileNameUnixToMPEiXTraditional(const AUnixFileName : String; const AGroupName : String=''; const AAcountName : String=''): String;
function FileNameUnixToMPEiXHFS(const AUnixFileName : String; const IsRoot : Boolean=False): String;
function FileNameUnixToOS9(const AUnixFileName : String) : String;

implementation

uses
  IdException,
  IdGlobal, IdGlobalProtocols, SysUtils;

function EnsureValidCharsByValidSet(const AFilePart, AValidChars : String; const  AReplaceWith : String='_'): String;
var i : Integer;
begin
  Result := '';
  for i := 1 to Length(AFilePart) do
  begin
      if CharIsInSet(AFilePart, i, AValidChars) then
      begin
        Result := Result + AFilePart[i];
      end
      else
      begin
        Result := Result + AReplaceWith;
      end;
  end;
end;

function EnsureValidCharsByInvalidSet(const AFilePart, AInvalidChars : String;
  const AReplaceWith : String='_'): String;
var i : Integer;
begin
  Result := '';
  for i := 1 to Length(AFilePart) do
  begin
      if not CharIsInSet(AFilePart, i, AInValidChars) then
      begin
        Result := Result + AFilePart[i];
      end
      else
      begin
        Result := Result + AReplaceWith;
      end;
  end;
end;

function FileNameUnixToVMS(const AUnixFileName : String) : String;
var LFName, LFExt : String;
{sample VMS fully qualified filename:

DKA0:[MYDIR.SUBDIR1.SUBDIR2]MYFILE.TXT;1

Note VMS uses 39 chars for name and type

valid chars are:
letters A through Z 
numbers 0 through 9 
underscore ( _ )
hyphen ( -)
dollar sign ( $ )

See:  http://www.uh.edu/infotech/services/documentation/vms/v0505.html
}
var
  VMS_Valid_Chars : String;
begin
  VMS_Valid_Chars := CharRange('A','Z')+CharRange('0','9')+'_-$';
  //VMS is case insensitive - UpperCase to simplify processing
  Result := UpperCase(AUnixFileName);
  LFName := Fetch(Result,'.');
  LFExt := Fetch(Result,'.');
  LFExt := Fetch(LFExt,';');
  LFName := Copy(LFName,1,39);
  LFName := EnsureValidCharsByValidSet(LFName,VMS_Valid_Chars);
  LFExt := Copy(LFExt,1,39);
  LFExt := EnsureValidCharsByValidSet(LFExt,VMS_Valid_Chars);
  Result := LFName;
  if LFExt <>'' then
  begin
    Result := Result + '.'+LFExt;
  end;
end;

function FileNameVMSToUnix(const AVMSFileName : String) : String;
begin
  Result := AVMSFileName;
  //We strip off the version marker because that doesn't make sense in
  //Win32 and Unix.  In VMS, there's a crude type of version control in the file system where
  //different versions of the same file are kept.
  //For example, if you open IDABOUT.PAS;1, make a change, and save it, it is saved
  //as IDABOUT.PAS;2.  Make a further change and save it and it will be saved as
  //IDABOUT.PAS;3.
  Result := Fetch(Result,';');
  //VMS is case insensitive
  Result := LowerCase(AVMSFileName);
end;

function FileNameMSDOSToUnix(const AMSDOSFileName : String) : String;
begin
  Result := LowerCase(AMSDOSFileName);
end;

function FileNameUnixToMSDOS(const AUnixFileName : String):String;
var LFName, LFExt : String;
//From: http://macinfo.its.queensu.ca/Mark/AMT2/AMTCrossPlatfrom.html
//Window V3.1 and DOS file names compatibility:
//Windows 3.1/DOS names cannot have more than eight characters and can
//contain only the letters A through Z, the numbers 0 through 9 and the
//following special characters:
//underscore (_), dollar sign ($), tilde (~), exclamation point (!),
//number sign (#), percent sign (%), ampersand (&), hyphen (-), braces ({}), parenthesis (), at sign (@), apostrophe ('), and the grave accent (').

//Note: Macintosh does not allow colin (:) in it's file name and supports upto 32 characters.

var
  MSDOS_Valid_Chars : String;
begin
  MSDOS_Valid_Chars := CharRange('A','Z')+CharRange('0','9')+'_$~!#%&-{}()@'''+Char(180);
  Result := UpperCase(AUnixFileName);
  LFName := Fetch(Result,'.');
  LFName := Copy(LFName,1,8);
  LFName := EnsureValidCharsByValidSet(LFName,MSDOS_Valid_Chars);
  LFExt := Fetch(Result,'.');
  LFExt := Copy(LFExt,1,3);
  LFExt := EnsureValidCharsByValidSet(LFExt,MSDOS_Valid_Chars);
  Result := LFName;
  if LFExt <> '' then
  begin
    Result := Result + '.'+LFExt;
  end;
end;

function FileNameUnixToWin32(const AUnixFileName : String):String;
//from: http://linux-ntfs.sourceforge.net/ntfs/concepts/filename_namespace.html
const
  WIN32_INVALID_CHARS  = '"*/:<>?\|' + #0;
  WIN32_INVALID_LAST  = ' .';  //not permitted as the last character in Win32
begin
  Result := EnsureValidCharsByInvalidSet(AUnixFileName,WIN32_INVALID_CHARS);
  if Result <> '' then begin
    if CharIsInSet(Result, Length(Result), WIN32_INVALID_LAST) then begin
      Delete(Result,Length(Result),1);
      if Result = '' then begin
        Result := '_';
      end;
    end;
  end;
end;

function FileNameWin32ToUnix(const AWin32FileName : String): String;
//from http://linux-ntfs.sourceforge.net/ntfs/concepts/filename_namespace.html
//const UNIX_INVALID_CHARS : TIdValidChars = [#0,'/'];
begin
  Result := LowerCase(AWin32FileName);
end;

function FileNameUnixToVMCMS(const AUnixFileName : String): String;
// From: CMS Introductory Guide at the University of Kentuckey
//    http://ukcc.uky.edu/~ukccinfo.391/cmsintro.html
//      Under CMS a file is identified by a fileid with three parts:  the filename, the
//      filetype, and the filemode.  The filemode, from this point on in this guide, will
//      always be A1.  In most cases, the filemode is optional when referring to files.
//      The filename and filetype can contain from one to eight characters (letters,
//      numbers, and these seven special characters: @#$+-:_).  Choose filenames and
//      filetypes that help to identify the contents of the file.
var
  LFName, LFExt : String;
  Valid_VMCMS_Chars : String;
begin
  Valid_VMCMS_Chars := CharRange('A','Z')+ CharRange('0','9')+'@#$+-:_';
  Result := UpperCase(AUnixFileName);
  LFName := Fetch(Result,'.');
  LFName := EnsureValidCharsByValidSet(LFExt,VALID_VMCMS_CHARS);
  LFName := Copy(LFName,1,8);
  LFExt := Fetch(Result,'.');
  LFExt := EnsureValidCharsByValidSet(LFExt,VALID_VMCMS_CHARS);
  LFExt := Copy(LFExt,1,8);
  Result := LFName;
  if LFExt <> '' then
  begin
    Result := Result + '.'+LFExt;
  end;
end;

function FileNameVMCMSToUnix(const AVMCMSFileName : String): String;
begin
  Result := LowerCase(AVMCMSFileName);
end;

function FileNameUnixToMUSICSP(const AUnixFileName : String) : String;
{
Obtained from a ftphelp.txt on a Music/SP Server

The MUSIC/SP file system has a directory structure similar to that
of DOS and Unix.  The separator character between directory names
is a backslash (\), but the FTP client can use either a slash (/)
or a backslash (\).  Directory names can be up to 17 characters.
File names within a directory can be up to 17 characters.  The total
name, including directory names on the front, can be up to 50
characters.  Upper/lower case is not significant in file names.
Letters (A to Z), digits (0 to 9), and some special characters
(including $ # @ _ + - . % & !) can be used, but the first character
of each part must not be a digit or + - . % & !.
}
var
  Valid_MUSICSP : String;
  MUSICSP_Cant_Start : String;
begin
  Valid_MUSICSP := CharRange('A','Z')+CharRange('0','9')+'$#@_+-.%&!';  {do not localize}
  MUSICSP_Cant_Start := CharRange('0','9')+ '+-.%!';  {do not localize}
// note we have to do our vality checks before truncating the length in
// case we need to replace the default replacement char and the length changes
// because of that.
  Result := EnsureValidCharsByValidSet(UpperCase(AUnixFileName),VALID_MUSICSP);
  Result := Copy(Result,1,15);
  if Result <> '' then begin
    if CharIsInSet(Result, 1, MUSICSP_CANT_START) then begin
      if Length(Result) > 1 then begin
        {$IFDEF STRING_IS_IMMUTABLE}
        Result := Copy(Result,2,MaxInt);
        {$ELSE}
        Delete(Result,1,1);
        {$ENDIF}
      end else begin
        {$IFDEF STRING_IS_IMMUTABLE}
        Result := '_';  {do not localize}
        {$ELSE}
        Result[1] := '_'; {do not localize}
        {$ENDIF}
      end;
    end;
  end;
end;

function FileNameMUSICSPToUnix(const AMUSICSPFileName : String) : String;
begin
  Result := LowerCase(AMUSICSPFileName);
end;

function FileNameUnixToMVS(const AUnixFileName : String; const AUserID : String; const AUseAnotherID : Boolean=False) : String;
const
  MVS_FQN_MAX_LEN = 44;
  MVS_MAX_QUAL_LEN = 8;
var
  LQualifier : String;
  LMaxLen : Integer;
  LBuf : String;
  MVS_Valid_Qual_Chars : String;
  MVS_Valid_First_Char : String;
begin
  MVS_Valid_Qual_Chars := CharRange('0','9')+CharRange('A','Z')+'@$#';  {do not localize}
  MVS_Valid_First_Char := CharRange('A','Z'); {do not localize}
  //in MVS, there's a maximum of 44 characters and MVS prepends a prefix with the userID and
  //sometimes process name.  Thus, the dataset name can have 44 characters minus the user ID - 1 (for the dot)
  //
  //e.g.  CZHOWER can have a fully qualified name with a maximum of 36 characters
  //      JPMUGAAS can have a fully qualified name with a maximum of 35 characters
  //
  //if AUseAnotherID is true, we give a fully qualified name with a prefix in '' which
  //is called ticks.  That permits someone to access another user's dataset.
  //
  //e.g.  CZHOWER could access a dataset created by JPMUGAAS (named INDY.IDABOUT.PAS)
  //      by using the name:
  //
  //'JPMUGAAS.INDY.IDABOUT.PAS'
  //
  //JPMUGAAS can access the same data with the name:
  //
  //INDY.IDABOUT.PAS
  //
  //where the JPMUGAAS. prefix is implied.
  LMaxLen := MVS_FQN_MAX_LEN - 1 - Length(AUserID);

  LBuf := UpperCase(AUnixFileName);
  Result := '';
  repeat

     LQualifier := Fetch(LBuf,'.');
     if LQualifier <>'' then
     begin
       repeat
         if not CharIsInSet(LQualifier, 1, MVS_VALID_FIRST_CHAR) then
         begin
           Delete(LQualifier,1,1);
           if LQualifier='' then
           begin
             break;
           end;
         end
         else
         begin
           Break;
         end;
       until False;
     end;
     //we do it this way in case the qualifier only had an invalid char such as #
     if LQualifier <> '' then
     begin
       LQualifier := EnsureValidCharsByValidSet(LQualifier,MVS_VALID_QUAL_CHARS,'');
     end;
     LQualifier := Copy(LQualifier,1,MVS_MAX_QUAL_LEN);
     if LQualifier <> '' then
     begin
       Result := Result + '.' +LQualifier;
       if Result<>'' then
       begin
         if Result[1]='.' then
         begin
           Delete(Result,1,1);
         end;
       end;
       if (Length(Result)>LMaxLen) or (LBuf='') then
       begin
         Result := Copy(Result,1,LMaxLen);
         Break;
       end;
     end;
     if LBuf = '' then
     begin
       Break;
     end;
  until False;
  if AUseAnotherID then
  begin
    Result := ''''+AUserID+'.'+Result+'''';
  end;
end;

function FileNameMVSToUnix(const AMVSFileName : String) : String;
begin
  Result := LowerCase(AMVSFileName);
end;

{
Note that Account name does not necessarily imply a username.  When logging in,
the user provides both the username and account.  It's like the username is the key to
a cabnet (several people can have their keys to that cabnit.

The group name is like a drawer in a cabnet.  That is only needed if you are logged in with
an account and group but wish to access a file in a different group.

That's how the manual
described it.

The MPE/iX file system is basically flat with an account, group, and file name.
}
function MPEiXValidateFIlePart(AFilePart : String) : String;
var
  Valid_MPEIX_Start : String;
  Valid_MPEIX_FName : String;
begin
  Valid_MPEIX_Start := CharRange('A','Z');
  Valid_MPEIX_FName :=  Valid_MPEIX_Start + CharRange('0','9');
  Result := UpperCase(AFilePart);
  if IndyPos('.',Result)>1 then
  begin
    Result := Fetch(Result,'.');
  end;
  if Result<>'' then
  begin
    Result := EnsureValidCharsByValidSet(Result,VALID_MPEIX_FNAME,'');
    repeat
      if not CharIsInSet(Result, 1, VALID_MPEIX_START) then
      begin
        Delete(Result,1,1);
        if Result='' then
        begin
          break;
        end;
      end
      else
      begin
        Break;
      end;
    until False;
  end;
  //no more than 8 chars
  Result := COpy(Result,1,8);
end;

function FileNameUnixToMPEiXTraditional(const AUnixFileName : String; const AGroupName : String=''; const AAcountName : String=''): String;
//based on http://docs.hp.com/mpeix/onlinedocs/32650-90871/32650-90871.html
//
//1) Starts with a letter - case insensitive
//2) Contains only letters and numbers
//3) No other charactors (a / is acceptable but it means a lockword which can cause
// you to be unable to retreive the file
//4) No more than 8 chars
//
//Note that fullname and groupname are 1 to 8 chars and follow the same rules


//just to eliminate some double processing for tests
var LBuf : String;
begin
  Result := MPEiXValidateFIlePart(AUnixFileName);
  LBuf := MPEiXValidateFIlePart(AGroupName);
  if LBuf <> '' then
  begin
    //if no group, we skip the account part
    Result := Result + '.'+LBuf;
    LBuf := MPEIxValidateFilePart(AAcountName);
    if LBuf <> '' then
    begin
      Result := Result + '.'+LBuf;
    end;
  end;
end;

function FileNameUnixToMPEiXHFS(const AUnixFileName : String; const IsRoot : Boolean=False): String;
//based on:  http://docs.hp.com/mpeix/onlinedocs/32650-90492/32650-90492.html
{
http://docs.hp.com/mpeix/onlinedocs/32650-90492/32650-90492.html
FS pathnames differ from MPE pathnames in the following ways:

Names are separated with forward slashes (/), rather than dots.

The order of the file name, group name, and account name are presented in
reverse order compared to MPE syntax (/ACCT/GROUP/FILE versus FILE.GROUP.ACCT).

Slash (/) at the beginning of a pathname indicates the root directory.

Dot-slash (./) at the beginning of a pathname indicates the current working
directory (CWD). The CWD is the directory in which you are currently working.

Pathnames can be up to 1023 characters whereas traditional MPE names must be
less than or equal to 26 characters (names can be up to 35 characters if a
lockword is used). See Table 2-2 for CI restrictions.

Using these conventions, the format of the MPE pathname
MYFILE.PAYROLL.FINANCE appears as follows in HFS syntax:

   /FINANCE/PAYROLL/MYFILE
In this example, it is assumed that MYFILE is a file under the PAYROLL group
and FINANCE account. However, FINANCE and PAYROLL need not necessarily be an
account and a group as they must in MPE syntax. Using HFS syntax, MYFILE could
be a file under the PAYROLL HFS subdirectory, which is under the FINANCE HFS
directory, which is under the root directory.
}

var
  MPEIX_Valid_Chars : String;
  MPEIX_CantStart : String;
begin
  MPEIX_Valid_Chars := CharRange('a','z')+CharRange('A','Z')+CharRange('0','9')+'._-';
  MPEIX_CantStart := '-';
  Result := AUnixFileName;
  if Result<>'' then
  begin
    Result := EnsureValidCharsByValidSet(Result,MPEIX_VALID_CHARS,'_');
    repeat
      if CharIsInSet(Result, 1, MPEIX_CANTSTART) then
      begin
        Delete(Result,1,1);
        if Result='' then
        begin
          break;
        end;
      end
      else
      begin
        Break;
      end;
    until False;
  end;
  //note that this for clarrifying that this is a HFS file instead of a Traditional
  //MPEiX file.
  //A file in the foot folder uses the / and a file in the current dir uses ./
  if IsRoot then
  begin
    Result := '/'+Result;
  end
  else
  begin
    Result := './'+Result;
  end;
  Result := Copy(result,1,255);
end;

function FileNameUnixToOS9(const AUnixFileName : String) : String;
//based on:
//http://www.roug.org/soren/6809/os9guide/os9guide.pdf

{
Names can have one to 29 characters, all of which are used for matching. They
must becin with an upper- or lower-case letter followed by any combination of
the following characters:
UpperCase letters: A - Z
LowerCase letters: a - z
decimal digits: 0 - 9
underscore: _
period: .
}
var
  OS9_Must_Start : String;
  OS9_Valid_Char : String;
begin
  OS9_Must_Start := CharRange('a','z')+CharRange('A','Z');
  OS9_Valid_Char := CharRange('0','9')+'_.';
  Result := AUnixFileName;
  if Result<>'' then
  begin
    Result := EnsureValidCharsByValidSet(Result,OS9_VALID_CHAR,'_');
    repeat
      if ((CharIsInSet(Result, 1, OS9_MUST_START))=False) then
      begin
        Delete(Result,1,1);
        if Result='' then
        begin
          break;
        end;
      end
      else
      begin
        Break;
      end;
    until False;
  end;
  Result := Copy(Result,1,29);
end;

end.

