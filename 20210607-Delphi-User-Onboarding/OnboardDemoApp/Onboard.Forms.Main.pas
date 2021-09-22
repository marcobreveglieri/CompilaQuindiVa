unit Onboard.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  Onboard.Frames.Step, FMX.Controls.Presentation, FMX.StdCtrls, System.Actions,
  FMX.ActnList, FMX.Gestures;

type
  TMainForm = class(TForm)
    StepTabs: TTabControl;
    TableTab: TTabItem;
    PizzaTab: TTabItem;
    MeatTab: TTabItem;
    TableStep: TStepFrame;
    PizzaStep: TStepFrame;
    MeatStep: TStepFrame;
    BillTab: TTabItem;
    BillStep: TStepFrame;
    OnboardToolbar: TToolBar;
    Button1: TButton;
    Button2: TButton;
    MainActionList: TActionList;
    CloseAction: TAction;
    EndStepAction: TChangeTabAction;
    NextStepAction: TNextTabAction;
    PreviousStepAction: TPreviousTabAction;
    Button3: TButton;
    StyleBook: TStyleBook;
    GestureManager: TGestureManager;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  StepTabs.ActiveTab := TableTab;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if PreviousStepAction.Enabled then
    begin
      PreviousStepAction.Execute;
      Key := 0;
    end;
  end;
end;

end.
