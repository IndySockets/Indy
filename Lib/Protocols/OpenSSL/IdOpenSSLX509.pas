{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

unit IdOpenSSLX509;

interface

{$i IdCompilerDefines.inc}

uses
  IdOpenSSLPersistent,
  IdOpenSSLHeaders_ossl_typ,
  IdCTypes,
  IdGlobal,
  Classes;

type
  TIdOpenSSLX509Name = class(TIdOpenSSLPersistent)
  private
    FName: PX509_NAME;
    function GetAsString: string;
    function GetCN: string;

    function GetNameEntry(const nid: TIdC_INT): string;
    function GetOU: string;
    function GetC: string;
    function GetO: string;
    function GetST: string;
    function GetL: string;
  public
    constructor Create(const AName: PX509_NAME); reintroduce;
    procedure AssignTo(Dest: TPersistent); override;

    property AsString: string read GetAsString;

    /// <summary>
    ///   OID 2.5.4.3: Common name
    /// </summary>
    property CN: string read GetCN;
    /// <summary>
    ///   OID 2.5.4.10: Organization
    /// </summary>
    property O: string read GetO;
    /// <summary>
    ///   OID 2.5.4.11: Organizational unit
    /// </summary>
    property OU: string read GetOU;
    /// <summary>
    ///   OID 2.5.4.6: Country
    /// </summary>
    property C: string read GetC;
    /// <summary>
    ///   OID 2.5.4.8: State or Province Name
    /// </summary>
    /// <remarks>
    ///   In Windows also known only as "S"
    /// </remarks>
    property ST: string read GetST;
    /// <summary>
    ///   OID 2.5.4.8: State or Province Name
    /// </summary>
    /// <remarks>
    ///   In OpenSSL also known only as "ST"
    /// </remarks>
    property S: string read GetST; //FI:C110
    /// <summary>
    ///   OID 2.5.4.7: Locality
    /// </summary>
    property L: string read GetL;
  end;

  // https://zakird.com/2013/10/13/certificate-parsing-with-openssl
  TIdOpenSSLX509 = class(TIdOpenSSLPersistent)
  private
    FX509: PX509;
    FIssuer: TIdOpenSSLX509Name;
    FSubject: TIdOpenSSLX509Name;
    function GetVersion: TIdC_Long;
    function GetIssuer: TIdOpenSSLX509Name;
    function GetSerialNumber: string;
    function GetSubject: TIdOpenSSLX509Name;
    function GetSignatureAlgorithmAsString: string;
    function GetSignatureAlgorithmAsNID: TIdC_INT;
    function GetThumbprintAsMD5: string;
    function GetThumbprintAsSHA1: string;
    function GetThumbprintAsSHA256: string;
    function GetValidFromInGMT: TDateTime;
//    function GetPublicKey: TIdBytes;

    function GetInternalThumbprint(const md: PEVP_MD): string;
    function ASN1TimeToDateTime(const ATimeASN1: PASN1_TIME): TDateTime;
    function GetValidToInGMT: TDateTime;
  public
    constructor Create(const AX509: PX509); reintroduce; overload;
    constructor Create(const AFile: string); reintroduce; overload;
    destructor Destroy; override;
    procedure AssignTo(Dest: TPersistent); override;

    procedure SaveToFile(const AFile:string);

    /// <returns>
    ///   Returns the numerical value of the version field of the certificate.
    /// </returns>
    /// <remarks>
    ///   Note: this is defined by standards (X.509 et al) to be one less than
    ///   the certificate version. So a version 3 certificate will return 2 and
    ///   a version 1 certificate will return 0.
    /// </remarks>
    property Version: TIdC_Long read GetVersion;
    /// <returns>
    ///   Returns the hexadecimal serial number
    /// </returns>
    property SerialNumber: string read GetSerialNumber;
    /// <remarks>
    ///   Constants for NIDs can be found in IdOpenSSLHeaders_obj_mac.pas,
    ///   for example <see cref="IdOpenSSLHeaders_obj_mac|NID_sha256WithRSAEncryption"/>
    ///   for SHA256RSA.
    /// </remarks>
    property SignatureAlgorithmAsNID: TIdC_INT read GetSignatureAlgorithmAsNID;
    /// <remarks>
    ///   Constants for LNs (long names) can be found in IdOpenSSLHeaders_obj_mac.pas,
    ///   for example <see cref="IdOpenSSLHeaders_obj_mac|LN_sha256WithRSAEncryption"/>
    ///   for SHA256RSA.
    /// </remarks>
    /// <returns>
    ///   Returns a LN (long name) of the signature algorithm
    /// </returns>
    property SignatureAlgorithmAsString: string read GetSignatureAlgorithmAsString;

    property Issuer: TIdOpenSSLX509Name read GetIssuer;

    property ValidFromInGMT: TDateTime read GetValidFromInGMT;
    property ValidToInGMT: TDateTime read GetValidToInGMT;

    property Subject: TIdOpenSSLX509Name read GetSubject;

//    property PublicKey: TIdBytes read GetPublicKey;

    property ThumbprintAsMD5: string read GetThumbprintAsMD5;
    property ThumbprintAsSHA1: string read GetThumbprintAsSHA1;
    property ThumbprintAsSHA256: string read GetThumbprintAsSHA256;

    property X509: PX509 read FX509 write FX509;
  end;

implementation

uses
  IdOpenSSLHeaders_asn1,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_bn,
  IdOpenSSLHeaders_crypto,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_obj_mac,
  IdOpenSSLHeaders_objects,
  IdOpenSSLHeaders_pem,
  IdOpenSSLHeaders_x509,
  IdOpenSSLUtils;

{ TIdOpenSSLX509 }

function TIdOpenSSLX509.ASN1TimeToDateTime(
  const ATimeASN1: PASN1_TIME): TDateTime;
var
  LTime: TIdC_TM;
begin
  Result := 0;
  if ASN1_TIME_to_tm(ATimeASN1, @LTime) = 1 then
    Result := TMToDateTime(LTime);
end;

procedure TIdOpenSSLX509.AssignTo(Dest: TPersistent);
begin
  inherited;
  if Dest is TIdOpenSSLX509 then
    TIdOpenSSLX509(Dest).FX509 := FX509;
end;

constructor TIdOpenSSLX509.Create(const AFile: string);
var
  LBio: PBIO;
begin
  inherited Create();
  LBio := BIO_new_file(GetPAnsiChar(UTF8String(AFile)), 'r');
  if Assigned(LBio) then
    FX509 := PEM_read_bio_X509(LBio, nil, nil, nil);
end;

constructor TIdOpenSSLX509.Create(const AX509: PX509);
begin
  inherited Create();
  X509_up_ref(AX509);
  FX509 := AX509;
end;

destructor TIdOpenSSLX509.Destroy;
begin
  FSubject.Free();
  FIssuer.Free();
  X509_free(FX509);
  inherited;
end;

function TIdOpenSSLX509.GetIssuer: TIdOpenSSLX509Name;
begin
  if not Assigned(FIssuer) then
    FIssuer := TIdOpenSSLX509Name.Create(X509_get_issuer_name(FX509));
  Result := FIssuer;
end;

//function TIdOpenSSLX509.GetPublicKey: TIdBytes;
//var
//  LPubKey: PEVP_PKEY;
//begin
//  LPubKey := X509_get_pubkey(FX509);
//end;

function TIdOpenSSLX509.GetSerialNumber: string;
var
  LAsAsn1Int: PASN1_INTEGER;
  LAsBN: PBIGNUM;
begin
  LAsAsn1Int := X509_get_serialNumber(FX509);
  LAsBN := ASN1_INTEGER_to_BN(LAsAsn1Int, nil);
  Result := GetString(BN_bn2hex(LAsBN));
end;

function TIdOpenSSLX509.GetSignatureAlgorithmAsString: string;
var
  LNID: TIdC_INT;
begin
  LNID := SignatureAlgorithmAsNID;
  Result := GetString(OBJ_nid2ln(LNID));
end;

function TIdOpenSSLX509.GetSignatureAlgorithmAsNID: TIdC_INT;
begin
  Result := X509_get_signature_nid(FX509);
end;

function TIdOpenSSLX509.GetSubject: TIdOpenSSLX509Name;
begin
  if not Assigned(FSubject) then
    FSubject := TIdOpenSSLX509Name.Create(X509_get_subject_name(FX509));
  Result := FSubject;
end;

function TIdOpenSSLX509.GetInternalThumbprint(const md: PEVP_MD): string;
var
  LBuffer: array[0 .. EVP_MAX_MD_SIZE -1] of Byte;
  LByteCount: TIdC_UINT;
  i: Integer;
begin
  Result := '';
  LByteCount := EVP_MAX_MD_SIZE;
  if X509_digest(FX509, md, @LBuffer, @LByteCount) = 1 then
    for i := 0 to LByteCount-1 do
      Result := Result + ByteToHex(LBuffer[i]);
end;

function TIdOpenSSLX509.GetThumbprintAsMD5: string;
begin
  Result := GetInternalThumbprint(EVP_md5());
end;

function TIdOpenSSLX509.GetThumbprintAsSHA1: string;
begin
  Result := GetInternalThumbprint(EVP_sha1());
end;

function TIdOpenSSLX509.GetThumbprintAsSHA256: string;
begin
  Result := GetInternalThumbprint(EVP_sha256());
end;

function TIdOpenSSLX509.GetValidFromInGMT: TDateTime;
begin
  Result := ASN1TimeToDateTime(X509_get0_notBefore(FX509));
end;

function TIdOpenSSLX509.GetValidToInGMT: TDateTime;
begin
  Result := ASN1TimeToDateTime(X509_get0_notAfter(FX509));
end;

function TIdOpenSSLX509.GetVersion: TIdC_Long;
begin
  Result := X509_get_version(FX509);
end;

procedure TIdOpenSSLX509.SaveToFile(const AFile: string);
var
  LBio: PBIO;
begin
  // w: Create an empty file for output operations. If a file with the same name
  //    already exists, its contents are discarded and the file is treated as a
  //    new empty file.
  LBio := BIO_new_file(GetPAnsiChar(UTF8String(AFile)), 'w');
  PEM_write_bio_X509(LBio, FX509);
end;

{ TIdOpenSSLX509Name }

procedure TIdOpenSSLX509Name.AssignTo(Dest: TPersistent);
begin
  inherited;
  if Dest is TIdOpenSSLX509Name then
    TIdOpenSSLX509Name(Dest).FName := FName;
end;

constructor TIdOpenSSLX509Name.Create(const AName: PX509_NAME);
begin
  inherited Create();
  FName := AName;
end;

function TIdOpenSSLX509Name.GetAsString: string;
begin
  Result := GetString(X509_NAME_oneline(FName, nil, 0));
end;

function TIdOpenSSLX509Name.GetC: string;
begin
  Result := GetNameEntry(NID_countryName);
end;

function TIdOpenSSLX509Name.GetCN: string;
begin
  Result := GetNameEntry(NID_commonName);
end;

function TIdOpenSSLX509Name.GetL: string;
begin
  Result := GetNameEntry(NID_localityName);
end;

function TIdOpenSSLX509Name.GetNameEntry(const nid: TIdC_INT): string;

  function TryGetPosition(const name: PX509_NAME; const nid: TIdC_INT; var lastpos: TIdC_INT): Boolean;
  begin
    lastpos := X509_NAME_get_index_by_NID(name, nid, lastpos);
    Result := not (lastpos = -1);
  end;

var
  LPos: TIdC_INT;
  LEntry: PX509_NAME_ENTRY;
  LString: PASN1_STRING;
  LBuffer: PByte;
  LReturn: TIdC_INT;
begin
  Result := '';

  LPos := -1;
  while TryGetPosition(FName, nid, LPos) do
  begin
    LEntry := X509_NAME_get_entry(FName, LPos);
    if not Assigned(LEntry) then
      Exit;
    LString := X509_NAME_ENTRY_get_data(LEntry);

    LReturn := ASN1_STRING_to_UTF8(@LBuffer, LString);
    if LReturn < 0 then
      Exit;
    try
      if not (Result = '') then
        Result := Result + ' ';
      Result := Result + GetString(PIdAnsiChar(LBuffer));
    finally
      OPENSSL_free(LBuffer);
    end;
  end;
end;

function TIdOpenSSLX509Name.GetO: string;
begin
  Result := GetNameEntry(NID_organizationName);
end;

function TIdOpenSSLX509Name.GetOU: string;
begin
  Result := GetNameEntry(NID_organizationalUnitName);
end;

function TIdOpenSSLX509Name.GetST: string;
begin
  Result := GetNameEntry(NID_stateOrProvinceName);
end;

end.
