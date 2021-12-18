unit Cocktails.Frames.DetailPage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cocktails.Frames.BasePage, System.Actions, FMX.ActnList,
  FMX.Controls.Presentation, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.WebBrowser;

type

  TDetailPageFrame = class(TBasePageFrame)
    DrinkLabel: TLabel;
    DetailBindingsList: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    TagLabel: TLabel;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    CategoryLabel: TLabel;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    InstructionTitleLabel: TLabel;
    InstructionMemo: TMemo;
    LinkControlToField1: TLinkControlToField;
    ImageWebBrowser: TWebBrowser;
    LinkPropertyToFieldURL: TLinkPropertyToField;
    BackButton: TButton;
    BackAction: TAction;
    procedure BackActionExecute(Sender: TObject);
  private
  public
  end;

implementation

{$R *.fmx}

uses
  Cocktails.Model.Pages, Cocktails.Model.Types, Cocktails.Modules.App;

procedure TDetailPageFrame.BackActionExecute(Sender: TObject);
begin
  AppModule.SetPageView(TPageView.Search);
end;

initialization

  RegisterViewPage(TPageView.Detail, TDetailPageFrame);

end.
