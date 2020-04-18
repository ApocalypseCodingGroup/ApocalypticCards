unit datamodel;

interface
uses
  cwCollections
;

type
  IGameDataObject = interface
    function AsObject: TObject;
    function ToJSON: string;
  end;

  IGameData = interface( IGameDataObject )
    //- Getters
    function getSessionID: string;
    function getSessionName: string;
    function getLangID: string;
    function getMinUser: integer;
    function getMaxUser: integer;
    function getRunning: boolean;
    function getPassword: string;

    //- Setters
    procedure setSessionID( const value: string );
    procedure setSessionName( const value: string );
    procedure setLangID( const value: string );
    procedure setMinUser( const value: integer );
    procedure setMaxUser( const value: integer );
    procedure setRunning( const value: boolean );
    procedure setPassword( const value: string );

    //- Properties
    property SessionPassword: string  read getPassword    write setPassword;
    property SessionID: string        read getSessionID   write setSessionID;
    property SessionName: string      read getSessionName write setSessionName;
    property LangID: string           read getLangID      write setLangID;
    property MinUser: integer         read getMinUser     write setMinUser;
    property MaxUser: integer         read getMaxUser     write setMaxUser;
    property Running: boolean         read getRunning     write setRunning;
  end;
  
  IUserData = interface( IGameDataObject )
    //- Getters
    function getUserID: string;
    function getName: string;
    function getGameID: string;

    //- Setters
    procedure setUserID( const value: string );
    procedure setName( const value: string );
    procedure setGameID( const value: string );

    //- Properties
    property UserID: string      read getUserID      write setUserID;
    property Name: string        read getName        write setName;
    property GameID: string      read getGameID      write setGameID; //<- Which game am I joined to?
  end;


  IDataModel = interface
  ['{0C23B564-0030-4895-BF7C-88F910EFD825}']

    function getGames: IList<IGameData>;
    function CreateGame(const GameData: IGameData) : boolean;

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
