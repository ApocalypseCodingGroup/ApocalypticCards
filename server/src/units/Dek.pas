unit Dek;

interface

Const
  {$IFDEF DEBUG}
  BaseURL = 'http://localhost:8080';
  {$ELSE}
  BaseURL = 'https://apocalypse.chapmanworld.com/api/';
  {$ENDIF}

Type
  TArrayOfString = array of string;

   ICardgame = Interface
    ['{C11CFA85-FBB1-4620-BAC5-783AA64CF446}']
     Function CreateNewSessionKey : String;
     Function JoinSession(Const aSessionID,aUserName : String) : String;
     function Read_Games(out Response: string): boolean;
   end;

   IDataBase = Interface
    ['{0C23B564-0030-4895-BF7C-88F910EFD825}']
     Function CreateNewGame(Const aSessionID : String;out Error : String) : boolean;
     Function JoinGame(Const aSessionID,aUserName : String;out Token, Error : String) : boolean;
     function ReadGames( out Response: string ): boolean;
   end;

implementation

end.
