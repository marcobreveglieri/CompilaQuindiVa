unit Nimel.UI.Frames.Match;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Actions, FMX.ActnList, Nimel.Core.Game, Nimel.Core.Tokens,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, Nimel.UI.Base.View,
  FMX.Effects, System.ImageList, FMX.ImgList, FMX.Filter.Effects;

type

  TMatchView = class(TBaseView)
    MatchActionList: TActionList;
    TossAction: TAction;
    PassAction: TAction;
    TurnScoreLabel: TLabel;
    PotLayout: TLayout;
    ContainerLayout: TScaledLayout;
    Player1Image: TImage;
    Player2Image: TImage;
    CenterLayout: TLayout;
    CommandLayout: TLayout;
    GameStartImage: TImageControl;
    GameExitImage: TImageControl;
    Player2Layout: TLayout;
    Player1Layout: TLayout;
    Piggy2Image: TImage;
    Piggy1Image: TImage;
    Player1ScoreLabel: TLabel;
    Player2ScoreLabel: TLabel;
    GlowEffect1: TGlowEffect;
    GlowEffect2: TGlowEffect;
    DiceImageList: TImageList;
    TokenLayout: TLayout;
    Token1Image: TImage;
    Token2Image: TImage;
    Token1ScoreLabel: TLabel;
    ShadowEffect1: TShadowEffect;
    Token2ScoreLabel: TLabel;
    ShadowEffect2: TShadowEffect;
    PotImage: TImage;
    TerminateAction: TAction;
    PlayerOnEffect: TGlowEffect;
    PlayerOffEffect: TSepiaEffect;
    WinnerImage: TImage;
    TerminateImage: TImageControl;
    procedure TossActionExecute(Sender: TObject);
    procedure PassActionExecute(Sender: TObject);
    procedure MatchActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure TerminateActionExecute(Sender: TObject);
  private
    FGame: TGame;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure StartGame;
    procedure TerminateGame;
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  FMX.MultiResBitmap,
  Nimel.Services.Messaging,
  Nimel.Services.Tokens.Cube;

constructor TMatchView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGame := TGame.Create;
  StartGame;
end;

destructor TMatchView.Destroy;
begin
  if Assigned(FGame) then
    FreeAndNil(FGame);
  inherited Destroy;
end;

procedure TMatchView.MatchActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  var LPlaying := FGame.Playing;
  var LRunning := LPlaying and not FGame.Session.IsWon;
  PassAction.Enabled := LRunning;
  TossAction.Enabled := LRunning;
  var LSession := FGame.Session;
  Player1ScoreLabel.Text := IntToStr(LSession.Scores[0]);
  Player2ScoreLabel.Text := IntToStr(LSession.Scores[1]);
  TurnScoreLabel.Text := IntToStr(LSession.TurnScore);
  Token1ScoreLabel.Text := IntToStr(LSession.TokenPoints[0]);
  Token2ScoreLabel.Text := IntToStr(LSession.TokenPoints[1]);
  if LPlaying then
  begin
    case LSession.TurnPlayer of
      0:
      begin
        PlayerOnEffect.Parent := Player1Image;
        PlayerOffEffect.Parent := Player2Image;
      end;
      1:
      begin
        PlayerOnEffect.Parent := Player2Image;
        PlayerOffEffect.Parent := Player1Image;
      end;
    end;
    var LSize := TSize.Create(512, 512);
    Token1Image.Bitmap := DiceImageList.Bitmap(LSize, LSession.TokenPoints[0] - 1);
    Token2Image.Bitmap := DiceImageList.Bitmap(LSize, LSession.TokenPoints[1] - 1);
    if LSession.IsWon then
    begin
      case LSession.WinnerIndex of
        0:
          WinnerImage.Parent := Player1Image;
        1:
          WinnerImage.Parent := Player2Image;
      end;
      WinnerImage.Visible := True;
    end
    else begin
      WinnerImage.Parent := nil;
      WinnerImage.Visible := False;
    end;
  end
  else begin
    PlayerOnEffect.Parent := nil;
    PlayerOffEffect.Parent := nil;
  end;
end;

procedure TMatchView.PassActionExecute(Sender: TObject);
begin
  FGame.Session.Pass;
end;

procedure TMatchView.TossActionExecute(Sender: TObject);
begin
  FGame.Session.Roll;
end;

procedure TMatchView.StartGame;
begin
  var LTokens: TArray<IToken> := [
    CreateCubeToken,
    CreateCubeToken
  ];
  FGame.Start(LTokens);
end;

procedure TMatchView.TerminateActionExecute(Sender: TObject);
begin
  TMessageManager.DefaultManager.SendMessage(Self,
    TGameCommandMessage.Create(TGameCommandType.Terminate));
end;

procedure TMatchView.TerminateGame;
begin
  FGame.Quit;
end;

end.
