unit datamodel.carddata.standard;

interface
uses
  datamodel
, datamodel.gamedataobject.custom
;

type
  TCardData = class( TGameDataObject, ICardData )
  private
    fCardID : string;
    fTitle  : string;
    fOwner  : string;
  strict private
    function  getCardID: string;
    function  getTitle: string;
    function  getOwner: String;
    procedure setCardID( const value: string );
    procedure setTitle( const value: string );
    procedure setOwner(const Value: String);
  end;

implementation

{ TCardData }

function TCardData.getCardID: string;
begin
  Result := fCardID;
end;

function TCardData.getOwner: String;
begin
  Result := fOwner;
end;

function TCardData.getTitle: string;
begin
  Result := fTitle;
end;

procedure TCardData.setCardID(const value: string);
begin
  fCardID := Value;
end;

procedure TCardData.setOwner(const Value: String);
begin
  fOwner := Value;
end;

procedure TCardData.setTitle(const value: string);
begin
  fTitle := Value;
end;

end.
