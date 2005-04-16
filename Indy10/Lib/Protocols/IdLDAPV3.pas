{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  117094: IdLDAPV3.pas 
{
{   Rev 1.0    15/04/2005 7:25:04 AM  GGrieve
{ first ported to INdy
}
Unit IdLDAPV3;


{! 4 !}


Interface


Uses
  Classes,
  Contnrs;


Type
  TIdLDAPV3ResultCode = (
          lrcSuccess,
          lrcOperationsError,
          lrcProtocolError,
          lrcTimeLimitExceeded,
          lrcSizeLimitExceeded,
          lrcCompareFalse,
          lrcCompareTrue,
          lrcAuthMethodNotSupported,
          lrcStrongAuthRequired,
                                                             lrcReserved9,
          lrcReferral,
          lrcAdminLimitExceeded,
          lrcUnavailableCriticalExtension,
          lrcConfidentialityRequired,
          lrcSaslBindInProgress,
          lrcNoSuchAttribute,
          lrcUndefinedAttributeType,
          lrcInappropriateMatching,
          lrcConstraintViolation,
          lrcAttributeOrValueExists,
          lrcInvalidAttributeSyntax,
                                                             lrcReserved22,
                                                             lrcReserved23,
                                                             lrcReserved24,
                                                             lrcReserved25,
                                                             lrcReserved26,
                                                             lrcReserved27,
                                                             lrcReserved28,
                                                             lrcReserved29,
                                                             lrcReserved30,
                                                             lrcReserved31,
          lrcNoSuchObject,
          lrcAliasProblem,
          lrcInvalidDNSyntax,
                                                             lrcReserved_undefinedIsLeaf,
          lrcAliasDereferencingProblem,
                                                             lrcReserved37,
                                                             lrcReserved38,
                                                             lrcReserved39,
                                                             lrcReserved40,
                                                             lrcReserved41,
                                                             lrcReserved42,
                                                             lrcReserved43,
                                                             lrcReserved44,
                                                             lrcReserved45,
                                                             lrcReserved46,
                                                             lrcReserved47,
          lrcInappropriateAuthentication,
          lrcInvalidCredentials,
          lrcInsufficientAccessRights,
          lrcBusy,
          lrcUnavailable,
          lrcUnwillingToPerform,
          lrcLoopDetect,
                                                             lrcReserved55,
                                                             lrcReserved56,
                                                             lrcReserved57,
                                                             lrcReserved58,
                                                             lrcReserved59,
                                                             lrcReserved60,
                                                             lrcReserved61,
                                                             lrcReserved62,
                                                             lrcReserved63,
          lrcNamingViolation,
          lrcObjectClassViolation,
          lrcNotAllowedOnNonLeaf,
          lrcNotAllowedOnRDN,
          lrcEntryAlreadyExists,
          lrcObjectClassModsProhibited,
                                                             lrcReservedCLDAP,
          lrcAffectsMultipleDSAs,
                                                             lrcReserved72,
                                                             lrcReserved73,
                                                             lrcReserved74,
                                                             lrcReserved75,
                                                             lrcReserved76,
                                                             lrcReserved77,
                                                             lrcReserved78,
                                                             lrcReserved79,
          lrcOther);


  TIdLDAPV3SearchScope = (ssBaseObject, ssSingleLevel, ssWholeSubtree);
  TIdLDAPV3SearchDerefAliases = (sdNeverDerefAliases, sdDerefInSearching, sdDerefFindingBaseObj, sdDerefAlways);

  TIdLDAPV3ModificationOperation = (moAdd, omDelete, moReplace);


Const
  NAMES_LDAPV3RESULTCODE : Array [TIdLDAPV3ResultCode] Of String = (
    'Success',
    'OperationsError',
    'ProtocolError',
    'TimeLimitExceeded',
    'SizeLimitExceeded',
    'CompareFalse',
    'CompareTrue',
    'AuthMethodNotSupported',
    'StrongAuthRequired',
    'Reserved9',
    'Referral',
    'AdminLimitExceeded',
    'UnavailableCriticalExtension',
    'ConfidentialityRequired',
    'SaslBindInProgress',
    'NoSuchAttribute',
    'UndefinedAttributeType',
    'InappropriateMatching',
    'ConstraintViolation',
    'AttributeOrValueExists',
    'InvalidAttributeSyntax',
    'Reserved22',
    'Reserved23',
    'Reserved24',
    'Reserved25',
    'Reserved26',
    'Reserved27',
    'Reserved28',
    'Reserved29',
    'Reserved30',
    'Reserved31',
    'NoSuchObject',
    'AliasProblem',
    'InvalidDNSyntax',
    'Reserved_undefinedIsLeaf',
    'AliasDereferencingProblem',
    'Reserved37',
    'Reserved38',
    'Reserved39',
    'Reserved40',
    'Reserved41',
    'Reserved42',
    'Reserved43',
    'Reserved44',
    'Reserved45',
    'Reserved46',
    'Reserved47',
    'InappropriateAuthentication',
    'InvalidCredentials',
    'InsufficientAccessRights',
    'Busy',
    'Unavailable',
    'UnwillingToPerform',
    'LoopDetect',
    'Reserved55',
    'Reserved56',
    'Reserved57',
    'Reserved58',
    'Reserved59',
    'Reserved60',
    'Reserved61',
    'Reserved62',
    'Reserved63',
    'NamingViolation',
    'ObjectClassViolation',
    'NotAllowedOnNonLeaf',
    'NotAllowedOnRDN',
    'EntryAlreadyExists',
    'ObjectClassModsProhibited',
    'ReservedCLDAP',
    'AffectsMultipleDSAs',
    'Reserved72',
    'Reserved73',
    'Reserved74',
    'Reserved75',
    'Reserved76',
    'Reserved77',
    'Reserved78',
    'Reserved79',
    'Other');

  NAMES_LDAPV3SEARCHSCOPE : Array [TIdLDAPV3SearchScope] Of String = ('BaseObject', 'SingleLevel', 'WholeSubtree');
  NAMES_LDAPV3SEARCHDEREFALIASES : Array [TIdLDAPV3SearchDerefAliases] Of String = ('NeverDerefAliases', 'DerefInSearching', 'DerefFindingBaseObj', 'DerefAlways');
  NAMES_LDAPV3MODIFICATIONOPERATION : Array [TIdLDAPV3ModificationOperation] Of String = ('Add', 'Delete', 'Replace');


Type

  // simple types
  TIdLDAPV3MessageID = Integer;//  >= 0

  TIdLDAPV3LDAPString = String; // UTF-8
  TIdLDAPV3LDAPOID = String;
  TIdLDAPV3LDAPDN = TIdLDAPV3LDAPString;
  TIdLDAPV3RelativeLDAPDN = TIdLDAPV3LDAPString;
  TIdLDAPV3AttributeType = TIdLDAPV3LDAPString;
  TIdLDAPV3AttributeDescription = TIdLDAPV3LDAPString;
  TIdLDAPV3AttributeValue = String;
  TIdLDAPV3AssertionValue = String;
  TIdLDAPV3MatchingRuleId = TIdLDAPV3LDAPString;

  TIdLDAPV3AttributeDescriptionList = TStringList;
  TIdLDAPV3AttributeValueSet = TStringList;
  TIdLDAPV3Referral = TStringList;

  // general Classes
  TIdLDAPV3Control = Class (TObject)
  Private
    FCriticality: Boolean;
    FControlValue: String;
    FControlType: TIdLDAPV3LDAPOID;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property controlType : TIdLDAPV3LDAPOID Read FControlType Write FControlType;
    Property criticality : Boolean Read FCriticality Write FCriticality; // DEFAULT FALSE,
    Property controlValue : String Read FControlValue Write FControlValue; // OPTIONAL
  End;

  TIdLDAPV3ControlList = Class (TObjectList)
  Private
    Function GetControl(iIndex : Integer):TIdLDAPV3Control;
  Protected
  Public
    Property Control[iIndex : Integer] : TIdLDAPV3Control Read GetControl; default;
  End;

  TIdLDAPV3AttributeValueAssertion = Class (TObject)
  Private
    FAssertionValue: TIdLDAPV3AssertionValue;
    FAttributeDesc: TIdLDAPV3AttributeDescription;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property attributeDesc : TIdLDAPV3AttributeDescription Read FAttributeDesc Write FAttributeDesc;
    Property assertionValue : TIdLDAPV3AssertionValue Read FAssertionValue Write FAssertionValue;
  End;

  TIdLDAPV3Attribute = Class (TObject)
  Private
    FType: TIdLDAPV3AttributeDescription;
    FVals: TIdLDAPV3AttributeValueSet;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property _type : TIdLDAPV3AttributeDescription Read FType Write FType;
    Property vals : TIdLDAPV3AttributeValueSet Read FVals Write FVals;
  End;

  TIdLDAPV3AttributeList = Class (TObjectList)
  Private
    Function GetAttribute(iIndex : Integer):TIdLDAPV3Attribute;
  Protected
  Public
    Property Attribute[iIndex : Integer] : TIdLDAPV3Attribute Read GetAttribute; default;
  End;

  // Message Classes
  TIdLDAPV3LDAPResult = Class (TObject)
  Private
    FMatchedDN: TIdLDAPV3LDAPDN;
    FErrorMessage: TIdLDAPV3LDAPString;
    FReferral: TIdLDAPV3Referral;
    FResultCode: TIdLDAPV3ResultCode;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property resultCode : TIdLDAPV3ResultCode Read FResultCode Write FResultCode;
    Property matchedDN : TIdLDAPV3LDAPDN Read FMatchedDN Write FMatchedDN;
    Property errorMessage : TIdLDAPV3LDAPString Read FErrorMessage Write FErrorMessage;
    Property {3} referral : TIdLDAPV3Referral Read FReferral Write FReferral; // OPTIONAL
  End;

  TIdLDAPV3SaslCredentials = Class (TObject)
  Private
    FCredentials: String;
    FMechanism: TIdLDAPV3LDAPString;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property mechanism : TIdLDAPV3LDAPString Read FMechanism Write FMechanism;
    Property credentials : String Read FCredentials Write FCredentials; // OPTIONAL
  End;

  TIdLDAPV3AuthenticationChoice = Class (TObject)
  Private
    FSimple: String;
    FSasl: TIdLDAPV3SaslCredentials;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    // choice
      Property {0} simple : String Read FSimple Write FSimple;
      Property {3} sasl : TIdLDAPV3SaslCredentials Read FSasl Write FSasl;
  End;

  {0}
  TIdLDAPV3BindRequest = Class (TObject)
  Private
    FVersion: Byte;
    FAuthentication: TIdLDAPv3AuthenticationChoice;
    FName: TIdLDAPV3LDAPDN;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property version : Byte Read FVersion Write FVersion;
    Property name : TIdLDAPV3LDAPDN Read FName Write FName;
    Property authentication : TIdLDAPv3AuthenticationChoice Read FAuthentication Write FAuthentication;
  End;

  {1}
  TIdLDAPV3BindResponse = Class (TIdLDAPv3LDAPResult)
  Private
    FServerSaslCreds: String;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Override;

    Property {7} serverSaslCreds : String Read FServerSaslCreds Write FServerSaslCreds; // optional
  End;

  {2}
  TIdLDAPV3UnbindRequest = Class (TObject)
  Public
  End;

  TIdLDAPV3Substring = Class (TObject)
  Private
    FAny: TIdLDAPV3LDAPString;
    FFinal: TIdLDAPV3LDAPString;
    FInitial: TIdLDAPV3LDAPString;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property {0} initial : TIdLDAPV3LDAPString Read FInitial Write FInitial;
    Property {1} any     : TIdLDAPV3LDAPString Read FAny   Write FAny    ;
    Property {2} final   : TIdLDAPV3LDAPString Read FFinal Write FFinal  ;
  End;

  TIdLDAPV3SubstringList = Class (TObjectList)
  Private
    Function GetSubstring(iIndex : Integer):TIdLDAPV3Substring;
  Protected
  Public
    Property Substring[iIndex : Integer] : TIdLDAPV3Substring Read GetSubstring; default;
  End;

  TIdLDAPV3SubstringFilter = Class (TObject)
  Private
    FType: TIdLDAPV3AttributeDescription;
    FSubstrings: TIdLDAPV3SubstringList;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property _type : TIdLDAPV3AttributeDescription Read FType Write FType;
    Property substrings : TIdLDAPV3SubstringList Read FSubstrings Write FSubstrings; // rule: count > 0
  End;

  TIdLDAPV3MatchingRuleAssertion = Class (TObject)
  Private
    FDnAttributes: Boolean;
    FMatchValue: TIdLDAPV3AssertionValue;
    FType: TIdLDAPV3AttributeDescription;
    FMatchingRule: TIdLDAPV3MatchingRuleId;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property {1} matchingRule    : TIdLDAPV3MatchingRuleId Read FMatchingRule   Write FMatchingRule   ; // OPTIONAL
    Property {2} _type           : TIdLDAPV3AttributeDescription Read FType           Write FType           ; // OPTIONAL
    Property {3} matchValue      : TIdLDAPV3AssertionValue Read FMatchValue     Write FMatchValue     ;
    Property {4} dnAttributes    : Boolean Read FDnAttributes   Write FDnAttributes   ; // DEFAULT FALSE
  End;

  TIdLDAPV3FilterList = Class;

  TIdLDAPV3Filter = Class (TObject)
  Private
    FPresent: TIdLDAPV3AttributeDescription;
    FEqualityMatch: TIdLDAPV3AttributeValueAssertion;
    FLessOrEqual: TIdLDAPV3AttributeValueAssertion;
    FgreaterOrEqual: TIdLDAPV3AttributeValueAssertion;
    FApproxMatch: TIdLDAPV3AttributeValueAssertion;
    FNot: TIdLDAPV3Filter;
    F_Or: TIdLDAPV3FilterList;
    FAnd: TIdLDAPV3FilterList;
    FExtensibleMatch: TIdLDAPV3MatchingRuleAssertion;
    FSubstrings: TIdLDAPV3SubstringFilter;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property {0} _and : TIdLDAPV3FilterList Read FAnd Write FAnd;
    Property {1} _or : TIdLDAPV3FilterList Read F_Or Write F_or;
    Property {2} _not : TIdLDAPV3Filter Read FNot Write FNot;
    Property {3} equalityMatch  : TIdLDAPV3AttributeValueAssertion Read FEqualityMatch Write FEqualityMatch ;
    Property {4} substrings     : TIdLDAPV3SubstringFilter Read FSubstrings    Write FSubstrings    ;
    Property {5} greaterOrEqual : TIdLDAPV3AttributeValueAssertion Read FGreaterOrEqual Write FGreaterOrEqual;
    Property {6} lessOrEqual    : TIdLDAPV3AttributeValueAssertion Read FLessOrEqual   Write FLessOrEqual   ;
    Property {7} present        : TIdLDAPV3AttributeDescription Read FPresent       Write FPresent       ;
    Property {8} approxMatch    : TIdLDAPV3AttributeValueAssertion Read FApproxMatch   Write FApproxMatch   ;
    Property {9} extensibleMatch : TIdLDAPV3MatchingRuleAssertion Read FExtensibleMatch Write FExtensibleMatch;
  End;

  TIdLDAPV3FilterList = Class (TObjectList)
  Private
    Function GetFilter(iIndex : Integer):TIdLDAPV3Filter;
  Protected
  Public
    Property Filter[iIndex : Integer] : TIdLDAPV3Filter Read GetFilter; default;
  End;

  {3}
  TIdLDAPV3SearchRequest = Class (TObject)
  Private
    FTypesOnly: Boolean;
    FTimeLimit: Integer;
    FSizeLimit: Integer;
    FAttributes: TIdLDAPV3AttributeDescriptionList;
    FFilter: TIdLDAPV3Filter;
    FBaseObject: TIdLDAPV3LDAPDN;
    FDerefAliases: TIdLDAPV3SearchDerefAliases;
    FScope: TIdLDAPV3SearchScope;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property baseObject : TIdLDAPV3LDAPDN Read FBaseObject Write FBaseObject;
    Property scope : TIdLDAPV3SearchScope Read FScope Write FScope;
    Property derefAliases : TIdLDAPV3SearchDerefAliases Read FDerefAliases Write FDerefAliases;
    Property sizeLimit : Integer Read FSizeLimit Write FSizeLimit;
    Property timeLimit : Integer Read FTimeLimit Write FTimeLimit;
    Property typesOnly : Boolean Read FTypesOnly Write FTypesOnly;
    Property filter : TIdLDAPV3Filter Read FFilter Write FFilter;
    Property attributes : TIdLDAPV3AttributeDescriptionList Read FAttributes Write FAttributes;
  End;

  TIdLDAPV3PartialAttribute = Class (TObject)
  Private
    FType: TIdLDAPV3AttributeDescription;
    FVals: TIdLDAPV3AttributeValueSet;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property _type : TIdLDAPV3AttributeDescription Read FType Write FType;
    Property vals : TIdLDAPV3AttributeValueSet Read FVals Write FVals;
  End;

  TIdLDAPV3PartialAttributeList = Class (TObjectList)
  Private
    Function GetPartialAttribute(iIndex : Integer):TIdLDAPV3PartialAttribute;
  Protected
  Public
    Property PartialAttribute[iIndex : Integer] : TIdLDAPV3PartialAttribute Read GetPartialAttribute; default;
  End;

  {4}
  TIdLDAPV3SearchResultEntry = Class (TObject)
  Private
    FObjectName: TIdLDAPV3LDAPDN;
    FAttributes: TIdLDAPV3PartialAttributeList;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property objectName : TIdLDAPV3LDAPDN Read FObjectName Write FObjectName;
    Property attributes : TIdLDAPV3PartialAttributeList Read FAttributes Write FAttributes;
  End;

  {5}
  TIdLDAPV3SearchResultDone = Class (TIdLDAPV3LDAPResult)
  Public
  End;

  TIdLDAPV3AttributeTypeAndValues = Class (TObject)
  Private
    FType: TIdLDAPV3AttributeDescription;
    FVals: TIdLDAPV3AttributeValueSet;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property _type : TIdLDAPV3AttributeDescription Read FType Write FType;
    Property vals : TIdLDAPV3AttributeValueSet Read FVals Write FVals;
  End;

  TIdLDAPV3Modification = Class (TObject)
  Private
    FModification: TIdLDAPV3AttributeTypeAndValues;
    FOperation: TIdLDAPV3ModificationOperation;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property operation : TIdLDAPV3ModificationOperation Read FOperation Write FOperation;
    Property modification : TIdLDAPV3AttributeTypeAndValues Read FModification Write FModification;
  End;

  TIdLDAPV3ModificationList = Class (TObjectList)
  Private
    Function GetModification(iIndex : Integer):TIdLDAPV3Modification;
  Protected
  Public
    Property Modification[iIndex : Integer] : TIdLDAPV3Modification Read GetModification; default;
  End;

  {6}
  TIdLDAPV3ModifyRequest = Class (TObject)
  Private
    FObject: TIdLDAPV3LDAPDN;
    FModifications: TIdLDAPV3ModificationList;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property _object : TIdLDAPV3LDAPDN Read FObject Write FObject;
    Property modifications : TIdLDAPV3ModificationList Read FModifications Write FModifications;
  End;

  {7}
  TIdLDAPV3ModifyResponse = Class (TIdLDAPV3LDAPResult)
  Public
  End;

  {8}
  TIdLDAPV3AddRequest = Class (TObject)
  Private
    FAttributes: TIdLDAPV3AttributeList;
    FEntry: TIdLDAPV3LDAPDN;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property entry : TIdLDAPV3LDAPDN Read FEntry Write FEntry;
    Property attributes : TIdLDAPV3AttributeList Read FAttributes Write FAttributes;
  End;

  {9}
  TIdLDAPV3AddResponse = Class (TIdLDAPV3LDAPResult)
  Public
  End;

  {10}
  TIdLDAPV3DelRequest = Class (TObject)
  Private
    FEntry: TIdLDAPV3LDAPDN;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property entry : TIdLDAPV3LDAPDN Read FEntry Write FEntry;
  End;

  {11}
  TIdLDAPV3DelResponse = Class(TIdLDAPV3LDAPResult)
  Public
  End;

  {12}
  TIdLDAPV3ModifyDNRequest = Class (TObject)
  Private
    FDeleteoldrdn: Boolean;
    FNewSuperior: TIdLDAPV3LDAPDN;
    FEntry: TIdLDAPV3LDAPDN;
    FNewrdn: TIdLDAPV3RelativeLDAPDN;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property entry : TIdLDAPV3LDAPDN Read FEntry Write FEntry;
    Property newrdn : TIdLDAPV3RelativeLDAPDN Read FNewrdn Write FNewrdn;
    Property deleteoldrdn : Boolean Read FDeleteoldrdn Write FDeleteoldrdn;
    Property {0} newSuperior : TIdLDAPV3LDAPDN Read FNewSuperior Write FNewSuperior; // OPTIONAL
  End;

  {13}
  TIdLDAPV3ModifyDNResponse = Class(TIdLDAPV3LDAPResult)
  Public
  End;

  {14}
  TIdLDAPV3CompareRequest = Class (TObject)
  Private
    FAva: TIdLDAPV3AttributeValueAssertion;
    FEntry: TIdLDAPV3LDAPDN;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property entry : TIdLDAPV3LDAPDN Read FEntry Write FEntry;
    Property ava : TIdLDAPV3AttributeValueAssertion Read FAva Write FAva;
  End;

  {15}
  TIdLDAPV3CompareResponse = Class(TIdLDAPV3LDAPResult)
  Public
  End;

  {16}
  TIdLDAPV3AbandonRequest = Class (TObject)
  Private
    FId: TIdLDAPV3MessageID;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property id : TIdLDAPV3MessageID Read FId Write FId;
  End;

  {19}
  TIdLDAPV3SearchResultReference = Class (TObject)
  Private
    FRef: TIdLDAPV3Referral;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property ref : TIdLDAPV3Referral Read FRef Write FRef;
  End;

  {23}
  TIdLDAPV3ExtendedRequest = Class (TObject)
  Private
    FRequestValue: String;
    FRequestName: TIdLDAPV3LDAPOID;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;

    Property {0} requestName : TIdLDAPV3LDAPOID Read FRequestName Write FRequestName;
    Property {1} requestValue : String Read FRequestValue Write FRequestValue; // OPTIONAL
  End;

  {24}
  TIdLDAPV3ExtendedResponse = Class (TIdLDAPV3LDAPResult)
  Private
    FResponse: String;
    FResponseName: TIdLDAPV3LDAPOID;
  Public
    Constructor Create; 
    Destructor Destroy; Override;
    Procedure Clear; Overload; Override;

    Property {10} responseName : TIdLDAPV3LDAPOID Read FResponseName Write FResponseName; // OPTIONAL
    Property {11} response : String Read FResponse Write FResponse; // OPTIONAL
  End;

  TIdLDAPV3LDAPMessage = Class (TObject)
  Private
    FAbandonRequest: TIdLDAPV3AbandonRequest;
    FAddRequest: TIdLDAPV3AddRequest;
    FAddResponse: TIdLDAPV3AddResponse;
    FBindRequest: TIdLDAPV3BindRequest;
    FBindResponse: TIdLDAPV3BindResponse;
    FCompareRequest: TIdLDAPV3CompareRequest;
    FCompareResponse: TIdLDAPV3CompareResponse;
    FControls: TIdLDAPV3ControlList;
    FDelRequest: TIdLDAPV3DelRequest;
    FDelResponse: TIdLDAPV3DelResponse;
    FExtendedReq: TIdLDAPV3ExtendedRequest;
    FExtendedResp: TIdLDAPV3ExtendedResponse;
    FMessageID: TIdLDAPV3MessageID;
    FModDNRequest: TIdLDAPV3ModifyDNRequest;
    FModDNResponse: TIdLDAPV3ModifyDNResponse;
    FModifyRequest: TIdLDAPV3ModifyRequest;
    FModifyResponse: TIdLDAPV3ModifyResponse;
    FSearchRequest: TIdLDAPV3SearchRequest;
    FSearchResDone: TIdLDAPV3SearchResultDone;
    FSearchResEntry: TIdLDAPV3SearchResultEntry;
    FSearchResRef: TIdLDAPV3SearchResultReference;
    FUnbindRequest: TIdLDAPV3UnbindRequest;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure Clear; Overload; Virtual;



    Property messageID : TIdLDAPV3MessageID Read FMessageID Write FMessageID;
    // protocolOp CHOICE
      Property bindRequest : TIdLDAPV3BindRequest Read FBindRequest Write FBindRequest;
      Property bindResponse : TIdLDAPV3BindResponse Read FBindResponse Write FBindResponse;
      Property unbindRequest : TIdLDAPV3UnbindRequest Read FUnbindRequest Write FUnbindRequest;
      Property searchRequest : TIdLDAPV3SearchRequest Read FSearchRequest Write FSearchRequest;
      Property searchResEntry : TIdLDAPV3SearchResultEntry Read FSearchResEntry Write FSearchResEntry;
      Property searchResDone : TIdLDAPV3SearchResultDone Read FSearchResDone Write FSearchResDone;
      Property searchResRef : TIdLDAPV3SearchResultReference Read FSearchResRef Write FSearchResRef;
      Property modifyRequest : TIdLDAPV3ModifyRequest Read FModifyRequest Write FModifyRequest;
      Property modifyResponse : TIdLDAPV3ModifyResponse Read FModifyResponse Write FModifyResponse;
      Property addRequest : TIdLDAPV3AddRequest Read FAddRequest Write FAddRequest;
      Property addResponse : TIdLDAPV3AddResponse Read FAddResponse Write FAddResponse;
      Property delRequest : TIdLDAPV3DelRequest Read FDelRequest Write FDelRequest;
      Property delResponse : TIdLDAPV3DelResponse Read FDelResponse Write FDelResponse;
      Property modDNRequest : TIdLDAPV3ModifyDNRequest Read FModDNRequest Write FModDNRequest;
      Property modDNResponse : TIdLDAPV3ModifyDNResponse Read FModDNResponse Write FModDNResponse;
      Property compareRequest : TIdLDAPV3CompareRequest Read FCompareRequest Write FCompareRequest;
      Property compareResponse : TIdLDAPV3CompareResponse Read FCompareResponse Write FCompareResponse;
      Property abandonRequest : TIdLDAPV3AbandonRequest Read FAbandonRequest Write FAbandonRequest;
      Property extendedReq : TIdLDAPV3ExtendedRequest Read FExtendedReq Write FExtendedReq;
      Property extendedResp : TIdLDAPV3ExtendedResponse Read FExtendedResp Write FExtendedResp;
    Property controls : TIdLDAPV3ControlList Read FControls Write FControls;
  End;

  TIdLDAPV3Message = TIdLDAPV3LDAPMessage;


Implementation


{ TIdLDAPV3Control }

Constructor TIdLDAPV3Control.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3Control.Clear;
Begin
  FCriticality := False;
  FControlValue := '';
  FControlType := '';
End;

Destructor TIdLDAPV3Control.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3ControlList }

Function TIdLDAPV3ControlList.GetControl(iIndex: Integer): TIdLDAPV3Control;
Begin
  Result := TIdLDAPV3Control(items[iIndex]);
End;

{ TIdLDAPV3AttributeValueAssertion }

Constructor TIdLDAPV3AttributeValueAssertion.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3AttributeValueAssertion.Clear;
Begin
  FAssertionValue := '';
  FAttributeDesc := '';
End;

Destructor TIdLDAPV3AttributeValueAssertion.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3Attribute }

Constructor TIdLDAPV3Attribute.Create;
Begin
  Inherited;
  FVals := TIdLDAPV3AttributeValueSet.Create;
End;

Procedure TIdLDAPV3Attribute.Clear;
Begin
  FType := '';
  FVals.Free;
  FVals := Nil;
End;

Destructor TIdLDAPV3Attribute.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3AttributeList }

