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
  Rev 1.3    10/16/2003 10:49:18 PM  DSiders
  Added localization comments.

  Rev 1.2    10/8/2003 9:49:02 PM  GGrieve
  merge all TIdCharset to here

  Rev 1.1    10/3/2003 5:39:26 PM  GGrieve
  dotnet work

  Rev 1.0    11/14/2002 02:14:14 PM  JPMugaas
}

unit IdCharsets;

{
  This file is automatically created from
  http://www.iana.org/assignments/character-sets

  All character set constants are prefixed with "idcs", this could lead
  to having a constant named idcscs... because some IANA names are actually
  cs...
  All constants have been renamed to fit Delphi's naming scheme,
  '-', '.', ':' and '+' are converted to '_'
  If a collision occurs, a '_' is appended to the name.
  Care is taken to
    a) put the preferred charset first in a list of identical ones
    b) not append a '_' to the preferred charset

  Two functions can be found here:
  1)
  * function FindPreferredCharset(const Charset: TIdCharSet): TIdCharSet;
  is provided to find the preferred identical charset from an arbitrary
  charset given.

  2)
  * function FindCharset(const s: string): TIdCharset;
  can be used to find a charset from a given string
  (if not found idcs_INVALID is returned)

  For references and people see the end of the file (copied from above location)

  Johannes Berg - 2002-08-22

 -- header of the original file follows --

  ===================================================================
  CHARACTER SETS

  (last updated 2007-05-14)

  These are the official names for character sets that may be used in
  the Internet and may be referred to in Internet documentation.  These
  names are expressed in ANSI_X3.4-1968 which is commonly called
  US-ASCII or simply ASCII.  The character set most commonly use in the
  Internet and used especially in protocol standards is US-ASCII, this
  is strongly encouraged.  The use of the name US-ASCII is also
  encouraged.

  The character set names may be up to 40 characters taken from the
  printable characters of US-ASCII.  However, no distinction is made
  between use of upper and lower case letters.

  The MIBenum value is a unique value for use in MIBs to identify coded
  character sets.

  The value space for MIBenum values has been divided into three
  regions. The first region (3-999) consists of coded character sets
  that have been standardized by some standard setting organization.
  This region is intended for standards that do not have subset
  implementations. The second region (1000-1999) is for the Unicode and
  ISO/IEC 10646 coded character sets together with a specification of a
  (set of) sub-repertoires that may occur.  The third region (>1999) is
  intended for vendor specific coded character sets.

    Assigned MIB enum Numbers
    -------------------------
    0-2		Reserved
    3-999		Set By Standards Organizations
    1000-1999	Unicode / 10646
    2000-2999	Vendor

  The aliases that start with "cs" have been added for use with the
  IANA-CHARSET-MIB as originally defined in RFC3808, and as currently
  maintained by IANA at http://www.iana.org/assignments/ianacharset-mib.
  Note that the ianacharset-mib needs to be kept in sync with this
  registry.  These aliases that start with "cs" contain the standard
  numbers along with suggestive names in order to facilitate applications
  that want to display the names in user interfaces.  The "cs" stands
  for character set and is provided for applications that need a lower
  case first letter but want to use mixed case thereafter that cannot
  contain any special characters, such as underbar ("_") and dash ("-").

  If the character set is from an ISO standard, its cs alias is the ISO
  standard number or name.  If the character set is not from an ISO
  standard, but is registered with ISO (IPSJ/ITSCJ is the current ISO
  Registration Authority), the ISO Registry number is specified as
  ISOnnn followed by letters suggestive of the name or standards number
  of the code set.  When a national or international standard is
  revised, the year of revision is added to the cs alias of the new
  character set entry in the IANA Registry in order to distinguish the
  revised character set from the original character set.
}

interface

{$i IdCompilerDefines.inc}

// once upon a time Indy had 3 different declarations of TIdCharSet
// now all use this one. For reference, one of the more widely used
// enums and the equivalents in the full enum is listed here:
//
//  csGB2312         idcsGB2312 *
//  csBig5           idcsBig5 *
//  csIso2022jp      idcsISO_2022_JP *
//  csEucKR          idcsEUC_KR *
//  csIso88591       idcsISO_8859_1 *
//  csWindows1251    idcswindows_1251 *
//  csKOI8r          idcsKOI8_R *
//  csKOI8u          idcsKOI8_U *
//  csUnicode        idcsUNICODE_1_1
//
//
//  Classic UTF-8 is idcsUTF_8

