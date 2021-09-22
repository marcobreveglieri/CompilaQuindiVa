program Cqv.Countdown;

uses
  System.StartUpCopy,
  FMX.Forms,
  Cqv.Countdown.Forms.Main in 'Cqv.Countdown.Forms.Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CompilaQuindiVa - Countdown';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
