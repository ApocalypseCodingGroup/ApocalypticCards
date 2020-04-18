unit ViewModel;

interface
uses
  cwCollections
, DataModel
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

    // function JoinGame( const jston: string ): string;

   end;

implementation


end.
