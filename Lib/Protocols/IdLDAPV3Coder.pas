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
  Rev 1.0    15/04/2005 7:25:06 AM  GGrieve
  first ported to INdy
}

unit IdLDAPV3Coder;

interface

{$i IdCompilerDefines.inc}

uses
  IdASN1Coder,
  IdLdapV3;

type
  TIdLDAPV3Encoder = Class (TIdASN1Encoder)
  private
    procedure WriteAuthentication(oAuthentication: TIdLDAPv3AuthenticationChoice);
    procedure WriteFilterList(oFilterList : TIdLDAPV3FilterList; iTag : integer);
    procedure WriteAttributeValueAssertion(oAttributeValueAssertion : TIdLDAPV3AttributeValueAssertion; iTag : integer);
    procedure WriteSubstring(oSubstring : TIdLDAPV3Substring; iTag : integer);
    procedure WriteSubstringFilter(oSubstringFilter : TIdLDAPV3SubstringFilter; iTag : integer);
    procedure WriteMatchingRuleAssertion(oMatchingRuleAssertion : TIdLDAPV3MatchingRuleAssertion; iTag : integer);
    procedure WriteFilter(oFilter : TIdLDAPV3Filter; iTag : integer);
    procedure WriteAttributes(oAttributes : TIdLDAPV3AttributeDescriptionList; iTag : integer);
    procedure WriteReferral(oReferral : TIdLDAPV3Referral; iTag : integer);
    procedure WritePartialAttributeList(oAttributes : TIdLDAPV3PartialAttributeList; iTag : integer);
    procedure WritePartialAttribute(oAttribute : TIdLDAPV3PartialAttribute; iTag : integer);

    procedure WriteResultInner(oResult : TIdLDAPV3LDAPResult);

    procedure WritebindRequest(oBindRequest : TIdLDAPV3BindRequest);
    procedure WritebindResponse(oBindResponse : TIdLDAPV3BindResponse);
    procedure WriteunbindRequest(oUnbindRequest : TIdLDAPV3UnbindRequest);
    procedure WritesearchRequest(oSearchRequest : TIdLDAPV3SearchRequest);
    procedure WritesearchResEntry(oSearchResEntry : TIdLDAPV3SearchResultEntry);
    procedure WritesearchResDone(oSearchResDone : TIdLDAPV3SearchResultDone);
    procedure WritesearchResRef(oSearchResRef : TIdLDAPV3SearchResultReference);
    procedure WritemodifyRequest(oModifyRequest : TIdLDAPV3ModifyRequest);
    procedure WritemodifyResponse(oModifyResponse : TIdLDAPV3ModifyResponse);
    procedure WriteaddRequest(oAddRequest : TIdLDAPV3AddRequest);
    procedure WriteaddResponse(oAddResponse : TIdLDAPV3AddResponse);
    procedure WritedelRequest(oDelRequest : TIdLDAPV3DelRequest);
    procedure WritedelResponse(oDelResponse : TIdLDAPV3DelResponse);
    procedure WritemodDNRequest(oModDNRequest : TIdLDAPV3ModifyDNRequest);
    procedure WritemodDNResponse(oModDNResponse : TIdLDAPV3ModifyDNResponse);
    procedure WritecompareRequest(oCompareRequest : TIdLDAPV3CompareRequest);
    procedure WritecompareResponse(oCompareResponse : TIdLDAPV3CompareResponse);
    procedure WriteabandonRequest(oAbandonRequest : TIdLDAPV3AbandonRequest);
    procedure WriteextendedReq(oExtendedReq : TIdLDAPV3ExtendedRequest);
    procedure WriteextendedResp(oExtendedResp : TIdLDAPV3ExtendedResponse);
  public
    procedure Produce(oMessage : TIdLDAPV3Message); Overload; Virtual;
  end;

  TIdLDAPV3Decoder = Class (TIdASN1Decoder)
  private
    procedure ReadFilter(oFilter : TIdLDAPV3Filter);
    procedure ReadFilterList(oFilterList : TIdLDAPV3FilterList);
    procedure ReadAttributes(oAttributes : TIdLDAPV3AttributeDescriptionList);
    procedure ReadAttributeValueAssertion(oEqualityMatch : TIdLDAPV3AttributeValueAssertion);
    procedure ReadSubstringFilter(oSubstrings : TIdLDAPV3SubstringFilter);
    procedure ReadMatchingRuleAssertion(oExtensibleMatch : TIdLDAPV3MatchingRuleAssertion);
    procedure ReadSubString(oString : TIdLDAPV3Substring);
    procedure ReadPartialAttribute(oAttribute : TIdLDAPV3PartialAttribute);
    procedure ReadPartialAttributeList(oAttributes : TIdLDAPV3PartialAttributeList);

    procedure ReadReferral(oReferral : TIdLDAPV3Referral);
    procedure ReadResultInner(oResult : TIdLDAPV3LDAPResult);

    procedure ReadBindRequest(oMessage : TIdLDAPV3Message);
    procedure ReadBindResponse(oMessage : TIdLDAPV3Message);
    procedure ReadSearchRequest(oMessage : TIdLDAPV3Message);
    procedure ReadSearchResultEntry(oMessage : TIdLDAPV3Message);
    procedure ReadSearchResultDone(oMessage : TIdLDAPV3Message);
  public
    procedure ReadMessage(oMessage : TIdLDAPV3Message); Overload; Virtual;
  end;

