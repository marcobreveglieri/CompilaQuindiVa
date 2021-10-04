unit Cqv.Overlays.Modules.Resources;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, FMX.ImgList;

type
  TResourceModule = class(TDataModule)
    ViewImageList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResourceModule: TResourceModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
