program BarcodeClient;

uses
  Vcl.Forms,
  BarcodeClient.Forms.Main in 'BarcodeClient.Forms.Main.pas' {MainForm};

{$R *.res}

var
  MainForm: TMainForm;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
