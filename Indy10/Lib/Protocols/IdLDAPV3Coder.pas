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
{   Rev 1.0    15/04/2005 7:25:06 AM  GGrieve
{ first ported to INdy
}
Unit IdLDAPV3Coder;

Interface

Uses
  IdASN1Coder,
  IdLdapV3;

Type
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
    Procedure WriteReferral(oReferral : TIdLDAPV3Referral; iTag : integer);
    Procedure WritePartialAttributeList(oAttributes : TIdLDAPV3PartialAttributeList; iTag : integer);
    Procedure WritePartialAttribute(oAttribute : TIdLDAPV3PartialAttribute; iTag : integer);

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
  Public
    Procedure Produce(oMessage : TIdLDAPV3Message); Overload; Virtual;
  End;

Type
  TIdLDAPV3Decoder = Class (TIdASN1Decoder)
  Private
    Procedure ReadFilter(oFilter : TIdLDAPV3Filter);
    Procedure ReadFilterList(oFilterList : TIdLDAPV3FilterList);
    Procedure ReadAttributes(oAttributes : TIdLDAPV3AttributeDescriptionList);
    Procedure ReadAttributeValueAssertion(oEqualityMatch : TIdLDAPV3AttributeValueAssertion);
    Procedure ReadSubstringFilter(oSubstrings : TIdLDAPV3SubstringFilter);
    Procedure ReadMatchingRuleAssertion(oExtensibleMatch : TIdLDAPV3MatchingRuleAssertion);
    Procedure ReadSubString(oString : TIdLDAPV3Substring);
    Procedure ReadPartialAttribute(oAttribute : TIdLDAPV3PartialAttribute);
    Procedure ReadPartialAttributeList(oAttributes : TIdLDAPV3PartialAttributeList);

    Procedure ReadReferral(oReferral : TIdLDAPV3Referral);
    Procedure ReadResultInner(oResult : TIdLDAPV3LDAPResult);

    Procedure ReadBindRequest(oMessage : TIdLDAPV3Message);
    Procedure ReadBindResponse(oMessage : TIdLDAPV3Message);
    Procedure ReadSearchRequest(oMessage : TIdLDAPV3Message);
    Procedure ReadSearchResultEntry(oMessage : TIdLDAPV3Message);
    Procedure ReadSearchResultDone(oMessage : TIdLDAPV3Message);
  Public
    Procedure ReadMessage(oMessage : TIdLDAPV3Message); Overload; Virtual;
  End;


Implementation

uses
  SysUtils,
  IdException;

{ TIdLDAPV3Encoder }

Procedure TIdLDAPV3Encoder.Produce(oMessage: TIdLDAPV3Message);
Begin
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
    Raise EIdException.create('No Protocol Choice operation on message');
  StopSequence;
  StopWriting;
End;

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
  Raise EIdException.create('Not yet implemented');
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
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritemodifyRequest(oModifyRequest : TIdLDAPV3ModifyRequest);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritemodifyResponse(oModifyResponse : TIdLDAPV3ModifyResponse);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WriteaddRequest(oAddRequest : TIdLDAPV3AddRequest);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WriteaddResponse(oAddResponse : TIdLDAPV3AddResponse);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritedelRequest(oDelRequest : TIdLDAPV3DelRequest);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritedelResponse(oDelResponse : TIdLDAPV3DelResponse);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritemodDNRequest(oModDNRequest : TIdLDAPV3ModifyDNRequest);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritemodDNResponse(oModDNResponse : TIdLDAPV3ModifyDNResponse);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritecompareRequest(oCompareRequest : TIdLDAPV3CompareRequest);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WritecompareResponse(oCompareResponse : TIdLDAPV3CompareResponse);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WriteabandonRequest(oAbandonRequest : TIdLDAPV3AbandonRequest);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WriteextendedReq(oExtendedReq : TIdLDAPV3ExtendedRequest);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WriteextendedResp(oExtendedResp : TIdLDAPV3ExtendedResponse);
begin
  Raise EIdException.create('Not yet implemented');
end;

procedure TIdLDAPV3Encoder.WriteAuthentication(oAuthentication: TIdLDAPv3AuthenticationChoice);
begin
  if assigned(oAuthentication.sasl) then
    Raise EIdException.create('sasl not handled yet')
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
    Raise EIdException.create('No operation Choice on Filter');
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
End;


{ TIdLDAPV3Decoder }

Procedure TIdLDAPV3Decoder.ReadBindRequest(oMessage: TIdLDAPV3Message);
Begin
  oMessage.bindRequest := TIdLDAPV3BindRequest.Create;
  ReadSequenceBegin;
  oMessage.bindRequest.version := ReadInteger;
  oMessage.bindRequest.name := ReadString;
  Case NextTag Of
    0: oMessage.bindRequest.authentication.simple := ReadString;
    3: Raise EIdException.create('SASL Not handled yet');
  Else
    Raise EIdException.create('Unknown Tag '+IntToStr(NextTag));
  End;
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadBindResponse(oMessage: TIdLDAPV3Message);
Begin
  oMessage.bindResponse := TIdLDAPV3BindResponse.Create;
  ReadSequenceBegin;
  ReadResultInner(oMessage.BindResponse);
  If Not SequenceEnded Then
    oMessage.bindResponse.serverSaslCreds := ReadString;
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadFilter(oFilter: TIdLDAPV3Filter);
Begin
  Case NextTag Of
    0: Begin
       oFilter._and := TIdLDAPV3FilterList.Create;
       ReadFilterList(oFilter._and);
       End;
    1: Begin
       oFilter._or := TIdLDAPV3FilterList.Create;
       ReadFilterList(oFilter._or);
       End;
    2: Begin
       oFilter._not := TIdLDAPV3Filter.Create;
       ReadFilter(oFilter._not);
       End;
    3: Begin
       oFilter.equalityMatch  := TIdLDAPV3AttributeValueAssertion.Create;
       ReadAttributeValueAssertion(oFilter.equalityMatch );
       End;
    4: Begin
       oFilter.substrings     := TIdLDAPV3SubstringFilter.Create;
       ReadSubstringFilter(oFilter.substrings);
       End;
    5: Begin
       oFilter.greaterOrEqual := TIdLDAPV3AttributeValueAssertion.Create;
       ReadAttributeValueAssertion(oFilter.greaterOrEqual);
       End;
    6: Begin
       oFilter.lessOrEqual    := TIdLDAPV3AttributeValueAssertion.Create;
       ReadAttributeValueAssertion(oFilter.lessOrEqual);
       End;
    7: oFilter.present := ReadString;
    8: Begin
       oFilter.approxMatch    := TIdLDAPV3AttributeValueAssertion.Create;
       ReadAttributeValueAssertion(oFilter.approxMatch);
       End;
    9: Begin
       oFilter.extensibleMatch := TIdLDAPV3MatchingRuleAssertion.Create;
       ReadMatchingRuleAssertion(oFilter.extensibleMatch);
       End;
  Else
    Raise EIdException.create('Unknown Tag '+IntToStr(NextTag));
  End;
End;

Procedure TIdLDAPV3Decoder.ReadFilterList(oFilterList : TIdLDAPV3FilterList);
Var
  oFilter : TIdLDAPV3Filter;
Begin
  While NextTagType = aitSequence Do
    Begin
    ReadFilter(oFilter);
    oFilterList.Add(oFilter);
    End;
End;

Procedure TIdLDAPV3Decoder.ReadAttributeValueAssertion(oEqualityMatch : TIdLDAPV3AttributeValueAssertion);
Begin
  ReadSequenceBegin;
  oEqualityMatch.attributeDesc := ReadString;
  oEqualityMatch.assertionValue := ReadString;
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadSubString(oString: TIdLDAPV3Substring);
Begin
  ReadSequenceBegin;
  Case NextTag Of
    0 : oString.initial := ReadString;
    1 : oString.any     := ReadString;
    2 : oString.final   := ReadString;
  Else
    Raise EIdException.create('Unknown Tag '+IntToStr(NextTag));
  End;
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadSubstringFilter(oSubstrings : TIdLDAPV3SubstringFilter);
Var
  oString : TIdLDAPV3Substring;
Begin
  ReadSequenceBegin;
  oSubstrings._type := ReadString;
  While Not SequenceEnded Do
    Begin
    ReadSubString(oString);
    oSubstrings.substrings.Add(oString);
    End;
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadMatchingRuleAssertion(oExtensibleMatch : TIdLDAPV3MatchingRuleAssertion);
Begin
  ReadSequenceBegin;
  If NextTag = 1 Then
    oExtensibleMatch.matchingRule := ReadString;
  If NextTag = 2 Then
    oExtensibleMatch._type := ReadString;
  oExtensibleMatch.matchValue := ReadString;
  If Not SequenceEnded Then
    oExtensibleMatch.dnAttributes := ReadBoolean
  Else
    oExtensibleMatch.dnAttributes := False;
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadAttributes(oAttributes: TIdLDAPV3AttributeDescriptionList);
Begin
  ReadSequenceBegin;
  While Not SequenceEnded Do
    oAttributes.Add(ReadString);
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadSearchRequest(oMessage : TIdLDAPV3Message);
Begin
  oMessage.searchRequest := TIdLDAPV3SearchRequest.Create;
  ReadSequenceBegin;
  oMessage.searchRequest.baseObject := ReadString;
  oMessage.searchRequest.scope := TIdLDAPV3SearchScope(ReadEnum);
  oMessage.searchRequest.derefAliases := TIdLDAPV3SearchDerefAliases(ReadEnum);
  oMessage.searchRequest.sizeLimit := ReadInteger;
  oMessage.searchRequest.timeLimit := ReadInteger;
  oMessage.searchRequest.typesOnly := ReadBoolean;
  ReadFilter(oMessage.searchRequest.filter);
  ReadAttributes(oMessage.searchRequest.attributes);
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadSearchResultEntry(oMessage: TIdLDAPV3Message);
Begin
  oMessage.searchResEntry := TIdLDAPV3SearchResultEntry.Create;
  ReadSequenceBegin;
  oMessage.searchResEntry.objectName := ReadString;
  ReadPartialAttributeList(oMessage.searchResEntry.attributes);
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadSearchResultDone(oMessage: TIdLDAPV3Message);
Begin
  oMessage.searchResDone := TIdLDAPV3SearchResultDone.Create;
  ReadSequenceBegin;
  ReadResultInner(oMessage.searchResDone);
  ReadSequenceEnd;
End;


Procedure TIdLDAPV3Decoder.ReadMessage(oMessage: TIdLDAPV3Message);
Begin
  StartReading;
  oMessage.Clear;
  ReadSequenceBegin;
  oMessage.messageID := ReadInteger;
  Case NextTag Of
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
  Else
    Raise EIdException.create('Unknown Tag '+IntToStr(NextTag));
  End;
  // while not SequenceEnded do
  //   readControl....
  ReadSequenceEnd;
  StopReading;
End;

Procedure TIdLDAPV3Decoder.ReadResultInner(oResult: TIdLDAPV3LDAPResult);
Begin
  oResult.resultCode := TIdLDAPV3ResultCode(ReadEnum);
  oResult.matchedDN := ReadString;
  oResult.errorMessage := ReadString;
  If Not SequenceEnded And (NextTag = 3) Then
    Begin
    oResult.referral := TIdLDAPV3Referral.Create;
    ReadReferral(oResult.Referral);
    End;
End;

Procedure TIdLDAPV3Decoder.ReadReferral(oReferral: TIdLDAPV3Referral);
Begin
  ReadSequenceBegin;
  While Not SequenceEnded Do
    oReferral.Add(ReadString);
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadPartialAttributeList(oAttributes: TIdLDAPV3PartialAttributeList);
Var
  oAttr : TIdLDAPV3PartialAttribute;
Begin
  ReadSequenceBegin;
  While Not SequenceEnded Do
    Begin
    ReadPartialAttribute(oAttr);
    oAttributes.Add(oAttr);
    End;
  ReadSequenceEnd;
End;

Procedure TIdLDAPV3Decoder.ReadPartialAttribute(oAttribute: TIdLDAPV3PartialAttribute);
Begin
  ReadSequenceBegin;
  oAttribute._type := ReadString;
  ReadSequenceBegin;
  While Not SequenceEnded Do
    oAttribute.vals.Add(ReadString);
  ReadSequenceEnd;
  ReadSequenceEnd;
End;

End.
