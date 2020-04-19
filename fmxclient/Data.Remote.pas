unit Data.Remote;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope
, datamodel
;

type
  TErrorProc = reference to procedure (const AMessage: string);

  TRemoteData = class(TDataModule)
    RESTClient1: TRESTClient;
    GameRequest: TRESTRequest;
    GameResponse: TRESTResponse;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateGame(const AGameData: IGameData; const AOnSuccess: TProc<string>;
      const AOnError: TErrorProc);
  end;

var
  RemoteData: TRemoteData;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.JSON, REST.JSON
,  datamodel.standard
;

{ TRemoteData }

procedure TRemoteData.CreateGame(const AGameData: IGameData;
  const AOnSuccess: TProc<string>; const AOnError: TErrorProc);
var
  LJSON: string;
begin
  LJSON := TJson.ObjectToJsonString(AGameData.AsObject);

//  GameRequest.Method := rmPOST;
  GameRequest.Body.Add(LJSON, ctAPPLICATION_JSON); // actual body of the request, application/json
//  GameRequest.Params.ParameterByName('body').Value := LJSON; // application/x-www-form-urlencoded
  GameRequest.ExecuteAsync(
    procedure
    begin
      if Assigned(AOnSuccess) then
        AOnSuccess(GameResponse.Content);
    end
   , True, True
   , procedure(AObj: TObject)
     begin
      if Assigned(AOnError) then
        AOnError('ERROR! ' + AObj.ToString);
     end
  );

end;

end.
