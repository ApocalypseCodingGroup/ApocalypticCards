unit datamodel.userdata.standard;

interface
uses
  datamodel
;

type
  TUserData = class( TGameDataObject, IUserData )
  private
    fUserID: string;
    fName: string;
    fGameID: string;
  strict private //- IUserData -//
    //- Getters
    function getUserID: string;
    function getName: string;
    function getGameID: string;
    //- Setters
    procedure setUserID( const value: string );
    procedure setName( const value: string );
    procedure setGameID( const value: string );
  public

  end;

implementation

{ TUserData }

function TUserData.getGameID: string;
begin
  Result := fGameID;
end;

function TUserData.getName: string;
begin
  Result := fName;
end;

function TUserData.getUserID: string;
begin
  Result := fUserID;
end;

procedure TUserData.setGameID(const value: string);
begin
  fGameID := Value;
end;

procedure TUserData.setName(const value: string);
begin
  fName := Value;
end;

procedure TUserData.setUserID(const value: string);
begin
  fUserID := Value;
end;

end.
