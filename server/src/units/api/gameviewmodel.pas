unit gameviewmodel;

interface
uses
  System.Generics.Collections
;

Const
  {$IFDEF DEBUG}
  BaseURL = 'http://localhost:8080';
  {$ELSE}
  BaseURL = 'https://apocalypse.chapmanworld.com/api/';
  {$ENDIF}

Type
  TArrayOfString = array of string;

  ///  <summary>
  ///    Represents a running game session.
  ///  </summary>
  IGame = interface
    ['{832D2DB6-B760-4903-8B79-84B92CE47399}']

    function getGameData: IGameData;

    property Data: IGameData read getGameData;
  end;

   ///  <summary>
   ///    This provides access to the collections which represent the
   ///    end-points for out game.
   ///  </summary>
   IGameViewModel = interface
     ['{B3C6E9B2-EDE2-4FD6-A99A-E987F06A3538}']

     function getGames: IList<IGame>;

     property Games: IList<IGame> read getGames;
   end;




implementation

end.
