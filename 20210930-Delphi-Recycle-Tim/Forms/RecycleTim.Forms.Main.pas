unit RecycleTim.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.Controls.Presentation, FMX.StdCtrls,
  RecycleTim.Core.Game, RecycleTim.Core.Types, RecycleTim.Core.Words;

type

{ TMainForm }

  TMainForm = class(TForm)
    LogoImage: TImage;
    GameActionList: TActionList;
    GameStartAction: TAction;
    GameSurrendAction: TAction;
    FileExitAction: TFileExit;
    FileExitButton: TButton;
    GameStartButton: TButton;
    GameSurrendButton: TButton;
    AttemptImage: TImage;
    WordLabel: TLabel;
    AttemptLabel: TLabel;
    procedure GameStartActionExecute(Sender: TObject);
    procedure GameSurrendActionExecute(Sender: TObject);
    procedure GameActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    FGame: TGame;
    procedure SetAttemptBitmap(Attempts: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

uses
  RecycleTim.Modules.RestWordGenerator;

{ TMainForm }

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGame := TGame.Create;
  AttemptLabel.Text := string.Empty;
end;

destructor TMainForm.Destroy;
begin
  if FGame <> nil then
    FreeAndNil(FGame);
  inherited Destroy;
end;

procedure TMainForm.GameActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  GameStartAction.Enabled := FGame.Status <> TGameStatus.Playing;
  GameSurrendAction.Enabled := FGame.Status = TGameStatus.Playing;
  FileExitAction.Enabled := True;
  case FGame.Status of
    Idle:
    begin
      WordLabel.Text := 'Welcome!';
      WordLabel.TextSettings.FontColor := TAlphaColors.Aliceblue;
    end;
    Playing:
    begin
      WordLabel.Text := FGame.MaskedWord;
      WordLabel.TextSettings.FontColor := TAlphaColors.Black;
    end;
    Lost:
    begin
      WordLabel.Text := FGame.SecretWord;
      WordLabel.TextSettings.FontColor := TAlphaColors.Red;
    end;
    Won:
    begin
      WordLabel.Text := FGame.SecretWord;
      WordLabel.TextSettings.FontColor := TAlphaColors.Green;
    end;
  end;
  SetAttemptBitmap(FGame.Attempts);
  Handled := True;
end;

procedure TMainForm.GameStartActionExecute(Sender: TObject);
begin
  FGame.Start(GetRestWordGenerator());
end;

procedure TMainForm.GameSurrendActionExecute(Sender: TObject);
begin
  FGame.Surrend;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if FGame.Status <> TGameStatus.Playing then
    Exit;
  FGame.TryChar(KeyChar);
  KeyChar := #0;
end;

procedure TMainForm.SetAttemptBitmap(Attempts: Integer);
begin
  if FGame.Status = TGameStatus.Idle then
  begin
    AttemptImage.Visible := False;
    Exit;
  end;
  var LStream := TResourceStream.Create(HInstance,
    Format('PngAttempt%d', [Attempts]), RT_RCDATA);
  try
    AttemptImage.Bitmap.LoadFromStream(LStream);
  finally
    LStream.Free;
  end;
  AttemptImage.Visible := True;
  AttemptLabel.Text := IntToStr(FGame.Attempts);
end;

end.
