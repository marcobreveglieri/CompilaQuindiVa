unit Nimel.UI.Frames.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, System.Actions,
  FMX.ActnList, System.ImageList, FMX.ImgList, FMX.Ani, Nimel.UI.Base.View;

type
  THomeView = class(TBaseView)
    ContainerLayout: TScaledLayout;
    LogoImage: TImage;
    CommandLayout: TLayout;
    GameStartImage: TImageControl;
    GameExitImage: TImageControl;
    HomeActionList: TActionList;
    GameStartAction: TAction;
    GameExitAction: TAction;
    ScaleAnimation: TFloatAnimation;
    procedure GameStartActionExecute(Sender: TObject);
    procedure GameExitActionExecute(Sender: TObject);
  private
  public
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  Nimel.Services.Messaging;

procedure THomeView.GameExitActionExecute(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self,
    TGameCommandMessage.Create(TGameCommandType.Quit));
end;

procedure THomeView.GameStartActionExecute(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self,
    TGameCommandMessage.Create(TGameCommandType.Start));
end;

end.
