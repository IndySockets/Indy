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
  Rev 1.0    15/04/2005 7:25:04 AM  GGrieve
  first ported to INdy
}

unit IdLDAPV3;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdContainers;

type
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

const
  NAMES_LDAPV3RESULTCODE: Array [TIdLDAPV3ResultCode] of String = (
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

  NAMES_LDAPV3SEARCHSCOPE: Array [TIdLDAPV3SearchScope] of String =
    ('BaseObject', 'SingleLevel', 'WholeSubtree');

  NAMES_LDAPV3SEARCHDEREFALIASES: Array [TIdLDAPV3SearchDerefAliases] of String =
    ('NeverDerefAliases', 'DerefInSearching', 'DerefFindingBaseObj', 'DerefAlways');

  NAMES_LDAPV3MODIFICATIONOPERATION: Array [TIdLDAPV3ModificationOperation] of String =
    ('Add', 'Delete', 'Replace');

type
  // simple types
  TIdLDAPV3MessageID = Integer; // >= 0

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
  private
    FCriticality: Boolean;
    FControlValue: String;
    FControlType: TIdLDAPV3LDAPOID;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property controlType: TIdLDAPV3LDAPOID read FControlType write FControlType;
    property criticality: Boolean read FCriticality write FCriticality; // DEFAULT FALSE
    property controlValue: String read FControlValue write FControlValue; // OPTIONAL
  end;

  TIdLDAPV3ControlList = Class (TIdObjectList)
  private
    function GetControl(iIndex: Integer):TIdLDAPV3Control;
  protected
  public
    property Control[iIndex: Integer]: TIdLDAPV3Control read GetControl; default;
  end;

  TIdLDAPV3AttributeValueAssertion = Class (TObject)
  private
    FAssertionValue: TIdLDAPV3AssertionValue;
    FAttributeDesc: TIdLDAPV3AttributeDescription;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property attributeDesc: TIdLDAPV3AttributeDescription read FAttributeDesc write FAttributeDesc;
    property assertionValue: TIdLDAPV3AssertionValue read FAssertionValue write FAssertionValue;
  end;

  TIdLDAPV3Attribute = Class (TObject)
  private
    FType: TIdLDAPV3AttributeDescription;
    FVals: TIdLDAPV3AttributeValueSet;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property _type: TIdLDAPV3AttributeDescription read FType write FType;
    property vals: TIdLDAPV3AttributeValueSet read FVals write FVals;
  end;

  TIdLDAPV3AttributeList = Class (TIdObjectList)
  private
    function GetAttribute(iIndex: Integer):TIdLDAPV3Attribute;
  protected
  public
    property Attribute[iIndex: Integer]: TIdLDAPV3Attribute read GetAttribute; default;
  end;

  // Message Classes
  TIdLDAPV3LDAPResult = Class (TObject)
  private
    FMatchedDN: TIdLDAPV3LDAPDN;
    FErrorMessage: TIdLDAPV3LDAPString;
    FReferral: TIdLDAPV3Referral;
    FResultCode: TIdLDAPV3ResultCode;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property resultCode: TIdLDAPV3ResultCode read FResultCode write FResultCode;
    property matchedDN: TIdLDAPV3LDAPDN read FMatchedDN write FMatchedDN;
    property errorMessage: TIdLDAPV3LDAPString read FErrorMessage write FErrorMessage;
    property referral: TIdLDAPV3Referral read FReferral write FReferral; // OPTIONAL {3}
  end;

  TIdLDAPV3SaslCredentials = Class (TObject)
  private
    FCredentials: String;
    FMechanism: TIdLDAPV3LDAPString;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property mechanism: TIdLDAPV3LDAPString read FMechanism write FMechanism;
    property credentials: String read FCredentials write FCredentials; // OPTIONAL
  end;

  TIdLDAPV3AuthenticationChoice = Class (TObject)
  private
    FSimple: String;
    FSasl: TIdLDAPV3SaslCredentials;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    // choice
    property simple: String read FSimple write FSimple; {0}
    property sasl: TIdLDAPV3SaslCredentials read FSasl write FSasl; {3}
  end;

  {0}
  TIdLDAPV3BindRequest = Class (TObject)
  private
    FVersion: Byte;
    FAuthentication: TIdLDAPv3AuthenticationChoice;
    FName: TIdLDAPV3LDAPDN;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property version: Byte read FVersion write FVersion;
    property name: TIdLDAPV3LDAPDN read FName write FName;
    property authentication: TIdLDAPv3AuthenticationChoice read FAuthentication write FAuthentication;
  end;

  {1}
  TIdLDAPV3BindResponse = Class (TIdLDAPv3LDAPResult)
  private
    FServerSaslCreds: String;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; override;

    property serverSaslCreds: String read FServerSaslCreds write FServerSaslCreds; // optional {7}
  end;

  {2}
  TIdLDAPV3UnbindRequest = Class (TObject)
  public
  end;

  TIdLDAPV3Substring = Class (TObject)
  private
    FAny: TIdLDAPV3LDAPString;
    FFinal: TIdLDAPV3LDAPString;
    FInitial: TIdLDAPV3LDAPString;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property initial: TIdLDAPV3LDAPString read FInitial write FInitial; {0}
    property any: TIdLDAPV3LDAPString read FAny write FAny; {1}
    property final: TIdLDAPV3LDAPString read FFinal write FFinal; {2}
  end;

  TIdLDAPV3SubstringList = Class (TIdObjectList)
  private
    function GetSubstring(iIndex: Integer):TIdLDAPV3Substring;
  protected
  public
    property Substring[iIndex: Integer]: TIdLDAPV3Substring read GetSubstring; default;
  end;

  TIdLDAPV3SubstringFilter = Class (TObject)
  private
    FType: TIdLDAPV3AttributeDescription;
    FSubstrings: TIdLDAPV3SubstringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property _type: TIdLDAPV3AttributeDescription read FType write FType;
    property substrings: TIdLDAPV3SubstringList read FSubstrings write FSubstrings; // rule: count > 0
  end;

  TIdLDAPV3MatchingRuleAssertion = Class (TObject)
  private
    FDnAttributes: Boolean;
    FMatchValue: TIdLDAPV3AssertionValue;
    FType: TIdLDAPV3AttributeDescription;
    FMatchingRule: TIdLDAPV3MatchingRuleId;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property matchingRule: TIdLDAPV3MatchingRuleId read FMatchingRule write FMatchingRule;// OPTIONAL      {1}
    property _type: TIdLDAPV3AttributeDescription read FType write FType;                 // OPTIONAL      {2}
    property matchValue: TIdLDAPV3AssertionValue read FMatchValue write FMatchValue;      //               {3}
    property dnAttributes: Boolean read FDnAttributes write FDnAttributes;                // DEFAULT FALSE {4}
  end;

  TIdLDAPV3FilterList = Class;

  TIdLDAPV3Filter = Class (TObject)
  private
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
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property _and: TIdLDAPV3FilterList read FAnd write FAnd; {0}
    property _or: TIdLDAPV3FilterList read F_Or write F_or; {1}
    property _not: TIdLDAPV3Filter read FNot write FNot; {2}
    property equalityMatch: TIdLDAPV3AttributeValueAssertion read FEqualityMatch write FEqualityMatch; {3}
    property substrings: TIdLDAPV3SubstringFilter read FSubstrings write FSubstrings; {4}
    property greaterOrEqual: TIdLDAPV3AttributeValueAssertion read FGreaterOrEqual write FGreaterOrEqual; {5}
    property lessOrEqual: TIdLDAPV3AttributeValueAssertion read FLessOrEqual write FLessOrEqual; {6}
    property present: TIdLDAPV3AttributeDescription read FPresent write FPresent; {7}
    property approxMatch: TIdLDAPV3AttributeValueAssertion read FApproxMatch write FApproxMatch; {8}
    property extensibleMatch: TIdLDAPV3MatchingRuleAssertion read FExtensibleMatch write FExtensibleMatch; {9}
  end;

  TIdLDAPV3FilterList = Class (TIdObjectList)
  private
    Function GetFilter(iIndex: Integer):TIdLDAPV3Filter;
  protected
  public
    property Filter[iIndex: Integer]: TIdLDAPV3Filter read GetFilter; default;
  end;

  {3}
  TIdLDAPV3SearchRequest = Class (TObject)
  private
    FTypesOnly: Boolean;
    FTimeLimit: Integer;
    FSizeLimit: Integer;
    FAttributes: TIdLDAPV3AttributeDescriptionList;
    FFilter: TIdLDAPV3Filter;
    FBaseObject: TIdLDAPV3LDAPDN;
    FDerefAliases: TIdLDAPV3SearchDerefAliases;
    FScope: TIdLDAPV3SearchScope;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property baseObject: TIdLDAPV3LDAPDN read FBaseObject write FBaseObject;
    property scope: TIdLDAPV3SearchScope read FScope write FScope;
    property derefAliases: TIdLDAPV3SearchDerefAliases read FDerefAliases write FDerefAliases;
    property sizeLimit: Integer read FSizeLimit write FSizeLimit;
    property timeLimit: Integer read FTimeLimit write FTimeLimit;
    property typesOnly: Boolean read FTypesOnly write FTypesOnly;
    property filter: TIdLDAPV3Filter read FFilter write FFilter;
    property attributes: TIdLDAPV3AttributeDescriptionList read FAttributes write FAttributes;
  end;

  TIdLDAPV3PartialAttribute = Class (TObject)
  private
    FType: TIdLDAPV3AttributeDescription;
    FVals: TIdLDAPV3AttributeValueSet;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property _type: TIdLDAPV3AttributeDescription read FType write FType;
    property vals: TIdLDAPV3AttributeValueSet read FVals write FVals;
  end;

  TIdLDAPV3PartialAttributeList = Class (TIdObjectList)
  private
    function GetPartialAttribute(iIndex: Integer):TIdLDAPV3PartialAttribute;
  protected
  public
    property PartialAttribute[iIndex: Integer]: TIdLDAPV3PartialAttribute read GetPartialAttribute; default;
  end;

  {4}
  TIdLDAPV3SearchResultEntry = Class (TObject)
  private
    FObjectName: TIdLDAPV3LDAPDN;
    FAttributes: TIdLDAPV3PartialAttributeList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property objectName: TIdLDAPV3LDAPDN read FObjectName write FObjectName;
    property attributes: TIdLDAPV3PartialAttributeList read FAttributes write FAttributes;
  end;

  {5}
  TIdLDAPV3SearchResultDone = Class (TIdLDAPV3LDAPResult)
  public
  end;

  TIdLDAPV3AttributeTypeAndValues = Class (TObject)
  private
    FType: TIdLDAPV3AttributeDescription;
    FVals: TIdLDAPV3AttributeValueSet;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property _type: TIdLDAPV3AttributeDescription read FType write FType;
    property vals: TIdLDAPV3AttributeValueSet read FVals write FVals;
  end;

  TIdLDAPV3Modification = Class (TObject)
  private
    FModification: TIdLDAPV3AttributeTypeAndValues;
    FOperation: TIdLDAPV3ModificationOperation;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property operation: TIdLDAPV3ModificationOperation read FOperation write FOperation;
    property modification: TIdLDAPV3AttributeTypeAndValues read FModification write FModification;
  end;

  TIdLDAPV3ModificationList = Class (TIdObjectList)
  private
    function GetModification(iIndex: Integer):TIdLDAPV3Modification;
  protected
  public
    property Modification[iIndex: Integer]: TIdLDAPV3Modification read GetModification; default;
  end;

  {6}
  TIdLDAPV3ModifyRequest = Class (TObject)
  private
    FObject: TIdLDAPV3LDAPDN;
    FModifications: TIdLDAPV3ModificationList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property _object: TIdLDAPV3LDAPDN read FObject write FObject;
    property modifications: TIdLDAPV3ModificationList read FModifications write FModifications;
  end;

  {7}
  TIdLDAPV3ModifyResponse = Class (TIdLDAPV3LDAPResult)
  public
  end;

  {8}
  TIdLDAPV3AddRequest = Class (TObject)
  private
    FAttributes: TIdLDAPV3AttributeList;
    FEntry: TIdLDAPV3LDAPDN;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property entry: TIdLDAPV3LDAPDN read FEntry write FEntry;
    property attributes: TIdLDAPV3AttributeList read FAttributes write FAttributes;
  end;

  {9}
  TIdLDAPV3AddResponse = Class (TIdLDAPV3LDAPResult)
  public
  end;

  {10}
  TIdLDAPV3DelRequest = Class (TObject)
  private
    FEntry: TIdLDAPV3LDAPDN;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property entry: TIdLDAPV3LDAPDN read FEntry write FEntry;
  end;

  {11}
  TIdLDAPV3DelResponse = Class(TIdLDAPV3LDAPResult)
  public
  end;

  {12}
  TIdLDAPV3ModifyDNRequest = Class (TObject)
  private
    FDeleteoldrdn: Boolean;
    FNewSuperior: TIdLDAPV3LDAPDN;
    FEntry: TIdLDAPV3LDAPDN;
    FNewrdn: TIdLDAPV3RelativeLDAPDN;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property entry: TIdLDAPV3LDAPDN read FEntry write FEntry;
    property newrdn: TIdLDAPV3RelativeLDAPDN read FNewrdn write FNewrdn;
    property deleteoldrdn: Boolean read FDeleteoldrdn write FDeleteoldrdn;
    property newSuperior: TIdLDAPV3LDAPDN read FNewSuperior write FNewSuperior; // OPTIONAL {0}
  end;

  {13}
  TIdLDAPV3ModifyDNResponse = Class(TIdLDAPV3LDAPResult)
  public
  end;

  {14}
  TIdLDAPV3CompareRequest = Class (TObject)
  private
    FAva: TIdLDAPV3AttributeValueAssertion;
    FEntry: TIdLDAPV3LDAPDN;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property entry: TIdLDAPV3LDAPDN read FEntry write FEntry;
    property ava: TIdLDAPV3AttributeValueAssertion read FAva write FAva;
  end;

  {15}
  TIdLDAPV3CompareResponse = Class(TIdLDAPV3LDAPResult)
  public
  end;

  {16}
  TIdLDAPV3AbandonRequest = Class (TObject)
  private
    FId: TIdLDAPV3MessageID;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property id: TIdLDAPV3MessageID read FId write FId;
  end;

  {19}
  TIdLDAPV3SearchResultReference = Class (TObject)
  private
    FRef: TIdLDAPV3Referral;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property ref: TIdLDAPV3Referral read FRef write FRef;
  end;

  {23}
  TIdLDAPV3ExtendedRequest = Class (TObject)
  private
    FRequestValue: String;
    FRequestName: TIdLDAPV3LDAPOID;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property requestName: TIdLDAPV3LDAPOID read FRequestName write FRequestName; {0}
    property requestValue: String read FRequestValue write FRequestValue; // OPTIONAL {1}
  end;

  {24}
  TIdLDAPV3ExtendedResponse = Class (TIdLDAPV3LDAPResult)
  private
    FResponse: String;
    FResponseName: TIdLDAPV3LDAPOID;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; override;

    property responseName: TIdLDAPV3LDAPOID read FResponseName write FResponseName; // OPTIONAL {10}
    property response: String read FResponse write FResponse; // OPTIONAL {11}
  end;

  TIdLDAPV3LDAPMessage = Class (TObject)
  private
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
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; overload; virtual;

    property messageID: TIdLDAPV3MessageID read FMessageID write FMessageID;
    // protocolOp CHOICE
    property bindRequest: TIdLDAPV3BindRequest read FBindRequest write FBindRequest;
    property bindResponse: TIdLDAPV3BindResponse read FBindResponse write FBindResponse;
    property unbindRequest: TIdLDAPV3UnbindRequest read FUnbindRequest write FUnbindRequest;
    property searchRequest: TIdLDAPV3SearchRequest read FSearchRequest write FSearchRequest;
    property searchResEntry: TIdLDAPV3SearchResultEntry read FSearchResEntry write FSearchResEntry;
    property searchResDone: TIdLDAPV3SearchResultDone read FSearchResDone write FSearchResDone;
    property searchResRef: TIdLDAPV3SearchResultReference read FSearchResRef write FSearchResRef;
    property modifyRequest: TIdLDAPV3ModifyRequest read FModifyRequest write FModifyRequest;
    property modifyResponse: TIdLDAPV3ModifyResponse read FModifyResponse write FModifyResponse;
    property addRequest: TIdLDAPV3AddRequest read FAddRequest write FAddRequest;
    property addResponse: TIdLDAPV3AddResponse read FAddResponse write FAddResponse;
    property delRequest: TIdLDAPV3DelRequest read FDelRequest write FDelRequest;
    property delResponse: TIdLDAPV3DelResponse read FDelResponse write FDelResponse;
    property modDNRequest: TIdLDAPV3ModifyDNRequest read FModDNRequest write FModDNRequest;
    property modDNResponse: TIdLDAPV3ModifyDNResponse read FModDNResponse write FModDNResponse;
    property compareRequest: TIdLDAPV3CompareRequest read FCompareRequest write FCompareRequest;
    property compareResponse: TIdLDAPV3CompareResponse read FCompareResponse write FCompareResponse;
    property abandonRequest: TIdLDAPV3AbandonRequest read FAbandonRequest write FAbandonRequest;
    property extendedReq: TIdLDAPV3ExtendedRequest read FExtendedReq write FExtendedReq;
    property extendedResp: TIdLDAPV3ExtendedResponse read FExtendedResp write FExtendedResp;
    property controls: TIdLDAPV3ControlList read FControls write FControls;
  end;

  TIdLDAPV3Message = TIdLDAPV3LDAPMessage;

implementation

uses
  SysUtils;

{ TIdLDAPV3Control }

constructor TIdLDAPV3Control.Create;
begin
  inherited;
end;

procedure TIdLDAPV3Control.Clear;
begin
  FCriticality := False;
  FControlValue := '';
  FControlType := '';
end;

destructor TIdLDAPV3Control.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3ControlList }

