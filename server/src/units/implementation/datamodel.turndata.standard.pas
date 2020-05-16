unit datamodel.turndata.standard;

interface
uses
  cwCollections
, datamodel
, datamodel.gamedataobject.custom
;

type
  TTurnData = class( TGameDataObject, ITurnData )
    fQuestion: ICardData;
    fSelection: ICardData;
    fAnswers: IList<ICardData>;
    fCards: IList<ICardData>;

  strict private
    function getQuestion: ICardData;
    function getSelection: ICardData;
    function getAnswers: IList<ICardData>;
    function getCards: IList<ICardData>;
  protected
    function ToJSON: string; override;

  public
    constructor Create;
    destructor Destroy; override;

    Class Function FromJSON(Const aJSON : String) : ITurnData;
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
  fQuestion :=  TCardData.Create;
end;

destructor TTurnData.Destroy;
begin
  fQuestion := nil;
  fAnswers := nil;
  fCards := nil;
  fSelection := nil;
  inherited;
end;

class Function TTurnData.FromJSON(Const aJSON : String) : ITurnData;
var
  lJSONObj   : TJSONObject;
  lSelection,
  lQuestion  : TJSONObject;
  lAnswers,
  lCards     : TJSONArray;
  lCard      : ICardData;
  idx        : integer;
begin
  Result := TTurnData.Create;

  lJSONObj   := TJSONObject.ParseJSONValue(aJSON) as TJSONObject;
  lQuestion  := lJSONObj.Values['question'] as TJSONObject;
  lSelection := lJSONObj.Values['selection'] as TJSONObject;
  lAnswers   := lJSONObj.Values['answers'] as TJSONArray;
  lCards     := lJSONObj.Values['cards'] as TJSONArray;
  Result.Question.CardID  := lQuestion.Values['cardid'].Value;
  Result.Question.Title   := lQuestion.Values['title'].Value;

  Result.Selection.CardID := lSelection.Values['cardid'].Value;
  Result.Selection.Title  := lSelection.Values['title'].Value;

  for idx := 0 to lAnswers.Count-1 do
    begin
      lCard := TCardData.Create;
      lCard.CardID := TJSONObject(lAnswers.Items[idx]).Values['cardid'].Value;
      lCard.Title  := TJSONObject(lAnswers.Items[idx]).Values['title'].Value;
      lCard.Owner  := TJSONObject(lAnswers.Items[idx]).Values['owner'].Value;
      Result.Answers.Add(lCard);
    end;

  for idx := 0 to lCards.Count-1 do
    begin
      lCard := TCardData.Create;
      lCard.CardID := TJSONObject(lCards.Items[idx]).Values['cardid'].Value;
      lCard.Title  := TJSONObject(lCards.Items[idx]).Values['title'].Value;
      lCard.Owner  := TJSONObject(lCards.Items[idx]).Values['owner'].Value;
      Result.Cards.Add(lCard);
    end;
end;

function TTurnData.getAnswers: IList<ICardData>;
begin
  Result := fAnswers;
end;

function TTurnData.getCards: IList<ICardData>;
begin
  Result := fCards;
end;

function TTurnData.getQuestion: ICardData;
begin
  Result := fQuestion;
end;

function TTurnData.getSelection: ICardData;
begin
  Result := fSelection;
end;

function TTurnData.ToJSON: string;
var
  TurnData: TJSONObject;
  Selection,
  Question: TJSONObject;
  Answer: TJSONObject;
  Card: TJSONObject;
  Answers: TJSONArray;
  Cards: TJSONArray;
begin
  TurnData := TJSONObject.Create;
  try
    Question  := TJSONObject.Create;
    Question.AddPair('cardid',fQuestion.CardID);
    Question.AddPair('title',fQuestion.Title);

    TurnData.AddPair('question',Question);

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
        Answer.AddPair('owner',Item.Owner);
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
        Card.AddPair('owner',Item.Owner);
        Cards.Add(Card);
      end
    );
    Result := TurnData.ToJSON;
  finally
    TurnData.DisposeOf;
  end;
end;

end.
