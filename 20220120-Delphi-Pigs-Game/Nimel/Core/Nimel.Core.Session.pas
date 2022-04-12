unit Nimel.Core.Session;

interface

uses
  System.Generics.Collections,
  Nimel.Core.Player, Nimel.Core.Tokens;

type

{ TSession }

  TSession = class
  private
    FGoalScore: Integer;
    FPlayers: TObjectList<TPlayer>;
    FTokens: TArray<IToken>;
    FTokenPoints: TArray<Integer>;
    FScores: TArray<Integer>;
    FTurnScore: Integer;
    FTurnPlayer: Integer;
    FWinnerIndex: Integer;
    function GetPlayers: TArray<TPlayer>;
    function GetScores: TArray<Integer>;
  protected
    procedure Initialize(ANumberOfPlayers: Integer);
  public
    constructor Create(const ATokens: TArray<IToken>;
      APlayerCount: Integer; AGoalScore: Integer);
    destructor Destroy; override;
    procedure Pass;
    procedure Roll;
    function IsWon: Boolean;
    property Players: TArray<TPlayer> read GetPlayers;
    property Scores: TArray<Integer> read GetScores;
    property TokenPoints: TArray<Integer> read FTokenPoints;
    property TurnScore: Integer read FTurnScore;
    property TurnPlayer: Integer read FTurnPlayer;
    property WinnerIndex: Integer read FWinnerIndex;
  end;

implementation

uses
  System.SysUtils,
  Nimel.Core.Resources, Nimel.Core.Errors;

{ TSession }

constructor TSession.Create(const ATokens: TArray<IToken>;
  APlayerCount: Integer; AGoalScore: Integer);
begin
  inherited Create;
  FGoalScore := AGoalScore;
  FPlayers := TObjectList<TPlayer>.Create;
  FTokens := ATokens;
  FWinnerIndex := -1;
  SetLength(FTokenPoints, Length(FTokens));
  Initialize(APlayerCount);
end;

destructor TSession.Destroy;
begin
  if Assigned(FPlayers) then
    FreeAndNil(FPlayers);
  inherited;
end;

function TSession.GetPlayers: TArray<TPlayer>;
begin
  Result := FPlayers.ToArray;
end;

function TSession.GetScores: TArray<Integer>;
begin
  Result := FScores;
end;

procedure TSession.Initialize(ANumberOfPlayers: Integer);
begin
  if ANumberOfPlayers <= 1 then
    raise ENimelException.Create(StrInvalidNumberOfPlayers);

  FPlayers.Clear;
  SetLength(FScores, ANumberOfPlayers);
  for var LPlayerNumber := 1 to ANumberOfPlayers do
  begin
    var LNewPlayer := TPlayer.Create(Format('Player %d', [LPlayerNumber]));
    try
      FPlayers.Add(LNewPlayer);
    except
      LNewPlayer.Free;
      raise;
    end;
    FScores[LPlayerNumber - 1] := 0;
  end;
end;

function TSession.IsWon: Boolean;
begin
  Result := FWinnerIndex >= 0;
end;

procedure TSession.Pass;
begin
  // Incremento i punti del giocatore con quelli del turno.
  Inc(FScores[FTurnPlayer], FTurnScore);

  // Verificare se il punteggio di vincita è stato raggiunto.
  if FScores[FTurnPlayer] >= FGoalScore then
  begin
    FWinnerIndex := FTurnPlayer;
    Exit;
  end;

  // Azzero il punteggio del turno.
  FTurnScore := 0;

  // Passo la mano al giocatore successivo.
  Inc(FTurnPlayer);
  if FTurnPlayer >= FPlayers.Count then
    FTurnPlayer := 0;
end;

procedure TSession.Roll;
begin
  // Lancia i dadi e salva il loro punteggio.
  var LTokenScore := 0;
  var LOneAny := False;
  var LOneAll := True;
  for var LTokenIndex := 0 to Length(FTokens) - 1 do
  begin
    var LTokenPoints := FTokens[LTokenIndex].GetPoints;
    if LTokenPoints = 1 then
      LOneAny := True
    else
      LOneAll := False;
    Inc(LTokenScore, LTokenPoints);
    FTokenPoints[LTokenIndex] := LTokenPoints;
  end;

  // Determina la variazione del punteggio del turno.
  if LOneAll then
    FTurnScore := FTurnScore * 2
  else if LOneAny then
    FTurnScore := 0
  else
    Inc(FTurnScore, LTokenScore);

  // Se è presente un solo "uno", si resetta il
  // punteggio del giocatore e si passa il turno.
  if LOneAny and not LOneAll then
  begin
    FScores[FTurnPlayer] := 0;
    Pass;
  end;
end;

end.
