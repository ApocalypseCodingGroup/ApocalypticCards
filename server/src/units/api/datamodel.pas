unit datamodel;

interface
uses
  cwCollections
;

const
  cPasswordLen       = 9;
  cMinUserCount      = 3;
  cMaxUserCount      = 10;
  cStartPasswordChar = 48;
  cPasswordCharRange = 42;

const
  cNullString = '';
  cGeneratePasswordFlag = 'Generate';

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
    function getIsCurrentUser: boolean;
    function getUserID: string;
    function getName: string;
    function getGameID: string;
    function getDeleted: boolean;

    //- Setters
    procedure setIsCurrentUser( const value: boolean );
    procedure setUserID( const value: string );
    procedure setName( const value: string );
    procedure setGameID( const value: string );
    procedure setDeleted( const value: boolean );

    //- Properties
    property Deleted: boolean       read getDeleted       write setDeleted;
    property IsCurrentUser: boolean read getIsCurrentUser write setIsCurrentUser;
    property UserID: string         read getUserID        write setUserID;
    property Name: string           read getName          write setName;
    property GameID: string         read getGameID        write setGameID; //<- Which game am I joined to?
  end;


  IDataModel = interface
  ['{0C23B564-0030-4895-BF7C-88F910EFD825}']

    procedure CleanUp;
    procedure UpdateUserPing( const UserID: string );
    function getGames: IList<IGameData>;
    function CreateGame(const GameData: IGameData) : boolean;
    function FindGameByID(const GameID: string): IGameData;
    function FindGameByPassword(const Password: string): IGameData;
    procedure CreateUser(const NewUser: IUserData);
    function getUsers(const AuthToken: string): IList<IUserData>;

  end;


implementation

end.
