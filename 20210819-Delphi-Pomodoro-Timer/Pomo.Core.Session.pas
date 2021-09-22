unit Pomo.Core.Session;

interface

uses
  System.SysUtils, System.DateUtils, System.TimeSpan,
  Pomo.Core.Types;

type

  TPomoSession = class
  private
    FMinutes: Integer;
    FStage: TPomoStage;
    FStartedAt: TDateTime;
    FEndingAt: TDateTime;
  public
    constructor Create(AStage: TPomoStage; AMinutes: Integer);
    function GetElapsedTime: TTimeSpan;
    function GetRemainingTime: TTimeSpan;
    function IsEnded: Boolean;
    property EndingAt: TDateTime read FEndingAt;
    property Minutes: Integer read FMinutes;
    property Stage: TPomoStage read FStage;
    property StartedAt: TDateTime read FStartedAt;
  end;

implementation

constructor TPomoSession.Create(AStage: TPomoStage; AMinutes: Integer);
begin
  inherited Create;
  FMinutes := AMinutes;
  FStage := AStage;
  FStartedAt := Now;
  FEndingAt := IncMinute(FStartedAt, FMinutes);
end;

function TPomoSession.GetElapsedTime: TTimeSpan;
begin
  Result := TTimeSpan.Subtract(Now, FStartedAt);
end;

function TPomoSession.GetRemainingTime: TTimeSpan;
begin
  Result := TTimeSpan.Subtract(FEndingAt, Now);
end;

function TPomoSession.IsEnded: Boolean;
begin
  Result := GetRemainingTime.Ticks <= 0;
end;

end.
