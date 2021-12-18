program Cocktails;

uses
  System.StartUpCopy,
  FMX.Forms,
  Cocktails.Forms.Main in 'Cocktails.Forms.Main.pas' {MainForm},
  Cocktails.Frames.BasePage in 'Cocktails.Frames.BasePage.pas' {BasePageFrame: TFrame},
  Cocktails.Frames.SearchPage in 'Cocktails.Frames.SearchPage.pas' {SearchPageFrame: TFrame},
  Cocktails.Frames.HomePage in 'Cocktails.Frames.HomePage.pas' {HomePageFrame: TFrame},
  Cocktails.Modules.App in 'Cocktails.Modules.App.pas' {AppModule: TDataModule},
  Cocktails.Model.Types in 'Cocktails.Model.Types.pas',
  Cocktails.Model.Messages in 'Cocktails.Model.Messages.pas',
  Cocktails.Modules.Client in 'Cocktails.Modules.Client.pas' {ClientModule: TDataModule},
  Cocktails.Model.Pages in 'Cocktails.Model.Pages.pas',
  Cocktails.Frames.DetailPage in 'Cocktails.Frames.DetailPage.pas' {DetailPageFrame: TFrame},
  Cocktails.Frames.AboutPage in 'Cocktails.Frames.AboutPage.pas' {AboutPageFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAppModule, AppModule);
  Application.CreateForm(TClientModule, ClientModule);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
