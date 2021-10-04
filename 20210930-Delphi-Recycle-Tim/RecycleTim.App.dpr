program RecycleTim.App;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  RecycleTim.Forms.Main in 'Forms\RecycleTim.Forms.Main.pas' {MainForm},
  RecycleTim.Modules.RestWordGenerator in 'Modules\RecycleTim.Modules.RestWordGenerator.pas' {RestWordGeneratorModule: TDataModule};

{$R *.res}

var
  MainForm: TMainForm;

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
