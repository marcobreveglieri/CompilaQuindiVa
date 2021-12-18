unit Cocktails.Modules.Client;

interface

uses
  System.SysUtils, System.Classes, REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FireDAC.Stan.StorageBin;

type
  TClientModule = class(TDataModule)
    RESTClient: TRESTClient;
    RESTRequestSearch: TRESTRequest;
    RESTResponseSearch: TRESTResponse;
  private
  public
    procedure ExecuteSearch(const ATerm: string);
  end;

var
  ClientModule: TClientModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TClientModule }

procedure TClientModule.ExecuteSearch(const ATerm: string);
begin
  RESTRequestSearch.Params.ParameterByName('s').Value := ATerm;
  RESTRequestSearch.Execute;
end;

end.
