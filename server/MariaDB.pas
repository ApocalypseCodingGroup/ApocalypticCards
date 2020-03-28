unit MariaDB;

interface

Uses
  Dek
;

Type
  TMariaDB = Class(TInterfacedObject,IDataBase)
    strict private
      Function CreateNewGame(Const aSessionID : String;out Error : String) : boolean;
      Function JoinGame(Const aSessionID,aUserName : String;out Token, Error : String) : boolean;
    private

    public
      Constructor Create;
      Class Function Construct : IDataBase;
  end;

implementation

{ TMariaDB }

class function TMariaDB.Construct: IDataBase;
begin
  Result := TMariaDB.Create;
end;

constructor TMariaDB.Create;
begin
  inherited Create;
end;

function TMariaDB.CreateNewGame(const aSessionID: String; out Error: String): boolean;
begin
  Error := 'Not Implemented';
  result := false;
end;

function TMariaDB.JoinGame(const aSessionID, aUserName: String; out Token, Error: String): boolean;
begin
  Error := 'Not Implemented';
  result := false;
end;

end.
