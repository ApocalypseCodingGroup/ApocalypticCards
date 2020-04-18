unit datamodel.standard;

interface
uses
  DataModel
, datamodel.gamedata.standard
;

type
  TGameData = datamodel.gamedata.standard.TGameData;

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
