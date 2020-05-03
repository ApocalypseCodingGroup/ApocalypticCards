unit datamodel.standard;

interface
uses
  DataModel
, datamodel.gamedata.standard
, datamodel.userdata.standard
, datamodel.carddata.standard
, datamodel.turndata.standard
;

type
  TGameData = datamodel.gamedata.standard.TGameData;
  TUserData = datamodel.userdata.standard.TUserData;
  TCardData = datamodel.carddata.standard.TCardData;
  TTurnData = datamodel.turndata.standard.TTurnData;

  TDataModel = record
    class function Create: IDataModel; static;
  end;

implementation
uses
  SysUtils
, DataModel.DataModel.Standard
;

class function TDataModel.Create: IDataModel;
begin
  try
    Result := DataModel.DataModel.Standard.TDataModel.Create;
  except
    Result := nil;
  end;
end;

end.
