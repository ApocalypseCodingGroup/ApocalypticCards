unit datamodel.standard;

interface
uses
  DataModel
;

type
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
