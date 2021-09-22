unit Cqv.Countdown.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.Ani;

type
  TMainForm = class(TForm)
    LogoImage: TImage;
    StartingText: TText;
    HeaderLayout: TLayout;
    FooterLayout: TLayout;
    TopicText: TText;
    StartingShadowEffect: TShadowEffect;
    TopicShadowEffect: TShadowEffect;
    CenterLayout: TLayout;
    TimePie: TPie;
    RotatingArc: TArc;
    RotatingAnimation: TFloatAnimation;
    TimeText: TText;
    TimeShadowEffect: TShadowEffect;
    ClockTimer: TTimer;
    TimeFloatAnimation: TFloatAnimation;
    MainPanel: TGridPanelLayout;
    procedure FormCreate(Sender: TObject);
    procedure TopicTextDblClick(Sender: TObject);
    procedure StartingTextDblClick(Sender: TObject);
    procedure ClockTimerTick(Sender: TObject);
    procedure TimeTextDblClick(Sender: TObject);
  private
    FTargetTime: TDateTime;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  System.DateUtils, System.Math, FMX.DialogService;

procedure TMainForm.ClockTimerTick(Sender: TObject);
begin
  var DiffTime := FTargetTime - Now;
  if DiffTime > 0 then
  begin
    TimeText.Text := FormatDateTime('nn:ss', DiffTime);
    TimePie.EndAngle := Min(SecondsBetween(Now, FTargetTime), 360);
  end
  else begin
    TimeText.Text := 'LIVE!';
    TimePie.EndAngle := 0;
  end;
  TimeShadowEffect.UpdateParentEffects;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FTargetTime := IncSecond(Now, 360);
end;

procedure TMainForm.StartingTextDblClick(Sender: TObject);
begin
  Close();
end;

procedure TMainForm.TimeTextDblClick(Sender: TObject);
begin
  TDialogService.InputQuery(Application.Title,
    ['Inserisci la data/ora di inizio streaming'], [DateTimeToStr(FTargetTime)],
    procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if AResult <> mrOk then
        Exit;
      if Length(AValues) <= 0 then
        Exit;
      FTargetTime := StrToDateTime(AValues[0]);
    end);
end;

procedure TMainForm.TopicTextDblClick(Sender: TObject);
begin
  TDialogService.InputQuery(Application.Title,
    ['Inserisci il titolo della puntata'], [TopicText.Text],
    procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      if AResult <> mrOk then
        Exit;
      if Length(AValues) <= 0 then
        Exit;
      TopicText.Text := AValues[0];
      TopicShadowEffect.UpdateParentEffects;
    end);
end;

end.