Function TIdLDAPV3AttributeList.GetAttribute(iIndex: Integer): TIdLDAPV3Attribute;
Begin
  Result := TIdLDAPV3Attribute(items[iIndex]);
End;

{ TIdLDAPV3LDAPResult }

Constructor TIdLDAPV3LDAPResult.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3LDAPResult.Clear;
Begin
  FMatchedDN := '';
  FErrorMessage := '';
  FResultCode := lrcSuccess;
  FReferral.Free;
  FReferral := Nil;
End;

Destructor TIdLDAPV3LDAPResult.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3SaslCredentials }

Constructor TIdLDAPV3SaslCredentials.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3SaslCredentials.Clear;
Begin
  FCredentials := '';
  FMechanism := '';
End;

Destructor TIdLDAPV3SaslCredentials.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3AuthenticationChoice }

Constructor TIdLDAPV3AuthenticationChoice.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3AuthenticationChoice.Clear;
Begin
  FSimple := '';
  FSasl.Free;
  FSasl := Nil;
End;

Destructor TIdLDAPV3AuthenticationChoice.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3BindRequest }

Constructor TIdLDAPV3BindRequest.Create;
Begin
  Inherited;
  FAuthentication := TIdLDAPv3AuthenticationChoice.Create;
End;

Procedure TIdLDAPV3BindRequest.Clear;
Begin
  FVersion := 0;
  FName := '';
  FAuthentication.Free;
  FAuthentication := Nil;
