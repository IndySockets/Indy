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
  Rev 1.12    7/24/04 12:56:14 PM  RLebeau
  Compiler fix for Print(TIdBytes)

  Rev 1.11    7/23/04 7:15:16 PM  RLebeau
  Added extra exception handling to various Print...() methods

  Rev 1.10    2004.05.20 11:36:50 AM  czhower
  IdStreamVCL

  Rev 1.9    2004.03.03 11:54:32 AM  czhower
  IdStream change

  Rev 1.8    2004.02.03 5:43:56 PM  czhower
  Name changes

  Rev 1.7    1/21/2004 3:11:22 PM  JPMugaas
  InitComponent

  Rev 1.6    10/24/2003 02:54:52 PM  JPMugaas
  These should now work with the new code.

  Rev 1.5    2003.10.24 10:43:10 AM  czhower
  TIdSTream to dos

  Rev 1.4    2003.10.12 4:04:00 PM  czhower
  compile todos

  Rev 1.3    2/24/2003 09:07:26 PM  JPMugaas

  Rev 1.2    2/6/2003 03:18:08 AM  JPMugaas
  Updated components that compile with Indy 10.

  Rev 1.1    12/6/2002 05:30:18 PM  JPMugaas
  Now decend from TIdTCPClientCustom instead of TIdTCPClient.

  Rev 1.0    11/13/2002 07:56:22 AM  JPMugaas

  27.07. rewrite component for integration
   in Indy core library
}

unit IdLPR;

