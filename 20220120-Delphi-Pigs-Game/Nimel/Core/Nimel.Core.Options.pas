unit Nimel.Core.Options;

interface

uses
  System.Classes, Nimel.Core.Tokens;

type

{ TOptions }

  TOptions = class (TPersistent)
  private
    FNumberOfPlayers: Integer;
    FScoreToWin: Integer;
  public
    constructor Create;
  published
    property NumberOfPlayers: Integer read FNumberOfPlayers write FNumberOfPlayers default 2;
    property ScoreToWin: Integer read FScoreToWin write FScoreToWin default 50;
  end;

implementation

{ TOptions }

constructor TOptions.Create;
begin
  inherited Create;
  FNumberOfPlayers := 2;
  FScoreToWin := 50;
end;

end.

