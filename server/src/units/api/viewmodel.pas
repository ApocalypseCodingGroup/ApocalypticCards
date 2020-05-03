unit ViewModel;

interface
uses
  cwCollections
, DataModel
;

type
   ///  <summary>
   ///    This provides access to the collections which represent the
   ///    end-points for out game.
   ///  </summary>
   IViewModel = interface
     ['{B3C6E9B2-EDE2-4FD6-A99A-E987F06A3538}']

     procedure CleanUp;

     procedure UpdateUserPing( const UserID: string );

     /// <summary>
     ///   Returns a collection of public games waiting for users to join.
     /// </summary>
     function getPublicGames: string;

     /// <summary>
     ///   Create a new game based on the json parameters provided. As a
     ///   minimum, the following parameters must be provided. <br /><br />{ <br />
     ///   "sessionName": "My new game", <br />"langID": "GB", <br />} <br /><br />
     ///   Optionally provide "minUsers", "maxUsers" and the "sessionPassword:"
     ///   parameter may be set to the keyword "Generate" in order to make this
     ///   game private.
     /// </summary>
     function CreateGame( const json: string ): string;

     /// <summary>
     ///   <para>
     ///     This method creates a new entry in the users table for a
     ///     specified game.
     ///   </para>
     ///   <para>
     ///     required json:
     ///   </para>
     ///   <para>
     ///     "Name": "John Smith" <br />"sessionID": "&lt;GUID&gt;" <br /><br />
     ///     The game will be loaded based on either the GUID or Password,
     ///     and if the user successfully joins, their GUID is returned as
     ///     part of the user record. <br />
     ///   </para>
     /// </summary>
     function JoinGame( const json: string ): string;

     /// <summary>
     ///
     /// </summary>
     function getUsers( const AuthToken: string ): string;

     ///  <summary>
     ///    Progress the game state.
     ///  </summary>
     function setGameState( AuthToken: string; const json: string ): string;

     ///  <summary>
     ///    Get current turn data for user specified by auth token
     ///  </summary>
     function getCurrentTurn( AuthToken: string ): string;

   end;

implementation


end.
