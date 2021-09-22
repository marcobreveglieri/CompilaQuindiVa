unit Pomo.UI.Forms.Main;

interface

uses
  System.SysUtils,
  System.TimeSpan,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  Pomo.Core.Timer,
  Pomo.Core.Types,
  System.Actions,
  FMX.ActnList, FMX.Menus, System.ImageList, FMX.ImgList, FMX.Objects,
  FMX.Effects, FMX.Filter.Effects;

type
  TMainForm = class(TForm)
    PomoActionList: TActionList;
    StartPomodoroAction: TAction;
    CancelSessionAction: TAction;
    PomoImageList: TImageList;
    StartShortBreakAction: TAction;
    StartLongBreakAction: TAction;
    PomoToolBar: TToolBar;
    StartPomodoroButton: TButton;
    CancelSessionButton: TButton;
    StartLongBreakButton: TButton;
    StartShortBreakButton: TButton;
    PomoImage: TImage;
    TimeLabel: TLabel;
    StageEffect: THueAdjustEffect;
    IdleEffect: TMonochromeEffect;
    procedure PomoActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure StartPomodoroActionExecute(Sender: TObject);
    procedure CancelSessionActionExecute(Sender: TObject);
    procedure StartLongBreakActionExecute(Sender: TObject);
    procedure StartShortBreakActionExecute(Sender: TObject);
  private
    FPomoTimer: TPomoTimer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}


constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPomoTimer := TPomoTimer.Create;
  //FPomoTimer.Options.Minutes[TPomoStage.Pomodoro] := 1;
end;

destructor TMainForm.Destroy;
begin
  if FPomoTimer <> nil then
    FreeAndNil(FPomoTimer);
  inherited Destroy;
end;

procedure TMainForm.PomoActionListUpdate(Action: TBasicAction;
    var Handled: Boolean);
begin
  var LSession := FPomoTimer.Session;
  var LIdle := LSession = nil;
  var LIsPomodoro := not LIdle and (LSession.Stage = TPomoStage.Pomodoro);

  // Start/stop update
  StartPomodoroAction.Enabled := LIdle;
  StartShortBreakAction.Enabled := LIdle;
  StartLongBreakAction.Enabled := LIdle;
  CancelSessionAction.Enabled := not LIdle;

  // Cancel button update
  if LIsPomodoro then
    CancelSessionAction.Text := 'Squash!'
  else
    CancelSessionAction.Text := 'Stop';

  // Time update
  var LTime := TTimeSpan.Zero;
  if (LSession <> nil) and (not LSession.IsEnded) then
    LTime := LSession.GetRemainingTime;
  TimeLabel.Text := Format('%.2d:%.2d', [LTime.Minutes, LTime.Seconds]);
  TimeLabel.UpdateEffects;

  // Pomo color
  StageEffect.Enabled := not LIdle;
  if StageEffect.Enabled then
  begin
    case LSession.Stage of
      Pomodoro:
        StageEffect.Hue := 0;
      ShortBreak:
        StageEffect.Hue := 1.0;
      LongBreak:
        StageEffect.Hue := 0.5;
    end;
  end;
  IdleEffect.Enabled := LIdle;

  Handled := True;
end;

procedure TMainForm.StartPomodoroActionExecute(Sender: TObject);
begin
  FPomoTimer.Start(TPomoStage.Pomodoro);
end;

procedure TMainForm.CancelSessionActionExecute(Sender: TObject);
begin
  FPomoTimer.Stop;
end;

procedure TMainForm.StartLongBreakActionExecute(Sender: TObject);
begin
  FPomoTimer.Start(TPomoStage.LongBreak);
end;

procedure TMainForm.StartShortBreakActionExecute(Sender: TObject);
begin
  FPomoTimer.Start(TPomoStage.ShortBreak);
end;

end.
