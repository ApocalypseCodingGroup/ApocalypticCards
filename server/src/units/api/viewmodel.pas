unit ViewModel;

interface
uses
  cwCollections
, DataModel
;

type

  /// <summary>
  ///   Used as a common root for game objects in the ViewModel.
  /// </summary>
  IGameObject = interface

    /// <summary>
    ///   Write this game object as JSON
    /// </summary>
    function ToJSON: string;
  end;

  ///  <summary>
  ///    Represents a running game session.
  ///  </summary>
  IGame = interface( IGameObject )
    ['{832D2DB6-B760-4903-8B79-84B92CE47399}']

    /// <summary>
    ///   Returns the storage object for this game.
    /// </summary>
    function getGameData: IGameData;

    /// <summary>
    ///   Returns the storage object for this game.
    /// </summary>
    property Data: IGameData read getGameData;
  end;

   ///  <summary>
   ///    This provides access to the collections which represent the
   ///    end-points for out game.
   ///  </summary>
   IViewModel = interface
     ['{B3C6E9B2-EDE2-4FD6-A99A-E987F06A3538}']

     /// <summary>
     ///   Returns a collection of public running games.
     /// </summary>
     function getPublicGames: string;

     /// <summary>
     ///   Creates a new game based on the JSON provided. Required JSON values:
     ///   <br />{ <br />"SessionName": "&lt;some game&gt;", <br />"LangID":
     ///   "&lt;ID&gt;", <br />"MaxUsers": 200 <br />}
     /// </summary>
     function CreateGame( const json: string ): string;

   end;



implementation


end.
