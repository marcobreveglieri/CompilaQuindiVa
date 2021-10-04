unit Cqv.Overlays.UI.Views.Thirds;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cqv.Overlays.UI.Base.View, FMX.Controls.Presentation, FMX.Edit, FMX.Layouts,
  System.Actions, FMX.ActnList, Cqv.Overlays.UI.Base.Widget, FMX.ImgList;

type

  TThirdsViewFrame = class(TViewBaseFrame)
    UpperEdit: TEdit;
    LowerEdit: TEdit;
    UpperLabel: TLabel;
    LowerLabel: TLabel;
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
  Cqv.Overlays.UI.Widgets.Thirds, Cqv.Overlays.Modules.Resources;

resourcestring
  StrThirdsViewTitle = 'Lower thirds';

function TThirdsViewFrame.GetTitle: string;
begin
  Result := StrThirdsViewTitle;
end;

function TThirdsViewFrame.GetWidgetClass: TWidgetClass;
begin
  Result := TThirdsWidgetFrame;
end;

procedure TThirdsViewFrame.InitializeWidget(const AWidget: TWidgetBaseFrame);
begin
  inherited;
  with TThirdsWidgetFrame(AWidget) do
  begin
    SetUpperText(UpperEdit.Text);
    SetLowerText(LowerEdit.Text);
    Run;
  end;
end;

end.
