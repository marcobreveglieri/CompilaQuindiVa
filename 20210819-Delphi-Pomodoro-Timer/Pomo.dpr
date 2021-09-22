program Pomo;

uses
  System.StartUpCopy,
  FMX.Forms,
  Pomo.UI.Forms.Main in 'Pomo.UI.Forms.Main.pas' {MainForm},
  Pomo.Core.Types in 'Pomo.Core.Types.pas',
  Pomo.Core.Session in 'Pomo.Core.Session.pas',
  Pomo.Core.Options in 'Pomo.Core.Options.pas',
  Pomo.Core.Timer in 'Pomo.Core.Timer.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
