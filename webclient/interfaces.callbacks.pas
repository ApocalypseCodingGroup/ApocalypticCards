unit interfaces.callbacks;

interface

uses classes.gamedata;

// IanB - Specially removed the repeated "type" keywords to make Gus happy :)
type
  TGameGuid = string;
  TUserGuid = string;

  TCreateGameCallback      = reference to procedure(const CreatedGame: boolean);
  TGetGamesCallback        = reference to procedure(const GamesFound: boolean);
  TGetSpecificGameCallback = reference to procedure(const GamesFound: boolean; const GameGUID: TGameGuid);
  TGetUserCallback         = reference to procedure(const UserFound: boolean; const UserName: TUserGuid);

implementation

end.
