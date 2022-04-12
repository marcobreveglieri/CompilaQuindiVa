unit Nimel.Core.Game;

interface

uses
  Nimel.Core.Options, Nimel.Core.Tokens, Nimel.Core.Session;

type

{ TGame }

  TGame = class
  private
    FOptions: TOptions;
    FSession: TSession;
  public
    constructor Create();
    destructor Destroy; override;
    function Playing: Boolean;
    procedure Quit;
    procedure Start(const ATokens: TArray<IToken>);
    property Options: TOptions read FOptions;
    property Session: TSession read FSession;
  end;

implementation

uses
  System.SysUtils;

{ TGame }

constructor TGame.Create;
begin
  inherited Create;
  FOptions := TOptions.Create;
end;

destructor TGame.Destroy;
begin
  Quit;
  if Assigned(FOptions) then
    FreeAndNil(FOptions);
  inherited Destroy;
end;

function TGame.Playing: Boolean;
begin
  Result := Assigned(FSession);
end;

procedure TGame.Quit;
begin
  if not Playing then
    Exit;
  FreeAndNil(FSession);
end;

procedure TGame.Start(const ATokens: TArray<IToken>);
begin
  if Playing then
    Exit;
  FSession := TSession.Create(ATokens,
    FOptions.NumberOfPlayers,
    FOptions.ScoreToWin);
end;

end.