End;

Destructor TIdLDAPV3BindRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3BindResponse }

Constructor TIdLDAPV3BindResponse.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3BindResponse.Clear;
Begin
  Inherited;

  FServerSaslCreds := '';
End;

Destructor TIdLDAPV3BindResponse.Destroy;
Begin
  Inherited;
End;

{ TIdLDAPV3Substring }

Constructor TIdLDAPV3Substring.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3Substring.Clear;
Begin
  FAny := '';
  FFinal := '';
  FInitial := '';
End;

Destructor TIdLDAPV3Substring.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3SubstringList }

Function TIdLDAPV3SubstringList.GetSubstring(iIndex: Integer): TIdLDAPV3Substring;
Begin
  Result := TIdLDAPV3Substring(items[iIndex]);
End;

{ TIdLDAPV3SubstringFilter }

Constructor TIdLDAPV3SubstringFilter.Create;
Begin
  Inherited;
  FSubstrings := TIdLDAPV3SubstringList.Create;
End;

Procedure TIdLDAPV3SubstringFilter.Clear;
Begin
  FType := '';
  FSubstrings.Free;
  FSubstrings := Nil;
End;

Destructor TIdLDAPV3SubstringFilter.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3MatchingRuleAssertion }

Constructor TIdLDAPV3MatchingRuleAssertion.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3MatchingRuleAssertion.Clear;
Begin
  FDnAttributes := False;
  FMatchValue := '';
  FType := '';
  FMatchingRule := '';