{
  Indy Line Print Remote TIdLPR
  Version 9.1.0
  Original author Mario Mueller
  home: www.hemasoft.de
  mail: babelfisch@daybyday.de
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdAssignedNumbers, IdGlobal, IdException, IdTCPClient,
  IdComponent, IdBaseComponent;

type
  TIdLPRFileFormat =
    (ffCIF, // CalTech Intermediate Form
     ffDVI, //   DVI (TeX output).
     ffFormattedText, //add formatting as needed to text file
     ffPlot, //   Berkeley Unix plot library
     ffControlCharText, //text file with control charactors
     ffDitroff, // ditroff output
     ffPostScript, //Postscript output file
     ffPR,//'pr' format    {Do not Localize}
     ffFORTRAM, // FORTRAN carriage control
     ffTroff, //Troff output
     ffSunRaster); //  Sun raster format file

const
  DEF_FILEFORMAT = ffControlCharText;
  DEF_INDENTCOUNT = 0;
  DEF_BANNERPAGE = False;
  DEF_OUTPUTWIDTH = 0;
  DEF_MAILWHENPRINTED = False;

type
  TIdLPRControlFile = class(TPersistent)
  protected
    FBannerClass: String;			// 'C'    {Do not Localize}
    FHostName: String;				// 'H'    {Do not Localize}
    FIndentCount: Integer;		// 'I'    {Do not Localize}
    FJobName: String;					// 'J'    {Do not Localize}
    FBannerPage: Boolean;			// 'L'    {Do not Localize}
    FUserName: String;					// 'P'    {Do not Localize}
    FOutputWidth: Integer;		// 'W'    {Do not Localize}

    FFileFormat : TIdLPRFileFormat;
    FTroffRomanFont : String; //substitue the Roman font with the font in file
    FTroffItalicFont : String;//substitue the Italic font with the font in file
    FTroffBoldFont : String;  //substitue the bold font with the font in file
    FTroffSpecialFont : String; //substitue the special font with the font
                                //in this file
    FMailWhenPrinted : Boolean; //mail me when you have printed the job
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property HostName: String read FHostName write FHostName;
  published
    property BannerClass: String read FBannerClass write FBannerClass;
    property IndentCount: Integer read FIndentCount write FIndentCount default DEF_INDENTCOUNT;
    property JobName: String read FJobName write FJobName;
    property BannerPage: Boolean read FBannerPage write FBannerPage default DEF_BANNERPAGE;
    property UserName: String read FUserName write FUserName;
    property OutputWidth: Integer read FOutputWidth write FOutputWidth default DEF_OUTPUTWIDTH;
    property FileFormat: TIdLPRFileFormat read FFileFormat write FFileFormat default DEF_FILEFORMAT;
    {font data }
    property TroffRomanFont : String read FTroffRomanFont write FTroffRomanFont;
    property TroffItalicFont : String read FTroffItalicFont write FTroffItalicFont;
    property TroffBoldFont : String read FTroffBoldFont write FTroffBoldFont;
    property TroffSpecialFont : String read FTroffSpecialFont write FTroffSpecialFont;
    {misc}
    property MailWhenPrinted : Boolean read FMailWhenPrinted write FMailWhenPrinted default DEF_MAILWHENPRINTED;
  end;

type
  TIdLPRStatus = (psPrinting, psJobCompleted, psError, psGettingQueueState,
    psGotQueueState, psDeletingJobs, psJobsDeleted, psPrintingWaitingJobs,
    psPrintedWaitingJobs);

type
  TIdLPRStatusEvent = procedure(ASender: TObject;
    const AStatus: TIdLPRStatus;
    const AStatusText: String) of object;

type
  TIdLPR = class(TIdTCPClientCustom)
  protected
    FOnLPRStatus: TIdLPRStatusEvent;
    FQueue: String;
    FJobId: Integer;
    FControlFile: TIdLPRControlFile;
    procedure DoOnLPRStatus(const AStatus: TIdLPRStatus;
    const AStatusText: String);
    procedure SeTIdLPRControlFile(const Value: TIdLPRControlFile);
    procedure CheckReply;
    function GetJobId: String;
    procedure SetJobId(const Value: String);
    procedure InternalPrint(Data: TStream);
    function GetControlData: String;
    procedure InitComponent; override;
  public
    {$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
    constructor Create(AOwner: TComponent); reintroduce; overload;
    {$ENDIF}
    destructor Destroy; override;
    procedure Connect; override;
    procedure Print(const AText: String); overload;
    procedure Print(const ABuffer: TIdBytes); overload;
    procedure PrintFile(const AFileName: String);
    function GetQueueState(const AShortFormat: Boolean = False; const AList : String = '') : String;    {Do not Localize}
    procedure PrintWaitingJobs;
    procedure RemoveJobList(const AList: String; const AAsRoot: Boolean = False);
    property JobId: String read GetJobId write SetJobId;
  published
    property Queue: String read FQueue write FQueue;
    property ControlFile: TIdLPRControlFile read FControlFile write SeTIdLPRControlFile;
    property Host;
    property Port default IdPORT_LPD;
    property OnLPRStatus: TIdLPRStatusEvent read FOnLPRStatus write FOnLPRStatus;
  end;

type
  EIdLPRErrorException = class(EIdException);

implementation

uses
  {$IFDEF DOTNET}
  IdStreamNET,
  {$ELSE}
  IdStreamVCL,
  {$ENDIF}
  IdGlobalProtocols, IdResourceStringsProtocols, IdStack, IdStackConsts,
  SysUtils;

{ TIdLPR }

{$IFDEF WORKAROUND_INLINE_CONSTRUCTORS}
constructor TIdLPR.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
{$ENDIF}

procedure TIdLPR.InitComponent;
begin
  inherited InitComponent;

  Port := IdPORT_LPD;
  Queue := 'pr1';    {Do not Localize}
  FJobId := 1;
  FControlFile := TIdLPRControlFile.Create;

  // Restriction in RFC 1179
  // The source port must be in the range 721 to 731, inclusive.

  BoundPortMin := 721;
  BoundPortMax := 731;
end;

procedure TIdLPR.Connect;
var
  LPort: TIdPort;
begin
  // RLebeau 3/7/2010: there is a problem on Windows where sometimes it will
  // not raise a WSAEADDRINUSE error in TIdSocketHandle.TryBind(), but will
  // delay it until TIdSocketHandle.Connect() instead.  So we will loop here
  // to force a Connect() on each port, rather than let TIdSocketHandle do
  // the looping in BindPortReserved().  If this logic proves useful in other
  // protocols, we can move it into TIdSocketHandle later on...

  // AWinkelsdorf 3/9/2010: Implemented, adjusted to use BoundPortMax and
  // BoundPortMin

  // looping backwards because that is what TIdSocketHandle.BindPortReserved() does
  for LPort := BoundPortMax downto BoundPortMin do
  begin
    BoundPort := LPort;
    try
      inherited Connect;
      Exit;
    except
      on E: EIdCouldNotBindSocket do begin end;
      on E: EIdSocketError do begin
        if E.LastError <> Id_WSAEADDRINUSE then begin
          raise;
        end;
        // Socket already in use, cleanup and try again with the next
        Disconnect;
      end;
    end;
  end;

  // no local ports could be bound successfully
  raise EIdCanNotBindPortInRange.CreateFmt(RSCannotBindRange, [BoundPortMin, BoundPortMax]);
end;

procedure TIdLPR.Print(const AText: String);
var
  LStream: TStream;
  LEncoding: IIdTextEncoding;
begin
  LStream := TMemoryStream.Create;
  try
    LEncoding := IndyTextEncoding_8Bit;
    WriteStringToStream(LStream, AText, LEncoding{$IFDEF STRING_IS_ANSI}, LEncoding{$ENDIF});
    LEncoding := nil;
    LStream.Position := 0;
    InternalPrint(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdLPR.Print(const ABuffer: TIdBytes);
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    WriteTIdBytesToStream(LStream, ABuffer);
    LStream.Position := 0;
    InternalPrint(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TIdLPR.PrintFile(const AFileName: String);
var
  LStream: TIdReadFileExclusiveStream;
  p: Integer;
begin
  p := RPos(GPathDelim, AFileName);
  ControlFile.JobName := Copy(AFileName, p+1, Length(AFileName)-p);
  LStream := TIdReadFileExclusiveStream.Create(AFileName);
  try
    InternalPrint(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

function TIdLPR.GetJobId: String;
begin
  Result := IndyFormat('%.3d', [FJobId]);    {Do not Localize}
end;

procedure TIdLPR.SetJobId(const Value: String);
var
  I: Integer;
begin
  I := IndyStrToInt(Value);
  if I < 999 then begin
    FJobId := I;
  end;
end;

procedure TIdLPR.InternalPrint(Data: TStream);
begin
  try
    if not Connected then begin
      Exit;
    end;
    Inc(FJobID);
    if FJobID > 999 then begin
      FJobID := 1;
    end;
    DoOnLPRStatus(psPrinting, JobID);
    try
      ControlFile.HostName := GStack.HostName
    except
      ControlFile.HostName := 'localhost';    {Do not Localize}
    end;

    // Receive a printer job
    IOHandler.Write(#02 + Queue + LF);
    CheckReply;
    // Receive control file
    IOHandler.Write(#02 + IntToStr(Length(GetControlData)) + ' cfA' + JobId + ControlFile.HostName + LF);    {Do not Localize}
    CheckReply;
    // Send control file
    IOHandler.Write(GetControlData);
    IOHandler.Write(#0);
    CheckReply;
    // Send data file
    IOHandler.Write(#03 + IntToStr(Data.Size) +	' dfA'  + JobId + ControlFile.HostName + LF);   {Do not Localize}
    CheckReply;
    // Send data
    IOHandler.Write(Data);
    IOHandler.Write(#0);
    CheckReply;
    DoOnLPRStatus(psJobCompleted, JobID);
  except
    on E: Exception do begin
      DoOnLPRStatus(psError, E.Message);
    end;
  end;
end;

function TIdLPR.GetQueueState(const AShortFormat: Boolean = False; const AList : String = '') : String;    {Do not Localize}
begin
  DoOnLPRStatus(psGettingQueueState, AList);
  if AShortFormat then begin
    IOHandler.Write(#03 + Queue + ' ' + AList + LF)    {Do not Localize}
  end else begin
    IOHandler.Write(#04 + Queue + ' ' + AList + LF);    {Do not Localize}
  end;
//  This was the original code - problematic as this is more than one line
//  read until I close the connection
//  result:=ReadLn(LF);
  Result := IOHandler.AllData;
  DoOnLPRStatus(psGotQueueState, result);
end;

function TIdLPR.GetControlData: String;
var
  Data: String;
begin
  Data := '';    {Do not Localize}
  try
    // H - Host name
    Data := Data + 'H' + FControlFile.HostName + LF;    {Do not Localize}
    // P - User identification
    Data := Data + 'P' + FControlFile.UserName + LF;    {Do not Localize}
    // J - Job name for banner page
    if Length(FControlFile.JobName) > 0 then begin
      Data := Data + 'J' + FControlFile.JobName + LF;    {Do not Localize}
    end else begin
      Data := Data + 'JcfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
    end;
    //mail when printed
    if FControlFile.FMailWhenPrinted then begin
      Data := Data + 'M' + FControlFile.UserName + LF;    {Do not Localize}
    end;
    case FControlFile.FFileFormat of
       ffCIF : // CalTech Intermediate Form
       begin
         Data := Data + 'cdfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffDVI : //   DVI (TeX output).
       begin
         Data := Data + 'ddfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffFormattedText : //add formatting as needed to text file
       begin
         Data := Data + 'fdfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffPlot : //   Berkeley Unix plot library
       begin
         Data := Data + 'gdfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffControlCharText : //text file with control charactors
       begin
         Data := Data + 'ldfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffDitroff : // ditroff output
       begin
         Data := Data + 'ndfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffPostScript : //Postscript output file
       begin
         Data := Data + 'odfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffPR : //'pr' format    {Do not Localize}
       begin
         Data := Data + 'pdfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffFORTRAM : // FORTRAN carriage control
       begin
         Data := Data + 'rdfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffTroff : //Troff output
       begin
         Data := Data + 'ldfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}
       end;
       ffSunRaster : //  Sun raster format file
       begin
       end;
    end;
    // U - Unlink data file
    Data := Data + 'UdfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}

    // N - Name of source file
    Data := Data + 'NcfA' + JobId + FControlFile.HostName + LF;    {Do not Localize}

    if FControlFile.FFileFormat = ffFormattedText then begin
      if FControlFile.IndentCount > 0 then begin
        Data := Data + 'I' + IntToStr(FControlFile.IndentCount) + LF;    {Do not Localize}
      end;
      if FControlFile.OutputWidth > 0 then begin
        Data := Data + 'W' + IntToStr(FControlFile.OutputWidth) + LF;    {Do not Localize}
      end;
    end;
    if Length(FControlFile.BannerClass) > 0 then begin
      Data := Data + 'C' + FControlFile.BannerClass + LF;    {Do not Localize}
    end;
    if FControlFile.BannerPage then begin
      Data := Data + 'L' + FControlFile.UserName + LF;    {Do not Localize}
    end;
    if Length(FControlFile.TroffRomanFont) > 0 then begin
      Data := Data + '1' + FControlFile.TroffRomanFont + LF;    {Do not Localize}
    end;
    if Length(FControlFile.TroffItalicFont) > 0 then begin
      Data := Data + '2' + FControlFile.TroffItalicFont + LF;    {Do not Localize}
    end;
    if Length(FControlFile.TroffBoldFont) > 0 then begin
      Data := Data + '3' + FControlFile.TroffBoldFont + LF;    {Do not Localize}
    end;
    if Length(FControlFile.TroffSpecialFont) > 0 then begin
      Data := Data + '4' + FControlFile.TroffSpecialFont + LF;    {Do not Localize}
    end;
    Result := Data;
  except
    Result := 'error';    {Do not Localize}
  end;
end;

procedure TIdLPR.SeTIdLPRControlFile(const Value: TIdLPRControlFile);
begin
  FControlFile.Assign(Value);
end;

destructor TIdLPR.Destroy;
begin
  FreeAndNil(FControlFile);
  inherited Destroy;
end;

procedure TIdLPR.PrintWaitingJobs;
begin
  try
    DoOnLPRStatus(psPrintingWaitingJobs, '');    {Do not Localize}
    IOHandler.Write(#03 + Queue + LF);
    CheckReply;
    DoOnLPRStatus(psPrintedWaitingJobs, '');    {Do not Localize}
  except
    on E: Exception do begin
      DoOnLPRStatus(psError, E.Message);
    end;
  end;
end;

procedure TIdLPR.RemoveJobList(const AList: String; const AAsRoot: Boolean = False);
begin
  try
    DoOnLPRStatus(psDeletingJobs, JobID);
    if AAsRoot then begin
      {Only root can delete other people's print jobs}    {Do not Localize}
      IOHandler.Write(#05 + Queue + ' root ' + AList + LF);    {Do not Localize}
    end else begin
      IOHandler.Write(#05 + Queue + ' ' + ControlFile.UserName + ' ' + AList + LF);    {Do not Localize}
    end;
    CheckReply;
    DoOnLPRStatus(psJobsDeleted, JobID);
  except
    on E: Exception do begin
      DoOnLPRStatus(psError, E.Message);
    end;
  end;
end;

procedure TIdLPR.CheckReply;
var
  Ret : Byte;
begin
  Ret := IOHandler.ReadByte;
  if Ret <> $00 then begin
    raise EIdLPRErrorException.CreateFmt(RSLPRError, [Integer(Ret), JobID]);
  end;
end;

procedure TIdLPR.DoOnLPRStatus(const AStatus: TIdLPRStatus; const AStatusText: String);
begin
  if Assigned(FOnLPRStatus) then begin
    FOnLPRStatus(Self, AStatus, AStatusText);
  end;
end;

{ TIdLPRControlFile }
procedure TIdLPRControlFile.Assign(Source: TPersistent);
var
  cnt : TIdLPRControlFile;
begin
  if Source is TIdLPRControlFile then
  begin
    cnt := Source as TIdLPRControlFile;
    FBannerClass := cnt.BannerClass;
    FIndentCount := cnt.IndentCount;
    FJobName := cnt.JobName;
    FBannerPage := cnt.BannerPage;
    FUserName := cnt.UserName;
    FOutputWidth := cnt.OutputWidth;
    FFileFormat := cnt.FileFormat;
    FTroffRomanFont := cnt.TroffRomanFont;
    FTroffItalicFont := cnt.TroffItalicFont;
    FTroffBoldFont := cnt.TroffBoldFont;
    FTroffSpecialFont := cnt.TroffSpecialFont;
    FMailWhenPrinted := cnt.MailWhenPrinted;
  end else begin
    inherited Assign(Source);
  end;
end;

constructor TIdLPRControlFile.Create;
begin
  inherited Create;
  try
    HostName := GStack.HostName;
  except
    HostName := RSLPRUnknown;   
  end;
  FFileFormat := DEF_FILEFORMAT;
  FIndentCount := DEF_INDENTCOUNT;
  FBannerPage := DEF_BANNERPAGE;
  FOutputWidth := DEF_OUTPUTWIDTH;
end;

end.
