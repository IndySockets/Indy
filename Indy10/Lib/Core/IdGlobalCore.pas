{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  108470: IdGlobalCore.pas 
{
{   Rev 1.2    8/16/2004 1:08:46 PM  JPMugaas
{ Failed to compile in some IDE's.
}
{
{   Rev 1.1    2004.08.13 21:46:20  czhower
{ Fix for .NET
}
{
{   Rev 1.0    2004.08.13 10:54:58  czhower
{ Initial checkin
}
unit IdGlobalCore;

interface

uses
  Classes,
  IdGlobal;

{$I IdCompilerDefines.inc}
const
  {$IFDEF MSWINDOWS}
  tpListener = tpHighest;
  {$ENDIF}
  {$IFDEF DotNet}
  tpListener = tpHighest;
  {$ENDIF}
  {$IFDEF Linux}
  tpListener = tpNormal;
  {$ENDIF}

implementation

end.
