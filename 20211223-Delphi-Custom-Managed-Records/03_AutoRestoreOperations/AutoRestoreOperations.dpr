program AutoRestoreOperations;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  AutoUpdate in 'AutoUpdate.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
