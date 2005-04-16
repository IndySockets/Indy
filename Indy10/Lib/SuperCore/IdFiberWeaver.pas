{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  56068: IdFiberWeaver.pas 
{
{   Rev 1.0    2004.02.03 12:38:50 AM  czhower
{ Move
}
{
{   Rev 1.0    2003.10.19 2:50:54 PM  czhower
{ Fiber cleanup
}
unit IdFiberWeaver;

interface

uses
  IdBaseComponent, IdFiber,
  Windows;

type
  TIdFiberWeaver = class(TIdBaseComponent)
  protected
    procedure Relinquish(
      AFiber: TIdFiber;
      AReschedule: Boolean
      ); virtual; abstract;
  public
    procedure Add(
      AFiber: TIdFiber
      ); virtual; abstract;
    function WaitForFibers(
      ATimeout: Cardinal = Infinite
      ): Boolean;
      virtual; abstract;
  end;

implementation

end.
