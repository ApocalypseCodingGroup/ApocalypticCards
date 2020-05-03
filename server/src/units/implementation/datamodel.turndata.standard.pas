unit datamodel.turndata.standard;

interface
uses
  cwCollections
, datamodel
, datamodel.gamedataobject.custom
;

type
  TTurnData = class( TGameDataObject, ITurnData )
    fQuestion: string;
    fSelection: ICardData;
    fAnswers: IList<ICardData>;
    fCards: IList<ICardData>;

  strict private
    function getQuestion: string;
    function getSelection: ICardData;
    function getAnswers: IList<ICardData>;
    function getCards: IList<ICardData>;
    procedure setQuestion( const value: string );

  protected
    function ToJSON: string; override;

  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation
uses
  System.JSON
, cwCollections.Standard
, datamodel.carddata.standard
;

{ TTurnData }

constructor TTurnData.Create;
begin
  inherited;
  fAnswers := TList<ICardData>.Create;
  fCards := TList<ICardData>.Create;
  fSelection := TCardData.Create;
end;

destructor TTurnData.Destroy;
begin
  fAnswers := nil;
  fCards := nil;
  fSelection := nil;
  inherited;
end;

function TTurnData.getAnswers: IList<ICardData>;
begin
  Result := fAnswers;
end;

function TTurnData.getCards: IList<ICardData>;
begin
  Result := fCards;
end;

function TTurnData.getQuestion: string;
begin
  Result := fQuestion;
end;

function TTurnData.getSelection: ICardData;
begin
  Result := fSelection;
end;

procedure TTurnData.setQuestion(const value: string);
begin
  fQuestion := Value;
end;

function TTurnData.ToJSON: string;
var
  TurnData: TJSONObject;
  Selection: TJSONObject;
  Answer: TJSONObject;
  Card: TJSONObject;
  Answers: TJSONArray;
  Cards: TJSONArray;
begin
  TurnData := TJSONObject.Create;
  try
    TurnData.AddPair(TJSONPair.Create('question',fQuestion));
    Selection := TJSONObject.Create;
    Selection.AddPair('cardid',fSelection.CardID);
    Selection.AddPair('title',fSelection.Title);
    TurnData.AddPair('selection',Selection);
    Answers := TJSONArray.Create;
    TurnData.AddPair('answers',Answers);
    fAnswers.ForEach(
      procedure ( const item: ICardData )
      begin
        Answer := TJSONObject.Create;
        Answer.AddPair('cardid',Item.CardID);
        Answer.AddPair('title',Item.Title);
        Answers.Add(Answer);
      end
    );
    Cards := TJSONArray.Create;
    TurnData.AddPair('cards',Cards);
    fCards.ForEach(
      procedure ( const item: ICardData )
      begin
        Card := TJSONObject.Create;
        Card.AddPair('cardid',Item.CardID);
        Card.AddPair('title',Item.Title);
        Cards.Add(Answer);
      end
    );
    Result := TurnData.ToJSON;
  finally
    TurnData.DisposeOf;
  end;
end;

end.
