unit Game.Interfaces;

interface

const
  cPasswordLen       = 9;
  cMinUserCount      = 3;
  cMaxUserCount      = 10;
  cStartPasswordChar = 48;
  cPasswordCharRange = 42;
  cGameRounds        = 5;
  cCardsPerHand      = 6;

const
  cNullString = '';
  cGeneratePasswordFlag = 'Generate';

type
  IGameDataObject = interface
    function AsObject: TObject;
    function ToJSON: string;
  end;


  TGameState = (
    gsGreenRoom,  //- Waiting for players to join
    gsRunning,    //- Game has started
    gsNextTurn,   //- (Not to database, just triggers state change)
    gsGameOver    //- We're done here.
  );


  IGameData = interface( IGameDataObject )
    //- Getters
    function getSessionID: string;
    function getSessionName: string;
    function getLangID: string;
    function getMinUser: integer;
    function getMaxUser: integer;
    function getGameState: TGameState;
    function getPassword: string;
    function getUserCount: integer;
    function getCurrentQuestion: string;

    //- Setters
    procedure setSessionID( const value: string );
    procedure setSessionName( const value: string );
    procedure setLangID( const value: string );
    procedure setMinUser( const value: integer );
    procedure setMaxUser( const value: integer );
    procedure setGameState( const value: TGameState );
    procedure setPassword( const value: string );
    procedure setUserCount( const value: integer );
    procedure setCurrentQuestion( const value: string );

    //- Properties
    property SessionPassword: string  read getPassword        write setPassword;
    property SessionID: string        read getSessionID       write setSessionID;
    property SessionName: string      read getSessionName     write setSessionName;
    property LangID: string           read getLangID          write setLangID;
    property MinUser: integer         read getMinUser         write setMinUser;
    property MaxUser: integer         read getMaxUser         write setMaxUser;
    property GameState: TGameState    read getGameState       write setGameState;
    property UserCount: integer       read getUserCount       write setUserCount;
    property CurrentQuestion: string  read getCurrentQuestion write setCurrentQuestion;
  end;

  TPlayerState = (
    psInGreenRoom,            //- Waiting in green room for game to begin.
    psJudgeWaitingForSubmit,  //- Waiting for other players to submit cards
    psPlayerSubmitting,       //- I should submit a card from my hand
    psGameEnded               //- Game is over, display scores
  );

  IUserData = interface( IGameDataObject )
    //- Getters
    function getIsCurrentUser: boolean;
    function getUserID: string;
    function getName: string;
    function getGameID: string;
    function getDeleted: boolean;
    function getPlayerState: TPlayerState;
    function getScore: integer;

    //- Setters
    procedure setIsCurrentUser( const value: boolean );
    procedure setUserID( const value: string );
    procedure setName( const value: string );
    procedure setGameID( const value: string );
    procedure setDeleted( const value: boolean );
    procedure setPlayerState( const value: TPlayerState );
    procedure setScore( const value: integer );

    //- Properties
    property PlayerState: TPlayerState read getPlayerState   write setPlayerState;
    property Score: integer            read getScore         write setScore;
    property Deleted: boolean          read getDeleted       write setDeleted;
    property IsCurrentUser: boolean    read getIsCurrentUser write setIsCurrentUser;
    property UserID: string            read getUserID        write setUserID;
    property Name: string              read getName          write setName;
    property GameID: string            read getGameID        write setGameID; //<- Which game am I joined to?
  end;


implementation

end.
