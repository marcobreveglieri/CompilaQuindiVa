unit KuFu.Forms.Live;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Ani, FMX.MultiResBitmap;

type
  TLiveForm = class(TForm)
    VipImage: TImage;
    VipRectangle: TRectangle;
    VipPixelateEffect: TPixelateEffect;
    VipNameRectangle: TRectangle;
    VipNameLabel: TLabel;
    VipNameAnimation: TFloatAnimation;
    GlowEffect: TGlowEffect;
    procedure VipNameAnimationFinish(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    function GetEffectLevel: Single;
    procedure RevealVip();
    procedure SetEffectLevel(const ALevel: Single);
    procedure SetVipInfo(const AName: string; APicture: TFixedMultiResBitmap);
  end;

implementation

{$R *.fmx}

procedure TLiveForm.FormCreate(Sender: TObject);
begin
  VipNameRectangle.Position.X := -480;
end;

function TLiveForm.GetEffectLevel: Single;
begin
  Result := VipPixelateEffect.BlockCount;
end;

procedure TLiveForm.RevealVip();
begin
  VipPixelateEffect.Enabled := False;
  with VipNameAnimation do
  begin
    Delay := 0;
    Inverse := False;
    Start;
  end;
end;

procedure TLiveForm.SetEffectLevel(const ALevel: Single);
begin
  VipPixelateEffect.BlockCount := ALevel;
end;

procedure TLiveForm.SetVipInfo(const AName: string; APicture: TFixedMultiResBitmap);
begin
  VipNameLabel.Text := AName;
  VipImage.MultiResBitmap := APicture;
  VipPixelateEffect.BlockCount := 25;
  VipPixelateEffect.Enabled := True;
end;

procedure TLiveForm.VipNameAnimationFinish(Sender: TObject);
begin
  with VipNameAnimation do
  begin
    if Inverse then
      Exit;
    Delay := 5;
    Inverse := True;
    Start;
  end;
end;

end.
