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
  Rev 1.13    10/26/2004 9:09:36 PM  JPMugaas
    Updated references.

  Rev 1.12    24/10/2004 21:25:18  ANeillans
    Modifications to allow Username and Domain parts to be set.

  Rev 1.11    24.08.2004 17:29:30  Andreas Hausladen
    Fixed GetEMailAddresses
    Lots of simple but effective optimizations

  Rev 1.10    09/08/2004 08:17:08  ANeillans
    Rename username property to user

  Rev 1.9    08/08/2004 20:58:02  ANeillans
    Added support for Username extraction.

  Rev 1.8    23/04/2004 20:34:36  CCostelloe
    Clarified a question in the code as to why a code path ended there

  Rev 1.7    3/6/2004 5:45:00 PM  JPMugaas
    Fixed problem obtaining the Text property for an E-Mail address with
    no domain.

  Rev 1.6    2004.02.03 5:45:08 PM  czhower
      Name changes

  Rev 1.5    24/01/2004 19:12:10  CCostelloe
    Cleaned up warnings

  Rev 1.4    10/12/2003 7:51:50 PM  BGooijen
    Fixed Range Check Error

  Rev 1.3    10/8/2003 9:50:24 PM  GGrieve
    use IdDelete

  Rev 1.2    6/10/2003 5:48:50 PM  SGrobety
    DotNet updates

  Rev 1.1    5/18/2003 02:30:36 PM  JPMugaas
    Added some backdoors for the TIdDirectSMTP processing.

  Rev 1.0    11/14/2002 02:19:44 PM  JPMugaas

  2001-Aug-30 - Jim Gunkel
      Fixed bugs that would occur with group names containing spaces
      (box test 19) and content being located after the email
      address (box test 33)

  2001-Jul-11 - Allen O'Neill
      Added hack to not allow recipient entries being added that are blank

  2001-Jul-11 - Allen O'Neill
      Added hack to accomodate a PERIOD (#46) in an email address -
      this whole area needs to be looked at.

  2001-Feb-03 - Peter Mee
      Overhauled TIdEMailAddressItem.GetText to support non-standard textual
      elements.

  2001-Jan-29 - Peter Mee
      Overhauled TIdEMailAddressList.SetEMailAddresses to support comments
      and escaped characters and to ignore groups.

  2001-Jan-28 - Peter Mee
      Overhauled TIdEMailAddressItem.SetText to support comments and escaped
      characters.

  2000-Jun-10 - J. Peter Mugaas
      started this unit to facilitate some Indy work including the
      TIdEMailAddressItem and TIdEMailAddressList classes

      The GetText and SetText were originally the ToArpa and FromArpa
      functions in the TIdMessage component
}

unit IdEMailAddress;

{
  Developer(s):
    J. Peter Mugaas

  Contributor(s):
    Ciaran Costelloe
    Bas Gooijen
    Grahame Grieve
    Stephane Grobety
    Jim Gunkel
    Andreas Hausladen
    Peter Mee
    Andy Neillans
    Allen O'Neill
}

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdException;

