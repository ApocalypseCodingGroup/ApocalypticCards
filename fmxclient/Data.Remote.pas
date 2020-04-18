unit Data.Remote;

interface

uses
  System.SysUtils, System.Classes;

type
  TRemoteData = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RemoteData: TRemoteData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
