unit Cocktails.Frames.BasePage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, System.Actions, FMX.ActnList;

type

  TBasePageFrame = class(TFrame)
    PageToolBar: TToolBar;
    TitleLabel: TLabel;
    HomeButton: TButton;
    PageActionList: TActionList;
    HomeAction: TAction;
    procedure HomeActionExecute(Sender: TObject);
  private
  public
  end;

  TPageFrameClass = class of TBasePageFrame;

implementation

{$R *.fmx}

uses
  Cocktails.Model.Types,
  Cocktails.Modules.App;

procedure TBasePageFrame.HomeActionExecute(Sender: TObject);
begin
  AppModule.SetPageView(TPageView.Home);
end;

end.
