unit Cqv.Overlays.UI.Widgets.Thirds;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cqv.Overlays.UI.Base.Widget, FMX.Controls.Presentation, FMX.Objects, FMX.Ani;

type

  TThirdsWidgetFrame = class(TWidgetBaseFrame)
    UpperLabel: TLabel;
    LowerLabel: TLabel;
    BoxRectangle: TRectangle;
    SlideAnimation: TFloatAnimation;
    procedure SlideAnimationFinish(Sender: TObject);
  private
  public
    procedure SetLowerText(const AText: string);
    procedure SetUpperText(const AText: string);
    procedure Run;
  end;

implementation

{$R *.fmx}

procedure TThirdsWidgetFrame.SlideAnimationFinish(Sender: TObject);
begin
  with SlideAnimation do
  begin
    if Inverse then
      Exit;
    Delay := 5;
    Inverse := True;
    Start;
  end;
end;

procedure TThirdsWidgetFrame.SetLowerText(const AText: string);
begin
  LowerLabel.Text := AText;
end;

procedure TThirdsWidgetFrame.SetUpperText(const AText: string);
begin
  UpperLabel.Text := AText;
end;

procedure TThirdsWidgetFrame.Run;
begin
  with SlideAnimation do
  begin
    Delay := 0;
    Inverse := False;
    Start;
  end;
end;

end.
