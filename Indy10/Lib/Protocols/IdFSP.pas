{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  111212: IdFSP.pas 
{
{   Rev 1.17    2/10/2005 2:24:38 PM  JPMugaas
{ Minor Restructures for some new UnixTime Service components.
}
{
{   Rev 1.16    1/17/2005 7:29:12 PM  JPMugaas
{ Now uses new TIdBuffer functionality.
}
{
{   Rev 1.15    1/9/2005 6:08:06 PM  JPMugaas
{ Payload size now specified for CC_GET_FILE.
{ Now will raise exception if you specify a packet size less than 512.
}
{
{   Rev 1.12    11/12/2004 8:37:36 AM  JPMugaas
{ Minor compile error.  OOPS!!!
}
{
{   Rev 1.11    11/11/2004 11:22:54 PM  JPMugaas
{ Removed an $IFDEF that's no longer needed.
}
{
{   Rev 1.10    11/8/2004 8:36:04 PM  JPMugaas
{ Added value for command that may appear later.
}
{
{   Rev 1.9    11/7/2004 11:34:16 PM  JPMugaas
{ Now uses inherited methods again.  The inherited methods now use the Binding
{ methods we used here.
}
{
{   Rev 1.8    11/6/2004 1:46:34 AM  JPMugaas
{ Minor bug fix for when there is no data in a reply to CC_GET_PRO.
}
{
{   Rev 1.7    11/5/2004 7:55:02 PM  JPMugaas
{ Changed to use, Connect, Recv, Send, and Disconnect instead of ReceiveFrom
{ and SendTo.  This should improve performance as we do make repeated contacts
{ to the host and UDP connect will cause the stack to filter out packets that
{ aren't from the peer.  There should only be one DNS resolution per session
{ making this more efficient (cutting down to about 87 seconds to get a dir).
}
{
{   Rev 1.4    10/31/2004 1:49:58 AM  JPMugaas
{ Now uses item type from TIdFTPList for dirs and files.  We don't use Skip
{ items or end of dir marker items.
}
{
{   Rev 1.2    10/30/2004 10:23:58 PM  JPMugaas
{ Should be much faster.
}
{
{   Rev 1.1    10/30/2004 7:04:26 PM  JPMugaas
{ FSP Upload.
}
{
{   Rev 1.0    10/29/2004 12:34:20 PM  JPMugaas
{ File Services Protocol implementation started
}
unit IdFSP;

interface

uses
  IdException,
  IdFTPList,
  IdGlobal,
  IdSys,
  IdThreadSafe,
  IdObjs,
  IdUDPClient;

{This is based on:

http://cvs.sourceforge.net/viewcvs.py/fsp/fsp/doc/PROTOCOL?rev=1.4&view=markup

and the Java Lib at fsp.sourceforge.net was also referenced.

I have verified this on a CygWin build of the FSP Server at fsp.sourceforge.net.
}
{


FSP Packet format:
  HEADER - size = Fixed size 12 bytes. Always present.
  DATA         - size = defined in header (DATA_LENGTH)
  XTRA DATA- size = packet_size - header_size (12) - DATA_LENGTH

Maximal data size DATA_LENGTH + XTRA_DATA length is 1024. Clients and servers
are not required to support XTRA DATA (but in current FSP implementation does).
If XTRA DATA are provided, there must be also contained in MESSAGE_CHECKSUM.

HEADER FORMAT (12 bytes)
 byte FSP_COMMAND
 byte MESSAGE_CHECKSUM
 word KEY
 word SEQUENCE
 word DATA_LENGTH
 long FILE_POSITION

MESSAGE_CHECKSUM
Entire packet (HEADER + DATA + XTRA DATA) is checksumed.  When computing a
checksum use zero in place of MESSAGE_CHECKSUM header field. 

Due to some unknown reason, method of computing checksums is different in each
direction. For packets travelling from server to client initial checksum
value is zero, otherwise it is HEADER + DATA + XTRA DATA size.

Checksums in server->client direction are computed as follows:

 /* assume that we have already zeroed checksum in packet */
 unsigned int sum,checksum;
 for(t = packet_start, sum = 0; t < packet_end; sum += *t++);
 checksum= sum + (sum >> 8);

KEY
Client's message to server contain a KEY value that is the same as the KEY
value of the previous message received from the server. KEY is choosen random
by server.
}

{



 CC_VERSION     0x10- Get server version string and setup

                request
                file position: ignored
                data:          not used
xtra data:     not used

reply
file position:  size of optional extra version data
data:           ASCIIZ Server version string
xtra data:      optional extra version data
byte - FLAGS
        bit 0 set - server does logging
bit 1 set - server is read only
bit 2 set - reverse lookup required
bit 3 set - server is in private mode
bit 4 set - thruput control
        if bit 4 is set thruput info follows
long - max_thruput allowed (in bytes/sec)
word - max. packet size supported by server
}

const
  IdPORT_FSP = 21;

  HSIZE=12;    //header size
  DEF_MAXSPACE=1012; //data length
  DEF_MAXSIZE=DEF_MAXSPACE+HSIZE; //default maximum packet size

//commands
  CC_VERSION     = $10;  //Get server version string and setup
  CC_INFO        = $11;  //return server's extended info block
  CC_ERR         = $40;  //error response from server
  CC_GET_DIR     = $41; // get a directory listing
  CC_GET_FILE    = $42; // get a file
  CC_UP_LOAD     = $43; // open a file for writing
  CC_INSTALL     = $44; // close and install file opened for writing
  CC_DEL_FILE    = $45; // delete a file
  CC_DEL_DIR     = $46; // delete a directory
  CC_GET_PRO     = $47; // get directory protection
  CC_SET_PRO     = $48; // set directory protection
  CC_MAKE_DIR    = $49; // create a directory
  CC_BYE         = $4A; // finish a session
  CC_GRAB_FILE   = $4B; // atomic get+delete a file
  CC_GRAB_DONE   = $4C; // atomic get+delete a file done
  CC_STAT        = $4D; // get information about file/directory
  CC_RENAME      = $4E; // rename file or directory
  CC_CH_PASSW    = $4F; // change password
//Reserved commands:
 CC_LIMIT        = $80;
 { commands > 0x7F will have extended
     header. No such extensions or commands
    which uses that are known today. This
    header will be used in protocol version 3.   }

  CC_TEST         = $81; //reserved for testing of new header

  RDTYPE_END      = $00;
  RDTYPE_FILE     = $01;
  RDTYPE_DIR      = $02;
  RDTYPE_SKIP     = $2A;   //42

  MINTIMEOUT =   1340;   //1.34 seconds
  MAXTIMEOUT = 300000; //300 seconds
type
  EIdFSPException = class(EIdException);
  EIdFSPFileAlreadyExists = class(EIdFSPException);
  EIdFSPFileNotFound = class(EIdFSPException);
  EIdFSPProtException = class(EIdFSPException);
  EIdFSPPacketTooSmall = class(EIdFSPException);
{
RDIRENT.HEADER types:
  RDTYPE_END      0x00
  RDTYPE_FILE     0x01
  RDTYPE_DIR      0x02
  RDTYPE_SKIP     0x2A
}
  TIdFSPStatInfo = class(TIdCollectionItem)
  protected
      FModifiedDateGMT : TIdDateTime;
    FModifiedDate: TIdDateTime;
    //Size is Int64 in case FSP 3 has an expansion, otherise, it can only handle
    //file sizes up 4 GB's.  It's not a bug, it's a feature.
    FSize: Int64;
    FItemType :TIdDirItemType;
  published
    property ItemType :TIdDirItemType read FItemType write FItemType;
    property Size: Int64 read FSize write FSize;
    property ModifiedDate: TIdDateTime read FModifiedDate write FModifiedDate;
    property ModifiedDateGMT : TIdDateTime read FModifiedDateGMT write FModifiedDateGMT;
  end;
  TIdFSPListItem = class(TIdFSPStatInfo)
  protected
    FFileName: string;
  published
    property FileName: string read FFileName write FFileName;
  end;
  TIdFSPListItems = class(TIdCollection)
  protected
    function GetItems(AIndex: Integer): TIdFSPListItem;
    procedure SetItems(AIndex: Integer; const Value: TIdFSPListItem);
  public
    function Add: TIdFSPListItem;
    constructor Create; reintroduce;
    function ParseEntries(const AData : TIdBytes; const ADataLen : Cardinal) : Boolean;
    function IndexOf(AItem: TIdFSPListItem): Integer;
    property Items[AIndex: Integer]: TIdFSPListItem read GetItems write SetItems; default;

  end;
  TIdFSPDirInfo = class(TObject)
  protected
    FOwnsDir,
    FCanDeleteFiles,
    FCanAddFiles,
    FCanMakeDir,
    FOnlyOwnerCanReadFiles,
    FHasReadMe,
    FCanBeListed,
    FCanRenameFiles : Boolean;
    FReadMe : String;
  public
    property OwnsDir : Boolean read FOwnsDir write FOwnsDir;
    property CanDeleteFiles : Boolean read FCanDeleteFiles write FCanDeleteFiles;
    property CanAddFiles : Boolean read FCanAddFiles write FCanAddFiles;
    property CanMakeDir : Boolean read FCanMakeDir write FCanMakeDir;
    property OnlyOwnerCanReadFiles : Boolean read FOnlyOwnerCanReadFiles write FOnlyOwnerCanReadFiles;
    property HasReadMe : Boolean read FHasReadMe write FHasReadMe;
{


        Compatibility

Versions older than 2.8.1b6 do not uses bits 6 and 7. This
causes that directory can be listable even it do not have
6th bit set.
}
    property CanBeListed : Boolean read FCanBeListed write FCanBeListed;
    property CanRenameFiles : Boolean read FCanRenameFiles write FCanRenameFiles;
    property ReadMe : String read FReadMe write FReadMe;
  end;
  TIdFSPPacket = class(TObject)
  protected
    FCmd: Byte;
    FFilePosition: Cardinal;
    FData: TIdBytes;
    FDataLen : Word;
    FExtraData: TIdBytes;
//    FExtraDataLen : Cardinal;
    FSequence: Word;
    FKey: Word;
    FValid : Boolean;
  public
    constructor Create;
    function WritePacket : TIdBytes;
    procedure ReadPacket(const AData : TIdBytes; const ALen : Cardinal);
    property Valid : Boolean read FValid;
    property Cmd : Byte read FCmd write FCmd;
    property Key : Word read FKey write FKey;
    property Sequence : Word read FSequence write FSequence;
    property FilePosition : Cardinal read FFilePosition write FFilePosition;
    property Data : TIdBytes read FData write FData;
    property DataLen : Word read FDataLen write FDataLen;
    property ExtraData : TIdBytes read FExtraData write FExtraData;
  //  property WritePacket : TIdBytes read GetWritePacket write SetWritePacket;
  end;
  TIdFSPLogEvent = procedure (Sender : TObject; APacket : TIdFSPPacket) of object;
  TIdFSP = class(TIdUDPClient)
  protected
    FConEstablished : Boolean;
    FSequence : Word;
    FKey : Word;
    FSystemDesc: string;
    FSystemServerLogs : Boolean;
    FSystemReadOnly : Boolean;
    FSystemReverseLookupRequired : Boolean;
    FSystemPrivateMode : Boolean;
    FSystemAcceptsExtraData : Boolean;
    FThruputControl : Boolean;

    FServerMaxThruPut : Cardinal;  //bytes per sec
    FServerMaxPacketSize : Word; //maximum packet size server supports
    FClientMaxPacketSize : Word; //maximum packet we wish to support
    FDirectoryListing: TIdFSPListItems;
    FDirInfo : TIdFSPDirInfo;
    FStatInfo : TIdFSPStatInfo;
    FOnRecv, FOnSend : TIdFSPLogEvent;

    FAbortFlag : TIdThreadSafeBoolean;

    //note:  This is optimized for performance - DO NOT MESS with it even if you don't like it
    //or think its wrong.  There is a performance penalty that is noticable with downloading,
    //uploading, and dirs because those use a series of packets - not one and we limited in
    //packet size.  We also do not want to eat CPU cycles excessively which I've noticed
    //with previous code.
    procedure SendCmdOnce(ACmdPacket, ARecvPacket : TIdFSPPacket; var VTempBuf : TIdBytes; const ARaiseException : Boolean=True); overload;
    procedure SendCmdOnce(const ACmd : Byte; const AData, AExtraData : TIdBYtes;
      const AFilePosition : Int64; //in case FSP 3.0 does support more than 4GB
      var VData, VExtraData : TIdBytes; const ARaiseException : Boolean=True);  overload;

    procedure SendCmd(ACmdPacket, ARecvPacket : TIdFSPPacket; var VTempBuf : TIdBytes; const ARaiseException : Boolean=True); overload;
    procedure SendCmd(const ACmd : Byte; const AData, AExtraData : TIdBYtes;
      const AFilePosition : Int64; //in case FSP 3.0 does support more than 4GB
      var VData, VExtraData : TIdBytes; const ARaiseException : Boolean=True);  overload;
    procedure SendCmd(const ACmd : Byte; const AData : TIdBYtes;
      const AFilePosition : Int64; //in case FSP 3.0 does support more than 4GB
      var VData, VExtraData : TIdBytes; const ARaiseException : Boolean=True); overload;
    procedure ParseDirInfo(const ABuf, AExtraBuf: TIdBytes; ADir : TIdFSPDirInfo);
    procedure InitComponent; override;
    function MaxBufferSize : Word;
    function PrefPayloadSize : Word;
    procedure SetClientMaxPacketSize(const AValue: Word);
  public
    destructor Destroy; override;
    procedure Connect; override; //this is so we can use it similarly to FTP
    procedure Disconnect; override;
    procedure Version;
    procedure Delete(const AFilename: string);
    procedure RemoveDir(const ADirName: string);
    procedure Rename(const ASourceFile, ADestFile: string);
    procedure MakeDir(const ADirName: string);
    //this is so we can use it similarly to FTP
    //and also sends a BYE command which is the courteous thing to do.
    procedure List;  overload;
    procedure List(  
      const ASpecifier: string); overload;
    procedure GetDirInfo(const ADIR : String); overload;
    procedure GetDirInfo(const ADIR : String; ADirInfo : TIdFSPDirInfo); overload;
    procedure GetStatInfo(const APath : String);
    procedure Get(const ASourceFile, ADestFile: string; const ACanOverwrite: boolean = false;
      AResume: Boolean = false); overload;
    procedure Get(const ASourceFile: string; ADest: TIdStream2; AResume: Boolean = false); overload;
    procedure Put(const ASource: TIdStream2; const ADestFile: string;
       const AGMTTime : TIdDateTime=0); overload;
    procedure Put(const ASourceFile: string; const ADestFile: string=''); overload;
    property SystemDesc: string read FSystemDesc;
    property SystemServerLogs : Boolean read  FSystemServerLogs;
    property SystemReadOnly : Boolean read FSystemReadOnly;
    property SystemReverseLookupRequired : Boolean read FSystemReverseLookupRequired;
    property SystemPrivateMode : Boolean read FSystemPrivateMode;
    property SystemAcceptsExtraData : Boolean read  FSystemAcceptsExtraData;
    property ThruputControl : Boolean read FThruputControl;
    property ServerMaxThruPut : Cardinal read FServerMaxThruPut;
    property ServerMaxPacketSize : Word read FServerMaxPacketSize;
    property ClientMaxPacketSize : Word read FClientMaxPacketSize write SetClientMaxPacketSize;
    property DirectoryListing: TIdFSPListItems read FDirectoryListing;
    property DirInfo : TIdFSPDirInfo read FDirInfo;
    property StatInfo : TIdFSPStatInfo read FStatInfo;
  published
    property Port default IdPORT_FSP;
    property OnWork;
    property OnWorkBegin;
    property OnWorkEnd;
    property OnRecv : TIdFSPLogEvent read FOnRecv write FOnRecv;
    property OnSend : TIdFSPLogEvent read  FOnSend write FOnSend;
  end;

implementation
uses IdBuffer, IdComponent, IdGlobalProtocols, IdResourceStringsProtocols, 
  IdStack;

function ParseASCIIZ(const ABytes : TIdBytes; const ALen : Cardinal) : String;
var i : Cardinal;
begin
  Result := '';
  if ALen=0 then
  begin
    Exit;
  end;
  for i := 0 to ALen do
  begin
    if ABytes[i]=0 then
    begin
      Break;
    end
    else
    begin
      Result := Result + Char(ABytes[i]);
    end;
  end;
end;

procedure ParseStatInfo(const AData : TIdBytes; VL : TIdFSPStatInfo; var VI : Cardinal);
var LC : Cardinal;
begin
  //we don't parse the file type because there is some variation between CC_GET_DIR and CC_STAT
  CopyBytesToHostCardinal(AData,VI,LC);

   VL.FModifiedDateGMT := UnixDateTimeToDelphiDateTime(LC);
   VL.FModifiedDate := VL.FModifiedDateGMT + OffSetFromUTC;
   VI := VI + 4;

    CopyBytesToHostCardinal(AData,VI,LC);
   VL.Size :=  LC;
   VI := VI + 5;     //we want to skip over the type byte we processed earlier
 
end;

{ TIdFSP }

procedure TIdFSP.Connect;
begin
  FSequence := 1;
  FKey := 0;
  FServerMaxThruPut := 0;
  FServerMaxPacketSize := DEF_MAXSIZE;
  inherited Connect;
end;

destructor TIdFSP.Destroy;
begin
  Disconnect;
  Sys.FreeAndNil( FDirInfo );
  Sys.FreeAndNil( FDirectoryListing );
  Sys.FreeAndNil( FStatInfo );
  Sys.FreeAndNil( FAbortFlag );
  inherited;
end;

procedure TIdFSP.Disconnect;
var
  LBuf,LData, LExtra : TIdBytes;
begin
  if FConEstablished then
  begin
    SetLength(LBuf,0);
    SendCmd( CC_BYE,LBuf,0,LData,LExtra);
    inherited Disconnect;
  end;
  FConEstablished := False;
end;

procedure TIdFSP.Get(const ASourceFile: string; ADest: TIdStream2;
  AResume: Boolean);
var LSendPacket : TIdFSPPacket;
    LRecvPacket :  TIdFSPPacket;
    LLen : Integer;
    LTmpBuf : TIdBytes;
begin
  SetLength(LTmpBuf,MaxBufferSize);
  LSendPacket := TIdFSPPacket.Create;
  LRecvPacket :=  TIdFSPPacket.Create;
  try
    if AResume then begin
       LSendPacket.FFilePosition := ADest.Position;
    end
    else
    begin
      LSendPacket.FFilePosition := 0;
    end;
    LSendPacket.Cmd := CC_GET_FILE;
    LSendPacket.FData := ToBytes(ASourceFile+#0);
    LSendPacket.FDataLen := Length(ASourceFile)+1;
    //specify a preferred block size
    SetLength(LSendPacket.FExtraData, 2);
    CopyTIdNetworkWord(PrefPayloadSize,LSendPacket.FExtraData,0);
    
    BeginWork(wmRead);
    try
      repeat
         SendCmd(LSendPacket,LRecvPacket,LTmpBuf);
         LLen := LRecvPacket.FDataLen; //Length(LRecvPacket.Data);
         if LLen >0 then
         begin
           ADest.Write(LRecvPacket.Data,LLen);
           DoWork(wmRead,LLen);
           Inc(LSendPacket.FFilePosition,LLen);
         end
         else
         begin
           Break;
         end;
      until False;
    finally
      EndWork(wmRead);
    end;
  finally
    Sys.FreeAndNil(LSendPacket);
    Sys.FreeAndNil(LRecvPacket);
  end;
end;

procedure TIdFSP.Get(const ASourceFile, ADestFile: string;
  const ACanOverwrite: boolean; AResume: Boolean);
var
  LDestStream: TIdStream2;
begin
    if ACanOverwrite and (not AResume) then begin
      Sys.DeleteFile(ADestFile);
      LDestStream := TFileCreateStream.Create(ADestFile);
    end
    else begin
      if (not ACanOverwrite) and AResume then begin
        LDestStream := TAppendFileStream.Create(ADestFile);
      end
      else begin
        raise EIdFSPFileAlreadyExists.Create(RSDestinationFileAlreadyExists);
      end;
    end;


  try
    Get(ASourceFile, LDestStream, AResume);
  finally
    Sys.FreeAndNil(LDestStream);
  end;
end;



procedure TIdFSP.GetDirInfo(const ADIR: String);
begin
  GetDirInfo(ADir,Self.FDirInfo );
end;

procedure TIdFSP.InitComponent;
begin
  inherited;
  Port := IdPORT_FSP;
  FSequence := 0;
  FKey := 0;
   FDirInfo := TIdFSPDirInfo.Create;
  FDirectoryListing:= TIdFSPListItems.Create;
  FStatInfo := TIdFSPStatInfo.Create(nil);
  BroadcastEnabled := False;
  FConEstablished := False;
  FClientMaxPacketSize := DEF_MAXSIZE;
  FAbortFlag := TIdThreadSafeBoolean.Create;
  FAbortFlag.Value := FALSE;
end;

procedure TIdFSP.List;
begin
  List('/');
end;

procedure TIdFSP.List(const ASpecifier: string);
var
  LSendPacket : TIdFSPPacket;
  LRecvPacket :  TIdFSPPacket;
  LTmpBuf : TIdBytes;
begin
  SetLength(LTmpBuf,MaxBufferSize);
  LSendPacket := TIdFSPPacket.Create;
  LRecvPacket :=  TIdFSPPacket.Create;
  try
  //
    LSendPacket.Cmd := CC_GET_DIR;
    LSendPacket.FFilePosition := 0;
    SetLength(LRecvPacket.FData, MaxBufferSize );
    SetLength(LSendPacket.FExtraData, 2);

    CopyTIdNetworkWord(PrefPayloadSize,LSendPacket.FExtraData,0);

    FDirectoryListing.Clear;
    repeat

      if ASpecifier ='' then
      begin
        LSendPacket.Data := ToBytes('/'+#0);
        LSendPacket.DataLen := 2;
      end
      else
      begin
        LSendPacket.Data := ToBytes(ASpecifier+#0);
        LSendPacket.DataLen := Length(LSendPacket.Data);
      end;


      SendCmd(LSendPacket,LRecvPacket,LTmpBuf);

      if LRecvPacket.DataLen > 0 then
      begin
        Inc(LSendPacket.FFilePosition,LRecvPacket.DataLen);
      end
      else
      begin
        Break;
      end;
      if LRecvPacket.DataLen < Self.PrefPayloadSize then
      begin
        Break;
      end;
    until FDirectoryListing.ParseEntries( LRecvPacket.FData, LRecvPacket.FDataLen );
  finally
    Sys.FreeAndNil(LSendPacket);
    Sys.FreeAndNil(LRecvPacket);
  end;
end;

procedure TIdFSP.SendCmd(const ACmd: Byte; const AData,
  AExtraData: TIdBYtes; const AFilePosition: Int64; var VData,
  VExtraData: TIdBytes; const ARaiseException : Boolean=True);
var LSendPacket : TIdFSPPacket;
    LRecvPacket :  TIdFSPPacket;
    LTmpBuf : TIdBytes;
begin
  SetLength(LTmpBuf,MaxBufferSize);
  LSendPacket := TIdFSPPacket.Create;
   LRecvPacket :=  TIdFSPPacket.Create;
  try
    LSendPacket.Cmd := ACmd;
    LSendPacket.FilePosition := AFilePosition;
    LSendPacket.Data := AData;
    LSendPacket.FDataLen := Length(AData);
    LSendPacket.ExtraData := AExtraData;
    SendCmd(LSendPacket,LRecvPacket,LTmpBuf,ARaiseException );
    VData := LRecvPacket.Data;
    VExtraData := LRecvPacket.ExtraData;

  finally
    Sys.FreeAndNil(LSendPacket);
    Sys.FreeAndNil(LRecvPacket);
  end;
end;

procedure TIdFSP.SendCmd(const ACmd: Byte; const AData: TIdBYtes;
  const AFilePosition: Int64; var VData, VExtraData: TIdBytes; const ARaiseException : Boolean=True);
var LExtraData : TIdBytes;
begin
  SetLength(LExtraData,0);
  SendCmd(ACmd,AData,LExtraData,AFilePosition,VData,VExtraData, ARaiseException);
end;

procedure TIdFSP.Version;
var
  LData, LBuf, LExtraBuf : TIdBytes;
  LDetails : Byte;
begin
  SetLength(LData,0);
  {we use this instead of SendCmd because of the following note
  in the protocol specification

FILE SERVICE PROTOCOL VERSION 2, OFFICIAL PROTOCOL DEFINITION, FSP v2,
Document version 0.17, Last updated  25 Dec 2004
  (http://fsp.sourceforge.net/doc/PROTOCOL.txt):



Note

Some fsp servers do not responds to this command,
because this command is used by FSP scanners and
servers do not wishes to be detected.

  }

  SendCmdOnce(CC_VERSION,LData,LData,0,LBuf,LExtraBuf) ;
  if Length(LData)>0 then
  begin
    FSystemDesc := ParseASCIIZ( LBuf, Length(LBuf));
    if Length(LExtraBuf)>0 then
    begin
      LDetails := LExtraBuf[0];
      //bit 0 set - server does logging
      FSystemServerLogs := LDetails and $01=$01;
      //bit 1 set - server is read only
      FSystemReadOnly := LDetails and $02=$02;
      //bit 2 set - reverse lookup required
      FSystemReverseLookupRequired := LDetails and $04=$04;
    //bit 3 set - server is in private mode
      FSystemPrivateMode := LDetails and $08=$08;
    //  if bit 4 is set thruput info follows
      FThruputControl := LDetails and $10=$10;
    // bit 5 set - server accept XTRA
   //  DATA on input
      FSystemAcceptsExtraData := LDetails and $20=$20;
    //long - max_thruput allowed (in bytes/sec)
    //word - max. packet size supported by server
      if FThruputControl then
      begin
        if Length(LExtraBuf)>4 then
        begin
          CopyBytesToHostCardinal(LExtraBuf,1,FServerMaxThruPut);
          if Length(LExtraBuf)>6 then
          begin
            CopyBytesToHostWord(LExtraBuf,5,FServerMaxPacketSize);

          end;
        end;
      end
      else
      begin
        if Length(LExtraBuf)>2 then
        begin
          CopyBytesToHostWord(LExtraBuf,1,FServerMaxPacketSize);
        end;
      end;
    end;
  end;
end;

procedure TIdFSP.SendCmd(ACmdPacket, ARecvPacket: TIdFSPPacket; var VTempBuf : TIdBytes; const ARaiseException : Boolean=True);
var 
  LLen : Integer;
  LSendBuf : TIdBytes;
  LMSec : Integer;
begin
  Inc(FSequence);
  //we don't set the temp buff size here for speed.  
  ACmdPacket.Key := FKey;
  ACmdPacket.Sequence := FSequence;
  LMSec := MINTIMEOUT;
  LSendBuf := ACmdPacket.WritePacket;
    repeat
      SendBuffer(LSendBuf);

      if Assigned(FOnSend) then
      begin
        FOnSend(Self,ACmdPacket);
      end;

      LLen := ReceiveBuffer( VTempBuf, LMsec );

        ARecvPacket.ReadPacket(VTempBuf,LLen);
      

      if ARecvPacket.FValid then
      begin
        if Assigned(FOnRecv) then
        begin
          FOnRecv(Self,ARecvPacket);
        end;
        if (ARecvPacket.Sequence = FSequence) then
        begin
          break;
        end;
      end;

      LMSec := Round(LMSec * 1.5);
      if LMSec > MAXTIMEOUT then
      begin
        LMSec := MAXTIMEOUT;
      end;
    until False;
    FKey := ARecvPacket.Key;

    if ARaiseException and (ARecvPacket.Cmd = CC_ERR) then
    begin
      Raise EIdFSPProtException.Create( ParseASCIIZ(ARecvPacket.Data, ARecvPacket.DataLen));
    end;

end;

procedure TIdFSP.GetStatInfo(const APath: String);
var
  LData, LBuf,LExtraBuf : TIdBytes;
  i : Cardinal;
begin
  i := 0;
  LData := ToBytes(APath + #0);
  SendCmd(CC_STAT,LData,0,LBuf,LExtraBuf);
  if Length(LBuf)>8 then
  begin
{


data format is the same as in directory listing with exception
that there is no file name appended. If file do not exists or
there is other problem (no access rights) return type of file is
0.

        struct STAT  {
      long  time;
      long  size;
      byte  type;
}
     case LBuf[8] of
       0 : //file not found
       begin
         raise EIdFSPFileNotFound.Create(RSFSPNotFound );
       end;
       RDTYPE_FILE :
       begin
         FStatInfo.ItemType := ditFile;
       end;
       RDTYPE_DIR :
       begin
         FStatInfo.ItemType := ditDirectory;
       end;
     end;
     ParseStatInfo(LBuf,Self.FStatInfo,i);
  end;
end;

procedure TIdFSP.Put(const ASource: TIdStream2; const ADestFile: string;
  const AGMTTime: TIdDateTime);
var LUnixDate : Cardinal;
  LSendPacket : TIdFSPPacket;
  LRecvPacket :  TIdFSPPacket;
  LPosition : Cardinal;
  LLen : Integer;
  LTmpBuf : TIdBytes;
begin
  LPosition := 0;
  SetLength( LTmpBuf,MaxBufferSize);
  LSendPacket := TIdFSPPacket.Create;
  LRecvPacket :=  TIdFSPPacket.Create;
  try
    SetLength(LSendPacket.FData, PrefPayloadSize);
    LSendPacket.Cmd := CC_UP_LOAD;
    repeat
      LLen := ASource.Read(LSendPacket.FData,PrefPayloadSize,0);
      if LLen < PrefPayloadSize then
      begin
        if LLen = 0 then
        begin
          break;
        end;
      end;
      LSendPacket.FDataLen := LLen;
      LSendPacket.FilePosition := LPosition;

      SendCmd(LSendPacket,LRecvPacket,LTmpBuf);
      if LLen < PrefPayloadSize then
      begin
        break;
      end;
      inc(LPosition,LLen);
    until False;
    //send the Install packet
    LSendPacket.Cmd := CC_INSTALL;
    LSendPacket.FilePosition := 0;
    LSendPacket.Data := ToBytes(ADestFile+#0);
    LSendPacket.FDataLen := Length(LSendPacket.Data);
    //File date - optional
    if AGMTTime=0 then
    begin
      SetLength(LSendPacket.FExtraData ,0);
    end
    else
    begin
      LUnixDate := DateTimeToUnix(AGMTTime);
      SetLength(LSendPacket.FExtraData,4);
      CopyTIdNetworkCardinal(LUnixDate,LSendPacket.FExtraData,0);
    end;
    SendCmd(LSendPacket,LRecvPacket,LTmpBuf);
  finally
    Sys.FreeAndNil(LSendPacket);
    Sys.FreeAndNil(LRecvPacket);
  end;

end;



procedure TIdFSP.Put(const ASourceFile, ADestFile: string);
var
  LSourceStream: TIdStream2;
  LDestFileName : String;
begin
  LDestFileName := ADestFile;
  if LDestFileName = '' then
  begin
    LDestFileName := Sys.ExtractFileName(ASourceFile);
  end;
  LSourceStream := TReadFileNonExclusiveStream.Create(ASourceFile); try
    Put(LSourceStream, LDestFileName, GetGMTDateByName(ASourceFile) );
  finally Sys.FreeAndNil(LSourceStream); end;
end;

procedure TIdFSP.Delete(const AFilename: string);
var LData : TIdBytes;
  LBuf, LExBuf : TIdBytes;
begin
  LData := ToBytes(AFilename+#0);
  SendCmd(CC_DEL_FILE,LData,0,LBuf, LExBuf);
end;

procedure TIdFSP.MakeDir(const ADirName: string);
var LData : TIdBytes;
  LBuf, LExBuf : TIdBytes;
begin
  LData := ToBytes(ADirName+#0);
  SendCmd(CC_MAKE_DIR,LData,0,LBuf, LExBuf);
  ParseDirInfo(LBuf,LExBuf, FDirInfo);
end;

procedure TIdFSP.RemoveDir(const ADirName: string);
var LData : TIdBytes;
  LBuf, LExBuf : TIdBytes;
begin
  LData := ToBytes(ADirName+#0);
  SendCmd(CC_DEL_DIR,LData,0,LBuf, LExBuf);
end;

procedure TIdFSP.Rename(const ASourceFile, ADestFile: string);
var LBuf, LData, LDataExt : TIdBytes;
begin
   SetLength(LData,0);
   SetLength(LDataExt,0);
   LBuf := ToBytes(ASourceFile+#0+ADestFile);
   SendCmd(CC_RENAME,LBuf,0,LData,LDataExt);
end;

procedure TIdFSP.ParseDirInfo(const ABuf, AExtraBuf: TIdBytes; ADir : TIdFSPDirInfo);
begin
  ADir.ReadMe := ParseASCIIZ(ABuf,Length(ABuf));
  if Length(AExtraBuf)>0 then
  begin
    //0 - caller owns the directory
    ADir.OwnsDir        := AExtraBuf[0] and $01=$01;
    //1 - files can be deleted from this dir
    ADir.CanDeleteFiles := AExtraBuf[0] and $02=$02;
   // 2 - files can be added to this dir
    ADir.CanAddFiles    := AExtraBuf[0] and $04=$04;
    //3 - new subdirectories can be created
    ADir.CanMakeDir     := AExtraBuf[0] and $08=$08;
    //4 - files are NOT readable by non-owners
    ADir.OnlyOwnerCanReadFiles  := AExtraBuf[0] and $10=$10;
    //5 - directory contain an readme file
    ADir.HasReadMe      := AExtraBuf[0] and $20=$20;
    //6 - directory can be listed
    ADir.CanBeListed    := AExtraBuf[0] and $40=$40;
    //7 - files can be renamed in this directory
    ADir.CanRenameFiles := AExtraBuf[0] and $80=$80;
  end;
end;

procedure TIdFSP.GetDirInfo(const ADIR: String; ADirInfo: TIdFSPDirInfo);
var LData, LBuf, LExtraBuf : TIdBytes;
begin
  LData := ToBytes(ADIR+#0);
  SendCmd(CC_GET_PRO,LData,0,LBuf,LExtraBuf);
  ParseDirInfo(LBuf,LExtraBuf, ADirInfo );
end;

procedure TIdFSP.SendCmdOnce(ACmdPacket, ARecvPacket: TIdFSPPacket;
  var VTempBuf: TIdBytes; const ARaiseException: Boolean);
var 
  LLen : Integer;
  LBuf : TIdBytes;
  LSendBuf : TIdBytes;
//This is for where there may not be a reply to a command from a server.
begin
  Inc(FSequence);
  SetLength(LBuf,MaxBufferSize);
  ACmdPacket.Key := FKey;
  ACmdPacket.Sequence := FSequence;

  LSendBuf := ACmdPacket.WritePacket;
  SendBuffer(LSendBuf);

  if Assigned(FOnSend) then
  begin
    FOnSend(Self,ACmdPacket);
  end;
  repeat
    LLen := ReceiveBuffer( LBuf, MINTIMEOUT );
    if LLen=0 then
    begin
      break;
    end;
    ARecvPacket.ReadPacket(LBuf,LLen);

    if ARecvPacket.FValid then
    begin
      if Assigned(FOnRecv) then
      begin
        FOnRecv(Self,ARecvPacket);
      end;
      if (ARecvPacket.Sequence = FSequence) then
      begin
        FKey := ARecvPacket.Key;
        break;
      end;
    end;
  until False;

  if ARaiseException and (ARecvPacket.Cmd = CC_ERR) then
  begin
    Raise EIdFSPProtException.Create( ParseASCIIZ(ARecvPacket.Data, ARecvPacket.DataLen));
  end;

end;

procedure TIdFSP.SendCmdOnce(const ACmd: Byte; const AData,
  AExtraData: TIdBYtes; const AFilePosition: Int64; var VData,
  VExtraData: TIdBytes; const ARaiseException: Boolean);
var LSendPacket : TIdFSPPacket;
    LRecvPacket :  TIdFSPPacket;
    LTmpBuf : TIdBytes;
begin
  SetLength(LTmpBuf,MaxBufferSize);
  LSendPacket := TIdFSPPacket.Create;
   LRecvPacket :=  TIdFSPPacket.Create;
  try
    LSendPacket.Cmd := ACmd;
    LSendPacket.FilePosition := AFilePosition;
    LSendPacket.Data := AData;
    LSendPacket.FDataLen := Length(AData);
    LSendPacket.ExtraData := AExtraData;
    SendCmdOnce(LSendPacket,LRecvPacket,LTmpBuf,ARaiseException );
    VData := LRecvPacket.Data;
    VExtraData := LRecvPacket.ExtraData;

  finally
    Sys.FreeAndNil(LSendPacket);
    Sys.FreeAndNil(LRecvPacket);
  end;
end;

function TIdFSP.MaxBufferSize: Word;
//use only for calculating buffer for reading UDP packet

begin
  Result := Max(FClientMaxPacketSize,DEF_MAXSIZE);
  Result := Max(FServerMaxPacketSize,Result);
  Result := Result + HSIZE; //just in case
end;

function TIdFSP.PrefPayloadSize: Word;
//maximum size of the data feild we want to use
begin
  Result := Min( FClientMaxPacketSize,FServerMaxPacketSize);
  Result := Result - HSIZE;
end;

procedure TIdFSP.SetClientMaxPacketSize(const AValue: Word);
begin
//maximal size required by RFC
//note that 512 gives a payload of 500 bytes in a packet
  if AValue<512 then
  begin
    raise EIdFSPPacketTooSmall.Create(RSFSPPacketTooSmall);
  end;
  FClientMaxPacketSize := AValue;
end;

{ TIdFSPPacket }

constructor TIdFSPPacket.Create;
begin
  inherited Create;
  FCmd := 0;
  FFilePosition := 0;
  FDataLen := 0;
  SetLength(FData,0);
  SetLength(FExtraData,0);
  FSequence:=0;
  FKey:=0;
end;

function TIdFSPPacket.WritePacket : TIdBytes;
var
   LExtraDataLen : Word;
   LSum : Cardinal;
   i : Integer;
    LBuf : TIdBuffer;
//ported from:
//http://cvs.sourceforge.net/viewcvs.py/fsp/javalib/FSPpacket.java?rev=1.6&view=markup
begin

  LExtraDataLen := Length(FExtraData);
  LBuf := TIdBuffer.Create;
  try
    LBuf.Capacity := HSIZE+FDataLen+LExtraDataLen;
    //cmd
    LBuf.Write(Cmd,0);
    //checksum
    LBuf.Write(Byte(0),1);  //this will be the checksum value
    //key
    LBuf.Write(FKey,2);

    // sequence
    LBuf.Write(FSequence,4);

    // data length
    LBuf.Write(FDataLen,6);
    // position
    LBuf.Write(FFilePosition,8);
    //end of header section
    //data section
    if FDataLen >0 then
    begin
      LBuf.WriteLen(FData,FDataLen,HSIZE);
    end;

    //extra data section
    if LExtraDataLen>0 then
    begin
      LBuf.Write(FExtraData,HSIZE+FDataLen);
   //   CopyTIdBytes(FExtraData, 0,Result,HSIZE+FDataLen,LExtraDataLen);
    end;
    //checksum
    LSum := HSIZE + FDataLen + LExtraDataLen;
    for i := (HSIZE + FDataLen + LExtraDataLen) - 1 downto 0 do begin
  	  LSum:=LSum + (LBuf.ExtractToByte(i) and $FF);
    end;
    LBuf.Write(byte(LSum+(LSum shr 8)),1);
    //now write to result
    LBuf.ExtractToBytes(Result,-1,True);
  finally

    Sys.FreeAndNil(LBuf);
  end;
end;

procedure TIdFSPPacket.ReadPacket(const AData : TIdBytes; const ALen : Cardinal);
var
  LSum, LnSum, LcSum : Cardinal; //cardinal to prevent a range-check error
  t : Word;
  LExtraDataLen : Cardinal;
  LBuf : TIdBuffer;
begin
  LBuf := TIdBuffer.Create(AData,ALen);
  try
    FValid := True;
    if ALen<HSIZE then
    begin
      FValid := False;
      Sys.FreeAndNil(LBuf);
      Exit;
    end;
    //check data length
    FDataLen := LBuf.ExtractToWord(6);

  if FDataLen > Cardinal(LBuf.Size) then
  begin
    FValid := False;
  end;
  //validate checksum
  LSum := LBuf.ExtractToByte(1); //checksum
  LBuf.Write(Byte(0),1);//zero it out so we can verify the data
  LnSum := ALen;

  t:=Lnsum-1;
  Lnsum:=0;
  for t:=t downto 0 do begin
      Lnsum := Lnsum + (LBuf.ExtractToByte(t) and $FF);
  end;
  lcsum:=byte(Lnsum + (Lnsum shr 8));
  if LcSum <> LSum then
  begin
    FValid := False;
  end;
  //command
  FCmd := LBuf.ExtractToByte(0);
  //key
  FKey := LBuf.ExtractToWord(2);
  // sequence
  FSequence := LBuf.ExtractToWord(4);

  //6-7 are data length which was already processed
  //file position
  FFilePosition := LBuf.ExtractToCardinal(8);
  //extract data
  if FDataLen > 0 then
  begin
    LBuf.ExtractToBytes(FData,FDataLen,False,HSIZE);
  end
  else
  begin
    SetLength(FData,0);
  end;

  LExtraDataLen := ALen - (HSIZE+FDataLen);
  //extract extra data
  if LExtraDataLen>0 then
  begin
    LBuf.ExtractToBytes(FExtraData,LExtraDataLen,False,HSIZE+FDataLen);
  end
  else
  begin
    SetLength(FExtraData,0);
  end;
  finally
    Sys.FreeAndNil(LBuf);
  end;
end;

{ TIdFSPListItems }

function TIdFSPListItems.Add: TIdFSPListItem;
begin
  Result := TIdFSPListItem(inherited Add);
end;

constructor TIdFSPListItems.Create;
begin
  inherited Create(TIdFSPListItem);
end;

function TIdFSPListItems.GetItems(AIndex: Integer): TIdFSPListItem;
begin
  Result := TIdFSPListItem(inherited Items[AIndex]);
end;

function TIdFSPListItems.IndexOf(AItem: TIdFSPListItem): Integer;
Var
  i: Integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    if AItem = Items[i] then begin
      result := i;
      break;
    end;

end;

function TIdFSPListItems.ParseEntries(const AData: TIdBytes; const ADataLen : Cardinal) : Boolean;
var 
  i : Cardinal;
  LI : TIdFSPListItem;
  LSkip : Boolean;
  LFileName : String;
begin
  Result := False;
  i := 0;
  repeat
    if i < (ADataLen-9) then
    begin
      LI := nil;
      LSkip := False;
      case AData[i+8] of
        RDTYPE_END  :
        begin
          Result := True;
          Exit;
        end;
        RDTYPE_FILE :
        begin
          LI := Add;
          LI.ItemType := ditFile;
        end;
        RDTYPE_DIR  :
        begin
          LI := Add;
          LI.ItemType := ditDirectory;
        end;
        RDTYPE_SKIP :
        begin
          LSkip := True;
        end
      else
        Exit;
      end;
      if LSkip then
      begin
        i := i + 8;
      end
      else
      begin
        ParseStatInfo(AData,LI,i);
      end;
      if not LSkip then
      begin
        LFileName := '';
        repeat
          if i>=ADataLen then
          begin
            Break;
          end;
          if AData[i]=0 then
          begin
            break;
          end
          else
          begin
            LFileName := LFileName + Char(AData[i]);
          end;
          inc(i);
        until (i >= ADataLen);
        LI.FileName := LFileName;
      end;
      repeat
        inc(i);
      until (i and $03)=0;
    end
    else
    begin
      Exit;
    end;
  until False;
end;

procedure TIdFSPListItems.SetItems(AIndex: Integer; const Value: TIdFSPListItem);
begin
  inherited Items[AIndex] := Value;
end;

end.
