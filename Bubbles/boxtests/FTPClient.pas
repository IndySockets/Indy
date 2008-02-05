{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11247: FTPClient.pas 
{
{   Rev 1.0    11/12/2002 09:17:40 PM  JPMugaas
{ Initial check in.  Import from FTP VC.
}
unit FTPClient;

interface

uses
  IndyBox;

type
  TFTPClient = class(TIndyBox)
  public
    procedure Test; override;
    procedure FTP(const APassive: Boolean);
  end;

implementation

uses
  Classes,
  IdGlobal, IdFTP,
  SysUtils;

const
  ParamHost = 'ftp.nevrona.com';
  ParamUser = 'FTPTest';
  ParamPassword = 'FTPTest';

{ TFTPClient }

procedure TFTPClient.Test;
begin
  Status('Testing Passive.');
  FTP(True);
  Status('Testing Active.');
  FTP(False);
end;

procedure TFTPClient.FTP(const APassive: Boolean);
var
  i: Integer;
  LDirList: TStringList;
  LRecvData: string;
  LRecvStream: TMemoryStream;
  LSrcData: string;
  LSrcStream: TMemoryStream;
  LUsername, LPassword, LHost : String;
begin
  LSrcStream := TMemoryStream.Create; try
    // Fill Source Stream
    SetLength(LSrcData, 256);
    for i := 0 to 255 do begin
      LSrcData[i + 1] := Chr(i);
    end;
    LSrcStream.WriteBuffer(LSrcData[1], Length(LSrcData));
    LSrcStream.Position := 0;
    //
    with TIdFTP.Create(nil) do try
      Passive := APassive;
      LHost := Trim(GlobalParamValue('FTP Server'));
      LUsername := Trim(GlobalParamValue('FTP Username'));
      LPassword := Trim(GlobalParamValue('FTP Password'));
      if Length(LHost) = 0 then
      begin
        LHost := ParamHost;
        LUsername := ParamUser;
        LPassword := ParamPassword;
      end;

      Host := LHost;
      Username := LUsername;
      Password := LPassword;
      Connect; try
        // Check GET and PUT
        Self.Status('Testing PUT');
        Put(LSrcStream, 'IndyTest.dat');
        Self.Status('Testing GET');
        LRecvStream := TMemoryStream.Create; try
          Get('IndyTest.dat', LRecvStream);
          LRecvStream.Position := 0;
          SetLength(LRecvData, LRecvStream.Size);
          LRecvStream.ReadBuffer(LRecvData[1], Length(LRecvData));
        finally FreeAndNil(LRecvStream); end;
        Check(SameText(LSrcData, LRecvData), 'Files do not match');
        // Check Rename function
        Self.Status('Testing Rename');
        Rename('IndyTest.dat', 'IndyTestRenamed.dat');
         // Clean up file
        Self.Status('Testing Delete');
        Delete('IndyTestRenamed.dat');
        // Make sure that GET on a non-existant file does in fact fail
        try
          Self.Status('Testing GET of non existant file');
          Get('FakeFile.dat', LRecvStream);
          Check(False, 'Exception expected.');
        except end;
        // Dir Functions
        Self.Status('Testing Directory functions');
        MakeDir('EmptyTestDir');
        ChangeDir('EmptyTestDir');
        LDirList := TStringList.Create; try
          List(LDirList);
        finally FreeAndNil(LDirList); end;
        ChangeDir('..');
        RemoveDir('EmptyTestDir');
      finally Disconnect; end;
    finally Free; end;
  finally FreeAndNil(LSrcStream); end;
end;

initialization
  TIndyBox.RegisterBox(TFTPClient, 'FTP Client', 'Clients');
end.
