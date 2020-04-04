unit datamodel.game.standard;

interface
uses
  datamodel
;

type
  TGameData = class(  TInterfacedObject, IGameData )
  private
    fSessionName: string;
    fLangID: string;
    fMinUser: integer;
    fMaxUser: integer;
    fSessionID: string;
  public
    property SessionID: string read fSessionID write fSessionID;
    property SessionName: string read fSessionName write fSessionName;
    property LangID: string read fLangID write fLangID;
    property MinUser: integer read fMinUser write fMinUser;
    property MaxUser: integer read fMaxUser write fMaxUser;
  end;

implementation

end.