implementation

uses
  SysUtils,
  IdException;

{ TIdLDAPV3Encoder }

procedure TIdLDAPV3Encoder.Produce(oMessage: TIdLDAPV3Message);
begin
  StartWriting;
  StartSequence;
  WriteInteger(oMessage.messageID);
  if assigned(oMessage.bindRequest) then
    WritebindRequest(oMessage.bindRequest) // TIdLDAPV3BindRequest
  else if assigned(oMessage.bindResponse) then
    WritebindResponse(oMessage.bindResponse) // TIdLDAPV3BindResponse
  else if assigned(oMessage.unbindRequest) then
    WriteunbindRequest(oMessage.unbindRequest) // TIdLDAPV3UnbindRequest
  else if assigned(oMessage.searchRequest) then
    WritesearchRequest(oMessage.searchRequest) // TIdLDAPV3SearchRequest
  else if assigned(oMessage.searchResEntry) then
    WritesearchResEntry(oMessage.searchResEntry) // TIdLDAPV3SearchResultEntry
  else if assigned(oMessage.searchResDone) then
    WritesearchResDone(oMessage.searchResDone) // TIdLDAPV3SearchResultDone
  else if assigned(oMessage.searchResRef) then
    WritesearchResRef(oMessage.searchResRef) // TIdLDAPV3SearchResultReference
  else if assigned(oMessage.modifyRequest) then
    WritemodifyRequest(oMessage.modifyRequest) // TIdLDAPV3ModifyRequest
  else if assigned(oMessage.modifyResponse) then
    WritemodifyResponse(oMessage.modifyResponse) // TIdLDAPV3ModifyResponse
  else if assigned(oMessage.addRequest) then
    WriteaddRequest(oMessage.addRequest) // TIdLDAPV3AddRequest
  else if assigned(oMessage.addResponse) then
    WriteaddResponse(oMessage.addResponse) // TIdLDAPV3AddResponse
  else if assigned(oMessage.delRequest) then
    WritedelRequest(oMessage.delRequest) // TIdLDAPV3DelRequest
  else if assigned(oMessage.delResponse) then
    WritedelResponse(oMessage.delResponse) // TIdLDAPV3DelResponse
  else if assigned(oMessage.modDNRequest) then
    WritemodDNRequest(oMessage.modDNRequest) // TIdLDAPV3ModifyDNRequest
  else if assigned(oMessage.modDNResponse) then
    WritemodDNResponse(oMessage.modDNResponse) // TIdLDAPV3ModifyDNResponse
  else if assigned(oMessage.compareRequest) then
    WritecompareRequest(oMessage.compareRequest) // TIdLDAPV3CompareRequest
  else if assigned(oMessage.compareResponse) then
    WritecompareResponse(oMessage.compareResponse) // TIdLDAPV3CompareResponse
  else if assigned(oMessage.abandonRequest) then
    WriteabandonRequest(oMessage.abandonRequest) // TIdLDAPV3AbandonRequest
  else if assigned(oMessage.extendedReq) then
    WriteextendedReq(oMessage.extendedReq) // TIdLDAPV3ExtendedRequest
  else if assigned(oMessage.extendedResp) then
    WriteextendedResp(oMessage.extendedResp) // TIdLDAPV3ExtendedResponse
  else
    raise EIdException.create('No Protocol Choice operation on message'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  StopSequence;
  StopWriting;
end;

procedure TIdLDAPV3Encoder.WritebindRequest(oBindRequest : TIdLDAPV3BindRequest);
begin
  StartSequence(0);
  WriteInteger(oBindRequest.version);
  WriteString(oBindRequest.name);
  WriteAuthentication(oBindRequest.authentication);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WritebindResponse(oBindResponse : TIdLDAPV3BindResponse);
begin
  StartSequence(1);
  WriteResultInner(oBindResponse);
  if oBindResponse.serverSaslCreds <> '' then
    WriteString(oBindResponse.serverSaslCreds);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WriteunbindRequest(oUnbindRequest : TIdLDAPV3UnbindRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritesearchRequest(oSearchRequest : TIdLDAPV3SearchRequest);
begin
  StartSequence(3);
  WriteString(oSearchRequest.baseObject);
  WriteEnum(ord(oSearchRequest.scope));
  WriteEnum(ord(oSearchRequest.derefAliases));
  WriteInteger(oSearchRequest.sizeLimit);
  WriteInteger(oSearchRequest.timeLimit);
  WriteBoolean(oSearchRequest.typesOnly);
  WriteFilter(osearchRequest.filter, -1);
  WriteAttributes(osearchRequest.attributes, -1);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WritesearchResEntry(oSearchResEntry : TIdLDAPV3SearchResultEntry);
begin
  StartSequence(4);
  WriteString(oSearchResEntry.objectName);
  WritePartialAttributeList(oSearchResEntry.attributes, -1);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WritesearchResDone(oSearchResDone : TIdLDAPV3SearchResultDone);
begin
  StartSequence(5);
  WriteResultInner(oSearchResDone);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WritesearchResRef(oSearchResRef : TIdLDAPV3SearchResultReference);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritemodifyRequest(oModifyRequest : TIdLDAPV3ModifyRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritemodifyResponse(oModifyResponse : TIdLDAPV3ModifyResponse);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WriteaddRequest(oAddRequest : TIdLDAPV3AddRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WriteaddResponse(oAddResponse : TIdLDAPV3AddResponse);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritedelRequest(oDelRequest : TIdLDAPV3DelRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritedelResponse(oDelResponse : TIdLDAPV3DelResponse);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritemodDNRequest(oModDNRequest : TIdLDAPV3ModifyDNRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritemodDNResponse(oModDNResponse : TIdLDAPV3ModifyDNResponse);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritecompareRequest(oCompareRequest : TIdLDAPV3CompareRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WritecompareResponse(oCompareResponse : TIdLDAPV3CompareResponse);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WriteabandonRequest(oAbandonRequest : TIdLDAPV3AbandonRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WriteextendedReq(oExtendedReq : TIdLDAPV3ExtendedRequest);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WriteextendedResp(oExtendedResp : TIdLDAPV3ExtendedResponse);
begin
  raise EIdException.create('Not yet implemented'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WriteAuthentication(oAuthentication: TIdLDAPv3AuthenticationChoice);
begin
  if assigned(oAuthentication.sasl) then
    raise EIdException.create('sasl not handled yet') {do not localize} // TODO: add a resource string, and create a new Exception class for this
  else
    WriteString(0, oAuthentication.simple);
end;

procedure TIdLDAPV3Encoder.WriteFilter(oFilter : TIdLDAPV3Filter; iTag : integer);
begin
  if assigned(oFilter._and) then
    WriteFilterList(oFilter._And, 0)
  else if assigned(oFilter._or) then
    WriteFilterList(oFilter._or, 1)
  else if assigned(oFilter._not) then
    WriteFilter(oFilter._not, 2)
  else if assigned(oFilter.equalityMatch ) then
    WriteAttributeValueAssertion(oFilter.equalityMatch, 3)
  else if assigned(oFilter.substrings) then
    WriteSubstringFilter(oFilter.substrings, 4)
  else if assigned(oFilter.greaterOrEqual) then
    WriteAttributeValueAssertion(oFilter.greaterOrEqual, 5)
  else if assigned(oFilter.lessOrEqual) then
    WriteAttributeValueAssertion(oFilter.lessOrEqual, 6)
  else if oFilter.present <> '' then
    WriteString(7, oFilter.present)
  else if assigned(oFilter.approxMatch) then
    WriteAttributeValueAssertion(oFilter.approxMatch, 8)
  else if assigned(oFilter.extensibleMatch) then
    WriteMatchingRuleAssertion(oFilter.extensibleMatch, 9)
  else
    raise EIdException.create('No operation Choice on Filter'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
end;

procedure TIdLDAPV3Encoder.WriteFilterList(oFilterList : TIdLDAPV3FilterList; iTag : integer);
var
  iLoop : integer;
begin
  for iLoop := 0 to oFilterList.count - 1 do
    writeFilter(oFilterList[iLoop], iTag);
end;

procedure TIdLDAPV3Encoder.WriteAttributeValueAssertion(oAttributeValueAssertion : TIdLDAPV3AttributeValueAssertion; iTag : integer);
begin
  StartSequence(aicContextSpecific, iTag);
  WriteString(oAttributeValueAssertion.attributeDesc);
  WriteString(oAttributeValueAssertion.assertionValue);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WriteSubstring(oSubstring : TIdLDAPV3Substring; iTag : integer);
begin
  StartSequence(aicContextSpecific, iTag);
  if oSubstring.initial <> '' then
    WriteString(0, oSubstring.initial)
  else if oSubstring.any <> '' then
    WriteString(1, oSubstring.any)
  else if oSubstring.final <> '' then
    WriteString(2, oSubstring.final);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WriteSubstringFilter(oSubstringFilter : TIdLDAPV3SubstringFilter; iTag : integer);
var
  iLoop : integer;
begin
  StartSequence(aicContextSpecific, iTag);
  WriteString(oSubstringFilter._type);
  for iLoop := 0 to oSubstringFilter.substrings.count - 1 do
    WriteSubString(oSubstringFilter.substrings[iLoop], -1);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WriteMatchingRuleAssertion(oMatchingRuleAssertion : TIdLDAPV3MatchingRuleAssertion; iTag : integer);
begin
  StartSequence(aicContextSpecific, iTag);
  if oMatchingRuleAssertion.matchingRule <> '' then
    writeString(1, oMatchingRuleAssertion.matchingRule)
  else if oMatchingRuleAssertion._type <> '' then
    writeString(2, oMatchingRuleAssertion._type);
  WriteString(oMatchingRuleAssertion.matchValue);
  if oMatchingRuleAssertion.dnAttributes then
    WriteBoolean(true);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WriteAttributes(oAttributes : TIdLDAPV3AttributeDescriptionList; iTag : integer);
var
  iLoop : integer;
begin
  StartSequence(iTag);
  for iLoop := 0 to oAttributes.Count - 1 do
    WriteString(oAttributes[iLoop]);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WriteResultInner(oResult: TIdLDAPV3LDAPResult);
begin
  WriteEnum(ord(oResult.resultCode));
  WriteString(oResult.matchedDN);
  WriteString(oResult.errorMessage);
  if assigned(oResult.referral) then
    writeReferral(oResult.referral, 3);
end;

procedure TIdLDAPV3Encoder.WriteReferral(oReferral: TIdLDAPV3Referral; iTag : integer);
var
  iLoop : integer;
begin
  StartSequence(aicContextSpecific, iTag);
  for iLoop := 0 to oReferral.Count - 1 do
    WriteString(oReferral[iLoop]);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WritePartialAttributeList(oAttributes: TIdLDAPV3PartialAttributeList; iTag: integer);
var
  iLoop : integer;
begin
  StartSequence(iTag);
  for iLoop := 0 to oAttributes.Count - 1 do
    WritePartialAttribute(oAttributes[iLoop], -1);
  StopSequence;
end;

procedure TIdLDAPV3Encoder.WritePartialAttribute(oAttribute: TIdLDAPV3PartialAttribute; iTag: integer);
var
  iLoop : integer;
begin
  StartSequence(iTag);
  WriteString(oAttribute._type);
  StartSequence(aicUniversal, 17);
  for iLoop := 0 to oAttribute.vals.count - 1 do
    WriteString(oAttribute.vals[iLoop]);
  StopSequence;
  StopSequence;
end;


{ TIdLDAPV3Decoder }

procedure TIdLDAPV3Decoder.ReadBindRequest(oMessage: TIdLDAPV3Message);
begin
  oMessage.bindRequest := TIdLDAPV3BindRequest.Create;
  ReadSequencebegin;
  oMessage.bindRequest.version := ReadInteger;
  oMessage.bindRequest.name := ReadString;
  case NextTag Of
    0: oMessage.bindRequest.authentication.simple := ReadString;
    3: raise EIdException.create('SASL not handled yet'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  else
    raise EIdException.create('Unknown Tag '+IntToStr(NextTag)); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  end;
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadBindResponse(oMessage: TIdLDAPV3Message);
begin
  oMessage.bindResponse := TIdLDAPV3BindResponse.Create;
  ReadSequencebegin;
  ReadResultInner(oMessage.BindResponse);
  if not SequenceEnded then
    oMessage.bindResponse.serverSaslCreds := ReadString;
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadFilter(oFilter: TIdLDAPV3Filter);
begin
  case NextTag Of
    0: begin
        oFilter._and := TIdLDAPV3FilterList.Create;
        ReadFilterList(oFilter._and);
       end;
    1: begin
        oFilter._or := TIdLDAPV3FilterList.Create;
        ReadFilterList(oFilter._or);
       end;
    2: begin
        oFilter._not := TIdLDAPV3Filter.Create;
        ReadFilter(oFilter._not);
       end;
    3: begin
        oFilter.equalityMatch  := TIdLDAPV3AttributeValueAssertion.Create;
        ReadAttributeValueAssertion(oFilter.equalityMatch );
       end;
    4: begin
        oFilter.substrings     := TIdLDAPV3SubstringFilter.Create;
        ReadSubstringFilter(oFilter.substrings);
       end;
    5: begin
        oFilter.greaterOrEqual := TIdLDAPV3AttributeValueAssertion.Create;
        ReadAttributeValueAssertion(oFilter.greaterOrEqual);
       end;
    6: begin
        oFilter.lessOrEqual    := TIdLDAPV3AttributeValueAssertion.Create;
        ReadAttributeValueAssertion(oFilter.lessOrEqual);
       end;
    7: oFilter.present := ReadString;
    8: begin
        oFilter.approxMatch    := TIdLDAPV3AttributeValueAssertion.Create;
        ReadAttributeValueAssertion(oFilter.approxMatch);
       end;
    9: begin
        oFilter.extensibleMatch := TIdLDAPV3MatchingRuleAssertion.Create;
        ReadMatchingRuleAssertion(oFilter.extensibleMatch);
       end;
  else
    raise EIdException.create('Unknown Tag '+IntToStr(NextTag)); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  end;
end;

procedure TIdLDAPV3Decoder.ReadFilterList(oFilterList : TIdLDAPV3FilterList);
Var
  oFilter : TIdLDAPV3Filter;
begin
  while NextTagType = aitSequence do
  begin
    ReadFilter(oFilter);
    oFilterList.Add(oFilter);
  end;
end;

procedure TIdLDAPV3Decoder.ReadAttributeValueAssertion(oEqualityMatch : TIdLDAPV3AttributeValueAssertion);
begin
  ReadSequencebegin;
  oEqualityMatch.attributeDesc := ReadString;
  oEqualityMatch.assertionValue := ReadString;
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadSubString(oString: TIdLDAPV3Substring);
begin
  ReadSequencebegin;
  case NextTag Of
    0 : oString.initial := ReadString;
    1 : oString.any     := ReadString;
    2 : oString.final   := ReadString;
  else
    raise EIdException.create('Unknown Tag '+IntToStr(NextTag)); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  end;
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadSubstringFilter(oSubstrings : TIdLDAPV3SubstringFilter);
Var
  oString : TIdLDAPV3Substring;
begin
  ReadSequencebegin;
  oSubstrings._type := ReadString;
  while not SequenceEnded do
  begin
    ReadSubString(oString);
    oSubstrings.substrings.Add(oString);
  end;
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadMatchingRuleAssertion(oExtensibleMatch : TIdLDAPV3MatchingRuleAssertion);
begin
  ReadSequencebegin;
  if NextTag = 1 then
    oExtensibleMatch.matchingRule := ReadString;
  if NextTag = 2 then
    oExtensibleMatch._type := ReadString;
  oExtensibleMatch.matchValue := ReadString;
  if not SequenceEnded then
    oExtensibleMatch.dnAttributes := ReadBoolean
  else
    oExtensibleMatch.dnAttributes := False;
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadAttributes(oAttributes: TIdLDAPV3AttributeDescriptionList);
begin
  ReadSequencebegin;
  while not SequenceEnded do
    oAttributes.Add(ReadString);
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadSearchRequest(oMessage : TIdLDAPV3Message);
begin
  oMessage.searchRequest := TIdLDAPV3SearchRequest.Create;
  ReadSequencebegin;
  oMessage.searchRequest.baseObject := ReadString;
  oMessage.searchRequest.scope := TIdLDAPV3SearchScope(ReadEnum);
  oMessage.searchRequest.derefAliases := TIdLDAPV3SearchDerefAliases(ReadEnum);
  oMessage.searchRequest.sizeLimit := ReadInteger;
  oMessage.searchRequest.timeLimit := ReadInteger;
  oMessage.searchRequest.typesOnly := ReadBoolean;
  ReadFilter(oMessage.searchRequest.filter);
  ReadAttributes(oMessage.searchRequest.attributes);
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadSearchResultEntry(oMessage: TIdLDAPV3Message);
begin
  oMessage.searchResEntry := TIdLDAPV3SearchResultEntry.Create;
  ReadSequencebegin;
  oMessage.searchResEntry.objectName := ReadString;
  ReadPartialAttributeList(oMessage.searchResEntry.attributes);
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadSearchResultDone(oMessage: TIdLDAPV3Message);
begin
  oMessage.searchResDone := TIdLDAPV3SearchResultDone.Create;
  ReadSequencebegin;
  ReadResultInner(oMessage.searchResDone);
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadMessage(oMessage: TIdLDAPV3Message);
begin
  StartReading;
  oMessage.Clear;
  ReadSequencebegin;
  oMessage.messageID := ReadInteger;
  case NextTag Of
    0  : ReadBindRequest(oMessage);
    1  : ReadBindResponse(oMessage);
//    2  : ReadUnbindRequest(oMessage);
    3  : ReadSearchRequest(oMessage);
    4  : ReadSearchResultEntry(oMessage);
    5  : ReadSearchResultDone(oMessage);
//    6  : ReadModifyRequest(oMessage);
//    7  : ReadModifyResponse(oMessage);
//    8  : ReadAddRequest(oMessage);
//    9  : ReadAddResponse(oMessage);
//    10  : ReadDelRequest(oMessage);
//    11  : ReadDelResponse(oMessage);
//    12  : ReadModifyDNRequest(oMessage);
//    13  : ReadModifyDNResponse(oMessage);
//    14  : ReadCompareRequest(oMessage);
//    15  : ReadCompareResponse(oMessage);
//    16  : ReadAbandonRequest(oMessage);
//    19  : ReadSearchResultReference(oMessage);
//    23  : ReadExtendedRequest(oMessage);
//    24  : ReadExtendedResponse(oMessage);
  else
    raise EIdException.create('Unknown Tag '+IntToStr(NextTag)); {do not localize} // TODO: add a resource string, and create a new Exception class for this
  end;
  // while not SequenceEnded do
  //   readControl....
  ReadSequenceend;
  StopReading;
end;

procedure TIdLDAPV3Decoder.ReadResultInner(oResult: TIdLDAPV3LDAPResult);
begin
  oResult.resultCode := TIdLDAPV3ResultCode(ReadEnum);
  oResult.matchedDN := ReadString;
  oResult.errorMessage := ReadString;
  if not SequenceEnded and (NextTag = 3) then
  begin
    oResult.referral := TIdLDAPV3Referral.Create;
    ReadReferral(oResult.Referral);
  end;
end;

procedure TIdLDAPV3Decoder.ReadReferral(oReferral: TIdLDAPV3Referral);
begin
  ReadSequencebegin;
  while not SequenceEnded do
    oReferral.Add(ReadString);
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadPartialAttributeList(oAttributes: TIdLDAPV3PartialAttributeList);
Var
  oAttr : TIdLDAPV3PartialAttribute;
begin
  ReadSequencebegin;
  while not SequenceEnded do
    begin
    ReadPartialAttribute(oAttr);
    oAttributes.Add(oAttr);
    end;
  ReadSequenceend;
end;

procedure TIdLDAPV3Decoder.ReadPartialAttribute(oAttribute: TIdLDAPV3PartialAttribute);
begin
  ReadSequencebegin;
  oAttribute._type := ReadString;
  ReadSequencebegin;
  while not SequenceEnded do
    oAttribute.vals.Add(ReadString);
  ReadSequenceend;
  ReadSequenceend;
end;

End.