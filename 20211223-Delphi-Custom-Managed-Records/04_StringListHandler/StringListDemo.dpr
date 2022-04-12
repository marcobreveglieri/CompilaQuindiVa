program StringListDemo;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  StringListHandler in 'StringListHandler.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'String List Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
