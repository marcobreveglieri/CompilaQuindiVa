unit Cqv.Overlays.UI.Views.Score;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  System.Actions,
  FMX.ActnList,
  FMX.Controls.Presentation,
  Cqv.Overlays.UI.Base.View,
  Cqv.Overlays.UI.Base.Widget, FMX.Edit, FMX.EditBox, FMX.NumberBox;

type
  TScoreViewFrame = class(TViewBaseFrame)
    Score1Label: TLabel;
    Score2Label: TLabel;
    Score1Box: TNumberBox;
    Score2Box: TNumberBox;
  private
  protected
    function GetWidgetClass: TWidgetClass; override;
    procedure InitializeWidget(const AWidget: TWidgetBaseFrame); override;
  public
    function GetTitle: string; override;
  end;

implementation

{$R *.fmx}

uses
  Cqv.Overlays.UI.Widgets.Score;

{ TScoreViewFrame }

function TScoreViewFrame.GetTitle: string;
begin
  Result := 'Score';
end;

function TScoreViewFrame.GetWidgetClass: TWidgetClass;
begin
  Result := TScoreWidgetFrame;
end;

procedure TScoreViewFrame.InitializeWidget(const AWidget: TWidgetBaseFrame);
begin
  inherited;
  var LScore1 := StrToInt(Score1Box.Text);
  var LScore2 := StrToInt(Score2Box.Text);
  var LWidget := TScoreWidgetFrame(AWidget);
  LWidget.SetScores(LScore1, LScore2);
  LWidget.Run;
end;

end.
