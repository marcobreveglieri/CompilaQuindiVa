unit Cqv.Overlays.UI.Base.Widget;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls;

type

  TWidgetBaseFrame = class(TFrame)
  private
  public
  end;

  TWidgetClass = class of TWidgetBaseFrame;

implementation

{$R *.fmx}

end.