End;

Destructor TIdLDAPV3MatchingRuleAssertion.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3Filter }

Constructor TIdLDAPV3Filter.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3Filter.Clear;
Begin
  FPresent := '';
  FEqualityMatch.Free;
  FEqualityMatch := Nil;
  FLessOrEqual.Free;
  FLessOrEqual := Nil;
  FgreaterOrEqual.Free;
  FgreaterOrEqual := Nil;
  FApproxMatch.Free;
  FApproxMatch := Nil;
  FNot.Free;
  FNot := Nil;
  F_Or.Free;
  F_Or := Nil;
  FAnd.Free;
  FAnd := Nil;
  FExtensibleMatch.Free;
  FExtensibleMatch := Nil;
  FSubstrings.Free;
  FSubstrings := Nil;
End;

Destructor TIdLDAPV3Filter.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3FilterList }

Function TIdLDAPV3FilterList.GetFilter(iIndex: Integer): TIdLDAPV3Filter;
Begin
  Result := TIdLDAPV3Filter(items[iIndex]);
End;

{ TIdLDAPV3SearchRequest }

Constructor TIdLDAPV3SearchRequest.Create;
Begin
  Inherited;
  FAttributes := TIdLDAPV3AttributeDescriptionList.Create;
  FFilter := TIdLDAPV3Filter.Create;
