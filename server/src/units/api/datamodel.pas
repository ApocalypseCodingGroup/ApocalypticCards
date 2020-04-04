unit datamodel;

interface
uses
  System.Generics.Collections
;

type
  IGameData = interface
    //- Getters
    function getSessionID: string;
    function getSessionName: string;
    function getLangID: string;
    function getMinUser: integer;
    function getMaxUser: integer;

    //- Setters
    procedure setSessionID( const value: string );
    procedure setSessionName( const value: string );
    procedure setLangID( const value: string );
    procedure setMinUser( const value: integer );
    procedure setMaxUser( const value: integer );

    //- Properties
    property SessionID: string   read getSessionID   write setSessionID;
    property SessionName: string read getSessionName write setSessionName;
    property LangID: string      read getLangID      write setLangID;
    property MinUser: integer    read getMinUser     write setMinUser;
    property MaxUser: integer    read getMaxUser     write setMaxUser;
  end;

  IDataBase = Interface
  ['{0C23B564-0030-4895-BF7C-88F910EFD825}']

    function getGames: IList<IGameData>;

//    Function CreateNewGame(Const aSessionID : String;out Error : String) : boolean;
//    Function JoinGame(Const aSessionID,aUserName : String;out Token, Error : String) : boolean;
//    function ReadGames( out Response: string ): boolean;
  end;

//
//  ICardgame = Interface
//  ['{C11CFA85-FBB1-4620-BAC5-783AA64CF446}']
//    Function JoinSession(Const aSessionID,aUserName : String) : String;
//    function Read_Games(out Response: string): boolean;
//    function Create_Games(out Response: string; const RequestJSON: string ): boolean;
//  end;

implementation

end.
