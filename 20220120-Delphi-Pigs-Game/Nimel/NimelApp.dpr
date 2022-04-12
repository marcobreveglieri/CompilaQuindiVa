program NimelApp;

uses
  System.StartUpCopy,
  FMX.Forms,
  Skia.FMX,
  Nimel.UI.Forms.Main in 'UI\Nimel.UI.Forms.Main.pas' {MainForm},
  Nimel.Services.Tokens.Cube in 'Services\Nimel.Services.Tokens.Cube.pas',
  Nimel.Core.Errors in 'Core\Nimel.Core.Errors.pas',
  Nimel.Core.Game in 'Core\Nimel.Core.Game.pas',
  Nimel.Core.Options in 'Core\Nimel.Core.Options.pas',
  Nimel.Core.Player in 'Core\Nimel.Core.Player.pas',
  Nimel.Core.Resources in 'Core\Nimel.Core.Resources.pas',
  Nimel.Core.Session in 'Core\Nimel.Core.Session.pas',
  Nimel.Core.Tokens in 'Core\Nimel.Core.Tokens.pas',
  Nimel.UI.Frames.Match in 'UI\Nimel.UI.Frames.Match.pas' {MatchView: TFrame},
  Nimel.UI.Frames.Home in 'UI\Nimel.UI.Frames.Home.pas' {HomeView: TFrame},
  Nimel.Services.Messaging in 'Services\Nimel.Services.Messaging.pas',
  Nimel.UI.Base.View in 'UI\Nimel.UI.Base.View.pas' {BaseView: TFrame},
  Nimel.UI.Frames.Winner in 'UI\Nimel.UI.Frames.Winner.pas' {WinnerView: TFrame},
  Nimel.Services.AudioManager in 'Services\Nimel.Services.AudioManager.pas';

{$R *.res}

var
  MainForm: TMainForm;

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