End;

Procedure TIdLDAPV3SearchRequest.Clear;
Begin
  FTypesOnly := False;
  FTimeLimit := 0;
  FSizeLimit := 0;
  FBaseObject := '';
  FDerefAliases := sdNeverDerefAliases;
  FScope := ssBaseObject;
  FAttributes.Free;
  FAttributes := Nil;
  FFilter.Free;
  FFilter := Nil;
End;

Destructor TIdLDAPV3SearchRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3PartialAttribute }

Constructor TIdLDAPV3PartialAttribute.Create;
Begin
  Inherited;
  FVals := TIdLDAPV3AttributeValueSet.Create;
End;

Procedure TIdLDAPV3PartialAttribute.Clear;
Begin
  FType := '';
  FVals.Free;
  FVals := Nil;
End;

Destructor TIdLDAPV3PartialAttribute.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3PartialAttributeList }

Function TIdLDAPV3PartialAttributeList.GetPartialAttribute(iIndex: Integer): TIdLDAPV3PartialAttribute;
Begin
  Result := TIdLDAPV3PartialAttribute(items[iIndex]);
End;

{ TIdLDAPV3SearchResultEntry }

Constructor TIdLDAPV3SearchResultEntry.Create;
Begin
  Inherited;
  FAttributes := TIdLDAPV3PartialAttributeList.Create;
