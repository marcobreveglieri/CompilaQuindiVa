unit Cocktails.Frames.HomePage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cocktails.Frames.BasePage, FMX.Controls.Presentation,
  FMX.Objects, System.Actions, FMX.ActnList;

type
  THomePageFrame = class(TBasePageFrame)
    LogoImage: TImage;
    CommandPanel: TPanel;
    SearchButton: TButton;
    SearchAction: TAction;
    procedure SearchActionExecute(Sender: TObject);
  private
  public
  end;

implementation

{$R *.fmx}

uses
  Cocktails.Model.Types,
  Cocktails.Modules.App,
  Cocktails.Model.Pages;

procedure THomePageFrame.SearchActionExecute(Sender: TObject);
begin
  AppModule.SetPageView(TPageView.Search);
end;

initialization
  RegisterViewPage(TPageView.Home, THomePageFrame);

end.
