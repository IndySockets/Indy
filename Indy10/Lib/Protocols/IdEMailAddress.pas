{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  13822: IdEMailAddress.pas
{
{   Rev 1.13    10/26/2004 9:09:36 PM  JPMugaas
{ Updated references.
}
{
{   Rev 1.12    24/10/2004 21:25:18  ANeillans
{ Modifications to allow Username and Domain parts to be set.
}
{
{   Rev 1.11    24.08.2004 17:29:30  Andreas Hausladen
{ Fixed GetEMailAddresses
{ Lots of simple but effective optimizations
}
{
{   Rev 1.10    09/08/2004 08:17:08  ANeillans
{ Rename username property to user
}
{
{   Rev 1.9    08/08/2004 20:58:02  ANeillans
{ Added support for Username extraction.
}
{
{   Rev 1.8    23/04/2004 20:34:36  CCostelloe
{ Clarified a question in the code as to why a code path ended there
}
{
{   Rev 1.7    3/6/2004 5:45:00 PM  JPMugaas
{ Fixed problem obtaining the Text property for an E-Mail address with no
{ domain.
}
{
{   Rev 1.6    2004.02.03 5:45:08 PM  czhower
{ Name changes
}
{
{   Rev 1.5    24/01/2004 19:12:10  CCostelloe
{ Cleaned up warnings
}
{
{   Rev 1.4    10/12/2003 7:51:50 PM  BGooijen
{ Fixed Range Check Error
}
{
{   Rev 1.3    10/8/2003 9:50:24 PM  GGrieve
{ use IdDelete
}
{
{   Rev 1.2    6/10/2003 5:48:50 PM  SGrobety
{ DotNet updates
}
{
{   Rev 1.1    5/18/2003 02:30:36 PM  JPMugaas
{ Added some backdoors for the TIdDirectSMTP processing.
}
{
{   Rev 1.0    11/14/2002 02:19:44 PM  JPMugaas
}
unit IdEMailAddress;

{
 ToDo: look into alterations required for TIdEMailAddressItem.GetText.
}
{
2001-Aug-30 - Jim Gunkel
  - Fixed bugs that would occur with group names containing spaces (box test 19)
    and content being located after the email address (box test 33)
2001-Jul-11 - Allen O'Neill
  - Added hack to not allow recipient entries being added that are blank
2001-Jul-11 - Allen O'Neill
  - Added hack to accomodate a PERIOD (#46) in an email address - this whole area needs to be looked at.
2001-Feb-03 - Peter Mee
  - Overhauled TIdEMailAddressItem.GetText to support non-standard textual
    elements.
2001-Jan-29 - Peter Mee
  - Overhauled TIdEMailAddressList.SetEMailAddresses to support comments
    and escaped characters and to ignore groups.
2001-Jan-28 - Peter Mee
  - Overhauled TIdEMailAddressItem.SetText to support comments and escaped
    characters.
2000-Jun-10 - J. Peter Mugaas
  - started this unit to facilitate some Indy work including the
    TIdEMailAddressItem and TIdEMailAddressList classes
  - The GetText and SetText were originally the ToArpa and FromArpa functions in
    the TIdMessage component}


interface

uses
  Classes,
  IdException,
  IdSys,
  IdTStrings;

type
   EIdEmailParseError = class(EIdException);

   TIdEMailAddressItem = class (TCollectionItem)
   protected
     FAddress: string;
     FName: string;
     Function GetText: string;
     Procedure SetText(AText: string);
     function ConvertAddress: string;
     function GetDomain: string;
     procedure SetDomain(const ADomain: String);
     function GetUsername: string;
     procedure SetUsername(const AUsername: String);
   public
     procedure Assign(Source: TPersistent); override;
   published
     {This is the E-Mail address itself }
     property Address: string read FAddress write FAddress;
     {This is the person's name}    {Do not Localize}
     property Name: string read FName write FName;
     {This is the combined person's name and E-Mail address}    {Do not Localize}
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

     {This returns formatted list of formated
     addresses including the names from the collection }
     procedure FillTStrings(AStrings: TIdStrings);
     function Add: TIdEMailAddressItem;
     //get all of the domains in the list so we can process those individually with
     //TIdDirectSMTP
     procedure GetDomains(AStrings: TIdStrings);
     {Sort by domains for making it easier to process E-Mails directly in
     TIdDirectSMTP}
     procedure SortByDomain;
     //Get all of the E-Mail addresses for a particular domain so we can
     //send E-Mail to recipients at one domain with only one connection for
     //speed with TIdDirectSMTP.
     procedure AddressesByDomain(AList: TIdEMailAddressList; const ADomain: string);
     property Items[Index: Integer]: TIdEMailAddressItem read GetItem write SetItem; default;
     {This is a comma separated list of formated
     addresses including the names from the collection }
     property EMailAddresses: string read GetEMailAddresses write SetEMailAddresses;
   end;

implementation

uses
  IdGlobal, IdGlobalProtocols, IdExceptionCore, IdResourceStringsProtocols;

const
  // This is actually the ATEXT without the '"' and space characters...    {Do not Localize}
  IETF_ATEXT: string = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'   {Do not Localize}
   + '1234567890!#$%&''*+-/=?_`{}|~';    {Do not Localize}
  // ATEXT without the '"'    {Do not Localize}
  IETF_ATEXT_SPACE: string = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'   {Do not Localize}
   + '1234567890!#$%&''*+-/=?_`{}|~ ';   {Do not Localize}
  IETF_QUOTABLE: string = '\"';  {Do not Localize}

// Three functions for easier manipulating of strings.
// Don't know of any system functions to perform these actions.    {Do not Localize}
// If there aren't & someone can find an optimised way of performing    {Do not Localize}
// then please implement...
function FindFirstOf(const AFind, AText: string): Integer;
var
  nCount, nPos: Integer;
begin
  Result := 0;
  for nCount := 1 to Length(AFind) do begin
    nPos := IndyPos(AFind[nCount], AText);
    if nPos > 0 then begin
      if Result = 0 then begin
        Result := nPos;
      end else if Result > nPos then begin
        Result := nPos;
      end;
    end;
  end;
end;

function FindFirstNotOf(const AFind, AText: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  if AFind = '' then
  begin
    Result := 1;
    Exit;
  end;

  if AText = '' then
  begin
    Exit;
  end;

  for i := 1 to Length(AText) do
  begin
    if IndyPos(AText[i], AFind) = 0 then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

function TrimAllOf(const ATrim, AText: string): string;
var
  Len: Integer;
begin
  Result := AText;
  Len := Length(Result);
  while Len > 0 do
  begin
    if Pos(Result[1], ATrim) > 0 then
    begin
      Delete(Result, 1, 1);
      Dec(Len);
    end else Break;
  end;
  while Len > 0 do begin
    if Pos(Result[Len], ATrim) > 0 then
    begin
      Delete(Result, Len, 1);
      Dec(Len);
    end else Break;
  end;
end;

{ TIdEMailAddressItem }

procedure TIdEMailAddressItem.Assign(Source: TPersistent);
var Addr : TIdEMailAddressItem;
begin
  if ClassType <> Source.ClassType then
  begin
    inherited
  end
  else
  begin
    Addr := TIdEMailAddressItem(Source);
    Address := Addr.Address;
    Name := Addr.Name;
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
    if FAddress[i] = '@' then  {Do not Localize}
    begin
      domainPart := Copy(FAddress, i, MaxInt);
      tempAddress := Copy(FAddress, 1, i - 1);
      Break;
    end;
  end;

  i := FindFirstNotOf(IETF_ATEXT, tempAddress);
  if (i = 0) or (Copy(tempAddress,i,1) = #46) then //hack to accomodate periods in emailaddress
//  if i = 0 then
  begin
    if FName <> '' then
    begin
      Result := '<' + tempAddress + domainPart + '>';   {Do not Localize}
    end else
    begin
      Result := tempAddress + domainPart;
    end;
  end else
  begin
    localPart := '"';      {Do not Localize}
    while i > 0 do
    begin
      localPart := localPart + Copy(tempAddress, 1, i - 1);
      if IndyPos(tempAddress[i], IETF_QUOTABLE) > 0 then
      begin
        localPart := localPart + '\';   {Do not Localize}
      end;
      localPart := localPart + tempAddress[i];
      IdDelete(tempAddress, 1, i);
      i := FindFirstNotOf(IETF_ATEXT, tempAddress);
    end;
    Result := '<' + localPart + tempAddress + '"' + domainPart + '>';   {Do not Localize}
  end;
end;

function TIdEMailAddressItem.GetDomain: string;
var i: Integer;
begin
  Result := '';
  for i := Length(FAddress) downto 1 do
  begin
    if FAddress[i] = '@' then  {Do not Localize}
    begin
      Result := Copy(FAddress, i + 1, MaxInt);
      Break;
    end;
  end;
end;

procedure TIdEMailAddressItem.SetDomain(const ADomain: String);
Var
 Result : String;
begin
  Result := FAddress;
  Delete(Result, Pos('@', Result)-1, Length(Result));
  Result := Result + '@' + ADomain;
  FAddress := Result;
end;

function TIdEMailAddressItem.GetUsername: string;
var i: Integer;
begin
  Result := '';
  for i := Length(FAddress) downto 1 do
  begin
    if FAddress[i] = '@' then  {Do not Localize}
    begin
      Result := Copy(FAddress, 1, i - 1);
      Break;
    end;
  end;
end;

procedure TIdEMailAddressItem.SetUsername(const AUsername: String);
Var
 Result : String;
begin
  Result := FAddress;
  Delete(Result, 1, Pos('@', Result) + 1);
  Result := AUsername + '@' + Result;
  FAddress := Result;
end;

function TIdEMailAddressItem.GetText: string;
var
  i: Integer;
  tempName, resName: string;
begin
  if (FName <> '') and (Sys.UpperCase(FAddress) <> FName) then
  begin
    i := FindFirstNotOf(IETF_ATEXT_SPACE, FName);
    if i > 0 then
    begin
      // Need to quote the FName.
      resName := '"' + Copy(FName, 1, i - 1);    {Do not Localize}
      if IndyPos(FName[i], IETF_QUOTABLE) > 0 then
      begin
        resName := resName + '\';   {Do not Localize}
      end;
      resName := resName + FName[i];

      tempName := Copy(FName, i + 1, MaxInt);
      while tempName <> '' do
      begin
        i := FindFirstNotOf(IETF_ATEXT_SPACE, tempName);
        if i = 0 then
        begin
          Result := resName + tempName + '" ' + ConvertAddress;  {Do not Localize}
          Exit;
        end;
        resName := resName + Copy(tempName, 1, i - 1);
        if IndyPos(tempName[i], IETF_QUOTABLE) > 0 then
        begin
          resName := resName + '\';     {Do not Localize}
        end;
        resName := resName + tempName[i];
        IdDelete(tempName, 1, i);
      end;
      Result := resName + '" ' + ConvertAddress;   {Do not Localize}
    end else
    begin
      Result := FName + ' ' + ConvertAddress;  {Do not Localize}
    end;
  end //  if
  else
  begin
    Result := ConvertAddress;
  end; // else .. if
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
  FAddress := '';    {Do not Localize}
  FName := '';        {Do not Localize}

  AText := Sys.Trim(AText);
  if AText = '' then
    Exit;

  // Find the first known character type.
  nFirst := FindFirstOf('("< @' + TAB, AText);   {Do not Localize}
  if nFirst <> 0 then
  begin
    nBracketCount := 0;
    bInAddress := False;
    bAddressInLT := False;
    bInQuote := False;
    bAfterAt := False;
    repeat
      case AText[nFirst] of
        ' ', TAB :             {Do not Localize}
        begin
          if nFirst = 1 then
          begin
            Delete(AText, 1, 1);
          end else
          begin
            // Only valid if in a name not contained in quotes - keep the space.
            if bAfterAt then begin
              FAddress := FAddress + Sys.Trim(Copy(AText, 1, nFirst - 1));
            end else begin
              FName := FName + Copy(AText, 1, nFirst);
            end;
            IdDelete(AText, 1, nFirst);
          end;
        end;
        '(' :                                {Do not Localize}
        begin
          Inc(nBracketCount);
          if (nFirst > 1) then
          begin
            // There's at least one character to the name    {Do not Localize}
            if bInAddress then
            begin
              FAddress := FAddress + Sys.Trim(Copy(AText, 1, nFirst - 1));
            end else
            begin
              if nBracketCount = 1 then
              begin
                FName := FName + Copy(AText, 1, nFirst - 1);
              end;
            end;
            IdDelete(AText, 1, nFirst);
          end else
          begin
            Delete(AText, 1, 1);
          end;
        end;
        ')' :                                {Do not Localize}
        begin
          Dec(nBracketCount);
          IdDelete(AText, 1, nFirst);
        end;
        '"' :                              {Do not Localize}
        begin
          if bInQuote then
          begin
            if bAddressInLT then
            begin
              FAddress := FAddress + Sys.Trim(Copy(AText, 1, nFirst - 1));
            end else
            begin
              FName := FName + Sys.Trim(Copy(AText, 1, nFirst - 1));
            end;
            IdDelete(AText, 1, nFirst);
            bInQuote := False;
          end else
          begin
            bInQuote := True;
            Delete(AText, 1, 1);
          end;
        end;
        '<' :                             {Do not Localize}
        begin
          if nFirst > 1 then
          begin
            FName := FName + Copy(AText, 1, nFirst - 1);
          end;
          FName := TrimAllOf(' ' + TAB, Sys.Trim(FName));    {Do not Localize}
          bAddressInLT := True;
          bInAddress := True;
          Delete(AText, 1, nFirst);
        end;
        '>' :                            {Do not Localize}
        begin
          // Only searched for if the address starts with '<'    {Do not Localize}
          bInAddress := False;
          bAfterAt := False;
          FAddress := FAddress +
            TrimAllOf(' ' + TAB, Sys.Trim(Copy(AText, 1, nFirst - 1)));  {Do not Localize}
          IdDelete(AText, 1, nFirst);
        end;
        '@' :                 {Do not Localize}
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
              // Strange use. For now raise an exception until a real-world
              // example can be found.
              // Basically, it's formatted as follows:    {Do not Localize}
              //    <someguy@domain.example> some-text @ some-text
              // or:
              //    some-text <someguy@domain.example> some-text @ some-text
              // where some text may be blank.
              //CC: Note you used to arrive here if the From header in an email
              //included more than one address (which was subsequently changed)
              //because our code did not parse the From header for multiple
              //addresses.  That may have been the reason for this code.
              raise EIdEmailParseError.Create(RSEMailSymbolOutsideAddress);
            end else
            begin
              // If at this point, we're either supporting an e-mail address    {Do not Localize}
              // on it's own, or the old-style valid format:    {Do not Localize}
              //    "Name" name@domain.example
              bInAddress := True;
              FAddress := FAddress + Copy(AText, 1, nFirst);
              IdDelete(AText, 1, nFirst);
            end;
          end;
        end;
        '.' :                {Do not Localize}
        begin
          // Must now be a part of the domain part of the address.
          if bAddressInLT then
          begin
            // Whitespace is possible around the parts of the domain.
            FAddress := FAddress +
              TrimAllOf(' ' + TAB, Sys.Trim(Copy(AText, 1, nFirst - 1))) + '.'; {Do not Localize}
            AText := Sys.TrimLeft(Copy(AText, nFirst + 1, MaxInt));
          end else
          begin
            // No whitespace is allowed if no wrapping <> characters.
            FAddress := FAddress + Copy(AText, 1, nFirst);
            IdDelete(AText, 1, nFirst);
          end;
        end;
        '\' :                   {Do not Localize}
        begin
          // This will only be discovered in a bracketted or quoted section.
          // It's an escape character indicating the next cahracter is    {Do not Localize}
          // a literal.
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


      // Check for bracketted sections first: ("<>" <> "" <"">) - all is ignored
      if nBracketCount > 0 then
      begin
        // Inside a bracket, only three charatcers are special.
        // '(' Opens a nested bracket: (One (Two (Three )))    {Do not Localize}
        // ')' Closes a bracket    {Do not Localize}
        // '/' Escape character: (One /) /( // (Two /) ))    {Do not Localize}
        nFirst := FindFirstOf('()\', AText);     {Do not Localize}

      // Check if in quote before address: <"My Name"@domain.example> is valid
      end else if bInQuote then
      begin
      // Inside quotes, only the end quote and escape character are special.
        nFirst := FindFirstOf('"\', AText);   {Do not Localize}

      // Check if after the @ of the address: domain.example>
      end else if bAfterAt then
      begin
        if bAddressInLT then
        begin
          // If the address is enclosed, then only the '(', '.' & '>' need be    {Do not Localize}
          // looked for, trimming all content when found: domain  .  example >
          nFirst := FindFirstOf('.>(', AText);       {Do not Localize}
        end else
        begin
          nFirst := FindFirstOf('.( ', AText);  {Do not Localize}
        end;

      // Check if in address: <name@domain.example>
      end else if bInAddress then
      begin
        nFirst := FindFirstOf('"(@>', AText);   {Do not Localize}

      // Not in anything - check for opening charactere
      end else
      begin
        // Outside brackets
        nFirst := FindFirstOf('("< @' + TAB, AText);    {Do not Localize}
      end;
    until nFirst = 0;
    if bInAddress and not bAddressInLT then
    begin
      FAddress := FAddress + TrimAllOf(' ' + TAB, Sys.Trim(AText));   {Do not Localize}
    end;
  end else
  begin
    // No special characters, so assume a simple address
    FAddress := AText;
  end;
end;



{ TIdEMailAddressList }

function TIdEMailAddressList.Add: TIdEMailAddressItem;
begin
  Result := TIdEMailAddressItem(inherited Add);
end;

constructor TIdEMailAddressList.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TIdEMailAddressItem);
end;

procedure TIdEMailAddressList.FillTStrings(AStrings: TIdStrings);
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
      Result := Result + ', ' + GetItem(idx).Text; {Do not Localize}
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

  if (Sys.Trim(AList) = '') then Exit;   {Do not Localize}

  iStart := FindFirstOf(':;(", ' + TAB, AList); {Do not Localize}
  if iStart = 0 then begin
    EMail := Add;
    EMail.Text := Sys.TrimLeft(AList);
  end else begin
    sTemp := '';                   {Do not Localize}
    nInBracket := 0;
    bInQuote := False;
    repeat
      case AList[iStart] of
        ' ', TAB: begin                 {Do not Localize}
          if iStart = 1 then begin
            sTemp := sTemp + AList[iStart];
            IdDelete(AList, 1, 1);
          end else begin
            sTemp := sTemp + Copy(AList, 1, iStart);
            IdDelete(AList, 1, iStart);
          end;
        end;
        ':' :                           {Do not Localize}
        begin
          // The start of a group - ignore the lot.
          IdDelete(AList, 1, iStart);
          sTemp := '';                 {Do not Localize}
        end;
        ';' :                          {Do not Localize}
        begin
          // End of a group.  If we have something (groups can be empty),
          // then process it.
          sTemp := sTemp + Copy(AList, 1, iStart - 1);
          if Sys.Trim(sTemp) <> '' then begin
            EMail := Add;
            EMail.Text := Sys.TrimLeft(sTemp);
            sTemp := '';                     {Do not Localize}
          end;
          // Now simply remove the end of the group.
          IdDelete(AList, 1, iStart);
        end;
        '(': begin                     {Do not Localize}
          Inc(nInBracket);
          sTemp := sTemp + Copy(AList, 1, iStart);
          IdDelete(AList, 1, iStart);
        end;
        ')': begin                     {Do not Localize}
          Dec(nInBracket);
          sTemp := sTemp + Copy(AList, 1, iStart);
          IdDelete(AList, 1, iStart);
        end;
        '"': begin                     {Do not Localize}
          sTemp := sTemp + Copy(AList, 1, iStart);
          IdDelete(AList, 1, iStart);
          bInQuote := not bInQuote;
        end;
        ',': begin                       {Do not Localize}
          sTemp := sTemp + Copy(AList, 1, iStart - 1);
          EMail := Add;
          EMail.Text := sTemp;
          // added - Allen .. saves blank entries being added
          if (Sys.Trim(Email.Text) = '') or (Sys.Trim(Email.Text) = '<>') then   {Do not Localize}
          begin
            Sys.FreeAndNil(Email);
          end;
          sTemp := '';    {Do not Localize}
          IdDelete(AList, 1, iStart);
        end;
        '\': begin                                     {Do not Localize}
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
    if (Sys.Trim(sTemp) <> '') or (Sys.Trim(AList) <> '') then begin
      sTemp := sTemp + AList;
      EMail := Add;
      EMail.Text := Sys.TrimLeft(sTemp);
      // added - Allen .. saves blank entries being added
      if (Sys.Trim(Email.Text) = '') or (Sys.Trim(Email.Text) = '<>') then   {Do not Localize}
      begin
        Sys.FreeAndNil(Email);
      end;
    end;
  end;
end;

procedure TIdEMailAddressList.SortByDomain;
var
  i, j: Integer;
  LTemp: string;
begin
  for i := Count -1 downto 0 do
  begin
    for j := 0 to Count -2 do
    begin
      if IndyCompareStr(Items[J].Domain , Items[J + 1].Domain)> 0 then begin
        LTemp := Items[j].Text;

        Items[j].Text := Items[j+1].Text;
        Items[j+1].Text := LTemp;
      end;
    end;
  end;
end;

procedure TIdEMailAddressList.GetDomains(AStrings: TIdStrings);
var
  i: Integer;
  LCurDom: string;
begin
  if Assigned(AStrings) then
  begin
    AStrings.Clear;
    for i := 0 to Count-1 do
    begin
      LCurDom :=  Sys.Lowercase(Items[i].Domain);
      if AStrings.IndexOf( LCurDom ) = -1 then
      begin
        AStrings.Add( LCurDom );
      end;
    end;
  end;
end;

procedure TIdEMailAddressList.AddressesByDomain(AList: TIdEMailAddressList;
  const ADomain: string);
var
  i: Integer;
  LDomain: string;
  LCurDom: string;
  LEnt : TIdEMailAddressItem;
begin
  LDomain := Sys.LowerCase(ADomain);
  AList.Clear;
  for i := 0 to Count-1 do
  begin
    LCurDom := Sys.LowerCase(Items[i].Domain);
    if LCurDom = LDomain then
    begin
      LEnt := AList.Add;
      LEnt.Text := Items[i].Text;
    end;
  end;
end;

end.
