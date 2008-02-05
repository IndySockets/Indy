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
  Rev 1.2    2004.02.03 5:44:46 PM  czhower
  Name changes

  Rev 1.1    10/17/2003 12:06:16 AM  DSiders
  Added localization comments.

  Rev 1.0    11/13/2002 08:30:10 AM  JPMugaas
  Initial import from FTP VC.
}

unit IdGopherConsts;

{*******************************************************}
{                                                       }
{       Indy IdGopherConsts - this just contains        }
{         Constants used for writing Gopher servers     }
{         and clients                                   }
{                                                       }
{       Copyright (C) 2000 Winshoes Working Group       }
{       Original author: Pete Mee and moved to          }
{       this unit by J. Peter Mugaas                    }
{       2000-April-23                                   }
{                                                       }
{*******************************************************}

interface
{$i IdCompilerDefines.inc}

uses
  IdGlobal;

Const
  {Item constants - comments taken from RFC}
  IdGopherItem_Document = '0'; // Item is a file
  IdGopherItem_Directory = '1'; // Item is a directory
  IdGopherItem_CSO = '2'; // Item is a CSO phone-book server
  IdGopherItem_Error = '3';  // Error
  IdGopherItem_BinHex = '4'; // Item is a BinHexed Macintosh file.
  IdGopherItem_BinDOS = '5'; // Item is DOS binary archive of some sort.
    // Client must read until the TCP connection closes.  Beware.
  IdGopherItem_UUE = '6'; // Item is a UNIX uuencoded file.
  IdGopherItem_Search = '7'; // Item is an Index-Search server.
  IdGopherItem_Telnet = '8'; // Item points to a text-based telnet session.
  IdGopherItem_Binary = '9'; // Item is a binary file.
    // Client must read until the TCP connection closes.  Beware.
  IdGopherItem_Redundant = '+'; // Item is a redundant server
  IdGopherItem_TN3270 = 'T'; // Item points to a text-based tn3270 session.
  IdGopherItem_GIF = 'g'; // Item is a GIF format graphics file.
  IdGopherItem_Image = ':'; // Item is some kind of image file.
    // Client decides how to display.  Was 'I', but depracted
  IdGopherItem_Image2 = 'I'; //Item is some kind of image file -
    // this was drepreciated

  {Items discovered outside of Gopher RFC - "Gopher+"}
  IdGopherItem_Sound = '<';  //Was 'S', but deprecated
  IdGopherItem_Sound2 = 'S'; //This was depreciated but should be used with clients
  IdGopherItem_Movie = ';';  //Was 'M', but deprecated
  IdGopherItem_HTML = 'h';
  IdGopherItem_MIME = 'M'; //See above for a potential conflict with Movie
  IdGopherItem_Information = 'i'; // Not a file - just information

  IdGopherPlusIndicator = IdGopherItem_Redundant; // Observant people will note
    // the conflict here...!
  IdGopherPlusInformation = '!'; // Formatted information
  IdGopherPlusDirectoryInformation = '$';

  //Gopher+ additional information
  IdGopherPlusInfo = '+INFO: '; {do not localize}
  { Info format is the standard Gopher directory entry + TAB + '+'.
    The info is contained on the same line as the '+INFO: '}
  IdGopherPlusAdmin = '+ADMIN:' + EOL;  {do not localize}
  { Admin block required for every item.  The '+ADMIN:' occurs on a
    line of it's own (starting with a space) and is followed by
    the fields - one per line.

    Required fields:
    ' Admin: ' [+ comments] + '<' + admin e-mail address + '>'
    ' ModDate: ' [+ comments] + '<' + dateformat:YYYYMMDDhhnnss + '>'

    Optional fields regardless of location:
    ' Score: ' + relevance-ranking
    ' Score-range: ' + lower-bound  + ' ' + upper-bound

    Optional fields recommended at the root only:
    ' Site: ' + site-name
    ' Org: ' + organization-description
    ' Loc: ' + city + ', ' + state + ', ' + country
    ' Geog: ' + latitude + ' ' + longitude
    ' TZ: ' + GMT-offset

    Additional recorded possibilities:
    ' Provider: ' + item-provider-name
    ' Author: ' + author
    ' Creation-Date: ' + '<' + YYYYMMDDhhnnss + '>'
    ' Expiration-Date: ' + '<' + YYYYMMDDhhnnss + '>'
    }
  IdGopherPlusViews = '+VIEWS:' + EOL;  {do not localize}
  { View formats are one per line:
    ' ' + mime/type [+ langcode] + ': <' + size estimate + '>'
    ' ' + logcode = ' ' + ISO-639-Code + '_' + ISO-3166-Code
  }
  IdGopherPlusAbstract = '+ABSTRACT:' + EOL;  {do not localize}
  { Is followed by a (multi-)line description.  Line(s) begin with
    a space.}
  IdGopherPlusAsk = '+ASK:';  {do not localize}

  //Questions for +ASK section:
  IdGopherPlusAskPassword = 'AskP: '; {do not localize}
  IdGopherPlusAskLong = 'AskL: ';     {do not localize}
  IdGopherPlusAskFileName = 'AskF: '; {do not localize}

  // Prompted responses for +ASK section:

  // Multi-choice, multi-selection
  IdGopherPlusSelect = 'Select: ';      {do not localize}
  // Multi-choice, single-selection
  IdGopherPlusChoose = 'Choose: ';      {do not localize}
  //Multi-choice, single-selection
  IdGopherPlusChooseFile = 'ChooseF: '; {do not localize}

  //Known response types:
  IdGopherPlusData_BeginSign = '+-1' + EOL;
  IdGopherPlusData_EndSign = EOL + '.' + EOL;
  IdGopherPlusData_UnknownSize = '+-2' + EOL;
  IdGopherPlusData_ErrorBeginSign = '--1' + EOL;
  IdGopherPlusData_ErrorUnknownSize = '--2' + EOL;
  IdGopherPlusError_NotAvailable = '1';
  IdGopherPlusError_TryLater = '2';
  IdGopherPlusError_ItemMoved = '3';

implementation

end.
