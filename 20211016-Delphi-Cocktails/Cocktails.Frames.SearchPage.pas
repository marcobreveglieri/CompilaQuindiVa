unit Cocktails.Frames.SearchPage;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cocktails.Frames.BasePage, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation,
  System.Actions, FMX.ActnList, FMX.Edit, FMX.Layouts, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope;

type
  TSearchPageFrame = class(TBasePageFrame)
    SearchEdit: TEdit;
    SearchLayout: TLayout;
    SearchButton: TButton;
    SearchAction: TAction;
    SearchBindingList: TBindingsList;
    DrinkListView: TListView;
    LinkListControlToField1: TLinkListControlToField;
    procedure SearchActionExecute(Sender: TObject);
    procedure PageActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure DrinkListViewItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
  public
  end;

implementation

{$R *.fmx}

uses
  Cocktails.Modules.Client, Cocktails.Model.Pages, Cocktails.Model.Types,
  Cocktails.Modules.App;

procedure TSearchPageFrame.DrinkListViewItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
   TThread.CreateAnonymousThread(
      procedure
      begin
        Sleep(100);
        TThread.Synchronize(nil,
          procedure
          begin
            AppModule.SetPageView(TPageView.Detail);
          end);
      end
    ).Start;
end;

procedure TSearchPageFrame.PageActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  SearchAction.Enabled := not string.IsNullOrWhiteSpace(SearchEdit.Text);
end;

procedure TSearchPageFrame.SearchActionExecute(Sender: TObject);
begin
  inherited;
  ClientModule.ExecuteSearch(SearchEdit.Text);
end;

initialization

  RegisterViewPage(TPageView.Search, TSearchPageFrame);

end.