End;

Procedure TIdLDAPV3SearchResultEntry.Clear;
Begin
  FObjectName := '';
  FAttributes.Free;
  FAttributes := Nil;
End;

Destructor TIdLDAPV3SearchResultEntry.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3AttributeTypeAndValues }

Constructor TIdLDAPV3AttributeTypeAndValues.Create;
Begin
  Inherited;
  FVals := TIdLDAPV3AttributeValueSet.Create;
End;

Procedure TIdLDAPV3AttributeTypeAndValues.Clear;
Begin
  FType := '';
  FVals.Free;
  FVals := Nil;
End;

Destructor TIdLDAPV3AttributeTypeAndValues.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3Modification }

Constructor TIdLDAPV3Modification.Create;
Begin
  Inherited;
  FModification := TIdLDAPV3AttributeTypeAndValues.Create;
End;

Procedure TIdLDAPV3Modification.Clear;
Begin
  FOperation := moAdd;
  FModification.Free;
  FModification := Nil;
End;

Destructor TIdLDAPV3Modification.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3ModificationList }

Function TIdLDAPV3ModificationList.GetModification(iIndex: Integer): TIdLDAPV3Modification;
Begin
  Result := TIdLDAPV3Modification(items[iIndex]);
End;

{ TIdLDAPV3ModifyRequest }

