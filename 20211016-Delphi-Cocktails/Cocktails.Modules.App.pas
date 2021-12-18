unit Cocktails.Modules.App;

interface

uses
  System.SysUtils, System.Classes, Cocktails.Model.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.Components, Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter;

type

  TAppModule = class(TDataModule)
    RESTAdapterSearch: TRESTResponseDataSetAdapter;
    DrinkTable: TFDMemTable;
    DrinkBindSource: TBindSourceDB;
    procedure DataModuleCreate(Sender: TObject);
  private
    FPageView: TPageView;
  public
    procedure SetPageView(APageView: TPageView);
    property PageView: TPageView read FPageView;
  end;

var
  AppModule: TAppModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  System.Messaging,
  Cocktails.Model.Messages;

procedure TAppModule.DataModuleCreate(Sender: TObject);
begin
  FPageView := TPageView.Home;
end;

procedure TAppModule.SetPageView(APageView: TPageView);
begin
  FPageView := APageView;
  TMessageManager.DefaultManager.SendMessage(Self,
    TPageViewChangeMessage.Create);
end;

end.
