unit Cqv.Overlays.UI.Widgets.Score;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cqv.Overlays.UI.Base.Widget, FMX.Controls.Presentation, FMX.Layouts,
  FMX.Effects, FMX.Ani;

type

  TScoreWidgetFrame = class(TWidgetBaseFrame)
    Score1Label: TLabel;
    ScoreLayout: TLayout;
    Score2Label: TLabel;
    ShadowEffect: TShadowEffect;
    ZoomAnimation: TFloatAnimation;
  private
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetScores(AScore1, AScore2: Integer);
    procedure Run;
  end;

implementation

{$R *.fmx}

{ TScoreWidgetFrame }

constructor TScoreWidgetFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetScores(0, 0);
end;

procedure TScoreWidgetFrame.Run;
begin
  ZoomAnimation.Start;
end;

procedure TScoreWidgetFrame.SetScores(AScore1, AScore2: Integer);
begin
  Score1Label.Text := IntToStr(AScore1);
  Score2Label.Text := IntToStr(AScore2);
end;

end.
