unit datamodel.carddata.standard;

interface
uses
  datamodel
, datamodel.gamedataobject.custom
;

type
  TCardData = class( TGameDataObject, ICardData )
  private
    fCardID: string;
    fTitle: string;
  strict private
    function getCardID: string;
    function getTitle: string;
    procedure setCardID( const value: string );
    procedure setTitle( const value: string );
  end;

implementation

{ TCardData }

function TCardData.getCardID: string;
begin
  Result := fCardID;
end;

function TCardData.getTitle: string;
begin
  Result := fTitle;
end;

procedure TCardData.setCardID(const value: string);
begin
  fCardID := Value;
end;

procedure TCardData.setTitle(const value: string);
begin
  fTitle := Value;
end;

end.