Function TIdLDAPV3ControlList.GetControl(iIndex: Integer): TIdLDAPV3Control;
begin
  Result := TIdLDAPV3Control(items[iIndex]);
end;

{ TIdLDAPV3AttributeValueAssertion }

constructor TIdLDAPV3AttributeValueAssertion.Create;
begin
  inherited;
end;

procedure TIdLDAPV3AttributeValueAssertion.Clear;
begin
  FAssertionValue := '';
  FAttributeDesc := '';
end;

destructor TIdLDAPV3AttributeValueAssertion.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3Attribute }

constructor TIdLDAPV3Attribute.Create;
begin
  inherited;
  FVals := TIdLDAPV3AttributeValueSet.Create;
end;

procedure TIdLDAPV3Attribute.Clear;
begin
  FType := '';
  FreeAndNil(FVals);
end;

destructor TIdLDAPV3Attribute.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3AttributeList }

Function TIdLDAPV3AttributeList.GetAttribute(iIndex: Integer): TIdLDAPV3Attribute;
begin
  Result := TIdLDAPV3Attribute(items[iIndex]);
end;

{ TIdLDAPV3LDAPResult }

constructor TIdLDAPV3LDAPResult.Create;
begin
  inherited;
end;

procedure TIdLDAPV3LDAPResult.Clear;
begin
  FMatchedDN := '';
  FErrorMessage := '';
  FResultCode := lrcSuccess;
  FreeAndNil(FReferral);
