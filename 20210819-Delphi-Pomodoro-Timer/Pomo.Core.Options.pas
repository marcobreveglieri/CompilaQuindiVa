unit Pomo.Core.Options;

interface

uses
  System.Generics.Collections, System.SysUtils,
  Pomo.Core.Types;

type

  TPomoOptions = class
  private
    FMinutes: TDictionary<TPomoStage, Integer>;
    function GetMinutes(AStage: TPomoStage): Integer;
    procedure SetMinutes(AStage: TPomoStage; const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    property Minutes[AStage: TPomoStage]: Integer
      read GetMinutes write SetMinutes;
  end;

implementation

constructor TPomoOptions.Create;
begin
  inherited Create;
  FMinutes := TDictionary<TPomoStage, Integer>.Create();
  FMinutes.Add(TPomoStage.Pomodoro, 25);
  FMinutes.Add(TPomoStage.ShortBreak, 5);
  FMinutes.Add(TPomoStage.LongBreak, 15);
end;

destructor TPomoOptions.Destroy;
begin
  if FMinutes <> nil then
    FreeAndNil(FMinutes);
  inherited Destroy;
end;

function TPomoOptions.GetMinutes(AStage: TPomoStage): Integer;
const
  DefaultMinutes: Integer = 10;
begin
  if not FMinutes.TryGetValue(AStage, Result) then
    Result := DefaultMinutes;
end;

procedure TPomoOptions.SetMinutes(AStage: TPomoStage;
  const Value: Integer);
begin
  FMinutes[AStage] := Value;
end;

end.
