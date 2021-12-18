unit Cocktails.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  Cocktails.Frames.BasePage;

type
  TMainForm = class(TForm)
    AppStyleBook: TStyleBook;
    PageLayout: TLayout;
    procedure FormCreate(Sender: TObject);
  private
    FCurrentPage: TBasePageFrame;
    procedure ShowPage(APageFrameClass: TPageFrameClass);
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  System.Messaging,
  Cocktails.Model.Messages,
  Cocktails.Model.Pages,
  Cocktails.Model.Types,
  Cocktails.Modules.App;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TMessageManager.DefaultManager.SubscribeToMessage(TPageViewChangeMessage,
    procedure (const Sender: TObject; const M: TMessage)
    begin
      var LPageClass := GetViewPage(AppModule.PageView);
      if LPageClass = nil then
        raise Exception.Create('Classe della pagina per la vista non trovata');
      ShowPage(LPageClass);
    end
  );

  AppModule.SetPageView(TPageView.Home);
end;

procedure TMainForm.ShowPage(APageFrameClass: TPageFrameClass);
begin
  if not Assigned(APageFrameClass) then
    Exit;
  if Assigned(FCurrentPage) and (FCurrentPage.ClassType = APageFrameClass) then
    Exit;
  var LNewPage := APageFrameClass.Create(Self);
  try
    LNewPage.Parent := PageLayout;
  except
    LNewPage.Free;
    raise;
  end;
  if Assigned(FCurrentPage) then
    FreeAndNil(FCurrentPage);
  FCurrentPage := LNewPage;
end;

end.