end;

destructor TIdLDAPV3LDAPResult.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3SaslCredentials }

constructor TIdLDAPV3SaslCredentials.Create;
begin
  inherited;
end;

procedure TIdLDAPV3SaslCredentials.Clear;
begin
  FCredentials := '';
  FMechanism := '';
end;

destructor TIdLDAPV3SaslCredentials.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3AuthenticationChoice }

constructor TIdLDAPV3AuthenticationChoice.Create;
begin
  inherited;
end;

procedure TIdLDAPV3AuthenticationChoice.Clear;
begin
  FSimple := '';
  FreeAndNil(FSasl);
end;

destructor TIdLDAPV3AuthenticationChoice.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3BindRequest }

constructor TIdLDAPV3BindRequest.Create;
begin
  inherited;
  FAuthentication := TIdLDAPv3AuthenticationChoice.Create;
end;

procedure TIdLDAPV3BindRequest.Clear;
begin
  FVersion := 0;
  FName := '';
  FreeAndNil(FAuthentication);
end;

destructor TIdLDAPV3BindRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3BindResponse }

constructor TIdLDAPV3BindResponse.Create;
begin
  inherited;
end;

procedure TIdLDAPV3BindResponse.Clear;
begin
  inherited;

  FServerSaslCreds := '';
end;

