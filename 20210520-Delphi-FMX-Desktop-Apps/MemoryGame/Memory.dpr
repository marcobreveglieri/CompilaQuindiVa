program Memory;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  Memory.UI.Main in 'Memory.UI.Main.pas' {MainForm},
  Memory.Core.Game in 'Memory.Core.Game.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
