unit datamodel.gamedataobject.custom;

interface
uses
  DataModel
;

type
  TGameDataObject = class( TInterfacedObject, IGameDataObject )
  strict private
    function AsObject: TObject;
  end;

implementation

function TGameDataObject.AsObject: TObject;
begin
  Result := Self;
end;

end.