destructor TIdLDAPV3BindResponse.Destroy;
begin
  inherited;
end;

{ TIdLDAPV3Substring }

constructor TIdLDAPV3Substring.Create;
begin
  inherited;
end;

procedure TIdLDAPV3Substring.Clear;
begin
  FAny := '';
  FFinal := '';
  FInitial := '';
end;

destructor TIdLDAPV3Substring.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3SubstringList }

Function TIdLDAPV3SubstringList.GetSubstring(iIndex: Integer): TIdLDAPV3Substring;
begin
  Result := TIdLDAPV3Substring(items[iIndex]);
end;

{ TIdLDAPV3SubstringFilter }

constructor TIdLDAPV3SubstringFilter.Create;
begin
  inherited;
  FSubstrings := TIdLDAPV3SubstringList.Create;
end;

procedure TIdLDAPV3SubstringFilter.Clear;
begin
  FType := '';
  FreeAndNil(FSubstrings);
end;

destructor TIdLDAPV3SubstringFilter.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3MatchingRuleAssertion }

constructor TIdLDAPV3MatchingRuleAssertion.Create;
begin
  inherited;
end;

procedure TIdLDAPV3MatchingRuleAssertion.Clear;
begin
  FDnAttributes := False;
  FMatchValue := '';
  FType := '';
  FMatchingRule := '';
