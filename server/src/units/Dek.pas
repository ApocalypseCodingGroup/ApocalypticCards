unit Dek;

interface

Const
  {$IFDEF DEBUG}
  BaseURL = 'http://localhost:8080';
  {$ELSE}
  BaseURL = 'https://apocalypse.chapmanworld.com/api/';
  {$ENDIF}

Type
  TArrayOfString = array of string;

  TGameObject = class
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

  ICardgame = Interface
  ['{C11CFA85-FBB1-4620-BAC5-783AA64CF446}']
    Function JoinSession(Const aSessionID,aUserName : String) : String;
    function Read_Games(out Response: string): boolean;
    function Create_Games(out Response: string; const RequestJSON: string ): boolean;
  end;

  IDataBase = Interface
  ['{0C23B564-0030-4895-BF7C-88F910EFD825}']
    Function CreateNewGame(Const aSessionID : String;out Error : String) : boolean;
    Function JoinGame(Const aSessionID,aUserName : String;out Token, Error : String) : boolean;
    function ReadGames( out Response: string ): boolean;
  end;


implementation

end.
