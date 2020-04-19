unit Utils.Messages;

interface

uses
  Classes, SysUtils
, System.Messaging
;

type
  TAppView = (Init, Home, CreateGame, JoinGame, GreenRoom);


  TCurrentViewChanged = class(TMessage<TAppView>);


implementation

end.
