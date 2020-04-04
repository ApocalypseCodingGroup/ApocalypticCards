unit viewmodel.gameobject.custom;

interface
uses
  ViewModel
;

type
  TGameObject = class( TInterfacedObject, IGameObject )
  protected
    function ToJSON: string; virtual; abstract;
  end;

implementation

end.