Constructor TIdLDAPV3ModifyRequest.Create;
Begin
  Inherited;
  FModifications := TIdLDAPV3ModificationList.Create;
End;

Procedure TIdLDAPV3ModifyRequest.Clear;
Begin
  FObject := '';
  FModifications.Free;
  FModifications := Nil;
End;

Destructor TIdLDAPV3ModifyRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3AddRequest }

Constructor TIdLDAPV3AddRequest.Create;
Begin
  Inherited;
  FAttributes := TIdLDAPV3AttributeList.Create;
End;

Procedure TIdLDAPV3AddRequest.Clear;
Begin
  FEntry := '';
  FAttributes.Free;
  FAttributes := Nil;
End;

Destructor TIdLDAPV3AddRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3DelRequest }

Constructor TIdLDAPV3DelRequest.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3DelRequest.Clear;
Begin
  FEntry := '';
End;

Destructor TIdLDAPV3DelRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3ModifyDNRequest }

Constructor TIdLDAPV3ModifyDNRequest.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3ModifyDNRequest.Clear;
Begin
  FDeleteoldrdn := False;
  FNewSuperior := '';
  FEntry := '';
  FNewrdn := '';
End;

Destructor TIdLDAPV3ModifyDNRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3CompareRequest }

Constructor TIdLDAPV3CompareRequest.Create;
Begin
  Inherited;
  FAva := TIdLDAPV3AttributeValueAssertion.Create;
