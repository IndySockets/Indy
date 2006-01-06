unit MgrPkgGenMgrDModDS;

interface

uses
  SysUtils, Classes, DB;

type
  TDMDS = class(TDataModule)
    DSMain: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMDS: TDMDS;

implementation

uses DModule;

{$R *.dfm}

end.
