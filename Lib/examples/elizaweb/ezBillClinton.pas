{ $HDR$}
{**********************************************************************
 Unit archived using Team Coherence                                   
 Team Coherence is Copyright 2002 by Quality Software Components      
                                                                      
 For further information / comments, visit our WEB site at            
 http://www.TeamCoherence.com                                         
**********************************************************************

 $Log:  21824: EZBillClinton.pas 

   Rev 1.0    2003.07.13 12:12:00 AM  czhower
 Initial checkin


   Rev 1.0    2003.05.19 2:54:10 PM  czhower
}
unit ezBillClinton;

interface
{$ifdef fpc}
  {$mode objfpc}{$H+}
{$endif}
uses
  EZPersonality;

type
  TPersonalityBillClinton = class(TEZPersonality)
  protected
    procedure InitReplies; override;
  public
    class function Attributes: TEZPersonalityAttributes; override;
  end;

implementation

{ TPersonalityBillClinton }

class function TPersonalityBillClinton.Attributes: TEZPersonalityAttributes;
begin
  with Result do begin
    Name := 'Bill Clinton';
    Description := 'Slick Willy himself';
  end;
end;

procedure TPersonalityBillClinton.InitReplies;
begin
// Paula
  AddReply([' sex '], [
   'That is a personal subject and not appropriate for a president to speak about.'
   , 'This is between Hillary and I.'
   ], [
   '',
   'Laugh'
   ]);
  AddReply([' defensive '], [
   'I am not being defensive.'
   , 'Why are you picking on me?'
   ]);
  AddReply([' Monica '], [
   'She was a fine intern.'
   , 'I would recommend her to future presidents for work in the oval office as well.'
   , 'I am sorry but I cannot violate her client privelege confidentiality.'
   , 'That has been classified as a state secret.'
   , 'Did you hear the one about the quail, the bush and the tree?'
   ], [
   '',
   'OhYeah'
   ]);
  AddReply([' whitewater '], [
   'I do not know about that.'
   , 'That was Hillary''s investment not mine.'
   , 'I was not involved in that, you should speak to my wife.'
   ]);
  AddReply([' Jennifer '], [
   'That is old news.'
   , 'Why do you insist on bringing up old issues?'
   ]);
  AddReply([' Hillary '], [
   'Hillary is not on trial here.'
   , 'What Hillary does is her business.'
   ]);
  AddReply([' Big Mac'], [
   'Oh yeah. I like them.'
   ], [
   'INeedFood'
   ]);
  AddReply(['--NOKEYFOUND--'], [
   'I am trying my hardest. But I do not understand what you are asking me.'
   , 'I must consult with my lawyer before speaking on this.'
   , 'I plead the fifth ammendment.'
   , 'I choose not to answer that question on advise from my lawyer'
   ]);
end;

initialization
  TPersonalityBillClinton.RegisterPersonality;
end.
