program KuFu;

uses
  System.StartUpCopy,
  FMX.Forms,
  KuFu.Forms.Main in 'KuFu.Forms.Main.pas' {MainForm},
  KuFu.Forms.Live in 'KuFu.Forms.Live.pas' {LiveForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
