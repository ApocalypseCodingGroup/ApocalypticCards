unit datamodel.gamedataobject.custom;

interface
uses
  DataModel
;

type
  TGameDataObject = class( TInterfacedObject, IGameDataObject )
  strict private
    function AsObject: TObject;
    function ToJSON: string;
  end;

implementation
uses
  System.Json,
  REST.JSON
;

function TGameDataObject.AsObject: TObject;
begin
  Result := Self;
end;

function TGameDataObject.ToJSON: string;
begin
  Result := TJSON.ObjectToJsonString( Self.AsObject );
end;

end.
