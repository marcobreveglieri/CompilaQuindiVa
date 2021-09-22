unit Memory.UI.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.MultiResBitmap,
  System.IOUtils,
  Memory.Core.Game, System.Actions, FMX.ActnList, FMX.Effects;

type

{ TMainForm }

  TMainForm = class(TForm)
    CardPanel: TGridPanelLayout;
    CardTemplateImage: TImage;
    TitleLayout: TLayout;
    LogoImage: TImage;
    GameStartButton: TButton;
    MainActionList: TActionList;
    GameStartAction: TAction;
    GameStopAction: TAction;
    GameStopButton: TButton;
    TitleLabel: TLabel;
    TitleGlowEffect: TGlowEffect;
    MoveLabel: TLabel;
    LogoShadowEffect: TShadowEffect;
    procedure GameStartActionExecute(Sender: TObject);
    procedure GameStopActionExecute(Sender: TObject);
    procedure MainActionListUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    FCards: array of TImage;
    FCurrent: Integer;
    FGame: TGame;
    procedure InitCards;
    procedure RefreshUI;
    procedure HandleCardClick(Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

{ TMainForm }

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCurrent := -1;
  FGame := TGame.Create;
  InitCards;
  RefreshUI;
end;

destructor TMainForm.Destroy;
begin
  if FGame <> nil then
    FreeAndNil(FGame);
  inherited Destroy;
end;

procedure TMainForm.GameStartActionExecute(Sender: TObject);
begin
  if FGame.Session = TGameSession.Started then
    Exit;
  FCurrent := -1;
  FGame.Start;
  RefreshUI;
end;

procedure TMainForm.GameStopActionExecute(Sender: TObject);
begin
  if FGame.Session = TGameSession.Stopped then
    Exit;
  FGame.Stop;
  RefreshUI;
end;

procedure TMainForm.HandleCardClick(Sender: TObject);
var
  CardIndex: Integer;
  CardImage: TImage;
  CurrentCard, GameCard: TGameCard;
begin
  if FGame.Session <> TGameSession.Started then
    Exit;

  CardImage := TImage(Sender);
  CardIndex := CardImage.Tag;
  GameCard := FGame.Cards[CardIndex];

  if GameCard.Status = TGameCardStatus.Uncovered then
    Exit;

  if GameCard.Status = TGameCardStatus.Matched then
    Exit;

  GameCard.Status := TGameCardStatus.Uncovered;
  RefreshUI;

  if FCurrent < 0 then
  begin
    FCurrent := CardIndex;
    Exit;
  end;

  FGame.IncMoves;

  CurrentCard := FGame.Cards[FCurrent];
  FCurrent := -1;

  if CurrentCard.Value = GameCard.Value then
  begin
    CurrentCard.Status := TGameCardStatus.Matched;
    GameCard.Status := TGameCardStatus.Matched;
    RefreshUI;
    if FGame.CheckIfFinished then
      GameStopAction.Execute;
    Exit;
  end;

  Application.ProcessMessages;
  Sleep(2000);
  CurrentCard.Status := TGameCardStatus.Covered;
  GameCard.Status := TGameCardStatus.Covered;
  RefreshUI;
end;

procedure TMainForm.InitCards;
var
  Item: TImage;
  i: Integer;
begin
  SetLength(FCards, FGame.CardCount);
  for i := 0 to FGame.CardCount - 1 do
  begin
    Item := TImage.Create(Self);
    Item.Parent := CardPanel;
    Item.Width := 300;
    Item.Height := 300;
    Item.Align := TAlignLayout.Center;
    Item.Tag := i;
    Item.OnClick := HandleCardClick;
    FCards[i] := Item;
  end;
end;

procedure TMainForm.MainActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  GameStartAction.Enabled := FGame.Session <> TGameSession.Started;
  GameStopAction.Enabled := FGame.Session <> TGameSession.Stopped;
  Handled := True;
end;

procedure TMainForm.RefreshUI;
var
  GameCard: TGameCard;
  ImageName: string;
  ImageStream: TResourceStream;
  i: Integer;
begin
  for i := 0 to FGame.CardCount - 1 do
  begin
    GameCard := FGame.Cards[i];
    if GameCard.Status = TGameCardStatus.Covered then
      ImageName := 'JpgCardBack'
    else
      ImageName := Format('JpgCard%d', [GameCard.Value]);
    ImageStream := TResourceStream.Create(HInstance, ImageName, RT_RCDATA);
    try
      FCards[i].Bitmap.LoadFromStream(ImageStream);
    finally
      ImageStream.Free;
    end;
    FCards[i].Repaint;
  end;
  MoveLabel.Text := Format('Tentativi: %d', [FGame.Moves]);
  CardPanel.Repaint;
end;

end.
