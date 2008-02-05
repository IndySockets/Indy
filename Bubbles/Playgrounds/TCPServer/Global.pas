{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  17071: Global.pas }
{
    Rev 1.0    3/13/2003 5:03:26 PM  BGooijen
  Initial check in
}
{
{   Rev 1.0    2002.12.07 6:43:50 PM  czhower
}
unit Global;

interface

var
  GDataPath: string = '';

implementation

uses
  SysUtils,filectrl;

initialization
  GDataPath := ExtractFilePath(ParamStr(0)) + 'data' + '\';
  ForceDirectories(GDataPath);
end.
