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
{   Rev 1.3    16/01/2005 22:33:06  CCostelloe
{ Minor update
}
{
{   Rev 1.2    22/12/2004 23:09:52  CCostelloe
{ Another intermediate check-in, this sorts out the compressed RTF message and
{ (if it has one) the message .Body.
}
{
{   Rev 1.1    18/12/2004 20:35:24  CCostelloe
{ Intermediate check-in, lots more to be done.
}
{
{   Rev 1.0    02/12/2004 22:56:26  CCostelloe
{ Initial version
}
unit IdCoderTNEF;

{
    This is for decoding Microsoft's TNEF email messages, which are usually
      transmitted as an attachment called either "WINMAIL.DAT" or "ATT00001.DAT"
      in a MIME-encoded message (though other variants of the file name, but not
      the extension, are occasionally encountered).
      The MIME type should be "application/ms-tnef".
    This is deliberately NOT similar to the other coder classes, this
      should usually be used by passing in a TNEF TIdAttachment which has
      been extracted from a message.
    You can optionally get a debugging log of the parsing by setting the third
      optional parameter to True, as in "TIdCoderTNEF.Parse(A_TIdBytes,
      A_TIdMessage, True);", and then load the log into a TMemo by calling
      "Memo1.Text := A_TIdCoderTNEF.Log;".
    The aim of the initial implementation was just to extract any attachments from
      the TNEF, along with their filenames, and put them in the TIdMessage's
      MessageParts for the user.
    Some additional applicable fields have also been parsed out of the TNEF
      and inserted into the TIdMessage.  This is an ongoing development.
    METHODOLOGY:
      A TNEF is a collection of blocks of data, each block is either a
        IdTNEFLvlMessage or a IdTNEFLvlAttachment block.  IdTNEFLvlAttachment
        blocks are straightforward, see the parsing below.
        A IdTNEFLvlMessage block may contain an item like the message subject,
        date sent, etc.  However, a block may also contain a IdTNEFattMAPIProps,
        which contains sub-blocks corresponding to MAPI properties which will
        also typically include the message subject, date sent, etc.
        The methodology used by me is that the IdTNEFLvlMessage level takes
        priority, i.e. if there is a message subject at both the IdTNEFLvlMessage
        and the IdTNEFattMAPIProps level, then the IdTNEFLvlMessage is the one
        that will be used.
      The TIdMessage is filled in from the TNEF in a similar manner to the way
        Indy decodes MIME messages.  Particularly note that the message text
        is often only in an RTF format and so it will be put in a TIdText part
        and NOT in the TIdMessage.Body.  The TIdMessage.Body MAY contain the
        plain-text version of the message, IF it is present.
      Parts (either TIdText or TIdAttachmentFile) are added to the TIdMessage
        in the order they are encountered.  This may be different from an
        RFC-compliant MIME email, which (in the case of alternative versions
        of the message text) puts the simplest first, i.e. text/plain
        before text/html before text/rtf.

To do:
    When finished decoding, rescan the parts and insert parts like
      'multipart/alternative' and set up the ParentPart pointers as required to
      imitate Indy's treatment of MIME parts in Indy10.
    For LLong, LShort, get them to get signed values.
    GetMapiSysTime or GetTime may be out by an hour?  Time zone issue?
    Add meaningful headers like ContentType to message parts.
    Some TIdMessage fields may be found in different TNEF fields (e.g. sender/from).
      They don't appear to be consistent in practice, and there may be semantical
      differences between the usage of terms like Sender between TNEF and MIME.
    See the "TODO"s in the code below.
}

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdMessage,
  IdException,
  IdAttachment,
  IdAttachmentFile,
  SysUtils;

type
  TIdCoderTNEF = class(TObject)
  private
    FData: TStream;         //Used for walking through the file
    FKey: Word;             //Every TNEF has one, but no-one seems to know why!
    FLog: string;           //The (optional) debugging log goes here
    FDoLogging: Boolean;    //Should we be doing the optional logging?
    FMsg: TIdMessage;       //The destination for our extracted attachments
    FCurrentAttachment: TIdAttachment;  //Attachment we are currently decoding into
    FReceiptRequested: Boolean;  //Need to cache this because receipt flag may precede sender address
    //
    procedure DoLog(const AMsg: String; const AAppendSize: Boolean = True);
    procedure DoLogFmt(const AFormat: string; const Args: array of const; AAppendSize: Boolean = True);
    //Low-level utility functions:
    function  GetMultipleUnicodeOrString8String(AType: Word): TIdUnicodeString;
    function  GetUnicodeOrString8String(AType: Word): TIdUnicodeString;
    function  GetByte: Byte;
    function  GetBytes(ALength: Integer; APeek: Boolean = False): TIdBytes;
    function  GetByteAsHexString: string; overload;
    function  GetByteAsHexString(AByte: Byte): string; overload;
    function  GetByteAsChar(AByte: Byte): char;
    function  GetBytesAsHexString(ACount: integer): string;
    function  GetWord: Word;
    function  GetLongWord: LongWord;
    function  GetInt64: Int64;
    function  GetString(ALength: Word): string;
    function  GetDate(ALength: Word): TDateTime;
    procedure Skip(ACount: integer);
    procedure CheckForEof(ANumBytesRequested: integer);
    procedure Checksum(ANumBytesToCheck: integer);
    function  PadWithZeroes(const AStr: string; ACount: integer): string;
    procedure DumpBytes(const ABytes: TIdBytes);
    //Attribute-specific stuff...
    function  GetAttributeString(const AAttributeName: string; AType: Word): string;
    //MAPI parsing...
    function  GetStringForMapiType(AType: Word): string;
    function  GetMapiBoolean(AType: Word; const AText: string): Smallint;
    function  GetMapiLong(AType: Word; const AText: string): Longint;
    function  GetMapiStrings(AType: Word; const AText: string): string;
    function  GetMapiBinary(AType: Word; const AText: string): TIdBytes;
    function  GetMapiBinaryAsEmailName(AType: Word; const AText: string): string;
    function  GetMapiBinaryAsString(AType: Word; const AText: string): string;
    //function  GetMapiObject(AType: Word; AText: string): TIdBytes;
    function  GetMapiItemAsBytes(AType: Word; const AText: string): TIdBytes;
    function  GetMapiItemAsBytesPossiblyCompressed(AType: Word; const AText: string): TIdBytes;
    function  DecompressRtf(ACount, ALength: LongWord; AType: Word; const AText: string): TIdBytes;
    function  GetMapiSysTime(AType: Word; const AText: string): TDateTime;
    function  InternalGetMapiItemAsBytes(ACount, ALength: LongWord; AType: Word; const AText: string): TIdBytes;
  protected
    procedure ParseMessageBlock;
    procedure ParseAttachmentBlock;
    procedure ParseAttribute(AAttribute, AType: Word);
    procedure ParseMapiProps(ALength: LongWord);
    procedure ParseMapiProp;
    procedure IsCurrentAttachmentValid;
    //For debugging log...
    function  GetStringForAttribute(AAttribute: Word): string;
    function  GetStringForType(AType: Word): string;
  public
    //The following is the normal parser call you would use...
    procedure Parse(const AIn: TIdAttachment; AMsg: TIdMessage; ALog: Boolean = False); overload;
    //TIdIMAP4 should set up a stream & use this...
    procedure Parse(const AIn: TStream; AMsg: TIdMessage; ALog: Boolean = False); overload;
    //The TIdBytes and string versions are really for debugging...
    procedure Parse(const AIn: TIdBytes; AMsg: TIdMessage; ALog: Boolean = False); overload;
    procedure Parse(const AIn: string; AMsg: TIdMessage; ALog: Boolean = False);   overload;
    //Tells you if a filename matches TNEF semantics (winmail.dat, att0001.dat)
    class function IsFilenameTnef(const AFilename: string): Boolean; static; {$IFDEF HAS_DEPRECATED}deprecated{$IFDEF HAS_DEPRECATED_MSG} 'Use standalone IsFilenameTnef() function'{$ENDIF};{$ENDIF}
    property  Key: Word read FKey;  //TODO: Does this have a meaningful use?
    property  Log: string read FLog;
  end;

  EIdTnefInvalidTNEFSignature = class(EIdException);
  EIdTnefRanOutOfBytes = class(EIdException);
  EIdTnefUnknownBlockType = class(EIdException);
  EIdTnefChecksumFailure = class(EIdException);
  EIdTnefCurrentAttachmentInvalid = class(EIdException);
  EIdTnefAttributeUnexpectedType = class(EIdException);
  EIdTnefUnexpectedType = class(EIdException);
  EIdTnefUnexpectedValue = class(EIdException);
  EIdTnefNotSupported = class(EIdException);
  EIdTnefUnknownMapiType = class(EIdException);
  EIdTnefCorruptData = class(EIdException);

function IsFilenameTnef(const AFilename: string): Boolean;

implementation

uses
  {$IFDEF HAS_UNIT_DateUtils}DateUtils,{$ENDIF}
  IdMessageClient, IdText, IdStream;

const
  //Initial RTF-compression decode string...
  IdTNEF_decode_string: string = '{\rtf1\ansi\mac\deff0\deftab720{\fonttbl;}{\f0\fnil \froman \fswiss \fmodern \fscript \fdecor MS Sans SerifSymbolArialTimes New RomanCourier{\colortbl\red0\green0\blue0'+#10#13+'\par \pard\plain\f0\fs20\b\i\u\tab\tx';  {Do not localize}

  //The following are equivalents to those defined Microsoft's TNEF.H.
  //File signature...
  IdTNEFSignature = $223E9F78;          //Every TNEF should have this

  //Highest-level block types...
  IdTNEFLvlMessage    = 1;              //Corresponds to Microsoft's LVL_MESSAGE
  IdTNEFLvlAttachment = 2;              //Corresponds to Microsoft's LVL_ATTACHMENT

  //Data types...
  IdTNEFAtpTriples  = 0;                //Corresponds to Microsoft's AtpTriples, similarly for the following
  IdTNEFAtpString   = 1;
  IdTNEFAtpText     = 2;
  IdTNEFAtpDate     = 3;
  IdTNEFAtpShort    = 4;
  IdTNEFAtpLong     = 5;
  IdTNEFAtpByte     = 6;
  IdTNEFAtpWord     = 7;
  IdTNEFAtpDWord    = 8;
  IdTNEFAtpMax      = 9;

  //Attribute types...
  IdTNEFattNull	                         = $0000;
  IdTNEFattFrom                          = $8000;  // /* PR_ORIGINATOR_RETURN_ADDRESS */
  IdTNEFattSubject                       = $8004;  // /* PR_SUBJECT */
  IdTNEFattDateSent                      = $8005;  // /* PR_CLIENT_SUBMIT_TIME */
  IdTNEFattDateRecd                      = $8006;  // /* PR_MESSAGE_DELIVERY_TIME */
  IdTNEFattMessageStatus                 = $8007;  // /* PR_MESSAGE_FLAGS */
  IdTNEFattMessageClass                  = $8008;  // /* PR_MESSAGE_CLASS */
  IdTNEFattMessageID                     = $8009;  // /* PR_MESSAGE_ID */
  IdTNEFattParentID                      = $800A;  // /* PR_PARENT_ID */
  IdTNEFattConversationID                = $800B;  // /* PR_CONVERSATION_ID */
  IdTNEFattBody                          = $800C;  // /* PR_BODY */
  IdTNEFattPriority                      = $800D;  // /* PR_IMPORTANCE */
  IdTNEFattAttachData                    = $800F;  // /* PR_ATTACH_DATA_xxx */
  IdTNEFattAttachTitle                   = $8010;  // /* PR_ATTACH_FILENAME */
  IdTNEFattAttachMetaFile                = $8011;  // /* PR_ATTACH_RENDERING */
  IdTNEFattAttachCreateDate              = $8012;  // /* PR_CREATION_TIME */
  IdTNEFattAttachModifyDate              = $8013;  // /* PR_LAST_MODIFICATION_TIME */
  IdTNEFattDateModified                  = $8020;  // /* PR_LAST_MODIFICATION_TIME */
  IdTNEFattAttachTransportFilename       = $9001;  // /* PR_ATTACH_TRANSPORT_NAME */
  IdTNEFattAttachRenddata                = $9002;  //
  IdTNEFattMAPIProps                     = $9003;  //
  IdTNEFattRecipTable                    = $9004;  // /* PR_MESSAGE_RECIPIENTS */
  IdTNEFattAttachment                    = $9005;  //
  IdTNEFattTnefVersion                   = $9006;  //
  IdTNEFattOemCodepage                   = $9007;  //
  IdTNEFattOriginalMessageClass          = $0006;  // /* PR_ORIG_MESSAGE_CLASS */

  IdTNEFattOwner                         = $0000;  // /* PR_RCVD_REPRESENTING_xxx  or PR_SENT_REPRESENTING_xxx */
  IdTNEFattSentFor                       = $0001;  // /* PR_SENT_REPRESENTING_xxx */
  IdTNEFattDelegate                      = $0002;  // /* PR_RCVD_REPRESENTING_xxx */
  IdTNEFattDateStart                     = $0006;  // /* PR_DATE_START */
  IdTNEFattDateEnd                       = $0007;  // /* PR_DATE_END */
  IdTNEFattAidOwner                      = $0008;  // /* PR_OWNER_APPT_ID */
  IdTNEFattRequestRes                    = $0009;  // /* PR_RESPONSE_REQUESTED */

  //Message priorities...
  IdTNEFprioLow		= 3;
  IdTNEFprioNorm	= 2;
  IdTNEFprioHigh	= 1;

  //MAPI property value types...
  IdTNEF_PT_UNSPECIFIED	= 0;	//TODO: * (Reserved for interface use) type doesn't matter to caller */
  IdTNEF_PT_NULL		= 1;	//TODO: * NULL property value */
  IdTNEF_PT_I2			= 2;	//* Signed 16-bit value */
  IdTNEF_PT_LONG		= 3;	//* Signed 32-bit value */
  IdTNEF_PT_R4			= 4;	//* 4-byte floating point */
  IdTNEF_PT_DOUBLE		= 5;	//TODO: * Floating point double */
  IdTNEF_PT_CURRENCY		= 6;	//TODO: * Signed 64-bit int (decimal w/	4 digits right of decimal pt) */
  IdTNEF_PT_APPTIME		= 7;	//TODO: * Application time */
  IdTNEF_PT_ERROR		= 10;	//TODO: * 32-bit error value */
  IdTNEF_PT_BOOLEAN		= 11;	//* 16-bit boolean (non-zero true) */
  IdTNEF_PT_OBJECT		= 13;	//* Embedded object in a property */
  IdTNEF_PT_I8			= 20;   //TODO: * 8-byte signed integer */
  IdTNEF_PT_STRING8		= 30;   //* Null terminated 8-bit character string */
  IdTNEF_PT_UNICODE		= 31;   //* Null terminated Unicode string */
  IdTNEF_PT_SYSTIME		= 64;   //TODO: * FILETIME 64-bit int w/ number of 100ns periods since Jan 1,1601 */
  IdTNEF_PT_CLSID		= 72;	//TODO:* OLE GUID */
  IdTNEF_PT_BINARY		= 258;  //* Uninterpreted (counted byte array) */

  IdTNEF_MV_FLAG		= $1000;			//TODO: * Multi-value flag */


  //MAPI property tags...
  IdTNEF_PR_ALTERNATE_RECIPIENT_ALLOWED				= $0002; //PROP_TAG( PT_BOOLEAN,	0x0002)
  IdTNEF_PR_ORIGINATOR_DELIVERY_REPORT_REQUESTED	= $0023; //PROP_TAG( PT_BOOLEAN,	0x0023)
  IdTNEF_PR_PRIORITY								= $0026; //PROP_TAG( PT_LONG,		0x0026)
  IdTNEF_PR_READ_RECEIPT_REQUESTED					= $0029; //PROP_TAG( PT_BOOLEAN,	0x0029)
  IdTNEF_PR_ORIGINAL_SENSITIVITY					= $002E; //PROP_TAG( PT_LONG,		0x002E)
  IdTNEF_PR_SENSITIVITY								= $0036; //PROP_TAG( PT_LONG,		0x0036)
  IdTNEF_PR_CLIENT_SUBMIT_TIME						= $0039; //PROP_TAG( PT_SYSTIME,	0x0039)
  IdTNEF_PR_SUBJECT_PREFIX							= $003D; //PROP_TAG( PT_TSTRING,	0x003D)
  IdTNEF_PR_MESSAGE_SUBMISSION_ID					= $0047; //PROP_TAG( PT_BINARY,	    0x0047)
  IdTNEF_PR_ORIGINAL_SUBJECT						= $0049; //PROP_TAG( PT_TSTRING,	0x0049)
  IdTNEF_PR_ORIGINAL_AUTHOR_NAME					= $004D; //PROP_TAG( PT_TSTRING,	0x004D)
  IdTNEF_PR_ORIGINAL_SUBMIT_TIME					= $004E; //PROP_TAG( PT_SYSTIME,	0x004E)
  IdTNEF_PR_ORIGINAL_SENDER_NAME					= $005A; //PROP_TAG( PT_TSTRING,	0x005A)
  IdTNEF_PR_ORIGINAL_SENDER_ENTRYID					= $005B; //PROP_TAG( PT_BINARY,	    0x005B)
  IdTNEF_PR_ORIGINAL_SENDER_SEARCH_KEY				= $005C; //PROP_TAG( PT_BINARY,	    0x005C)
  IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_NAME			= $005D; //PROP_TAG( PT_TSTRING,	0x005D)
  IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_ENTRYID		= $005E; //PROP_TAG( PT_BINARY,	    0x005E)
  IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_SEARCH_KEY	= $005F; //PROP_TAG( PT_BINARY,	    0x005F)
  IdTNEF_PR_ORIGINAL_SENDER_ADDRTYPE				= $0066; //PROP_TAG( PT_TSTRING,	0x0066)
  IdTNEF_PR_ORIGINAL_SENDER_EMAIL_ADDRESS			= $0067; //PROP_TAG( PT_TSTRING,	0x0067)
  IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_ADDRTYPE		= $0068; //PROP_TAG( PT_TSTRING,	0x0068)
  IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_EMAIL_ADDRESS= $0069; //PROP_TAG( PT_TSTRING,	0x0069)
  IdTNEF_PR_CONVERSATION_TOPIC						= $0070; //PROP_TAG( PT_TSTRING,	0x0070)
  IdTNEF_PR_CONVERSATION_INDEX						= $0071; //PROP_TAG( PT_BINARY,	    0x0071)
  IdTNEF_PR_ORIGINAL_DISPLAY_CC						= $0073; //PROP_TAG( PT_TSTRING,	0x0073)
  IdTNEF_PR_ORIGINAL_DISPLAY_TO						= $0074; //PROP_TAG( PT_TSTRING,	0x0074)
  IdTNEF_PR_REPLY_REQUESTED							= $0C17; //PROP_TAG( PT_BOOLEAN,	0x0C17)
  IdTNEF_PR_SENDER_SEARCH_KEY						= $0C1D; //PROP_TAG( PT_BINARY,	    0x0C1D)
  IdTNEF_PR_SENDER_NAME								= $0C1A; //PROP_TAG( PT_TSTRING,	0x0C1A)
  IdTNEF_PR_DELETE_AFTER_SUBMIT						= $0E01; //PROP_TAG( PT_BOOLEAN,	0x0E01)
  IdTNEF_PR_MESSAGE_DELIVERY_TIME					= $0E06; //PROP_TAG( PT_SYSTIME,	0x0E06)
  IdTNEF_PR_SENTMAIL_ENTRYID						= $0E0A; //PROP_TAG( PT_BINARY,	    0x0E0A)
  IdTNEF_PR_NORMALIZED_SUBJECT						= $0E1D; //PROP_TAG( PT_TSTRING,	0x0E1D)
  IdTNEF_PR_RTF_IN_SYNC								= $0E1F; //PROP_TAG( PT_BOOLEAN,	0x0E1F)
  IdTNEF_PR_MAPPING_SIGNATURE						= $0FF8; //PROP_TAG( PT_BINARY,	    0x0FF8)
  IdTNEF_PR_STORE_RECORD_KEY						= $0FFA; //PROP_TAG( PT_BINARY,	    0x0FFA)
  IdTNEF_PR_STORE_ENTRYID							= $0FFB; //PROP_TAG( PT_BINARY,	    0x0FFB)
  IdTNEF_PR_OBJECT_TYPE								= $0FFE; //PROP_TAG( PT_LONG,		0x0FFE)
  IdTNEF_PR_STORE_SUPPORT_MASK						= $340D; //PROP_TAG( PT_LONG,		0x340D)
  IdTNEF_PR_TNEF_CORRELATION_KEY					= $007F; //PROP_TAG(PT_BINARY,		0x007F)
  IdTNEF_PR_BODY									= $1000; //PROP_TAG( PT_TSTRING,	0x1000)
  IdTNEF_PR_RTF_SYNC_BODY_CRC						= $1006; //PROP_TAG( PT_LONG,		0x1006)
  IdTNEF_PR_RTF_SYNC_BODY_COUNT						= $1007; //PROP_TAG( PT_LONG,		0x1007)
  IdTNEF_PR_RTF_SYNC_BODY_TAG						= $1008; //PROP_TAG( PT_TSTRING,	0x1008)
  IdTNEF_PR_RTF_COMPRESSED							= $1009; //PROP_TAG( PT_BINARY,	    0x1009)
  IdTNEF_PR_RTF_SYNC_PREFIX_COUNT					= $1010; //PROP_TAG( PT_LONG,		0x1010)
  IdTNEF_PR_RTF_SYNC_TRAILING_COUNT					= $1011; //PROP_TAG( PT_LONG,		0x1011)
  IdTNEF_PR_ORIGINALLY_INTENDED_RECIP_ENTRYID		= $1012; //PROP_TAG( PT_BINARY,	    0x1012)
{
#define PR_ACKNOWLEDGEMENT_MODE						PROP_TAG( PT_LONG,		0x0001)
//#define PR_ALTERNATE_RECIPIENT_ALLOWED				PROP_TAG( PT_BOOLEAN,	0x0002)
#define PR_AUTHORIZING_USERS						PROP_TAG( PT_BINARY,	0x0003)
#define PR_AUTO_FORWARD_COMMENT						PROP_TAG( PT_TSTRING,	0x0004)
#define PR_AUTO_FORWARD_COMMENT_W					PROP_TAG( PT_UNICODE,	0x0004)
#define PR_AUTO_FORWARD_COMMENT_A					PROP_TAG( PT_STRING8,	0x0004)
#define PR_AUTO_FORWARDED							PROP_TAG( PT_BOOLEAN,	0x0005)
#define PR_CONTENT_CONFIDENTIALITY_ALGORITHM_ID		PROP_TAG( PT_BINARY,	0x0006)
#define PR_CONTENT_CORRELATOR						PROP_TAG( PT_BINARY,	0x0007)
#define PR_CONTENT_IDENTIFIER						PROP_TAG( PT_TSTRING,	0x0008)
#define PR_CONTENT_IDENTIFIER_W						PROP_TAG( PT_UNICODE,	0x0008)
#define PR_CONTENT_IDENTIFIER_A						PROP_TAG( PT_STRING8,	0x0008)
#define PR_CONTENT_LENGTH							PROP_TAG( PT_LONG,		0x0009)
#define PR_CONTENT_RETURN_REQUESTED					PROP_TAG( PT_BOOLEAN,	0x000A)



#define PR_CONVERSATION_KEY							PROP_TAG( PT_BINARY,	0x000B)

#define PR_CONVERSION_EITS							PROP_TAG( PT_BINARY,	0x000C)
#define PR_CONVERSION_WITH_LOSS_PROHIBITED			PROP_TAG( PT_BOOLEAN,	0x000D)
#define PR_CONVERTED_EITS							PROP_TAG( PT_BINARY,	0x000E)
#define PR_DEFERRED_DELIVERY_TIME					PROP_TAG( PT_SYSTIME,	0x000F)
#define PR_DELIVER_TIME								PROP_TAG( PT_SYSTIME,	0x0010)
#define PR_DISCARD_REASON							PROP_TAG( PT_LONG,		0x0011)
#define PR_DISCLOSURE_OF_RECIPIENTS					PROP_TAG( PT_BOOLEAN,	0x0012)
#define PR_DL_EXPANSION_HISTORY						PROP_TAG( PT_BINARY,	0x0013)
#define PR_DL_EXPANSION_PROHIBITED					PROP_TAG( PT_BOOLEAN,	0x0014)
#define PR_EXPIRY_TIME								PROP_TAG( PT_SYSTIME,	0x0015)
#define PR_IMPLICIT_CONVERSION_PROHIBITED			PROP_TAG( PT_BOOLEAN,	0x0016)
#define PR_IMPORTANCE								PROP_TAG( PT_LONG,		0x0017)
#define PR_IPM_ID									PROP_TAG( PT_BINARY,	0x0018)
#define PR_LATEST_DELIVERY_TIME						PROP_TAG( PT_SYSTIME,	0x0019)
#define PR_MESSAGE_CLASS							PROP_TAG( PT_TSTRING,	0x001A)
#define PR_MESSAGE_CLASS_W							PROP_TAG( PT_UNICODE,	0x001A)
#define PR_MESSAGE_CLASS_A							PROP_TAG( PT_STRING8,	0x001A)
#define PR_MESSAGE_DELIVERY_ID						PROP_TAG( PT_BINARY,	0x001B)





#define PR_MESSAGE_SECURITY_LABEL					PROP_TAG( PT_BINARY,	0x001E)
#define PR_OBSOLETED_IPMS							PROP_TAG( PT_BINARY,	0x001F)
#define PR_ORIGINALLY_INTENDED_RECIPIENT_NAME		PROP_TAG( PT_BINARY,	0x0020)
#define PR_ORIGINAL_EITS							PROP_TAG( PT_BINARY,	0x0021)
#define PR_ORIGINATOR_CERTIFICATE					PROP_TAG( PT_BINARY,	0x0022)
//#define PR_ORIGINATOR_DELIVERY_REPORT_REQUESTED		PROP_TAG( PT_BOOLEAN,	0x0023)
#define PR_ORIGINATOR_RETURN_ADDRESS				PROP_TAG( PT_BINARY,	0x0024)



#define PR_PARENT_KEY								PROP_TAG( PT_BINARY,	0x0025)
//#define PR_PRIORITY									PROP_TAG( PT_LONG,		0x0026)



#define PR_ORIGIN_CHECK								PROP_TAG( PT_BINARY,	0x0027)
#define PR_PROOF_OF_SUBMISSION_REQUESTED			PROP_TAG( PT_BOOLEAN,	0x0028)
#define PR_READ_RECEIPT_REQUESTED					PROP_TAG( PT_BOOLEAN,	0x0029)
#define PR_RECEIPT_TIME								PROP_TAG( PT_SYSTIME,	0x002A)
#define PR_RECIPIENT_REASSIGNMENT_PROHIBITED		PROP_TAG( PT_BOOLEAN,	0x002B)
#define PR_REDIRECTION_HISTORY						PROP_TAG( PT_BINARY,	0x002C)
#define PR_RELATED_IPMS								PROP_TAG( PT_BINARY,	0x002D)
//#define PR_ORIGINAL_SENSITIVITY						PROP_TAG( PT_LONG,		0x002E)
#define	PR_LANGUAGES								PROP_TAG( PT_TSTRING,	0x002F)
#define	PR_LANGUAGES_W								PROP_TAG( PT_UNICODE,	0x002F)
#define	PR_LANGUAGES_A								PROP_TAG( PT_STRING8,	0x002F)
#define PR_REPLY_TIME								PROP_TAG( PT_SYSTIME,	0x0030)
#define PR_REPORT_TAG								PROP_TAG( PT_BINARY,	0x0031)
#define PR_REPORT_TIME								PROP_TAG( PT_SYSTIME,	0x0032)
#define PR_RETURNED_IPM								PROP_TAG( PT_BOOLEAN,	0x0033)
#define PR_SECURITY									PROP_TAG( PT_LONG,		0x0034)
#define	PR_INCOMPLETE_COPY							PROP_TAG( PT_BOOLEAN,	0x0035)
#define PR_SENSITIVITY								PROP_TAG( PT_LONG,		0x0036)
#define PR_SUBJECT									PROP_TAG( PT_TSTRING,	0x0037)
#define PR_SUBJECT_W								PROP_TAG( PT_UNICODE,	0x0037)
#define PR_SUBJECT_A								PROP_TAG( PT_STRING8,	0x0037)
#define PR_SUBJECT_IPM								PROP_TAG( PT_BINARY,	0x0038)
//#define PR_CLIENT_SUBMIT_TIME						PROP_TAG( PT_SYSTIME,	0x0039)
#define PR_REPORT_NAME								PROP_TAG( PT_TSTRING,	0x003A)
#define PR_REPORT_NAME_W							PROP_TAG( PT_UNICODE,	0x003A)
#define PR_REPORT_NAME_A							PROP_TAG( PT_STRING8,	0x003A)
#define	PR_SENT_REPRESENTING_SEARCH_KEY				PROP_TAG( PT_BINARY,	0x003B)
#define PR_X400_CONTENT_TYPE						PROP_TAG( PT_BINARY,	0x003C)
//#define PR_SUBJECT_PREFIX							PROP_TAG( PT_TSTRING,	0x003D)
//#define PR_SUBJECT_PREFIX_W	 						PROP_TAG( PT_UNICODE,	0x003D)
//#define PR_SUBJECT_PREFIX_A	 						PROP_TAG( PT_STRING8,	0x003D)
#define PR_NON_RECEIPT_REASON						PROP_TAG( PT_LONG,		0x003E)
#define PR_RECEIVED_BY_ENTRYID						PROP_TAG( PT_BINARY,	0x003F)
#define PR_RECEIVED_BY_NAME							PROP_TAG( PT_TSTRING,	0x0040)
#define PR_RECEIVED_BY_NAME_W						PROP_TAG( PT_UNICODE,	0x0040)
#define PR_RECEIVED_BY_NAME_A						PROP_TAG( PT_STRING8,	0x0040)
#define	PR_SENT_REPRESENTING_ENTRYID				PROP_TAG( PT_BINARY,	0x0041)
#define PR_SENT_REPRESENTING_NAME					PROP_TAG( PT_TSTRING,	0x0042)
#define PR_SENT_REPRESENTING_NAME_W					PROP_TAG( PT_UNICODE,	0x0042)
#define PR_SENT_REPRESENTING_NAME_A					PROP_TAG( PT_STRING8,	0x0042)
#define PR_RCVD_REPRESENTING_ENTRYID				PROP_TAG( PT_BINARY,	0x0043)
#define PR_RCVD_REPRESENTING_NAME					PROP_TAG( PT_TSTRING,	0x0044)
#define PR_RCVD_REPRESENTING_NAME_W					PROP_TAG( PT_UNICODE,	0x0044)
#define PR_RCVD_REPRESENTING_NAME_A					PROP_TAG( PT_STRING8,	0x0044)
#define PR_REPORT_ENTRYID							PROP_TAG( PT_BINARY,	0x0045)
#define PR_READ_RECEIPT_ENTRYID						PROP_TAG( PT_BINARY,	0x0046)
#define PR_MESSAGE_SUBMISSION_ID					PROP_TAG( PT_BINARY,	0x0047)
#define PR_PROVIDER_SUBMIT_TIME						PROP_TAG( PT_SYSTIME,	0x0048)
//#define	PR_ORIGINAL_SUBJECT							PROP_TAG( PT_TSTRING,	0x0049)
#define	PR_ORIGINAL_SUBJECT_W						PROP_TAG( PT_UNICODE,	0x0049)
#define	PR_ORIGINAL_SUBJECT_A						PROP_TAG( PT_STRING8,	0x0049)
#define PR_DISC_VAL									PROP_TAG( PT_BOOLEAN,	0x004A)
#define PR_ORIG_MESSAGE_CLASS						PROP_TAG( PT_TSTRING,	0x004B)
#define PR_ORIG_MESSAGE_CLASS_W						PROP_TAG( PT_UNICODE,	0x004B)
#define PR_ORIG_MESSAGE_CLASS_A						PROP_TAG( PT_STRING8,	0x004B)
#define PR_ORIGINAL_AUTHOR_ENTRYID					PROP_TAG( PT_BINARY,	0x004C)
#define PR_ORIGINAL_AUTHOR_NAME						PROP_TAG( PT_TSTRING,	0x004D)
#define PR_ORIGINAL_AUTHOR_NAME_W					PROP_TAG( PT_UNICODE,	0x004D)
#define PR_ORIGINAL_AUTHOR_NAME_A					PROP_TAG( PT_STRING8,	0x004D)
//#define PR_ORIGINAL_SUBMIT_TIME						PROP_TAG( PT_SYSTIME,	0x004E)
#define PR_REPLY_RECIPIENT_ENTRIES					PROP_TAG( PT_BINARY,	0x004F)
#define PR_REPLY_RECIPIENT_NAMES					PROP_TAG( PT_TSTRING,	0x0050)
#define PR_REPLY_RECIPIENT_NAMES_W					PROP_TAG( PT_UNICODE,	0x0050)
#define PR_REPLY_RECIPIENT_NAMES_A					PROP_TAG( PT_STRING8,	0x0050)

#define PR_RECEIVED_BY_SEARCH_KEY					PROP_TAG( PT_BINARY,	0x0051)
#define PR_RCVD_REPRESENTING_SEARCH_KEY				PROP_TAG( PT_BINARY,	0x0052)
#define PR_READ_RECEIPT_SEARCH_KEY					PROP_TAG( PT_BINARY,	0x0053)
#define PR_REPORT_SEARCH_KEY						PROP_TAG( PT_BINARY,	0x0054)
#define	PR_ORIGINAL_DELIVERY_TIME					PROP_TAG( PT_SYSTIME,	0x0055)
#define PR_ORIGINAL_AUTHOR_SEARCH_KEY				PROP_TAG( PT_BINARY,	0x0056)

#define	PR_MESSAGE_TO_ME							PROP_TAG( PT_BOOLEAN,	0x0057)
#define	PR_MESSAGE_CC_ME							PROP_TAG( PT_BOOLEAN,	0x0058)
#define	PR_MESSAGE_RECIP_ME							PROP_TAG( PT_BOOLEAN,	0x0059)

//#define PR_ORIGINAL_SENDER_NAME						PROP_TAG( PT_TSTRING,	0x005A)
//#define PR_ORIGINAL_SENDER_NAME_W					PROP_TAG( PT_UNICODE,	0x005A)
//#define PR_ORIGINAL_SENDER_NAME_A					PROP_TAG( PT_STRING8,	0x005A)
//#define	PR_ORIGINAL_SENDER_ENTRYID					PROP_TAG( PT_BINARY,	0x005B)
//#define	PR_ORIGINAL_SENDER_SEARCH_KEY				PROP_TAG( PT_BINARY,	0x005C)
//#define PR_ORIGINAL_SENT_REPRESENTING_NAME			PROP_TAG( PT_TSTRING,	0x005D)
//#define PR_ORIGINAL_SENT_REPRESENTING_NAME_W		PROP_TAG( PT_UNICODE,	0x005D)
//#define PR_ORIGINAL_SENT_REPRESENTING_NAME_A		PROP_TAG( PT_STRING8,	0x005D)
//#define	PR_ORIGINAL_SENT_REPRESENTING_ENTRYID		PROP_TAG( PT_BINARY,	0x005E)
//#define	PR_ORIGINAL_SENT_REPRESENTING_SEARCH_KEY	PROP_TAG( PT_BINARY,	0x005F)

#define PR_START_DATE								PROP_TAG( PT_SYSTIME,	0x0060)
#define PR_END_DATE									PROP_TAG( PT_SYSTIME,	0x0061)
#define PR_OWNER_APPT_ID							PROP_TAG( PT_LONG,		0x0062)
#define PR_RESPONSE_REQUESTED						PROP_TAG( PT_BOOLEAN,	0x0063)

#define PR_SENT_REPRESENTING_ADDRTYPE				PROP_TAG( PT_TSTRING,	0x0064)
#define PR_SENT_REPRESENTING_ADDRTYPE_W				PROP_TAG( PT_UNICODE,	0x0064)
#define PR_SENT_REPRESENTING_ADDRTYPE_A				PROP_TAG( PT_STRING8,	0x0064)
#define PR_SENT_REPRESENTING_EMAIL_ADDRESS			PROP_TAG( PT_TSTRING,	0x0065)
#define PR_SENT_REPRESENTING_EMAIL_ADDRESS_W		PROP_TAG( PT_UNICODE,	0x0065)
#define PR_SENT_REPRESENTING_EMAIL_ADDRESS_A		PROP_TAG( PT_STRING8,	0x0065)

//#define PR_ORIGINAL_SENDER_ADDRTYPE					PROP_TAG( PT_TSTRING,	0x0066)
//#define PR_ORIGINAL_SENDER_ADDRTYPE_W				PROP_TAG( PT_UNICODE,	0x0066)
//#define PR_ORIGINAL_SENDER_ADDRTYPE_A				PROP_TAG( PT_STRING8,	0x0066)
//#define PR_ORIGINAL_SENDER_EMAIL_ADDRESS			PROP_TAG( PT_TSTRING,	0x0067)
//#define PR_ORIGINAL_SENDER_EMAIL_ADDRESS_W			PROP_TAG( PT_UNICODE,	0x0067)
//#define PR_ORIGINAL_SENDER_EMAIL_ADDRESS_A			PROP_TAG( PT_STRING8,	0x0067)

//#define PR_ORIGINAL_SENT_REPRESENTING_ADDRTYPE		PROP_TAG( PT_TSTRING,	0x0068)
//#define PR_ORIGINAL_SENT_REPRESENTING_ADDRTYPE_W	PROP_TAG( PT_UNICODE,	0x0068)
//#define PR_ORIGINAL_SENT_REPRESENTING_ADDRTYPE_A	PROP_TAG( PT_STRING8,	0x0068)
//#define PR_ORIGINAL_SENT_REPRESENTING_EMAIL_ADDRESS	PROP_TAG( PT_TSTRING,	0x0069)
//#define PR_ORIGINAL_SENT_REPRESENTING_EMAIL_ADDRESS_W	PROP_TAG( PT_UNICODE,	0x0069)
//#define PR_ORIGINAL_SENT_REPRESENTING_EMAIL_ADDRESS_A	PROP_TAG( PT_STRING8,	0x0069)

//#define	PR_CONVERSATION_TOPIC						PROP_TAG( PT_TSTRING,	0x0070)
#define	PR_CONVERSATION_TOPIC_W						PROP_TAG( PT_UNICODE,	0x0070)
#define	PR_CONVERSATION_TOPIC_A						PROP_TAG( PT_STRING8,	0x0070)
//#define	PR_CONVERSATION_INDEX						PROP_TAG( PT_BINARY,	0x0071)

#define PR_ORIGINAL_DISPLAY_BCC						PROP_TAG( PT_TSTRING,	0x0072)
#define PR_ORIGINAL_DISPLAY_BCC_W					PROP_TAG( PT_UNICODE,	0x0072)
#define PR_ORIGINAL_DISPLAY_BCC_A					PROP_TAG( PT_STRING8,	0x0072)
//#define PR_ORIGINAL_DISPLAY_CC						PROP_TAG( PT_TSTRING,	0x0073)
//#define PR_ORIGINAL_DISPLAY_CC_W					PROP_TAG( PT_UNICODE,	0x0073)
//#define PR_ORIGINAL_DISPLAY_CC_A					PROP_TAG( PT_STRING8,	0x0073)
//#define PR_ORIGINAL_DISPLAY_TO						PROP_TAG( PT_TSTRING,	0x0074)
//#define PR_ORIGINAL_DISPLAY_TO_W					PROP_TAG( PT_UNICODE,	0x0074)
//#define PR_ORIGINAL_DISPLAY_TO_A					PROP_TAG( PT_STRING8,	0x0074)

#define PR_RECEIVED_BY_ADDRTYPE						PROP_TAG( PT_TSTRING,	0x0075)
#define PR_RECEIVED_BY_ADDRTYPE_W					PROP_TAG( PT_UNICODE,	0x0075)
#define PR_RECEIVED_BY_ADDRTYPE_A					PROP_TAG( PT_STRING8,	0x0075)
#define	PR_RECEIVED_BY_EMAIL_ADDRESS				PROP_TAG( PT_TSTRING,	0x0076)
#define	PR_RECEIVED_BY_EMAIL_ADDRESS_W				PROP_TAG( PT_UNICODE,	0x0076)
#define	PR_RECEIVED_BY_EMAIL_ADDRESS_A				PROP_TAG( PT_STRING8,	0x0076)

#define PR_RCVD_REPRESENTING_ADDRTYPE				PROP_TAG( PT_TSTRING,	0x0077)
#define PR_RCVD_REPRESENTING_ADDRTYPE_W				PROP_TAG( PT_UNICODE,	0x0077)
#define PR_RCVD_REPRESENTING_ADDRTYPE_A				PROP_TAG( PT_STRING8,	0x0077)
#define PR_RCVD_REPRESENTING_EMAIL_ADDRESS			PROP_TAG( PT_TSTRING,	0x0078)
#define PR_RCVD_REPRESENTING_EMAIL_ADDRESS_W		PROP_TAG( PT_UNICODE,	0x0078)
#define PR_RCVD_REPRESENTING_EMAIL_ADDRESS_A		PROP_TAG( PT_STRING8,	0x0078)

#define PR_ORIGINAL_AUTHOR_ADDRTYPE					PROP_TAG( PT_TSTRING,	0x0079)
#define PR_ORIGINAL_AUTHOR_ADDRTYPE_W				PROP_TAG( PT_UNICODE,	0x0079)
#define PR_ORIGINAL_AUTHOR_ADDRTYPE_A				PROP_TAG( PT_STRING8,	0x0079)
#define PR_ORIGINAL_AUTHOR_EMAIL_ADDRESS			PROP_TAG( PT_TSTRING,	0x007A)
#define PR_ORIGINAL_AUTHOR_EMAIL_ADDRESS_W			PROP_TAG( PT_UNICODE,	0x007A)
#define PR_ORIGINAL_AUTHOR_EMAIL_ADDRESS_A			PROP_TAG( PT_STRING8,	0x007A)

#define PR_ORIGINALLY_INTENDED_RECIP_ADDRTYPE		PROP_TAG( PT_TSTRING,	0x007B)
#define PR_ORIGINALLY_INTENDED_RECIP_ADDRTYPE_W		PROP_TAG( PT_UNICODE,	0x007B)
#define PR_ORIGINALLY_INTENDED_RECIP_ADDRTYPE_A		PROP_TAG( PT_STRING8,	0x007B)
#define PR_ORIGINALLY_INTENDED_RECIP_EMAIL_ADDRESS	PROP_TAG( PT_TSTRING,	0x007C)
#define PR_ORIGINALLY_INTENDED_RECIP_EMAIL_ADDRESS_W	PROP_TAG( PT_UNICODE,	0x007C)
#define PR_ORIGINALLY_INTENDED_RECIP_EMAIL_ADDRESS_A	PROP_TAG( PT_STRING8,	0x007C)

#define PR_TRANSPORT_MESSAGE_HEADERS				PROP_TAG(PT_TSTRING,	0x007D)
#define PR_TRANSPORT_MESSAGE_HEADERS_W				PROP_TAG(PT_UNICODE,	0x007D)
#define PR_TRANSPORT_MESSAGE_HEADERS_A				PROP_TAG(PT_STRING8,	0x007D)

#define PR_DELEGATION								PROP_TAG(PT_BINARY,		0x007E)

#define PR_TNEF_CORRELATION_KEY						PROP_TAG(PT_BINARY,		0x007F)



/*
 *	Message content properties
 */

//#define PR_BODY										PROP_TAG( PT_TSTRING,	0x1000)
//#define PR_BODY_W									PROP_TAG( PT_UNICODE,	0x1000)
//#define PR_BODY_A									PROP_TAG( PT_STRING8,	0x1000)
#define PR_REPORT_TEXT								PROP_TAG( PT_TSTRING,	0x1001)
#define PR_REPORT_TEXT_W							PROP_TAG( PT_UNICODE,	0x1001)
#define PR_REPORT_TEXT_A							PROP_TAG( PT_STRING8,	0x1001)
#define PR_ORIGINATOR_AND_DL_EXPANSION_HISTORY		PROP_TAG( PT_BINARY,	0x1002)
#define PR_REPORTING_DL_NAME						PROP_TAG( PT_BINARY,	0x1003)
#define PR_REPORTING_MTA_CERTIFICATE				PROP_TAG( PT_BINARY,	0x1004)

/*  Removed PR_REPORT_ORIGIN_AUTHENTICATION_CHECK with DCR 3865, use PR_ORIGIN_CHECK */

#define PR_RTF_SYNC_BODY_CRC						PROP_TAG( PT_LONG,		0x1006)
#define PR_RTF_SYNC_BODY_COUNT						PROP_TAG( PT_LONG,		0x1007)
#define PR_RTF_SYNC_BODY_TAG						PROP_TAG( PT_TSTRING,	0x1008)
#define PR_RTF_SYNC_BODY_TAG_W						PROP_TAG( PT_UNICODE,	0x1008)
#define PR_RTF_SYNC_BODY_TAG_A						PROP_TAG( PT_STRING8,	0x1008)
#define PR_RTF_COMPRESSED							PROP_TAG( PT_BINARY,	0x1009)
#define PR_RTF_SYNC_PREFIX_COUNT					PROP_TAG( PT_LONG,		0x1010)
#define PR_RTF_SYNC_TRAILING_COUNT					PROP_TAG( PT_LONG,		0x1011)
#define PR_ORIGINALLY_INTENDED_RECIP_ENTRYID		PROP_TAG( PT_BINARY,	0x1012)

/*
 *  Reserved 0x1100-0x1200
 */


/*
 *	Message recipient properties
 */

#define PR_CONTENT_INTEGRITY_CHECK					PROP_TAG( PT_BINARY,	0x0C00)
#define PR_EXPLICIT_CONVERSION						PROP_TAG( PT_LONG,		0x0C01)
#define PR_IPM_RETURN_REQUESTED						PROP_TAG( PT_BOOLEAN,	0x0C02)
#define PR_MESSAGE_TOKEN							PROP_TAG( PT_BINARY,	0x0C03)
#define PR_NDR_REASON_CODE							PROP_TAG( PT_LONG,		0x0C04)
#define PR_NDR_DIAG_CODE							PROP_TAG( PT_LONG,		0x0C05)
#define PR_NON_RECEIPT_NOTIFICATION_REQUESTED		PROP_TAG( PT_BOOLEAN,	0x0C06)
#define PR_DELIVERY_POINT							PROP_TAG( PT_LONG,		0x0C07)

#define PR_ORIGINATOR_NON_DELIVERY_REPORT_REQUESTED	PROP_TAG( PT_BOOLEAN,	0x0C08)
#define PR_ORIGINATOR_REQUESTED_ALTERNATE_RECIPIENT	PROP_TAG( PT_BINARY,	0x0C09)
#define PR_PHYSICAL_DELIVERY_BUREAU_FAX_DELIVERY	PROP_TAG( PT_BOOLEAN,	0x0C0A)
#define PR_PHYSICAL_DELIVERY_MODE					PROP_TAG( PT_LONG,		0x0C0B)
#define PR_PHYSICAL_DELIVERY_REPORT_REQUEST			PROP_TAG( PT_LONG,		0x0C0C)
#define PR_PHYSICAL_FORWARDING_ADDRESS				PROP_TAG( PT_BINARY,	0x0C0D)
#define PR_PHYSICAL_FORWARDING_ADDRESS_REQUESTED	PROP_TAG( PT_BOOLEAN,	0x0C0E)
#define PR_PHYSICAL_FORWARDING_PROHIBITED			PROP_TAG( PT_BOOLEAN,	0x0C0F)
#define PR_PHYSICAL_RENDITION_ATTRIBUTES			PROP_TAG( PT_BINARY,	0x0C10)
#define PR_PROOF_OF_DELIVERY						PROP_TAG( PT_BINARY,	0x0C11)
#define PR_PROOF_OF_DELIVERY_REQUESTED				PROP_TAG( PT_BOOLEAN,	0x0C12)
#define PR_RECIPIENT_CERTIFICATE					PROP_TAG( PT_BINARY,	0x0C13)
#define PR_RECIPIENT_NUMBER_FOR_ADVICE				PROP_TAG( PT_TSTRING,	0x0C14)
#define PR_RECIPIENT_NUMBER_FOR_ADVICE_W			PROP_TAG( PT_UNICODE,	0x0C14)
#define PR_RECIPIENT_NUMBER_FOR_ADVICE_A			PROP_TAG( PT_STRING8,	0x0C14)
#define PR_RECIPIENT_TYPE							PROP_TAG( PT_LONG,		0x0C15)
#define PR_REGISTERED_MAIL_TYPE						PROP_TAG( PT_LONG,		0x0C16)
//#define PR_REPLY_REQUESTED							PROP_TAG( PT_BOOLEAN,	0x0C17)
#define PR_REQUESTED_DELIVERY_METHOD				PROP_TAG( PT_LONG,		0x0C18)
#define PR_SENDER_ENTRYID							PROP_TAG( PT_BINARY,	0x0C19)
//#define PR_SENDER_NAME								PROP_TAG( PT_TSTRING,	0x0C1A)
//#define PR_SENDER_NAME_W							PROP_TAG( PT_UNICODE,	0x0C1A)
//#define PR_SENDER_NAME_A							PROP_TAG( PT_STRING8,	0x0C1A)
#define PR_SUPPLEMENTARY_INFO						PROP_TAG( PT_TSTRING,	0x0C1B)
#define PR_SUPPLEMENTARY_INFO_W						PROP_TAG( PT_UNICODE,	0x0C1B)
#define PR_SUPPLEMENTARY_INFO_A						PROP_TAG( PT_STRING8,	0x0C1B)
#define PR_TYPE_OF_MTS_USER							PROP_TAG( PT_LONG,		0x0C1C)
//#define PR_SENDER_SEARCH_KEY						PROP_TAG( PT_BINARY,	0x0C1D)
#define PR_SENDER_ADDRTYPE							PROP_TAG( PT_TSTRING,	0x0C1E)
#define PR_SENDER_ADDRTYPE_W						PROP_TAG( PT_UNICODE,	0x0C1E)
#define PR_SENDER_ADDRTYPE_A						PROP_TAG( PT_STRING8,	0x0C1E)
#define PR_SENDER_EMAIL_ADDRESS						PROP_TAG( PT_TSTRING,	0x0C1F)
#define PR_SENDER_EMAIL_ADDRESS_W					PROP_TAG( PT_UNICODE,	0x0C1F)
#define PR_SENDER_EMAIL_ADDRESS_A					PROP_TAG( PT_STRING8,	0x0C1F)

/*
 *	Message non-transmittable properties
 */

/*
 * The two tags, PR_MESSAGE_RECIPIENTS and PR_MESSAGE_ATTACHMENTS,
 * are to be used in the exclude list passed to
 * IMessage::CopyTo when the caller wants either the recipients or attachments
 * of the message to not get copied.  It is also used in the ProblemArray
 * return from IMessage::CopyTo when an error is encountered copying them
 */

#define PR_CURRENT_VERSION							PROP_TAG( PT_I8,		0x0E00)
//#define PR_DELETE_AFTER_SUBMIT						PROP_TAG( PT_BOOLEAN,	0x0E01)
#define PR_DISPLAY_BCC								PROP_TAG( PT_TSTRING,	0x0E02)
#define PR_DISPLAY_BCC_W							PROP_TAG( PT_UNICODE,	0x0E02)
#define PR_DISPLAY_BCC_A							PROP_TAG( PT_STRING8,	0x0E02)
#define PR_DISPLAY_CC								PROP_TAG( PT_TSTRING,	0x0E03)
#define PR_DISPLAY_CC_W								PROP_TAG( PT_UNICODE,	0x0E03)
#define PR_DISPLAY_CC_A								PROP_TAG( PT_STRING8,	0x0E03)
#define PR_DISPLAY_TO								PROP_TAG( PT_TSTRING,	0x0E04)
#define PR_DISPLAY_TO_W								PROP_TAG( PT_UNICODE,	0x0E04)
#define PR_DISPLAY_TO_A								PROP_TAG( PT_STRING8,	0x0E04)
#define PR_PARENT_DISPLAY							PROP_TAG( PT_TSTRING,	0x0E05)
#define PR_PARENT_DISPLAY_W							PROP_TAG( PT_UNICODE,	0x0E05)
#define PR_PARENT_DISPLAY_A							PROP_TAG( PT_STRING8,	0x0E05)
#define PR_MESSAGE_DELIVERY_TIME					PROP_TAG( PT_SYSTIME,	0x0E06)
#define PR_MESSAGE_FLAGS							PROP_TAG( PT_LONG,		0x0E07)
#define PR_MESSAGE_SIZE								PROP_TAG( PT_LONG,		0x0E08)
#define PR_PARENT_ENTRYID							PROP_TAG( PT_BINARY,	0x0E09)
#define PR_SENTMAIL_ENTRYID							PROP_TAG( PT_BINARY,	0x0E0A)
#define PR_CORRELATE								PROP_TAG( PT_BOOLEAN,	0x0E0C)
#define PR_CORRELATE_MTSID							PROP_TAG( PT_BINARY,	0x0E0D)
#define PR_DISCRETE_VALUES							PROP_TAG( PT_BOOLEAN,	0x0E0E)
#define PR_RESPONSIBILITY							PROP_TAG( PT_BOOLEAN,	0x0E0F)
#define	PR_SPOOLER_STATUS							PROP_TAG( PT_LONG,		0x0E10)
#define	PR_TRANSPORT_STATUS							PROP_TAG( PT_LONG,		0x0E11)
#define PR_MESSAGE_RECIPIENTS						PROP_TAG( PT_OBJECT,	0x0E12)
#define PR_MESSAGE_ATTACHMENTS						PROP_TAG( PT_OBJECT,	0x0E13)
#define PR_SUBMIT_FLAGS								PROP_TAG( PT_LONG,		0x0E14)
#define PR_RECIPIENT_STATUS							PROP_TAG( PT_LONG,		0x0E15)
#define	PR_TRANSPORT_KEY							PROP_TAG( PT_LONG,		0x0E16)
#define PR_MSG_STATUS								PROP_TAG( PT_LONG,		0x0E17)
#define	PR_MESSAGE_DOWNLOAD_TIME					PROP_TAG( PT_LONG,		0x0E18)
#define PR_CREATION_VERSION							PROP_TAG( PT_I8,		0x0E19)
#define PR_MODIFY_VERSION							PROP_TAG( PT_I8,		0x0E1A)
#define PR_HASATTACH								PROP_TAG( PT_BOOLEAN,	0x0E1B)
#define PR_BODY_CRC									PROP_TAG( PT_LONG,      0x0E1C)
//#define PR_NORMALIZED_SUBJECT						PROP_TAG( PT_TSTRING,	0x0E1D)
//#define PR_NORMALIZED_SUBJECT_W						PROP_TAG( PT_UNICODE,	0x0E1D)
//#define PR_NORMALIZED_SUBJECT_A						PROP_TAG( PT_STRING8,	0x0E1D)
#define PR_RTF_IN_SYNC								PROP_TAG( PT_BOOLEAN,	0x0E1F)
#define PR_ATTACH_SIZE								PROP_TAG( PT_LONG,		0x0E20)
#define PR_ATTACH_NUM								PROP_TAG( PT_LONG,		0x0E21)
#define PR_PREPROCESS								PROP_TAG( PT_BOOLEAN,	0x0E22)

/* PR_ORIGINAL_DISPLAY_TO, _CC, and _BCC moved to transmittible range 03/09/95 */

#define PR_ORIGINATING_MTA_CERTIFICATE				PROP_TAG( PT_BINARY,	0x0E25)
#define PR_PROOF_OF_SUBMISSION						PROP_TAG( PT_BINARY,	0x0E26)


/*
 * The range of non-message and non-recipient property IDs (0x3000 - 0x3FFF) is
 * further broken down into ranges to make assigning new property IDs easier.
 *
 *	From	To		Kind of property
 *	--------------------------------
 *	3000	32FF	MAPI_defined common property
 *	3200	33FF	MAPI_defined form property
 *	3400	35FF	MAPI_defined message store property
 *	3600	36FF	MAPI_defined Folder or AB Container property
 *	3700	38FF	MAPI_defined attachment property
 *	3900	39FF	MAPI_defined address book property
 *	3A00	3BFF	MAPI_defined mailuser property
 *	3C00	3CFF	MAPI_defined DistList property
 *	3D00	3DFF	MAPI_defined Profile Section property
 *	3E00	3EFF	MAPI_defined Status property
 *	3F00	3FFF	MAPI_defined display table property
 */

/*
 *	Properties common to numerous MAPI objects.
 *
 *	Those properties that can appear on messages are in the
 *	non-transmittable range for messages. They start at the high
 *	end of that range and work down.
 *
 *	Properties that never appear on messages are defined in the common
 *	property range (see above).
 */

/*
 * properties that are common to multiple objects (including message objects)
 * -- these ids are in the non-transmittable range
 */

#define PR_ENTRYID									PROP_TAG( PT_BINARY,	0x0FFF)
#define PR_OBJECT_TYPE								PROP_TAG( PT_LONG,		0x0FFE)
#define PR_ICON										PROP_TAG( PT_BINARY,	0x0FFD)
#define PR_MINI_ICON								PROP_TAG( PT_BINARY,	0x0FFC)
#define PR_STORE_ENTRYID							PROP_TAG( PT_BINARY,	0x0FFB)
#define PR_STORE_RECORD_KEY							PROP_TAG( PT_BINARY,	0x0FFA)
#define PR_RECORD_KEY								PROP_TAG( PT_BINARY,	0x0FF9)
#define PR_MAPPING_SIGNATURE						PROP_TAG( PT_BINARY,	0x0FF8)
#define PR_ACCESS_LEVEL								PROP_TAG( PT_LONG,		0x0FF7)
#define PR_INSTANCE_KEY								PROP_TAG( PT_BINARY,	0x0FF6)
#define PR_ROW_TYPE									PROP_TAG( PT_LONG,		0x0FF5)
#define PR_ACCESS									PROP_TAG( PT_LONG,		0x0FF4)

/*
 * properties that are common to multiple objects (usually not including message objects)
 * -- these ids are in the transmittable range
 */

#define PR_ROWID									PROP_TAG( PT_LONG,		0x3000)
#define PR_DISPLAY_NAME								PROP_TAG( PT_TSTRING,	0x3001)
#define PR_DISPLAY_NAME_W							PROP_TAG( PT_UNICODE,	0x3001)
#define PR_DISPLAY_NAME_A							PROP_TAG( PT_STRING8,	0x3001)
#define PR_ADDRTYPE									PROP_TAG( PT_TSTRING,	0x3002)
#define PR_ADDRTYPE_W								PROP_TAG( PT_UNICODE,	0x3002)
#define PR_ADDRTYPE_A								PROP_TAG( PT_STRING8,	0x3002)
#define PR_EMAIL_ADDRESS							PROP_TAG( PT_TSTRING,	0x3003)
#define PR_EMAIL_ADDRESS_W							PROP_TAG( PT_UNICODE,	0x3003)
#define PR_EMAIL_ADDRESS_A							PROP_TAG( PT_STRING8,	0x3003)
#define PR_COMMENT									PROP_TAG( PT_TSTRING,	0x3004)
#define PR_COMMENT_W								PROP_TAG( PT_UNICODE,	0x3004)
#define PR_COMMENT_A								PROP_TAG( PT_STRING8,	0x3004)
#define PR_DEPTH									PROP_TAG( PT_LONG,		0x3005)
#define PR_PROVIDER_DISPLAY							PROP_TAG( PT_TSTRING,	0x3006)
#define PR_PROVIDER_DISPLAY_W						PROP_TAG( PT_UNICODE,	0x3006)
#define PR_PROVIDER_DISPLAY_A						PROP_TAG( PT_STRING8,	0x3006)
#define PR_CREATION_TIME							PROP_TAG( PT_SYSTIME,	0x3007)
#define PR_LAST_MODIFICATION_TIME					PROP_TAG( PT_SYSTIME,	0x3008)
#define PR_RESOURCE_FLAGS							PROP_TAG( PT_LONG,		0x3009)
#define PR_PROVIDER_DLL_NAME						PROP_TAG( PT_TSTRING,	0x300A)
#define PR_PROVIDER_DLL_NAME_W						PROP_TAG( PT_UNICODE,	0x300A)
#define PR_PROVIDER_DLL_NAME_A						PROP_TAG( PT_STRING8,	0x300A)
#define PR_SEARCH_KEY								PROP_TAG( PT_BINARY,	0x300B)
#define PR_PROVIDER_UID								PROP_TAG( PT_BINARY,	0x300C)
#define PR_PROVIDER_ORDINAL							PROP_TAG( PT_LONG,		0x300D)

/*
 *  MAPI Form properties
 */
#define PR_FORM_VERSION								PROP_TAG(PT_TSTRING,	0x3301)
#define PR_FORM_VERSION_W							PROP_TAG(PT_UNICODE,	0x3301)
#define PR_FORM_VERSION_A							PROP_TAG(PT_STRING8,	0x3301)
#define PR_FORM_CLSID								PROP_TAG(PT_CLSID,		0x3302)
#define PR_FORM_CONTACT_NAME						PROP_TAG(PT_TSTRING,	0x3303)
#define PR_FORM_CONTACT_NAME_W						PROP_TAG(PT_UNICODE,	0x3303)
#define PR_FORM_CONTACT_NAME_A						PROP_TAG(PT_STRING8,	0x3303)
#define PR_FORM_CATEGORY							PROP_TAG(PT_TSTRING,	0x3304)
#define PR_FORM_CATEGORY_W							PROP_TAG(PT_UNICODE,	0x3304)
#define PR_FORM_CATEGORY_A							PROP_TAG(PT_STRING8,	0x3304)
#define PR_FORM_CATEGORY_SUB						PROP_TAG(PT_TSTRING,	0x3305)
#define PR_FORM_CATEGORY_SUB_W						PROP_TAG(PT_UNICODE,	0x3305)
#define PR_FORM_CATEGORY_SUB_A						PROP_TAG(PT_STRING8,	0x3305)
#define PR_FORM_HOST_MAP							PROP_TAG(PT_MV_LONG,	0x3306)
#define PR_FORM_HIDDEN								PROP_TAG(PT_BOOLEAN,	0x3307)
#define PR_FORM_DESIGNER_NAME						PROP_TAG(PT_TSTRING,	0x3308)
#define PR_FORM_DESIGNER_NAME_W						PROP_TAG(PT_UNICODE,	0x3308)
#define PR_FORM_DESIGNER_NAME_A						PROP_TAG(PT_STRING8,	0x3308)
#define PR_FORM_DESIGNER_GUID						PROP_TAG(PT_CLSID,		0x3309)
#define PR_FORM_MESSAGE_BEHAVIOR					PROP_TAG(PT_LONG,		0x330A)

/*
 *	Message store properties
 */

#define PR_DEFAULT_STORE							PROP_TAG( PT_BOOLEAN,	0x3400)
#define PR_STORE_SUPPORT_MASK						PROP_TAG( PT_LONG,		0x340D)
#define PR_STORE_STATE								PROP_TAG( PT_LONG,		0x340E)

#define PR_IPM_SUBTREE_SEARCH_KEY					PROP_TAG( PT_BINARY,	0x3410)
#define PR_IPM_OUTBOX_SEARCH_KEY					PROP_TAG( PT_BINARY,	0x3411)
#define PR_IPM_WASTEBASKET_SEARCH_KEY				PROP_TAG( PT_BINARY,	0x3412)
#define PR_IPM_SENTMAIL_SEARCH_KEY					PROP_TAG( PT_BINARY,	0x3413)
#define PR_MDB_PROVIDER								PROP_TAG( PT_BINARY,	0x3414)
#define PR_RECEIVE_FOLDER_SETTINGS					PROP_TAG( PT_OBJECT,	0x3415)

#define PR_VALID_FOLDER_MASK						PROP_TAG( PT_LONG,		0x35DF)
#define PR_IPM_SUBTREE_ENTRYID						PROP_TAG( PT_BINARY,	0x35E0)

#define PR_IPM_OUTBOX_ENTRYID						PROP_TAG( PT_BINARY,	0x35E2)
#define PR_IPM_WASTEBASKET_ENTRYID					PROP_TAG( PT_BINARY,	0x35E3)
#define PR_IPM_SENTMAIL_ENTRYID						PROP_TAG( PT_BINARY,	0x35E4)
#define PR_VIEWS_ENTRYID							PROP_TAG( PT_BINARY,	0x35E5)
#define PR_COMMON_VIEWS_ENTRYID						PROP_TAG( PT_BINARY,	0x35E6)
#define PR_FINDER_ENTRYID							PROP_TAG( PT_BINARY,	0x35E7)

/* Proptags 0x35E8-0x35FF reserved for folders "guaranteed" by PR_VALID_FOLDER_MASK */


/*
 *	Folder and AB Container properties
 */

#define PR_CONTAINER_FLAGS							PROP_TAG( PT_LONG,		0x3600)
#define PR_FOLDER_TYPE								PROP_TAG( PT_LONG,		0x3601)
#define PR_CONTENT_COUNT							PROP_TAG( PT_LONG,		0x3602)
#define PR_CONTENT_UNREAD							PROP_TAG( PT_LONG,		0x3603)
#define PR_CREATE_TEMPLATES							PROP_TAG( PT_OBJECT,	0x3604)
#define PR_DETAILS_TABLE							PROP_TAG( PT_OBJECT,	0x3605)
#define PR_SEARCH									PROP_TAG( PT_OBJECT,	0x3607)
#define PR_SELECTABLE								PROP_TAG( PT_BOOLEAN,	0x3609)
#define PR_SUBFOLDERS								PROP_TAG( PT_BOOLEAN,	0x360A)
#define PR_STATUS									PROP_TAG( PT_LONG,		0x360B)
#define PR_ANR										PROP_TAG( PT_TSTRING,	0x360C)
#define PR_ANR_W									PROP_TAG( PT_UNICODE,	0x360C)
#define PR_ANR_A									PROP_TAG( PT_STRING8,	0x360C)
#define PR_CONTENTS_SORT_ORDER						PROP_TAG( PT_MV_LONG,	0x360D)
#define PR_CONTAINER_HIERARCHY						PROP_TAG( PT_OBJECT,	0x360E)
#define PR_CONTAINER_CONTENTS						PROP_TAG( PT_OBJECT,	0x360F)
#define PR_FOLDER_ASSOCIATED_CONTENTS				PROP_TAG( PT_OBJECT,	0x3610)
#define PR_DEF_CREATE_DL							PROP_TAG( PT_BINARY,	0x3611)
#define PR_DEF_CREATE_MAILUSER						PROP_TAG( PT_BINARY,	0x3612)
#define	PR_CONTAINER_CLASS							PROP_TAG( PT_TSTRING,	0x3613)
#define	PR_CONTAINER_CLASS_W						PROP_TAG( PT_UNICODE,	0x3613)
#define	PR_CONTAINER_CLASS_A						PROP_TAG( PT_STRING8,	0x3613)
#define	PR_CONTAINER_MODIFY_VERSION					PROP_TAG( PT_I8,		0x3614)
#define PR_AB_PROVIDER_ID							PROP_TAG( PT_BINARY,	0x3615)
#define PR_DEFAULT_VIEW_ENTRYID						PROP_TAG( PT_BINARY,	0x3616)
#define	PR_ASSOC_CONTENT_COUNT						PROP_TAG( PT_LONG,		0x3617)

/* Reserved 0x36C0-0x36FF */

/*
 *	Attachment properties
 */

#define PR_ATTACHMENT_X400_PARAMETERS				PROP_TAG( PT_BINARY,	0x3700)
#define PR_ATTACH_DATA_OBJ							PROP_TAG( PT_OBJECT,	0x3701)
#define PR_ATTACH_DATA_BIN							PROP_TAG( PT_BINARY,	0x3701)
#define PR_ATTACH_ENCODING							PROP_TAG( PT_BINARY,	0x3702)
#define PR_ATTACH_EXTENSION							PROP_TAG( PT_TSTRING,	0x3703)
#define PR_ATTACH_EXTENSION_W						PROP_TAG( PT_UNICODE,	0x3703)
#define PR_ATTACH_EXTENSION_A						PROP_TAG( PT_STRING8,	0x3703)
#define PR_ATTACH_FILENAME							PROP_TAG( PT_TSTRING,	0x3704)
#define PR_ATTACH_FILENAME_W						PROP_TAG( PT_UNICODE,	0x3704)
#define PR_ATTACH_FILENAME_A						PROP_TAG( PT_STRING8,	0x3704)
#define PR_ATTACH_METHOD							PROP_TAG( PT_LONG,		0x3705)
#define PR_ATTACH_LONG_FILENAME	 					PROP_TAG( PT_TSTRING,	0x3707)
#define PR_ATTACH_LONG_FILENAME_W					PROP_TAG( PT_UNICODE,	0x3707)
#define PR_ATTACH_LONG_FILENAME_A					PROP_TAG( PT_STRING8,	0x3707)
#define PR_ATTACH_PATHNAME							PROP_TAG( PT_TSTRING,	0x3708)
#define PR_ATTACH_PATHNAME_W						PROP_TAG( PT_UNICODE,	0x3708)
#define PR_ATTACH_PATHNAME_A						PROP_TAG( PT_STRING8,	0x3708)
#define PR_ATTACH_RENDERING							PROP_TAG( PT_BINARY,    0x3709)
#define PR_ATTACH_TAG								PROP_TAG( PT_BINARY,	0x370A)
#define PR_RENDERING_POSITION						PROP_TAG( PT_LONG,		0x370B)
#define PR_ATTACH_TRANSPORT_NAME					PROP_TAG( PT_TSTRING,	0x370C)
#define PR_ATTACH_TRANSPORT_NAME_W					PROP_TAG( PT_UNICODE,	0x370C)
#define PR_ATTACH_TRANSPORT_NAME_A					PROP_TAG( PT_STRING8,	0x370C)
#define PR_ATTACH_LONG_PATHNAME	 					PROP_TAG( PT_TSTRING,	0x370D)
#define PR_ATTACH_LONG_PATHNAME_W					PROP_TAG( PT_UNICODE,	0x370D)
#define PR_ATTACH_LONG_PATHNAME_A					PROP_TAG( PT_STRING8,	0x370D)
#define PR_ATTACH_MIME_TAG							PROP_TAG( PT_TSTRING,	0x370E)
#define PR_ATTACH_MIME_TAG_W						PROP_TAG( PT_UNICODE,	0x370E)
#define PR_ATTACH_MIME_TAG_A						PROP_TAG( PT_STRING8,	0x370E)
#define	PR_ATTACH_ADDITIONAL_INFO					PROP_TAG( PT_BINARY,	0x370F)

/*
 *  AB Object properties
 */

#define PR_DISPLAY_TYPE								PROP_TAG( PT_LONG,		0x3900)
#define PR_TEMPLATEID								PROP_TAG( PT_BINARY,	0x3902)
#define PR_PRIMARY_CAPABILITY						PROP_TAG( PT_BINARY,	0x3904)


/*
 *	Mail user properties
 */
#define PR_7BIT_DISPLAY_NAME						PROP_TAG( PT_STRING8,	0x39FF)
#define PR_ACCOUNT									PROP_TAG( PT_TSTRING,	0x3A00)
#define PR_ACCOUNT_W								PROP_TAG( PT_UNICODE,	0x3A00)
#define PR_ACCOUNT_A								PROP_TAG( PT_STRING8,	0x3A00)
#define PR_ALTERNATE_RECIPIENT						PROP_TAG( PT_BINARY,	0x3A01)
#define PR_CALLBACK_TELEPHONE_NUMBER				PROP_TAG( PT_TSTRING,	0x3A02)
#define PR_CALLBACK_TELEPHONE_NUMBER_W				PROP_TAG( PT_UNICODE,	0x3A02)
#define PR_CALLBACK_TELEPHONE_NUMBER_A				PROP_TAG( PT_STRING8,	0x3A02)
#define PR_CONVERSION_PROHIBITED					PROP_TAG( PT_BOOLEAN,	0x3A03)
#define PR_DISCLOSE_RECIPIENTS						PROP_TAG( PT_BOOLEAN,	0x3A04)
#define PR_GENERATION								PROP_TAG( PT_TSTRING,	0x3A05)
#define PR_GENERATION_W								PROP_TAG( PT_UNICODE,	0x3A05)
#define PR_GENERATION_A								PROP_TAG( PT_STRING8,	0x3A05)
#define PR_GIVEN_NAME								PROP_TAG( PT_TSTRING,	0x3A06)
#define PR_GIVEN_NAME_W								PROP_TAG( PT_UNICODE,	0x3A06)
#define PR_GIVEN_NAME_A								PROP_TAG( PT_STRING8,	0x3A06)
#define PR_GOVERNMENT_ID_NUMBER						PROP_TAG( PT_TSTRING,	0x3A07)
#define PR_GOVERNMENT_ID_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A07)
#define PR_GOVERNMENT_ID_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A07)
#define PR_BUSINESS_TELEPHONE_NUMBER				PROP_TAG( PT_TSTRING,	0x3A08)
#define PR_BUSINESS_TELEPHONE_NUMBER_W				PROP_TAG( PT_UNICODE,	0x3A08)
#define PR_BUSINESS_TELEPHONE_NUMBER_A				PROP_TAG( PT_STRING8,	0x3A08)
#define PR_OFFICE_TELEPHONE_NUMBER					PR_BUSINESS_TELEPHONE_NUMBER
#define PR_OFFICE_TELEPHONE_NUMBER_W				PR_BUSINESS_TELEPHONE_NUMBER_W
#define PR_OFFICE_TELEPHONE_NUMBER_A				PR_BUSINESS_TELEPHONE_NUMBER_A
#define PR_HOME_TELEPHONE_NUMBER					PROP_TAG( PT_TSTRING,	0x3A09)
#define PR_HOME_TELEPHONE_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A09)
#define PR_HOME_TELEPHONE_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A09)
#define PR_INITIALS									PROP_TAG( PT_TSTRING,	0x3A0A)
#define PR_INITIALS_W								PROP_TAG( PT_UNICODE,	0x3A0A)
#define PR_INITIALS_A								PROP_TAG( PT_STRING8,	0x3A0A)
#define PR_KEYWORD									PROP_TAG( PT_TSTRING,	0x3A0B)
#define PR_KEYWORD_W								PROP_TAG( PT_UNICODE,	0x3A0B)
#define PR_KEYWORD_A								PROP_TAG( PT_STRING8,	0x3A0B)
#define PR_LANGUAGE									PROP_TAG( PT_TSTRING,	0x3A0C)
#define PR_LANGUAGE_W								PROP_TAG( PT_UNICODE,	0x3A0C)
#define PR_LANGUAGE_A								PROP_TAG( PT_STRING8,	0x3A0C)
#define PR_LOCATION									PROP_TAG( PT_TSTRING,	0x3A0D)
#define PR_LOCATION_W								PROP_TAG( PT_UNICODE,	0x3A0D)
#define PR_LOCATION_A								PROP_TAG( PT_STRING8,	0x3A0D)
#define PR_MAIL_PERMISSION							PROP_TAG( PT_BOOLEAN,	0x3A0E)
#define PR_MHS_COMMON_NAME							PROP_TAG( PT_TSTRING,	0x3A0F)
#define PR_MHS_COMMON_NAME_W						PROP_TAG( PT_UNICODE,	0x3A0F)
#define PR_MHS_COMMON_NAME_A						PROP_TAG( PT_STRING8,	0x3A0F)
#define PR_ORGANIZATIONAL_ID_NUMBER					PROP_TAG( PT_TSTRING,	0x3A10)
#define PR_ORGANIZATIONAL_ID_NUMBER_W				PROP_TAG( PT_UNICODE,	0x3A10)
#define PR_ORGANIZATIONAL_ID_NUMBER_A				PROP_TAG( PT_STRING8,	0x3A10)
#define PR_SURNAME									PROP_TAG( PT_TSTRING,	0x3A11)
#define PR_SURNAME_W								PROP_TAG( PT_UNICODE,	0x3A11)
#define PR_SURNAME_A								PROP_TAG( PT_STRING8,	0x3A11)
#define PR_ORIGINAL_ENTRYID							PROP_TAG( PT_BINARY,	0x3A12)
#define PR_ORIGINAL_DISPLAY_NAME					PROP_TAG( PT_TSTRING,	0x3A13)
#define PR_ORIGINAL_DISPLAY_NAME_W					PROP_TAG( PT_UNICODE,	0x3A13)
#define PR_ORIGINAL_DISPLAY_NAME_A					PROP_TAG( PT_STRING8,	0x3A13)
#define PR_ORIGINAL_SEARCH_KEY						PROP_TAG( PT_BINARY,	0x3A14)
#define PR_POSTAL_ADDRESS							PROP_TAG( PT_TSTRING,	0x3A15)
#define PR_POSTAL_ADDRESS_W							PROP_TAG( PT_UNICODE,	0x3A15)
#define PR_POSTAL_ADDRESS_A							PROP_TAG( PT_STRING8,	0x3A15)
#define PR_COMPANY_NAME								PROP_TAG( PT_TSTRING,	0x3A16)
#define PR_COMPANY_NAME_W							PROP_TAG( PT_UNICODE,	0x3A16)
#define PR_COMPANY_NAME_A							PROP_TAG( PT_STRING8,	0x3A16)
#define PR_TITLE									PROP_TAG( PT_TSTRING,	0x3A17)
#define PR_TITLE_W									PROP_TAG( PT_UNICODE,	0x3A17)
#define PR_TITLE_A									PROP_TAG( PT_STRING8,	0x3A17)
#define PR_DEPARTMENT_NAME							PROP_TAG( PT_TSTRING,	0x3A18)
#define PR_DEPARTMENT_NAME_W						PROP_TAG( PT_UNICODE,	0x3A18)
#define PR_DEPARTMENT_NAME_A						PROP_TAG( PT_STRING8,	0x3A18)
#define PR_OFFICE_LOCATION							PROP_TAG( PT_TSTRING,	0x3A19)
#define PR_OFFICE_LOCATION_W						PROP_TAG( PT_UNICODE,	0x3A19)
#define PR_OFFICE_LOCATION_A						PROP_TAG( PT_STRING8,	0x3A19)
#define PR_PRIMARY_TELEPHONE_NUMBER					PROP_TAG( PT_TSTRING,	0x3A1A)
#define PR_PRIMARY_TELEPHONE_NUMBER_W				PROP_TAG( PT_UNICODE,	0x3A1A)
#define PR_PRIMARY_TELEPHONE_NUMBER_A				PROP_TAG( PT_STRING8,	0x3A1A)
#define PR_BUSINESS2_TELEPHONE_NUMBER				PROP_TAG( PT_TSTRING,	0x3A1B)
#define PR_BUSINESS2_TELEPHONE_NUMBER_W				PROP_TAG( PT_UNICODE,	0x3A1B)
#define PR_BUSINESS2_TELEPHONE_NUMBER_A				PROP_TAG( PT_STRING8,	0x3A1B)
#define PR_OFFICE2_TELEPHONE_NUMBER					PR_BUSINESS2_TELEPHONE_NUMBER
#define PR_OFFICE2_TELEPHONE_NUMBER_W				PR_BUSINESS2_TELEPHONE_NUMBER_W
#define PR_OFFICE2_TELEPHONE_NUMBER_A				PR_BUSINESS2_TELEPHONE_NUMBER_A
#define PR_MOBILE_TELEPHONE_NUMBER					PROP_TAG( PT_TSTRING,	0x3A1C)
#define PR_MOBILE_TELEPHONE_NUMBER_W				PROP_TAG( PT_UNICODE,	0x3A1C)
#define PR_MOBILE_TELEPHONE_NUMBER_A				PROP_TAG( PT_STRING8,	0x3A1C)
#define PR_CELLULAR_TELEPHONE_NUMBER				PR_MOBILE_TELEPHONE_NUMBER
#define PR_CELLULAR_TELEPHONE_NUMBER_W				PR_MOBILE_TELEPHONE_NUMBER_W
#define PR_CELLULAR_TELEPHONE_NUMBER_A				PR_MOBILE_TELEPHONE_NUMBER_A
#define PR_RADIO_TELEPHONE_NUMBER					PROP_TAG( PT_TSTRING,	0x3A1D)
#define PR_RADIO_TELEPHONE_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A1D)
#define PR_RADIO_TELEPHONE_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A1D)
#define PR_CAR_TELEPHONE_NUMBER						PROP_TAG( PT_TSTRING,	0x3A1E)
#define PR_CAR_TELEPHONE_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A1E)
#define PR_CAR_TELEPHONE_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A1E)
#define PR_OTHER_TELEPHONE_NUMBER					PROP_TAG( PT_TSTRING,	0x3A1F)
#define PR_OTHER_TELEPHONE_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A1F)
#define PR_OTHER_TELEPHONE_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A1F)
#define PR_TRANSMITABLE_DISPLAY_NAME				PROP_TAG( PT_TSTRING,	0x3A20)
#define PR_TRANSMITABLE_DISPLAY_NAME_W				PROP_TAG( PT_UNICODE,	0x3A20)
#define PR_TRANSMITABLE_DISPLAY_NAME_A				PROP_TAG( PT_STRING8,	0x3A20)
#define PR_PAGER_TELEPHONE_NUMBER					PROP_TAG( PT_TSTRING,	0x3A21)
#define PR_PAGER_TELEPHONE_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A21)
#define PR_PAGER_TELEPHONE_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A21)
#define PR_BEEPER_TELEPHONE_NUMBER					PR_PAGER_TELEPHONE_NUMBER
#define PR_BEEPER_TELEPHONE_NUMBER_W				PR_PAGER_TELEPHONE_NUMBER_W
#define PR_BEEPER_TELEPHONE_NUMBER_A				PR_PAGER_TELEPHONE_NUMBER_A
#define PR_USER_CERTIFICATE							PROP_TAG( PT_BINARY,	0x3A22)
#define PR_PRIMARY_FAX_NUMBER						PROP_TAG( PT_TSTRING,	0x3A23)
#define PR_PRIMARY_FAX_NUMBER_W						PROP_TAG( PT_UNICODE,	0x3A23)
#define PR_PRIMARY_FAX_NUMBER_A						PROP_TAG( PT_STRING8,	0x3A23)
#define PR_BUSINESS_FAX_NUMBER						PROP_TAG( PT_TSTRING,	0x3A24)
#define PR_BUSINESS_FAX_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A24)
#define PR_BUSINESS_FAX_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A24)
#define PR_HOME_FAX_NUMBER							PROP_TAG( PT_TSTRING,	0x3A25)
#define PR_HOME_FAX_NUMBER_W						PROP_TAG( PT_UNICODE,	0x3A25)
#define PR_HOME_FAX_NUMBER_A						PROP_TAG( PT_STRING8,	0x3A25)
#define PR_COUNTRY									PROP_TAG( PT_TSTRING,	0x3A26)
#define PR_COUNTRY_W								PROP_TAG( PT_UNICODE,	0x3A26)
#define PR_COUNTRY_A								PROP_TAG( PT_STRING8,	0x3A26)
#define PR_BUSINESS_ADDRESS_COUNTRY					PR_COUNTRY
#define PR_BUSINESS_ADDRESS_COUNTRY_W				PR_COUNTRY_W
#define PR_BUSINESS_ADDRESS_COUNTRY_A				PR_COUNTRY_A

#define PR_LOCALITY									PROP_TAG( PT_TSTRING,	0x3A27)
#define PR_LOCALITY_W								PROP_TAG( PT_UNICODE,	0x3A27)
#define PR_LOCALITY_A								PROP_TAG( PT_STRING8,	0x3A27)
#define PR_BUSINESS_ADDRESS_CITY					PR_LOCALITY
#define PR_BUSINESS_ADDRESS_CITY_W					PR_LOCALITY_W
#define PR_BUSINESS_ADDRESS_CITY_A					PR_LOCALITY_A

#define PR_STATE_OR_PROVINCE						PROP_TAG( PT_TSTRING,	0x3A28)
#define PR_STATE_OR_PROVINCE_W						PROP_TAG( PT_UNICODE,	0x3A28)
#define PR_STATE_OR_PROVINCE_A						PROP_TAG( PT_STRING8,	0x3A28)
#define PR_BUSINESS_ADDRESS_STATE_OR_PROVINCE		PR_STATE_OR_PROVINCE
#define PR_BUSINESS_ADDRESS_STATE_OR_PROVINCE_W		PR_STATE_OR_PROVINCE_W
#define PR_BUSINESS_ADDRESS_STATE_OR_PROVINCE_A		PR_STATE_OR_PROVINCE_A

#define PR_STREET_ADDRESS							PROP_TAG( PT_TSTRING,	0x3A29)
#define PR_STREET_ADDRESS_W							PROP_TAG( PT_UNICODE,	0x3A29)
#define PR_STREET_ADDRESS_A							PROP_TAG( PT_STRING8,	0x3A29)
#define PR_BUSINESS_ADDRESS_STREET					PR_STREET_ADDRESS
#define PR_BUSINESS_ADDRESS_STREET_W				PR_STREET_ADDRESS_W
#define PR_BUSINESS_ADDRESS_STREET_A				PR_STREET_ADDRESS_A

#define PR_POSTAL_CODE								PROP_TAG( PT_TSTRING,	0x3A2A)
#define PR_POSTAL_CODE_W							PROP_TAG( PT_UNICODE,	0x3A2A)
#define PR_POSTAL_CODE_A							PROP_TAG( PT_STRING8,	0x3A2A)
#define PR_BUSINESS_ADDRESS_POSTAL_CODE				PR_POSTAL_CODE
#define PR_BUSINESS_ADDRESS_POSTAL_CODE_W			PR_POSTAL_CODE_W
#define PR_BUSINESS_ADDRESS_POSTAL_CODE_A			PR_POSTAL_CODE_A


#define PR_POST_OFFICE_BOX							PROP_TAG( PT_TSTRING,	0x3A2B)
#define PR_POST_OFFICE_BOX_W						PROP_TAG( PT_UNICODE,	0x3A2B)
#define PR_POST_OFFICE_BOX_A						PROP_TAG( PT_STRING8,	0x3A2B)
#define PR_BUSINESS_ADDRESS_POST_OFFICE_BOX			PR_POST_OFFICE_BOX
#define PR_BUSINESS_ADDRESS_POST_OFFICE_BOX_W		PR_POST_OFFICE_BOX_W
#define PR_BUSINESS_ADDRESS_POST_OFFICE_BOX_A		PR_POST_OFFICE_BOX_A


#define PR_TELEX_NUMBER								PROP_TAG( PT_TSTRING,	0x3A2C)
#define PR_TELEX_NUMBER_W							PROP_TAG( PT_UNICODE,	0x3A2C)
#define PR_TELEX_NUMBER_A							PROP_TAG( PT_STRING8,	0x3A2C)
#define PR_ISDN_NUMBER								PROP_TAG( PT_TSTRING,	0x3A2D)
#define PR_ISDN_NUMBER_W							PROP_TAG( PT_UNICODE,	0x3A2D)
#define PR_ISDN_NUMBER_A							PROP_TAG( PT_STRING8,	0x3A2D)
#define PR_ASSISTANT_TELEPHONE_NUMBER				PROP_TAG( PT_TSTRING,	0x3A2E)
#define PR_ASSISTANT_TELEPHONE_NUMBER_W				PROP_TAG( PT_UNICODE,	0x3A2E)
#define PR_ASSISTANT_TELEPHONE_NUMBER_A				PROP_TAG( PT_STRING8,	0x3A2E)
#define PR_HOME2_TELEPHONE_NUMBER					PROP_TAG( PT_TSTRING,	0x3A2F)
#define PR_HOME2_TELEPHONE_NUMBER_W					PROP_TAG( PT_UNICODE,	0x3A2F)
#define PR_HOME2_TELEPHONE_NUMBER_A					PROP_TAG( PT_STRING8,	0x3A2F)
#define PR_ASSISTANT								PROP_TAG( PT_TSTRING,	0x3A30)
#define PR_ASSISTANT_W								PROP_TAG( PT_UNICODE,	0x3A30)
#define PR_ASSISTANT_A								PROP_TAG( PT_STRING8,	0x3A30)
#define PR_SEND_RICH_INFO							PROP_TAG( PT_BOOLEAN,	0x3A40)

#define PR_WEDDING_ANNIVERSARY						PROP_TAG( PT_SYSTIME, 0x3A41)
#define PR_BIRTHDAY									PROP_TAG( PT_SYSTIME, 0x3A42)


#define PR_HOBBIES									PROP_TAG( PT_TSTRING, 0x3A43)
#define PR_HOBBIES_W								PROP_TAG( PT_UNICODE, 0x3A43)
#define PR_HOBBIES_A								PROP_TAG( PT_STRING8, 0x3A43)

#define PR_MIDDLE_NAME								PROP_TAG( PT_TSTRING, 0x3A44)
#define PR_MIDDLE_NAME_W							PROP_TAG( PT_UNICODE, 0x3A44)
#define PR_MIDDLE_NAME_A							PROP_TAG( PT_STRING8, 0x3A44)

#define PR_DISPLAY_NAME_PREFIX						PROP_TAG( PT_TSTRING, 0x3A45)
#define PR_DISPLAY_NAME_PREFIX_W					PROP_TAG( PT_UNICODE, 0x3A45)
#define PR_DISPLAY_NAME_PREFIX_A					PROP_TAG( PT_STRING8, 0x3A45)

#define PR_PROFESSION								PROP_TAG( PT_TSTRING, 0x3A46)
#define PR_PROFESSION_W								PROP_TAG( PT_UNICODE, 0x3A46)
#define PR_PROFESSION_A								PROP_TAG( PT_STRING8, 0x3A46)

#define PR_PREFERRED_BY_NAME						PROP_TAG( PT_TSTRING, 0x3A47)
#define PR_PREFERRED_BY_NAME_W						PROP_TAG( PT_UNICODE, 0x3A47)
#define PR_PREFERRED_BY_NAME_A						PROP_TAG( PT_STRING8, 0x3A47)

#define PR_SPOUSE_NAME								PROP_TAG( PT_TSTRING, 0x3A48)
#define PR_SPOUSE_NAME_W							PROP_TAG( PT_UNICODE, 0x3A48)
#define PR_SPOUSE_NAME_A							PROP_TAG( PT_STRING8, 0x3A48)

#define PR_COMPUTER_NETWORK_NAME					PROP_TAG( PT_TSTRING, 0x3A49)
#define PR_COMPUTER_NETWORK_NAME_W					PROP_TAG( PT_UNICODE, 0x3A49)
#define PR_COMPUTER_NETWORK_NAME_A					PROP_TAG( PT_STRING8, 0x3A49)

#define PR_CUSTOMER_ID								PROP_TAG( PT_TSTRING, 0x3A4A)
#define PR_CUSTOMER_ID_W							PROP_TAG( PT_UNICODE, 0x3A4A)
#define PR_CUSTOMER_ID_A							PROP_TAG( PT_STRING8, 0x3A4A)

#define PR_TTYTDD_PHONE_NUMBER						PROP_TAG( PT_TSTRING, 0x3A4B)
#define PR_TTYTDD_PHONE_NUMBER_W					PROP_TAG( PT_UNICODE, 0x3A4B)
#define PR_TTYTDD_PHONE_NUMBER_A					PROP_TAG( PT_STRING8, 0x3A4B)

#define PR_FTP_SITE									PROP_TAG( PT_TSTRING, 0x3A4C)
#define PR_FTP_SITE_W								PROP_TAG( PT_UNICODE, 0x3A4C)
#define PR_FTP_SITE_A								PROP_TAG( PT_STRING8, 0x3A4C)

#define PR_GENDER									PROP_TAG( PT_SHORT, 0x3A4D)

#define PR_MANAGER_NAME								PROP_TAG( PT_TSTRING, 0x3A4E)
#define PR_MANAGER_NAME_W							PROP_TAG( PT_UNICODE, 0x3A4E)
#define PR_MANAGER_NAME_A							PROP_TAG( PT_STRING8, 0x3A4E)

#define PR_NICKNAME									PROP_TAG( PT_TSTRING, 0x3A4F)
#define PR_NICKNAME_W								PROP_TAG( PT_UNICODE, 0x3A4F)
#define PR_NICKNAME_A								PROP_TAG( PT_STRING8, 0x3A4F)

#define PR_PERSONAL_HOME_PAGE						PROP_TAG( PT_TSTRING, 0x3A50)
#define PR_PERSONAL_HOME_PAGE_W						PROP_TAG( PT_UNICODE, 0x3A50)
#define PR_PERSONAL_HOME_PAGE_A						PROP_TAG( PT_STRING8, 0x3A50)


#define PR_BUSINESS_HOME_PAGE						PROP_TAG( PT_TSTRING, 0x3A51)
#define PR_BUSINESS_HOME_PAGE_W						PROP_TAG( PT_UNICODE, 0x3A51)
#define PR_BUSINESS_HOME_PAGE_A						PROP_TAG( PT_STRING8, 0x3A51)

#define PR_CONTACT_VERSION							PROP_TAG( PT_CLSID, 0x3A52)
#define PR_CONTACT_ENTRYIDS							PROP_TAG( PT_MV_BINARY, 0x3A53)

#define PR_CONTACT_ADDRTYPES						PROP_TAG( PT_MV_TSTRING, 0x3A54)
#define PR_CONTACT_ADDRTYPES_W						PROP_TAG( PT_MV_UNICODE, 0x3A54)
#define PR_CONTACT_ADDRTYPES_A						PROP_TAG( PT_MV_STRING8, 0x3A54)

#define PR_CONTACT_DEFAULT_ADDRESS_INDEX			PROP_TAG( PT_LONG, 0x3A55)

#define PR_CONTACT_EMAIL_ADDRESSES					PROP_TAG( PT_MV_TSTRING, 0x3A56)
#define PR_CONTACT_EMAIL_ADDRESSES_W				PROP_TAG( PT_MV_UNICODE, 0x3A56)
#define PR_CONTACT_EMAIL_ADDRESSES_A				PROP_TAG( PT_MV_STRING8, 0x3A56)


#define PR_COMPANY_MAIN_PHONE_NUMBER				PROP_TAG( PT_TSTRING, 0x3A57)
#define PR_COMPANY_MAIN_PHONE_NUMBER_W				PROP_TAG( PT_UNICODE, 0x3A57)
#define PR_COMPANY_MAIN_PHONE_NUMBER_A				PROP_TAG( PT_STRING8, 0x3A57)

#define PR_CHILDRENS_NAMES							PROP_TAG( PT_MV_TSTRING, 0x3A58)
#define PR_CHILDRENS_NAMES_W						PROP_TAG( PT_MV_UNICODE, 0x3A58)
#define PR_CHILDRENS_NAMES_A						PROP_TAG( PT_MV_STRING8, 0x3A58)



#define PR_HOME_ADDRESS_CITY						PROP_TAG( PT_TSTRING, 0x3A59)
#define PR_HOME_ADDRESS_CITY_W						PROP_TAG( PT_UNICODE, 0x3A59)
#define PR_HOME_ADDRESS_CITY_A						PROP_TAG( PT_STRING8, 0x3A59)

#define PR_HOME_ADDRESS_COUNTRY						PROP_TAG( PT_TSTRING, 0x3A5A)
#define PR_HOME_ADDRESS_COUNTRY_W					PROP_TAG( PT_UNICODE, 0x3A5A)
#define PR_HOME_ADDRESS_COUNTRY_A					PROP_TAG( PT_STRING8, 0x3A5A)

#define PR_HOME_ADDRESS_POSTAL_CODE					PROP_TAG( PT_TSTRING, 0x3A5B)
#define PR_HOME_ADDRESS_POSTAL_CODE_W				PROP_TAG( PT_UNICODE, 0x3A5B)
#define PR_HOME_ADDRESS_POSTAL_CODE_A				PROP_TAG( PT_STRING8, 0x3A5B)

#define PR_HOME_ADDRESS_STATE_OR_PROVINCE			PROP_TAG( PT_TSTRING, 0x3A5C)
#define PR_HOME_ADDRESS_STATE_OR_PROVINCE_W			PROP_TAG( PT_UNICODE, 0x3A5C)
#define PR_HOME_ADDRESS_STATE_OR_PROVINCE_A			PROP_TAG( PT_STRING8, 0x3A5C)

#define PR_HOME_ADDRESS_STREET						PROP_TAG( PT_TSTRING, 0x3A5D)
#define PR_HOME_ADDRESS_STREET_W					PROP_TAG( PT_UNICODE, 0x3A5D)
#define PR_HOME_ADDRESS_STREET_A					PROP_TAG( PT_STRING8, 0x3A5D)

#define PR_HOME_ADDRESS_POST_OFFICE_BOX				PROP_TAG( PT_TSTRING, 0x3A5E)
#define PR_HOME_ADDRESS_POST_OFFICE_BOX_W			PROP_TAG( PT_UNICODE, 0x3A5E)
#define PR_HOME_ADDRESS_POST_OFFICE_BOX_A			PROP_TAG( PT_STRING8, 0x3A5E)

#define PR_OTHER_ADDRESS_CITY						PROP_TAG( PT_TSTRING, 0x3A5F)
#define PR_OTHER_ADDRESS_CITY_W						PROP_TAG( PT_UNICODE, 0x3A5F)
#define PR_OTHER_ADDRESS_CITY_A						PROP_TAG( PT_STRING8, 0x3A5F)

#define PR_OTHER_ADDRESS_COUNTRY					PROP_TAG( PT_TSTRING, 0x3A60)
#define PR_OTHER_ADDRESS_COUNTRY_W					PROP_TAG( PT_UNICODE, 0x3A60)
#define PR_OTHER_ADDRESS_COUNTRY_A					PROP_TAG( PT_STRING8, 0x3A60)

#define PR_OTHER_ADDRESS_POSTAL_CODE				PROP_TAG( PT_TSTRING, 0x3A61)
#define PR_OTHER_ADDRESS_POSTAL_CODE_W				PROP_TAG( PT_UNICODE, 0x3A61)
#define PR_OTHER_ADDRESS_POSTAL_CODE_A				PROP_TAG( PT_STRING8, 0x3A61)

#define PR_OTHER_ADDRESS_STATE_OR_PROVINCE			PROP_TAG( PT_TSTRING, 0x3A62)
#define PR_OTHER_ADDRESS_STATE_OR_PROVINCE_W		PROP_TAG( PT_UNICODE, 0x3A62)
#define PR_OTHER_ADDRESS_STATE_OR_PROVINCE_A		PROP_TAG( PT_STRING8, 0x3A62)

#define PR_OTHER_ADDRESS_STREET						PROP_TAG( PT_TSTRING, 0x3A63)
#define PR_OTHER_ADDRESS_STREET_W					PROP_TAG( PT_UNICODE, 0x3A63)
#define PR_OTHER_ADDRESS_STREET_A					PROP_TAG( PT_STRING8, 0x3A63)

#define PR_OTHER_ADDRESS_POST_OFFICE_BOX			PROP_TAG( PT_TSTRING, 0x3A64)
#define PR_OTHER_ADDRESS_POST_OFFICE_BOX_W			PROP_TAG( PT_UNICODE, 0x3A64)
#define PR_OTHER_ADDRESS_POST_OFFICE_BOX_A			PROP_TAG( PT_STRING8, 0x3A64)


/*
 *	Profile section properties
 */

#define PR_STORE_PROVIDERS							PROP_TAG( PT_BINARY,	0x3D00)
#define PR_AB_PROVIDERS								PROP_TAG( PT_BINARY,	0x3D01)
#define PR_TRANSPORT_PROVIDERS						PROP_TAG( PT_BINARY,	0x3D02)

#define PR_DEFAULT_PROFILE							PROP_TAG( PT_BOOLEAN,	0x3D04)
#define PR_AB_SEARCH_PATH							PROP_TAG( PT_MV_BINARY,	0x3D05)
#define PR_AB_DEFAULT_DIR							PROP_TAG( PT_BINARY,	0x3D06)
#define PR_AB_DEFAULT_PAB							PROP_TAG( PT_BINARY,	0x3D07)

#define PR_FILTERING_HOOKS                          PROP_TAG( PT_BINARY,    0x3D08)
#define PR_SERVICE_NAME								PROP_TAG( PT_TSTRING,	0x3D09)
#define PR_SERVICE_NAME_W							PROP_TAG( PT_UNICODE,	0x3D09)
#define PR_SERVICE_NAME_A							PROP_TAG( PT_STRING8,	0x3D09)
#define PR_SERVICE_DLL_NAME							PROP_TAG( PT_TSTRING,	0x3D0A)
#define PR_SERVICE_DLL_NAME_W						PROP_TAG( PT_UNICODE,	0x3D0A)
#define PR_SERVICE_DLL_NAME_A						PROP_TAG( PT_STRING8,	0x3D0A)
#define PR_SERVICE_ENTRY_NAME						PROP_TAG( PT_STRING8,	0x3D0B)
#define PR_SERVICE_UID								PROP_TAG( PT_BINARY,	0x3D0C)
#define PR_SERVICE_EXTRA_UIDS						PROP_TAG( PT_BINARY,	0x3D0D)
#define PR_SERVICES									PROP_TAG( PT_BINARY,	0x3D0E)
#define PR_SERVICE_SUPPORT_FILES   					PROP_TAG( PT_MV_TSTRING, 0x3D0F)
#define PR_SERVICE_SUPPORT_FILES_W					PROP_TAG( PT_MV_UNICODE, 0x3D0F)
#define PR_SERVICE_SUPPORT_FILES_A					PROP_TAG( PT_MV_STRING8, 0x3D0F)
#define PR_SERVICE_DELETE_FILES   					PROP_TAG( PT_MV_TSTRING, 0x3D10)
#define PR_SERVICE_DELETE_FILES_W					PROP_TAG( PT_MV_UNICODE, 0x3D10)
#define PR_SERVICE_DELETE_FILES_A					PROP_TAG( PT_MV_STRING8, 0x3D10)
#define PR_AB_SEARCH_PATH_UPDATE   					PROP_TAG( PT_BINARY, 	 0x3D11)
#define PR_PROFILE_NAME								PROP_TAG( PT_TSTRING,	0x3D12)
#define PR_PROFILE_NAME_A							PROP_TAG( PT_STRING8,	0x3D12)
#define PR_PROFILE_NAME_W							PROP_TAG( PT_UNICODE,	0x3D12)

/*
 *	Status object properties
 */

#define PR_IDENTITY_DISPLAY							PROP_TAG( PT_TSTRING,	0x3E00)
#define PR_IDENTITY_DISPLAY_W						PROP_TAG( PT_UNICODE,	0x3E00)
#define PR_IDENTITY_DISPLAY_A						PROP_TAG( PT_STRING8,	0x3E00)
#define PR_IDENTITY_ENTRYID							PROP_TAG( PT_BINARY,	0x3E01)
#define PR_RESOURCE_METHODS							PROP_TAG( PT_LONG,		0x3E02)
#define PR_RESOURCE_TYPE							PROP_TAG( PT_LONG,		0x3E03)
#define PR_STATUS_CODE								PROP_TAG( PT_LONG,		0x3E04)
#define PR_IDENTITY_SEARCH_KEY						PROP_TAG( PT_BINARY,	0x3E05)
#define PR_OWN_STORE_ENTRYID						PROP_TAG( PT_BINARY,	0x3E06)
#define PR_RESOURCE_PATH							PROP_TAG( PT_TSTRING,   0x3E07)
#define PR_RESOURCE_PATH_W							PROP_TAG( PT_UNICODE,   0x3E07)
#define PR_RESOURCE_PATH_A							PROP_TAG( PT_STRING8,   0x3E07)
#define PR_STATUS_STRING							PROP_TAG( PT_TSTRING,	0x3E08)
#define PR_STATUS_STRING_W							PROP_TAG( PT_UNICODE,	0x3E08)
#define PR_STATUS_STRING_A							PROP_TAG( PT_STRING8,	0x3E08)
#define PR_X400_DEFERRED_DELIVERY_CANCEL			PROP_TAG( PT_BOOLEAN,	0x3E09)
#define PR_HEADER_FOLDER_ENTRYID					PROP_TAG( PT_BINARY,	0x3E0A)
#define PR_REMOTE_PROGRESS							PROP_TAG( PT_LONG,		0x3E0B)
#define PR_REMOTE_PROGRESS_TEXT						PROP_TAG( PT_TSTRING,	0x3E0C)
#define PR_REMOTE_PROGRESS_TEXT_W					PROP_TAG( PT_UNICODE,	0x3E0C)
#define PR_REMOTE_PROGRESS_TEXT_A					PROP_TAG( PT_STRING8,	0x3E0C)
#define PR_REMOTE_VALIDATE_OK						PROP_TAG( PT_BOOLEAN,	0x3E0D)

/*
 * Display table properties
 */

#define PR_CONTROL_FLAGS							PROP_TAG( PT_LONG,		0x3F00)
#define PR_CONTROL_STRUCTURE						PROP_TAG( PT_BINARY,	0x3F01)
#define PR_CONTROL_TYPE								PROP_TAG( PT_LONG,		0x3F02)
#define PR_DELTAX									PROP_TAG( PT_LONG,		0x3F03)
#define PR_DELTAY									PROP_TAG( PT_LONG,		0x3F04)
#define PR_XPOS										PROP_TAG( PT_LONG,		0x3F05)
#define PR_YPOS										PROP_TAG( PT_LONG,		0x3F06)
#define PR_CONTROL_ID								PROP_TAG( PT_BINARY,	0x3F07)
#define PR_INITIAL_DETAILS_PANE						PROP_TAG( PT_LONG,		0x3F08)

}

procedure TIdCoderTNEF.DoLog(const AMsg: String; const AAppendSize: Boolean = True);
begin
  if AAppendSize then begin
    FLog := FLog + IntToStr(FData.Size - FData.Position) + ':' + AMsg + EOL;  {Do not localize}
  end else begin
    FLog := FLog + AMsg + EOL;
  end;
end;

procedure TIdCoderTNEF.DoLogFmt(const AFormat: string; const Args: array of const; AAppendSize: Boolean = True);
begin
  DoLog(IndyFormat(AFormat, Args), AAppendSize);
end;

function TIdCoderTNEF.GetStringForMapiType(AType: Word): string;
begin
  case AType of
    IdTNEF_PT_UNSPECIFIED: begin
      Result := 'Unspecified';  {Do not localize}
    end;
    IdTNEF_PT_NULL: begin
      Result := 'Null';  {Do not localize}
    end;
    IdTNEF_PT_I2: begin
      Result := 'Short';  {Do not localize}
    end;
    IdTNEF_PT_LONG: begin
      Result := 'Long';  {Do not localize}
    end;
    IdTNEF_PT_R4: begin
      Result := 'Float';  {Do not localize}
    end;
    IdTNEF_PT_DOUBLE: begin
      Result := 'Double';  {Do not localize}
    end;
    IdTNEF_PT_CURRENCY: begin
      Result := 'Currency';  {Do not localize}
    end;
    IdTNEF_PT_APPTIME: begin
      Result := 'Application time';  {Do not localize}
    end;
    IdTNEF_PT_ERROR: begin
      Result := 'Error code';  {Do not localize}
    end;
    IdTNEF_PT_BOOLEAN: begin
      Result := 'Boolean';  {Do not localize}
    end;
    IdTNEF_PT_OBJECT: begin
      Result := 'Object';  {Do not localize}
    end;
    IdTNEF_PT_I8: begin
      Result := '64-bit integer';  {Do not localize}
    end;
    IdTNEF_PT_STRING8: begin
      Result := 'String8';  {Do not localize}
    end;
    IdTNEF_PT_UNICODE: begin
      Result := 'Unicode';  {Do not localize}
    end;
    IdTNEF_PT_SYSTIME: begin
      Result := 'SysTime';  {Do not localize}
    end;
    IdTNEF_PT_CLSID: begin
      Result := 'ClsId';  {Do not localize}
    end;
    IdTNEF_PT_BINARY: begin
      Result := 'Binary';  {Do not localize}
    end;
  else
    Result := 'Unknown';  {Do not localize}
  end;
end;

function TIdCoderTNEF.GetStringForType(AType: Word): string;
begin
  case AType of
    IdTNEFAtpTriples: begin
      Result := 'Triples';  {Do not localize}
    end;
    IdTNEFAtpString: begin
      Result := 'String';  {Do not localize}
    end;
    IdTNEFAtpText: begin
      Result := 'Text';  {Do not localize}
    end;
    IdTNEFAtpDate: begin
      Result := 'Date';  {Do not localize}
    end;
    IdTNEFAtpShort: begin
      Result := 'Short';  {Do not localize}
    end;
    IdTNEFAtpLong: begin
      Result := 'Long';  {Do not localize}
    end;
    IdTNEFAtpByte: begin
      Result := 'Byte';  {Do not localize}
    end;
    IdTNEFAtpWord: begin
      Result := 'Word';  {Do not localize}
    end;
    IdTNEFAtpDWord: begin
      Result := 'DWord';  {Do not localize}
    end;
    IdTNEFAtpMax: begin
      Result := 'Max';  {Do not localize}
    end;
  else
    Result := 'Unknown';  {Do not localize}
  end;
end;

function TIdCoderTNEF.GetStringForAttribute(AAttribute: Word): string;
begin
  case AAttribute of
    IdTNEFattNull: begin
      Result := 'Null';  {Do not localize}
    end;
    IdTNEFattFrom: begin
      Result := 'From';  {Do not localize}
    end;
    IdTNEFattSubject: begin
      Result := 'Subject';  {Do not localize}
    end;
    IdTNEFattDateSent: begin
      Result := 'DateSent';  {Do not localize}
    end;
    IdTNEFattDateRecd: begin
      Result := 'DateRecd';  {Do not localize}
    end;
    IdTNEFattMessageStatus: begin
      Result := 'MessageStatus';  {Do not localize}
    end;
    IdTNEFattMessageClass: begin
      Result := 'MessageClass';  {Do not localize}
    end;
    IdTNEFattMessageID: begin
      Result := 'MessageID';  {Do not localize}
    end;
    IdTNEFattParentID: begin
      Result := 'ParentID';  {Do not localize}
    end;
    IdTNEFattConversationID: begin
      Result := 'ConversationID';  {Do not localize}
    end;
    IdTNEFattPriority: begin
      Result := 'Priority';  {Do not localize}
    end;
    IdTNEFattAttachData: begin
      Result := 'AttachData';  {Do not localize}
    end;
    IdTNEFattAttachTitle: begin
      Result := 'AttachTitle';  {Do not localize}
    end;
    IdTNEFattAttachMetaFile: begin
      Result := 'AttachMetaFile';  {Do not localize}
    end;
    IdTNEFattAttachCreateDate: begin
      Result := 'AttachCreateDate';  {Do not localize}
    end;
    IdTNEFattAttachModifyDate: begin
      Result := 'AttachModifyDate';  {Do not localize}
    end;
    IdTNEFattDateModified: begin
      Result := 'DateModified';  {Do not localize}
    end;
    IdTNEFattAttachTransportFilename: begin
      Result := 'AttachTransportFilename';  {Do not localize}
    end;
    IdTNEFattAttachRenddata: begin
      Result := 'AttachRenddata';  {Do not localize}
    end;
    IdTNEFattMAPIProps: begin
      Result := 'MAPIProps';  {Do not localize}
    end;
    IdTNEFattRecipTable: begin
      Result := 'RecipTable';  {Do not localize}
    end;
    IdTNEFattAttachment: begin
      Result := 'Null';  {Do not localize}
    end;
    IdTNEFattTnefVersion: begin
      Result := 'TnefVersion';  {Do not localize}
    end;
    IdTNEFattOemCodepage: begin
      Result := 'OemCodepage';  {Do not localize}
    end;
    IdTNEFattOriginalMessageClass: begin
      Result := 'OriginalMessageClass';  {Do not localize}
    end;
    //IdTNEFattOwner: begin
    //  Result := 'Owner';  {Do not localize}
    //end;
    IdTNEFattSentFor: begin
      Result := 'SentFor';  {Do not localize}
    end;
    IdTNEFattDelegate: begin
      Result := 'Delegate';  {Do not localize}
    end;
    //IdTNEFattDateStart: begin
    //  Result := 'DateStart';  {Do not localize}
    //end;
    IdTNEFattDateEnd: begin
      Result := 'DateEnd';  {Do not localize}
    end;
    IdTNEFattAidOwner: begin
      Result := 'OwnerAID';  {Do not localize}
    end;
    IdTNEFattRequestRes: begin
      Result := 'ResponseRequested';  {Do not localize}
    end;
  else
    Result := 'Unknown';  {Do not localize}
  end;
end;

class function TIdCoderTNEF.IsFilenameTnef(const AFilename: string): Boolean;
begin
  Result := IdCoderTNEF.IsFilenameTnef(AFilename);
end;

function IsFilenameTnef(const AFilename: string): Boolean;
begin
  if TextIsSame(AFilename, 'winmail.dat') then begin
    Result := True;
  end
  else if TextStartsWith(AFilename, 'att') and TextEndsWith(AFilename, '.dat') then begin
    Result := IndyStrToInt(Copy(AFilename, 4, Length(AFilename)-7), -1) > -1;
  end else begin
    Result := False;
  end;
end;

function TIdCoderTNEF.GetMultipleUnicodeOrString8String(AType: Word): TIdUnicodeString;
var
  LIndex, LCount: LongWord;
begin
  //Usually this will only contain one string, but if there are more, return
  //them as a single string concatenated with semicolons.
  LCount := GetLongWord;
  if FDoLogging then begin
    DoLogFmt('     Found %d %s String(s):', [LCount, GetStringForMapiType(AType)]);  {Do not localize}
  end;
  if LCount = 0 then begin  //Very unlikely, just paranoia
    Result := '';
    Exit;
  end;
  Result := GetUnicodeOrString8String(AType);
  for LIndex := 2 to LCount do begin
    Result := ';' + GetUnicodeOrString8String(AType);    {Do not localize}
  end;
end;

function TIdCoderTNEF.GetUnicodeOrString8String(AType: Word): TIdUnicodeString;
var
  LLength: LongWord;
  LBuf: TIdBytes;
begin
  Result := '';
  LLength := GetLongWord;
  if LLength = 0 then begin
    Exit;
  end;
  //Note the length count includes a terminating null.
  case AType of
    IdTNEF_PT_UNICODE: begin
      LBuf := GetBytes(LLength);
      SetString(Result, PWideChar(LBuf), (LLength div SizeOf(TIdWideChar))-1);
    end;
    IdTNEF_PT_STRING8: begin
      LBuf := GetBytes(LLength);
      // TODO: use the value from the attOemCodepage attribute to decode the data:
      Result := {IndyTextEncoding(attOemCodepage)}IndyTextEncoding_8Bit.GetString(LBuf, 0, Length(LBuf)-1);
    end;
    else begin
      Skip(LLength);
    end;
  end;
  if FDoLogging then begin
    DoLog('     Found string value: ' + Result);  {Do not localize}
  end;
  //Note the strings are padded to 4-byte boundaries...
  if (LLength mod 4) > 0 then begin
    Skip(4 - (LLength mod 4));
  end;
end;

function TIdCoderTNEF.PadWithZeroes(const AStr: string; ACount: integer): string;
begin
  if Length(AStr) < ACount then begin
    Result := StringOfChar('0', ACount-Length(AStr)) + AStr;
  end else begin
    Result := AStr;
  end;
end;

function TIdCoderTNEF.GetByteAsChar(AByte: Byte): Char;
begin
  //Return a displayable char or '.' if not displayable.
  if (Ord(AByte) > 31) and (Ord(AByte) < 127) then begin
    Result := Chr(AByte);
  end else begin
    Result := '.';  {Do not localize}
  end;
end;

function TIdCoderTNEF.GetByteAsHexString(AByte: Byte): string;
var
  LsTemp: string;
begin
  LsTemp := IndyFormat('%x', [AByte]);    {Do not localize}
  Result := PadWithZeroes(LsTemp, 2);
end;

function TIdCoderTNEF.GetByteAsHexString: string;
var
  LnTemp: Byte;
  LsTemp: string;
begin
  LnTemp := GetByte;
  LsTemp := IndyFormat('%x', [LnTemp]);  {Do not localize}
  Result := PadWithZeroes(LsTemp, 2);
end;

function TIdCoderTNEF.GetBytesAsHexString(ACount: integer): string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to ACount-1 do begin
    Result := Result + GetByteAsHexString + ' ';  {Do not localize}
  end;
end;

function TIdCoderTNEF.GetByte: Byte;
var
  LTemp: TIdBytes;
begin
  LTemp := GetBytes(SizeOf(Byte));
  Result := LTemp[0];
end;

function TIdCoderTNEF.GetBytes(ALength: Integer; APeek: Boolean = False): TIdBytes;
var
  LPos: TIdStreamSize;
begin
  Result := nil;
  CheckForEof(ALength);
  LPos := FData.Position;
  try
    //Note the length count includes a terminating null.
    ReadTIdBytesFromStream(FData, Result, ALength);
  finally
    if APeek then begin
      FData.Position := LPos;
    end;
  end;
end;

function TIdCoderTNEF.GetWord: Word;
var
  LTemp: TIdBytes;
begin
  LTemp := GetBytes(SizeOf(Word));
  Result := PWord(LTemp)^;
end;

function TIdCoderTNEF.GetLongWord: LongWord;
var
  LTemp: TIdBytes;
begin
  LTemp := GetBytes(SizeOf(LongWord));
  Result := PLongWord(LTemp)^;
end;

function TIdCoderTNEF.GetInt64: Int64;
var
  LTemp: TIdBytes;
begin
  LTemp := GetBytes(SizeOf(Int64));
  Result := PInt64(@LTemp[0])^;
end;

function TIdCoderTNEF.GetString(ALength: Word): string;
begin
  if ALength > 0 then begin
    Result := ReadStringFromStream(FData, ALength-1, IndyTextEncoding_8Bit{$IFDEF STRING_IS_ANSI}, IndyTextEncoding_8Bit{$ENDIF});
    Skip(1) //Skip terminating null
  end else begin
    Result := '';
  end;
end;

function  TIdCoderTNEF.GetDate(ALength: Word): TDateTime;
var
  LYear, LMonth, LDay, LHour, LMinute, LSecond: Word;
begin
  LYear   := GetWord;
  LMonth  := GetWord;
  LDay    := GetWord;
  LHour   := GetWord;
  LMinute := GetWord;
  LSecond := GetWord;
  Skip(SizeOf(Word));  //Day-of-week
  Result := EncodeDateTime(LYear, LMonth, LDay, LHour, LMinute, LSecond, 0);
end;

procedure TIdCoderTNEF.Skip(ACount: integer);
begin
  CheckForEof(ACount);
  FData.Seek(ACount, soFromCurrent);
end;

procedure TIdCoderTNEF.Checksum(ANumBytesToCheck: integer);
var
  LChecksum: Word;
  i: integer;
  LBytes: TIdBytes;
  LTNEFChecksum: Word;
begin
  //Do a checksum on ANumBytesToCheck bytes from the current position.
  //Compare to the recorded TNEF value in the word after these bytes.
  //DONT move our stream pointer forward.
  LBytes := GetBytes(ANumBytesToCheck + SizeOf(Word), True);
  LChecksum := 0;
  for i := 0 to ANumBytesToCheck-1 do begin
    Inc(LChecksum, LBytes[i]);
  end;
  LTNEFChecksum := PWord(@LBytes[ANumBytesToCheck])^;
  if LChecksum <> LTNEFChecksum then begin
    raise EIdTnefChecksumFailure.Create('Checksum failure - TNEF is corrupt or truncated');  {Do not localize}
  end;
end;

procedure TIdCoderTNEF.CheckForEof(ANumBytesRequested: integer);
begin
  //See if you have enough bytes left to satisfy the request for nNumBytesRequested...
  if (FData.Size - FData.Position) < TIdStreamSize(ANumBytesRequested) then begin
    raise EIdTnefRanOutOfBytes.Create('Hit end of file prematurely - TNEF is corrupt or truncated');  {Do not localize}
  end;
end;

procedure TIdCoderTNEF.Parse(const AIn: string; AMsg: TIdMessage; ALog: Boolean = False);
var
  LIn: TMemoryStream;
begin
  LIn := TMemoryStream.Create;
  try
    WriteStringToStream(LIn, AIn, IndyTextEncoding_8Bit{$IFDEF STRING_IS_ANSI}, IndyTextEncoding_8Bit{$ENDIF});
    LIn.Position := 0;
    Parse(LIn, AMsg, ALog);
  finally
    LIn.Free;
  end;
end;

procedure TIdCoderTNEF.Parse(const AIn: TIdAttachment; AMsg: TIdMessage; ALog: Boolean = False);
var
  LTempStream: TStream;
begin
  LTempStream := AIn.OpenLoadStream;
  try
    Parse(LTempStream, AMsg, ALog);
  finally
    AIn.CloseLoadStream;
  end;
end;

procedure TIdCoderTNEF.Parse(const AIn: TIdBytes; AMsg: TIdMessage; ALog: Boolean = False);
var
  LIn: TMemoryStream;
begin
  LIn := TMemoryStream.Create;
  try
    WriteTIdBytesToStream(LIn, AIn);
    LIn.Position := 0;
    Parse(LIn, AMsg, ALog);
  finally
    LIn.Free;
  end;
end;

procedure TIdCoderTNEF.ParseMessageBlock;
var
  LType, LAttribute: Word;
begin
  LAttribute := GetWord;
  LType := GetWord;
  ParseAttribute(LAttribute, LType);
end;

procedure TIdCoderTNEF.IsCurrentAttachmentValid;
begin
  if FCurrentAttachment = nil then begin
    raise EIdTnefCurrentAttachmentInvalid.Create('Attempt to access invalid attachment - invalid TNEF missing attAttachRenddata attribute at start of attachment?');  {Do not localize}
  end;
end;

function  TIdCoderTNEF.GetAttributeString(const AAttributeName: string; AType: Word): string;
var
  LLength: LongWord;
begin
  LLength := GetLongWord;
  if FDoLogging then begin
    DoLogFmt('   ParseAttachmentBlock found %s type, length: %d', [AAttributeName, LLength]);  {Do not localize}
  end;
  if AType <> IdTNEFAtpString then begin
    raise EIdTnefAttributeUnexpectedType.Create(AAttributeName + ' not a String');  {Do not localize}
  end;
  Checksum(LLength);
  Result := GetString(LLength);
  Skip(2);  //Checksum
end;

procedure TIdCoderTNEF.ParseAttachmentBlock;
var
  LType, LAttribute: Word;
  LLength: LongWord;
  LDestStream: TStream;
begin
  LAttribute := GetWord;
  LType := GetWord;
  if FDoLogging then begin
    DoLogFmt('   ParseAttachmentBlock passed a %s type %s', [GetStringForAttribute(LAttribute), GetStringForType(LType)]);  {Do not localize}
  end;
  case LAttribute of
    IdTNEFattAttachRenddata: begin
      //Per Microsoft, you get this first, at the start of every attachment,
      //create a new attachment when you encounter this.
      LLength := GetLongWord;
      if FDoLogging then begin
        DoLog('   ParseAttachmentBlock found IdTNETattAttachRenddata type, length: ' + IntToStr(LLength));  {Do not localize}
      end;
      Checksum(LLength);
      Skip(LLength);
      Skip(2);  //Checksum
      if FDoLogging then begin
        DoLog('   Adding attachment to decoded message.');  {Do not localize}
      end;
      FMsg.DoCreateAttachment(nil, FCurrentAttachment);
      FCurrentAttachment.ParentPart := -1;
    end;
    IdTNEFattAttachTitle: begin
      //This is the filename of the attachment, set the already-created attachment's
      //filename to this.
      IsCurrentAttachmentValid;
      FCurrentAttachment.FileName := GetAttributeString('IdTNEFattAttachTitle', LType);  {Do not localize}
      if FDoLogging then begin
        DoLog('   ParseAttachmentBlock parsed attachment filename: ' + FCurrentAttachment.FileName);  {Do not localize}
      end;
    end;
    IdTNEFattAttachData: begin
      //This is the attachment file contents, set it for the already-created
      //attachment.
      LLength := GetLongWord;
      if FDoLogging then begin
        DoLog('   ParseAttachmentBlock found IdTNEFattAttachData type, length: ' + IntToStr(LLength));  {Do not localize}
      end;
      if LType <> IdTNEFAtpByte then begin
        raise EIdTnefAttributeUnexpectedType.Create('TNEF AttachmentData not a Byte');  {Do not localize}
      end;
      Checksum(LLength);
      if LLength > 0 then begin
        IsCurrentAttachmentValid;
        LDestStream := FCurrentAttachment.PrepareTempStream;
        try
          LDestStream.CopyFrom(FData, LLength);
        finally
          FCurrentAttachment.FinishTempStream;
        end;
      end;
      if FDoLogging then begin
        DoLogFmt('   ParseAttachmentBlock copied %d bytes to attachment.', [LLength]);  {Do not localize}
      end;
      Skip(2);  //Checksum
      end;
    else
      if FDoLogging then begin
        DoLogFmt('   ParseAttachmentBlock found unknown attribute: %d, type: %d, passing to ParseAttribute.', [LAttribute, LType]);  {Do not localize}
      end;
      ParseAttribute(LAttribute, LType);
  end;
end;

function TIdCoderTNEF.GetMapiBoolean(AType: Word; const AText: string): Smallint;
begin
  if AType <> IdTNEF_PT_BOOLEAN then begin
    raise EIdTnefUnexpectedType.CreateFmt('Expected Boolean for %s', [AText]);  {Do not localize}
  end;
  Result := GetWord;
  Skip(SizeOf(Word));  //Skip next two bytes (padded to 4 bytes)
  if FDoLogging then begin
    DoLogFmt('     ParseMapiProp found %s Boolean, value: %d', [AText, Result]);  {Do not localize}
  end;
end;

function TIdCoderTNEF.GetMapiLong(AType: Word; const AText: string): Longint;
begin
  if AType <> IdTNEF_PT_LONG then begin
    raise EIdTnefUnexpectedType.CreateFmt('Expected Long for %s', [AText]);  {Do not localize}
  end;
  Result := GetLongWord;
  if FDoLogging then begin
    DoLogFmt('     ParseMapiProp found %s Long, value: %d', [AText, Result]);  {Do not localize}
  end;
end;

function  TIdCoderTNEF.GetMapiSysTime(AType: Word; const AText: string): TDateTime;
var
  LHour, LMinute, LSecond, LMilliSecond: Word;
  LVal: Int64;
  LTime: Double;
begin
  //MAPI's SysTime is a 64-bit integer holding the number of 100ns intervals
  //since 1st Jan 1601.
  if AType <> IdTNEF_PT_SYSTIME then begin
    raise EIdTnefUnexpectedType.CreateFmt('Expected SysTime for %s', [AText]);  {Do not localize}
  end;
  LVal := GetInt64;
  //I am sure there is a better way of doing the following...
  LVal := LVal div 10;  //Ditch the 100ns
  LVal := LVal div 1000;  //Ditch the ms
  LMilliSecond := LVal mod 1000;
  LVal := LVal div 1000;
  LSecond := LVal mod 60;
  LVal := LVal div 60;
  LMinute := LVal mod 60;
  LVal := LVal div 60;
  LHour := LVal mod 24;
  LVal := LVal div 24;
  //LVal is now the days since 1/1/1601.  Subtract Delphi's 300-year offset...
  Result := LVal;
  Result := Result + EncodeDate(1601, 1, 1);  {Do not localize}
  //Is the hour out by 1 or is it WET vs GMT time?  Or is it GetDate that is the hour out?
  LTime := ((((((LHour*60)+LMinute)*60)+LSecond)*1000)+LMilliSecond)/(24*60*60*1000);
  Result := Result + LTime;
  if FDoLogging then begin
    DoLogFmt('     ParseMapiProp found %s SysTime, value: %s', [AText, DateTimeToStr(Result)]);  {Do not localize}
  end;
end;

function TIdCoderTNEF.GetMapiStrings(AType: Word; const AText: string): string;
begin
  //May be PT_UNICODE or PT_STRING8 (PT_TSTRING will be aliased to one of these)...
  if (AType <> IdTNEF_PT_UNICODE) and (AType <> IdTNEF_PT_STRING8) then begin
    raise EIdTnefUnexpectedType.CreateFmt('Expected Unicode or String8 for %s', [AText]);  {Do not localize}
  end;
  Result := GetMultipleUnicodeOrString8String(AType);
  if FDoLogging then begin
    DoLogFmt('     ParseMapiProp found %s String, value: %s', [AText, Result]);  {Do not localize}
  end;
end;

{ GetMapiObject was previously needed, may be needed later in development...
function TIdCoderTNEF.GetMapiObject(AType: Word; const AText: string): TIdBytes;
begin
  if AType <> IdTNEF_PT_OBJECT then begin
    raise EIdTnefUnexpectedType.CreateFmt('Expected Object for %s', [AText]);  {Do not localize}
{  end;
  Result := GetMapiItemAsBytes(AType, AText);
end;
}

function TIdCoderTNEF.GetMapiBinaryAsString(AType: Word; const AText: string): string;
var
  LBinary: TIdBytes;
  LStrLen: integer;
  LIndex: integer;
begin
  //You MUST know that the binary data is really a null-terminated string.
  LBinary := GetMapiBinary(AType, AText);
  LStrLen := Length(LBinary)-1;
  Result := '';
  for LIndex := 0 to LStrLen-1 do begin
    Result := Result + Chr(LBinary[LIndex]);
  end;
end;

function TIdCoderTNEF.GetMapiBinaryAsEmailName(AType: Word; const AText: string): string;
begin
  Result := GetMapiBinaryAsString(AType, AText);
  //If it starts SMTP: then remove SMTP:, but leave anything else (e.g. FAX:)
  if TextStartsWith(Result, 'SMTP:') then begin  {Do not localize}
    Result := Trim(Copy(Result, 6, MaxInt));
  end;
  Result := LowerCase(Result);
end;

function TIdCoderTNEF.GetMapiBinary(AType: Word; const AText: string): TIdBytes;
begin
  if AType <> IdTNEF_PT_BINARY then begin
    raise EIdTnefUnexpectedType.CreateFmt('Expected Binary for %s', [AText]);  {Do not localize}
  end;
  Result := GetMapiItemAsBytesPossiblyCompressed(AType, AText);
end;

function TIdCoderTNEF.GetMapiItemAsBytesPossiblyCompressed(AType: Word; const AText: string): TIdBytes;
var
  LCount, LLength: LongWord;
  LMagicNumber: LongWord;
  LCompressedSize, LUncompressedSize: LongWord;
  LPos: TIdStreamSize;
begin
  SetLength(Result, 0);
  LCount := GetLongWord;
  if FDoLogging then begin
    DoLogFmt('     Found %d %s:', [LCount, GetStringForMapiType(AType)]);  {Do not localize}
  end;
  if LCount = 0 then begin  //Very unlikely, just paranoia
    Exit;
  end;
  if LCount <> 1 then begin
    raise EIdTnefNotSupported.Create('Binary/Object not supported with a count > 1');  {Do not localize}
  end;
  LLength := GetLongWord;
  if LLength >= 12 then begin
    //Peek ahead to see if it has an optional magic number, indicating that it
    //has another header here.
    //If it has a valid magic number, then the next long is the
    //uncompressed size, then the compressed size, next is the magic (long) number,
    //next is a CRC.
    //We initially only want to see if it has a magic number...
    LPos := FData.Position;
    try
      Skip(8);
      LMagicNumber := GetLongWord;
    finally
      FData.Position := LPos;
    end;
    if LMagicNumber = $414C454D then begin
      //It has a header, but this magic number means it is NOT compressed.
      //Note: I have never seen this option existing in reality.
      LCompressedSize := GetLongWord;
      LUncompressedSize := GetLongWord;
      Skip(SizeOf(LongWord));  //Magic word
      Skip(SizeOf(LongWord));  //Checksum, ignore this, this block was crc-checked already
      if FDoLogging then begin
        DoLogFmt('     Is uncompressed, uncompressed size %d, compressed size %d',   {Do not localize}
          [LUncompressedSize, LCompressedSize]);
      end;
      Result := InternalGetMapiItemAsBytes(LCount, LLength-16, AType, AText);
      Exit;
    end
    else if LMagicNumber = $75465A4C then begin
      //It is compressed.  Decompress it.
      Result := DecompressRtf(LCount, LLength, AType, AText);
      Exit;
    end;
  end;
  //Not compressed (or not compressed in a format we recognise)...
  Result := InternalGetMapiItemAsBytes(LCount, LLength, AType, AText);
end;

function TIdCoderTNEF.DecompressRtf(ACount, ALength: LongWord; AType: Word; const AText: string): TIdBytes;
var
  LCompressedSize, LUncompressedSize: LongWord;
  LData: TIdBytes;
  LInIndex, LOutIndex: LongWord;
  LFlags: Byte;
  LShifts: integer;
  LFlag: Byte;
  LCodePosition: integer;
  LCodeLength: integer;
  LDecodeString: string;
  LDecodeStringLength: LongWord;
  LTemp: Integer;
  LOutBufferSize: LongWord;
begin
  //Read header...
  LCompressedSize := GetLongWord;  //Length AFTER this field (LLength - 4)
  LUncompressedSize := GetLongWord;
  GetLongWord;  //Magic number
  GetLongWord;     //Checksum, ignore this, this block was crc-checked already
  if FDoLogging then begin
    DoLogFmt('     Is compressed, uncompressed size %d, compressed size %d',  {Do not localize}
      [LUncompressedSize, LCompressedSize]);
  end;
  //Get the compressed bytes...
  LData := InternalGetMapiItemAsBytes(ACount, ALength-16, AType, AText);
  LDecodeStringLength := Length(IdTNEF_decode_string);
  LOutBufferSize := LDecodeStringLength + LUncompressedSize;
  SetLength(Result, LOutBufferSize);
  //Copy the preload decode string into the output...
  LDecodeString := IdTNEF_decode_string;
  for LTemp := 0 to LDecodeStringLength-1 do begin
    Result[LTemp] := Byte(LDecodeString[LTemp+1]);
  end;
  LInIndex := 0;
  LOutIndex := LDecodeStringLength;
  Dec(ALength, 16);  //Adjust for the header.
  LShifts := 8;  //Force an initial load of the first flag byte
  LFlags := 0;  //Stop warning
  while LInIndex < ALength do begin
    //This scheme blocks that contain a starting byte of eight flags followed by
    //eight 1 or 2-byte entries.  If the flag is 0, its entry is a single
    //literal byte, if 1 then its entry is a two-byte compression code.
    if LShifts = 8 then begin
      LFlags := LData[LInIndex];
      LShifts := 0;
      Inc(LInIndex);
    end;
    LFlag := LFlags and 1;
    LFlags := LFlags shr 1;
    Inc(LShifts);
    if LFlag = 0 then begin
      //A single literal byte...
      Result[LOutIndex] := LData[LInIndex];
      Inc(LInIndex);
      Inc(LOutIndex);
    end else begin
      //A two-byte code telling us that the bytes we want to output are
      //a copy of bytes that were previously outputted.  The position of
      //the previous bytes is the first three nibbles, the number of
      //bytes to copy is the last nibble.
      LCodePosition := LData[LInIndex];
      Inc(LInIndex);
      LCodeLength := LData[LInIndex];
      Inc(LInIndex);
      LCodePosition := LCodePosition shl 4;
      LCodePosition := LCodePosition or (LCodeLength shr 4);
      LCodeLength := LCodeLength and $F;   //The low nibble
      //Since repetitions of 0 or 1 byte would be a waste of time, the
      //length runs from 2 to 17 instead of 0 to 15...
      LCodeLength := LCodeLength + 2;
      //LCodePosition points to the byte sequence we are to copy from the
      //previously-decoded output data.  The output data is viewed as a
      //4096-byte circular buffer into which LCodePosition points.  It is
      //further complicated by the fact that the buffer is preloaded with
      //the string IdTNEF_decode_string.  Rather than using a real buffer,
      //we just calculate the corresponding position in the output data.
      LCodePosition := ((Integer(LOutIndex) div 4096) * 4096) + LCodePosition;
      //The flag byte always has 8 bits, but at the end of the data, the
      //last bits may be padding.  In this case, both LOutPosition and
      //LOutIndex will equal LOutBufferSize (1 byte past our output).
      //If we don't filter them out, we will get an access violation.
      if LOutIndex >= LOutBufferSize then begin
        if FDoLogging then begin
          DoLogFmt('  Ignoring EOD padding: %d bytes from offset %d to %d destlen %d',   {Do not localize}
            [LCodeLength, LCodePosition, LOutIndex, LOutBufferSize],
            False);
        end;
      end else begin
        if LCodePosition >= Integer(LOutIndex) then begin
          //The buffer is supposed to be a circular buffer.  Since we
          //made it a linear buffer, we need to wrap around...
          LCodePosition := LCodePosition - 4096;
        end;
        if LCodePosition < 0 then begin
          //This should never happen, would cause an AV...
          raise EIdTnefCorruptData.Create('Corrupt compressed rtf: negative code position');  {Do not localize}
        end;
        if FDoLogging then begin
          DoLogFmt('  Copying %d bytes from offset %d to %d destlen %d',   {Do not localize}
            [LCodeLength, LCodePosition, LOutIndex, LOutBufferSize], False);
        end;
        for LTemp := 0 to LCodeLength-1 do begin
          Result[LOutIndex] := Result[LCodePosition+LTemp];         //GPFs here
          Inc(LOutIndex);
        end;
      end;
    end;
  end;
  //Remove the decode string from the output...
  for LOutIndex := 0 to LUncompressedSize-1 do begin
    Result[LOutIndex] := Result[LOutIndex+LDecodeStringLength];
  end;
  SetLength(Result, LUncompressedSize);
  if FDoLogging then begin
    DoLog('     Uncompressed bytes:');  {Do not localize}
    DumpBytes(Result);
  end;
end;

function TIdCoderTNEF.GetMapiItemAsBytes(AType: Word; const AText: string): TIdBytes;
var
  LCount, LLength: LongWord;
begin
  SetLength(Result, 0);
  LCount := GetLongWord;
  if FDoLogging then begin
    DoLogFmt('     Found %d %s:', [LCount, GetStringForMapiType(AType)]);  {Do not localize}
  end;
  if LCount = 0 then begin  //Very unlikely, just paranoia
    Exit;
  end;
  if LCount <> 1 then begin
    raise EIdTnefNotSupported.Create('Binary/Object not supported with a count > 1');  {Do not localize}
  end;
  LLength := GetLongWord;
  Result := InternalGetMapiItemAsBytes(LCount, LLength, AType, AText);
end;

function TIdCoderTNEF.InternalGetMapiItemAsBytes(ACount, ALength: LongWord; AType: Word; const AText: string): TIdBytes;
var
  LPos: TIdStreamSize;
begin
  if FDoLogging then begin
    DoLogFmt('     Item had %d bytes.', [ALength]);  {Do not localize}
  end;
  LPos := FData.Position;
  Result := GetBytes(ALength);
  if FDoLogging then begin
    DumpBytes(Result);
  end;
  //Note the bytes are padded to 4-byte boundaries...
  if (ALength mod 4) > 0 then begin
    ALength := ((ALength div 4) + 1) * 4;
  end;
  FData.Position := LPos + ALength;
  if FDoLogging then begin
    DoLogFmt('     ParseMapiProp found %s Bytes, count: %d', [AText, ACount]);  {Do not localize}
  end;
end;

procedure TIdCoderTNEF.DumpBytes(const ABytes: TIdBytes);
var
  LIndex: integer;
  LLHS, LRHS: string;
begin
  LLHS := '';
  LRHS := '';
  for LIndex := 0 to Length(ABytes)-1 do begin
    LLHS := LLHS + GetByteAsHexString(ABytes[LIndex])+' ';  {Do not localize}
    LRHS := LRHS + GetByteAsChar(ABytes[LIndex]);
    if ((LIndex+1) mod 16) = 0 then begin
      DoLog('      ' + LLHS + '  ' + LRHS, False);  {Do not localize}
      LLHS := '';
      LRHS := '';
    end;
  end;
  if LLHS <> '' then begin
    while Length(LLHS) < 48 do begin
      LLHS := LLHS + ' ';  {Do not localize}
    end;
    DoLog('      ' + LLHS + '  ' + LRHS, False);  {Do not localize}
  end;
end;

procedure TIdCoderTNEF.ParseMapiProp;
var
  LType, LAttribute: Word;
  LLength, LCount, I: LongWord;
  //LGUIDType: LongWord;
  LShort: Smallint;
  LStr: string;
  LGUID: string;
  LTextPart: TIdText;
  LDate: TDateTime;
begin
  LType := GetWord;
  LAttribute := GetWord;
  //Initially, just parse out the common attributes and the ones we are interested in.
  if LAttribute >= $8000 then begin
    //A named property: this has a GUID and some other optional stuff...
    LGUID := GetBytesAsHexString(16);
    if FDoLogging then begin
      DoLog('     MAPI item has a named property, GUID: ' + LGUID);  {Do not localize}
    end;
    LLength := GetLongWord;
    if LLength = 0 then begin
      //In this case, the named property uses an identifier...
      //TODO: What is the LGUIDType below?
      {LGUIDType :=} GetLongWord;
    end else begin
      //In this case, the named property uses a string...
      //TODO: Following code not tested...
      //Skip strings for now
      LCount := LLength;
      for I := 1 to LCount do begin
        LLength := GetLongWord;
        if LLength = 0 then begin
          Continue;
        end;
        Skip(LLength);
        //Note the strings are padded to 4-byte boundaries...
        if (LLength mod 4) > 0 then begin
          Skip(4 - (LLength mod 4));
        end;
      end;
    end;
  end;
  case LAttribute of
    IdTNEF_PR_ALTERNATE_RECIPIENT_ALLOWED: begin
      {LShort := } GetMapiBoolean(LType, 'ALTERNATE_RECIPIENT_ALLOWED');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINATOR_DELIVERY_REPORT_REQUESTED: begin
      //A delivery receipt, not supported by most systems, implement as a read receipt
      LShort := GetMapiBoolean(LType, 'ORIGINATOR_DELIVERY_REPORT_REQUESTED');  {Do not localize}
      if LShort > 0 then begin
        //Have we already parsed the sender?
        if FMsg.From.Address <> '' then begin
          FMsg.ReceiptRecipient.Address := FMsg.From.Address;
        end else begin
          FReceiptRequested := True;
        end;
        if FDoLogging then begin
          DoLog('     Delivery receipt requested.');  {Do not localize}
        end;
      end else begin
        if FDoLogging then begin
          DoLog('     Delivery receipt not requested.');  {Do not localize}
        end;
      end;
    end;
    IdTNEF_PR_PRIORITY: begin
      {LLong := } GetMapiLong(LType, 'PRIORITY');  {Do not localize}
    end;
    IdTNEF_PR_READ_RECEIPT_REQUESTED: begin
      LShort := GetMapiBoolean(LType, 'READ_RECEIPT_REQUESTED');  {Do not localize}
      if LShort > 0 then begin
        //Have we already parsed the sender?
        if FMsg.From.Address <> '' then begin
          FMsg.ReceiptRecipient.Address := FMsg.From.Address;
        end else begin
          FReceiptRequested := True;
        end;
        if FDoLogging then begin
          DoLog('     Read receipt requested.');  {Do not localize}
        end;
      end else begin
        if FDoLogging then begin
          DoLog('     Read receipt not requested.');  {Do not localize}
        end;
      end;
    end;
    IdTNEF_PR_ORIGINAL_SENSITIVITY: begin
      {LLong := } GetMapiLong(LType, 'ORIGINAL_SENSITIVITY');  {Do not localize}
    end;
    IdTNEF_PR_SENSITIVITY: begin
      {LLong := } GetMapiLong(LType, 'SENSITIVITY');  {Do not localize}
    end;
    IdTNEF_PR_SUBJECT_PREFIX: begin
      {LStr := } GetMapiStrings(LType, 'SUBJECT_PREFIX');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_AUTHOR_NAME: begin
      {LStr := } GetMapiStrings(LType, 'ORIGINAL_AUTHOR_NAME');  {Do not localize}
    end;
    IdTNEF_PR_CONVERSATION_TOPIC: begin
      LStr := GetMapiStrings(LType, 'CONVERSATION_TOPIC');  {Do not localize}
      if FMsg.Subject = '' then begin //Only use this as subject if did not find subject at a higher level
        FMsg.Subject := LStr;
        if FDoLogging then begin
          DoLog('     Message has subject (from CONVERSATION_TOPIC): ' + LStr);  {Do not localize}
        end;
      end else begin
        if FDoLogging then begin
          DoLog('     CONVERSATION_TOPIC ignored, already have subject.  CONVERSATION_TOPIC: ' + LStr);  {Do not localize}
        end;
      end;
    end;
    IdTNEF_PR_CLIENT_SUBMIT_TIME: begin
      LDate := GetMapiSysTime(LType, 'CLIENT_SUBMIT_TIME');  {Do not localize}
      if FMsg.Date = 0 then begin //Only use this as date if did not find date at a higher level
        FMsg.Date := LDate;
        if FDoLogging then begin
          DoLog('     Message has date (from CLIENT_SUBMIT_TIME): ' + DateTimeToStr(LDate));  {Do not localize}
        end;
      end else begin
        if FDoLogging then begin
          DoLog('     CLIENT_SUBMIT_TIME ignored, already have date.  CLIENT_SUBMIT_TIME: ' + DateTimeToStr(LDate));  {Do not localize}
        end;
      end;
    end;
    IdTNEF_PR_CONVERSATION_INDEX: begin
      GetMapiBinary(LType, 'CONVERSATION_INDEX');  {Do not localize}
    end;
    IdTNEF_PR_MESSAGE_SUBMISSION_ID: begin
      GetMapiBinary(LType, 'MESSAGE_SUBMISSION_ID');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SUBJECT: begin
      {LStr :=} GetMapiStrings(LType, 'ORIGINAL_SUBJECT');  {Do not localize}
    end;
    IdTNEF_PR_REPLY_REQUESTED: begin
      {LShort :=} GetMapiBoolean(LType, 'REPLY_REQUESTED');  {Do not localize}
    end;
    IdTNEF_PR_SENDER_SEARCH_KEY: begin
      LStr := GetMapiBinaryAsEmailName(LType, 'SENDER_SEARCH_KEY');  {Do not localize}
      FMsg.From.Address := LStr;
      if FReceiptRequested = True then begin
        FMsg.ReceiptRecipient.Address := FMsg.From.Address;
      end;
      if FDoLogging then begin
        DoLog('     Message sender: ' + LStr);  {Do not localize}
      end;
    end;
    IdTNEF_PR_DELETE_AFTER_SUBMIT: begin
      GetMapiBoolean(LType, 'DELETE_AFTER_SUBMIT');  {Do not localize}
    end;
    IdTNEF_PR_MESSAGE_DELIVERY_TIME: begin
      GetMapiSysTime(LType, 'MESSAGE_DELIVERY_TIME');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SUBMIT_TIME: begin
      GetMapiSysTime(LType, 'ORIGINAL_SUBMIT_TIME');  {Do not localize}
    end;
    IdTNEF_PR_SENTMAIL_ENTRYID: begin
      GetMapiBinary(LType, 'SENTMAIL_ENTRYID');  {Do not localize}
    end;
    IdTNEF_PR_RTF_IN_SYNC: begin
      GetMapiBoolean(LType, 'RTF_IN_SYNC');  {Do not localize}
    end;
    IdTNEF_PR_MAPPING_SIGNATURE: begin
      GetMapiBinary(LType, 'MAPPING_SIGNATURE');  {Do not localize}
    end;
    IdTNEF_PR_STORE_RECORD_KEY: begin
      GetMapiBinary(LType, 'STORE_RECORD_KEY');  {Do not localize}
    end;
    IdTNEF_PR_STORE_ENTRYID: begin
      GetMapiBinary(LType, 'STORE_ENTRYID');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENDER_NAME: begin
      LStr := GetMapiStrings(LType, 'ORIGINAL_SENDER_NAME');  {Do not localize}
      if FMsg.From.Address = '' then begin
        FMsg.From.Address := LStr;
        if FDoLogging then begin
          DoLog('     Message has From (from ORIGINAL_SENDER_NAME): ' + LStr);  {Do not localize}
        end;
      end else begin
        if FDoLogging then begin
          DoLog('     ORIGINAL_SENDER_NAME ignored, already have From.  ORIGINAL_SENDER_NAME: ' + LStr);  {Do not localize}
        end;
      end;
      if FDoLogging then begin
        DoLog('     Message From: ' + FMsg.From.Address);  {Do not localize}
      end;
    end;
    IdTNEF_PR_ORIGINAL_SENDER_ENTRYID: begin
      GetMapiBinary(LType, 'ORIGINAL_SENDER_ENTRYID');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENDER_SEARCH_KEY: begin
      GetMapiBinary(LType, 'ORIGINAL_SENDER_SEARCH_KEY');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_NAME: begin
      GetMapiStrings(LType, 'ORIGINAL_SENT_REPRESENTING_NAME');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_ENTRYID: begin
      GetMapiBinary(LType, 'ORIGINAL_SENT_REPRESENTING_ENTRYID');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_SEARCH_KEY: begin
      GetMapiBinary(LType, 'ORIGINAL_SENT_REPRESENTING_SEARCH_KEY');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENDER_ADDRTYPE: begin
      GetMapiStrings(LType, 'ORIGINAL_SENDER_ADDRTYPE');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENDER_EMAIL_ADDRESS: begin
      GetMapiStrings(LType, 'ORIGINAL_SENDER_EMAIL_ADDRESS');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_ADDRTYPE: begin
      GetMapiStrings(LType, 'ORIGINAL_SENT_REPRESENTING_ADDRTYPE');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_SENT_REPRESENTING_EMAIL_ADDRESS: begin
      GetMapiStrings(LType, 'ORIGINAL_SENT_REPRESENTING_EMAIL_ADDRESS');  {Do not localize}
    end;
    IdTNEF_PR_SENDER_NAME: begin
      GetMapiStrings(LType, 'SENDER_NAME');  {Do not localize}
    end;
    IdTNEF_PR_NORMALIZED_SUBJECT: begin
      GetMapiStrings(LType, 'NORMALIZED_SUBJECT');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_DISPLAY_CC: begin
      GetMapiStrings(LType, 'ORIGINAL_DISPLAY_CC');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINAL_DISPLAY_TO: begin
      GetMapiStrings(LType, 'ORIGINAL_DISPLAY_TO');  {Do not localize}
    end;
    IdTNEF_PR_OBJECT_TYPE: begin
      {LLong := } GetMapiLong(LType, 'OBJECT_TYPE');  {Do not localize}
    end;
    IdTNEF_PR_STORE_SUPPORT_MASK: begin
      {LLong := } GetMapiLong(LType, 'STORE_SUPPORT_MASK');  {Do not localize}
    end;
    IdTNEF_PR_TNEF_CORRELATION_KEY: begin
      LStr := GetMapiBinaryAsString(LType, 'CORRELATION_KEY');  {Do not localize}
      if FMsg.MsgId = '' then begin
        FMsg.MsgId := LStr;
        if FDoLogging then begin
          DoLog('     Message has message ID (from CORRELATION_KEY): ' + LStr);  {Do not localize}
        end;
      end else begin
        if FDoLogging then begin
          DoLog('     CORRELATION_KEY ignored, already have message ID.  CORRELATION_KEY: ' + LStr);  {Do not localize}
        end;
      end;
      if FDoLogging then begin
        DoLog('     Message ID: ' + FMsg.MsgId);  {Do not localize}
      end;
    end;
    IdTNEF_PR_RTF_SYNC_BODY_CRC: begin
      {LLong := } GetMapiLong(LType, 'RTF_SYNC_BODY_CRC');  {Do not localize}
    end;
    IdTNEF_PR_RTF_SYNC_BODY_COUNT: begin
      {LLong := } GetMapiLong(LType, 'RTF_SYNC_BODY_COUNT');  {Do not localize}
    end;
    IdTNEF_PR_RTF_SYNC_BODY_TAG: begin
      {LStr :=} GetMapiStrings(LType, 'RTF_SYNC_BODY_TAG');  {Do not localize}
    end;
    IdTNEF_PR_BODY: begin
      LStr := GetMapiStrings(LType, 'BODY');  {Do not localize}
      FMsg.Body.Text := LStr;
    end;
    IdTNEF_PR_RTF_COMPRESSED: begin
      LStr := GetMapiBinaryAsString(LType, 'RTF_COMPRESSED');  {Do not localize}
      //Add this as a TIdText part of type text/rtf...
      LTextPart := TIdText.Create(FMsg.MessageParts);
      LTextPart.ContentType := 'text/rtf';  {Do not localize}
      LTextPart.Body.Text := LStr;
    end;
    IdTNEF_PR_RTF_SYNC_PREFIX_COUNT: begin
      {LLong := } GetMapiLong(LType, 'RTF_SYNC_PREFIX_COUNT');  {Do not localize}
    end;
    IdTNEF_PR_RTF_SYNC_TRAILING_COUNT: begin
      {LLong := } GetMapiLong(LType, 'RTF_SYNC_TRAILING_COUNT');  {Do not localize}
    end;
    IdTNEF_PR_ORIGINALLY_INTENDED_RECIP_ENTRYID: begin
      GetMapiBinary(LType, 'ORIGINALLY_INTENDED_RECIP_ENTRYID');  {Do not localize}
    end;
  else
    //For the types we are not interested in, skip past them...
    case LType of
      IdTNEF_PT_BOOLEAN,
      IdTNEF_PT_LONG,
      IdTNEF_PT_I2,
      IdTNEF_PT_R4,
      IdTNEF_PT_ERROR,
      IdTNEF_PT_APPTIME: begin
        if FDoLogging then begin
          DoLogFmt('     Skipping MAPI attribute 0x%x of type %s', [LAttribute, GetStringForMapiType(LType)]);  {Do not localize}
        end;
        Skip(4);  //Only 2 bytes used, but padded to 4
      end;
      IdTNEF_PT_BINARY,
      IdTNEF_PT_OBJECT: begin
        if FDoLogging then begin
          DoLogFmt('     Skipping MAPI attribute 0x%x of type %s', [LAttribute, GetStringForMapiType(LType)]);  {Do not localize}
        end;
        GetMapiItemAsBytes(LType, 'ignored data');
      end;
      IdTNEF_PT_UNICODE,
      IdTNEF_PT_STRING8: begin
        if FDoLogging then begin
          DoLogFmt('     Skipping MAPI attribute 0x%x of type %s', [LAttribute, GetStringForMapiType(LType)]);  {Do not localize}
        end;
        GetMapiStrings(LType, 'ignored data');
      end;
      IdTNEF_PT_SYSTIME,
      IdTNEF_PT_DOUBLE,
      IdTNEF_PT_I8,
      IdTNEF_PT_CURRENCY: begin
        if FDoLogging then begin
          DoLogFmt('     Skipping MAPI attribute 0x%x of type %s', [LAttribute, GetStringForMapiType(LType)]);  {Do not localize}
        end;
        Skip(8);
      end;
    else
      raise EIdTnefUnknownMapiType.CreateFmt('Encountered unknown MAPI type: %d, attribute: %d', [LType, LAttribute]);  {Do not localize}
    end;
  end;
end;

procedure TIdCoderTNEF.ParseMapiProps(ALength: LongWord);
var
  LNumEntries: LongWord;
  LIndex: LongWord;
begin
  if FDoLogging then begin
    DoLogFmt('   Parsing MAPI block, %d bytes.', [ALength]);  {Do not localize}
  end;
  LNumEntries := GetLongWord;
  if FDoLogging then begin
    DoLogFmt('   Contains %d entries.', [LNumEntries]);  {Do not localize}
  end;
  if LNumEntries > 0 then begin
    for LIndex := 0 to LNumEntries-1 do begin
      if FDoLogging then begin
        DoLogFmt('    Entry %d:', [LIndex]);  {Do not localize}
      end;
      ParseMapiProp;
    end;
  end;
end;

procedure TIdCoderTNEF.ParseAttribute(AAttribute, AType: Word);
var
  LLength: LongWord;
  LMajor, LMinor: Word;
  LShort: Smallint;
begin
  LLength := GetLongWord;
  Checksum(LLength);
  case AAttribute of
    IdTNEFattTnefVersion: begin
      if AType <> IdTNEFAtpDWord then begin
        raise EIdTnefUnexpectedType.Create('Expected DWord for TnefVersion');  {Do not localize}
      end;
      LMinor := GetWord;
      LMajor := GetWord;
      if FDoLogging then begin
        DoLogFmt('     ParseAttribute found TNef Version DWord.  Major version: %d Minor version: %d', [LMajor, LMinor]);  {Do not localize}
      end;
      if (LMajor <> 1) and (LMinor <> 0) then begin
        if FDoLogging then begin
          DoLog('     Expected a version with Major = 1, Minor = 0.  Some elements may not parse correctly.');  {Do not localize}
        end;
      end else begin
        if FDoLogging then begin
          DoLog('     This is the expected version.');  {Do not localize}
        end;
      end;
    end;
    IdTNEFattSubject: begin
      if AType <> IdTNEFAtpString then begin
        raise EIdTnefUnexpectedType.Create('Expected String for TnefSubject');  {Do not localize}
      end;
      FMsg.Subject := GetString(LLength);
      if FDoLogging then begin
        DoLog('     ParseAttribute found TNef Subject String: ' + FMsg.Subject);  {Do not localize}
        DoLog('     Message has subject: ' + FMsg.Subject);  {Do not localize}
      end;
    end;
    IdTNEFattDateSent: begin
      if AType <> IdTNEFAtpDate then begin
        raise EIdTnefUnexpectedType.Create('Expected Date for TnefDateSent');  {Do not localize}
      end;
      FMsg.Date := GetDate(LLength);
      if FDoLogging then begin
        DoLog('     ParseAttribute found TNef Date Sent.');  {Do not localize}
        DoLog('     Message has date: ' + DateTimeToStr(FMsg.Date));  {Do not localize}
      end;
    end;
    IdTNEFattMessageID: begin
      if AType <> IdTNEFAtpString then begin
        raise EIdTnefUnexpectedType.Create('Expected String for TnefMessageID');  {Do not localize}
      end;
      FMsg.MsgId := GetString(LLength);
      if FDoLogging then begin
        DoLog('     ParseAttribute found TNef Message ID.');  {Do not localize}
        DoLog('     Message has ID: ' + FMsg.MsgId);  {Do not localize}
      end;
    end;
    IdTNEFattPriority: begin
      if AType <> IdTNEFAtpShort then begin
        raise EIdTnefUnexpectedType.Create('Expected Short for TnefPriority');  {Do not localize}
      end;
      LShort := GetWord;
      if FDoLogging then begin
        DoLog('     ParseAttribute found Priority Short.');  {Do not localize}
      end;
      case LShort of
        IdTNEFprioLow: begin
          FMsg.Priority := mpLow;
          if FDoLogging then begin
            DoLog('     Message has low priority.');  {Do not localize}
          end;
        end;
        IdTNEFprioNorm: begin
          FMsg.Priority := mpNormal;
          if FDoLogging then begin
            DoLog('     Message has normal priority.');  {Do not localize}
          end;
        end;
        IdTNEFprioHigh: begin
          FMsg.Priority := mpHigh;
          if FDoLogging then begin
            DoLog('     Message has high priority.');  {Do not localize}
          end;
        end;
      else
        raise EIdTnefUnexpectedValue.Create('Unexpected value for priority.');  {Do not localize}
      end;
    end;
    IdTNEFattMAPIProps: begin
      ParseMapiProps(LLength);
    end;
  else
    case AType of
      IdTNEFAtpTriples: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpTriples type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
      IdTNEFAtpString: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpString type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
      IdTNEFAtpText: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpText type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
      IdTNEFAtpDate: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpDate type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
         end;
        Skip(LLength);
      end;
      IdTNEFAtpShort: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpShort type, %s, length: %d', [GetStringForAttribute(AAttribute), LLength]);  {Do not localize}
        end;
        Skip(LLength);
      end;
      IdTNEFAtpLong: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpLong type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
      IdTNEFAtpByte: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpByte type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
      IdTNEFAtpWord: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpWord type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
      IdTNEFAtpDWord: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpDWord type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
      IdTNEFAtpMax: begin
        if FDoLogging then begin
          DoLogFmt('     ParseAttribute found AtpMax type, %s, length: %d',  {Do not localize}
            [GetStringForAttribute(AAttribute), LLength]);
        end;
        Skip(LLength);
      end;
    else
      if FDoLogging then begin
        DoLogFmt('     ParseAttribute found unknown type, %s, length: %d',  {Do not localize}
           [GetStringForAttribute(AAttribute), LLength]);
      end;
      Skip(LLength);
    end;
  end;
  Skip(2);  //Checksum
end;

procedure TIdCoderTNEF.Parse(const AIn: TStream; AMsg: TIdMessage; ALog: Boolean = False);
var
  LdwTemp: LongWord;
  LBlockType: Byte;
begin
  FLog := '';
  FDoLogging := ALog;
  FMsg := AMsg;
  FMsg.Clear;
  FMsg.ContentType := 'multipart/mixed';  //Default: improve on this at a later stage.
  FReceiptRequested := False;
  FCurrentAttachment := nil;
  FData := AIn;
  if FDoLogging then begin
    DoLogFmt('Bytes in TNEF: %d', [FData.Size - FData.Position], False);  {Do not localize}
  end;
  //Check for a valid TNEF signature...
  LdwTemp := GetLongWord;
  if LdwTemp <> IdTNEFSignature then begin
    if FDoLogging then begin
      DoLog('Invalid TNEF signature', False);  {Do not localize}
    end;
    raise EIdTnefInvalidTNEFSignature.Create('Invalid TNEF signature');  {Do not localize}
  end;
  FKey := GetWord;
  if FDoLogging then begin
    DoLogFmt('Key: %d' + EOL + 'Bytes left plus message:', [FKey], False);  {Do not localize}
  end;
  repeat
    LBlockType := GetByte;
    case LBlockType of
      IdTNEFLvlMessage: begin
        if FDoLogging then begin
          DoLog(' Calling ParseMessageBlock:');  {Do not localize}
        end;
        ParseMessageBlock;
      end;
      IdTNEFLvlAttachment: begin
        if FDoLogging then begin
          DoLog(' Calling ParseAttachmentBlock:');  {Do not localize}
        end;
        ParseAttachmentBlock;
      end;
    else
      begin
        if FDoLogging then begin
          DoLogFmt(' Hit unknown block type: %d', [LBlockType]);  {Do not localize}
        end;
        raise EIdTnefUnknownBlockType.Create('Hit unknown block type in TNEF - corrupt TNEF?');  {Do not localize}
      end;
    end;
  until FData.Position >= FData.Size;
  if FDoLogging then begin
    DoLog(' Finished processing TNEF.');  {Do not localize}
  end;
end;

end.

