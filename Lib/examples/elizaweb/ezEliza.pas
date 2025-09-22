{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{
 $Log:  21826: EZEliza.pas 

   Rev 1.0    2003.07.13 12:12:00 AM  czhower
 Initial checkin


   Rev 1.0    2003.05.19 2:54:14 PM  czhower
}
unit ezEliza;

interface
{$ifdef fpc}
  {$mode objfpc}{$H+}
{$endif}
uses
  EZPersonality;

type
  TPersonalityEliza = class(TEZPersonality)
  protected
    procedure InitReplies; override;
  public
    class function Attributes: TEZPersonalityAttributes; override;
  end;

implementation

{ TPersonalityEliza }

class function TPersonalityEliza.Attributes: TEZPersonalityAttributes;
begin
  with Result do begin
    Name := 'Eliza';
    Description := 'Original Eliza implementation.';
  end;    
end;

procedure TPersonalityEliza.InitReplies;
begin
  // These are parsed in order - first one wins
  // If no space before, it can be the end of a word
  // If no space on either side, can be the middle of word
  AddReply([' CAN YOU '], [
   'Don''t you believe that I can *?'
   , 'Perhaps you would like to be like me.'
   , 'You want me to be able to *?'
   ]);
  AddReply([' CAN I '], [
    'Perhaps you don''t want to *?'
    , 'Do you want to be able to *?'
   ]);
  AddReply([' YOU ARE ', ' YOU''RE '], [
   'What makes you think I am *?'
   , 'Does it please you to believe I am *?'
   , 'Perhaps you would like to be", *?'
   , 'Do you sometimes wish you were *?'
   ]);
  AddReply(['I DON''T '], [
   'don''t you really *?'
   , 'Why don''t you *?'
   , 'Do you wish to be able to *?'
   , 'Does that trouble you?'
   ]);
  AddReply(['I FEEL '], [
   'Do you often feel *?'
   , 'Do you enjoy feeling *?'
   ]);
  AddReply(['WHY DON''T YOU '], [
   'Do you really believe I don''t *?'
   , 'Perhaps in good time I will", *?'
   , 'Do you want me to *?'
   ]);
  AddReply(['WHY CAN''T I '], [
   'Do you think you should be able to *?'
   , 'Why can''t you *?'
   ]);
  AddReply(['ARE YOU '], [
   'Why are you interested in whether or not I am *?'
   , 'Would you prefer if I were not *?'
   , 'Perhaps in your fantasies I am", *?'
   ]);
  AddReply(['I CAN''T ', 'I CANNOT', 'I CAN NOT'], [
   'How do you know you can''t *?'
   , 'Have you tried?'
   , 'Perhaps you can now *.'
   ]);
  AddReply(['I AM ', 'I''M'], [
   'Did you come to me because you are *?'
   , 'How long have you been *?'
   , 'Do you believe it is normal to be *?'
   , 'Do you enjoy being *?'
   ]);
  AddReply(['YOU '], [
   'We were discussing you--not me.'
   , 'Oh, I ?'
   , 'You''re not really talking about me, are you?'
   ]);
  AddReply(['I WANT '], [
   'What would it mean to you if you got *?'
   , 'Why do you want *?'
   , 'Suppose you soon got *?'
   , 'What if you never got *?'
   , 'I sometimes also want *?'
   ]);
  AddReply(['WHAT ', 'HOW ', 'WHO ', 'WHERE ', 'WHEN ', 'WHY '], [
   'Why do you ask?'
   , 'Does that question interest you?'
   , 'What answer would please you the most?'
   , 'What do you think?'
   , 'Are such questions on your mind often?'
   , 'What is it that you really want to know?'
   , 'Have you asked anyone else?'
   , 'Have you asked such questions before?'
   , 'What else comes to mind when you ask that?'
   ]);
  AddReply(['NAME '], [
   'Names don''t interest me.'
   , 'I don''t care about names --please go on.'
   ]);
  AddReply(['CAUSE '], [
   'Is that the real reason?'
   , 'don''t any other reasons come to mind?'
   , 'Does that reason explain anything else?'
   , 'What other reasons might there be?'
   ]);
  AddReply(['SORRY '], [
   'Please don''t apologize!'
   , 'Apologies are not necessary.'
   , 'What feelings do you have when you apologize?'
   , 'don''t be so defensive!'
   ]);
  AddReply(['DREAM '], [
   'What does that dream suggest to you?'
   , 'Do you dream often?'
   , 'What persons appear in your dreams?'
   , 'Are you disturbed by your dreams?'
   ]);
  AddReply(['HELLO ', 'HI '], [
   'How do you do ...please state your problem.'
   ]);
  AddReply(['MAYBE '], [
   'You don''t seem quite certain.'
   , 'Why the uncertain tone?'
   , 'can''t you be more positive?'
   , 'You aren''t sure?'
   , 'don''t you know?'
   ]);
  AddReply(['NO '], [
   'Are you saying no just to be negative?'
   , 'You are being a bit negative.'
   , 'Why not?'
   , 'Are you sure?'
   , 'Why no?'
   ]);
  AddReply(['YOUR '], [
   'Why are you concerned about my *?'
   , 'What about your own *?'
   ]);
  AddReply(['ALWAYS '], [
   'Can you think of a specific example?'
   , 'When?'
   , 'What are you thinking of?'
   , 'Really, always?'
   ]);
  AddReply(['THINK '], [
   'Do you really think so?'
   , 'But you are not sure you, *?'
   , 'Do you doubt you *?'
   ]);
  AddReply(['ALIKE '], [
   'In what way?'
   , 'What resemblance do you see?'
   , 'What does the similarity suggest to you?'
   , 'What other connections do you see?'
   , 'Could there really be some connection?'
   , 'How?'
   , 'You seem quite positive.'
   ]);
  AddReply(['YES '], [
   'Are you sure?'
   , 'I see.'
   , 'I understand.'
   ]);
  AddReply(['FRIEND '], [
   'Why do you bring up the topic of friends?'
   , 'Do your friends worry you?'
   , 'Do your friends pick on you?'
   , 'Are you sure you have any friends?'
   , 'Do you impose on your friends?'
   , 'Perhaps your love for friends worries you.'
   ]);
  AddReply(['COMPUTER'], [
   'Do computers worry you?'
   , 'Are you talking about me in particular?'
   , 'Are you frightened by machines?'
   , 'Why do you mention computers?'
   , 'What do you think machines have to do with your problem?'
   , 'don''t you think computers can help people?'
   , 'What is it about machines that worries you?'
   ]);
  AddReply(['--NOKEYFOUND--'], [
   'Say, do you have any psychological problems?'
   , 'What does that suggest to you?'
   , 'I see.'
   , 'I''m not sure I understand you fully.'
   , 'Come come elucidate your thoughts.'
   , 'Can you elaborate on that?'
   , 'That is quite interesting.'
   ]);
end;

initialization
  TPersonalityEliza.RegisterPersonality;
end.
