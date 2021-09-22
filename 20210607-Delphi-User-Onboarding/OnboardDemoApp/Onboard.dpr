program Onboard;

uses
  System.StartUpCopy,
  FMX.Forms,
  Onboard.Forms.Main in 'Onboard.Forms.Main.pas' {MainForm},
  Onboard.Frames.Step in 'Onboard.Frames.Step.pas' {StepFrame: TFrame},
  Onboard.Frames.ClosingStep in 'Onboard.Frames.ClosingStep.pas' {ClosingStepFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