type
  TIdCharSet = (
    idcs_INVALID, { signifies an invalid character was found when searching for a charset by name }

    { US-ASCII }
    { MIB: 3 }
    idcs_US_ASCII,                                      // Codepage: 20127
    idcs_ANSI_X3_4_1968,
    idcs_iso_ir_6,
    idcs_ANSI_X3_4_1986,
    idcs_ISO_646_irv_1991,
    idcs_ASCII,
    idcs_ISO646_US,
    idcs_us,
    idcs_IBM367,
    idcs_cp367,
    idcs_csASCII,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 27 }
    idcs_ISO_10646_UTF_1,                               // Codepage: ?
    idcs_csISO10646UTF1,
    { Source:
      Universal Transfer Format (1), this is the multibyte
      encoding, that subsets ASCII-7. It does not have byte
      ordering issues. }

    { MIB: 28 }
    idcs_ISO_646_basic_1983,                            // Codepage: ?
    idcs_ref,
    idcs_csISO646basic1983,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 29 }
    idcs_INVARIANT,                                     // Codepage: ?
    idcs_csINVARIANT,
    { References: RFC1345,KXS2 }

    { MIB: 30 }
    idcs_ISO_646_irv_1983,                              // Codepage: ?
    idcs_iso_ir_2,
    idcs_irv,
    idcs_csISO2IntlRefVersion,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 20 }
    idcs_BS_4730,                                       // Codepage: ?
    idcs_iso_ir_4,
    idcs_ISO646_GB,
    idcs_gb,
    idcs_uk,
    idcs_csISO4UnitedKingdom,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 31 }
    idcs_NATS_SEFI,                                     // Codepage: ?
    idcs_iso_ir_8_1,
    idcs_csNATSSEFI,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 32 }
    idcs_NATS_SEFI_ADD,                                 // Codepage: ?
    idcs_iso_ir_8_2,
    idcs_csNATSSEFIADD,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 33 }
    idcs_NATS_DANO,                                     // Codepage: ?
    idcs_iso_ir_9_1,
    idcs_csNATSDANO,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 34 }
    idcs_NATS_DANO_ADD,                                 // Codepage: ?
    idcs_iso_ir_9_2,
    idcs_csNATSDANOADD,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 35 }
    idcs_SEN_850200_B,                                  // Codepage: ?
    idcs_iso_ir_10,
    idcs_FI,
    idcs_ISO646_FI,
    idcs_ISO646_SE,
    idcs_se,
    idcs_csISO10Swedish,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 21 }
    idcs_SEN_850200_C,                                  // Codepage: ?
    idcs_iso_ir_11,
    idcs_ISO646_SE2,
    idcs_se2,
    idcs_csISO11SwedishForNames,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Korean }
    { MIB: 36 }
    idcs_KS_C_5601_1987,                                // Codepage: 949
    idcs_iso_ir_149,
    idcs_KS_C_5601_1989,
    idcs_KSC_5601,
    idcs_korean,
    idcs_csKSC56011987,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Korean (ISO) }
    { MIB: 37 }
    idcs_ISO_2022_KR,                                   // Codepage: 50225
    idcs_csISO2022KR,
    { References: RFC1557,Choi }
    { Source:
      RFC-1557 (see also KS_C_5601-1987) }

    { Korean (EUC) }
    { MIB: 38 }
    idcs_EUC_KR,                                        // Codepage: 51949
    idcs_csEUCKR,
    { References: RFC1557,Choi }
    { Source:
      RFC-1557 (see also KS_C_5861-1992) }

    { Japanese (JIS-Allow 1 byte Kana - SO/SI) }
    { MIB: 39 }
    idcs_ISO_2022_JP,                                   // Codepage: 50220 [need to verify]
    idcs_csISO2022JP,                                   // Codepage: 50221
    { References: RFC1468,Murai }
    { Source:
      RFC-1468 (see also RFC-2237) }

    { MIB: 40 }
    idcs_ISO_2022_JP_2,                                 // Codepage: ?
    idcs_csISO2022JP2,
    { References: RFC1554,Ohta }
    { Source:
      RFC-1554 }

    { MIB: 104 }
    idcs_ISO_2022_CN,                                   // Codepage: ?
    { References: RFC1922 }
    { Source:
      RFC-1922 }

    { MIB: 105 }
    idcs_ISO_2022_CN_EXT,                               // Codepage: ?
    { References: RFC1922 }
    { Source:
      RFC-1922 }

    { MIB: 41 }
    idcs_JIS_C6220_1969_jp,                             // Codepage: ?
    idcs_JIS_C6220_1969,
    idcs_iso_ir_13,
    idcs_katakana,
    idcs_x0201_7,
    idcs_csISO13JISC6220jp,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 42 }
    idcs_JIS_C6220_1969_ro,                             // Codepage: ?
    idcs_iso_ir_14,
    idcs_jp,
    idcs_ISO646_JP,
    idcs_csISO14JISC6220ro,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 22 }
    idcs_IT,                                            // Codepage: ?
    idcs_iso_ir_15,
    idcs_ISO646_IT,
    idcs_csISO15Italian,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 43 }
    idcs_PT,                                            // Codepage: ?
    idcs_iso_ir_16,
    idcs_ISO646_PT,
    idcs_csISO16Portuguese,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 23 }
    idcs_ES,                                            // Codepage: ?
    idcs_iso_ir_17,
    idcs_ISO646_ES,
    idcs_csISO17Spanish,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 44 }
    idcs_greek7_old,                                    // Codepage: ?
    idcs_iso_ir_18,
    idcs_csISO18Greek7Old,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 45 }
    idcs_latin_greek,                                   // Codepage: ?
    idcs_iso_ir_19,
    idcs_csISO19LatinGreek,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 24 }
    idcs_DIN_66003,                                     // Codepage: ?
    idcs_iso_ir_21,
    idcs_de,
    idcs_ISO646_DE,
    idcs_csISO21German,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 46 }
    idcs_NF_Z_62_010_1973,                              // Codepage: ?
    idcs_iso_ir_25,
    idcs_ISO646_FR1,
    idcs_csISO25French,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 47 }
    idcs_Latin_greek_1,                                 // Codepage: ?
    idcs_iso_ir_27,
    idcs_csISO27LatinGreek1,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 48 }
    idcs_ISO_5427,                                      // Codepage: ?
    idcs_iso_ir_37,
    idcs_csISO5427Cyrillic,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 49 }
    idcs_JIS_C6226_1978,                                // Codepage: ?
    idcs_iso_ir_42,
    idcs_csISO42JISC62261978,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 50 }
    idcs_BS_viewdata,                                   // Codepage: ?
    idcs_iso_ir_47,
    idcs_csISO47BSViewdata,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 51 }
    idcs_INIS,                                          // Codepage: ?
    idcs_iso_ir_49,
    idcs_csISO49INIS,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 52 }
    idcs_INIS_8,                                        // Codepage: ?
    idcs_iso_ir_50,
    idcs_csISO50INIS8,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 53 }
    idcs_INIS_cyrillic,                                 // Codepage: ?
    idcs_iso_ir_51,
    idcs_csISO51INISCyrillic,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 54 }
    idcs_ISO_5427_1981,                                 // Codepage: ?
    idcs_iso_ir_54,
    idcs_ISO5427Cyrillic1981,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 55 }
    idcs_ISO_5428_1980,                                 // Codepage: ?
    idcs_iso_ir_55,
    idcs_csISO5428Greek,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 56 }
    idcs_GB_1988_80,                                    // Codepage: ?
    idcs_iso_ir_57,
    idcs_cn,
    idcs_ISO646_CN,
    idcs_csISO57GB1988,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 57 }
    idcs_GB_2312_80,                                    // Codepage: ?
    idcs_iso_ir_58,
    idcs_chinese,
    idcs_csISO58GB231280,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 25 }
    idcs_NS_4551_1,                                     // Codepage: ?
    idcs_iso_ir_60,
    idcs_ISO646_NO,
    idcs_no,
    idcs_csISO60DanishNorwegian,
    idcs_csISO60Norwegian1,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 58 }
    idcs_NS_4551_2,                                     // Codepage: ?
    idcs_ISO646_NO2,
    idcs_iso_ir_61,
    idcs_no2,
    idcs_csISO61Norwegian2,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 26 }
    idcs_NF_Z_62_010,                                   // Codepage: ?
    idcs_iso_ir_69,
    idcs_ISO646_FR,
    idcs_fr,
    idcs_csISO69French,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 59 }
    idcs_videotex_suppl,                                // Codepage: ?
    idcs_iso_ir_70,
    idcs_csISO70VideotexSupp1,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 60 }
    idcs_PT2,                                           // Codepage: ?
    idcs_iso_ir_84,
    idcs_ISO646_PT2,
    idcs_csISO84Portuguese2,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 61 }
    idcs_ES2,                                           // Codepage: ?
    idcs_iso_ir_85,
    idcs_ISO646_ES2,
    idcs_csISO85Spanish2,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 62 }
    idcs_MSZ_7795_3,                                    // Codepage: ?
    idcs_iso_ir_86,
    idcs_ISO646_HU,
    idcs_hu,
    idcs_csISO86Hungarian,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 63 }
    idcs_JIS_C6226_1983,                                // Codepage: ?
    idcs_iso_ir_87,
    idcs_x0208,
    idcs_JIS_X0208_1983,
    idcs_csISO87JISX0208,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 64 }
    idcs_greek7,                                        // Codepage: ?
    idcs_iso_ir_88,
    idcs_csISO88Greek7,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 65 }
    idcs_ASMO_449,                                      // Codepage: ?
    idcs_ISO_9036,
    idcs_arabic7,
    idcs_iso_ir_89,
    idcs_csISO89ASMO449,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 66 }
    idcs_iso_ir_90,                                     // Codepage: ?
    idcs_csISO90,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 67 }
    idcs_JIS_C6229_1984_a,                              // Codepage: ?
    idcs_iso_ir_91,
    idcs_jp_ocr_a,
    idcs_csISO91JISC62291984a,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 68 }
    idcs_JIS_C6229_1984_b,                              // Codepage: ?
    idcs_iso_ir_92,
    idcs_ISO646_JP_OCR_B,
    idcs_jp_ocr_b,
    idcs_csISO92JISC62991984b,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 69 }
    idcs_JIS_C6229_1984_b_add,                          // Codepage: ?
    idcs_iso_ir_93,
    idcs_jp_ocr_b_add,
    idcs_csISO93JIS62291984badd,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 70 }
    idcs_JIS_C6229_1984_hand,                           // Codepage: ?
    idcs_iso_ir_94,
    idcs_jp_ocr_hand,
    idcs_csISO94JIS62291984hand,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 71 }
    idcs_JIS_C6229_1984_hand_add,                       // Codepage: ?
    idcs_iso_ir_95,
    idcs_jp_ocr_hand_add,
    idcs_csISO95JIS62291984handadd,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 72 }
    idcs_JIS_C6229_1984_kana,                           // Codepage: ?
    idcs_iso_ir_96,
    idcs_csISO96JISC62291984kana,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 73 }
    idcs_ISO_2033_1983,                                 // Codepage: ?
    idcs_iso_ir_98,
    idcs_e13b,
    idcs_csISO2033,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 74 }
    idcs_ANSI_X3_110_1983,                              // Codepage: ?
    idcs_iso_ir_99,
    idcs_CSA_T500_1983,
    idcs_NAPLPS,
    idcs_csISO99NAPLPS,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Western European (ISO) }
    { MIB: 4 }
    idcs_ISO_8859_1,                                    // Codepage: 28591
    idcs_ISO_8859_1_1987,
    idcs_iso_ir_100,
    idcs_ISO_8859_1_,
    idcs_latin1,
    idcs_l1,
    idcs_IBM819,
    idcs_CP819,
    idcs_csISOLatin1,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Central European (ISO) }
    { MIB: 5 }
    idcs_ISO_8859_2,                                    // Codepage: 28592
    idcs_ISO_8859_2_1987,
    idcs_iso_ir_101,
    idcs_ISO_8859_2_,
    idcs_latin2,
    idcs_l2,
    idcs_csISOLatin2,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 75 }
    idcs_T_61_7bit,                                     // Codepage: ?
    idcs_iso_ir_102,
    idcs_csISO102T617bit,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 76 }
    idcs_T_61_8bit,                                     // Codepage: ?
    idcs_T_61,
    idcs_iso_ir_103,
    idcs_csISO103T618bit,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Latin 3 (ISO) }
    { MIB: 6 }
    idcs_ISO_8859_3,                                    // Codepage: 28593
    idcs_ISO_8859_3_1988,
    idcs_iso_ir_109,
    idcs_ISO_8859_3_,
    idcs_latin3,
    idcs_l3,
    idcs_csISOLatin3,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Baltic (ISO) }
    { MIB: 7 }
    idcs_ISO_8859_4,                                    // Codepage: 28594
    idcs_ISO_8859_4_1988,
    idcs_iso_ir_110,
    idcs_ISO_8859_4_,
    idcs_latin4,
    idcs_l4,
    idcs_csISOLatin4,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 77 }
    idcs_ECMA_cyrillic,                                 // Codepage: ?
    idcs_iso_ir_111,
    idcs_KOI8_E,
    idcs_csISO111ECMACyrillic,
    { Source:
      ISO registry (formerly ECMA registry)
      http://www.itscj.ipsj.jp/ISO-IR/111.pdf }

    { MIB: 78 }
    idcs_CSA_Z243_4_1985_1,                             // Codepage: ?
    idcs_iso_ir_121,
    idcs_ISO646_CA,
    idcs_csa7_1,
    idcs_ca,
    idcs_csISO121Canadian1,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 79 }
    idcs_CSA_Z243_4_1985_2,                             // Codepage: ?
    idcs_iso_ir_122,
    idcs_ISO646_CA2,
    idcs_csa7_2,
    idcs_csISO122Canadian2,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 80 }
    idcs_CSA_Z243_4_1985_gr,                            // Codepage: ?
    idcs_iso_ir_123,
    idcs_csISO123CSAZ24341985gr,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Arabic (ISO) }
    { MIB: 9 }
    idcs_ISO_8859_6,                                    // Codepage: 28596
    idcs_ISO_8859_6_1987,
    idcs_iso_ir_127,
    idcs_ISO_8859_6_,
    idcs_ECMA_114,
    idcs_ASMO_708,
    idcs_arabic,
    idcs_csISOLatinArabic,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 81 }
    idcs_ISO_8859_6_E,                                  // Codepage: ?
    idcs_ISO_8859_6_E_,
    idcs_csISO88596E,
    { References: RFC1556,IANA }
    { Source:
      RFC1556 }

    { MIB: 82 }
    idcs_ISO_8859_6_I,                                  // Codepage: ?
    idcs_ISO_8859_6_I_,
    idcs_csISO88596I,
    { References: RFC1556,IANA }
    { Source:
      RFC1556 }

    { Greek (ISO) }
    { MIB: 10 }
    idcs_ISO_8859_7,                                    // Codepage: 28597
    idcs_ISO_8859_7_1987,
    idcs_iso_ir_126,
    idcs_ISO_8859_7_,
    idcs_ELOT_928,
    idcs_ECMA_118,
    idcs_greek,
    idcs_greek8,
    idcs_csISOLatinGreek,
    { References: RFC1947,RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 83 }
    idcs_T_101_G2,                                      // Codepage: ?
    idcs_iso_ir_128,
    idcs_csISO128T101G2,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Hebrew (ISO-Visual) }
    { MIB: 11 }
    idcs_ISO_8859_8,                                    // Codepage: 28598
    idcs_ISO_8859_8_1988,
    idcs_iso_ir_138,
    idcs_ISO_8859_8_,
    idcs_hebrew,
    idcs_csISOLatinHebrew,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 84 }
    idcs_ISO_8859_8_E,                                  // Codepage: ?
    idcs_ISO_8859_8_E_,
    idcs_csISO88598E,
    { References: RFC1556,Nussbacher }
    { Source:
      RFC1556 }

    { Hebrew (ISO-Logical) }
    { MIB: 85 }
    idcs_ISO_8859_8_I,                                  // Codepage: 38598
    idcs_ISO_8859_8_I_,
    idcs_csISO88598I,
    { References: RFC1556,Nussbacher }
    { Source:
      RFC1556 }

    { MIB: 86 }
    idcs_CSN_369103,                                    // Codepage: ?
    idcs_iso_ir_139,
    idcs_csISO139CSN369103,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 87 }
    idcs_JUS_I_B1_002,                                  // Codepage: ?
    idcs_iso_ir_141,
    idcs_ISO646_YU,
    idcs_js,
    idcs_yu,
    idcs_csISO141JUSIB1002,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 14 }
    idcs_ISO_6937_2_add,                                // Codepage: ?
    idcs_iso_ir_142,
    idcs_csISOTextComm,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry and ISO 6937-2:1983 }

    { MIB: 88 }
    idcs_IEC_P27_1,                                     // Codepage: ?
    idcs_iso_ir_143,
    idcs_csISO143IECP271,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Cyrillic (ISO) }
    { MIB: 8 }
    idcs_ISO_8859_5,                                    // Codepage: 28595
    idcs_ISO_8859_5_1988,
    idcs_iso_ir_144,
    idcs_ISO_8859_5_,
    idcs_cyrillic,
    idcs_csISOLatinCyrillic,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 89 }
    idcs_JUS_I_B1_003_serb,                             // Codepage: ?
    idcs_iso_ir_146,
    idcs_serbian,
    idcs_csISO146Serbian,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 90 }
    idcs_JUS_I_B1_003_mac,                              // Codepage: ?
    idcs_macedonian,
    idcs_iso_ir_147,
    idcs_csISO147Macedonian,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { Turkish (ISO) }
    { MIB: 12 }
    idcs_ISO_8859_9,                                    // Codepage: 28599
    idcs_ISO_8859_9_1989,
    idcs_iso_ir_148,
    idcs_ISO_8859_9_,
    idcs_latin5,
    idcs_l5,
    idcs_csISOLatin5,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 91 }
    idcs_greek_ccitt,                                   // Codepage: ?
    idcs_iso_ir_150,
    idcs_csISO150,
    idcs_csISO150GreekCCITT,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 92 }
    idcs_NC_NC00_10_81,                                 // Codepage: ?
    idcs_cuba,
    idcs_iso_ir_151,
    idcs_ISO646_CU,
    idcs_csISO151Cuba,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 93 }
    idcs_ISO_6937_2_25,                                 // Codepage: ?
    idcs_iso_ir_152,
    idcs_csISO6937Add,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 94 }
    idcs_GOST_19768_74,                                 // Codepage: ?
    idcs_ST_SEV_358_88,
    idcs_iso_ir_153,
    idcs_csISO153GOST1976874,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 95 }
    idcs_ISO_8859_supp,                                 // Codepage: ?
    idcs_iso_ir_154,
    idcs_latin1_2_5,
    idcs_csISO8859Supp,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 96 }
    idcs_ISO_10367_box,                                 // Codepage: ?
    idcs_iso_ir_155,
    idcs_csISO10367Box,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 13 }
    idcs_ISO_8859_10,                                   // Codepage: ?
    idcs_iso_ir_157,
    idcs_l6,
    idcs_ISO_8859_10_1992,
    idcs_csISOLatin6,
    idcs_latin6,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 97 }
    idcs_latin_lap,                                     // Codepage: ?
    idcs_lap,
    idcs_iso_ir_158,
    idcs_csISO158Lap,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 98 }
    idcs_JIS_X0212_1990,                                // Codepage: ?
    idcs_x0212,
    idcs_iso_ir_159,
    idcs_csISO159JISX02121990,
    { References: RFC1345,KXS2 }
    { Source:
      ECMA registry }

    { MIB: 99 }
    idcs_DS_2089,                                       // Codepage: ?
    idcs_DS2089,
    idcs_ISO646_DK,
    idcs_dk,
    idcs_csISO646Danish,
    { References: RFC1345,KXS2 }
    { Source:
      Danish Standard, DS 2089, February 1974 }

    { MIB: 100 }
    idcs_us_dk,                                         // Codepage: ?
    idcs_csUSDK,
    { References: RFC1345,KXS2 }

    { MIB: 101 }
    idcs_dk_us,                                         // Codepage: ?
    idcs_csDKUS,
    { References: RFC1345,KXS2 }

    { MIB: 15 }
    idcs_JIS_X0201,                                     // Codepage: ?
    idcs_X0201,
    idcs_csHalfWidthKatakana,
    { References: RFC1345,KXS2 }
    { Source:
      JIS X 0201-1976.   One byte only, this is equivalent to
      JIS/Roman (similar to ASCII) plus eight-bit half-width
      Katakana }

    { MIB: 102 }
    idcs_KSC5636,                                       // Codepage: ?
    idcs_ISO646_KR,
    idcs_csKSC5636,
    { References: RFC1345,KXS2 }

    { MIB: 2008 }
    idcs_DEC_MCS,                                       // Codepage: ?
    idcs_dec,
    idcs_csDECMCS,
    { References: RFC1345,KXS2 }
    { Source:
      VAX/VMS User's Manual,
      Order Number: AI-Y517A-TE, April 1986. }

    { MIB: 2004 }
    idcs_hp_roman8,                                     // Codepage: ?
    idcs_roman8,
    idcs_r8,
    idcs_csHPRoman8,
    { References: HP-PCL5,RFC1345,KXS2 }
    { Source:
      LaserJet IIP Printer User's Manual,
      HP part no 33471-90901, Hewlet-Packard, June 1989. }

    { Western European (Mac) }
    { MIB: 2027 }
    idcs_macintosh,                                     // Codepage: 10000
    idcs_mac,
    idcs_csMacintosh,
    { References: RFC1345,KXS2 }
    { Source:
      The Unicode Standard ver1.0, ISBN 0-201-56788-1, Oct 1991 }

    { IBM EBCDIC (US-Canada) }
    { MIB: 2028 }
    idcs_IBM037,                                        // Codepage: 37
    idcs_cp037,
    idcs_ebcdic_cp_us,
    idcs_ebcdic_cp_ca,
    idcs_ebcdic_cp_wt,
    idcs_ebcdic_cp_nl,
    idcs_csIBM037,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2029 }
    idcs_IBM038,                                        // Codepage: ?
    idcs_EBCDIC_INT,
    idcs_cp038,
    idcs_csIBM038,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3174 Character Set Ref, GA27-3831-02, March 1990 }

    { IBM EBCDIC (Germany) }
    { MIB: 2030 }
    idcs_IBM273,                                        // Codepage: 20273
    idcs_CP273,
    idcs_csIBM273,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2031 }
    idcs_IBM274,                                        // Codepage: ?
    idcs_EBCDIC_BE,
    idcs_CP274,
    idcs_csIBM274,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3174 Character Set Ref, GA27-3831-02, March 1990 }

    { MIB: 2032 }
    idcs_IBM275,                                        // Codepage: ?
    idcs_EBCDIC_BR,
    idcs_cp275,
    idcs_csIBM275,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Denmark-Norway) }
    { MIB: 2033 }
    idcs_IBM277,                                        // Codepage: 20277
    idcs_EBCDIC_CP_DK,
    idcs_EBCDIC_CP_NO,
    idcs_csIBM277,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Finland-Sweden) }
    { MIB: 2034 }
    idcs_IBM278,                                        // Codepage: 20278
    idcs_CP278,
    idcs_ebcdic_cp_fi,
    idcs_ebcdic_cp_se,
    idcs_csIBM278,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Italy) }
    { MIB: 2035 }
    idcs_IBM280,                                        // Codepage: 20280
    idcs_CP280,
    idcs_ebcdic_cp_it,
    idcs_csIBM280,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2036 }
    idcs_IBM281,                                        // Codepage: ?
    idcs_EBCDIC_JP_E,
    idcs_cp281,
    idcs_csIBM281,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3174 Character Set Ref, GA27-3831-02, March 1990 }

    { IBM EBCDIC (Spain) }
    { MIB: 2037 }
    idcs_IBM284,                                        // Codepage: 20284
    idcs_CP284,
    idcs_ebcdic_cp_es,
    idcs_csIBM284,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (UK) }
    { MIB: 2038 }
    idcs_IBM285,                                        // Codepage: 20285
    idcs_CP285,
    idcs_ebcdic_cp_gb,
    idcs_csIBM285,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Japanese katakana) }
    { MIB: 2039 }
    idcs_IBM290,                                        // Codepage: 20290
    idcs_cp290,
    idcs_EBCDIC_JP_kana,
    idcs_csIBM290,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3174 Character Set Ref, GA27-3831-02, March 1990 }

    { IBM EBCDIC (France) }
    { MIB: 2040 }
    idcs_IBM297,                                        // Codepage: 20297
    idcs_cp297,
    idcs_ebcdic_cp_fr,
    idcs_csIBM297,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Arabic) }
    { MIB: 2041 }
    idcs_IBM420,                                        // Codepage: 20420
    idcs_cp420,
    idcs_ebcdic_cp_ar1,
    idcs_csIBM420,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990,
      IBM NLS RM p 11-11 }

    { IBM EBCDIC (Greek) }
    { MIB: 2042 }
    idcs_IBM423,                                        // Codepage: 20423
    idcs_cp423,
    idcs_ebcdic_cp_gr,
    idcs_csIBM423,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Hebrew) }
    { MIB: 2043 }
    idcs_IBM424,                                        // Codepage: 20424
    idcs_cp424,
    idcs_ebcdic_cp_he,
    idcs_csIBM424,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { OEM United States }
    { MIB: 2011 }
    idcs_IBM437,                                        // Codepage: 437
    idcs_cp437,
    idcs_437,
    idcs_csPC8CodePage437,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (International) }
    { MIB: 2044 }
    idcs_IBM500,                                        // Codepage: 500
    idcs_CP500,
    idcs_ebcdic_cp_be,
    idcs_ebcdic_cp_ch,
    idcs_csIBM500,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { Baltic (DOS) }
    { MIB: 2087 }
    idcs_IBM775,                                        // Codepage: 775
    idcs_cp775,
    idcs_csPC775Baltic,
    { References: HP-PCL5 }
    { Source:
      HP PCL 5 Comparison Guide (P/N 5021-0329) pp B-13, 1996 }

    { Western European (DOS) }
    { MIB: 2009 }
    idcs_IBM850,                                        // Codepage: 850
    idcs_cp850,
    idcs_850,
    idcs_csPC850Multilingual,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2045 }
    idcs_IBM851,                                        // Codepage: ?
    idcs_cp851,
    idcs_851,
    idcs_csIBM851,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { Central European (DOS) }
    { MIB: 2010 }
    idcs_IBM852,                                        // Codepage: 852
    idcs_cp852,
    idcs_852,
    idcs_csPCp852,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { OEM Cyrillic }
    { MIB: 2046 }
    idcs_IBM855,                                        // Codepage: 855
    idcs_cp855,
    idcs_855,
    idcs_csIBM855,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { Turkish (DOS) }
    { MIB: 2047 }
    idcs_IBM857,                                        // Codepage: 857
    idcs_cp857,
    idcs_857,
    idcs_csIBM857,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { Portuguese (DOS) }
    { MIB: 2048 }
    idcs_IBM860,                                        // Codepage: 860
    idcs_cp860,
    idcs_860,
    idcs_csIBM860,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { Icelandic (DOS) }
    { MIB: 2049 }
    idcs_IBM861,                                        // Codepage: 861
    idcs_cp861,
    idcs_861,
    idcs_cp_is,
    idcs_csIBM861,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2013 }
    idcs_IBM862,                                        // Codepage: ?
    idcs_cp862,
    idcs_862,
    idcs_csPC862LatinHebrew,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { French Canadian (DOS) }
    { MIB: 2050 }
    idcs_IBM863,                                        // Codepage: 863
    idcs_cp863,
    idcs_863,
    idcs_csIBM863,
    { References: RFC1345,KXS2 }
    { Source:
      IBM Keyboard layouts and code pages, PN 07G4586 June 1991 }

    { Arabic (864) }
    { MIB: 2051 }
    idcs_IBM864,                                        // Codepage: 864
    idcs_cp864,
    idcs_csIBM864,
    { References: RFC1345,KXS2 }
    { Source:
      IBM Keyboard layouts and code pages, PN 07G4586 June 1991 }

    { Nordic (DOS) }
    { MIB: 2052 }
    idcs_IBM865,                                        // Codepage: 865
    idcs_cp865,
    idcs_865,
    idcs_csIBM865,
    { References: RFC1345,KXS2 }
    { Source:
      IBM DOS 3.3 Ref (Abridged), 94X9575 (Feb 1987) }

    { Cyrillic (DOS) }
    { MIB: 2086 }
    idcs_IBM866,                                        // Codepage: 866
    idcs_cp866,
    idcs_866,
    idcs_csIBM866,
    { References: Pond }
    { Source:
      IBM NLDG Volume 2 (SE09-8002-03) August 1994 }

    { MIB: 2053 }
    idcs_IBM868,                                        // Codepage: ?
    idcs_CP868,
    idcs_cp_ar,
    idcs_csIBM868,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { Greek, Modern (DOS) }
    { MIB: 2054 }
    idcs_IBM869,                                        // Codepage: 869
    idcs_cp869,
    idcs_869,
    idcs_cp_gr,
    idcs_csIBM869,
    { References: RFC1345,KXS2 }
    { Source:
      IBM Keyboard layouts and code pages, PN 07G4586 June 1991 }

    { IBM EBCDIC (Multilingual Latin-2) }
    { MIB: 2055 }
    idcs_IBM870,                                        // Codepage: 870
    idcs_CP870,
    idcs_ebcdic_cp_roece,
    idcs_ebcdic_cp_yu,
    idcs_csIBM870,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Icelandic) }
    { MIB: 2056 }
    idcs_IBM871,                                        // Codepage: 20871
    idcs_CP871,
    idcs_ebcdic_cp_is,
    idcs_csIBM871,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Cyrillic Russian) }
    { MIB: 2057 }
    idcs_IBM880,                                        // Codepage: 20880
    idcs_cp880,
    idcs_EBCDIC_Cyrillic,
    idcs_csIBM880,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2058 }
    idcs_IBM891,                                        // Codepage: ?
    idcs_cp891,
    idcs_csIBM891,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2059 }
    idcs_IBM903,                                        // Codepage: ?
    idcs_cp903,
    idcs_csIBM903,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2060 }
    idcs_IBM904,                                        // Codepage: ?
    idcs_cp904,
    idcs_904,
    idcs_csIBBM904,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Turkish) }
    { MIB: 2061 }
    idcs_IBM905,                                        // Codepage: 20905
    idcs_CP905,
    idcs_ebcdic_cp_tr,
    idcs_csIBM905,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3174 Character Set Ref, GA27-3831-02, March 1990 }

    { MIB: 2062 }
    idcs_IBM918,                                        // Codepage: ?
    idcs_CP918,
    idcs_ebcdic_cp_ar2,
    idcs_csIBM918,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { IBM EBCDIC (Turkish Latin-5) }
    { MIB: 2063 }
    idcs_IBM1026,                                       // Codepage: 1026
    idcs_CP1026,
    idcs_csIBM1026,
    { References: RFC1345,KXS2 }
    { Source:
      IBM NLS RM Vol2 SE09-8002-01, March 1990 }

    { MIB: 2064 }
    idcs_EBCDIC_AT_DE,                                  // Codepage: ?
    idcs_csIBMEBCDICATDE,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2065 }
    idcs_EBCDIC_AT_DE_A,                                // Codepage: ?
    idcs_csEBCDICATDEA,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2066 }
    idcs_EBCDIC_CA_FR,                                  // Codepage: ?
    idcs_csEBCDICCAFR,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2067 }
    idcs_EBCDIC_DK_NO,                                  // Codepage: ?
    idcs_csEBCDICDKNO,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2068 }
    idcs_EBCDIC_DK_NO_A,                                // Codepage: ?
    idcs_csEBCDICDKNOA,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2069 }
    idcs_EBCDIC_FI_SE,                                  // Codepage: ?
    idcs_csEBCDICFISE,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2070 }
    idcs_EBCDIC_FI_SE_A,                                // Codepage: ?
    idcs_csEBCDICFISEA,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2071 }
    idcs_EBCDIC_FR,                                     // Codepage: ?
    idcs_csEBCDICFR,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2072 }
    idcs_EBCDIC_IT,                                     // Codepage: ?
    idcs_csEBCDICIT,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2073 }
    idcs_EBCDIC_PT,                                     // Codepage: ?
    idcs_csEBCDICPT,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2074 }
    idcs_EBCDIC_ES,                                     // Codepage: ?
    idcs_csEBCDICES,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2075 }
    idcs_EBCDIC_ES_A,                                   // Codepage: ?
    idcs_csEBCDICESA,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2076 }
    idcs_EBCDIC_ES_S,                                   // Codepage: ?
    idcs_csEBCDICESS,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2077 }
    idcs_EBCDIC_UK,                                     // Codepage: ?
    idcs_csEBCDICUK,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2078 }
    idcs_EBCDIC_US,                                     // Codepage: ?
    idcs_csEBCDICUS,
    { References: RFC1345,KXS2 }
    { Source:
      IBM 3270 Char Set Ref Ch 10, GA27-2837-9, April 1987 }

    { MIB: 2079 }
    idcs_UNKNOWN_8BIT,                                  // Codepage: ?
    idcs_csUnknown8BiT,
    { References: RFC1428 }

    { MIB: 2080 }
    idcs_MNEMONIC,                                      // Codepage: ?
    idcs_csMnemonic,
    { References: RFC1345,KXS2 }
    { Source:
      RFC 1345, also known as "mnemonic+ascii+38" }

    { MIB: 2081 }
    idcs_MNEM,                                          // Codepage: ?
    idcs_csMnem,
    { References: RFC1345,KXS2 }
    { Source:
      RFC 1345, also known as "mnemonic+ascii+8200" }

    { MIB: 2082 }
    idcs_VISCII,                                        // Codepage: ?
    idcs_csVISCII,
    { References: RFC1456 }
    { Source:
      RFC 1456 }

    { MIB: 2083 }
    idcs_VIQR,                                          // Codepage: ?
    idcs_csVIQR,
    { References: RFC1456 }
    { Source:
      RFC 1456 }

    { Cyrillic (KOI8-R) }
    { MIB: 2084 }
    idcs_KOI8_R,                                        // Codepage: 20866
    idcs_csKOI8R,
    { References: RFC1489 }
    { Source:
      RFC 1489, based on GOST-19768-74, ISO-6937/8,
      INIS-Cyrillic, ISO-5427. }

    { Cyrillic (KOI8-U) }
    { MIB: 2088 }
    idcs_KOI8_U,                                        // Codepage: 21866
    { References: RFC2319 }
    { Source:
      RFC 2319 }

    { OEM Multilingual Latin I }
    { MIB: 2089 }
    idcs_IBM00858,                                      // Codepage: 858
    idcs_CCSID00858,
    idcs_CP00858,
    idcs_PC_Multilingual_850_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM00858)    [Mahdi] }

    { IBM Latin-1 }
    { MIB: 2090 }
    idcs_IBM00924,                                      // Codepage: 20924
    idcs_CCSID00924,
    idcs_CP00924,
    idcs_ebcdic_Latin9__euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM00924)    [Mahdi] }

    { IBM EBCDIC (US-Canada-Euro) }
    { MIB: 2091 }
    idcs_IBM01140,                                      // Codepage: 1140
    idcs_CCSID01140,
    idcs_CP01140,
    idcs_ebcdic_us_37_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01140)    [Mahdi] }

    { IBM EBCDIC (Germany-Euro) }
    { MIB: 2092 }
    idcs_IBM01141,                                      // Codepage: 1141
    idcs_CCSID01141,
    idcs_CP01141,
    idcs_ebcdic_de_273_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01141)    [Mahdi] }

    { IBM EBCDIC (Denmark-Norway-Euro) }
    { MIB: 2093 }
    idcs_IBM01142,                                      // Codepage: 1142
    idcs_CCSID01142,
    idcs_CP01142,
    idcs_ebcdic_dk_277_euro,
    idcs_ebcdic_no_277_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01142)    [Mahdi] }

    { IBM EBCDIC (Finland-Sweden-Euro) }
    { MIB: 2094 }
    idcs_IBM01143,                                      // Codepage: 1143
    idcs_CCSID01143,
    idcs_CP01143,
    idcs_ebcdic_fi_278_euro,
    idcs_ebcdic_se_278_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01143)    [Mahdi] }

    { IBM EBCDIC (Italy-Euro) }
    { MIB: 2095 }
    idcs_IBM01144,                                      // Codepage: 1144
    idcs_CCSID01144,
    idcs_CP01144,
    idcs_ebcdic_it_280_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01144)    [Mahdi] }

    { IBM EBCDIC (Spain-Euro) }
    { MIB: 2096 }
    idcs_IBM01145,                                      // Codepage: 1145
    idcs_CCSID01145,
    idcs_CP01145,
    idcs_ebcdic_es_284_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01145)    [Mahdi] }

    { IBM EBCDIC (UK-Euro) }
    { MIB: 2097 }
    idcs_IBM01146,                                      // Codepage: 1146
    idcs_CCSID01146,
    idcs_CP01146,
    idcs_ebcdic_gb_285_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01146)    [Mahdi] }

    { IBM EBCDIC (France-Euro) }
    { MIB: 2098 }
    idcs_IBM01147,                                      // Codepage: 1147
    idcs_CCSID01147,
    idcs_CP01147,
    idcs_ebcdic_fr_297_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01147)    [Mahdi] }

    { IBM EBCDIC (International-Euro) }
    { MIB: 2099 }
    idcs_IBM01148,                                      // Codepage: 1148
    idcs_CCSID01148,
    idcs_CP01148,
    idcs_ebcdic_international_500_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01148)    [Mahdi] }

    { IBM EBCDIC (Icelandic-Euro) }
    { MIB: 2100 }
    idcs_IBM01149,                                      // Codepage: 1149
    idcs_CCSID01149,
    idcs_CP01149,
    idcs_ebcdic_is_871_euro,
    { Source:
      IBM See (http://www.iana.org/assignments/charset-reg/IBM01149)    [Mahdi] }

    { MIB: 2101 }
    idcs_Big5_HKSCS,                                    // Codepage: ?
    { References: Yick }
    { Source:
      See (http://www.iana.org/assignments/charset-reg/Big5-HKSCS) }

    { MIB: 1013 }
    idcs_UTF_16BE,                                      // Codepage: 1201
    { References: RFC2781 }
    { Source:
      RFC 2781 }

    { MIB: 1014 }
    idcs_UTF_16LE,                                      // Codepage: 1200
    { References: RFC2781 }
    { Source:
      RFC 2781 }

    { Unicode }
    { MIB: 1015 }
    idcs_UTF_16,                                        // Codepage: 1200
    { References: RFC2781 }
    { Source:
      RFC 2781 }

    { MIB: 1016 }
    idcs_CESU_8,                                        // Codepage: ?
    idcs_csCESU_8,
    { References: Phipps }
    { Source:
      <http://www.unicode.org/unicode/reports/tr26> }

    { Unicode (UTF-32) }
    { MIB: 1017 }
    idcs_UTF_32,                                        // Codepage: 12000
    { References: Davis }
    { Source:
      <http://www.unicode.org/unicode/reports/tr19/> }

    { Unicode (UTF-32 Big endian) }
    { MIB: 1018 }
    idcs_UTF_32BE,                                      // Codepage: 12001
    { References: Davis }
    { Source:
      <http://www.unicode.org/unicode/reports/tr19/> }

    { MIB: 1019 }
    idcs_UTF_32LE,                                      // Codepage: 12000
    { References: Davis }
    { Source:
      <http://www.unicode.org/unicode/reports/tr19/> }

    { MIB: 103 }
    idcs_UNICODE_1_1_UTF_7,                             // Codepage: ?
    idcs_csUnicode11UTF7,
    { References: RFC1642 }
    { Source:
      RFC 1642 }

    { Unicode (UTF-8) }
    { MIB: 106 }
    idcs_UTF_8,                                         // Codepage: 65001
    { References: RFC3629 }
    { Source:
      RFC 3629 }

    { Estonian (ISO) }
    { MIB: 109 }
    idcs_ISO_8859_13,                                   // Codepage: 28603
    { Source:
      ISO See (http://www.iana.org/assignments/charset-reg/ISO-8859-13)[Tumasonis] }

    { MIB: 110 }
    idcs_ISO_8859_14,                                   // Codepage: ?
    idcs_iso_ir_199,
    idcs_ISO_8859_14_1998,
    idcs_ISO_8859_14_,
    idcs_latin8,
    idcs_iso_celtic,
    idcs_l8,
    { Source:
      ISO See (http://www.iana.org/assignments/charset-reg/ISO-8859-14) [Simonsen] }

    { Latin 9 (ISO) }
    { MIB: 111 }
    idcs_ISO_8859_15,                                   // Codepage: 28605
    idcs_ISO_8859_15_,
    idcs_Latin_9,
    { Source:
      ISO
      Please see: <http://www.iana.org/assignments/charset-reg/ISO-8859-15> }

    { MIB: 112 }
    idcs_ISO_8859_16,                                   // Codepage: ?
    idcs_iso_ir_226,
    idcs_ISO_8859_16_2001,
    idcs_ISO_8859_16_,
    idcs_latin10,
    idcs_l10,
    { Source:
      ISO }

    { MIB: 113 }
    idcs_GBK,                                           // Codepage: 936
    idcs_CP936,
    idcs_MS936,
    idcs_windows_936,
    { Source:
      Chinese IT Standardization Technical Committee
      Please see: <http://www.iana.org/assignments/charset-reg/GBK> }

    { Chinese Simplified (GB18030) }
    { MIB: 114 }
    idcs_GB18030,                                       // Codepage: 54936
    { Source:
      Chinese IT Standardization Technical Committee
      Please see: <http://www.iana.org/assignments/charset-reg/GB18030> }

    { MIB: 16 }
    idcs_JIS_Encoding,                                  // Codepage: ?
    idcs_csJISEncoding,
    { Source:
      JIS X 0202-1991.  Uses ISO 2022 escape sequences to
      shift code sets as documented in JIS X 0202-1991. }

    { Japanese (Shift-JIS) }
    { MIB: 17 }
    idcs_Shift_JIS,                                     // Codepage: 932
    idcs_MS_Kanji,
    idcs_csShiftJIS,
    { Source:
      This charset is an extension of csHalfWidthKatakana by
      adding graphic characters in JIS X 0208.  The CCS's are
      JIS X0201:1997 and JIS X0208:1997.  The
      complete definition is shown in Appendix 1 of JIS
      X0208:1997.
      This charset can be used for the top-level media type "text". }

    { Japanese (EUC) }
    { MIB: 18 }
    idcs_EUC_JP,                                        // Codepage: 20932 [need to verify]
    idcs_Extended_UNIX_Code_Packed_Format_for_Japanese,
    idcs_csEUCPkdFmtJapanese,
    { Source:
      Standardized by OSF, UNIX International, and UNIX Systems
      Laboratories Pacific.  Uses ISO 2022 rules to select
      code set 0: US-ASCII (a single 7-bit byte set)
      code set 1: JIS X0208-1990 (a double 8-bit byte set)
      restricted to A0-FF in both bytes
      code set 2: Half Width Katakana (a single 7-bit byte set)
      requiring SS2 as the character prefix
      code set 3: JIS X0212-1990 (a double 7-bit byte set)
      restricted to A0-FF in both bytes
      requiring SS3 as the character prefix }

    { MIB: 19 }
    idcs_Extended_UNIX_Code_Fixed_Width_for_Japanese,   // Codepage: ?
    idcs_csEUCFixWidJapanese,
    { Source:
      Used in Japan.  Each character is 2 octets.
      code set 0: US-ASCII (a single 7-bit byte set)
      1st byte = 00
      2nd byte = 20-7E
      code set 1: JIS X0208-1990 (a double 7-bit byte set)
      restricted  to A0-FF in both bytes
      code set 2: Half Width Katakana (a single 7-bit byte set)
      1st byte = 00
      2nd byte = A0-FF
      code set 3: JIS X0212-1990 (a double 7-bit byte set)
      restricted to A0-FF in
      the first byte
      and 21-7E in the second byte }

    { Hebrew (DOS) }
    { MIB: -1 }
    idcs_DOS_862,                                       // Codepage: 862

    { Thai (Windows) }
    { MIB: -1 }
    idcs_windows_874,                                   // Codepage: 874

    { IBM EBCDIC (Greek Modern) }
    { MIB: -1 }
    idcs_cp875,                                         // Codepage: 875

    { IBM Latin-1 }
    { MIB: -1 }
    idcs_IBM01047,                                      // Codepage: 1047

    { Unicode (Big endian) }
    { MIB: -1 }
    idcs_unicodeFFFE,                                   // Codepage: 1201

    { Korean (Johab) }
    { MIB: -1 }
    idcs_Johab,                                         // Codepage: 1361

    { Japanese (Mac) }
    { MIB: -1 }
    idcs_x_mac_japanese,                                // Codepage: 10001

    { Chinese Traditional (Mac) }
    { MIB: -1 }
    idcs_x_mac_chinesetrad,                             // Codepage: 10002

    { Korean (Mac) }
    { MIB: -1 }
    idcs_x_mac_korean,                                  // Codepage: 10003

    { Arabic (Mac) }
    { MIB: -1 }
    idcs_x_mac_arabic,                                  // Codepage: 10004

    { Hebrew (Mac) }
    { MIB: -1 }
    idcs_x_mac_hebrew,                                  // Codepage: 10005

    { Greek (Mac) }
    { MIB: -1 }
    idcs_x_mac_greek,                                   // Codepage: 10006

    { Cyrillic (Mac) }
    { MIB: -1 }
    idcs_x_mac_cyrillic,                                // Codepage: 10007

    { Chinese Simplified (Mac) }
    { MIB: -1 }
    idcs_x_mac_chinesesimp,                             // Codepage: 10008

    { Romanian (Mac) }
    { MIB: -1 }
    idcs_x_mac_romanian,                                // Codepage: 10010

    { Ukrainian (Mac) }
    { MIB: -1 }
    idcs_x_mac_ukrainian,                               // Codepage: 10017

    { Thai (Mac) }
    { MIB: -1 }
    idcs_x_mac_thai,                                    // Codepage: 10021

    { Central European (Mac) }
    { MIB: -1 }
    idcs_x_mac_ce,                                      // Codepage: 10029

    { Icelandic (Mac) }
    { MIB: -1 }
    idcs_x_mac_icelandic,                               // Codepage: 10079

    { Turkish (Mac) }
    { MIB: -1 }
    idcs_x_mac_turkish,                                 // Codepage: 10081

    { Croatian (Mac) }
    { MIB: -1 }
    idcs_x_mac_croatian,                                // Codepage: 10082

    { Chinese Traditional (CNS) }
    { MIB: -1 }
    idcs_x_Chinese_CNS,                                 // Codepage: 20000

    { TCA Taiwan }
    { MIB: -1 }
    idcs_x_cp20001,                                     // Codepage: 20001

    { Chinese Traditional (Eten) }
    { MIB: -1 }
    idcs_x_Chinese_Eten,                                // Codepage: 20002

    { IBM5550 Taiwan }
    { MIB: -1 }
    idcs_x_cp20003,                                     // Codepage: 20003

    { TeleText Taiwan }
    { MIB: -1 }
    idcs_x_cp20004,                                     // Codepage: 20004

    { Wang Taiwan }
    { MIB: -1 }
    idcs_x_cp20005,                                     // Codepage: 20005

    { Western European (IA5) }
    { MIB: -1 }
    idcs_x_IA5,                                         // Codepage: 20105

    { German (IA5) }
    { MIB: -1 }
    idcs_x_IA5_German,                                  // Codepage: 20106

    { Swedish (IA5) }
    { MIB: -1 }
    idcs_x_IA5_Swedish,                                 // Codepage: 20107

    { Norwegian (IA5) }
    { MIB: -1 }
    idcs_x_IA5_Norwegian,                               // Codepage: 20108

    { T.61 }
    { MIB: -1 }
    idcs_x_cp20261,                                     // Codepage: 20261

    { ISO-6937 }
    { MIB: -1 }
    idcs_x_cp20269,                                     // Codepage: 20269

    { IBM EBCDIC (Korean Extended) }
    { MIB: -1 }
    idcs_x_EBCDIC_KoreanExtended,                       // Codepage: 20833

    { Chinese Simplified (GB2312-80) }
    { MIB: -1 }
    idcs_x_cp20936,                                     // Codepage: 20936

    { Korean Wansung }
    { MIB: -1 }
    idcs_x_cp20949,                                     // Codepage: 20949

    { IBM EBCDIC (Cyrillic Serbian-Bulgarian) }
    { MIB: -1 }
    idcs_cp1025,                                        // Codepage: 21025

    { Europa }
    { MIB: -1 }
    idcs_x_Europa,                                      // Codepage: 29001

    { Chinese Simplified (ISO-2022) }
    { MIB: -1 }
    idcs_x_cp50227,                                     // Codepage: 50227

    { Chinese Simplified (EUC) }
    { MIB: -1 }
    idcs_EUC_CN,                                        // Codepage: 51936

    { ISCII Devanagari }
    { MIB: -1 }
    idcs_x_iscii_de,                                    // Codepage: 57002

    { ISCII Bengali }
    { MIB: -1 }
    idcs_x_iscii_be,                                    // Codepage: 57003

    { ISCII Tamil }
    { MIB: -1 }
    idcs_x_iscii_ta,                                    // Codepage: 57004

    { ISCII Telugu }
    { MIB: -1 }
    idcs_x_iscii_te,                                    // Codepage: 57005

    { ISCII Assamese }
    { MIB: -1 }
    idcs_x_iscii_as,                                    // Codepage: 57006

    { ISCII Oriya }
    { MIB: -1 }
    idcs_x_iscii_or,                                    // Codepage: 57007

    { ISCII Kannada }
    { MIB: -1 }
    idcs_x_iscii_ka,                                    // Codepage: 57008

    { ISCII Malayalam }
    { MIB: -1 }
    idcs_x_iscii_ma,                                    // Codepage: 57009

    { ISCII Gujarati }
    { MIB: -1 }
    idcs_x_iscii_gu,                                    // Codepage: 57010

    { ISCII Punjabi }
    { MIB: -1 }
    idcs_x_iscii_pa,                                    // Codepage: 57011

    { IBM EBCDIC (Arabic) }
    { MIB: -1 }
    idcs_x_EBCDIC_Arabic,                               // Codepage: 20420

    { IBM EBCDIC (Cyrillic Russian) }
    { MIB: -1 }
    idcs_x_EBCDIC_CyrillicRussian,                      // Codepage: 20880

    { IBM EBCDIC (Cyrillic Serbian-Bulgarian) }
    { MIB: -1 }
    idcs_x_EBCDIC_CyrillicSerbianBulgarian,             // Codepage: 21025

    { IBM EBCDIC (Denmark-Norway) }
    { MIB: -1 }
    idcs_x_EBCDIC_DenmarkNorway,                        // Codepage: 20277

    { IBM EBCDIC (Denmark-Norway-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_denmarknorway_euro,                   // Codepage: 1142

    { IBM EBCDIC (Finland-Sweden) }
    { MIB: -1 }
    idcs_x_EBCDIC_FinlandSweden,                        // Codepage: 20278

    { IBM EBCDIC (Finland-Sweden-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_finlandsweden_euro,                   // Codepage: 1143
    idcs_X_EBCDIC_France,

    { IBM EBCDIC (France-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_france_euro,                          // Codepage: 1147

    { IBM EBCDIC (Germany) }
    { MIB: -1 }
    idcs_x_EBCDIC_Germany,                              // Codepage: 20273

    { IBM EBCDIC (Germany-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_germany_euro,                         // Codepage: 1141

    { IBM EBCDIC (Greek Modern) }
    { MIB: -1 }
    idcs_x_EBCDIC_GreekModern,                          // Codepage: 875

    { IBM EBCDIC (Greek) }
    { MIB: -1 }
    idcs_x_EBCDIC_Greek,                                // Codepage: 20423

    { IBM EBCDIC (Hebrew) }
    { MIB: -1 }
    idcs_x_EBCDIC_Hebrew,                               // Codepage: 20424

    { IBM EBCDIC (Icelandic) }
    { MIB: -1 }
    idcs_x_EBCDIC_Icelandic,                            // Codepage: 20871

    { IBM EBCDIC (Icelandic-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_icelandic_euro,                       // Codepage: 1149

    { IBM EBCDIC (International-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_international_euro,                   // Codepage: 1148

    { IBM EBCDIC (Italy) }
    { MIB: -1 }
    idcs_x_EBCDIC_Italy,                                // Codepage: 20280

    { IBM EBCDIC (Italy-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_italy_euro,                           // Codepage: 1144

    { IBM EBCDIC (Japanese and Japanese Katakana) }
    { MIB: -1 }
    idcs_x_EBCDIC_JapaneseAndKana,                      // Codepage: 50930

    { IBM EBCDIC (Japanese and Japanese-Latin) }
    { MIB: -1 }
    idcs_x_EBCDIC_JapaneseAndJapaneseLatin,             // Codepage: 50939

    { IBM EBCDIC (Japanese and US-Canada) }
    { MIB: -1 }
    idcs_x_EBCDIC_JapaneseAndUSCanada,                  // Codepage: 50931

    { IBM EBCDIC (Japanese katakana) }
    { MIB: -1 }
    idcs_x_EBCDIC_JapaneseKatakana,                     // Codepage: 20290

    { IBM EBCDIC (Korean and Korean Extended) }
    { MIB: -1 }
    idcs_x_EBCDIC_KoreanAndKoreanExtended,              // Codepage: 50933

    { IBM EBCDIC (Simplified Chinese) }
    { MIB: -1 }
    idcs_x_EBCDIC_SimplifiedChinese,                    // Codepage: 50935

    { IBM EBCDIC (Spain) }
    { MIB: -1 }
    idcs_X_EBCDIC_Spain,                                // Codepage: 20284

    { IBM EBCDIC (Spain-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_spain_euro,                           // Codepage: 1145

    { IBM EBCDIC (Thai) }
    { MIB: -1 }
    idcs_x_EBCDIC_Thai,                                 // Codepage: 20838

    { IBM EBCDIC (Traditional Chinese) }
    { MIB: -1 }
    idcs_x_EBCDIC_TraditionalChinese,                   // Codepage: 50937

    { IBM EBCDIC (Turkish) }
    { MIB: -1 }
    idcs_x_EBCDIC_Turkish,                              // Codepage: 20905

    { IBM EBCDIC (UK) }
    { MIB: -1 }
    idcs_x_EBCDIC_UK,                                   // Codepage: 20285

    { IBM EBCDIC (UK-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_uk_euro,                              // Codepage: 1146

    { IBM EBCDIC (US-Canada-Euro) }
    { MIB: -1 }
    idcs_x_ebcdic_cp_us_euro,                           // Codepage: 1140

    { MIB: 115 }
    idcs_OSD_EBCDIC_DF04_15,                            // Codepage: ?
    { Source:
      Fujitsu-Siemens standard mainframe EBCDIC encoding
      Please see: <http://www.iana.org/assignments/charset-reg/OSD-EBCDIC-DF04-15> }

    { MIB: 116 }
    idcs_OSD_EBCDIC_DF03_IRV,                           // Codepage: ?
    { Source:
      Fujitsu-Siemens standard mainframe EBCDIC encoding
      Please see: <http://www.iana.org/assignments/charset-reg/OSD-EBCDIC-DF03-IRV> }

    { MIB: 117 }
    idcs_OSD_EBCDIC_DF04_1,                             // Codepage: ?
    { Source:
      Fujitsu-Siemens standard mainframe EBCDIC encoding
      Please see: <http://www.iana.org/assignments/charset-reg/OSD-EBCDIC-DF04-1> }

    { MIB: 118 }
    idcs_ISO_11548_1,                                   // Codepage: ?
    idcs_ISO_11548_1_,
    idcs_ISO_TR_11548_1,
    idcs_csISO115481,
    { Source:
      See <http://www.iana.org/assignments/charset-reg/ISO-11548-1>            [Thibault] }

    { MIB: 119 }
    idcs_KZ_1048,                                       // Codepage: ?
    idcs_STRK1048_2002,
    idcs_RK1048,
    idcs_csKZ1048,
    { Source:
      See <http://www.iana.org/assignments/charset-reg/KZ-1048>      [Veremeev, Kikkarin] }

    { MIB: 1000 }
    idcs_ISO_10646_UCS_2,                               // Codepage: ?
    idcs_csUnicode,
    { Source:
      the 2-octet Basic Multilingual Plane, aka Unicode
      this needs to specify network byte order: the standard
      does not specify (it is a 16-bit integer space) }

    { MIB: 1001 }
    idcs_ISO_10646_UCS_4,                               // Codepage: ?
    idcs_csUCS4,
    { Source:
      the full code space. (same comment about byte order,
      these are 31-bit numbers. }

    { MIB: 1010 }
    idcs_UNICODE_1_1,                                   // Codepage: ?
    idcs_csUnicode11,
    { References: RFC1641 }
    { Source:
      RFC 1641 }

    { MIB: 1011 }
    idcs_SCSU,                                          // Codepage: ?
    { Source:
      SCSU See (http://www.iana.org/assignments/charset-reg/SCSU)     [Scherer] }

    { Unicode (UTF-7) }
    { MIB: 1012 }
    idcs_UTF_7,                                         // Codepage: 65000
    { References: RFC2152 }
    { Source:
      RFC 2152 }

    { MIB: 1002 }
    idcs_ISO_10646_UCS_Basic,                           // Codepage: ?
    idcs_csUnicodeASCII,
    { Source:
      ASCII subset of Unicode.  Basic Latin = collection 1
      See ISO 10646, Appendix A }

    { MIB: 1003 }
    idcs_ISO_10646_Unicode_Latin1,                      // Codepage: ?
    idcs_csUnicodeLatin1,
    idcs_ISO_10646,
    { Source:
      ISO Latin-1 subset of Unicode. Basic Latin and Latin-1
      Supplement  = collections 1 and 2.  See ISO 10646,
      Appendix A.  See RFC 1815. }

    { MIB: -1 }
    idcs_ISO_10646_J_1,                                 // Codepage: ?
    { Source:
      ISO 10646 Japanese, see RFC 1815. }

    { MIB: 1005 }
    idcs_ISO_Unicode_IBM_1261,                          // Codepage: ?
    idcs_csUnicodeIBM1261,
    { Source:
      IBM Latin-2, -3, -5, Extended Presentation Set, GCSGID: 1261 }

    { MIB: 1006 }
    idcs_ISO_Unicode_IBM_1268,                          // Codepage: ?
    idcs_csUnicodeIBM1268,
    { Source:
      IBM Latin-4 Extended Presentation Set, GCSGID: 1268 }

    { MIB: 1007 }
    idcs_ISO_Unicode_IBM_1276,                          // Codepage: ?
    idcs_csUnicodeIBM1276,
    { Source:
      IBM Cyrillic Greek Extended Presentation Set, GCSGID: 1276 }

    { MIB: 1008 }
    idcs_ISO_Unicode_IBM_1264,                          // Codepage: ?
    idcs_csUnicodeIBM1264,
    { Source:
      IBM Arabic Presentation Set, GCSGID: 1264 }

    { MIB: 1009 }
    idcs_ISO_Unicode_IBM_1265,                          // Codepage: ?
    idcs_csUnicodeIBM1265,
    { Source:
      IBM Hebrew Presentation Set, GCSGID: 1265 }

    { MIB: 1020 }
    idcs_BOCU_1,                                        // Codepage: ?
    idcs_csBOCU_1,
    { References: Scherer }
    { Source:
      http://www.unicode.org/notes/tn6/ }

    { MIB: 2000 }
    idcs_ISO_8859_1_Windows_3_0_Latin_1,                // Codepage: ?
    idcs_csWindows30Latin1,
    { References: HP-PCL5 }
    { Source:
      Extended ISO 8859-1 Latin-1 for Windows 3.0.
      PCL Symbol Set id: 9U }

    { MIB: 2001 }
    idcs_ISO_8859_1_Windows_3_1_Latin_1,                // Codepage: ?
    idcs_csWindows31Latin1,
    { References: HP-PCL5 }
    { Source:
      Extended ISO 8859-1 Latin-1 for Windows 3.1.
      PCL Symbol Set id: 19U }

    { MIB: 2002 }
    idcs_ISO_8859_2_Windows_Latin_2,                    // Codepage: ?
    idcs_csWindows31Latin2,
    { References: HP-PCL5 }
    { Source:
      Extended ISO 8859-2.  Latin-2 for Windows 3.1.
      PCL Symbol Set id: 9E }

    { MIB: 2003 }
    idcs_ISO_8859_9_Windows_Latin_5,                    // Codepage: ?
    idcs_csWindows31Latin5,
    { References: HP-PCL5 }
    { Source:
      Extended ISO 8859-9.  Latin-5 for Windows 3.1
      PCL Symbol Set id: 5T }

    { MIB: 2005 }
    idcs_Adobe_Standard_Encoding,                       // Codepage: ?
    idcs_csAdobeStandardEncoding,
    { References: Adobe }
    { Source:
      PostScript Language Reference Manual
      PCL Symbol Set id: 10J }

    { MIB: 2006 }
    idcs_Ventura_US,                                    // Codepage: ?
    idcs_csVenturaUS,
    { References: HP-PCL5 }
    { Source:
      Ventura US.  ASCII plus characters typically used in
      publishing, like pilcrow, copyright, registered, trade mark,
      section, dagger, and double dagger in the range A0 (hex)
      to FF (hex).
      PCL Symbol Set id: 14J }

    { MIB: 2007 }
    idcs_Ventura_International,                         // Codepage: ?
    idcs_csVenturaInternational,
    { References: HP-PCL5 }
    { Source:
      Ventura International.  ASCII plus coded characters similar
      to Roman8.
      PCL Symbol Set id: 13J }

    { MIB: 2012 }
    idcs_PC8_Danish_Norwegian,                          // Codepage: ?
    idcs_csPC8DanishNorwegian,
    { References: HP-PCL5 }
    { Source:
      PC Danish Norwegian
      8-bit PC set for Danish Norwegian
      PCL Symbol Set id: 11U }

    { MIB: 2014 }
    idcs_PC8_Turkish,                                   // Codepage: ?
    idcs_csPC8Turkish,
    { References: HP-PCL5 }
    { Source:
      PC Latin Turkish.  PCL Symbol Set id: 9T }

    { MIB: 2015 }
    idcs_IBM_Symbols,                                   // Codepage: ?
    idcs_csIBMSymbols,
    { References: IBM-CIDT }
    { Source:
      Presentation Set, CPGID: 259 }

    { IBM EBCDIC (Thai) }
    { MIB: 2016 }
    idcs_IBM_Thai,                                      // Codepage: 20838
    idcs_csIBMThai,
    { References: IBM-CIDT }
    { Source:
      Presentation Set, CPGID: 838 }

    { MIB: 2017 }
    idcs_HP_Legal,                                      // Codepage: ?
    idcs_csHPLegal,
    { References: HP-PCL5 }
    { Source:
      PCL 5 Comparison Guide, Hewlett-Packard,
      HP part number 5961-0510, October 1992
      PCL Symbol Set id: 1U }

    { MIB: 2018 }
    idcs_HP_Pi_font,                                    // Codepage: ?
    idcs_csHPPiFont,
    { References: HP-PCL5 }
    { Source:
      PCL 5 Comparison Guide, Hewlett-Packard,
      HP part number 5961-0510, October 1992
      PCL Symbol Set id: 15U }

    { MIB: 2019 }
    idcs_HP_Math8,                                      // Codepage: ?
    idcs_csHPMath8,
    { References: HP-PCL5 }
    { Source:
      PCL 5 Comparison Guide, Hewlett-Packard,
      HP part number 5961-0510, October 1992
      PCL Symbol Set id: 8M }

    { MIB: 2020 }
    idcs_Adobe_Symbol_Encoding,                         // Codepage: ?
    idcs_csHPPSMath,
    { References: Adobe }
    { Source:
      PostScript Language Reference Manual
      PCL Symbol Set id: 5M }

    { MIB: 2021 }
    idcs_HP_DeskTop,                                    // Codepage: ?
    idcs_csHPDesktop,
    { References: HP-PCL5 }
    { Source:
      PCL 5 Comparison Guide, Hewlett-Packard,
      HP part number 5961-0510, October 1992
      PCL Symbol Set id: 7J }

    { MIB: 2022 }
    idcs_Ventura_Math,                                  // Codepage: ?
    idcs_csVenturaMath,
    { References: HP-PCL5 }
    { Source:
      PCL 5 Comparison Guide, Hewlett-Packard,
      HP part number 5961-0510, October 1992
      PCL Symbol Set id: 6M }

    { MIB: 2023 }
    idcs_Microsoft_Publishing,                          // Codepage: ?
    idcs_csMicrosoftPublishing,
    { References: HP-PCL5 }
    { Source:
      PCL 5 Comparison Guide, Hewlett-Packard,
      HP part number 5961-0510, October 1992
      PCL Symbol Set id: 6J }

    { MIB: 2024 }
    idcs_Windows_31J,                                   // Codepage: ?
    idcs_csWindows31J,
    { Source:
      Windows Japanese.  A further extension of Shift_JIS
      to include NEC special characters (Row 13), NEC
      selection of IBM extensions (Rows 89 to 92), and IBM
      extensions (Rows 115 to 119).  The CCS's are
      JIS X0201:1997, JIS X0208:1997, and these extensions.
      This charset can be used for the top-level media type "text",
      but it is of limited or specialized use (see RFC2278).
      PCL Symbol Set id: 19K }

    { Chinese Simplified (GB2312) }
    { MIB: 2025 }
    idcs_GB2312,                                        // Codepage: 936
    idcs_csGB2312,
    { Source:
      Chinese for People's Republic of China (PRC) mixed one byte,
      two byte set:
      20-7E = one byte ASCII
      A1-FE = two byte PRC Kanji
      See GB 2312-80
      PCL Symbol Set Id: 18C }

    { Chinese Traditional (Big5) }
    { MIB: 2026 }
    idcs_Big5,                                          // Codepage: 950
    idcs_csBig5,
    { Source:
      Chinese for Taiwan Multi-byte set.
      PCL Symbol Set Id: 18T }

    { Chinese Simplified (HZ) }
    { MIB: 2085 }
    idcs_HZ_GB_2312,                                    // Codepage: 52936
    { Source:
      RFC 1842, RFC 1843                                       [RFC1842, RFC1843] }

    { MIB: 2102 }
    idcs_IBM1047,                                       // Codepage: ?
    idcs_IBM_1047,
    { References: Robrigado }
    { Source:
      IBM1047 (EBCDIC Latin 1/Open Systems) }

    { MIB: 2103 }
    idcs_PTCP154,                                       // Codepage: ?
    idcs_csPTCP154,
    idcs_PT154,
    idcs_CP154,
    idcs_Cyrillic_Asian,
    { References: Uskov }
    { Source:
      See (http://www.iana.org/assignments/charset-reg/PTCP154) }

    { MIB: 2104 }
    idcs_Amiga_1251,                                    // Codepage: ?
    idcs_Ami1251,
    idcs_Amiga1251,
    idcs_Ami_1251,
    { Source:
      See (http://www.amiga.ultranet.ru/Amiga-1251.html) }

    { MIB: 2105 }
    idcs_KOI7_switched,                                 // Codepage: ?
    { Source:
      See <http://www.iana.org/assignments/charset-reg/KOI7-switched> }

    { MIB: 2106 }
    idcs_BRF,                                           // Codepage: ?
    idcs_csBRF,
    { Source:
      See <http://www.iana.org/assignments/charset-reg/BRF>                    [Thibault] }

    { MIB: 2107 }
    idcs_TSCII,                                         // Codepage: ?
    idcs_csTSCII,
    { Source:
      See <http://www.iana.org/assignments/charset-reg/TSCII>           [Kalyanasundaram] }

    { Central European (Windows) }
    { MIB: 2250 }
    idcs_windows_1250,                                  // Codepage: 1250
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1250) [Lazhintseva] }

    { Cyrillic (Windows) }
    { MIB: 2251 }
    idcs_windows_1251,                                  // Codepage: 1251
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1251) [Lazhintseva] }

    { Western European (Windows) }
    { MIB: 2252 }
    idcs_windows_1252,                                  // Codepage: 1252
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1252)       [Wendt] }

    { Greek (Windows) }
    { MIB: 2253 }
    idcs_windows_1253,                                  // Codepage: 1253
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1253) [Lazhintseva] }

    { Turkish (Windows) }
    { MIB: 2254 }
    idcs_windows_1254,                                  // Codepage: 1254
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1254) [Lazhintseva] }

    { Hebrew (Windows) }
    { MIB: 2255 }
    idcs_windows_1255,                                  // Codepage: 1255
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1255) [Lazhintseva] }

    { Arabic (Windows) }
    { MIB: 2256 }
    idcs_windows_1256,                                  // Codepage: 1256
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1256) [Lazhintseva] }

    { Baltic (Windows) }
    { MIB: 2257 }
    idcs_windows_1257,                                  // Codepage: 1257
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1257) [Lazhintseva] }

    { Vietnamese (Windows) }
    { MIB: 2258 }
    idcs_windows_1258,                                  // Codepage: 1258
    { Source:
      Microsoft  (http://www.iana.org/assignments/charset-reg/windows-1258) [Lazhintseva] }

    { MIB: 2259 }
    idcs_TIS_620,                                       // Codepage: ?
    { Source:
      Thai Industrial Standards Institute (TISI)                             [Tantsetthi] }

    { Arabic (DOS) }
    { MIB: -1 }
    idcs_DOS_720,                                       // Codepage: 720

    { Greek (DOS) }
    { MIB: -1 }
    idcs_ibm737                                         // Codepage: 737

  );

const
  IdCharsetNames : array[Low(TIdCharSet)..High(TIdCharSet)] of string = (
    '', {invalid is empty}
    'US-ASCII',                                      {do not localize}
    'ANSI_X3.4-1968',                                {do not localize}
    'iso-ir-6',                                      {do not localize}
    'ANSI_X3.4-1986',                                {do not localize}
    'ISO_646.irv:1991',                              {do not localize}
    'ASCII',                                         {do not localize}
    'ISO646-US',                                     {do not localize}
    'us',                                            {do not localize}
    'IBM367',                                        {do not localize}
    'cp367',                                         {do not localize}
    'csASCII',                                       {do not localize}
    'ISO-10646-UTF-1',                               {do not localize}
    'csISO10646UTF1',                                {do not localize}
    'ISO_646.basic:1983',                            {do not localize}
    'ref',                                           {do not localize}
    'csISO646basic1983',                             {do not localize}
    'INVARIANT',                                     {do not localize}
    'csINVARIANT',                                   {do not localize}
    'ISO_646.irv:1983',                              {do not localize}
    'iso-ir-2',                                      {do not localize}
    'irv',                                           {do not localize}
    'csISO2IntlRefVersion',                          {do not localize}
    'BS_4730',                                       {do not localize}
    'iso-ir-4',                                      {do not localize}
    'ISO646-GB',                                     {do not localize}
    'gb',                                            {do not localize}
    'uk',                                            {do not localize}
    'csISO4UnitedKingdom',                           {do not localize}
    'NATS-SEFI',                                     {do not localize}
    'iso-ir-8-1',                                    {do not localize}
    'csNATSSEFI',                                    {do not localize}
    'NATS-SEFI-ADD',                                 {do not localize}
    'iso-ir-8-2',                                    {do not localize}
    'csNATSSEFIADD',                                 {do not localize}
    'NATS-DANO',                                     {do not localize}
    'iso-ir-9-1',                                    {do not localize}
    'csNATSDANO',                                    {do not localize}
    'NATS-DANO-ADD',                                 {do not localize}
    'iso-ir-9-2',                                    {do not localize}
    'csNATSDANOADD',                                 {do not localize}
    'SEN_850200_B',                                  {do not localize}
    'iso-ir-10',                                     {do not localize}
    'FI',                                            {do not localize}
    'ISO646-FI',                                     {do not localize}
    'ISO646-SE',                                     {do not localize}
    'se',                                            {do not localize}
    'csISO10Swedish',                                {do not localize}
    'SEN_850200_C',                                  {do not localize}
    'iso-ir-11',                                     {do not localize}
    'ISO646-SE2',                                    {do not localize}
    'se2',                                           {do not localize}
    'csISO11SwedishForNames',                        {do not localize}
    'KS_C_5601-1987',                                {do not localize}
    'iso-ir-149',                                    {do not localize}
    'KS_C_5601-1989',                                {do not localize}
    'KSC_5601',                                      {do not localize}
    'korean',                                        {do not localize}
    'csKSC56011987',                                 {do not localize}
    'ISO-2022-KR',                                   {do not localize}
    'csISO2022KR',                                   {do not localize}
    'EUC-KR',                                        {do not localize}
    'csEUCKR',                                       {do not localize}
    'ISO-2022-JP',                                   {do not localize}
    'csISO2022JP',                                   {do not localize}
    'ISO-2022-JP-2',                                 {do not localize}
    'csISO2022JP2',                                  {do not localize}
    'ISO-2022-CN',                                   {do not localize}
    'ISO-2022-CN-EXT',                               {do not localize}
    'JIS_C6220-1969-jp',                             {do not localize}
    'JIS_C6220-1969',                                {do not localize}
    'iso-ir-13',                                     {do not localize}
    'katakana',                                      {do not localize}
    'x0201-7',                                       {do not localize}
    'csISO13JISC6220jp',                             {do not localize}
    'JIS_C6220-1969-ro',                             {do not localize}
    'iso-ir-14',                                     {do not localize}
    'jp',                                            {do not localize}
    'ISO646-JP',                                     {do not localize}
    'csISO14JISC6220ro',                             {do not localize}
    'IT',                                            {do not localize}
    'iso-ir-15',                                     {do not localize}
    'ISO646-IT',                                     {do not localize}
    'csISO15Italian',                                {do not localize}
    'PT',                                            {do not localize}
    'iso-ir-16',                                     {do not localize}
    'ISO646-PT',                                     {do not localize}
    'csISO16Portuguese',                             {do not localize}
    'ES',                                            {do not localize}
    'iso-ir-17',                                     {do not localize}
    'ISO646-ES',                                     {do not localize}
    'csISO17Spanish',                                {do not localize}
    'greek7-old',                                    {do not localize}
    'iso-ir-18',                                     {do not localize}
    'csISO18Greek7Old',                              {do not localize}
    'latin-greek',                                   {do not localize}
    'iso-ir-19',                                     {do not localize}
    'csISO19LatinGreek',                             {do not localize}
    'DIN_66003',                                     {do not localize}
    'iso-ir-21',                                     {do not localize}
    'de',                                            {do not localize}
    'ISO646-DE',                                     {do not localize}
    'csISO21German',                                 {do not localize}
    'NF_Z_62-010_(1973)',                            {do not localize}
    'iso-ir-25',                                     {do not localize}
    'ISO646-FR1',                                    {do not localize}
    'csISO25French',                                 {do not localize}
    'Latin-greek-1',                                 {do not localize}
    'iso-ir-27',                                     {do not localize}
    'csISO27LatinGreek1',                            {do not localize}
    'ISO_5427',                                      {do not localize}
    'iso-ir-37',                                     {do not localize}
    'csISO5427Cyrillic',                             {do not localize}
    'JIS_C6226-1978',                                {do not localize}
    'iso-ir-42',                                     {do not localize}
    'csISO42JISC62261978',                           {do not localize}
    'BS_viewdata',                                   {do not localize}
    'iso-ir-47',                                     {do not localize}
    'csISO47BSViewdata',                             {do not localize}
    'INIS',                                          {do not localize}
    'iso-ir-49',                                     {do not localize}
    'csISO49INIS',                                   {do not localize}
    'INIS-8',                                        {do not localize}
    'iso-ir-50',                                     {do not localize}
    'csISO50INIS8',                                  {do not localize}
    'INIS-cyrillic',                                 {do not localize}
    'iso-ir-51',                                     {do not localize}
    'csISO51INISCyrillic',                           {do not localize}
    'ISO_5427:1981',                                 {do not localize}
    'iso-ir-54',                                     {do not localize}
    'ISO5427Cyrillic1981',                           {do not localize}
    'ISO_5428:1980',                                 {do not localize}
    'iso-ir-55',                                     {do not localize}
    'csISO5428Greek',                                {do not localize}
    'GB_1988-80',                                    {do not localize}
    'iso-ir-57',                                     {do not localize}
    'cn',                                            {do not localize}
    'ISO646-CN',                                     {do not localize}
    'csISO57GB1988',                                 {do not localize}
    'GB_2312-80',                                    {do not localize}
    'iso-ir-58',                                     {do not localize}
    'chinese',                                       {do not localize}
    'csISO58GB231280',                               {do not localize}
    'NS_4551-1',                                     {do not localize}
    'iso-ir-60',                                     {do not localize}
    'ISO646-NO',                                     {do not localize}
    'no',                                            {do not localize}
    'csISO60DanishNorwegian',                        {do not localize}
    'csISO60Norwegian1',                             {do not localize}
    'NS_4551-2',                                     {do not localize}
    'ISO646-NO2',                                    {do not localize}
    'iso-ir-61',                                     {do not localize}
    'no2',                                           {do not localize}
    'csISO61Norwegian2',                             {do not localize}
    'NF_Z_62-010',                                   {do not localize}
    'iso-ir-69',                                     {do not localize}
    'ISO646-FR',                                     {do not localize}
    'fr',                                            {do not localize}
    'csISO69French',                                 {do not localize}
    'videotex-suppl',                                {do not localize}
    'iso-ir-70',                                     {do not localize}
    'csISO70VideotexSupp1',                          {do not localize}
    'PT2',                                           {do not localize}
    'iso-ir-84',                                     {do not localize}
    'ISO646-PT2',                                    {do not localize}
    'csISO84Portuguese2',                            {do not localize}
    'ES2',                                           {do not localize}
    'iso-ir-85',                                     {do not localize}
    'ISO646-ES2',                                    {do not localize}
    'csISO85Spanish2',                               {do not localize}
    'MSZ_7795.3',                                    {do not localize}
    'iso-ir-86',                                     {do not localize}
    'ISO646-HU',                                     {do not localize}
    'hu',                                            {do not localize}
    'csISO86Hungarian',                              {do not localize}
    'JIS_C6226-1983',                                {do not localize}
    'iso-ir-87',                                     {do not localize}
    'x0208',                                         {do not localize}
    'JIS_X0208-1983',                                {do not localize}
    'csISO87JISX0208',                               {do not localize}
    'greek7',                                        {do not localize}
    'iso-ir-88',                                     {do not localize}
    'csISO88Greek7',                                 {do not localize}
    'ASMO_449',                                      {do not localize}
    'ISO_9036',                                      {do not localize}
    'arabic7',                                       {do not localize}
    'iso-ir-89',                                     {do not localize}
    'csISO89ASMO449',                                {do not localize}
    'iso-ir-90',                                     {do not localize}
    'csISO90',                                       {do not localize}
    'JIS_C6229-1984-a',                              {do not localize}
    'iso-ir-91',                                     {do not localize}
    'jp-ocr-a',                                      {do not localize}
    'csISO91JISC62291984a',                          {do not localize}
    'JIS_C6229-1984-b',                              {do not localize}
    'iso-ir-92',                                     {do not localize}
    'ISO646-JP-OCR-B',                               {do not localize}
    'jp-ocr-b',                                      {do not localize}
    'csISO92JISC62991984b',                          {do not localize}
    'JIS_C6229-1984-b-add',                          {do not localize}
    'iso-ir-93',                                     {do not localize}
    'jp-ocr-b-add',                                  {do not localize}
    'csISO93JIS62291984badd',                        {do not localize}
    'JIS_C6229-1984-hand',                           {do not localize}
    'iso-ir-94',                                     {do not localize}
    'jp-ocr-hand',                                   {do not localize}
    'csISO94JIS62291984hand',                        {do not localize}
    'JIS_C6229-1984-hand-add',                       {do not localize}
    'iso-ir-95',                                     {do not localize}
    'jp-ocr-hand-add',                               {do not localize}
    'csISO95JIS62291984handadd',                     {do not localize}
    'JIS_C6229-1984-kana',                           {do not localize}
    'iso-ir-96',                                     {do not localize}
    'csISO96JISC62291984kana',                       {do not localize}
    'ISO_2033-1983',                                 {do not localize}
    'iso-ir-98',                                     {do not localize}
    'e13b',                                          {do not localize}
    'csISO2033',                                     {do not localize}
    'ANSI_X3.110-1983',                              {do not localize}
    'iso-ir-99',                                     {do not localize}
    'CSA_T500-1983',                                 {do not localize}
    'NAPLPS',                                        {do not localize}
    'csISO99NAPLPS',                                 {do not localize}
    'ISO-8859-1',                                    {do not localize}
    'ISO_8859-1:1987',                               {do not localize}
    'iso-ir-100',                                    {do not localize}
    'ISO_8859-1',                                    {do not localize}
    'latin1',                                        {do not localize}
    'l1',                                            {do not localize}
    'IBM819',                                        {do not localize}
    'CP819',                                         {do not localize}
    'csISOLatin1',                                   {do not localize}
    'ISO-8859-2',                                    {do not localize}
    'ISO_8859-2:1987',                               {do not localize}
    'iso-ir-101',                                    {do not localize}
    'ISO_8859-2',                                    {do not localize}
    'latin2',                                        {do not localize}
    'l2',                                            {do not localize}
    'csISOLatin2',                                   {do not localize}
    'T.61-7bit',                                     {do not localize}
    'iso-ir-102',                                    {do not localize}
    'csISO102T617bit',                               {do not localize}
    'T.61-8bit',                                     {do not localize}
    'T.61',                                          {do not localize}
    'iso-ir-103',                                    {do not localize}
    'csISO103T618bit',                               {do not localize}
    'ISO-8859-3',                                    {do not localize}
    'ISO_8859-3:1988',                               {do not localize}
    'iso-ir-109',                                    {do not localize}
    'ISO_8859-3',                                    {do not localize}
    'latin3',                                        {do not localize}
    'l3',                                            {do not localize}
    'csISOLatin3',                                   {do not localize}
    'ISO-8859-4',                                    {do not localize}
    'ISO_8859-4:1988',                               {do not localize}
    'iso-ir-110',                                    {do not localize}
    'ISO_8859-4',                                    {do not localize}
    'latin4',                                        {do not localize}
    'l4',                                            {do not localize}
    'csISOLatin4',                                   {do not localize}
    'ECMA-cyrillic',                                 {do not localize}
    'iso-ir-111',                                    {do not localize}
    'KOI8-E',                                        {do not localize}
    'csISO111ECMACyrillic',                          {do not localize}
    'CSA_Z243.4-1985-1',                             {do not localize}
    'iso-ir-121',                                    {do not localize}
    'ISO646-CA',                                     {do not localize}
    'csa7-1',                                        {do not localize}
    'ca',                                            {do not localize}
    'csISO121Canadian1',                             {do not localize}
    'CSA_Z243.4-1985-2',                             {do not localize}
    'iso-ir-122',                                    {do not localize}
    'ISO646-CA2',                                    {do not localize}
    'csa7-2',                                        {do not localize}
    'csISO122Canadian2',                             {do not localize}
    'CSA_Z243.4-1985-gr',                            {do not localize}
    'iso-ir-123',                                    {do not localize}
    'csISO123CSAZ24341985gr',                        {do not localize}
    'ISO-8859-6',                                    {do not localize}
    'ISO_8859-6:1987',                               {do not localize}
    'iso-ir-127',                                    {do not localize}
    'ISO_8859-6',                                    {do not localize}
    'ECMA-114',                                      {do not localize}
    'ASMO-708',                                      {do not localize}
    'arabic',                                        {do not localize}
    'csISOLatinArabic',                              {do not localize}
    'ISO-8859-6-E',                                  {do not localize}
    'ISO_8859-6-E',                                  {do not localize}
    'csISO88596E',                                   {do not localize}
    'ISO-8859-6-I',                                  {do not localize}
    'ISO_8859-6-I',                                  {do not localize}
    'csISO88596I',                                   {do not localize}
    'ISO-8859-7',                                    {do not localize}
    'ISO_8859-7:1987',                               {do not localize}
    'iso-ir-126',                                    {do not localize}
    'ISO_8859-7',                                    {do not localize}
    'ELOT_928',                                      {do not localize}
    'ECMA-118',                                      {do not localize}
    'greek',                                         {do not localize}
    'greek8',                                        {do not localize}
    'csISOLatinGreek',                               {do not localize}
    'T.101-G2',                                      {do not localize}
    'iso-ir-128',                                    {do not localize}
    'csISO128T101G2',                                {do not localize}
    'ISO-8859-8',                                    {do not localize}
    'ISO_8859-8:1988',                               {do not localize}
    'iso-ir-138',                                    {do not localize}
    'ISO_8859-8',                                    {do not localize}
    'hebrew',                                        {do not localize}
    'csISOLatinHebrew',                              {do not localize}
    'ISO-8859-8-E',                                  {do not localize}
    'ISO_8859-8-E',                                  {do not localize}
    'csISO88598E',                                   {do not localize}
    'ISO-8859-8-I',                                  {do not localize}
    'ISO_8859-8-I',                                  {do not localize}
    'csISO88598I',                                   {do not localize}
    'CSN_369103',                                    {do not localize}
    'iso-ir-139',                                    {do not localize}
    'csISO139CSN369103',                             {do not localize}
    'JUS_I.B1.002',                                  {do not localize}
    'iso-ir-141',                                    {do not localize}
    'ISO646-YU',                                     {do not localize}
    'js',                                            {do not localize}
    'yu',                                            {do not localize}
    'csISO141JUSIB1002',                             {do not localize}
    'ISO_6937-2-add',                                {do not localize}
    'iso-ir-142',                                    {do not localize}
    'csISOTextComm',                                 {do not localize}
    'IEC_P27-1',                                     {do not localize}
    'iso-ir-143',                                    {do not localize}
    'csISO143IECP271',                               {do not localize}
    'ISO-8859-5',                                    {do not localize}
    'ISO_8859-5:1988',                               {do not localize}
    'iso-ir-144',                                    {do not localize}
    'ISO_8859-5',                                    {do not localize}
    'cyrillic',                                      {do not localize}
    'csISOLatinCyrillic',                            {do not localize}
    'JUS_I.B1.003-serb',                             {do not localize}
    'iso-ir-146',                                    {do not localize}
    'serbian',                                       {do not localize}
    'csISO146Serbian',                               {do not localize}
    'JUS_I.B1.003-mac',                              {do not localize}
    'macedonian',                                    {do not localize}
    'iso-ir-147',                                    {do not localize}
    'csISO147Macedonian',                            {do not localize}
    'ISO-8859-9',                                    {do not localize}
    'ISO_8859-9:1989',                               {do not localize}
    'iso-ir-148',                                    {do not localize}
    'ISO_8859-9',                                    {do not localize}
    'latin5',                                        {do not localize}
    'l5',                                            {do not localize}
    'csISOLatin5',                                   {do not localize}
    'greek-ccitt',                                   {do not localize}
    'iso-ir-150',                                    {do not localize}
    'csISO150',                                      {do not localize}
    'csISO150GreekCCITT',                            {do not localize}
    'NC_NC00-10:81',                                 {do not localize}
    'cuba',                                          {do not localize}
    'iso-ir-151',                                    {do not localize}
    'ISO646-CU',                                     {do not localize}
    'csISO151Cuba',                                  {do not localize}
    'ISO_6937-2-25',                                 {do not localize}
    'iso-ir-152',                                    {do not localize}
    'csISO6937Add',                                  {do not localize}
    'GOST_19768-74',                                 {do not localize}
    'ST_SEV_358-88',                                 {do not localize}
    'iso-ir-153',                                    {do not localize}
    'csISO153GOST1976874',                           {do not localize}
    'ISO_8859-supp',                                 {do not localize}
    'iso-ir-154',                                    {do not localize}
    'latin1-2-5',                                    {do not localize}
    'csISO8859Supp',                                 {do not localize}
    'ISO_10367-box',                                 {do not localize}
    'iso-ir-155',                                    {do not localize}
    'csISO10367Box',                                 {do not localize}
    'ISO-8859-10',                                   {do not localize}
    'iso-ir-157',                                    {do not localize}
    'l6',                                            {do not localize}
    'ISO_8859-10:1992',                              {do not localize}
    'csISOLatin6',                                   {do not localize}
    'latin6',                                        {do not localize}
    'latin-lap',                                     {do not localize}
    'lap',                                           {do not localize}
    'iso-ir-158',                                    {do not localize}
    'csISO158Lap',                                   {do not localize}
    'JIS_X0212-1990',                                {do not localize}
    'x0212',                                         {do not localize}
    'iso-ir-159',                                    {do not localize}
    'csISO159JISX02121990',                          {do not localize}
    'DS_2089',                                       {do not localize}
    'DS2089',                                        {do not localize}
    'ISO646-DK',                                     {do not localize}
    'dk',                                            {do not localize}
    'csISO646Danish',                                {do not localize}
    'us-dk',                                         {do not localize}
    'csUSDK',                                        {do not localize}
    'dk-us',                                         {do not localize}
    'csDKUS',                                        {do not localize}
    'JIS_X0201',                                     {do not localize}
    'X0201',                                         {do not localize}
    'csHalfWidthKatakana',                           {do not localize}
    'KSC5636',                                       {do not localize}
    'ISO646-KR',                                     {do not localize}
    'csKSC5636',                                     {do not localize}
    'DEC-MCS',                                       {do not localize}
    'dec',                                           {do not localize}
    'csDECMCS',                                      {do not localize}
    'hp-roman8',                                     {do not localize}
    'roman8',                                        {do not localize}
    'r8',                                            {do not localize}
    'csHPRoman8',                                    {do not localize}
    'macintosh',                                     {do not localize}
    'mac',                                           {do not localize}
    'csMacintosh',                                   {do not localize}
    'IBM037',                                        {do not localize}
    'cp037',                                         {do not localize}
    'ebcdic-cp-us',                                  {do not localize}
    'ebcdic-cp-ca',                                  {do not localize}
    'ebcdic-cp-wt',                                  {do not localize}
    'ebcdic-cp-nl',                                  {do not localize}
    'csIBM037',                                      {do not localize}
    'IBM038',                                        {do not localize}
    'EBCDIC-INT',                                    {do not localize}
    'cp038',                                         {do not localize}
    'csIBM038',                                      {do not localize}
    'IBM273',                                        {do not localize}
    'CP273',                                         {do not localize}
    'csIBM273',                                      {do not localize}
    'IBM274',                                        {do not localize}
    'EBCDIC-BE',                                     {do not localize}
    'CP274',                                         {do not localize}
    'csIBM274',                                      {do not localize}
    'IBM275',                                        {do not localize}
    'EBCDIC-BR',                                     {do not localize}
    'cp275',                                         {do not localize}
    'csIBM275',                                      {do not localize}
    'IBM277',                                        {do not localize}
    'EBCDIC-CP-DK',                                  {do not localize}
    'EBCDIC-CP-NO',                                  {do not localize}
    'csIBM277',                                      {do not localize}
    'IBM278',                                        {do not localize}
    'CP278',                                         {do not localize}
    'ebcdic-cp-fi',                                  {do not localize}
    'ebcdic-cp-se',                                  {do not localize}
    'csIBM278',                                      {do not localize}
    'IBM280',                                        {do not localize}
    'CP280',                                         {do not localize}
    'ebcdic-cp-it',                                  {do not localize}
    'csIBM280',                                      {do not localize}
    'IBM281',                                        {do not localize}
    'EBCDIC-JP-E',                                   {do not localize}
    'cp281',                                         {do not localize}
    'csIBM281',                                      {do not localize}
    'IBM284',                                        {do not localize}
    'CP284',                                         {do not localize}
    'ebcdic-cp-es',                                  {do not localize}
    'csIBM284',                                      {do not localize}
    'IBM285',                                        {do not localize}
    'CP285',                                         {do not localize}
    'ebcdic-cp-gb',                                  {do not localize}
    'csIBM285',                                      {do not localize}
    'IBM290',                                        {do not localize}
    'cp290',                                         {do not localize}
    'EBCDIC-JP-kana',                                {do not localize}
    'csIBM290',                                      {do not localize}
    'IBM297',                                        {do not localize}
    'cp297',                                         {do not localize}
    'ebcdic-cp-fr',                                  {do not localize}
    'csIBM297',                                      {do not localize}
    'IBM420',                                        {do not localize}
    'cp420',                                         {do not localize}
    'ebcdic-cp-ar1',                                 {do not localize}
    'csIBM420',                                      {do not localize}
    'IBM423',                                        {do not localize}
    'cp423',                                         {do not localize}
    'ebcdic-cp-gr',                                  {do not localize}
    'csIBM423',                                      {do not localize}
    'IBM424',                                        {do not localize}
    'cp424',                                         {do not localize}
    'ebcdic-cp-he',                                  {do not localize}
    'csIBM424',                                      {do not localize}
    'IBM437',                                        {do not localize}
    'cp437',                                         {do not localize}
    '437',                                           {do not localize}
    'csPC8CodePage437',                              {do not localize}
    'IBM500',                                        {do not localize}
    'CP500',                                         {do not localize}
    'ebcdic-cp-be',                                  {do not localize}
    'ebcdic-cp-ch',                                  {do not localize}
    'csIBM500',                                      {do not localize}
    'IBM775',                                        {do not localize}
    'cp775',                                         {do not localize}
    'csPC775Baltic',                                 {do not localize}
    'IBM850',                                        {do not localize}
    'cp850',                                         {do not localize}
    '850',                                           {do not localize}
    'csPC850Multilingual',                           {do not localize}
    'IBM851',                                        {do not localize}
    'cp851',                                         {do not localize}
    '851',                                           {do not localize}
    'csIBM851',                                      {do not localize}
    'IBM852',                                        {do not localize}
    'cp852',                                         {do not localize}
    '852',                                           {do not localize}
    'csPCp852',                                      {do not localize}
    'IBM855',                                        {do not localize}
    'cp855',                                         {do not localize}
    '855',                                           {do not localize}
    'csIBM855',                                      {do not localize}
    'IBM857',                                        {do not localize}
    'cp857',                                         {do not localize}
    '857',                                           {do not localize}
    'csIBM857',                                      {do not localize}
    'IBM860',                                        {do not localize}
    'cp860',                                         {do not localize}
    '860',                                           {do not localize}
    'csIBM860',                                      {do not localize}
    'IBM861',                                        {do not localize}
    'cp861',                                         {do not localize}
    '861',                                           {do not localize}
    'cp-is',                                         {do not localize}
    'csIBM861',                                      {do not localize}
    'IBM862',                                        {do not localize}
    'cp862',                                         {do not localize}
    '862',                                           {do not localize}
    'csPC862LatinHebrew',                            {do not localize}
    'IBM863',                                        {do not localize}
    'cp863',                                         {do not localize}
    '863',                                           {do not localize}
    'csIBM863',                                      {do not localize}
    'IBM864',                                        {do not localize}
    'cp864',                                         {do not localize}
    'csIBM864',                                      {do not localize}
    'IBM865',                                        {do not localize}
    'cp865',                                         {do not localize}
    '865',                                           {do not localize}
    'csIBM865',                                      {do not localize}
    'IBM866',                                        {do not localize}
    'cp866',                                         {do not localize}
    '866',                                           {do not localize}
    'csIBM866',                                      {do not localize}
    'IBM868',                                        {do not localize}
    'CP868',                                         {do not localize}
    'cp-ar',                                         {do not localize}
    'csIBM868',                                      {do not localize}
    'IBM869',                                        {do not localize}
    'cp869',                                         {do not localize}
    '869',                                           {do not localize}
    'cp-gr',                                         {do not localize}
    'csIBM869',                                      {do not localize}
    'IBM870',                                        {do not localize}
    'CP870',                                         {do not localize}
    'ebcdic-cp-roece',                               {do not localize}
    'ebcdic-cp-yu',                                  {do not localize}
    'csIBM870',                                      {do not localize}
    'IBM871',                                        {do not localize}
    'CP871',                                         {do not localize}
    'ebcdic-cp-is',                                  {do not localize}
    'csIBM871',                                      {do not localize}
    'IBM880',                                        {do not localize}
    'cp880',                                         {do not localize}
    'EBCDIC-Cyrillic',                               {do not localize}
    'csIBM880',                                      {do not localize}
    'IBM891',                                        {do not localize}
    'cp891',                                         {do not localize}
    'csIBM891',                                      {do not localize}
    'IBM903',                                        {do not localize}
    'cp903',                                         {do not localize}
    'csIBM903',                                      {do not localize}
    'IBM904',                                        {do not localize}
    'cp904',                                         {do not localize}
    '904',                                           {do not localize}
    'csIBBM904',                                     {do not localize}
    'IBM905',                                        {do not localize}
    'CP905',                                         {do not localize}
    'ebcdic-cp-tr',                                  {do not localize}
    'csIBM905',                                      {do not localize}
    'IBM918',                                        {do not localize}
    'CP918',                                         {do not localize}
    'ebcdic-cp-ar2',                                 {do not localize}
    'csIBM918',                                      {do not localize}
    'IBM1026',                                       {do not localize}
    'CP1026',                                        {do not localize}
    'csIBM1026',                                     {do not localize}
    'EBCDIC-AT-DE',                                  {do not localize}
    'csIBMEBCDICATDE',                               {do not localize}
    'EBCDIC-AT-DE-A',                                {do not localize}
    'csEBCDICATDEA',                                 {do not localize}
    'EBCDIC-CA-FR',                                  {do not localize}
    'csEBCDICCAFR',                                  {do not localize}
    'EBCDIC-DK-NO',                                  {do not localize}
    'csEBCDICDKNO',                                  {do not localize}
    'EBCDIC-DK-NO-A',                                {do not localize}
    'csEBCDICDKNOA',                                 {do not localize}
    'EBCDIC-FI-SE',                                  {do not localize}
    'csEBCDICFISE',                                  {do not localize}
    'EBCDIC-FI-SE-A',                                {do not localize}
    'csEBCDICFISEA',                                 {do not localize}
    'EBCDIC-FR',                                     {do not localize}
    'csEBCDICFR',                                    {do not localize}
    'EBCDIC-IT',                                     {do not localize}
    'csEBCDICIT',                                    {do not localize}
    'EBCDIC-PT',                                     {do not localize}
    'csEBCDICPT',                                    {do not localize}
    'EBCDIC-ES',                                     {do not localize}
    'csEBCDICES',                                    {do not localize}
    'EBCDIC-ES-A',                                   {do not localize}
    'csEBCDICESA',                                   {do not localize}
    'EBCDIC-ES-S',                                   {do not localize}
    'csEBCDICESS',                                   {do not localize}
    'EBCDIC-UK',                                     {do not localize}
    'csEBCDICUK',                                    {do not localize}
    'EBCDIC-US',                                     {do not localize}
    'csEBCDICUS',                                    {do not localize}
    'UNKNOWN-8BIT',                                  {do not localize}
    'csUnknown8BiT',                                 {do not localize}
    'MNEMONIC',                                      {do not localize}
    'csMnemonic',                                    {do not localize}
    'MNEM',                                          {do not localize}
    'csMnem',                                        {do not localize}
    'VISCII',                                        {do not localize}
    'csVISCII',                                      {do not localize}
    'VIQR',                                          {do not localize}
    'csVIQR',                                        {do not localize}
    'KOI8-R',                                        {do not localize}
    'csKOI8R',                                       {do not localize}
    'KOI8-U',                                        {do not localize}
    'IBM00858',                                      {do not localize}
    'CCSID00858',                                    {do not localize}
    'CP00858',                                       {do not localize}
    'PC-Multilingual-850+euro',                      {do not localize}
    'IBM00924',                                      {do not localize}
    'CCSID00924',                                    {do not localize}
    'CP00924',                                       {do not localize}
    'ebcdic-Latin9--euro',                           {do not localize}
    'IBM01140',                                      {do not localize}
    'CCSID01140',                                    {do not localize}
    'CP01140',                                       {do not localize}
    'ebcdic-us-37+euro',                             {do not localize}
    'IBM01141',                                      {do not localize}
    'CCSID01141',                                    {do not localize}
    'CP01141',                                       {do not localize}
    'ebcdic-de-273+euro',                            {do not localize}
    'IBM01142',                                      {do not localize}
    'CCSID01142',                                    {do not localize}
    'CP01142',                                       {do not localize}
    'ebcdic-dk-277+euro',                            {do not localize}
    'ebcdic-no-277+euro',                            {do not localize}
    'IBM01143',                                      {do not localize}
    'CCSID01143',                                    {do not localize}
    'CP01143',                                       {do not localize}
    'ebcdic-fi-278+euro',                            {do not localize}
    'ebcdic-se-278+euro',                            {do not localize}
    'IBM01144',                                      {do not localize}
    'CCSID01144',                                    {do not localize}
    'CP01144',                                       {do not localize}
    'ebcdic-it-280+euro',                            {do not localize}
    'IBM01145',                                      {do not localize}
    'CCSID01145',                                    {do not localize}
    'CP01145',                                       {do not localize}
    'ebcdic-es-284+euro',                            {do not localize}
    'IBM01146',                                      {do not localize}
    'CCSID01146',                                    {do not localize}
    'CP01146',                                       {do not localize}
    'ebcdic-gb-285+euro',                            {do not localize}
    'IBM01147',                                      {do not localize}
    'CCSID01147',                                    {do not localize}
    'CP01147',                                       {do not localize}
    'ebcdic-fr-297+euro',                            {do not localize}
    'IBM01148',                                      {do not localize}
    'CCSID01148',                                    {do not localize}
    'CP01148',                                       {do not localize}
    'ebcdic-international-500+euro',                 {do not localize}
    'IBM01149',                                      {do not localize}
    'CCSID01149',                                    {do not localize}
    'CP01149',                                       {do not localize}
    'ebcdic-is-871+euro',                            {do not localize}
    'Big5-HKSCS',                                    {do not localize}
    'UTF-16BE',                                      {do not localize}
    'UTF-16LE',                                      {do not localize}
    'UTF-16',                                        {do not localize}
    'CESU-8',                                        {do not localize}
    'csCESU-8',                                      {do not localize}
    'UTF-32',                                        {do not localize}
    'UTF-32BE',                                      {do not localize}
    'UTF-32LE',                                      {do not localize}
    'UNICODE-1-1-UTF-7',                             {do not localize}
    'csUnicode11UTF7',                               {do not localize}
    'UTF-8',                                         {do not localize}
    'ISO-8859-13',                                   {do not localize}
    'ISO-8859-14',                                   {do not localize}
    'iso-ir-199',                                    {do not localize}
    'ISO_8859-14:1998',                              {do not localize}
    'ISO_8859-14',                                   {do not localize}
    'latin8',                                        {do not localize}
    'iso-celtic',                                    {do not localize}
    'l8',                                            {do not localize}
    'ISO-8859-15',                                   {do not localize}
    'ISO_8859-15',                                   {do not localize}
    'Latin-9',                                       {do not localize}
    'ISO-8859-16',                                   {do not localize}
    'iso-ir-226',                                    {do not localize}
    'ISO_8859-16:2001',                              {do not localize}
    'ISO_8859-16',                                   {do not localize}
    'latin10',                                       {do not localize}
    'l10',                                           {do not localize}
    'GBK',                                           {do not localize}
    'CP936',                                         {do not localize}
    'MS936',                                         {do not localize}
    'windows-936',                                   {do not localize}
    'GB18030',                                       {do not localize}
    'JIS_Encoding',                                  {do not localize}
    'csJISEncoding',                                 {do not localize}
    'Shift_JIS',                                     {do not localize}
    'MS_Kanji',                                      {do not localize}
    'csShiftJIS',                                    {do not localize}
    'EUC-JP',                                        {do not localize}
    'Extended_UNIX_Code_Packed_Format_for_Japanese', {do not localize}
    'csEUCPkdFmtJapanese',                           {do not localize}
    'Extended_UNIX_Code_Fixed_Width_for_Japanese',   {do not localize}
    'csEUCFixWidJapanese',                           {do not localize}
    'DOS-862',                                       {do not localize}
    'windows-874',                                   {do not localize}
    'cp875',                                         {do not localize}
    'IBM01047',                                      {do not localize}
    'unicodeFFFE',                                   {do not localize}
    'Johab',                                         {do not localize}
    'x-mac-japanese',                                {do not localize}
    'x-mac-chinesetrad',                             {do not localize}
    'x-mac-korean',                                  {do not localize}
    'x-mac-arabic',                                  {do not localize}
    'x-mac-hebrew',                                  {do not localize}
    'x-mac-greek',                                   {do not localize}
    'x-mac-cyrillic',                                {do not localize}
    'x-mac-chinesesimp',                             {do not localize}
    'x-mac-romanian',                                {do not localize}
    'x-mac-ukrainian',                               {do not localize}
    'x-mac-thai',                                    {do not localize}
    'x-mac-ce',                                      {do not localize}
    'x-mac-icelandic',                               {do not localize}
    'x-mac-turkish',                                 {do not localize}
    'x-mac-croatian',                                {do not localize}
    'x-Chinese-CNS',                                 {do not localize}
    'x-cp20001',                                     {do not localize}
    'x-Chinese-Eten',                                {do not localize}
    'x-cp20003',                                     {do not localize}
    'x-cp20004',                                     {do not localize}
    'x-cp20005',                                     {do not localize}
    'x-IA5',                                         {do not localize}
    'x-IA5-German',                                  {do not localize}
    'x-IA5-Swedish',                                 {do not localize}
    'x-IA5-Norwegian',                               {do not localize}
    'x-cp20261',                                     {do not localize}
    'x-cp20269',                                     {do not localize}
    'x-EBCDIC-KoreanExtended',                       {do not localize}
    'x-cp20936',                                     {do not localize}
    'x-cp20949',                                     {do not localize}
    'cp1025',                                        {do not localize}
    'x-Europa',                                      {do not localize}
    'x-cp50227',                                     {do not localize}
    'EUC-CN',                                        {do not localize}
    'x-iscii-de',                                    {do not localize}
    'x-iscii-be',                                    {do not localize}
    'x-iscii-ta',                                    {do not localize}
    'x-iscii-te',                                    {do not localize}
    'x-iscii-as',                                    {do not localize}
    'x-iscii-or',                                    {do not localize}
    'x-iscii-ka',                                    {do not localize}
    'x-iscii-ma',                                    {do not localize}
    'x-iscii-gu',                                    {do not localize}
    'x-iscii-pa',                                    {do not localize}
    'x-EBCDIC-Arabic',                               {do not localize}
    'x-EBCDIC-CyrillicRussian',                      {do not localize}
    'x-EBCDIC-CyrillicSerbianBulgarian',             {do not localize}
    'x-EBCDIC-DenmarkNorway',                        {do not localize}
    'x-ebcdic-denmarknorway-euro',                   {do not localize}
    'x-EBCDIC-FinlandSweden',                        {do not localize}
    'x-ebcdic-finlandsweden-euro',                   {do not localize}
    'X-EBCDIC-France',                               {do not localize}
    'x-ebcdic-france-euro',                          {do not localize}
    'x-EBCDIC-Germany',                              {do not localize}
    'x-ebcdic-germany-euro',                         {do not localize}
    'x-EBCDIC-GreekModern',                          {do not localize}
    'x-EBCDIC-Greek',                                {do not localize}
    'x-EBCDIC-Hebrew',                               {do not localize}
    'x-EBCDIC-Icelandic',                            {do not localize}
    'x-ebcdic-icelandic-euro',                       {do not localize}
    'x-ebcdic-international-euro',                   {do not localize}
    'x-EBCDIC-Italy',                                {do not localize}
    'x-ebcdic-italy-euro',                           {do not localize}
    'x-EBCDIC-JapaneseAndKana',                      {do not localize}
    'x-EBCDIC-JapaneseAndJapaneseLatin',             {do not localize}
    'x-EBCDIC-JapaneseAndUSCanada',                  {do not localize}
    'x-EBCDIC-JapaneseKatakana',                     {do not localize}
    'x-EBCDIC-KoreanAndKoreanExtended',              {do not localize}
    'x-EBCDIC-SimplifiedChinese',                    {do not localize}
    'X-EBCDIC-Spain',                                {do not localize}
    'x-ebcdic-spain-euro',                           {do not localize}
    'x-EBCDIC-Thai',                                 {do not localize}
    'x-EBCDIC-TraditionalChinese',                   {do not localize}
    'x-EBCDIC-Turkish',                              {do not localize}
    'x-EBCDIC-UK',                                   {do not localize}
    'x-ebcdic-uk-euro',                              {do not localize}
    'x-ebcdic-cp-us-euro',                           {do not localize}
    'OSD_EBCDIC_DF04_15',                            {do not localize}
    'OSD_EBCDIC_DF03_IRV',                           {do not localize}
    'OSD_EBCDIC_DF04_1',                             {do not localize}
    'ISO-11548-1',                                   {do not localize}
    'ISO_11548-1',                                   {do not localize}
    'ISO_TR_11548-1',                                {do not localize}
    'csISO115481',                                   {do not localize}
    'KZ-1048',                                       {do not localize}
    'STRK1048-2002',                                 {do not localize}
    'RK1048',                                        {do not localize}
    'csKZ1048',                                      {do not localize}
    'ISO-10646-UCS-2',                               {do not localize}
    'csUnicode',                                     {do not localize}
    'ISO-10646-UCS-4',                               {do not localize}
    'csUCS4',                                        {do not localize}
    'UNICODE-1-1',                                   {do not localize}
    'csUnicode11',                                   {do not localize}
    'SCSU',                                          {do not localize}
    'UTF-7',                                         {do not localize}
    'ISO-10646-UCS-Basic',                           {do not localize}
    'csUnicodeASCII',                                {do not localize}
    'ISO-10646-Unicode-Latin1',                      {do not localize}
    'csUnicodeLatin1',                               {do not localize}
    'ISO-10646',                                     {do not localize}
    'ISO-10646-J-1',                                 {do not localize}
    'ISO-Unicode-IBM-1261',                          {do not localize}
    'csUnicodeIBM1261',                              {do not localize}
    'ISO-Unicode-IBM-1268',                          {do not localize}
    'csUnicodeIBM1268',                              {do not localize}
    'ISO-Unicode-IBM-1276',                          {do not localize}
    'csUnicodeIBM1276',                              {do not localize}
    'ISO-Unicode-IBM-1264',                          {do not localize}
    'csUnicodeIBM1264',                              {do not localize}
    'ISO-Unicode-IBM-1265',                          {do not localize}
    'csUnicodeIBM1265',                              {do not localize}
    'BOCU-1',                                        {do not localize}
    'csBOCU-1',                                      {do not localize}
    'ISO-8859-1-Windows-3.0-Latin-1',                {do not localize}
    'csWindows30Latin1',                             {do not localize}
    'ISO-8859-1-Windows-3.1-Latin-1',                {do not localize}
    'csWindows31Latin1',                             {do not localize}
    'ISO-8859-2-Windows-Latin-2',                    {do not localize}
    'csWindows31Latin2',                             {do not localize}
    'ISO-8859-9-Windows-Latin-5',                    {do not localize}
    'csWindows31Latin5',                             {do not localize}
    'Adobe-Standard-Encoding',                       {do not localize}
    'csAdobeStandardEncoding',                       {do not localize}
    'Ventura-US',                                    {do not localize}
    'csVenturaUS',                                   {do not localize}
    'Ventura-International',                         {do not localize}
    'csVenturaInternational',                        {do not localize}
    'PC8-Danish-Norwegian',                          {do not localize}
    'csPC8DanishNorwegian',                          {do not localize}
    'PC8-Turkish',                                   {do not localize}
    'csPC8Turkish',                                  {do not localize}
    'IBM-Symbols',                                   {do not localize}
    'csIBMSymbols',                                  {do not localize}
    'IBM-Thai',                                      {do not localize}
    'csIBMThai',                                     {do not localize}
    'HP-Legal',                                      {do not localize}
    'csHPLegal',                                     {do not localize}
    'HP-Pi-font',                                    {do not localize}
    'csHPPiFont',                                    {do not localize}
    'HP-Math8',                                      {do not localize}
    'csHPMath8',                                     {do not localize}
    'Adobe-Symbol-Encoding',                         {do not localize}
    'csHPPSMath',                                    {do not localize}
    'HP-DeskTop',                                    {do not localize}
    'csHPDesktop',                                   {do not localize}
    'Ventura-Math',                                  {do not localize}
    'csVenturaMath',                                 {do not localize}
    'Microsoft-Publishing',                          {do not localize}
    'csMicrosoftPublishing',                         {do not localize}
    'Windows-31J',                                   {do not localize}
    'csWindows31J',                                  {do not localize}
    'GB2312',                                        {do not localize}
    'csGB2312',                                      {do not localize}
    'Big5',                                          {do not localize}
    'csBig5',                                        {do not localize}
    'HZ-GB-2312',                                    {do not localize}
    'IBM1047',                                       {do not localize}
    'IBM-1047',                                      {do not localize}
    'PTCP154',                                       {do not localize}
    'csPTCP154',                                     {do not localize}
    'PT154',                                         {do not localize}
    'CP154',                                         {do not localize}
    'Cyrillic-Asian',                                {do not localize}
    'Amiga-1251',                                    {do not localize}
    'Ami1251',                                       {do not localize}
    'Amiga1251',                                     {do not localize}
    'Ami-1251',                                      {do not localize}
    'KOI7-switched',                                 {do not localize}
    'BRF',                                           {do not localize}
    'csBRF',                                         {do not localize}
    'TSCII',                                         {do not localize}
    'csTSCII',                                       {do not localize}
    'windows-1250',                                  {do not localize}
    'windows-1251',                                  {do not localize}
    'windows-1252',                                  {do not localize}
    'windows-1253',                                  {do not localize}
    'windows-1254',                                  {do not localize}
    'windows-1255',                                  {do not localize}
    'windows-1256',                                  {do not localize}
    'windows-1257',                                  {do not localize}
    'windows-1258',                                  {do not localize}
    'TIS-620',                                       {do not localize}
    'DOS-720',                                       {do not localize}
    'ibm737'                                         {do not localize}
  );

function FindPreferredCharset(const ACharSet: TIdCharSet): TIdCharSet;
function FindCharset(const ACharSet: string): TIdCharset;
function CharsetToCodePage(const ACharSet: TIdCharSet): Word; overload;
function CharsetToCodePage(const ACharSet: String): Word; overload;

implementation

uses
  IdGlobal,
  SysUtils;

function FindPreferredCharset(const ACharSet: TIdCharSet): TIdCharSet;
begin
  case ACharSet of
    { US-ASCII }
    idcs_ANSI_X3_4_1968,
    idcs_iso_ir_6,
    idcs_ANSI_X3_4_1986,
    idcs_ISO_646_irv_1991,
    idcs_ASCII,
    idcs_ISO646_US,
    idcs_us,
    idcs_IBM367,
    idcs_cp367,
    idcs_csASCII:
      Result := idcs_US_ASCII;

    { Korean (ISO) }
    idcs_csISO2022KR:
      Result := idcs_ISO_2022_KR;

    { Korean (EUC) }
    idcs_csEUCKR:
      Result := idcs_EUC_KR;

    { Japanese (JIS-Allow 1 byte Kana - SO/SI) }
    idcs_csISO2022JP:
      Result := idcs_ISO_2022_JP;

    idcs_csISO2022JP2:
      Result := idcs_ISO_2022_JP_2;

    { Western European (ISO) }
    idcs_ISO_8859_1_1987,
    idcs_iso_ir_100,
    idcs_ISO_8859_1_,
    idcs_latin1,
    idcs_l1,
    idcs_IBM819,
    idcs_CP819,
    idcs_csISOLatin1:
      Result := idcs_ISO_8859_1;

    { Central European (ISO) }
    idcs_ISO_8859_2_1987,
    idcs_iso_ir_101,
    idcs_ISO_8859_2_,
    idcs_latin2,
    idcs_l2,
    idcs_csISOLatin2:
      Result := idcs_ISO_8859_2;

    { Latin 3 (ISO) }
    idcs_ISO_8859_3_1988,
    idcs_iso_ir_109,
    idcs_ISO_8859_3_,
    idcs_latin3,
    idcs_l3,
    idcs_csISOLatin3:
      Result := idcs_ISO_8859_3;

    { Baltic (ISO) }
    idcs_ISO_8859_4_1988,
    idcs_iso_ir_110,
    idcs_ISO_8859_4_,
    idcs_latin4,
    idcs_l4,
    idcs_csISOLatin4:
      Result := idcs_ISO_8859_4;

    { Arabic (ISO) }
    idcs_ISO_8859_6_1987,
    idcs_iso_ir_127,
    idcs_ISO_8859_6_,
    idcs_ECMA_114,
    idcs_ASMO_708,
    idcs_arabic,
    idcs_csISOLatinArabic:
      Result := idcs_ISO_8859_6;

    idcs_ISO_8859_6_E_,
    idcs_csISO88596E:
      Result := idcs_ISO_8859_6_E;

    idcs_ISO_8859_6_I_,
    idcs_csISO88596I:
      Result := idcs_ISO_8859_6_I;

    { Greek (ISO) }
    idcs_ISO_8859_7_1987,
    idcs_iso_ir_126,
    idcs_ISO_8859_7_,
    idcs_ELOT_928,
    idcs_ECMA_118,
    idcs_greek,
    idcs_greek8,
    idcs_csISOLatinGreek:
      Result := idcs_ISO_8859_7;

    { Hebrew (ISO-Visual) }
    idcs_ISO_8859_8_1988,
    idcs_iso_ir_138,
    idcs_ISO_8859_8_,
    idcs_hebrew,
    idcs_csISOLatinHebrew:
      Result := idcs_ISO_8859_8;

    idcs_ISO_8859_8_E_,
    idcs_csISO88598E:
      Result := idcs_ISO_8859_8_E;

    { Hebrew (ISO-Logical) }
    idcs_ISO_8859_8_I_,
    idcs_csISO88598I:
      Result := idcs_ISO_8859_8_I;

    { Cyrillic (ISO) }
    idcs_ISO_8859_5_1988,
    idcs_iso_ir_144,
    idcs_ISO_8859_5_,
    idcs_cyrillic,
    idcs_csISOLatinCyrillic:
      Result := idcs_ISO_8859_5;

    { Turkish (ISO) }
    idcs_ISO_8859_9_1989,
    idcs_iso_ir_148,
    idcs_ISO_8859_9_,
    idcs_latin5,
    idcs_l5,
    idcs_csISOLatin5:
      Result := idcs_ISO_8859_9;

    idcs_iso_ir_157,
    idcs_l6,
    idcs_ISO_8859_10_1992,
    idcs_csISOLatin6,
    idcs_latin6:
      Result := idcs_ISO_8859_10;

    { Cyrillic (KOI8-R) }
    idcs_csKOI8R:
      Result := idcs_KOI8_R;

    { Japanese (Shift-JIS) }
    idcs_MS_Kanji,
    idcs_csShiftJIS:
      Result := idcs_Shift_JIS;

    { Japanese (EUC) }
    idcs_Extended_UNIX_Code_Packed_Format_for_Japanese,
    idcs_csEUCPkdFmtJapanese:
      Result := idcs_EUC_JP;

    { Chinese Simplified (GB2312) }
    idcs_csGB2312:
      Result := idcs_GB2312;

    { Chinese Traditional (Big5) }
    idcs_csBig5:
      Result := idcs_Big5;

  else
    Result := ACharSet;
  end;
end;

{
  REFERENCES

  [RFC1345]  Simonsen, K., "Character Mnemonics & Character Sets",
             RFC 1345, Rationel Almen Planlaegning, Rationel Almen
             Planlaegning, June 1992.

  [RFC1428]  Vaudreuil, G., "Transition of Internet Mail from
             Just-Send-8 to 8bit-SMTP/MIME", RFC1428, CNRI, February
             1993.

  [RFC1456]  Vietnamese Standardization Working Group, "Conventions for
             Encoding the Vietnamese Language VISCII: VIetnamese
             Standard Code for Information Interchange VIQR: VIetnamese
             Quoted-Readable Specification Revision 1.1", RFC 1456, May
             1993.

  [RFC1468]  Murai, J., Crispin, M., and E. van der Poel, "Japanese
             Character Encoding for Internet Messages", RFC 1468,
             Keio University, Panda Programming, June 1993.

  [RFC1489]  Chernov, A., "Registration of a Cyrillic Character Set",
             RFC1489, RELCOM Development Team, July 1993.

  [RFC1554]  Ohta, M., and K. Handa, "ISO-2022-JP-2: Multilingual
             Extension of ISO-2022-JP", RFC1554, Tokyo Institute of
             Technology, ETL, December 1993.

  [RFC1556]  Nussbacher, H., "Handling of Bi-directional Texts in MIME",
             RFC1556, Israeli Inter-University, December 1993.

  [RFC1557]  Choi, U., Chon, K., and H. Park, "Korean Character Encoding
             for Internet Messages", KAIST, Solvit Chosun Media,
             December 1993.

  [RFC1641]  Goldsmith, D., and M. Davis, "Using Unicode with MIME",
             RFC1641, Taligent, Inc., July 1994.

  [RFC1642]  Goldsmith, D., and M. Davis, "UTF-7", RFC1642, Taligent,
             Inc., July 1994.

  [RFC1815]  Ohta, M., "Character Sets ISO-10646 and ISO-10646-J-1",
             RFC 1815, Tokyo Institute of Technology, July 1995.


  [Adobe]    Adobe Systems Incorporated, PostScript Language Reference
             Manual, second edition, Addison-Wesley Publishing Company,
             Inc., 1990.

  [HP-PCL5]  Hewlett-Packard Company, "HP PCL 5 Comparison Guide",
             (P/N 5021-0329) pp B-13, 1996.

  [IBM-CIDT] IBM Corporation, "ABOUT TYPE: IBM's Technical Reference
             for Core Interchange Digitized Type", Publication number
             S544-3708-01

  [RFC1842]  Wei, Y., J. Li, and Y. Jiang, "ASCII Printable
             Characters-Based Chinese Character Encoding for Internet
             Messages", RFC 1842, Harvard University, Rice University,
             University of Maryland, August 1995.

  [RFC1843]  Lee, F., "HZ - A Data Format for Exchanging Files of
             Arbitrarily Mixed Chinese and ASCII Characters", RFC 1843,
             Stanford University, August 1995.

  [RFC2152]  Goldsmith, D., M. Davis, "UTF-7: A Mail-Safe Transformation
             Format of Unicode", RFC 2152, Apple Computer, Inc.,
             Taligent Inc., May 1997.

  [RFC2279]  Yergeau, F., "UTF-8, A Transformation Format of ISO 10646",
             RFC 2279, Alis Technologies, January, 1998.

  [RFC2781]  Hoffman, P., Yergeau, F., "UTF-16, an encoding of ISO 10646",
             RFC 2781, February 2000.


  PEOPLE

  [KXS2] Keld Simonsen <Keld.Simonsen@dkuug.dk>

  [Choi] Woohyong Choi <whchoi@cosmos.kaist.ac.kr>

  [Davis] Mark Davis, <mark@unicode.org>, April 2002.

  [Lazhintseva] Katya Lazhintseva, <katyal@MICROSOFT.com>, May 1996.

  [Mahdi] Tamer Mahdi, <tamer@ca.ibm.com>, August 2000.

  [Murai] Jun Murai <jun@wide.ad.jp>

  [Nussbacher] Hank Nussbacher, <hank@vm.tau.ac.il>

  [Ohta] Masataka Ohta, <mohta@cc.titech.ac.jp>, July 1995.

  [Phipps] Toby Phipps, <tphipps@peoplesoft.com>, March 2002.

  [Pond] Rick Pond, <rickpond@vnet.ibm.com> March 1997.

  [Scherer] Markus Scherer, <markus.scherer@jtcsv.com>, August 2000.

  [Simonsen] Keld Simonsen, <Keld.Simonsen@rap.dk>, August 2000.
}

{ this is for searching a charset from a string, it must be case-insensitive }
function FindCharset(const ACharSet: string): TIdCharset;
var
  Lcset: TIdCharset;
begin
  Result := idcs_INVALID;

  for Lcset := Low(TIdCharSet) to High(TIdCharSet) do begin
    if TextIsSame(IdCharsetNames[Lcset], ACharSet) then begin
      Result := Lcset;
      Exit;
    end;
  end;

  // RLebeau 5/2/2017: have seen some malformed emails that use 'utf8' instead
  // of 'utf-8', so let's check for that.  Not adding 'utf8' to TIdCharSet at
  // this time, as I don't want to cause any compatibility issues...

  // RLebeau 9/27/2017: updating to handle a few more UTFs without hyphens...

  case PosInStrArray(ACharset, ['UTF7', 'UTF8', 'UTF16', 'UTF16LE', 'UTF16BE', 'UTF32', 'UTF32LE', 'UTF32BE'], False) of {Do not Localize}
    0:   Result := idcs_UTF_7;
    1:   Result := idcs_UTF_8;
    2,3: Result := idcs_UTF_16LE;
    4:   Result := idcs_UTF_16BE;
    5,6: Result := idcs_UTF_32LE;
    7:   Result := idcs_UTF_32BE;
  end;

  // TODO: on Windows, utilize the following Registry key for additional lookups:
  //
  // HKEY_CLASSES_ROOT\Mime\Database\Charset
end;

// RLebeau: this table was generated by scanning my PC's Windows Registry key:
// "HKEY_CLASSES_ROOT\Mime\Database\Charset"
// and then filling in missing values using various online resources.
// This may be incomplete or not entirely accurate...

// TODO: compare to the list found at https://stackoverflow.com/a/53750294/65863...

const
  IdCharsetCodePages : array[Low(TIdCharSet)..High(TIdCharSet)] of Word = (
    0,     // Unknown

    20127, // US-ASCII
    20127, // ANSI_X3.4-1968
    20127, // iso-ir-6
    20127, // ANSI_X3.4-1986
    20127, // ISO_646.irv:1991
    20127, // ASCII
    20127, // ISO646-US
    20127, // us
    20127, // IBM367
    20127, // cp367
    20127, // csASCII

    0,     // ISO-10646-UTF-1
    0,     // csISO10646UTF1

    0,     // ISO_646.basic:1983
    0,     // ref
    0,     // csISO646basic1983

    0,     // INVARIANT
    0,     // csINVARIANT

    0,     // ISO_646.irv:1983
    0,     // iso-ir-2
    0,     // irv
    0,     // csISO2IntlRefVersion

    0,     // BS_4730
    0,     // iso-ir-4
    0,     // ISO646-GB
    0,     // gb
    0,     // uk
    0,     // csISO4UnitedKingdom

    0,     // NATS-SEFI
    0,     // iso-ir-8-1
    0,     // csNATSSEFI

    0,     // NATS-SEFI-ADD
    0,     // iso-ir-8-2
    0,     // csNATSSEFIADD

    0,     // NATS-DANO
    0,     // iso-ir-9-1
    0,     // csNATSDANO

    0,     // NATS-DANO-ADD
    0,     // iso-ir-9-2
    0,     // csNATSDANOADD

    0,     // SEN_850200_B
    0,     // iso-ir-10
    0,     // FI
    0,     // ISO646-FI
    0,     // ISO646-SE
    0,     // se
    0,     // csISO10Swedish

    0,     // SEN_850200_C
    0,     // iso-ir-11
    0,     // ISO646-SE2
    0,     // se2
    0,     // csISO11SwedishForNames

    949,   // KS_C_5601-1987
    949,   // iso-ir-149
    949,   // KS_C_5601-1989
    949,   // KSC_5601
    949,   // korean
    949,   // csKSC56011987

    50225, // ISO-2022-KR
    50225, // csISO2022KR

    51949, // EUC-KR
    51949, // csEUCKR

    50220, // ISO-2022-JP [need to verify]
    50221, // csISO2022JP

    0,     // ISO-2022-JP-2
    0,     // csISO2022JP2

    0,     // ISO-2022-CN

    0,     // ISO-2022-CN-EXT

    0,     // JIS_C6220-1969-jp
    0,     // JIS_C6220-1969
    0,     // iso-ir-13
    0,     // katakana
    0,     // x0201-7
    0,     // csISO13JISC6220jp

    0,     // JIS_C6220-1969-ro
    0,     // iso-ir-14
    0,     // jp
    0,     // ISO646-JP
    0,     // csISO14JISC6220ro

    0,     // IT
    0,     // iso-ir-15
    0,     // ISO646-IT
    0,     // csISO15Italian

    0,     // PT
    0,     // iso-ir-16
    0,     // ISO646-PT
    0,     // csISO16Portuguese

    0,     // ES
    0,     // iso-ir-17
    0,     // ISO646-ES
    0,     // csISO17Spanish

    0,     // greek7-old
    0,     // iso-ir-18
    0,     // csISO18Greek7Old

    0,     // latin-greek
    0,     // iso-ir-19
    0,     // csISO19LatinGreek

    0,     // DIN_66003
    0,     // iso-ir-21
    0,     // de
    0,     // ISO646-DE
    0,     // csISO21German

    0,     // NF_Z_62-010_(1973)
    0,     // iso-ir-25
    0,     // ISO646-FR1
    0,     // csISO25French

    0,     // Latin-greek-1
    0,     // iso-ir-27
    0,     // csISO27LatinGreek1

    0,     // ISO_5427
    0,     // iso-ir-37
    0,     // csISO5427Cyrillic

    0,     // JIS_C6226-1978
    0,     // iso-ir-42
    0,     // csISO42JISC62261978

    0,     // BS_viewdata
    0,     // iso-ir-47
    0,     // csISO47BSViewdata

    0,     // INIS
    0,     // iso-ir-49
    0,     // csISO49INIS

    0,     // INIS-8
    0,     // iso-ir-50
    0,     // csISO50INIS8

    0,     // INIS-cyrillic
    0,     // iso-ir-51
    0,     // csISO51INISCyrillic

    0,     // ISO_5427:1981
    0,     // iso-ir-54
    0,     // ISO5427Cyrillic1981

    0,     // ISO_5428:1980
    0,     // iso-ir-55
    0,     // csISO5428Greek

    0,     // GB_1988-80
    0,     // iso-ir-57
    0,     // cn
    0,     // ISO646-CN
    0,     // csISO57GB1988

    936,   // GB_2312-80
    936,   // iso-ir-58
    936,   // chinese   //aliases to gb2312 on Windows
    936,   // csISO58GB231280

    0,     // NS_4551-1
    0,     // iso-ir-60
    0,     // ISO646-NO
    0,     // no
    0,     // csISO60DanishNorwegian
    0,     // csISO60Norwegian1

    0,     // NS_4551-2
    0,     // ISO646-NO2
    0,     // iso-ir-61
    0,     // no2
    0,     // csISO61Norwegian2

    0,     // NF_Z_62-010
    0,     // iso-ir-69
    0,     // ISO646-FR
    0,     // fr
    0,     // csISO69French

    0,     // videotex-suppl
    0,     // iso-ir-70
    0,     // csISO70VideotexSupp1

    0,     // PT2
    0,     // iso-ir-84
    0,     // ISO646-PT2
    0,     // csISO84Portuguese2

    0,     // ES2
    0,     // iso-ir-85
    0,     // ISO646-ES2
    0,     // csISO85Spanish2

    0,     // MSZ_7795.3
    0,     // iso-ir-86
    0,     // ISO646-HU
    0,     // hu
    0,     // csISO86Hungarian

    0,     // JIS_C6226-1983
    0,     // iso-ir-87
    0,     // x0208
    0,     // JIS_X0208-1983
    0,     // csISO87JISX0208

    0,     // greek7
    0,     // iso-ir-88
    0,     // csISO88Greek7

    0,     // ASMO_449
    0,     // ISO_9036
    0,     // arabic7
    0,     // iso-ir-89
    0,     // csISO89ASMO449

    0,     // iso-ir-90
    0,     // csISO90

    0,     // JIS_C6229-1984-a
    0,     // iso-ir-91
    0,     // jp-ocr-a
    0,     // csISO91JISC62291984a

    0,     // JIS_C6229-1984-b
    0,     // iso-ir-92
    0,     // ISO646-JP-OCR-B
    0,     // jp-ocr-b
    0,     // csISO92JISC62991984b

    0,     // JIS_C6229-1984-b-add
    0,     // iso-ir-93
    0,     // jp-ocr-b-add
    0,     // csISO93JIS62291984badd

    0,     // JIS_C6229-1984-hand
    0,     // iso-ir-94
    0,     // jp-ocr-hand
    0,     // csISO94JIS62291984hand

    0,     // JIS_C6229-1984-hand-add
    0,     // iso-ir-95
    0,     // jp-ocr-hand-add
    0,     // csISO95JIS62291984handadd

    0,     // JIS_C6229-1984-kana
    0,     // iso-ir-96
    0,     // csISO96JISC62291984kana

    0,     // ISO_2033-1983
    0,     // iso-ir-98
    0,     // e13b
    0,     // csISO2033

    0,     // ANSI_X3.110-1983
    0,     // iso-ir-99
    0,     // CSA_T500-1983
    0,     // NAPLPS
    0,     // csISO99NAPLPS

    28591, // ISO-8859-1
    28591, // ISO_8859-1:1987
    28591, // iso-ir-100
    28591, // ISO_8859-1
    28591, // latin1
    28591, // l1
    28591, // IBM819
    28591, // CP819
    28591, // csISOLatin1

    28592, // ISO-8859-2
    28592, // ISO_8859-2:1987
    28592, // iso-ir-101
    28592, // ISO_8859-2
    28592, // latin2
    28592, // l2
    28592, // csISOLatin2

    0,     // T.61-7bit
    0,     // iso-ir-102
    0,     // csISO102T617bit

    0,     // T.61-8bit
    0,     // T.61
    0,     // iso-ir-103
    0,     // csISO103T618bit

    28593, // ISO-8859-3
    28593, // ISO_8859-3:1988
    28593, // iso-ir-109
    28593, // ISO_8859-3
    28593, // latin3
    28593, // l3
    28593, // csISOLatin3

    28594, // ISO-8859-4
    28594, // ISO_8859-4:1988
    28594, // iso-ir-110
    28594, // ISO_8859-4
    28594, // latin4
    28594, // l4
    28594, // csISOLatin4

    0,     // ECMA-cyrillic
    0,     // iso-ir-111
    0,     // KOI8-E
    0,     // csISO111ECMACyrillic

    0,     // CSA_Z243.4-1985-1
    0,     // iso-ir-121
    0,     // ISO646-CA
    0,     // csa7-1
    0,     // ca
    0,     // csISO121Canadian1

    0,     // CSA_Z243.4-1985-2
    0,     // iso-ir-122
    0,     // ISO646-CA2
    0,     // csa7-2
    0,     // csISO122Canadian2

    0,     // CSA_Z243.4-1985-gr
    0,     // iso-ir-123
    0,     // csISO123CSAZ24341985gr

    28596, // ISO-8859-6
    708,   // ISO_8859-6:1987
    708,   // iso-ir-127
    708,   // ISO_8859-6
    708,   // ECMA-114
    708,   // ASMO-708
    708,   // arabic
    708,   // csISOLatinArabic

    0,     // ISO-8859-6-E
    0,     // ISO_8859-6-E
    0,     // csISO88596E

    0,     // ISO-8859-6-I
    0,     // ISO_8859-6-I
    0,     // csISO88596I

    28597, // ISO-8859-7
    28597, // ISO_8859-7:1987
    28597, // iso-ir-126
    28597, // ISO_8859-7
    28597, // ELOT_928
    28597, // ECMA-118
    28597, // greek
    28597, // greek8
    28597, // csISOLatinGreek

    0,     // T.101-G2
    0,     // iso-ir-128
    0,     // csISO128T101G2

    28598, // ISO-8859-8
    28598, // ISO_8859-8:1988
    28598, // iso-ir-138
    28598, // ISO_8859-8
    28598, // hebrew
    28598, // csISOLatinHebrew

    0,     // ISO-8859-8-E
    0,     // ISO_8859-8-E
    0,     // csISO88598E

    38598, // ISO-8859-8-I
    38598, // ISO_8859-8-I
    38598, // csISO88598I

    0,     // CSN_369103
    0,     // iso-ir-139
    0,     // csISO139CSN369103

    0,     // JUS_I.B1.002
    0,     // iso-ir-141
    0,     // ISO646-YU
    0,     // js
    0,     // yu
    0,     // csISO141JUSIB1002

    0,     // ISO_6937-2-add
    0,     // iso-ir-142
    0,     // csISOTextComm

    0,     // IEC_P27-1
    0,     // iso-ir-143
    0,     // csISO143IECP271

    28595, // ISO-8859-5
    28595, // ISO_8859-5:1988
    28595, // iso-ir-144
    28595, // ISO_8859-5
    28595, // cyrillic
    28595, // csISOLatinCyrillic

    0,     // JUS_I.B1.003-serb
    0,     // iso-ir-146
    0,     // serbian
    0,     // csISO146Serbian

    0,     // JUS_I.B1.003-mac
    0,     // macedonian
    0,     // iso-ir-147
    0,     // csISO147Macedonian

    28599, // ISO-8859-9
    28599, // ISO_8859-9:1989
    28599, // iso-ir-148
    28599, // ISO_8859-9
    28599, // latin5
    28599, // l5
    28599, // csISOLatin5

    0,     // greek-ccitt
    0,     // iso-ir-150
    0,     // csISO150
    0,     // csISO150GreekCCITT

    0,     // NC_NC00-10:81
    0,     // cuba
    0,     // iso-ir-151
    0,     // ISO646-CU
    0,     // csISO151Cuba

    0,     // ISO_6937-2-25
    0,     // iso-ir-152
    0,     // csISO6937Add

    0,     // GOST_19768-74
    0,     // ST_SEV_358-88
    0,     // iso-ir-153
    0,     // csISO153GOST1976874

    0,     // ISO_8859-supp
    0,     // iso-ir-154
    0,     // latin1-2-5
    0,     // csISO8859Supp

    0,     // ISO_10367-box
    0,     // iso-ir-155
    0,     // csISO10367Box

    0,     // ISO-8859-10
    0,     // iso-ir-157
    0,     // l6
    0,     // ISO_8859-10:1992
    0,     // csISOLatin6
    0,     // latin6

    0,     // latin-lap
    0,     // lap
    0,     // iso-ir-158
    0,     // csISO158Lap

    0,     // JIS_X0212-1990
    0,     // x0212
    0,     // iso-ir-159
    0,     // csISO159JISX02121990

    0,     // DS_2089
    0,     // DS2089
    0,     // ISO646-DK
    0,     // dk
    0,     // csISO646Danish

    0,     // us-dk
    0,     // csUSDK

    0,     // dk-us
    0,     // csDKUS

    0,     // JIS_X0201
    0,     // X0201
    0,     // csHalfWidthKatakana

    0,     // KSC5636
    0,     // ISO646-KR
    0,     // csKSC5636

    0,     // DEC-MCS
    0,     // dec
    0,     // csDECMCS

    0,     // hp-roman8
    0,     // roman8
    0,     // r8
    0,     // csHPRoman8

    10000, // macintosh
    10000, // mac
    10000, // csMacintosh

    37,    // IBM037
    37,    // cp037
    37,    // ebcdic-cp-us
    37,    // ebcdic-cp-ca
    37,    // ebcdic-cp-wt
    37,    // ebcdic-cp-nl
    37,    // csIBM037

    0,     // IBM038
    0,     // EBCDIC-INT
    0,     // cp038
    0,     // csIBM038

    20273, // IBM273
    20273, // CP273
    20273, // csIBM273

    0,     // IBM274
    0,     // EBCDIC-BE
    0,     // CP274
    0,     // csIBM274

    0,     // IBM275
    0,     // EBCDIC-BR
    0,     // cp275
    0,     // csIBM275

    20277, // IBM277
    20277, // EBCDIC-CP-DK
    20277, // EBCDIC-CP-NO
    20277, // csIBM277

    20278, // IBM278
    20278, // CP278
    20278, // ebcdic-cp-fi
    20278, // ebcdic-cp-se
    20278, // csIBM278

    20280, // IBM280
    20280, // CP280
    20280, // ebcdic-cp-it
    20280, // csIBM280

    0,     // IBM281
    0,     // EBCDIC-JP-E
    0,     // cp281
    0,     // csIBM281

    20284, // IBM284
    20284, // CP284
    20284, // ebcdic-cp-es
    20284, // csIBM284

    20285, // IBM285
    20285, // CP285
    20285, // ebcdic-cp-gb
    20285, // csIBM285

    20290, // IBM290
    20290, // cp290
    20290, // EBCDIC-JP-kana
    20290, // csIBM290

    20297, // IBM297
    20297, // cp297
    20297, // ebcdic-cp-fr
    20297, // csIBM297

    20420, // IBM420
    20420, // cp420
    20420, // ebcdic-cp-ar1
    20420, // csIBM420

    20423, // IBM423
    20423, // cp423
    20423, // ebcdic-cp-gr
    20423, // csIBM423

    20424, // IBM424
    20424, // cp424
    20424, // ebcdic-cp-he
    20424, // csIBM424

    437,   // IBM437
    437,   // cp437
    437,   // 437
    437,   // csPC8CodePage437

    500,   // IBM500
    500,   // CP500
    500,   // ebcdic-cp-be
    500,   // ebcdic-cp-ch
    500,   // csIBM500

    775,   // IBM775
    775,   // cp775
    775,   // csPC775Baltic

    850,   // IBM850
    850,   // cp850
    850,   // 850
    850,   // csPC850Multilingual

    0,     // IBM851
    0,     // cp851
    0,     // 851
    0,     // csIBM851

    852,   // IBM852
    852,   // cp852
    852,   // 852
    852,   // csPCp852

    855,   // IBM855
    855,   // cp855
    855,   // 855
    855,   // csIBM855

    857,   // IBM857
    857,   // cp857
    857,   // 857
    857,   // csIBM857

    860,   // IBM860
    860,   // cp860
    860,   // 860
    860,   // csIBM860

    861,   // IBM861
    861,   // cp861
    861,   // 861
    861,   // cp-is
    861,   // csIBM861

    0,     // IBM862
    0,     // cp862
    0,     // 862
    0,     // csPC862LatinHebrew

    863,   // IBM863
    863,   // cp863
    863,   // 863
    863,   // csIBM863

    864,   // IBM864
    864,   // cp864
    864,   // csIBM864

    865,   // IBM865
    865,   // cp865
    865,   // 865
    865,   // csIBM865

    866,   // IBM866
    866,   // cp866
    866,   // 866
    866,   // csIBM866

    0,     // IBM868
    0,     // CP868
    0,     // cp-ar
    0,     // csIBM868

    869,   // IBM869
    869,   // cp869
    869,   // 869
    869,   // cp-gr
    869,   // csIBM869

    870,   // IBM870
    870,   // CP870
    870,   // ebcdic-cp-roece
    870,   // ebcdic-cp-yu
    870,   // csIBM870

    20871, // IBM871
    20871, // CP871
    20871, // ebcdic-cp-is
    20871, // csIBM871

    20880, // IBM880
    20880, // cp880
    20880, // EBCDIC-Cyrillic
    20880, // csIBM880

    0,     // IBM891
    0,     // cp891
    0,     // csIBM891

    0,     // IBM903
    0,     // cp903
    0,     // csIBM903

    0,     // IBM904
    0,     // cp904
    0,     // 904
    0,     // csIBBM904

    20905, // IBM905
    20905, // CP905
    20905, // ebcdic-cp-tr
    20905, // csIBM905

    0,     // IBM918
    0,     // CP918
    0,     // ebcdic-cp-ar2
    0,     // csIBM918

    1026,  // IBM1026
    1026,  // CP1026
    1026,  // csIBM1026

    0,     // EBCDIC-AT-DE
    0,     // csIBMEBCDICATDE

    0,     // EBCDIC-AT-DE-A
    0,     // csEBCDICATDEA

    0,     // EBCDIC-CA-FR
    0,     // csEBCDICCAFR

    0,     // EBCDIC-DK-NO
    0,     // csEBCDICDKNO

    0,     // EBCDIC-DK-NO-A
    0,     // csEBCDICDKNOA

    0,     // EBCDIC-FI-SE
    0,     // csEBCDICFISE

    0,     // EBCDIC-FI-SE-A
    0,     // csEBCDICFISEA

    0,     // EBCDIC-FR
    0,     // csEBCDICFR

    0,     // EBCDIC-IT
    0,     // csEBCDICIT

    0,     // EBCDIC-PT
    0,     // csEBCDICPT

    0,     // EBCDIC-ES
    0,     // csEBCDICES

    0,     // EBCDIC-ES-A
    0,     // csEBCDICESA

    0,     // EBCDIC-ES-S
    0,     // csEBCDICESS

    0,     // EBCDIC-UK
    0,     // csEBCDICUK

    0,     // EBCDIC-US
    0,     // csEBCDICUS

    0,     // UNKNOWN-8BIT
    0,     // csUnknown8BiT

    0,     // MNEMONIC
    0,     // csMnemonic

    0,     // MNEM
    0,     // csMnem

    0,     // VISCII
    0,     // csVISCII

    0,     // VIQR
    0,     // csVIQR

    20866, // KOI8-R
    20866, // csKOI8R

    21866, // KOI8-U

    858,   // IBM00858
    858,   // CCSID00858
    858,   // CP00858
    858,   // PC-Multilingual-850+euro

    20924, // IBM00924
    20924, // CCSID00924
    20924, // CP00924
    20924, // ebcdic-Latin9--euro

    1140,  // IBM01140
    1140,  // CCSID01140
    1140,  // CP01140
    1140,  // ebcdic-us-37+euro

    1141,  // IBM01141
    1141,  // CCSID01141
    1141,  // CP01141
    1141,  // ebcdic-de-273+euro

    1142,  // IBM01142
    1142,  // CCSID01142
    1142,  // CP01142
    1142,  // ebcdic-dk-277+euro
    1142,  // ebcdic-no-277+euro

    1143,  // IBM01143
    1143,  // CCSID01143
    1143,  // CP01143
    1143,  // ebcdic-fi-278+euro
    1143,  // ebcdic-se-278+euro

    1144,  // IBM01144
    1144,  // CCSID01144
    1144,  // CP01144
    1144,  // ebcdic-it-280+euro

    1145,  // IBM01145
    1145,  // CCSID01145
    1145,  // CP01145
    1145,  // ebcdic-es-284+euro

    1146,  // IBM01146
    1146,  // CCSID01146
    1146,  // CP01146
    1146,  // ebcdic-gb-285+euro

    1147,  // IBM01147
    1147,  // CCSID01147
    1147,  // CP01147
    1147,  // ebcdic-fr-297+euro

    1148,  // IBM01148
    1148,  // CCSID01148
    1148,  // CP01148
    1148,  // ebcdic-international-500+euro

    1149,  // IBM01149
    1149,  // CCSID01149
    1149,  // CP01149
    1149,  // ebcdic-is-871+euro

    0,     // Big5-HKSCS

    1201,  // UTF-16BE

    1200,  // UTF-16LE

    1200,  // UTF-16

    0,     // CESU-8
    0,     // csCESU-8

    12000, // UTF-32

    12001, // UTF-32BE

    12000, // UTF-32LE

    0,     // UNICODE-1-1-UTF-7
    0,     // csUnicode11UTF7

    65001, // UTF-8

    28603, // ISO-8859-13

    0,     // ISO-8859-14
    0,     // iso-ir-199
    0,     // ISO_8859-14:1998
    0,     // ISO_8859-14
    0,     // latin8
    0,     // iso-celtic
    0,     // l8

    28605, // ISO-8859-15
    28605, // ISO_8859-15
    28605, // Latin-9

    0,     // ISO-8859-16
    0,     // iso-ir-226
    0,     // ISO_8859-16:2001
    0,     // ISO_8859-16
    0,     // latin10
    0,     // l10

    936,     // GBK
    936,     // CP936
    936,     // MS936
    936,     // windows-936

    54936, // GB18030

    0,     // JIS_Encoding
    0,     // csJISEncoding

    932,   // Shift_JIS
    932,   // MS_Kanji
    932,   // csShiftJIS

    20932, // EUC-JP [need to verify]
    20932, // Extended_UNIX_Code_Packed_Format_for_Japanese
    20932, // csEUCPkdFmtJapanese

    0,     // Extended_UNIX_Code_Fixed_Width_for_Japanese
    0,     // csEUCFixWidJapanese

    862,   // DOS-862

    874,   // windows-874

    875,   // cp875

    1047,  // IBM01047

    1201,  // unicodeFFFE

    1361,  // Johab

    10001, // x-mac-japanese

    10002, // x-mac-chinesetrad

    10003, // x-mac-korean

    10004, // x-mac-arabic

    10005, // x-mac-hebrew

    10006, // x-mac-greek

    10007, // x-mac-cyrillic

    10008, // x-mac-chinesesimp

    10010, // x-mac-romanian

    10017, // x-mac-ukrainian

    10021, // x-mac-thai

    10029, // x-mac-ce

    10079, // x-mac-icelandic

    10081, // x-mac-turkish

    10082, // x-mac-croatian

    20000, // x-Chinese-CNS

    20001, // x-cp20001

    20002, // x-Chinese-Eten

    20003, // x-cp20003

    20004, // x-cp20004

    20005, // x-cp20005

    20105, // x-IA5

    20106, // x-IA5-German

    20107, // x-IA5-Swedish

    20108, // x-IA5-Norwegian

    20261, // x-cp20261

    20269, // x-cp20269

    20833, // x-EBCDIC-KoreanExtended

    20936, // x-cp20936

    20949, // x-cp20949

    21025, // cp1025

    29001, // x-Europa

    50227, // x-cp50227

    51936, // EUC-CN

    57002, // x-iscii-de

    57003, // x-iscii-be

    57004, // x-iscii-ta

    57005, // x-iscii-te

    57006, // x-iscii-as

    57007, // x-iscii-or

    57008, // x-iscii-ka

    57009, // x-iscii-ma

    57010, // x-iscii-gu

    57011, // x-iscii-pa

    20420, // x-EBCDIC-Arabic

    20880, // x-EBCDIC-CyrillicRussian

    21025, // x-EBCDIC-CyrillicSerbianBulgarian

    20277, // x-EBCDIC-DenmarkNorway

    1142,  // x-ebcdic-denmarknorway-euro

    20278, // x-EBCDIC-FinlandSweden

    1143,  // x-ebcdic-finlandsweden-euro
    1143,  // X-EBCDIC-France

    1147,  // x-ebcdic-france-euro

    20273, // x-EBCDIC-Germany

    1141,  // x-ebcdic-germany-euro

    875,   // x-EBCDIC-GreekModern

    20423, // x-EBCDIC-Greek

    20424, // x-EBCDIC-Hebrew

    20871, // x-EBCDIC-Icelandic

    1149,  // x-ebcdic-icelandic-euro

    1148,  // x-ebcdic-international-euro

    20280, // x-EBCDIC-Italy

    1144,  // x-ebcdic-italy-euro

    50930, // x-EBCDIC-JapaneseAndKana

    50939, // x-EBCDIC-JapaneseAndJapaneseLatin

    50931, // x-EBCDIC-JapaneseAndUSCanada

    20290, // x-EBCDIC-JapaneseKatakana

    50933, // x-EBCDIC-KoreanAndKoreanExtended

    50935, // x-EBCDIC-SimplifiedChinese

    20284, // X-EBCDIC-Spain

    1145,  // x-ebcdic-spain-euro

    20838, // x-EBCDIC-Thai

    50937, // x-EBCDIC-TraditionalChinese

    20905, // x-EBCDIC-Turkish

    20285, // x-EBCDIC-UK

    1146,  // x-ebcdic-uk-euro

    1140,  // x-ebcdic-cp-us-euro

    0,     // OSD_EBCDIC_DF04_15

    0,     // OSD_EBCDIC_DF03_IRV

    0,     // OSD_EBCDIC_DF04_1

    0,     // ISO-11548-1
    0,     // ISO_11548-1
    0,     // ISO_TR_11548-1
    0,     // csISO115481

    0,     // KZ-1048
    0,     // STRK1048-2002
    0,     // RK1048
    0,     // csKZ1048

    0,     // ISO-10646-UCS-2
    0,     // csUnicode

    0,     // ISO-10646-UCS-4
    0,     // csUCS4

    0,     // UNICODE-1-1
    0,     // csUnicode11

    0,     // SCSU

    65000, // UTF-7

    0,     // ISO-10646-UCS-Basic
    0,     // csUnicodeASCII

    0,     // ISO-10646-Unicode-Latin1
    0,     // csUnicodeLatin1
    0,     // ISO-10646

    0,     // ISO-10646-J-1

    0,     // ISO-Unicode-IBM-1261
    0,     // csUnicodeIBM1261

    0,     // ISO-Unicode-IBM-1268
    0,     // csUnicodeIBM1268

    0,     // ISO-Unicode-IBM-1276
    0,     // csUnicodeIBM1276

    0,     // ISO-Unicode-IBM-1264
    0,     // csUnicodeIBM1264

    0,     // ISO-Unicode-IBM-1265
    0,     // csUnicodeIBM1265

    0,     // BOCU-1
    0,     // csBOCU-1

    0,     // ISO-8859-1-Windows-3.0-Latin-1
    0,     // csWindows30Latin1

    0,     // ISO-8859-1-Windows-3.1-Latin-1
    0,     // csWindows31Latin1

    0,     // ISO-8859-2-Windows-Latin-2
    0,     // csWindows31Latin2

    0,     // ISO-8859-9-Windows-Latin-5
    0,     // csWindows31Latin5

    0,     // Adobe-Standard-Encoding
    0,     // csAdobeStandardEncoding

    0,     // Ventura-US
    0,     // csVenturaUS

    0,     // Ventura-International
    0,     // csVenturaInternational

    0,     // PC8-Danish-Norwegian
    0,     // csPC8DanishNorwegian

    0,     // PC8-Turkish
    0,     // csPC8Turkish

    0,     // IBM-Symbols
    0,     // csIBMSymbols

    20838, // IBM-Thai
    20838, // csIBMThai

    0,     // HP-Legal
    0,     // csHPLegal

    0,     // HP-Pi-font
    0,     // csHPPiFont

    0,     // HP-Math8
    0,     // csHPMath8

    0,     // Adobe-Symbol-Encoding
    0,     // csHPPSMath

    0,     // HP-DeskTop
    0,     // csHPDesktop

    0,     // Ventura-Math
    0,     // csVenturaMath

    0,     // Microsoft-Publishing
    0,     // csMicrosoftPublishing

    0,     // Windows-31J
    0,     // csWindows31J

    936,   // GB2312
    936,   // csGB2312

    950,   // Big5
    950,   // csBig5

    52936, // HZ-GB-2312

    0,     // IBM1047
    0,     // IBM-1047

    0,     // PTCP154
    0,     // csPTCP154
    0,     // PT154
    0,     // CP154
    0,     // Cyrillic-Asian

    0,     // Amiga-1251
    0,     // Ami1251
    0,     // Amiga1251
    0,     // Ami-1251

    0,     // KOI7-switched

    0,     // BRF
    0,     // csBRF

    0,     // TSCII
    0,     // csTSCII

    1250,  // windows-1250

    1251,  // windows-1251

    1252,  // windows-1252

    1253,  // windows-1253

    1254,  // windows-1254

    1255,  // windows-1255

    1256,  // windows-1256

    1257,  // windows-1257

    1258,  // windows-1258

    0,     // TIS-620

    720,   // DOS-720

    737    // ibm737

  );

function CharsetToCodePage(const ACharSet: TIdCharSet): Word;
begin
  Result := IdCharsetCodePages[ACharSet];

  // TODO: on Windows, utilize the following Registry keys for additional lookups:
  //
  // HKEY_CLASSES_ROOT\Mime\Database\Codepage
  // HKEY_CLASSES_ROOT\Mime\Database\Charset
  //
  // Except, there may be some inaccuracies in it.  For example, "iso-8859-1"
  // gets mapped to codepage 1252 instead of the more preferred 28591...

  {
  if Result = 0 then
  begin
    ...
  end;
  }
end;

function CharsetToCodePage(const ACharSet: String): Word; overload;
begin
  Result := IdCharsetCodePages[FindCharset(ACharSet)];

  // TODO: on Windows, utilize the following Registry keys for additional lookups:
  //
  // HKEY_CLASSES_ROOT\Mime\Database\Codepage
  // HKEY_CLASSES_ROOT\Mime\Database\Charset
  //
  // Except, there may be some inaccuracies in it.  For example, "iso-8859-1"
  // gets mapped to codepage 1252 instead of the more preferred 28591...

  {
  if Result = 0 then
  begin
    ...
  end;
  }
end;

end.
