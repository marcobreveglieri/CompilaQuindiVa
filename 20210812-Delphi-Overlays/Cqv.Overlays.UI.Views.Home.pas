unit Cqv.Overlays.UI.Views.Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Cqv.Overlays.UI.Base.View, FMX.Objects, System.Actions, FMX.ActnList,
  FMX.Controls.Presentation;

type

  /// <summary>
  ///   Rappresenta la vista iniziale dell'applicazione.
  /// </summary>
  THomeViewFrame = class(TViewBaseFrame)
    LogoImage: TImage;
  private
  public
    function GetTitle: string; override;
  end;

implementation

{$R *.fmx}

resourcestring
  StrHomeViewTitle = 'Pagina iniziale';

function THomeViewFrame.GetTitle: string;
begin
  Result := StrHomeViewTitle;
end;

end.
