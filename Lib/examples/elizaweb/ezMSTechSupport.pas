{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{
 $Log:  21832: EZMSTechSupport.pas 

   Rev 1.0    2003.07.13 12:12:04 AM  czhower
 Initial checkin


   Rev 1.0    2003.05.19 2:54:20 PM  czhower
}
unit ezMSTechSupport;

interface
{$ifdef fpc}
{$mode objfpc}{$H+}
{$endif}
uses
  EZPersonality;

type
  TPersonalityMSTechSupport = class(TEZPersonality)
  protected
    procedure InitReplies; override;
  public
    class function Attributes: TEZPersonalityAttributes; override;
  end;

implementation

{ TPersonalityMSTechSupport }

class function TPersonalityMSTechSupport.Attributes: TEZPersonalityAttributes;
begin
  with Result do begin
    Name := 'Microsoft Technical Support';
    Description := 'Dont pay $5 a minute, get the SAME level of suppor for'
     + ' free!';
  end;
end;

procedure TPersonalityMSTechSupport.InitReplies;
begin
  AddReply([' My problem is ', ' The problem is '], [
   'So you are calling about *?'
   , 'Is * a problem?'
   ]);
  AddReply([' crashes when I ', ' crashes when ', ' crashing when '], [
   'The obvious answer would be not to *'
   , 'You are just asking for trouble.'
   ]);
  AddReply([' bug '], [
   'Are you sure thats a bug?'
   , 'Thats not a bug, its a feature.'
   ]);
  AddReply([' AV ', ' AVs ', ' Access violation ', ' crash ', ' BSOD '], [
   'I am sorry but I cannot reproduce that problem here.'
   , 'It works fine here. The problem must be on your end.'
   , 'Hmm. I have never heard of a problem like that.'
   , 'Have you tried rebooting your system?'
   , 'Do you have all the service packs installed?'
   ]);
  AddReply([' Borland ', ' Delphi '], [
   'Is Borland still around?'
   , 'The problem is probably with the Borland product. You should contact Borland.'
   , 'I am sorry but we do not support Borland products.'
   ]);
  AddReply(['--NOKEYFOUND--'], [
   'I will need more information.'
   , 'I will need to ask my supervisor for help.'
   ]);
end;

initialization
  TPersonalityMSTechSupport.RegisterPersonality;
end.
