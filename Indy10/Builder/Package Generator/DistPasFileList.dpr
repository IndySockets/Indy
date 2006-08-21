program DistPasFileList;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  DModule in 'DModule.pas' {DM: TDataModule};

procedure Main;
var s : TStringList;
  Lst : String;
begin
 DM := TDM.Create(nil); try
    s := TStringList.Create;
    try
      // Default Output Path is w:\source\Indy10
      DM.OutputPath := 'w:\source\Indy10';
      // Default Data Path is W:\source\Indy10\builder\Package Generator\Data
      DM.DataPath   := 'W:\source\Indy10\builder\Package Generator\Data';
      DM.tablFile.Open;
      try
        while not DM.tablFile.Eof do
        begin
          LSt := DM.tablFile.FieldByName('Pkg').AsString+'\' + DM.tablFile.FieldByName('FileName').AsString+'.pas';
          //This is a temporary hack.  In the FPC view, IdCompressorZLibEx is renamed to IdCompressorZLib
          //because that's no longer based on the ZLibEx package.  I did not merge this back because
          //there would be code breakage and I did not want to break code in a minor version.
          if LSt = 'Protocols\IdCompressorZLib.pas' then
          begin
            LSt := 'Protocols\IdCompressorZLibEx.pas';
          end;
          s.Add(LSt);
          WriteLn(LSt);
          DM.tablFile.Next;
        end;
        s.SaveToFile('w:\source\Indy10\Lib\FileList.txt');
      finally
        DM.tablFile.Close;
      end;
    finally
      FreeAndNil(s);
    end;
  finally FreeAndNil(DM); end;
end;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  Main;
end.