type
   EIdEmailParseError = class(EIdException);

   { ToDo: look into alterations required for TIdEMailAddressItem.GetText }
   TIdEMailAddressItem = class(TCollectionItem)
   protected
     FAddress: string;
     FName: string;
     function GetText: string;
     procedure SetText(AText: string);
     function ConvertAddress: string;
     function GetDomain: string;
     procedure SetDomain(const ADomain: String);
     function GetUsername: string;
     procedure SetUsername(const AUsername: String);
   public
     procedure Assign(Source: TPersistent); override;
     constructor Create; reintroduce; overload;
     constructor Create(ACollection: TCollection); overload; override;
     constructor Create(const AText: string); reintroduce; overload;
   published
     {This is the E-Mail address itself }
     property Address: string read FAddress write FAddress;
     { This is the person's name }
     property Name: string read FName write FName;
     { This is the combined person's name and E-Mail address }
     property Text: string read GetText write SetText;
     {Extracted domain for some types of E-Mail processing}
     property Domain: string read GetDomain write SetDomain;
     property User: string read GetUsername write SetUsername;
   end;

   TIdEMailAddressList = class (TOwnedCollection)
   protected
     function GetItem(Index: Integer): TIdEMailAddressItem;
     procedure SetItem(Index: Integer; const Value: TIdEMailAddressItem);
     function GetEMailAddresses: string;
     procedure SetEMailAddresses(AList: string);
   public
     constructor Create(AOwner: TPersistent); reintroduce;
     { List of formated addresses including the names from the collection }
     procedure FillTStrings(AStrings: TStrings);
     function Add: TIdEMailAddressItem; reintroduce;
     procedure AddItems(AList: TIdEMailAddressList);
     { get all of the domains in the list so we can process individually }
     procedure GetDomains(AStrings: TStrings);
     { Sort by domains for making it easier to process E-Mails directly }
     procedure SortByDomain;
     { Gets all E-Mail addresses for a particular domain so we can
       send to recipients at one domain with only one connection }
     procedure AddressesByDomain(AList: TIdEMailAddressList; const ADomain: string);
     property Items[Index: Integer]: TIdEMailAddressItem read GetItem write SetItem; default;
     { Comma-separated list of formated addresses including the names
       from the collection }
     property EMailAddresses: string read GetEMailAddresses write SetEMailAddresses;
   end;

implementation

uses
  IdGlobal,
  IdGlobalProtocols,
  IdExceptionCore,
  IdResourceStringsProtocols, SysUtils;

const
  // ATEXT without the double quote and space characters
  IETF_ATEXT: string = 'abcdefghijklmnopqrstuvwxyz' + {do not localize}
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +                    {do not localize}
    '1234567890!#$%&''*+-/=?_`{}|~';                  {do not localize}

  // ATEXT without the double quote character
  IETF_ATEXT_SPACE: string = 'abcdefghijklmnopqrstuvwxyz' + {do not localize}
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +                          {do not localize}
    '1234567890!#$%&''*+-/=?_`{}|~ ';                       {do not localize}

  IETF_QUOTABLE: string = '\"'; {do not localize}

{ TIdEMailAddressItem }

constructor TIdEMailAddressItem.Create;
begin
  inherited Create(nil);
end;

constructor TIdEMailAddressItem.Create(ACollection: TCollection);
begin
  inherited Create(ACollection);
end;

constructor TIdEMailAddressItem.Create(const AText: string);
begin
  inherited Create(nil);
  Text := AText;
end;

procedure TIdEMailAddressItem.Assign(Source: TPersistent);
var
  LAddr : TIdEMailAddressItem;
begin
  if Source is TIdEMailAddressItem then begin
    LAddr := TIdEMailAddressItem(Source);
    Address := LAddr.Address;
    Name := LAddr.Name;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIdEMailAddressItem.ConvertAddress: string;
var
  i: Integer;
  domainPart, tempAddress, localPart: string;
begin
  if FAddress = '' then
  begin
    if FName <> '' then
    begin
      Result := '<>';   {Do not Localize}
    end else
    begin
      Result := ''; {Do not Localize}
    end;
    Exit;
  end;

  // First work backwards to the @ sign.
  tempAddress := FAddress;
  domainPart := '';
  for i := Length(FAddress) downto 1 do
  begin
    if FAddress[i] = '@' then {do not localize}
    begin
      domainPart := Copy(FAddress, i, MaxInt);
      tempAddress := Copy(FAddress, 1, i - 1);
      Break;
    end;
  end;

  i := FindFirstNotOf(IETF_ATEXT, tempAddress);
  // hack to accomodate periods in emailaddress
  if (i = 0) or CharEquals(tempAddress, i, #46) then
  begin
    if FName <> '' then begin
      Result := '<' + tempAddress + domainPart + '>'; {do not localize}
    end else begin
      Result := tempAddress + domainPart;
    end;
  end else
  begin
    localPart := '"';    {do not localize}
    while i > 0 do
    begin
      localPart := localPart + Copy(tempAddress, 1, i - 1);
      if IndyPos(tempAddress[i], IETF_QUOTABLE) > 0 then
      begin
        localPart := localPart + '\'; {do not localize}
      end;
      localPart := localPart + tempAddress[i];
      IdDelete(tempAddress, 1, i);
      i := FindFirstNotOf(IETF_ATEXT, tempAddress);
    end;
    Result := '<' + localPart + tempAddress + '"' + domainPart + '>'; {do not localize}
  end;
end;

function TIdEMailAddressItem.GetDomain: string;
var
  i: Integer;
begin
  Result := '';
  // TODO: use RPos() or LastDelimiter() instead of a manual loop...
  for i := Length(FAddress) downto 1 do
  begin
    if FAddress[i] = '@' then {do not localize}
    begin
      Result := Copy(FAddress, i + 1, MaxInt);
      Break;
    end;
  end;
end;

procedure TIdEMailAddressItem.SetDomain(const ADomain: String);
var
 S : String;
 lPos: Integer;
begin
  S := FAddress;
  // keep existing user info in the address... use new domain info
  lPos := IndyPos('@', S); {do not localize}
  if lPos > 0 then begin
    IdDelete(S, lPos, Length(S));
  end;
  FAddress := S + '@' + ADomain; {do not localize}
end;

function TIdEMailAddressItem.GetUsername: string;
var
  i: Integer;
begin
  Result := '';
  for i := Length(FAddress) downto 1 do
  begin
    if FAddress[i] = '@' then {do not localize}
    begin
      Result := Copy(FAddress, 1, i - 1);
      Break;
    end;
  end;
end;

procedure TIdEMailAddressItem.SetUsername(const AUsername: String);
var
 S : String;
 lPos: Integer;
begin
  S := FAddress;
  // discard old user info... keep existing domain in the address
  lPos := IndyPos('@', S);
  if lPos > 0 then begin
    IdDelete(S, 1, lPos); {do not localize}
  end;
  FAddress := AUsername + '@' + S;
end;

function TIdEMailAddressItem.GetText: string;
var
  i: Integer;
  tempName, resName: string;
begin
  if (FName <> '') and (not TextIsSame(FAddress, FName)) then
  begin
    i := FindFirstNotOf(IETF_ATEXT_SPACE, FName);
    if i > 0 then
    begin
      // Need to quote the FName.
      resName := '"' + Copy(FName, 1, i - 1);  {do not localize}
      if IndyPos(FName[i], IETF_QUOTABLE) > 0 then
      begin
        resName := resName + '\'; {do not localize}
      end;
      resName := resName + FName[i];
      tempName := Copy(FName, i + 1, MaxInt);
      while tempName <> '' do
      begin
        i := FindFirstNotOf(IETF_ATEXT_SPACE, tempName);
        if i = 0 then
        begin
          Result := resName + tempName + '" ' + ConvertAddress; {do not localize}
          Exit;
        end;
        resName := resName + Copy(tempName, 1, i - 1);
        if IndyPos(tempName[i], IETF_QUOTABLE) > 0 then
        begin
          resName := resName + '\';   {do not localize}
        end;
        resName := resName + tempName[i];
        IdDelete(tempName, 1, i);
      end;
      Result := resName + '" ' + ConvertAddress; {do not localize}
    end else
    begin
      Result := FName + ' ' + ConvertAddress; {do not localize}
    end;
  end else
  begin
    Result := ConvertAddress;
  end;
end;

procedure TIdEMailAddressItem.SetText(AText: string);
var
  nFirst,
  nBracketCount: Integer;
  bInAddress,
  bAddressInLT,
  bAfterAt,
  bInQuote : Boolean;
begin
  FAddress := '';
  FName := '';

  AText := Trim(AText);
  if AText = '' then begin
    Exit;
  end;

  // Find the first known character type.
  if Pos('<', AText) > 0 then begin
    nFirst := FindFirstOf('("< ' + TAB, AText)   {Do not Localize}
  end else begin
    nFirst := FindFirstOf('(" @' + TAB, AText);   {Do not Localize}
  end;

  if nFirst <> 0 then
  begin
    nBracketCount := 0;
    bInAddress := False;
    bAddressInLT := False;
    bInQuote := False;
    bAfterAt := False;
    repeat
      case AText[nFirst] of
        ' ', TAB : {do not localize}
        begin
          if nFirst = 1 then
          begin
            IdDelete(AText, 1, 1);
          end else
          begin
            // Only valid if in a name not contained in quotes - keep the space.
            if bAfterAt then begin
              FAddress := FAddress + Trim(Copy(AText, 1, nFirst - 1));
            end else begin
              FName := FName + Copy(AText, 1, nFirst);
            end;
            IdDelete(AText, 1, nFirst);
          end;
        end;
        '(' : {do not localize}
        begin
          Inc(nBracketCount);
          if nFirst > 1 then
          begin
            // There's at least one character to the name
            if bInAddress then
            begin
              FAddress := FAddress + Trim(Copy(AText, 1, nFirst - 1));
            end
            else if nBracketCount = 1 then
            begin
              FName := FName + Copy(AText, 1, nFirst - 1);
            end;
            IdDelete(AText, 1, nFirst);
          end else
          begin
            IdDelete(AText, 1, 1);
          end;
        end;
        ')' : {do not localize}
        begin
          Dec(nBracketCount);
          IdDelete(AText, 1, nFirst);
        end;
        '"' : {do not localize}
        begin
          if bInQuote then
          begin
            if bAddressInLT then
            begin
              FAddress := FAddress + Trim(Copy(AText, 1, nFirst - 1));
            end else begin
              FName := FName + Trim(Copy(AText, 1, nFirst - 1));
            end;
            IdDelete(AText, 1, nFirst);
            bInQuote := False;
          end else
          begin
            bInQuote := True;
            IdDelete(AText, 1, 1);
          end;
        end;
        '<' : {do not localize}
        begin
          if nFirst > 1 then
          begin
            FName := FName + Copy(AText, 1, nFirst - 1);
          end;
          FName := TrimAllOf(' ' + TAB, Trim(FName));  {do not localize}
          bAddressInLT := True;
          bInAddress := True;
          IdDelete(AText, 1, nFirst);
        end;
        '>' : {do not localize}
        begin
          // Only searched for if the address starts with '<'
          bInAddress := False;
          bAfterAt := False;
          FAddress := FAddress + TrimAllOf(' ' + TAB,   {do not localize}
            Trim(Copy(AText, 1, nFirst - 1)));
          IdDelete(AText, 1, nFirst);
        end;
        '@' : {do not localize}
        begin
          bAfterAt := True;
          if bInAddress then
          begin
            FAddress := FAddress + Copy(AText, 1, nFirst);
            IdDelete(AText, 1, nFirst);
          end else
          begin
            if bAddressInLT then
            begin
              {
                Strange use. For now raise an exception until a real-world
                example can be found.

                Basically, it's formatted as follows:
                  <someguy@domain.example> some-text @ some-text
                or:
                  some-text <someguy@domain.example> some-text @ some-text

                where some text may be blank.  Note you used to arrive here
                if the From header in an email included more than one address
                (which was subsequently changed) because our code did not
                parse the From header for multiple addresses.  That may have
                been the reason for this code.
              }
              //raise EIdEmailParseError.Create(RSEMailSymbolOutsideAddress);
              FName := FName + AText;
              Exit;
            end;
            {
              at this point, we're either supporting an e-mail address on
              it's own, or the old-style valid format:

              "Name" name@domain.example
            }
            bInAddress := True;
            FAddress := FAddress + Copy(AText, 1, nFirst);
            IdDelete(AText, 1, nFirst);
          end;
        end;
        '.' : {do not localize}
        begin
          // Must now be a part of the domain part of the address.
          if bAddressInLT then
          begin
            // Whitespace is possible around the parts of the domain.
            FAddress := FAddress +
              TrimAllOf(' ' + TAB, Trim(Copy(AText, 1, nFirst - 1))) + '.'; {do not localize}
            AText := TrimLeft(Copy(AText, nFirst + 1, MaxInt));
          end else
          begin
            // No whitespace is allowed if no wrapping <> characters.
            FAddress := FAddress + Copy(AText, 1, nFirst);
            IdDelete(AText, 1, nFirst);
          end;
        end;
        '\' : {do not localize}
        begin
          {
            This will only be discovered in a bracketed or quoted section.
            It's an escape character indicating the next character is a literal.
          }
          if bInQuote then
          begin
            // Need to retain the second character
            if bInAddress then
            begin
              FAddress := FAddress + Copy(AText, 1, nFirst - 1);
              FAddress := FAddress + AText[nFirst + 1];
            end else
            begin
              FName := FName + Copy(AText, 1, nFirst - 1);
              FName := FName + AText[nFirst + 1];
            end;
          end;
          IdDelete(AText, 1, nFirst + 1);
        end;
      end;
      {
        Check for bracketted sections first:
          ("<>" <> "" <"">) - all is ignored
      }
      if nBracketCount > 0 then
      begin
        {
          Inside a bracket, only three characters are special.
            '('    Opens a nested bracket: (One (Two (Three )))
            ')'   Closes a bracket
            '\'   Escape character: (One \) \( \\ (Two \) ))
         }
        nFirst := FindFirstOf('()\', AText);   {do not localize}

      // Check if in quote before address: <"My Name"@domain.example> is valid
      end else if bInQuote then
      begin
      // Inside quotes, only the end quote and escape character are special.

        // previously FindFirst. This fixes a bug in From: like: "This is "my" name" <address@domain.com> delivered from DecodeHeader
        nFirst := LastDelimiter('"\', AText); {do not localize}

      // Check if after the @ of the address: domain.example>
      end else if bAfterAt then
      begin
        if bAddressInLT then
        begin
          {
            If the address is enclosed, then only the '(', '.' & '>'
            need be looked for, trimming all content when found:
              domain  .  example >
          }
          nFirst := FindFirstOf('.>(', AText);     {do not localize}
        end else begin
          nFirst := FindFirstOf('.( ', AText);  {Do not Localize}
        end;

      // Check if in address: <name@domain.example>
      end else if bInAddress then
      begin
        nFirst := FindFirstOf('"(@>', AText); {do not localize}

      // Not in anything - check for opening character
      end else
      begin
        // Outside brackets
        nFirst := FindFirstOf('("< @' + TAB, AText);  {do not localize}
      end;
    until nFirst = 0;
    if bInAddress and (not bAddressInLT) then
    begin
      FAddress := FAddress + TrimAllOf(' ' + TAB, Trim(AText)); {do not localize}
    end;
  end else
  begin
    // No special characters, so assume a simple address
    FAddress := AText;
  end;
end;

{ TIdEMailAddressList }

constructor TIdEMailAddressList.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdEMailAddressItem);
end;

function TIdEMailAddressList.Add: TIdEMailAddressItem;
begin
  Result := TIdEMailAddressItem(inherited Add);
end;

procedure TIdEMailAddressList.AddItems(AList: TIdEMailAddressList);
var
  I: Integer;
begin
  if AList <> nil then begin
    for I := 0 to AList.Count-1 do begin
      Add.Assign(AList[I]);
    end;
  end;
end;

procedure TIdEMailAddressList.FillTStrings(AStrings: TStrings);
var
  idx: Integer;
begin
  for idx := 0 to Count - 1 do
  begin
    AStrings.Add(GetItem(idx).Text);
  end;
end;

function TIdEMailAddressList.GetItem(Index: Integer): TIdEMailAddressItem;
begin
  Result := TIdEMailAddressItem(inherited Items[Index]);
end;

function TIdEMailAddressList.GetEMailAddresses: string;
var
  idx: Integer;
begin
  Result := '';   {Do not Localize}
  for idx := 0 to Count - 1 do
  begin
    if Result = '' then
      Result := GetItem(idx).Text
    else
      Result := Result + ', ' + GetItem(idx).Text; {do not localize}
  end;
end;

procedure TIdEMailAddressList.SetItem(Index: Integer;
  const Value: TIdEMailAddressItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TIdEMailAddressList.SetEMailAddresses(AList: string);
var
  EMail : TIdEMailAddressItem;
  iStart: Integer;
  sTemp: string;
  nInBracket: Integer;
  bInQuote : Boolean;
begin
  Clear;
  if Trim(AList) = '' then begin {Do not Localize}
    Exit;
  end;

  iStart := FindFirstOf(':;(", ' + TAB, AList); {do not localize}
  if iStart = 0 then
  begin
    EMail := Add;
    EMail.Text := TrimLeft(AList);
  end else
  begin
    sTemp := ''; {do not localize}
    nInBracket := 0;
    bInQuote := False;
    repeat
      case AList[iStart] of
        ' ', TAB: {do not localize}
        begin
          if iStart = 1 then begin
            sTemp := sTemp + AList[iStart];
            IdDelete(AList, 1, 1);
          end else begin
            sTemp := sTemp + Copy(AList, 1, iStart);
            IdDelete(AList, 1, iStart);
          end;
        end;
        ':' : {do not localize}
        begin
          // The start of a group - ignore the lot.
          IdDelete(AList, 1, iStart);
          sTemp := '';
        end;
        ';' : {do not localize}
        begin
          {
            End of a group.  If we have something (groups can be empty),
            then process it.
           }
          sTemp := sTemp + Copy(AList, 1, iStart - 1);
          if Trim(sTemp) <> '' then
          begin
            EMail := Add;
            EMail.Text := TrimLeft(sTemp);
            sTemp := ''; {do not localize}
          end;
          // Now simply remove the end of the group.
          IdDelete(AList, 1, iStart);
        end;
        '(': {do not localize}
        begin
          Inc(nInBracket);
          sTemp := sTemp + Copy(AList, 1, iStart);
          IdDelete(AList, 1, iStart);
        end;
        ')': {do not localize}
        begin
          Dec(nInBracket);
          sTemp := sTemp + Copy(AList, 1, iStart);
          IdDelete(AList, 1, iStart);
        end;
        '"': {do not localize}
        begin
          sTemp := sTemp + Copy(AList, 1, iStart);
          IdDelete(AList, 1, iStart);
          bInQuote := not bInQuote;
        end;
        ',': {do not localize}
        begin
          sTemp := sTemp + Copy(AList, 1, iStart - 1);
          EMail := Add;
          EMail.Text := sTemp;
          // added - Allen .. saves blank entries being added
          sTemp := Trim(Email.Text);
          if (sTemp = '') or (sTemp = '<>') then {do not localize}
          begin
            IdDisposeAndNil(Email);
          end;
          sTemp := '';
          IdDelete(AList, 1, iStart);
        end;
        '\': {do not localize}
        begin
          // Escape character - simply copy this char and the next to the buffer.
          sTemp := sTemp + Copy(AList, 1, iStart + 1);
          IdDelete(AList, 1, iStart + 1);
        end;
      end;

      if nInBracket > 0 then begin
        iStart := FindFirstOf('(\)', AList);    {Do not Localize}
      end else if bInQuote then begin
        iStart := FindFirstOf('"\', AList);    {Do not Localize}
      end else begin
        iStart := FindFirstOf(':;(", ' + TAB, AList);  {Do not Localize}
      end;
    until iStart = 0;

    // Clean up the content in sTemp
    if (Trim(sTemp) <> '') or (Trim(AList) <> '') then
    begin
      sTemp := sTemp + AList;
      EMail := Add;
      EMail.Text := TrimLeft(sTemp);
      // added - Allen .. saves blank entries being added
      sTemp := Trim(Email.Text);
      if (sTemp = '') or (sTemp = '<>') then {do not localize}
      begin
        IdDisposeAndNil(Email);
      end;
    end;
  end;
end;

procedure TIdEMailAddressList.SortByDomain;
var
  i, j: Integer;
  LTemp: string;
begin
  for i := Count-1 downto 0 do
  begin
    for j := 0 to Count-2 do
    begin
      if IndyCompareStr(Items[J].Domain, Items[J + 1].Domain) > 0 then
      begin
        LTemp := Items[j].Text;
        Items[j].Text := Items[j+1].Text;
        Items[j+1].Text := LTemp;
      end;
    end;
  end;
end;

procedure TIdEMailAddressList.GetDomains(AStrings: TStrings);
var
  i: Integer;
  LCurDom: string;
begin
  if Assigned(AStrings) then
  begin
    AStrings.BeginUpdate;
    try
      AStrings.Clear;
      for i := 0 to Count-1 do
      begin
        LCurDom := LowerCase(Items[i].Domain);
        if AStrings.IndexOf(LCurDom) = -1 then begin
          AStrings.Add(LCurDom);
        end;
      end;
    finally
      AStrings.EndUpdate;
    end;
  end;
end;

procedure TIdEMailAddressList.AddressesByDomain(AList: TIdEMailAddressList;
  const ADomain: string);
var
  i: Integer;
  LEnt : TIdEMailAddressItem;
begin
  AList.Clear;
  for i := 0 to Count-1 do
  begin
    if TextIsSame(Items[i].Domain, ADomain) then
    begin
      LEnt := AList.Add;
      LEnt.Text := Items[i].Text;
    end;
  end;
end;

end.
