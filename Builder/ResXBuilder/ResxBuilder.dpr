{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  109240: ResxBuilder.dpr 
{
{   Rev 1.1    9/8/2004 10:11:16 PM  JPMugaas
{ Now also generates the .resources for the Protocols design-time package in
{ DotNET.
}
{
{   Rev 1.0    9/8/2004 5:56:58 AM  JPMugaas
{ Builder program for .resources files.  You can NOT use a standard resource
{ compiler.  You have to use a DotNET ResourceWriter class.
}
program ResxBuilder;

{$APPTYPE CONSOLE}

{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Drawing.dll'}

uses
  System.Drawing,
  System.Resources;

var
  RW : System.Resources.ResourceWriter;
  Bmp1, Bmp2, bmp3, bmp4 : System.Drawing.Bitmap;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  RW := System.Resources.ResourceWriter.Create('w:\source\Indy10\Lib\Core\IdCreditsBitmap.resources');
  try
    Bmp1 := System.Drawing.Bitmap.Create('w:\source\Indy10\Lib\Core\Res\TIDABOUTPICTURE.BMP');
    Bmp2 := System.Drawing.Bitmap.Create('w:\source\Indy10\Lib\Core\Res\Sink.bmp');
    try

      RW.AddResource('TIDABOUTPICTURE',Bmp1);

      RW.AddResource('TIDKITCHENSINK',Bmp2);
      RW.Generate;
      RW.Close;

    finally
      bmp1.Dispose;
      bmp2.Dispose;
    end;
  finally
    RW.Dispose;
  end;
  RW := System.Resources.ResourceWriter.Create('w:\source\Indy10\Lib\Protocols\IdSASLListEditorForm.resources');
  try
    Bmp1 := System.Drawing.Bitmap.Create('w:\source\Indy10\Lib\Protocols\Res\ARROWDOWN.bmp');
    Bmp2 := System.Drawing.Bitmap.Create('w:\source\Indy10\Lib\Protocols\Res\ARROWLEFT.bmp');
    Bmp3 := System.Drawing.Bitmap.Create('w:\source\Indy10\Lib\Protocols\Res\ARROWRIGHT.bmp');
    Bmp4 := System.Drawing.Bitmap.Create('w:\source\Indy10\Lib\Protocols\Res\ARROWUP.bmp');
    try
       RW.AddResource('ARROWDOWN',Bmp1);

      RW.AddResource('ARROWLEFT',Bmp2);
      RW.AddResource('ARROWRIGHT',bmp3);
      RW.AddResource('ARROWUP',bmp4);
      RW.Generate;
      RW.Close;
    finally
      bmp1.Dispose;
      bmp2.Dispose;
      bmp3.Dispose;
      bmp4.Dispose;
    end;

  finally
    RW.Dispose;
  end;
end.
