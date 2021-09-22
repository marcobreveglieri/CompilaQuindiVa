unit Onboard.Frames.ClosingStep;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Onboard.Frames.Step, FMX.Objects, FMX.Controls.Presentation;

type
  TClosingStepFrame = class(TStepFrame)
    CloseButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClosingStepFrame: TClosingStepFrame;

implementation

{$R *.fmx}

end.