end;

destructor TIdLDAPV3MatchingRuleAssertion.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3Filter }

constructor TIdLDAPV3Filter.Create;
begin
  inherited;
end;

procedure TIdLDAPV3Filter.Clear;
begin
  FPresent := '';
  FreeAndNil(FEqualityMatch);
  FreeAndNil(FLessOrEqual);
  FreeAndNil(FgreaterOrEqual);
  FreeAndNil(FApproxMatch);
  FreeAndNil(FNot);
  FreeAndNil(F_Or);
  FreeAndNil(FAnd);
  FreeAndNil(FExtensibleMatch);
  FreeAndNil(FSubstrings);
end;

destructor TIdLDAPV3Filter.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3FilterList }

Function TIdLDAPV3FilterList.GetFilter(iIndex: Integer): TIdLDAPV3Filter;
begin
  Result := TIdLDAPV3Filter(items[iIndex]);
end;

{ TIdLDAPV3SearchRequest }

constructor TIdLDAPV3SearchRequest.Create;
begin
  inherited;
  FAttributes := TIdLDAPV3AttributeDescriptionList.Create;
  FFilter := TIdLDAPV3Filter.Create;
end;

procedure TIdLDAPV3SearchRequest.Clear;
begin
  FTypesOnly := False;
  FTimeLimit := 0;
  FSizeLimit := 0;
  FBaseObject := '';
  FDerefAliases := sdNeverDerefAliases;
  FScope := ssBaseObject;
  FreeAndNil(FAttributes);
  FreeAndNil(FFilter);