End;

Procedure TIdLDAPV3CompareRequest.Clear;
Begin
  FEntry := '';
  FAva.Free;
  FAva := Nil;
End;

Destructor TIdLDAPV3CompareRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3AbandonRequest }

Constructor TIdLDAPV3AbandonRequest.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3AbandonRequest.Clear;
Begin
  FId := 0;
End;

Destructor TIdLDAPV3AbandonRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3SearchResultReference }

Constructor TIdLDAPV3SearchResultReference.Create;
Begin
  Inherited;
  FRef := TIdLDAPV3Referral.Create;

End;

Procedure TIdLDAPV3SearchResultReference.Clear;
Begin
  FRef.Free;
  FRef := Nil;
End;

Destructor TIdLDAPV3SearchResultReference.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3ExtendedRequest }

Constructor TIdLDAPV3ExtendedRequest.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3ExtendedRequest.Clear;
Begin
  FRequestValue := '';
  FRequestName := '';
End;

Destructor TIdLDAPV3ExtendedRequest.Destroy;
Begin
  Clear;
  Inherited;
End;

{ TIdLDAPV3ExtendedResponse }

Constructor TIdLDAPV3ExtendedResponse.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3ExtendedResponse.Clear;
Begin
  Inherited;

  FResponse := '';
  FResponseName := '';
End;

Destructor TIdLDAPV3ExtendedResponse.Destroy;
Begin
  Inherited;
End;

{ TIdLDAPV3LDAPMessage }

Constructor TIdLDAPV3LDAPMessage.Create;
Begin
  Inherited;
End;

Procedure TIdLDAPV3LDAPMessage.Clear;
Begin
  FMessageID := 0;
  FAbandonRequest.Free;
  FAbandonRequest := Nil;
  FAddRequest.Free;
  FAddRequest := Nil;
  FAddResponse.Free;
  FAddResponse := Nil;
  FBindRequest.Free;
  FBindRequest := Nil;
  FBindResponse.Free;
  FBindResponse := Nil;
  FCompareRequest.Free;
  FCompareRequest := Nil;
  FCompareResponse.Free;
  FCompareResponse := Nil;
  FControls.Free;
  FControls := Nil;
  FDelRequest.Free;
  FDelRequest := Nil;
  FDelResponse.Free;
  FDelResponse := Nil;
  FExtendedReq.Free;
  FExtendedReq := Nil;
  FExtendedResp.Free;
  FExtendedResp := Nil;
  FModDNRequest.Free;
  FModDNRequest := Nil;
  FModDNResponse.Free;
  FModDNResponse := Nil;
  FModifyRequest.Free;
  FModifyRequest := Nil;
  FModifyResponse.Free;
  FModifyResponse := Nil;
  FSearchRequest.Free;
  FSearchRequest := Nil;
  FSearchResDone.Free;
  FSearchResDone := Nil;
  FSearchResEntry.Free;
  FSearchResEntry := Nil;
  FSearchResRef.Free;
  FSearchResRef := Nil;
  FUnbindRequest.Free;
  FUnbindRequest := Nil;
End;

Destructor TIdLDAPV3LDAPMessage.Destroy;
Begin
  Clear;
  Inherited;
End;

End.
