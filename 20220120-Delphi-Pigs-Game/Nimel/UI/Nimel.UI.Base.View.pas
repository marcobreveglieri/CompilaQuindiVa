unit Nimel.UI.Base.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls;

type

  TBaseView = class(TFrame)
  private
  public
  end;

  TViewClass = class of TBaseView;

implementation

{$R *.fmx}

end.