end;

destructor TIdLDAPV3SearchRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3PartialAttribute }

constructor TIdLDAPV3PartialAttribute.Create;
begin
  inherited;
  FVals := TIdLDAPV3AttributeValueSet.Create;
end;

procedure TIdLDAPV3PartialAttribute.Clear;
begin
  FType := '';
  FreeAndNil(FVals);
end;

destructor TIdLDAPV3PartialAttribute.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3PartialAttributeList }

Function TIdLDAPV3PartialAttributeList.GetPartialAttribute(iIndex: Integer): TIdLDAPV3PartialAttribute;
begin
  Result := TIdLDAPV3PartialAttribute(items[iIndex]);
end;

{ TIdLDAPV3SearchResultEntry }

constructor TIdLDAPV3SearchResultEntry.Create;
begin
  inherited;
  FAttributes := TIdLDAPV3PartialAttributeList.Create;
end;

procedure TIdLDAPV3SearchResultEntry.Clear;
begin
  FObjectName := '';
  FreeAndNil(FAttributes);
end;

destructor TIdLDAPV3SearchResultEntry.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3AttributeTypeAndValues }

constructor TIdLDAPV3AttributeTypeAndValues.Create;
begin
  inherited;
  FVals := TIdLDAPV3AttributeValueSet.Create;
end;

procedure TIdLDAPV3AttributeTypeAndValues.Clear;
begin
  FType := '';
  FreeAndNil(FVals);
end;

destructor TIdLDAPV3AttributeTypeAndValues.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3Modification }

constructor TIdLDAPV3Modification.Create;
begin
  inherited;
  FModification := TIdLDAPV3AttributeTypeAndValues.Create;
end;

procedure TIdLDAPV3Modification.Clear;
begin
  FOperation := moAdd;
  FreeAndNil(FModification);
end;

destructor TIdLDAPV3Modification.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3ModificationList }

Function TIdLDAPV3ModificationList.GetModification(iIndex: Integer): TIdLDAPV3Modification;
begin
  Result := TIdLDAPV3Modification(items[iIndex]);
end;

