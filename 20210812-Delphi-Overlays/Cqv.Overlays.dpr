program Cqv.Overlays;

uses
  System.StartUpCopy,
  FMX.Forms,
  Cqv.Overlays.UI.Forms.Main in 'Cqv.Overlays.UI.Forms.Main.pas' {MainForm},
  Cqv.Overlays.UI.Forms.Chroma in 'Cqv.Overlays.UI.Forms.Chroma.pas' {ChromaForm},
  Cqv.Overlays.Modules.Resources in 'Cqv.Overlays.Modules.Resources.pas' {ResourceModule: TDataModule},
  Cqv.Overlays.UI.Base.View in 'Cqv.Overlays.UI.Base.View.pas' {ViewBaseFrame: TFrame},
  Cqv.Overlays.UI.Views.Home in 'Cqv.Overlays.UI.Views.Home.pas' {HomeViewFrame: TFrame},
  Cqv.Overlays.UI.Views.Thirds in 'Cqv.Overlays.UI.Views.Thirds.pas' {ThirdsViewFrame: TFrame},
  Cqv.Overlays.UI.Base.Widget in 'Cqv.Overlays.UI.Base.Widget.pas' {WidgetBaseFrame: TFrame},
  Cqv.Overlays.UI.Widgets.Thirds in 'Cqv.Overlays.UI.Widgets.Thirds.pas' {ThirdsWidgetFrame: TFrame},
  Cqv.Overlays.UI.Widgets.Score in 'Cqv.Overlays.UI.Widgets.Score.pas' {ScoreWidgetFrame: TFrame},
  Cqv.Overlays.UI.Views.Score in 'Cqv.Overlays.UI.Views.Score.pas' {ScoreViewFrame: TFrame};

{$R *.res}

var
  MainForm: TMainForm;

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TResourceModule, ResourceModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
