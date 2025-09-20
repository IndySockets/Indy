{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{
 $Log:  21830: EZIFM.pas 

   Rev 1.0    2003.07.13 12:12:02 AM  czhower
 Initial checkin


   Rev 1.0    2003.05.19 3:47:44 PM  czhower


   Rev 1.0    2003.05.19 2:54:10 PM  czhower
}
unit ezIFM;

interface
{$mode objfpc}{$H+}

uses
  EZPersonality;

type
  TPersonalityIFM = class(TEZPersonality)
  protected
    procedure InitReplies; override;
  public
    class function Attributes: TEZPersonalityAttributes; override;
  end;

implementation

{ TPersonalityIFM }

class function TPersonalityIFM.Attributes: TEZPersonalityAttributes;
begin
  with Result do begin
    Name := 'Iraq Foreign Minister';
    Description := 'I deny nothing!';
  end;
end;

procedure TPersonalityIFM.InitReplies;
begin

(*
"because we will behead you all"
"These cowards have no morals. They have no shame about lying"
"We will slaughter them, Bush Jr. and his international gang of bastards!"
"They are like a snake and we are going to cut it in pieces."

"They do not even have control over themselves! Do not believe them!"
"They will be burnt. We are going to tackle them"

"We blocked them inside the city. Their rear is blocked"

"Desperate Americans"
"They want to deceive their people first because now they are in a very shabby situation."
"It's a small town [Umm Qasar], it has only a few docks... now they are in a trap"

"Iraqi forces are still in control of the city, and they are engaging in an attrition war with the enemy"
"Americans are now in disarray"
"Iraq will spread them even more and chop them up."

*)

  AddReply([' airport '], [
   'Today we slaughtered them in the airport. They are out of Saddam International Airport.'
   , 'The force that was in the airport, this force was destroyed..'
   , 'At Saddam Airport? Now that''''s just silly!.'
   , 'We went into the airport and crushed them, we cleaned the WHOOOLE place out, they were slaughtered.'
   , 'They are nowhere near the airport ..they are lost in the desert...they can not read a compass...they are retarded.'
   ]);

  AddReply([' surrender ', ' prisoners '], [
   'Those are not Iraqi soldiers at all. Where did they bring them from?'
   ]);

  AddReply([' george ', ' bush '], [
   'Bush, this man is a war criminal, and we will see that he is brought to trial.'
   , 'The leader of the international criminal gang of bastards.'
   , 'The insane little dwarf Bush.'
   , 'Bush is a very stupid man. The American people are not stupid, they are very clever. I can''''t understand how such clever people came to elect such a stupid president.'
   , 'Bush doesn''''t even know if Spain is a republic or a kingdom, how can they follow this man?'
   , 'Bush, Blair and Rumsfeld. They are the funny trio.'
   , 'This criminal in the White House is a stupid criminal.'
   ]);

  AddReply([' tony ', ' blair ', ' britain ', ' uk ', ' british '], [
   'Bush, Blair and Rumsfeld. They are the funny trio.'
   , 'Britain is not worth an old shoe.'
   , 'I think the British nation has never been faced with a tragedy like this fellow Blair.'
   ]);

  AddReply([' american ', ' americans ', ' troops ', ' soldiers '], [
   'They are again in the dirt in the desert.'
   , 'We besieged them and killed most of them, and I think we will finish them soon.'
   , 'Their casualties and bodies are many.'
   , 'We feed them death and hell!'
   , 'Let the American infidels bask in their illusion.'
   , 'We have given them a sour taste.'
   , 'They are most welcome. We will butcher them..'
   , 'We will welcome them with bullets and shoes.'
   , 'We have placed them in a quagmire from which they can never emerge except dead.'
   , 'Washington has thrown their soldiers on the fire.'
   , 'We will kill them all........most of them..'
   ]);

  AddReply([' tommy ', ' franks '], [
   'Who is this dog Franks in Qatar?'
   , 'Idiot.'
   ]);

  AddReply([' you '], [
   'What do I have to do with this?'
   , 'Why ask me?'
   , 'You should ask yourself that question!'
   ]);

  AddReply([' your '], [
   'I don''''t know anything about any *'
   , 'What *'
   ]);

  AddReply([' helicoptor ', ' helicoptors '], [
   'We have destroyed 2 tanks, fighter planes, 2 helicopters and their shovels - We have driven them back.'
   , 'Our farmers, they are targeting accurately the enemy.'
   ]);

  AddReply([' un ', ' united nations '], [
   'The United Nations is a place for prostitution under the feet of Americans.'
   ]);

  AddReply([' donald ', ' rumsfield '], [
   'The midget Bush and that Rumsfield deserve only to be beaten with shoes by freedom loving people everywhere.'
   , 'Rumsfeld, he needs to be hit on the head.'
   , 'Yesterday we heard this villain called Rumsfeld. He, of course, is a war criminal.'
   , 'Bush, Blair and Rumsfeld. They are the funny trio.'
   , 'Rumsfeld is a crook and the most despicable creature.'
   , 'Rumsfeld is the worst kind of bastard.'
   ]);

  AddReply([' feel ', ' think '], [
   'My feelings - as usual - we will slaughter them all.'
   , 'Our initial assessment is that they will all die.'
   , 'God will roast their stomachs in hell at the hands of Iraqis.'
   ]);

  AddReply([' scared '], [
   'No I am not scared, and neither should you be!.'
   ]);

  AddReply([' baghdad '], [
   'There are no American infidels in Baghdad. Never!'
   , 'Be assured. Baghdad is safe, protected.'
   , 'We will see how the issue will turn out when they come to Baghdad.'
   , 'I triple guarantee you, there are no American soldiers in Baghdad.'
   , 'They''''re not even within 100 miles.'
   , 'They are nowhere near Baghdad. Their allegations are a cover-up for their failure.'
   , 'They will try to enter Baghdad, and I think this is where their graveyard will be.'
   , 'Their objective is to get to the outskirts of Baghdad. So be it.'
   ]);

  AddReply([' tanks ', ' tank '], [
   'We have them surrounded in their tanks.'
   , 'They''''re coming to surrender or be burned in their tanks.'
   , 'We have destroyed 2 tanks, fighter planes, 2 helicopters and their shovels - We have driven them back.'
   , 'There are only two American tanks in the city.'
   ]);

  AddReply([' television ', ' media ', ' newspaper ', ' press '], [
   'I blame Al-Jazeera - they are marketing for the Americans!'
   , 'The American press is all about lies! All they tell is lies, lies and more lies!'
   ]);

  AddReply(['--NOKEYFOUND--'], [
   'I speak better English than this villain Bush.'
   , 'We are winning!'
   , 'Blood-sucking bastards.'
   , 'This is unbased.'
   , 'The louts of colonialism.'
   , 'I will only answer reasonable questions.'
   , 'Don''''t believe anything! We will chase the rascals back to London!'
   ]);
end;

initialization
  TPersonalityIFM.RegisterPersonality;
end.
