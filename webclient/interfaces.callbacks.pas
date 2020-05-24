unit interfaces.callbacks;

interface

uses classes.gamedata;

type TGameGuid = string;
type TUserGuid = string;

type TCreateGameCallback      = reference to procedure(const CreatedGame: boolean);
type TGetGamesCallback        = reference to procedure(const GamesFound: boolean);
type TGetSpecificGameCallback = reference to procedure(const GamesFound: boolean; const GameGUID: TGameGuid);
type TGetUserCallback         = reference to procedure(const UserFound: boolean; const UserName: TUserGuid);

implementation

end.