{ TIdLDAPV3ModifyRequest }

constructor TIdLDAPV3ModifyRequest.Create;
begin
  inherited;
  FModifications := TIdLDAPV3ModificationList.Create;
end;

procedure TIdLDAPV3ModifyRequest.Clear;
begin
  FObject := '';
  FreeAndNil(FModifications);
end;

destructor TIdLDAPV3ModifyRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3AddRequest }

constructor TIdLDAPV3AddRequest.Create;
begin
  inherited;
  FAttributes := TIdLDAPV3AttributeList.Create;
end;

procedure TIdLDAPV3AddRequest.Clear;
begin
  FEntry := '';
  FreeAndNil(FAttributes);
end;

destructor TIdLDAPV3AddRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3DelRequest }

constructor TIdLDAPV3DelRequest.Create;
begin
  inherited;
end;

procedure TIdLDAPV3DelRequest.Clear;
begin
  FEntry := '';
end;

destructor TIdLDAPV3DelRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3ModifyDNRequest }

constructor TIdLDAPV3ModifyDNRequest.Create;
begin
  inherited;
end;

procedure TIdLDAPV3ModifyDNRequest.Clear;
begin
  FDeleteoldrdn := False;
  FNewSuperior := '';
  FEntry := '';
  FNewrdn := '';
end;

destructor TIdLDAPV3ModifyDNRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3CompareRequest }

constructor TIdLDAPV3CompareRequest.Create;
begin
  inherited;
  FAva := TIdLDAPV3AttributeValueAssertion.Create;
end;

procedure TIdLDAPV3CompareRequest.Clear;
begin
  FEntry := '';
  FreeAndNil(FAva);
end;

destructor TIdLDAPV3CompareRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3AbandonRequest }

constructor TIdLDAPV3AbandonRequest.Create;
begin
  inherited;
end;

procedure TIdLDAPV3AbandonRequest.Clear;
begin
  FId := 0;
end;

destructor TIdLDAPV3AbandonRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3SearchResultReference }

constructor TIdLDAPV3SearchResultReference.Create;
begin
  inherited;
  FRef := TIdLDAPV3Referral.Create;
end;

procedure TIdLDAPV3SearchResultReference.Clear;
begin
  FreeAndNil(FRef);
end;

destructor TIdLDAPV3SearchResultReference.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3ExtendedRequest }

constructor TIdLDAPV3ExtendedRequest.Create;
begin
  inherited;
end;

procedure TIdLDAPV3ExtendedRequest.Clear;
begin
  FRequestValue := '';
  FRequestName := '';
end;

destructor TIdLDAPV3ExtendedRequest.Destroy;
begin
  Clear;
  inherited;
end;

{ TIdLDAPV3ExtendedResponse }

constructor TIdLDAPV3ExtendedResponse.Create;
begin
  inherited;
end;

procedure TIdLDAPV3ExtendedResponse.Clear;
begin
  inherited;
  FResponse := '';
  FResponseName := '';
end;

destructor TIdLDAPV3ExtendedResponse.Destroy;
begin
  inherited;
end;

{ TIdLDAPV3LDAPMessage }

constructor TIdLDAPV3LDAPMessage.Create;
begin
  inherited;
end;

procedure TIdLDAPV3LDAPMessage.Clear;
begin
  FMessageID := 0;
  FreeAndNil(FAbandonRequest);
  FreeAndNil(FAddRequest);
  FreeAndNil(FAddResponse);
  FreeAndNil(FBindRequest);
  FreeAndNil(FBindResponse);
  FreeAndNil(FCompareRequest);
  FreeAndNil(FCompareResponse);
  FreeAndNil(FControls);
  FreeAndNil(FDelRequest);
  FreeAndNil(FDelResponse);
  FreeAndNil(FExtendedReq);
  FreeAndNil(FExtendedResp);
  FreeAndNil(FModDNRequest);
  FreeAndNil(FModDNResponse);
  FreeAndNil(FModifyRequest);
  FreeAndNil(FModifyResponse);
  FreeAndNil(FSearchRequest);
  FreeAndNil(FSearchResDone);
  FreeAndNil(FSearchResEntry);
  FreeAndNil(FSearchResRef);
  FreeAndNil(FUnbindRequest);
end;

destructor TIdLDAPV3LDAPMessage.Destroy;
begin
  Clear;
  inherited;
end;

End.
