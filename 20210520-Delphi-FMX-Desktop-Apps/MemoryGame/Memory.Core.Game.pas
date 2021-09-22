unit Memory.Core.Game;

interface

uses
  System.Classes, System.Math, Generics.Collections;

{ Consts }

const
  GameItemCountPerRow = 4;

type

{ TGameCardStatus }

  TGameCardStatus = (Covered, Uncovered, Matched);

{ TGameCard }

  TGameCard = class
  public
    Status: TGameCardStatus;
    Value: Integer;
  end;

{ TGameCards }

  TGameCards = TObjectList<TGameCard>;

{ TGameSession }

  TGameSession = (Started, Stopped);

{ TGame }

  TGame = class
  private
    FCards: TGameCards;
    FMoves: Integer;
    FSession: TGameSession;
  protected
    function GetCardCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function CheckIfFinished: Boolean;
    procedure Start;
    procedure Stop;
    procedure IncMoves;
    property Cards: TGameCards read FCards;
    property CardCount: Integer read GetCardCount;
    property Moves: Integer read FMoves;
    property Session: TGameSession read FSession;
  end;

implementation

{ TGame }

function TGame.CheckIfFinished: Boolean;
var
  Item: TGameCard;
begin
  for Item in FCards do
  begin
    if Item.Status <> TGameCardStatus.Matched then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

constructor TGame.Create;
var
  i: Integer;
begin
  inherited Create;
  FCards := TGameCards.Create;
  for i := 0 to (GameItemCountPerRow * GameItemCountPerRow - 1) do
    FCards.Add(TGameCard.Create);
  Start;
end;

destructor TGame.Destroy;
begin
  FCards.Free;
  inherited Destroy;
end;

function TGame.GetCardCount: Integer;
begin
  Result := FCards.Count;
end;

procedure TGame.IncMoves;
begin
  Inc(FMoves);
end;

procedure TGame.Start;
var
  i, p: Integer;
begin
  FMoves := 0;
  for i := 0 to CardCount - 1 do
  begin
    FCards[i].Status := TGameCardStatus.Covered;
    FCards[i].Value := 0;
  end;
  Randomize;
  for i := 1 to CardCount div 2 do
  begin
    while True do
    begin
      p := RandomRange(0, CardCount);
      if FCards[p].Value = 0 then
      begin
        FCards[p].Value := i;
        Break;
      end;
    end;
    while True do
    begin
      p := RandomRange(0, CardCount);
      if FCards[p].Value = 0 then
      begin
        FCards[p].Value := i;
        Break;
      end;
    end;
  end;
  FSession := TGameSession.Started;
end;

procedure TGame.Stop;
var
  I: Integer;
begin
  for I := 0 to CardCount - 1 do
    FCards[I].Status := TGameCardStatus.Uncovered;
  FSession := TGameSession.Stopped;
end;

end.
