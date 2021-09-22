unit Cqv.Overlays.UI.Forms.Chroma;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani;

type

  TChromaForm = class(TForm)
  private
  public
  end;

  function ChromaForm: TChromaForm;

implementation

{$R *.fmx}

var
  LChromaForm: TChromaForm;

function ChromaForm: TChromaForm;
begin
  if LChromaForm = nil then
    LChromaForm := TChromaForm.Create(Application);
  Result := LChromaForm;
end;

end.
