unit Utils.Messages;

interface

uses
  Classes, SysUtils
, System.Messaging
;

type
  TAppView = (Init, Home, CreateGame, JoinGame, GreenRoom);

  TCurrentViewChanged = class(TMessage<TAppView>);
  TGameUsersChanged = class(TMessage);
  TGamesChanged = class(TMessage);

  TUsersPollingStopped = class(TMessage);
  TGamesPollingStopped = class(TMessage);

  TMessageHelper = class helper for TMessageBase
    procedure Send(const ASender: TObject);
    class procedure CreateAndSend(const ASender: TObject); overload;
    class procedure SendMessage(const ASender: TObject; const AMessage: TMessageBase); overload;
    class function Subscribe(const AListener: TMessageListener): Integer;
  end;


implementation

{ TMessageHelper }

class procedure TMessageHelper.CreateAndSend(const ASender: TObject);
begin
  SendMessage(ASender, Self.Create);
end;

class procedure TMessageHelper.SendMessage(const ASender: TObject;
  const AMessage: TMessageBase);
begin
  TMessageManager.DefaultManager.SendMessage(ASender, AMessage);
end;

procedure TMessageHelper.Send(const ASender: TObject);
begin
  SendMessage(ASender, Self);
end;

class function TMessageHelper.Subscribe(const AListener: TMessageListener): Integer;
begin
  Result := TMessageManager.DefaultManager.SubscribeToMessage(Self, AListener);
end;

end.
